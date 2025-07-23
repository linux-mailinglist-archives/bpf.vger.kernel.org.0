Return-Path: <bpf+bounces-64179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78142B0F77E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41952170771
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EC1F0994;
	Wed, 23 Jul 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aceyplc5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F71E1E00
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285958; cv=none; b=lT8F9+c724f4NZseDTVD09IhI+nj+PWnW7Xw4M8+sG0hRbLIKjG2GW6CjN9uK39SLSQUZqRV+u+KRSdrpLUUZoUh6Svb+LL0eZunp1yxl+sGW3glm2Lkvncae8th0qoNhMHVsFYgz9qh0uMMwFxtLWGlasFUKTHILJmTLhwH32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285958; c=relaxed/simple;
	bh=ViuSl5cGk4og+qEq4ioF3jjulTVS4Mepxp2z5eDwG50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDnQG3wr8oRfYyZ77PG2uYk4AIKzJVe5Wvdi3OWeodVHnBhklL29WJfCRGhIQ/b8pUIFTqpBAZyR1AsizodRD9d+UdNXb5j/CX0Nv1NbzPbrfSS6DTeEwFQf0U2OOh87ETNM11M6AYh3aJNQMqMry0OZEJoiYa+pSG2R6G9p2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aceyplc5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753285956; x=1784821956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViuSl5cGk4og+qEq4ioF3jjulTVS4Mepxp2z5eDwG50=;
  b=aceyplc5llyeuZxazM26jg2VuOnx9nrJmtGlCzRrpUOCiR6ieivjJqzT
   GxpJ1eoJ9CyfBosM6FvKUGqbxSfkoSF5RRVVql8sEGC9cfp0lC9D0sMKG
   MqebK5eioZAwc7JxqBbp74tTIw+LhehKc3Q3sSRqtHgD/iu1bxiFRohNm
   DtfzK6OJQT3IaSWdaUTVesguwqy9lqoGoItqUsFLVb0n7NWnF/FKIAu34
   HcslwZLbufSWoSoNjmBSb0LNBPZsMl3wSCsGtkKC8hRrJ6ngxE1PV8Gzt
   G9YPK+nqs5O7aRljNF/5kf9BY/RFBQUJDp/kvlBA2LsJA49JRscj6/nub
   A==;
X-CSE-ConnectionGUID: OuaO4rziQGyuPwMB8iNvFQ==
X-CSE-MsgGUID: bycZc0nyQneor3L6a2Akww==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55280712"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55280712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:52:35 -0700
X-CSE-ConnectionGUID: oQVTBNiKR6CJzmMxZIULwQ==
X-CSE-MsgGUID: Zt8zXrr6Tqezh85FlwTPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163847093"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2025 08:52:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueblc-000JVJ-2M;
	Wed, 23 Jul 2025 15:52:28 +0000
Date: Wed, 23 Jul 2025 23:52:01 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next] bpf, arm64: JIT support for private stack
Message-ID: <202507232327.S1FR5cNc-lkp@intel.com>
References: <20250722173254.3879-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722173254.3879-1-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arm64-JIT-support-for-private-stack/20250723-013449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250722173254.3879-1-puranjay%40kernel.org
patch subject: [PATCH bpf-next] bpf, arm64: JIT support for private stack
config: arm64-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507232327.S1FR5cNc-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507232327.S1FR5cNc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507232327.S1FR5cNc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/net/bpf_jit_comp.c:2031:6: warning: variable 'ro_header' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2031 |         if (build_body(&ctx, extra_pass)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2160:8: note: uninitialized use occurs here
    2160 |                 if (!ro_header && priv_stack_ptr) {
         |                      ^~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2031:2: note: remove the 'if' if its condition is always false
    2031 |         if (build_body(&ctx, extra_pass)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2032 |                 prog = orig_prog;
         |                 ~~~~~~~~~~~~~~~~~
    2033 |                 goto out_off;
         |                 ~~~~~~~~~~~~~
    2034 |         }
         |         ~
   arch/arm64/net/bpf_jit_comp.c:2026:6: warning: variable 'ro_header' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2026 |         if (build_prologue(&ctx, was_classic)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2160:8: note: uninitialized use occurs here
    2160 |                 if (!ro_header && priv_stack_ptr) {
         |                      ^~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2026:2: note: remove the 'if' if its condition is always false
    2026 |         if (build_prologue(&ctx, was_classic)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2027 |                 prog = orig_prog;
         |                 ~~~~~~~~~~~~~~~~~
    2028 |                 goto out_off;
         |                 ~~~~~~~~~~~~~
    2029 |         }
         |         ~
   arch/arm64/net/bpf_jit_comp.c:2010:6: warning: variable 'ro_header' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2010 |         if (ctx.offset == NULL) {
         |             ^~~~~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2160:8: note: uninitialized use occurs here
    2160 |                 if (!ro_header && priv_stack_ptr) {
         |                      ^~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:2010:2: note: remove the 'if' if its condition is always false
    2010 |         if (ctx.offset == NULL) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
    2011 |                 prog = orig_prog;
         |                 ~~~~~~~~~~~~~~~~~
    2012 |                 goto out_off;
         |                 ~~~~~~~~~~~~~
    2013 |         }
         |         ~
   arch/arm64/net/bpf_jit_comp.c:1942:37: note: initialize the variable 'ro_header' to silence this warning
    1942 |         struct bpf_binary_header *ro_header;
         |                                            ^
         |                                             = NULL
   3 warnings generated.


vim +2031 arch/arm64/net/bpf_jit_comp.c

db496944fdaaf2 Alexei Starovoitov    2017-12-14  1936  
d1c55ab5e41fcd Daniel Borkmann       2016-05-13  1937  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1938  {
b2ad54e1533e91 Xu Kuohai             2022-07-11  1939  	int image_size, prog_size, extable_size, extable_align, extable_offset;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1940  	struct bpf_prog *tmp, *orig_prog = prog;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  1941  	struct bpf_binary_header *header;
1dad391daef129 Puranjay Mohan        2024-02-28  1942  	struct bpf_binary_header *ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1943  	struct arm64_jit_data *jit_data;
291f131eb536b5 Puranjay Mohan        2025-07-22  1944  	void __percpu *priv_stack_ptr = NULL;
56ea6a8b4949c6 Daniel Borkmann       2018-05-14  1945  	bool was_classic = bpf_prog_was_classic(prog);
291f131eb536b5 Puranjay Mohan        2025-07-22  1946  	int priv_stack_alloc_sz;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1947  	bool tmp_blinded = false;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1948  	bool extra_pass = false;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1949  	struct jit_ctx ctx;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  1950  	u8 *image_ptr;
1dad391daef129 Puranjay Mohan        2024-02-28  1951  	u8 *ro_image_ptr;
ddbe9ec55039dd Xu Kuohai             2024-09-03  1952  	int body_idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  1953  	int exentry_idx;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1954  
60b58afc96c9df Alexei Starovoitov    2017-12-14  1955  	if (!prog->jit_requested)
26eb042ee4c784 Daniel Borkmann       2016-05-13  1956  		return orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1957  
26eb042ee4c784 Daniel Borkmann       2016-05-13  1958  	tmp = bpf_jit_blind_constants(prog);
26eb042ee4c784 Daniel Borkmann       2016-05-13  1959  	/* If blinding was requested and we failed during blinding,
26eb042ee4c784 Daniel Borkmann       2016-05-13  1960  	 * we must fall back to the interpreter.
26eb042ee4c784 Daniel Borkmann       2016-05-13  1961  	 */
26eb042ee4c784 Daniel Borkmann       2016-05-13  1962  	if (IS_ERR(tmp))
26eb042ee4c784 Daniel Borkmann       2016-05-13  1963  		return orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1964  	if (tmp != prog) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1965  		tmp_blinded = true;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1966  		prog = tmp;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1967  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1968  
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1969  	jit_data = prog->aux->jit_data;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1970  	if (!jit_data) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1971  		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1972  		if (!jit_data) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1973  			prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1974  			goto out;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1975  		}
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1976  		prog->aux->jit_data = jit_data;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1977  	}
291f131eb536b5 Puranjay Mohan        2025-07-22  1978  	priv_stack_ptr = prog->aux->priv_stack_ptr;
291f131eb536b5 Puranjay Mohan        2025-07-22  1979  	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
291f131eb536b5 Puranjay Mohan        2025-07-22  1980  		/* Allocate actual private stack size with verifier-calculated
291f131eb536b5 Puranjay Mohan        2025-07-22  1981  		 * stack size plus two memory guards to protect overflow and
291f131eb536b5 Puranjay Mohan        2025-07-22  1982  		 * underflow.
291f131eb536b5 Puranjay Mohan        2025-07-22  1983  		 */
291f131eb536b5 Puranjay Mohan        2025-07-22  1984  		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
291f131eb536b5 Puranjay Mohan        2025-07-22  1985  				      2 * PRIV_STACK_GUARD_SZ;
291f131eb536b5 Puranjay Mohan        2025-07-22  1986  		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 16, GFP_KERNEL);
291f131eb536b5 Puranjay Mohan        2025-07-22  1987  		if (!priv_stack_ptr) {
291f131eb536b5 Puranjay Mohan        2025-07-22  1988  			prog = orig_prog;
291f131eb536b5 Puranjay Mohan        2025-07-22  1989  			goto out_priv_stack;
291f131eb536b5 Puranjay Mohan        2025-07-22  1990  		}
291f131eb536b5 Puranjay Mohan        2025-07-22  1991  
291f131eb536b5 Puranjay Mohan        2025-07-22  1992  		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
291f131eb536b5 Puranjay Mohan        2025-07-22  1993  		prog->aux->priv_stack_ptr = priv_stack_ptr;
291f131eb536b5 Puranjay Mohan        2025-07-22  1994  	}
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1995  	if (jit_data->ctx.offset) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1996  		ctx = jit_data->ctx;
1dad391daef129 Puranjay Mohan        2024-02-28  1997  		ro_image_ptr = jit_data->ro_image;
1dad391daef129 Puranjay Mohan        2024-02-28  1998  		ro_header = jit_data->ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1999  		header = jit_data->header;
1dad391daef129 Puranjay Mohan        2024-02-28  2000  		image_ptr = (void *)header + ((void *)ro_image_ptr
1dad391daef129 Puranjay Mohan        2024-02-28  2001  						 - (void *)ro_header);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2002  		extra_pass = true;
800834285361dc Jean-Philippe Brucker 2020-07-28  2003  		prog_size = sizeof(u32) * ctx.idx;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2004  		goto skip_init_ctx;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2005  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2006  	memset(&ctx, 0, sizeof(ctx));
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2007  	ctx.prog = prog;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2008  
19f68ed6dc90c9 Aijun Sun             2022-08-04  2009  	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
26eb042ee4c784 Daniel Borkmann       2016-05-13  2010  	if (ctx.offset == NULL) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  2011  		prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2012  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2013  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2014  
4dd31243e30843 Puranjay Mohan        2024-03-25  2015  	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
5d4fa9ec5643a5 Xu Kuohai             2024-08-26  2016  	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
5b3d19b9bd4080 Xu Kuohai             2022-03-21  2017  
291f131eb536b5 Puranjay Mohan        2025-07-22  2018  	if (priv_stack_ptr)
291f131eb536b5 Puranjay Mohan        2025-07-22  2019  		ctx.priv_sp_used = true;
291f131eb536b5 Puranjay Mohan        2025-07-22  2020  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2021  	/* Pass 1: Estimate the maximum image size.
68e4f238b0e9d3 Hou Tao               2022-02-26  2022  	 *
68e4f238b0e9d3 Hou Tao               2022-02-26  2023  	 * BPF line info needs ctx->offset[i] to be the offset of
68e4f238b0e9d3 Hou Tao               2022-02-26  2024  	 * instruction[i] in jited image, so build prologue first.
68e4f238b0e9d3 Hou Tao               2022-02-26  2025  	 */
5d4fa9ec5643a5 Xu Kuohai             2024-08-26  2026  	if (build_prologue(&ctx, was_classic)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  2027  		prog = orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2028  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2029  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2030  
68e4f238b0e9d3 Hou Tao               2022-02-26 @2031  	if (build_body(&ctx, extra_pass)) {
ddb55992b04d97 Zi Shen Lim           2016-06-08  2032  		prog = orig_prog;
ddb55992b04d97 Zi Shen Lim           2016-06-08  2033  		goto out_off;
ddb55992b04d97 Zi Shen Lim           2016-06-08  2034  	}
51c9fbb1b146f3 Zi Shen Lim           2014-12-03  2035  
51c9fbb1b146f3 Zi Shen Lim           2014-12-03  2036  	ctx.epilogue_offset = ctx.idx;
0dfefc2ea2f29c James Morse           2021-12-09  2037  	build_epilogue(&ctx, was_classic);
b2ad54e1533e91 Xu Kuohai             2022-07-11  2038  	build_plt(&ctx);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2039  
b2ad54e1533e91 Xu Kuohai             2022-07-11  2040  	extable_align = __alignof__(struct exception_table_entry);
800834285361dc Jean-Philippe Brucker 2020-07-28  2041  	extable_size = prog->aux->num_exentries *
800834285361dc Jean-Philippe Brucker 2020-07-28  2042  		sizeof(struct exception_table_entry);
800834285361dc Jean-Philippe Brucker 2020-07-28  2043  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2044  	/* Now we know the maximum image size. */
800834285361dc Jean-Philippe Brucker 2020-07-28  2045  	prog_size = sizeof(u32) * ctx.idx;
b2ad54e1533e91 Xu Kuohai             2022-07-11  2046  	/* also allocate space for plt target */
b2ad54e1533e91 Xu Kuohai             2022-07-11  2047  	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
b2ad54e1533e91 Xu Kuohai             2022-07-11  2048  	image_size = extable_offset + extable_size;
1dad391daef129 Puranjay Mohan        2024-02-28  2049  	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
1dad391daef129 Puranjay Mohan        2024-02-28  2050  					      sizeof(u32), &header, &image_ptr,
1dad391daef129 Puranjay Mohan        2024-02-28  2051  					      jit_fill_hole);
1dad391daef129 Puranjay Mohan        2024-02-28  2052  	if (!ro_header) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  2053  		prog = orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2054  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2055  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2056  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2057  	/* Pass 2: Determine jited position and result for each instruction */
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2058  
1dad391daef129 Puranjay Mohan        2024-02-28  2059  	/*
1dad391daef129 Puranjay Mohan        2024-02-28  2060  	 * Use the image(RW) for writing the JITed instructions. But also save
1dad391daef129 Puranjay Mohan        2024-02-28  2061  	 * the ro_image(RX) for calculating the offsets in the image. The RW
1dad391daef129 Puranjay Mohan        2024-02-28  2062  	 * image will be later copied to the RX image from where the program
1dad391daef129 Puranjay Mohan        2024-02-28  2063  	 * will run. The bpf_jit_binary_pack_finalize() will do this copy in the
1dad391daef129 Puranjay Mohan        2024-02-28  2064  	 * final step.
1dad391daef129 Puranjay Mohan        2024-02-28  2065  	 */
425e1ed73e6574 Luc Van Oostenryck    2017-06-28  2066  	ctx.image = (__le32 *)image_ptr;
1dad391daef129 Puranjay Mohan        2024-02-28  2067  	ctx.ro_image = (__le32 *)ro_image_ptr;
800834285361dc Jean-Philippe Brucker 2020-07-28  2068  	if (extable_size)
1dad391daef129 Puranjay Mohan        2024-02-28  2069  		prog->aux->extable = (void *)ro_image_ptr + extable_offset;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2070  skip_init_ctx:
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2071  	ctx.idx = 0;
800834285361dc Jean-Philippe Brucker 2020-07-28  2072  	ctx.exentry_idx = 0;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2073  	ctx.write = true;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  2074  
5d4fa9ec5643a5 Xu Kuohai             2024-08-26  2075  	build_prologue(&ctx, was_classic);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2076  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2077  	/* Record exentry_idx and body_idx before first build_body */
ddbe9ec55039dd Xu Kuohai             2024-09-03  2078  	exentry_idx = ctx.exentry_idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2079  	body_idx = ctx.idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2080  	/* Dont write body instructions to memory for now */
ddbe9ec55039dd Xu Kuohai             2024-09-03  2081  	ctx.write = false;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2082  
8c11ea5ce13da0 Daniel Borkmann       2018-11-26  2083  	if (build_body(&ctx, extra_pass)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  2084  		prog = orig_prog;
1dad391daef129 Puranjay Mohan        2024-02-28  2085  		goto out_free_hdr;
60ef0494f197d4 Daniel Borkmann       2014-09-11  2086  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2087  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2088  	ctx.epilogue_offset = ctx.idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2089  	ctx.exentry_idx = exentry_idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2090  	ctx.idx = body_idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2091  	ctx.write = true;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2092  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2093  	/* Pass 3: Adjust jump offset and write final image */
ddbe9ec55039dd Xu Kuohai             2024-09-03  2094  	if (build_body(&ctx, extra_pass) ||
ddbe9ec55039dd Xu Kuohai             2024-09-03  2095  		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
ddbe9ec55039dd Xu Kuohai             2024-09-03  2096  		prog = orig_prog;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2097  		goto out_free_hdr;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2098  	}
ddbe9ec55039dd Xu Kuohai             2024-09-03  2099  
0dfefc2ea2f29c James Morse           2021-12-09  2100  	build_epilogue(&ctx, was_classic);
b2ad54e1533e91 Xu Kuohai             2022-07-11  2101  	build_plt(&ctx);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2102  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2103  	/* Extra pass to validate JITed code. */
efc9909fdce00a Xu Kuohai             2022-07-11  2104  	if (validate_ctx(&ctx)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  2105  		prog = orig_prog;
1dad391daef129 Puranjay Mohan        2024-02-28  2106  		goto out_free_hdr;
42ff712bc0c3d7 Zi Shen Lim           2016-01-13  2107  	}
42ff712bc0c3d7 Zi Shen Lim           2016-01-13  2108  
ddbe9ec55039dd Xu Kuohai             2024-09-03  2109  	/* update the real prog size */
ddbe9ec55039dd Xu Kuohai             2024-09-03  2110  	prog_size = sizeof(u32) * ctx.idx;
ddbe9ec55039dd Xu Kuohai             2024-09-03  2111  
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2112  	/* And we're done. */
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2113  	if (bpf_jit_enable > 1)
800834285361dc Jean-Philippe Brucker 2020-07-28  2114  		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2115  
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2116  	if (!prog->is_func || extra_pass) {
ddbe9ec55039dd Xu Kuohai             2024-09-03  2117  		/* The jited image may shrink since the jited result for
ddbe9ec55039dd Xu Kuohai             2024-09-03  2118  		 * BPF_CALL to subprog may be changed from indirect call
ddbe9ec55039dd Xu Kuohai             2024-09-03  2119  		 * to direct call.
ddbe9ec55039dd Xu Kuohai             2024-09-03  2120  		 */
ddbe9ec55039dd Xu Kuohai             2024-09-03  2121  		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
ddbe9ec55039dd Xu Kuohai             2024-09-03  2122  			pr_err_once("multi-func JIT bug %d > %d\n",
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2123  				    ctx.idx, jit_data->ctx.idx);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2124  			prog->bpf_func = NULL;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2125  			prog->jited = 0;
10f3b29c65bb2f Eric Dumazet          2022-05-31  2126  			prog->jited_len = 0;
1dad391daef129 Puranjay Mohan        2024-02-28  2127  			goto out_free_hdr;
1dad391daef129 Puranjay Mohan        2024-02-28  2128  		}
9919c5c98cb25d Rafael Passos         2024-06-14  2129  		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
1dad391daef129 Puranjay Mohan        2024-02-28  2130  			/* ro_header has been freed */
1dad391daef129 Puranjay Mohan        2024-02-28  2131  			ro_header = NULL;
1dad391daef129 Puranjay Mohan        2024-02-28  2132  			prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2133  			goto out_off;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2134  		}
1dad391daef129 Puranjay Mohan        2024-02-28  2135  		/*
1dad391daef129 Puranjay Mohan        2024-02-28  2136  		 * The instructions have now been copied to the ROX region from
1dad391daef129 Puranjay Mohan        2024-02-28  2137  		 * where they will execute. Now the data cache has to be cleaned to
1dad391daef129 Puranjay Mohan        2024-02-28  2138  		 * the PoU and the I-cache has to be invalidated for the VAs.
1dad391daef129 Puranjay Mohan        2024-02-28  2139  		 */
1dad391daef129 Puranjay Mohan        2024-02-28  2140  		bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2141  	} else {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2142  		jit_data->ctx = ctx;
1dad391daef129 Puranjay Mohan        2024-02-28  2143  		jit_data->ro_image = ro_image_ptr;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2144  		jit_data->header = header;
1dad391daef129 Puranjay Mohan        2024-02-28  2145  		jit_data->ro_header = ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2146  	}
1dad391daef129 Puranjay Mohan        2024-02-28  2147  
1dad391daef129 Puranjay Mohan        2024-02-28  2148  	prog->bpf_func = (void *)ctx.ro_image;
a91263d520246b Daniel Borkmann       2015-09-30  2149  	prog->jited = 1;
800834285361dc Jean-Philippe Brucker 2020-07-28  2150  	prog->jited_len = prog_size;
26eb042ee4c784 Daniel Borkmann       2016-05-13  2151  
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2152  	if (!prog->is_func || extra_pass) {
dda7596c109fc3 Hou Tao               2022-02-26  2153  		int i;
dda7596c109fc3 Hou Tao               2022-02-26  2154  
dda7596c109fc3 Hou Tao               2022-02-26  2155  		/* offset[prog->len] is the size of program */
dda7596c109fc3 Hou Tao               2022-02-26  2156  		for (i = 0; i <= prog->len; i++)
dda7596c109fc3 Hou Tao               2022-02-26  2157  			ctx.offset[i] *= AARCH64_INSN_SIZE;
32f6865c7aa3c4 Ilias Apalodimas      2020-09-17  2158  		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
26eb042ee4c784 Daniel Borkmann       2016-05-13  2159  out_off:
291f131eb536b5 Puranjay Mohan        2025-07-22  2160  		if (!ro_header && priv_stack_ptr) {
291f131eb536b5 Puranjay Mohan        2025-07-22  2161  			free_percpu(priv_stack_ptr);
291f131eb536b5 Puranjay Mohan        2025-07-22  2162  			prog->aux->priv_stack_ptr = NULL;
291f131eb536b5 Puranjay Mohan        2025-07-22  2163  		}
19f68ed6dc90c9 Aijun Sun             2022-08-04  2164  		kvfree(ctx.offset);
291f131eb536b5 Puranjay Mohan        2025-07-22  2165  out_priv_stack:
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2166  		kfree(jit_data);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2167  		prog->aux->jit_data = NULL;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  2168  	}
26eb042ee4c784 Daniel Borkmann       2016-05-13  2169  out:
26eb042ee4c784 Daniel Borkmann       2016-05-13  2170  	if (tmp_blinded)
26eb042ee4c784 Daniel Borkmann       2016-05-13  2171  		bpf_jit_prog_release_other(prog, prog == orig_prog ?
26eb042ee4c784 Daniel Borkmann       2016-05-13  2172  					   tmp : orig_prog);
d1c55ab5e41fcd Daniel Borkmann       2016-05-13  2173  	return prog;
1dad391daef129 Puranjay Mohan        2024-02-28  2174  
1dad391daef129 Puranjay Mohan        2024-02-28  2175  out_free_hdr:
1dad391daef129 Puranjay Mohan        2024-02-28  2176  	if (header) {
1dad391daef129 Puranjay Mohan        2024-02-28  2177  		bpf_arch_text_copy(&ro_header->size, &header->size,
1dad391daef129 Puranjay Mohan        2024-02-28  2178  				   sizeof(header->size));
1dad391daef129 Puranjay Mohan        2024-02-28  2179  		bpf_jit_binary_pack_free(ro_header, header);
1dad391daef129 Puranjay Mohan        2024-02-28  2180  	}
1dad391daef129 Puranjay Mohan        2024-02-28  2181  	goto out_off;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  2182  }
91fc957c9b1d6c Ard Biesheuvel        2018-11-23  2183  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

