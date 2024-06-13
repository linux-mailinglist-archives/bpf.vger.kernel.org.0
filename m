Return-Path: <bpf+bounces-32067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96660906AFE
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055402838FA
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CE143724;
	Thu, 13 Jun 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRZjw/Ne"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534E1411E0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278138; cv=none; b=cwLPOW8y1C9FsKlOwxf++ooR+CuWbwkSUzqcSZFOvNpSUsVNyCFTU36QeXtdTXRIp6m3g+yFy3Ql/2xl76dUMpPBVbNTezuQGVAUNujHwHvagIaB4oU96MVSz+flF9CLCtZ1EiPZxHlYC0MAitBq735CoDUI1GZxZ5jfVgQj4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278138; c=relaxed/simple;
	bh=jpGBlXHjOdJh6xprJQRmwhCdo3MJxJNJgoqNIn7vcow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjT9qcgsHBKDkeVhpyxsP+w+YP1ZGiEFm70oOSr4/o35ELfrG3eAkuRYhlqJRpRAt6dPWjR03oLvaoFJOV7y++zluOhFZb+WKzVhKqBSpXK5+jm9v5gAfawXPPyunDAtSR9U3lGipfQd1DCW8bS3CoQyIugK7GwP9h7vOPvZ7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRZjw/Ne; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718278136; x=1749814136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpGBlXHjOdJh6xprJQRmwhCdo3MJxJNJgoqNIn7vcow=;
  b=SRZjw/Ne7lYTMHIxKBxsRL3sUTOBhJm3aDKxAiP0LT3U3R3A2adxRuNE
   +/TI6cd9WmkCHcgVrKvXajeGJJE+mRiMCyvl5tfqiXTOnsyBEtOqs1DDn
   0Yup2Z26iMEXkWkFHU3/wDSR+mbYWdjTaZUrVC36VBrO4WnAXoEw99cMX
   QRSZhkOG29wWfdZlAPb95frDprRRT2FfvQdMA52ZQfY/bn5mXzgQOgCZ3
   bQksB0kNWZCp3zlb0VozjXQ8HARCB122Y6BL73uwJloD9REXgNFxPWjR/
   icvR2MEiT0sKOIe7zJ4sEAWbUFkdMfpjMSOP50nv1JziQNTJeqlHmGjmS
   g==;
X-CSE-ConnectionGUID: NSWYt2P1TRa03cOAFp1wOg==
X-CSE-MsgGUID: XDU61Jv5TS6kviknpY8zjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26512233"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="26512233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 04:28:56 -0700
X-CSE-ConnectionGUID: zaPqFEh/Qj2OGUIuDq5C9A==
X-CSE-MsgGUID: NfBlG5GEQ9OY16RKjJ/tJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40229997"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Jun 2024 04:28:52 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHidO-0002Xs-0A;
	Thu, 13 Jun 2024 11:28:50 +0000
Date: Thu, 13 Jun 2024 19:27:50 +0800
From: kernel test robot <lkp@intel.com>
To: Rafael Passos <rafael@rcpassos.me>, davem@davemloft.net,
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: remove unused parameter in
 bpf_jit_binary_pack_finalize
Message-ID: <202406131947.L4MhzX6z-lkp@intel.com>
References: <7eaed3dc-28e5-409f-8f73-a1bf8acc2937@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eaed3dc-28e5-409f-8f73-a1bf8acc2937@smtp-relay.sendinblue.com>

Hi Rafael,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-Passos/bpf-remove-unused-parameter-in-__bpf_free_used_btfs/20240613-110048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/7eaed3dc-28e5-409f-8f73-a1bf8acc2937%40smtp-relay.sendinblue.com
patch subject: [PATCH bpf-next 1/3] bpf: remove unused parameter in bpf_jit_binary_pack_finalize
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240613/202406131947.L4MhzX6z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240613/202406131947.L4MhzX6z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406131947.L4MhzX6z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/bug.h:26,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from arch/arm64/net/bpf_jit_comp.c:11:
   arch/arm64/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
>> arch/arm64/net/bpf_jit_comp.c:1832:58: error: passing argument 1 of 'bpf_jit_binary_pack_finalize' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1832 |                 if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
         |                                                          ^~~~
         |                                                          |
         |                                                          struct bpf_prog *
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   In file included from arch/arm64/net/bpf_jit_comp.c:12:
   include/linux/filter.h:1132:60: note: expected 'struct bpf_binary_header *' but argument is of type 'struct bpf_prog *'
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>> arch/arm64/net/bpf_jit_comp.c:1832:29: error: too many arguments to function 'bpf_jit_binary_pack_finalize'
    1832 |                 if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/filter.h:1132:5: note: declared here
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bpf_jit_binary_pack_finalize +1832 arch/arm64/net/bpf_jit_comp.c

db496944fdaaf2 Alexei Starovoitov    2017-12-14  1685  
d1c55ab5e41fcd Daniel Borkmann       2016-05-13  1686  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1687  {
b2ad54e1533e91 Xu Kuohai             2022-07-11  1688  	int image_size, prog_size, extable_size, extable_align, extable_offset;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1689  	struct bpf_prog *tmp, *orig_prog = prog;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  1690  	struct bpf_binary_header *header;
1dad391daef129 Puranjay Mohan        2024-02-28  1691  	struct bpf_binary_header *ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1692  	struct arm64_jit_data *jit_data;
56ea6a8b4949c6 Daniel Borkmann       2018-05-14  1693  	bool was_classic = bpf_prog_was_classic(prog);
26eb042ee4c784 Daniel Borkmann       2016-05-13  1694  	bool tmp_blinded = false;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1695  	bool extra_pass = false;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1696  	struct jit_ctx ctx;
339af577ec05c8 Puranjay Mohan        2024-03-25  1697  	u64 arena_vm_start;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  1698  	u8 *image_ptr;
1dad391daef129 Puranjay Mohan        2024-02-28  1699  	u8 *ro_image_ptr;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1700  
60b58afc96c9df Alexei Starovoitov    2017-12-14  1701  	if (!prog->jit_requested)
26eb042ee4c784 Daniel Borkmann       2016-05-13  1702  		return orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1703  
26eb042ee4c784 Daniel Borkmann       2016-05-13  1704  	tmp = bpf_jit_blind_constants(prog);
26eb042ee4c784 Daniel Borkmann       2016-05-13  1705  	/* If blinding was requested and we failed during blinding,
26eb042ee4c784 Daniel Borkmann       2016-05-13  1706  	 * we must fall back to the interpreter.
26eb042ee4c784 Daniel Borkmann       2016-05-13  1707  	 */
26eb042ee4c784 Daniel Borkmann       2016-05-13  1708  	if (IS_ERR(tmp))
26eb042ee4c784 Daniel Borkmann       2016-05-13  1709  		return orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1710  	if (tmp != prog) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1711  		tmp_blinded = true;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1712  		prog = tmp;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1713  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1714  
339af577ec05c8 Puranjay Mohan        2024-03-25  1715  	arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1716  	jit_data = prog->aux->jit_data;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1717  	if (!jit_data) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1718  		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1719  		if (!jit_data) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1720  			prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1721  			goto out;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1722  		}
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1723  		prog->aux->jit_data = jit_data;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1724  	}
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1725  	if (jit_data->ctx.offset) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1726  		ctx = jit_data->ctx;
1dad391daef129 Puranjay Mohan        2024-02-28  1727  		ro_image_ptr = jit_data->ro_image;
1dad391daef129 Puranjay Mohan        2024-02-28  1728  		ro_header = jit_data->ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1729  		header = jit_data->header;
1dad391daef129 Puranjay Mohan        2024-02-28  1730  		image_ptr = (void *)header + ((void *)ro_image_ptr
1dad391daef129 Puranjay Mohan        2024-02-28  1731  						 - (void *)ro_header);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1732  		extra_pass = true;
800834285361dc Jean-Philippe Brucker 2020-07-28  1733  		prog_size = sizeof(u32) * ctx.idx;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1734  		goto skip_init_ctx;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1735  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1736  	memset(&ctx, 0, sizeof(ctx));
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1737  	ctx.prog = prog;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1738  
19f68ed6dc90c9 Aijun Sun             2022-08-04  1739  	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
26eb042ee4c784 Daniel Borkmann       2016-05-13  1740  	if (ctx.offset == NULL) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1741  		prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1742  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1743  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1744  
5b3d19b9bd4080 Xu Kuohai             2022-03-21  1745  	ctx.fpb_offset = find_fpb_offset(prog);
4dd31243e30843 Puranjay Mohan        2024-03-25  1746  	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
5b3d19b9bd4080 Xu Kuohai             2022-03-21  1747  
68e4f238b0e9d3 Hou Tao               2022-02-26  1748  	/*
68e4f238b0e9d3 Hou Tao               2022-02-26  1749  	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
68e4f238b0e9d3 Hou Tao               2022-02-26  1750  	 *
68e4f238b0e9d3 Hou Tao               2022-02-26  1751  	 * BPF line info needs ctx->offset[i] to be the offset of
68e4f238b0e9d3 Hou Tao               2022-02-26  1752  	 * instruction[i] in jited image, so build prologue first.
68e4f238b0e9d3 Hou Tao               2022-02-26  1753  	 */
339af577ec05c8 Puranjay Mohan        2024-03-25  1754  	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
339af577ec05c8 Puranjay Mohan        2024-03-25  1755  			   arena_vm_start)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1756  		prog = orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1757  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1758  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1759  
68e4f238b0e9d3 Hou Tao               2022-02-26  1760  	if (build_body(&ctx, extra_pass)) {
ddb55992b04d97 Zi Shen Lim           2016-06-08  1761  		prog = orig_prog;
ddb55992b04d97 Zi Shen Lim           2016-06-08  1762  		goto out_off;
ddb55992b04d97 Zi Shen Lim           2016-06-08  1763  	}
51c9fbb1b146f3 Zi Shen Lim           2014-12-03  1764  
51c9fbb1b146f3 Zi Shen Lim           2014-12-03  1765  	ctx.epilogue_offset = ctx.idx;
22fc0e80aeb5c0 Puranjay Mohan        2024-02-01  1766  	build_epilogue(&ctx, prog->aux->exception_cb);
b2ad54e1533e91 Xu Kuohai             2022-07-11  1767  	build_plt(&ctx);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1768  
b2ad54e1533e91 Xu Kuohai             2022-07-11  1769  	extable_align = __alignof__(struct exception_table_entry);
800834285361dc Jean-Philippe Brucker 2020-07-28  1770  	extable_size = prog->aux->num_exentries *
800834285361dc Jean-Philippe Brucker 2020-07-28  1771  		sizeof(struct exception_table_entry);
800834285361dc Jean-Philippe Brucker 2020-07-28  1772  
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1773  	/* Now we know the actual image size. */
800834285361dc Jean-Philippe Brucker 2020-07-28  1774  	prog_size = sizeof(u32) * ctx.idx;
b2ad54e1533e91 Xu Kuohai             2022-07-11  1775  	/* also allocate space for plt target */
b2ad54e1533e91 Xu Kuohai             2022-07-11  1776  	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
b2ad54e1533e91 Xu Kuohai             2022-07-11  1777  	image_size = extable_offset + extable_size;
1dad391daef129 Puranjay Mohan        2024-02-28  1778  	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
1dad391daef129 Puranjay Mohan        2024-02-28  1779  					      sizeof(u32), &header, &image_ptr,
1dad391daef129 Puranjay Mohan        2024-02-28  1780  					      jit_fill_hole);
1dad391daef129 Puranjay Mohan        2024-02-28  1781  	if (!ro_header) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1782  		prog = orig_prog;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1783  		goto out_off;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1784  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1785  
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1786  	/* 2. Now, the actual pass. */
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1787  
1dad391daef129 Puranjay Mohan        2024-02-28  1788  	/*
1dad391daef129 Puranjay Mohan        2024-02-28  1789  	 * Use the image(RW) for writing the JITed instructions. But also save
1dad391daef129 Puranjay Mohan        2024-02-28  1790  	 * the ro_image(RX) for calculating the offsets in the image. The RW
1dad391daef129 Puranjay Mohan        2024-02-28  1791  	 * image will be later copied to the RX image from where the program
1dad391daef129 Puranjay Mohan        2024-02-28  1792  	 * will run. The bpf_jit_binary_pack_finalize() will do this copy in the
1dad391daef129 Puranjay Mohan        2024-02-28  1793  	 * final step.
1dad391daef129 Puranjay Mohan        2024-02-28  1794  	 */
425e1ed73e6574 Luc Van Oostenryck    2017-06-28  1795  	ctx.image = (__le32 *)image_ptr;
1dad391daef129 Puranjay Mohan        2024-02-28  1796  	ctx.ro_image = (__le32 *)ro_image_ptr;
800834285361dc Jean-Philippe Brucker 2020-07-28  1797  	if (extable_size)
1dad391daef129 Puranjay Mohan        2024-02-28  1798  		prog->aux->extable = (void *)ro_image_ptr + extable_offset;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1799  skip_init_ctx:
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1800  	ctx.idx = 0;
800834285361dc Jean-Philippe Brucker 2020-07-28  1801  	ctx.exentry_idx = 0;
b569c1c622c5e6 Daniel Borkmann       2014-09-16  1802  
339af577ec05c8 Puranjay Mohan        2024-03-25  1803  	build_prologue(&ctx, was_classic, prog->aux->exception_cb, arena_vm_start);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1804  
8c11ea5ce13da0 Daniel Borkmann       2018-11-26  1805  	if (build_body(&ctx, extra_pass)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1806  		prog = orig_prog;
1dad391daef129 Puranjay Mohan        2024-02-28  1807  		goto out_free_hdr;
60ef0494f197d4 Daniel Borkmann       2014-09-11  1808  	}
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1809  
22fc0e80aeb5c0 Puranjay Mohan        2024-02-01  1810  	build_epilogue(&ctx, prog->aux->exception_cb);
b2ad54e1533e91 Xu Kuohai             2022-07-11  1811  	build_plt(&ctx);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1812  
42ff712bc0c3d7 Zi Shen Lim           2016-01-13  1813  	/* 3. Extra pass to validate JITed code. */
efc9909fdce00a Xu Kuohai             2022-07-11  1814  	if (validate_ctx(&ctx)) {
26eb042ee4c784 Daniel Borkmann       2016-05-13  1815  		prog = orig_prog;
1dad391daef129 Puranjay Mohan        2024-02-28  1816  		goto out_free_hdr;
42ff712bc0c3d7 Zi Shen Lim           2016-01-13  1817  	}
42ff712bc0c3d7 Zi Shen Lim           2016-01-13  1818  
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1819  	/* And we're done. */
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1820  	if (bpf_jit_enable > 1)
800834285361dc Jean-Philippe Brucker 2020-07-28  1821  		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1822  
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1823  	if (!prog->is_func || extra_pass) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1824  		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1825  			pr_err_once("multi-func JIT bug %d != %d\n",
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1826  				    ctx.idx, jit_data->ctx.idx);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1827  			prog->bpf_func = NULL;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1828  			prog->jited = 0;
10f3b29c65bb2f Eric Dumazet          2022-05-31  1829  			prog->jited_len = 0;
1dad391daef129 Puranjay Mohan        2024-02-28  1830  			goto out_free_hdr;
1dad391daef129 Puranjay Mohan        2024-02-28  1831  		}
1dad391daef129 Puranjay Mohan        2024-02-28 @1832  		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
1dad391daef129 Puranjay Mohan        2024-02-28  1833  							 header))) {
1dad391daef129 Puranjay Mohan        2024-02-28  1834  			/* ro_header has been freed */
1dad391daef129 Puranjay Mohan        2024-02-28  1835  			ro_header = NULL;
1dad391daef129 Puranjay Mohan        2024-02-28  1836  			prog = orig_prog;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1837  			goto out_off;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1838  		}
1dad391daef129 Puranjay Mohan        2024-02-28  1839  		/*
1dad391daef129 Puranjay Mohan        2024-02-28  1840  		 * The instructions have now been copied to the ROX region from
1dad391daef129 Puranjay Mohan        2024-02-28  1841  		 * where they will execute. Now the data cache has to be cleaned to
1dad391daef129 Puranjay Mohan        2024-02-28  1842  		 * the PoU and the I-cache has to be invalidated for the VAs.
1dad391daef129 Puranjay Mohan        2024-02-28  1843  		 */
1dad391daef129 Puranjay Mohan        2024-02-28  1844  		bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1845  	} else {
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1846  		jit_data->ctx = ctx;
1dad391daef129 Puranjay Mohan        2024-02-28  1847  		jit_data->ro_image = ro_image_ptr;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1848  		jit_data->header = header;
1dad391daef129 Puranjay Mohan        2024-02-28  1849  		jit_data->ro_header = ro_header;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1850  	}
1dad391daef129 Puranjay Mohan        2024-02-28  1851  
1dad391daef129 Puranjay Mohan        2024-02-28  1852  	prog->bpf_func = (void *)ctx.ro_image;
a91263d520246b Daniel Borkmann       2015-09-30  1853  	prog->jited = 1;
800834285361dc Jean-Philippe Brucker 2020-07-28  1854  	prog->jited_len = prog_size;
26eb042ee4c784 Daniel Borkmann       2016-05-13  1855  
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1856  	if (!prog->is_func || extra_pass) {
dda7596c109fc3 Hou Tao               2022-02-26  1857  		int i;
dda7596c109fc3 Hou Tao               2022-02-26  1858  
dda7596c109fc3 Hou Tao               2022-02-26  1859  		/* offset[prog->len] is the size of program */
dda7596c109fc3 Hou Tao               2022-02-26  1860  		for (i = 0; i <= prog->len; i++)
dda7596c109fc3 Hou Tao               2022-02-26  1861  			ctx.offset[i] *= AARCH64_INSN_SIZE;
32f6865c7aa3c4 Ilias Apalodimas      2020-09-17  1862  		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
26eb042ee4c784 Daniel Borkmann       2016-05-13  1863  out_off:
19f68ed6dc90c9 Aijun Sun             2022-08-04  1864  		kvfree(ctx.offset);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1865  		kfree(jit_data);
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1866  		prog->aux->jit_data = NULL;
db496944fdaaf2 Alexei Starovoitov    2017-12-14  1867  	}
26eb042ee4c784 Daniel Borkmann       2016-05-13  1868  out:
26eb042ee4c784 Daniel Borkmann       2016-05-13  1869  	if (tmp_blinded)
26eb042ee4c784 Daniel Borkmann       2016-05-13  1870  		bpf_jit_prog_release_other(prog, prog == orig_prog ?
26eb042ee4c784 Daniel Borkmann       2016-05-13  1871  					   tmp : orig_prog);
d1c55ab5e41fcd Daniel Borkmann       2016-05-13  1872  	return prog;
1dad391daef129 Puranjay Mohan        2024-02-28  1873  
1dad391daef129 Puranjay Mohan        2024-02-28  1874  out_free_hdr:
1dad391daef129 Puranjay Mohan        2024-02-28  1875  	if (header) {
1dad391daef129 Puranjay Mohan        2024-02-28  1876  		bpf_arch_text_copy(&ro_header->size, &header->size,
1dad391daef129 Puranjay Mohan        2024-02-28  1877  				   sizeof(header->size));
1dad391daef129 Puranjay Mohan        2024-02-28  1878  		bpf_jit_binary_pack_free(ro_header, header);
1dad391daef129 Puranjay Mohan        2024-02-28  1879  	}
1dad391daef129 Puranjay Mohan        2024-02-28  1880  	goto out_off;
e54bcde3d69d40 Zi Shen Lim           2014-08-26  1881  }
91fc957c9b1d6c Ard Biesheuvel        2018-11-23  1882  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

