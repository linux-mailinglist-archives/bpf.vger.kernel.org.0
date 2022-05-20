Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93652E16B
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 02:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiETAxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 20:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiETAxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 20:53:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE4132745;
        Thu, 19 May 2022 17:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653008021; x=1684544021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8C5zP7C3/VtxzfUpI1AzDUBxF7UEmMbOVc7FxUlsvLs=;
  b=VL8YXO+krgVjPc7t2XXGEJqI7duqrIIbJV1h3wKdpQtJmoXo585LvNF+
   baeB+W5Ihyt70xT/NEzeCCKt15JUt5WBFeq/4BEY0pZnoLAk/EMH6lW8g
   xXHdhK8pqg0j2JMH6aYCK9qmowf0pILtNUF0y4B0CH5AXVqr1uE4FZSyx
   BOZIj1T3NoLednOpTH+XTaFqzK+ikLNkvs4VrbA4ezcALNt0XRoU3w7hH
   dcuQQsqoeOEMI6/zaAQ6td8FZfC68MG+oteXzRsjBnxPkTFCDWh7QMJ9x
   MTWDSbL1R4VFyyungmm3uuP+KDIVUS1pEkE5Ml6duIzUQAjW7hd0D7k1W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="270022730"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="270022730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="662002149"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 17:53:38 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqtd-000465-RI;
        Fri, 20 May 2022 00:53:37 +0000
Date:   Fri, 20 May 2022 08:52:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 bpf-next 7/8] vmalloc: introduce huge_vmalloc_supported
Message-ID: <202205200826.fu46joi3-lkp@intel.com>
References: <20220519202037.2401584-8-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202037.2401584-8-song@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf_prog_pack-followup/20220520-043417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: sh-randconfig-r024-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200826.fu46joi3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f1d2b40a3e45708f74228a552a43399b20c71954
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Song-Liu/bpf_prog_pack-followup/20220520-043417
        git checkout f1d2b40a3e45708f74228a552a43399b20c71954
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/firewire/core-iso.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/firewire/core-cdev.o:include/linux/vmalloc.h:251: first defined here
--
   sh4-linux-ld: drivers/mtd/ubi/vmt.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/upd.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/build.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/cdev.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/kapi.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/eba.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/io.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/wl.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/attach.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/misc.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/mtd/ubi/debug.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/mtd/ubi/vtbl.o:include/linux/vmalloc.h:251: first defined here
--
   sh4-linux-ld: drivers/usb/gadget/function/uvc_queue.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/usb/gadget/function/f_uvc.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: drivers/usb/gadget/function/uvc_v4l2.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/usb/gadget/function/f_uvc.o:include/linux/vmalloc.h:251: first defined here
--
   sh4-linux-ld: drivers/hid/hid-picolcd_cir.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; drivers/hid/hid-picolcd_core.o:include/linux/vmalloc.h:251: first defined here
--
   sh4-linux-ld: fs/jffs2/read.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/write.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/gc.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/build.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/fs.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/super.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/compr_rtime.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/compr_zlib.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/jffs2/compr_lzo.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/jffs2/compr.o:include/linux/vmalloc.h:251: first defined here
--
   sh4-linux-ld: fs/ubifs/journal.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/file.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/dir.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/super.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/sb.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/io.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/tnc.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/master.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/scan.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/replay.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/log.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/commit.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/gc.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/orphan.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/budget.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/find.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/tnc_commit.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/compress.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/lpt.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/lprops.o: in function `huge_vmalloc_supported':
>> include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/recovery.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/ioctl.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/lpt_commit.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/tnc_misc.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/debug.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/misc.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/sysfs.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/crypto.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/xattr.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here
   sh4-linux-ld: fs/ubifs/auth.o: in function `huge_vmalloc_supported':
   include/linux/vmalloc.h:251: multiple definition of `huge_vmalloc_supported'; fs/ubifs/shrinker.o:include/linux/vmalloc.h:251: first defined here


vim +251 include/linux/vmalloc.h

   246	
   247	#else
   248	static inline void set_vm_flush_reset_perms(void *addr)
   249	{
   250	}
 > 251	bool huge_vmalloc_supported(void) { return false; }
   252	#endif
   253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
