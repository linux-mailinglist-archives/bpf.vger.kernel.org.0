Return-Path: <bpf+bounces-39320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1653971C5A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DAD1F24523
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A541BA29C;
	Mon,  9 Sep 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VUJroyY0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B01BA262
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891586; cv=none; b=n4U2L65NFHITpItQ/+LMJF9sCULoOjG2hQQLrjy8Rq7SpwRBm1y8ne06qSx+DG9mAyFocZJUUGEgaFguRHsiPH9eSadjnbxJ4WeaZFRDrDR95U7tEU0PiiXeUVtxCZa8An0UIWD5fYX3BgMYLiEXDZxA9tbFPWcJWgio3X0C6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891586; c=relaxed/simple;
	bh=RkbtQlDT6yg+KA5CzIMwhnUeKJAuyxcqouu7s5bcLlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxqda+Gj/o+oH01cVnTEm02PQcpM855pbt/XtSSldWSCx04tPKaoYItYRcpGq+IfQuNI/PqlSrMaT2n7lo96q9sdEzZzeHd27VfIPTfR1RV3bptLvfKZ3g+2l8uWA2oUJRgZ/wuI2JIIz6acXXgrFTiiwOLC+cBBg/BeXJpxY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VUJroyY0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso13698835e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725891581; x=1726496381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmNZomq0tzGNF5A2KXaMDUzIOLvUyU3B8RAET9f1f00=;
        b=VUJroyY08RYhrSU0y6FxAchLZhfvO2DwPdkWCBtR7RI7fYZV/ZJnuGFhjcMUOg8TBU
         W5AKlk0RtgA2pM3PSadCjoU6QQ9lHCyEIyw0BdUxIVgfbZOvPqXwYcq2EYpU5uXnIyih
         ykymPt+UYYkWyio4rEbotyKip1ACYbIviN3hRgMyVUCQmqOO7VDbGGvHiEk4ebunKdpl
         L+EocXgob3nj/rj/mbgxBKLqcxLu4akucVbE8PefIPFqLc9OG4JcxuIR+Slbidd0shlQ
         pSMvqdLc7W6PtEERPalR968s0KXppHw6/MMArjWPAXED+xZUB8nkD0nIb96FkYsOcm+u
         hFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891581; x=1726496381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmNZomq0tzGNF5A2KXaMDUzIOLvUyU3B8RAET9f1f00=;
        b=ipA4meO12DHbRp95ZBD43ZLXiDJxHg0zH6XrzSUeMBKxSNYSus4qvuaOW91Q0i7cMr
         Vm/DxVuDw7AxUEt7E2XE3Y09dAqS9tVyvl/lJvRNWGeiEyGUdWAjK0mT7C+l67VrfQMF
         oBaTj3mxHMi7GiIumSspGi25S5CtAHLIc2dwSEk/XByDULx+XaBabzJHXu3slJIkN8F9
         /5z2mSVTmOAdfQyeYJ/QWyzkhG6ik2wad7KK2MxtPly5Cg4OeUQvJQj2S0Cv/l1Lmm8Z
         Rmp+sJKxyxsZbtB7NknG8Qno48lHowUkjvdha3bmlX2+jiyk7UZZ/bNQXt3An7UhIhgW
         9axQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPnfz1EZUD3MZye7hYy5Rtf8bKS2bMuADb9ti6wycegkl2Conj5CLog7dFm7lweIvGSLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmB4WDCEoBU1KUVtPap+/Sy/yBlNmnaz+cyJ2LEwCZcnTnAqOY
	uzyZiRQBX8b8L+WrJe4jHVhrxxqaZjWEL+6aK7o56gBc/RFxPIPFTdHXLzaBXVI=
X-Google-Smtp-Source: AGHT+IHBxCUzyue5bwpE5IKibXLbKzoBlQimEFeBEwBQy4CEK9sBVaxcmFbE9YZqE4IMQJ1ff+Vhug==
X-Received: by 2002:a05:600c:358a:b0:42c:b950:6821 with SMTP id 5b1f17b1804b1-42cb9506a4amr21150175e9.19.1725891580826;
        Mon, 09 Sep 2024 07:19:40 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb3cb6f74sm54467535e9.23.2024.09.09.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:19:40 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:19:38 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxjcg3n7kjqgyiwo"
Content-Disposition: inline
In-Reply-To: <20240817093334.6062-2-chenridong@huawei.com>


--uxjcg3n7kjqgyiwo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> acquired in different tasks, which may lead to deadlock.
> It can lead to a deadlock through the following steps:
> 1. A large number of cpusets are deleted asynchronously, which puts a
>    large number of cgroup_bpf_release works into system_wq. The max_active
>    of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
>    cgroup_bpf_release works, and many cgroup_bpf_release works will be put
>    into inactive queue. As illustrated in the diagram, there are 256 (in
>    the acvtive queue) + n (in the inactive queue) works.
> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>    smp_call_on_cpu work into system_wq. However step 1 has already filled
>    system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
>    to wait until the works that were put into the inacvtive queue earlier
>    have executed (n cgroup_bpf_release), so it will be blocked for a whil=
e.
> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step =
2.
> 4. Cpusets that were deleted at step 1 put cgroup_release works into
>    cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
>    When cgroup_metux is acqured by work at css_killed_work_fn, it will
>    call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
>    However, cpuset_css_offline will be blocked for step 3.
> 5. At this moment, there are 256 works in active queue that are
>    cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
>    a result, all of them are blocked. Consequently, sscs.work can not be
>    executed. Ultimately, this situation leads to four processes being
>    blocked, forming a deadlock.
>=20
> system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(=
step4)
> ...
> 2000+ cgroups deleted asyn
> 256 actives + n inactives
> 				__lockup_detector_reconfigure
> 				P(cpu_hotplug_lock.read)
> 				put sscs.work into system_wq
> 256 + n + 1(sscs.work)
> sscs.work wait to be executed
> 				warting sscs.work finish
> 								percpu_down_write
> 								P(cpu_hotplug_lock.write)
> 								...blocking...
> 											css_killed_work_fn
> 											P(cgroup_mutex)
> 											cpuset_css_offline
> 											P(cpu_hotplug_lock.read)
> 											...blocking...
> 256 cgroup_bpf_release
> mutex_lock(&cgroup_mutex);
> ..blocking...

Thanks, Ridong, for laying this out.
Let me try to extract the core of the deps above.

The correct lock ordering is: cgroup_mutex then cpu_hotplug_lock.
However, the smp_call_on_cpu() under cpus_read_lock may lead to
a deadlock (ABBA over those two locks).

This is OK
	thread T					system_wq worker
=09
	  						lock(cgroup_mutex) (II)
							...
							unlock(cgroup_mutex)
	down(cpu_hotplug_lock.read)
	smp_call_on_cpu
	  queue_work_on(cpu, system_wq, scss) (I)
							scss.func
	  wait_for_completion(scss)
	up(cpu_hotplug_lock.read)

However, there is no ordering between (I) and (II) so they can also happen
in opposite

	thread T					system_wq worker
=09
	down(cpu_hotplug_lock.read)
	smp_call_on_cpu
	  queue_work_on(cpu, system_wq, scss) (I)
	  						lock(cgroup_mutex)  (II)
							...
							unlock(cgroup_mutex)
							scss.func
	  wait_for_completion(scss)
	up(cpu_hotplug_lock.read)

And here the thread T + system_wq worker effectively call
cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
two threads, it won't be caught by lockdep.)

By that reasoning any holder of cgroup_mutex on system_wq makes system
susceptible to a deadlock (in presence of cpu_hotplug_lock waiting
writers + cpuset operations). And the two work items must meet in same
worker's processing hence probability is low (zero?) with less than
WQ_DFL_ACTIVE items.

(And more generally, any lock that is ordered before cpu_hotplug_lock
should not be taken in system_wq work functions. Or at least such works
items should not saturate WQ_DFL_ACTIVE workers.)

Wrt other uses of cgroup_mutex, I only see
  bpf_map_free_in_work
    queue_work(system_unbound_wq)
      bpf_map_free_deferred
        ops->map_free =3D=3D cgroup_storage_map_free
          cgroup_lock()
which is safe since it uses a different workqueue than system_wq.

> To fix the problem, place cgroup_bpf_release works on cgroup_destroy_wq,
> which can break the loop and solve the problem.

Yes, it moves the problematic cgroup_mutex holder away from system_wq
and cgroup_destroy_wq could not cause similar problems because there are
no explicit waiter for particular work items or its flushing.


> System wqs are for misc things which shouldn't create a large number
> of concurrent work items.  If something is going to generate
> >WQ_DFL_ACTIVE(256) concurrent work
> items, it should use its own dedicated workqueue.

Actually, I'm not sure (because I lack workqueue knowledge) if producing
less than WQ_DFL_ACTIVE work items completely eliminates the chance of
two offending work items producing the wrong lock ordering.


> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgrou=
p itself")

I'm now indifferent whether this is needed (perhaps in the sense it is
the _latest_ of multiple changes that contributed to possibility of this
deadlock scenario).


> Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb6=
0@huawei.com/T/#t
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/bpf/cgroup.c             | 2 +-
>  kernel/cgroup/cgroup-internal.h | 1 +
>  kernel/cgroup/cgroup.c          | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)

I have convinved myself now that you can put

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

Regards,
Michal

--uxjcg3n7kjqgyiwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt8D9QAKCRAt3Wney77B
SQQCAP45v0WT5P4mlwx1ORHVmc0agb3HKzQ/+z3OLHSb2db+tAEA+2yVguo5s74u
0RLWr97lT8UGEQS7pvS4+nH6qTf5CgU=
=Ex6+
-----END PGP SIGNATURE-----

--uxjcg3n7kjqgyiwo--

