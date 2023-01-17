Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE12C66E2AC
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjAQPrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAQPqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 10:46:19 -0500
X-Greylist: delayed 1818 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 07:44:17 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A5B741B6F
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/vQ8l
        ujlHPAo719eQYKpSHLJgqfRyeZVINfTpIv8RRI=; b=IJwoZLL7c8DMPqFF7jwD0
        v18p8zoctNbIYtJCYPi/qnQ80uIcGLuYDtx7mR63nG3e38JyIZuNtDwjz7HLmg49
        fjstzRUUE/et2D9Rz4GjMSDHRzw+McGg0lVC6HnBXjLq9RnP3JLOG2O4lX3XRoCK
        0J/f/SOnFtrKx2LihA0BVI=
Received: from localhost.localdomain (unknown [202.112.238.191])
        by smtp12 (Coremail) with SMTP id fORpCgA33XT9usZjkqGZAA--.64291S4;
        Tue, 17 Jan 2023 23:13:02 +0800 (CST)
From:   WritePaper <clangllvm@126.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com
Cc:     john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, clangllvm@126.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bpf: security enhancement by limiting the offensive eBPF helpers
Date:   Tue, 17 Jan 2023 23:12:56 +0800
Message-Id: <20230117151256.605977-1-clangllvm@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fORpCgA33XT9usZjkqGZAA--.64291S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1xJrWDCw1kXw48Ww47CFg_yoW8ZrWDpF
        yDGFZrArZ7JF42gr9rJr1xCrWrA398WrW7WFWDWa18ZrnrXr4jqr4UKF4IkF1rZrZxGrW7
        ua129FZ0kF12ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziiIDxUUUUU=
X-Originating-IP: [202.112.238.191]
X-CM-SenderInfo: xfod0wpooyzqqrswhudrp/1tbiLR-5y1pEAlbwcwAAsJ
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_send_singal and bpf_override_return is similar to
bpf_write_user and can affect userspace processes. Thus, these two
helpers should also be constraint by security lockdown.

Signed-off-by: WritePaper <clangllvm@126.com>
---
 include/linux/security.h | 3 +++
 kernel/trace/bpf_trace.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f..cb90b2860 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -123,6 +123,9 @@ enum lockdown_reason {
 	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_XMON_WR,
 	LOCKDOWN_BPF_WRITE_USER,
+	LOCKDOWN_BPF_SEND_SIGNAL,
+	LOCKDOWN_BPF_OVERRIDE_RETURN,
+	LOCKDOWN_OFFENSIVE_BPF_MAX,
 	LOCKDOWN_DBG_WRITE_KERNEL,
 	LOCKDOWN_RTAS_ERROR_INJECTION,
 	LOCKDOWN_INTEGRITY_MAX,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c8..3a80f4b6f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1463,7 +1463,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_cgrp_storage_delete_proto;
 #endif
 	case BPF_FUNC_send_signal:
-		return &bpf_send_signal_proto;
+		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
+		       NULL : &bpf_send_signal_proto;
 	case BPF_FUNC_send_signal_thread:
 		return &bpf_send_signal_thread_proto;
 	case BPF_FUNC_perf_event_read_value:
@@ -1531,7 +1532,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stack_proto;
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 	case BPF_FUNC_override_return:
-		return &bpf_override_return_proto;
+		return security_locked_down(LOCKDOWN_BPF_OVERRIDE_RETURN) < 0 ?
+		       NULL : &bpf_override_return_proto;
 #endif
 	case BPF_FUNC_get_func_ip:
 		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
-- 
2.25.1

