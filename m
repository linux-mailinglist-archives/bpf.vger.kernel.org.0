Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696216730EB
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 06:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjASFDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 00:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjASFC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 00:02:56 -0500
X-Greylist: delayed 1810 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 20:56:52 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18FFEDB;
        Wed, 18 Jan 2023 20:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=ZQ//IA0NhKdNE+rYfKAyp7+VVDgWEzVXpQLE2095Tpg=;
        b=f5bVgdyhOtYwDtdjvRtO78ken69rCoTHl+ndTtW+Kki+il066LR1BgJoPsvZqL
        QqRf+r9qzbp976qfwSri6WkJ8/ufyENSUBcd+QrTtxYJwW/yHw/0VkCchUSyPdcB
        K8/3SU5D+xSc0s6VCZ97ZA8udMXxCl8xRTDhVL+uppokM=
Received: from localhost.localdomain (unknown [202.112.238.191])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wA3B2qWxchjSVC7AA--.61981S4;
        Thu, 19 Jan 2023 12:22:48 +0800 (CST)
From:   Yi He <clangllvm@126.com>
To:     tixxdz@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        clangllvm@126.com, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, yhs@meta.com
Subject: [PATCH V2] bpf: security enhancement by limiting the offensive eBPF helpers
Date:   Thu, 19 Jan 2023 12:22:44 +0800
Message-Id: <20230119042244.763779-1-clangllvm@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEiveUd_N8qHy54AS0q90FuUSQ=7mePm8FL88Aw-sY7fT7NqFQ@mail.gmail.com>
References: <CAEiveUd_N8qHy54AS0q90FuUSQ=7mePm8FL88Aw-sY7fT7NqFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3B2qWxchjSVC7AA--.61981S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1DZr4DZF13Cr48Aw4rGrg_yoW7ur45pF
        WDKry3Ar4kJr4Ik347J3yxWF4Fy3y5WrW7Gan5K3y8ZanxJr40gr1fKF4a9Fn5ZrZ8G3ya
        q39FvrZ8Aa1Dua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRb_-PUUUUU=
X-Originating-IP: [202.112.238.191]
X-CM-SenderInfo: xfod0wpooyzqqrswhudrp/1tbiYBn7y1pEKC6rqwAAsR
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

Thanks for you reply.

I have studied this problem for months. I would like to give more details to
 clarify why these two helpers can break the INTEGRITY and should be lockdown.

First, this helpers are only for eBPF tracing programs. LSM-bpf and seccomp do 
not need them. The documents say the two functions are experimental. 
Now the eBPF products (e.g., Cillium, Falco) seldom use them but the evil eBPF 
can abuse them.

Second, override_return is similar to bpf_write_user can defintely break the 
INTEGRITY by altering other processes' system call or kernel functions 
(KProbe)'s return code.

> Then solution should be toward restricting eBPF in container, there is already
> sysctl, per process seccomp, LSM + bpf LSM for that.
Yes, the solution is for restricting eBPF in container. But a fine-gained access 
control is required, such as assigning different eBPF privilege to various containers, 
rather than just disable eBPF in a container. 
 
The mechanisms you mententioned do not properly sovle the problem.
sysctl can only disable the unprivielge
users to access eBPF via the kernel.unprivileged_bpf_disabled flag. The untrusted eBPF
are installed by privielge users inside a container but can harm the whole system and 
other shared-kernel containers.
seccomp also can only disable the bpf system call to totally disable eBPF while we may 
need to selectively enable the benign features of eBPF and disallow the offensive features
which may be abused.
LSM + bpf LSM can implement this functionality. However, it is difficult to identify 
a process from a container [1] as at many LSM hooks, we can only get a process's pid and
 name which can be forged by the mailicous program. A correct way is to use the inode number
 to set policy for benign processes. Moreover, the LSM bpf's overhead is unacceptable.

[1]. https://blog.doyensec.com/2022/10/11/ebpf-bypass-security-monitoring.html

> Those are more or less same as bpf sending signal. Supervisors are using
> seccomp to ret kill process and/or sending signals. Where will you draw the
> line? should we go restrict those too? IMHO this does not relate to lockdown.
> I don't see that much difference between a seccomp kill and ebpf signal.

The bpf_send_singal is different to any other signal sending functions as it 
enables a eBPF tracing program from a container to kill any processes 
(even the privielge proceess) of the host or other containers. 
Supervisors and seccomp can only kill its child process. Other signal sending 
do not need to be restricted as they can not be used inside a container to kill 
any processes outside of a container. 

> This reasoning will kill any effort to improve sandbox mechanisms that are
> moving some functionality from seccomp ret kill to a more flexible and
> transparent bpf-LSM model where privileged installs the sandbox. Actually,
> we are already doing this and beside eBPF flexibility and transparency
> (change policy at runtime without restart) from a _user perspective_
We will try to implement alternative mechanisms for constrained eBPF 
features only since the LSM-bpf have shortages in both flexibility and
 performance. 

This patch is only for blocking the offensive features of eBPF and avoiding them 
affecting the INTEGRITY of the container, given that the evil eBPF can abuse these
helpers to affect any processes running in inside or outside of the container, 
sharing the same kernel.

[1]. https://github.com/Gui774ume/krie/blob/master/ebpf/krie/hooks/lsm.h

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

