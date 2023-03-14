Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B06BA3B1
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCNXoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCNXnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12823D902;
        Tue, 14 Mar 2023 16:42:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v21so8160794ple.9;
        Tue, 14 Mar 2023 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUz9t3miV/6g18NoyX2KHMC0EiLYl+hvlFPuzWmCtsU=;
        b=XomfK7jyB3k61EfY5qAfnfRDEZ3ZWHdtMyzPh8jWVWzBgiVOnXqrV6fHKfDymD9WyU
         K4raOz7T4Frod+/HmNne94Kl42KqEQER5atLtKI7m+uIdVs6+skh2mioVGUhQtkgM4gN
         mUm/flgUHzBUNTQC6+mAgPfwVnVGI4re2n420OAylxucfbvWonrQheMYb6L3FCEYddov
         nqYUhc/ZraL6nw9+wqaJzqhwTAZIH9ATmgcHxVpri+HhhsKVlJUVP6v7fzuHAjU7d9V4
         I8+dJwwJ/yxP2QB77leav+cqL37eFVXdv0eJjk5CaSBMdInPmrmgimRbcTCvoQ1YXRuY
         BuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUz9t3miV/6g18NoyX2KHMC0EiLYl+hvlFPuzWmCtsU=;
        b=v/3RoHVnhJ6fI/WXB8fuXE3pSJ/xEe+jd4xD3xJ4epq6w1t7jZ3P+sBnN17apVonBx
         Tc61su07zPsB6bStjqQqSq/d4PMw+iasvXEsCPgRm/QWD+Q0I+xj74+qbZmpzOJMrg33
         oK71anQyMzBUEbMxYa4xH1NEbTQ5hlm2OTXuwil9ktGdozWpumNuAuZ+DJFpVSnN8iZO
         dYaSKk6h3Onio8MhzDfsSIbZtbBTRVAywWmoJQPZNaRh7HeR+PnexJaKWrgCpfwpsSoA
         fFSmOODiZOWkwII3bT16sKXoK7weE4Pr3LSz1fsHtks25ekxzfWvx3OkUdz0KRIIv5Iy
         EitQ==
X-Gm-Message-State: AO0yUKVaqscWIc/VEFEMXZu6+RoJZdFiJ1FQQqBuTxugq6ZKwztEWO+E
        joHGfNgRoqLyfTc3HiA9lyk=
X-Google-Smtp-Source: AK7set/lPJTrFbOOgl/ZD7hgiVjyoz/bxi1eJbzxhfRSZnVtMnMxLmIKpYVxzOJgRaTqqxjTxKEsLA==
X-Received: by 2002:a17:903:234a:b0:19f:3797:d8de with SMTP id c10-20020a170903234a00b0019f3797d8demr879742plh.9.1678837369104;
        Tue, 14 Mar 2023 16:42:49 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 07/10] perf bpf filter: Add data_src sample data support
Date:   Tue, 14 Mar 2023 16:42:34 -0700
Message-Id: <20230314234237.3008956-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The data_src has many entries to express memory behaviors.  Add each
term separately so that users can combine them for their purpose.

I didn't add prefix for the constants for simplicity as they are mostly
distinguishable but I had to use l1_miss and l2_hit for mem_dtlb since
mem_lvl has different values for the same names.  Note that I decided
mem_lvl to be used as an alias of mem_lvlnum as it's deprecated now.
According to the comment in the UAPI header, users should use the mix
of mem_lvlnum, mem_remote and mem_snoop.  Also the SNOOPX bits are
concatenated to mem_snoop for simplicity.

The following terms are used for data_src and the corresponding perf
sample data fields:

 * mem_op : { load, store, pfetch, exec }
 * mem_lvl: { l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem }
 * mem_snoop: { none, hit, miss, hitm, fwd, peer }
 * mem_remote: { remote }
 * mem_lock: { locked }
 * mem_dtlb { l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault }
 * mem_blk { by_data, by_addr }
 * mem_hops { hops0, hops1, hops2, hops3 }

We can now use a filter expression like below:

  'mem_op == load, mem_lvl <= l2, mem_dtlb == l1_hit'
  'mem_dtlb == l2_miss, mem_hops > hops1'
  'mem_lvl == ram, mem_remote == 1'

Note that 'na' is shared among the terms as it has the same value except
for mem_lvl.  I don't have a good idea to handle that for now.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.l                 | 61 ++++++++++++++++++++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 23 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 419f923b35c0..3e66b7a0215e 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -42,6 +42,12 @@ static int value(int base)
 	return BFT_NUM;
 }
 
+static int constant(int val)
+{
+	perf_bpf_filter_lval.num = val;
+	return BFT_NUM;
+}
+
 static int error(const char *str)
 {
 	printf("perf_bpf_filter: Unexpected filter %s: %s\n", str, perf_bpf_filter_text);
@@ -80,6 +86,15 @@ retire_lat	{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); } /* alias for we
 phys_addr	{ return sample(PERF_SAMPLE_PHYS_ADDR); }
 code_pgsz	{ return sample(PERF_SAMPLE_CODE_PAGE_SIZE); }
 data_pgsz	{ return sample(PERF_SAMPLE_DATA_PAGE_SIZE); }
+mem_op		{ return sample_part(PERF_SAMPLE_DATA_SRC, 1); }
+mem_lvlnum	{ return sample_part(PERF_SAMPLE_DATA_SRC, 2); }
+mem_lvl		{ return sample_part(PERF_SAMPLE_DATA_SRC, 2); } /* alias for mem_lvlnum */
+mem_snoop	{ return sample_part(PERF_SAMPLE_DATA_SRC, 3); } /* include snoopx */
+mem_remote	{ return sample_part(PERF_SAMPLE_DATA_SRC, 4); }
+mem_lock	{ return sample_part(PERF_SAMPLE_DATA_SRC, 5); }
+mem_dtlb	{ return sample_part(PERF_SAMPLE_DATA_SRC, 6); }
+mem_blk		{ return sample_part(PERF_SAMPLE_DATA_SRC, 7); }
+mem_hops	{ return sample_part(PERF_SAMPLE_DATA_SRC, 8); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
@@ -89,6 +104,52 @@ data_pgsz	{ return sample(PERF_SAMPLE_DATA_PAGE_SIZE); }
 "<="		{ return operator(PBF_OP_LE); }
 "&"		{ return operator(PBF_OP_AND); }
 
+na		{ return constant(PERF_MEM_OP_NA); }
+load		{ return constant(PERF_MEM_OP_LOAD); }
+store		{ return constant(PERF_MEM_OP_STORE); }
+pfetch		{ return constant(PERF_MEM_OP_PFETCH); }
+exec		{ return constant(PERF_MEM_OP_EXEC); }
+
+l1		{ return constant(PERF_MEM_LVLNUM_L1); }
+l2		{ return constant(PERF_MEM_LVLNUM_L2); }
+l3		{ return constant(PERF_MEM_LVLNUM_L3); }
+l4		{ return constant(PERF_MEM_LVLNUM_L4); }
+cxl		{ return constant(PERF_MEM_LVLNUM_CXL); }
+io		{ return constant(PERF_MEM_LVLNUM_IO); }
+any_cache	{ return constant(PERF_MEM_LVLNUM_ANY_CACHE); }
+lfb		{ return constant(PERF_MEM_LVLNUM_LFB); }
+ram		{ return constant(PERF_MEM_LVLNUM_RAM); }
+pmem		{ return constant(PERF_MEM_LVLNUM_PMEM); }
+
+none		{ return constant(PERF_MEM_SNOOP_NONE); }
+hit		{ return constant(PERF_MEM_SNOOP_HIT); }
+miss		{ return constant(PERF_MEM_SNOOP_MISS); }
+hitm		{ return constant(PERF_MEM_SNOOP_HITM); }
+fwd		{ return constant(PERF_MEM_SNOOPX_FWD); }
+peer		{ return constant(PERF_MEM_SNOOPX_PEER); }
+
+remote		{ return constant(PERF_MEM_REMOTE_REMOTE); }
+
+locked		{ return constant(PERF_MEM_LOCK_LOCKED); }
+
+l1_hit		{ return constant(PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT); }
+l1_miss		{ return constant(PERF_MEM_TLB_L1 | PERF_MEM_TLB_MISS); }
+l2_hit		{ return constant(PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT); }
+l2_miss		{ return constant(PERF_MEM_TLB_L2 | PERF_MEM_TLB_MISS); }
+any_hit		{ return constant(PERF_MEM_TLB_HIT); }
+any_miss	{ return constant(PERF_MEM_TLB_MISS); }
+walk		{ return constant(PERF_MEM_TLB_WK); }
+os		{ return constant(PERF_MEM_TLB_OS); }
+fault		{ return constant(PERF_MEM_TLB_OS); } /* alias for os */
+
+by_data		{ return constant(PERF_MEM_BLK_DATA); }
+by_addr		{ return constant(PERF_MEM_BLK_ADDR); }
+
+hops0		{ return constant(PERF_MEM_HOPS_0); }
+hops1		{ return constant(PERF_MEM_HOPS_1); }
+hops2		{ return constant(PERF_MEM_HOPS_2); }
+hops3		{ return constant(PERF_MEM_HOPS_3); }
+
 ","		{ return ','; }
 
 {ident}		{ return error("ident"); }
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index d930401c5bfc..88dbc788d257 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -70,6 +70,29 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return kctx->data->code_page_size;
 	case PERF_SAMPLE_DATA_PAGE_SIZE:
 		return kctx->data->data_page_size;
+	case PERF_SAMPLE_DATA_SRC:
+		if (entry->part == 1)
+			return kctx->data->data_src.mem_op;
+		if (entry->part == 2)
+			return kctx->data->data_src.mem_lvl_num;
+		if (entry->part == 3) {
+			__u32 snoop = kctx->data->data_src.mem_snoop;
+			__u32 snoopx = kctx->data->data_src.mem_snoopx;
+
+			return (snoopx << 5) | snoop;
+		}
+		if (entry->part == 4)
+			return kctx->data->data_src.mem_remote;
+		if (entry->part == 5)
+			return kctx->data->data_src.mem_lock;
+		if (entry->part == 6)
+			return kctx->data->data_src.mem_dtlb;
+		if (entry->part == 7)
+			return kctx->data->data_src.mem_blk;
+		if (entry->part == 8)
+			return kctx->data->data_src.mem_hops;
+		/* return the whole word */
+		return kctx->data->data_src.val;
 	default:
 		break;
 	}
-- 
2.40.0.rc1.284.g88254d51c5-goog

