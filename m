Return-Path: <bpf+bounces-1729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C826072095E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8263E281AD6
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D41DDD2;
	Fri,  2 Jun 2023 18:47:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7833302
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:47:59 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E151A5;
	Fri,  2 Jun 2023 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685731677; x=1717267677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOtDdfsc2P2CR837OFCfK8rZd7DNtGjRdjWJhX8MhDI=;
  b=m5Z6I6HxVFUV1Yp5WdNT9ghCRLpaSbcSeLKcy7CEAed7NcyKf0n6FMa0
   lnDztt3z058ngK/gI8xQRvNq4oIfdxaExyYcvQ2YB4LKHXYkoCD/b4adK
   P1GAuxmInznEmPrzLnLGuaB4+pfyjqEkEbioKOhKU3d3L620xqqXFFjkC
   PYoBC/eHHbrkAvtpR+YiyAekmCcYTQ9IJ7jq81WMG4rAhI2sEoSDwg9f+
   hd2eMfWq4LSAzq4Iip0VlffFLVZIt+YJPW07SdWxm75++v4rzbBw6W/Mu
   hT06mAWD8RJWiblsqOOo7BCJOcTkYXVJBkg9WAJ1s/FnSNOfYb8lhBs8B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335553728"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="335553728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="797690951"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="797690951"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2023 11:47:54 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q59oX-0000q1-3D;
	Fri, 02 Jun 2023 18:47:53 +0000
Date: Sat, 3 Jun 2023 02:46:59 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
	cyphar@cyphar.com, luto@kernel.org
Subject: Re: [PATCH RESEND bpf-next 15/18] bpf: take into account BPF token
 when fetching helper protos
Message-ID: <202306030252.UOXkWZTK-lkp@intel.com>
References: <20230602150011.1657856-16-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602150011.1657856-16-andrii@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230602150011.1657856-16-andrii%40kernel.org
patch subject: [PATCH RESEND bpf-next 15/18] bpf: take into account BPF token when fetching helper protos
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230603/202306030252.UOXkWZTK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3d830ca845b075ab4132487aaaa69b70a467863c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
        git checkout 3d830ca845b075ab4132487aaaa69b70a467863c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030252.UOXkWZTK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bpf_verifier.h:7,
                    from net/core/filter.c:21:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
   include/linux/bpf.h:2475:16: warning: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Wint-conversion]
    2475 |         return -EOPNOTSUPP;
         |                ^
   net/core/filter.c: In function 'bpf_sk_base_func_proto':
>> net/core/filter.c:11653:14: error: implicit declaration of function 'bpf_token_capable'; did you mean 'bpf_token_put'? [-Werror=implicit-function-declaration]
   11653 |         if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
         |              ^~~~~~~~~~~~~~~~~
         |              bpf_token_put
   cc1: some warnings being treated as errors


vim +11653 net/core/filter.c

 11619	
 11620	static const struct bpf_func_proto *
 11621	bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 11622	{
 11623		const struct bpf_func_proto *func;
 11624	
 11625		switch (func_id) {
 11626		case BPF_FUNC_skc_to_tcp6_sock:
 11627			func = &bpf_skc_to_tcp6_sock_proto;
 11628			break;
 11629		case BPF_FUNC_skc_to_tcp_sock:
 11630			func = &bpf_skc_to_tcp_sock_proto;
 11631			break;
 11632		case BPF_FUNC_skc_to_tcp_timewait_sock:
 11633			func = &bpf_skc_to_tcp_timewait_sock_proto;
 11634			break;
 11635		case BPF_FUNC_skc_to_tcp_request_sock:
 11636			func = &bpf_skc_to_tcp_request_sock_proto;
 11637			break;
 11638		case BPF_FUNC_skc_to_udp6_sock:
 11639			func = &bpf_skc_to_udp6_sock_proto;
 11640			break;
 11641		case BPF_FUNC_skc_to_unix_sock:
 11642			func = &bpf_skc_to_unix_sock_proto;
 11643			break;
 11644		case BPF_FUNC_skc_to_mptcp_sock:
 11645			func = &bpf_skc_to_mptcp_sock_proto;
 11646			break;
 11647		case BPF_FUNC_ktime_get_coarse_ns:
 11648			return &bpf_ktime_get_coarse_ns_proto;
 11649		default:
 11650			return bpf_base_func_proto(func_id, prog);
 11651		}
 11652	
 11653		if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 11654			return NULL;
 11655	
 11656		return func;
 11657	}
 11658	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

