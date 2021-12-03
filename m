Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCD467F7E
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383285AbhLCVtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 16:49:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:33979 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383283AbhLCVtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 16:49:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297861300"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="297861300"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="461037607"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2021 13:46:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtGNq-000I5m-SW; Fri, 03 Dec 2021 21:46:22 +0000
Date:   Sat, 4 Dec 2021 05:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: add signature to eBPF instructions
Message-ID: <202112040507.siNkODlN-lkp@intel.com>
References: <20211203191844.69709-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203191844.69709-2-mcroce@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Matteo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Matteo-Croce/bpf-add-signature/20211204-032018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20211204/202112040507.siNkODlN-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fdfe32b9e64c6a208965002215d467ec383b6f57
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matteo-Croce/bpf-add-signature/20211204-032018
        git checkout fdfe32b9e64c6a208965002215d467ec383b6f57
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
>> kernel/bpf/syscall.c:2324:47: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2324 |                 if (copy_from_user(signature, (char *)attr->signature, attr->sig_len)) {
         |                                               ^


vim +2324 kernel/bpf/syscall.c

  2192	
  2193	static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
  2194	{
  2195		enum bpf_prog_type type = attr->prog_type;
  2196		struct bpf_prog *prog, *dst_prog = NULL;
  2197		struct btf *attach_btf = NULL;
  2198		int err;
  2199		char license[128];
  2200		bool is_gpl;
  2201	
  2202		if (CHECK_ATTR(BPF_PROG_LOAD))
  2203			return -EINVAL;
  2204	
  2205		if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
  2206					 BPF_F_ANY_ALIGNMENT |
  2207					 BPF_F_TEST_STATE_FREQ |
  2208					 BPF_F_SLEEPABLE |
  2209					 BPF_F_TEST_RND_HI32))
  2210			return -EINVAL;
  2211	
  2212		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
  2213		    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
  2214		    !bpf_capable())
  2215			return -EPERM;
  2216	
  2217		/* copy eBPF program license from user space */
  2218		if (strncpy_from_bpfptr(license,
  2219					make_bpfptr(attr->license, uattr.is_kernel),
  2220					sizeof(license) - 1) < 0)
  2221			return -EFAULT;
  2222		license[sizeof(license) - 1] = 0;
  2223	
  2224		/* eBPF programs must be GPL compatible to use GPL-ed functions */
  2225		is_gpl = license_is_gpl_compatible(license);
  2226	
  2227		if (attr->insn_cnt == 0 ||
  2228		    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
  2229			return -E2BIG;
  2230		if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
  2231		    type != BPF_PROG_TYPE_CGROUP_SKB &&
  2232		    !bpf_capable())
  2233			return -EPERM;
  2234	
  2235		if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
  2236			return -EPERM;
  2237		if (is_perfmon_prog_type(type) && !perfmon_capable())
  2238			return -EPERM;
  2239	
  2240		/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
  2241		 * or btf, we need to check which one it is
  2242		 */
  2243		if (attr->attach_prog_fd) {
  2244			dst_prog = bpf_prog_get(attr->attach_prog_fd);
  2245			if (IS_ERR(dst_prog)) {
  2246				dst_prog = NULL;
  2247				attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
  2248				if (IS_ERR(attach_btf))
  2249					return -EINVAL;
  2250				if (!btf_is_kernel(attach_btf)) {
  2251					/* attaching through specifying bpf_prog's BTF
  2252					 * objects directly might be supported eventually
  2253					 */
  2254					btf_put(attach_btf);
  2255					return -ENOTSUPP;
  2256				}
  2257			}
  2258		} else if (attr->attach_btf_id) {
  2259			/* fall back to vmlinux BTF, if BTF type ID is specified */
  2260			attach_btf = bpf_get_btf_vmlinux();
  2261			if (IS_ERR(attach_btf))
  2262				return PTR_ERR(attach_btf);
  2263			if (!attach_btf)
  2264				return -EINVAL;
  2265			btf_get(attach_btf);
  2266		}
  2267	
  2268		bpf_prog_load_fixup_attach_type(attr);
  2269		if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
  2270					       attach_btf, attr->attach_btf_id,
  2271					       dst_prog)) {
  2272			if (dst_prog)
  2273				bpf_prog_put(dst_prog);
  2274			if (attach_btf)
  2275				btf_put(attach_btf);
  2276			return -EINVAL;
  2277		}
  2278	
  2279		/* plain bpf_prog allocation */
  2280		prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
  2281		if (!prog) {
  2282			if (dst_prog)
  2283				bpf_prog_put(dst_prog);
  2284			if (attach_btf)
  2285				btf_put(attach_btf);
  2286			return -ENOMEM;
  2287		}
  2288	
  2289		prog->expected_attach_type = attr->expected_attach_type;
  2290		prog->aux->attach_btf = attach_btf;
  2291		prog->aux->attach_btf_id = attr->attach_btf_id;
  2292		prog->aux->dst_prog = dst_prog;
  2293		prog->aux->offload_requested = !!attr->prog_ifindex;
  2294		prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
  2295	
  2296		err = security_bpf_prog_alloc(prog->aux);
  2297		if (err)
  2298			goto free_prog;
  2299	
  2300		prog->aux->user = get_current_user();
  2301		prog->len = attr->insn_cnt;
  2302	
  2303		err = -EFAULT;
  2304		if (copy_from_bpfptr(prog->insns,
  2305				     make_bpfptr(attr->insns, uattr.is_kernel),
  2306				     bpf_prog_insn_size(prog)) != 0)
  2307			goto free_prog_sec;
  2308	
  2309		err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
  2310				       sizeof(attr->prog_name));
  2311		if (err < 0)
  2312			goto free_prog_sec;
  2313	
  2314	#ifdef CONFIG_BPF_SIG
  2315		if (attr->sig_len) {
  2316			char *signature;
  2317	
  2318			signature = kmalloc(attr->sig_len, GFP_USER);
  2319			if (!signature) {
  2320				err = -ENOMEM;
  2321				goto free_prog_sec;
  2322			}
  2323	
> 2324			if (copy_from_user(signature, (char *)attr->signature, attr->sig_len)) {
  2325				err = -EFAULT;
  2326				kfree(signature);
  2327				goto free_prog_sec;
  2328			}
  2329	
  2330			err = verify_pkcs7_signature(prog->insns,
  2331						     prog->len * sizeof(struct bpf_insn),
  2332						     signature, attr->sig_len,
  2333						     VERIFY_USE_SECONDARY_KEYRING,
  2334						     VERIFYING_BPF_SIGNATURE,
  2335						     NULL, NULL);
  2336			kfree(signature);
  2337	
  2338			if (err) {
  2339				pr_warn("Invalid BPF signature for '%s': %pe\n",
  2340					prog->aux->name, ERR_PTR(err));
  2341				goto free_prog_sec;
  2342			}
  2343		}
  2344	#endif
  2345	
  2346		prog->orig_prog = NULL;
  2347		prog->jited = 0;
  2348	
  2349		atomic64_set(&prog->aux->refcnt, 1);
  2350		prog->gpl_compatible = is_gpl ? 1 : 0;
  2351	
  2352		if (bpf_prog_is_dev_bound(prog->aux)) {
  2353			err = bpf_prog_offload_init(prog, attr);
  2354			if (err)
  2355				goto free_prog_sec;
  2356		}
  2357	
  2358		/* find program type: socket_filter vs tracing_filter */
  2359		err = find_prog_type(type, prog);
  2360		if (err < 0)
  2361			goto free_prog_sec;
  2362	
  2363		prog->aux->load_time = ktime_get_boottime_ns();
  2364	
  2365		/* run eBPF verifier */
  2366		err = bpf_check(&prog, attr, uattr);
  2367		if (err < 0)
  2368			goto free_used_maps;
  2369	
  2370		prog = bpf_prog_select_runtime(prog, &err);
  2371		if (err < 0)
  2372			goto free_used_maps;
  2373	
  2374		err = bpf_prog_alloc_id(prog);
  2375		if (err)
  2376			goto free_used_maps;
  2377	
  2378		/* Upon success of bpf_prog_alloc_id(), the BPF prog is
  2379		 * effectively publicly exposed. However, retrieving via
  2380		 * bpf_prog_get_fd_by_id() will take another reference,
  2381		 * therefore it cannot be gone underneath us.
  2382		 *
  2383		 * Only for the time /after/ successful bpf_prog_new_fd()
  2384		 * and before returning to userspace, we might just hold
  2385		 * one reference and any parallel close on that fd could
  2386		 * rip everything out. Hence, below notifications must
  2387		 * happen before bpf_prog_new_fd().
  2388		 *
  2389		 * Also, any failure handling from this point onwards must
  2390		 * be using bpf_prog_put() given the program is exposed.
  2391		 */
  2392		bpf_prog_kallsyms_add(prog);
  2393		perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
  2394		bpf_audit_prog(prog, BPF_AUDIT_LOAD);
  2395	
  2396		err = bpf_prog_new_fd(prog);
  2397		if (err < 0)
  2398			bpf_prog_put(prog);
  2399		return err;
  2400	
  2401	free_used_maps:
  2402		/* In case we have subprogs, we need to wait for a grace
  2403		 * period before we can tear down JIT memory since symbols
  2404		 * are already exposed under kallsyms.
  2405		 */
  2406		__bpf_prog_put_noref(prog, prog->aux->func_cnt);
  2407		return err;
  2408	free_prog_sec:
  2409		free_uid(prog->aux->user);
  2410		security_bpf_prog_free(prog->aux);
  2411	free_prog:
  2412		if (prog->aux->attach_btf)
  2413			btf_put(prog->aux->attach_btf);
  2414		bpf_prog_free(prog);
  2415		return err;
  2416	}
  2417	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
