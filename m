Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03F6498D0
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 07:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLLGEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 01:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLLGED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 01:04:03 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9822B1C5;
        Sun, 11 Dec 2022 22:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U9YButPqEGGSX9xbkqlpyWTzGu0h8bPsQbZrD1r0BaM=;
  b=Mbr6OgAao4w4oaqXASWDbDH+E4WsYGmURaGXreEuSlOVI6NxobgmFLDm
   0fXBQKVgpcZlyjk/5TlnfCEWeHcbx/21CC2C98av6PaZHYoIR2JfLZ2qJ
   o0GSkREMmMot1eU/20xWi5LoV97JkMoAvqqdSiZFTYOqUanRIO42mWZ5Z
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,237,1665439200"; 
   d="scan'208";a="42358754"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 07:03:57 +0100
Date:   Mon, 12 Dec 2022 07:03:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tejun Heo <tj@kernel.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        torvalds@linux-foundation.org, mingo@redhat.com,
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
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler
 class
In-Reply-To: <Y5aO3y23uoQFCazr@slm.duckdns.org>
Message-ID: <alpine.DEB.2.22.394.2212120702560.2971@hadrien>
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-15-tj@kernel.org> <alpine.DEB.2.22.394.2212112331150.29296@hadrien> <Y5aO3y23uoQFCazr@slm.duckdns.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Sun, 11 Dec 2022, Tejun Heo wrote:

> Hello, Julia.
>
> On Sun, Dec 11, 2022 at 11:33:50PM +0100, Julia Lawall wrote:
> > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > new file mode 100644
> > > index 000000000000..f42464d66de4
> > > --- /dev/null
> > > +++ b/kernel/sched/ext.c
> > > @@ -0,0 +1,2780 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> > > + * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> > > + * Copyright (c) 2022 David Vernet <dvernet@meta.com>
> > > + */
> > > +#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> > > +
> > > +enum scx_internal_consts {
> > > +	SCX_NR_ONLINE_OPS	 = SCX_OP_IDX(init),
> > > +	SCX_DSP_DFL_MAX_BATCH	 = 32,
> >
> > This definition of SCX_DSP_DFL_MAX_BATCH makes the dispatch queue have size
> > 32.  The example central policy thus aborts if more than 32 tasks are woken
> > up at once.
>
> Yeah, scx_exampl_central needs to either set ops.dispatch_max_batch higher
> according to number of CPUs or flush and exit the loop and retry when
> scx_bpf_dispatch_nr_slots() reaches zero. Will update.

Since there could be any number of waking threads, maybe some kind of
flush and retry solution would be better?

julia

>
> Thanks.
>
> --
> tejun
>
