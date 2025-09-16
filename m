Return-Path: <bpf+bounces-68551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAFB5A3C9
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910AE1BC82F0
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6F285C95;
	Tue, 16 Sep 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UePHBpda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A527280A
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057792; cv=none; b=YKx8eCEW63gB/j+4zJrNHxV4ogop2Re2CvAyfSDe7GOcYxhV7W23z5uNMVUN1c7lPDDE7dQh0zjPjzYtjsU1A2qjGFnMSbNbC6hGjtnRdbMj34EkImriTccHxRnwBdaGKFizGk3nqBpfTZMD45biSCyGfSqkBoWozfF+/AeHsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057792; c=relaxed/simple;
	bh=MU3rtdGXDtR+m3q1MP92g1TPsDcjUEOZSMcvE/dQekQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o47Ci5D8WREUzPmEyn2YrCeyGXEsJaKmXthxGAyObR3bTW/bzkgjsLXlgscA9i2xbAV7D9V+6uF9SRQw/lPayfa3zPsC2ouVYhjHUPnzImaQTNPjOIarBwPbmX0xVf7koCfsSZXHSC6XS0C9qfO8OKhDDleS/69ChBqxI5BDg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UePHBpda; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25e5e1cd552so29224775ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057790; x=1758662590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0nNzDjiB9EKew4oRdFfJpBLQOFZI1MAQqs/FyiOypw=;
        b=UePHBpda6iKiojcMM2kxDhLnJL/u3tZSgLbiLSzH+UdVIQ5H71eDDTk3Ob0Qr1ycpJ
         Wx/8IX6BvqQHv9Xh3BwsKamTNrwof4Ga4EZMyCxNGUmxX3Iab3uOyvqm4XhtJo1Owkqr
         8onKVlac9x4AmbU8cVyICe9f0yrj4Q9qRZ1HTxhYAi86Xnd8Yr4l6AkyKBnxDO+K8B/O
         2SEJdhwpTbyZOmXBQnrOjFejrf9GEog4CaJBx5fi7L2JGe7/ZwjHBuuZwMMxKRxzRLBE
         gF1kD76nXqHons7rZrBNgjip4tdhX0LU2AaRWutteCGw6XePos01nLjTasOQ4LjKrJlV
         MUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057790; x=1758662590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0nNzDjiB9EKew4oRdFfJpBLQOFZI1MAQqs/FyiOypw=;
        b=PwrEWg1/lLXZJKP/L/Rn0biY7rNW6MBG/GLzdRqA2oXeQV/k7T2JFRjiB4NcNLAAW0
         sx32H/yqekj70HMT+oA4tYOCa4aGhcTL57cUkeh5SAcgnK2+VtaCVLPKwUONs3sc0JT/
         nmLtJqBQWbnTEF7UmeqSgmMPFRsnN2GUIYVw5yNYSzJXsXVRobXl/MrRZb4h/yJi3/Y3
         rumjr4gj85Ym+FQj6O5ZUYJi+LNh+/M6GIj9140dFN47f6/aeEC6SY4EX/XBdyd12M8u
         3bcuCWH8NEGLKkV8EOuDV+ctRgu731oIG5MTLX0y0qIYca5us1I1uTwTUsiFSOYt5G4r
         Lvbg==
X-Gm-Message-State: AOJu0YwaPmbVKt4H9NJ0CvERSWtOuNusy3fQldfRY2INJw8m82I71tl9
	npa2G1FLklg2vq7qReMxHI3V2xXWMH44+6yqaXFUrRC6nkWwggvxQeVeLBYZmKx2
X-Gm-Gg: ASbGnctt/cTbLf7tCe6gQk19CTSQQOYrbP7fzd88hfO1hH3OPi6YJTttfYbQR1LKYDQ
	nRmoNPiODRVqZ9vA0+OhXJJfMEKB2p4WfZYZVlxL3d+BO/6qE0ktJjfSW2ngy2ZY0ZT+AAmwPFn
	KCUD2vQjVgHcAAX7uJcXS1ExEnUtOUT01dryW4JOplvOapKSVzBjzA/OAX7YpIsCMsZ9pqU0Wmp
	/yGGSGU13UA0FNxZHpJWIdc1xtEp/eJzB6Vv1znz6d4I8KbGEA4kEXIIyO33XeFpJKBnZ61meeL
	MiTobWOngZuxxaN8nx07N1nS3NpHVGY/rOID/lQHrihss/drKwqZ6eBF31zzNPrp7Oy8O1vYVs1
	lr8UMmXn1CB8pC6ll1jn47f2oh17OeOT5uKZ/Voj/IOQpzw==
X-Google-Smtp-Source: AGHT+IEN96hk4ELPP5e8CBrFiA0BdD3adgo60+IIBKjsFtMkzuGHfrmcAswGEYImzhmkLtGGe7zFXg==
X-Received: by 2002:a17:903:32ca:b0:267:f4e4:e4df with SMTP id d9443c01a7336-267f4e4e671mr26588475ad.57.1758057789559;
        Tue, 16 Sep 2025 14:23:09 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267df817ef5sm23021585ad.0.2025.09.16.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:23:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for missing bpf_scc_visit on speculative path
Date: Tue, 16 Sep 2025 14:22:50 -0700
Message-ID: <20250916212251.3490455-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot generated a program that triggers a verifier_bug() call in
maybe_exit_scc(). maybe_exit_scc() assumes that, when called for a
state with insn_idx in some SCC, there should be an instance of struct
bpf_scc_visit allocated for that SCC. Turns out the assumption does
not hold for speculative execution paths. See example in the next
patch.

maybe_scc_exit() is called from update_branch_counts() for states that
reach branch count of zero, meaning that path exploration for a
particular path is finished. Path exploration can finish in one of
three ways:
a. Verification error is found. In this case, update_branch_counts()
   is called only for non-speculative paths.
b. Top level BPF_EXIT is reached. Such instructions are never a part of
   an SCC, so compute_scc_callchain() in maybe_scc_exit() will return
   false, and maybe_scc_exit() will return early.
c. A checkpoint is reached and matched. Checkpoints are created by
   is_state_visited(), which calls maybe_enter_scc(), which allocates
   bpf_scc_visit instances for checkpoints within SCCs.

Hence, for non-speculative symbolic execution paths, the assumption
still holds: if maybe_scc_exit() is called for a state within an SCC,
bpf_scc_visit instance must exist.

This patch removes the verifier_bug() call for speculative paths.

Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/68c85acd.050a0220.2ff435.03a4.GAE@google.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..beaa391e02fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1950,9 +1950,24 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 		return 0;
 	visit = scc_visit_lookup(env, callchain);
 	if (!visit) {
-		verifier_bug(env, "scc exit: no visit info for call chain %s",
-			     format_callchain(env, callchain));
-		return -EFAULT;
+		/*
+		 * If path traversal stops inside an SCC, corresponding bpf_scc_visit
+		 * must exist for non-speculative paths. For non-speculative paths
+		 * traversal stops when:
+		 * a. Verification error is found, maybe_exit_scc() is not called.
+		 * b. Top level BPF_EXIT is reached. Top level BPF_EXIT is not a member
+		 *    of any SCC.
+		 * c. A checkpoint is reached and matched. Checkpoints are created by
+		 *    is_state_visited(), which calls maybe_enter_scc(), which allocates
+		 *    bpf_scc_visit instances for checkpoints within SCCs.
+		 * (c) is the only case that can reach this point.
+		 */
+		if (!st->speculative) {
+			verifier_bug(env, "scc exit: no visit info for call chain %s",
+				     format_callchain(env, callchain));
+			return -EFAULT;
+		}
+		return 0;
 	}
 	if (visit->entry_state != st)
 		return 0;
-- 
2.51.0


