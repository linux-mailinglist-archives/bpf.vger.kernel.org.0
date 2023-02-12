Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42AC693B0E
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 00:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBLXVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 18:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBLXVI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 18:21:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45510262
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676244059; x=1707780059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7b9YyBHcRUPxz/axnNKKkMFESVIYOC0Hbm4TQUMW04=;
  b=Ka+LbNaT6or1Zb6zIqMY0PEp0rhrpJ56pybGLnYOKb2ZDTj8vfiQQ2JW
   pdGFBG2GA8KlBIn9pAqKtSSEGKo8VwBnkDYNAW/KmYXQyZX5G2uTuPACF
   EERF+lRsPVdub4WULI5BTCCcSAyJVoURTPoxwkF+aL6CvPs/4qpIGuH7D
   +LwugWewy+WlC1CD086+ce8ktln5c5Lov3ai2wPR8YCThBoMWlg1Vypz9
   X62+ddHV8BFE75su3BlAAF2pTL4HQjLXWQeVY0sG+1Ja7jaoyQbEYUnID
   NDiRPNXBQ8pPxCsL+XFqRYB+bCNVDupzP2AuKrBC2GcXwzI/MOJNugmVx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="314411539"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="314411539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 15:20:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="811402585"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="811402585"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2023 15:20:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRLeS-0007Qb-1l;
        Sun, 12 Feb 2023 23:20:56 +0000
Date:   Mon, 13 Feb 2023 07:20:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH bpf-next v2] bpf, docs: Explain helper functions
Message-ID: <202302130706.NBSii5FS-lkp@intel.com>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206191647.2075-1-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Thaler/bpf-docs-Explain-helper-functions/20230207-031845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230206191647.2075-1-dthaler1968%40googlemail.com
patch subject: [PATCH bpf-next v2] bpf, docs: Explain helper functions
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/b579d93fed53b16ad7241911226cbeb3b42f8266
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Thaler/bpf-docs-Explain-helper-functions/20230207-031845
        git checkout b579d93fed53b16ad7241911226cbeb3b42f8266
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302130706.NBSii5FS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/bpf/clang-notes.rst:24: WARNING: Title underline too short.

vim +24 Documentation/bpf/clang-notes.rst

    22	
    23	Reserved instructions
  > 24	====================
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
