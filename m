Return-Path: <bpf+bounces-391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB747005B5
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED36F281B3B
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A95AD507;
	Fri, 12 May 2023 10:34:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB6AD57
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:34:55 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBD13848
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3063208beedso9313871f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683887649; x=1686479649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMbB3rUKr4BJ9Y1bRCvT0+9HIM59fAt1h5Xo/nKUPv4=;
        b=Uj3pso/Eayo7KRB5BgEY/pQdMWehWmqU7frzwSVuYUMrofP//oKvuC5zzOh0uBxMKB
         mBdE08WGIYHWG4NjdozigFfh64aq91VEd+nMboC13Yt87cBVJ9faurkpRG8xR+4DYk2M
         LsycLsHCwzhQujivFZvJuOz/8OamwSEaAGaR+Z2oWlbE3e3hzTDnuuc21lkYV1XLxcW8
         KgJr0YtzsjqMRPXdHe1yRlXNyBthedZYcDUiMUSmg48hTkC53p8s1zXvf3bPmbik39Xj
         tV2nmCJSIhBiBYrbVF3c5QqyUBjtzb0V0Z94jjieToHo/qiLdXqmQyd9lW+7B1MClSmI
         pNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887649; x=1686479649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMbB3rUKr4BJ9Y1bRCvT0+9HIM59fAt1h5Xo/nKUPv4=;
        b=BbNHWicSnXrcC60pvWYKtX1FAJmRknID+u6zR2sVzLG2YX0gvBhurZRBikf2wKghyP
         HHFVUt3bOlo1cgKBQgK5qUUlsEC/YtqCr4umCKh0SvoR1uWRqHHZATkVMRdb8nB81U0t
         cPVJ13UbOqxdmtzZFWYycGu4nRls1+zQuiuvTXE1HxnXuf5c1Y0qX586TJ/C9VOgi2ea
         QhjWhVfb0CPP84KAHT6AWD7X+QGdHhDPjuQ6Fo9wAf/aK3WSAZuOMZgXQAA9Uj+6LkMJ
         LHPBzyDDF+HEvUjB5nLgPNJy2f3NtYt3uAsqR57XRjle8Vr5VGp0FnA9pJYtwQEu7svj
         TSAw==
X-Gm-Message-State: AC+VfDw8ukWNvV7BOzsuM9rsMhlu3xAOWx+XJW11IB98IvL5b59K/VD/
	CVC3qUeQMn0EtQTlYRDsNrTxmw==
X-Google-Smtp-Source: ACHHUZ6eqgFzzfyx/ebDX6KljV6e6EeFX865Nmj1frO4+NFhJumo1ClpWmA6lyn7LT36n89NnJDzmg==
X-Received: by 2002:adf:fccb:0:b0:306:3899:ccbf with SMTP id f11-20020adffccb000000b003063899ccbfmr17483186wrs.14.1683887649515;
        Fri, 12 May 2023 03:34:09 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm17946320wrr.95.2023.05.12.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:34:09 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value to fix accessing its fields
Date: Fri, 12 May 2023 11:33:54 +0100
Message-Id: <20230512103354.48374-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512103354.48374-1-quentin@isovalent.com>
References: <20230512103354.48374-1-quentin@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Lobakin <alobakin@pm.me>

Fix the following error when building bpftool:

  CLANG   profiler.bpf.o
  CLANG   pid_iter.bpf.o
skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^

struct bpf_perf_event_value is being used in the kernel only when
CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
Define struct bpf_perf_event_value___local with the
`preserve_access_index` attribute inside the pid_iter BPF prog to
allow compiling on any configs. It is a full mirror of a UAPI
structure, so is compatible both with and w/o CO-RE.
bpf_perf_event_read_value() requires a pointer of the original type,
so a cast is needed.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 27 ++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index ce5b65e07ab1..2f80edc682f1 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -4,6 +4,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct bpf_perf_event_value___local {
+	__u64 counter;
+	__u64 enabled;
+	__u64 running;
+} __attribute__((preserve_access_index));
+
 /* map of perf event fds, num_cpu * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -15,14 +21,14 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } fentry_readings SEC(".maps");
 
 /* accumulated readings */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } accum_readings SEC(".maps");
 
 /* sample counts, one per cpu */
@@ -39,7 +45,7 @@ const volatile __u32 num_metric = 1;
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value *ptrs[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local *ptrs[MAX_NUM_MATRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
@@ -53,10 +59,10 @@ int BPF_PROG(fentry_XXX)
 	}
 
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
-		struct bpf_perf_event_value reading;
+		struct bpf_perf_event_value___local reading;
 		int err;
 
-		err = bpf_perf_event_read_value(&events, key, &reading,
+		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
 						sizeof(reading));
 		if (err)
 			return 0;
@@ -68,14 +74,14 @@ int BPF_PROG(fentry_XXX)
 }
 
 static inline void
-fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
+fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 {
-	struct bpf_perf_event_value *before, diff;
+	struct bpf_perf_event_value___local *before, diff;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
 	if (before && before->counter) {
-		struct bpf_perf_event_value *accum;
+		struct bpf_perf_event_value___local *accum;
 
 		diff.counter = after->counter - before->counter;
 		diff.enabled = after->enabled - before->enabled;
@@ -93,7 +99,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
 SEC("fexit/XXX")
 int BPF_PROG(fexit_XXX)
 {
-	struct bpf_perf_event_value readings[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local readings[MAX_NUM_MATRICS];
 	u32 cpu = bpf_get_smp_processor_id();
 	u32 i, zero = 0;
 	int err;
@@ -102,7 +108,8 @@ int BPF_PROG(fexit_XXX)
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
 		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
-						readings + i, sizeof(*readings));
+						(void *)(readings + i),
+						sizeof(*readings));
 		if (err)
 			return 0;
 	}
-- 
2.34.1


