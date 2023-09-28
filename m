Return-Path: <bpf+bounces-11081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22317B2744
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9A63B2838DA
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E400168AB;
	Thu, 28 Sep 2023 21:14:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8B15AD9;
	Thu, 28 Sep 2023 21:14:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDDF3;
	Thu, 28 Sep 2023 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Djf5vC9R2QQRJ5sa4M5AHJ2h7xGGZ+DqCUCd25RvJM8=; b=agMja51AJkiVlJue+tH+NWnpUp
	Hg2K0tCkNhHPLI9wH5MR8wksCqdQgP9bDBXEz7LfbZa1rva89y/F7Cazpsz0Mm4gVZxy6wuVBv9M3
	BC0/qPspeJt7FhPUidpMkzNz+BOou/qbJu0glpiLyzv+ahdtdBdxtV3lSsOp8vlvgEicwfLFJEx5V
	k6tmI5Lhe4sTCQwveIWaiLe5/yA2aHwuOli41TzqGMZyAPIelFYDpZ9Gyb1vHGYqdHn1bzZFfrAHD
	ndAvkVgw4yzoVlBh70lDO5EDwFo3ABapJ3D8CKyT03es+u1EEiXHNRTW9nlXrx6U36HKijBtt49ol
	tXvlp1bg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qlyKu-000Bkz-Cy; Thu, 28 Sep 2023 23:14:16 +0200
Received: from [178.197.248.41] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qlyKt-000PSo-S3; Thu, 28 Sep 2023 23:14:16 +0200
Subject: Re: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-2-daniel@iogearbox.net> <877coa8xp2.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <11c6240c-ab6b-fba3-d84a-824b3fa36ac9@iogearbox.net>
Date: Thu, 28 Sep 2023 23:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <877coa8xp2.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27045/Thu Sep 28 09:39:25 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/23 11:16 AM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> This work adds a new, minimal BPF-programmable device called "meta" we
>> recently presented at LSF/MM/BPF. The latter name derives from the Greek
>> μετά, encompassing a wide array of meanings such as "on top of", "beyond".
>> Given business logic is defined by BPF, this device can have many meanings.
>> The core idea is that BPF programs are executed within the drivers xmit
>> routine and therefore e.g. in case of containers/Pods moving BPF processing
>> closer to the source.
> 
> I like the concept, but I think we should change the name (as I believe
> I also mentioned back when you presented it at LSF/MM/BPF). I know this
> is basically bikeshedding, but I nevertheless think it is important, for
> a couple of reasons:
> 
> - As you say, meta has a specific meaning, and this device is not a
>    "meta" device in the common sense of the word: it is not tied to other
>    devices (so it's not 'on top of' anything), and it is not "about"
>    anything (as in metadata). It is just a device type that is programmed
>    by BPF, so let's call it that.
> 
> - It's not discoverable; how are people supposed to figure out that they
>    should go look for a 'meta' device? We also already have multiple
>    things called 'metadata', so this is just going to create even more
>    confusion (as we also discussed in relation to 'xdp hints').
> 
> - It squats on a pretty widely used term throughout the kernel
>    (CONFIG_META, 'meta' as the module name). This is related to the above
>    point; seeing something named 'meta' in lsmod, the natural assumption
>    wouldn't be that it's a network driver.
> 
> I think we should just name the driver 'bpfnet'; it's not pretty, but
> it's obvious and descriptive. Optionally we could teach 'ip' to
> understand just 'bpf' as the device type, so you could go 'ip link add
> type bpf' and get one of these.

I'll think about it, the bpfnet sounds terrible as you also noticed. I
definitely don't like that. Perhaps meta_net as suggested by Andrii in
the other thread could be a compromise. Need to sleep over it, my pref
was actually to keep it shorter.

>> One of the goals was that in case of Pod egress traffic, this allows to
>> move BPF programs from hostns tcx ingress into the device itself, providing
>> earlier drop or forward mechanisms, for example, if the BPF program
>> determines that the skb must be sent out of the node, then a redirect to
>> the physical device can take place directly without going through per-CPU
>> backlog queue. This helps to shift processing for such traffic from softirq
>> to process context, leading to better scheduling decisions and better
>> performance.
> 
> So my only reservation to having this tied to a BPF-only device like
> this is basically that if this is indeed such a big win, shouldn't we
> try to make the stack operate in this mode by default? I assume you did
> the analysis of what it would take to change veth to operate in this
> mode; so what was the reason you decided to create a new device type
> instead?

There are multiple virtual device flavors and veth is not the sole one. Could
other virtual devices have been extended into veth? Perhaps, but it doesn't
mean it should. veth has very much connotation of L2 and device pair. In this
case here the core of it is around having BPF logic as part of the xmit logic
(with default policies when no BPF is attached), being able to have L3 mode
and having the option to use them as paired devices but also as just single/
standalone one which we plan to push as next step after this series.

> Some comments on the code below:
> 
>> --- /dev/null
>> +++ b/drivers/net/meta.c
>> @@ -0,0 +1,734 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2023 Isovalent */
>> +
>> +#include <linux/netdevice.h>
>> +#include <linux/ethtool.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/filter.h>
>> +#include <linux/netfilter_netdev.h>
>> +#include <linux/bpf_mprog.h>
>> +
>> +#include <net/meta.h>
>> +#include <net/dst.h>
>> +#include <net/tcx.h>
>> +
>> +#define DRV_NAME	"meta"
>> +#define DRV_VERSION	"1.0"
> 
> Looking at veth as an example, this will probably never get updated :)
> 
> So wouldn't it be better to use the kernel version as the driver
> version? That way there will at least be some information in this field.
> I guess we could make the same change for veth.

That's fine, I can change it to something more useful.

[...]
>> +static netdev_tx_t meta_xmit(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	struct meta *meta = netdev_priv(dev);
>> +	enum meta_action ret = READ_ONCE(meta->policy);
>> +	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
>> +	const struct bpf_mprog_entry *entry;
>> +	struct net_device *peer;
>> +
>> +	rcu_read_lock();
>> +	peer = rcu_dereference(meta->peer);
>> +	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
>> +		     !pskb_may_pull(skb, ETH_HLEN) ||
>> +		     skb_orphan_frags(skb, GFP_ATOMIC)))
>> +		goto drop;
>> +	meta_scrub_minimum(skb);
>> +	skb->dev = peer;
>> +	entry = rcu_dereference(meta->active);
>> +	if (entry)
>> +		ret = meta_run(meta, entry, skb, ret);
>> +	switch (ret) {
>> +	case META_NEXT:
>> +	case META_PASS:
>> +		skb->pkt_type = PACKET_HOST;
>> +		skb->protocol = eth_type_trans(skb, skb->dev);
>> +		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
>> +		__netif_rx(skb);
>> +		break;
>> +	case META_REDIRECT:
>> +		skb_do_redirect(skb);
>> +		break;
>> +	case META_DROP:
> 
> Why the aliases for the constants? Might as well reuse the TCX names?

The constants are also used for the default configuration of the device
when no bpf is attached. Using tcx constant names as part of the config
is confusing, I don't see a reason why it needs to be tied together, it's
more confusing than it would help anything.

>> +	default:
>> +drop:
>> +		ret_dev = NET_XMIT_DROP;
>> +		dev_core_stats_tx_dropped_inc(dev);
>> +		kfree_skb(skb);
>> +		break;
>> +	}
>> +	rcu_read_unlock();
>> +	return ret_dev;
>> +}
>> +
>> +static int meta_open(struct net_device *dev)
>> +{
>> +	struct meta *meta = netdev_priv(dev);
>> +	struct net_device *peer = rtnl_dereference(meta->peer);
>> +
>> +	if (!peer)
>> +		return -ENOTCONN;
>> +	if (peer->flags & IFF_UP) {
>> +		netif_carrier_on(dev);
>> +		netif_carrier_on(peer);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int meta_close(struct net_device *dev)
>> +{
>> +	struct meta *meta = netdev_priv(dev);
>> +	struct net_device *peer = rtnl_dereference(meta->peer);
>> +
>> +	netif_carrier_off(dev);
>> +	if (peer)
>> +		netif_carrier_off(peer);
>> +	return 0;
>> +}
>> +
>> +static int meta_get_iflink(const struct net_device *dev)
>> +{
>> +	struct meta *meta = netdev_priv(dev);
>> +	struct net_device *peer;
>> +	int iflink = 0;
>> +
>> +	rcu_read_lock();
>> +	peer = rcu_dereference(meta->peer);
>> +	if (peer)
>> +		iflink = peer->ifindex;
>> +	rcu_read_unlock();
>> +	return iflink;
>> +}
>> +
>> +static void meta_set_multicast_list(struct net_device *dev)
>> +{
>> +}
> 
> The function name indicates there is some functionality envisioned here?
> Why is the function empty?

This is a stub callback to deal with multicast filter, given it's a virtual
dev and it'll receive traffic you push to w/o further config this one is
empty. See also ndo_set_rx_mode for various other virtual-only devs. I can
add a comment.

[...]
>> +static struct net_device *meta_dev_fetch(struct net *net, u32 ifindex, u32 which)
>> +{
>> +	struct net_device *dev;
>> +	struct meta *meta;
>> +
>> +	ASSERT_RTNL();
>> +
>> +	switch (which) {
>> +	case BPF_META_PRIMARY:
>> +	case BPF_META_PEER:
>> +		break;
>> +	default:
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	dev = __dev_get_by_index(net, ifindex);
>> +	if (!dev)
>> +		return ERR_PTR(-ENODEV);
>> +	if (!(dev->priv_flags & IFF_META))
>> +		return ERR_PTR(-ENXIO);
> 
> I don't really think a new flag value is needed here? Can't you just
> make this check if (dev->netdev_ops == &meta_netdev_ops) ?

Agree, very good point. Will change.

[...]
>>   #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
>> @@ -3720,6 +3721,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>>   		return BPF_PROG_TYPE_LSM;
>>   	case BPF_TCX_INGRESS:
>>   	case BPF_TCX_EGRESS:
>> +	case BPF_META_PRIMARY:
>> +	case BPF_META_PEER:
>>   		return BPF_PROG_TYPE_SCHED_CLS;
>>   	default:
>>   		return BPF_PROG_TYPE_UNSPEC;
>> @@ -3771,7 +3774,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>>   		return 0;
>>   	case BPF_PROG_TYPE_SCHED_CLS:
>>   		if (attach_type != BPF_TCX_INGRESS &&
>> -		    attach_type != BPF_TCX_EGRESS)
>> +		    attach_type != BPF_TCX_EGRESS &&
>> +		    attach_type != BPF_META_PRIMARY &&
>> +		    attach_type != BPF_META_PEER)
> 
> PRIMARY and PEER basically correspond to INGRESS and EGRESS in terms of
> which packets the program sees, right? So why not just reuse ingress and
> egress designators, the fact that it's a "peer" attachment is mostly an
> implementation detail, isn't it? Or should 'mirred' redirection to the
> device inside a container also be supported? (is it?)

No, ingress/egress is higly confusing here given it can have many meanings.
You can ingress into the container or ingress into the host, for example, so
it is not clear without more context. Also in a next step we plan to make
this device configurable as a single device instead of peered. Then it's
only 'primary' available where you attach to, much simpler to reason about
from a mental model.

> Reusing it (and special-casing the tcx attachment) would prevent people
> from accidentally attaching a tcx program on top of the device (which
> AFAICT if otherwise possible, right?). Or maybe this is a feature?

You can use tcx with it just fine and maybe some people have a need for it,
for example, for implementing logic within the container. There is certainly
no reason to prevent that.

Thanks,
Daniel

