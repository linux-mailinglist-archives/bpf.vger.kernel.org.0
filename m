Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46663067F3
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhA0Xbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhA0XbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 18:31:16 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D484C061794
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:29:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id l124so2811169qke.7
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2xvw56uMQ1ecuAEADRnoIpPQc7Y6L/lmpB1+lxfp0II=;
        b=TDuQRdk+Cp6QcQnhveInYzgj7+qT95NpYNmFCkXwUUTt7AmCuuS5mjFKS+acp2a/JS
         OO7MVd/Vb9FDSvWK9R7iBYCqO+QWdXQ6+Xq1zTVvO34FryOdQc7V5kM0zBOt6HhY7RyP
         3mLoi6btRxY3g+LZqlhB1RE2vkk8SsK/TJgKfF0AoJvC7EPg6ArGsQsfmvwGcKqyE+hT
         mw7RUHRXOLdvLlB9g66qKlkYQVsWlRqiGUA4uzkuO76vSj/Edxd/mMElWEPWVstW3tKt
         vwp/bNN4bpHsLk6Z3iMC/uptF2e6xMCQxazWsE5HeVfHb65tENcTdHQtC+gitFkm01Pc
         V61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2xvw56uMQ1ecuAEADRnoIpPQc7Y6L/lmpB1+lxfp0II=;
        b=Y0vws3DT6TunSYv3fReWiQ6AcJ6RufEZ/7lGUe4LrhpUrMWuSIOoD+gYS8kwHpSuDZ
         kU+awwb2Uh0hQlCbJ2uJjpmT2PjfeTjHUnqrsMhC4VH9dfwylEioGzpapL7PQ/HkbVc+
         2KBtceFBN2YVUor29mzbB/OAyGLRUq7OQnM0BeGYM7RCngIfDrEjTPbLnsy1q5oQYfXM
         CdHzlY1yKf+DNmTp/DOvjvDh63u5+ITl0EHtbyIDSLyp0Ef94EC3ijuSikeVtcBMmexA
         EG/Libydf1zf/Y2I3FjkWag7PDvgEhsU4wm+herY9SeWzNTkYY2cK4mS+4YPew+omqsu
         2U/g==
X-Gm-Message-State: AOAM532s8HsbZHdpGwsA2qt/8nYRpRgvdXbwoUWpVyTy1u/oYnqsEGyf
        I+evp5f+OrBQq97AYqAEVFBCNSU=
X-Google-Smtp-Source: ABdhPJygd+LWTq3OcfriVsvZs0yM5KI1hOAhIJIzAF5DNobIqEF+dhNKIzuPqQJh+sGbFq2CxJ6iUzI=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a0c:e28c:: with SMTP id r12mr3962060qvl.34.1611790142513;
 Wed, 27 Jan 2021 15:29:02 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:28:53 -0800
In-Reply-To: <20210127232853.3753823-1-sdf@google.com>
Message-Id: <20210127232853.3753823-5-sdf@google.com>
Mime-Version: 1.0
References: <20210127232853.3753823-1-sdf@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH bpf-next v2 4/4] bpf: enable bpf_{g,s}etsockopt in BPF_CGROUP_UDP{4,6}_RECVMSG
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Those hooks run as BPF_CGROUP_RUN_SA_PROG_LOCK and operate on
a locked socket.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c                                 | 4 ++++
 tools/testing/selftests/bpf/progs/recvmsg4_prog.c | 5 +++++
 tools/testing/selftests/bpf/progs/recvmsg6_prog.c | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba436b1d70c2..e15d4741719a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7023,6 +7023,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
 		case BPF_CGROUP_UDP6_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
@@ -7039,6 +7041,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
 		case BPF_CGROUP_UDP6_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
diff --git a/tools/testing/selftests/bpf/progs/recvmsg4_prog.c b/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
index fc2fe8a952fa..3d1ae8b3402f 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
@@ -8,6 +8,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include <bpf_sockopt_helpers.h>
+
 #define SERV4_IP		0xc0a801feU /* 192.168.1.254 */
 #define SERV4_PORT		4040
 
@@ -28,6 +30,9 @@ int recvmsg4_prog(struct bpf_sock_addr *ctx)
 	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
 		return 1;
 
+	if (!get_set_sk_priority(ctx))
+		return 1;
+
 	ctx->user_ip4 = bpf_htonl(SERV4_IP);
 	ctx->user_port = bpf_htons(SERV4_PORT);
 
diff --git a/tools/testing/selftests/bpf/progs/recvmsg6_prog.c b/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
index 6060fd63324b..27dfb21b21b4 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
@@ -8,6 +8,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include <bpf_sockopt_helpers.h>
+
 #define SERV6_IP_0		0xfaceb00c /* face:b00c:1234:5678::abcd */
 #define SERV6_IP_1		0x12345678
 #define SERV6_IP_2		0x00000000
@@ -31,6 +33,9 @@ int recvmsg6_prog(struct bpf_sock_addr *ctx)
 	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
 		return 1;
 
+	if (!get_set_sk_priority(ctx))
+		return 1;
+
 	ctx->user_ip6[0] = bpf_htonl(SERV6_IP_0);
 	ctx->user_ip6[1] = bpf_htonl(SERV6_IP_1);
 	ctx->user_ip6[2] = bpf_htonl(SERV6_IP_2);
-- 
2.30.0.280.ga3ce27912f-goog

