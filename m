Return-Path: <bpf+bounces-58343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996AAB8E2E
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2A79E5F9A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B225A34F;
	Thu, 15 May 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iITj/T0j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274B258CDC;
	Thu, 15 May 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331605; cv=none; b=uUfVpddIi7SFQTYEkwD/Bk+kgVSOGaBm/FGXQ2xs/bKnr9hM2EgLeB0cWrMFkRwqrbG54kpo06lnQBf4Vypw8i0mkHe+akQg67OLJU61jeEJ/TaqPdCJHfJgYbLASzbk5LuY2Bp30rDQhHZDmlJYOtuPfAFteG2JRrVKhsUtd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331605; c=relaxed/simple;
	bh=wUfB25Z6DjgPNVxGmXlzpAkbXQRJJQpijp0/dUMP8+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRPFdfLAyrbz2ZMi1Drp7MI0508aeTIKUvxaIPuMnQAxBdjeh5n6Epnutgs0IWwZdNu6nWhSEO4AK0EKiSFJ9jADm+3FKCQ+ToOq6VvBaof8+P0BsyJmdHsVyDz0oDba0piUOnCYYQDigeC9dGQwjp65/GSq0/UTenpUP+3egSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iITj/T0j; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30c35ac35dfso1161694a91.1;
        Thu, 15 May 2025 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331603; x=1747936403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54fguFj5SD0Kvvv9NyED44yQjf3eGCVtUMb2jdU2xJ4=;
        b=iITj/T0j13NGqhd8sVxaPjVIRn0iuCvG+SCB2UXDEW5Z0ukFSm0fx/xsT9N3hrgwvW
         2z+lyNfSMQ3N82pTqAtGG7yabmPDLRBIM39qnqNDFcCepg48sJiY/7WKWgDA+PYmuc/Z
         L1KrChG7EZGyWHnbB+i8hFZZz8jOQicUmW2tV65DAlMkfyWWwmoYJwxYqi2oIe+swy51
         5wK+uUPruZddDwaZGCg/NyKMcR8Pn3EobH8hHlFOV3ofSGidf1kanBI0b7gglfYJ8SuS
         1/NwyOK6a+F2DjayMsLNmKuZIKx3BsmZLjofq6OzaLyHzTGHl0KWNI5s0MALEZVJ467b
         aPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331603; x=1747936403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54fguFj5SD0Kvvv9NyED44yQjf3eGCVtUMb2jdU2xJ4=;
        b=XBZKqOjWsBXnX/ZPAghWwjrLYo83mX6rAFwn1zpJfI87k6Vdnjd35RlqermnPSBbHm
         XCcX7F3IbW0XAdLlAY1mOj9MDf0qc9LAHfhVh2z8Rw5ndQbVXg08p0qZFsY07tL5H5Kt
         lKa4YAz0tbQGpsU7eSsLsoS5tXWsGvv5SLAZX6Ngmf8M4nBiVMWNtWeDoMqWZH3ZGpRt
         Tevs5HnIJc+bRNLstnRKjCyt+DBqpTaYpbT+KsTOdX7qUzGw8OEYk95FdN9Wqx0A2s9/
         a8jEC5lCpyWfjxkztzeYsgGyssiM2YsnaEq4id4q8J0vzifLuxUnhaV2qzeGMgjWyMqh
         /fcg==
X-Forwarded-Encrypted: i=1; AJvYcCUcZbagtRmosryRkXH4+z3eDypP8Gc5HsG9n300do1ljWV7lM5bC71cyAriAZngfLuTaP7hD8B7+/Ed4K/BGWXM@vger.kernel.org, AJvYcCWbOqLzhfBFZoZATHjvTw/J6afiUH+DhQ+h3c7a2mT2C8/5IwzrlBdY2U/xZ2LzAUGNuUo=@vger.kernel.org, AJvYcCXIuzSH0AgiS1DGaEtdE2PPvxXm6QMJQebA91+hYu0uW6PMQHSE+mTbN3Shdd+Lqz4rq1zI8nTlikJ7OpYs@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyEleYymItrP0NYiXn0GbSQJFMDs8TzoG4Xx+FxVd6en5zqg9
	wTznIgp9uI6N9ZWF069vcqua8AhBRoe4AmDqtlJsUsYMRikk7gP4F8jdSpN169Z34/mjK4yw92q
	UBYAZLUfuWPOHM27OOJ1Dy2kaAPyjOZC0GAWw
X-Gm-Gg: ASbGncu0gaV6immyKLOPyZIgRPPDwSFWNGOVRcnMK+NkSbaS9jRTn64FfPBhc7mRd4T
	yIcbu09zVyqmN8Tb9KFQJ+IB2y7jETVDRQdBepltwe2Ml3rvdSjvN0ANm1xzfb1diaVOIycTrzt
	A5kgksljGywNu36qVQLLXU8Tj80quy7dB70SYmXui4imKW2VuH
X-Google-Smtp-Source: AGHT+IHL17I+NPoYgpEtbfBy6dbR6YRLDhqI/LlE4JZevZnvZpbndJacxlHQ01gcFFUzfoGL6d9/8LE8xRDWqjvXXBw=
X-Received: by 2002:a17:90b:3e8e:b0:30a:fe:140f with SMTP id
 98e67ed59e1d1-30e7d5ac5eemr431874a91.28.1747331602926; Thu, 15 May 2025
 10:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org> <202505150911.1254C695D@keescook>
 <20250515171821.6je7a4uvmttcdiia@desk> <202505151039.DAA202A@keescook>
In-Reply-To: <202505151039.DAA202A@keescook>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:53:10 -0700
X-Gm-Features: AX0GCFttxkh9zWvmT_O0s4tiVH_OWTb-CIz6U-4nojzu3dXqjUGIWuP0S5kbsAM
Message-ID: <CAEf4Bzb4LZK5p08t1y-32wAFDGoRGKR1w1T_je6+a_EOE2uSYQ@mail.gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change since 6.15-rc6
To: Kees Cook <kees@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:41=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, May 15, 2025 at 10:18:21AM -0700, Pawan Gupta wrote:
> > On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> > > On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > > > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
> > > > >There is an observable slowdown when running BPF selftests on 6.15=
-rc6
> > > > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x8=
6_64}.
> > > > [...]
> > > > Where can I find the .config for the slow runs?
> > >
> > > Oops, I can read. :) Doing a build now...
> > >
> > > > And how do I run the test myself directly?
> > >
> > > I found:
> > > https://docs.kernel.org/bpf/bpf_devel_QA.html
> > >
> > > But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> > > tests, no info on building the test modules).
> > >
> > > This seems to be needed:
> > >
> > > make O=3Dregression-bug -C tools/testing/selftests/bpf/test_kmods
> > >
> > > But then the booted kernel doesn't load it (missing signatures?)
> > >
> > > Anyway, I'll keep digging...
> >
> > After struggling with this for a while, I figured vmtest.sh is the easi=
est
> > way to test bpf:
> >
> > ./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs
>
> I can't even build the test_progs. :(
>
> $ make test_progs
> ...
>   CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
> progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy=
_from_user_task_str'; ISO C99 and later do not support implicit function de=
clarations [-Wimplicit-function-declaration]
>    98 |         ret =3D bpf_copy_from_user_task_str((char *)task_str1, si=
zeof(task_str1), ptr, task, 0
> );
>       |               ^
> 1 error generated.
>

BPF selftests expect that there was a successful kernel build done
before that. So generally speaking:

0) cd <linux/repo/path>
1) export O=3D/path/to/build
2) cat tools/testing/selftests/bpf/config >> /path/to/build/.config
3) make O=3D/path/to/build -j$(nproc) oldefconfig all
4) cd tools/testing/selftests/bpf # everything is built within this
directory, we don't support KBUILD_PATH or O for BPF selftests build
artifacts
5) make O=3D/path/to/build -j$(nproc)

step #5 will search for vmlinux image across O, KBUILD_PATH or in
current linux source repo (in that order), and will generate necessary
vmlinux.h header out of BTF information embedded in vmlinux, which is
necessary for tests

You might need some dependent packages (libelf-devel, zlib-devel,
maybe some other, don't remember) to build everything, but if you are
on recent enough Clang (19? might work with a bit older one), you
should be good.

But tbh, if the above causes you problems, I don't think you need to
spend that much time trying to build BPF selftests, given you know
what the issue is and you are fixing it.

>
> --
> Kees Cook
>

