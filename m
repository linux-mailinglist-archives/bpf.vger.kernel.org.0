Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3A715D8
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfGWKPv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 06:15:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34579 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfGWKPv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 06:15:51 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so25886444pfe.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h7dsUuY4XgkJrRpU//tPdbDW3VQMrwX3cEPK49aoW3k=;
        b=A6zgmMm9WbUycg22ml8plJHz5SO7tE5NzLs68G+UB7ZBg8EEC6XfiQ8P8xB9wnOYVm
         RlpA7V9i8lJv+cLpVgCe4fC/h1Q/gr50/RTnLWyfs7a872TsHqE4JXFpSy/iem7u2O76
         utYfJjJbXuFbYB45hgszstotN3ptHtRIhHd7vDy63kqb7FTk3bFUU5Vy9fpHGWdGq22l
         /AeySlzvSSBd0AR9D+8zidJK4Lsr4lADoYNKZ5VRxq9Y6K1GYNB/n8sxkHQOJZQ3sMif
         em6H1Ia98Uv/5RjfZcreyhdDwLv+bO1a8MVG593Di2QXNdV1n1PMoevvdLP9ExhiY3Vg
         jDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h7dsUuY4XgkJrRpU//tPdbDW3VQMrwX3cEPK49aoW3k=;
        b=AEeRIFHthIDwk3jf74KE4SrrdWphMIMvJkVhkNgiSRzyCdwMXvxd8uwJGKbNjx3ex2
         GteExMJAo89eRD5I1ZSvHjXC5taOPaGqyXKl/BoLEMWQMWrKVhl9An5zg4evKPwial37
         gZGg1j56ULkCQi1WsTFNmHiUCM/WSDbVZz+LFlMKs7jpN/8I8dGcIKtUtLUTav7W9FCj
         +xKCIgFL8MET140WnDTSebZ/lKk+XEqeOs8L8QhzW8jdP+t7OxxS3syW1dl0TafQKVsv
         eMSZTA2NKISJNczz9AL/Va832/ShXtxLgCNdDqCwsBWT2UZl7TpYvksgYMqlgofQfxM2
         n8Vw==
X-Gm-Message-State: APjAAAVfx6Xa8i3fxdghY21joOvmli+McmcxotfrtoKRDjItuAUuk3z7
        DCv4nr5HkiAMQ1Imr+gTfZczLTxrZt4qXw==
X-Google-Smtp-Source: APXvYqwvjeWio7ylwSxyvRjLzjXom8IC9uRyVyoj/Wm7PsJSHz4Kg6ZGjXpcFwuZrM+qkvTQWaIV8V4sbongvA==
X-Received: by 2002:a63:b555:: with SMTP id u21mr77094873pgo.222.1563876950294;
 Tue, 23 Jul 2019 03:15:50 -0700 (PDT)
Date:   Tue, 23 Jul 2019 03:15:38 -0700
In-Reply-To: <20190723101538.136328-1-edumazet@google.com>
Message-Id: <20190723101538.136328-3-edumazet@google.com>
Mime-Version: 1.0
References: <20190723101538.136328-1-edumazet@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf 2/2] selftests/bpf: add another gso_segs access
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use BPF_REG_1 for source and destination of gso_segs read,
to exercise "bpf: fix access to skb_shared_info->gso_segs" fix.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/verifier/ctx_skb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index b0fda2877119c4af08277bd0f329f238c193313c..d438193804b212ffa80c94be47e8c1aca392181e 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -974,6 +974,17 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
+{
+	"read gso_segs from CGROUP_SKB",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
+		    offsetof(struct __sk_buff, gso_segs)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
 {
 	"write gso_segs from CGROUP_SKB",
 	.insns = {
-- 
2.22.0.657.g960e92d24f-goog

