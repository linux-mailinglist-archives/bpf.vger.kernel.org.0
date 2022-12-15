Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C764E373
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 22:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOVov (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLOVou (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013E5D6B4
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBE261F5B
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 21:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B29C433EF;
        Thu, 15 Dec 2022 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140688;
        bh=U1qUL7wdMxoyRXsve+77tZ2NNXgSvfwUMgTvR4MlbNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL/1pn3K1ynioy4X5+RFpUCxfUeEyDeJUWjox9GhmRRo5gAUDPraNGvgVh399G8cw
         9nVe60usWGnwWc81z9Pun+NTkC8BLKAc62i/0RO/ygiaVKBXlWvWruLDiKdXlwtUo5
         etXKUV9dzPhatjavwRMrJ7qG115b2Ew1I/vatksf5gnEQadgdZV5GbNA7gFXRsPH8F
         GjjbnTzK0Wb8Rm8M516Jc70KQ9t0Mc3LzJW2KrtDyUvBoxEiF5Ez1rnsGqHyax22ru
         ucDGWNFeYzA3vekWK7+vcyX0Gqnoj7BlfY1RWqJuKtXcxh04JcBysEE7VP/JGT6ZEB
         WoVJp1FfUPWVA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCHv3 bpf-next 1/3] bpf: Add struct for bin_args arg in bpf_bprintf_prepare
Date:   Thu, 15 Dec 2022 22:44:28 +0100
Message-Id: <20221215214430.1336195-2-jolsa@kernel.org>
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

Adding struct bpf_bprintf_data to hold bin_args argument
for bpf_bprintf_prepare function.

We will add another return argument to bpf_bprintf_prepare
and pass the struct to bpf_bprintf_cleanup for proper cleanup
in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      |  7 ++++++-
 kernel/bpf/helpers.c     | 24 +++++++++++++-----------
 kernel/bpf/verifier.c    |  3 ++-
 kernel/trace/bpf_trace.c | 34 ++++++++++++++++++++--------------
 4 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3de24cfb7a3d..cc390ba32e70 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2796,8 +2796,13 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
 
+struct bpf_bprintf_data {
+	u32 *bin_args;
+	bool get_bin_args;
+};
+
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_buf, u32 num_args);
+			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(void);
 
 /* the implementation of the opaque uapi struct bpf_dynptr */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af30c6cbd65d..7dbf6bb72cad 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -798,16 +798,16 @@ void bpf_bprintf_cleanup(void)
  * Returns a negative value if fmt is an invalid format string or 0 otherwise.
  *
  * This can be used in two ways:
- * - Format string verification only: when bin_args is NULL
+ * - Format string verification only: when data->get_bin_args is false
  * - Arguments preparation: in addition to the above verification, it writes in
- *   bin_args a binary representation of arguments usable by bstr_printf where
- *   pointers from BPF have been sanitized.
+ *   data->bin_args a binary representation of arguments usable by bstr_printf
+ *   where pointers from BPF have been sanitized.
  *
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_args, u32 num_args)
+			u32 num_args, struct bpf_bprintf_data *data)
 {
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
@@ -820,12 +820,12 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (bin_args) {
+	if (data->get_bin_args) {
 		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
 			return -EBUSY;
 
 		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
-		*bin_args = (u32 *)tmp_buf;
+		data->bin_args = (u32 *)tmp_buf;
 	}
 
 	for (i = 0; i < fmt_size; i++) {
@@ -1026,24 +1026,26 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 }
 
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
 	if (data_len % 8 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
 	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
 	 * can safely give an unbounded size.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	err = bstr_printf(str, str_size, fmt, bin_args);
+	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
 	bpf_bprintf_cleanup();
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..faa358b3d5d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7612,6 +7612,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
 	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
 	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	struct bpf_bprintf_data data = {};
 	int err, fmt_map_off, num_args;
 	u64 fmt_addr;
 	char *fmt;
@@ -7636,7 +7637,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
 	 * can focus on validating the format specifiers.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, num_args, &data);
 	if (err < 0)
 		verbose(env, "Invalid format string\n");
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..3e849c3a7cc8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -378,18 +378,20 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
-	u32 *bin_args;
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
-				  MAX_TRACE_PRINTK_VARARGS);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
+				  MAX_TRACE_PRINTK_VARARGS, &data);
 	if (ret < 0)
 		return ret;
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
 
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
@@ -427,25 +429,27 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
-BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
+BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	   u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret, num_args;
-	u32 *bin_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
 	if (ret < 0)
 		return ret;
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
 
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
@@ -472,21 +476,23 @@ const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 }
 
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	seq_bprintf(m, fmt, bin_args);
+	seq_bprintf(m, fmt, data.bin_args);
 
 	bpf_bprintf_cleanup();
 
-- 
2.38.1

