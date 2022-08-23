Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF159EDEF
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiHWVEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiHWVEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 17:04:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9102C121;
        Tue, 23 Aug 2022 14:03:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so13891345plo.10;
        Tue, 23 Aug 2022 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=cHRKNBYKG3xOANZ6kQFhVpqVJ5L+ueZJ9Jdjp1L40rk=;
        b=E3+WEPxKj4HxRkV70dmExf/Tz2+s9dV7G4PaLZIsgQkCjPruXMnKR2eIYwO2iHBVI6
         qntA+JylLJLA9n/AdZclpvxps3wRZNn6xQjDzrMtIQDYzFlsnIDD2MDgxx9Fznv5y1Ri
         hizD601ZaUzj24mAxL3iYNmAtaK3y6MuIZxJdX8nq6Kftzq47lKKE3gyyXYvK6aqHIXS
         9pfT98oxI+yEeaXW4hE2e0tUYZFom3KkIlzOCVQz82eF8KSnjVxw9LDaWD7uRTdyABNI
         gZAadCTkPXL+uZRpViiIF6pqXSQ9HpB2D2A8vbSiOtXyoOqCj24o5izy4JVDjf0FVYAr
         kukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=cHRKNBYKG3xOANZ6kQFhVpqVJ5L+ueZJ9Jdjp1L40rk=;
        b=ZKgyGJTEC9O7JGxFKnLTckUdPlPF13/jnKrvW/sJFfZAcByxdW4wBGlcpjWgbYzDU5
         1KG53Eg/Ef480W9bo2sURj9HeciEi5KZS+G9yEmVW+9no6xIAVFO0d4I1Hr8Lr/6JJvR
         iqv9FGngZq97Mii6lAsoe1vDW2+3hCJggMB31I36HNRFOMY0JHQGifRRFCuTXDE8ZHCi
         pYcY7dYddV6jk733FlPjKx4pDnDzdGRwc24iQ0Sg5tIP0Iv09R9P/0ajcA13O7+Bzqqt
         IcRV1vO9e0M394eOlchz0Ik6ml7RJnp8Ahk/sf9scIHEpyUlIR3XvH5KjX3PtMnmF7Jz
         dNAQ==
X-Gm-Message-State: ACgBeo0x5rXVHcjmq/ydLfcJLLEIqVSWF3LRDt2LDBWuqepgbJ1AoNh0
        sWKikre4OsQ1urB0o51sBbw=
X-Google-Smtp-Source: AA6agR67hhYfAwhqhOZCJYEOZFHAw67F6AN1sn1ho3gkR0V3iW1cuIAlaltrsb9wzAhaLGwaLYSR7w==
X-Received: by 2002:a17:90a:4805:b0:1f5:39ab:29a9 with SMTP id a5-20020a17090a480500b001f539ab29a9mr4929745pjh.202.1661288637690;
        Tue, 23 Aug 2022 14:03:57 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:c356:cd91:38b5:bb7])
        by smtp.gmail.com with ESMTPSA id e62-20020a621e41000000b0052da33fe7d2sm11485603pfe.95.2022.08.23.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 14:03:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Date:   Tue, 23 Aug 2022 14:03:54 -0700
Message-Id: <20220823210354.1407473-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
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

The helper is for BPF programs attached to perf_event in order to read
event-specific raw data.  I followed the convention of the
bpf_read_branch_records() helper so that it can tell the size of
record using BPF_F_GET_RAW_RECORD flag.

The use case is to filter perf event samples based on the HW provided
data which have more detailed information about the sample.

Note that it only reads the first fragment of the raw record.  But it
seems mostly ok since all the existing PMU raw data have only single
fragment and the multi-fragment records are only for BPF output attached
to sockets.  So unless it's used with such an extreme case, it'd work
for most of tracing use cases.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I don't know how to test this.  As the raw data is available on some
hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
rejected by the verifier.  Actually it needs a bpf_perf_event_data
context so that's not an option IIUC.

 include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..af7f70564819 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5355,6 +5355,23 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		raw record associated to *ctx* and store it in the buffer
+ *		pointed by *buf* up to size *size* bytes.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
+ *		instead return the number of bytes required to store the raw
+ *		record. If this flag is set, *buf* may be NULL.
+ *
+ *		**-EINVAL** if arguments invalid or **size** not a multiple
+ *		of **sizeof**\ (u64\ ).
+ *
+ *		**-ENOENT** if the event does not have raw records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5566,6 +5583,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(read_raw_record),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -5749,6 +5767,11 @@ enum {
 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
 };
 
+/* BPF_FUNC_read_raw_record flags. */
+enum {
+	BPF_F_GET_RAW_RECORD_SIZE	= (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..db172b12e5f8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/perf_event.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1532,6 +1533,44 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.arg4_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_read_raw_record, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct perf_raw_record *raw = ctx->data->raw;
+	struct perf_raw_frag *frag;
+	u32 to_copy;
+
+	if (unlikely(flags & ~BPF_F_GET_RAW_RECORD_SIZE))
+		return -EINVAL;
+
+	if (unlikely(!raw))
+		return -ENOENT;
+
+	if (flags & BPF_F_GET_RAW_RECORD_SIZE)
+		return raw->size;
+
+	if (!buf || (size % sizeof(u32) != 0))
+		return -EINVAL;
+
+	frag = &raw->frag;
+	WARN_ON_ONCE(!perf_raw_frag_last(frag));
+
+	to_copy = min_t(u32, frag->size, size);
+	memcpy(buf, frag->data, to_copy);
+
+	return to_copy;
+}
+
+static const struct bpf_func_proto bpf_read_raw_record_proto = {
+	.func           = bpf_read_raw_record,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type      = ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1548,6 +1587,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_read_branch_records_proto;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_pe;
+	case BPF_FUNC_read_raw_record:
+		return &bpf_read_raw_record_proto;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
-- 
2.37.2.609.g9ff673ca1a-goog

