Return-Path: <bpf+bounces-10830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D47AE301
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 595B41C209F8
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34EEA4;
	Tue, 26 Sep 2023 00:39:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82E628;
	Tue, 26 Sep 2023 00:39:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25786109;
	Mon, 25 Sep 2023 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695688784; x=1727224784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=esAM1eq6e5BDjVaq/Dlxo26wwl6ckKJqGizWKOm9u7Q=;
  b=SNG3CW2zmRAnsMiNBH0HrSYAe9RUoFxLXNYDEE0RfQQm7M1eDXAq2Hya
   y1nZ8Bgj48Gr49CC+9J0rPp30ZgFcNHxery2f5PCTdxOuuSBH0m9sxXVv
   H+g8lW6J5ILQ9HRJ7cQMFMlQ9CiJWg+kcq/E83ut99Yc37bVX+8K6MvtP
   hqyG2zKpbXiP5HfxpoNsfjWy2lMlPOCMB6KvQaeGfO2KGsQyeBflYw2zv
   19aPxge8ICa7jManKmOvCtw08Rk3tKfjdjDDrWZVAfVWdQ9J0/2FKx0YM
   xei2NhVXmC+R5uLSBJIPVza3I7cmYO0Gf8NrCXujnudNV2YRfedmg0FNH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412365169"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412365169"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777913573"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="777913573"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2023 17:39:40 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qkw70-0002CL-1N;
	Tue, 26 Sep 2023 00:39:38 +0000
Date: Tue, 26 Sep 2023 08:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, daniel@iogearbox.net,
	ast@kernel.org, andrii@kernel.org, jakub@cloudflare.com
Cc: oe-kbuild-all@lists.linux.dev, john.fastabend@gmail.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com
Subject: Re: [PATCH bpf v2 1/3] bpf: tcp_read_skb needs to pop skb regardless
 of seq
Message-ID: <202309260854.w4YOXCoL-lkp@intel.com>
References: <20230925202448.100920-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925202448.100920-2-john.fastabend@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Fastabend/bpf-tcp_read_skb-needs-to-pop-skb-regardless-of-seq/20230926-042625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20230925202448.100920-2-john.fastabend%40gmail.com
patch subject: [PATCH bpf v2 1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230926/202309260854.w4YOXCoL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230926/202309260854.w4YOXCoL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309260854.w4YOXCoL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_read_skb':
>> net/ipv4/tcp.c:1624:26: warning: unused variable 'tp' [-Wunused-variable]
    1624 |         struct tcp_sock *tp = tcp_sk(sk);
         |                          ^~


vim +/tp +1624 net/ipv4/tcp.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1621  
965b57b469a589 Cong Wang      2022-06-15  1622  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
04919bed948dc2 Cong Wang      2022-06-15  1623  {
04919bed948dc2 Cong Wang      2022-06-15 @1624  	struct tcp_sock *tp = tcp_sk(sk);
04919bed948dc2 Cong Wang      2022-06-15  1625  	struct sk_buff *skb;
04919bed948dc2 Cong Wang      2022-06-15  1626  	int copied = 0;
04919bed948dc2 Cong Wang      2022-06-15  1627  
04919bed948dc2 Cong Wang      2022-06-15  1628  	if (sk->sk_state == TCP_LISTEN)
04919bed948dc2 Cong Wang      2022-06-15  1629  		return -ENOTCONN;
04919bed948dc2 Cong Wang      2022-06-15  1630  
44bb37a8112f62 John Fastabend 2023-09-25  1631  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
db4192a754ebd5 Cong Wang      2022-09-12  1632  		u8 tcp_flags;
db4192a754ebd5 Cong Wang      2022-09-12  1633  		int used;
04919bed948dc2 Cong Wang      2022-06-15  1634  
04919bed948dc2 Cong Wang      2022-06-15  1635  		__skb_unlink(skb, &sk->sk_receive_queue);
96628951869c0d Peilin Ye      2022-09-08  1636  		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
db4192a754ebd5 Cong Wang      2022-09-12  1637  		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
db4192a754ebd5 Cong Wang      2022-09-12  1638  		used = recv_actor(sk, skb);
db4192a754ebd5 Cong Wang      2022-09-12  1639  		if (used < 0) {
db4192a754ebd5 Cong Wang      2022-09-12  1640  			if (!copied)
db4192a754ebd5 Cong Wang      2022-09-12  1641  				copied = used;
db4192a754ebd5 Cong Wang      2022-09-12  1642  			break;
db4192a754ebd5 Cong Wang      2022-09-12  1643  		}
db4192a754ebd5 Cong Wang      2022-09-12  1644  		copied += used;
db4192a754ebd5 Cong Wang      2022-09-12  1645  
44bb37a8112f62 John Fastabend 2023-09-25  1646  		if (tcp_flags & TCPHDR_FIN)
db4192a754ebd5 Cong Wang      2022-09-12  1647  			break;
db4192a754ebd5 Cong Wang      2022-09-12  1648  	}
04919bed948dc2 Cong Wang      2022-06-15  1649  	return copied;
04919bed948dc2 Cong Wang      2022-06-15  1650  }
04919bed948dc2 Cong Wang      2022-06-15  1651  EXPORT_SYMBOL(tcp_read_skb);
04919bed948dc2 Cong Wang      2022-06-15  1652  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

