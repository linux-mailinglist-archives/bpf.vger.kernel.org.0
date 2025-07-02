Return-Path: <bpf+bounces-62037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CCAF091A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3FA4A2B4D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FF1B423D;
	Wed,  2 Jul 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by6K9ged"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7629FC0A
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426268; cv=none; b=q/vFPyutTtUQnSuhjiv8evgNXqodPLZmRJnmgaUKXjyzrEpVS9K9AkgeGpv1twc2NT0LVczBlS0vy+pH4AgIk4fvg6asmQ/BfM19ma+AvhiYd1sz7Cif7yKLwOUSxUdT/PN72ms3W1UGv+NDr/TpQ50SDwLlW3R0S4fkVqZ/gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426268; c=relaxed/simple;
	bh=AI6q4JpYWdyYAt95InDEg0J7suQigoysjGatGbygY9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTPK58FWjwEroJVnjPZzrwvdYfttgIcj3kuaO41/nlsrHLK4CMBABOnU1I3ykg3ZqjHq202cYx3V0F6zoRpwy6AIjSgdKztbWJqdgkpGnfiyuelc0ZPqZuR8fxkFvzP2DgPTIgZg0tFNN1KhdvTvIB+ZWiA6hTK8KYw0NUH46W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by6K9ged; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0c4945c76so568078066b.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426265; x=1752031065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soMrPN4UavRpGFaPbDzAGIPjIEIqaloYu/K7TMiwe64=;
        b=by6K9gedzR8Awg36hs7SJq9dE9AwS37ZX7dgYO4blTdER2nQmQDZgyVRq2Pl/P9xkQ
         yb9/www3ebRJCMBEdokRIBKIuumdGIi5nS8TvNo5w2VFkJg4QaNaEPWQGv8ed8QKkpiu
         Uj/rUJyOLrkCgGIJvTmmgftLahow1MJzzOOJrTBpQMurHcPtDkE26PkhnsU7rNuMxoEm
         HVwxAlZSx+6buupEVDZvq0MQ8ujp9Oc1yR0PaJ1LwXVO81xVmKnHBzivb2kOjNBPXbG5
         pXIhgaLg+JOvncyoH7Ft1sYGr95Y9wOYFaYrXOD4iyYbQKrYL7KVaeT+kIGb0Y0/c2SA
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426265; x=1752031065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soMrPN4UavRpGFaPbDzAGIPjIEIqaloYu/K7TMiwe64=;
        b=wkRY5xXXidsxgN0D4AShl7+VcU2vez70UOW+h0vmgFEZMebz4PtU2n3r0/KRhMKlio
         +wB0XP11ezTiOVS6cWu2i2fAULvBxSe5CjpMIpq6xTCJd4tsFH0CALLit/lK+M9WJ8SB
         PMDjzbzuowOeBPOTOOqEmiEZ0akC7sGgaUQv/rzURTkGOzGpNI/UuXh3cfTX9+pcM1eo
         F/0prfiYhrMB7AiKOE0GDoJB+6bQnon/YUdu7we8LivSb0Y4eL5ZsDzss5VCExcWbUld
         Pn65urigr0itpkyaZMVBSl7ulDKMjnf6wkLW2YK0lbnAl4DM331JbW3GEUr5qcRL40yP
         F3Hg==
X-Gm-Message-State: AOJu0YwxTHzsXvht6pf23M1/+Az5gkhzKTEiin+vxBkjpPfG5ZQtSAqi
	100m9KYlAq9TSa00Po1VorYwUj0BIrusw8+MMkTonFbyEJw4HgyFr/awvahde3y5q34=
X-Gm-Gg: ASbGncvvFrWbt673vTnHFED3uXWWTEMH+4mky8f5CcMq4vRz0Ehe+B1zc2txDevuCuJ
	lv09bz0ECYv95wcAZAKxQrqC3rUZbuJalIqskiu3kAzFSs4SpOxLRaRypwAsHrD9k8m2vguA3zZ
	HT2FVBADVRGmL8+PdL0cisxaXtcGQP/oENZt3R2NXp+3VRms2/5FkIJ00alSzP20pwUBeyAoHzI
	+4mSwqG6L3X19jSlpV3k3IeRO8LY9irAmL8/r3lpi0ux08WMRCni12mj11SeDGMc5C85p5x1oC5
	Vr3desgxvPr3VcS8K72W7YgK0m6Hw6rd0LwFolC8BZTk7Cq8EQY=
X-Google-Smtp-Source: AGHT+IFzKMzd/Y/wRqiK7tnjQko6Fgged9I5qmkJk3GLgk9i1VCSWkqKkORUP/rYp7TuSn9EQlb7cQ==
X-Received: by 2002:a17:906:c102:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-ae3c2a94ecemr114292366b.17.1751426264664;
        Tue, 01 Jul 2025 20:17:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae36327ce4asm911915366b.163.2025.07.01.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 01/12] bpf: Refactor bprintf buffer support
Date: Tue,  1 Jul 2025 20:17:26 -0700
Message-ID: <20250702031737.407548-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; h=from:subject; bh=AI6q4JpYWdyYAt95InDEg0J7suQigoysjGatGbygY9s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQF54MwHBwwDpTYxL0mxZvLEaV0/4QFWGN5mYs B93BT2iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8RymJRD/ 92S4uEaNGniqymOVcpTzL03jnRjeqHDjGNIS55+K/us/sZEQuzER+15EgnvrLiA6BSgasXd6ar0hht FNl++MfeXdRqq8ojWaizNePZ2WToVCJOoawCuiGJlSHZ6riSH3iPecPWxy9Ba01Oc8M+VOuLZNVtKn Gn2C1+Jbg5DJg4ubOaOseNNNnKqGK+Itldc8dbDG51NVcXsDvfeKnWnPe8QR+InMSMXpjHtzoAZRam zd7NiSlWQlH4u4DPCSqnBaSE8jKMAJ1+HprysxHcARATqp0d9NC8vyMH9bn+F/YOVn4lqq8NJGfinN HuR10IfMtah/3cyoCUTgYLYY8tlBy50aLAjL0+a2/G/yAUgYaNRtQf/8BgUOnMWOfysoMLFdi49g+q GdzAFzxCiKeXL4YtTDWZYSsdMNwLnbg5PHntYLnrUD60AcV2g3jCMig57SuGg0p3tgFdFZhZxQ7LMS 4UNO7gWcwnzXPcyw7rvrwcSFgRCjOLaUwa/V8ev/MpJzygzHiPnVEVZ9zHGtwuWALyT5peY3roS/cS Dj4BD3lFphlfhrDyiOWS/pVuvDXGHSHyzUBxh7Qkh/BlPI935mxGFCKMryd77tfIB/iyqE5DEaxh8P UNlhhYSVonMEjPcL7R1qgCDJfRJf7DQCkoaMoR1pK9UTSQedOmOd4iCEvZHw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Refactor code to be able to get and put bprintf buffers and use
bpf_printf_prepare independently. This will be used in the next patch to
implement BPF streams support, particularly as a staging buffer for
strings that need to be formatted and then allocated and pushed into a
stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 15 ++++++++++++++-
 kernel/bpf/helpers.c | 26 +++++++++++---------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..4fff0cee8622 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3550,6 +3550,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 #define MAX_BPRINTF_VARARGS		12
 #define MAX_BPRINTF_BUF			1024
 
+/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
+ * arguments representation.
+ */
+#define MAX_BPRINTF_BIN_ARGS	512
+
+struct bpf_bprintf_buffers {
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
+};
+
 struct bpf_bprintf_data {
 	u32 *bin_args;
 	char *buf;
@@ -3557,9 +3567,12 @@ struct bpf_bprintf_data {
 	bool get_buf;
 };
 
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
+void bpf_put_buffers(void);
+
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f48fa3fe8dec..8f1cc1d525db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -764,22 +764,13 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	return -EINVAL;
 }
 
-/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
- * arguments representation.
- */
-#define MAX_BPRINTF_BIN_ARGS	512
-
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
-struct bpf_bprintf_buffers {
-	char bin_args[MAX_BPRINTF_BIN_ARGS];
-	char buf[MAX_BPRINTF_BUF];
-};
 
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
@@ -795,16 +786,21 @@ static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+void bpf_put_buffers(void)
 {
-	if (!data->bin_args && !data->buf)
-		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
 	preempt_enable();
 }
 
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+{
+	if (!data->bin_args && !data->buf)
+		return;
+	bpf_put_buffers();
+}
+
 /*
  * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like helpers
  *
@@ -819,7 +815,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
@@ -835,7 +831,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (get_buffers && try_get_buffers(&buffers))
+	if (get_buffers && bpf_try_get_buffers(&buffers))
 		return -EBUSY;
 
 	if (data->get_bin_args) {
-- 
2.47.1


