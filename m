Return-Path: <bpf+bounces-6988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8B76FF7B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA271C20A8B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388CBA28;
	Fri,  4 Aug 2023 11:29:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4BA959
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 11:29:22 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69711B;
	Fri,  4 Aug 2023 04:29:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BAFD1F8AF;
	Fri,  4 Aug 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1691148557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWX8UAE3vE+ECHESJ7u2irG1vRHlk+PFNMojuMOOzsU=;
	b=Yi1KQ6Y6gjCUg17Re2YSDtjdjGq8O6Uw+IWTvdXzRT9SToLnRJl81QhBp9t8Hfuvy/V0EP
	pWuDnUkcCIr0qRKh7wqscRObmm7NfR5fM/PeDHmDD8Jj2V+a2HDs+GFQGaAN2EvbiZ/BwE
	xsClVxAsEAt5HYkQjUDARP66k3B87Kk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 024B2133B5;
	Fri,  4 Aug 2023 11:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Jh09OQzhzGQ3VAAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 04 Aug 2023 11:29:16 +0000
Date: Fri, 4 Aug 2023 13:29:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804093804.47039-2-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
	T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri 04-08-23 17:38:03, Chuyi Zhou wrote:
> This patch adds a new hook bpf_select_task in oom_evaluate_task. It
> takes oc and current iterating task as parameters and returns a result
> indicating which one is selected by bpf program.
> 
> Although bpf_select_task is used to bypass the default method, there are
> some existing rules should be obeyed. Specifically, we skip these
> "unkillable" tasks(e.g., kthread, MMF_OOM_SKIP, in_vfork()).So we do not
> consider tasks with lowest score returned by oom_badness except it was
> caused by OOM_SCORE_ADJ_MIN.

Is this really necessary? I do get why we need to preserve
OOM_SCORE_ADJ_* semantic for in-kernel oom selection logic but why
should an arbitrary oom policy care. Look at it from an arbitrary user
space based policy. It just picks a task or memcg and kills taks by
sending SIG_KILL (or maybe SIG_TERM first) signal. oom_score constrains
will not prevent anybody from doing that.

tsk_is_oom_victim (and MMF_OOM_SKIP) is a slightly different case but
not too much. The primary motivation is to prevent new oom victims
while there is one already being killed. This is a reasonable heuristic
especially with the async oom reclaim (oom_reaper). It also reduces
amount of oom emergency memory reserves to some degree but since those
are not absolute this is no longer the primary motivation. _But_ I can
imagine that some policies might be much more aggresive and allow to
select new victims if preexisting are not being killed in time.

oom_unkillable_task is a general sanity check so it should remain in
place.

I am not really sure about oom_task_origin. That is just a very weird
case and I guess it wouldn't hurt to keep it in generic path.

All that being said I think we want something like the following (very
pseudo-code). I have no idea what is the proper way how to define BPF
hooks though so a help from BPF maintainers would be more then handy
---
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 00982b133dc1..9f1743ee2b28 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -190,10 +190,6 @@ static inline bool trigger_all_cpu_backtrace(void)
 {
 	return false;
 }
-static inline bool trigger_allbutself_cpu_backtrace(void)
-{
-	return false;
-}
 static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
 	return false;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 612b5597d3af..c9e04be52700 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -317,6 +317,22 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
 		goto next;
 
+	/*
+	 * If task is allocating a lot of memory and has been marked to be
+	 * killed first if it triggers an oom, then select it.
+	 */
+	if (oom_task_origin(task)) {
+		points = LONG_MAX;
+		goto select;
+	}
+
+	switch (bpf_oom_evaluate_task(task, oc, &points)) {
+		case -EOPNOTSUPP: break; /* No BPF policy */
+		case -EBUSY: goto abort; /* abort search process */
+		case 0: goto next; /* ignore process */
+		default: goto select; /* note the task */
+	}
+
 	/*
 	 * This task already has access to memory reserves and is being killed.
 	 * Don't allow any other task to have access to the reserves unless
@@ -329,15 +345,6 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto abort;
 	}
 
-	/*
-	 * If task is allocating a lot of memory and has been marked to be
-	 * killed first if it triggers an oom, then select it.
-	 */
-	if (oom_task_origin(task)) {
-		points = LONG_MAX;
-		goto select;
-	}
-
 	points = oom_badness(task, oc->totalpages);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
-- 
Michal Hocko
SUSE Labs

