Return-Path: <bpf+bounces-40539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E59899FB
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 07:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98871F21962
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0413A244;
	Mon, 30 Sep 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgIMNzBR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B53F9D2;
	Mon, 30 Sep 2024 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673416; cv=none; b=M5vyH2XpATed7sWrPm555A9VS4IoQMdtAXT34q9PyrMdRZ3nJ8sB9c7bKlUQA8EEgqHd9drzL/x/rorfOIJPDiWol5aXeStYSnl0NJdA2MwGAckhQlCGvpIl2hzi06qnLVCHvTt6v6lzphIE6eGVTn66KN/1bzk17ZuQYuVVXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673416; c=relaxed/simple;
	bh=dllRmrwzShIXVgGoq+5nOCyekmpQLEkB0GnnVVMJkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBQnssdxGhc0QvTcS+1ZC0Evy5ONcR4Db1NLvgaVNQqTiLlbv0LMfKCgZOO5q5BBFtRjmwvLHBs/WQSJmTDE0oGzYkMWnoGpqHEKP4iiCJey0+fRXfFo7lxKOjDMvWRRJ25z7xXyeFKEl/A52tf+g0ncxDvFQNCoJ8HuA+z0l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgIMNzBR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727673414; x=1759209414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dllRmrwzShIXVgGoq+5nOCyekmpQLEkB0GnnVVMJkno=;
  b=CgIMNzBRVU7hX6E8zteLxzSAitvd3tzHIp0teYJaDFcXp3pRYpL/pfD4
   D5/9H/pJNrJZDqfWfzWXcD4ZfLSsJ1LoJNowRPow7+YylHGKNEMN9MLHO
   eIcjUl+GgiTUIixq2JHc+09mqc5OtAnDNiHxFmMjftlsI7TbPsMnovD4p
   vgLk8X3IcPH1XSt6cWgTlHM1G7nyMDTlq8CJ3t2FWkbhNE+uiVcSXdsHj
   lrRlVufkbyhWBnB4RZwvIe+DYEvwzYk1yAs87ovkvFW8NbtIhDN9NpYv0
   zxN07MO8n5SxNs4JCTcfeHm/blsSA53AUgZQ3wk8ynNrZusMhJUO3DxSh
   w==;
X-CSE-ConnectionGUID: 7817yehDRLy+8UYo+fKTKw==
X-CSE-MsgGUID: 22h5oNsRTHiVaB+yaUethw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44262550"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="44262550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 22:16:52 -0700
X-CSE-ConnectionGUID: Wfymu7l8Sr2ScvZ1x+pXhg==
X-CSE-MsgGUID: kB223VhcT8mm9MED6UiXJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="103964176"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Sep 2024 22:16:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv8m6-000P3z-1s;
	Mon, 30 Sep 2024 05:16:46 +0000
Date: Mon, 30 Sep 2024 13:15:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jordan Rife <jrife@google.com>,
	netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] bpf: Prevent infinite loops with bpf_redirect_peer
Message-ID: <202409301255.h6vAvBWG-lkp@intel.com>
References: <20240929170219.1881536-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929170219.1881536-1-jrife@google.com>

Hi Jordan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master net/main net-next/main linus/master v6.12-rc1 next-20240927]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/bpf-Prevent-infinite-loops-with-bpf_redirect_peer/20240930-010356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240929170219.1881536-1-jrife%40google.com
patch subject: [PATCH v1] bpf: Prevent infinite loops with bpf_redirect_peer
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240930/202409301255.h6vAvBWG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240930/202409301255.h6vAvBWG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409301255.h6vAvBWG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/dev.c: In function '__netif_receive_skb_core':
>> net/core/dev.c:5458:13: warning: unused variable 'loops' [-Wunused-variable]
    5458 |         int loops = 0;
         |             ^~~~~


vim +/loops +5458 net/core/dev.c

  5448	
  5449	static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
  5450					    struct packet_type **ppt_prev)
  5451	{
  5452		struct packet_type *ptype, *pt_prev;
  5453		rx_handler_func_t *rx_handler;
  5454		struct sk_buff *skb = *pskb;
  5455		struct net_device *orig_dev;
  5456		bool deliver_exact = false;
  5457		int ret = NET_RX_DROP;
> 5458		int loops = 0;
  5459		__be16 type;
  5460	
  5461		net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
  5462	
  5463		trace_netif_receive_skb(skb);
  5464	
  5465		orig_dev = skb->dev;
  5466	
  5467		skb_reset_network_header(skb);
  5468		if (!skb_transport_header_was_set(skb))
  5469			skb_reset_transport_header(skb);
  5470		skb_reset_mac_len(skb);
  5471	
  5472		pt_prev = NULL;
  5473	
  5474	another_round:
  5475		skb->skb_iif = skb->dev->ifindex;
  5476	
  5477		__this_cpu_inc(softnet_data.processed);
  5478	
  5479		if (static_branch_unlikely(&generic_xdp_needed_key)) {
  5480			int ret2;
  5481	
  5482			migrate_disable();
  5483			ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
  5484					      &skb);
  5485			migrate_enable();
  5486	
  5487			if (ret2 != XDP_PASS) {
  5488				ret = NET_RX_DROP;
  5489				goto out;
  5490			}
  5491		}
  5492	
  5493		if (eth_type_vlan(skb->protocol)) {
  5494			skb = skb_vlan_untag(skb);
  5495			if (unlikely(!skb))
  5496				goto out;
  5497		}
  5498	
  5499		if (skb_skip_tc_classify(skb))
  5500			goto skip_classify;
  5501	
  5502		if (pfmemalloc)
  5503			goto skip_taps;
  5504	
  5505		list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
  5506			if (pt_prev)
  5507				ret = deliver_skb(skb, pt_prev, orig_dev);
  5508			pt_prev = ptype;
  5509		}
  5510	
  5511		list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
  5512			if (pt_prev)
  5513				ret = deliver_skb(skb, pt_prev, orig_dev);
  5514			pt_prev = ptype;
  5515		}
  5516	
  5517	skip_taps:
  5518	#ifdef CONFIG_NET_INGRESS
  5519		if (static_branch_unlikely(&ingress_needed_key)) {
  5520			bool another = false;
  5521	
  5522			nf_skip_egress(skb, true);
  5523			skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
  5524						 &another);
  5525			if (another) {
  5526				loops++;
  5527				if (unlikely(loops == RX_LOOP_LIMIT)) {
  5528					ret = NET_RX_DROP;
  5529					net_crit_ratelimited("bpf: loop limit reached on datapath, buggy bpf program?\n");
  5530					goto out;
  5531				}
  5532	
  5533				goto another_round;
  5534			}
  5535			if (!skb)
  5536				goto out;
  5537	
  5538			nf_skip_egress(skb, false);
  5539			if (nf_ingress(skb, &pt_prev, &ret, orig_dev) < 0)
  5540				goto out;
  5541		}
  5542	#endif
  5543		skb_reset_redirect(skb);
  5544	skip_classify:
  5545		if (pfmemalloc && !skb_pfmemalloc_protocol(skb))
  5546			goto drop;
  5547	
  5548		if (skb_vlan_tag_present(skb)) {
  5549			if (pt_prev) {
  5550				ret = deliver_skb(skb, pt_prev, orig_dev);
  5551				pt_prev = NULL;
  5552			}
  5553			if (vlan_do_receive(&skb))
  5554				goto another_round;
  5555			else if (unlikely(!skb))
  5556				goto out;
  5557		}
  5558	
  5559		rx_handler = rcu_dereference(skb->dev->rx_handler);
  5560		if (rx_handler) {
  5561			if (pt_prev) {
  5562				ret = deliver_skb(skb, pt_prev, orig_dev);
  5563				pt_prev = NULL;
  5564			}
  5565			switch (rx_handler(&skb)) {
  5566			case RX_HANDLER_CONSUMED:
  5567				ret = NET_RX_SUCCESS;
  5568				goto out;
  5569			case RX_HANDLER_ANOTHER:
  5570				goto another_round;
  5571			case RX_HANDLER_EXACT:
  5572				deliver_exact = true;
  5573				break;
  5574			case RX_HANDLER_PASS:
  5575				break;
  5576			default:
  5577				BUG();
  5578			}
  5579		}
  5580	
  5581		if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
  5582	check_vlan_id:
  5583			if (skb_vlan_tag_get_id(skb)) {
  5584				/* Vlan id is non 0 and vlan_do_receive() above couldn't
  5585				 * find vlan device.
  5586				 */
  5587				skb->pkt_type = PACKET_OTHERHOST;
  5588			} else if (eth_type_vlan(skb->protocol)) {
  5589				/* Outer header is 802.1P with vlan 0, inner header is
  5590				 * 802.1Q or 802.1AD and vlan_do_receive() above could
  5591				 * not find vlan dev for vlan id 0.
  5592				 */
  5593				__vlan_hwaccel_clear_tag(skb);
  5594				skb = skb_vlan_untag(skb);
  5595				if (unlikely(!skb))
  5596					goto out;
  5597				if (vlan_do_receive(&skb))
  5598					/* After stripping off 802.1P header with vlan 0
  5599					 * vlan dev is found for inner header.
  5600					 */
  5601					goto another_round;
  5602				else if (unlikely(!skb))
  5603					goto out;
  5604				else
  5605					/* We have stripped outer 802.1P vlan 0 header.
  5606					 * But could not find vlan dev.
  5607					 * check again for vlan id to set OTHERHOST.
  5608					 */
  5609					goto check_vlan_id;
  5610			}
  5611			/* Note: we might in the future use prio bits
  5612			 * and set skb->priority like in vlan_do_receive()
  5613			 * For the time being, just ignore Priority Code Point
  5614			 */
  5615			__vlan_hwaccel_clear_tag(skb);
  5616		}
  5617	
  5618		type = skb->protocol;
  5619	
  5620		/* deliver only exact match when indicated */
  5621		if (likely(!deliver_exact)) {
  5622			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  5623					       &ptype_base[ntohs(type) &
  5624							   PTYPE_HASH_MASK]);
  5625		}
  5626	
  5627		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  5628				       &orig_dev->ptype_specific);
  5629	
  5630		if (unlikely(skb->dev != orig_dev)) {
  5631			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  5632					       &skb->dev->ptype_specific);
  5633		}
  5634	
  5635		if (pt_prev) {
  5636			if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
  5637				goto drop;
  5638			*ppt_prev = pt_prev;
  5639		} else {
  5640	drop:
  5641			if (!deliver_exact)
  5642				dev_core_stats_rx_dropped_inc(skb->dev);
  5643			else
  5644				dev_core_stats_rx_nohandler_inc(skb->dev);
  5645			kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
  5646			/* Jamal, now you will not able to escape explaining
  5647			 * me how you were going to use this. :-)
  5648			 */
  5649			ret = NET_RX_DROP;
  5650		}
  5651	
  5652	out:
  5653		/* The invariant here is that if *ppt_prev is not NULL
  5654		 * then skb should also be non-NULL.
  5655		 *
  5656		 * Apparently *ppt_prev assignment above holds this invariant due to
  5657		 * skb dereferencing near it.
  5658		 */
  5659		*pskb = skb;
  5660		return ret;
  5661	}
  5662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

