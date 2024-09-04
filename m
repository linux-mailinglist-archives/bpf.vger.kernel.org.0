Return-Path: <bpf+bounces-38940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824B96CAB2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 01:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8921F28493
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12B17ADFF;
	Wed,  4 Sep 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IydZZ3eO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714701372;
	Wed,  4 Sep 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725491296; cv=none; b=UD9oQpj1M8lFDn5a4laS5WSKT4WacTMf2bRuaRyCee3z0ZIQJNldHo6B+3RDc7T9C04KUU8+Bc7Jno6mMELGUwTrDDz2WHhBp9B4Mxx+VrCBWJ1yeYZEOtvUbG+6bGvzVfm4v+1E4MbdNCvPctylY9SXZ2ZGvmvtAWKgjg8K+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725491296; c=relaxed/simple;
	bh=W0MIkPSO2C4lNTa5xi4cBTl7ACN4+NCLF5x0oARKKjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXyOqzhPLgdkTq7b70B0HCi5zcBW/ETD0sNlvgnMccvmJhSUonMFjs6DDuC/or9+NgcE+ikewje6CA86vnaHov5WyNb+Q01zSHBTk3JT/i90PNNTyxUIsOhtEaX9SLhBQmQAoEPYwBWFd4Gf6POmKNMzeNNaVupZVgoSuHkmR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IydZZ3eO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2054e22ce3fso1866965ad.2;
        Wed, 04 Sep 2024 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725491295; x=1726096095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuYY7Ue61iqYlGMoVC45JUKp7fJ5h0XkO3P1iEMCu2c=;
        b=IydZZ3eOhavpcJbVvW+h6wEY/BxcLOtSepirtktHKbS+64JGFoK0qD1zQwCod4pSkI
         CPPAR4OW88rxamXY6mtR5b0LdPRa4l9vzB+QWOmUz7MdtpUXlo4ko3wVFFt1QKrspAJv
         RETEAiKjTFe1+/WcDKb6oC+t0qhfQkykZSmAFLxDW1QmOSHETA6TIKoUgkkJKKQarv91
         rvWg8jShqP+FsNoWJ7OhiJHJT39vnAvkJvlNi37LnT7jBTR1wlCpI3fPwcYRTfymUmCn
         JLu66ZaSm1sfzsNUx6aPbllilquQT658JY1T8zlh6JHmtew6EREI32xQGpwcD94XXVXW
         /wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725491295; x=1726096095;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuYY7Ue61iqYlGMoVC45JUKp7fJ5h0XkO3P1iEMCu2c=;
        b=Ec+ZDXuU27zUqroyaec/nFFsg7loAEKwgxg7SCD1TligbFPLrmpoS8vByTccBzWmKA
         oV4IwQNRcdX9e2d9hc6hibgXmXv7jv6Ma4O3yQyJ7bhgA7jS5RqEu9esiXGOvVejQLUq
         a40FdDCkRlwJEupecQgeTniZvFwW6X+UScVH5jwwEBqwfVr3ya3kMU00Fe2sXnD/h9dT
         PmhrqFy2WG8B2NIDhLcuSztTTcCzVZj4F4emlVYgIkHoy17dxgwFTf8xSkJ1A+6YFZNA
         LfxTHYeQsh5vq4w7zq18/Dgr99Nm6guu4PuZbdI/MJaOIHDWojQbmMoTvFZI0hWhYjht
         cYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEIsJRy2kTjfOkmAnPe+NBIR9beqP2/5PAxRzepZDFEFRS0U8zSbi9yuJzdy8NL0cfuxQ=@vger.kernel.org, AJvYcCWMjjPDRslrfmzC7suxA+myWChsXex4QstkmDs4p5Jwmx8EV8oQcPktwl0Zbvavc2t2jy/yVnh6@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnHhp/VKXijrgeW0X2nDCgwP5YUfliVw8HISKdwJUkHTVZOkz
	suBpTVBfAurdBOBmygyX6CyrgPrSYqm2mKdhHuX87He0MTOmpt7P
X-Google-Smtp-Source: AGHT+IF4rQGkEVUHVpqqXf2jKmQLiLHqowPu6xYKSxVTfrDXBPMBmlKsnz4QlN3364FnuloKsGiLHQ==
X-Received: by 2002:a17:902:e543:b0:1fc:6a13:a394 with SMTP id d9443c01a7336-20699ae817dmr101712865ad.23.1725491294513;
        Wed, 04 Sep 2024 16:08:14 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae951f35sm18340095ad.85.2024.09.04.16.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:08:13 -0700 (PDT)
Message-ID: <1bd4056c2b311aca03b7707b077f7555db4e55d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/10] selftests/bpf: Disable feature-llvm
 for vmtest
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui
 <pulehui@huawei.com>
Date: Wed, 04 Sep 2024 16:08:08 -0700
In-Reply-To: <fc9a03f1809cfdd80a9a8cb7b513e32302be5a43.camel@gmail.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
	 <20240904141951.1139090-4-pulehui@huaweicloud.com>
	 <fc9a03f1809cfdd80a9a8cb7b513e32302be5a43.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 12:37 -0700, Eduard Zingerman wrote:
> On Wed, 2024-09-04 at 14:19 +0000, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >=20
> > After commit b991fc520700 ("selftests/bpf: utility function to get
> > program disassembly after jit"), Makefile will link libLLVM* related
> > libraries to the user binary execution file when detecting that
> > feature-llvm is enabled, which will cause the local vmtest to appear as
> > follows mistake:
> >=20
> >   ./test_progs: error while loading shared libraries: libLLVM-17.so.1:
> >     cannot open shared object file: No such file or directory
> >=20
> > Considering that the get_jited_program_text() function is a useful tool
> > for user debugging and will not be relied upon by the entire bpf
> > selftests, let's turn it off in local vmtest.
> >=20
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
>=20
> I actually don't agree.
> The __jited tag is supposed to be used by selftests
> (granted, used by a single selftest for now).
> Maybe add an option to forgo LLVM linkage when test_progs are compiled?
> Regarding base image lacking libLLVM -- I need to fix this.
>=20

Please consider using my commit [1] instead of this patch, it forces
static linking form LLVM libraries, thus avoiding issues with rootfs.
(This was suggested by Andrii off list).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ez/bpf-next.git/commit/=
?h=3Dselftest-llvm-static-linking&id=3D263bacf2f20fbc17204fd912609e26bdf6ac=
5a13


