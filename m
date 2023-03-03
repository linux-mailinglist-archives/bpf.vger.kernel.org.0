Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94F6A8DD7
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 01:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCCA14 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 19:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCA1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 19:27:55 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6158635BC;
        Thu,  2 Mar 2023 16:27:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pXtH6-0005M3-Sg; Fri, 03 Mar 2023 01:27:52 +0100
Date:   Fri, 3 Mar 2023 01:27:52 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
Message-ID: <20230303002752.GA4300@breakpoint.cc>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230302172757.9548-2-fw@strlen.de>
 <ZAEG1gtoXl125GlW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAEG1gtoXl125GlW@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> wrote:
> On 03/02, Florian Westphal wrote:
> > +			struct {
> > +				__u32		pf;
> > +				__u32		hooknum;
> > +				__s32		prio;
> > +			} netfilter;
> 
> For recent tc BPF program extensions, we've discussed that it might be
> better
> to have an option to attach program before/after another one in the chain.
> So the API essentially would receive a before/after flag + fd/id of the
>
> Should we do something similar here? See [0] for the original
> discussion.
> 
> 0: https://lore.kernel.org/bpf/YzzWDqAmN5DRTupQ@google.com/

Thanks for the pointer, I will have a look.

The above exposes the "prio" of netfilter hooks, so someone
that needs their hook to run early on, say, before netfilters
nat engine, could just use INT_MIN.

We could -- for nf bpf -- make the bpf_link fail if a hook
with the same priority already exists to avoid the "undefined
behaviour" here (same prio means register order decides what
hook function runs first ...).

This could be relevant if you have e.g. one bpf program collecting
statistics vs. one doing drops.

I'll dig though the thread and would try to mimic the tc link
mechanism as close as possible.
