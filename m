Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9991B69933
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfGOQkJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 12:40:09 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37414 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbfGOQkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 12:40:09 -0400
Received: by mail-pg1-f202.google.com with SMTP id n9so7396873pgq.4
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2019 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4/lhOxHYSoVa00N4hV5HTOW6iAH34TOVHfJ1YdAnqVc=;
        b=HiG90D6OKwsznGztDnHSD5e2gM8jEansA4ZG1AXELsO2+QnASoFDxqACN9HvFQHDDr
         taSj9ZJy61b9SNMntah4yrJqr3xNhS7SfALtKljW/cREzXZq8lS7Lr4+TXzYMT6BsIqF
         Qh2HdAhljZRd9Gdp+Ge2QGnm2Lc8mPBXttYG5oN02MOSVqXo2hxW2dfMiqN5foJ41OQQ
         1RnnCMIJobHFI4x7PvpQuAibUbvhZL1mF9gfUfCWqKlARXsP7WDHXEVs0VxWICkuSHjA
         ktje1D0zo+/Mho/klTq/4OeKBpvdkezm+nkPKLx0ye10OaxTxzsXLEUZf3HOGr5U1Ilw
         Ihpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4/lhOxHYSoVa00N4hV5HTOW6iAH34TOVHfJ1YdAnqVc=;
        b=lFnqiMYS7Dy61+CJtv/KGBI59r0G5qr8o25JNWSNiU8hTsI2JDepD+YwoMM7cPeh3G
         5fjvAMDVj+tT8aeRZEpp924bMGZuyD7M3XOrGQV8rtfF5NM5htjonf6v7AIhppS8i3RX
         /DXMRcU/gOiZyyElk7NxsaNNX/UiiuPnbPWY8HYV+S0PqN3N91OavUiEguC8IXbTtSb5
         6uYUSau+GkHO0IiBTqHwCnGGOEUOCfIdr1SB0rPOMPQty+d8EZ0lpc26I+E/2MyxEsFr
         P8oST6L4LCNRHs3wV9r1n913C/A68L87fHD7rluUhuYKGJGIfh9YROxVyQZ8nFvOyOWg
         vc8Q==
X-Gm-Message-State: APjAAAUR9k2CVTPE5lxb1ZQpALzmSQ6JwlK8pIbt9b+dIpq3pKVZD7YP
        e1q4Bqu7HmvLQX4DBl1eAOjWi3I=
X-Google-Smtp-Source: APXvYqzhp0sVGa8TEkl0+a7QDelm+b6vnwU2eObG+o6sjXihgr2lsRwaOEiI/802/Co6yHx5aX6znjQ=
X-Received: by 2002:a65:42c3:: with SMTP id l3mr27762384pgp.372.1563208808427;
 Mon, 15 Jul 2019 09:40:08 -0700 (PDT)
Date:   Mon, 15 Jul 2019 09:39:55 -0700
In-Reply-To: <20190715163956.204061-1-sdf@google.com>
Message-Id: <20190715163956.204061-5-sdf@google.com>
Mime-Version: 1.0
References: <20190715163956.204061-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH bpf 4/5] selftests/bpf: add selftests for wide loads
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mirror existing wide store tests with wide loads. The only significant
difference is expected error string.

Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/verifier/wide_access.c      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/wide_access.c b/tools/testing/selftests/bpf/verifier/wide_access.c
index 3ac97328432f..ccade9312d21 100644
--- a/tools/testing/selftests/bpf/verifier/wide_access.c
+++ b/tools/testing/selftests/bpf/verifier/wide_access.c
@@ -34,3 +34,40 @@ BPF_SOCK_ADDR_STORE(msg_src_ip6, 3, REJECT,
 		    "invalid bpf_context access off=56 size=8"),
 
 #undef BPF_SOCK_ADDR_STORE
+
+#define BPF_SOCK_ADDR_LOAD(field, off, res, err) \
+{ \
+	"wide load from bpf_sock_addr." #field "[" #off "]", \
+	.insns = { \
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, \
+		    offsetof(struct bpf_sock_addr, field[off])), \
+	BPF_MOV64_IMM(BPF_REG_0, 1), \
+	BPF_EXIT_INSN(), \
+	}, \
+	.result = res, \
+	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR, \
+	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG, \
+	.errstr = err, \
+}
+
+/* user_ip6[0] is u64 aligned */
+BPF_SOCK_ADDR_LOAD(user_ip6, 0, ACCEPT,
+		   NULL),
+BPF_SOCK_ADDR_LOAD(user_ip6, 1, REJECT,
+		   "invalid bpf_context access off=12 size=8"),
+BPF_SOCK_ADDR_LOAD(user_ip6, 2, ACCEPT,
+		   NULL),
+BPF_SOCK_ADDR_LOAD(user_ip6, 3, REJECT,
+		   "invalid bpf_context access off=20 size=8"),
+
+/* msg_src_ip6[0] is _not_ u64 aligned */
+BPF_SOCK_ADDR_LOAD(msg_src_ip6, 0, REJECT,
+		   "invalid bpf_context access off=44 size=8"),
+BPF_SOCK_ADDR_LOAD(msg_src_ip6, 1, ACCEPT,
+		   NULL),
+BPF_SOCK_ADDR_LOAD(msg_src_ip6, 2, REJECT,
+		   "invalid bpf_context access off=52 size=8"),
+BPF_SOCK_ADDR_LOAD(msg_src_ip6, 3, REJECT,
+		   "invalid bpf_context access off=56 size=8"),
+
+#undef BPF_SOCK_ADDR_LOAD
-- 
2.22.0.510.g264f2c817a-goog

