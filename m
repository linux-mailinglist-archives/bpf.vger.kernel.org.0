Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF996D3821
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjDBNsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 09:48:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165A7DBB;
        Sun,  2 Apr 2023 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680443285; x=1711979285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8IrL2VmEc7QY4rRQiZNQOAy6BijstVun0yp4vULcF8=;
  b=j0wexA6wXbvn76SykgDQaJkJLUPdR8G70yg3Ppfqp9uMxjjesfeyHZHq
   mkYBdk9zkyqKnDoz7L0myWSJDKwELuTj6lUvFh+D/cQl8rDisJnwaA6st
   SODe8NtbFJ4GISiwC+Rhn5BvTIAKU6nnveiv7F8Qr68IYaSzZscEeVFbz
   bZ3wkevcP01CjL5BI2nppB1Tem1eLbGA+6xi33GdWlGO/MwFDsc6KrVmy
   RqWcOMxbC13zhn/XVT8X2IKBJLQxyDzQVethEWPrMcMNFS3EJOnla7qz3
   TuSIUhPwgUTT18sH2AV5QyS+D/Z0lNntBidNPF28luqgPAijQqyZfKHg+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="325731176"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="325731176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 06:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="774892544"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="774892544"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Apr 2023 06:48:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piy3t-000NQT-1O;
        Sun, 02 Apr 2023 13:48:01 +0000
Date:   Sun, 2 Apr 2023 21:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, bagasdotme@gmail.com, maxtram95@gmail.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description
 and graph
Message-ID: <202304022107.IwHc05cs-lkp@intel.com>
References: <20230401200651.1022113-2-joe@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401200651.1022113-2-joe@isovalent.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joe,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Stringer/docs-bpf-Add-LRU-internals-description-and-graph/20230402-040757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230401200651.1022113-2-joe%40isovalent.com
patch subject: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description and graph
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/0c42be421b73fffe9160867ac673ea9841982ece
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joe-Stringer/docs-bpf-Add-LRU-internals-description-and-graph/20230402-040757
        git checkout 0c42be421b73fffe9160867ac673ea9841982ece
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304022107.IwHc05cs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Orthogonal edges do not currently handle edge labels. Try using xlabels.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
