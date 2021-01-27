Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52D3067EA
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhA0Xas (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhA0X3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 18:29:39 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9799C061786
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:28:57 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j14so2278165qtv.3
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vhYc+wYs1G7uMUF5oKdhWeUe49WbW+rEtELI/tcKMYQ=;
        b=gEpnlv6QErCrOa/TbynVCsUr2DaTAz0N4g99zQe6s37ZHgy72UhpH8yjntCGdO9XQn
         FTumQqRVw6wC/kfhlT9np60lQ6czL6W6F4gEmvUzhKDXF7hQW9PvEs/CkGzKAGPQEjPk
         iVsRIFh+XHTOipDGh2O2PTy0cS5gG33UhKcj2UY2df5gCxLBapSY24j7Z4R9bF3cOAEz
         ZxadJDzLF9txyK+S0zJy9Vr3XN9O++Ks5/+gTB4ujydQMFx9rEIPMK4chAWTYUpR6ZtW
         69JaMcRfoP51ZUBhYa28s0MML3pnkbnpKKSIscg6NphOoe6fqVYiBsomhXYE4dd66oGo
         PSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vhYc+wYs1G7uMUF5oKdhWeUe49WbW+rEtELI/tcKMYQ=;
        b=mN3MwziccW2O6gfZ0Epcv2htQ9qWGums4AKLlBLhjgvQkxF+Zg/jXSBBNKBfMZOp7U
         J3cQH0ePtEJ6CN82YbMx8WsplpTAYBB/lWQVgBVr7k1C+YAcCu71x/KnCFTR1fQFMcrE
         b0b8ZZP9vkVnstQEHlX1nK4FHkyBNJiGA/8lHRXqIXTTjncvEpvLTXJkoZFtAWMN2v9Z
         vH+zMJmAgT2kvTy4bRBioXG8sP00AnZhKNWNoPPaHma1oMgY1N0cV7Lf5lyid+Ozum4U
         UyxhXlon9y9rrz6d60GPpKaR+VOsDQmlS4iPRrw+cpQFOQC0hCoHq0mw7GFC/rgQuHQO
         jMBw==
X-Gm-Message-State: AOAM533fTzgbb3VhG0F7ET+iLCAj1TaIZ9KApfmlSM0IHlLMqcNEuCmh
        3yVzAx6BVQ4TAKgDsibgsk7cPH4=
X-Google-Smtp-Source: ABdhPJyOqgEf3yknfsu9j4NXAicwqvknx32YCcYaBiy5q4xQPRb/zXWFUXU90jtxW1PDdDTj1Fmuv9s=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:148a:: with SMTP id
 bn10mr3996484qvb.52.1611790136865; Wed, 27 Jan 2021 15:28:56 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:28:50 -0800
In-Reply-To: <20210127232853.3753823-1-sdf@google.com>
Message-Id: <20210127232853.3753823-2-sdf@google.com>
Mime-Version: 1.0
References: <20210127232853.3753823-1-sdf@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH bpf-next v2 1/4] bpf: enable bpf_{g,s}etsockopt in BPF_CGROUP_UDP{4,6}_SENDMSG
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Can be used to query/modify socket state for unconnected UDP sendmsg.
Those hooks run as BPF_CGROUP_RUN_SA_PROG_LOCK and operate on
a locked socket.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c                             |  4 ++++
 .../selftests/bpf/bpf_sockopt_helpers.h       | 21 +++++++++++++++++++
 .../selftests/bpf/progs/sendmsg4_prog.c       |  7 +++++++
 .../selftests/bpf/progs/sendmsg6_prog.c       |  5 +++++
 4 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_sockopt_helpers.h

diff --git a/net/core/filter.c b/net/core/filter.c
index 9ab94e90d660..3d7f78a19565 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7023,6 +7023,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UDP4_SENDMSG:
+		case BPF_CGROUP_UDP6_SENDMSG:
 			return &bpf_sock_addr_setsockopt_proto;
 		default:
 			return NULL;
@@ -7033,6 +7035,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UDP4_SENDMSG:
+		case BPF_CGROUP_UDP6_SENDMSG:
 			return &bpf_sock_addr_getsockopt_proto;
 		default:
 			return NULL;
diff --git a/tools/testing/selftests/bpf/bpf_sockopt_helpers.h b/tools/testing/selftests/bpf/bpf_sockopt_helpers.h
new file mode 100644
index 000000000000..11f3a0976174
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_sockopt_helpers.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <sys/socket.h>
+#include <bpf/bpf_helpers.h>
+
+int get_set_sk_priority(void *ctx)
+{
+	int prio;
+
+	/* Verify that context allows calling bpf_getsockopt and
+	 * bpf_setsockopt by reading and writing back socket
+	 * priority.
+	 */
+
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0;
+
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
index 092d9da536f3..ac5abc34cde8 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
@@ -8,6 +8,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include <bpf_sockopt_helpers.h>
+
 #define SRC1_IP4		0xAC100001U /* 172.16.0.1 */
 #define SRC2_IP4		0x00000000U
 #define SRC_REWRITE_IP4		0x7f000004U
@@ -21,9 +23,14 @@ int _version SEC("version") = 1;
 SEC("cgroup/sendmsg4")
 int sendmsg_v4_prog(struct bpf_sock_addr *ctx)
 {
+	int prio;
+
 	if (ctx->type != SOCK_DGRAM)
 		return 0;
 
+	if (!get_set_sk_priority(ctx))
+		return 0;
+
 	/* Rewrite source. */
 	if (ctx->msg_src_ip4 == bpf_htonl(SRC1_IP4) ||
 	    ctx->msg_src_ip4 == bpf_htonl(SRC2_IP4)) {
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index 255a432bc163..24694b1a8d82 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -8,6 +8,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include <bpf_sockopt_helpers.h>
+
 #define SRC_REWRITE_IP6_0	0
 #define SRC_REWRITE_IP6_1	0
 #define SRC_REWRITE_IP6_2	0
@@ -28,6 +30,9 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	if (ctx->type != SOCK_DGRAM)
 		return 0;
 
+	if (!get_set_sk_priority(ctx))
+		return 0;
+
 	/* Rewrite source. */
 	if (ctx->msg_src_ip6[3] == bpf_htonl(1) ||
 	    ctx->msg_src_ip6[3] == bpf_htonl(0)) {
-- 
2.30.0.280.ga3ce27912f-goog

