Return-Path: <bpf+bounces-41160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27089993939
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836DCB2299E
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B218C02F;
	Mon,  7 Oct 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUSPJ0NS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD028EA
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336863; cv=none; b=PdxXXIoxUtX8Px8/cVAe8dKbCOSltbr+gvmEx+G8V4cYFLDuZd9O/2ifaHgwyxZHyG7+BsmKzmNKoqAHW/ImyVsFvG5hGVuPfq0P5QWePSiTS/EQn7AoMdhTu8hLtf9zB97VJoiyMz9flVJE4z10fwV4QlFCkB5BkUEt0NDgpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336863; c=relaxed/simple;
	bh=uaMyzD5C3CI/9OcpCdVnuv2C2597Tnofy/2xheO+Pks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaekMc0YHa+Aet2yI/76Ua6/0spBpOUGiXCpAqEShGX6gd7VXR2FSfVDetf38KD73DtmwTboseULIPxM869jThlGJWW2PeMOIepR0oxWJbcLPQCCDsl9/ZVm9VcAcFvRCgy9WBALxq27vC8ZRYFI52HCc6YjiLimFckvROkycrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUSPJ0NS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728336860; x=1759872860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uaMyzD5C3CI/9OcpCdVnuv2C2597Tnofy/2xheO+Pks=;
  b=jUSPJ0NSZP4qaD7Ya/RLXR+NPRuxWfTkUX0r8fiR+5bRsyleafK9qN8E
   Bpqn4+rpRzSEGGEWuOvwhWNj4yorPcZaQoxXrKHBt4GOEi8sAnkOo26Rh
   1XKTDRukuRnKMOiku/dtfD3l3RgyzFwHnzKFpUC7Nl7vH2G3vmULQVtBx
   vykmNkQUryQbxQYCO7I5j3Bc/03K+/0lugGjKMpWigKqOpvFOIATF6Pot
   f1KaWSmVf02Cto8kmQZ083lw5XhshBPUp6zAKItw2MQT+ICP8fa/GigCB
   ECiGNFldgspOeTPF7AA4OR7BTPaaTjJGUB5Gal7WWs0xMIYRIqckUgvFn
   A==;
X-CSE-ConnectionGUID: JBl3Ni5AQqqUoNLspSS9+g==
X-CSE-MsgGUID: ZOJcWZNJQLuKjNwFj9XRqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27384891"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27384891"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 14:34:19 -0700
X-CSE-ConnectionGUID: onf92s/HQOCVUb6mTfg6oA==
X-CSE-MsgGUID: LsWpRk82S5Oc3AIFcNg59Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75608247"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Oct 2024 14:34:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxvMs-0005YQ-0H;
	Mon, 07 Oct 2024 21:34:14 +0000
Date: Tue, 8 Oct 2024 05:33:43 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, toke@redhat.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, puranjay@kernel.org,
	xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
	leon.hwang@linux.dev, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
Message-ID: <202410080522.O8nxCK2v-lkp@intel.com>
References: <20241006130130.77125-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006130130.77125-2-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Prevent-tailcall-infinite-loop-caused-by-freplace/20241006-210309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241006130130.77125-2-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop caused by freplace
config: powerpc64-randconfig-r071-20241008 (https://download.01.org/0day-ci/archive/20241008/202410080522.O8nxCK2v-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080522.O8nxCK2v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080522.O8nxCK2v-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from init/main.c:21:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf.h:1398:5: warning: no previous prototype for 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/workqueue.h:132,
                    from kernel/workqueue.c:531:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf.h:1398:5: warning: no previous prototype for 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/workqueue.c: In function '__alloc_workqueue':
   kernel/workqueue.c:5665:9: warning: function '__alloc_workqueue' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    5665 |         name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
         |         ^~~~~~~~
--
   In file included from include/linux/security.h:35,
                    from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:102,
                    from include/net/addrconf.h:65,
                    from lib/vsprintf.c:41:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf.h:1398:5: warning: no previous prototype for 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/time/hrtimer.c:30:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf.h:1398:5: warning: no previous prototype for 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:124:35: warning: initialized field overwritten [-Woverride-init]
     124 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:124:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
--
   powerpc64-linux-ld: drivers/char/tpm/eventlog/tpm1.o: in function `bpf_extension_link_prog':
>> tpm1.c:(.text+0x494): multiple definition of `bpf_extension_link_prog'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0x130): first defined here
   powerpc64-linux-ld: drivers/char/tpm/eventlog/tpm1.o: in function `bpf_extension_unlink_prog':
>> tpm1.c:(.text+0x4a4): multiple definition of `bpf_extension_unlink_prog'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0x140): first defined here
   powerpc64-linux-ld: drivers/char/tpm/eventlog/tpm2.o: in function `bpf_extension_link_prog':
   tpm2.c:(.text+0x3d0): multiple definition of `bpf_extension_link_prog'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0x130): first defined here
   powerpc64-linux-ld: drivers/char/tpm/eventlog/tpm2.o: in function `bpf_extension_unlink_prog':
   tpm2.c:(.text+0x3e0): multiple definition of `bpf_extension_unlink_prog'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0x140): first defined here
--
   powerpc64-linux-ld: drivers/i2c/i2c-core-smbus.o: in function `bpf_extension_link_prog':
>> i2c-core-smbus.c:(.text+0x1d40): multiple definition of `bpf_extension_link_prog'; drivers/i2c/i2c-core-base.o:i2c-core-base.c:(.text+0x3e60): first defined here
   powerpc64-linux-ld: drivers/i2c/i2c-core-smbus.o: in function `bpf_extension_unlink_prog':
>> i2c-core-smbus.c:(.text+0x1d50): multiple definition of `bpf_extension_unlink_prog'; drivers/i2c/i2c-core-base.o:i2c-core-base.c:(.text+0x3e70): first defined here
   powerpc64-linux-ld: drivers/i2c/i2c-core-slave.o: in function `bpf_extension_link_prog':
   i2c-core-slave.c:(.text+0x73c): multiple definition of `bpf_extension_link_prog'; drivers/i2c/i2c-core-base.o:i2c-core-base.c:(.text+0x3e60): first defined here
   powerpc64-linux-ld: drivers/i2c/i2c-core-slave.o: in function `bpf_extension_unlink_prog':
   i2c-core-slave.c:(.text+0x74c): multiple definition of `bpf_extension_unlink_prog'; drivers/i2c/i2c-core-base.o:i2c-core-base.c:(.text+0x3e70): first defined here
--
   powerpc64-linux-ld: drivers/scsi/snic/snic_main.o: in function `bpf_extension_link_prog':
>> snic_main.c:(.text+0x234): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_main.o: in function `bpf_extension_unlink_prog':
>> snic_main.c:(.text+0x244): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_res.o: in function `bpf_extension_link_prog':
   snic_res.c:(.text+0x0): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_res.o: in function `bpf_extension_unlink_prog':
   snic_res.c:(.text+0x10): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_isr.o: in function `bpf_extension_link_prog':
   snic_isr.c:(.text+0x1ec): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_isr.o: in function `bpf_extension_unlink_prog':
   snic_isr.c:(.text+0x1fc): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_ctl.o: in function `bpf_extension_link_prog':
   snic_ctl.c:(.text+0x0): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_ctl.o: in function `bpf_extension_unlink_prog':
   snic_ctl.c:(.text+0x10): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_io.o: in function `bpf_extension_link_prog':
   snic_io.c:(.text+0x310): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_io.o: in function `bpf_extension_unlink_prog':
   snic_io.c:(.text+0x320): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_scsi.o: in function `bpf_extension_link_prog':
   snic_scsi.c:(.text+0x3dfc): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_scsi.o: in function `bpf_extension_unlink_prog':
   snic_scsi.c:(.text+0x3e0c): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_disc.o: in function `bpf_extension_link_prog':
   snic_disc.c:(.text+0xbf8): multiple definition of `bpf_extension_link_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1d4): first defined here
   powerpc64-linux-ld: drivers/scsi/snic/snic_disc.o: in function `bpf_extension_unlink_prog':
   snic_disc.c:(.text+0xc08): multiple definition of `bpf_extension_unlink_prog'; drivers/scsi/snic/snic_attrs.o:snic_attrs.c:(.text+0x1e4): first defined here
--
   powerpc64-linux-ld: fs/ext2/xattr.o: in function `bpf_extension_link_prog':
>> xattr.c:(.text+0xd24): multiple definition of `bpf_extension_link_prog'; fs/ext2/trace.o:trace.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: fs/ext2/xattr.o: in function `bpf_extension_unlink_prog':
>> xattr.c:(.text+0xd34): multiple definition of `bpf_extension_unlink_prog'; fs/ext2/trace.o:trace.c:(.text+0x7d0): first defined here
   powerpc64-linux-ld: fs/ext2/xattr_security.o: in function `bpf_extension_link_prog':
   xattr_security.c:(.text+0xdc): multiple definition of `bpf_extension_link_prog'; fs/ext2/trace.o:trace.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: fs/ext2/xattr_security.o: in function `bpf_extension_unlink_prog':
   xattr_security.c:(.text+0xec): multiple definition of `bpf_extension_unlink_prog'; fs/ext2/trace.o:trace.c:(.text+0x7d0): first defined here
--
   powerpc64-linux-ld: drivers/nvdimm/bus.o: in function `bpf_extension_link_prog':
>> bus.c:(.text+0x1384): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/bus.o: in function `bpf_extension_unlink_prog':
>> bus.c:(.text+0x1394): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/dimm_devs.o: in function `bpf_extension_link_prog':
   dimm_devs.c:(.text+0x12c0): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/dimm_devs.o: in function `bpf_extension_unlink_prog':
   dimm_devs.c:(.text+0x12d0): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/dimm.o: in function `bpf_extension_link_prog':
   dimm.c:(.text+0x2d0): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/dimm.o: in function `bpf_extension_unlink_prog':
   dimm.c:(.text+0x2e0): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/region_devs.o: in function `bpf_extension_link_prog':
   region_devs.c:(.text+0x1388): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/region_devs.o: in function `bpf_extension_unlink_prog':
   region_devs.c:(.text+0x1398): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/region.o: in function `bpf_extension_link_prog':
   region.c:(.text+0x3d4): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/region.o: in function `bpf_extension_unlink_prog':
   region.c:(.text+0x3e4): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/namespace_devs.o: in function `bpf_extension_link_prog':
   namespace_devs.c:(.text+0x2efc): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/namespace_devs.o: in function `bpf_extension_unlink_prog':
   namespace_devs.c:(.text+0x2f0c): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/label.o: in function `bpf_extension_link_prog':
   label.c:(.text+0x324): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/label.o: in function `bpf_extension_unlink_prog':
   label.c:(.text+0x334): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/badrange.o: in function `bpf_extension_link_prog':
   badrange.c:(.text+0x674): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/badrange.o: in function `bpf_extension_unlink_prog':
   badrange.c:(.text+0x684): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/claim.o: in function `bpf_extension_link_prog':
   claim.c:(.text+0x380): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/claim.o: in function `bpf_extension_unlink_prog':
   claim.c:(.text+0x390): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/btt_devs.o: in function `bpf_extension_link_prog':
   btt_devs.c:(.text+0xb24): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/btt_devs.o: in function `bpf_extension_unlink_prog':
   btt_devs.c:(.text+0xb34): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
   powerpc64-linux-ld: drivers/nvdimm/security.o: in function `bpf_extension_link_prog':
   security.c:(.text+0x4c0): multiple definition of `bpf_extension_link_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe48): first defined here
   powerpc64-linux-ld: drivers/nvdimm/security.o: in function `bpf_extension_unlink_prog':
   security.c:(.text+0x4d0): multiple definition of `bpf_extension_unlink_prog'; drivers/nvdimm/core.o:core.c:(.text+0xe58): first defined here
--
   powerpc64-linux-ld: drivers/pcmcia/cistpl.o: in function `bpf_extension_link_prog':
>> cistpl.c:(.text+0x1430): multiple definition of `bpf_extension_link_prog'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0xec0): first defined here
   powerpc64-linux-ld: drivers/pcmcia/cistpl.o: in function `bpf_extension_unlink_prog':
>> cistpl.c:(.text+0x1440): multiple definition of `bpf_extension_unlink_prog'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0xed0): first defined here
   powerpc64-linux-ld: drivers/pcmcia/pcmcia_cis.o: in function `bpf_extension_link_prog':
   pcmcia_cis.c:(.text+0x718): multiple definition of `bpf_extension_link_prog'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0xec0): first defined here
   powerpc64-linux-ld: drivers/pcmcia/pcmcia_cis.o: in function `bpf_extension_unlink_prog':
   pcmcia_cis.c:(.text+0x728): multiple definition of `bpf_extension_unlink_prog'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0xed0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

