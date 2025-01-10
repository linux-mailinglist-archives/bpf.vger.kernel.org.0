Return-Path: <bpf+bounces-48595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258AA09D9F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25CF188D10D
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CECC217645;
	Fri, 10 Jan 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXKCkpdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BD216E0E;
	Fri, 10 Jan 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547243; cv=none; b=Ku/IB/W4Bkmt7pwvancmDB9whpB6jszCSIfdRjrVRYx2SDB2B0F0hqlgQLlo3omC1VAToJRPDhT1y0wnUvgN2Zz93Tk2FsN8BPqwvh+7vaaER9UaGduOOIEJaG//2TKowKdLCF+KFLcXFEB/TSKm/nY1ZUIfVskQDupS0DfxdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547243; c=relaxed/simple;
	bh=QgK5KsegXhKFR5ddBCWzNOeqFxCMW3lP1lAw4zcTzEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4q1irkHrtVwPTFYW4/YfD7x5pk2NFYQthabSyVPQItATKPcVJ4Oln8OolgCpz+A62c/cngpuOPJWa8bZiei37F9XdlknnmF56vFgWnLDV5sExMucgZ3tboFDeeb8erZ1EliXZlpty7jLJadOhaYDsFKYg+aMiL+xdzm1FkP+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXKCkpdL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efded08c79so3515465a91.0;
        Fri, 10 Jan 2025 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736547241; x=1737152041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgK5KsegXhKFR5ddBCWzNOeqFxCMW3lP1lAw4zcTzEk=;
        b=aXKCkpdLckoQOa4er+XLXPVDdbpXHgF19Vnuwj4zbWbomcEBGKsrgnffKCmUgjMsg8
         0Nvk4wvF8L6hEsT+aWiY7WUBSlA+A0nI9116uj4tSoMamPMYdXCUDLaB9XNeWoPPizTf
         t9W4+dooD1EriJhwtPgs1YoffrqAMg7SYKmp2j5URBw5MjN3dMp/ErWsYJv2oUpknADT
         syQ2YFT/f/sqkJpagC1jLNZV+4yk5ScIjhGuXC2zcKv5NXLn7iFBSYP8+JNbJ4wBCBVK
         41W9GOJ221SmQhR9T9ejrJNdc6HyG/YbwspWjWRX/hgEdvsx+jmqiVJFqSdnVJ+fijYk
         ZmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547241; x=1737152041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgK5KsegXhKFR5ddBCWzNOeqFxCMW3lP1lAw4zcTzEk=;
        b=k12rWKCvo3535T/grCep0GuiKgPQiRqCtTkQK0oA1JdZNk3ykZYFURUP3AZT857kQ/
         DW91Uharsgboxh0XO+Sr/RQpVmwih9izH7+IioYQ9KYy3uqF6N4ll9SLgTxDz5UsSRKa
         uUI9pv5d4qnTmmoHbFJKkJyQtD5v4mP2ZD70Dw2v15RZ8/ECHft0kmehK0nKs/ABp4qX
         pxTf21QDigd601M1ZHFP2Lg4TwH80x8PokSeOZ6wvvf5jX9ISbT6X0OoQvkl/rWa0W0B
         9ogNOnCkFZBYiVqgmfGym6WaLRikrJHczpNq/qJrvKKl1v4O4prXrP1NCSsmc06+LeA7
         kM+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8uxNJRzMTj+LuqF1FuCjzXqE+9fBZhlTrR8zExxsirgAs74zcaQZSrusOXMS3R9tI6Vk=@vger.kernel.org, AJvYcCXFw0k0Jshcu31CSOIH5BklQZrPge6rK73srx90MpKGrV3ZAzJIF2fDfdXQAqgtWF+qK0OT583+7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YymnD3wb5m6WqtXYtWW0fS/QifE9X4bcXAobqf5P6VaCm84/L5P
	2FGs4Jl3Az69jyiQUvyIWqNuTqRvQsKWRWDQp3fg3VLln0Nm5C6PVvrDV7DnHvmyYZ4XUFuPXt3
	h5TyOYNQBl4pIfs4D6TbF1Ut23IHiKg==
X-Gm-Gg: ASbGncvl6wTjXaX6zJny52Gy7Zoa4bjCddh9XRjfIKYVbokgbzcW5lfyYFyzS0O9w2m
	vJdLHJ6herCUNf6B/NYzd/G/LTK44qYq2NGmfxh3XuwIJsoWR4J0h2g==
X-Google-Smtp-Source: AGHT+IEkhECxP+vtppG7+FPxVHizW1PMsEtotibNy//3JwJr0UNqaylhJ35WanSFv25j/j/600kRkqx9UOwOeDx0qHQ=
X-Received: by 2002:a17:90b:2f03:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2f548eb32ffmr19346454a91.15.1736547239797; Fri, 10 Jan 2025
 14:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <Z4El7MpHaaj2YX32@x1>
 <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
In-Reply-To: <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 14:13:48 -0800
X-Gm-Features: AbW1kvbPR5LOV9sADdRu_h0-S3eyrHKfj62sXKkDUeA1yLm_MeUQLl9SmixXtoI
Message-ID: <CAEf4BzbPEdxH2AfTBd5HuHQUKqVm8wqTdzSk7NJLQ0-1ajschQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, 
	mykolal@fb.com, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 7:58=E2=80=AFAM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, January 10th, 2025 at 5:51 AM, Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
>
> >
> >
> > On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> >
> > > BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> > > into the master branch.
> >
> >
> > In the past the libbpf github actions was tracking the tmp.master (it w=
ould
> > be better to track "next") branch and I was looking at when it passed t=
o
> > then move "next" to master, that would be great to have so that we
> > wouldn't be having these bugs in the git history, avoiding force pushes=
.
>
> libbpf CI is still tracking tmp.master:
>
> https://github.com/libbpf/libbpf/actions/runs/12696027660/job/35389206487
>
> However it only runs once a day. BPF CI runs more frequently due to the
> volume of incoming patches. As of recently, BPF CI has been using "master=
".
> Yesterday, when I saw the failures, I switched BPF CI to v1.28.
>
> I think the right way to approach this is for libbpf/libbpf to track "nex=
t",
> and BPF CI use "master". Then, most importantly, only merge next into mas=
ter
> after libbpf CI has passed.
>
> This can potentially be automated, but would require push access to the
> pahole repo. Until then, a maintainer would need to manually check the
> libbpf CI status here:
>
> https://github.com/libbpf/libbpf/actions/workflows/test.yml
>
> Another thing is that libbpf CI only tests x86_64 currently.
> We could add aarch64 to libbpf, or migrate pahole staging job to
> kernel-patches/vmtest (which is almost identical to BPF CI).
>
> Andrii, what do you think?
>

It would be nice to test pahole as soon as any relevant libbpf patch
is sent upstream for review. We should make sure this doesn't happen
for all combinations of compiler/arch/etc, just pick one configuration
for x86-64 and aarch64 and run that?

[...]

