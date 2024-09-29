Return-Path: <bpf+bounces-40482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329639893C4
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C209281C2E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3B13C80A;
	Sun, 29 Sep 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWNJmzsJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D6F9CF
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598745; cv=none; b=JqfZE5cx2cH8GW5gSTfqpdSv+4GWUE7TyaWjJAE4/UHkgTtKiXvAKrPz0zqylPgX3rC15BiNOyUJeRMnGAlVEaFFaLfYYc3Fe/jaUHxOSTgmhELQqdrordzcqbXvg5Gie61QQ1Gntpc1rTzd/Kuwd0OOfH9Ayev9YOX1A53hebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598745; c=relaxed/simple;
	bh=0o978GRvfZ8V0H6nIdIBnoShKZ69/3PIRvn9q0Acu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTXUMzxvXwo7WC6HoFhamWgZP0BWMiedS/F0XPS1w3vceuMAKh0EEoONGEsVMJ+kxskXsgoEDBATsoTgWLW0/2GLWNkTSWMH8uXFuB1eLOGvoz1ybtuWXUbfj+c+d2fQFFFfilUs3T6F1JnfdXlwA1ueMZPtEMXg2TEf4r55hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWNJmzsJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727598743; x=1759134743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0o978GRvfZ8V0H6nIdIBnoShKZ69/3PIRvn9q0Acu+U=;
  b=lWNJmzsJHfb35QI4FnVizzBhmD30L4kdPEgJ+1pyOmyLpcqvb2QnLMLG
   m5YPj/+FSIhQ805o5hKugqx8NA969Z1oDxrfQ0tm0jjmxD7YHmjHCMRSV
   cXKyN+3ezh8GQemFAT1zgmlgwR443tvpaWZ3yAcwQ4nvnRn2f1txjyHwf
   y/mC3d1afnnI4gCNZwtMfnG4uRef6+zDZ7gxO9DgKvsWmp7LM2s3XGUwv
   8cAnyUd8S8oZCy0GauX/Lb/pbJTHCuKQWD37uxLv+fvQGGEgF0xyR70UW
   rmFSkJ/vnNHGiaeI+poKrFgSrzwyv39GcR89KIeHgRoXBYWEYyJn/qW+M
   A==;
X-CSE-ConnectionGUID: 2aevMWRuRvajOoX51WJiLA==
X-CSE-MsgGUID: V8bAzxWfR2GnN50NSqN0Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26792957"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="26792957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 01:32:22 -0700
X-CSE-ConnectionGUID: fg2Cm1HBRtCqSLrEO+4Acw==
X-CSE-MsgGUID: ecC4Oo7BQmCFkIQpanA3zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="72852810"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Sep 2024 01:32:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1supLl-000O6V-1Z;
	Sun, 29 Sep 2024 08:32:17 +0000
Date: Sun, 29 Sep 2024 16:31:43 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Message-ID: <202409291637.cuQ0jRdD-lkp@intel.com>
References: <20240926234526.1770736-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926234526.1770736-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Allow-each-subprog-having-stack-size-of-512-bytes/20240927-074744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240926234526.1770736-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
config: x86_64-randconfig-122-20240929 (https://download.01.org/0day-ci/archive/20240929/202409291637.cuQ0jRdD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409291637.cuQ0jRdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409291637.cuQ0jRdD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/net/bpf_jit_comp.c:1503:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *private_frame_ptr @@     got void [noderef] __percpu *[assigned] private_frame_ptr @@
   arch/x86/net/bpf_jit_comp.c:1503:47: sparse:     expected void *private_frame_ptr
   arch/x86/net/bpf_jit_comp.c:1503:47: sparse:     got void [noderef] __percpu *[assigned] private_frame_ptr

vim +1503 arch/x86/net/bpf_jit_comp.c

  1442	
  1443	#define __LOAD_TCC_PTR(off)			\
  1444		EMIT3_off32(0x48, 0x8B, 0x85, off)
  1445	/* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
  1446	#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
  1447		__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
  1448	
  1449	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1450			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1451	{
  1452		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1453		struct bpf_insn *insn = bpf_prog->insnsi;
  1454		bool callee_regs_used[4] = {};
  1455		int insn_cnt = bpf_prog->len;
  1456		bool seen_exit = false;
  1457		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1458		void __percpu *private_frame_ptr = NULL;
  1459		u64 arena_vm_start, user_vm_start;
  1460		u32 orig_stack_depth, stack_depth;
  1461		int i, excnt = 0;
  1462		int ilen, proglen = 0;
  1463		u8 *prog = temp;
  1464		int err;
  1465	
  1466		stack_depth = bpf_prog->aux->stack_depth;
  1467		orig_stack_depth = round_up(stack_depth, 8);
  1468		if (bpf_prog->pstack) {
  1469			stack_depth = 0;
  1470			if (bpf_prog->pstack == PSTACK_TREE_ROOT)
  1471				private_frame_ptr = bpf_prog->private_stack_ptr + orig_stack_depth;
  1472		}
  1473	
  1474		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1475		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1476	
  1477		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1478	
  1479		emit_prologue(&prog, stack_depth,
  1480			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1481			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
  1482			      bpf_prog->pstack);
  1483		/* Exception callback will clobber callee regs for its own use, and
  1484		 * restore the original callee regs from main prog's stack frame.
  1485		 */
  1486		if (bpf_prog->aux->exception_boundary) {
  1487			/* We also need to save r12, which is not mapped to any BPF
  1488			 * register, as we throw after entry into the kernel, which may
  1489			 * overwrite r12.
  1490			 */
  1491			push_r12(&prog);
  1492			push_callee_regs(&prog, all_callee_regs_used);
  1493		} else {
  1494			if (arena_vm_start)
  1495				push_r12(&prog);
  1496			push_callee_regs(&prog, callee_regs_used);
  1497		}
  1498		if (arena_vm_start)
  1499			emit_mov_imm64(&prog, X86_REG_R12,
  1500				       arena_vm_start >> 32, (u32) arena_vm_start);
  1501	
  1502		if (bpf_prog->pstack == PSTACK_TREE_ROOT) {
> 1503			emit_private_frame_ptr(&prog, private_frame_ptr);
  1504		} else if (bpf_prog->pstack == PSTACK_TREE_INTERNAL  && orig_stack_depth) {
  1505			/* r9 += orig_stack_depth */
  1506			maybe_emit_1mod(&prog, X86_REG_R9, true);
  1507			if (is_imm8(orig_stack_depth))
  1508				EMIT3(0x83, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
  1509			else
  1510				EMIT2_off32(0x81, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
  1511		}
  1512	
  1513		ilen = prog - temp;
  1514		if (rw_image)
  1515			memcpy(rw_image + proglen, temp, ilen);
  1516		proglen += ilen;
  1517		addrs[0] = proglen;
  1518		prog = temp;
  1519	
  1520		for (i = 1; i <= insn_cnt; i++, insn++) {
  1521			const s32 imm32 = insn->imm;
  1522			u32 dst_reg = insn->dst_reg;
  1523			u32 src_reg = insn->src_reg;
  1524			u8 b2 = 0, b3 = 0;
  1525			u8 *start_of_ldx;
  1526			s64 jmp_offset;
  1527			s16 insn_off;
  1528			u8 jmp_cond;
  1529			u8 *func;
  1530			int nops;
  1531	
  1532			if (bpf_prog->pstack) {
  1533				if (src_reg == BPF_REG_FP)
  1534					src_reg = X86_REG_R9;
  1535	
  1536				if (dst_reg == BPF_REG_FP)
  1537					dst_reg = X86_REG_R9;
  1538			}
  1539	
  1540			switch (insn->code) {
  1541				/* ALU */
  1542			case BPF_ALU | BPF_ADD | BPF_X:
  1543			case BPF_ALU | BPF_SUB | BPF_X:
  1544			case BPF_ALU | BPF_AND | BPF_X:
  1545			case BPF_ALU | BPF_OR | BPF_X:
  1546			case BPF_ALU | BPF_XOR | BPF_X:
  1547			case BPF_ALU64 | BPF_ADD | BPF_X:
  1548			case BPF_ALU64 | BPF_SUB | BPF_X:
  1549			case BPF_ALU64 | BPF_AND | BPF_X:
  1550			case BPF_ALU64 | BPF_OR | BPF_X:
  1551			case BPF_ALU64 | BPF_XOR | BPF_X:
  1552				maybe_emit_mod(&prog, dst_reg, src_reg,
  1553					       BPF_CLASS(insn->code) == BPF_ALU64);
  1554				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1555				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1556				break;
  1557	
  1558			case BPF_ALU64 | BPF_MOV | BPF_X:
  1559				if (insn_is_cast_user(insn)) {
  1560					if (dst_reg != src_reg)
  1561						/* 32-bit mov */
  1562						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1563					/* shl dst_reg, 32 */
  1564					maybe_emit_1mod(&prog, dst_reg, true);
  1565					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1566	
  1567					/* or dst_reg, user_vm_start */
  1568					maybe_emit_1mod(&prog, dst_reg, true);
  1569					if (is_axreg(dst_reg))
  1570						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1571					else
  1572						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1573	
  1574					/* rol dst_reg, 32 */
  1575					maybe_emit_1mod(&prog, dst_reg, true);
  1576					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1577	
  1578					/* xor r11, r11 */
  1579					EMIT3(0x4D, 0x31, 0xDB);
  1580	
  1581					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1582					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1583					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1584	
  1585					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1586					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1587					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1588					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1589					break;
  1590				} else if (insn_is_mov_percpu_addr(insn)) {
  1591					/* mov <dst>, <src> (if necessary) */
  1592					EMIT_mov(dst_reg, src_reg);
  1593	#ifdef CONFIG_SMP
  1594					/* add <dst>, gs:[<off>] */
  1595					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1596					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1597					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1598	#endif
  1599					break;
  1600				}
  1601				fallthrough;
  1602			case BPF_ALU | BPF_MOV | BPF_X:
  1603				if (insn->off == 0)
  1604					emit_mov_reg(&prog,
  1605						     BPF_CLASS(insn->code) == BPF_ALU64,
  1606						     dst_reg, src_reg);
  1607				else
  1608					emit_movsx_reg(&prog, insn->off,
  1609						       BPF_CLASS(insn->code) == BPF_ALU64,
  1610						       dst_reg, src_reg);
  1611				break;
  1612	
  1613				/* neg dst */
  1614			case BPF_ALU | BPF_NEG:
  1615			case BPF_ALU64 | BPF_NEG:
  1616				maybe_emit_1mod(&prog, dst_reg,
  1617						BPF_CLASS(insn->code) == BPF_ALU64);
  1618				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1619				break;
  1620	
  1621			case BPF_ALU | BPF_ADD | BPF_K:
  1622			case BPF_ALU | BPF_SUB | BPF_K:
  1623			case BPF_ALU | BPF_AND | BPF_K:
  1624			case BPF_ALU | BPF_OR | BPF_K:
  1625			case BPF_ALU | BPF_XOR | BPF_K:
  1626			case BPF_ALU64 | BPF_ADD | BPF_K:
  1627			case BPF_ALU64 | BPF_SUB | BPF_K:
  1628			case BPF_ALU64 | BPF_AND | BPF_K:
  1629			case BPF_ALU64 | BPF_OR | BPF_K:
  1630			case BPF_ALU64 | BPF_XOR | BPF_K:
  1631				maybe_emit_1mod(&prog, dst_reg,
  1632						BPF_CLASS(insn->code) == BPF_ALU64);
  1633	
  1634				/*
  1635				 * b3 holds 'normal' opcode, b2 short form only valid
  1636				 * in case dst is eax/rax.
  1637				 */
  1638				switch (BPF_OP(insn->code)) {
  1639				case BPF_ADD:
  1640					b3 = 0xC0;
  1641					b2 = 0x05;
  1642					break;
  1643				case BPF_SUB:
  1644					b3 = 0xE8;
  1645					b2 = 0x2D;
  1646					break;
  1647				case BPF_AND:
  1648					b3 = 0xE0;
  1649					b2 = 0x25;
  1650					break;
  1651				case BPF_OR:
  1652					b3 = 0xC8;
  1653					b2 = 0x0D;
  1654					break;
  1655				case BPF_XOR:
  1656					b3 = 0xF0;
  1657					b2 = 0x35;
  1658					break;
  1659				}
  1660	
  1661				if (is_imm8(imm32))
  1662					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1663				else if (is_axreg(dst_reg))
  1664					EMIT1_off32(b2, imm32);
  1665				else
  1666					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1667				break;
  1668	
  1669			case BPF_ALU64 | BPF_MOV | BPF_K:
  1670			case BPF_ALU | BPF_MOV | BPF_K:
  1671				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1672					       dst_reg, imm32);
  1673				break;
  1674	
  1675			case BPF_LD | BPF_IMM | BPF_DW:
  1676				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1677				insn++;
  1678				i++;
  1679				break;
  1680	
  1681				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1682			case BPF_ALU | BPF_MOD | BPF_X:
  1683			case BPF_ALU | BPF_DIV | BPF_X:
  1684			case BPF_ALU | BPF_MOD | BPF_K:
  1685			case BPF_ALU | BPF_DIV | BPF_K:
  1686			case BPF_ALU64 | BPF_MOD | BPF_X:
  1687			case BPF_ALU64 | BPF_DIV | BPF_X:
  1688			case BPF_ALU64 | BPF_MOD | BPF_K:
  1689			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1690				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1691	
  1692				if (dst_reg != BPF_REG_0)
  1693					EMIT1(0x50); /* push rax */
  1694				if (dst_reg != BPF_REG_3)
  1695					EMIT1(0x52); /* push rdx */
  1696	
  1697				if (BPF_SRC(insn->code) == BPF_X) {
  1698					if (src_reg == BPF_REG_0 ||
  1699					    src_reg == BPF_REG_3) {
  1700						/* mov r11, src_reg */
  1701						EMIT_mov(AUX_REG, src_reg);
  1702						src_reg = AUX_REG;
  1703					}
  1704				} else {
  1705					/* mov r11, imm32 */
  1706					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1707					src_reg = AUX_REG;
  1708				}
  1709	
  1710				if (dst_reg != BPF_REG_0)
  1711					/* mov rax, dst_reg */
  1712					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1713	
  1714				if (insn->off == 0) {
  1715					/*
  1716					 * xor edx, edx
  1717					 * equivalent to 'xor rdx, rdx', but one byte less
  1718					 */
  1719					EMIT2(0x31, 0xd2);
  1720	
  1721					/* div src_reg */
  1722					maybe_emit_1mod(&prog, src_reg, is64);
  1723					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1724				} else {
  1725					if (BPF_CLASS(insn->code) == BPF_ALU)
  1726						EMIT1(0x99); /* cdq */
  1727					else
  1728						EMIT2(0x48, 0x99); /* cqo */
  1729	
  1730					/* idiv src_reg */
  1731					maybe_emit_1mod(&prog, src_reg, is64);
  1732					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1733				}
  1734	
  1735				if (BPF_OP(insn->code) == BPF_MOD &&
  1736				    dst_reg != BPF_REG_3)
  1737					/* mov dst_reg, rdx */
  1738					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1739				else if (BPF_OP(insn->code) == BPF_DIV &&
  1740					 dst_reg != BPF_REG_0)
  1741					/* mov dst_reg, rax */
  1742					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1743	
  1744				if (dst_reg != BPF_REG_3)
  1745					EMIT1(0x5A); /* pop rdx */
  1746				if (dst_reg != BPF_REG_0)
  1747					EMIT1(0x58); /* pop rax */
  1748				break;
  1749			}
  1750	
  1751			case BPF_ALU | BPF_MUL | BPF_K:
  1752			case BPF_ALU64 | BPF_MUL | BPF_K:
  1753				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1754					       BPF_CLASS(insn->code) == BPF_ALU64);
  1755	
  1756				if (is_imm8(imm32))
  1757					/* imul dst_reg, dst_reg, imm8 */
  1758					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1759					      imm32);
  1760				else
  1761					/* imul dst_reg, dst_reg, imm32 */
  1762					EMIT2_off32(0x69,
  1763						    add_2reg(0xC0, dst_reg, dst_reg),
  1764						    imm32);
  1765				break;
  1766	
  1767			case BPF_ALU | BPF_MUL | BPF_X:
  1768			case BPF_ALU64 | BPF_MUL | BPF_X:
  1769				maybe_emit_mod(&prog, src_reg, dst_reg,
  1770					       BPF_CLASS(insn->code) == BPF_ALU64);
  1771	
  1772				/* imul dst_reg, src_reg */
  1773				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1774				break;
  1775	
  1776				/* Shifts */
  1777			case BPF_ALU | BPF_LSH | BPF_K:
  1778			case BPF_ALU | BPF_RSH | BPF_K:
  1779			case BPF_ALU | BPF_ARSH | BPF_K:
  1780			case BPF_ALU64 | BPF_LSH | BPF_K:
  1781			case BPF_ALU64 | BPF_RSH | BPF_K:
  1782			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1783				maybe_emit_1mod(&prog, dst_reg,
  1784						BPF_CLASS(insn->code) == BPF_ALU64);
  1785	
  1786				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1787				if (imm32 == 1)
  1788					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1789				else
  1790					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  1791				break;
  1792	
  1793			case BPF_ALU | BPF_LSH | BPF_X:
  1794			case BPF_ALU | BPF_RSH | BPF_X:
  1795			case BPF_ALU | BPF_ARSH | BPF_X:
  1796			case BPF_ALU64 | BPF_LSH | BPF_X:
  1797			case BPF_ALU64 | BPF_RSH | BPF_X:
  1798			case BPF_ALU64 | BPF_ARSH | BPF_X:
  1799				/* BMI2 shifts aren't better when shift count is already in rcx */
  1800				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  1801					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  1802					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  1803					u8 op;
  1804	
  1805					switch (BPF_OP(insn->code)) {
  1806					case BPF_LSH:
  1807						op = 1; /* prefix 0x66 */
  1808						break;
  1809					case BPF_RSH:
  1810						op = 3; /* prefix 0xf2 */
  1811						break;
  1812					case BPF_ARSH:
  1813						op = 2; /* prefix 0xf3 */
  1814						break;
  1815					}
  1816	
  1817					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  1818	
  1819					break;
  1820				}
  1821	
  1822				if (src_reg != BPF_REG_4) { /* common case */
  1823					/* Check for bad case when dst_reg == rcx */
  1824					if (dst_reg == BPF_REG_4) {
  1825						/* mov r11, dst_reg */
  1826						EMIT_mov(AUX_REG, dst_reg);
  1827						dst_reg = AUX_REG;
  1828					} else {
  1829						EMIT1(0x51); /* push rcx */
  1830					}
  1831					/* mov rcx, src_reg */
  1832					EMIT_mov(BPF_REG_4, src_reg);
  1833				}
  1834	
  1835				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  1836				maybe_emit_1mod(&prog, dst_reg,
  1837						BPF_CLASS(insn->code) == BPF_ALU64);
  1838	
  1839				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1840				EMIT2(0xD3, add_1reg(b3, dst_reg));
  1841	
  1842				if (src_reg != BPF_REG_4) {
  1843					if (insn->dst_reg == BPF_REG_4)
  1844						/* mov dst_reg, r11 */
  1845						EMIT_mov(insn->dst_reg, AUX_REG);
  1846					else
  1847						EMIT1(0x59); /* pop rcx */
  1848				}
  1849	
  1850				break;
  1851	
  1852			case BPF_ALU | BPF_END | BPF_FROM_BE:
  1853			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  1854				switch (imm32) {
  1855				case 16:
  1856					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  1857					EMIT1(0x66);
  1858					if (is_ereg(dst_reg))
  1859						EMIT1(0x41);
  1860					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  1861	
  1862					/* Emit 'movzwl eax, ax' */
  1863					if (is_ereg(dst_reg))
  1864						EMIT3(0x45, 0x0F, 0xB7);
  1865					else
  1866						EMIT2(0x0F, 0xB7);
  1867					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1868					break;
  1869				case 32:
  1870					/* Emit 'bswap eax' to swap lower 4 bytes */
  1871					if (is_ereg(dst_reg))
  1872						EMIT2(0x41, 0x0F);
  1873					else
  1874						EMIT1(0x0F);
  1875					EMIT1(add_1reg(0xC8, dst_reg));
  1876					break;
  1877				case 64:
  1878					/* Emit 'bswap rax' to swap 8 bytes */
  1879					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  1880					      add_1reg(0xC8, dst_reg));
  1881					break;
  1882				}
  1883				break;
  1884	
  1885			case BPF_ALU | BPF_END | BPF_FROM_LE:
  1886				switch (imm32) {
  1887				case 16:
  1888					/*
  1889					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  1890					 * into 64 bit
  1891					 */
  1892					if (is_ereg(dst_reg))
  1893						EMIT3(0x45, 0x0F, 0xB7);
  1894					else
  1895						EMIT2(0x0F, 0xB7);
  1896					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1897					break;
  1898				case 32:
  1899					/* Emit 'mov eax, eax' to clear upper 32-bits */
  1900					if (is_ereg(dst_reg))
  1901						EMIT1(0x45);
  1902					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  1903					break;
  1904				case 64:
  1905					/* nop */
  1906					break;
  1907				}
  1908				break;
  1909	
  1910				/* speculation barrier */
  1911			case BPF_ST | BPF_NOSPEC:
  1912				EMIT_LFENCE();
  1913				break;
  1914	
  1915				/* ST: *(u8*)(dst_reg + off) = imm */
  1916			case BPF_ST | BPF_MEM | BPF_B:
  1917				if (is_ereg(dst_reg))
  1918					EMIT2(0x41, 0xC6);
  1919				else
  1920					EMIT1(0xC6);
  1921				goto st;
  1922			case BPF_ST | BPF_MEM | BPF_H:
  1923				if (is_ereg(dst_reg))
  1924					EMIT3(0x66, 0x41, 0xC7);
  1925				else
  1926					EMIT2(0x66, 0xC7);
  1927				goto st;
  1928			case BPF_ST | BPF_MEM | BPF_W:
  1929				if (is_ereg(dst_reg))
  1930					EMIT2(0x41, 0xC7);
  1931				else
  1932					EMIT1(0xC7);
  1933				goto st;
  1934			case BPF_ST | BPF_MEM | BPF_DW:
  1935				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  1936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

