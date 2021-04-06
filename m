Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F753550AF
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhDFKTk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 06:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242740AbhDFKTb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 06:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617704363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ufcdt/zJw9j/1FNSFVZxZoRU8kGYBv449O2z2yjeO8=;
        b=XSU8yr9Mml8P/27nyc9gssDJxJBCllTwgF1ABdr48dSRN180Eh3mQT3AoCjcHVVjCl5Ugg
        ANnpm54VfECC96lnOK5+dLHrj7Jakg2c9EjIlJigmKi+4OWPXys1XnN54/x11Z1LDUhWJZ
        IPe2fulcTKtIArMw4To3yWdVCuZJxdM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-BH87rMBlNbCMmK43cRumNA-1; Tue, 06 Apr 2021 06:19:21 -0400
X-MC-Unique: BH87rMBlNbCMmK43cRumNA-1
Received: by mail-ed1-f72.google.com with SMTP id o24so10144578edt.15
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 03:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+ufcdt/zJw9j/1FNSFVZxZoRU8kGYBv449O2z2yjeO8=;
        b=hK0mRdaLrd8ofCMsArZgMQx71QnZy/SvOsUZ+9VzdWnpTMwy9gkYZdwKUzotUQR+u9
         LOUOW0qyA7G3a2spoDwkpKB3m3nov9unK2mDFrRiAk3/wcHse5TjwRHxtSMHclEfI81e
         TT93CSN/zAy4kq3fefvL4CQowf8qXPnDkja8SZ3ntkaZLk+VN9BEy2wphY1W8qb4s3F5
         995eebpHV7OoeVSR15pmu4aqK88nZVuFsTPOLLYK+sJ34L2tmXV1/OjzB5ns89Z+ifbt
         1iN1LMOBxWVx/XZ1ppr+sPhWgkBmTKawbwJG1/MWf1otkrGDB6nnaksdHN26jyaDmILq
         vukA==
X-Gm-Message-State: AOAM5301lxV39Sqov4uG25KQpuIXl284ulkuhdNWcPm7zYKPMrbo90VL
        KnNWKyLVE4pxejFXo6vrF7DesTSGLJVSdYcPG899iSimEUXqqvWFRIqVIoaglDfNUbMy/hNmxcL
        k48Ewr0v00z1r
X-Received: by 2002:a17:906:26c9:: with SMTP id u9mr32838243ejc.520.1617704360469;
        Tue, 06 Apr 2021 03:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKwe/Gl6HZeC04h+m57gvA5VMqo2tcnIH+2UED5/265g04nui6Cog7Q0uWkVz8QiZw6NE3pg==
X-Received: by 2002:a17:906:26c9:: with SMTP id u9mr32838210ejc.520.1617704360075;
        Tue, 06 Apr 2021 03:19:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w13sm994838edx.15.2021.04.06.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:19:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 02137180300; Tue,  6 Apr 2021 12:19:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210406063819.GF2900@Leo-laptop-t470s>
References: <20210402121954.3568992-1-liuhangbin@gmail.com>
 <20210402121954.3568992-3-liuhangbin@gmail.com>
 <606baa5025735_d46462085b@john-XPS-13-9370.notmuch>
 <20210406063819.GF2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Apr 2021 12:19:18 +0200
Message-ID: <878s5v4swp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Mon, Apr 05, 2021 at 05:24:48PM -0700, John Fastabend wrote:
>> Hangbin Liu wrote:
>> > This patch add two flags BPF_F_BROADCAST and BPF_F_EXCLUDE_INGRESS to extend
>> > xdp_redirect_map for broadcast support.
>> > 
>> > Keep the general data path in net/core/filter.c and the native data
>> > path in kernel/bpf/devmap.c so we can use direct calls to get better
>> > performace.
>> > 
>> > Here is the performance result by using xdp_redirect_{map, map_multi} in
>> > sample/bpf and send pkts via pktgen cmd:
>> > ./pktgen_sample03_burst_single_flow.sh -i eno1 -d $dst_ip -m $dst_mac -t 10 -s 64
>> > 
>> > There are some drop back as we need to loop the map and get each interface.
>> > 
>> > Version          | Test                                | Generic | Native
>> > 5.12 rc2         | redirect_map        i40e->i40e      |    2.0M |  9.8M
>> > 5.12 rc2         | redirect_map        i40e->veth      |    1.8M | 12.0M
>> 
>> Are these are 10gbps i40e ports? Sorry if I asked this earlier, maybe
>> add a note in the commit if another respin is needed.
>
> Yes, I will add it if there is an update.
>
>> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> > index 3980fb3bfb09..c8452c5f40f8 100644
>> > --- a/kernel/bpf/devmap.c
>> > +++ b/kernel/bpf/devmap.c
>> > @@ -198,6 +198,7 @@ static void dev_map_free(struct bpf_map *map)
>> >  	list_del_rcu(&dtab->list);
>> >  	spin_unlock(&dev_map_lock);
>> >  
>> > +	bpf_clear_redirect_map(map);
>> 
>> Is this a bugfix? If its needed here wouldn't we also need it in the
>> devmap case.
>
> No, in ee75aef23afe ("bpf, xdp: Restructure redirect actions") this function
> was removed. I added it back as we use ri->map again.
>
> What devmap case you mean?
>
>> 
>> >  	synchronize_rcu();
>> >  
>> >  	/* Make sure prior __dev_map_entry_free() have completed. */
>> 
>> [...]
>> 
>> > +
>> > +static struct bpf_dtab_netdev *devmap_get_next_obj(struct xdp_buff *xdp,
>> > +						   struct bpf_map *map,
>> > +						   u32 *key, u32 *next_key,
>> > +						   int ex_ifindex)
>> > +{
>> > +	struct bpf_dtab_netdev *obj;
>> > +	struct net_device *dev;
>> > +	u32 index;
>> > +	int err;
>> > +
>> > +	err = devmap_get_next_key(map, key, next_key);
>> > +	if (err)
>> > +		return NULL;
>> > +
>> > +	/* When using dev map hash, we could restart the hashtab traversal
>> > +	 * in case the key has been updated/removed in the mean time.
>> > +	 * So we may end up potentially looping due to traversal restarts
>> > +	 * from first elem.
>> > +	 *
>> > +	 * Let's use map's max_entries to limit the loop number.
>> > +	 */
>> > +	for (index = 0; index < map->max_entries; index++) {
>> > +		obj = devmap_lookup_elem(map, *next_key);
>> > +		if (!obj || dst_dev_is_ingress(obj, ex_ifindex))
>> > +			goto find_next;
>> > +
>> > +		dev = obj->dev;
>> > +
>> > +		if (!dev->netdev_ops->ndo_xdp_xmit)
>> > +			goto find_next;
>> > +
>> > +		err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
>> > +		if (unlikely(err))
>> > +			goto find_next;
>> > +
>> > +		return obj;
>> > +
>> > +find_next:
>> > +		key = next_key;
>> > +		err = devmap_get_next_key(map, key, next_key);
>> > +		if (err)
>> > +			break;
>> > +	}
>> 
>> I'm missing something. Either an elaborated commit message or comment
>> is probably needed. I've been looking at this block for 30 minutes and
>> can't see how we avoid sending duplicate frames on a single interface?
>> Can you check this code flow, 
>> 
>>   dev_map_enqueue_multi()
>>    for (;;) {
>>      next_obj = devmap_get_next_obj(...)
>>         for (index = 0; index < map->max_entries; index++) {
>>            obj = devmap_lookup_elem();
>>            if (!obj) goto find_next
>>            key = next_key;
>>            err = devmap_get_next_key() 
>>                   if (!key) goto find_first
>>                   for (i = 0; i < dtab->n_buckets; i++)
>>                      return *next <- now *next_key is point back
>>                                      at first entry
>>            // loop back through and find first obj and return that
>
> 	 devmap_get_next_key() will loop to find the first one if there is no
> 	 key or dev. In normal time it will stop after the latest one.
>>         }
>>       bq_enqueue(...) // enqueue original obj
>>       obj = next_obj;
>>       key = next_key; 
>>       ...  // we are going to enqueue first obj, but how do we know
>>            // this hasn't already been sent? Presumably if we have
>>            // a delete in the hash table in the middle of a multicast
>>            // operation this might happen?
>>    }
>
> And yes, there is an corner case that if we removed a dev during multicast,
> there is an possibility that restart from the first key. But given that
> this is an unlikely case, and in normal internet there is also a possibility
> of duplicate/lost packet. This should also be acceptable?

In my mind this falls under "acceptable corner cases". I.e., if you're
going to use the map for redirect and you expect to be updating it while
you're doing so, don't use a hashmap. But if you will not be updating
the map (or find the possible duplication acceptable), you can use the
hashmap and gain the benefit of being able to index by ifindex.

But John does have a point that this is not obvious; so maybe it should
be pointed out in the helper documentation?

-Toke

