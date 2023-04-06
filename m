Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC26DA45D
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDFVGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFVGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D67683;
        Thu,  6 Apr 2023 14:06:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so38592683plb.12;
        Thu, 06 Apr 2023 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815177; x=1683407177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ3pP06/vkhTaryl+NLjH5tImeyj0o8TuktuLvogXTQ=;
        b=J0OSbxA45dv3BUhE6KsxYmllTmH7ivCr2Ee8Fn/cQtIk3VXC/p4+42kd9bohqzPWVa
         j1OL5n33OkXr9qoMN2YKGwpBKAUnIb19Z+zHziZddNwUWXc5oQzRkcL5dVW/TOdbDqyx
         o7DUcn0AMFMVVquO+8HhoQfQHprTg6ioKqdaQQfPxxwbdVAdAkhEzvqk6ANUAbRCUgk7
         iDZ02bvbf/rROuDkrPGBV4Eu3W/Xm5IaBaNY/dm4ZuwTIFABTJGsC6l2e8HLzbf43Iyu
         nxyzfOtk8V7iyuZU1zI1i1maGnBnGzF6miq6JUY7ICqNHEbya+uZOsK6+bbP92eVE8BK
         AN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815177; x=1683407177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQ3pP06/vkhTaryl+NLjH5tImeyj0o8TuktuLvogXTQ=;
        b=IVmdY4it2YgE5n5UtfNUB4QsTsbx7hR2D3trJtXJipJmXNZH7j6d7lNjPrnJAlKhAD
         CwNb0F0u2DWiEdX0yG8vYhvjgEY4nFld3jlUHxmbXg0Chj6BNWzhujc8vgXTPfcphcwR
         AynXlO9jqMiUo0Q6SiX5oQOu7wSNqzipKjeTpIVCEnNVBwT2QaKTDTUo9PuFfs5VxDKL
         oVS9as0Cb7W7jRV25s9vSKOD5w7iu9AbrfPJEr0CPKQhSOGjnQy7Jen4YAwWY9ADleqR
         /66GyAqQNbzPidNoCGa31Vxg8JLydD+npL287NtOUOSVFXC5APPu40Djne+cA8b/YCUr
         vggQ==
X-Gm-Message-State: AAQBX9ee3Yr3RJgbHAx5bJOjLqwKQHh1ky+VGJpVrNdf5HXAbZT1Z1vq
        SXEngcwxybCRXtleNKAMtks=
X-Google-Smtp-Source: AKy350YOjUfdcnsjqf+TP1sVZ4kWr7vIbNmeF513W2HYDOvcepZSYYh1e1yJx+UqlvwEG2L7D9gtbw==
X-Received: by 2002:a17:902:c613:b0:1a1:b440:3773 with SMTP id r19-20020a170902c61300b001a1b4403773mr409103plr.27.1680815176746;
        Thu, 06 Apr 2023 14:06:16 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:16 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/7] perf lock contention: Use -M for --map-nr-entries
Date:   Thu,  6 Apr 2023 14:06:06 -0700
Message-Id: <20230406210611.1622492-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Users often want to change the map size, let's add a short option (-M)
for that.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt | 1 +
 tools/perf/builtin-lock.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 37aae194a2a1..b5e5d088d51c 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -155,6 +155,7 @@ CONTENTION OPTIONS
 --tid=<value>::
         Record events on existing thread ID (comma separated list).
 
+-M::
 --map-nr-entries=<value>::
 	Maximum number of BPF map entries (default: 10240).
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 695ce6bd64f7..ef56bf90058d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2294,7 +2294,7 @@ int cmd_lock(int argc, const char **argv)
 		   "Trace on existing process id"),
 	OPT_STRING(0, "tid", &target.tid, "tid",
 		   "Trace on existing thread id (exclusive to --pid)"),
-	OPT_CALLBACK(0, "map-nr-entries", &bpf_map_entries, "num",
+	OPT_CALLBACK('M', "map-nr-entries", &bpf_map_entries, "num",
 		     "Max number of BPF map entries", parse_map_entry),
 	OPT_CALLBACK(0, "max-stack", &max_stack_depth, "num",
 		     "Set the maximum stack depth when collecting lopck contention, "
-- 
2.40.0.577.gac1e443424-goog

