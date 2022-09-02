Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D95AB95E
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIBUS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBUSZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 16:18:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64FF0779
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662149904; x=1693685904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7vsQj12ut9zMOv/30A2helBXPdrzne8MM0lkuf6Et8=;
  b=cj07SZoCP+bydHMn0BCktHAWLPMO0phXULS4X5sJEKAoBPpEhOmKcjUm
   0iZUaWSkYgUX861fyRD3NrskFGnrPTHziF+k8CMfpFCbgT64OCETumWex
   RPPeZoSKmBr+08yM7oT/zx4ps0OzB/zJ1RADE2vDZaBzORRcPigk3mZR6
   QT0mUIINWN8XiI+91L9nJZ4fq1eByTqzm9CtnuDD1UAxJrT9+5tHYH4yV
   Y5CL+v28RxUaw5iB9GXfqp4q1MRnewgiaJNr8v1L3RFdp5G6XpI5OhQPm
   lgnl7TFSDaduEjrnprYinlbwlnPrK+X3EzzSz5TBNEVKb0EF9GfNahaIp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297371364"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="297371364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 13:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="643046135"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2022 13:18:21 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUD7M-0000ZX-1W;
        Fri, 02 Sep 2022 20:18:20 +0000
Date:   Sat, 3 Sep 2022 04:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harsh Modi <harshmodi@google.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, harshmodi@google.com, sdf@google.com,
        ast@kernel.org, haoluo@google.com, joannelkoong@gmail.com,
        quentin@isovalent.com, joe@cilium.io
Subject: Re: [PATCH bpf-next] bpf: Add bpf_[skb|xdp]_packet_hash.
Message-ID: <202209030436.cVQGH3xQ-lkp@intel.com>
References: <20220831233615.2288256-1-harshmodi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831233615.2288256-1-harshmodi@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Harsh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Harsh-Modi/bpf-Add-bpf_-skb-xdp-_packet_hash/20220901-073646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220903/202209030436.cVQGH3xQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/078b031d06a73f3fc17333d808db554ec4753a90
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Harsh-Modi/bpf-Add-bpf_-skb-xdp-_packet_hash/20220901-073646
        git checkout 078b031d06a73f3fc17333d808db554ec4753a90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: net/core/filter.o: in function `crc32c_csum_update':
>> filter.c:(.text+0x61fd): undefined reference to `crc32c'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
