Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955152854E1
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 01:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgJFXRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgJFXRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 19:17:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BCC061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 16:17:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h8so119614plt.12
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VySQMLcpvwdaQwxN1j3WmXvvfiQlhoZC1gK89XJ/g5w=;
        b=SXgcLOEhtgtayhfk/lI0LBIgpNCwL5GxWEYnx5/x7x+FfcRLqVsVg43/aCmz81P61b
         uzmuYKxe0U3RIMMxcNfHKbnUQ4v+9/2KD4FyPA9HntrB32AbeZdxcd+s6ygX/YTiEs1i
         TwsXdL73ffPOef03BW4xzZsAZU4hckfJMwrWByq4/7bBS5fBLHdKaT/qbzaBA/qVZ34u
         QuuLT7mStF19IB+0oZimzsivfU89yKoLoxBTXQXDFqHBvhYA12vM2Feg/b5MoPEuFOPE
         tWjLdjxG+oVYL5iGo/NiASKkutdCTKO8tSoPzWc2X0AU5LTtwUT4Yj2H+m6r/W8Q9y/2
         fdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VySQMLcpvwdaQwxN1j3WmXvvfiQlhoZC1gK89XJ/g5w=;
        b=NrMg9v6TXTV/vN6yn2/LSGDMhB+Q35UYTV59bhJmWwpo3BvtHjR6qHfVWw18EhBPwq
         UTPaDWhRL1pbkVbrsvHWNE5++a3T2Oiill2XsNGtqCo0UQFK5WYzeTWQRLd/r3LY0FlT
         xvBTebpDFEfNl9ygG4KFspBcLMjVOmpoifMowkLxT8TXqiDO3tRlbCfiLK51hwU/CaUZ
         RDmCLIxitvTUkTXfxZadj2B6xmyyAbsyh+TOzh1iNjXGtyaIibvycVga9qdVHu9dIqwe
         c0L73B5c0Dgl+aryx26URNzNRx/rAlHvSdNWb2X8rEAKydSrMGfJpT4Ds9MSGwHqbv/3
         7oPw==
X-Gm-Message-State: AOAM533uNa8E3XEGn31Ca5LkRmZFxPW6Qe5qbFBxCKAQUFJmfwO1W4oj
        p4JJxfxPcgA1v4ehT2cYi/kuO+csWog=
X-Google-Smtp-Source: ABdhPJzTFN3yuwQqJWyMD96v7WuoK0hZd60QG8joPjfL/EAKrjL9X0KXv86U4SMONrsWCK0OBT1RHhjrNyQ=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a17:90a:c706:: with SMTP id
 o6mr359030pjt.185.1602026229067; Tue, 06 Oct 2020 16:17:09 -0700 (PDT)
Date:   Tue,  6 Oct 2020 16:17:06 -0700
Message-Id: <20201006231706.2744579-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] bpf: Fix test_verifier after introducing resolve_pseudo_ldimm64
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 4976b718c355 ("bpf: Introduce pseudo_btf_id") switched
the order of check_subprogs() and resolve_pseudo_ldimm() in
the verifier. Now an empty prog and the prog of a single
invalid ldimm expect to see the error "last insn is not an
exit or jmp" instead, because the check for subprogs comes
first. Fix the expection of the error message.

Tested:
 # ./test_verifier
 Summary: 1130 PASSED, 538 SKIPPED, 0 FAILED
 and the full set of bpf selftests.

Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/verifier/basic.c    | 2 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/basic.c b/tools/testing/selftests/bpf/verifier/basic.c
index b8d18642653a..de84f0d57082 100644
--- a/tools/testing/selftests/bpf/verifier/basic.c
+++ b/tools/testing/selftests/bpf/verifier/basic.c
@@ -2,7 +2,7 @@
 	"empty prog",
 	.insns = {
 	},
-	.errstr = "unknown opcode 00",
+	.errstr = "last insn is not an exit or jmp",
 	.result = REJECT,
 },
 {
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index 3856dba733e9..f300ba62edd0 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -55,7 +55,7 @@
 	.insns = {
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
 	},
-	.errstr = "invalid bpf_ld_imm64 insn",
+	.errstr = "last insn is not an exit or jmp",
 	.result = REJECT,
 },
 {
-- 
2.28.0.806.g8561365e88-goog

