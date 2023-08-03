Return-Path: <bpf+bounces-6848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2076E9F3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFFD28212B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155D1F17F;
	Thu,  3 Aug 2023 13:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2B1F169;
	Thu,  3 Aug 2023 13:20:39 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995AF134;
	Thu,  3 Aug 2023 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691068838; x=1722604838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YxMDdwofIrNP7i680TZcMe4YpznNLpYvBUEHi/vv6ZU=;
  b=chQlEsz3YvURUnA90Upe+DKjRF8xiGFoUB8xWW+T6oLEl382w49oCFY5
   UA9YCFwHVDYEbdmETAori5GDJLoUqNXHM8bPDz/woi/yWddh/9Mz926IA
   StiuH6lNqstlQai6YQJd5AwqArQxJzV+AbeO3fnA82kGk+EtrN3/cK/VA
   bneJnEn+VOGUvgQ20Ziq3091Cr37UlKQG7Bst1f74Zgx3K0kJJFbpW2qt
   eVI3bi5V5df+J0CFktNSxOGpp07PJlu5eVbj+xDk3xnFyWSAY+v96JFK6
   XaCIQ41K0OMGTAFaBQRi8B/0KbqQBSJFYB+1s3tLTIU+KYQ09ckuhS2gK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367323726"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="367323726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="853250382"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="853250382"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2023 06:18:27 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qRYDi-00027j-1M;
	Thu, 03 Aug 2023 13:18:26 +0000
Date: Thu, 3 Aug 2023 21:17:43 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Brendan Jackman <jackmanb@chromium.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
Message-ID: <202308032054.aq4D9VOg-lkp@intel.com>
References: <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/bpf-Add-update_socket_protocol-hook/20230803-153209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang%40suse.com
patch subject: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
config: nios2-randconfig-r006-20230731 (https://download.01.org/0day-ci/archive/20230803/202308032054.aq4D9VOg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308032054.aq4D9VOg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308032054.aq4D9VOg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/socket.c:1648: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *      A hook for bpf progs to attach to and update socket protocol.


vim +1648 net/socket.c

  1646	
  1647	/**
> 1648	 *	A hook for bpf progs to attach to and update socket protocol.
  1649	 *
  1650	 *	A static noinline declaration here could cause the compiler to
  1651	 *	optimize away the function. A global noinline declaration will
  1652	 *	keep the definition, but may optimize away the callsite.
  1653	 *	Therefore, __weak is needed to ensure that the call is still
  1654	 *	emitted, by telling the compiler that we don't know what the
  1655	 *	function might eventually be.
  1656	 *
  1657	 *	__diag_* below are needed to dismiss the missing prototype warning.
  1658	 */
  1659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

