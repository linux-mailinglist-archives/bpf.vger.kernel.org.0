Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922F2316C7
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 02:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgG2AbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgG2AbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 20:31:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4AC061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 17:31:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b1so7569985qto.17
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VP+hVP7N9UUwB/BEdPvwYJDuj2mx5IG1QsAyzoOD2Z8=;
        b=G364prxxu/zrM5aCIqvvjp++AFEMIbRTIWjaao2m0kCZsxJ1opiuwcNigCcArkX7Nh
         XYUI2Xt8CB52IHV1sAEPQttMYVRFAnoXQKdUzMwoT5v8K8Je9UEjyLRKYvn/MCwn5qXZ
         MWyiPawzpTqTiGriWjq8tAN4F37Il0ldk8iyezGY6Y0Jdf4mz3b8xzTigAbLyf+z2XgW
         +8kqAdJXMnoszXydaKmBvaRvFJpAIBZvZiXd04gZUTpAAwB7YmePJ2QJxFKlzc9mtMxl
         ogWUd9fPdAsC6ng47Qha2JTnfr++evUBJFF78+8CFX8obsyznW0/cZcuPQu/vOclkQ9u
         2p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VP+hVP7N9UUwB/BEdPvwYJDuj2mx5IG1QsAyzoOD2Z8=;
        b=sj4gPuhl8gYSlFwgDZHegKN8HatMI8rRwH0drMe2LJNteE9xg8DanRPHkziNKSTbxX
         Itz67dqL7zSJmbN90IP9vwaeXQK5JvdhPYHwVU10UrPncw9rGaSLx6dsnUrr08fcB0rL
         Tk/VkUHqGxD6dsCulyvilE+8+605KrKIpg6vFpxb061oYAyZn/aGDZj/3OU085y0zG76
         pPArB0xvBTDzS74vehA9ptXJOmp8wbyBlIZaCfKE0qIWzefhsTHDWHeWW+7QRGNF1FMX
         +n0A2X96jOYal54/Hff3cu+FzAhacSJNkKkh/tiuzNhxa9cxAatzxmzr7ZQiWz9CqpF1
         kcYw==
X-Gm-Message-State: AOAM530bTjRdil0L/DSp1u0fqgk4rhrxvRfsYIxI6zpg4j4Ce6ZvUNsJ
        9NtNY7TZIi3tAeztoFHXgif851w=
X-Google-Smtp-Source: ABdhPJzV4vkPQLAySDlf1UA0dz/tux3nz3mC6/r1qDLtZPF6vx/pcrf16zqk6y/PVfsPXRlDsO+VOtQ=
X-Received: by 2002:ad4:49a1:: with SMTP id u1mr11985218qvx.245.1595982668251;
 Tue, 28 Jul 2020 17:31:08 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:31:04 -0700
In-Reply-To: <20200729003104.1280813-1-sdf@google.com>
Message-Id: <20200729003104.1280813-2-sdf@google.com>
Mime-Version: 1.0
References: <20200729003104.1280813-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: verify socket storage in cgroup/sock_{create,release}
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Augment udp_limit test to set and verify socket storage value.
That should be enough to exercise the changes from the previous
patch.

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/progs/udp_limit.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/udp_limit.c b/tools/testing/selftests/bpf/progs/udp_limit.c
index 8429b22525a7..165e3c2dd9a3 100644
--- a/tools/testing/selftests/bpf/progs/udp_limit.c
+++ b/tools/testing/selftests/bpf/progs/udp_limit.c
@@ -6,14 +6,28 @@
 
 int invocations = 0, in_use = 0;
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} sk_map SEC(".maps");
+
 SEC("cgroup/sock_create")
 int sock(struct bpf_sock *ctx)
 {
+	int *sk_storage;
 	__u32 key;
 
 	if (ctx->type != SOCK_DGRAM)
 		return 1;
 
+	sk_storage = bpf_sk_storage_get(&sk_map, ctx, 0,
+					BPF_SK_STORAGE_GET_F_CREATE);
+	if (!sk_storage)
+		return 0;
+	*sk_storage = 0xdeadbeef;
+
 	__sync_fetch_and_add(&invocations, 1);
 
 	if (in_use > 0) {
@@ -31,11 +45,16 @@ int sock(struct bpf_sock *ctx)
 SEC("cgroup/sock_release")
 int sock_release(struct bpf_sock *ctx)
 {
+	int *sk_storage;
 	__u32 key;
 
 	if (ctx->type != SOCK_DGRAM)
 		return 1;
 
+	sk_storage = bpf_sk_storage_get(&sk_map, ctx, 0, 0);
+	if (!sk_storage || *sk_storage != 0xdeadbeef)
+		return 0;
+
 	__sync_fetch_and_add(&invocations, 1);
 	__sync_fetch_and_add(&in_use, -1);
 	return 1;
-- 
2.28.0.163.g6104cc2f0b6-goog

