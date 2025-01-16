Return-Path: <bpf+bounces-49136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96FA146B4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7761816BA5A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12525A634;
	Thu, 16 Jan 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlHusuZM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6925A62A;
	Thu, 16 Jan 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070923; cv=none; b=mMGzW6UEoM9Ba83CNRXan4hYJhBVkziWbKDiBU4ffutN5Dc5IvBikt4hGlXtRcwlZiQAPmP7g/STHfwNwZu1BckHN2mS9CbdXjx+5pCD+By5pIlzdYpaxIeG26+Zcw6cUEL8GJDpL5CEkzvoEenBA7WMFjjio4eZND4vAD++2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070923; c=relaxed/simple;
	bh=di/pIvSrdbMWmeDfpwVD9gAOu3oa1zKKr3cirqXRmqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEQnS5/jm2gXwsg66j2x2NxFUHmzWk/8qw9Urps9eTib2R+dm/qhNgcZ7SpO6gPNlp5ibRu/U2aO5wFeb/8zHrW+2x+zsyrJv0XO7rau+zyd4lqagr6oGf6RvLVmCYbmuSxI/Y+pY+MMBarGTDsqyuWuaEKeedMiI7iLpG4Gpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlHusuZM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso2109424a91.0;
        Thu, 16 Jan 2025 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737070921; x=1737675721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di/pIvSrdbMWmeDfpwVD9gAOu3oa1zKKr3cirqXRmqY=;
        b=SlHusuZMWGLtEZsM8NrqdP+knTzjyp94TNZhilvM7pZI8mRs0mkBIpadVBMs4rkNp6
         DDTLwrRvoG77kjIb0/KqavN7SGs23NmA6fdyEBfJpqTDiqcz8atwKDGZX+/PAcTAm5Vn
         w44eZGKkxNhHAJLhwui1SrSV4ms9QKH5a7oyZ/qmXfA3mwm9DtHZEBDwj0ph5lhMv3y4
         iT1+nKPEXNH8KzdleYBdakGRZdx6mT/J0patVOrY5331O4aB9JlGRzmpQWx2xyBG+YbO
         t9xcPIOXIwaU2M9wXwPY6Fz74aDEApqgUUAzoMdmFK/s3Ke9pGWIG+QX9ahPdJZqSXdb
         xjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070921; x=1737675721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di/pIvSrdbMWmeDfpwVD9gAOu3oa1zKKr3cirqXRmqY=;
        b=eRmtVWlBCdUoBGuev8rIf4ccX8DS/pupKoT9zyIqMNUp8p5IE7VgaQmGzVG6UcJkXm
         sCe4BCOpTSMsCMlvXtaTDfH1FiwwY/RO94zbDKjw565CC8Ls2lSFsw71pKbvtLdgjT9d
         Hvl69t070h2fYBxCw/4L7qosDST+DJygEv9QvVMfT3H1ytDT3s2YO2Ien1RLouSiBqX1
         xLj6wuv73GzuwL9bp46/OWzr0Io/eQnkGVmQulgDMqRd6HaeYNA58bdgblAQYgACIwup
         ll+Qn8Thj2YA+vUZqcZKosR/8ZGxUdr6PXSukwrp9Fct2376xqSr7uatCJXqiiDcSg1m
         jdrA==
X-Forwarded-Encrypted: i=1; AJvYcCUpi4MxSjHeIyLp3BIwP2xquY738TeVUPrF94SeeW0UNnU5Tgtf5UfSC7G30vcavzajg2RQSztLmw==@vger.kernel.org, AJvYcCVEmxz5M2Xl/SBbJR8X9T87C8/vItNjOOWliPfRRHeJxOHScf5Cqg0fnCR95cHI7ltbTM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9cFd2YNqRdeen/doGBO/0IOaQ9LeFSXWrLaZ894q08fQA5Hi
	uQ4VtCWb2N+rg7lKZgUVNFiFlSLBXDHFShv81T8Bhe0QgQgeQM6o1pxQFQaNlnmXB7DxadW2P5H
	cLoKuF+1PsGb9f+k4COfxrBhemWY=
X-Gm-Gg: ASbGnctZ/ns09wnLH5xGKZuIc+QCrJiSxGkAae+txqITZukq+pumdh4UYpD0QhboV80
	9W48sp/ZBiNtRMYEhPoEllwvCY+qhhp2C2LBy
X-Google-Smtp-Source: AGHT+IGTZZvQL3gWVHVT2Fpi+TjubCvf3misV/JYk72sEM2Vl6RnOSeneTsB8LRBSdhq7bM6Z2i226uEpSIXNWztoZI=
X-Received: by 2002:a17:90b:534c:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2f782b01fafmr888391a91.0.1737070921006; Thu, 16 Jan 2025
 15:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <Z4El7MpHaaj2YX32@x1>
 <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
 <gPqr61y-AW0EUZ6chsBf2VapMfPv3lcgMFNv9ZG9Whx27iDVUWv8OMw0mTxJw2ptx9jrGxNbNBMOXmmmzhElig3VeabYlWlaGlPD6jSAYsY=@pm.me>
In-Reply-To: <gPqr61y-AW0EUZ6chsBf2VapMfPv3lcgMFNv9ZG9Whx27iDVUWv8OMw0mTxJw2ptx9jrGxNbNBMOXmmmzhElig3VeabYlWlaGlPD6jSAYsY=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:41:49 -0800
X-Gm-Features: AbW1kvbdm1CDMqBakd7CsGOetBcbcTxwDeaFgvgvmczrNzmgC3mSeaEi0XmMvUg
Message-ID: <CAEf4Bzawp=RazHAu=K8WjhhU=A9nSu08OTcov3JScyotxi8GhA@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: alan.maguire@oracle.com, andrii@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	eddyz87@gmail.com, mykolal@fb.com, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:06=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, January 10th, 2025 at 7:58 AM, Ihor Solodrai <ihor.solodrai@pm=
.me> wrote:
>
> >
> > On Friday, January 10th, 2025 at 5:51 AM, Arnaldo Carvalho de Melo acme=
@kernel.org wrote:
> >
> > > On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> > >
> > > > BPF CI caught a segfault on aarch64 and s390x [1] after recent merg=
es
> > > > into the master branch.
> > >
> > > In the past the libbpf github actions was tracking the tmp.master (it=
 would
> > > be better to track "next") branch and I was looking at when it passed=
 to
> > > then move "next" to master, that would be great to have so that we
> > > wouldn't be having these bugs in the git history, avoiding force push=
es.
> >
> >
> > libbpf CI is still tracking tmp.master:
> >
> > https://github.com/libbpf/libbpf/actions/runs/12696027660/job/353892064=
87
> >
> > However it only runs once a day. BPF CI runs more frequently due to the
> > volume of incoming patches. As of recently, BPF CI has been using "mast=
er".
> > Yesterday, when I saw the failures, I switched BPF CI to v1.28.
> >
> > I think the right way to approach this is for libbpf/libbpf to track "n=
ext",
> > and BPF CI use "master". Then, most importantly, only merge next into m=
aster
> > after libbpf CI has passed.
> >
> > This can potentially be automated, but would require push access to the
> > pahole repo. Until then, a maintainer would need to manually check the
> > libbpf CI status here:
> >
> > https://github.com/libbpf/libbpf/actions/workflows/test.yml
> >
> > Another thing is that libbpf CI only tests x86_64 currently.
> > We could add aarch64 to libbpf, or migrate pahole staging job to
> > kernel-patches/vmtest (which is almost identical to BPF CI).
>
> Hi everyone.
>
> I looked into adding aarch64 to libbpf/libbpf CI: we can't do that
> because Github does not provide hosted Linux aarch64 runners, only
> macs [1].
>
> Since BPF CI already has all the infrastructure in place, I figured
> it's going to be relatively easy to set up an additional workflow
> specifically for pahole.
>
> Here is how it looks like:
> https://github.com/kernel-patches/vmtest/actions/runs/12796621827
>
> This is basically a simplified BPF CI run: build pahole, build kernel
> with gcc, build selftests/bpf with clang-18 and run test_progs (only
> one runner, but we can run more if appropriate).
>
> I am thinking to set it up to run once a week, testing pahole/next.
> If we do that, tmp.master tracking on libbpf/libbpf can be removed.

Why not daily? I was even thinking of running it as part of patch
testing to catch regressions as early as possible, but then we'd have
red CI for any small pahole regression, which would be cumbersome. So
perhaps a daily separate run that wouldn't affect upstream patches?

>
> I also thought about email notifications to dwarves list, like we have
> for BPF CI. Unfortunately, there is no nice-and-easy way to set this
> up: we either have to maintain a dummy email account and use a
> third-party action (like [2]), or we could add a code path to Kernel
> Patches Daemon that currently handles BPF CI notifications. I don't
> like either way.
>
> Alternatively, maintainers could subscribe to github notifications on
> kernel-patches/bpf (aka "watch"), but that might be too noisy as there
> is a lot of activity there. Of course, you could check the CI runs
> without any notifications too.

Can you send email from inside the CI itself? E.g., if pahole build
fails or selftests fail, explicitly send email before failing CI run?
Just one idea, don't have anything better.

>
> Alan, Arnaldo, Andrii, please let me know if you have any suggestions
> or objections.
>
> [1] https://docs.github.com/en/actions/using-github-hosted-runners/using-=
github-hosted-runners/about-github-hosted-runners#standard-github-hosted-ru=
nners-for-public-repositories
> [2] https://github.com/marketplace/actions/send-email
>
> >
> > [...]
>
>

