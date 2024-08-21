Return-Path: <bpf+bounces-37736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D064C95A2F6
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5780D1F22793
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88871537A3;
	Wed, 21 Aug 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PPN2ehFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULtnYKOY"
X-Original-To: bpf@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9F43AB2;
	Wed, 21 Aug 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258208; cv=none; b=duAni2N+HkqlF0hsFxMLgyEBgPVokFy7kmTpHDLYqb5w1RjralZp0M/Y6Mek4SUiQR9loG5VJTgH+5SC8JypHXnXgA4skYEm0zAgtLtqIhSxn6NNhkZHVmspB3in3ukSVt0wHOatvVExY45rdcMhavA/HerdpU/fFw6FJoJ357I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258208; c=relaxed/simple;
	bh=1AriWfZ6EzkLaciBURe2A/AjcUh57VumYWkUeKiaBl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/TX84fTCWvzw9HXlwegMpH28iEeJHQMa7+dYL0vHtaLZg8MxDVOcqpkYuDPOWuqBzIfks8RKZIjIHSBM2wchlMs6nDsY6pNfzDH7hB5hD7kI/T9JuM4G0fTDRS7okQzLtxLer1ri5C/FngNp9ueI9doGNx1dPEPbvhqklG0Yhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=PPN2ehFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULtnYKOY; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 1FAED200ADB;
	Wed, 21 Aug 2024 12:36:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Aug 2024 12:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724258203;
	 x=1724265403; bh=bHgA/01GAODS9cxNCldY3ddoOgoAtJIssNkJpWLJAJk=; b=
	PPN2ehFbsVv+9xnl/UzVbkR5ZSVmrkSfk0ac0WATFxYH4+T/bvKtZVZQI0tQJf7w
	pEGPnKujkGHR11Z39i8TepGkxZiHMsBOzGLgdOt3TkQLInWI5oaz+5zBJazMfHCn
	IDjgj8QfMy0D/iSQFNQGxkO2e+m9+wK1S5GKbAQBd2+8LfZ8u49yOZJcG7LWLCw7
	YBcLceHnTo+F4UUYL/4klxzHg4+1jOVoKBprwF/+kjQOHqFDHd+dd9Rt7s6J1q3f
	dfnu7eLJOHUvWJTvj0AM2Vv2Jo6MeQCVSJKI/gyB6ACMh7QuBj+UmnpCSbtAnsPW
	b7n5+4tHnGa6wTK2JCDxyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724258203; x=
	1724265403; bh=bHgA/01GAODS9cxNCldY3ddoOgoAtJIssNkJpWLJAJk=; b=U
	LtnYKOY7DgrSFmdd6/GBgTdbj1vtTEwgl/U0tYkgO8mqR5ahKZUhXyYTUrOaBwqK
	DvSlguvfMLFj4Xeb3l7Fy+F/JiSVE/+LIIdEJMRHiHa2a0epqP5vadG4C6N86rMO
	doNe3sJQ/ik6IddXIOg7TMv61KuQKiESh5dZddpci+pVg959qmXUSbWCqskJ0rom
	tRns6VDC/JEd8d2Kww45CYWMd2Zup8ZxZBMXgAxe29YOi7zFGYa/9Mb1bmFNdZBX
	onwuGkcedW3V8h4MI9GSsIbYppgPeeuPUdX7YzLji5XgysWVxIHX/emH56WyWJ0s
	ogshnsA2DWHgOxxifTd3w==
X-ME-Sender: <xms:mhfGZurT2TPUlk8UezSzGPuCBqfKQgSumln34Ts820CO0YyJ2JY0Wg>
    <xme:mhfGZsqS0VfrIi0ByvgU67zTeYXt0UFMZx9L3abewT5ZGdMKOxqo5Zsd9VyA0Fmu_
    EonyfedNfICDKXuEQ>
X-ME-Received: <xmr:mhfGZjNUtSMcXSNJ1tqtcl6OpS4bEl57JzJ4wtowkMUfLTjgjBFgIVqPV7SloU422zhONo7_aondy1xjjpU0u2BiPY_NSiNyslozQUJbL54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeegkeejvdejgeehteek
    udfhgfefgeevkeelhfegueeljefhleejtdekveffnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedviedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehinhht
    vghlrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtohhkvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrsghi
    rghntghonhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhdrlh
    hosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtph
    htthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhihshgr
    rdiirghrvghmsggrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:mhfGZt4XwjtV1asJfMFcBSTnpqKVoPRpFeR8pQG5GJSMMIJOsIl-2Q>
    <xmx:mhfGZt5hAZTD7P0RIeJCLalu2t0YsVRVUdRnwI8eMSj2zoATj4P7GQ>
    <xmx:mhfGZti7EoARV9faedGMI6MtvUKC9wDPSEfXAabQlAP62HokgHHYMg>
    <xmx:mhfGZn6ce0qWKbpfAIQ_-fZiYMuMI_FfT0O_HpoeJJ5YNNGYEf4Qsg>
    <xmx:mxfGZsKv2e2ZV_xVYE5CePQPCkEgpH6dtmYy-GcBxkUETqNXUGHfds3Z>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 12:36:39 -0400 (EDT)
Date: Wed, 21 Aug 2024 09:36:36 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 	Alexander Lobakin <alexandr.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 	Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 	Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 	Lorenzo Bianconi <lorenzo@kernel.org>,
 David Miller <davem@davemloft.net>, 	Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, 	Paolo Abeni <pabeni@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 	Yajun Deng <yajun.deng@linux.dev>,
 Willem de Bruijn <willemb@google.com>,
 	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ji5ybcoaybk54mphk2qi4aiv5b7s3nmxdi2iqsyjvg4ang7d4l@iwdvgjbhihyz>
References: <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
 <874j7oean6.fsf@toke.dk>
 <34cc17a1-dee2-4eb0-9b24-7b264cb63521@kernel.org>
 <c596dff4-1e8b-4184-8eb6-590b4da2d92a@intel.com>
 <merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh>
 <7a91042b-4406-4b99-99c5-6ec1ec7b98d7@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a91042b-4406-4b99-99c5-6ec1ec7b98d7@intel.com>

On Wed, Aug 21, 2024 at 03:16:51PM GMT, Alexander Lobakin wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Tue, 20 Aug 2024 17:29:45 -0700
> 
> > Hi Olek,
> > 
> > On Mon, Aug 19, 2024 at 04:50:52PM GMT, Alexander Lobakin wrote:
> > [..]
> >>> Thanks A LOT for doing this benchmarking!
> >>
> >> I optimized the code a bit and picked my old patches for bulk NAPI skb
> >> cache allocation and today I got 4.7 Mpps 🎉
> >> IOW, the result of the series (7 patches totally, but 2 are not
> >> networking-related) is 2.7 -> 4.7 Mpps == 75%!
> >>
> >> Daniel,
> >>
> >> if you want, you can pick my tree[0], either full or just up to
> >>
> >> "bpf: cpumap: switch to napi_skb_cache_get_bulk()"
> >>
> >> (13 patches total: 6 for netdev_feature_t and 7 for the cpumap)
> >>
> >> and test with your usecases. Would be nice to see some real world
> >> results, not my synthetic tests :D
> >>
> >>> --Jesper
> >>
> >> [0]
> >> https://github.com/alobakin/linux/compare/idpf-libie-new~52...idpf-libie-new/
> > 
> > So it turns out keeping the workload in place while I update and reboot
> > the kernel is a Hard Problem. I'll put in some more effort and see if I
> > can get one of the workloads to stay still, but it'll be a somewhat
> > noisy test even if it works. So the following are synthetic tests
> > (neper) but on a real prod setup as far as container networking and
> > configuration is concerned.
> > 
> > I cherry-picked 586be610~1..ca22ac8e9de onto our 6.9-ish branch. Had to
> > skip some of the flag refactors b/c of conflicts - I didn't know the
> > code well enough to do fixups. So I had to apply this diff (FWIW not sure
> > the struct_size() here was right anyhow):
> > 
> > diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> > index 089d19c62efe..359fbfaa43eb 100644
> > --- a/kernel/bpf/cpumap.c
> > +++ b/kernel/bpf/cpumap.c
> > @@ -110,7 +110,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
> >  	if (!cmap->cpu_map)
> >  		goto free_cmap;
> >  
> > -	dev = bpf_map_area_alloc(struct_size(dev, priv, 0), NUMA_NO_NODE);
> > +	dev = bpf_map_area_alloc(sizeof(*dev), NUMA_NO_NODE);
> 
> Hmm, it will allocate the same amount of memory. Why do you need this?
> Are you running these patches on some older kernel which doesn't have a
> proper flex array at the end of &net_device?

Ah my mistake, you're right. I probably looked at the 6.9 source without
the flex array and confused it with net-next. But yeah, the 6.9 kernel
I tested with does not have the flex array.

> 
> >  	if (!dev)
> >  		goto free_cpu_map;
> >  
> > 
> > ==== Baseline ===
> > 	./tcp_rr -c -H $SERVER -p 50,90,99 -T4 -F8 -l30				./tcp_stream -c -H $SERVER -T8 -F16 -l30
> > 
> > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > Run 1	2578189	        0.00008831	0.00010623	0.00013439		Run 1	15427.22
> > Run 2	2657923	        0.00008575	0.00010239	0.00012927		Run 2	15272.12
> > Run 3	2700402	        0.00008447	0.00010111	0.00013183		Run 3	14871.35
> > Run 4	2571739	        0.00008575	0.00011519	0.00013823		Run 4	15344.72
> > Run 5	2476427	        0.00008703	0.00013055	0.00016895		Run 5	15193.2
> > Average	2596936	        0.000086262	0.000111094	0.000140534		Average	15221.722
> > 
> > === cpumap NAPI patches ===
> > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > Run 1	2554598	        0.00008703	0.00011263	0.00013055		Run 1	17090.29
> > Run 2	2478905	        0.00009087	0.00011391	0.00014463		Run 2	16742.27
> > Run 3	2418599	        0.00009471	0.00011007	0.00014207		Run 3	17555.3
> > Run 4	2562463	        0.00008959	0.00010367	0.00013055		Run 4	17892.3
> > Run 5	2716551	        0.00008127	0.00010879	0.00013439		Run 5	17578.32
> > Average	2546223.2	0.000088694	0.000109814	0.000136438		Average	17371.696
> > Delta	-1.95%	        2.82%	        -1.15%	        -2.91%			        14.12%
> > 
> > 
> > So it looks like the GRO patches work quite well out of the box. It's
> > curious that tcp_rr transactions go down a bit, though. I don't have any
> > intuition around that.
> 
> 14% is quite nice I'd say. Is this first table taken from the cpumap as
> well or just direct Rx?

Both cpumap. The only variable I changed was adding your patches.

Thanks,
Daniel

