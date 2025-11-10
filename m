Return-Path: <bpf+bounces-74064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90DC46E1C
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 14:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740B21891B66
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB13101DC;
	Mon, 10 Nov 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CL/ziG+d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YuHyusdp"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734623C516
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781153; cv=none; b=TVC0YZMVEqEPoTDnUoic2vT8dfh9Yudgyd2KU/hC/r/9n6F1dv7+GCUpQ+tObqDj/bH9uwwpwpCarpRKiPS139l5NmTMSkcHr/4Q7xTQgRoxkM72z2hC9jbgLGf7hY7CtYGDOQXwGLuI/im4sY1E1hZV+RH0vwSLcSxZxqhdDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781153; c=relaxed/simple;
	bh=EeR12cpmuusHZgWY5C4HbNEoA5hSwHLr8ty5TKjmSVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN10glF/ABLYT5E99IgFfuObWxkG5ds1N9kIyswrE8q9qkNAYd+Z8BfuHxu3x+BFDwF1/ltCjM98ecvaIumN7DGX0tYjruBuM5CiA9WJXto0GBTOMTA5rH6mQC+zefnlg2tF8IwIa5MZiy59ZVdc2YRL35ILUopy9lXiVlbuQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CL/ziG+d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YuHyusdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 14:25:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762781149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvgdCM1ejcaF/+cp43uA2Axad0gMApJhoH/v8OPB9h8=;
	b=CL/ziG+dvLEwnN0v1l/kdboYXKORjIhhzX15LAUQ+gA/vDLWTXXLBkWeLixDskVUXh+QwE
	y+9rFqJrT+lJKsWusuiJw3Ni31Zo7fxFKBaqOd3vLWD8uo3+VUaVwZKB/XS9+MAdxzrhnn
	/4c3r0FokMTWladwwySwP7DySYgvTL/R3HTHibN3OXV1oSdTJVGcIQ4OQZShq0PYVL6+uS
	wb0sS8/ibVYBlalFjcf2ogcY2H8IfZoleVKB05e3gVMZf2PzTUjGEh8Z8LaGjUt2COgs4B
	4pkpss0rOaZqgtEBYBiZuMVemTQaQvSIA91dcpzSAQVtvbaw1XW2Vi7/NQvMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762781149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvgdCM1ejcaF/+cp43uA2Axad0gMApJhoH/v8OPB9h8=;
	b=YuHyusdpX9sD1fnshGSumuFBdqPLb47j1hUpkzESsIOyobsf44mc8oV/ooqFMN0WtdOjUN
	bhv9ia/+PbFnwfBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bot+bpf-ci@kernel.org, chandna.sahil@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Message-ID: <20251110132546.eE4o18h6@linutronix.de>
References: <20251109173648.401996-1-chandna.sahil@gmail.com>
 <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
 <2ed9877e-77e4-4f18-84fd-dc8b1ffe810f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ed9877e-77e4-4f18-84fd-dc8b1ffe810f@linux.dev>

On 2025-11-09 11:44:48 [-0800], Yonghong Song wrote:

Could we do this instead?
There is  __bpf_stream_push_str() => bpf_stream_page_reserve_elem() =>
bpf_stream_page_replace() => alloc_pages_nolock().

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c8..5a4965724c374 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1598,6 +1598,7 @@ struct task_struct {
 	void				*security;
 #endif
 #ifdef CONFIG_BPF_SYSCALL
+	s8				bpf_bprintf_idx;
 	/* Used by BPF task local storage */
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb25e70e0bdc0..62e37c845ec5a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -770,28 +770,39 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
 
-static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
-static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
+struct bpf_cpu_buffer {
+	struct bpf_bprintf_buffers bufs[MAX_BPRINTF_NEST_LEVEL];
+	local_lock_t	lock[MAX_BPRINTF_NEST_LEVEL];
+};
+
+static DEFINE_PER_CPU(struct bpf_cpu_buffer, bpf_cpu_bprintf) = {
+	.lock = { [0 ... MAX_BPRINTF_NEST_LEVEL - 1] = INIT_LOCAL_LOCK(bpf_cpu_bprintf.lock) },
+};
 
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
-	int nest_level;
+	s8 nest_level;
 
-	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
-	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
-		this_cpu_dec(bpf_bprintf_nest_level);
+	nest_level = current->bpf_bprintf_idx++;
+	if (WARN_ON_ONCE(nest_level >= MAX_BPRINTF_NEST_LEVEL)) {
+		current->bpf_bprintf_idx--;
 		return -EBUSY;
 	}
-	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
 
+	local_lock(&bpf_cpu_bprintf.lock[nest_level]);
+	*bufs = this_cpu_ptr(&bpf_cpu_bprintf.bufs[nest_level]);
 	return 0;
 }
 
 void bpf_put_buffers(void)
 {
-	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
+	s8 nest_level;
+
+	nest_level = current->bpf_bprintf_idx;
+	if (WARN_ON_ONCE(nest_level == 0))
 		return;
-	this_cpu_dec(bpf_bprintf_nest_level);
+	local_unlock(&bpf_cpu_bprintf.lock[nest_level - 1]);
+	current->bpf_bprintf_idx--;
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)

