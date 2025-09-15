Return-Path: <bpf+bounces-68369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC414B56F38
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 06:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0483A7B97
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA727056D;
	Mon, 15 Sep 2025 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwsv55ks"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089C22FF37
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909408; cv=none; b=RHZJxCzPVcwiU7Yi30vP/Pzf0SCS8mbOVnzPK99tFBPXWGiRjvmtLv8TaXbgOc0czhRYhbRZXpkimhz+KFYt62MKmdjNt3mMRsTcbuKEAyg7KcbgcuvRz7Q8NPIET/XiDGto/4RoRDDk/hNtbjCHEsqxpnHUGNdv35f2W3hj+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909408; c=relaxed/simple;
	bh=fzRRG/r3s3EP5v5q8MdsUGsSICu3sHP8rRP47BZCjYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEZgjCx37R2e2hKtF2Q1PoReceT7h79YV1tJltMNMXbJeQRSrC7fUdZBYnR64GuLsjwTFOCc1p+X7za36XY3T/puOZDYOsFIeBaM9G6XX8aPXIvxqINSF4SkBzC4wvLipAuu/+uB9qjtMJhUKc2aPbAkqSQFberWrlLODxMXyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwsv55ks; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757909405; x=1789445405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fzRRG/r3s3EP5v5q8MdsUGsSICu3sHP8rRP47BZCjYM=;
  b=Qwsv55ks24Tl/0L/dJ9HUBZbI3/8jAnKABwCJkxlQjbYax1iSbilpgLO
   vdKl2aka5FwPsn63SWKikrrI4zrR53hKr51GZNhc80+8NBu8WQc4a/GuF
   oCaSyB1qv2ngRnxtTYbym7ipxvYrIE+F1XseanDu4iCxU4IVI2iLwMHA9
   kJ4Cx8P2RjhjFQb/WVBmAYyUqLwAXpn6ANexS60jOODfleIM0qsCcJ5ws
   1z9pAbRYGn5PodALeSESNzk2EdlxfdCM7nDlkg4wR2c05ePSie7lmEDbB
   o8pCbrXKMrvLxJ7Cz1P2lX6U/dls63LPNy4YwtGH65UdJEfXJqNbea4nm
   A==;
X-CSE-ConnectionGUID: dbuARhWSS32zZuCzpSz+LA==
X-CSE-MsgGUID: wMP47AS9QHqOw/+Oh39dJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60023327"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="60023327"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 21:10:04 -0700
X-CSE-ConnectionGUID: phCnyGFFT8ODYpHeEP/0qA==
X-CSE-MsgGUID: W97ulzUvT0+1V666z69W9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174949347"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Sep 2025 21:10:02 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uy0XP-0002x6-0X;
	Mon, 15 Sep 2025 04:09:59 +0000
Date: Mon, 15 Sep 2025 12:09:26 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
Message-ID: <202509151152.1FcyFoR8-lkp@intel.com>
References: <20250913193922.1910480-4-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913193922.1910480-4-a.s.protopopov@gmail.com>

Hi Anton,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-fix-the-return-value-of-push_stack/20250914-033453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250913193922.1910480-4-a.s.protopopov%40gmail.com
patch subject: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type: instructions array
config: x86_64-randconfig-078-20250914 (https://download.01.org/0day-ci/archive/20250915/202509151152.1FcyFoR8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509151152.1FcyFoR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509151152.1FcyFoR8-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/net/bpf_jit_comp.o: in function `do_jit':
>> arch/x86/net/bpf_jit_comp.c:2726:(.text+0xbb78): undefined reference to `bpf_prog_update_insn_ptr'


vim +2726 arch/x86/net/bpf_jit_comp.c

  1603	
  1604	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1605			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1606	{
  1607		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1608		struct bpf_insn *insn = bpf_prog->insnsi;
  1609		bool callee_regs_used[4] = {};
  1610		int insn_cnt = bpf_prog->len;
  1611		bool seen_exit = false;
  1612		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1613		void __percpu *priv_frame_ptr = NULL;
  1614		u64 arena_vm_start, user_vm_start;
  1615		void __percpu *priv_stack_ptr;
  1616		int i, excnt = 0;
  1617		int ilen, proglen = 0;
  1618		u8 *prog = temp;
  1619		u32 stack_depth;
  1620		int err;
  1621	
  1622		stack_depth = bpf_prog->aux->stack_depth;
  1623		priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
  1624		if (priv_stack_ptr) {
  1625			priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
  1626			stack_depth = 0;
  1627		}
  1628	
  1629		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1630		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1631	
  1632		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1633	
  1634		emit_prologue(&prog, image, stack_depth,
  1635			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1636			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1637		/* Exception callback will clobber callee regs for its own use, and
  1638		 * restore the original callee regs from main prog's stack frame.
  1639		 */
  1640		if (bpf_prog->aux->exception_boundary) {
  1641			/* We also need to save r12, which is not mapped to any BPF
  1642			 * register, as we throw after entry into the kernel, which may
  1643			 * overwrite r12.
  1644			 */
  1645			push_r12(&prog);
  1646			push_callee_regs(&prog, all_callee_regs_used);
  1647		} else {
  1648			if (arena_vm_start)
  1649				push_r12(&prog);
  1650			push_callee_regs(&prog, callee_regs_used);
  1651		}
  1652		if (arena_vm_start)
  1653			emit_mov_imm64(&prog, X86_REG_R12,
  1654				       arena_vm_start >> 32, (u32) arena_vm_start);
  1655	
  1656		if (priv_frame_ptr)
  1657			emit_priv_frame_ptr(&prog, priv_frame_ptr);
  1658	
  1659		ilen = prog - temp;
  1660		if (rw_image)
  1661			memcpy(rw_image + proglen, temp, ilen);
  1662		proglen += ilen;
  1663		addrs[0] = proglen;
  1664		prog = temp;
  1665	
  1666		for (i = 1; i <= insn_cnt; i++, insn++) {
  1667			u32 abs_xlated_off = bpf_prog->aux->subprog_start + i - 1;
  1668			const s32 imm32 = insn->imm;
  1669			u32 dst_reg = insn->dst_reg;
  1670			u32 src_reg = insn->src_reg;
  1671			u8 b2 = 0, b3 = 0;
  1672			u8 *start_of_ldx;
  1673			s64 jmp_offset;
  1674			s16 insn_off;
  1675			u8 jmp_cond;
  1676			u8 *func;
  1677			int nops;
  1678	
  1679			if (priv_frame_ptr) {
  1680				if (src_reg == BPF_REG_FP)
  1681					src_reg = X86_REG_R9;
  1682	
  1683				if (dst_reg == BPF_REG_FP)
  1684					dst_reg = X86_REG_R9;
  1685			}
  1686	
  1687			switch (insn->code) {
  1688				/* ALU */
  1689			case BPF_ALU | BPF_ADD | BPF_X:
  1690			case BPF_ALU | BPF_SUB | BPF_X:
  1691			case BPF_ALU | BPF_AND | BPF_X:
  1692			case BPF_ALU | BPF_OR | BPF_X:
  1693			case BPF_ALU | BPF_XOR | BPF_X:
  1694			case BPF_ALU64 | BPF_ADD | BPF_X:
  1695			case BPF_ALU64 | BPF_SUB | BPF_X:
  1696			case BPF_ALU64 | BPF_AND | BPF_X:
  1697			case BPF_ALU64 | BPF_OR | BPF_X:
  1698			case BPF_ALU64 | BPF_XOR | BPF_X:
  1699				maybe_emit_mod(&prog, dst_reg, src_reg,
  1700					       BPF_CLASS(insn->code) == BPF_ALU64);
  1701				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1702				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1703				break;
  1704	
  1705			case BPF_ALU64 | BPF_MOV | BPF_X:
  1706				if (insn_is_cast_user(insn)) {
  1707					if (dst_reg != src_reg)
  1708						/* 32-bit mov */
  1709						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1710					/* shl dst_reg, 32 */
  1711					maybe_emit_1mod(&prog, dst_reg, true);
  1712					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1713	
  1714					/* or dst_reg, user_vm_start */
  1715					maybe_emit_1mod(&prog, dst_reg, true);
  1716					if (is_axreg(dst_reg))
  1717						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1718					else
  1719						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1720	
  1721					/* rol dst_reg, 32 */
  1722					maybe_emit_1mod(&prog, dst_reg, true);
  1723					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1724	
  1725					/* xor r11, r11 */
  1726					EMIT3(0x4D, 0x31, 0xDB);
  1727	
  1728					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1729					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1730					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1731	
  1732					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1733					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1734					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1735					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1736					break;
  1737				} else if (insn_is_mov_percpu_addr(insn)) {
  1738					/* mov <dst>, <src> (if necessary) */
  1739					EMIT_mov(dst_reg, src_reg);
  1740	#ifdef CONFIG_SMP
  1741					/* add <dst>, gs:[<off>] */
  1742					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1743					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1744					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1745	#endif
  1746					break;
  1747				}
  1748				fallthrough;
  1749			case BPF_ALU | BPF_MOV | BPF_X:
  1750				if (insn->off == 0)
  1751					emit_mov_reg(&prog,
  1752						     BPF_CLASS(insn->code) == BPF_ALU64,
  1753						     dst_reg, src_reg);
  1754				else
  1755					emit_movsx_reg(&prog, insn->off,
  1756						       BPF_CLASS(insn->code) == BPF_ALU64,
  1757						       dst_reg, src_reg);
  1758				break;
  1759	
  1760				/* neg dst */
  1761			case BPF_ALU | BPF_NEG:
  1762			case BPF_ALU64 | BPF_NEG:
  1763				maybe_emit_1mod(&prog, dst_reg,
  1764						BPF_CLASS(insn->code) == BPF_ALU64);
  1765				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1766				break;
  1767	
  1768			case BPF_ALU | BPF_ADD | BPF_K:
  1769			case BPF_ALU | BPF_SUB | BPF_K:
  1770			case BPF_ALU | BPF_AND | BPF_K:
  1771			case BPF_ALU | BPF_OR | BPF_K:
  1772			case BPF_ALU | BPF_XOR | BPF_K:
  1773			case BPF_ALU64 | BPF_ADD | BPF_K:
  1774			case BPF_ALU64 | BPF_SUB | BPF_K:
  1775			case BPF_ALU64 | BPF_AND | BPF_K:
  1776			case BPF_ALU64 | BPF_OR | BPF_K:
  1777			case BPF_ALU64 | BPF_XOR | BPF_K:
  1778				maybe_emit_1mod(&prog, dst_reg,
  1779						BPF_CLASS(insn->code) == BPF_ALU64);
  1780	
  1781				/*
  1782				 * b3 holds 'normal' opcode, b2 short form only valid
  1783				 * in case dst is eax/rax.
  1784				 */
  1785				switch (BPF_OP(insn->code)) {
  1786				case BPF_ADD:
  1787					b3 = 0xC0;
  1788					b2 = 0x05;
  1789					break;
  1790				case BPF_SUB:
  1791					b3 = 0xE8;
  1792					b2 = 0x2D;
  1793					break;
  1794				case BPF_AND:
  1795					b3 = 0xE0;
  1796					b2 = 0x25;
  1797					break;
  1798				case BPF_OR:
  1799					b3 = 0xC8;
  1800					b2 = 0x0D;
  1801					break;
  1802				case BPF_XOR:
  1803					b3 = 0xF0;
  1804					b2 = 0x35;
  1805					break;
  1806				}
  1807	
  1808				if (is_imm8(imm32))
  1809					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1810				else if (is_axreg(dst_reg))
  1811					EMIT1_off32(b2, imm32);
  1812				else
  1813					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1814				break;
  1815	
  1816			case BPF_ALU64 | BPF_MOV | BPF_K:
  1817			case BPF_ALU | BPF_MOV | BPF_K:
  1818				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1819					       dst_reg, imm32);
  1820				break;
  1821	
  1822			case BPF_LD | BPF_IMM | BPF_DW:
  1823				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1824				insn++;
  1825				i++;
  1826				break;
  1827	
  1828				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1829			case BPF_ALU | BPF_MOD | BPF_X:
  1830			case BPF_ALU | BPF_DIV | BPF_X:
  1831			case BPF_ALU | BPF_MOD | BPF_K:
  1832			case BPF_ALU | BPF_DIV | BPF_K:
  1833			case BPF_ALU64 | BPF_MOD | BPF_X:
  1834			case BPF_ALU64 | BPF_DIV | BPF_X:
  1835			case BPF_ALU64 | BPF_MOD | BPF_K:
  1836			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1837				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1838	
  1839				if (dst_reg != BPF_REG_0)
  1840					EMIT1(0x50); /* push rax */
  1841				if (dst_reg != BPF_REG_3)
  1842					EMIT1(0x52); /* push rdx */
  1843	
  1844				if (BPF_SRC(insn->code) == BPF_X) {
  1845					if (src_reg == BPF_REG_0 ||
  1846					    src_reg == BPF_REG_3) {
  1847						/* mov r11, src_reg */
  1848						EMIT_mov(AUX_REG, src_reg);
  1849						src_reg = AUX_REG;
  1850					}
  1851				} else {
  1852					/* mov r11, imm32 */
  1853					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1854					src_reg = AUX_REG;
  1855				}
  1856	
  1857				if (dst_reg != BPF_REG_0)
  1858					/* mov rax, dst_reg */
  1859					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1860	
  1861				if (insn->off == 0) {
  1862					/*
  1863					 * xor edx, edx
  1864					 * equivalent to 'xor rdx, rdx', but one byte less
  1865					 */
  1866					EMIT2(0x31, 0xd2);
  1867	
  1868					/* div src_reg */
  1869					maybe_emit_1mod(&prog, src_reg, is64);
  1870					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1871				} else {
  1872					if (BPF_CLASS(insn->code) == BPF_ALU)
  1873						EMIT1(0x99); /* cdq */
  1874					else
  1875						EMIT2(0x48, 0x99); /* cqo */
  1876	
  1877					/* idiv src_reg */
  1878					maybe_emit_1mod(&prog, src_reg, is64);
  1879					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1880				}
  1881	
  1882				if (BPF_OP(insn->code) == BPF_MOD &&
  1883				    dst_reg != BPF_REG_3)
  1884					/* mov dst_reg, rdx */
  1885					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1886				else if (BPF_OP(insn->code) == BPF_DIV &&
  1887					 dst_reg != BPF_REG_0)
  1888					/* mov dst_reg, rax */
  1889					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1890	
  1891				if (dst_reg != BPF_REG_3)
  1892					EMIT1(0x5A); /* pop rdx */
  1893				if (dst_reg != BPF_REG_0)
  1894					EMIT1(0x58); /* pop rax */
  1895				break;
  1896			}
  1897	
  1898			case BPF_ALU | BPF_MUL | BPF_K:
  1899			case BPF_ALU64 | BPF_MUL | BPF_K:
  1900				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1901					       BPF_CLASS(insn->code) == BPF_ALU64);
  1902	
  1903				if (is_imm8(imm32))
  1904					/* imul dst_reg, dst_reg, imm8 */
  1905					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1906					      imm32);
  1907				else
  1908					/* imul dst_reg, dst_reg, imm32 */
  1909					EMIT2_off32(0x69,
  1910						    add_2reg(0xC0, dst_reg, dst_reg),
  1911						    imm32);
  1912				break;
  1913	
  1914			case BPF_ALU | BPF_MUL | BPF_X:
  1915			case BPF_ALU64 | BPF_MUL | BPF_X:
  1916				maybe_emit_mod(&prog, src_reg, dst_reg,
  1917					       BPF_CLASS(insn->code) == BPF_ALU64);
  1918	
  1919				/* imul dst_reg, src_reg */
  1920				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1921				break;
  1922	
  1923				/* Shifts */
  1924			case BPF_ALU | BPF_LSH | BPF_K:
  1925			case BPF_ALU | BPF_RSH | BPF_K:
  1926			case BPF_ALU | BPF_ARSH | BPF_K:
  1927			case BPF_ALU64 | BPF_LSH | BPF_K:
  1928			case BPF_ALU64 | BPF_RSH | BPF_K:
  1929			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1930				maybe_emit_1mod(&prog, dst_reg,
  1931						BPF_CLASS(insn->code) == BPF_ALU64);
  1932	
  1933				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1934				if (imm32 == 1)
  1935					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1936				else
  1937					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  1938				break;
  1939	
  1940			case BPF_ALU | BPF_LSH | BPF_X:
  1941			case BPF_ALU | BPF_RSH | BPF_X:
  1942			case BPF_ALU | BPF_ARSH | BPF_X:
  1943			case BPF_ALU64 | BPF_LSH | BPF_X:
  1944			case BPF_ALU64 | BPF_RSH | BPF_X:
  1945			case BPF_ALU64 | BPF_ARSH | BPF_X:
  1946				/* BMI2 shifts aren't better when shift count is already in rcx */
  1947				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  1948					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  1949					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  1950					u8 op;
  1951	
  1952					switch (BPF_OP(insn->code)) {
  1953					case BPF_LSH:
  1954						op = 1; /* prefix 0x66 */
  1955						break;
  1956					case BPF_RSH:
  1957						op = 3; /* prefix 0xf2 */
  1958						break;
  1959					case BPF_ARSH:
  1960						op = 2; /* prefix 0xf3 */
  1961						break;
  1962					}
  1963	
  1964					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  1965	
  1966					break;
  1967				}
  1968	
  1969				if (src_reg != BPF_REG_4) { /* common case */
  1970					/* Check for bad case when dst_reg == rcx */
  1971					if (dst_reg == BPF_REG_4) {
  1972						/* mov r11, dst_reg */
  1973						EMIT_mov(AUX_REG, dst_reg);
  1974						dst_reg = AUX_REG;
  1975					} else {
  1976						EMIT1(0x51); /* push rcx */
  1977					}
  1978					/* mov rcx, src_reg */
  1979					EMIT_mov(BPF_REG_4, src_reg);
  1980				}
  1981	
  1982				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  1983				maybe_emit_1mod(&prog, dst_reg,
  1984						BPF_CLASS(insn->code) == BPF_ALU64);
  1985	
  1986				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1987				EMIT2(0xD3, add_1reg(b3, dst_reg));
  1988	
  1989				if (src_reg != BPF_REG_4) {
  1990					if (insn->dst_reg == BPF_REG_4)
  1991						/* mov dst_reg, r11 */
  1992						EMIT_mov(insn->dst_reg, AUX_REG);
  1993					else
  1994						EMIT1(0x59); /* pop rcx */
  1995				}
  1996	
  1997				break;
  1998	
  1999			case BPF_ALU | BPF_END | BPF_FROM_BE:
  2000			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  2001				switch (imm32) {
  2002				case 16:
  2003					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  2004					EMIT1(0x66);
  2005					if (is_ereg(dst_reg))
  2006						EMIT1(0x41);
  2007					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  2008	
  2009					/* Emit 'movzwl eax, ax' */
  2010					if (is_ereg(dst_reg))
  2011						EMIT3(0x45, 0x0F, 0xB7);
  2012					else
  2013						EMIT2(0x0F, 0xB7);
  2014					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2015					break;
  2016				case 32:
  2017					/* Emit 'bswap eax' to swap lower 4 bytes */
  2018					if (is_ereg(dst_reg))
  2019						EMIT2(0x41, 0x0F);
  2020					else
  2021						EMIT1(0x0F);
  2022					EMIT1(add_1reg(0xC8, dst_reg));
  2023					break;
  2024				case 64:
  2025					/* Emit 'bswap rax' to swap 8 bytes */
  2026					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  2027					      add_1reg(0xC8, dst_reg));
  2028					break;
  2029				}
  2030				break;
  2031	
  2032			case BPF_ALU | BPF_END | BPF_FROM_LE:
  2033				switch (imm32) {
  2034				case 16:
  2035					/*
  2036					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  2037					 * into 64 bit
  2038					 */
  2039					if (is_ereg(dst_reg))
  2040						EMIT3(0x45, 0x0F, 0xB7);
  2041					else
  2042						EMIT2(0x0F, 0xB7);
  2043					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2044					break;
  2045				case 32:
  2046					/* Emit 'mov eax, eax' to clear upper 32-bits */
  2047					if (is_ereg(dst_reg))
  2048						EMIT1(0x45);
  2049					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  2050					break;
  2051				case 64:
  2052					/* nop */
  2053					break;
  2054				}
  2055				break;
  2056	
  2057				/* speculation barrier */
  2058			case BPF_ST | BPF_NOSPEC:
  2059				EMIT_LFENCE();
  2060				break;
  2061	
  2062				/* ST: *(u8*)(dst_reg + off) = imm */
  2063			case BPF_ST | BPF_MEM | BPF_B:
  2064				if (is_ereg(dst_reg))
  2065					EMIT2(0x41, 0xC6);
  2066				else
  2067					EMIT1(0xC6);
  2068				goto st;
  2069			case BPF_ST | BPF_MEM | BPF_H:
  2070				if (is_ereg(dst_reg))
  2071					EMIT3(0x66, 0x41, 0xC7);
  2072				else
  2073					EMIT2(0x66, 0xC7);
  2074				goto st;
  2075			case BPF_ST | BPF_MEM | BPF_W:
  2076				if (is_ereg(dst_reg))
  2077					EMIT2(0x41, 0xC7);
  2078				else
  2079					EMIT1(0xC7);
  2080				goto st;
  2081			case BPF_ST | BPF_MEM | BPF_DW:
  2082				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  2083	
  2084	st:			if (is_imm8(insn->off))
  2085					EMIT2(add_1reg(0x40, dst_reg), insn->off);
  2086				else
  2087					EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
  2088	
  2089				EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
  2090				break;
  2091	
  2092				/* STX: *(u8*)(dst_reg + off) = src_reg */
  2093			case BPF_STX | BPF_MEM | BPF_B:
  2094			case BPF_STX | BPF_MEM | BPF_H:
  2095			case BPF_STX | BPF_MEM | BPF_W:
  2096			case BPF_STX | BPF_MEM | BPF_DW:
  2097				emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2098				break;
  2099	
  2100			case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
  2101			case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
  2102			case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
  2103			case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
  2104				start_of_ldx = prog;
  2105				emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
  2106				goto populate_extable;
  2107	
  2108				/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
  2109			case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
  2110			case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
  2111			case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
  2112			case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
  2113			case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
  2114			case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
  2115			case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
  2116			case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
  2117				start_of_ldx = prog;
  2118				if (BPF_CLASS(insn->code) == BPF_LDX)
  2119					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2120				else
  2121					emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2122	populate_extable:
  2123				{
  2124					struct exception_table_entry *ex;
  2125					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2126					u32 arena_reg, fixup_reg;
  2127					s64 delta;
  2128	
  2129					if (!bpf_prog->aux->extable)
  2130						break;
  2131	
  2132					if (excnt >= bpf_prog->aux->num_exentries) {
  2133						pr_err("mem32 extable bug\n");
  2134						return -EFAULT;
  2135					}
  2136					ex = &bpf_prog->aux->extable[excnt++];
  2137	
  2138					delta = _insn - (u8 *)&ex->insn;
  2139					/* switch ex to rw buffer for writes */
  2140					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2141	
  2142					ex->insn = delta;
  2143	
  2144					ex->data = EX_TYPE_BPF;
  2145	
  2146					/*
  2147					 * src_reg/dst_reg holds the address in the arena region with upper
  2148					 * 32-bits being zero because of a preceding addr_space_cast(r<n>,
  2149					 * 0x0, 0x1) instruction. This address is adjusted with the addition
  2150					 * of arena_vm_start (see the implementation of BPF_PROBE_MEM32 and
  2151					 * BPF_PROBE_ATOMIC) before being used for the memory access. Pass
  2152					 * the reg holding the unmodified 32-bit address to
  2153					 * ex_handler_bpf().
  2154					 */
  2155					if (BPF_CLASS(insn->code) == BPF_LDX) {
  2156						arena_reg = reg2pt_regs[src_reg];
  2157						fixup_reg = reg2pt_regs[dst_reg];
  2158					} else {
  2159						arena_reg = reg2pt_regs[dst_reg];
  2160						fixup_reg = DONT_CLEAR;
  2161					}
  2162	
  2163					ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
  2164						    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
  2165						    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
  2166					ex->fixup |= FIXUP_ARENA_ACCESS;
  2167	
  2168					ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
  2169				}
  2170				break;
  2171	
  2172				/* LDX: dst_reg = *(u8*)(src_reg + off) */
  2173			case BPF_LDX | BPF_MEM | BPF_B:
  2174			case BPF_LDX | BPF_PROBE_MEM | BPF_B:
  2175			case BPF_LDX | BPF_MEM | BPF_H:
  2176			case BPF_LDX | BPF_PROBE_MEM | BPF_H:
  2177			case BPF_LDX | BPF_MEM | BPF_W:
  2178			case BPF_LDX | BPF_PROBE_MEM | BPF_W:
  2179			case BPF_LDX | BPF_MEM | BPF_DW:
  2180			case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
  2181				/* LDXS: dst_reg = *(s8*)(src_reg + off) */
  2182			case BPF_LDX | BPF_MEMSX | BPF_B:
  2183			case BPF_LDX | BPF_MEMSX | BPF_H:
  2184			case BPF_LDX | BPF_MEMSX | BPF_W:
  2185			case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
  2186			case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
  2187			case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
  2188				insn_off = insn->off;
  2189	
  2190				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2191				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2192					/* Conservatively check that src_reg + insn->off is a kernel address:
  2193					 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
  2194					 *   and
  2195					 *   src_reg + insn->off < VSYSCALL_ADDR
  2196					 */
  2197	
  2198					u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
  2199					u8 *end_of_jmp;
  2200	
  2201					/* movabsq r10, VSYSCALL_ADDR */
  2202					emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
  2203						       (u32)(long)VSYSCALL_ADDR);
  2204	
  2205					/* mov src_reg, r11 */
  2206					EMIT_mov(AUX_REG, src_reg);
  2207	
  2208					if (insn->off) {
  2209						/* add r11, insn->off */
  2210						maybe_emit_1mod(&prog, AUX_REG, true);
  2211						EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
  2212					}
  2213	
  2214					/* sub r11, r10 */
  2215					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2216					EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2217	
  2218					/* movabsq r10, limit */
  2219					emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
  2220						       (u32)(long)limit);
  2221	
  2222					/* cmp r10, r11 */
  2223					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2224					EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2225	
  2226					/* if unsigned '>', goto load */
  2227					EMIT2(X86_JA, 0);
  2228					end_of_jmp = prog;
  2229	
  2230					/* xor dst_reg, dst_reg */
  2231					emit_mov_imm32(&prog, false, dst_reg, 0);
  2232					/* jmp byte_after_ldx */
  2233					EMIT2(0xEB, 0);
  2234	
  2235					/* populate jmp_offset for JAE above to jump to start_of_ldx */
  2236					start_of_ldx = prog;
  2237					end_of_jmp[-1] = start_of_ldx - end_of_jmp;
  2238				}
  2239				if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
  2240				    BPF_MODE(insn->code) == BPF_MEMSX)
  2241					emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2242				else
  2243					emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2244				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2245				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2246					struct exception_table_entry *ex;
  2247					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2248					s64 delta;
  2249	
  2250					/* populate jmp_offset for JMP above */
  2251					start_of_ldx[-1] = prog - start_of_ldx;
  2252	
  2253					if (!bpf_prog->aux->extable)
  2254						break;
  2255	
  2256					if (excnt >= bpf_prog->aux->num_exentries) {
  2257						pr_err("ex gen bug\n");
  2258						return -EFAULT;
  2259					}
  2260					ex = &bpf_prog->aux->extable[excnt++];
  2261	
  2262					delta = _insn - (u8 *)&ex->insn;
  2263					if (!is_simm32(delta)) {
  2264						pr_err("extable->insn doesn't fit into 32-bit\n");
  2265						return -EFAULT;
  2266					}
  2267					/* switch ex to rw buffer for writes */
  2268					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2269	
  2270					ex->insn = delta;
  2271	
  2272					ex->data = EX_TYPE_BPF;
  2273	
  2274					if (dst_reg > BPF_REG_9) {
  2275						pr_err("verifier error\n");
  2276						return -EFAULT;
  2277					}
  2278					/*
  2279					 * Compute size of x86 insn and its target dest x86 register.
  2280					 * ex_handler_bpf() will use lower 8 bits to adjust
  2281					 * pt_regs->ip to jump over this x86 instruction
  2282					 * and upper bits to figure out which pt_regs to zero out.
  2283					 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
  2284					 * of 4 bytes will be ignored and rbx will be zero inited.
  2285					 */
  2286					ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
  2287						    FIELD_PREP(FIXUP_REG_MASK, reg2pt_regs[dst_reg]);
  2288				}
  2289				break;
  2290	
  2291			case BPF_STX | BPF_ATOMIC | BPF_B:
  2292			case BPF_STX | BPF_ATOMIC | BPF_H:
  2293				if (!bpf_atomic_is_load_store(insn)) {
  2294					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2295					return -EFAULT;
  2296				}
  2297				fallthrough;
  2298			case BPF_STX | BPF_ATOMIC | BPF_W:
  2299			case BPF_STX | BPF_ATOMIC | BPF_DW:
  2300				if (insn->imm == (BPF_AND | BPF_FETCH) ||
  2301				    insn->imm == (BPF_OR | BPF_FETCH) ||
  2302				    insn->imm == (BPF_XOR | BPF_FETCH)) {
  2303					bool is64 = BPF_SIZE(insn->code) == BPF_DW;
  2304					u32 real_src_reg = src_reg;
  2305					u32 real_dst_reg = dst_reg;
  2306					u8 *branch_target;
  2307	
  2308					/*
  2309					 * Can't be implemented with a single x86 insn.
  2310					 * Need to do a CMPXCHG loop.
  2311					 */
  2312	
  2313					/* Will need RAX as a CMPXCHG operand so save R0 */
  2314					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
  2315					if (src_reg == BPF_REG_0)
  2316						real_src_reg = BPF_REG_AX;
  2317					if (dst_reg == BPF_REG_0)
  2318						real_dst_reg = BPF_REG_AX;
  2319	
  2320					branch_target = prog;
  2321					/* Load old value */
  2322					emit_ldx(&prog, BPF_SIZE(insn->code),
  2323						 BPF_REG_0, real_dst_reg, insn->off);
  2324					/*
  2325					 * Perform the (commutative) operation locally,
  2326					 * put the result in the AUX_REG.
  2327					 */
  2328					emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
  2329					maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
  2330					EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
  2331					      add_2reg(0xC0, AUX_REG, real_src_reg));
  2332					/* Attempt to swap in new value */
  2333					err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
  2334							      real_dst_reg, AUX_REG,
  2335							      insn->off,
  2336							      BPF_SIZE(insn->code));
  2337					if (WARN_ON(err))
  2338						return err;
  2339					/*
  2340					 * ZF tells us whether we won the race. If it's
  2341					 * cleared we need to try again.
  2342					 */
  2343					EMIT2(X86_JNE, -(prog - branch_target) - 2);
  2344					/* Return the pre-modification value */
  2345					emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
  2346					/* Restore R0 after clobbering RAX */
  2347					emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
  2348					break;
  2349				}
  2350	
  2351				if (bpf_atomic_is_load_store(insn))
  2352					err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
  2353								insn->off, BPF_SIZE(insn->code));
  2354				else
  2355					err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
  2356							      insn->off, BPF_SIZE(insn->code));
  2357				if (err)
  2358					return err;
  2359				break;
  2360	
  2361			case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
  2362			case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
  2363				if (!bpf_atomic_is_load_store(insn)) {
  2364					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2365					return -EFAULT;
  2366				}
  2367				fallthrough;
  2368			case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
  2369			case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
  2370				start_of_ldx = prog;
  2371	
  2372				if (bpf_atomic_is_load_store(insn))
  2373					err = emit_atomic_ld_st_index(&prog, insn->imm,
  2374								      BPF_SIZE(insn->code), dst_reg,
  2375								      src_reg, X86_REG_R12, insn->off);
  2376				else
  2377					err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
  2378								    dst_reg, src_reg, X86_REG_R12,
  2379								    insn->off);
  2380				if (err)
  2381					return err;
  2382				goto populate_extable;
  2383	
  2384				/* call */
  2385			case BPF_JMP | BPF_CALL: {
  2386				u8 *ip = image + addrs[i - 1];
  2387	
  2388				func = (u8 *) __bpf_call_base + imm32;
  2389				if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
  2390					LOAD_TAIL_CALL_CNT_PTR(stack_depth);
  2391					ip += 7;
  2392				}
  2393				if (!imm32)
  2394					return -EINVAL;
  2395				if (priv_frame_ptr) {
  2396					push_r9(&prog);
  2397					ip += 2;
  2398				}
  2399				ip += x86_call_depth_emit_accounting(&prog, func, ip);
  2400				if (emit_call(&prog, func, ip))
  2401					return -EINVAL;
  2402				if (priv_frame_ptr)
  2403					pop_r9(&prog);
  2404				break;
  2405			}
  2406	
  2407			case BPF_JMP | BPF_TAIL_CALL:
  2408				if (imm32)
  2409					emit_bpf_tail_call_direct(bpf_prog,
  2410								  &bpf_prog->aux->poke_tab[imm32 - 1],
  2411								  &prog, image + addrs[i - 1],
  2412								  callee_regs_used,
  2413								  stack_depth,
  2414								  ctx);
  2415				else
  2416					emit_bpf_tail_call_indirect(bpf_prog,
  2417								    &prog,
  2418								    callee_regs_used,
  2419								    stack_depth,
  2420								    image + addrs[i - 1],
  2421								    ctx);
  2422				break;
  2423	
  2424				/* cond jump */
  2425			case BPF_JMP | BPF_JEQ | BPF_X:
  2426			case BPF_JMP | BPF_JNE | BPF_X:
  2427			case BPF_JMP | BPF_JGT | BPF_X:
  2428			case BPF_JMP | BPF_JLT | BPF_X:
  2429			case BPF_JMP | BPF_JGE | BPF_X:
  2430			case BPF_JMP | BPF_JLE | BPF_X:
  2431			case BPF_JMP | BPF_JSGT | BPF_X:
  2432			case BPF_JMP | BPF_JSLT | BPF_X:
  2433			case BPF_JMP | BPF_JSGE | BPF_X:
  2434			case BPF_JMP | BPF_JSLE | BPF_X:
  2435			case BPF_JMP32 | BPF_JEQ | BPF_X:
  2436			case BPF_JMP32 | BPF_JNE | BPF_X:
  2437			case BPF_JMP32 | BPF_JGT | BPF_X:
  2438			case BPF_JMP32 | BPF_JLT | BPF_X:
  2439			case BPF_JMP32 | BPF_JGE | BPF_X:
  2440			case BPF_JMP32 | BPF_JLE | BPF_X:
  2441			case BPF_JMP32 | BPF_JSGT | BPF_X:
  2442			case BPF_JMP32 | BPF_JSLT | BPF_X:
  2443			case BPF_JMP32 | BPF_JSGE | BPF_X:
  2444			case BPF_JMP32 | BPF_JSLE | BPF_X:
  2445				/* cmp dst_reg, src_reg */
  2446				maybe_emit_mod(&prog, dst_reg, src_reg,
  2447					       BPF_CLASS(insn->code) == BPF_JMP);
  2448				EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
  2449				goto emit_cond_jmp;
  2450	
  2451			case BPF_JMP | BPF_JSET | BPF_X:
  2452			case BPF_JMP32 | BPF_JSET | BPF_X:
  2453				/* test dst_reg, src_reg */
  2454				maybe_emit_mod(&prog, dst_reg, src_reg,
  2455					       BPF_CLASS(insn->code) == BPF_JMP);
  2456				EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
  2457				goto emit_cond_jmp;
  2458	
  2459			case BPF_JMP | BPF_JSET | BPF_K:
  2460			case BPF_JMP32 | BPF_JSET | BPF_K:
  2461				/* test dst_reg, imm32 */
  2462				maybe_emit_1mod(&prog, dst_reg,
  2463						BPF_CLASS(insn->code) == BPF_JMP);
  2464				EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
  2465				goto emit_cond_jmp;
  2466	
  2467			case BPF_JMP | BPF_JEQ | BPF_K:
  2468			case BPF_JMP | BPF_JNE | BPF_K:
  2469			case BPF_JMP | BPF_JGT | BPF_K:
  2470			case BPF_JMP | BPF_JLT | BPF_K:
  2471			case BPF_JMP | BPF_JGE | BPF_K:
  2472			case BPF_JMP | BPF_JLE | BPF_K:
  2473			case BPF_JMP | BPF_JSGT | BPF_K:
  2474			case BPF_JMP | BPF_JSLT | BPF_K:
  2475			case BPF_JMP | BPF_JSGE | BPF_K:
  2476			case BPF_JMP | BPF_JSLE | BPF_K:
  2477			case BPF_JMP32 | BPF_JEQ | BPF_K:
  2478			case BPF_JMP32 | BPF_JNE | BPF_K:
  2479			case BPF_JMP32 | BPF_JGT | BPF_K:
  2480			case BPF_JMP32 | BPF_JLT | BPF_K:
  2481			case BPF_JMP32 | BPF_JGE | BPF_K:
  2482			case BPF_JMP32 | BPF_JLE | BPF_K:
  2483			case BPF_JMP32 | BPF_JSGT | BPF_K:
  2484			case BPF_JMP32 | BPF_JSLT | BPF_K:
  2485			case BPF_JMP32 | BPF_JSGE | BPF_K:
  2486			case BPF_JMP32 | BPF_JSLE | BPF_K:
  2487				/* test dst_reg, dst_reg to save one extra byte */
  2488				if (imm32 == 0) {
  2489					maybe_emit_mod(&prog, dst_reg, dst_reg,
  2490						       BPF_CLASS(insn->code) == BPF_JMP);
  2491					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  2492					goto emit_cond_jmp;
  2493				}
  2494	
  2495				/* cmp dst_reg, imm8/32 */
  2496				maybe_emit_1mod(&prog, dst_reg,
  2497						BPF_CLASS(insn->code) == BPF_JMP);
  2498	
  2499				if (is_imm8(imm32))
  2500					EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
  2501				else
  2502					EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
  2503	
  2504	emit_cond_jmp:		/* Convert BPF opcode to x86 */
  2505				switch (BPF_OP(insn->code)) {
  2506				case BPF_JEQ:
  2507					jmp_cond = X86_JE;
  2508					break;
  2509				case BPF_JSET:
  2510				case BPF_JNE:
  2511					jmp_cond = X86_JNE;
  2512					break;
  2513				case BPF_JGT:
  2514					/* GT is unsigned '>', JA in x86 */
  2515					jmp_cond = X86_JA;
  2516					break;
  2517				case BPF_JLT:
  2518					/* LT is unsigned '<', JB in x86 */
  2519					jmp_cond = X86_JB;
  2520					break;
  2521				case BPF_JGE:
  2522					/* GE is unsigned '>=', JAE in x86 */
  2523					jmp_cond = X86_JAE;
  2524					break;
  2525				case BPF_JLE:
  2526					/* LE is unsigned '<=', JBE in x86 */
  2527					jmp_cond = X86_JBE;
  2528					break;
  2529				case BPF_JSGT:
  2530					/* Signed '>', GT in x86 */
  2531					jmp_cond = X86_JG;
  2532					break;
  2533				case BPF_JSLT:
  2534					/* Signed '<', LT in x86 */
  2535					jmp_cond = X86_JL;
  2536					break;
  2537				case BPF_JSGE:
  2538					/* Signed '>=', GE in x86 */
  2539					jmp_cond = X86_JGE;
  2540					break;
  2541				case BPF_JSLE:
  2542					/* Signed '<=', LE in x86 */
  2543					jmp_cond = X86_JLE;
  2544					break;
  2545				default: /* to silence GCC warning */
  2546					return -EFAULT;
  2547				}
  2548				jmp_offset = addrs[i + insn->off] - addrs[i];
  2549				if (is_imm8_jmp_offset(jmp_offset)) {
  2550					if (jmp_padding) {
  2551						/* To keep the jmp_offset valid, the extra bytes are
  2552						 * padded before the jump insn, so we subtract the
  2553						 * 2 bytes of jmp_cond insn from INSN_SZ_DIFF.
  2554						 *
  2555						 * If the previous pass already emits an imm8
  2556						 * jmp_cond, then this BPF insn won't shrink, so
  2557						 * "nops" is 0.
  2558						 *
  2559						 * On the other hand, if the previous pass emits an
  2560						 * imm32 jmp_cond, the extra 4 bytes(*) is padded to
  2561						 * keep the image from shrinking further.
  2562						 *
  2563						 * (*) imm32 jmp_cond is 6 bytes, and imm8 jmp_cond
  2564						 *     is 2 bytes, so the size difference is 4 bytes.
  2565						 */
  2566						nops = INSN_SZ_DIFF - 2;
  2567						if (nops != 0 && nops != 4) {
  2568							pr_err("unexpected jmp_cond padding: %d bytes\n",
  2569							       nops);
  2570							return -EFAULT;
  2571						}
  2572						emit_nops(&prog, nops);
  2573					}
  2574					EMIT2(jmp_cond, jmp_offset);
  2575				} else if (is_simm32(jmp_offset)) {
  2576					EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
  2577				} else {
  2578					pr_err("cond_jmp gen bug %llx\n", jmp_offset);
  2579					return -EFAULT;
  2580				}
  2581	
  2582				break;
  2583	
  2584			case BPF_JMP | BPF_JA:
  2585			case BPF_JMP32 | BPF_JA:
  2586				if (BPF_CLASS(insn->code) == BPF_JMP) {
  2587					if (insn->off == -1)
  2588						/* -1 jmp instructions will always jump
  2589						 * backwards two bytes. Explicitly handling
  2590						 * this case avoids wasting too many passes
  2591						 * when there are long sequences of replaced
  2592						 * dead code.
  2593						 */
  2594						jmp_offset = -2;
  2595					else
  2596						jmp_offset = addrs[i + insn->off] - addrs[i];
  2597				} else {
  2598					if (insn->imm == -1)
  2599						jmp_offset = -2;
  2600					else
  2601						jmp_offset = addrs[i + insn->imm] - addrs[i];
  2602				}
  2603	
  2604				if (!jmp_offset) {
  2605					/*
  2606					 * If jmp_padding is enabled, the extra nops will
  2607					 * be inserted. Otherwise, optimize out nop jumps.
  2608					 */
  2609					if (jmp_padding) {
  2610						/* There are 3 possible conditions.
  2611						 * (1) This BPF_JA is already optimized out in
  2612						 *     the previous run, so there is no need
  2613						 *     to pad any extra byte (0 byte).
  2614						 * (2) The previous pass emits an imm8 jmp,
  2615						 *     so we pad 2 bytes to match the previous
  2616						 *     insn size.
  2617						 * (3) Similarly, the previous pass emits an
  2618						 *     imm32 jmp, and 5 bytes is padded.
  2619						 */
  2620						nops = INSN_SZ_DIFF;
  2621						if (nops != 0 && nops != 2 && nops != 5) {
  2622							pr_err("unexpected nop jump padding: %d bytes\n",
  2623							       nops);
  2624							return -EFAULT;
  2625						}
  2626						emit_nops(&prog, nops);
  2627					}
  2628					break;
  2629				}
  2630	emit_jmp:
  2631				if (is_imm8_jmp_offset(jmp_offset)) {
  2632					if (jmp_padding) {
  2633						/* To avoid breaking jmp_offset, the extra bytes
  2634						 * are padded before the actual jmp insn, so
  2635						 * 2 bytes is subtracted from INSN_SZ_DIFF.
  2636						 *
  2637						 * If the previous pass already emits an imm8
  2638						 * jmp, there is nothing to pad (0 byte).
  2639						 *
  2640						 * If it emits an imm32 jmp (5 bytes) previously
  2641						 * and now an imm8 jmp (2 bytes), then we pad
  2642						 * (5 - 2 = 3) bytes to stop the image from
  2643						 * shrinking further.
  2644						 */
  2645						nops = INSN_SZ_DIFF - 2;
  2646						if (nops != 0 && nops != 3) {
  2647							pr_err("unexpected jump padding: %d bytes\n",
  2648							       nops);
  2649							return -EFAULT;
  2650						}
  2651						emit_nops(&prog, INSN_SZ_DIFF - 2);
  2652					}
  2653					EMIT2(0xEB, jmp_offset);
  2654				} else if (is_simm32(jmp_offset)) {
  2655					EMIT1_off32(0xE9, jmp_offset);
  2656				} else {
  2657					pr_err("jmp gen bug %llx\n", jmp_offset);
  2658					return -EFAULT;
  2659				}
  2660				break;
  2661	
  2662			case BPF_JMP | BPF_EXIT:
  2663				if (seen_exit) {
  2664					jmp_offset = ctx->cleanup_addr - addrs[i];
  2665					goto emit_jmp;
  2666				}
  2667				seen_exit = true;
  2668				/* Update cleanup_addr */
  2669				ctx->cleanup_addr = proglen;
  2670				if (bpf_prog_was_classic(bpf_prog) &&
  2671				    !capable(CAP_SYS_ADMIN)) {
  2672					u8 *ip = image + addrs[i - 1];
  2673	
  2674					if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
  2675						return -EINVAL;
  2676				}
  2677				if (bpf_prog->aux->exception_boundary) {
  2678					pop_callee_regs(&prog, all_callee_regs_used);
  2679					pop_r12(&prog);
  2680				} else {
  2681					pop_callee_regs(&prog, callee_regs_used);
  2682					if (arena_vm_start)
  2683						pop_r12(&prog);
  2684				}
  2685				EMIT1(0xC9);         /* leave */
  2686				emit_return(&prog, image + addrs[i - 1] + (prog - temp));
  2687				break;
  2688	
  2689			default:
  2690				/*
  2691				 * By design x86-64 JIT should support all BPF instructions.
  2692				 * This error will be seen if new instruction was added
  2693				 * to the interpreter, but not to the JIT, or if there is
  2694				 * junk in bpf_prog.
  2695				 */
  2696				pr_err("bpf_jit: unknown opcode %02x\n", insn->code);
  2697				return -EINVAL;
  2698			}
  2699	
  2700			ilen = prog - temp;
  2701			if (ilen > BPF_MAX_INSN_SIZE) {
  2702				pr_err("bpf_jit: fatal insn size error\n");
  2703				return -EFAULT;
  2704			}
  2705	
  2706			if (image) {
  2707				/*
  2708				 * When populating the image, assert that:
  2709				 *
  2710				 *  i) We do not write beyond the allocated space, and
  2711				 * ii) addrs[i] did not change from the prior run, in order
  2712				 *     to validate assumptions made for computing branch
  2713				 *     displacements.
  2714				 */
  2715				if (unlikely(proglen + ilen > oldproglen ||
  2716					     proglen + ilen != addrs[i])) {
  2717					pr_err("bpf_jit: fatal error\n");
  2718					return -EFAULT;
  2719				}
  2720				memcpy(rw_image + proglen, temp, ilen);
  2721	
  2722				/*
  2723				 * Instruction arrays need to know how xlated code
  2724				 * maps to jitted code
  2725				 */
> 2726				bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen,
  2727							 image + proglen);
  2728			}
  2729			proglen += ilen;
  2730			addrs[i] = proglen;
  2731			prog = temp;
  2732		}
  2733	
  2734		if (image && excnt != bpf_prog->aux->num_exentries) {
  2735			pr_err("extable is not populated\n");
  2736			return -EFAULT;
  2737		}
  2738		return proglen;
  2739	}
  2740	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

