Return-Path: <bpf+bounces-40151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9DC97DB40
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 03:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BF51F223A9
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E563D5;
	Sat, 21 Sep 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx5RxW4s"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B277ECC;
	Sat, 21 Sep 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726883611; cv=none; b=iofBso1uSJvr5oxncjtyx3aBopBSCKZYNOvW0iG3gOAkkSLvgIMdo1/qred4b10LetYoTVS0fp8xxONwu5Ccp1vFICzbQyTy7/dJ21lwayo/qjKME5sMQVS72F2pOUXjsYFFZKwsrX5jXh8QheNug+KSaT6wGL5lLgVVApnoDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726883611; c=relaxed/simple;
	bh=XTJsGq7nACH6xvgH0UirAVDsChmA2ZB+dEZukQjNjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHXxw1gzNTt799q37YanizeboQfCcfhxSNFW4WBwlf38SE0lW/WJA8N6nbUecHAcwtI8cEbKaywJ7XGyAriMyHLc2Q7CQHSU98yLvLYOegNJMhxP1blxXagmRey54axEHNhTq9BBQtULJ9++hlA+kgXui8CLVBp96XhLhMUmx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx5RxW4s; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726883608; x=1758419608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTJsGq7nACH6xvgH0UirAVDsChmA2ZB+dEZukQjNjy4=;
  b=lx5RxW4sh1ahE24vnYLclrbJ2LWfpa0rkCwa55tdRmjY7TFcUf8b9wyW
   Fvb8t2kW2+RlPRLjck2jcHx54uh1+WA+oWW8Dy386H6xUwBIDtAdGKaiU
   9WKT4BRoer9hOvr6VcqMRAudQz5oTdNNBkAq95SA0aoD54e60w/Jn2l7D
   5JTd6/y/qhfyod0IL/fdaWWGEaMeoDyLHRxSFuiSz2n4+LKNg3ednzrVj
   wMgu3juF9DA2/Wpn2SDeItLMtQ+YAKDp23eqvyYHx7SI/4aHEkHRcG4BC
   12scC69OfSO9yGahpZWk0sQHGlCZ6zsbaOjlHUlCJmTaoVZ4JQjhS2gxl
   w==;
X-CSE-ConnectionGUID: oVkAkmZBRPukL4BKuZUfKA==
X-CSE-MsgGUID: cEszo2pcTNuCkhGj3VM7YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="29801350"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="29801350"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 18:53:27 -0700
X-CSE-ConnectionGUID: TCEjqr4KR3G1FnFOu4+O0A==
X-CSE-MsgGUID: gR9TPEPVSFqryQ9sonq41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="70533065"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 18:53:22 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srpJH-000F27-0y;
	Sat, 21 Sep 2024 01:53:19 +0000
Date: Sat, 21 Sep 2024 09:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, Tao Chen <chen.dylane@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
Message-ID: <202409210927.QzQakLAf-lkp@intel.com>
References: <20240920153706.919154-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920153706.919154-1-chen.dylane@gmail.com>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Chen/bpf-Add-BPF_CALL_FUNC-to-simplify-code/20240920-233936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240920153706.919154-1-chen.dylane%40gmail.com
patch subject: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
config: arm-randconfig-001-20240921 (https://download.01.org/0day-ci/archive/20240921/202409210927.QzQakLAf-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210927.QzQakLAf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210927.QzQakLAf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:9:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/bpf/core.c:2010:36: error: called object type 'u8 *' (aka 'unsigned char *') is not a function or function pointer
    2010 |                 BPF_R0 = BPF_CALL_FUNC(insn->imm)(BPF_R1, BPF_R2, BPF_R3,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~^
   kernel/bpf/core.c:2015:41: error: called object type 'u8 *' (aka 'unsigned char *') is not a function or function pointer
    2015 |                 BPF_R0 = BPF_CALL_FUNC_ARGS(insn->imm)(BPF_R1, BPF_R2,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   1 warning and 2 errors generated.


vim +2010 kernel/bpf/core.c

  1744	
  1745	select_insn:
  1746		goto *jumptable[insn->code];
  1747	
  1748		/* Explicitly mask the register-based shift amounts with 63 or 31
  1749		 * to avoid undefined behavior. Normally this won't affect the
  1750		 * generated code, for example, in case of native 64 bit archs such
  1751		 * as x86-64 or arm64, the compiler is optimizing the AND away for
  1752		 * the interpreter. In case of JITs, each of the JIT backends compiles
  1753		 * the BPF shift operations to machine instructions which produce
  1754		 * implementation-defined results in such a case; the resulting
  1755		 * contents of the register may be arbitrary, but program behaviour
  1756		 * as a whole remains defined. In other words, in case of JIT backends,
  1757		 * the AND must /not/ be added to the emitted LSH/RSH/ARSH translation.
  1758		 */
  1759		/* ALU (shifts) */
  1760	#define SHT(OPCODE, OP)					\
  1761		ALU64_##OPCODE##_X:				\
  1762			DST = DST OP (SRC & 63);		\
  1763			CONT;					\
  1764		ALU_##OPCODE##_X:				\
  1765			DST = (u32) DST OP ((u32) SRC & 31);	\
  1766			CONT;					\
  1767		ALU64_##OPCODE##_K:				\
  1768			DST = DST OP IMM;			\
  1769			CONT;					\
  1770		ALU_##OPCODE##_K:				\
  1771			DST = (u32) DST OP (u32) IMM;		\
  1772			CONT;
  1773		/* ALU (rest) */
  1774	#define ALU(OPCODE, OP)					\
  1775		ALU64_##OPCODE##_X:				\
  1776			DST = DST OP SRC;			\
  1777			CONT;					\
  1778		ALU_##OPCODE##_X:				\
  1779			DST = (u32) DST OP (u32) SRC;		\
  1780			CONT;					\
  1781		ALU64_##OPCODE##_K:				\
  1782			DST = DST OP IMM;			\
  1783			CONT;					\
  1784		ALU_##OPCODE##_K:				\
  1785			DST = (u32) DST OP (u32) IMM;		\
  1786			CONT;
  1787		ALU(ADD,  +)
  1788		ALU(SUB,  -)
  1789		ALU(AND,  &)
  1790		ALU(OR,   |)
  1791		ALU(XOR,  ^)
  1792		ALU(MUL,  *)
  1793		SHT(LSH, <<)
  1794		SHT(RSH, >>)
  1795	#undef SHT
  1796	#undef ALU
  1797		ALU_NEG:
  1798			DST = (u32) -DST;
  1799			CONT;
  1800		ALU64_NEG:
  1801			DST = -DST;
  1802			CONT;
  1803		ALU_MOV_X:
  1804			switch (OFF) {
  1805			case 0:
  1806				DST = (u32) SRC;
  1807				break;
  1808			case 8:
  1809				DST = (u32)(s8) SRC;
  1810				break;
  1811			case 16:
  1812				DST = (u32)(s16) SRC;
  1813				break;
  1814			}
  1815			CONT;
  1816		ALU_MOV_K:
  1817			DST = (u32) IMM;
  1818			CONT;
  1819		ALU64_MOV_X:
  1820			switch (OFF) {
  1821			case 0:
  1822				DST = SRC;
  1823				break;
  1824			case 8:
  1825				DST = (s8) SRC;
  1826				break;
  1827			case 16:
  1828				DST = (s16) SRC;
  1829				break;
  1830			case 32:
  1831				DST = (s32) SRC;
  1832				break;
  1833			}
  1834			CONT;
  1835		ALU64_MOV_K:
  1836			DST = IMM;
  1837			CONT;
  1838		LD_IMM_DW:
  1839			DST = (u64) (u32) insn[0].imm | ((u64) (u32) insn[1].imm) << 32;
  1840			insn++;
  1841			CONT;
  1842		ALU_ARSH_X:
  1843			DST = (u64) (u32) (((s32) DST) >> (SRC & 31));
  1844			CONT;
  1845		ALU_ARSH_K:
  1846			DST = (u64) (u32) (((s32) DST) >> IMM);
  1847			CONT;
  1848		ALU64_ARSH_X:
  1849			(*(s64 *) &DST) >>= (SRC & 63);
  1850			CONT;
  1851		ALU64_ARSH_K:
  1852			(*(s64 *) &DST) >>= IMM;
  1853			CONT;
  1854		ALU64_MOD_X:
  1855			switch (OFF) {
  1856			case 0:
  1857				div64_u64_rem(DST, SRC, &AX);
  1858				DST = AX;
  1859				break;
  1860			case 1:
  1861				AX = div64_s64(DST, SRC);
  1862				DST = DST - AX * SRC;
  1863				break;
  1864			}
  1865			CONT;
  1866		ALU_MOD_X:
  1867			switch (OFF) {
  1868			case 0:
  1869				AX = (u32) DST;
  1870				DST = do_div(AX, (u32) SRC);
  1871				break;
  1872			case 1:
  1873				AX = abs((s32)DST);
  1874				AX = do_div(AX, abs((s32)SRC));
  1875				if ((s32)DST < 0)
  1876					DST = (u32)-AX;
  1877				else
  1878					DST = (u32)AX;
  1879				break;
  1880			}
  1881			CONT;
  1882		ALU64_MOD_K:
  1883			switch (OFF) {
  1884			case 0:
  1885				div64_u64_rem(DST, IMM, &AX);
  1886				DST = AX;
  1887				break;
  1888			case 1:
  1889				AX = div64_s64(DST, IMM);
  1890				DST = DST - AX * IMM;
  1891				break;
  1892			}
  1893			CONT;
  1894		ALU_MOD_K:
  1895			switch (OFF) {
  1896			case 0:
  1897				AX = (u32) DST;
  1898				DST = do_div(AX, (u32) IMM);
  1899				break;
  1900			case 1:
  1901				AX = abs((s32)DST);
  1902				AX = do_div(AX, abs((s32)IMM));
  1903				if ((s32)DST < 0)
  1904					DST = (u32)-AX;
  1905				else
  1906					DST = (u32)AX;
  1907				break;
  1908			}
  1909			CONT;
  1910		ALU64_DIV_X:
  1911			switch (OFF) {
  1912			case 0:
  1913				DST = div64_u64(DST, SRC);
  1914				break;
  1915			case 1:
  1916				DST = div64_s64(DST, SRC);
  1917				break;
  1918			}
  1919			CONT;
  1920		ALU_DIV_X:
  1921			switch (OFF) {
  1922			case 0:
  1923				AX = (u32) DST;
  1924				do_div(AX, (u32) SRC);
  1925				DST = (u32) AX;
  1926				break;
  1927			case 1:
  1928				AX = abs((s32)DST);
  1929				do_div(AX, abs((s32)SRC));
  1930				if (((s32)DST < 0) == ((s32)SRC < 0))
  1931					DST = (u32)AX;
  1932				else
  1933					DST = (u32)-AX;
  1934				break;
  1935			}
  1936			CONT;
  1937		ALU64_DIV_K:
  1938			switch (OFF) {
  1939			case 0:
  1940				DST = div64_u64(DST, IMM);
  1941				break;
  1942			case 1:
  1943				DST = div64_s64(DST, IMM);
  1944				break;
  1945			}
  1946			CONT;
  1947		ALU_DIV_K:
  1948			switch (OFF) {
  1949			case 0:
  1950				AX = (u32) DST;
  1951				do_div(AX, (u32) IMM);
  1952				DST = (u32) AX;
  1953				break;
  1954			case 1:
  1955				AX = abs((s32)DST);
  1956				do_div(AX, abs((s32)IMM));
  1957				if (((s32)DST < 0) == ((s32)IMM < 0))
  1958					DST = (u32)AX;
  1959				else
  1960					DST = (u32)-AX;
  1961				break;
  1962			}
  1963			CONT;
  1964		ALU_END_TO_BE:
  1965			switch (IMM) {
  1966			case 16:
  1967				DST = (__force u16) cpu_to_be16(DST);
  1968				break;
  1969			case 32:
  1970				DST = (__force u32) cpu_to_be32(DST);
  1971				break;
  1972			case 64:
  1973				DST = (__force u64) cpu_to_be64(DST);
  1974				break;
  1975			}
  1976			CONT;
  1977		ALU_END_TO_LE:
  1978			switch (IMM) {
  1979			case 16:
  1980				DST = (__force u16) cpu_to_le16(DST);
  1981				break;
  1982			case 32:
  1983				DST = (__force u32) cpu_to_le32(DST);
  1984				break;
  1985			case 64:
  1986				DST = (__force u64) cpu_to_le64(DST);
  1987				break;
  1988			}
  1989			CONT;
  1990		ALU64_END_TO_LE:
  1991			switch (IMM) {
  1992			case 16:
  1993				DST = (__force u16) __swab16(DST);
  1994				break;
  1995			case 32:
  1996				DST = (__force u32) __swab32(DST);
  1997				break;
  1998			case 64:
  1999				DST = (__force u64) __swab64(DST);
  2000				break;
  2001			}
  2002			CONT;
  2003	
  2004		/* CALL */
  2005		JMP_CALL:
  2006			/* Function call scratches BPF_R1-BPF_R5 registers,
  2007			 * preserves BPF_R6-BPF_R9, and stores return value
  2008			 * into BPF_R0.
  2009			 */
> 2010			BPF_R0 = BPF_CALL_FUNC(insn->imm)(BPF_R1, BPF_R2, BPF_R3,
  2011							       BPF_R4, BPF_R5);
  2012			CONT;
  2013	
  2014		JMP_CALL_ARGS:
  2015			BPF_R0 = BPF_CALL_FUNC_ARGS(insn->imm)(BPF_R1, BPF_R2,
  2016								    BPF_R3, BPF_R4,
  2017								    BPF_R5,
  2018								    insn + insn->off + 1);
  2019			CONT;
  2020	
  2021		JMP_TAIL_CALL: {
  2022			struct bpf_map *map = (struct bpf_map *) (unsigned long) BPF_R2;
  2023			struct bpf_array *array = container_of(map, struct bpf_array, map);
  2024			struct bpf_prog *prog;
  2025			u32 index = BPF_R3;
  2026	
  2027			if (unlikely(index >= array->map.max_entries))
  2028				goto out;
  2029	
  2030			if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
  2031				goto out;
  2032	
  2033			tail_call_cnt++;
  2034	
  2035			prog = READ_ONCE(array->ptrs[index]);
  2036			if (!prog)
  2037				goto out;
  2038	
  2039			/* ARG1 at this point is guaranteed to point to CTX from
  2040			 * the verifier side due to the fact that the tail call is
  2041			 * handled like a helper, that is, bpf_tail_call_proto,
  2042			 * where arg1_type is ARG_PTR_TO_CTX.
  2043			 */
  2044			insn = prog->insnsi;
  2045			goto select_insn;
  2046	out:
  2047			CONT;
  2048		}
  2049		JMP_JA:
  2050			insn += insn->off;
  2051			CONT;
  2052		JMP32_JA:
  2053			insn += insn->imm;
  2054			CONT;
  2055		JMP_EXIT:
  2056			return BPF_R0;
  2057		/* JMP */
  2058	#define COND_JMP(SIGN, OPCODE, CMP_OP)				\
  2059		JMP_##OPCODE##_X:					\
  2060			if ((SIGN##64) DST CMP_OP (SIGN##64) SRC) {	\
  2061				insn += insn->off;			\
  2062				CONT_JMP;				\
  2063			}						\
  2064			CONT;						\
  2065		JMP32_##OPCODE##_X:					\
  2066			if ((SIGN##32) DST CMP_OP (SIGN##32) SRC) {	\
  2067				insn += insn->off;			\
  2068				CONT_JMP;				\
  2069			}						\
  2070			CONT;						\
  2071		JMP_##OPCODE##_K:					\
  2072			if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {	\
  2073				insn += insn->off;			\
  2074				CONT_JMP;				\
  2075			}						\
  2076			CONT;						\
  2077		JMP32_##OPCODE##_K:					\
  2078			if ((SIGN##32) DST CMP_OP (SIGN##32) IMM) {	\
  2079				insn += insn->off;			\
  2080				CONT_JMP;				\
  2081			}						\
  2082			CONT;
  2083		COND_JMP(u, JEQ, ==)
  2084		COND_JMP(u, JNE, !=)
  2085		COND_JMP(u, JGT, >)
  2086		COND_JMP(u, JLT, <)
  2087		COND_JMP(u, JGE, >=)
  2088		COND_JMP(u, JLE, <=)
  2089		COND_JMP(u, JSET, &)
  2090		COND_JMP(s, JSGT, >)
  2091		COND_JMP(s, JSLT, <)
  2092		COND_JMP(s, JSGE, >=)
  2093		COND_JMP(s, JSLE, <=)
  2094	#undef COND_JMP
  2095		/* ST, STX and LDX*/
  2096		ST_NOSPEC:
  2097			/* Speculation barrier for mitigating Speculative Store Bypass.
  2098			 * In case of arm64, we rely on the firmware mitigation as
  2099			 * controlled via the ssbd kernel parameter. Whenever the
  2100			 * mitigation is enabled, it works for all of the kernel code
  2101			 * with no need to provide any additional instructions here.
  2102			 * In case of x86, we use 'lfence' insn for mitigation. We
  2103			 * reuse preexisting logic from Spectre v1 mitigation that
  2104			 * happens to produce the required code on x86 for v4 as well.
  2105			 */
  2106			barrier_nospec();
  2107			CONT;
  2108	#define LDST(SIZEOP, SIZE)						\
  2109		STX_MEM_##SIZEOP:						\
  2110			*(SIZE *)(unsigned long) (DST + insn->off) = SRC;	\
  2111			CONT;							\
  2112		ST_MEM_##SIZEOP:						\
  2113			*(SIZE *)(unsigned long) (DST + insn->off) = IMM;	\
  2114			CONT;							\
  2115		LDX_MEM_##SIZEOP:						\
  2116			DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
  2117			CONT;							\
  2118		LDX_PROBE_MEM_##SIZEOP:						\
  2119			bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
  2120				      (const void *)(long) (SRC + insn->off));	\
  2121			DST = *((SIZE *)&DST);					\
  2122			CONT;
  2123	
  2124		LDST(B,   u8)
  2125		LDST(H,  u16)
  2126		LDST(W,  u32)
  2127		LDST(DW, u64)
  2128	#undef LDST
  2129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

