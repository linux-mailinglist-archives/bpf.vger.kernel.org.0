Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9248A6EACF8
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjDUOb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjDUOb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 10:31:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD514695;
        Fri, 21 Apr 2023 07:31:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a66e7a52d3so18841735ad.0;
        Fri, 21 Apr 2023 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682087486; x=1684679486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKhBu8sG6Yo56k0RSsJ8wWqsAKsW1s8Uamb5SWZYgmk=;
        b=n3ftHlJTpDJTkhfmUdCx6lBZTh4cfghTRGbTz3FvC4THayyOQtgN77Abu9ocarHQgr
         8nFhZuVDAb2VCja7jEil9DfV3soQQHx42HhgvhLV7AzRJvfv3KepPonCF0oergHy5x3I
         Fw4buBJcMGJYJ6stwT0NRdlkt022MQK52ST0n+kOsFD7W2ql3m1a0+CjfJhhdDtXhTQE
         bqKPWgh80N1ZAbqlVQUfNYl6sbvah77a5gQ/8BB6jLQhV3Acjhs2d2m704esGj2SK1Tb
         woSvx4G+raElIdfKeYFOO9AOn4ocPOyPmCnhAfQkrqR2iA86UW3A+NgQa4vAESxzRtzQ
         8Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087486; x=1684679486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKhBu8sG6Yo56k0RSsJ8wWqsAKsW1s8Uamb5SWZYgmk=;
        b=NYDpIcUIpCPJ44lNOLzD+q2ps7NgbSirbZ7XF2wp1ic4ngKul+f4rQJavA8I6fnCdq
         Kza7DVldZmMtIbceWq5vTIvdLvUWVsSpFZ53M8O+W7KS6aqTUp7OdJ7wT8PI5+0Gp/Nx
         mQyDmVo23PrIILyiPB/gtxfqRX0CquSkjHosMqdkJQG1CIHIZAh829cTSEhquWpSzQYU
         UCQe8P7Io8az7zoVUJoETep5wk2/7mi5jyVHx/L3fPl6itn1WtZ8Q7BDFVTg6SwEftom
         rq69licFU7J2NuQiEQRAFjLUs/+7GnnjLQTHe4LiE4VQ9zy8G4HIcv5tjp9ZVXLjedL/
         2c8Q==
X-Gm-Message-State: AAQBX9cED/ja+qBlkbrQH7yjv75JAhFtQ2bPKCT2PBk0+gVzjO07tG1U
        Dh+S+3d+zl31j6Rr7prAROI=
X-Google-Smtp-Source: AKy350bILZA+mnUYouk96Lb5R8bvZWVAEsO0G7f03O40kqNKn6GIzLpCW14jdGIP/mVBHuNfx/ZIOA==
X-Received: by 2002:a17:903:40cc:b0:1a0:6bd4:ea78 with SMTP id t12-20020a17090340cc00b001a06bd4ea78mr5285204pld.31.1682087485496;
        Fri, 21 Apr 2023 07:31:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jh22-20020a170903329600b001a5262134d7sm2828397plb.202.2023.04.21.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:31:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Apr 2023 04:31:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 28/32] sched_ext: Implement core-sched support
Message-ID: <ZEKeO7CI_ESpZS2H@slm.duckdns.org>
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-29-tj@kernel.org>
 <ZEGY28sZgvEL7ssi@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGY28sZgvEL7ssi@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Andrea.

On Thu, Apr 20, 2023 at 09:56:11PM +0200, Andrea Righi wrote:
> On Fri, Mar 17, 2023 at 11:33:29AM -1000, Tejun Heo wrote:
> ...
> >  
> > +static int balance_scx(struct rq *rq, struct task_struct *prev,
> > +		       struct rq_flags *rf)
> > +{
> > +	int ret;
> > +
> > +	ret = balance_one(rq, prev, rf, true);
> > +
> > +	/*
> > +	 * When core-sched is enabled, this ops.balance() call will be followed
> > +	 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
> > +	 * on the SMT siblings. Balance the siblings too.
> > +	 */
> > +	if (sched_core_enabled(rq)) {
> > +		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
> 
> balance_scx() should be a no-op if CONFIG_SCHED_SMT is undefined or we
> may get a build error here.
> 
> For example with a minimal ppc64le config (and CONFIG_SCHED_SMT off) I
> can reproduce this:
> 
>  ./arch/powerpc/include/asm/smp.h:139:22: error: implicit declaration of function 'cpu_smt_mask'; did you mean 'cpu_cpu_mask'? [-Werror=implicit-function-declaration]
> 
> So maybe have something like this (or similar):
> 
> #ifdef CONFIG_SCHED_SMT
> ...
> #else
> static inline int balance_scx(struct rq *rq, struct task_struct *prev,
> 		       struct rq_flags *rf)
> {
> 	return 0
> }
> #endif

Will fix.

Thank you.

-- 
tejun
