Return-Path: <bpf+bounces-6541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CE76AAC0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E45D281810
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F01ED35;
	Tue,  1 Aug 2023 08:18:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0A1110
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:18:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0191BF;
	Tue,  1 Aug 2023 01:18:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7591921DFE;
	Tue,  1 Aug 2023 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690877934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th3TVmao/0x4HDpYobaDa+zIfUP58vr2suXjIXYqDAs=;
	b=PFpC4n26NsDcbGMx678HIpahAvYlClpKV9/C3rrYlupG1oWWwGPqLcjCZucPuD36zQfxVe
	R6z6DgdNLJbTQ/9rx8Y2ukEuMW7oodt++QpDgwldM6R/AY9Qq4tE1LR6JtD6jPTArqBBR7
	bVcXjaazBfQ/TEvSERiuLSuGCqKxoiQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 663AA139BD;
	Tue,  1 Aug 2023 08:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IehFGO6/yGSEHgAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 01 Aug 2023 08:18:54 +0000
Date: Tue, 1 Aug 2023 10:18:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com, muchun.song@linux.dev,
	zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMi/7oWdrczvE8eU@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
 <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
 <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
 <ZMe17kOoHr/eYnVT@dhcp22.suse.cz>
 <f8f44103-afba-10ee-b14b-a8e60a7f33d8@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8f44103-afba-10ee-b14b-a8e60a7f33d8@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 01-08-23 00:26:20, Chuyi Zhou wrote:
> 
> 
> 在 2023/7/31 21:23, Michal Hocko 写道:
> > On Mon 31-07-23 14:00:22, Chuyi Zhou wrote:
> > > Hello, Michal
> > > 
> > > 在 2023/7/28 01:23, Michal Hocko 写道:
> > [...]
> > > > This sounds like a very specific oom policy and that is fine. But the
> > > > interface shouldn't be bound to any concepts like priorities let alone
> > > > be bound to memcg based selection. Ideally the BPF program should get
> > > > the oom_control as an input and either get a hook to kill process or if
> > > > that is not possible then return an entity to kill (either process or
> > > > set of processes).
> > > 
> > > Here are two interfaces I can think of. I was wondering if you could give me
> > > some feedback.
> > > 
> > > 1. Add a new hook in select_bad_process(), we can attach it and return a set
> > > of pids or cgroup_ids which are pre-selected by user-defined policy,
> > > suggested by Roman. Then we could use oom_evaluate_task to find a final
> > > victim among them. It's user-friendly and we can offload the OOM policy to
> > > userspace.
> > > 
> > > 2. Add a new hook in oom_evaluate_task() and return a point to override the
> > > default oom_badness return-value. The simplest way to use this is to protect
> > > certain processes by setting the minimum score.
> > > 
> > > Of course if you have a better idea, please let me know.
> > 
> > Hooking into oom_evaluate_task seems the least disruptive to the
> > existing oom killer implementation. I would start by planing with that
> > and see whether useful oom policies could be defined this way. I am not
> > sure what is the best way to communicate user input so that a BPF prgram
> > can consume it though. The interface should be generic enough that it
> > doesn't really pre-define any specific class of policies. Maybe we can
> > add something completely opaque to each memcg/task? Does BPF
> > infrastructure allow anything like that already?
> > 
> 
> “Maybe we can add something completely opaque to each memcg/task?”
> Sorry, I don't understand what you mean.

What I meant to say is to add a very non-specific interface that would
would a specific BPF program understand. Mostly an opaque value from the
memcg POV.

> I think we probably don't need to expose too much to the user, the following
> might be sufficient:
> 
> noinline int bpf_get_score(struct oom_control *oc,
> 		struct task_struct *task);
> 
> static int oom_evaluate_task()
> {
> 	...
> 	points = bpf_get_score(oc, task);
> 	if (!check_points_valid(points))
>          	points = oom_badness(task, oc->totalpages);
> 	...
> }
> 
> There are several reasons:
> 
> 1. The implementation of use-defined OOM policy, such as iteration, sorting
> and other complex operations, is more suitable to be placed in the userspace
> rather than in the bpf program. It is more convenient to implement these
> operations in userspace in which the useful information (memory usage of
> each task and memcg, memory allocation speed, etc.) can also be captured.
> For example, oomd implements multiple policies[1] without kernel-space
> input.

I do agree that userspace can handle a lot on its own and provide the
input to the BPF program to make a decision.

> 2. Userspace apps, such as oomd, can import useful information into bpf
> program, e.g., through bpf_map, and update it periodically. For example, we
> can do the scoring directly in userspace and maintain a score hash, so that
> in the bpf program, we only need to look for the corresponding score of the
> process.

Sure, why not. But all that is an implementation detail. We are
currently talkin about a proper abstraction and layering that would
allow what you do currently but also much more.

> Userspace policy（oomd）
>          bpf_map_update
>          score_hash
>       ------------------>  BPF program
>                               look up score in
>                                score_hash
>                             ---------------> kernel space
> Just some thoughts.

I believe all the above should be possible if BPF program is hooked at
the oom_evaluate_task layer and allow to bypass the default logic. BPF
program can process whatever data it has available. The oom scope iteration
will be implemented already in the kernel so all the BPF program has to
do is to rank processes and/or memcgs if oom.group is enabled. Whould
that work for your usecase?

> Thanks!
> 
> [1]https://github.com/facebookincubator/oomd/tree/main/src/oomd/plugins)

-- 
Michal Hocko
SUSE Labs

