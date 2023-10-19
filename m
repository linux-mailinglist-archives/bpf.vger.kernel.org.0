Return-Path: <bpf+bounces-12674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAF7CF0C9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB3281F35
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747ED8F74;
	Thu, 19 Oct 2023 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJ3LzduV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E78F64
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:09:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365F195
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697699340; x=1729235340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hyVNic0tqttX+00AlOGc3CyTTc3XI7khC0QmRX6dD7o=;
  b=GJ3LzduViRcoJVfUETY8PEYkv5cy+itqu8Cul526qllV/fhN4Kd+LHwf
   eISKm5SI3SZir5x0hilWuvG5EwXAfjmWw3+ixh//NwO5T1ena6Z5ld7Kt
   CvBKcdka8QZJOiSficvbgYPBoCo4c/zaU1DB6E8q18Bg+kjN8po0HlUdP
   ur+8XWIMgtUdIzd7J3j6T9w4A2vGhZiF16uNFPHatduW8gntfS3uYaK3I
   UaJPCR+5vF7hAouj0T8LoL5B7FOG2RuMPUBUjp/tWTNQC1sLsasW9eHQM
   JZqZrSG8RKjGQ4FWNGj7UwSJP8RUULShdP5si/FuzjMPi1NqwpCMGF8oE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450409119"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="450409119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 00:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791899818"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="791899818"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2023 00:08:57 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qtN9J-0001mK-35;
	Thu, 19 Oct 2023 07:08:53 +0000
Date: Thu, 19 Oct 2023 15:08:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <202310191409.pIIb2buD-lkp@intel.com>
References: <20231019042405.2971130-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019042405.2971130-8-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-improve-JEQ-JNE-branch-taken-logic/20231019-122550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231019042405.2971130-8-andrii%40kernel.org
patch subject: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310191409.pIIb2buD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191409.pIIb2buD-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:NEW_TYPEDEFS: do not add new typedefs
#169: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:21:
+typedef unsigned long long ___u64;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#170: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:22:
+typedef unsigned int ___u32;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#171: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:23:
+typedef long long ___s64;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#172: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:24:
+typedef int ___s32;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#215: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:67:
+	case U64: return (u64)x < (u64)y ? (u64)x : (u64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#216: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:68:
+	case U32: return (u32)x < (u32)y ? (u32)x : (u32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#217: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:69:
+	case S64: return (s64)x < (s64)y ? (s64)x : (s64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#218: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:70:
+	case S32: return (s32)x < (s32)y ? (s32)x : (s32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#219: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:71:
+	default: printf("min_t!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'min_t', this function's name, in a string
#219: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:71:
+	default: printf("min_t!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#226: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:78:
+	case U64: return (u64)x > (u64)y ? (u64)x : (u64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#227: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:79:
+	case U32: return (u32)x > (u32)y ? (u32)x : (u32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#228: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:80:
+	case S64: return (s64)x > (s64)y ? (s64)x : (s64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#229: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:81:
+	case S32: return (s32)x > (s32)y ? (u32)(s32)x : (u32)(s32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#230: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:82:
+	default: printf("max_t!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'max_t', this function's name, in a string
#230: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:82:
+	default: printf("max_t!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#241: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:93:
+	default: printf("t_str!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_str', this function's name, in a string
#241: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:93:
+	default: printf("t_str!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#252: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:104:
+	default: printf("t_is_32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_is_32', this function's name, in a string
#252: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:104:
+	default: printf("t_is_32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#263: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:115:
+	default: printf("t_signed!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_signed', this function's name, in a string
#263: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:115:
+	default: printf("t_signed!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#274: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:126:
+	default: printf("t_unsigned!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_unsigned', this function's name, in a string
#274: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:126:
+	default: printf("t_unsigned!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#285: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:137:
+	default: printf("num_is_small!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'num_is_small', this function's name, in a string
#285: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:137:
+	default: printf("num_is_small!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#299: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:151:
+		default: printf("snprintf_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'snprintf_num', this function's name, in a string
#299: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:151:
+		default: printf("snprintf_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#339: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:191:
+		default: printf("snprintf_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'snprintf_num', this function's name, in a string
#339: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:191:
+		default: printf("snprintf_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#386: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:238:
+	default: printf("unkn_subreg!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'unkn_subreg', this function's name, in a string
#386: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:238:
+	default: printf("unkn_subreg!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#397: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:249:
+	default: printf("range!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range', this function's name, in a string
#397: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:249:
+	default: printf("range!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#454: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:306:
+	default: printf("range_cast_u64!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_u64', this function's name, in a string
#454: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:306:
+	default: printf("range_cast_u64!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#476: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:328:
+	default: printf("range_cast_s64!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_s64', this function's name, in a string
#476: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:328:
+	default: printf("range_cast_s64!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#493: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:345:
+	default: printf("range_cast_u32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_u32', this function's name, in a string
#493: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:345:
+	default: printf("range_cast_u32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#510: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:362:
+	default: printf("range_cast_s32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_s32', this function's name, in a string
#510: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:362:
+	default: printf("range_cast_s32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#526: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:378:
+	default: printf("range_cast!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast', this function's name, in a string
#526: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:378:
+	default: printf("range_cast!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#537: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:389:
+	default: printf("is_valid_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'is_valid_num', this function's name, in a string
#537: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:389:
+	default: printf("is_valid_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#551: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:403:
+	default: printf("is_valid_range!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'is_valid_range', this function's name, in a string
#551: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:403:
+	default: printf("is_valid_range!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#606: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:458:
+	default: printf("complement_op!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'complement_op', this function's name, in a string
#606: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:458:
+	default: printf("complement_op!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#619: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:471:
+	default: printf("op_str!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'op_str', this function's name, in a string
#619: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:471:
+	default: printf("op_str!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#638: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:490:
+	default: printf("range_canbe op %d\n", op); exit(1);					\

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#643: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:495:
+	case U64: { range_canbe(u64); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#644: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:496:
+	case U32: { range_canbe(u32); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#645: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:497:
+	case S64: { range_canbe(s64); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#646: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:498:
+	case S32: { range_canbe(s32); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#647: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:499:
+	default: printf("range_canbe!\n"); exit(1);

WARNING:LINE_SPACING: Missing a blank line after declarations
#933: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:785:
+	struct bpf_insn insns[64];
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1014: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:866:
+	case OP_LT: op_code = spec.compare_signed ? BPF_JSLT : BPF_JLT; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1015: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:867:
+	case OP_LE: op_code = spec.compare_signed ? BPF_JSLE : BPF_JLE; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1016: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:868:
+	case OP_GT: op_code = spec.compare_signed ? BPF_JSGT : BPF_JGT; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1017: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:869:
+	case OP_GE: op_code = spec.compare_signed ? BPF_JSGE : BPF_JGE; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1018: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:870:
+	case OP_EQ: op_code = BPF_JEQ; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1019: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:871:
+	case OP_NE: op_code = BPF_JNE; break;

WARNING:BRACES: braces {} are not necessary for single statement blocks
#1153: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1005:
+		for (t = MIN_T; t <= MAX_T; t++) {
+			reg->r[t] = range(t, sval, sval);
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#1559: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1411:
+		for (j = 0; j < ARRAY_SIZE(lower_seeds); j++) {
+			uvals[cnt++] = (((u64)upper_seeds[i]) << 32) | lower_seeds[j];
+		}

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#1566: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1418:
+	for (i = 1, j = 0; i < cnt; i++)
+	{

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1665: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1517:
+	for (i = 0; i < val_cnt; i++)
+	for (j = 0; j < range_cnt; j++)

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1666: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1518:
+	for (j = 0; j < range_cnt; j++)
+	for (cond_t = MIN_T; cond_t <= MAX_T; cond_t++) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

