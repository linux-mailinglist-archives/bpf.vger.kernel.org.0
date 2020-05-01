Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4205C1C20DB
	for <lists+bpf@lfdr.de>; Sat,  2 May 2020 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgEAWnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 May 2020 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgEAWnW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 May 2020 18:43:22 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C92C061A0C
        for <bpf@vger.kernel.org>; Fri,  1 May 2020 15:43:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h186so11683220qkc.22
        for <bpf@vger.kernel.org>; Fri, 01 May 2020 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hPopuAbrlmDsANSXoPS/PnMAqzIuG9U4bFV/yQD4WPs=;
        b=osNjIOxDjuzqW8qj8TELt/+bUWdiy5cmqDEc1FO9Vn4B37Mv6y1qrrgvJgr2aP4ATF
         +FsPWJ3c0RbiWpkCFLCucJLJchpN83IK2kBvcIRqVG7fwwjluABt2vyFrIjgIt1HLZhG
         M0kFfAzxIe4l1FPf57Y4YAZpmkvKis/LLS63trRUGGIfGsux8fcp5ZynPfU+eZRifqX0
         iHFaQQQ7LOIuisqcuoCqShPmCHzK0uTJ+Rg9SmIWHvjR1BSD+F/8zLz8XPDRamI4c4zx
         he7CV/UFxDoUeFbvamO7PeRCyIURtLQvJVbF/I7bjlefvjEv6k1WZPa2C+gV4w8Ov+3j
         tfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hPopuAbrlmDsANSXoPS/PnMAqzIuG9U4bFV/yQD4WPs=;
        b=AErRTpTHMfSxLwxB/3MSJUh8WmglvnJMT3OePCerNGIgB07+pJZpYI+2VgJbpi8l19
         S5GiQnWTVXf2W5OCKTUzy0AffSKcRsK84haipoov9ARDrlq0AO/EDLzVon1Zng6n54zV
         a5KjgiKqmxfNMzaYtu6Ul8iKxECiL1mgi4HSppRRp8ENUCtxUzVIxyPpNlA1jbDBCdhh
         VSazQPbPYjPfByMlGvsra5t7c7ccFkpVEI6cXFncWSR6otxBPc9H6r4CtLLko/nPAlbz
         K1WEGvEmvNRofk67lYTo5bL4pmoTkL31n6KoKOaXe7Zh3QWx3HfLrqsInQ9LxIGB5E1T
         4VmQ==
X-Gm-Message-State: AGi0PuZxrczXz9XhUAJ5azLWBstxnmN3syYsGR2aEqt5/m9mZSjI4Z86
        MPU4ZJxyHlN21moU0XfqyfASpNI=
X-Google-Smtp-Source: APiQypKoYKEOuZ8b1jDi8uTsR6ZTp/BZEofSFZyymt+b6pnE4/6ia65lDN/XDXJS7h/+OO2vpqaLtd0=
X-Received: by 2002:a05:6214:1262:: with SMTP id r2mr6284830qvv.126.1588373001796;
 Fri, 01 May 2020 15:43:21 -0700 (PDT)
Date:   Fri,  1 May 2020 15:43:20 -0700
Message-Id: <20200501224320.28441-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next] selftests/bpf: use reno instead of dctcp
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey pointed out that we can use reno instead of dctcp for CC
tests and drop CONFIG_TCP_CONG_DCTCP=y requirement.

Fixes: beecf11bc218 ("bpf: Bpf_{g,s}etsockopt for struct bpf_sock_addr")
Suggested-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/config                | 1 -
 tools/testing/selftests/bpf/progs/connect4_prog.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 6e5b94c036ca..60e3ae5d4e48 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -37,4 +37,3 @@ CONFIG_IPV6_SIT=m
 CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
-CONFIG_TCP_CONG_DCTCP=y
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 972918cd2d7f..c2c85c31cffd 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -59,12 +59,12 @@ static __inline int verify_cc(struct bpf_sock_addr *ctx,
 
 static __inline int set_cc(struct bpf_sock_addr *ctx)
 {
-	char dctcp[TCP_CA_NAME_MAX] = "dctcp";
+	char reno[TCP_CA_NAME_MAX] = "reno";
 	char cubic[TCP_CA_NAME_MAX] = "cubic";
 
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &dctcp, sizeof(dctcp)))
+	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
 		return 1;
-	if (verify_cc(ctx, dctcp))
+	if (verify_cc(ctx, reno))
 		return 1;
 
 	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
-- 
2.26.2.526.g744177e7f7-goog

