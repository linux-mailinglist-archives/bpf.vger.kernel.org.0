Return-Path: <bpf+bounces-56987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12CAA3BAF
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B94C6B6A
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C822777E4;
	Tue, 29 Apr 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHSrQDYu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F524BD02
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966668; cv=none; b=SVB/T4PJLVxjEEHfcMxOUPg61bSbYsDiCUc2KbgskuMIwTb8kRG+IaeLzs+dpuT6OjCcrligzcB0jHJNjTO1FqIfDi4EHlkYiikeB+VGZmNOHeE8BDB9NocyqvE5SnEnebdqeBqnafuPPkv7edHxH8KDzTkxVlKsdAeOPoChEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966668; c=relaxed/simple;
	bh=wY9say8tGiLCWO3IU3LClcUQ6iwxEoNogz9c5HCWbbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3oya6MOHWEXZfxKn6nOcSuC7nalB6q+ZIVV3M9z7tdgEaSrPhB6YsemRdePWuZgPmem6l9kH9FOcs4Xu4jc4W8vFEB4/5zI0nwcOHzqX/gRCF2X8WE6+AKHZrp1velVX0V5/rVxxT3SMAKZGb2jteLpklXiZ5qYTgLAgNwBKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHSrQDYu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47666573242so476791cf.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745966666; x=1746571466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q+2haq7XwAv6J5PtSHPQ69YS6DBi9vH+XHrN06jFIM=;
        b=NHSrQDYuvvtQkXmwavpy/3IET/FzBVQm0xjMRiXZljjwwMmFD6OLpzvnFMkcQyr9ah
         ptIY/Vxk/47yqOcuulVEUK5FeuDNr3lf00mexcKLHKa4hFksHPIF6k3klrWZSZruCCE3
         UyOrY+qIZ02sfiiKo3OZE4GmgXCIIh6dRNKL8HoVLdfWvnKhs1w4SU2ftP5Zq9p0dLL2
         yrKi5rg++VZnSAW5LiVif51uTtlfCJPMTWb4COxECm/jN8UIJdlN3o3ONlCq+OYrQQpM
         5hQ81AwGeEZpx5jD7OKdrDzJraenifSn/Wb/vKhYTv7Ot7yAaqfLhJb1S9Fc+Rs7PtaT
         zSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966666; x=1746571466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q+2haq7XwAv6J5PtSHPQ69YS6DBi9vH+XHrN06jFIM=;
        b=YiZhEOF+tpJyj4QPgGdZx2tWHSCA7t/aijBk1ZChkB6THYaS7W5gkMRKj1e3F9KFk8
         yEkjib1XW7e1MvoGw4dLnPD1t5Eci1JM3AVg+Ahdo4Bb63dy03TW7o8cJNgyu1T2r7GK
         gJwp4PTtFQlNyshaWjKctAtfXwHkAuM/n07nYHCS+6yEdfLmOLyngdAfpQc40kYhpxe7
         swobN12CMXYQx+jHVmC/xfMdprc4yP3nneX5fFT+xA30dfl4HuCbk3TXi07G9+X1o098
         gHJczYToNLlt0p8uy7VlerXlh3FWPyl+oj9yGk9SiyvKuFPC6l75sjrODGiuH9mSOq3x
         eSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cEse6kVvu0vMgFobqNOaimZj4lZr9rCuXxp9Up1i/3Jm+E4xabeXE+SzXpUB5VZTVv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1sIxE//zy6SxW5+u9GNy6rj6r3LOuApAb+/9CMZPWYf7fprE
	WnGZZMpwEPzlwASKg2p/aHlv97JCTAM7rPSMNT3sDDglYJeEnpRW/JwX0N+XyWIQobZjvzGuQkF
	j0DUIHVcpZrukg/EpaEHILeTQfuhcQgwmIijk
X-Gm-Gg: ASbGncvMk16Hed+5Nw6Uk2oPczdRTMeeQ0ngU2ESeQVuycmkgfoFXw9CtaBgpEEwedY
	aPvepRo6AHfHrMs8oHnVAXVjUBLg+XG7RVHWRxTINXwkNZR15GzkfC5X/TBvft/oPlKqG5kq9lN
	O4msfXdr3ECnTyMzKsXPcznNA7L5M+h8cdlIzoNRu9XirTdh0A5AFcUyFaLJ7wMFY=
X-Google-Smtp-Source: AGHT+IGp3ol19l66XpIR0HRveaM+/EwEn2dP2bkpY0B9zrpxdPZiZBnty9O1i5cicSDF8bDdT7SZ8k6g1jsNGNxwKCI=
X-Received: by 2002:a05:622a:44e:b0:477:63b7:3523 with SMTP id
 d75a77b69052e-489b9935eafmr1740991cf.4.1745966665576; Tue, 29 Apr 2025
 15:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 15:44:14 -0700
X-Gm-Features: ATxdqUFgwg8VjWDE02DoJhjYn9FVXzG-oTsO_zJH_wM8K_TPzbvSWrGdfiA0Du4
Message-ID: <CAJuCfpHnND1UJ1ZqiyshPqwbZDfeN41HOUuc7DWQfSM1cATBmQ@mail.gmail.com>
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Rientjes <rientjes@google.com>, 
	Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 8:36=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> This patchset adds an ability to customize the out of memory
> handling using bpf.
>
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
>
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking-based policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
>
> It provides a generic hook which is called before the existing OOM
> killer code and allows implementing any policy, e.g.  picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).
>
> The past attempt to implement memory-cgroup aware policy [2] showed
> that there are multiple opinions on what the best policy is.  As it's
> highly workload-dependent and specific to a concrete way of organizing
> workloads, the structure of the cgroup tree etc, a customizable
> bpf-based implementation is preferable over a in-kernel implementation
> with a dozen on sysctls.
>
> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls. In this scenario the userspace daemon was supposed to handle
> the majority of OOMs, while the in-kernel OOM killer worked as the
> last resort measure to guarantee that the system would never deadlock
> on the memory. But this approach creates additional infrastructure
> churn: userspace OOM daemon is a separate entity which needs to be
> deployed, updated, monitored. A completely different pipeline needs to
> be built to monitor both types of OOM events and collect associated
> logs. A userspace daemon is more restricted in terms on what data is
> available to it. Implementing a daemon which can work reliably under a
> heavy memory pressure in the system is also tricky.

I didn't read the whole patchset yet but want to mention couple
features that we should not forget:
- memory reaping. Maybe you already call oom_reap_task_mm() after BPF
oom-handler kills a process or maybe BPF handler is expected to
implement it?
- kill reporting to userspace. I think BPF handler would be expected
to implement it?

>
> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@byt=
edance.com/
> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> [3]: https://github.com/facebookincubator/oomd
> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd=
.service.html
>
> ----
>
> This is an RFC version, which is not intended to be merged in the current=
 form.
> Open questions/TODOs:
> 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
>    It has to be able to return a value, to be sleepable (to use cgroup it=
erators)
>    and to have trusted arguments to pass oom_control down to bpf_oom_kill=
_process().
>    Current patchset has a workaround (patch "bpf: treat fmodret tracing p=
rogram's
>    arguments as trusted"), which is not safe. One option is to fake acqui=
re/release
>    semantics for the oom_control pointer. Other option is to introduce a =
completely
>    new attachment or program type, similar to lsm hooks.
> 2) Currently lockdep complaints about a potential circular dependency bec=
ause
>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under oo=
m_lock.
>    One way to fix it is to make it non-sleepable, but then it will requir=
e some
>    additional work to allow it using cgroup iterators. It's intervened wi=
th 1).
> 3) What kind of hierarchical features are required? Do we want to nest oo=
m policies?
>    Do we want to attach oom policies to cgroups? I think it's too complic=
ated,
>    but if we want a full hierarchical support, it might be required.
>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the =
true root
>    memcg, which is potentially outside of the ns of the loading process. =
Does
>    it require some additional capabilities checks? Should it be removed?
> 4) Documentation is lacking and will be added in the next version.
>
>
> Roman Gushchin (12):
>   mm: introduce a bpf hook for OOM handling
>   bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
>   bpf: treat fmodret tracing program's arguments as trusted
>   mm: introduce bpf_oom_kill_process() bpf kfunc
>   mm: introduce bpf kfuncs to deal with memcg pointers
>   mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
>   bpf: selftests: introduce read_cgroup_file() helper
>   bpf: selftests: bpf OOM handler test
>   sched: psi: bpf hook to handle psi events
>   mm: introduce bpf_out_of_memory() bpf kfunc
>   bpf: selftests: introduce open_cgroup_file() helper
>   bpf: selftests: psi handler test
>
>  include/linux/memcontrol.h                   |   2 +
>  include/linux/oom.h                          |   5 +
>  kernel/bpf/btf.c                             |   9 +-
>  kernel/bpf/verifier.c                        |   5 +
>  kernel/sched/psi.c                           |  36 ++-
>  mm/Makefile                                  |   3 +
>  mm/bpf_memcontrol.c                          | 108 +++++++++
>  mm/oom_kill.c                                | 140 +++++++++++
>  tools/testing/selftests/bpf/cgroup_helpers.c |  67 ++++++
>  tools/testing/selftests/bpf/cgroup_helpers.h |   3 +
>  tools/testing/selftests/bpf/prog_tests/oom.c | 227 ++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/psi.c | 234 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_oom.c | 103 ++++++++
>  tools/testing/selftests/bpf/progs/test_psi.c |  43 ++++
>  14 files changed, 983 insertions(+), 2 deletions(-)
>  create mode 100644 mm/bpf_memcontrol.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/oom.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/psi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c
>
> --
> 2.49.0.901.g37484f566f-goog
>

