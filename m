Return-Path: <bpf+bounces-31995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE5905FC6
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC51B22835
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 00:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FB8C11;
	Thu, 13 Jun 2024 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eS1Ms0I6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB8611B;
	Thu, 13 Jun 2024 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239108; cv=none; b=Cdlae8hBB3xZ9U2pTv+NxMNlJ/p9BmnGEFXsJDTwo1ucBvUtQCMpg44ghgv6XAh6VAiGtpPJRxkb3QnIrvvvL4VM8WxXK/K6R/Oe75+yA52o+8Vyyl/6gdlmXraqADwy0P5+NqXBn20hVRi1d/dQeNVGKh3D7eioR7K+a9tZSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239108; c=relaxed/simple;
	bh=xwhOVH4IotpCZNZAPSa+OqtR7eMdCTyHHuTyOgqkc84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMKCn9/dHSKKdj9bFAg9I1UhJfyIvItvZGxPpjPaixU4YvDTMhGp0KIIpbowodFQ+fVqj4/It4nBEaJxxI6e4T9NzxsJi6dvnwdzcXMloJCkZfXqWRsBrXYz5bWIET1nrPHDs0l4Pxr+KcLMG0VEJDVZJnPfde45QMZeFAXZ0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eS1Ms0I6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718239106; x=1749775106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xwhOVH4IotpCZNZAPSa+OqtR7eMdCTyHHuTyOgqkc84=;
  b=eS1Ms0I6mF2QibMDuEx/LO40zUu0h94mzqz3D1uT66Ti6U7gZV2ZPlsX
   f0VKAhtXQCv2+2bb+C+ljaYCD5mxDQOGm/KZcaIGmZ23f4YI0oyW383Yo
   k8wDzgAAEi5r1ldbPC4+a4EzrmB0Y8U4wi0vLmf8zWk86DFEBJorWpiFN
   EmF3KTkqyNtp/yoRRU+utBLyAYnX6zgd8D/ox3xf4OeupI2XDA9rKV3zS
   g0r6xatAV3PB/8b1WZ5Dfk2DfbtPX2aC7U/U36kpn6UyVEmHZrPbevkbl
   oNMa4C971OQHt1si0k7F7zwxz/5CAAXcyx95EubHOa9FUogCLsL1WMh0z
   g==;
X-CSE-ConnectionGUID: FdyA8h6SS8mIPFlR0nwGzA==
X-CSE-MsgGUID: 3CTtxvKoTtiUsrRQ7U7I0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18813849"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18813849"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 17:38:26 -0700
X-CSE-ConnectionGUID: OK9tqlSLSPu8ijYQRLFZnQ==
X-CSE-MsgGUID: VCDKbOSrTk2PAZcdVR1DAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39915722"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Jun 2024 17:38:19 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHYTp-00022g-1E;
	Thu, 13 Jun 2024 00:38:17 +0000
Date: Thu, 13 Jun 2024 08:38:05 +0800
From: kernel test robot <lkp@intel.com>
To: kunyu <kunyu@nfschina.com>, davem@davemloft.net, dsahern@kernel.org,
	udknight@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] x86: net: bpf_jit_comp32: Remove unused 'cnt' variables
 from most functions
Message-ID: <202406130855.la1z88C0-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20240613 (https://download.01.org/0day-ci/archive/20240613/202406130855.la1z88C0-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240613/202406130855.la1z88C0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406130855.la1z88C0-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_mov_i':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: in expansion of macro 'EMIT'
    #define EMIT2(b1, b2)  EMIT((b1) + ((b2) << 8), 2)
                           ^~~~
   arch/x86/net/bpf_jit_comp32.c:214:4: note: in expansion of macro 'EMIT2'
       EMIT2(0x33, add_2reg(0xC0, IA32_EAX, IA32_EAX));
       ^~~~~
   arch/x86/net/bpf_jit_comp32.c:65:43: note: each undeclared identifier is reported only once for each function it appears in
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: in expansion of macro 'EMIT'
    #define EMIT2(b1, b2)  EMIT((b1) + ((b2) << 8), 2)
                           ^~~~
   arch/x86/net/bpf_jit_comp32.c:214:4: note: in expansion of macro 'EMIT2'
       EMIT2(0x33, add_2reg(0xC0, IA32_EAX, IA32_EAX));
       ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_mov_r':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:241:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(src));
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_mul_r':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:291:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src));
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_to_le_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:323:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_to_be_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:370:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_div_mod_r':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:437:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_shift_r':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:485:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(dst));
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_alu_r':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:526:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(src));
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_alu_i':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:599:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(dst));
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_neg64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:696:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_lsh_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:729:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_arsh_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:781:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_rsh_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:833:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_lsh_i64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:885:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_rsh_i64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:932:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_arsh_i64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:980:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_mul_r64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:1026:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_ia32_mul_i64':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: in expansion of macro 'EMIT'
    #define EMIT2(b1, b2)  EMIT((b1) + ((b2) << 8), 2)
                           ^~~~
   arch/x86/net/bpf_jit_comp32.c:76:7: note: in expansion of macro 'EMIT2'
     do { EMIT2(b1, b2); EMIT(off, 4); } while (0)
          ^~~~~
   arch/x86/net/bpf_jit_comp32.c:1103:2: note: in expansion of macro 'EMIT2_off32'
     EMIT2_off32(0xC7, add_1reg(0xC0, IA32_EAX), val);
     ^~~~~~~~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_prologue':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:67:20: note: in expansion of macro 'EMIT'
    #define EMIT1(b1)  EMIT(b1, 1)
                       ^~~~
   arch/x86/net/bpf_jit_comp32.c:1191:2: note: in expansion of macro 'EMIT1'
     EMIT1(0x55);
     ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_epilogue':
>> arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:1231:2: note: in expansion of macro 'EMIT3'
     EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(r0[0]));
     ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_push_r64':
   arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:1375:2: note: in expansion of macro 'EMIT3'
     EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_hi));
     ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_push_r32':
   arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:1392:2: note: in expansion of macro 'EMIT3'
     EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_lo));
     ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'emit_kfunc_call':
   arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:69:27: note: in expansion of macro 'EMIT'
    #define EMIT3(b1, b2, b3) EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
                              ^~~~
   arch/x86/net/bpf_jit_comp32.c:1588:3: note: in expansion of macro 'EMIT3'
      EMIT3(0x8B, add_2reg(0x40, IA32_EBP, *cur_arg_reg++),
      ^~~~~
   arch/x86/net/bpf_jit_comp32.c: In function 'do_jit':
   arch/x86/net/bpf_jit_comp32.c:65:43: error: 'cnt' undeclared (first use in this function); did you mean 'int'?
     do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
                                              ^
   arch/x86/net/bpf_jit_comp32.c:68:24: note: in expansion of macro 'EMIT'
    #define EMIT2(b1, b2)  EMIT((b1) + ((b2) << 8), 2)
                           ^~~~
   arch/x86/net/bpf_jit_comp32.c:76:7: note: in expansion of macro 'EMIT2'
     do { EMIT2(b1, b2); EMIT(off, 4); } while (0)
          ^~~~~
   arch/x86/net/bpf_jit_comp32.c:1737:5: note: in expansion of macro 'EMIT2_off32'
        EMIT2_off32(0xC7, add_1reg(0xC0, IA32_ECX),
        ^~~~~~~~~~~


vim +65 arch/x86/net/bpf_jit_comp32.c

03f5781be2c7b7 Wang YanQing 2018-05-03  63  
03f5781be2c7b7 Wang YanQing 2018-05-03  64  #define EMIT(bytes, len) \
03f5781be2c7b7 Wang YanQing 2018-05-03 @65  	do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
03f5781be2c7b7 Wang YanQing 2018-05-03  66  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

