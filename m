Return-Path: <bpf+bounces-10685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA17AC2CC
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 97227B2084A
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464851D547;
	Sat, 23 Sep 2023 14:38:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D71CFA5;
	Sat, 23 Sep 2023 14:38:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D111D;
	Sat, 23 Sep 2023 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695479888; x=1727015888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FgEs+W2rw9WobfIupSC05nSHa9tZRyrzcLmSdnEKaM=;
  b=G1v9xIqkAhfEihGV2laXpUr7g1M1QuvhUxijRdkXb6gpwin46yeIbEQH
   Cxt65qdUpu7orqgM+nQ9SmwsqNruMegqoE3MdQnA+GVuOtkkr6l8bfVTd
   XRN57hCv+6n0WEuoRoUBAqJkc0XWwVjK17wKJTIjHKtCfJZSoxHdSVO5t
   yT2K5z4ims10ej7lQFsNRRg0OObteEXScs7OKad5KIuNgXYbRcGIaGxqb
   4orMr23glM8KIUhk+oXn2SOnXVm1fD654XGKBK/bU/GrM0GWB7mPE+8Zp
   4IKbJh62KjaZ7B4ch5g/ocT9WgQXGCuhm4ySRtx3F9BNPJ/1/KS4ERGsM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="360408650"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="360408650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 07:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="697519648"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="697519648"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2023 07:38:02 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qk3lB-0002Tt-30;
	Sat, 23 Sep 2023 14:37:34 +0000
Date: Sat, 23 Sep 2023 22:37:15 +0800
From: kernel test robot <lkp@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, daniel@iogearbox.net,
	ast@kernel.org, andrii@kernel.org, jakub@cloudflare.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/3] bpf: tcp_read_skb needs to pop skb regardless of
 seq
Message-ID: <202309232236.36lvZlKR-lkp@intel.com>
References: <20230920232706.498747-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920232706.498747-2-john.fastabend@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Fastabend/bpf-tcp_read_skb-needs-to-pop-skb-regardless-of-seq/20230921-073209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20230920232706.498747-2-john.fastabend%40gmail.com
patch subject: [PATCH bpf 1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230923/202309232236.36lvZlKR-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309232236.36lvZlKR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309232236.36lvZlKR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/tcp.c:252:
   In file included from include/linux/inet_diag.h:5:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/ipv4/tcp.c:252:
   In file included from include/linux/inet_diag.h:5:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/ipv4/tcp.c:252:
   In file included from include/linux/inet_diag.h:5:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/ipv4/tcp.c:1625:6: warning: variable 'seq' set but not used [-Wunused-but-set-variable]
    1625 |         u32 seq = tp->copied_seq;
         |             ^
   13 warnings generated.


vim +/seq +1625 net/ipv4/tcp.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1621  
965b57b469a589 Cong Wang      2022-06-15  1622  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
04919bed948dc2 Cong Wang      2022-06-15  1623  {
04919bed948dc2 Cong Wang      2022-06-15  1624  	struct tcp_sock *tp = tcp_sk(sk);
04919bed948dc2 Cong Wang      2022-06-15 @1625  	u32 seq = tp->copied_seq;
04919bed948dc2 Cong Wang      2022-06-15  1626  	struct sk_buff *skb;
04919bed948dc2 Cong Wang      2022-06-15  1627  	int copied = 0;
04919bed948dc2 Cong Wang      2022-06-15  1628  
04919bed948dc2 Cong Wang      2022-06-15  1629  	if (sk->sk_state == TCP_LISTEN)
04919bed948dc2 Cong Wang      2022-06-15  1630  		return -ENOTCONN;
04919bed948dc2 Cong Wang      2022-06-15  1631  
98edede7d6d1b6 John Fastabend 2023-09-20  1632  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
db4192a754ebd5 Cong Wang      2022-09-12  1633  		u8 tcp_flags;
db4192a754ebd5 Cong Wang      2022-09-12  1634  		int used;
04919bed948dc2 Cong Wang      2022-06-15  1635  
04919bed948dc2 Cong Wang      2022-06-15  1636  		__skb_unlink(skb, &sk->sk_receive_queue);
96628951869c0d Peilin Ye      2022-09-08  1637  		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
db4192a754ebd5 Cong Wang      2022-09-12  1638  		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
db4192a754ebd5 Cong Wang      2022-09-12  1639  		used = recv_actor(sk, skb);
db4192a754ebd5 Cong Wang      2022-09-12  1640  		if (used < 0) {
db4192a754ebd5 Cong Wang      2022-09-12  1641  			if (!copied)
db4192a754ebd5 Cong Wang      2022-09-12  1642  				copied = used;
db4192a754ebd5 Cong Wang      2022-09-12  1643  			break;
db4192a754ebd5 Cong Wang      2022-09-12  1644  		}
db4192a754ebd5 Cong Wang      2022-09-12  1645  		seq += used;
db4192a754ebd5 Cong Wang      2022-09-12  1646  		copied += used;
db4192a754ebd5 Cong Wang      2022-09-12  1647  
db4192a754ebd5 Cong Wang      2022-09-12  1648  		if (tcp_flags & TCPHDR_FIN) {
04919bed948dc2 Cong Wang      2022-06-15  1649  			++seq;
db4192a754ebd5 Cong Wang      2022-09-12  1650  			break;
db4192a754ebd5 Cong Wang      2022-09-12  1651  		}
04919bed948dc2 Cong Wang      2022-06-15  1652  	}
04919bed948dc2 Cong Wang      2022-06-15  1653  	return copied;
04919bed948dc2 Cong Wang      2022-06-15  1654  }
04919bed948dc2 Cong Wang      2022-06-15  1655  EXPORT_SYMBOL(tcp_read_skb);
04919bed948dc2 Cong Wang      2022-06-15  1656  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

