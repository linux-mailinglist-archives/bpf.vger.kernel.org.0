Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D094258F174
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiHJRTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiHJRTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:19:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520087E011;
        Wed, 10 Aug 2022 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660151941; x=1691687941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmwbX+mh4uHjDwRRDXV7R/Jr/jLNCB9tPJUFhhiEExg=;
  b=i9EYUVTPX9I1oGQ97HRirb2SLIQOa4qvjDVAhy0+Y8vGH9KjMCVjuIw5
   bfvFUG3UIPn/q1xSP9vSOWt2Rd3QE2s5yk9RG6DSmvEeq6IHWvFYofMKu
   pvysSzZnuNRRi5R7gl0qCUtXx2xzoSiYksTXMQCwGIFXOTm7fNK8dd2AD
   CFmpOMGviay/QqT+naJ6nsiHyhaovtejb3zzhkfgKJF/re/cl1xKv8CU/
   2p5TLekmqIzuDJ7jms5scR0/EvUv6X18jPq694UcT0/jcVLEwi4oCKkgB
   puIV71xVc/VagJqd0uxdAOYSF+c7hT5v5sneE1HhX9Su5Qs6uEmqwmOeF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="289900449"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="289900449"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="638186837"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 10:18:57 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLpM8-0000WL-2p;
        Wed, 10 Aug 2022 17:18:56 +0000
Date:   Thu, 11 Aug 2022 01:18:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <202208110108.ilG9Ea14-lkp@intel.com>
References: <20220809094300.83116-2-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-2-hadess@hadess.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Bastien,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on balbi-usb/testing/next peter-chen-usb/for-usb-next linus/master v5.19 next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm64-randconfig-r001-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110108.ilG9Ea14-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6bd6f04e6d463be82fbf45585e4af84925bf1ab9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
        git checkout 6bd6f04e6d463be82fbf45585e4af84925bf1ab9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/core/devio.c:2649:1: warning: unused label 'out' [-Wunused-label]
   out:
   ^~~~
   1 warning generated.


vim +/out +2649 drivers/usb/core/devio.c

  2627	
  2628	int usb_revoke_for_euid(struct usb_device *udev,
  2629			int euid)
  2630	{
  2631		struct usb_dev_state *ps;
  2632	
  2633		usb_lock_device(udev);
  2634	
  2635		list_for_each_entry(ps, &udev->filelist, list) {
  2636			if (euid >= 0) {
  2637				kuid_t kuid;
  2638	
  2639				if (!ps || !ps->cred)
  2640					continue;
  2641				kuid = ps->cred->euid;
  2642				if (kuid.val != euid)
  2643					continue;
  2644			}
  2645	
  2646			usbdev_revoke(ps);
  2647		}
  2648	
> 2649	out:
  2650		usb_unlock_device(udev);
  2651		return 0;
  2652	}
  2653	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
