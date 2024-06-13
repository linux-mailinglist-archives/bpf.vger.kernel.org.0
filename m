Return-Path: <bpf+bounces-32020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A269061A7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A057B281D1C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337D4BAA6;
	Thu, 13 Jun 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxD8b5rX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6CBA39;
	Thu, 13 Jun 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245055; cv=none; b=apsx283bIeM/vlFK2NkJTozxpiNMNwdO3VPxq0fgA+EaNdV0mhQNupUwnX/xXTvW4oTISnbm8xwAixp79ohByFsOlf7Q3YuGT77sp0kBGltiZMHCMRDfcBhSVxNtd8ls4ax8tZ7rXe7gD3KJkMhbeZVnypZ/aRcF0mYbZZv/7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245055; c=relaxed/simple;
	bh=dNcRgajM1ThTufvj2ufbyUHlHy7G1SnZCaO8/oTcorU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rks1bys0mxtN9hbNSfdiSMaUqr4VtHSbKWwSBACmye7EIu36J1BOsx5w0zuJO1nvOPufPaY7yN5fQkEw3o1DQ97moEoXVcIQxbLTfB8Mxr3KawJqSbo3izLVKnigZUW5LAclju8V5vL9mSzc0z09aYI4qBZo0pUgH4lK/h/0Dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxD8b5rX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718245053; x=1749781053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNcRgajM1ThTufvj2ufbyUHlHy7G1SnZCaO8/oTcorU=;
  b=jxD8b5rX2jdI8Wl0H2bynMWYlBmx5JtpnJy5t/xFO8UG2YD8EEys53iG
   POaqQtOuM5Ov8XVYYMbmkY/3aR1q6CrbaKMLRes6GV4+Ljhk/60ZlJeGC
   bHwDMXBA9KJ5TIUhu+UBmomiyXaLwiYxnVey9BEz3TTQL62X73egU1J+r
   SEWUcBDW6B/RjnmU/X2w12Z273wWe9Nt17xae/ob/D7+Zlig70mS0IImj
   Xj6qjpHdXuIMrO5mOH5MjvS55iiEUhNrPtA2ptuenvAReM2w26saiJtD+
   FWAvjvTi7VRABX0sJsEiuzUs1lS3esmHGHoJ/DBwPSNHM1Nq0x1VT7+gI
   Q==;
X-CSE-ConnectionGUID: YOAAwucHTnyY/SrbUpx0/w==
X-CSE-MsgGUID: SCRVzx3pRdqx4Coq5cs+JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32525507"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32525507"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 19:17:33 -0700
X-CSE-ConnectionGUID: Wd6ciDiNRgWjwlBSzg6UEA==
X-CSE-MsgGUID: ZU5P9ltWRm+Gd7EDwPgqhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40451870"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2024 19:17:26 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHa1j-00027W-21;
	Thu, 13 Jun 2024 02:17:23 +0000
Date: Thu, 13 Jun 2024 10:16:48 +0800
From: kernel test robot <lkp@intel.com>
To: kunyu <kunyu@nfschina.com>, davem@davemloft.net, dsahern@kernel.org,
	udknight@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] x86: net: bpf_jit_comp32: Remove unused 'cnt' variables
 from most functions
Message-ID: <202406130900.iANs9YtU-lkp@intel.com>
References: <20240612085823.28133-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085823.28133-1-kunyu@nfschina.com>

Hi kunyu,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master net-next/main net/main linus/master v6.10-rc3 next-20240612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kunyu/x86-net-bpf_jit_comp32-Remove-unused-cnt-variables-from-most-functions/20240612-170017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240612085823.28133-1-kunyu%40nfschina.com
patch subject: [PATCH] x86: net: bpf_jit_comp32: Remove unused 'cnt' variables from most functions
config: i386-buildonly-randconfig-004-20240613 (https://download.01.org/0day-ci/archive/20240613/202406130900.iANs9YtU-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240613/202406130900.iANs9YtU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406130900.iANs9YtU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/net/bpf_jit_comp32.c:214:4: error: use of undeclared identifier 'cnt'
     214 |                         EMIT2(0x33, add_2reg(0xC0, IA32_EAX, IA32_EAX));
         |                         ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: expanded from macro 'EMIT2'
      68 | #define EMIT2(b1, b2)           EMIT((b1) + ((b2) << 8), 2)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:216:4: error: use of undeclared identifier 'cnt'
     216 |                         EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
         |                         ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: expanded from macro 'EMIT3'
      69 | #define EMIT3(b1, b2, b3)       EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:219:4: error: use of undeclared identifier 'cnt'
     219 |                         EMIT3_off32(0xC7, add_1reg(0x40, IA32_EBP),
         |                         ^
   arch/x86/net/bpf_jit_comp32.c:78:7: note: expanded from macro 'EMIT3_off32'
      78 |         do { EMIT3(b1, b2, b3); EMIT(off, 4); } while (0)
         |              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: expanded from macro 'EMIT3'
      69 | #define EMIT3(b1, b2, b3)       EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:219:4: error: use of undeclared identifier 'cnt'
   arch/x86/net/bpf_jit_comp32.c:78:26: note: expanded from macro 'EMIT3_off32'
      78 |         do { EMIT3(b1, b2, b3); EMIT(off, 4); } while (0)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:224:4: error: use of undeclared identifier 'cnt'
     224 |                         EMIT2(0x33, add_2reg(0xC0, dst, dst));
         |                         ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: expanded from macro 'EMIT2'
      68 | #define EMIT2(b1, b2)           EMIT((b1) + ((b2) << 8), 2)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:226:4: error: use of undeclared identifier 'cnt'
     226 |                         EMIT2_off32(0xC7, add_1reg(0xC0, dst),
         |                         ^
   arch/x86/net/bpf_jit_comp32.c:76:7: note: expanded from macro 'EMIT2_off32'
      76 |         do { EMIT2(b1, b2); EMIT(off, 4); } while (0)
         |              ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: expanded from macro 'EMIT2'
      68 | #define EMIT2(b1, b2)           EMIT((b1) + ((b2) << 8), 2)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:226:4: error: use of undeclared identifier 'cnt'
   arch/x86/net/bpf_jit_comp32.c:76:22: note: expanded from macro 'EMIT2_off32'
      76 |         do { EMIT2(b1, b2); EMIT(off, 4); } while (0)
         |                             ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:241:3: error: use of undeclared identifier 'cnt'
     241 |                 EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(src));
         |                 ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: expanded from macro 'EMIT3'
      69 | #define EMIT3(b1, b2, b3)       EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:244:3: error: use of undeclared identifier 'cnt'
     244 |                 EMIT3(0x89, add_2reg(0x40, IA32_EBP, sreg), STACK_VAR(dst));
         |                 ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: expanded from macro 'EMIT3'
      69 | #define EMIT3(b1, b2, b3)       EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:247:3: error: use of undeclared identifier 'cnt'
     247 |                 EMIT2(0x89, add_2reg(0xC0, dst, sreg));
         |                 ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: expanded from macro 'EMIT2'
      68 | #define EMIT2(b1, b2)           EMIT((b1) + ((b2) << 8), 2)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^
   arch/x86/net/bpf_jit_comp32.c:291:3: error: use of undeclared identifier 'cnt'
     291 |                 EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src));
         |                 ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: expanded from macro 'EMIT3'
      69 | #define EMIT3(b1, b2, b3)       EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
         |                                 ^
   arch/x86/net/bpf_jit_comp32.c:65:43: note: expanded from macro 'EMIT'
      65 |         do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
         |                                                  ^


vim +/cnt +214 arch/x86/net/bpf_jit_comp32.c

03f5781be2c7b7 Wang YanQing 2018-05-03  205  
03f5781be2c7b7 Wang YanQing 2018-05-03  206  static inline void emit_ia32_mov_i(const u8 dst, const u32 val, bool dstk,
03f5781be2c7b7 Wang YanQing 2018-05-03  207  				   u8 **pprog)
03f5781be2c7b7 Wang YanQing 2018-05-03  208  {
03f5781be2c7b7 Wang YanQing 2018-05-03  209  	u8 *prog = *pprog;
03f5781be2c7b7 Wang YanQing 2018-05-03  210  
03f5781be2c7b7 Wang YanQing 2018-05-03  211  	if (dstk) {
03f5781be2c7b7 Wang YanQing 2018-05-03  212  		if (val == 0) {
03f5781be2c7b7 Wang YanQing 2018-05-03  213  			/* xor eax,eax */
03f5781be2c7b7 Wang YanQing 2018-05-03 @214  			EMIT2(0x33, add_2reg(0xC0, IA32_EAX, IA32_EAX));
03f5781be2c7b7 Wang YanQing 2018-05-03  215  			/* mov dword ptr [ebp+off],eax */
03f5781be2c7b7 Wang YanQing 2018-05-03  216  			EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
03f5781be2c7b7 Wang YanQing 2018-05-03  217  			      STACK_VAR(dst));
03f5781be2c7b7 Wang YanQing 2018-05-03  218  		} else {
03f5781be2c7b7 Wang YanQing 2018-05-03  219  			EMIT3_off32(0xC7, add_1reg(0x40, IA32_EBP),
03f5781be2c7b7 Wang YanQing 2018-05-03  220  				    STACK_VAR(dst), val);
03f5781be2c7b7 Wang YanQing 2018-05-03  221  		}
03f5781be2c7b7 Wang YanQing 2018-05-03  222  	} else {
03f5781be2c7b7 Wang YanQing 2018-05-03  223  		if (val == 0)
03f5781be2c7b7 Wang YanQing 2018-05-03  224  			EMIT2(0x33, add_2reg(0xC0, dst, dst));
03f5781be2c7b7 Wang YanQing 2018-05-03  225  		else
03f5781be2c7b7 Wang YanQing 2018-05-03  226  			EMIT2_off32(0xC7, add_1reg(0xC0, dst),
03f5781be2c7b7 Wang YanQing 2018-05-03  227  				    val);
03f5781be2c7b7 Wang YanQing 2018-05-03  228  	}
03f5781be2c7b7 Wang YanQing 2018-05-03  229  	*pprog = prog;
03f5781be2c7b7 Wang YanQing 2018-05-03  230  }
03f5781be2c7b7 Wang YanQing 2018-05-03  231  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

