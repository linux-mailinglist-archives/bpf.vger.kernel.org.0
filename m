Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC45AB5C4
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiIBPyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiIBPxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 11:53:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF38E9BC
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662133683; x=1693669683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4Fakjhd+ZOAe94994E9Pm8XSTFIaUB+EYRAUfZFuok=;
  b=TPOTR4vOh5Auc7Iwmecqd6x/yipwzV509AoXr0C+/TS636ickzTH4C//
   fRaWMfpuhYK+V+iF/QZLrOoA8Kp/D6k80nfc7Ikauz0H0ct+VYdjO1mrC
   ddZ5+CwvErKARS84NTw0Ubq5eAhI6ZR5iSjIxiU7aPhmdSUF7wNDc7kEq
   vYYFkTRzA8HvgfHSSbv0m2U17UEw8MJ75rZSZwNIpqiC/jxS6xs24I0N3
   g3uc7nu02f/hCdZ8BjtC4hJzfVaA8uZFNEy5glIwajCjbRvM42l/TX6gE
   Wa2cAaG9XPuQWjVn8sj/K84wd4QQG7zej8kc7JF0PGZSI5BTo+PPyephv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="322166572"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="322166572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 08:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="755295073"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2022 08:48:00 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU8tj-0000Fs-2G;
        Fri, 02 Sep 2022 15:47:59 +0000
Date:   Fri, 2 Sep 2022 23:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harsh Modi <harshmodi@google.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        harshmodi@google.com, sdf@google.com, ast@kernel.org,
        haoluo@google.com, joannelkoong@gmail.com, quentin@isovalent.com,
        joe@cilium.io
Subject: Re: [PATCH bpf-next] bpf: Add bpf_[skb|xdp]_packet_hash.
Message-ID: <202209022355.SbJhZF5b-lkp@intel.com>
References: <20220831233615.2288256-1-harshmodi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831233615.2288256-1-harshmodi@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220902/202209022355.SbJhZF5b-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/078b031d06a73f3fc17333d808db554ec4753a90
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Harsh-Modi/bpf-Add-bpf_-skb-xdp-_packet_hash/20220901-073646
        git checkout 078b031d06a73f3fc17333d808db554ec4753a90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: crc32c
   >>> referenced by filter.c
   >>>               core/filter.o:(crc32c_csum_update) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
