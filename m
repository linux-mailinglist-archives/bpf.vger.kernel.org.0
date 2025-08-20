Return-Path: <bpf+bounces-66130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4DB2E8AF
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89C54E4349
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F41B2E11CA;
	Wed, 20 Aug 2025 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QihiG2Dj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D481D86DC;
	Wed, 20 Aug 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732828; cv=none; b=SQN0G8wuZcRLqnMbmW/r2WX59DlZgibaO7QG2qirzuuJaomQuXKznU6aNEHRhBVOacMJAUos765V3uY5xAeccg+0iAFikuQrheFqblIYB08El5SJShAUK4fsMaIbLqEMtmei+4XsQUt6JVXQ5kAO8MIL3Vs0K38C34kbN4xQFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732828; c=relaxed/simple;
	bh=v94pCC9AMCpWFZn/le19ZZsTjIY7F3cpj6xBEnOfLCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa+5p38YwUVFgzZ6Snq9VU5YBvafCYLJ0h7wTjtgsqNNPSUKjqPum5esS0vnbKyaow2ZgbD3cfoniOCm2pikR4nQiFo21KgERMD3lTLxi1zeoenCZoAqkEqdHxq0Rjz9o1sx9H/YqsCsNsBs8I6k/RT+tHmvuUGqogBCkXQAa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QihiG2Dj; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb72d5409so59448266b.0;
        Wed, 20 Aug 2025 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755732824; x=1756337624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eMa5hDCcy00DzZK+4d6bk0F5shIXQnXC8ZXi1NtBu6Y=;
        b=QihiG2Djz06KlnnULcgVkTSYU3airVuR9ScY0Thd+h1eWRh1nXvietBkrTovdzabp+
         WWBzQZxAmeMCCBSaYct0/A4sS1VuL/BkHy/EZrI8i7Ld2sY3DKQcsK2rhsyqPcT4c+FY
         Xj/C+VnEAd52PDZ5krtmq8rAxcLRIHDmvzEdMRtjGbfoJ7MYFJbzLH3N+Ac8RhQ471Ux
         zCJmvewhlMtK3CceW4YlbjStq/AQvHbcJxXZ7Z+2oasWirXe+2yDugCrtTJOfYdZWS+A
         qWeKo/eiEwPNgzp1SOu3P10veMIZTVtl9c7BwfMqa+2LXQwcJI9KW6Rp0MNCdBUhx9+b
         hhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755732824; x=1756337624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMa5hDCcy00DzZK+4d6bk0F5shIXQnXC8ZXi1NtBu6Y=;
        b=EnF85c+DSvhfBFcPAiLERT1K8hqI9FBCTB1NTg1sE0GzvlUX6XMdF6zFfmVyY4gad8
         6hpfO66VnGnE28pOwUjp2l5UYoaakdX+wMuSe+hi7M6F1Wo+eKeojeG6MBfpjt6Qz2Zj
         TkwN3i/UU3qz88ODrmO/DVnTrONwH+rTSY627Gv+s3GcoAKcym2O8YiGlaLeCc+My/dM
         /hbXBPhKbzlmnn6g+HLSZ/ZbqMYz8LPHOEy4d93AkkGRx9MgQVTXbi6YmDaulev7cii1
         54WtujwoW1lebmtiwVR0gBqA9vYP4oQEhfl8k7uzQijXaCjlulIWdd/bAWFicpxGCPT4
         CWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUQh61KSlMpFOXmTEfEJzPhYDV2+iE4mPiXDE7DAS+TZcpdZcAg1LFruH441WS0hUoOhtZMArRAllyMWPA@vger.kernel.org, AJvYcCVnuot4Sa8OAOa3FD0ehghmGjFmoxyrW6mNMFX64wVv2GdTPnkp1I0lVgZJ2jjbn1VzrlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxT31g2Hljr8w0GjQW4LmENH1nEqXRUgHqRI38gh+JB1Al65P
	v6ikHjUAmAc5GwAJDMbMEUx6yTvBoWzolIdFBlhjVR605IwOPkIKdFeFQAZx6YIZRZy5vtt46tX
	LGsTTzN6SNuoHHOCg4lX0VoOiPtauFckkArag
X-Gm-Gg: ASbGncvKyJ53uBffpY5/4bK2lGbTTBGGBxiSMEbFgH2lF4CTP/1f0WiKcASrJdda9/B
	bg4kFoJqZ9hTqqi76BoIlyOmO6iE0m8WqwYoJ9TWCwVNpwPgKR5uY3a95tj2RvFKi81Kl/C95+i
	YMGympDfW+pehYXxOAbRCuNZOBT+auJ/MvQTXEbmh687Xy9DB2unCH2fF7jBwRhVDpWaKvizdEp
	El2TK+n
X-Google-Smtp-Source: AGHT+IGy7pBJhS/s9zgv7RuaStEj5/bZcNiNoBaaY+sPnjxw6k583h9j3V73e3aXVyd/P0UyTYZWXtPFmoKmmEG7bjc=
X-Received: by 2002:a17:907:3f2a:b0:ae3:f903:e41 with SMTP id
 a640c23a62f3a-afe07e4b6d3mr52682066b.54.1755732824430; Wed, 20 Aug 2025
 16:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-5-roman.gushchin@linux.dev> <CAP01T77yTb69hhi0CtDp9afVzO3T0fyPqhBF7By-iYYy__uOjA@mail.gmail.com>
 <87y0rdobq1.fsf@linux.dev>
In-Reply-To: <87y0rdobq1.fsf@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Aug 2025 01:33:07 +0200
X-Gm-Features: Ac12FXyVgUuTqfIxaQ6U-WHmd3Kj3yK2MQ1qHDQGthNBax58JBZkGn_b0uDcmcY
Message-ID: <CAP01T76t3V_7PDoKJZ04cLfLYmUyAgJ54uyGpQGduWhXrQkXfA@mail.gmail.com>
Subject: Re: [PATCH v1 04/14] mm: introduce bpf kfuncs to deal with memcg pointers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 00:43, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >>
> >> To effectively operate with memory cgroups in bpf there is a need
> >> to convert css pointers to memcg pointers. A simple container_of
> >> cast which is used in the kernel code can't be used in bpf because
> >> from the verifier's point of view that's a out-of-bounds memory access.
> >>
> >> Introduce helper get/put kfuncs which can be used to get
> >> a refcounted memcg pointer from the css pointer:
> >>   - bpf_get_mem_cgroup,
> >>   - bpf_put_mem_cgroup.
> >>
> >> bpf_get_mem_cgroup() can take both memcg's css and the corresponding
> >> cgroup's "self" css. It allows it to be used with the existing cgroup
> >> iterator which iterates over cgroup tree, not memcg tree.
> >>
> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> ---
> >>  include/linux/memcontrol.h |   2 +
> >>  mm/Makefile                |   1 +
> >>  mm/bpf_memcontrol.c        | 151 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 154 insertions(+)
> >>  create mode 100644 mm/bpf_memcontrol.c
> >>
> >> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> >> index 87b6688f124a..785a064000cd 100644
> >> --- a/include/linux/memcontrol.h
> >> +++ b/include/linux/memcontrol.h
> >> @@ -932,6 +932,8 @@ static inline void mod_memcg_page_state(struct page *page,
> >>         rcu_read_unlock();
> >>  }
> >>
> >> +unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> >> +unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
> >>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> >>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
> >>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> >> diff --git a/mm/Makefile b/mm/Makefile
> >> index a714aba03759..c397af904a87 100644
> >> --- a/mm/Makefile
> >> +++ b/mm/Makefile
> >> @@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
> >>  endif
> >>  ifdef CONFIG_BPF_SYSCALL
> >>  obj-y += bpf_oom.o
> >> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
> >>  endif
> >>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
> >>  obj-$(CONFIG_GUP_TEST) += gup_test.o
> >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> >> new file mode 100644
> >> index 000000000000..66f2a359af7e
> >> --- /dev/null
> >> +++ b/mm/bpf_memcontrol.c
> >> @@ -0,0 +1,151 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Memory Controller-related BPF kfuncs and auxiliary code
> >> + *
> >> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> >> + */
> >> +
> >> +#include <linux/memcontrol.h>
> >> +#include <linux/bpf.h>
> >> +
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +/**
> >> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> >> + * @css: pointer to the css structure
> >> + *
> >> + * Returns a pointer to a mem_cgroup structure after bumping
> >> + * the corresponding css's reference counter.
> >> + *
> >> + * It's fine to pass a css which belongs to any cgroup controller,
> >> + * e.g. unified hierarchy's main css.
> >> + *
> >> + * Implements KF_ACQUIRE semantics.
> >> + */
> >> +__bpf_kfunc struct mem_cgroup *
> >> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> >> +{
> >> +       struct mem_cgroup *memcg = NULL;
> >> +       bool rcu_unlock = false;
> >> +
> >> +       if (!root_mem_cgroup)
> >> +               return NULL;
> >> +
> >> +       if (root_mem_cgroup->css.ss != css->ss) {
> >> +               struct cgroup *cgroup = css->cgroup;
> >> +               int ssid = root_mem_cgroup->css.ss->id;
> >> +
> >> +               rcu_read_lock();
> >> +               rcu_unlock = true;
> >> +               css = rcu_dereference_raw(cgroup->subsys[ssid]);
> >> +       }
> >> +
> >> +       if (css && css_tryget(css))
> >> +               memcg = container_of(css, struct mem_cgroup, css);
> >> +
> >> +       if (rcu_unlock)
> >> +               rcu_read_unlock();
> >> +
> >> +       return memcg;
> >> +}
> >> +
> >> +/**
> >> + * bpf_put_mem_cgroup - Put a reference to a memory cgroup
> >> + * @memcg: memory cgroup to release
> >> + *
> >> + * Releases a previously acquired memcg reference.
> >> + * Implements KF_RELEASE semantics.
> >> + */
> >> +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> >> +{
> >> +       css_put(&memcg->css);
> >> +}
> >> +
> >> +/**
> >> + * bpf_mem_cgroup_events - Read memory cgroup's event counter
> >> + * @memcg: memory cgroup
> >> + * @event: event idx
> >> + *
> >> + * Allows to read memory cgroup event counters.
> >> + */
> >> +__bpf_kfunc unsigned long bpf_mem_cgroup_events(struct mem_cgroup *memcg, int event)
> >> +{
> >> +
> >> +       if (event < 0 || event >= NR_VM_EVENT_ITEMS)
> >> +               return (unsigned long)-1;
> >> +
> >> +       return memcg_events(memcg, event);
> >> +}
> >> +
> >> +/**
> >> + * bpf_mem_cgroup_usage - Read memory cgroup's usage
> >> + * @memcg: memory cgroup
> >> + *
> >> + * Returns current memory cgroup size in bytes.
> >> + */
> >> +__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
> >> +{
> >> +       return page_counter_read(&memcg->memory);
> >> +}
> >> +
> >> +/**
> >> + * bpf_mem_cgroup_events - Read memory cgroup's page state counter
> >> + * @memcg: memory cgroup
> >> + * @event: event idx
> >> + *
> >> + * Allows to read memory cgroup statistics.
> >> + */
> >> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
> >> +{
> >> +       if (idx < 0 || idx >= MEMCG_NR_STAT)
> >> +               return (unsigned long)-1;
> >> +
> >> +       return memcg_page_state(memcg, idx);
> >> +}
> >> +
> >> +/**
> >> + * bpf_mem_cgroup_flush_stats - Flush memory cgroup's statistics
> >> + * @memcg: memory cgroup
> >> + *
> >> + * Propagate memory cgroup's statistics up the cgroup tree.
> >> + *
> >> + * Note, that this function uses the rate-limited version of
> >> + * mem_cgroup_flush_stats() to avoid hurting the system-wide
> >> + * performance. So bpf_mem_cgroup_flush_stats() guarantees only
> >> + * that statistics is not stale beyond 2*FLUSH_TIME.
> >> + */
> >> +__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >> +{
> >> +       mem_cgroup_flush_stats_ratelimited(memcg);
> >> +}
> >> +
> >> +__bpf_kfunc_end_defs();
> >> +
> >> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> >> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
> >
> > I think you could set KF_TRUSTED_ARGS for this as well.
>
> Not really. The intended use case is to iterate over the cgroup tree,
> which gives non-trusted css pointers:
>         bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
>                 memcg = bpf_get_mem_cgroup(css_pos);
>         }

Then I assume they're at least RCU protected? You could relax it from
trusted to KF_RCU (since I see css_tryget internally).
Otherwise the default behavior is unconstrained (any ptr matching that
type obtained from random walks --- which is something to fix, but
until then we have to actively mark for taking safe arguments).

>
> Thanks

