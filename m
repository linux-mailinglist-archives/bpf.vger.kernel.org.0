Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449CB671C17
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjARMdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 07:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjARMcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 07:32:42 -0500
X-Greylist: delayed 1805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 03:49:53 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644295A375;
        Wed, 18 Jan 2023 03:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=z3knI
        4o7Y51dXHG8FRsTjca3hUpw5Zs0AgfUz081W6I=; b=PjLcNMP6y9SVUHnX1xO8F
        ivhmX/D8wAQQRyo3GB7iuuQmH56wATfTaFvy59q4G+msk6gTrFmounEzQ0dcvdMx
        QEPFKB5spDTAd6erpjLVg4ln0ud4ynhGVkhagDVq7WHK/XIk0fR/kxUxXa0OJBqS
        sEYmuAGDsqZEiMZJDqswJM=
Received: from localhost.localdomain (unknown [202.112.238.191])
        by smtp12 (Coremail) with SMTP id fORpCgA3FHSf1cdj8fmvAA--.15435S4;
        Wed, 18 Jan 2023 19:18:56 +0800 (CST)
From:   Yi He <clangllvm@126.com>
To:     daniel@iogearbox.net
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        clangllvm@126.com, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, yhs@meta.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH V2] bpf: security enhancement by limiting the offensive eBPF helpers
Date:   Wed, 18 Jan 2023 19:18:54 +0800
Message-Id: <20230118111854.744810-1-clangllvm@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ef9b8445-b02b-3f6a-a566-587695f322b7@iogearbox.net>
References: <ef9b8445-b02b-3f6a-a566-587695f322b7@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fORpCgA3FHSf1cdj8fmvAA--.15435S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy3tw13XF48uF4xZr18Krg_yoWrZw45pF
        WDGF93CrZ7JF4IgrsrJ34xGFWrA3y5WrW7GFWDKw18Za9Fqr4Yqr47tF4a93Z5ZrZxW3y2
        qa12vFZ0yF1qga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRb_-PUUUUU=
X-Originating-IP: [202.112.238.191]
X-CM-SenderInfo: xfod0wpooyzqqrswhudrp/1tbiqB36y1pD-eYBBwABsB
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

Thanks for your feedback.

This patch aims to mitigate the offensive eBPF problem which has been dicussed since 2019 [1]. Recently, we find that enable eBPF in container environemnt can lead to container escape or cross-nodes attacks (which may compromise mutiple VMs) in the Kubernetes [2]. Since lots of eBPF based tools are used in containers, mutiple containers have the CAP_SYS_ADMIN needed by eBPF which may be abused by untrusted eBPF code. 

We are still working for a better fine-grained eBPF permission model which add capability fitler bits to control the permissions of different eBPF program types and helper functions of a processes [3].

Security lockdown seems to be a simple way to mitigate this problem. It only restrict all the offensive features and enable other eBPF features needed by benign eBPF program such as Cillium (which do not use these offensive features but only need bpf_read_user).

> I'm not applying this.. i) this means by default you effectively remove these
> helpers from existing users in the wild given integrity mode is default for
> secure boot, but also ii) should we lock-down and remove the ability for other
> privileged entities like processes to send signals, seccomp to ret_kill, ptrace,
> etc given they all "can affect userspace processes"

It does not affect other privielge processes (e.g., ptrace) to kill process. Seccomp is classic bpf does not use this eBPF helper [4].

>  check out already existing FUNCTION_ERROR_INJECTION kernel config.
We do not think the FUNCTION_ERROR_INJECTION  config can solve this problem as this option is default enable in many linux distributions such as debian/ubuntu. All the syscall are in allowlist of error injection and can be attacked by evil eBPF via eBPF override return.

We hop you can rethink this problem. 

[1]. J. Dileo. Evil eBPF: Practical Abuses of an In-Kernel Bytecode Runtime. DEFCON 27
[2]. https://rolandorange.zone/report.html
[3]. https://lore.kernel.org/bpf/CAADnVQK4ucv=LugqZ3He9ubwdxDu6ohaBKr2E=TX0UT65+7WpQ@mail.gmail.com/T/ 
[4]. https://elixir.bootlin.com/linux/v6.2-rc4/source/kernel/seccomp.c#L1304


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

