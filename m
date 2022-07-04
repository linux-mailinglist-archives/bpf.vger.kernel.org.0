Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6BE5659DB
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiGDPa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiGDPa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 11:30:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670F2B2;
        Mon,  4 Jul 2022 08:30:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0169E2277B;
        Mon,  4 Jul 2022 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656948627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xk1ZJHt34COGC3XZeX8tbvvR/9JIJI9lBw/zzga5fSI=;
        b=f+AtvND0b4DcCf1ZJTPx9fh7p+06SMADxTw+PpX8t9fPp2q3CNp9yeELUPQxtbfQlpFHvN
        bYZofWkx9tcbzLG+z3RN0jQlWt8y8rAB89NjJBtn0VsDjWOi1AhLCTEdE/JCqBdqrgAdOn
        1HNrkuKTAEV67s2/juGSbWMGvc/B84c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D8302C142;
        Mon,  4 Jul 2022 15:30:26 +0000 (UTC)
Date:   Mon, 4 Jul 2022 17:30:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsMHkXJ0vAPG0lyM@dhcp22.suse.cz>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon 04-07-22 17:07:32, Michal Hocko wrote:
> On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > events are not raised.
> > > >
> > > > It's not/less of an issue in a generic case because consequent
> > > > allocations from a process context will trigger the reclaim and
> > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > memory cgroup, so it might never happen.
> > > 
> > > The patch looks good but the above sentence is confusing. What might
> > > never happen? Reclaim or MAX event on dying memcg?
> > 
> > Direct reclaim and MAX events. I agree it might be not clear without
> > looking into the code. How about something like this?
> > 
> > "It's not/less of an issue in a generic case because consequent
> > allocations from a process context will trigger the direct reclaim
> > and MEMCG_MAX events will be raised. However a bpf map can belong
> > to a dying/abandoned memory cgroup, so there will be no allocations
> > from a process context and no MEMCG_MAX events will be triggered."
> 
> Could you expand little bit more on the situation? Can those charges to
> offline memcg happen indefinetely? How can it ever go away then? Also is
> this something that we actually want to encourage?

One more question. Mostly out of curiosity. How is userspace actually
acting on those events? Are watchers still active on those dead memcgs?
-- 
Michal Hocko
SUSE Labs
