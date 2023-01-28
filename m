Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CA67F609
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 09:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjA1IR1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 03:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1IR0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 03:17:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4503610405
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 00:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893845; x=1706429845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=spM3AE0alRjjB//gXGhV1W5htvQfvEZ2ffYkRQxojPU=;
  b=c+RE6Y3pnUetE7rlKc8tuh4QfTKalrFfg2S+KQ4xEBmImGxVwralAvhA
   WK/iw64t0Oao89dblllWq/ymboZZHmXnyjIPSPG/FPVxr7h8QghdOh7qy
   ceq9kxs+ltw2T8g8OjsOfu8yWOmNxATjOjncJ9sGUcfv5t/r5/rSwElS4
   iQcysEpODynXF5gkMQvcMjJ4/q41rkz6MzomGOhiZn8iqzp9vZrVKyr7j
   sgwzrW8YpexY1dHM0fxWGI9C9p8ZQFywQZmDQI4UBedVkIoiXh8H53TkJ
   rXCBA4DG/36QCfj/nhFI/FLD51BUKLhzaRJ49ARn90QyCgvS1XhgrsZiI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413495705"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="413495705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="992339212"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="992339212"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2023 00:17:23 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLgOo-0000W9-2H;
        Sat, 28 Jan 2023 08:17:22 +0000
Date:   Sat, 28 Jan 2023 16:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grant Seltzer <grantseltzer@gmail.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
        grantseltzer@gmail.com
Subject: Re: [PATCH bpf-next] Add support for tracing programs in BPF_PROG_RUN
Message-ID: <202301281606.OPSk1bci-lkp@intel.com>
References: <20230127214353.628551-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127214353.628551-1-grantseltzer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Grant,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Grant-Seltzer/Add-support-for-tracing-programs-in-BPF_PROG_RUN/20230128-130222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230127214353.628551-1-grantseltzer%40gmail.com
patch subject: [PATCH bpf-next] Add support for tracing programs in BPF_PROG_RUN
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230128/202301281606.OPSk1bci-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/990088d6233eb15a4a42a83a998f47432305d4d7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Grant-Seltzer/Add-support-for-tracing-programs-in-BPF_PROG_RUN/20230128-130222
        git checkout 990088d6233eb15a4a42a83a998f47432305d4d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c: In function 'bpf_prog_test_run_tracing':
>> net/bpf/test_run.c:818:30: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     818 |         u16 side_effect = 0, ret = 0;
         |                              ^~~
>> net/bpf/test_run.c:818:13: warning: variable 'side_effect' set but not used [-Wunused-but-set-variable]
     818 |         u16 side_effect = 0, ret = 0;
         |             ^~~~~~~~~~~


vim +/ret +818 net/bpf/test_run.c

990088d6233eb1 Grant Seltzer          2023-01-27  812  
da00d2f117a08f KP Singh               2020-03-04  813  int bpf_prog_test_run_tracing(struct bpf_prog *prog,
da00d2f117a08f KP Singh               2020-03-04  814  			      const union bpf_attr *kattr,
da00d2f117a08f KP Singh               2020-03-04  815  			      union bpf_attr __user *uattr)
da00d2f117a08f KP Singh               2020-03-04  816  {
d923021c2ce12a Yonghong Song          2020-06-30  817  	struct bpf_fentry_test_t arg = {};
3d08b6f29cf33a KP Singh               2020-03-04 @818  	u16 side_effect = 0, ret = 0;
990088d6233eb1 Grant Seltzer          2023-01-27  819  	int b = 2, err = -EFAULT, current_cpu;
990088d6233eb1 Grant Seltzer          2023-01-27  820  
990088d6233eb1 Grant Seltzer          2023-01-27  821  	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
990088d6233eb1 Grant Seltzer          2023-01-27  822  	__u32 ctx_size_in = kattr->test.ctx_size_in;
990088d6233eb1 Grant Seltzer          2023-01-27  823  	struct bpf_tracing_test_run_info info;
990088d6233eb1 Grant Seltzer          2023-01-27  824  	int cpu = kattr->test.cpu;
da00d2f117a08f KP Singh               2020-03-04  825  
b530e9e1063ed2 Toke Høiland-Jørgensen 2022-03-09  826  	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
1b4d60ec162f82 Song Liu               2020-09-25  827  		return -EINVAL;
1b4d60ec162f82 Song Liu               2020-09-25  828  
da00d2f117a08f KP Singh               2020-03-04  829  	switch (prog->expected_attach_type) {
da00d2f117a08f KP Singh               2020-03-04  830  	case BPF_TRACE_FENTRY:
da00d2f117a08f KP Singh               2020-03-04  831  	case BPF_TRACE_FEXIT:
faeb2dce084aff Alexei Starovoitov     2019-11-14  832  		if (bpf_fentry_test1(1) != 2 ||
faeb2dce084aff Alexei Starovoitov     2019-11-14  833  		    bpf_fentry_test2(2, 3) != 5 ||
faeb2dce084aff Alexei Starovoitov     2019-11-14  834  		    bpf_fentry_test3(4, 5, 6) != 15 ||
faeb2dce084aff Alexei Starovoitov     2019-11-14  835  		    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
faeb2dce084aff Alexei Starovoitov     2019-11-14  836  		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
d923021c2ce12a Yonghong Song          2020-06-30  837  		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
d923021c2ce12a Yonghong Song          2020-06-30  838  		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
d923021c2ce12a Yonghong Song          2020-06-30  839  		    bpf_fentry_test8(&arg) != 0)
da00d2f117a08f KP Singh               2020-03-04  840  			goto out;
da00d2f117a08f KP Singh               2020-03-04  841  		break;
3d08b6f29cf33a KP Singh               2020-03-04  842  	case BPF_MODIFY_RETURN:
3d08b6f29cf33a KP Singh               2020-03-04  843  		ret = bpf_modify_return_test(1, &b);
3d08b6f29cf33a KP Singh               2020-03-04  844  		if (b != 2)
3d08b6f29cf33a KP Singh               2020-03-04  845  			side_effect = 1;
3d08b6f29cf33a KP Singh               2020-03-04  846  		break;
da00d2f117a08f KP Singh               2020-03-04  847  	default:
da00d2f117a08f KP Singh               2020-03-04  848  		goto out;
a25ecd9d1e6024 Colin Ian King         2019-11-18  849  	}
da00d2f117a08f KP Singh               2020-03-04  850  
990088d6233eb1 Grant Seltzer          2023-01-27  851  	/* doesn't support data_in/out, ctx_out, duration, or repeat */
990088d6233eb1 Grant Seltzer          2023-01-27  852  	if (kattr->test.data_in || kattr->test.data_out ||
990088d6233eb1 Grant Seltzer          2023-01-27  853  	    kattr->test.ctx_out || kattr->test.duration ||
990088d6233eb1 Grant Seltzer          2023-01-27  854  	    kattr->test.repeat || kattr->test.batch_size)
990088d6233eb1 Grant Seltzer          2023-01-27  855  		return -EINVAL;
990088d6233eb1 Grant Seltzer          2023-01-27  856  
990088d6233eb1 Grant Seltzer          2023-01-27  857  	if (ctx_size_in < prog->aux->max_ctx_offset ||
990088d6233eb1 Grant Seltzer          2023-01-27  858  	    ctx_size_in > MAX_BPF_FUNC_ARGS * sizeof(u64))
990088d6233eb1 Grant Seltzer          2023-01-27  859  		return -EINVAL;
990088d6233eb1 Grant Seltzer          2023-01-27  860  
990088d6233eb1 Grant Seltzer          2023-01-27  861  	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 && cpu != 0)
990088d6233eb1 Grant Seltzer          2023-01-27  862  		return -EINVAL;
990088d6233eb1 Grant Seltzer          2023-01-27  863  
990088d6233eb1 Grant Seltzer          2023-01-27  864  	if (ctx_size_in) {
990088d6233eb1 Grant Seltzer          2023-01-27  865  		info.ctx = memdup_user(ctx_in, ctx_size_in);
990088d6233eb1 Grant Seltzer          2023-01-27  866  		if (IS_ERR(info.ctx))
990088d6233eb1 Grant Seltzer          2023-01-27  867  			return PTR_ERR(info.ctx);
990088d6233eb1 Grant Seltzer          2023-01-27  868  	} else {
990088d6233eb1 Grant Seltzer          2023-01-27  869  		info.ctx = NULL;
990088d6233eb1 Grant Seltzer          2023-01-27  870  	}
3d08b6f29cf33a KP Singh               2020-03-04  871  
da00d2f117a08f KP Singh               2020-03-04  872  	err = 0;
990088d6233eb1 Grant Seltzer          2023-01-27  873  	info.prog = prog;
990088d6233eb1 Grant Seltzer          2023-01-27  874  
990088d6233eb1 Grant Seltzer          2023-01-27  875  	current_cpu = get_cpu();
990088d6233eb1 Grant Seltzer          2023-01-27  876  	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 ||
990088d6233eb1 Grant Seltzer          2023-01-27  877  	    cpu == current_cpu) {
990088d6233eb1 Grant Seltzer          2023-01-27  878  		__bpf_prog_test_run_tracing(&info);
990088d6233eb1 Grant Seltzer          2023-01-27  879  	} else if (cpu >= nr_cpu_ids || !cpu_online(cpu)) {
990088d6233eb1 Grant Seltzer          2023-01-27  880  		/* smp_call_function_single() also checks cpu_online()
990088d6233eb1 Grant Seltzer          2023-01-27  881  		 * after csd_lock(). However, since cpu is from user
990088d6233eb1 Grant Seltzer          2023-01-27  882  		 * space, let's do an extra quick check to filter out
990088d6233eb1 Grant Seltzer          2023-01-27  883  		 * invalid value before smp_call_function_single().
990088d6233eb1 Grant Seltzer          2023-01-27  884  		 */
990088d6233eb1 Grant Seltzer          2023-01-27  885  		err = -ENXIO;
990088d6233eb1 Grant Seltzer          2023-01-27  886  	} else {
990088d6233eb1 Grant Seltzer          2023-01-27  887  		err = smp_call_function_single(cpu, __bpf_prog_test_run_tracing,
990088d6233eb1 Grant Seltzer          2023-01-27  888  					       &info, 1);
990088d6233eb1 Grant Seltzer          2023-01-27  889  	}
990088d6233eb1 Grant Seltzer          2023-01-27  890  	put_cpu();
990088d6233eb1 Grant Seltzer          2023-01-27  891  
990088d6233eb1 Grant Seltzer          2023-01-27  892  	if (!err &&
990088d6233eb1 Grant Seltzer          2023-01-27  893  	    copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
990088d6233eb1 Grant Seltzer          2023-01-27  894  		err = -EFAULT;
990088d6233eb1 Grant Seltzer          2023-01-27  895  
990088d6233eb1 Grant Seltzer          2023-01-27  896  	kfree(info.ctx);
990088d6233eb1 Grant Seltzer          2023-01-27  897  
da00d2f117a08f KP Singh               2020-03-04  898  out:
da00d2f117a08f KP Singh               2020-03-04  899  	trace_bpf_test_finish(&err);
da00d2f117a08f KP Singh               2020-03-04  900  	return err;
1cf1cae963c2e6 Alexei Starovoitov     2017-03-30  901  }
1cf1cae963c2e6 Alexei Starovoitov     2017-03-30  902  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
