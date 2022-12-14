Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849464C680
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLNKEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLNKEd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B762E9
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2044BB816AD
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47EC433EF;
        Wed, 14 Dec 2022 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671012269;
        bh=08ipn/WSAfHhPR1e2jPJVqCwNjjaatl2d/6nUBsEaWM=;
        h=From:To:Cc:Subject:Date:From;
        b=laE7iW8vvaNA21n4873nQUpTy2acFfJzEuoCHpbaYsCcpZx+tqD9wcS1Qeo6kzbw/
         rifwCbbA4t8InaPGH1T2n3qOpxybmUAehRVP/xf4oQtL8mILZ7grznr+c/2VQeC+vc
         vRq7umR8Kifvc0oHynC+JJJr7G3ovEn7aC5LrpJzVwAtPcIVVPeTfRH97raa67Rx26
         7+W3FdhuO48C85mCfmq0gDqqn6uUvqg3HIQIM055tepOo7+sqgesbtOfPNVR6KHaaL
         wcqVrQWlsrSjAAfYuWlBvQRwx6od6BrdUkVnQX2LbVGPtsUNavZJcLnjM4xFg6tj9t
         DgKgU+DJJVMgA==
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
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next] bpf: Remove trace_printk_lock
Date:   Wed, 14 Dec 2022 11:04:24 +0100
Message-Id: <20221214100424.1209771-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Adding 4 per cpu buffers (1k each) which should be enough for all
possible nesting contexts (normal, softirq, irq, nmi) or possible
(yet unlikely) probe within the printk helpers.

In very unlikely case we'd run out of the nesting levels the printk
will be omitted.

[1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/

Reported-by: Hao Sun <sunhao.th@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - changed subject [Yonghong]
  - added WARN_ON_ONCE to get_printk_buf [Song]

 kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..a992b5a47fd6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
+#define BPF_TRACE_PRINTK_LEVELS		4
+
+struct trace_printk_buf {
+	char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
+	int level;
+};
+static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
+
+static void put_printk_buf(struct trace_printk_buf __percpu *buf)
+{
+	if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
+		return;
+	this_cpu_dec(buf->level);
+	preempt_enable();
+}
+
+static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
+{
+	int level;
+
+	preempt_disable();
+	level = this_cpu_inc_return(buf->level);
+	if (WARN_ON_ONCE(level > BPF_TRACE_PRINTK_LEVELS)) {
+		put_printk_buf(buf);
+		return false;
+	}
+	*data = (char *) this_cpu_ptr(&buf->data[level - 1]);
+	return true;
+}
 
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
 	u32 *bin_args;
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
+	char *buf;
 	int ret;
 
+	if (!get_printk_buf(&printk_buf, &buf))
+		return -EBUSY;
+
 	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
 				  MAX_TRACE_PRINTK_VARARGS);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
 
 	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
 	bpf_bprintf_cleanup();
 
+out:
+	put_printk_buf(&printk_buf);
 	return ret;
 }
 
@@ -427,31 +456,35 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
+static DEFINE_PER_CPU(struct trace_printk_buf, vprintk_buf);
+
 BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
 	   u32, data_len)
 {
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret, num_args;
 	u32 *bin_args;
+	char *buf;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
 	    (data_len && !data))
 		return -EINVAL;
 	num_args = data_len / 8;
 
+	if (!get_printk_buf(&vprintk_buf, &buf))
+		return -EBUSY;
+
 	ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
 
 	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
 	bpf_bprintf_cleanup();
 
+out:
+	put_printk_buf(&vprintk_buf);
 	return ret;
 }
 
-- 
2.38.1

