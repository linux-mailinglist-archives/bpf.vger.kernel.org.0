Return-Path: <bpf+bounces-68308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843AB56395
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 00:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70911B25CC6
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025E2BEC4E;
	Sat, 13 Sep 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9RXjM+z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341F2BE652
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757802251; cv=none; b=IpOqOpz1T++lom/8EWqDpISxsLJHaxFneNlSc28HLwx7N+nXAMp13J79oYt8d+o0paDWX3FofGxfUmrlbCDgAbWtWKLpZGL1UbfSq6e+53qmQjfI+QWxr/I6dQulx4fwGGosYxa5NRBRFEaLOS+Se1ZRMXcPZu5Rj8h2TmD+Pps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757802251; c=relaxed/simple;
	bh=6MnyGHDG1rusY3NQB0hLrFzipj3IpjlxWbVDL92fm/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZlD4Ky11ZjUlUwKkPPtbRyMIebTe67hzpkRyeZIsLGtgRIP/w3aSqGJ93SHoOmlR5tS7IbzqsWyQQltWqbQMS7jEC3VzqFWw/EQxMht3c5gui5O2KLG9FFRTVNtJ0h3RNNICo6L0OOtRhtrxhUTytxathXGsmjIspATxg8vNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9RXjM+z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761578340dso2178821b3a.3
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757802249; x=1758407049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNusiAJMG1RTzATvkpKjGZWnI3GIvk3GTQ3dPlhq+mM=;
        b=l9RXjM+zBqZhFvQKLgj/fwOK5WtpqpsXnECCs6TmN/JFZ4WK0X+BA0vg8k3j6zEpIj
         vO2tPj62fYM3Cc3oiRQ+8FV/1vDRBlUpLcyLn3/FlkL7jEe+72rPA3XtDxDfYWVlqLhh
         kQgvreozYzmX6F8Q60hVRx1P4IC9DawNMgFu/0DsK4peO8ps/Y1oHJsTqXFf5f/4I6+T
         hKNKzIu0KsimS95l7lKO4aOHcHTDMqrnJAJzswI++nVupQGVNmWenSR8FW6kXi5SYwVp
         A3eNEiIEuK4Jm2QnRXXqRvDSP1qJZoJF3h4l4dm4mBF7Wb0fIedEqhdRNxopDCs3fjvG
         gDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757802249; x=1758407049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNusiAJMG1RTzATvkpKjGZWnI3GIvk3GTQ3dPlhq+mM=;
        b=ZwP4DChzWOZi5cHAt9t4Lh8XgRkejpvl2xos0/uNSFweSAtLttaWPTJsM2Mrhis4J1
         1G4+QDbo/M+PlO9UtGgRjyfA3MTqmLSlImRbQOQySv0ih5SHKi7b9nF7bnFide4Oo/uT
         XzhQxzPJBZ0E3HYV7YmOT2MQ/uBBfFPcqo5z7J8D/vLk/FLBt5qScDXYaQUah/8hj47k
         urMGVuDe33BNIfEYfoDqtPxJgRrsujKIO7rbHmKgb3oVfYMxfqIK/so4z4ZQB/M0wUp4
         qcuCb4Q/MFkRvjoyPIzinztJCW8U5Wnqh3WYhcNY5t9uGkluGrYIho2ThQlOx6Hnnm59
         mPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ24gpclKQMqz3y3JnvvHGhtBBESHTbr80UgpTcidIrWpWOplgEYaW1+6CW0vGPH1XFNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IrIa0QIKkhLYFwd4+h/yjGs1S0WsAh+VQSNJ3YPhhM3eSFm2
	4gQZRSwFMx6C0n0qUT1ufQxY0nVUO37eW9Te+0j4Dfosafg+WGQdhcCW
X-Gm-Gg: ASbGncsMlf3+3ZVvK11ssrDTCTTBKS5udEJFf4FDqNJ7w4LlJ35GSCKtH2hAsZQHdqo
	+/lgR422e6DHsuV3t5V4ACEykuC42wWoZRSpC1UWnZDFd992jLpwnEXx0FQLlIO3NVvuyTH2m+N
	Z1U5L648Vxrjb4XAcWtf4iKuggm0KXOEGCW84IrT1nlHyhuxNUO2PLt6QzFBvvWX3ywwl9lrm9N
	RNAlBv4qN5dlb1QU0ZYRC67BkLc0zxhMDl7hHuacEpcUObi4SiOm3ScMnctof8o0dhs12J/vjGq
	aUmUfrjX2GDX6xW8wY7CITF2vgMY4UqCBnILG+MAxUjs1i58vbX9gMTvovWDZD/6RoFtqgXWOmA
	l7SQ0YqQ+aHkYusKdlrsfRIhfq7USAiPCEDm6fqdSDlQj2wa+/emhPdwx5EQ1n1biGHB34/Apby
	43/m10QGrRJ6uPynvpTXhXRmfbHH356Sl4JKjX
X-Google-Smtp-Source: AGHT+IH/5SIKYW4a2UvOEi85RoAgE5wgtLyQpdm4OPJOd59TSMw/eqJBPBbkFEJjKYxCPxkTuc8E/g==
X-Received: by 2002:a05:6a00:4b49:b0:776:21e4:23f with SMTP id d2e1a72fcca58-77621e40333mr4826900b3a.15.1757802249130;
        Sat, 13 Sep 2025 15:24:09 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793be6csm9326449b3a.14.2025.09.13.15.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 15:24:08 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Subject: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
Date: Sat, 13 Sep 2025 22:23:23 +0000
Message-Id: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sanity_check()
due to inconsistent umin/umax and var_off state after min/max updates.

reg_set_min_max() and adjust_reg_min_max_vals() could leave a register state
partially updated before syncing the bounds, causing verifier_bug() to fire.

This patch ensures reg_bounds_sync() is called after updates, and additionally
marks registers unbounded if min/max values are inconsistent, so that umin/umax,
smin/smax, and var_off remain consistent.

Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..8f5f02d39005 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	}
 }
 
+/* Ensure that a register's min/max bounds are sane.
+ * If any of the unsigned/signed bounds are inconsistent, mark the
+ * register as unbounded to prevent verifier invariant violations.
+ */
+static void __maybe_normalize_reg(struct bpf_reg_state *reg)
+{
+	if (reg->umin_value > reg->umax_value ||
+		reg->smin_value > reg->smax_value ||
+		reg->u32_min_value > reg->u32_max_value ||
+		reg->s32_min_value > reg->s32_max_value)
+			__mark_reg_unbounded(reg);
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg and
  * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
  * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
@@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
 	reg_bounds_sync(false_reg2);
+	__maybe_normalize_reg(false_reg1);
+	__maybe_normalize_reg(false_reg2);
 
 	/* jump (TRUE) branch */
 	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
 	reg_bounds_sync(true_reg1);
 	reg_bounds_sync(true_reg2);
+	__maybe_normalize_reg(true_reg1);
+	__maybe_normalize_reg(true_reg2);
 
 	err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
 	err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
-- 
2.34.1


