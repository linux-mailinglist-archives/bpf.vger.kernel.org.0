Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221B380E90
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhENRGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbhENRGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 13:06:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE3C06174A
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 10:05:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso22288646qkg.10
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RqPTeGqGrsQWf++frvlQ9XCDHFpfc6beQdPckFB0ivo=;
        b=bezesvg2yUnwuUzgcLMMNFmtSsc0Vlf/aRp26g5kwwUT2M1bBIgjzkdb6I1qx7gQgz
         upUhNJCZEfXCc3W9oAi/WhTBsdOTUkIOwa2Uc6SEEvDK/TIwUSZzZuM5gX0GXuzTADw3
         T5iROxIOdhrJZCmCq1H7ZozKW4WD9z8MWApfzNv1+V7xy28SzSKVVh3CyMUS5RpvqPkc
         H5yy2R6AEyYE6wUFF0MM4Qgd8CQU0OAQU3/vo2rws+3jDp4aT74r2NZyUxljNTDQL9v2
         Kdze6NdgNKoniF3XfP/LR22t7OuF07PIf7J3Y9vmgN1Lr7ddjYia03mp6z4CfQVCiAxW
         9JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RqPTeGqGrsQWf++frvlQ9XCDHFpfc6beQdPckFB0ivo=;
        b=OaRIFJGQVCv1ca7EScjkRA7CILRtEFN0lCpvW2pFa4I6yO6UcQwRAD2wXi7/QaRFxM
         kNtBBA/gdvRja4/SCHs849JGywPTJ9xQYoWOqY5iZdUiT4nWcAE42HVr25R7fotgU2dZ
         Q0E3OEmE6P6LWlSJi1DcN4U59WgpcAviu2pmLhhO5AiCkZ+fqANOTb45nAxb6FBFcC+U
         Q9hnjZr1Kyu741WgLtnu9OBfG6KItNjcT2iJEa/H8ckdtx0tYcNmX+FPl1SpCe0Pnm4i
         Fa0T0UpaCyCQl8EHH9rmRftkT0nGJCKG75Xw0bBkvCxd+ayiP07Zmdxw/ppx6xXmyG36
         rHCw==
X-Gm-Message-State: AOAM533V+1NZnZ9U5nnv5jUtr7+Ql/UnerciKfJbqeBkBxn4yRxZIF0D
        KZRl7r7OdEEZ2LQLTh7NC7gotLA=
X-Google-Smtp-Source: ABdhPJyRDcpzUXkatFe9NGn8mO2Ffe+B4GrZcHFk4Fq7dnDuTheEDsvDDbshhZ/uLJ/gcr/Dtr20rbc=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:2059:2bbd:d7a3:7f6e])
 (user=sdf job=sendgmr) by 2002:a0c:ab88:: with SMTP id j8mr47167970qvb.23.1621011930439;
 Fri, 14 May 2021 10:05:30 -0700 (PDT)
Date:   Fri, 14 May 2021 10:05:28 -0700
Message-Id: <20210514170528.3750250-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH bpf] selftests/bpf: convert static to global in tc_redirect progs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both IFINDEX_SRC and IFINDEX_DST are set from the userspace
and it won't work once bpf merges with bpf-next.

Fixes: 096eccdef0b3 ("selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/progs/test_tc_neigh.c | 4 ++--
 tools/testing/selftests/bpf/progs/test_tc_peer.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index 90f64a85998f..0c93d326a663 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -33,8 +33,8 @@
 				 a.s6_addr32[3] == b.s6_addr32[3])
 #endif
 
-static volatile const __u32 IFINDEX_SRC;
-static volatile const __u32 IFINDEX_DST;
+volatile const __u32 IFINDEX_SRC;
+volatile const __u32 IFINDEX_DST;
 
 static __always_inline bool is_remote_ep_v4(struct __sk_buff *skb,
 					    __be32 addr)
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 72c72950c3bb..ef264bced0e6 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -8,8 +8,8 @@
 
 #include <bpf/bpf_helpers.h>
 
-static volatile const __u32 IFINDEX_SRC;
-static volatile const __u32 IFINDEX_DST;
+volatile const __u32 IFINDEX_SRC;
+volatile const __u32 IFINDEX_DST;
 
 SEC("classifier/chk_egress")
 int tc_chk(struct __sk_buff *skb)
-- 
2.31.1.751.gd2f1c929bd-goog

