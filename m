Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD4671127
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 03:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjARC3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 21:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjARC3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 21:29:00 -0500
X-Greylist: delayed 3614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 18:28:57 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E29AA47EE8;
        Tue, 17 Jan 2023 18:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kDukO
        GUxCUhmiVTpo0WAwM5Sv6NWbvEKkGh0Nqs0F78=; b=c8zU+ous/g1cR/dxhstnG
        ymyDhwVgZZFNWpvQGwG13ugq+1nOYpWe/2geWhe//LT7NmgQlD4lMxgKtO4PhvZA
        j0NqCL9B7WpeCOvDTTIyLUeG2EJY4CwkIeUjaELq8Bu9tQgpogncN4UrrKcSP2Nu
        Fh3o4rt4tf41YN0J2Y3Mkk=
Received: from localhost.localdomain (unknown [202.112.238.191])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wBHec9iQ8djSFyfAA--.53903S4;
        Wed, 18 Jan 2023 08:54:58 +0800 (CST)
From:   Yi He <clangllvm@126.com>
To:     yhs@meta.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        clangllvm@126.com, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        martin.lau@linux.dev, mhiramat@kernel.org, rostedt@goodmis.org,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH V2] bpf: security enhancement by limiting the offensive eBPF helpers
Date:   Wed, 18 Jan 2023 08:54:32 +0800
Message-Id: <20230118005432.634229-1-clangllvm@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f539bfef-c098-5ff0-51ef-bfa8fd0c4661@meta.com>
References: <f539bfef-c098-5ff0-51ef-bfa8fd0c4661@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHec9iQ8djSFyfAA--.53903S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykGFy8KFy3JF1kXr1DWrg_yoW8tw43pF
        WDGF97Ars7JF42grnrJw1xGrWrC3y5WrW7GFWDGw48ZwsrXr4jqr1jkF4I9F1rZrZxGrW3
        ua129rZ0kF12ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRb_-PUUUUU=
X-Originating-IP: [202.112.238.191]
X-CM-SenderInfo: xfod0wpooyzqqrswhudrp/1tbiqAP6y1pD-eLLiQAAse
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_send_singal, bpf_send_singal_thread and bpf_override_return
is similar to bpf_write_user and can affect userspace processes.
Thus, these three helpers should also be restricted by security lockdown.

Signed-off-by: Yi He <clangllvm@126.com>
---
 V1 -> V2: add security lockdown to bpf_send_singal_thread and remove 
	the unused LOCKDOWN_OFFENSIVE_BPF_MAX.

 include/linux/security.h | 2 ++
 kernel/trace/bpf_trace.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f..42420e620 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -123,6 +123,8 @@ enum lockdown_reason {
 	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_XMON_WR,
 	LOCKDOWN_BPF_WRITE_USER,
+	LOCKDOWN_BPF_SEND_SIGNAL,
+	LOCKDOWN_BPF_OVERRIDE_RETURN,
 	LOCKDOWN_DBG_WRITE_KERNEL,
 	LOCKDOWN_RTAS_ERROR_INJECTION,
 	LOCKDOWN_INTEGRITY_MAX,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c8..fdb94868d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1463,9 +1463,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_cgrp_storage_delete_proto;
 #endif
 	case BPF_FUNC_send_signal:
-		return &bpf_send_signal_proto;
+		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
+		       NULL : &bpf_send_signal_proto;
 	case BPF_FUNC_send_signal_thread:
-		return &bpf_send_signal_thread_proto;
+		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
+		       NULL : &bpf_send_signal_thread_proto;
 	case BPF_FUNC_perf_event_read_value:
 		return &bpf_perf_event_read_value_proto;
 	case BPF_FUNC_get_ns_current_pid_tgid:
@@ -1531,7 +1533,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

