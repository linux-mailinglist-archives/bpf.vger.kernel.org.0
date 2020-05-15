Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0861D467E
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 08:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEOG4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgEOG4e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 02:56:34 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E9C05BD0A
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 23:56:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r124so1273831qkf.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tvl7gLFsS/dAedcEqfrKtncclZsMityBUyr8g2OugcQ=;
        b=L1Pcz6gnqUzZkJrzhBUQp0QUfmzqMeD11Syg0lPwtZra+G6eYVcIwSdxLHbea30lMH
         VPEiAhP4to/UFfvAX0LAMJ1tyxOpktCcAdayUEcYBXl6F8VgXGGU/TEUYJ3y15A/3R5E
         YU6LMqnfuUcMQBUHHdnob6YvUNLUlY7ezab93T8g6Q4fi9fcQCkBISB+hhwPcYVCeE8R
         1CUJySRpZreY8cMtNlU8Cm6Tfuw8qoyN8n86PLRd4NRTktgnuecp7WTaCr2RQI8IQ5td
         cCkgS+2KoQy94ltW9Gy0mZAHyMKpiXB+4bjqQRJZt7KHphQ7+zuJxxd+VRgQ0t2PZ1MJ
         xouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tvl7gLFsS/dAedcEqfrKtncclZsMityBUyr8g2OugcQ=;
        b=FWSPE3AOa+a5aj4GDUoVcyjzsAptLIjXgOOSnlYIeJp/URhgrYr0yeRccDW7wmY8xA
         UVyKvyJrr4fisT+65ZX8uxD1YDVGWxkD48JBkfAaZUIfgayhtJ+KDELkuyWFu1c0lHwU
         KY30AiodtLSokbcB82qVJJEOcFMTOwuBGftgz6H99jY62gxFCHT5HB5YFkKYX7MkxW9P
         MPLCifzEFPNawJ/zZ2Z4w7OXLpdIkrBpm/M9OTBI1/J5H90jwXcBBfolYkWW6d6JAczX
         w5EuZ3EJLJjQdpMVd9N1JvbLfrfOh90B0XsAhjqWia2WhIrCQM0S8hwjNc1C7o7IBctI
         +Vnw==
X-Gm-Message-State: AOAM530nSUNAIOW3FXemnHHdEZ8gMOZN+H2H2OF8hIZiq+i25Hr1YD3+
        xp0jfJejVueABI6kPOMmUztEOY/U3sL4
X-Google-Smtp-Source: ABdhPJxDHoNPBj+Xy4XlruWwU/uTMdd15h3I5dMGic4z9Trd8Ynf0UfZutAZW27seEr+Fu0dO/wbEvgsqVcx
X-Received: by 2002:a0c:ac41:: with SMTP id m1mr2102104qvb.71.1589525792231;
 Thu, 14 May 2020 23:56:32 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:17 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-2-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 1/8] libbpf: Fix memory leak and possible double-free in hashmap__clear
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Alston Tang <alston64@fb.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Fix memory leak in hashmap_clear() not freeing hashmap_entry structs for each
of the remaining entries. Also NULL-out bucket list to prevent possible
double-free between hashmap__clear() and hashmap__free().

Running test_progs-asan flavor clearly showed this problem.

Reported-by: Alston Tang <alston64@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200429012111.277390-5-andriin@fb.com
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..cffb96202e0d 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,14 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	int bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+		free(cur);
+	}
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.26.2.761.g0e0b3e54be-goog

