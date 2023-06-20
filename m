Return-Path: <bpf+bounces-2947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848B7372A1
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D502813AB
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6B2AB47;
	Tue, 20 Jun 2023 17:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A3A955
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBEC433C8;
	Tue, 20 Jun 2023 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687281674;
	bh=vRBGBNUYYQ+cKeZDIJdCYfN3me99s3tDJZBUVKipd1k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QG1WsOA0E+yR1VvMJBq+dY6Ufw+DTIOnRNxIWn9EEbToRgmWLQzLDnBPA6/lhP8jp
	 cxS4ojHMymNV6xKlJq+wMnrTVgWwL7grqILf/2VWZMCT0Cy5SogAv1Wd/yL0ifqO02
	 MD/kp7mhBYYl0jlVWLCvTwDt8fMrnorIK1QrPVuf95mi7GPNZviAM+iCSnD+DEp5yp
	 qmhQST5b9Rue9FTQsPvMbvxNpupJ4kGQMCCNwtclwEOFEZyZVFLZ1m6DQBx9tSiSMo
	 3kSdIGcCPA9xRJ9xoL6HW/8HeJK1fOSyx7i+e5BFu9nAlEqpr9SAEFr5cN4si+D3O4
	 jDg/wnuAjxhXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87BB7CE39F5; Tue, 20 Jun 2023 10:21:13 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:21:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next v5 2/2] bpf: Call
 rcu_momentary_dyntick_idle() in task work periodically
Message-ID: <34c9a132-d34b-46d7-9790-3b6d8eb4204d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230619143231.222536-1-houtao@huaweicloud.com>
 <20230619143231.222536-3-houtao@huaweicloud.com>
 <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>

On Tue, Jun 20, 2023 at 09:15:03AM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 19, 2023 at 7:00 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > +static void bpf_rcu_gp_acc_work(struct callback_head *head)
> > +{
> > +       struct bpf_rcu_gp_acc_ctx *ctx = container_of(head, struct bpf_rcu_gp_acc_ctx, work);
> > +
> > +       local_irq_disable();
> > +       rcu_momentary_dyntick_idle();
> > +       local_irq_enable();
> 
> We discussed this with Paul off-line and decided to go a different route.
> Paul prepared a patch for us to expose rcu_request_urgent_qs_task().
> I'll be sending the series later this week.

Just for completeness, this patch is in -rcu here and as shown below:

b1edaa1e6364 ("rcu: Export rcu_request_urgent_qs_task()")

							Thanx, Paul

------------------------------------------------------------------------

commit b1edaa1e6364caf9833a30b5dd7599080b6806b8
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jun 8 16:31:49 2023 -0700

    rcu: Export rcu_request_urgent_qs_task()
    
    If a CPU is executing a long series of non-sleeping system calls,
    RCU grace periods can be delayed for on the order of a couple hundred
    milliseconds.  This is normally not a problem, but if each system call
    does a call_rcu(), those callbacks can stack up.  RCU will eventually
    notice this callback storm, but use of rcu_request_urgent_qs_task()
    allows the code invoking call_rcu() to give RCU a heads up.
    
    This function is not for general use, not yet, anyway.
    
    Reported-by: Alexei Starovoitov <ast@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7f17acf29dda..7b949292908a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -138,6 +138,8 @@ static inline int rcu_needs_cpu(void)
 	return 0;
 }
 
+static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
+
 /*
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 56bccb5a8fde..126f6b418f6a 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -21,6 +21,7 @@ void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
+void rcu_request_urgent_qs_task(struct task_struct *t);
 
 /*
  * Note a virtualization-based context switch.  This is simply a
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9829d8161b21..0c99ec19c8e0 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -493,7 +493,6 @@ static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
-static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
@@ -514,7 +513,6 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
-void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #define RCU_SCHEDULER_INACTIVE	0

