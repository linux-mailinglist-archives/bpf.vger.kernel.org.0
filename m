Return-Path: <bpf+bounces-8055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A677B7807ED
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91751C20CD0
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3E182D9;
	Fri, 18 Aug 2023 09:02:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0F15495;
	Fri, 18 Aug 2023 09:02:16 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1174212;
	Fri, 18 Aug 2023 02:01:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26b67b38b61so516580a91.0;
        Fri, 18 Aug 2023 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349314; x=1692954114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xh8zEASjOId61d0T5CzTHeLfy4NYBbHm3OIzjsyLyM=;
        b=garpmHfp1NZCFs/JGbYM/LzyY6xj24XU1oIHsUXC4RWhiqbioDh0610x+iB6nmPMqR
         xRQdZ9yMIXi2Mf+LIFDH3DbnIYKl0VMpVUr0DNYVrkZoKhhyHCV0Yl4Ew6hN6MjS+UUb
         4mW2oaQlb3EzDeJmznB3tcrVA4YQtI6wM0+iEI8ObbsL8Ke1FSK6iyK+EH8lZIGfVAwK
         JRuOCbTHB0yw/oRkYCc/q9AEQopMh0aJwLBN2eC13dkt5octs92N9zczWc6DMiMXcrTT
         PVDvCEwDR80mgQzpY4/g8MiB0FSGDJqlfuK15dpPMAt44qDP/z+Uy0NTUUSSJXArijlc
         bNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349314; x=1692954114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xh8zEASjOId61d0T5CzTHeLfy4NYBbHm3OIzjsyLyM=;
        b=XsWZ6nBNtOgb4jVpJDkZpKBiAmfNWGx5FR9b/NH7rFqYbcqnJx9H0y/xqOdrcLurXo
         LLZ9CVyIu6oXX3AsQVld5ptmj4ApiIbGDF/Eq51brV6oTnk94AdEYzFgpkWY8UKjZnpA
         7SvR/N7w05RFh6+zUzGPMmVIzucBqpNQQwuV8nlyYVo/+LDcuj26HpMPjWtk4aw6foiO
         /5hlzUM0K8c/ELavpTeSZhJrizrLr9mKGvb5rQnJGyW4eiN2lNda+WuyQAfspoYjH2v7
         7Rh3XjTc4OCfAcjkZj2Ve2utyYfHVf3BwcTNLsf3FVO6i/JNy9FC1Ww5Tae8Gz8P8znj
         xSZg==
X-Gm-Message-State: AOJu0YyMw/JlVgSbegNKzHXgPrbycUGJY8vmXT5BAspsP4Q11p9QTfYM
	NZ+/PO0jINTbB5p0K7FgYA==
X-Google-Smtp-Source: AGHT+IGN+3ucFRLwemRnZTvByU1P9GwVZMCEuN32TdWOIqDNxPrK00ULfaAkPhH/RoFQSU/OVUg0ow==
X-Received: by 2002:a17:90a:2e0b:b0:268:3f6d:9751 with SMTP id q11-20020a17090a2e0b00b002683f6d9751mr1804960pjd.23.1692349313682;
        Fri, 18 Aug 2023 02:01:53 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:53 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 7/9] samples/bpf: fix broken map lookup probe
Date: Fri, 18 Aug 2023 18:01:17 +0900
Message-Id: <20230818090119.477441-8-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the commit 7c4cd051add3 ("bpf: Fix syscall's stackmap lookup
potential deadlock"), a potential deadlock issue was addressed, which
resulted in *_map_lookup_elem not triggering BPF programs.
(prior to lookup, bpf_disable_instrumentation() is used)

To resolve the broken map lookup probe using "htab_map_lookup_elem",
this commit introduces an alternative approach. Instead, it utilize
"bpf_map_copy_value" and apply a filter specifically for the hash table
with map_type.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Fixes: 7c4cd051add3 ("bpf: Fix syscall's stackmap lookup potential deadlock")
---
 samples/bpf/tracex6.bpf.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/tracex6.bpf.c b/samples/bpf/tracex6.bpf.c
index 6ad82e68f998..9b23b4737cfb 100644
--- a/samples/bpf/tracex6.bpf.c
+++ b/samples/bpf/tracex6.bpf.c
@@ -1,6 +1,8 @@
 #include "vmlinux.h"
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -44,13 +46,24 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kprobe/htab_map_lookup_elem")
-int bpf_prog2(struct pt_regs *ctx)
+/*
+ * Since *_map_lookup_elem can't be expected to trigger bpf programs
+ * due to potential deadlocks (bpf_disable_instrumentation), this bpf
+ * program will be attached to bpf_map_copy_value (which is called
+ * from map_lookup_elem) and will only filter the hashtable type.
+ */
+SEC("kprobe/bpf_map_copy_value")
+int BPF_KPROBE(bpf_prog2, struct bpf_map *map)
 {
 	u32 key = bpf_get_smp_processor_id();
 	struct bpf_perf_event_value *val, buf;
+	enum bpf_map_type type;
 	int error;
 
+	type = BPF_CORE_READ(map, map_type);
+	if (type != BPF_MAP_TYPE_HASH)
+		return 0;
+
 	error = bpf_perf_event_read_value(&counters, key, &buf, sizeof(buf));
 	if (error)
 		return 0;
-- 
2.34.1


