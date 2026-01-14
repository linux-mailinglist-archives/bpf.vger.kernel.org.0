Return-Path: <bpf+bounces-78938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31491D20498
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FAA2302E71A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06142441A6;
	Wed, 14 Jan 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR41azQl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241A3A4F23;
	Wed, 14 Jan 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409229; cv=none; b=V2htGhuAZ/eDK3ye0cF2cO/uSM7xEZTN/r8d1QVpR4EnYo/yoVRPX7Dbs8+A0STnP8oiWCyq4Xqg4JnMwAflyONYZyU1jY3Zyli5ul/Bo2Gc1Li8BNsbv1n3WnUEMmViDeCynMsOQXkxvqVaNEUWw8JiPGXb2yXLbNj6ruj++9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409229; c=relaxed/simple;
	bh=EzycDMpq2jHVOqqH80bCxoEYvUe/tN0Q/0cmWc3xYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XezJtgffqHUdCmIUckyDOkaWqeQktLjKV+ec/5159e+Z4Ot+JVjBSdtmYqdTeWv/a2MDZyEm9Xz5YHnsnqDiiGlyg3araPHaGFRp12B5Dv/IEBBJU2UC/1ITa7uLQd1aUlY9RYmCQRGX6x0DcRAo09BFd+Wv5zEOExJv74a9Htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR41azQl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768409227; x=1799945227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EzycDMpq2jHVOqqH80bCxoEYvUe/tN0Q/0cmWc3xYEo=;
  b=PR41azQlfBxGawLtbYKy1ntX+u4LPNDmEAaNBdH841HRRPYAx6qqM2S1
   s7ADCgxYshA8c5DtDVXduYChua5d/LuIIprSqb4xQyCXrg5/byWiYuCRn
   ni4rElRgSReS6DNksZabDjWG2zUoUPgdmYggdzQUmP5oZinON9jAo8RAe
   kNJY9z5Hmvf91Uj0SbvSCDY5VUGu7UtX1uoR8v3ZktRSIkW/1vjnYN+6x
   e7YbXx6Ev7xrxF+MKpf2BKAcW1wH3IL+AQRNmhjoX1STcQuFRqNUm7NR8
   zNJQJ2Om3eDe3WvjDe4pcTYqseZB0Muv4olFzKDNURIV6WVZpKpfH9XMX
   g==;
X-CSE-ConnectionGUID: oB9svY36TomZLZ8IXMwcIA==
X-CSE-MsgGUID: CKKyV1s2S7anb2I1kaS40w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80433682"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="80433682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:47:05 -0800
X-CSE-ConnectionGUID: cM7znGc7Q2G6xSzcbsfusQ==
X-CSE-MsgGUID: Lu3opdRzTP+yYXUyMxmeiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209771997"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Jan 2026 08:47:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg41L-00000000GfS-0sEs;
	Wed, 14 Jan 2026 16:46:59 +0000
Date: Thu, 15 Jan 2026 00:46:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf, x86: Emit ENDBR for indirect jump
 targets
Message-ID: <202601150016.x24DRk9R-lkp@intel.com>
References: <20260114093914.2403982-4-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114093914.2403982-4-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Fix-an-off-by-one-error-in-check_indirect_jump/20260114-172632
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260114093914.2403982-4-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next v4 3/4] bpf, x86: Emit ENDBR for indirect jump targets
config: x86_64-buildonly-randconfig-002-20260114 (https://download.01.org/0day-ci/archive/20260115/202601150016.x24DRk9R-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601150016.x24DRk9R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601150016.x24DRk9R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp.c: In function 'do_jit':
>> arch/x86/net/bpf_jit_comp.c:1737:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1737 |                         EMIT_ENDBR();
         |                                     ^


vim +/if +1737 arch/x86/net/bpf_jit_comp.c

  1650	
  1651	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1652			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1653	{
  1654		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1655		struct bpf_insn *insn = bpf_prog->insnsi;
  1656		bool callee_regs_used[4] = {};
  1657		int insn_cnt = bpf_prog->len;
  1658		bool seen_exit = false;
  1659		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1660		void __percpu *priv_frame_ptr = NULL;
  1661		u64 arena_vm_start, user_vm_start;
  1662		void __percpu *priv_stack_ptr;
  1663		int i, excnt = 0;
  1664		int ilen, proglen = 0;
  1665		u8 *prog = temp;
  1666		u32 stack_depth;
  1667		int err;
  1668	
  1669		stack_depth = bpf_prog->aux->stack_depth;
  1670		priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
  1671		if (priv_stack_ptr) {
  1672			priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
  1673			stack_depth = 0;
  1674		}
  1675	
  1676		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1677		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1678	
  1679		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1680	
  1681		emit_prologue(&prog, image, stack_depth,
  1682			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1683			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1684	
  1685		bpf_prog->aux->ksym.fp_start = prog - temp;
  1686	
  1687		/* Exception callback will clobber callee regs for its own use, and
  1688		 * restore the original callee regs from main prog's stack frame.
  1689		 */
  1690		if (bpf_prog->aux->exception_boundary) {
  1691			/* We also need to save r12, which is not mapped to any BPF
  1692			 * register, as we throw after entry into the kernel, which may
  1693			 * overwrite r12.
  1694			 */
  1695			push_r12(&prog);
  1696			push_callee_regs(&prog, all_callee_regs_used);
  1697		} else {
  1698			if (arena_vm_start)
  1699				push_r12(&prog);
  1700			push_callee_regs(&prog, callee_regs_used);
  1701		}
  1702		if (arena_vm_start)
  1703			emit_mov_imm64(&prog, X86_REG_R12,
  1704				       arena_vm_start >> 32, (u32) arena_vm_start);
  1705	
  1706		if (priv_frame_ptr)
  1707			emit_priv_frame_ptr(&prog, priv_frame_ptr);
  1708	
  1709		ilen = prog - temp;
  1710		if (rw_image)
  1711			memcpy(rw_image + proglen, temp, ilen);
  1712		proglen += ilen;
  1713		addrs[0] = proglen;
  1714		prog = temp;
  1715	
  1716		for (i = 1; i <= insn_cnt; i++, insn++) {
  1717			const s32 imm32 = insn->imm;
  1718			u32 dst_reg = insn->dst_reg;
  1719			u32 src_reg = insn->src_reg;
  1720			u8 b2 = 0, b3 = 0;
  1721			u8 *start_of_ldx;
  1722			s64 jmp_offset;
  1723			s16 insn_off;
  1724			u8 jmp_cond;
  1725			u8 *func;
  1726			int nops;
  1727	
  1728			if (priv_frame_ptr) {
  1729				if (src_reg == BPF_REG_FP)
  1730					src_reg = X86_REG_R9;
  1731	
  1732				if (dst_reg == BPF_REG_FP)
  1733					dst_reg = X86_REG_R9;
  1734			}
  1735	
  1736			if (bpf_insn_is_indirect_target(bpf_prog, i - 1))
> 1737				EMIT_ENDBR();
  1738	
  1739			switch (insn->code) {
  1740				/* ALU */
  1741			case BPF_ALU | BPF_ADD | BPF_X:
  1742			case BPF_ALU | BPF_SUB | BPF_X:
  1743			case BPF_ALU | BPF_AND | BPF_X:
  1744			case BPF_ALU | BPF_OR | BPF_X:
  1745			case BPF_ALU | BPF_XOR | BPF_X:
  1746			case BPF_ALU64 | BPF_ADD | BPF_X:
  1747			case BPF_ALU64 | BPF_SUB | BPF_X:
  1748			case BPF_ALU64 | BPF_AND | BPF_X:
  1749			case BPF_ALU64 | BPF_OR | BPF_X:
  1750			case BPF_ALU64 | BPF_XOR | BPF_X:
  1751				maybe_emit_mod(&prog, dst_reg, src_reg,
  1752					       BPF_CLASS(insn->code) == BPF_ALU64);
  1753				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1754				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1755				break;
  1756	
  1757			case BPF_ALU64 | BPF_MOV | BPF_X:
  1758				if (insn_is_cast_user(insn)) {
  1759					if (dst_reg != src_reg)
  1760						/* 32-bit mov */
  1761						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1762					/* shl dst_reg, 32 */
  1763					maybe_emit_1mod(&prog, dst_reg, true);
  1764					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1765	
  1766					/* or dst_reg, user_vm_start */
  1767					maybe_emit_1mod(&prog, dst_reg, true);
  1768					if (is_axreg(dst_reg))
  1769						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1770					else
  1771						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1772	
  1773					/* rol dst_reg, 32 */
  1774					maybe_emit_1mod(&prog, dst_reg, true);
  1775					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1776	
  1777					/* xor r11, r11 */
  1778					EMIT3(0x4D, 0x31, 0xDB);
  1779	
  1780					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1781					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1782					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1783	
  1784					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1785					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1786					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1787					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1788					break;
  1789				} else if (insn_is_mov_percpu_addr(insn)) {
  1790					/* mov <dst>, <src> (if necessary) */
  1791					EMIT_mov(dst_reg, src_reg);
  1792	#ifdef CONFIG_SMP
  1793					/* add <dst>, gs:[<off>] */
  1794					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1795					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1796					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1797	#endif
  1798					break;
  1799				}
  1800				fallthrough;
  1801			case BPF_ALU | BPF_MOV | BPF_X:
  1802				if (insn->off == 0)
  1803					emit_mov_reg(&prog,
  1804						     BPF_CLASS(insn->code) == BPF_ALU64,
  1805						     dst_reg, src_reg);
  1806				else
  1807					emit_movsx_reg(&prog, insn->off,
  1808						       BPF_CLASS(insn->code) == BPF_ALU64,
  1809						       dst_reg, src_reg);
  1810				break;
  1811	
  1812				/* neg dst */
  1813			case BPF_ALU | BPF_NEG:
  1814			case BPF_ALU64 | BPF_NEG:
  1815				maybe_emit_1mod(&prog, dst_reg,
  1816						BPF_CLASS(insn->code) == BPF_ALU64);
  1817				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1818				break;
  1819	
  1820			case BPF_ALU | BPF_ADD | BPF_K:
  1821			case BPF_ALU | BPF_SUB | BPF_K:
  1822			case BPF_ALU | BPF_AND | BPF_K:
  1823			case BPF_ALU | BPF_OR | BPF_K:
  1824			case BPF_ALU | BPF_XOR | BPF_K:
  1825			case BPF_ALU64 | BPF_ADD | BPF_K:
  1826			case BPF_ALU64 | BPF_SUB | BPF_K:
  1827			case BPF_ALU64 | BPF_AND | BPF_K:
  1828			case BPF_ALU64 | BPF_OR | BPF_K:
  1829			case BPF_ALU64 | BPF_XOR | BPF_K:
  1830				maybe_emit_1mod(&prog, dst_reg,
  1831						BPF_CLASS(insn->code) == BPF_ALU64);
  1832	
  1833				/*
  1834				 * b3 holds 'normal' opcode, b2 short form only valid
  1835				 * in case dst is eax/rax.
  1836				 */
  1837				switch (BPF_OP(insn->code)) {
  1838				case BPF_ADD:
  1839					b3 = 0xC0;
  1840					b2 = 0x05;
  1841					break;
  1842				case BPF_SUB:
  1843					b3 = 0xE8;
  1844					b2 = 0x2D;
  1845					break;
  1846				case BPF_AND:
  1847					b3 = 0xE0;
  1848					b2 = 0x25;
  1849					break;
  1850				case BPF_OR:
  1851					b3 = 0xC8;
  1852					b2 = 0x0D;
  1853					break;
  1854				case BPF_XOR:
  1855					b3 = 0xF0;
  1856					b2 = 0x35;
  1857					break;
  1858				}
  1859	
  1860				if (is_imm8(imm32))
  1861					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1862				else if (is_axreg(dst_reg))
  1863					EMIT1_off32(b2, imm32);
  1864				else
  1865					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1866				break;
  1867	
  1868			case BPF_ALU64 | BPF_MOV | BPF_K:
  1869			case BPF_ALU | BPF_MOV | BPF_K:
  1870				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1871					       dst_reg, imm32);
  1872				break;
  1873	
  1874			case BPF_LD | BPF_IMM | BPF_DW:
  1875				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1876				insn++;
  1877				i++;
  1878				break;
  1879	
  1880				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1881			case BPF_ALU | BPF_MOD | BPF_X:
  1882			case BPF_ALU | BPF_DIV | BPF_X:
  1883			case BPF_ALU | BPF_MOD | BPF_K:
  1884			case BPF_ALU | BPF_DIV | BPF_K:
  1885			case BPF_ALU64 | BPF_MOD | BPF_X:
  1886			case BPF_ALU64 | BPF_DIV | BPF_X:
  1887			case BPF_ALU64 | BPF_MOD | BPF_K:
  1888			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1889				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1890	
  1891				if (dst_reg != BPF_REG_0)
  1892					EMIT1(0x50); /* push rax */
  1893				if (dst_reg != BPF_REG_3)
  1894					EMIT1(0x52); /* push rdx */
  1895	
  1896				if (BPF_SRC(insn->code) == BPF_X) {
  1897					if (src_reg == BPF_REG_0 ||
  1898					    src_reg == BPF_REG_3) {
  1899						/* mov r11, src_reg */
  1900						EMIT_mov(AUX_REG, src_reg);
  1901						src_reg = AUX_REG;
  1902					}
  1903				} else {
  1904					/* mov r11, imm32 */
  1905					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1906					src_reg = AUX_REG;
  1907				}
  1908	
  1909				if (dst_reg != BPF_REG_0)
  1910					/* mov rax, dst_reg */
  1911					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1912	
  1913				if (insn->off == 0) {
  1914					/*
  1915					 * xor edx, edx
  1916					 * equivalent to 'xor rdx, rdx', but one byte less
  1917					 */
  1918					EMIT2(0x31, 0xd2);
  1919	
  1920					/* div src_reg */
  1921					maybe_emit_1mod(&prog, src_reg, is64);
  1922					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1923				} else {
  1924					if (BPF_CLASS(insn->code) == BPF_ALU)
  1925						EMIT1(0x99); /* cdq */
  1926					else
  1927						EMIT2(0x48, 0x99); /* cqo */
  1928	
  1929					/* idiv src_reg */
  1930					maybe_emit_1mod(&prog, src_reg, is64);
  1931					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1932				}
  1933	
  1934				if (BPF_OP(insn->code) == BPF_MOD &&
  1935				    dst_reg != BPF_REG_3)
  1936					/* mov dst_reg, rdx */
  1937					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1938				else if (BPF_OP(insn->code) == BPF_DIV &&
  1939					 dst_reg != BPF_REG_0)
  1940					/* mov dst_reg, rax */
  1941					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1942	
  1943				if (dst_reg != BPF_REG_3)
  1944					EMIT1(0x5A); /* pop rdx */
  1945				if (dst_reg != BPF_REG_0)
  1946					EMIT1(0x58); /* pop rax */
  1947				break;
  1948			}
  1949	
  1950			case BPF_ALU | BPF_MUL | BPF_K:
  1951			case BPF_ALU64 | BPF_MUL | BPF_K:
  1952				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1953					       BPF_CLASS(insn->code) == BPF_ALU64);
  1954	
  1955				if (is_imm8(imm32))
  1956					/* imul dst_reg, dst_reg, imm8 */
  1957					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1958					      imm32);
  1959				else
  1960					/* imul dst_reg, dst_reg, imm32 */
  1961					EMIT2_off32(0x69,
  1962						    add_2reg(0xC0, dst_reg, dst_reg),
  1963						    imm32);
  1964				break;
  1965	
  1966			case BPF_ALU | BPF_MUL | BPF_X:
  1967			case BPF_ALU64 | BPF_MUL | BPF_X:
  1968				maybe_emit_mod(&prog, src_reg, dst_reg,
  1969					       BPF_CLASS(insn->code) == BPF_ALU64);
  1970	
  1971				/* imul dst_reg, src_reg */
  1972				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1973				break;
  1974	
  1975				/* Shifts */
  1976			case BPF_ALU | BPF_LSH | BPF_K:
  1977			case BPF_ALU | BPF_RSH | BPF_K:
  1978			case BPF_ALU | BPF_ARSH | BPF_K:
  1979			case BPF_ALU64 | BPF_LSH | BPF_K:
  1980			case BPF_ALU64 | BPF_RSH | BPF_K:
  1981			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1982				maybe_emit_1mod(&prog, dst_reg,
  1983						BPF_CLASS(insn->code) == BPF_ALU64);
  1984	
  1985				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1986				if (imm32 == 1)
  1987					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1988				else
  1989					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  1990				break;
  1991	
  1992			case BPF_ALU | BPF_LSH | BPF_X:
  1993			case BPF_ALU | BPF_RSH | BPF_X:
  1994			case BPF_ALU | BPF_ARSH | BPF_X:
  1995			case BPF_ALU64 | BPF_LSH | BPF_X:
  1996			case BPF_ALU64 | BPF_RSH | BPF_X:
  1997			case BPF_ALU64 | BPF_ARSH | BPF_X:
  1998				/* BMI2 shifts aren't better when shift count is already in rcx */
  1999				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  2000					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  2001					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  2002					u8 op;
  2003	
  2004					switch (BPF_OP(insn->code)) {
  2005					case BPF_LSH:
  2006						op = 1; /* prefix 0x66 */
  2007						break;
  2008					case BPF_RSH:
  2009						op = 3; /* prefix 0xf2 */
  2010						break;
  2011					case BPF_ARSH:
  2012						op = 2; /* prefix 0xf3 */
  2013						break;
  2014					}
  2015	
  2016					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  2017	
  2018					break;
  2019				}
  2020	
  2021				if (src_reg != BPF_REG_4) { /* common case */
  2022					/* Check for bad case when dst_reg == rcx */
  2023					if (dst_reg == BPF_REG_4) {
  2024						/* mov r11, dst_reg */
  2025						EMIT_mov(AUX_REG, dst_reg);
  2026						dst_reg = AUX_REG;
  2027					} else {
  2028						EMIT1(0x51); /* push rcx */
  2029					}
  2030					/* mov rcx, src_reg */
  2031					EMIT_mov(BPF_REG_4, src_reg);
  2032				}
  2033	
  2034				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  2035				maybe_emit_1mod(&prog, dst_reg,
  2036						BPF_CLASS(insn->code) == BPF_ALU64);
  2037	
  2038				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  2039				EMIT2(0xD3, add_1reg(b3, dst_reg));
  2040	
  2041				if (src_reg != BPF_REG_4) {
  2042					if (insn->dst_reg == BPF_REG_4)
  2043						/* mov dst_reg, r11 */
  2044						EMIT_mov(insn->dst_reg, AUX_REG);
  2045					else
  2046						EMIT1(0x59); /* pop rcx */
  2047				}
  2048	
  2049				break;
  2050	
  2051			case BPF_ALU | BPF_END | BPF_FROM_BE:
  2052			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  2053				switch (imm32) {
  2054				case 16:
  2055					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  2056					EMIT1(0x66);
  2057					if (is_ereg(dst_reg))
  2058						EMIT1(0x41);
  2059					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  2060	
  2061					/* Emit 'movzwl eax, ax' */
  2062					if (is_ereg(dst_reg))
  2063						EMIT3(0x45, 0x0F, 0xB7);
  2064					else
  2065						EMIT2(0x0F, 0xB7);
  2066					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2067					break;
  2068				case 32:
  2069					/* Emit 'bswap eax' to swap lower 4 bytes */
  2070					if (is_ereg(dst_reg))
  2071						EMIT2(0x41, 0x0F);
  2072					else
  2073						EMIT1(0x0F);
  2074					EMIT1(add_1reg(0xC8, dst_reg));
  2075					break;
  2076				case 64:
  2077					/* Emit 'bswap rax' to swap 8 bytes */
  2078					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  2079					      add_1reg(0xC8, dst_reg));
  2080					break;
  2081				}
  2082				break;
  2083	
  2084			case BPF_ALU | BPF_END | BPF_FROM_LE:
  2085				switch (imm32) {
  2086				case 16:
  2087					/*
  2088					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  2089					 * into 64 bit
  2090					 */
  2091					if (is_ereg(dst_reg))
  2092						EMIT3(0x45, 0x0F, 0xB7);
  2093					else
  2094						EMIT2(0x0F, 0xB7);
  2095					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2096					break;
  2097				case 32:
  2098					/* Emit 'mov eax, eax' to clear upper 32-bits */
  2099					if (is_ereg(dst_reg))
  2100						EMIT1(0x45);
  2101					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  2102					break;
  2103				case 64:
  2104					/* nop */
  2105					break;
  2106				}
  2107				break;
  2108	
  2109				/* speculation barrier */
  2110			case BPF_ST | BPF_NOSPEC:
  2111				EMIT_LFENCE();
  2112				break;
  2113	
  2114				/* ST: *(u8*)(dst_reg + off) = imm */
  2115			case BPF_ST | BPF_MEM | BPF_B:
  2116				if (is_ereg(dst_reg))
  2117					EMIT2(0x41, 0xC6);
  2118				else
  2119					EMIT1(0xC6);
  2120				goto st;
  2121			case BPF_ST | BPF_MEM | BPF_H:
  2122				if (is_ereg(dst_reg))
  2123					EMIT3(0x66, 0x41, 0xC7);
  2124				else
  2125					EMIT2(0x66, 0xC7);
  2126				goto st;
  2127			case BPF_ST | BPF_MEM | BPF_W:
  2128				if (is_ereg(dst_reg))
  2129					EMIT2(0x41, 0xC7);
  2130				else
  2131					EMIT1(0xC7);
  2132				goto st;
  2133			case BPF_ST | BPF_MEM | BPF_DW:
  2134				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  2135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

