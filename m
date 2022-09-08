Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE55B28AA
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIHVlN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIHVlM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 17:41:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5AB5A4C;
        Thu,  8 Sep 2022 14:41:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso3808642pjd.4;
        Thu, 08 Sep 2022 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=S6hyUSVNablbJH4TeRzqEa2ZTS0Xgv79KyI85GSi4Ec=;
        b=BPkeKoggarXSBWcrU2HhJ4+yxokvb3lNgQweDmuSOwTbvZ3SV3bFjXK4FoB6BB7+uk
         QY2NuFBTBPkbFJiwhJwSH0s1jw7io+cNrZYz6CXDr7Llpi4uDwJT2z4n8tkXmdWePFS/
         69mrlnFtKbP9d+PV/XHMtb6CEAZCcQNSLmokc9qfuHHKqGyKAdkXd+/rQbuGpi1bsRaR
         8mZcEUsDi2mwrjXeJWFQDAmefdouL1WbV5EHAzQcwvlfQfG9w86IWLQ71yB02GNGZOko
         8gsc1rM10S2qDWNLb0if3tGGUPmwKg0Kso0BTV3zGJqK1IVPWM5MwQcuonbkemkzay46
         eTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=S6hyUSVNablbJH4TeRzqEa2ZTS0Xgv79KyI85GSi4Ec=;
        b=RMoKYG5/8txB7zrj/xQPz6dY/CrxPfcZNhlHCa80Y1hX++SPBlpfQz32Dn8LpRJhS/
         QO3wWZWyTQvmFmf3sXKRHZ3UIQQgeF3DZoFdAxR7uSmOyX8izn2VuiKIio/4w5ic32YO
         KMBSpLAmC3qMwRcyjJ+PuItLA6j+OkPm5/9l3dKl2h385QxAg22on6TrJN1LSw6QmyA9
         aIZgnvQBTX0NpKjftD94EWofolqynHgWXBWSQvOqNX2qFSnacjasBCPD5dUG7nuvzQr8
         Wht/gQ5Ex+TSzcypVMAsbFWnQAwOukgH43CgN6OI7B0q53eJxeqvXQPrcsUzjxWtFBs8
         8VwA==
X-Gm-Message-State: ACgBeo0h4hvijFHicapEBD6PEM4SOaFQg+MFU4B0xPNafi2GEVpo4ObS
        rKRTuajxHeXFOnJOLc1MSCg=
X-Google-Smtp-Source: AA6agR6C8pjHvJeNC2zbjYy3SEOAFdBBKgYVdsY++qQ4HNFJRo+ew6iWrKzr8nWGOGnp2UwQPu3N3Q==
X-Received: by 2002:a17:902:820f:b0:176:9654:354d with SMTP id x15-20020a170902820f00b001769654354dmr10798288pln.79.1662673271287;
        Thu, 08 Sep 2022 14:41:11 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id d28-20020aa797bc000000b00540d75197e5sm90435pfq.47.2022.09.08.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:41:10 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 3/3] perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY
Date:   Thu,  8 Sep 2022 14:41:04 -0700
Message-Id: <20220908214104.3851807-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908214104.3851807-1-namhyung@kernel.org>
References: <20220908214104.3851807-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's no in-tree user anymore.  Let's get rid of it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c       | 10 ----------
 arch/x86/events/intel/core.c    |  3 ---
 include/uapi/linux/perf_event.h |  2 --
 3 files changed, 15 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index dab094166693..ce5720bfb350 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -300,16 +300,6 @@ static int perf_ibs_init(struct perf_event *event)
 	hwc->config_base = perf_ibs->msr;
 	hwc->config = config;
 
-	/*
-	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
-	 * recorded as part of interrupt regs. Thus we need to use rip from
-	 * interrupt regs while unwinding call stack. Setting _EARLY flag
-	 * makes sure we unwind call-stack before perf sample rip is set to
-	 * IbsOpRip.
-	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
-
 	return 0;
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ba101c28dcc9..fcd43878a24d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3846,9 +3846,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
-
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index dca16582885f..e639c74cf5fb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -164,8 +164,6 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
 
 	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
-
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
-- 
2.37.2.789.g6183377224-goog

