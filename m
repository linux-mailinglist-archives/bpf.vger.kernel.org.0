Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A96C8537
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCXSgt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCXSgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 14:36:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23CAD;
        Fri, 24 Mar 2023 11:36:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pfmHH-0003Ph-GO; Fri, 24 Mar 2023 19:36:39 +0100
Date:   Fri, 24 Mar 2023 19:36:39 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 0/3] bpf: add netfilter program type
Message-ID: <20230324183639.GD1871@breakpoint.cc>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230323003638.pbzm6jino5qxjfvc@kashmir.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323003638.pbzm6jino5qxjfvc@kashmir.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> On Thu, Mar 02, 2023 at 06:27:54PM +0100, Florian Westphal wrote:
> > Add minimal support to hook bpf programs to netfilter hooks,
> > e.g. PREROUTING or FORWARD.
> > 
> > For this the most relevant parts for registering a netfilter
> > hook via the in-kernel api are exposed to userspace via bpf_link.
> > 
> > The new program type is 'tracing style' and assumes skb dynptrs are used
> > rather than 'direct packet access'.
> 
> [...]
> 
> Hope all is well. Do you have any updates on this series? I'm keen to
> start building on top of this work.

Sorry, I was busy with other work so this got sidelined.

I've pushed what I hav atm to
https://git.breakpoint.cc/cgit/fw/bpf-next.git/log/?h=nf_bpf_hooks_07

I had no time so far to do the testing needed for a new official
submission (e.g. bpf_link_info).

Compared to last uapi this now has a "flags" member that could be
used to indicate "need defrag" and so on.

I hope I can submit this again early April.
