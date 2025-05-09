Return-Path: <bpf+bounces-57867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B238AB1A65
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554DD1BA0C9E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E821221555;
	Fri,  9 May 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy5IB319"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68303235BF1
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807668; cv=none; b=PkGMTFnq8l5ElyF7D1ihGF2eV4AKhIWFfftMl/+IFvhOzTHQbqmGzmmkEbaCEo5CGIyPy4XaVid1Yi/g0XCmCfAkaEjn/yxvyGpx/IxvOHFK9XtblwvjhfjMLJaP1x6HJRke0xS9xw7RwL4r04jF78gdExngt7AEOs3wOsFf5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807668; c=relaxed/simple;
	bh=7d3te/IkIX2bt/bAY3VVheOuZ7MxIGEYFidQKWsaAa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE4FrLBAoO00lJuXwKt19WvLlgFjefmA8b6zFXgeTngAz0F2D/mOTFwuFqyX4iXrZxAJBn0ay7Foyt75xt95auspe4M2CwBayY0Tn4wWR+LqE5CH4kUdh5zpJbMBLDUkms6ngX0/2czK2kXRX+c6UzEY6GEmwp1tdWyaAIDuIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy5IB319; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1097981f8f.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746807664; x=1747412464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkqBwUVLqU2Vns/z0wrnWibbZxs7vugGHRzSTQ3DLoY=;
        b=Yy5IB3198AVsQi/0UuZyaJmlBCFQDb2PGri+5qx/FYWtaq5zVtTYp6iEtctf3iZ0/Z
         H06m0YCrEpJrrIa3iWfaQXz9BaVaxcYpGv5PN+SqedtcC/pGnAqCn4nmON3wuR0dn4xG
         Bc7pt9KcmKSCiJEJO7ot+0xzuAF47Wp2drIXw19EbIbAZw3zPhWSg9IJh/oflohQJ3TX
         9eMK4+IP+C1NZNfxGMkM6XvfywreJHoJ1y5KX0koAjetnWXrIsVaqYNyLBh3ULXf+9VU
         OfTSmOkCJmniIWymduZ2AWwwgHbx6Vk2SBI05uPsfqwDI3EGB7qvWcd+qqfoDD6Jx+Zx
         glww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807665; x=1747412465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkqBwUVLqU2Vns/z0wrnWibbZxs7vugGHRzSTQ3DLoY=;
        b=BNqW2hkCUS4eWZDQ643OtRp8VJ/F6tYT101UsQ1ND8yOFs8x1xH/+vcGRiY0CrrzNQ
         vaUydbbbPhpkiMdkS3zH93yvyO5XI1+3doIRguyZqMaFgApaw667kLYmys4bcB3Fzvs/
         zPAmgC/hJA/tgBc/eLLsQwFs/CRh33EHTQ/iprPGRcpReCwkLDq3x6puLtmCYsBXr65E
         ZOh5r+tiOtxyZk34EtzdZRhaDYVABd8qgSOVQvKw0UprRUOQP7eZtORKroS3yblFpR8+
         uG4nLjD/dYCC0UZObU3ZoIZafwV5gXY3slbUc1WcrR2gzAW0z/pwUZ4mJgwPvmDrya78
         /DHw==
X-Forwarded-Encrypted: i=1; AJvYcCV/sjNTpH96DvHdcri3JWFCdqHK2bVdKBb4uB4LGZFggIuNClCTYlKsjanH0nrbAk5J/8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywke6yxPwiLagjnLk9GUhsnJcjVzC0XOHbqJ3LmJsC5d6Fk4vr9
	rrB31+BVNdmtrDGqShUd6c7WnNhYdmfXtIytYDLg6bXyrPU8HqI7gatJQRXK7g73VqaAXsj1kya
	KlDk5JFA2zSALUCk8723gMYefQiM=
X-Gm-Gg: ASbGncsBU+7I00q+ixEwxaCpZOVvLccL1nIeVA/BNFZtqL2J/hZz1X7gkMunmkpyxP+
	5zxARFfJx7dFdpVZKJOjzKTOwE6o9Q1Fl6iszQhsde/BcfTzLljXs2jcnnA5z2pIuxXb1szY/ZK
	Byz9gGkwPtLyOemWIT5hCZxRzBjCoSgk6yDSWHfQ==
X-Google-Smtp-Source: AGHT+IEXOBxalvMv6t0v7CAJtIZU+3oMtzGOU8ypQmg6a+ES/CIiFwvhd0/9r1GmXbFMlSnCHFB21QntXcj2uq3s1b8=
X-Received: by 2002:a05:6000:2502:b0:3a0:af41:f92f with SMTP id
 ffacd0b85a97d-3a0b9941d91mr7722042f8f.20.1746807664487; Fri, 09 May 2025
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
 <aBx0qmVvL84Jb3rf@google.com>
In-Reply-To: <aBx0qmVvL84Jb3rf@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 09:20:53 -0700
X-Gm-Features: AX0GCFt_pMwGxaxSiTenX32H2Vn2ypF7pQ-bMfKvi9N0McXxCFLF20DzoG_m5rc
Message-ID: <CAADnVQJD3dQfuT2ExXL5iGeVj0TJ9L5KWGovmsSz5giKft4ryQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs as
 args to kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 2:09=E2=80=AFAM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> >
> >  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_=
state *reg,
> > -                      u32 regno, u32 mem_size)
> > +                      u32 regno, u32 mem_size, bool read_only)
>
> Maybe s/read_only/write_mem_access?

'bool' arguments are not readable at the callsite.
Let's use enum bpf_access_type BPF_READ|WRITE here
or introduce another enum ?

