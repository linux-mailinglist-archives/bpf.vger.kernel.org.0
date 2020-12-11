Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B322D8132
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406007AbgLKViY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 16:38:24 -0500
Received: from www62.your-server.de ([213.133.104.62]:58094 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404598AbgLKVhX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 16:37:23 -0500
Received: from 30.101.7.85.dynamic.wline.res.cust.swisscom.ch ([85.7.101.30] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1knq5h-000Eo1-Ja; Fri, 11 Dec 2020 22:36:41 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     torvalds@linux-foundation.org
Cc:     davem@davemloft.net, kuba@kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] bpf: Fix enum names for bpf_this_cpu_ptr() and bpf_per_cpu_ptr() helpers
Date:   Fri, 11 Dec 2020 22:36:25 +0100
Message-Id: <7c371fff2427c749f32523b9a4b834fe2dd1d58e.1607712517.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26014/Thu Dec 10 15:21:42 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Remove bpf_ prefix, which causes these helpers to be reported in verifier
dump as bpf_bpf_this_cpu_ptr() and bpf_bpf_per_cpu_ptr(), respectively. Lets
fix it as long as it is still possible before UAPI freezes on these helpers.

Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ Hi Linus, this small fix came unfortunately after we sent our last bpf
   pull request to David's net tree, and as far as I'm aware no further pull
   request for final 5.10 is planned at this moment from David's or Jakub's
   side. If you could apply this last fix directly to your tree, that would
   be very much appreciated. Thanks a lot! ]

 include/uapi/linux/bpf.h       | 4 ++--
 kernel/bpf/helpers.c           | 4 ++--
 kernel/trace/bpf_trace.c       | 4 ++--
 tools/include/uapi/linux/bpf.h | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6ceac3f7d62..556216dc9703 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3897,8 +3897,8 @@ union bpf_attr {
 	FN(seq_printf_btf),		\
 	FN(skb_cgroup_classid),		\
 	FN(redirect_neigh),		\
-	FN(bpf_per_cpu_ptr),            \
-	FN(bpf_this_cpu_ptr),		\
+	FN(per_cpu_ptr),		\
+	FN(this_cpu_ptr),		\
 	FN(redirect_peer),		\
 	/* */
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 25520f5eeaf6..deda1185237b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -717,9 +717,9 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_jiffies64:
 		return &bpf_jiffies64_proto;
-	case BPF_FUNC_bpf_per_cpu_ptr:
+	case BPF_FUNC_per_cpu_ptr:
 		return &bpf_per_cpu_ptr_proto;
-	case BPF_FUNC_bpf_this_cpu_ptr:
+	case BPF_FUNC_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
 	default:
 		break;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 048c655315f1..a125ea5e04cd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1337,9 +1337,9 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return prog->aux->sleepable ? &bpf_copy_from_user_proto : NULL;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
-	case BPF_FUNC_bpf_per_cpu_ptr:
+	case BPF_FUNC_per_cpu_ptr:
 		return &bpf_per_cpu_ptr_proto;
-	case BPF_FUNC_bpf_this_cpu_ptr:
+	case BPF_FUNC_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
 	default:
 		return NULL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6ceac3f7d62..556216dc9703 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3897,8 +3897,8 @@ union bpf_attr {
 	FN(seq_printf_btf),		\
 	FN(skb_cgroup_classid),		\
 	FN(redirect_neigh),		\
-	FN(bpf_per_cpu_ptr),            \
-	FN(bpf_this_cpu_ptr),		\
+	FN(per_cpu_ptr),		\
+	FN(this_cpu_ptr),		\
 	FN(redirect_peer),		\
 	/* */
 
-- 
2.21.0

