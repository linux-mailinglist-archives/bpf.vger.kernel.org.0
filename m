Return-Path: <bpf+bounces-8230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1A783E05
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1831C20AF1
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0679E2;
	Tue, 22 Aug 2023 10:39:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D563D2
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:39:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B4DD1;
	Tue, 22 Aug 2023 03:39:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 371E922C3F;
	Tue, 22 Aug 2023 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1692700771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt++ZjKipaLLHCbfSdt/MhajtxRUnICXT5NdYQFemG0=;
	b=DE9nQ6lSRdSE5X687K+61K+0pjZDj3wSDrJj813BGIF4kTvF0vbieC5fhxkyEQPVVNzH+6
	sDwt9fWTT9CtZtJgVDGawM4C6LaX64ach0OQHluW+YdXf34k5ViA6KIR3bszDKodxcUD6W
	KnL/vAcUeceqlwdwtiqFBFbDRrL4cXk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17A60132B9;
	Tue, 22 Aug 2023 10:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0jFIA2OQ5GTOKgAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 22 Aug 2023 10:39:31 +0000
Date: Tue, 22 Aug 2023 12:39:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, muchun.song@linux.dev,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
Message-ID: <ZOSQYrFb2xleB83o@dhcp22.suse.cz>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
	T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 16-08-23 19:07:10, Alexei Starovoitov wrote:
> On Thu, Aug 10, 2023 at 1:13 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
> >  static int oom_evaluate_task(struct task_struct *task, void *arg)
> >  {
> >         struct oom_control *oc = arg;
> > @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
> >         if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
> >                 goto next;
> >
> > +       /*
> > +        * If task is allocating a lot of memory and has been marked to be
> > +        * killed first if it triggers an oom, then select it.
> > +        */
> > +       if (oom_task_origin(task)) {
> > +               points = LONG_MAX;
> > +               goto select;
> > +       }
> > +
> > +       switch (bpf_oom_evaluate_task(task, oc)) {
> > +       case BPF_EVAL_ABORT:
> > +               goto abort; /* abort search process */
> > +       case BPF_EVAL_NEXT:
> > +               goto next; /* ignore the task */
> > +       case BPF_EVAL_SELECT:
> > +               goto select; /* select the task */
> > +       default:
> > +               break; /* No BPF policy */
> > +       }
> > +
> 
> I think forcing bpf prog to look at every task is going to be limiting
> long term.
> It's more flexible to invoke bpf prog from out_of_memory()
> and if it doesn't choose a task then fallback to select_bad_process().
> I believe that's what Roman was proposing.
> bpf can choose to iterate memcg or it might have some side knowledge
> that there are processes that can be set as oc->chosen right away,
> so it can skip the iteration.

This is certainly possible but I am worried this will lead to a lot of
duplication. There are common tasks that all/most oom victim selection
implementations should do. First of all they should make sure that the
victim is belonging to the oom domain. Arguably it should be also aware
of ongoing oom victim tear down to prevent from overkilling. Proper oom
victim reference counting handling. Most people are not even aware of
those things. Do we really want all those to be re-invented - most
likely incorrectly?

Advantage of reusing oom_evaluate_task is that all that can be avoided.
Iterating over tasks with a pre-defined oom-victim sure sounds like
unnecessary and wasted CPU cycles but if you want to prevent
over-killing this is still necessary. As the oom killer can be invoked
really rapidly (before the victim has a chance to die) I believe this is
a very useful feature.
-- 
Michal Hocko
SUSE Labs

