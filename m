Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075364E375
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 22:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOVpT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 16:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOVpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 16:45:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F65C779
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC9A61F4F
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 21:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14921C433EF;
        Thu, 15 Dec 2022 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140711;
        bh=2WuZ4Y/iUBWzPvev/Pdy5bU20yAK2v7qOkjsJ4dGTIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3JnrjAwOSKXTdw5rny6/UQx0L2J9Er/n4eYHHaA0LRkge1LIsiP+3/+zBlg+6jdi
         ZQVXr2YgI9daHyBsY8vfgNdFcFEBigqD4s4+CmWafQxjhceOvz76Y65yqPuQCAlFoO
         D2EgsrRWVRsCiOpC2aJ8PoPAM3dW9tKG6rjXHmW970D/FLxQWPDHesY1gV3djqqVUu
         Q404WBoRJkvnjezvp9H9saWCmyJHG03hnh90+rzJ7q9Y989M03zuvD6WzTD43iR9Vl
         6cMg7P4Dn6MIrPX3uUmhvMProQ1wHNrk5UWoe57+S9ro76bLCp7gvf6E2ZfPMz5iD9
         d0FqKsyI7hSaQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCHv3 bpf-next 3/3] bpf: Remove trace_printk_lock
Date:   Thu, 15 Dec 2022 22:44:30 +0100
Message-Id: <20221215214430.1336195-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215214430.1336195-1-jolsa@kernel.org>
References: <20221215214430.1336195-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
guarded with trace_printk_lock spin lock.

The spin lock contention causes issues with bpf programs attached to
contention_begin tracepoint [1] [2].

Andrii suggested we could get rid of the contention by using trylock,
but we could actually get rid of the spinlock completely by using
percpu buffers the same way as for bin_args in bpf_bprintf_prepare
function.

Adding new return 'buf' argument to struct bpf_bprintf_data and making
bpf_bprintf_prepare to return also the buffer for printk helpers.

[1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/

Reported-by: Hao Sun <sunhao.th@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/helpers.c     | 31 +++++++++++++++++++------------
 kernel/trace/bpf_trace.c | 20 ++++++--------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 656879385fbf..5fec2d1be6d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2795,10 +2795,13 @@ struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
+#define MAX_BPRINTF_BUF			1024
 
 struct bpf_bprintf_data {
 	u32 *bin_args;
+	char *buf;
 	bool get_bin_args;
+	bool get_buf;
 };
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9cca02e13f2e..23aa8cf8fd1a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -756,19 +756,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 /* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
  * arguments representation.
  */
-#define MAX_BPRINTF_BUF_LEN	512
+#define MAX_BPRINTF_BIN_ARGS	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
 struct bpf_bprintf_buffers {
-	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
 };
-static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
+
+static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_fmt_tmp_buf(char **tmp_buf)
+static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
-	struct bpf_bprintf_buffers *bufs;
 	int nest_level;
 
 	preempt_disable();
@@ -778,15 +779,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 		preempt_enable();
 		return -EBUSY;
 	}
-	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
-	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
+	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
 
 	return 0;
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 {
-	if (!data->bin_args)
+	if (!data->bin_args && !data->buf)
 		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
@@ -811,7 +811,9 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
+	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	struct bpf_bprintf_buffers *buffers = NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
@@ -822,14 +824,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (data->get_bin_args) {
-		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
-			return -EBUSY;
+	if (get_buffers && try_get_buffers(&buffers))
+		return -EBUSY;
 
-		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
+	if (data->get_bin_args) {
+		if (num_args)
+			tmp_buf = buffers->bin_args;
+		tmp_buf_end = tmp_buf + MAX_BPRINTF_BIN_ARGS;
 		data->bin_args = (u32 *)tmp_buf;
 	}
 
+	if (data->get_buf)
+		data->buf = buffers->buf;
+
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
 			err = -EINVAL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2129f7c68bb5..23ce498bca97 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -369,8 +369,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -380,9 +378,8 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
+		.get_buf	= true,
 	};
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret;
 
 	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
@@ -390,11 +387,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
 
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(data.buf);
 
 	bpf_bprintf_cleanup(&data);
 
@@ -434,9 +429,8 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
+		.get_buf	= true,
 	};
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret, num_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
@@ -448,11 +442,9 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
 
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(data.buf);
 
 	bpf_bprintf_cleanup(&data);
 
-- 
2.38.1

