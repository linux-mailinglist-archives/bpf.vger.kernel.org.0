Return-Path: <bpf+bounces-20324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C083C289
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 13:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9C41C23588
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEBF9D1;
	Thu, 25 Jan 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8FIK0VR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFC487B9
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185910; cv=none; b=BS16wpoScxx4fjAyDD44k0gdeRDYjx7TaDIPGvK4v2I5YQ+I9zeolbIwnoo45I6AEVHwzPo1b6GAEu4iWltpdIuuUX+KJKuq1b/c8D4mYDEaeXfo0Ucz9gzNOgu64EZb8Fc/t6OUBeTwF5dMfpID2LYrqh/8dUgh0VR99uKRcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185910; c=relaxed/simple;
	bh=FvUKVYMbufzCJ8f8tUJppPIW8xLG2OscPNBW2z1AOsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yioa3pEGSyhSMiycnpWYKF4ZMeVfR+3BL6K74HGVT2CQ6d9gh1kCNwOg8HcR0nf8hyaNzwOYUtOgoqvDDZz6J+Nm04xbzT94Uzw5cY7OrMCpDpS1MLQvXDDjymAR+UIB1IGr5MFn0c9nK1r+K5+e96tv9bH9Dcl82aoNisaTj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8FIK0VR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6851dd6b3c3so33164706d6.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 04:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706185908; x=1706790708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HvcMbsU9Bi44x6EXGV+6QPhRWi0xKZ2eBkNhH5/kMA=;
        b=I8FIK0VR2zm/jW3IMx5hyi/kKkNoYZE+6zjPFsK9/ui9ngsZ+wIfsYklBrT8bgtP91
         Wtjj9z2p7TYbij6Twh92lXybYL1kBkhwbUUPuovBrDY9uwn4ukZ71j6R/Q8HuYsTy2dh
         o29jkxXYQmHsfiBIYElstcnt2ygQ+dM2E0wHb6s1qgPrQEKV57SHwu1mcnq/hK7ug/T2
         EHtXwZYFwLpBqasgrs68odqRzfh5mr1dsYQLAuEUpsvyA3TyjnjNoiZdLkh+iEzYqHyi
         2gsOJLCOAaoFrkuc0KZ8xzIG43csRDsLrKBZgEBQj/P51OmxOZHs02DTFmtR9FZQ8Gsm
         eKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706185908; x=1706790708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HvcMbsU9Bi44x6EXGV+6QPhRWi0xKZ2eBkNhH5/kMA=;
        b=WqN1yXOTlDdQfojIvtELggoImFm6GNv7V0D/HDuWDcDs7S4hT6BmW+XVeQCKu1eqeG
         7Ghwklig7WZcanyIs+uhn0dXfuwhEW42m3eoEz4JhvgYU8dM7EIVdP17+qFjztrIG8V4
         KLY9t4wiI4MBZEewa52DzC+exnl9EEXNHu8AVtGXk762W7SifpmhvCS+mGBMee9OhG+F
         u99IOgGeJ8RQFMdbg2NVvNySuaSioaQiqFbjH3h8CG7lNoRI8lCaAu6ueRlDTMrCQBSu
         QtcjD8DWenDGLSFMx09KIRG3W+3LKigEzx/4ktW+aeIuJBDAiaqrzG0hx1ArFOSFSKYO
         gelg==
X-Gm-Message-State: AOJu0YzIzUqi4zsWHTLfjsksPWVynx0P/6kEC1oJWNnLARD/+Xh4tGQH
	EGoShZtqWiwPIM0DbJOFe+QC9hMHp9xA3DjiVNvE64aCcu32eCWM/uM6LvqDAsfxq9DTIkiwHPW
	Mx0UIQ/5scaBjJRq9fAbAqgFfRBA=
X-Google-Smtp-Source: AGHT+IHMyQIc1mTcN4GKoqNVMQsviBjHQqNy9uJMhBWjNdTMZApWcOuhTVY1JJncXSU36OKd8m1Pn5l7GcA1bHf6Bt0=
X-Received: by 2002:a05:6214:242d:b0:681:7e4b:fa06 with SMTP id
 gy13-20020a056214242d00b006817e4bfa06mr1025989qvb.46.1706185907667; Thu, 25
 Jan 2024 04:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123152716.5975-1-laoar.shao@gmail.com> <20240123152716.5975-2-laoar.shao@gmail.com>
 <20240123182617.GA30071@maniforge> <CALOAHbCpWgcwKfoWAQdjwwFDpsqqW9Ordy3cGVTY4h4=sUYK5g@mail.gmail.com>
 <CAEf4BzYjiNXibJBMERYLKy9em2k3HyXgxD2x=j+FRceUDmzfhw@mail.gmail.com>
In-Reply-To: <CAEf4BzYjiNXibJBMERYLKy9em2k3HyXgxD2x=j+FRceUDmzfhw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Jan 2024 20:31:11 +0800
Message-ID: <CALOAHbCBpyn_ESWB6tXvSQSaYeFJP54nREQZeBAard4vg=VeQw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Vernet <void@manifault.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 24, 2024 at 1:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Jan 24, 2024 at 2:26=E2=80=AFAM David Vernet <void@manifault.co=
m> wrote:
> > >
> > > On Tue, Jan 23, 2024 at 11:27:14PM +0800, Yafang Shao wrote:
> > > > Add three new kfuncs for bpf_iter_cpumask.
> > > > - bpf_iter_cpumask_new
> > > >   KF_RCU is defined because the cpumask must be a RCU trusted point=
er
> > > >   such as task->cpus_ptr.
> > > > - bpf_iter_cpumask_next
> > > > - bpf_iter_cpumask_destroy
> > > >
> > > > These new kfuncs facilitate the iteration of percpu data, such as
> > > > runqueues, psi_cgroup_cpu, and more.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > >
> > > Thanks for working on this, this will be nice to have!
> > >
> > > > ---
> > > >  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 82 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > > > index 2e73533a3811..474072a235d6 100644
> > > > --- a/kernel/bpf/cpumask.c
> > > > +++ b/kernel/bpf/cpumask.c
> > > > @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struc=
t cpumask *cpumask)
> > > >       return cpumask_weight(cpumask);
> > > >  }
> > > >
> > > > +struct bpf_iter_cpumask {
> > > > +     __u64 __opaque[2];
> > > > +} __aligned(8);
> > > > +
> > > > +struct bpf_iter_cpumask_kern {
> > > > +     struct cpumask *mask;
> > > > +     int cpu;
> > > > +} __aligned(8);
> > >
> > > Why do we need both of these if we're not going to put the opaque
> > > iterator in UAPI?
> >
> > Good point! Will remove it.
> > It aligns with the pattern seen in
> > bpf_iter_{css,task,task_vma,task_css}_kern, suggesting that we should
> > indeed eliminate them.
> >
>
> It feels a bit cleaner to have API-oriented (despite being unstable
> and coming from vmlinux.h) iter struct like bpf_iter_cpumask with just
> "__opaque" field. And then having _kern variant with actual memory
> layout. Technically _kern struct could grow smaller.
>
> I certainly wanted this split for bpf_iter_num as that one is more of
> a general purpose and stable struct. It's less relevant for more
> unstable iters here.

Understood. Thanks for your explanation.

--=20
Regards
Yafang

