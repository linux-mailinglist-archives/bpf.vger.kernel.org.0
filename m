Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140B05B14C6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiIHGiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 02:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIHGiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 02:38:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE15C59C9;
        Wed,  7 Sep 2022 23:38:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1374268pjh.3;
        Wed, 07 Sep 2022 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=ejkeCXq6weG9XOFKJtIPiuPMVIfy3kaHlllbgNPcMHo=;
        b=jvk02Sd6LWDcLrSGxtyVyRXDiX308iJXu9xgUdMBWKFRZcYndUnbffhXpMd/UCB74z
         UtO+dqkA4NMchvn2LKNbXLncZu1rSc0M814Yk1F0V8UWj8pfCNNApRl44tNCqx2amjSP
         0ovToD/EElFWb6Rcg+n6NSG9PDR8NSUDvK0EbJy00QQoyjxqWVIXq/LNcJJtdGaz+gXm
         hrfUnWN+e4rZjGjDH7tLuCWEWB1wVctsBTsgZmYw+KEGOlCljJr1Bx3OXGLoPxE3xWVw
         Trzib5uPpGFgBCXMxRbfp7yg6SuzqOqA/j0qb9AHfEQ/VrQo8kYKFRPovQ7mdf3DkVGb
         vcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ejkeCXq6weG9XOFKJtIPiuPMVIfy3kaHlllbgNPcMHo=;
        b=iUS2ZgXaC1dk6o8R0arcXGNyaCJCP888+Rk9m9ge4QYJ/eSEdGuf+TTZe+UqJ7QxAf
         SCmPNYdBC2ETS1HNnWek/FniG1G5uHa1pxA4myIwmVIfpjvf7UptMY+lznrohQRpMUQE
         WS99tV3J+d7+/J3RpMHX4ashR7x97kVEtdjEYMOtE9I6rBhpQ6R/+mV7dZmFc08FJIpa
         NuxEF2mV97FxCEb3BtFeqNwAlgzx1M4/xjVCq7NudvXaE6fe7F6UeMFqpPpCB1pCVjit
         vQIuVJTvYW42XJ+L9VMGe4ojkjPfhbIv28ie7eYO3AWWSBzeomve3jlr4WYBNpa3ZLuw
         3SFg==
X-Gm-Message-State: ACgBeo14UTYyyESvez2PckibE2iYR0+aT3ou1+gmnftTjMQIAJvJPWp0
        TrY8mREyJvU/4uJtRzm9BMY=
X-Google-Smtp-Source: AA6agR7+CSf6WyxxfU25l/GEhRlB2ckH2Ox6ikq0kZlWxLx8j5Quzfq6cJ4vZShbWtsgSkT6XZzTaw==
X-Received: by 2002:a17:903:110f:b0:171:3afa:e688 with SMTP id n15-20020a170903110f00b001713afae688mr7767234plh.162.1662619080242;
        Wed, 07 Sep 2022 23:38:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:7f21:d032:3f14:a4e6])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm890716pjo.47.2022.09.07.23.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:37:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 1/4] perf lock contention: Factor out get_symbol_name_offset()
Date:   Wed,  7 Sep 2022 23:37:51 -0700
Message-Id: <20220908063754.1369709-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908063754.1369709-1-namhyung@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
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

It's to convert addr to symbol+offset.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 70197c0593b1..2a5672f8d22e 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -902,6 +902,23 @@ bool is_lock_function(struct machine *machine, u64 addr)
 	return false;
 }
 
+static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
+				  char *buf, int size)
+{
+	u64 offset;
+
+	if (map == NULL || sym == NULL) {
+		buf[0] = '\0';
+		return 0;
+	}
+
+	offset = map->map_ip(map, ip) - sym->start;
+
+	if (offset)
+		return scnprintf(buf, size, "%s+%#lx", sym->name, offset);
+	else
+		return strlcpy(buf, sym->name, size);
+}
 static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
 				  char *buf, int size)
 {
@@ -944,15 +961,8 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 
 		sym = node->ms.sym;
 		if (sym && !is_lock_function(machine, node->ip)) {
-			struct map *map = node->ms.map;
-			u64 offset;
-
-			offset = map->map_ip(map, node->ip) - sym->start;
-
-			if (offset)
-				scnprintf(buf, size, "%s+%#lx", sym->name, offset);
-			else
-				strlcpy(buf, sym->name, size);
+			get_symbol_name_offset(node->ms.map, sym, node->ip,
+					       buf, size);
 			return 0;
 		}
 
-- 
2.37.2.789.g6183377224-goog

