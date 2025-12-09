Return-Path: <bpf+bounces-76367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D4CB0164
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79632302E96A
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEE331208;
	Tue,  9 Dec 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxDJpr+V"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354F330D4C
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287707; cv=none; b=CsPdkadLX49gsfPQIjI+RxhHdXU4+gq2OZTzVX5wNM0qs5qJWkKm3I+e6va27T9GACwD4sH2PCHf9Wrna6J9rbScZ9HBGn08IAEZG50VUJMchqVKD4QXcinjt8D5mdUCPjghHIU4LThIJFdt+ezZg1rNN34u7xrjj904iIlP3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287707; c=relaxed/simple;
	bh=Dfrq/H2BcUani0HbZ+XoddlaCDoKMT5JDZ7CediKXiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQzSLUaZ20Wh2lvYhuwWfzR5V9kDXpop9MeWsrN7oRn5OZprFl9Wck4OHIbGXusnfQu+GDsvRUQ5xJbdhsXZA9FuNbfDCi4Mi/yXoK+y1f6VvqbD3Fvjx0v6EDEJ1VwsBiQaFy4RIAsjp/Yp3dTYb+VyZjGQ3M2kNuQndxkZOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxDJpr+V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765287705; x=1796823705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dfrq/H2BcUani0HbZ+XoddlaCDoKMT5JDZ7CediKXiE=;
  b=hxDJpr+VQ6R8Wg6d3weQTR4rFQx7qQFAg5k7P3eDhXDZYPEdSXbpPdZh
   nijG6YF+S9p9HeoL7sj6cpr9AG6UzPJhgiJ126TMVh68gCxrRJ2dik3bt
   dJqzRzyw1RVElHdVCVVw4Uq73v6sKrvIP2D2V134HFxr1pwv00Prg9Z2T
   EFG696DsFFQZq0Vk81IIJ7B6IhKlDPzbOOo12UJUsQyAuBO+k/lV+1JA+
   zWTCNbio2Wktu9KdQ5dzRc+D3xgOSMP5zp0wjYkbhiMuT4us1tXcgxBgP
   ay5RfT+OWqazgm9Y1xd/XW/e+uhkqZVUFNeziWnDBh1QRAhLgQpjhkQYu
   w==;
X-CSE-ConnectionGUID: 9HIWy+N5Rhawx1lxLhFMDw==
X-CSE-MsgGUID: 8gGIotfyRaCcATu2zp4+4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="54783945"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="54783945"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 05:41:44 -0800
X-CSE-ConnectionGUID: zy0RqWpGS/Ce/aDKPvTv+A==
X-CSE-MsgGUID: BhT61fPeSmq4+AW2aMb9zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="201336938"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Dec 2025 05:41:42 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSxyF-000000001qT-05T9;
	Tue, 09 Dec 2025 13:41:39 +0000
Date: Tue, 9 Dec 2025 21:41:31 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 6/8] bpf: Check oracle in interpreter
Message-ID: <202512092111.CEpbdA03-lkp@intel.com>
References: <b2e0be3b88386a1101656b4d8faa38b02e317ea5.1765158925.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e0be3b88386a1101656b4d8faa38b02e317ea5.1765158925.git.paul.chaignon@gmail.com>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Chaignon/bpf-Save-pruning-point-states-in-oracle/20251208-102146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/b2e0be3b88386a1101656b4d8faa38b02e317ea5.1765158925.git.paul.chaignon%40gmail.com
patch subject: [PATCH bpf-next 6/8] bpf: Check oracle in interpreter
config: parisc-randconfig-r113-20251209 (https://download.01.org/0day-ci/archive/20251209/202512092111.CEpbdA03-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512092111.CEpbdA03-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512092111.CEpbdA03-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:251:49: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2031:43: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2036:48: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2357:77: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/xdp.h, ...):
   include/trace/events/xdp.h:304:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:331:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/bpf/core.c:1855:55: sparse: sparse: non size-preserving integer to pointer cast

vim +1855 kernel/bpf/core.c

  1757	
  1758	select_insn:
  1759		goto *jumptable[insn->code];
  1760	
  1761		/* Explicitly mask the register-based shift amounts with 63 or 31
  1762		 * to avoid undefined behavior. Normally this won't affect the
  1763		 * generated code, for example, in case of native 64 bit archs such
  1764		 * as x86-64 or arm64, the compiler is optimizing the AND away for
  1765		 * the interpreter. In case of JITs, each of the JIT backends compiles
  1766		 * the BPF shift operations to machine instructions which produce
  1767		 * implementation-defined results in such a case; the resulting
  1768		 * contents of the register may be arbitrary, but program behaviour
  1769		 * as a whole remains defined. In other words, in case of JIT backends,
  1770		 * the AND must /not/ be added to the emitted LSH/RSH/ARSH translation.
  1771		 */
  1772		/* ALU (shifts) */
  1773	#define SHT(OPCODE, OP)					\
  1774		ALU64_##OPCODE##_X:				\
  1775			DST = DST OP (SRC & 63);		\
  1776			CONT;					\
  1777		ALU_##OPCODE##_X:				\
  1778			DST = (u32) DST OP ((u32) SRC & 31);	\
  1779			CONT;					\
  1780		ALU64_##OPCODE##_K:				\
  1781			DST = DST OP IMM;			\
  1782			CONT;					\
  1783		ALU_##OPCODE##_K:				\
  1784			DST = (u32) DST OP (u32) IMM;		\
  1785			CONT;
  1786		/* ALU (rest) */
  1787	#define ALU(OPCODE, OP)					\
  1788		ALU64_##OPCODE##_X:				\
  1789			DST = DST OP SRC;			\
  1790			CONT;					\
  1791		ALU_##OPCODE##_X:				\
  1792			DST = (u32) DST OP (u32) SRC;		\
  1793			CONT;					\
  1794		ALU64_##OPCODE##_K:				\
  1795			DST = DST OP IMM;			\
  1796			CONT;					\
  1797		ALU_##OPCODE##_K:				\
  1798			DST = (u32) DST OP (u32) IMM;		\
  1799			CONT;
  1800		ALU(ADD,  +)
  1801		ALU(SUB,  -)
  1802		ALU(AND,  &)
  1803		ALU(OR,   |)
  1804		ALU(XOR,  ^)
  1805		ALU(MUL,  *)
  1806		SHT(LSH, <<)
  1807		SHT(RSH, >>)
  1808	#undef SHT
  1809	#undef ALU
  1810		ALU_NEG:
  1811			DST = (u32) -DST;
  1812			CONT;
  1813		ALU64_NEG:
  1814			DST = -DST;
  1815			CONT;
  1816		ALU_MOV_X:
  1817			switch (OFF) {
  1818			case 0:
  1819				DST = (u32) SRC;
  1820				break;
  1821			case 8:
  1822				DST = (u32)(s8) SRC;
  1823				break;
  1824			case 16:
  1825				DST = (u32)(s16) SRC;
  1826				break;
  1827			}
  1828			CONT;
  1829		ALU_MOV_K:
  1830			DST = (u32) IMM;
  1831			CONT;
  1832		ALU64_MOV_X:
  1833			switch (OFF) {
  1834			case 0:
  1835				DST = SRC;
  1836				break;
  1837			case 8:
  1838				DST = (s8) SRC;
  1839				break;
  1840			case 16:
  1841				DST = (s16) SRC;
  1842				break;
  1843			case 32:
  1844				DST = (s32) SRC;
  1845				break;
  1846			}
  1847			CONT;
  1848		ALU64_MOV_K:
  1849			DST = IMM;
  1850			CONT;
  1851		LD_IMM_DW: {
  1852			u64 address = (u64)(u32)insn[0].imm | ((u64)(u32)insn[1].imm) << 32;
  1853	
  1854			if (insn[0].src_reg == BPF_PSEUDO_MAP_ORACLE) {
> 1855				oracle_test((struct bpf_map *)address, regs);
  1856				insn++;
  1857				CONT;
  1858			}
  1859			DST = address;
  1860			insn++;
  1861			CONT;
  1862		}
  1863		ALU_ARSH_X:
  1864			DST = (u64) (u32) (((s32) DST) >> (SRC & 31));
  1865			CONT;
  1866		ALU_ARSH_K:
  1867			DST = (u64) (u32) (((s32) DST) >> IMM);
  1868			CONT;
  1869		ALU64_ARSH_X:
  1870			(*(s64 *) &DST) >>= (SRC & 63);
  1871			CONT;
  1872		ALU64_ARSH_K:
  1873			(*(s64 *) &DST) >>= IMM;
  1874			CONT;
  1875		ALU64_MOD_X:
  1876			switch (OFF) {
  1877			case 0:
  1878				div64_u64_rem(DST, SRC, &AX);
  1879				DST = AX;
  1880				break;
  1881			case 1:
  1882				AX = div64_s64(DST, SRC);
  1883				DST = DST - AX * SRC;
  1884				break;
  1885			}
  1886			CONT;
  1887		ALU_MOD_X:
  1888			switch (OFF) {
  1889			case 0:
  1890				AX = (u32) DST;
  1891				DST = do_div(AX, (u32) SRC);
  1892				break;
  1893			case 1:
  1894				AX = abs((s32)DST);
  1895				AX = do_div(AX, abs((s32)SRC));
  1896				if ((s32)DST < 0)
  1897					DST = (u32)-AX;
  1898				else
  1899					DST = (u32)AX;
  1900				break;
  1901			}
  1902			CONT;
  1903		ALU64_MOD_K:
  1904			switch (OFF) {
  1905			case 0:
  1906				div64_u64_rem(DST, IMM, &AX);
  1907				DST = AX;
  1908				break;
  1909			case 1:
  1910				AX = div64_s64(DST, IMM);
  1911				DST = DST - AX * IMM;
  1912				break;
  1913			}
  1914			CONT;
  1915		ALU_MOD_K:
  1916			switch (OFF) {
  1917			case 0:
  1918				AX = (u32) DST;
  1919				DST = do_div(AX, (u32) IMM);
  1920				break;
  1921			case 1:
  1922				AX = abs((s32)DST);
  1923				AX = do_div(AX, abs((s32)IMM));
  1924				if ((s32)DST < 0)
  1925					DST = (u32)-AX;
  1926				else
  1927					DST = (u32)AX;
  1928				break;
  1929			}
  1930			CONT;
  1931		ALU64_DIV_X:
  1932			switch (OFF) {
  1933			case 0:
  1934				DST = div64_u64(DST, SRC);
  1935				break;
  1936			case 1:
  1937				DST = div64_s64(DST, SRC);
  1938				break;
  1939			}
  1940			CONT;
  1941		ALU_DIV_X:
  1942			switch (OFF) {
  1943			case 0:
  1944				AX = (u32) DST;
  1945				do_div(AX, (u32) SRC);
  1946				DST = (u32) AX;
  1947				break;
  1948			case 1:
  1949				AX = abs((s32)DST);
  1950				do_div(AX, abs((s32)SRC));
  1951				if (((s32)DST < 0) == ((s32)SRC < 0))
  1952					DST = (u32)AX;
  1953				else
  1954					DST = (u32)-AX;
  1955				break;
  1956			}
  1957			CONT;
  1958		ALU64_DIV_K:
  1959			switch (OFF) {
  1960			case 0:
  1961				DST = div64_u64(DST, IMM);
  1962				break;
  1963			case 1:
  1964				DST = div64_s64(DST, IMM);
  1965				break;
  1966			}
  1967			CONT;
  1968		ALU_DIV_K:
  1969			switch (OFF) {
  1970			case 0:
  1971				AX = (u32) DST;
  1972				do_div(AX, (u32) IMM);
  1973				DST = (u32) AX;
  1974				break;
  1975			case 1:
  1976				AX = abs((s32)DST);
  1977				do_div(AX, abs((s32)IMM));
  1978				if (((s32)DST < 0) == ((s32)IMM < 0))
  1979					DST = (u32)AX;
  1980				else
  1981					DST = (u32)-AX;
  1982				break;
  1983			}
  1984			CONT;
  1985		ALU_END_TO_BE:
  1986			switch (IMM) {
  1987			case 16:
  1988				DST = (__force u16) cpu_to_be16(DST);
  1989				break;
  1990			case 32:
  1991				DST = (__force u32) cpu_to_be32(DST);
  1992				break;
  1993			case 64:
  1994				DST = (__force u64) cpu_to_be64(DST);
  1995				break;
  1996			}
  1997			CONT;
  1998		ALU_END_TO_LE:
  1999			switch (IMM) {
  2000			case 16:
  2001				DST = (__force u16) cpu_to_le16(DST);
  2002				break;
  2003			case 32:
  2004				DST = (__force u32) cpu_to_le32(DST);
  2005				break;
  2006			case 64:
  2007				DST = (__force u64) cpu_to_le64(DST);
  2008				break;
  2009			}
  2010			CONT;
  2011		ALU64_END_TO_LE:
  2012			switch (IMM) {
  2013			case 16:
  2014				DST = (__force u16) __swab16(DST);
  2015				break;
  2016			case 32:
  2017				DST = (__force u32) __swab32(DST);
  2018				break;
  2019			case 64:
  2020				DST = (__force u64) __swab64(DST);
  2021				break;
  2022			}
  2023			CONT;
  2024	
  2025		/* CALL */
  2026		JMP_CALL:
  2027			/* Function call scratches BPF_R1-BPF_R5 registers,
  2028			 * preserves BPF_R6-BPF_R9, and stores return value
  2029			 * into BPF_R0.
  2030			 */
  2031			BPF_R0 = (__bpf_call_base + insn->imm)(BPF_R1, BPF_R2, BPF_R3,
  2032							       BPF_R4, BPF_R5);
  2033			CONT;
  2034	
  2035		JMP_CALL_ARGS:
  2036			BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
  2037								    BPF_R3, BPF_R4,
  2038								    BPF_R5,
  2039								    insn + insn->off + 1);
  2040			CONT;
  2041	
  2042		JMP_TAIL_CALL: {
  2043			struct bpf_map *map = (struct bpf_map *) (unsigned long) BPF_R2;
  2044			struct bpf_array *array = container_of(map, struct bpf_array, map);
  2045			struct bpf_prog *prog;
  2046			u32 index = BPF_R3;
  2047	
  2048			if (unlikely(index >= array->map.max_entries))
  2049				goto out;
  2050	
  2051			if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
  2052				goto out;
  2053	
  2054			tail_call_cnt++;
  2055	
  2056			prog = READ_ONCE(array->ptrs[index]);
  2057			if (!prog)
  2058				goto out;
  2059	
  2060			/* ARG1 at this point is guaranteed to point to CTX from
  2061			 * the verifier side due to the fact that the tail call is
  2062			 * handled like a helper, that is, bpf_tail_call_proto,
  2063			 * where arg1_type is ARG_PTR_TO_CTX.
  2064			 */
  2065			insn = prog->insnsi;
  2066			goto select_insn;
  2067	out:
  2068			CONT;
  2069		}
  2070		JMP_JA:
  2071			insn += insn->off;
  2072			CONT;
  2073		JMP32_JA:
  2074			insn += insn->imm;
  2075			CONT;
  2076		JMP_EXIT:
  2077			return BPF_R0;
  2078		/* JMP */
  2079	#define COND_JMP(SIGN, OPCODE, CMP_OP)				\
  2080		JMP_##OPCODE##_X:					\
  2081			if ((SIGN##64) DST CMP_OP (SIGN##64) SRC) {	\
  2082				insn += insn->off;			\
  2083				CONT_JMP;				\
  2084			}						\
  2085			CONT;						\
  2086		JMP32_##OPCODE##_X:					\
  2087			if ((SIGN##32) DST CMP_OP (SIGN##32) SRC) {	\
  2088				insn += insn->off;			\
  2089				CONT_JMP;				\
  2090			}						\
  2091			CONT;						\
  2092		JMP_##OPCODE##_K:					\
  2093			if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {	\
  2094				insn += insn->off;			\
  2095				CONT_JMP;				\
  2096			}						\
  2097			CONT;						\
  2098		JMP32_##OPCODE##_K:					\
  2099			if ((SIGN##32) DST CMP_OP (SIGN##32) IMM) {	\
  2100				insn += insn->off;			\
  2101				CONT_JMP;				\
  2102			}						\
  2103			CONT;
  2104		COND_JMP(u, JEQ, ==)
  2105		COND_JMP(u, JNE, !=)
  2106		COND_JMP(u, JGT, >)
  2107		COND_JMP(u, JLT, <)
  2108		COND_JMP(u, JGE, >=)
  2109		COND_JMP(u, JLE, <=)
  2110		COND_JMP(u, JSET, &)
  2111		COND_JMP(s, JSGT, >)
  2112		COND_JMP(s, JSLT, <)
  2113		COND_JMP(s, JSGE, >=)
  2114		COND_JMP(s, JSLE, <=)
  2115	#undef COND_JMP
  2116		/* ST, STX and LDX*/
  2117		ST_NOSPEC:
  2118			/* Speculation barrier for mitigating Speculative Store Bypass,
  2119			 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
  2120			 * rely on the firmware mitigation as controlled via the ssbd
  2121			 * kernel parameter. Whenever the mitigation is enabled, it
  2122			 * works for all of the kernel code with no need to provide any
  2123			 * additional instructions here. In case of x86, we use 'lfence'
  2124			 * insn for mitigation. We reuse preexisting logic from Spectre
  2125			 * v1 mitigation that happens to produce the required code on
  2126			 * x86 for v4 as well.
  2127			 */
  2128			barrier_nospec();
  2129			CONT;
  2130	#define LDST(SIZEOP, SIZE)						\
  2131		STX_MEM_##SIZEOP:						\
  2132			*(SIZE *)(unsigned long) (DST + insn->off) = SRC;	\
  2133			CONT;							\
  2134		ST_MEM_##SIZEOP:						\
  2135			*(SIZE *)(unsigned long) (DST + insn->off) = IMM;	\
  2136			CONT;							\
  2137		LDX_MEM_##SIZEOP:						\
  2138			DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
  2139			CONT;							\
  2140		LDX_PROBE_MEM_##SIZEOP:						\
  2141			bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
  2142				      (const void *)(long) (SRC + insn->off));	\
  2143			DST = *((SIZE *)&DST);					\
  2144			CONT;
  2145	
  2146		LDST(B,   u8)
  2147		LDST(H,  u16)
  2148		LDST(W,  u32)
  2149		LDST(DW, u64)
  2150	#undef LDST
  2151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

