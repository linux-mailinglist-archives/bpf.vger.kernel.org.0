Return-Path: <bpf+bounces-16223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E67FE7DD
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 04:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CC01C20C2B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C113AD9;
	Thu, 30 Nov 2023 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmaR0+Tf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ADDD67;
	Wed, 29 Nov 2023 19:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316500; x=1732852500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPbKT2u1RiCAVsEy1gSYA3QPpByfCgWfk4B7HbjpC5U=;
  b=jmaR0+TfeuxyuvMAbK15DnYWReSTGKMCHgUrApUzJd+urTBZdA4Umith
   AFN/67p6Hy7BjPEwoO4ENkhhe20BAhblHcYDxTPUWjQ98gizYLkvgvPRg
   iyXLIt49Sp5iWmYxHLuKr19NIGwU43PkdGbVcIE+TO0X/kAD93M3XbDBm
   6TsINxASpU9s83+Xc/5xRzPoLHBzhlrYMaxNjAj9tsZlK5zeQG3hkVGlT
   djLZGknlnrJ7gIm/04ugYcK2pX+NMiCrSqjtbWetttSTZkN1cPnoV4eqk
   iYMe/j8MeYfdDKqTDHTfxMav4IFLNTuA/DLTCE/7jUPMo88GplO1KoYtT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="459757270"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="459757270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745488145"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745488145"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2023 19:54:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8Y8b-0001Iw-3B;
	Thu, 30 Nov 2023 03:54:53 +0000
Date: Thu, 30 Nov 2023 11:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 1/3] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <202311300843.welZEZkm-lkp@intel.com>
References: <20231129173312.31008-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129173312.31008-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-crypto-add-skcipher-to-bpf-crypto/20231130-014813
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231129173312.31008-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v6 1/3] bpf: make common crypto API for TC/XDP programs
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300843.welZEZkm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300843.welZEZkm-lkp@intel.com/

All errors (new ones prefixed by >>):

    3103 |                          psmouse->ps2dev.serio->phys);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/mouse/lifebook.c: In function 'lifebook_init':
   drivers/input/mouse/lifebook.c:283:21: warning: '/input1' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     283 |                  "%s/input1", psmouse->ps2dev.serio->phys);
         |                     ^~~~~~~
   In function 'lifebook_create_relative_device',
       inlined from 'lifebook_init' at drivers/input/mouse/lifebook.c:331:11:
   drivers/input/mouse/lifebook.c:282:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
     282 |         snprintf(priv->phys, sizeof(priv->phys),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     283 |                  "%s/input1", psmouse->ps2dev.serio->phys);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/mouse/elantech.c: In function 'elantech_setup_ps2':
   drivers/input/mouse/elantech.c:2090:65: warning: '/input1' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    2090 |                 snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
         |                                                                 ^~~~~~~
   drivers/input/mouse/elantech.c:2090:17: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
    2090 |                 snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2091 |                         psmouse->ps2dev.serio->phys);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7091:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7091 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7128:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7128 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
   drivers/input/mouse/vmmouse.c: In function 'vmmouse_init':
   drivers/input/mouse/vmmouse.c:455:53: warning: '/input1' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
         |                                                     ^~~~~~~
   drivers/input/mouse/vmmouse.c:455:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
     455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     456 |                  psmouse->ps2dev.serio->phys);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_synth.c:1165: warning: Excess function parameter 'args' description in '__synth_event_gen_cmd_start'
   kernel/trace/trace_events_synth.c:1714: warning: Excess function parameter 'args' description in 'synth_event_trace'
   drivers/thermal/thermal_sysfs.c: In function 'create_trip_attrs':
   drivers/thermal/thermal_sysfs.c:475:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 9 [-Wformat-truncation=]
     475 |                          "trip_point_%d_type", indx);
         |                                      ^~
   drivers/thermal/thermal_sysfs.c:475:26: note: directive argument in the range [-2147483644, 2147483646]
     475 |                          "trip_point_%d_type", indx);
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:474:17: note: 'snprintf' output between 18 and 28 bytes into a destination of size 20
     474 |                 snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     475 |                          "trip_point_%d_type", indx);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:486:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 9 [-Wformat-truncation=]
     486 |                          "trip_point_%d_temp", indx);
         |                                      ^~
   drivers/thermal/thermal_sysfs.c:486:26: note: directive argument in the range [-2147483644, 2147483646]
     486 |                          "trip_point_%d_temp", indx);
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:485:17: note: 'snprintf' output between 18 and 28 bytes into a destination of size 20
     485 |                 snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     486 |                          "trip_point_%d_temp", indx);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:502:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 9 [-Wformat-truncation=]
     502 |                          "trip_point_%d_hyst", indx);
         |                                      ^~
   drivers/thermal/thermal_sysfs.c:502:26: note: directive argument in the range [-2147483644, 2147483646]
     502 |                          "trip_point_%d_hyst", indx);
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:501:17: note: 'snprintf' output between 18 and 28 bytes into a destination of size 20
     501 |                 snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     502 |                          "trip_point_%d_hyst", indx);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/usb/asix.h:28,
                    from drivers/net/usb/ax88172a.c:15:
   drivers/net/usb/ax88172a.c: In function 'ax88172a_reset':
   include/linux/phy.h:300:20: warning: '%s' directive output may be truncated writing up to 60 bytes into a region of size 20 [-Wformat-truncation=]
     300 | #define PHY_ID_FMT "%s:%02x"
         |                    ^~~~~~~~~
   drivers/net/usb/ax88172a.c:309:38: note: in expansion of macro 'PHY_ID_FMT'
     309 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
         |                                      ^~~~~~~~~~
   include/linux/phy.h:300:21: note: format string is defined here
     300 | #define PHY_ID_FMT "%s:%02x"
         |                     ^~
   include/linux/phy.h:300:20: note: directive argument in the range [0, 65535]
     300 | #define PHY_ID_FMT "%s:%02x"
         |                    ^~~~~~~~~
   drivers/net/usb/ax88172a.c:309:38: note: in expansion of macro 'PHY_ID_FMT'
     309 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
         |                                      ^~~~~~~~~~
   drivers/net/usb/ax88172a.c:309:9: note: 'snprintf' output between 4 and 66 bytes into a destination of size 20
     309 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     310 |                  priv->mdio->id, priv->phy_addr);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:1350: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'
   kernel/bpf/crypto.c: In function 'bpf_crypto_ctx_create':
>> kernel/bpf/crypto.c:179:60: error: expected ')' before ';' token
     179 |                 *err = type->setauthsize(ctx->tfm, authsize;
         |                                         ~                  ^
         |                                                            )
>> kernel/bpf/crypto.c:181:34: error: expected ';' before '}' token
     181 |                         goto err;
         |                                  ^
         |                                  ;
     182 |         }
         |         ~                         
   make[5]: *** [scripts/Makefile.build:243: kernel/bpf/crypto.o] Error 1
   drivers/cpuidle/governors/ladder.c:54: warning: Function parameter or member 'dev' not described in 'ladder_do_selection'
   make[5]: Target 'kernel/bpf/' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:480: kernel/bpf] Error 2
   drivers/cpufreq/intel_pstate.c:264: warning: Function parameter or member 'epp_cached' not described in 'cpudata'
   make[4]: Target 'kernel/' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:480: kernel] Error 2
   drivers/leds/led-core.c: In function 'led_compose_name':
   drivers/leds/led-core.c:514:78: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     514 |                         snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
         |                                                                              ^
   drivers/leds/led-core.c:514:25: note: 'snprintf' output 2 or more bytes (assuming 65) into a destination of size 64
     514 |                         snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     515 |                                  devicename, tmp_buf);
         |                                  ~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member 'hdev' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member 'work' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member 'battery_timer' not described in 'magicmouse_sc'
   drivers/hwspinlock/hwspinlock_core.c:208: warning: Function parameter or member 'to' not described in '__hwspin_lock_timeout'
   drivers/hwspinlock/hwspinlock_core.c:208: warning: Excess function parameter 'timeout' description in '__hwspin_lock_timeout'
   drivers/hwspinlock/hwspinlock_core.c:318: warning: Excess function parameter 'bank' description in 'of_hwspin_lock_simple_xlate'
   drivers/hwspinlock/hwspinlock_core.c:647: warning: Function parameter or member 'hwlock' not described in '__hwspin_lock_request'
   drivers/firmware/efi/memmap.c:132: warning: Function parameter or member 'addr' not described in 'efi_memmap_init_late'
   drivers/firmware/efi/memmap.c:132: warning: Excess function parameter 'phys_addr' description in 'efi_memmap_init_late'
   drivers/hv/channel.c:597: warning: Function parameter or member 'size' not described in 'request_arr_init'
   drivers/firmware/efi/cper-x86.c: In function 'cper_print_proc_ia':
   drivers/firmware/efi/cper-x86.c:295:72: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     295 |                                 snprintf(infopfx, sizeof(infopfx), "%s ",
         |                                                                        ^
   drivers/firmware/efi/cper-x86.c:295:33: note: 'snprintf' output between 2 and 65 bytes into a destination of size 64
     295 |                                 snprintf(infopfx, sizeof(infopfx), "%s ",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     296 |                                          newpfx);
         |                                          ~~~~~~~
   drivers/firmware/efi/libstub/efi-stub-helper.c:563: warning: Function parameter or member 'out' not described in 'efi_load_initrd'
   drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or member 'memory_type' not described in 'efi_allocate_pages_aligned'
   make[3]: Target './' not remade because of errors.
   make[2]: *** [Makefile:1911: .] Error 2
   make[2]: Target 'vmlinux' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'vmlinux' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'vmlinux' not remade because of errors.


vim +179 kernel/bpf/crypto.c

   105	
   106	/**
   107	 * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
   108	 *
   109	 * Allocates a crypto context that can be used, acquired, and released by
   110	 * a BPF program. The crypto context returned by this function must either
   111	 * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
   112	 * As crypto API functions use GFP_KERNEL allocations, this function can
   113	 * only be used in sleepable BPF programs.
   114	 *
   115	 * bpf_crypto_ctx_create() allocates memory for crypto context.
   116	 * It may return NULL if no memory is available.
   117	 * @type__str: pointer to string representation of crypto type.
   118	 * @algo__str: pointer to string representation of algorithm.
   119	 * @pkey:      bpf_dynptr which holds cipher key to do crypto.
   120	 * @err:       integer to store error code when NULL is returned
   121	 */
   122	__bpf_kfunc struct bpf_crypto_ctx *
   123	bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
   124			      const struct bpf_dynptr_kern *pkey,
   125			      unsigned int authsize, int *err)
   126	{
   127		const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
   128		struct bpf_crypto_ctx *ctx;
   129		const u8 *key;
   130		u32 key_len;
   131	
   132		//type = bpf_crypto_get_type(type__str);
   133		if (IS_ERR(type)) {
   134			*err = PTR_ERR(type);
   135			return NULL;
   136		}
   137	
   138		if (!type->has_algo(algo__str)) {
   139			*err = -EOPNOTSUPP;
   140			goto err;
   141		}
   142	
   143		if (!authsize && type->setauthsize) {
   144			*err = -EOPNOTSUPP;
   145			goto err;
   146		}
   147	
   148		if (authsize && !type->setauthsize) {
   149			*err = -EOPNOTSUPP;
   150			goto err;
   151		}
   152	
   153		key_len = __bpf_dynptr_size(pkey);
   154		if (!key_len) {
   155			*err = -EINVAL;
   156			goto err;
   157		}
   158		key = __bpf_dynptr_data(pkey, key_len);
   159		if (!key) {
   160			*err = -EINVAL;
   161			goto err;
   162		}
   163	
   164		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
   165		if (!ctx) {
   166			*err = -ENOMEM;
   167			goto err;
   168		}
   169	
   170		ctx->type = type;
   171		ctx->tfm = type->alloc_tfm(algo__str);
   172		if (IS_ERR(ctx->tfm)) {
   173			*err = PTR_ERR(ctx->tfm);
   174			ctx->tfm = NULL;
   175			goto err;
   176		}
   177	
   178		if (authsize) {
 > 179			*err = type->setauthsize(ctx->tfm, authsize;
   180			if (*err)
 > 181				goto err;
   182		}
   183	
   184		*err = type->setkey(ctx->tfm, key, key_len);
   185		if (*err)
   186			goto err;
   187	
   188		refcount_set(&ctx->usage, 1);
   189	
   190		return ctx;
   191	err:
   192		if (ctx->tfm)
   193			type->free_tfm(ctx->tfm);
   194		kfree(ctx);
   195		module_put(type->owner);
   196	
   197		return NULL;
   198	}
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

