Return-Path: <bpf+bounces-21226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC37849B8C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262871F2132E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801F1CAA4;
	Mon,  5 Feb 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5O68L2e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092F1CA86
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138934; cv=none; b=IpjCbwUVT/FGBUk3cBwR3pew7ISsFNN8RgpWcevucR2X7rOHfOnGXxnqrCbpkBenofgKA46XcZweottknvmR85X3qnTgdluweF4nV5aOvdffPlxYe7fxBw+xNLQ9wSMh22jP6Q2XoisUv5v2ulbVWr1fiRkVOBXZ7pYO/P5N3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138934; c=relaxed/simple;
	bh=rmNjQomfQpoCnRaBN1vTPIo7AOHkslo9q8arq5KNEfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3W5rBsqdIYVTvxU0Ooz3jEJaImh5/AjW8GbsMYpMbYF5WABRR+6KzaCOd4/oZFeBlmPemqzcgt/t2DX1XjAosBM/ewZAHiUePwya1w8DCOr3VtB8DrxL1vPb+XztQL1YKAoHwF4b9+HBBGJ2tlYRBKlJVrHkXIaALDQLP1Li34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5O68L2e; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21432e87455so2092346fac.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138931; x=1707743731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYnrTyMuuQpsXk2cGIbD2TvHCAjk4pn8UcToxn41yoM=;
        b=V5O68L2eCaXZ/3yldGxurk48JnKJde80N3XciCgPM7IKPVZrYQt2lZSCBywVN8r76S
         SqksHbu10IWAKFVz06Wuc0pBaXO0Fv6F1q7WkPh0V9Y5Jx36lOUo/QxfFV54Z8UUOqpv
         Q7fj8KaqvtN9XV7N6snfv2nAmy6A4iqS0Be2x/GGtRmj92EEjwA0DCK60MhEW1OvBjNi
         fHTsg2zcQchcJiCp+F5dYyZh8f0jeIXfO4zsZ+372I0c9zpUYdRpjnbYSUUd0i0hYF2A
         eEATK8DwXl5QbC11Skal1wPRX+PqIt8EySfK/2YzfAo3Yy7tYFVjN4yeRPPRUUb3+mDb
         fArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138931; x=1707743731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYnrTyMuuQpsXk2cGIbD2TvHCAjk4pn8UcToxn41yoM=;
        b=pdyYsHQnWSzF5F+oW4JwcM5NE9hIBRlAA/ZPLXpLwdAegJ8gkVK/dvHx29ynTAVsiZ
         isKvHRYbHoKDOs+j1jrOr9A8E7Af7zIaIHXSHVXA98/KJLBubFBcSigCf7mpw/N3W5rm
         h/UHQNVZOFcDbegoFbjC8X1h0j/XEvWXwoFi3pqSUm3WHTpiGj5yWj/gVNivsRhI7d57
         7C84D77iJogE2QDZZKSx1q3D52gBYFb+bIIlqHajyUv3oHpgxH+h8NYpppjIO/nIyFgb
         Gv7QydVFqelwWpAmeuAdT0I/IDXont10aEtbbt5md5G5IVI0DFLufutCxDXSMT0zt0pn
         4woQ==
X-Gm-Message-State: AOJu0Yzs5TyxsWeZaRs5oY3d5v4TSQQK074K5xuNlXD6TmIfyMAnFMab
	qG/40XWB+0bvkyxRnqCA95FKMxckkCmKyXxbT54P/n0J3JxizfAP0X96D9RsE+EKqaPOVZ6sEa1
	gQ5XiqMJmp3LvrPLsDnPSOqIkI2Q=
X-Google-Smtp-Source: AGHT+IG5SEnnxJDcGqDuVFPAlJd22LuemSGISAYgm4cKDI9N3pS8CMMcQAuUhR5txWZtx5AelWcfQz76myw+ESMwJyM=
X-Received: by 2002:a05:6870:d389:b0:204:a85:2580 with SMTP id
 k9-20020a056870d38900b002040a852580mr8695329oag.34.1707138930993; Mon, 05 Feb
 2024 05:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-5-laoar.shao@gmail.com> <202402051121.y4w06atm-lkp@intel.com>
In-Reply-To: <202402051121.y4w06atm-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 Feb 2024 21:14:54 +0800
Message-ID: <CALOAHbDiOO+=0ZbVQBc9FJB3v0Ta7WGJV2aQ4y=J9KqBVMy=gQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
To: kernel test robot <lkp@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yafang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Ad=
d-bpf_iter_cpumask-kfuncs/20240131-232406
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20240131145454.86990-5-laoar.sha=
o%40gmail.com
> patch subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for c=
pumask iter
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240205/202402051121.y4w06atm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402051121.y4w06atm-lkp=
@intel.com/

Thanks for your report.
It seems that the issue is caused by missing CONFIG_PSI=3Dy.
The kernel config should align with tools/testing/selftests/bpf/config.

>
> All errors (new ones prefixed by >>):
>
> >> progs/cpumask_iter_success.c:61:2: error: incomplete definition of typ=
e 'struct psi_group_cpu'
>       61 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    progs/cpumask_iter_success.c:39:27: note: expanded from macro 'READ_PE=
RCPU_DATA'
>       39 |                 psi_nr_running +=3D groupc->tasks[NR_RUNNING];=
                                    \
>          |                                   ~~~~~~^
>    progs/cpumask_iter_success.c:13:21: note: forward declaration of 'stru=
ct psi_group_cpu'
>       13 | extern const struct psi_group_cpu system_group_pcpu __ksym __w=
eak;
>          |                     ^
> >> progs/cpumask_iter_success.c:61:2: error: use of undeclared identifier=
 'NR_RUNNING'; did you mean 'T_RUNNING'?
>       61 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
>          |         ^
>    progs/cpumask_iter_success.c:39:35: note: expanded from macro 'READ_PE=
RCPU_DATA'
>       39 |                 psi_nr_running +=3D groupc->tasks[NR_RUNNING];=
                                    \
>          |                                                 ^
>    /tools/include/vmlinux.h:28263:3: note: 'T_RUNNING' declared here
>     28263 |                 T_RUNNING =3D 0,
>           |                 ^
>    progs/cpumask_iter_success.c:80:2: error: incomplete definition of typ=
e 'struct psi_group_cpu'
>       80 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    progs/cpumask_iter_success.c:39:27: note: expanded from macro 'READ_PE=
RCPU_DATA'
>       39 |                 psi_nr_running +=3D groupc->tasks[NR_RUNNING];=
                                    \
>          |                                   ~~~~~~^
>    progs/cpumask_iter_success.c:13:21: note: forward declaration of 'stru=
ct psi_group_cpu'
>       13 | extern const struct psi_group_cpu system_group_pcpu __ksym __w=
eak;
>          |                     ^
>    progs/cpumask_iter_success.c:80:2: error: use of undeclared identifier=
 'NR_RUNNING'; did you mean 'T_RUNNING'?
>       80 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
>          |         ^
>    progs/cpumask_iter_success.c:39:35: note: expanded from macro 'READ_PE=
RCPU_DATA'
>       39 |                 psi_nr_running +=3D groupc->tasks[NR_RUNNING];=
                                    \
>          |                                                 ^
>    /tools/include/vmlinux.h:28263:3: note: 'T_RUNNING' declared here
>     28263 |                 T_RUNNING =3D 0,
>           |                 ^
>    4 errors generated.
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Regards
Yafang

