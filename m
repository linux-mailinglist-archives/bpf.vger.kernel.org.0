Return-Path: <bpf+bounces-6094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D85765A1C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D73E2823EF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9665F2714F;
	Thu, 27 Jul 2023 17:23:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBE27128
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:23:17 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583C32D75;
	Thu, 27 Jul 2023 10:23:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1690321A9B;
	Thu, 27 Jul 2023 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690478594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aweaNlAF2TaomfSSOciU5EAZdZoJxELHiitSS0DAgMw=;
	b=Dn1fOqLECmDrHHOezd7C2fkG0mBY88pGxix+QJUWf9ts6RjqaDHqJam7JiZu3hiAFz21kh
	22+8WO3hcE4TBI9bkzviVRQZLNmDsSUVLgwYjwV33gH+2BzfmMb9SyplKZLW2ti77AXLku
	FKk5ziCBKckN5+uNyUDUL0gew6AeGaU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC4CE13902;
	Thu, 27 Jul 2023 17:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ccKiNgGowmQ3ZgAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 27 Jul 2023 17:23:13 +0000
Date: Thu, 27 Jul 2023 19:23:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu 27-07-23 20:12:01, Chuyi Zhou wrote:
> 
> 
> 在 2023/7/27 16:15, Michal Hocko 写道:
> > On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> > > This patchset tries to add a new bpf prog type and use it to select
> > > a victim memcg when global OOM is invoked. The mainly motivation is
> > > the need to customizable OOM victim selection functionality so that
> > > we can protect more important app from OOM killer.
> > 
> > This is rather modest to give an idea how the whole thing is supposed to
> > work. I have looked through patches very quickly but there is no overall
> > design described anywhere either.
> > 
> > Please could you give us a high level design description and reasoning
> > why certain decisions have been made? e.g. why is this limited to the
> > global oom sitation, why is the BPF program forced to operate on memcgs
> > as entities etc...
> > Also it would be very helpful to call out limitations of the BPF
> > program, if there are any.
> > 
> > Thanks!
> 
> Hi,
> 
> Thanks for your advice.
> 
> The global/memcg OOM victim selection uses process as the base search
> granularity. However, we can see a need for cgroup level protection and
> there's been some discussion[1]. It seems reasonable to consider using memcg
> as a search granularity in victim selection algorithm.

Yes, it can be reasonable for some policies but making it central to the
design is very limiting.

> Besides, it seems pretty well fit for offloading policy decisions to a BPF
> program, since BPF is scalable and flexible. That's why the new BPF
> program operate on memcgs as entities.

I do not follow your line of argumentation here. The same could be
argued for processes or beans.

> The idea is to let user choose which leaf in the memcg tree should be
> selected as the victim. At the first layer, if we choose A, then it protects
> the memcg under the B, C, and D subtrees.
> 
>         root
>      /   ｜ \  \
>     A    B  C  D
>    /\
>   E F
> 
> 
> Using the BPF prog, we are allowed to compare the OOM priority between
> two siblings so that we can choose the best victim in each layer.

How is the priority defined and communicated to the userspace.

> For example:
> 
> run_prog(B, C) -> choose B
> run_prog(B, D) -> choose D
> run_prog(A, D) -> choose A
> 
> Once we select A as the victim in the first layer, the victim in next layer
> would be selected among A's children. Finally, we select a leaf memcg as
> victim.

This sounds like a very specific oom policy and that is fine. But the
interface shouldn't be bound to any concepts like priorities let alone
be bound to memcg based selection. Ideally the BPF program should get
the oom_control as an input and either get a hook to kill process or if
that is not possible then return an entity to kill (either process or
set of processes).

> In our scenarios, the impact caused by global OOM's is much more common, so
> we only considered global in this patchset. But it seems that the idea can
> also be applied to memcg OOM.

The global and memcg OOMs shouldn't have a different interface. If a
specific BPF program wants to implement a different policy for global
vs. memcg OOM then be it but this should be a decision of the said
program not an inherent limitation of the interface.

> 
> [1]https://lore.kernel.org/lkml/ZIgodGWoC%2FR07eak@dhcp22.suse.cz/
> 
> Thanks!
> -- 
> Chuyi Zhou

-- 
Michal Hocko
SUSE Labs

