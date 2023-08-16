Return-Path: <bpf+bounces-7931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98777E986
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 21:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B282818E4
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A517733;
	Wed, 16 Aug 2023 19:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F8F9F7
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:20:36 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643B270D;
	Wed, 16 Aug 2023 12:20:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso4292618a12.0;
        Wed, 16 Aug 2023 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692213635; x=1692818435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8KexCVPN58oQfCMNw6Q77uo6Q5lWvRmRjYDYyBoPEU=;
        b=TbgGV6W+n5Cl2TBu50xpf/gq4v1qLtSv1skCnXG/Ez2El0jaVyMCUmbPIW4ctaGsHK
         PXg6n80jCJyEVj3uN+ZVgBBxjdH3bTSK4b2tjBdbKvvU1DSveJ60mrJlxJekJ+W41SvI
         bxDTJQ3zDe3xfskDnL+6I1jr2Z6yffTXE5VQ7HRPAy94Dqje30C5ZF0ky+X6CZom6pnX
         Cg5xyxah78qxN7POHQuEQRrVZvTnn7TfAwZfucMjhODDfuyfwvaowPmI//XilyALbg8x
         Ekmt7G2zfTUSt9mGba+P/AjXt55CY41ZKpdtDRsmTUGBoBn56kufK8ppwNhZUsjQdxf4
         MChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213635; x=1692818435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8KexCVPN58oQfCMNw6Q77uo6Q5lWvRmRjYDYyBoPEU=;
        b=XoatsicUxz1cYrTvCLKOeBKyce6l+onllyqnPGhZJ+msSk9BuupVVURgAJCG1/tLQO
         7rw1Cx+W3P0Pnn4IHfcRpiWWPjqxoImoBXjXbrwu/Uvmv5+2q0FqgDJCVysoExnR9Ifk
         +y9QzmyJDaFLBOEbTV7PUGjOSWZ0w16ZhbmswHmYeiqeWZ4Pu1MX31Cm1eRd9X1ezp/0
         VC38ir5fHuBCCMGC7bDfZ1MIgnk9aCo+Z0+0y2jrNsH+I49WCA+nNY919AR73dR9v+OB
         pNd9dLM1kG8xQOJ7N5kj8BQLHk4wMEz2VV2KATaGU0TC4Vo++CaPyN0TDZECe/grVBzH
         FXmQ==
X-Gm-Message-State: AOJu0YzQlmWDRnXl8NCHqiFN6O3saDnr0SmwHzSdiAway6/G8/7R+53R
	1DzFiq+s+mPYJ7ujhvEdvwA=
X-Google-Smtp-Source: AGHT+IEML5RCzWxUXjFy4wo2ClKMUOuaMXg1QLrP0lyCB0iK9aIt7g8uyWHUU5SQoe3qy4tBa9ilNA==
X-Received: by 2002:a17:90b:50b:b0:268:2127:6cb6 with SMTP id r11-20020a17090b050b00b0026821276cb6mr2188704pjz.16.1692213635033;
        Wed, 16 Aug 2023 12:20:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090ae39300b002682523653asm85605pjz.49.2023.08.16.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:20:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 16 Aug 2023 09:20:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH 12/34] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZN0hgFJcnJiyKJjJ@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-13-tj@kernel.org>
 <ZNy256C0DqfpSMz5@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNy256C0DqfpSMz5@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Vishal.

On Wed, Aug 16, 2023 at 05:15:43PM +0530, Vishal Chourasia wrote:
> > +static inline bool task_on_scx(struct task_struct *p)
> > +{
> > +	return scx_enabled() && p->sched_class == &ext_sched_class;
> > +}
> While building the kernel, I encountered the following warning:
> 
> {KERNEL_SRC}/kernel/sched/core.c: In function ‘__task_prio’:
> {KERNEL_SRC}/kernel/sched/core.c:170:25: warning: passing argument 1 of ‘task_on_scx’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   170 |         if (task_on_scx(p))
>       |                         ^
> In file included from {KERNEL_SRC}/kernel/sched/sched.h:3593,
>                  from {KERNEL_SRC}/kernel/sched/core.c:86:
> {KERNEL_SRC}/kernel/sched/ext.h:124:52: note: expected ‘struct task_struct *’ but argument is of type ‘const struct task_struct *’
>   124 | static inline bool task_on_scx(struct task_struct *p)
>       |                                ~~~~~~~~~~~~~~~~~~~~^
> 
> To address this warning, I'd suggest modifying the signature of `task_on_scx` to
> accept `task_struct` argument as `const`. The proposed change is as follows: 
> 
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
> index 405037a4e6ce..e9c699a87770 100644
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -121,7 +121,7 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
>  
>  DECLARE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
>  
> -static inline bool task_on_scx(struct task_struct *p)
> +static inline bool task_on_scx(const struct task_struct *p)
>  {
>         return scx_enabled() && p->sched_class == &ext_sched_class;
>  }
> @@ -214,7 +214,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
>  #define scx_enabled()          false
>  #define scx_switched_all()     false
>  
> -static inline bool task_on_scx(struct task_struct *p) { return false; }
> +static inline bool task_on_scx(const struct task_struct *p) { return false; }
>  static inline void scx_pre_fork(struct task_struct *p) {}
>  static inline int scx_fork(struct task_struct *p) { return 0; }
>  static inline void scx_post_fork(struct task_struct *p) {}

Yeah, this is already fixed in the github repo by the following commit:

 https://github.com/sched-ext/sched_ext/commit/56b278fa8b5136457993f7389e34070d35f17e8a

The fix will be included in the next iteration.

Thanks.

-- 
tejun

