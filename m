Return-Path: <bpf+bounces-12958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45BF7D26E9
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 01:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6CC1C2095F
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C886FC0;
	Sun, 22 Oct 2023 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYZ9Zfim"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD93D6B
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 23:01:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2204DB
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698015679; x=1729551679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zXcJ+KdIhPVPzq7oFaMlsPv3G/+AWSr0+LRH9TFrsY=;
  b=bYZ9ZfimSw8rYAUmIUxbXei2bY9kePBKmmsSJglhsnYFEnnVS9hH0WgV
   yYOTEH639gQtCnvaF5Gxz+ctvJWJJ45vMr3F/ICDPeOYaLRZGFxL03I7G
   +HQMHPvf3CRaQNN0DRN8ddoy9DpMyTL4MQlPF7hzM7O5HhnCvE7lbTqab
   ALeIcA7u2VC9/1AYyvlPO0V6pFdhrPhOIJaIgILoYmghfWhNw4FJnIin7
   YgzbHHavNSyAg369oEjCRpL9TFSVVChDx067ldBBQw5ElxuuzczMjNAB5
   lwVUr5qExNWYpwtP9QuO+wF3FIYiVZHOswX04q4ZK9rFDH0XRaCB+QJoE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453209440"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453209440"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 16:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931514477"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="931514477"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2023 16:01:17 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quhRb-0006L4-0K;
	Sun, 22 Oct 2023 23:01:15 +0000
Date: Mon, 23 Oct 2023 07:01:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <202310230626.Y37NWY7u-lkp@intel.com>
References: <20231022205743.72352-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022205743.72352-8-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-improve-JEQ-JNE-branch-taken-logic/20231023-050035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231022205743.72352-8-andrii%40kernel.org
patch subject: [PATCH v4 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
reproduce: (https://download.01.org/0day-ci/archive/20231023/202310230626.Y37NWY7u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310230626.Y37NWY7u-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:NEW_TYPEDEFS: do not add new typedefs
#168: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:21:
+typedef unsigned long long ___u64;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#169: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:22:
+typedef unsigned int ___u32;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#170: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:23:
+typedef long long ___s64;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#171: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:24:
+typedef int ___s32;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#214: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:67:
+	case U64: return (u64)x < (u64)y ? (u64)x : (u64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#215: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:68:
+	case U32: return (u32)x < (u32)y ? (u32)x : (u32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#216: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:69:
+	case S64: return (s64)x < (s64)y ? (s64)x : (s64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#217: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:70:
+	case S32: return (s32)x < (s32)y ? (s32)x : (s32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#218: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:71:
+	default: printf("min_t!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'min_t', this function's name, in a string
#218: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:71:
+	default: printf("min_t!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#225: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:78:
+	case U64: return (u64)x > (u64)y ? (u64)x : (u64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#226: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:79:
+	case U32: return (u32)x > (u32)y ? (u32)x : (u32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#227: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:80:
+	case S64: return (s64)x > (s64)y ? (s64)x : (s64)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#228: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:81:
+	case S32: return (s32)x > (s32)y ? (u32)(s32)x : (u32)(s32)y;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#229: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:82:
+	default: printf("max_t!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'max_t', this function's name, in a string
#229: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:82:
+	default: printf("max_t!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#240: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:93:
+	default: printf("t_str!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_str', this function's name, in a string
#240: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:93:
+	default: printf("t_str!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#251: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:104:
+	default: printf("t_is_32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_is_32', this function's name, in a string
#251: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:104:
+	default: printf("t_is_32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#262: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:115:
+	default: printf("t_signed!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_signed', this function's name, in a string
#262: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:115:
+	default: printf("t_signed!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#273: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:126:
+	default: printf("t_unsigned!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 't_unsigned', this function's name, in a string
#273: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:126:
+	default: printf("t_unsigned!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#284: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:137:
+	default: printf("num_is_small!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'num_is_small', this function's name, in a string
#284: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:137:
+	default: printf("num_is_small!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#298: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:151:
+		default: printf("snprintf_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'snprintf_num', this function's name, in a string
#298: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:151:
+		default: printf("snprintf_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#338: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:191:
+		default: printf("snprintf_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'snprintf_num', this function's name, in a string
#338: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:191:
+		default: printf("snprintf_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#385: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:238:
+	default: printf("unkn_subreg!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'unkn_subreg', this function's name, in a string
#385: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:238:
+	default: printf("unkn_subreg!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#396: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:249:
+	default: printf("range!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range', this function's name, in a string
#396: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:249:
+	default: printf("range!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#453: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:306:
+	default: printf("range_cast_u64!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_u64', this function's name, in a string
#453: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:306:
+	default: printf("range_cast_u64!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#475: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:328:
+	default: printf("range_cast_s64!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_s64', this function's name, in a string
#475: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:328:
+	default: printf("range_cast_s64!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#492: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:345:
+	default: printf("range_cast_u32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_u32', this function's name, in a string
#492: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:345:
+	default: printf("range_cast_u32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#509: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:362:
+	default: printf("range_cast_s32!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast_s32', this function's name, in a string
#509: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:362:
+	default: printf("range_cast_s32!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#525: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:378:
+	default: printf("range_cast!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'range_cast', this function's name, in a string
#525: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:378:
+	default: printf("range_cast!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#536: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:389:
+	default: printf("is_valid_num!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'is_valid_num', this function's name, in a string
#536: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:389:
+	default: printf("is_valid_num!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#550: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:403:
+	default: printf("is_valid_range!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'is_valid_range', this function's name, in a string
#550: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:403:
+	default: printf("is_valid_range!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#605: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:458:
+	default: printf("complement_op!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'complement_op', this function's name, in a string
#605: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:458:
+	default: printf("complement_op!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#618: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:471:
+	default: printf("op_str!\n"); exit(1);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'op_str', this function's name, in a string
#618: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:471:
+	default: printf("op_str!\n"); exit(1);

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#637: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:490:
+	default: printf("range_canbe op %d\n", op); exit(1);					\

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#642: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:495:
+	case U64: { range_canbe(u64); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#643: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:496:
+	case U32: { range_canbe(u32); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#644: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:497:
+	case S64: { range_canbe(s64); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#645: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:498:
+	case S32: { range_canbe(s32); }

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#646: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:499:
+	default: printf("range_canbe!\n"); exit(1);

WARNING:LINE_SPACING: Missing a blank line after declarations
#953: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:806:
+	struct bpf_insn insns[64];
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1034: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:887:
+	case OP_LT: op_code = spec.compare_signed ? BPF_JSLT : BPF_JLT; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1035: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:888:
+	case OP_LE: op_code = spec.compare_signed ? BPF_JSLE : BPF_JLE; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1036: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:889:
+	case OP_GT: op_code = spec.compare_signed ? BPF_JSGT : BPF_JGT; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1037: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:890:
+	case OP_GE: op_code = spec.compare_signed ? BPF_JSGE : BPF_JGE; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1038: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:891:
+	case OP_EQ: op_code = BPF_JEQ; break;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#1039: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:892:
+	case OP_NE: op_code = BPF_JNE; break;

WARNING:BRACES: braces {} are not necessary for single statement blocks
#1173: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1026:
+		for (t = MIN_T; t <= MAX_T; t++) {
+			reg->r[t] = range(t, sval, sval);
+		}

WARNING:SPLIT_STRING: quoted string split across lines
#1540: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1393:
+			fprintf(env.stdout, "PROGRESS: %d/%d (%.2lf%%), "
+					    "elapsed %llu mins (%.2lf hrs), "

WARNING:SPLIT_STRING: quoted string split across lines
#1541: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1394:
+					    "elapsed %llu mins (%.2lf hrs), "
+					    "ETA %.0lf mins (%.2lf hrs)\n",

WARNING:BRACES: braces {} are not necessary for single statement blocks
#1619: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1472:
+		for (j = 0; j < ARRAY_SIZE(lower_seeds); j++) {
+			uvals[cnt++] = (((u64)upper_seeds[i]) << 32) | lower_seeds[j];
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#1655: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1508:
+	for (i = 0; i < ARRAY_SIZE(lower_seeds); i++) {
+		usubvals[cnt++] = lower_seeds[i];
+	}

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1764: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1617:
+	for (i = 0; i < val_cnt; i++)
+	for (j = 0; j < range_cnt; j++)

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1765: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1618:
+	for (j = 0; j < range_cnt; j++)
+	for (cond_t = MIN_T; cond_t <= MAX_T; cond_t++) {

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1785: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1638:
+	for (i = 0; i < subval_cnt; i++)
+	for (j = 0; j < subrange_cnt; j++)

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#1786: FILE: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1639:
+	for (j = 0; j < subrange_cnt; j++)
+	for (cond_t = MIN_T; cond_t <= MAX_T; cond_t++) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

