Return-Path: <bpf+bounces-70130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCEBB185A
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA019C0583
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5B2D5C6C;
	Wed,  1 Oct 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5I5+QMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C72D593A
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344039; cv=none; b=Ihcvk0XHB1WyfAI4OQbtnvYnSDwB/LMDLcy7rqfycgTa6NP42pgWCak3NU4iBFZ25ewrqViUydaybdQfcj3Y0wk2tyTSQAg5Wd5DUYy7xxHxitOx94vQTSQKfwMEBKt51UTC5lJc8Bdl/OOwKJ7ENoNmMvWLvmwEQxxxIr3cg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344039; c=relaxed/simple;
	bh=1umPVrMN25rwtFM9uAPR5FtEtbF3kEcUkN60uAVDZI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcCH/YXXfxPPXJ4JI6x3D0ztmJJBTZKdlE13NFcvimSEtchnTbV5Pnn3s13r+JoY5JMfyL6qTu11J4QQh0g3cg5QUwycJa755rgYzNXOMjh3KXHY6NDW1obtuVL6UPYnE4k9M/HSvk2EyVCMvruhYjv3ZnTm5x/56tBK48dUiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5I5+QMH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso307090a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759344037; x=1759948837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MDEJ0lu1+GJ/IUFWINEx2UnZw97BBaeZD5EhIvxkjMY=;
        b=L5I5+QMHtgKoXh3KKNHFDT7RZM0N0beLpSElit0R6zOcchdxQ59x99KNzr68Bif+Ai
         KrXjdMBupOkkzXLn8xMGLU2OHwBiXun6djZyls2y0jtmXhPOP9cry+c93JnKX9MbqOiJ
         lsp9SLL1972DXHf0dmKnGYb+cSpKJhz+yU1O2fNaL3lTJlz8Rx5Px6rXkVdvRyglQXx2
         5sxUzwQqDeiY6s8xfat223VH9Bg4jDAbc5hiSFxQUOGt+/5p/st/W3FFkqEmGoW0Qloz
         6730+id/5t3gL+ViXyKdfMAJBWfojFqzRG+x9GGmL0a9JfIfFyXvJB+/POd4K1hBC4EI
         LAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344037; x=1759948837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDEJ0lu1+GJ/IUFWINEx2UnZw97BBaeZD5EhIvxkjMY=;
        b=XF/0EmuzAyiyPsOvuYpagfv0NcHUVmEFnmtjQBzgda0WsYWhOfEBsdUgJ7qICqjofG
         YRDK5VgC6GqGm4jZVRCkATkU98YZ2C1BHBS+m/9tecqcWG3rIIKduhiDg8ni5V0sorW0
         cUMedAAYmCVj7VVmdCZBYsudwcqi5FXwMKpG5blqsw4MA/dOhyKsYFjychD9AKNsbTKu
         IqvMHrGK7bcyQH5ldivWIMDqx5QWfcBIqq9E+h5QFpYmaDoMc7ZJWlbbD1vI3SoIs3nS
         XlITEICFKaacpKhqTpJaqzIXVGmthGT2c/MoJDHYREfus0PawLba/HkNadegIrjR9lSy
         cOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/H64ygpu62Pxj5FHr8PJ54G55WChQXhpTmUas+cFJ9aObZLZ+rQ0hO+X/gneJ/DmJMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVE5F1Q4N5H6I0uiOIBZReJGflK4oalvweTfu5ctIIoP5Upep
	AnbD1M2nfsONBYeR0zCI+/kGzwPFiBaonuDSpt6pkGKvng9DS2u+g9xZ
X-Gm-Gg: ASbGncvC3bdjyVD4a1uKjqdulJcWygWSsyF3olY2vhyELbYnUVeEBrIgyLSW4kpXzJA
	gWVboQpDR1Cfy3NITqqEStKmRLG2GQvV5+JUP8W2TdXaK7FPi0IOiOEBo8X/GkLhnLjNelHxfIy
	XGZKksxsCVY9f3vBZJqQTovR+qOVRraOHX48SYpqvVlgVXCssczJOzUB7KyJif0+nrcvSP63Szj
	16T1ksuDj7qeQUB3ozFjSrVv+pK1+vtQLBZhY7mfe7+BHg+y15mad8LE9603MiZXplHTM0zlZKI
	uW8WX59qj6ByTX/KxA7mVBxkBXFnyh1oYrhfIOkFj5JeMsqqxxDtWhdnYGPZ3omtmf4iZAYBCIq
	qYTU0Vqt2Syp/LIZuX8KnDE4gdk2gSMIMiG9Hw+RkTDMv2aiXGf3ONuV2M1oz9lSIi7BmjVU=
X-Google-Smtp-Source: AGHT+IE9d7N5NG4XiPa9maEZ3RHrGA6o00yJybkBashehg2u+Wl6ekgRkDIwbZ+lXbWcT5ia5gUc1w==
X-Received: by 2002:a17:90b:4d84:b0:330:4a1d:223c with SMTP id 98e67ed59e1d1-339a6e955e2mr5211655a91.15.1759344036919;
        Wed, 01 Oct 2025 11:40:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm184384a12.37.2025.10.01.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:40:36 -0700 (PDT)
Message-ID: <15515a5f10587827b33b3e9eaeb854d5c96e88c6.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] bpf: Fix verifier crash on BPF_NEG with pointer
 register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:40:35 -0700
In-Reply-To: <20251001095613.267475-1-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> This patch fixes a crash in the BPF verifier triggered when the BPF_NEG
> operation is applied to a pointer-typed register. The verifier now
> checks that the destination register is not a pointer before performing
> the operation.
>=20
> Tested with syzkaller reproducer and new BPF sefltest.
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58

Nit: In the future, could you please include links to previous
     patch-set versions in the cover letter?  These links are usually
     accompanied with a short description of changes from version to
     version.

>=20
> Brahmajit Das (1):
>   bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
>=20
> KaFai Wan (1):
>   selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
>=20
>  kernel/bpf/verifier.c                          |  3 ++-
>  .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

