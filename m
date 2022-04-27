Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F765511337
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359328AbiD0IIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359282AbiD0IH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98B15C3AE;
        Wed, 27 Apr 2022 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651046677; x=1682582677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=23kSWxJrZI80+FxhewCBs4Zt/CG0UV6J7Lqk+S2dTCo=;
  b=FQUpsRpWZrqkR8YQwusf527oQaJraTOGDNswl+9R2qesjguVymGCdb81
   MK3l5J416F20t+vyn3y5b3R3UN2VanaGPqItL+PBuVYrChs0koZiOsFrw
   rmVoxojKyGMNZ1TbQo3L5Frdzv5CcEmgJGN//RHJCd919XfsYj+sCj4dT
   jMiZwrVBcHl+/+43AgFGS8NoO/UeM/4EQ5igGXAiPD9XUHulq87VlwUKQ
   ILx0id7A18zBDxkVzgWoSQQu6eb0uJAVDkG2xDSS+rUKyr9EIb+8d/YXP
   v2dXQzMLUYibTOwS2yDZMQIp6Z1QMYc+XOx25he9aYR39g5neRKjBsVxV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247784561"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247784561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="617405147"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2022 01:04:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njcf2-0004Uk-76;
        Wed, 27 Apr 2022 08:04:32 +0000
Date:   Wed, 27 Apr 2022 16:04:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: fix returnvar.cocci warnings
Message-ID: <Ymj5AJtiBx0UjEdT@8276d8ba1d54>
References: <202204271656.OTIj2QNJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204271656.OTIj2QNJ-lkp@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: kernel test robot <lkp@intel.com>

tools/lib/bpf/relo_core.c:1064:8-11: Unneeded variable: "len". Return "0" on line 1086


 Remove unneeded variable used to store return value.

Generated by: scripts/coccinelle/misc/returnvar.cocci

Fixes: b58af63aab11 ("libbpf: Refactor CO-RE relo human description formatting routine")
CC: Andrii Nakryiko <andrii@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   f02ac5c95dfd45d2f50ecc68d79177de326c668c
commit: b58af63aab11e4ae00fe96de9505759cfdde8ee9 [6746/7265] libbpf: Refactor CO-RE relo human description formatting routine
:::::: branch date: 2 hours ago
:::::: commit date: 9 hours ago

 tools/lib/bpf/relo_core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1061,7 +1061,7 @@ static int bpf_core_format_spec(char *bu
 	const struct btf_enum *e;
 	const char *s;
 	__u32 type_id;
-	int i, len = 0;
+	int i;
 
 #define append_buf(fmt, args...)				\
 	({							\
@@ -1083,7 +1083,7 @@ static int bpf_core_format_spec(char *bu
 		   type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
 
 	if (core_relo_is_type_based(spec->relo_kind))
-		return len;
+		return 0;
 
 	if (core_relo_is_enumval_based(spec->relo_kind)) {
 		t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
@@ -1091,7 +1091,7 @@ static int bpf_core_format_spec(char *bu
 		s = btf__name_by_offset(spec->btf, e->name_off);
 
 		append_buf("::%s = %u", s, e->val);
-		return len;
+		return 0;
 	}
 
 	if (core_relo_is_field_based(spec->relo_kind)) {
@@ -1110,10 +1110,10 @@ static int bpf_core_format_spec(char *bu
 			append_buf(" @ offset %u.%u)", spec->bit_offset / 8, spec->bit_offset % 8);
 		else
 			append_buf(" @ offset %u)", spec->bit_offset / 8);
-		return len;
+		return 0;
 	}
 
-	return len;
+	return 0;
 #undef append_buf
 }
 
