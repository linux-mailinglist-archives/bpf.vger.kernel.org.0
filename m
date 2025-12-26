Return-Path: <bpf+bounces-77445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD88CDE50F
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 05:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009C6301C924
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13A1917F0;
	Fri, 26 Dec 2025 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMn5HrK7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EE1DF742;
	Fri, 26 Dec 2025 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766722657; cv=none; b=VEluEjLr9008H/bRE4qBw7LlLzCHvmwK3IQPmLJijLi6TQ9892HXEjX/Qwq1el6nlkOM1XrrppfWovEJ8H4ay5GvW7scs/GIHmkjlaLwLPZ/1MuIZ0vFhqhficg93aWw6Ad7p6BCcDVvnfyW0/jyReUh9rUAchm8gS4KXfycHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766722657; c=relaxed/simple;
	bh=2GHnw5+Dg9hYR9f+Q51H9Tq9iIgS8ZoPz2xU6bSd98I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7yddj9HtE+FPrqq3i62z6RWMSvVcAJZaagJtoPgrcWnYmpzt28ApPfOuJm5ISWt4Hb/fvKQcpWjX9+290rMoB2OdDrRf5w9UsZbgG/rquSkx15Bop1rnLUV4YjdfHCOjj8sQZTFBbSwgM9vYg4n5aRG6sJzt+0vRdU+4ar4/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMn5HrK7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766722653; x=1798258653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GHnw5+Dg9hYR9f+Q51H9Tq9iIgS8ZoPz2xU6bSd98I=;
  b=KMn5HrK7Xyxu2oZnQVlyE7cxAvDgTQGP8MddnQ2vNNmMqdE/9Gt//2zr
   KPbTsskCa+SJVWvJhDr30l5WS061DizDy/Z4EWruQ+GkqP/QXNjEP+X6o
   Y3j6fd07yrdflWBb/zH7QcETCYcR9yJtBnjoeHkbmUSvLRiukFxg9QvrD
   npMlw8kiorMInhslPCbnLIJdCjg11EtOFQHqcDyiWwAa9cuO2i37tgsY3
   IxKt+tCKMB6s2JOwNs3p9dn0MKBSCYBixoElEcFPdSyjxNDe+Ep9Q0MZP
   uAPU7FDWguGnzT/TZYX+offa0oeRUWdDhkjehxIl2KB45Qnj5H4NDUjJE
   w==;
X-CSE-ConnectionGUID: 3xwiyZ9kRI+l4/ZOPjzr/w==
X-CSE-MsgGUID: ue+ozFCFQh2cOvwwV4VBVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68476797"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="68476797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 20:17:32 -0800
X-CSE-ConnectionGUID: PCvVDT77SSqZG7tD3DaOcQ==
X-CSE-MsgGUID: I8CsONIYTmKD5GkT+j/h4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="237718926"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Dec 2025 20:17:26 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYzGV-000000004hR-1twK;
	Fri, 26 Dec 2025 04:17:23 +0000
Date: Fri, 26 Dec 2025 12:16:46 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, dsahern@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	jiang.biao@linux.dev, x86@kernel.org, hpa@zytor.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for
 x86_64
Message-ID: <202512261106.r593kldO-lkp@intel.com>
References: <20251225104459.204104-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225104459.204104-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-x86-inline-bpf_get_current_task-for-x86_64/20251225-184906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251225104459.204104-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for x86_64
config: x86_64-buildonly-randconfig-003-20251226 (https://download.01.org/0day-ci/archive/20251226/202512261106.r593kldO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512261106.r593kldO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512261106.r593kldO-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp.c: In function 'do_jit':
>> arch/x86/net/bpf_jit_comp.c:2460:67: error: passing argument 2 of 'emit_ldx_percpu_r0' from pointer to non-enclosed address space
    2460 |                                         emit_ldx_percpu_r0(&prog, &const_current_task);
         |                                                                   ^~~~~~~~~~~~~~~~~~~


vim +/emit_ldx_percpu_r0 +2460 arch/x86/net/bpf_jit_comp.c

  1663	
  1664	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1665			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1666	{
  1667		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1668		struct bpf_insn *insn = bpf_prog->insnsi;
  1669		bool callee_regs_used[4] = {};
  1670		int insn_cnt = bpf_prog->len;
  1671		bool seen_exit = false;
  1672		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1673		void __percpu *priv_frame_ptr = NULL;
  1674		u64 arena_vm_start, user_vm_start;
  1675		void __percpu *priv_stack_ptr;
  1676		int i, excnt = 0;
  1677		int ilen, proglen = 0;
  1678		u8 *prog = temp;
  1679		u32 stack_depth;
  1680		int err;
  1681	
  1682		stack_depth = bpf_prog->aux->stack_depth;
  1683		priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
  1684		if (priv_stack_ptr) {
  1685			priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
  1686			stack_depth = 0;
  1687		}
  1688	
  1689		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1690		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1691	
  1692		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1693	
  1694		emit_prologue(&prog, image, stack_depth,
  1695			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1696			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1697	
  1698		bpf_prog->aux->ksym.fp_start = prog - temp;
  1699	
  1700		/* Exception callback will clobber callee regs for its own use, and
  1701		 * restore the original callee regs from main prog's stack frame.
  1702		 */
  1703		if (bpf_prog->aux->exception_boundary) {
  1704			/* We also need to save r12, which is not mapped to any BPF
  1705			 * register, as we throw after entry into the kernel, which may
  1706			 * overwrite r12.
  1707			 */
  1708			push_r12(&prog);
  1709			push_callee_regs(&prog, all_callee_regs_used);
  1710		} else {
  1711			if (arena_vm_start)
  1712				push_r12(&prog);
  1713			push_callee_regs(&prog, callee_regs_used);
  1714		}
  1715		if (arena_vm_start)
  1716			emit_mov_imm64(&prog, X86_REG_R12,
  1717				       arena_vm_start >> 32, (u32) arena_vm_start);
  1718	
  1719		if (priv_frame_ptr)
  1720			emit_priv_frame_ptr(&prog, priv_frame_ptr);
  1721	
  1722		ilen = prog - temp;
  1723		if (rw_image)
  1724			memcpy(rw_image + proglen, temp, ilen);
  1725		proglen += ilen;
  1726		addrs[0] = proglen;
  1727		prog = temp;
  1728	
  1729		for (i = 1; i <= insn_cnt; i++, insn++) {
  1730			const s32 imm32 = insn->imm;
  1731			u32 dst_reg = insn->dst_reg;
  1732			u32 src_reg = insn->src_reg;
  1733			u8 b2 = 0, b3 = 0;
  1734			u8 *start_of_ldx;
  1735			s64 jmp_offset;
  1736			s16 insn_off;
  1737			u8 jmp_cond;
  1738			u8 *func;
  1739			int nops;
  1740	
  1741			if (priv_frame_ptr) {
  1742				if (src_reg == BPF_REG_FP)
  1743					src_reg = X86_REG_R9;
  1744	
  1745				if (dst_reg == BPF_REG_FP)
  1746					dst_reg = X86_REG_R9;
  1747			}
  1748	
  1749			switch (insn->code) {
  1750				/* ALU */
  1751			case BPF_ALU | BPF_ADD | BPF_X:
  1752			case BPF_ALU | BPF_SUB | BPF_X:
  1753			case BPF_ALU | BPF_AND | BPF_X:
  1754			case BPF_ALU | BPF_OR | BPF_X:
  1755			case BPF_ALU | BPF_XOR | BPF_X:
  1756			case BPF_ALU64 | BPF_ADD | BPF_X:
  1757			case BPF_ALU64 | BPF_SUB | BPF_X:
  1758			case BPF_ALU64 | BPF_AND | BPF_X:
  1759			case BPF_ALU64 | BPF_OR | BPF_X:
  1760			case BPF_ALU64 | BPF_XOR | BPF_X:
  1761				maybe_emit_mod(&prog, dst_reg, src_reg,
  1762					       BPF_CLASS(insn->code) == BPF_ALU64);
  1763				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1764				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1765				break;
  1766	
  1767			case BPF_ALU64 | BPF_MOV | BPF_X:
  1768				if (insn_is_cast_user(insn)) {
  1769					if (dst_reg != src_reg)
  1770						/* 32-bit mov */
  1771						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1772					/* shl dst_reg, 32 */
  1773					maybe_emit_1mod(&prog, dst_reg, true);
  1774					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1775	
  1776					/* or dst_reg, user_vm_start */
  1777					maybe_emit_1mod(&prog, dst_reg, true);
  1778					if (is_axreg(dst_reg))
  1779						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1780					else
  1781						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1782	
  1783					/* rol dst_reg, 32 */
  1784					maybe_emit_1mod(&prog, dst_reg, true);
  1785					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1786	
  1787					/* xor r11, r11 */
  1788					EMIT3(0x4D, 0x31, 0xDB);
  1789	
  1790					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1791					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1792					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1793	
  1794					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1795					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1796					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1797					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1798					break;
  1799				} else if (insn_is_mov_percpu_addr(insn)) {
  1800					/* mov <dst>, <src> (if necessary) */
  1801					EMIT_mov(dst_reg, src_reg);
  1802	#ifdef CONFIG_SMP
  1803					/* add <dst>, gs:[<off>] */
  1804					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1805					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1806					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1807	#endif
  1808					break;
  1809				}
  1810				fallthrough;
  1811			case BPF_ALU | BPF_MOV | BPF_X:
  1812				if (insn->off == 0)
  1813					emit_mov_reg(&prog,
  1814						     BPF_CLASS(insn->code) == BPF_ALU64,
  1815						     dst_reg, src_reg);
  1816				else
  1817					emit_movsx_reg(&prog, insn->off,
  1818						       BPF_CLASS(insn->code) == BPF_ALU64,
  1819						       dst_reg, src_reg);
  1820				break;
  1821	
  1822				/* neg dst */
  1823			case BPF_ALU | BPF_NEG:
  1824			case BPF_ALU64 | BPF_NEG:
  1825				maybe_emit_1mod(&prog, dst_reg,
  1826						BPF_CLASS(insn->code) == BPF_ALU64);
  1827				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1828				break;
  1829	
  1830			case BPF_ALU | BPF_ADD | BPF_K:
  1831			case BPF_ALU | BPF_SUB | BPF_K:
  1832			case BPF_ALU | BPF_AND | BPF_K:
  1833			case BPF_ALU | BPF_OR | BPF_K:
  1834			case BPF_ALU | BPF_XOR | BPF_K:
  1835			case BPF_ALU64 | BPF_ADD | BPF_K:
  1836			case BPF_ALU64 | BPF_SUB | BPF_K:
  1837			case BPF_ALU64 | BPF_AND | BPF_K:
  1838			case BPF_ALU64 | BPF_OR | BPF_K:
  1839			case BPF_ALU64 | BPF_XOR | BPF_K:
  1840				maybe_emit_1mod(&prog, dst_reg,
  1841						BPF_CLASS(insn->code) == BPF_ALU64);
  1842	
  1843				/*
  1844				 * b3 holds 'normal' opcode, b2 short form only valid
  1845				 * in case dst is eax/rax.
  1846				 */
  1847				switch (BPF_OP(insn->code)) {
  1848				case BPF_ADD:
  1849					b3 = 0xC0;
  1850					b2 = 0x05;
  1851					break;
  1852				case BPF_SUB:
  1853					b3 = 0xE8;
  1854					b2 = 0x2D;
  1855					break;
  1856				case BPF_AND:
  1857					b3 = 0xE0;
  1858					b2 = 0x25;
  1859					break;
  1860				case BPF_OR:
  1861					b3 = 0xC8;
  1862					b2 = 0x0D;
  1863					break;
  1864				case BPF_XOR:
  1865					b3 = 0xF0;
  1866					b2 = 0x35;
  1867					break;
  1868				}
  1869	
  1870				if (is_imm8(imm32))
  1871					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1872				else if (is_axreg(dst_reg))
  1873					EMIT1_off32(b2, imm32);
  1874				else
  1875					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1876				break;
  1877	
  1878			case BPF_ALU64 | BPF_MOV | BPF_K:
  1879			case BPF_ALU | BPF_MOV | BPF_K:
  1880				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1881					       dst_reg, imm32);
  1882				break;
  1883	
  1884			case BPF_LD | BPF_IMM | BPF_DW:
  1885				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1886				insn++;
  1887				i++;
  1888				break;
  1889	
  1890				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1891			case BPF_ALU | BPF_MOD | BPF_X:
  1892			case BPF_ALU | BPF_DIV | BPF_X:
  1893			case BPF_ALU | BPF_MOD | BPF_K:
  1894			case BPF_ALU | BPF_DIV | BPF_K:
  1895			case BPF_ALU64 | BPF_MOD | BPF_X:
  1896			case BPF_ALU64 | BPF_DIV | BPF_X:
  1897			case BPF_ALU64 | BPF_MOD | BPF_K:
  1898			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1899				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1900	
  1901				if (dst_reg != BPF_REG_0)
  1902					EMIT1(0x50); /* push rax */
  1903				if (dst_reg != BPF_REG_3)
  1904					EMIT1(0x52); /* push rdx */
  1905	
  1906				if (BPF_SRC(insn->code) == BPF_X) {
  1907					if (src_reg == BPF_REG_0 ||
  1908					    src_reg == BPF_REG_3) {
  1909						/* mov r11, src_reg */
  1910						EMIT_mov(AUX_REG, src_reg);
  1911						src_reg = AUX_REG;
  1912					}
  1913				} else {
  1914					/* mov r11, imm32 */
  1915					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1916					src_reg = AUX_REG;
  1917				}
  1918	
  1919				if (dst_reg != BPF_REG_0)
  1920					/* mov rax, dst_reg */
  1921					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1922	
  1923				if (insn->off == 0) {
  1924					/*
  1925					 * xor edx, edx
  1926					 * equivalent to 'xor rdx, rdx', but one byte less
  1927					 */
  1928					EMIT2(0x31, 0xd2);
  1929	
  1930					/* div src_reg */
  1931					maybe_emit_1mod(&prog, src_reg, is64);
  1932					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1933				} else {
  1934					if (BPF_CLASS(insn->code) == BPF_ALU)
  1935						EMIT1(0x99); /* cdq */
  1936					else
  1937						EMIT2(0x48, 0x99); /* cqo */
  1938	
  1939					/* idiv src_reg */
  1940					maybe_emit_1mod(&prog, src_reg, is64);
  1941					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1942				}
  1943	
  1944				if (BPF_OP(insn->code) == BPF_MOD &&
  1945				    dst_reg != BPF_REG_3)
  1946					/* mov dst_reg, rdx */
  1947					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1948				else if (BPF_OP(insn->code) == BPF_DIV &&
  1949					 dst_reg != BPF_REG_0)
  1950					/* mov dst_reg, rax */
  1951					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1952	
  1953				if (dst_reg != BPF_REG_3)
  1954					EMIT1(0x5A); /* pop rdx */
  1955				if (dst_reg != BPF_REG_0)
  1956					EMIT1(0x58); /* pop rax */
  1957				break;
  1958			}
  1959	
  1960			case BPF_ALU | BPF_MUL | BPF_K:
  1961			case BPF_ALU64 | BPF_MUL | BPF_K:
  1962				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1963					       BPF_CLASS(insn->code) == BPF_ALU64);
  1964	
  1965				if (is_imm8(imm32))
  1966					/* imul dst_reg, dst_reg, imm8 */
  1967					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1968					      imm32);
  1969				else
  1970					/* imul dst_reg, dst_reg, imm32 */
  1971					EMIT2_off32(0x69,
  1972						    add_2reg(0xC0, dst_reg, dst_reg),
  1973						    imm32);
  1974				break;
  1975	
  1976			case BPF_ALU | BPF_MUL | BPF_X:
  1977			case BPF_ALU64 | BPF_MUL | BPF_X:
  1978				maybe_emit_mod(&prog, src_reg, dst_reg,
  1979					       BPF_CLASS(insn->code) == BPF_ALU64);
  1980	
  1981				/* imul dst_reg, src_reg */
  1982				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1983				break;
  1984	
  1985				/* Shifts */
  1986			case BPF_ALU | BPF_LSH | BPF_K:
  1987			case BPF_ALU | BPF_RSH | BPF_K:
  1988			case BPF_ALU | BPF_ARSH | BPF_K:
  1989			case BPF_ALU64 | BPF_LSH | BPF_K:
  1990			case BPF_ALU64 | BPF_RSH | BPF_K:
  1991			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1992				maybe_emit_1mod(&prog, dst_reg,
  1993						BPF_CLASS(insn->code) == BPF_ALU64);
  1994	
  1995				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1996				if (imm32 == 1)
  1997					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1998				else
  1999					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  2000				break;
  2001	
  2002			case BPF_ALU | BPF_LSH | BPF_X:
  2003			case BPF_ALU | BPF_RSH | BPF_X:
  2004			case BPF_ALU | BPF_ARSH | BPF_X:
  2005			case BPF_ALU64 | BPF_LSH | BPF_X:
  2006			case BPF_ALU64 | BPF_RSH | BPF_X:
  2007			case BPF_ALU64 | BPF_ARSH | BPF_X:
  2008				/* BMI2 shifts aren't better when shift count is already in rcx */
  2009				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  2010					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  2011					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  2012					u8 op;
  2013	
  2014					switch (BPF_OP(insn->code)) {
  2015					case BPF_LSH:
  2016						op = 1; /* prefix 0x66 */
  2017						break;
  2018					case BPF_RSH:
  2019						op = 3; /* prefix 0xf2 */
  2020						break;
  2021					case BPF_ARSH:
  2022						op = 2; /* prefix 0xf3 */
  2023						break;
  2024					}
  2025	
  2026					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  2027	
  2028					break;
  2029				}
  2030	
  2031				if (src_reg != BPF_REG_4) { /* common case */
  2032					/* Check for bad case when dst_reg == rcx */
  2033					if (dst_reg == BPF_REG_4) {
  2034						/* mov r11, dst_reg */
  2035						EMIT_mov(AUX_REG, dst_reg);
  2036						dst_reg = AUX_REG;
  2037					} else {
  2038						EMIT1(0x51); /* push rcx */
  2039					}
  2040					/* mov rcx, src_reg */
  2041					EMIT_mov(BPF_REG_4, src_reg);
  2042				}
  2043	
  2044				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  2045				maybe_emit_1mod(&prog, dst_reg,
  2046						BPF_CLASS(insn->code) == BPF_ALU64);
  2047	
  2048				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  2049				EMIT2(0xD3, add_1reg(b3, dst_reg));
  2050	
  2051				if (src_reg != BPF_REG_4) {
  2052					if (insn->dst_reg == BPF_REG_4)
  2053						/* mov dst_reg, r11 */
  2054						EMIT_mov(insn->dst_reg, AUX_REG);
  2055					else
  2056						EMIT1(0x59); /* pop rcx */
  2057				}
  2058	
  2059				break;
  2060	
  2061			case BPF_ALU | BPF_END | BPF_FROM_BE:
  2062			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  2063				switch (imm32) {
  2064				case 16:
  2065					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  2066					EMIT1(0x66);
  2067					if (is_ereg(dst_reg))
  2068						EMIT1(0x41);
  2069					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  2070	
  2071					/* Emit 'movzwl eax, ax' */
  2072					if (is_ereg(dst_reg))
  2073						EMIT3(0x45, 0x0F, 0xB7);
  2074					else
  2075						EMIT2(0x0F, 0xB7);
  2076					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2077					break;
  2078				case 32:
  2079					/* Emit 'bswap eax' to swap lower 4 bytes */
  2080					if (is_ereg(dst_reg))
  2081						EMIT2(0x41, 0x0F);
  2082					else
  2083						EMIT1(0x0F);
  2084					EMIT1(add_1reg(0xC8, dst_reg));
  2085					break;
  2086				case 64:
  2087					/* Emit 'bswap rax' to swap 8 bytes */
  2088					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  2089					      add_1reg(0xC8, dst_reg));
  2090					break;
  2091				}
  2092				break;
  2093	
  2094			case BPF_ALU | BPF_END | BPF_FROM_LE:
  2095				switch (imm32) {
  2096				case 16:
  2097					/*
  2098					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  2099					 * into 64 bit
  2100					 */
  2101					if (is_ereg(dst_reg))
  2102						EMIT3(0x45, 0x0F, 0xB7);
  2103					else
  2104						EMIT2(0x0F, 0xB7);
  2105					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2106					break;
  2107				case 32:
  2108					/* Emit 'mov eax, eax' to clear upper 32-bits */
  2109					if (is_ereg(dst_reg))
  2110						EMIT1(0x45);
  2111					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  2112					break;
  2113				case 64:
  2114					/* nop */
  2115					break;
  2116				}
  2117				break;
  2118	
  2119				/* speculation barrier */
  2120			case BPF_ST | BPF_NOSPEC:
  2121				EMIT_LFENCE();
  2122				break;
  2123	
  2124				/* ST: *(u8*)(dst_reg + off) = imm */
  2125			case BPF_ST | BPF_MEM | BPF_B:
  2126				if (is_ereg(dst_reg))
  2127					EMIT2(0x41, 0xC6);
  2128				else
  2129					EMIT1(0xC6);
  2130				goto st;
  2131			case BPF_ST | BPF_MEM | BPF_H:
  2132				if (is_ereg(dst_reg))
  2133					EMIT3(0x66, 0x41, 0xC7);
  2134				else
  2135					EMIT2(0x66, 0xC7);
  2136				goto st;
  2137			case BPF_ST | BPF_MEM | BPF_W:
  2138				if (is_ereg(dst_reg))
  2139					EMIT2(0x41, 0xC7);
  2140				else
  2141					EMIT1(0xC7);
  2142				goto st;
  2143			case BPF_ST | BPF_MEM | BPF_DW:
  2144				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  2145	
  2146	st:			if (is_imm8(insn->off))
  2147					EMIT2(add_1reg(0x40, dst_reg), insn->off);
  2148				else
  2149					EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
  2150	
  2151				EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
  2152				break;
  2153	
  2154				/* STX: *(u8*)(dst_reg + off) = src_reg */
  2155			case BPF_STX | BPF_MEM | BPF_B:
  2156			case BPF_STX | BPF_MEM | BPF_H:
  2157			case BPF_STX | BPF_MEM | BPF_W:
  2158			case BPF_STX | BPF_MEM | BPF_DW:
  2159				emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2160				break;
  2161	
  2162			case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
  2163			case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
  2164			case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
  2165			case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
  2166				start_of_ldx = prog;
  2167				emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
  2168				goto populate_extable;
  2169	
  2170				/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
  2171			case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
  2172			case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
  2173			case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
  2174			case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
  2175			case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
  2176			case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
  2177			case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
  2178			case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
  2179			case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
  2180			case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
  2181			case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
  2182				start_of_ldx = prog;
  2183				if (BPF_CLASS(insn->code) == BPF_LDX) {
  2184					if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
  2185						emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2186					else
  2187						emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2188				} else {
  2189					emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  2190				}
  2191	populate_extable:
  2192				{
  2193					struct exception_table_entry *ex;
  2194					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2195					u32 arena_reg, fixup_reg;
  2196					s64 delta;
  2197	
  2198					if (!bpf_prog->aux->extable)
  2199						break;
  2200	
  2201					if (excnt >= bpf_prog->aux->num_exentries) {
  2202						pr_err("mem32 extable bug\n");
  2203						return -EFAULT;
  2204					}
  2205					ex = &bpf_prog->aux->extable[excnt++];
  2206	
  2207					delta = _insn - (u8 *)&ex->insn;
  2208					/* switch ex to rw buffer for writes */
  2209					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2210	
  2211					ex->insn = delta;
  2212	
  2213					ex->data = EX_TYPE_BPF;
  2214	
  2215					/*
  2216					 * src_reg/dst_reg holds the address in the arena region with upper
  2217					 * 32-bits being zero because of a preceding addr_space_cast(r<n>,
  2218					 * 0x0, 0x1) instruction. This address is adjusted with the addition
  2219					 * of arena_vm_start (see the implementation of BPF_PROBE_MEM32 and
  2220					 * BPF_PROBE_ATOMIC) before being used for the memory access. Pass
  2221					 * the reg holding the unmodified 32-bit address to
  2222					 * ex_handler_bpf().
  2223					 */
  2224					if (BPF_CLASS(insn->code) == BPF_LDX) {
  2225						arena_reg = reg2pt_regs[src_reg];
  2226						fixup_reg = reg2pt_regs[dst_reg];
  2227					} else {
  2228						arena_reg = reg2pt_regs[dst_reg];
  2229						fixup_reg = DONT_CLEAR;
  2230					}
  2231	
  2232					ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
  2233						    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
  2234						    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
  2235					ex->fixup |= FIXUP_ARENA_ACCESS;
  2236	
  2237					ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
  2238				}
  2239				break;
  2240	
  2241				/* LDX: dst_reg = *(u8*)(src_reg + off) */
  2242			case BPF_LDX | BPF_MEM | BPF_B:
  2243			case BPF_LDX | BPF_PROBE_MEM | BPF_B:
  2244			case BPF_LDX | BPF_MEM | BPF_H:
  2245			case BPF_LDX | BPF_PROBE_MEM | BPF_H:
  2246			case BPF_LDX | BPF_MEM | BPF_W:
  2247			case BPF_LDX | BPF_PROBE_MEM | BPF_W:
  2248			case BPF_LDX | BPF_MEM | BPF_DW:
  2249			case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
  2250				/* LDXS: dst_reg = *(s8*)(src_reg + off) */
  2251			case BPF_LDX | BPF_MEMSX | BPF_B:
  2252			case BPF_LDX | BPF_MEMSX | BPF_H:
  2253			case BPF_LDX | BPF_MEMSX | BPF_W:
  2254			case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
  2255			case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
  2256			case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
  2257				insn_off = insn->off;
  2258	
  2259				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2260				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2261					/* Conservatively check that src_reg + insn->off is a kernel address:
  2262					 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
  2263					 *   and
  2264					 *   src_reg + insn->off < VSYSCALL_ADDR
  2265					 */
  2266	
  2267					u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
  2268					u8 *end_of_jmp;
  2269	
  2270					/* movabsq r10, VSYSCALL_ADDR */
  2271					emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
  2272						       (u32)(long)VSYSCALL_ADDR);
  2273	
  2274					/* mov src_reg, r11 */
  2275					EMIT_mov(AUX_REG, src_reg);
  2276	
  2277					if (insn->off) {
  2278						/* add r11, insn->off */
  2279						maybe_emit_1mod(&prog, AUX_REG, true);
  2280						EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
  2281					}
  2282	
  2283					/* sub r11, r10 */
  2284					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2285					EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2286	
  2287					/* movabsq r10, limit */
  2288					emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
  2289						       (u32)(long)limit);
  2290	
  2291					/* cmp r10, r11 */
  2292					maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
  2293					EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
  2294	
  2295					/* if unsigned '>', goto load */
  2296					EMIT2(X86_JA, 0);
  2297					end_of_jmp = prog;
  2298	
  2299					/* xor dst_reg, dst_reg */
  2300					emit_mov_imm32(&prog, false, dst_reg, 0);
  2301					/* jmp byte_after_ldx */
  2302					EMIT2(0xEB, 0);
  2303	
  2304					/* populate jmp_offset for JAE above to jump to start_of_ldx */
  2305					start_of_ldx = prog;
  2306					end_of_jmp[-1] = start_of_ldx - end_of_jmp;
  2307				}
  2308				if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
  2309				    BPF_MODE(insn->code) == BPF_MEMSX)
  2310					emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2311				else
  2312					emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  2313				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  2314				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  2315					struct exception_table_entry *ex;
  2316					u8 *_insn = image + proglen + (start_of_ldx - temp);
  2317					s64 delta;
  2318	
  2319					/* populate jmp_offset for JMP above */
  2320					start_of_ldx[-1] = prog - start_of_ldx;
  2321	
  2322					if (!bpf_prog->aux->extable)
  2323						break;
  2324	
  2325					if (excnt >= bpf_prog->aux->num_exentries) {
  2326						pr_err("ex gen bug\n");
  2327						return -EFAULT;
  2328					}
  2329					ex = &bpf_prog->aux->extable[excnt++];
  2330	
  2331					delta = _insn - (u8 *)&ex->insn;
  2332					if (!is_simm32(delta)) {
  2333						pr_err("extable->insn doesn't fit into 32-bit\n");
  2334						return -EFAULT;
  2335					}
  2336					/* switch ex to rw buffer for writes */
  2337					ex = (void *)rw_image + ((void *)ex - (void *)image);
  2338	
  2339					ex->insn = delta;
  2340	
  2341					ex->data = EX_TYPE_BPF;
  2342	
  2343					if (dst_reg > BPF_REG_9) {
  2344						pr_err("verifier error\n");
  2345						return -EFAULT;
  2346					}
  2347					/*
  2348					 * Compute size of x86 insn and its target dest x86 register.
  2349					 * ex_handler_bpf() will use lower 8 bits to adjust
  2350					 * pt_regs->ip to jump over this x86 instruction
  2351					 * and upper bits to figure out which pt_regs to zero out.
  2352					 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
  2353					 * of 4 bytes will be ignored and rbx will be zero inited.
  2354					 */
  2355					ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
  2356						    FIELD_PREP(FIXUP_REG_MASK, reg2pt_regs[dst_reg]);
  2357				}
  2358				break;
  2359	
  2360			case BPF_STX | BPF_ATOMIC | BPF_B:
  2361			case BPF_STX | BPF_ATOMIC | BPF_H:
  2362				if (!bpf_atomic_is_load_store(insn)) {
  2363					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2364					return -EFAULT;
  2365				}
  2366				fallthrough;
  2367			case BPF_STX | BPF_ATOMIC | BPF_W:
  2368			case BPF_STX | BPF_ATOMIC | BPF_DW:
  2369				if (insn->imm == (BPF_AND | BPF_FETCH) ||
  2370				    insn->imm == (BPF_OR | BPF_FETCH) ||
  2371				    insn->imm == (BPF_XOR | BPF_FETCH)) {
  2372					bool is64 = BPF_SIZE(insn->code) == BPF_DW;
  2373					u32 real_src_reg = src_reg;
  2374					u32 real_dst_reg = dst_reg;
  2375					u8 *branch_target;
  2376	
  2377					/*
  2378					 * Can't be implemented with a single x86 insn.
  2379					 * Need to do a CMPXCHG loop.
  2380					 */
  2381	
  2382					/* Will need RAX as a CMPXCHG operand so save R0 */
  2383					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
  2384					if (src_reg == BPF_REG_0)
  2385						real_src_reg = BPF_REG_AX;
  2386					if (dst_reg == BPF_REG_0)
  2387						real_dst_reg = BPF_REG_AX;
  2388	
  2389					branch_target = prog;
  2390					/* Load old value */
  2391					emit_ldx(&prog, BPF_SIZE(insn->code),
  2392						 BPF_REG_0, real_dst_reg, insn->off);
  2393					/*
  2394					 * Perform the (commutative) operation locally,
  2395					 * put the result in the AUX_REG.
  2396					 */
  2397					emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
  2398					maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
  2399					EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
  2400					      add_2reg(0xC0, AUX_REG, real_src_reg));
  2401					/* Attempt to swap in new value */
  2402					err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
  2403							      real_dst_reg, AUX_REG,
  2404							      insn->off,
  2405							      BPF_SIZE(insn->code));
  2406					if (WARN_ON(err))
  2407						return err;
  2408					/*
  2409					 * ZF tells us whether we won the race. If it's
  2410					 * cleared we need to try again.
  2411					 */
  2412					EMIT2(X86_JNE, -(prog - branch_target) - 2);
  2413					/* Return the pre-modification value */
  2414					emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
  2415					/* Restore R0 after clobbering RAX */
  2416					emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
  2417					break;
  2418				}
  2419	
  2420				if (bpf_atomic_is_load_store(insn))
  2421					err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
  2422								insn->off, BPF_SIZE(insn->code));
  2423				else
  2424					err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
  2425							      insn->off, BPF_SIZE(insn->code));
  2426				if (err)
  2427					return err;
  2428				break;
  2429	
  2430			case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
  2431			case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
  2432				if (!bpf_atomic_is_load_store(insn)) {
  2433					pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
  2434					return -EFAULT;
  2435				}
  2436				fallthrough;
  2437			case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
  2438			case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
  2439				start_of_ldx = prog;
  2440	
  2441				if (bpf_atomic_is_load_store(insn))
  2442					err = emit_atomic_ld_st_index(&prog, insn->imm,
  2443								      BPF_SIZE(insn->code), dst_reg,
  2444								      src_reg, X86_REG_R12, insn->off);
  2445				else
  2446					err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
  2447								    dst_reg, src_reg, X86_REG_R12,
  2448								    insn->off);
  2449				if (err)
  2450					return err;
  2451				goto populate_extable;
  2452	
  2453				/* call */
  2454			case BPF_JMP | BPF_CALL: {
  2455				u8 *ip = image + addrs[i - 1];
  2456	
  2457				if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
  2458							   insn->imm == BPF_FUNC_get_current_task_btf)) {
  2459					if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
> 2460						emit_ldx_percpu_r0(&prog, &const_current_task);
  2461					else
  2462						emit_ldx_percpu_r0(&prog, &current_task);
  2463					break;
  2464				}
  2465	
  2466				func = (u8 *) __bpf_call_base + imm32;
  2467				if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
  2468					LOAD_TAIL_CALL_CNT_PTR(stack_depth);
  2469					ip += 7;
  2470				}
  2471				if (!imm32)
  2472					return -EINVAL;
  2473				if (priv_frame_ptr) {
  2474					push_r9(&prog);
  2475					ip += 2;
  2476				}
  2477				ip += x86_call_depth_emit_accounting(&prog, func, ip);
  2478				if (emit_call(&prog, func, ip))
  2479					return -EINVAL;
  2480				if (priv_frame_ptr)
  2481					pop_r9(&prog);
  2482				break;
  2483			}
  2484	
  2485			case BPF_JMP | BPF_TAIL_CALL:
  2486				if (imm32)
  2487					emit_bpf_tail_call_direct(bpf_prog,
  2488								  &bpf_prog->aux->poke_tab[imm32 - 1],
  2489								  &prog, image + addrs[i - 1],
  2490								  callee_regs_used,
  2491								  stack_depth,
  2492								  ctx);
  2493				else
  2494					emit_bpf_tail_call_indirect(bpf_prog,
  2495								    &prog,
  2496								    callee_regs_used,
  2497								    stack_depth,
  2498								    image + addrs[i - 1],
  2499								    ctx);
  2500				break;
  2501	
  2502				/* cond jump */
  2503			case BPF_JMP | BPF_JEQ | BPF_X:
  2504			case BPF_JMP | BPF_JNE | BPF_X:
  2505			case BPF_JMP | BPF_JGT | BPF_X:
  2506			case BPF_JMP | BPF_JLT | BPF_X:
  2507			case BPF_JMP | BPF_JGE | BPF_X:
  2508			case BPF_JMP | BPF_JLE | BPF_X:
  2509			case BPF_JMP | BPF_JSGT | BPF_X:
  2510			case BPF_JMP | BPF_JSLT | BPF_X:
  2511			case BPF_JMP | BPF_JSGE | BPF_X:
  2512			case BPF_JMP | BPF_JSLE | BPF_X:
  2513			case BPF_JMP32 | BPF_JEQ | BPF_X:
  2514			case BPF_JMP32 | BPF_JNE | BPF_X:
  2515			case BPF_JMP32 | BPF_JGT | BPF_X:
  2516			case BPF_JMP32 | BPF_JLT | BPF_X:
  2517			case BPF_JMP32 | BPF_JGE | BPF_X:
  2518			case BPF_JMP32 | BPF_JLE | BPF_X:
  2519			case BPF_JMP32 | BPF_JSGT | BPF_X:
  2520			case BPF_JMP32 | BPF_JSLT | BPF_X:
  2521			case BPF_JMP32 | BPF_JSGE | BPF_X:
  2522			case BPF_JMP32 | BPF_JSLE | BPF_X:
  2523				/* cmp dst_reg, src_reg */
  2524				maybe_emit_mod(&prog, dst_reg, src_reg,
  2525					       BPF_CLASS(insn->code) == BPF_JMP);
  2526				EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
  2527				goto emit_cond_jmp;
  2528	
  2529			case BPF_JMP | BPF_JSET | BPF_X:
  2530			case BPF_JMP32 | BPF_JSET | BPF_X:
  2531				/* test dst_reg, src_reg */
  2532				maybe_emit_mod(&prog, dst_reg, src_reg,
  2533					       BPF_CLASS(insn->code) == BPF_JMP);
  2534				EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
  2535				goto emit_cond_jmp;
  2536	
  2537			case BPF_JMP | BPF_JSET | BPF_K:
  2538			case BPF_JMP32 | BPF_JSET | BPF_K:
  2539				/* test dst_reg, imm32 */
  2540				maybe_emit_1mod(&prog, dst_reg,
  2541						BPF_CLASS(insn->code) == BPF_JMP);
  2542				EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
  2543				goto emit_cond_jmp;
  2544	
  2545			case BPF_JMP | BPF_JEQ | BPF_K:
  2546			case BPF_JMP | BPF_JNE | BPF_K:
  2547			case BPF_JMP | BPF_JGT | BPF_K:
  2548			case BPF_JMP | BPF_JLT | BPF_K:
  2549			case BPF_JMP | BPF_JGE | BPF_K:
  2550			case BPF_JMP | BPF_JLE | BPF_K:
  2551			case BPF_JMP | BPF_JSGT | BPF_K:
  2552			case BPF_JMP | BPF_JSLT | BPF_K:
  2553			case BPF_JMP | BPF_JSGE | BPF_K:
  2554			case BPF_JMP | BPF_JSLE | BPF_K:
  2555			case BPF_JMP32 | BPF_JEQ | BPF_K:
  2556			case BPF_JMP32 | BPF_JNE | BPF_K:
  2557			case BPF_JMP32 | BPF_JGT | BPF_K:
  2558			case BPF_JMP32 | BPF_JLT | BPF_K:
  2559			case BPF_JMP32 | BPF_JGE | BPF_K:
  2560			case BPF_JMP32 | BPF_JLE | BPF_K:
  2561			case BPF_JMP32 | BPF_JSGT | BPF_K:
  2562			case BPF_JMP32 | BPF_JSLT | BPF_K:
  2563			case BPF_JMP32 | BPF_JSGE | BPF_K:
  2564			case BPF_JMP32 | BPF_JSLE | BPF_K:
  2565				/* test dst_reg, dst_reg to save one extra byte */
  2566				if (imm32 == 0) {
  2567					maybe_emit_mod(&prog, dst_reg, dst_reg,
  2568						       BPF_CLASS(insn->code) == BPF_JMP);
  2569					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  2570					goto emit_cond_jmp;
  2571				}
  2572	
  2573				/* cmp dst_reg, imm8/32 */
  2574				maybe_emit_1mod(&prog, dst_reg,
  2575						BPF_CLASS(insn->code) == BPF_JMP);
  2576	
  2577				if (is_imm8(imm32))
  2578					EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
  2579				else
  2580					EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
  2581	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

