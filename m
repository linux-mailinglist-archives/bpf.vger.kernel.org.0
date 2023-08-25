Return-Path: <bpf+bounces-8538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAC5787C89
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49947281701
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46D361;
	Fri, 25 Aug 2023 00:26:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A27E
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 00:26:59 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2061BD1
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 17:26:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so59911cf.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 17:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692923216; x=1693528016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE/ztH2CwgACZMdtKdLIrzyQq3XwqfUPfcUgZae1/tY=;
        b=HMLwfExOUEm0eHZm+mdNFpcqy472UOfiT4r19OayyzYi8yvtkqg76227NHCgEmoIYY
         U9ox956Ojq6JCQVYzKx6wQL8k4kDQSqCHivmJQUJiWFcKtycEFnydCHK1m6Mtigb+uik
         B/vBchI88W242d14tr6ZlmO2sNVxbEaFMp3Dd5yBLXfUyCiL8T4ZXzzrmF6X0NK0r6+4
         M2lrdq8HEXHEBGDuUDkWKEbOXWbKotpZm7ERxh300qI7Q3O2GIIQ/5LQ0/twxtxzGV82
         uDl4jGM4viH04Q4W2nXfb3DbVE2vKkELkmraSRqDeDJ3EXJO5cuySAG3ffjGhn0Wt8Lx
         xPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692923216; x=1693528016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE/ztH2CwgACZMdtKdLIrzyQq3XwqfUPfcUgZae1/tY=;
        b=Le9ORm92UTuCV8xc7rFKt2NU5jh9hh0d1g9B7O8uK834+N35ptR/OKHQkh58aQE4eJ
         Am3o38F+zrCj388JTQ/VUO4t27V4CeZBY85V5TMk4GbjgGSBntlVBaefrnMKfy+C7QG2
         C64BInlC+BrfzD0mnKNGh4s6A4zERpYR+c7f3ZJOG7t8ZKwvU6JtF1zSO0Ju57b3HSCZ
         I6K4BpFGXN0iL3WnX0fyMOikZScba0YD7ttQYyS14d3EEc+KBHnjsBKAsJkwkqlrU1Np
         M2yC3ZSR+MxXKWib/Id/jeaSyRMoH5FrsFjgLbJ2+MuhBrnfZoxmdkQU0WgLJZtPYwaY
         q5Ww==
X-Gm-Message-State: AOJu0YwBoCnzVzjq99QNhy8oTybGUZtILVWNFpdwLXp+DZFWtcOvtgZg
	aXtikjH4DHi/1KZ/tMwCAoqL/1b7TbAzqUih5FjIig==
X-Google-Smtp-Source: AGHT+IHNaFDpzxX5di1BodQif0JJ/0PqZnNj/F7MTdbPhlmXm/HwLRUe5zozWPARHwHHTJn4A1/5937WG8wrTThGrxM=
X-Received: by 2002:ac8:7d09:0:b0:410:a4cb:9045 with SMTP id
 g9-20020ac87d09000000b00410a4cb9045mr160249qtb.18.1692923216047; Thu, 24 Aug
 2023 17:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711011412.100319-1-tj@kernel.org> <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
In-Reply-To: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
From: Josh Don <joshdon@google.com>
Date: Thu, 24 Aug 2023 17:26:45 -0700
Message-ID: <CABk29Nt_iCv=2nbDUqFHnszMmDYNC7xEm1nNQXibnPKUxhsN_g@mail.gmail.com>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>, peterz@infradead.org
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, brho@google.com, pjt@google.com, derkling@google.com, 
	haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com, 
	dskarlat@cs.cmu.edu, riel@surriel.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Fri, Jul 21, 2023 at 11:37=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
[snip]
> We are comfortable with the current API. Everything we tried fit pretty
> well. It will continue to evolve but sched_ext now seems mature enough fo=
r
> initial inclusion. I suppose lack of response doesn't indicate tacit
> agreement from everyone, so what are you guys all thinking?

I want to reiterate Google=E2=80=99s support for this proposal.

We=E2=80=99ve been experimenting with pluggable scheduling via our ghOSt
framework (https://github.com/google/ghost-kernel) for quite a while
now. A few things have become clearly evident.

(1) There is a very non-trivial level of headroom that can be taken
advantage of by directed policy that more closely specializes to the
types of workloads deployed on a machine. I can provide two direct
examples.
In Search, the backend application has intimate knowledge of thread
workloads and RPC deadlines, which it immediately communicates to our
BPF scheduler via BPF maps. We've used this info to construct a policy
that reduces context switches, decreases p99 latency, and increases
QPS by 5% in testing. The flexibility of expressiveness in terms of
priority goes far beyond what niceness or cpu.shares could achieve.

For VM workloads, we=E2=80=99ve been testing a policy that has virtually
eliminated our >10ms latency tails via a combination of deadline and
fair scheduling, using an approach inspired by Tableau
(https://arpangujarati.github.io/pdfs/eurosys2018_paper.pdf). I find
this case particularly appealing from a pluggable scheduling
perspective because it highlights an area in which specialization to
the type of workload (VMs, which prefer longer, gang scheduled,
uninterrupted, and predictable low-latency access to CPU) provides
clear benefits, yet is not appropriate for a general-purpose scheduler
like CFS.

(2) Sched knobs are incredibly useful, and tuning has real effects.
The scheduler exports various debugfs knobs to control behavior, such
as minimum granularity, overall sched latency, and migration cost.
These mostly get baked into the kernel with semi-arbitrary values.
But, experimentally, it makes a lot of sense to (for example) lower
the migration cost on certain combinations of hardware and workload,
taking a tradeoff to increase migration rate but reduce non-work
conserving behavior.

We=E2=80=99ve taken this idea further with an ML based system to automatica=
lly
find the best combination of sched knobs for a given workload, given a
goal such as to maximize QPS. This has resulted in gains of 2-5%; a
lot of performance to leave on the table simply due to using preset
defaults. Pluggable scheduling would further increase the surface area
of experimentation, and yield additional insight into what other
kernel heuristics could be improved. It was from the ML work that we
gleaned that migrating tasks in smaller batches, but more frequently,
was a better tradeoff than the default configuration.

(3) There are a number of really interesting scheduling ideas that
would be difficult or infeasible to bake into the kernel. One clear
example is core scheduling, which was quite a complex addition to the
kernel (for example, due to managing fairness of tasks spanning the
logical cpus of a core), but which has relatively straightforward
implementation in sched_ext and ghOSt (for example, in ghOSt, a single
cpu can issue a transaction to run tasks on both itself and its
sibling, achieving the needed security property of core scheduling.
Fairness follows easily because runqueues can easily be any shape in
userspace, such as per-core.).
Another interesting idea is to offload scheduling entirely from VM
cores in order to keep ticks stopped with NOHZ independent of the task
count, since preemptive scheduling can be driven by a remote core.


Moving forward, we=E2=80=99re planning to redesign our ghOSt userspace
infrastructure to work on top of the sched_ext kernel infrastructure.
We think there=E2=80=99s a lot of benefit to the sched_ext design, especial=
ly
the very tight BPF integration. We=E2=80=99re committed to the idea of
pluggable scheduling, and are in close collaboration with Meta to
advance this work while we simultaneously deploy it internally.

Best,
Josh

