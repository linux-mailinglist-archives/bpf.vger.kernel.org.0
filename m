Return-Path: <bpf+bounces-6767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FE76DB41
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 01:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE3281EA0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38508154B8;
	Wed,  2 Aug 2023 23:07:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A0DF62
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 23:07:22 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F31727
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 16:07:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so3042975ad.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691017639; x=1691622439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XfALNwV/tfaSv7m6CeLFz7+Ffzzh4b0BiysQ0BR0LI=;
        b=HX0PnhQhu5wj5T9hUT8RYl45tsjKnkGZwG3CC76n7DmOQPZFmdEytv1AN1/SWS0ml8
         4hJXbJXB2WcpivzFNJdiu4r0ZSlcljau/cZ46mhYveuY7w5aPQ00sruzGBBBtyaDFC0/
         +WdiwiNjYPGkjPKqrv6h/02zvtN7GSwvgUS65l9+lkI7fVYeVPU1dqrVN9q5bUiZ/ftx
         Ks3BqLr54BKj6b2rUfOcYnbgxcpgiR41o/3F6LfD7vegPuTyoV5/Aak2yuzgjSyX/7/x
         FOKLsEEp/ViMz9wlNiDmabQefX/p2MlhVr1dVWK1b80OUv39Rcpu4d716E8RZm7XjtlQ
         2GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017639; x=1691622439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XfALNwV/tfaSv7m6CeLFz7+Ffzzh4b0BiysQ0BR0LI=;
        b=HJd6BjmrngQy39hXbKTD487fuaBdxbIMqkc8IuNIp3VB0dzPo9XTPh5nYarfOpZ+rk
         yncWoMytoLIEpKdwVGqytIS/OrWxqBxqTIe4bCZqSqXDlpMH0UFLGu0dkxr/0uMueaw9
         OhthOJvM85d/WHi5vGmEm0OMFLA5aoMpQNSi0u1IlFxEo+cIY+9dHK0QRty7judGhdJP
         HF0igtsEBDupkBUEL+ywd0alV7NXOy2YJaYrtriLPK4GM2Zp86X+fjKdNqaRho5b8fYJ
         Dh/QJuupuQWh0Wy+puSWWRltZ+bD12lD6P5Cl17SVZXeA7dCI7LWdZXdNzCo9Cdu9g0+
         vBiA==
X-Gm-Message-State: ABy/qLajSxqQcIaO2p4vl7cEavVyfc1ZRTk6VzkDWDFPOjjZ0HJ4kdEM
	0N+x0yvkvzea/gWD4bQREvA=
X-Google-Smtp-Source: APBJJlFe/68SDbbLQxS7wLXryXv/Uk2cNGoMUYtvFuRHDBuCqKUpgEzcbnU99Rggeq9px8KjuoeX9g==
X-Received: by 2002:a17:902:eccf:b0:1b6:7f96:42ca with SMTP id a15-20020a170902eccf00b001b67f9642camr17373299plh.66.1691017638850;
        Wed, 02 Aug 2023 16:07:18 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:35d3])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709028bcb00b001b7cbc5871csm12876739plo.53.2023.08.02.16.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:07:18 -0700 (PDT)
Date: Wed, 2 Aug 2023 16:07:15 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 7/7] selftests/bpf: Add tests for rbtree API
 interaction in sleepable progs
Message-ID: <20230802230715.3ltalexaczbomvbu@MacBook-Pro-8.local>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-8-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801203630.3581291-8-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 01:36:30PM -0700, Dave Marchevsky wrote:
> +SEC("?fentry.s/bpf_testmod_test_read")
> +__failure __msg("sleepable progs may only spin_{lock,unlock} in RCU CS")
> +int BPF_PROG(rbtree_fail_sleepable_lock_no_rcu,
> +	     struct file *file, struct kobject *kobj,
> +	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
> +{
> +	struct node_acquire *n;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return 0;
> +
> +	/* no bpf_rcu_read_{lock,unlock} */
> +	bpf_spin_lock(&glock);
> +	bpf_rbtree_add(&groot, &n->node, less);
> +	bpf_spin_unlock(&glock);

Continuing the discussion in the other patch...
I don't see anything wrong with above.
bpf_spin_lock will disable preemption and will call rbtree_add.
Everything looks safe.

RCU/Design/Requirements/Requirements.rst
"
In addition, anything that disables
preemption also marks an RCU-sched read-side critical section,
including preempt_disable() and preempt_enable(), local_irq_save()
and local_irq_restore(), and so on.
"
In practice it's always better to enforce explicit bpf_rcu_read_lock/unlock,
but seems overkill in this case. Sleepable prog holding spin_lock will
not cause a UAF for non-owned references with refcnt == 0.

