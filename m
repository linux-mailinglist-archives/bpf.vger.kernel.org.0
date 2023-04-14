Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336906E1CF9
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDNHL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 03:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNHL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 03:11:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7BE4B;
        Fri, 14 Apr 2023 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681456286; x=1712992286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TYSbSR6Fs9QW0UHSn/kSupaAR7Jqpb04MF8TYGHB5ec=;
  b=FhHR0u7K9i3X6JC0+iUhUWQk+d115wzNV2ApDv2YJc5GRYQIl8L6GVt4
   +p2/Fk3KEl19I41SHRFCF6P3ktwe74HyamU8BUo3tN2taCo3jYZw0pQBa
   aoRHckoRa6d0iKUn3Q0vuPKKuZziPHd6wKGQkHWlvKURq98gfVziUy2Q3
   Fe7bH5/ZwtzsvWBGJquPPAgdHI5HNE+mE7LhOLwljEbxPjEdIt92l4eL4
   +xCr3mVIFJkHTalId3DpqVy0TfjKTSOiYX4gY5x3grBrROI0peGjBehku
   DNtM0UCj2ij+/mozTJKMjmExAsvEn5NPDEsyPiAMUiI41v3hXURt+gH6p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="347117148"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="347117148"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 00:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="833437354"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="833437354"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2023 00:11:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnDaa-000ZJr-13;
        Fri, 14 Apr 2023 07:11:20 +0000
Date:   Fri, 14 Apr 2023 15:10:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "songrui.771" <songrui.771@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "songrui.771" <songrui.771@bytedance.com>
Subject: Re: [PATCH] libbpf: correct the macro KERNEL_VERSION for old kernel
Message-ID: <202304141549.j09aWR6q-lkp@intel.com>
References: <20230414045204.9748-1-songrui.771@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414045204.9748-1-songrui.771@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi songrui.771,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.3-rc6 next-20230413]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/songrui-771/libbpf-correct-the-macro-KERNEL_VERSION-for-old-kernel/20230414-125238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230414045204.9748-1-songrui.771%40bytedance.com
patch subject: [PATCH] libbpf: correct the macro KERNEL_VERSION for old kernel
reproduce:
        make versioncheck

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304141549.j09aWR6q-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-11 CC=gcc-11 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 294: need linux/version.h
>> ./tools/lib/bpf/libbpf_probes.c: 450: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 60: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
