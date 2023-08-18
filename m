Return-Path: <bpf+bounces-8054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C97807EB
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2515D281D19
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EED182C5;
	Fri, 18 Aug 2023 09:02:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EA182BD;
	Fri, 18 Aug 2023 09:02:13 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF243C0C;
	Fri, 18 Aug 2023 02:01:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc3d94d40fso5587725ad.3;
        Fri, 18 Aug 2023 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349310; x=1692954110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEdCdiPpMNFfDPKVrW4rvndg+m3lfoeDTBZC/Rf1A+E=;
        b=g6I+KP+fbsBxcLLRNdgxN1Yg/swl1XiRKIlNajh8ZcVL8TAigeyYiHFglOoxpAJuGu
         EdQ74cuS1CVjWpX/b3EY3wvHSbPX6lccnIo4Txp83ySSEyKHPj7FJfgS3gNCMJ3etn0k
         i4QdPqd/nhsiZRY0q/JRt0QCuvO971Lfdp7WfjLhVp376D/q+h/sMUPQYObsgTeDhUE3
         0cLdyxdbZgjycfZe1Jqudy1GNqzY7HCgkTAl2TFtP61Qmm1yvrQxD7AiBOXHL4NkAg9Z
         uGV9VJ4DmU2SP3iUHY2wUrzEmD1Oegb5gQt24oZHkljnukFKrrlAMx51RLY3Qch7Rp8K
         9V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349310; x=1692954110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEdCdiPpMNFfDPKVrW4rvndg+m3lfoeDTBZC/Rf1A+E=;
        b=LnCH/CotUJFJ3uesogwnyuizv2lAnyGB6sGL+6SVVQ3gaL0IlSXsD8tu74PiRILHDy
         +ZuXfkNDVQMFq8K9nlup3HaA1VTcd/YlBzYF3TlQ4ga69KUBCwkVUK9ia2xs448fIIXC
         yXma8y7cLrQTsGTIXJuCHm6XHUTcTUZYeFZjPmtX6o6NUnZ/Wnj2YvHjWAr4GyoVwPZM
         e1N6fri+HGvgVwNVZKQ6jqbpHEIKDLX7VZ/SJIuotgrL2qSBQQrCPJWb8550CbnokRiw
         D1ck6Fl/5ZImABlR3LYXefRU5JI/iNhuJrAL7wULiJkA9/tNf6dyLTxLC9wQ/SinTR3f
         33eg==
X-Gm-Message-State: AOJu0Yz1pWq7Q2ggUOpRoxrcOVflhKDI1igF28sgOgK/MBw1hAfUKam1
	l5SqzI325V3obQsX8P/aoA==
X-Google-Smtp-Source: AGHT+IFIQLB92lb8IM8DCXjuimWo3DdFYmTPBxeWk0u/kyYHhSrWL07SkLn5G+Sijm7Dhif2f7Dhdw==
X-Received: by 2002:a17:902:f545:b0:1bb:7f71:df43 with SMTP id h5-20020a170902f54500b001bb7f71df43mr2325897plf.34.1692349309755;
        Fri, 18 Aug 2023 02:01:49 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:49 -0700 (PDT)
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
Subject: [bpf-next 6/9] samples/bpf: fix bio latency check with tracepoint
Date: Fri, 18 Aug 2023 18:01:16 +0900
Message-Id: <20230818090119.477441-7-danieltimlee@gmail.com>
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

Recently, a new tracepoint for the block layer, specifically the
block_io_start/done tracepoints, was introduced in commit 5a80bd075f3b
("block: introduce block_io_start/block_io_done tracepoints").

Previously, the kprobe entry used for this purpose was quite unstable
and inherently broke relevant probes [1]. Now that a stable tracepoint
is available, this commit replaces the bio latency check with it.

One of the changes made during this replacement is the key used for the
hash table. Since 'struct request' cannot be used as a hash key, the
approach taken follows that which was implemented in bcc/biolatency [2].
(uses dev:sector for the key)

[1]: https://github.com/iovisor/bcc/issues/4261
[2]: https://github.com/iovisor/bcc/pull/4691

Fixes: 450b7879e345 ("block: move blk_account_io_{start,done} to blk-mq.c")
Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/tracex3.bpf.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/tracex3.bpf.c b/samples/bpf/tracex3.bpf.c
index 7cc60f10d2e5..41f37966f5f5 100644
--- a/samples/bpf/tracex3.bpf.c
+++ b/samples/bpf/tracex3.bpf.c
@@ -9,6 +9,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct start_key {
+	dev_t dev;
+	u32 _pad;
+	sector_t sector;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, long);
@@ -16,16 +22,17 @@ struct {
 	__uint(max_entries, 4096);
 } my_map SEC(".maps");
 
-/* kprobe is NOT a stable ABI. If kernel internals change this bpf+kprobe
- * example will no longer be meaningful
- */
-SEC("kprobe/blk_mq_start_request")
-int bpf_prog1(struct pt_regs *ctx)
+/* from /sys/kernel/tracing/events/block/block_io_start/format */
+SEC("tracepoint/block/block_io_start")
+int bpf_prog1(struct trace_event_raw_block_rq *ctx)
 {
-	long rq = PT_REGS_PARM1(ctx);
 	u64 val = bpf_ktime_get_ns();
+	struct start_key key = {
+		.dev = ctx->dev,
+		.sector = ctx->sector
+	};
 
-	bpf_map_update_elem(&my_map, &rq, &val, BPF_ANY);
+	bpf_map_update_elem(&my_map, &key, &val, BPF_ANY);
 	return 0;
 }
 
@@ -47,21 +54,26 @@ struct {
 	__uint(max_entries, SLOTS);
 } lat_map SEC(".maps");
 
-SEC("kprobe/__blk_account_io_done")
-int bpf_prog2(struct pt_regs *ctx)
+/* from /sys/kernel/tracing/events/block/block_io_done/format */
+SEC("tracepoint/block/block_io_done")
+int bpf_prog2(struct trace_event_raw_block_rq *ctx)
 {
-	long rq = PT_REGS_PARM1(ctx);
+	struct start_key key = {
+		.dev = ctx->dev,
+		.sector = ctx->sector
+	};
+
 	u64 *value, l, base;
 	u32 index;
 
-	value = bpf_map_lookup_elem(&my_map, &rq);
+	value = bpf_map_lookup_elem(&my_map, &key);
 	if (!value)
 		return 0;
 
 	u64 cur_time = bpf_ktime_get_ns();
 	u64 delta = cur_time - *value;
 
-	bpf_map_delete_elem(&my_map, &rq);
+	bpf_map_delete_elem(&my_map, &key);
 
 	/* the lines below are computing index = log10(delta)*10
 	 * using integer arithmetic
-- 
2.34.1


