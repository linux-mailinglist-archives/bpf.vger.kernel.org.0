Return-Path: <bpf+bounces-52018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D206A3CE88
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C917A264
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543B18E025;
	Thu, 20 Feb 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwYCmzhz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35D2AD16
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014399; cv=none; b=HBI9Km/V/ECEcsJrff2GdOd73Oo1XXP0xUJW+SdfS8kAIYw5uv8CK1WnemY3YX5TjlL9kpGBHsS6U295b4yQqgYHQFWGlX8biISLPHKP2fIrO3/yqUKOrK6MK1JI9/pn1nlNDc9/SGld2lf6sFXMTtcGIvcNmXNbhVSVWtx6hhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014399; c=relaxed/simple;
	bh=y9TqtEwuxAM59+pRGkNPZtMDonN/O6t9RwUUNszlNTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9S4jrqtrpaYMf6L+Oz1oOPo+z63UZruKHJfnJBCIxlrX+cCooercHRQZ/QSBy4aQjwjGvqIRrkF8tWOhfQtiy3VLhWOiYUax4mzF8OcyG0n4aSH/vThWJlmX4fIwWiPkagZhxjQpVFfaupnctCccUQvcRJjQmSZn2E6Ui5M40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwYCmzhz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d1c24b25so7439935ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014397; x=1740619197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUnHgSEounregn05uHGT75nqn32OY7tna6KiTBpIBWU=;
        b=YwYCmzhzZWgCqBpx3vZER5zzlcVQ7m7ocpnsxeGGcvSoX37Sso43YH/QEThOgxoJRZ
         gdnGmMTLgo+RzwcVTSDSb2+/iui9mlKQHpUj2kUdlrGFaUsHFHVWhLNdwy87YYVctg0d
         5Ghx5zxCLA9Z1sPknlH8proQNJPzIVwLBT7L3cVa5Du57h0Oda0IsuSpUgMfakOTq/rZ
         6phmWtnP2F1+1SxqWMgrhEr2pxL/as4dOhkmY48zPBO+kyjrAKZitAw7yC14udwx3RFr
         leJX6kKrw4Ze9seyrhd8bsnhj1ARgZlKPOqmDkApPL6NPGsvZuvBHpKvrsabvo2UU+r4
         oY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014397; x=1740619197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUnHgSEounregn05uHGT75nqn32OY7tna6KiTBpIBWU=;
        b=IGeqf2BgmLJbgow6cjtBX6SYDlpo4/QpCC1bJHJFhQB0F6AmLqd8HaJQHNXbiUrZKI
         cYER2FK+kWjV4zv9nI2pzXPR55VGVnlFa5yANIVMKSdCIaErPujQf/1qRXummV2BxAyy
         0dK8EN7hb1vBL//DFqJKvaejF0sw51JN4sYMnBba1U/Qsth+2hPR20Ijht7TxOonQckq
         DtPGnglXFT8s1P0alLe3cp/eHafXvYBjomyEGxomfj/0KociPk77G0DJWEfERKmCRmSW
         TrRgMNnBWrwZ0Crvg08kx6cbkDYgKXDzSBQdlTP+O7u1ttezqw9FxGv2Fwg6CXj+Ww57
         zy2g==
X-Gm-Message-State: AOJu0YxApwqvZ9uItuNu7DCkX1gS5nLRAkfv7OdS+mpfdcIy1gcleadT
	RZ1pJOillrscT2roxGcAb2yE2Z+nZXg7EWt8XF0LhVBcoPJgSrLEmiMkgyTOivceRAn7g/aRq92
	tZrtTWrXNVtrLgtiG0D2+0qGND4bihRnpqjjkgMZcmHnjXgOo/mZb3+eDq/EcFy5QXx+OqR6F9y
	a2fIq7WgljrMv4QxaZ3TpzgvKLVOKZKVtTOkSpMj8=
X-Google-Smtp-Source: AGHT+IGMFdx8KCQOyowQ5w7kdzLzapH1OG1g0TKzCE06XDnQiClJ/IBLT/uScVtfAiDmrUICsMmVFXpFWBIDzA==
X-Received: from plky4.prod.google.com ([2002:a17:902:7004:b0:220:d272:cfbe])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec89:b0:215:6b4c:89fa with SMTP id d9443c01a7336-221040137ffmr260028595ad.8.1740014397157;
 Wed, 19 Feb 2025 17:19:57 -0800 (PST)
Date: Thu, 20 Feb 2025 01:19:53 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <58c5d8d587948922f257ca4735b4eb9518a191cd.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 1/9] bpf/verifier: Factor out atomic_ptr_type_ok()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor out atomic_ptr_type_ok() as a helper function to be used later.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e57b7c949860..21658bd5e6d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6194,6 +6194,26 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+/* Return false if @regno contains a pointer whose type isn't supported for
+ * atomic instruction @insn.
+ */
+static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
+			       struct bpf_insn *insn)
+{
+	if (is_ctx_reg(env, regno))
+		return false;
+	if (is_pkt_reg(env, regno))
+		return false;
+	if (is_flow_key_reg(env, regno))
+		return false;
+	if (is_sk_reg(env, regno))
+		return false;
+	if (is_arena_reg(env, regno))
+		return bpf_jit_supports_insn(insn, true);
+
+	return true;
+}
+
 static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #ifdef CONFIG_NET
 	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
@@ -7651,11 +7671,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}
 
-	if (is_ctx_reg(env, insn->dst_reg) ||
-	    is_pkt_reg(env, insn->dst_reg) ||
-	    is_flow_key_reg(env, insn->dst_reg) ||
-	    is_sk_reg(env, insn->dst_reg) ||
-	    (is_arena_reg(env, insn->dst_reg) && !bpf_jit_supports_insn(insn, true))) {
+	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
-- 
2.48.1.601.g30ceb7b040-goog


