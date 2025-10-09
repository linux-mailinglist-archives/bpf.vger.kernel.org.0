Return-Path: <bpf+bounces-70705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE26BCB2C1
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F531A64661
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CD28726C;
	Thu,  9 Oct 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="I5e5Dwav"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0672625;
	Thu,  9 Oct 2025 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051453; cv=none; b=Ecftg13/RihZNCLss8Xr8ZSLWdPdxMWESjPgYU4SqtjlmuzDIkkmVyxoSCkXK6ZBfwgv60RF1/3X4w7kSYGPnm5gSwf+RRegO+8H4qmkck5wt1wWjfrSuN9cpAHVREGJzXjpUoQ60ps0Bs0fMrRH+RbPvxPAFuEwlx8JYdSH6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051453; c=relaxed/simple;
	bh=gc+ybdM0De26nX9Mj01KN/4BBkYCJycNHLqy84LCxKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkWDiyMfcxmVdc2UsOchMOjNwciV5n5gjRh4LFCJActjjfFwQXs/RVYuG1dcUJ2b7qZYWFCsFtQkFxkX1vG5bXThIqJShD8oaw4DlD7ABL1hWPDlR6S/WlNqmuFx3o/oucyOViATMHIYDqlnABIX+lEhQj97AIdMa32QCDoJyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=I5e5Dwav; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cjQbC0Ykqz9stc;
	Fri, 10 Oct 2025 01:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760051447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q89Qb4CiPE+6iZAL95P/KB/dEbD21pJ2NlegHW1IAQc=;
	b=I5e5Dwav3kX25PyOPJX0HDfGU8Ba8tPb4uMnTWx8nDlaNAwTxF110mqkTyozC88mH/38Mq
	j8nOQWjnGFAu5uQw879vrWN5MXhjVZrjuFde4+UqVcBlCmXq2sQDGsoEo3iVx5JDBNGpCW
	vei4Kn/isH/owkpdhxSRi9j98Jjvzww27jvdJybZFIlFmyGdVcpMOCYKlijiqhS4gHeATu
	ySELtyg0Yj4XMUYbB932+3LLqEcGVnwmLTzYSBidaAkpLT2Au3rdaPjaPCk7ZuKeEf7P6f
	X1vpMBHwKT6VtTjo0EI7sPEcICJ+YlAfvdWdLM64veO2tqZKHPxRCACxzcr2xw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Fri, 10 Oct 2025 04:40:40 +0530
From: Brahmajit Das <listout@listout.xyz>
To: d0fdced7-a9a5-473e-991f-4f5e4c13f616@linux.dev
Cc: yonghong.song@linux.dev, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, chandna.linuxkernel@gmail.com, daniel@iogearbox.net, 
	david.hunter.linux@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	khalid@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, song@kernel.org, 
	syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: test_run: Fix timer mode initialization to
 NO_MIGRATE mode
Message-ID: <z5vpeaow6kyr4uamfqlev7yxbfpr333ngws6tgjnuyjqaznfcr@vn4ihodpiwhz>
References: <lm4q7sgtfqabpuzkr73fz7xx7jinhwpwtdnhafoknngqvpduyn@srhrp6cnmnza>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lm4q7sgtfqabpuzkr73fz7xx7jinhwpwtdnhafoknngqvpduyn@srhrp6cnmnza>
X-Rspamd-Queue-Id: 4cjQbC0Ykqz9stc

On 10.10.2025 04:20, Brahmajit Das wrote:
> Yonghong Song,
> 
> > So I suspect that we can remove NO_PREEMPT/NO_MIGRATE in test_run.c
> > and use migrate_disable()/migrate_enable() universally.
> Would something like this work?
> 

Or we can do something like this to completely remove
NO_PREEMPT/NO_MIGRATE.

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -29,7 +29,6 @@
 #include <trace/events/bpf_test_run.h>

 struct bpf_test_timer {
-       enum { NO_PREEMPT, NO_MIGRATE } mode;
        u32 i;
        u64 time_start, time_spent;
 };
@@ -38,10 +37,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
        __acquires(rcu)
 {
        rcu_read_lock();
-       if (t->mode == NO_PREEMPT)
-               preempt_disable();
-       else
-               migrate_disable();
+       migrate_disable();

        t->time_start = ktime_get_ns();
 }
@@ -51,10 +47,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
        t->time_start = 0;

-       if (t->mode == NO_PREEMPT)
-               preempt_enable();
-       else
-               migrate_enable();
+       migrate_enable();
        rcu_read_unlock();
 }

@@ -374,7 +367,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,

 {
        struct xdp_test_data xdp = { .batch_size = batch_size };
-       struct bpf_test_timer t = { .mode = NO_MIGRATE };
+       struct bpf_test_timer t = {};
        int ret;

        if (!repeat)
@@ -404,7 +397,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
        struct bpf_prog_array_item item = {.prog = prog};
        struct bpf_run_ctx *old_ctx;
        struct bpf_cg_run_ctx run_ctx;
-       struct bpf_test_timer t = { NO_MIGRATE };
+       struct bpf_test_timer t = {};
        enum bpf_cgroup_storage_type stype;
        int ret;

@@ -1377,7 +1370,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
                                     const union bpf_attr *kattr,
                                     union bpf_attr __user *uattr)
 {
-       struct bpf_test_timer t = { NO_PREEMPT };
+       struct bpf_test_timer t = {};
        u32 size = kattr->test.data_size_in;
        struct bpf_flow_dissector ctx = {};
        u32 repeat = kattr->test.repeat;
@@ -1445,7 +1438,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
                                union bpf_attr __user *uattr)
 {
-       struct bpf_test_timer t = { NO_PREEMPT };
+       struct bpf_test_timer t = {};
        struct bpf_prog_array *progs = NULL;
        struct bpf_sk_lookup_kern ctx = {};
        u32 repeat = kattr->test.repeat;

Basically RFC. I posted a patch, wasn't aware that work was already
going on.

-- 
Regards,
listout

