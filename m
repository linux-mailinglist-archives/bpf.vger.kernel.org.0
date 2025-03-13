Return-Path: <bpf+bounces-53935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C6DA5EE07
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3517C17C6BE
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15498261384;
	Thu, 13 Mar 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwMb9ps9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AC260A3C
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854529; cv=none; b=ZN0nY3zXMXBb6GUQfVYz0rKkbRgYiRkKqY39AkW1RoMBS+X0rBwh047xFzjZ0ZexPpSaiMZXJ89GbWRqXQhODFJtXEjFrfsJmh4+8zoHBJF2UUP61AKpt4eYhHXVLCGbpCYkE6vKnX6zyNN468WVpNW/DIwTjJII1Q62Xv1i5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854529; c=relaxed/simple;
	bh=X5UNsgQLz9iTgGvIrppVBb3ORyLOzCGAvQvM37S4XjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLtRJL3F+hDVmWogF/kWHQdt+tlLjNhUQyyKU0r0nbiGwDBJja66KEjAOYP31nW2NSqERUcJlesgJHcb7WflsNByLTr7mOfBX26IFF/JZcPju3xvtM3nUnD0CNyw7HU7S56S76ysSSyqlsvbQGaVzK3ogXRy5Z9aaLsOcg0k2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwMb9ps9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741854526; x=1773390526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5UNsgQLz9iTgGvIrppVBb3ORyLOzCGAvQvM37S4XjQ=;
  b=KwMb9ps9BLTD8mojtLauICaNJgrShaWuYYKnIq+JGEiOFPoN2115j7tv
   4fHBqgsWTARAwpus52baw9DCHg3X0IhSY8XbumHFZBpGT4Oe56hpIwIT0
   ky9GpCRDt6vU44M32KeaIULq33Fj16rs70X0fLJAeledLq1hJ3Bmqej4K
   SLW3Vw9NuWy3JpIsxPy1pWLC3Ggy/BjY/KUiNU/+QsS2cd1Sb7IheT1Ew
   ggKPl54FgXS3kSxMkp9YMV9hE4xW0Yy/pksaktygR7CmpBfCq7ktbMZ6g
   G+mSbAdJFlu0gplyl6HZL0sOYWEuUQ68hljbkEQK7Qxub0cfQLXAM1e78
   g==;
X-CSE-ConnectionGUID: XM7hpYGgTeiqs71gKlywRQ==
X-CSE-MsgGUID: 4R7A6thWRde9EQ+ErtGesg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30548530"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="30548530"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:28:45 -0700
X-CSE-ConnectionGUID: kDsUwfG8SoGMF9SXVlSmog==
X-CSE-MsgGUID: Z6vVm1uXTXyDMn2mR+EQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120944653"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 13 Mar 2025 01:28:41 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsdvj-0009EW-2A;
	Thu, 13 Mar 2025 08:28:39 +0000
Date: Thu, 13 Mar 2025 16:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	bpf@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v10 2/4] bpf: add bpf_cpu_time_counter_to_ns
 helper
Message-ID: <202503131640.opwmXIvU-lkp@intel.com>
References: <20250311154850.3616840-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311154850.3616840-3-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_get_cpu_time_counter-kfunc/20250311-235326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250311154850.3616840-3-vadfed%40meta.com
patch subject: [PATCH bpf-next v10 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
config: x86_64-randconfig-004-20250313 (https://download.01.org/0day-ci/archive/20250313/202503131640.opwmXIvU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503131640.opwmXIvU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503131640.opwmXIvU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/net/bpf_jit_comp.o: in function `do_jit':
>> arch/x86/net/bpf_jit_comp.c:2294: undefined reference to `bpf_cpu_time_counter_to_ns'


vim +2294 arch/x86/net/bpf_jit_comp.c

  1498	
  1499	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1500			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1501	{
  1502		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1503		struct bpf_insn *insn = bpf_prog->insnsi;
  1504		bool callee_regs_used[4] = {};
  1505		int insn_cnt = bpf_prog->len;
  1506		bool seen_exit = false;
  1507		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1508		void __percpu *priv_frame_ptr = NULL;
  1509		u64 arena_vm_start, user_vm_start;
  1510		void __percpu *priv_stack_ptr;
  1511		int i, excnt = 0;
  1512		int ilen, proglen = 0;
  1513		u8 *prog = temp;
  1514		u32 stack_depth;
  1515		int err;
  1516	
  1517		stack_depth = bpf_prog->aux->stack_depth;
  1518		priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
  1519		if (priv_stack_ptr) {
  1520			priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
  1521			stack_depth = 0;
  1522		}
  1523	
  1524		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1525		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1526	
  1527		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1528	
  1529		emit_prologue(&prog, stack_depth,
  1530			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1531			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1532		/* Exception callback will clobber callee regs for its own use, and
  1533		 * restore the original callee regs from main prog's stack frame.
  1534		 */
  1535		if (bpf_prog->aux->exception_boundary) {
  1536			/* We also need to save r12, which is not mapped to any BPF
  1537			 * register, as we throw after entry into the kernel, which may
  1538			 * overwrite r12.
  1539			 */
  1540			push_r12(&prog);
  1541			push_callee_regs(&prog, all_callee_regs_used);
  1542		} else {
  1543			if (arena_vm_start)
  1544				push_r12(&prog);
  1545			push_callee_regs(&prog, callee_regs_used);
  1546		}
  1547		if (arena_vm_start)
  1548			emit_mov_imm64(&prog, X86_REG_R12,
  1549				       arena_vm_start >> 32, (u32) arena_vm_start);
  1550	
  1551		if (priv_frame_ptr)
  1552			emit_priv_frame_ptr(&prog, priv_frame_ptr);
  1553	
  1554		ilen = prog - temp;
  1555		if (rw_image)
  1556			memcpy(rw_image + proglen, temp, ilen);
  1557		proglen += ilen;
  1558		addrs[0] = proglen;
  1559		prog = temp;
  1560	
  1561		for (i = 1; i <= insn_cnt; i++, insn++) {
  1562			const s32 imm32 = insn->imm;
  1563			u32 dst_reg = insn->dst_reg;
  1564			u32 src_reg = insn->src_reg;
  1565			u8 b2 = 0, b3 = 0;
  1566			u8 *start_of_ldx;
  1567			s64 jmp_offset;
  1568			s16 insn_off;
  1569			u8 jmp_cond;
  1570			u8 *func;
  1571			int nops;
  1572	
  1573			if (priv_frame_ptr) {
  1574				if (src_reg == BPF_REG_FP)
  1575					src_reg = X86_REG_R9;
  1576	
  1577				if (dst_reg == BPF_REG_FP)
  1578					dst_reg = X86_REG_R9;
  1579			}
  1580	
  1581			switch (insn->code) {
  1582				/* ALU */
  1583			case BPF_ALU | BPF_ADD | BPF_X:
  1584			case BPF_ALU | BPF_SUB | BPF_X:
  1585			case BPF_ALU | BPF_AND | BPF_X:
  1586			case BPF_ALU | BPF_OR | BPF_X:
  1587			case BPF_ALU | BPF_XOR | BPF_X:
  1588			case BPF_ALU64 | BPF_ADD | BPF_X:
  1589			case BPF_ALU64 | BPF_SUB | BPF_X:
  1590			case BPF_ALU64 | BPF_AND | BPF_X:
  1591			case BPF_ALU64 | BPF_OR | BPF_X:
  1592			case BPF_ALU64 | BPF_XOR | BPF_X:
  1593				maybe_emit_mod(&prog, dst_reg, src_reg,
  1594					       BPF_CLASS(insn->code) == BPF_ALU64);
  1595				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1596				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1597				break;
  1598	
  1599			case BPF_ALU64 | BPF_MOV | BPF_X:
  1600				if (insn_is_cast_user(insn)) {
  1601					if (dst_reg != src_reg)
  1602						/* 32-bit mov */
  1603						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1604					/* shl dst_reg, 32 */
  1605					maybe_emit_1mod(&prog, dst_reg, true);
  1606					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1607	
  1608					/* or dst_reg, user_vm_start */
  1609					maybe_emit_1mod(&prog, dst_reg, true);
  1610					if (is_axreg(dst_reg))
  1611						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1612					else
  1613						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1614	
  1615					/* rol dst_reg, 32 */
  1616					maybe_emit_1mod(&prog, dst_reg, true);
  1617					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1618	
  1619					/* xor r11, r11 */
  1620					EMIT3(0x4D, 0x31, 0xDB);
  1621	
  1622					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1623					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1624					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1625	
  1626					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1627					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1628					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1629					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1630					break;
  1631				} else if (insn_is_mov_percpu_addr(insn)) {
  1632					/* mov <dst>, <src> (if necessary) */
  1633					EMIT_mov(dst_reg, src_reg);
  1634	#ifdef CONFIG_SMP
  1635					/* add <dst>, gs:[<off>] */
  1636					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1637					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1638					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1639	#endif
  1640					break;
  1641				}
  1642				fallthrough;
  1643			case BPF_ALU | BPF_MOV | BPF_X:
  1644				if (insn->off == 0)
  1645					emit_mov_reg(&prog,
  1646						     BPF_CLASS(insn->code) == BPF_ALU64,
  1647						     dst_reg, src_reg);
  1648				else
  1649					emit_movsx_reg(&prog, insn->off,
  1650						       BPF_CLASS(insn->code) == BPF_ALU64,
  1651						       dst_reg, src_reg);
  1652				break;
  1653	
  1654				/* neg dst */
  1655			case BPF_ALU | BPF_NEG:
  1656			case BPF_ALU64 | BPF_NEG:
  1657				maybe_emit_1mod(&prog, dst_reg,
  1658						BPF_CLASS(insn->code) == BPF_ALU64);
  1659				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1660				break;
  1661	
  1662			case BPF_ALU | BPF_ADD | BPF_K:
  1663			case BPF_ALU | BPF_SUB | BPF_K:
  1664			case BPF_ALU | BPF_AND | BPF_K:
  1665			case BPF_ALU | BPF_OR | BPF_K:
  1666			case BPF_ALU | BPF_XOR | BPF_K:
  1667			case BPF_ALU64 | BPF_ADD | BPF_K:
  1668			case BPF_ALU64 | BPF_SUB | BPF_K:
  1669			case BPF_ALU64 | BPF_AND | BPF_K:
  1670			case BPF_ALU64 | BPF_OR | BPF_K:
  1671			case BPF_ALU64 | BPF_XOR | BPF_K:
  1672				maybe_emit_1mod(&prog, dst_reg,
  1673						BPF_CLASS(insn->code) == BPF_ALU64);
  1674	
  1675				/*
  1676				 * b3 holds 'normal' opcode, b2 short form only valid
  1677				 * in case dst is eax/rax.
  1678				 */
  1679				switch (BPF_OP(insn->code)) {
  1680				case BPF_ADD:
  1681					b3 = 0xC0;
  1682					b2 = 0x05;
  1683					break;
  1684				case BPF_SUB:
  1685					b3 = 0xE8;
  1686					b2 = 0x2D;
  1687					break;
  1688				case BPF_AND:
  1689					b3 = 0xE0;
  1690					b2 = 0x25;
  1691					break;
  1692				case BPF_OR:
  1693					b3 = 0xC8;
  1694					b2 = 0x0D;
  1695					break;
  1696				case BPF_XOR:
  1697					b3 = 0xF0;
  1698					b2 = 0x35;
  1699					break;
  1700				}
  1701	
  1702				if (is_imm8(imm32))
  1703					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1704				else if (is_axreg(dst_reg))
  1705					EMIT1_off32(b2, imm32);
  1706				else
  1707					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1708				break;
  1709	
  1710			case BPF_ALU64 | BPF_MOV | BPF_K:
  1711			case BPF_ALU | BPF_MOV | BPF_K:
  1712				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1713					       dst_reg, imm32);
  1714				break;
  1715	
  1716			case BPF_LD | BPF_IMM | BPF_DW:
  1717				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1718				insn++;
  1719				i++;
  1720				break;
  1721	
  1722				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1723			case BPF_ALU | BPF_MOD | BPF_X:
  1724			case BPF_ALU | BPF_DIV | BPF_X:
  1725			case BPF_ALU | BPF_MOD | BPF_K:
  1726			case BPF_ALU | BPF_DIV | BPF_K:
  1727			case BPF_ALU64 | BPF_MOD | BPF_X:
  1728			case BPF_ALU64 | BPF_DIV | BPF_X:
  1729			case BPF_ALU64 | BPF_MOD | BPF_K:
  1730			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1731				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1732	
  1733				if (dst_reg != BPF_REG_0)
  1734					EMIT1(0x50); /* push rax */
  1735				if (dst_reg != BPF_REG_3)
  1736					EMIT1(0x52); /* push rdx */
  1737	
  1738				if (BPF_SRC(insn->code) == BPF_X) {
  1739					if (src_reg == BPF_REG_0 ||
  1740					    src_reg == BPF_REG_3) {
  1741						/* mov r11, src_reg */
  1742						EMIT_mov(AUX_REG, src_reg);
  1743						src_reg = AUX_REG;
  1744					}
  1745				} else {
  1746					/* mov r11, imm32 */
  1747					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1748					src_reg = AUX_REG;
  1749				}
  1750	
  1751				if (dst_reg != BPF_REG_0)
  1752					/* mov rax, dst_reg */
  1753					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1754	
  1755				if (insn->off == 0) {
  1756					/*
  1757					 * xor edx, edx
  1758					 * equivalent to 'xor rdx, rdx', but one byte less
  1759					 */
  1760					EMIT2(0x31, 0xd2);
  1761	
  1762					/* div src_reg */
  1763					maybe_emit_1mod(&prog, src_reg, is64);
  1764					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1765				} else {
  1766					if (BPF_CLASS(insn->code) == BPF_ALU)
  1767						EMIT1(0x99); /* cdq */
  1768					else
  1769						EMIT2(0x48, 0x99); /* cqo */
  1770	
  1771					/* idiv src_reg */
  1772					maybe_emit_1mod(&prog, src_reg, is64);
  1773					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1774				}
  1775	
  1776				if (BPF_OP(insn->code) == BPF_MOD &&
  1777				    dst_reg != BPF_REG_3)
  1778					/* mov dst_reg, rdx */
  1779					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1780				else if (BPF_OP(insn->code) == BPF_DIV &&
  1781					 dst_reg != BPF_REG_0)
  1782					/* mov dst_reg, rax */
  1783					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1784	
  1785				if (dst_reg != BPF_REG_3)
  1786					EMIT1(0x5A); /* pop rdx */
  1787				if (dst_reg != BPF_REG_0)
  1788					EMIT1(0x58); /* pop rax */
  1789				break;
  1790			}
  1791	
  1792			case BPF_ALU | BPF_MUL | BPF_K:
  1793			case BPF_ALU64 | BPF_MUL | BPF_K:
  1794				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1795					       BPF_CLASS(insn->code) == BPF_ALU64);
  1796	
  1797				if (is_imm8(imm32))
  1798					/* imul dst_reg, dst_reg, imm8 */
  1799					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1800					      imm32);
  1801				else
  1802					/* imul dst_reg, dst_reg, imm32 */
  1803					EMIT2_off32(0x69,
  1804						    add_2reg(0xC0, dst_reg, dst_reg),
  1805						    imm32);
  1806				break;
  1807	
  1808			case BPF_ALU | BPF_MUL | BPF_X:
  1809			case BPF_ALU64 | BPF_MUL | BPF_X:
  1810				maybe_emit_mod(&prog, src_reg, dst_reg,
  1811					       BPF_CLASS(insn->code) == BPF_ALU64);
  1812	
  1813				/* imul dst_reg, src_reg */
  1814				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1815				break;
  1816	
  1817				/* Shifts */
  1818			case BPF_ALU | BPF_LSH | BPF_K:
  1819			case BPF_ALU | BPF_RSH | BPF_K:
  1820			case BPF_ALU | BPF_ARSH | BPF_K:
  1821			case BPF_ALU64 | BPF_LSH | BPF_K:
  1822			case BPF_ALU64 | BPF_RSH | BPF_K:
  1823			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1824				maybe_emit_1mod(&prog, dst_reg,
  1825						BPF_CLASS(insn->code) == BPF_ALU64);
  1826	
  1827				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1828				if (imm32 == 1)
  1829					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1830				else
  1831					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  1832				break;
  1833	
  1834			case BPF_ALU | BPF_LSH | BPF_X:
  1835			case BPF_ALU | BPF_RSH | BPF_X:
  1836			case BPF_ALU | BPF_ARSH | BPF_X:
  1837			case BPF_ALU64 | BPF_LSH | BPF_X:
  1838			case BPF_ALU64 | BPF_RSH | BPF_X:
  1839			case BPF_ALU64 | BPF_ARSH | BPF_X:
  1840				/* BMI2 shifts aren't better when shift count is already in rcx */
  1841				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  1842					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  1843					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  1844					u8 op;
  1845	
  1846					switch (BPF_OP(insn->code)) {
  1847					case BPF_LSH:
  1848						op = 1; /* prefix 0x66 */
  1849						break;
  1850					case BPF_RSH:
  1851						op = 3; /* prefix 0xf2 */
  1852						break;
  1853					case BPF_ARSH:
  1854						op = 2; /* prefix 0xf3 */
  1855						break;
  1856					}
  1857	
  1858					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  1859	
  1860					break;
  1861				}
  1862	
  1863				if (src_reg != BPF_REG_4) { /* common case */
  1864					/* Check for bad case when dst_reg == rcx */
  1865					if (dst_reg == BPF_REG_4) {
  1866						/* mov r11, dst_reg */
  1867						EMIT_mov(AUX_REG, dst_reg);
  1868						dst_reg = AUX_REG;
  1869					} else {
  1870						EMIT1(0x51); /* push rcx */
  1871					}
  1872					/* mov rcx, src_reg */
  1873					EMIT_mov(BPF_REG_4, src_reg);
  1874				}
  1875	
  1876				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  1877				maybe_emit_1mod(&prog, dst_reg,
  1878						BPF_CLASS(insn->code) == BPF_ALU64);
  1879	
  1880				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1881				EMIT2(0xD3, add_1reg(b3, dst_reg));
  1882	
  1883				if (src_reg != BPF_REG_4) {
  1884					if (insn->dst_reg == BPF_REG_4)
  1885						/* mov dst_reg, r11 */
  1886						EMIT_mov(insn->dst_reg, AUX_REG);
  1887					else
  1888						EMIT1(0x59); /* pop rcx */
  1889				}
  1890	
  1891				break;
  1892	
  1893			case BPF_ALU | BPF_END | BPF_FROM_BE:
  1894			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  1895				switch (imm32) {
  1896				case 16:
  1897					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  1898					EMIT1(0x66);
  1899					if (is_ereg(dst_reg))
  1900						EMIT1(0x41);
  1901					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  1902	
  1903					/* Emit 'movzwl eax, ax' */
  1904					if (is_ereg(dst_reg))
  1905						EMIT3(0x45, 0x0F, 0xB7);
  1906					else
  1907						EMIT2(0x0F, 0xB7);
  1908					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1909					break;
  1910				case 32:
  1911					/* Emit 'bswap eax' to swap lower 4 bytes */
  1912					if (is_ereg(dst_reg))
  1913						EMIT2(0x41, 0x0F);
  1914					else
  1915						EMIT1(0x0F);
  1916					EMIT1(add_1reg(0xC8, dst_reg));
  1917					break;
  1918				case 64:
  1919					/* Emit 'bswap rax' to swap 8 bytes */
  1920					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  1921					      add_1reg(0xC8, dst_reg));
  1922					break;
  1923				}
  1924				break;
  1925	
  1926			case BPF_ALU | BPF_END | BPF_FROM_LE:
  1927				switch (imm32) {
  1928				case 16:
  1929					/*
  1930					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  1931					 * into 64 bit
  1932					 */
  1933					if (is_ereg(dst_reg))
  1934						EMIT3(0x45, 0x0F, 0xB7);
  1935					else
  1936						EMIT2(0x0F, 0xB7);
  1937					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1938					break;
  1939				case 32:
  1940					/* Emit 'mov eax, eax' to clear upper 32-bits */
  1941					if (is_ereg(dst_reg))
  1942						EMIT1(0x45);
  1943					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  1944					break;
  1945				case 64:
  1946					/* nop */
  1947					break;
  1948				}
  1949				break;
  1950	
  1951				/* speculation barrier */
  1952			case BPF_ST | BPF_NOSPEC:
  1953				EMIT_LFENCE();
  1954				break;
  1955	
  1956				/* ST: *(u8*)(dst_reg + off) = imm */
  1957			case BPF_ST | BPF_MEM | BPF_B:
  1958				if (is_ereg(dst_reg))
  1959					EMIT2(0x41, 0xC6);
  1960				else
  1961					EMIT1(0xC6);
  1962				goto st;
  1963			case BPF_ST | BPF_MEM | BPF_H:
  1964				if (is_ereg(dst_reg))
  1965					EMIT3(0x66, 0x41, 0xC7);
  1966				else
  1967					EMIT2(0x66, 0xC7);
  1968				goto st;
  1969			case BPF_ST | BPF_MEM | BPF_W:
  1970				if (is_ereg(dst_reg))
  1971					EMIT2(0x41, 0xC7);
  1972				else
  1973					EMIT1(0xC7);
  1974				goto st;
  1975			case BPF_ST | BPF_MEM | BPF_DW:
  1976				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  1977	
  1978	st:			if (is_imm8(insn->off))
  1979					EMIT2(add_1reg(0x40, dst_reg), insn->off);
  1980				else
  1981					EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
  1982	
  1983				EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
  1984				break;
  1985	
  1986				/* STX: *(u8*)(dst_reg + off) = src_reg */
  1987			case BPF_STX | BPF_MEM | BPF_B:
  1988			case BPF_STX | BPF_MEM | BPF_H:
  1989			case BPF_STX | BPF_MEM | BPF_W:
  1990			case BPF_STX | BPF_MEM | BPF_DW:
  1991				emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  1992				break;
  1993	
  1994			case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
  1995			case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
  1996			case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
  1997			case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
  1998				start_of_ldx = prog;
  1999				emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
  2000				goto populate_extable;
  2001	
  2002				/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
  2003			case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
  2004			case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
  2005			case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
  2006			case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
  2007			case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
  2008			case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
  2009			case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
  2010			case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
  2011				start_of_ldx = prog;
  2012				if (BPF_CLASS(insn->code) == BPF_LDX)
  2013					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2014				else
  2015					emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2016	populate_extable:
  2017				{
  2018					struct exception_table_entry *ex;
  2019					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2020					s64 delta;
  2021	
  2022					if (!bpf_prog->aux->extable)
  2023						break;
  2024	
  2025					if (excnt >= bpf_prog->aux->num_exentries) {
  2026						pr_err("mem32 extable bug\n");
  2027						return -EFAULT;
  2028					}
  2029					ex = &bpf_prog->aux->extable[excnt++];
  2030	
  2031					delta = _insn - (u8 *)&ex->insn;
  2032					/* switch ex to rw buffer for writes */
  2033					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2034	
  2035					ex->insn = delta;
  2036	
  2037					ex->data = EX_TYPE_BPF;
  2038	
  2039					ex->fixup = (prog - start_of_ldx) |
  2040						((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
  2041				}
  2042				break;
  2043	
  2044				/* LDX: dst_reg = *(u8*)(src_reg + off) */
  2045			case BPF_LDX | BPF_MEM | BPF_B:
  2046			case BPF_LDX | BPF_PROBE_MEM | BPF_B:
  2047			case BPF_LDX | BPF_MEM | BPF_H:
  2048			case BPF_LDX | BPF_PROBE_MEM | BPF_H:
  2049			case BPF_LDX | BPF_MEM | BPF_W:
  2050			case BPF_LDX | BPF_PROBE_MEM | BPF_W:
  2051			case BPF_LDX | BPF_MEM | BPF_DW:
  2052			case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
  2053				/* LDXS: dst_reg = *(s8*)(src_reg + off) */
  2054			case BPF_LDX | BPF_MEMSX | BPF_B:
  2055			case BPF_LDX | BPF_MEMSX | BPF_H:
  2056			case BPF_LDX | BPF_MEMSX | BPF_W:
  2057			case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
  2058			case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
  2059			case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
  2060				insn_off = insn->off;
  2061	
  2062				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2063				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2064					/* Conservatively check that src_reg + insn->off is a kernel address:
  2065					 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
  2066					 *   and
  2067					 *   src_reg + insn->off < VSYSCALL_ADDR
  2068					 */
  2069	
  2070					u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
  2071					u8 *end_of_jmp;
  2072	
  2073					/* movabsq r10, VSYSCALL_ADDR */
  2074					emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
  2075						       (u32)(long)VSYSCALL_ADDR);
  2076	
  2077					/* mov src_reg, r11 */
  2078					EMIT_mov(AUX_REG, src_reg);
  2079	
  2080					if (insn->off) {
  2081						/* add r11, insn->off */
  2082						maybe_emit_1mod(&prog, AUX_REG, true);
  2083						EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
  2084					}
  2085	
  2086					/* sub r11, r10 */
  2087					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2088					EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2089	
  2090					/* movabsq r10, limit */
  2091					emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
  2092						       (u32)(long)limit);
  2093	
  2094					/* cmp r10, r11 */
  2095					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2096					EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2097	
  2098					/* if unsigned '>', goto load */
  2099					EMIT2(X86_JA, 0);
  2100					end_of_jmp = prog;
  2101	
  2102					/* xor dst_reg, dst_reg */
  2103					emit_mov_imm32(&prog, false, dst_reg, 0);
  2104					/* jmp byte_after_ldx */
  2105					EMIT2(0xEB, 0);
  2106	
  2107					/* populate jmp_offset for JAE above to jump to start_of_ldx */
  2108					start_of_ldx = prog;
  2109					end_of_jmp[-1] = start_of_ldx - end_of_jmp;
  2110				}
  2111				if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
  2112				    BPF_MODE(insn->code) == BPF_MEMSX)
  2113					emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2114				else
  2115					emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2116				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2117				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2118					struct exception_table_entry *ex;
  2119					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2120					s64 delta;
  2121	
  2122					/* populate jmp_offset for JMP above */
  2123					start_of_ldx[-1] = prog - start_of_ldx;
  2124	
  2125					if (!bpf_prog->aux->extable)
  2126						break;
  2127	
  2128					if (excnt >= bpf_prog->aux->num_exentries) {
  2129						pr_err("ex gen bug\n");
  2130						return -EFAULT;
  2131					}
  2132					ex = &bpf_prog->aux->extable[excnt++];
  2133	
  2134					delta = _insn - (u8 *)&ex->insn;
  2135					if (!is_simm32(delta)) {
  2136						pr_err("extable->insn doesn't fit into 32-bit\n");
  2137						return -EFAULT;
  2138					}
  2139					/* switch ex to rw buffer for writes */
  2140					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2141	
  2142					ex->insn = delta;
  2143	
  2144					ex->data = EX_TYPE_BPF;
  2145	
  2146					if (dst_reg > BPF_REG_9) {
  2147						pr_err("verifier error\n");
  2148						return -EFAULT;
  2149					}
  2150					/*
  2151					 * Compute size of x86 insn and its target dest x86 register.
  2152					 * ex_handler_bpf() will use lower 8 bits to adjust
  2153					 * pt_regs->ip to jump over this x86 instruction
  2154					 * and upper bits to figure out which pt_regs to zero out.
  2155					 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
  2156					 * of 4 bytes will be ignored and rbx will be zero inited.
  2157					 */
  2158					ex->fixup = (prog - start_of_ldx) | (reg2pt_regs[dst_reg] << 8);
  2159				}
  2160				break;
  2161	
  2162			case BPF_STX | BPF_ATOMIC | BPF_B:
  2163			case BPF_STX | BPF_ATOMIC | BPF_H:
  2164				if (!bpf_atomic_is_load_store(insn)) {
  2165					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2166					return -EFAULT;
  2167				}
  2168				fallthrough;
  2169			case BPF_STX | BPF_ATOMIC | BPF_W:
  2170			case BPF_STX | BPF_ATOMIC | BPF_DW:
  2171				if (insn->imm == (BPF_AND | BPF_FETCH) ||
  2172				    insn->imm == (BPF_OR | BPF_FETCH) ||
  2173				    insn->imm == (BPF_XOR | BPF_FETCH)) {
  2174					bool is64 = BPF_SIZE(insn->code) == BPF_DW;
  2175					u32 real_src_reg = src_reg;
  2176					u32 real_dst_reg = dst_reg;
  2177					u8 *branch_target;
  2178	
  2179					/*
  2180					 * Can't be implemented with a single x86 insn.
  2181					 * Need to do a CMPXCHG loop.
  2182					 */
  2183	
  2184					/* Will need RAX as a CMPXCHG operand so save R0 */
  2185					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
  2186					if (src_reg == BPF_REG_0)
  2187						real_src_reg = BPF_REG_AX;
  2188					if (dst_reg == BPF_REG_0)
  2189						real_dst_reg = BPF_REG_AX;
  2190	
  2191					branch_target = prog;
  2192					/* Load old value */
  2193					emit_ldx(&prog, BPF_SIZE(insn->code),
  2194						 BPF_REG_0, real_dst_reg, insn->off);
  2195					/*
  2196					 * Perform the (commutative) operation locally,
  2197					 * put the result in the AUX_REG.
  2198					 */
  2199					emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
  2200					maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
  2201					EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
  2202					      add_2reg(0xC0, AUX_REG, real_src_reg));
  2203					/* Attempt to swap in new value */
  2204					err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
  2205							      real_dst_reg, AUX_REG,
  2206							      insn->off,
  2207							      BPF_SIZE(insn->code));
  2208					if (WARN_ON(err))
  2209						return err;
  2210					/*
  2211					 * ZF tells us whether we won the race. If it's
  2212					 * cleared we need to try again.
  2213					 */
  2214					EMIT2(X86_JNE, -(prog - branch_target) - 2);
  2215					/* Return the pre-modification value */
  2216					emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
  2217					/* Restore R0 after clobbering RAX */
  2218					emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
  2219					break;
  2220				}
  2221	
  2222				if (bpf_atomic_is_load_store(insn))
  2223					err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
  2224								insn->off, BPF_SIZE(insn->code));
  2225				else
  2226					err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
  2227							      insn->off, BPF_SIZE(insn->code));
  2228				if (err)
  2229					return err;
  2230				break;
  2231	
  2232			case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
  2233			case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
  2234				if (!bpf_atomic_is_load_store(insn)) {
  2235					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2236					return -EFAULT;
  2237				}
  2238				fallthrough;
  2239			case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
  2240			case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
  2241				start_of_ldx = prog;
  2242	
  2243				if (bpf_atomic_is_load_store(insn))
  2244					err = emit_atomic_ld_st_index(&prog, insn->imm,
  2245								      BPF_SIZE(insn->code), dst_reg,
  2246								      src_reg, X86_REG_R12, insn->off);
  2247				else
  2248					err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
  2249								    dst_reg, src_reg, X86_REG_R12,
  2250								    insn->off);
  2251				if (err)
  2252					return err;
  2253				goto populate_extable;
  2254	
  2255				/* call */
  2256			case BPF_JMP | BPF_CALL: {
  2257				u8 *ip = image + addrs[i - 1];
  2258	
  2259				if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
  2260				    IS_ENABLED(CONFIG_BPF_SYSCALL) &&
  2261				    imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
  2262				    cpu_feature_enabled(X86_FEATURE_TSC) &&
  2263				    using_native_sched_clock() && sched_clock_stable()) {
  2264					/* The default implementation of this kfunc uses
  2265					 * ktime_get_raw_ns() which effectively is implemented as
  2266					 * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip
  2267					 * masking part because we assume it's not needed in BPF
  2268					 * use case (two measurements close in time).
  2269					 * Original code for rdtsc_ordered() uses sequence:
  2270					 * 'rdtsc; nop; nop; nop' to patch it into
  2271					 * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
  2272					 * JIT uses 'lfence; rdtsc' variant because BPF program
  2273					 * doesn't care about cookie provided by rdtscp in RCX.
  2274					 * Save RDX because RDTSC will use EDX:EAX to return u64
  2275					 */
  2276					emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
  2277					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
  2278						EMIT_LFENCE();
  2279					EMIT2(0x0F, 0x31);
  2280	
  2281					/* shl RDX, 32 */
  2282					maybe_emit_1mod(&prog, BPF_REG_3, true);
  2283					EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
  2284					/* or RAX, RDX */
  2285					maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
  2286					EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
  2287					/* restore RDX from R11 */
  2288					emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
  2289	
  2290					break;
  2291				}
  2292	
  2293				if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> 2294				    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
  2295				    cpu_feature_enabled(X86_FEATURE_TSC) &&
  2296				    using_native_sched_clock() && sched_clock_stable()) {
  2297					struct cyc2ns_data data;
  2298					u32 mult, shift;
  2299	
  2300					cyc2ns_read_begin(&data);
  2301					mult = data.cyc2ns_mul;
  2302					shift = data.cyc2ns_shift;
  2303					cyc2ns_read_end();
  2304					/* imul RAX, RDI, mult */
  2305					maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
  2306					EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
  2307						    mult);
  2308	
  2309					/* shr RAX, shift (which is less than 64) */
  2310					maybe_emit_1mod(&prog, BPF_REG_0, true);
  2311					EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
  2312	
  2313					break;
  2314				}
  2315	
  2316				func = (u8 *) __bpf_call_base + imm32;
  2317				if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
  2318					LOAD_TAIL_CALL_CNT_PTR(stack_depth);
  2319					ip += 7;
  2320				}
  2321				if (!imm32)
  2322					return -EINVAL;
  2323				if (priv_frame_ptr) {
  2324					push_r9(&prog);
  2325					ip += 2;
  2326				}
  2327				ip += x86_call_depth_emit_accounting(&prog, func, ip);
  2328				if (emit_call(&prog, func, ip))
  2329					return -EINVAL;
  2330				if (priv_frame_ptr)
  2331					pop_r9(&prog);
  2332				break;
  2333			}
  2334	
  2335			case BPF_JMP | BPF_TAIL_CALL:
  2336				if (imm32)
  2337					emit_bpf_tail_call_direct(bpf_prog,
  2338								  &bpf_prog->aux->poke_tab[imm32 - 1],
  2339								  &prog, image + addrs[i - 1],
  2340								  callee_regs_used,
  2341								  stack_depth,
  2342								  ctx);
  2343				else
  2344					emit_bpf_tail_call_indirect(bpf_prog,
  2345								    &prog,
  2346								    callee_regs_used,
  2347								    stack_depth,
  2348								    image + addrs[i - 1],
  2349								    ctx);
  2350				break;
  2351	
  2352				/* cond jump */
  2353			case BPF_JMP | BPF_JEQ | BPF_X:
  2354			case BPF_JMP | BPF_JNE | BPF_X:
  2355			case BPF_JMP | BPF_JGT | BPF_X:
  2356			case BPF_JMP | BPF_JLT | BPF_X:
  2357			case BPF_JMP | BPF_JGE | BPF_X:
  2358			case BPF_JMP | BPF_JLE | BPF_X:
  2359			case BPF_JMP | BPF_JSGT | BPF_X:
  2360			case BPF_JMP | BPF_JSLT | BPF_X:
  2361			case BPF_JMP | BPF_JSGE | BPF_X:
  2362			case BPF_JMP | BPF_JSLE | BPF_X:
  2363			case BPF_JMP32 | BPF_JEQ | BPF_X:
  2364			case BPF_JMP32 | BPF_JNE | BPF_X:
  2365			case BPF_JMP32 | BPF_JGT | BPF_X:
  2366			case BPF_JMP32 | BPF_JLT | BPF_X:
  2367			case BPF_JMP32 | BPF_JGE | BPF_X:
  2368			case BPF_JMP32 | BPF_JLE | BPF_X:
  2369			case BPF_JMP32 | BPF_JSGT | BPF_X:
  2370			case BPF_JMP32 | BPF_JSLT | BPF_X:
  2371			case BPF_JMP32 | BPF_JSGE | BPF_X:
  2372			case BPF_JMP32 | BPF_JSLE | BPF_X:
  2373				/* cmp dst_reg, src_reg */
  2374				maybe_emit_mod(&prog, dst_reg, src_reg,
  2375					       BPF_CLASS(insn->code) == BPF_JMP);
  2376				EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
  2377				goto emit_cond_jmp;
  2378	
  2379			case BPF_JMP | BPF_JSET | BPF_X:
  2380			case BPF_JMP32 | BPF_JSET | BPF_X:
  2381				/* test dst_reg, src_reg */
  2382				maybe_emit_mod(&prog, dst_reg, src_reg,
  2383					       BPF_CLASS(insn->code) == BPF_JMP);
  2384				EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
  2385				goto emit_cond_jmp;
  2386	
  2387			case BPF_JMP | BPF_JSET | BPF_K:
  2388			case BPF_JMP32 | BPF_JSET | BPF_K:
  2389				/* test dst_reg, imm32 */
  2390				maybe_emit_1mod(&prog, dst_reg,
  2391						BPF_CLASS(insn->code) == BPF_JMP);
  2392				EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
  2393				goto emit_cond_jmp;
  2394	
  2395			case BPF_JMP | BPF_JEQ | BPF_K:
  2396			case BPF_JMP | BPF_JNE | BPF_K:
  2397			case BPF_JMP | BPF_JGT | BPF_K:
  2398			case BPF_JMP | BPF_JLT | BPF_K:
  2399			case BPF_JMP | BPF_JGE | BPF_K:
  2400			case BPF_JMP | BPF_JLE | BPF_K:
  2401			case BPF_JMP | BPF_JSGT | BPF_K:
  2402			case BPF_JMP | BPF_JSLT | BPF_K:
  2403			case BPF_JMP | BPF_JSGE | BPF_K:
  2404			case BPF_JMP | BPF_JSLE | BPF_K:
  2405			case BPF_JMP32 | BPF_JEQ | BPF_K:
  2406			case BPF_JMP32 | BPF_JNE | BPF_K:
  2407			case BPF_JMP32 | BPF_JGT | BPF_K:
  2408			case BPF_JMP32 | BPF_JLT | BPF_K:
  2409			case BPF_JMP32 | BPF_JGE | BPF_K:
  2410			case BPF_JMP32 | BPF_JLE | BPF_K:
  2411			case BPF_JMP32 | BPF_JSGT | BPF_K:
  2412			case BPF_JMP32 | BPF_JSLT | BPF_K:
  2413			case BPF_JMP32 | BPF_JSGE | BPF_K:
  2414			case BPF_JMP32 | BPF_JSLE | BPF_K:
  2415				/* test dst_reg, dst_reg to save one extra byte */
  2416				if (imm32 == 0) {
  2417					maybe_emit_mod(&prog, dst_reg, dst_reg,
  2418						       BPF_CLASS(insn->code) == BPF_JMP);
  2419					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  2420					goto emit_cond_jmp;
  2421				}
  2422	
  2423				/* cmp dst_reg, imm8/32 */
  2424				maybe_emit_1mod(&prog, dst_reg,
  2425						BPF_CLASS(insn->code) == BPF_JMP);
  2426	
  2427				if (is_imm8(imm32))
  2428					EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
  2429				else
  2430					EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
  2431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

