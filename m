Return-Path: <bpf+bounces-5036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85A753F7F
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 18:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69AA282087
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8EC1548D;
	Fri, 14 Jul 2023 16:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCB13AFD;
	Fri, 14 Jul 2023 16:06:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070DB35A2;
	Fri, 14 Jul 2023 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l2PxSpRMDs4SDhTszSS5GoCIUOZljs7VX1ueKZbYOmU=; b=nIPCgtct2lEpor0sY99RsVyHra
	m4CFUD5DF0IhlZ6krb0KjAk1pEpuahk5r3jduzzggkHa0dui0YtHBgMYt7p5URHSpUDnbxOYgOqG0
	TssLhTFhs7nFTYE1UmVW10RaXrtUMoyYvPtyzqZ5AoF/izsWoxJNy1JJmiQxy0cpPCZMYifvL5qGs
	7eE5dPLru5QRJCkEeLpqaqMjzoR/zSVxr6J5voZWqIiEl3WSa7EdkT641VOeDo2AUNtBXPNfrbRew
	2KaQ7zsVIlYqVhIqDZzfhkfX14c+BecLH4R6x9GNR2bZSsEl9AqkDHrRq2zzB7LPD4FWguKkRbTqB
	KHUgdC7A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKLJ3-000MuY-Pw; Fri, 14 Jul 2023 18:06:09 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKLJ3-000U4C-5b; Fri, 14 Jul 2023 18:06:09 +0200
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-2-daniel@iogearbox.net>
 <20230711002320.bp4mlb4at45vkrqt@MacBook-Pro-8.local>
 <CAEf4BzYYE=ekrkcdM3JY=G1RvDZaUoj1qE2vBcrBfbr8OvmVvw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5f8d6a17-5755-06f7-b754-33238359883e@iogearbox.net>
Date: Fri, 14 Jul 2023 18:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYYE=ekrkcdM3JY=G1RvDZaUoj1qE2vBcrBfbr8OvmVvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26969/Fri Jul 14 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 8:51 PM, Andrii Nakryiko wrote:
> On Mon, Jul 10, 2023 at 5:23 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Jul 10, 2023 at 10:12:11PM +0200, Daniel Borkmann wrote:
>>> + *
>>> + *   struct bpf_mprog_entry *entry, *peer;
>>> + *   int ret;
>>> + *
>>> + *   // bpf_mprog user-side lock
>>> + *   // fetch active @entry from attach location
>>> + *   [...]
>>> + *   ret = bpf_mprog_attach(entry, [...]);
>>> + *   if (ret >= 0) {
>>> + *       peer = bpf_mprog_peer(entry);
>>> + *       if (bpf_mprog_swap_entries(ret))
>>> + *           // swap @entry to @peer at attach location
>>> + *       bpf_mprog_commit(entry);
>>> + *       ret = 0;
>>> + *   } else {
>>> + *       // error path, bail out, propagate @ret
>>> + *   }
>>> + *   // bpf_mprog user-side unlock
>>> + *
>>> + *  Detach case:
>>> + *
>>> + *   struct bpf_mprog_entry *entry, *peer;
>>> + *   bool release;
>>> + *   int ret;
>>> + *
>>> + *   // bpf_mprog user-side lock
>>> + *   // fetch active @entry from attach location
>>> + *   [...]
>>> + *   ret = bpf_mprog_detach(entry, [...]);
>>> + *   if (ret >= 0) {
>>> + *       release = ret == BPF_MPROG_FREE;
>>> + *       peer = release ? NULL : bpf_mprog_peer(entry);
>>> + *       if (bpf_mprog_swap_entries(ret))
>>> + *           // swap @entry to @peer at attach location
>>> + *       bpf_mprog_commit(entry);
>>> + *       if (release)
>>> + *           // free bpf_mprog_bundle
>>> + *       ret = 0;
>>> + *   } else {
>>> + *       // error path, bail out, propagate @ret
>>> + *   }
>>> + *   // bpf_mprog user-side unlock
>>
>> Thanks for the doc. It helped a lot.
>> And when it's contained like this it's easier to discuss api.
>> It seems bpf_mprog_swap_entries() is trying to abstract the error code
>> away, but BPF_MPROG_FREE leaks out and tcx_entry_needs_release()
>> captures it with extra miniq_active twist, which I don't understand yet.
>> bpf_mprog_peer() is also leaking a bit of implementation detail.
>> Can we abstract it further, like:
>>
>> ret = bpf_mprog_detach(entry, [...], &new_entry);
>> if (ret >= 0) {
>>     if (entry != new_entry)
>>       // swap @entry to @new_entry at attach location
>>     bpf_mprog_commit(entry);
>>     if (!new_entry)
>>       // free bpf_mprog_bundle
>> }
>> and make bpf_mprog_peer internal to mprog. It will also allow removing
>> BPF_MPROG_FREE vs SWAP distinction. peer is hidden.
>>     if (entry != new_entry)
>>        // update
>> also will be easier to read inside tcx code without looking into mprog details.

+1, agree, and I implemented this suggestion in the v5.

> I'm actually thinking if it's possible to simplify it even further.
> For example, do we even need a separate bpf_mprog_{attach,detach} and
> bpf_mprog_commit()? So far it seems like bpf_mprog_commit() is
> inevitable in case of success of attach/detach, so we might as well
> just do it as the last step of attach/detach operation.

It needs to be done after the pointers have been swapped by the mprog user.

> The only problem seems to be due to bpf_mprog interface doing this
> optimization of replacing stuff in place, if possible, and allowing
> the caller to not do the swap. How important is it to avoid that swap
> of a bpf_mprog_fp (pointer)? Seems pretty cheap (and relatively rare
> operation), so I wouldn't bother optimizing this.

I would like to keep it given e.g. when application comes up, fetches links
from bpffs and updates all its programs in place, then this is the replace
situation.

> So how about we just say that there is always a swap. Internally in
> bpf_mprog_bundle current entry is determined based on revision&1. We
> can have bpf_mprog_cur_entry() to return a proper pointer after
> commit. Or bpf_mprog_attach() can return proper new entry as output
> parameter, whichever is preferable.
> 
> As for BPF_MPROG_FREE. That seems like an unnecessary complication as
> well. Caller can just check bpf_mprog_total() quickly, and if it
> dropped to zero assume FREE. Unless there is something more subtle
> there?

Agree, some may want to keep an empty bpf_mprog, others may want to
free it. I implemented it this way. I removed all the BPF_MPROG_*
return codes.

> With the above, the interface will be much simpler, IMO. You just do
> bpf_mprog_attach/detach, and then swap pointer to new bpf_mprog_entry.
> Then you can check bpf_mprog_total() for zero, and clean up further,
> if necessary.
> 
> We assume the caller has a proper locking, so all the above should be non-racy.
> 
> BTW, combining commit with attach allows us to avoid that relatively
> big bpf_mprog_cp array on the stack as well, because we will be able
> to update bundle->cp_items in-place.
> 
> The only (I believe :) ) big assumption I'm making in all of the above
> is that commit is inevitable and we won't have a situation where we
> start attach, update fp/cpp, and then decide to abort instead of going
> for commit. Is this possible? Can we avoid it by careful checks
> upfront and doing attach as last step that cannot be undone?
> 
> P.S. I guess one bit that I might have simplified is that
> synchronize_rcu() + bpf_prog_put(), but I'm not sure exactly why we
> put prog after sync_rcu. But if it's really necessary (and I assume it

It is because users can still be inflight on the old mprog_entry so it
must come after the sync rcu where we drop ref for the delete case.

Thanks again,
Daniel

