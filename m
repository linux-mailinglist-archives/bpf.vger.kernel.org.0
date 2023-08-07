Return-Path: <bpf+bounces-7140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E439D771C4F
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 10:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945F32811AC
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587D3D60;
	Mon,  7 Aug 2023 08:32:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C11C02
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 08:32:43 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50310EF;
	Mon,  7 Aug 2023 01:32:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D20FE1F460;
	Mon,  7 Aug 2023 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1691397154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd2eLu+erpKCPhHl0+124JewGiKtnvlRkZl3nQG/tkE=;
	b=Xl1XAWrspSkLFEX4h9Tocw59Elpej8M+0FJtFS37PGq07bLbBmVdP+q28qKXRa6S3nEUcC
	tbhr23XiP+glovP7zBms4LAmrlIII0JWnuxZSmwTdG4f7Q9AfkxsFA0ZFeWxyUhyVKiZWR
	4yBryiLNn3gPvD78LHfUqO/BheI7D0o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B330113487;
	Mon,  7 Aug 2023 08:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3ArUKCKs0GSVBgAAMHmgww
	(envelope-from <mhocko@suse.com>); Mon, 07 Aug 2023 08:32:34 +0000
Date: Mon, 7 Aug 2023 10:32:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, muchun.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNCsIm+RK0LStUA6@dhcp22.suse.cz>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <1719817f-6ae9-8f0b-5075-657cb4e80e20@oracle.com>
 <fa736940-2840-efa7-11e5-493465788545@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa736940-2840-efa7-11e5-493465788545@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat 05-08-23 07:55:56, Chuyi Zhou wrote:
> Hello,
> 
> 在 2023/8/4 19:34, Alan Maguire 写道:
[...]
> > I don't know anything about OOM mechanisms, so maybe it's just me, but I
> > found this confusing. Relying on the previous iteration to control
> > current iteration behaviour seems risky - even if BPF found a victim in
> > iteration N, it's no guarantee it will in iteration N+1.
> > 
> The current kernel's OOM actually works like this:
> 
> 1. if we first find a valid candidate victim A in iteration N, we would
> record it in oc->chosen.
> 
> 2. In iteration N + 1, N+2..., we just compare oc->chosen with the current
> iterating task. Suppose we think current task B is better than
> oc->chosen(A), we would set oc->chosen = B and we would not consider A
> anymore.
> 
> IIUC, most policy works like this. We just need to find the *most* suitable
> victim. Normally, if in current iteration we drop A and select B, we would
> not consider A anymore.

Yes, we iterate over all tasks in the specific oom domain (all tasks for
global and all members of memcg tree for hard limit oom). The in-tree
oom policy has to iterate all tasks to achieve some of its goals (like
preventing overkilling while the previously selected victim is still on
the way out). Also oom_score_adj might change the final decision so you
have to really check all eligible tasks.

I can imagine a BPF based policy could be less constrained and as Roman
suggested have a pre-selected victims on stand by. I do not see problem
to have break like mode. Similar to current abort without a canceling an
already noted victim.
-- 
Michal Hocko
SUSE Labs

