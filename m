Return-Path: <bpf+bounces-48655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA698A0AA1C
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FFD1885987
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21741B87D2;
	Sun, 12 Jan 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdQ1UcDB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA11B0F35;
	Sun, 12 Jan 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736692743; cv=none; b=jKWSAYeHY97AE9/8/9YwriwI9YlUY2+rZvBnYEKAySkNjilBpMqJHH28H0ftmM4zl8S+skutJ+r0deFlSlHpoPLHtpQtxh0H7TieSxyI9zHkgfJUlMBQEg0olZU7TE6aF4NZLM1Qx5qB4Qx1q4Yc3cV7qVaS9m3k+YlIbiBDlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736692743; c=relaxed/simple;
	bh=ExbjmQENANvuVNro49QEPjcEWrJdZJVKQIi+5LhICr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvIjHk4PJ+iiMEftb/N8CG889k0atIxwRzJKvd5ABnKcQo/14I2GnhQ/ooqYtFSHlvTEKfbkfpi2GZ42iR06irVRg+wExkpf7WSwTpiHjCuP7M6VTj1f0xgPE9CUmq4buz6n9zoEZcrUIoJVSXeJpRL1YzJAopJTez/eu9gdZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdQ1UcDB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736692741; x=1768228741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExbjmQENANvuVNro49QEPjcEWrJdZJVKQIi+5LhICr8=;
  b=FdQ1UcDB52997jNtqORBp4zaPMv3pjOJgvER12enBQIUtvBhiYbhuXwd
   mcpkV0ckoqB5W8WdUE4fvurUuc0g7yUZBJGuTXFopUTQY6gpFLqKIz1Hr
   Cz+FaUkmW7WFZsE9LrB0HbjboNZ6lbrQnmm9FnvufLN4Rb7YS405Yp8cm
   YvzE81H/NqF7KFagYKFOr12LChCVVfHM0x1wCSCgDM6rrZMOIkX6O9T8v
   PYLk2YshzoMAcRPiz2AS3lwur9TrTHk8WbBpK32+UazX60+ViUi1kcMuQ
   c2QP4Vz44WHe5f0oh5no1h4tHdvq788KoEeRRZ34p9ZqFkZfJF3r7Cf2L
   Q==;
X-CSE-ConnectionGUID: TsUKVS+dR2unxWDqqQhPLQ==
X-CSE-MsgGUID: LVGMCpCxTgqd052d5Oo9rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40604062"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="40604062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 06:39:01 -0800
X-CSE-ConnectionGUID: k3+zY7qARc+zroenPr4pnA==
X-CSE-MsgGUID: M4wP4h83Sf+99iRg88GYJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="104249844"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Jan 2025 06:38:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWz76-000M2V-1S;
	Sun, 12 Jan 2025 14:38:52 +0000
Date: Sun, 12 Jan 2025 22:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in
 some BPF calls
Message-ID: <202501122251.7G2Wsbzx-lkp@intel.com>
References: <20250112113748.73504-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112113748.73504-6-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-support-for-bpf_setsockopt/20250112-194115
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250112113748.73504-6-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v5 05/15] net-timestamp: add strict check in some BPF calls
config: i386-buildonly-randconfig-006-20250112 (https://download.01.org/0day-ci/archive/20250112/202501122251.7G2Wsbzx-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501122251.7G2Wsbzx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501122251.7G2Wsbzx-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4863:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4863 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4891:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4891 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5063:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5063 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5077:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5077 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5126:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5126 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:5592:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5592 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5626:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5626 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5660:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5660 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5703:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5703 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5880:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5880 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6417:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6417 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6429:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6429 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6515:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6515 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6525:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6525 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6569:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6569 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6658:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6658 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6902:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6902 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6921:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6921 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6940:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6940 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6964:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6964 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6988:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6988 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7012:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7012 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7029:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7029 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | OBJ_RELEASE,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   net/core/filter.c:7050:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7050 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7074:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7074 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7098:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7098 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7118:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7118 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7137:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7137 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7156:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7156 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7474:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7474 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7476:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7476 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7543:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7543 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7545:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7545 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>> net/core/filter.c:7631:19: warning: result of comparison of constant 'SK_BPF_CB_FLAGS' (1009) with expression of type 'u8' (aka 'unsigned char') is always true [-Wtautological-constant-out-of-range-compare]
    7631 |         if (bpf_sock->op != SK_BPF_CB_FLAGS)
         |             ~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   net/core/filter.c:7777:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7777 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   41 warnings generated.


vim +7631 net/core/filter.c

  7622	
  7623	BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
  7624		   void *, search_res, u32, len, u64, flags)
  7625	{
  7626		bool eol, load_syn = flags & BPF_LOAD_HDR_OPT_TCP_SYN;
  7627		const u8 *op, *opend, *magic, *search = search_res;
  7628		u8 search_kind, search_len, copy_len, magic_len;
  7629		int ret;
  7630	
> 7631		if (bpf_sock->op != SK_BPF_CB_FLAGS)
  7632			return -EINVAL;
  7633	
  7634		/* 2 byte is the minimal option len except TCPOPT_NOP and
  7635		 * TCPOPT_EOL which are useless for the bpf prog to learn
  7636		 * and this helper disallow loading them also.
  7637		 */
  7638		if (len < 2 || flags & ~BPF_LOAD_HDR_OPT_TCP_SYN)
  7639			return -EINVAL;
  7640	
  7641		search_kind = search[0];
  7642		search_len = search[1];
  7643	
  7644		if (search_len > len || search_kind == TCPOPT_NOP ||
  7645		    search_kind == TCPOPT_EOL)
  7646			return -EINVAL;
  7647	
  7648		if (search_kind == TCPOPT_EXP || search_kind == 253) {
  7649			/* 16 or 32 bit magic.  +2 for kind and kind length */
  7650			if (search_len != 4 && search_len != 6)
  7651				return -EINVAL;
  7652			magic = &search[2];
  7653			magic_len = search_len - 2;
  7654		} else {
  7655			if (search_len)
  7656				return -EINVAL;
  7657			magic = NULL;
  7658			magic_len = 0;
  7659		}
  7660	
  7661		if (load_syn) {
  7662			ret = bpf_sock_ops_get_syn(bpf_sock, TCP_BPF_SYN, &op);
  7663			if (ret < 0)
  7664				return ret;
  7665	
  7666			opend = op + ret;
  7667			op += sizeof(struct tcphdr);
  7668		} else {
  7669			if (!bpf_sock->skb ||
  7670			    bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB)
  7671				/* This bpf_sock->op cannot call this helper */
  7672				return -EPERM;
  7673	
  7674			opend = bpf_sock->skb_data_end;
  7675			op = bpf_sock->skb->data + sizeof(struct tcphdr);
  7676		}
  7677	
  7678		op = bpf_search_tcp_opt(op, opend, search_kind, magic, magic_len,
  7679					&eol);
  7680		if (IS_ERR(op))
  7681			return PTR_ERR(op);
  7682	
  7683		copy_len = op[1];
  7684		ret = copy_len;
  7685		if (copy_len > len) {
  7686			ret = -ENOSPC;
  7687			copy_len = len;
  7688		}
  7689	
  7690		memcpy(search_res, op, copy_len);
  7691		return ret;
  7692	}
  7693	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

