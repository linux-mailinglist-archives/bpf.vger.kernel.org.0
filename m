Return-Path: <bpf+bounces-67598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D2B46263
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15271CC81C8
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A217F4F6;
	Fri,  5 Sep 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3flNssD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05602235BEE
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097519; cv=none; b=YIBEt/g/YshBIcT9v+htRwztuTdPZ0UXedXP7VukSGxHPtFt8zihNERpTgtYtSiMP6gDxnLRA766dYuI93P/j0Qqe1Xb+N5pcnQBeHQ23aNm+/BpbOSViKfxENkX1FyL580p7Bz187xFkFhF2oF2MBNuxSFIK7Ihpp8UF1D5TFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097519; c=relaxed/simple;
	bh=sQTrJN/NqE8cCz07rmgvmwLyl97MZTzynu7sFwKmhgg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOKKOVicj7btgl1IfR4XrLQm6jCafWkG0ciJH70CVFEDCocPzX/TftwJYzNfNBTFovFyzWmrJTnsBb8Juq4iRJJIawZLzDcfMJ7ysH52ct1WUJJYKs4xu0RrVitS8cw4dtU7ccJ6DcvUj35mEPCUaprUKdVszdyZGQlSJ3co8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3flNssD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77287fb79d3so2192257b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757097517; x=1757702317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaoZHKsIdrsHZEJAr8xH+OqjAiSdKNxQE05QfNcjvOw=;
        b=K3flNssDH9a/WzpvX+GQUiCM6w4/rnPTyQyE8cU+TaBTb8q9cg7xr5JF+agfIIPQ6b
         DoK1OmK4w35zHDfSNHyaNltP/YJP6D2XqfLozy5iKhjkMLVA6mzFvRaMelKUARGEK1/R
         lAiylL6Hpv/2/iobf0kckMorVRQdroijpTBJ3QJ/Tnlo0Gplf14QLEb+DaLxHXlJynXT
         7xXjMeh5HD6Oj2JORfVaJYz/Yr/bj8+vGNXsUd5zCeeSu8wRe6lcL1Zvfck+op+4BgU6
         n5KvY8cWOtvzkog/R2vV5eEtBa/GHH87oYMmu/T8wALTB9pBNTE58t2XMsVwOsbvgTCO
         gSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097517; x=1757702317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AaoZHKsIdrsHZEJAr8xH+OqjAiSdKNxQE05QfNcjvOw=;
        b=cnWUltahdSdRIDb5w/brbsZD4rmFXEzkDQ8pVUnc3lU0FjkyCIY5mCjF+O9R0RgVyn
         bpCPenhuyv5Z9GLg6KDGGeKUa5F8KMAUhbT9qmYiWacdzEU+0WDOcLIgaWH5ojnZw2Aa
         ma2xk/tFNQIXN90aMpDQ44TA9prCeVpZ0b4t1mtQy2Fgo/1HwaMWPMwkP6NnFLxKk+Bj
         mnT6HElzLWZMRSVaVgLqaH4uf1Iww25gL4WMFKQHEtny95+0NvlZNBbKHKvYH6wW79We
         XrZ8rcXStkkNb/SuLwOAN/a5SQfNS9huzR+S1JytgDx3LVTFM4AELIfToSFxIIFjb9NO
         2pfA==
X-Forwarded-Encrypted: i=1; AJvYcCWLJA+InEVkWAdC3D9PUKFiCkgAuDk7gP/hKwYKFOCXfgJ5/ZERS75dKTO5Y3OePC8vTnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmCn6jSSIjy977eKSAxb5W9b7/VNLk3rxSb0S82W4gn3jjalu
	a56IWlFBDuKuzeuXRrFl1sU+oLFQ7foAX1nfhSrvlOmgAnTqIe36GA1P
X-Gm-Gg: ASbGnctf42hd58UGHR569KrHOgn2fD8Wo7m9/FBmJX+gE5rQgThscU97ytZpWSrXrGB
	Un1gY7mSaUmKRPfISyfh9rKKtHMw2/S+vK8dVIaYFVzxIbmjYUEs+kzbmEL+zYnSLvPaS6iCGV2
	nU8Zu1UhL102SuH2dc638qA1jdWbr/0Tj66rLpnzHzm5p00TEbeIGGjN0Kc4QCD/dAA0uG/eR2s
	qtATChCZikL8NoscgTNTJ5qf5wpinUv01r54XrbVsHFFVk2Tz4XtLOAysPGZuLWmTH4lwRVkFMQ
	Vrb+gicuO78SkgxMMbdnISSMVgbTfEJM1xckajZycz0+R3fnOdhIPs8FXFUaC9+Oh4GDQ9GIaty
	fsBkzXa3qyS1hCa26WmwPjb88NX/8
X-Google-Smtp-Source: AGHT+IHlP+jAKGVw0IBwEyGQZEjPlD9oubPvObYL7CTqaMTXGko16UGKCMV5TvFQfmfEvN5va6PW4A==
X-Received: by 2002:a05:6a00:4616:b0:770:343b:5457 with SMTP id d2e1a72fcca58-7723e308528mr28144669b3a.16.1757097517070;
        Fri, 05 Sep 2025 11:38:37 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a71c60bsm22262497b3a.103.2025.09.05.11.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:38:36 -0700 (PDT)
Message-ID: <cb5d92d707032fbc2276705c9b198318f0c4f5c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add tests for arena
 fault reporting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Fri, 05 Sep 2025 11:38:32 -0700
In-Reply-To: <mb61ptt1hq9sc.fsf@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
	 <20250901193730.43543-5-puranjay@kernel.org>
	 <3105c65cd99c483ecb4eb63d590fcec9601891bd.camel@gmail.com>
	 <mb61ptt1hq9sc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 14:00 +0000, Puranjay Mohan wrote:

[...]

> > I commented when prog_tests/stream.c was first introduced but it was
> > decided to postpone the change back then.
> > It would be nice to have the above expressed in terms similar to
> > bpf_misc.h:__msg() macro. E.g. name it __bpf_{stdout,stderr} and
> > have something like this in the progs/stream.c:
> >=20
> >   SEC("syscall")
> >   __success __retval(0)
> >   __bpf_stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}"=
)
>=20
> I would prefer naming them __stderr and __stdout

Works for me.

> >   __bpf_stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> >   ...
> >   int stream_arena_write_fault(void *ctx)
> >   {
> > 	...
> >   }
> >=20
> > Now that more tests are added, what do you think about such extension?
>=20
> I tried implementing this and it looks nice, so I think we
> should have it.
> Will add it with the next version.

Great, thank you.

