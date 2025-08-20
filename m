Return-Path: <bpf+bounces-66070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF67B2D8AD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E331A05EF5
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CF2DECA3;
	Wed, 20 Aug 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFI6vjsp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B572DC33B;
	Wed, 20 Aug 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682463; cv=none; b=WjQW5xeHrnafofjVzCGbXJ0oeUSifisOJ7PS5rmphc76l30fY5VoGJJfFdInWmxvU3G9JgTQV4QawDrS8lK895c53cEZp1YybzH0rXgL3FbGyjvtyDjBmclPqtVA48HGK1I935fikaK0U9MKMCsedz3zs0BD/CxPljpzcIHsQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682463; c=relaxed/simple;
	bh=KloKk+LlM5R3ZZr/Lsq5FB4BIuavstY9uH6J2ZRflaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIOPC4HImINbr18GQdFecOhYchAmFpBd4ESuan/7AdomVQu1zfRij4n7Rblpv7iVxQRWBmZ4SHcSjOb8WDJnA1YLGguDg7N56bVWhN5dFqPkDkFMmOaxLexO3sPLiGAC0q2jzNgMqEL44VRik22gIpcEdRPhcrBmwS3E6LLs6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFI6vjsp; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61aa702c9ebso60105a12.3;
        Wed, 20 Aug 2025 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755682460; x=1756287260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z79weBAoziwk7d5gCcPuETF5kep03u8b8tRTqrPor8s=;
        b=RFI6vjspXQi486V4Apq0imFKtJokM/9QkTeLrhbYw5mzcsfqKaWMK9CYDAoUdzXXxK
         nTbWbUfkUqNVLB4NhhvVzOVkLbLhkZBZtCy+wXCDHfqLss7oLFvjcIT/7Qs9erJLB/6r
         O8Mlkip7oIwjUupMGh1kRBG9xDT9YtC0JNXfic+CDvS0K3jIaPARtmoQPSip+LlIRGT1
         br8GyC42Gfuqy1p0LAFAzEB0SVwFHZTCSjuxVrzff5aGncBTrzU6CJlSu50vRgQC9JJN
         /rYKut8xKtE/iTcti+S5XVYor8Ipd7H8HC+0/gRl0qQNq9yDdJRgAWldTJ8bMz8Glz/y
         dWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682460; x=1756287260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z79weBAoziwk7d5gCcPuETF5kep03u8b8tRTqrPor8s=;
        b=Q7jJD48M/sSl0a03xg9OT6NJ450TvuwX4zu3iuusv4KXbk0FWnaxkvzrrW9ZQ9LAGL
         IeNodjhPc2rgqlwlvNc6B5egJVmHh+wYRQsKqAC3YHfQ4HSSk3Fd8JSrGjqoQBi89dLJ
         nl6FubB9AbgogtD6IxpnhuALR6rAoNsfQfgg3ym0Fp8aXEnCLbh4PXaRDnYROBh4OInz
         fB5n/Auz4r5VhqRgP9cDe2Ayt+mq5q/2p2Yp7GDbi/eYXHglpEP++986mco/asTIn5H8
         Aw2xQI8mf5sLHHS3jDpplArHqqRg0hTTSbqO40/QLFC0jGPPSEEVlY2JuS3MTDEdbl2k
         6Bag==
X-Forwarded-Encrypted: i=1; AJvYcCU5wvJjiQZHzyPHFCzGD0KXXrpZm6pE5QmGJBgz24AIvwXZjI3T4KQaAl0JqXUeg2vdBCxrtJK3m7h+B8gj@vger.kernel.org, AJvYcCXHwEsReMXyol6BUixq/GhTAtKO0AKiLJHRUG4fDh/8b0MTleP0PBxUaJiB5/mWMVgjIgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxy9MCpNffAVE1mnPFImpe5FZ8BjiDo1WpLrXZDKWSm9M3H7r
	buU4be9vBUpKO991WhTCO1Bp/77BKImxvifguk7y6vqMwtCfQqd2uK2I57B3VaGnDpd7+vfyC9B
	vwsUot089iwpqIQ9e5Y4q73JuicoLQfg=
X-Gm-Gg: ASbGncsVlwnlXaBkUH6E39K3B2r0ajycb8cKDsHA2WAffJ5nhYlvDrcrRuteIZNIkzg
	KPOvxS7BTejrZh5RU3EjyYOEO7bHMGKU8kvpxB5NVTHYelLgm1SpiUVGpie0uUPu+mYmKpWmUcv
	/vupmSypdtoSc6MSov6vYlmrcZHFdPpxEbJQ9BMvBXjzNE8g5pAy/UuJAsEKFB4Z0QwWSqSNu+w
	/dqM0NfRg==
X-Google-Smtp-Source: AGHT+IF7Z5HBgUuHRtZlDrk58pIlZKtqCG8u6CXuofJUTADQqbgEbDss+NhRKT3L0lSiXhbMysoUuPReH3dWOu/K2ZQ=
X-Received: by 2002:a05:6402:28cd:b0:615:5cc1:3453 with SMTP id
 4fb4d7f45d1cf-61a97557064mr1873977a12.9.1755682459448; Wed, 20 Aug 2025
 02:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-11-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-11-roman.gushchin@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 11:33:42 +0200
X-Gm-Features: Ac12FXxwG_eiUHr_rNpX2v397tG-VV8CGyGn-PqOmB_AUl8RqPT5ZQXR7dMaoo0
Message-ID: <CAP01T75_ArZiy9AB6TwNZCxKJKw+2yg58xz1ubTGZr4ynVt+Mg@mail.gmail.com>
Subject: Re: [PATCH v1 10/14] bpf: selftests: bpf OOM handler test
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Implement a pseudo-realistic test for the OOM handling
> functionality.
>
> The OOM handling policy which is implemented in bpf is to
> kill all tasks belonging to the biggest leaf cgroup, which
> doesn't contain unkillable tasks (tasks with oom_score_adj
> set to -1000). Pagecache size is excluded from the accounting.
>
> The test creates a hierarchy of memory cgroups, causes an
> OOM at the top level, checks that the expected process will be
> killed and checks memcg's oom statistics.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  [...]
> +
> +/*
> + * Find the largest leaf cgroup (ignoring page cache) without unkillable tasks
> + * and kill all belonging tasks.
> + */
> +SEC("struct_ops.s/handle_out_of_memory")
> +int BPF_PROG(test_out_of_memory, struct oom_control *oc)
> +{
> +       struct task_struct *task;
> +       struct mem_cgroup *root_memcg = oc->memcg;
> +       struct mem_cgroup *memcg, *victim = NULL;
> +       struct cgroup_subsys_state *css_pos;
> +       unsigned long usage, max_usage = 0;
> +       unsigned long pagecache = 0;
> +       int ret = 0;
> +
> +       if (root_memcg)
> +               root_memcg = bpf_get_mem_cgroup(&root_memcg->css);
> +       else
> +               root_memcg = bpf_get_root_mem_cgroup();
> +
> +       if (!root_memcg)
> +               return 0;
> +
> +       bpf_rcu_read_lock();
> +       bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
> +               if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendants)
> +                       continue;
> +
> +               memcg = bpf_get_mem_cgroup(css_pos);
> +               if (!memcg)
> +                       continue;
> +
> +               usage = bpf_mem_cgroup_usage(memcg);
> +               pagecache = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
> +
> +               if (usage > pagecache)
> +                       usage -= pagecache;
> +               else
> +                       usage = 0;
> +
> +               if ((usage > max_usage) && mem_cgroup_killable(memcg)) {
> +                       max_usage = usage;
> +                       if (victim)
> +                               bpf_put_mem_cgroup(victim);
> +                       victim = bpf_get_mem_cgroup(&memcg->css);
> +               }
> +
> +               bpf_put_mem_cgroup(memcg);
> +       }
> +       bpf_rcu_read_unlock();
> +
> +       if (!victim)
> +               goto exit;
> +
> +       bpf_for_each(css_task, task, &victim->css, CSS_TASK_ITER_PROCS) {
> +               struct task_struct *t = bpf_task_acquire(task);
> +
> +               if (t) {
> +                       if (!bpf_task_is_oom_victim(task))
> +                               bpf_oom_kill_process(oc, task, "bpf oom test");

Is there a scenario where we want to invoke bpf_oom_kill_process when
the task is not an oom victim?
Would it be better to subsume this check in the kfunc itself?

> +                       bpf_task_release(t);
> +                       ret = 1;
> +               }
> +       }
> +
> +       bpf_put_mem_cgroup(victim);
> +exit:
> +       bpf_put_mem_cgroup(root_memcg);
> +
> +       return ret;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_oom_ops test_bpf_oom = {
> +       .name = "bpf_test_policy",
> +       .handle_out_of_memory = (void *)test_out_of_memory,
> +};
> --
> 2.50.1
>

