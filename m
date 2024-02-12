Return-Path: <bpf+bounces-21798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AD852290
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CBD284288
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809194F5FE;
	Mon, 12 Feb 2024 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGWddIQ7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F93A8C2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780751; cv=none; b=GyxhQ43eXT73SNZzZrYnvR55Et/iaRo37zxDWNL7qel/yWSQwIwCOIqTiZYq7rm/KK/6kYGot7EjrfNY8UyvgWMeAIUySJBZqeZ52pfK2jjZP6UrpGroVxWJvEkYT0Aptd25kf2E1qs2+Eu2zj9LPhGKdIXbK/5xDNCbwp4wwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780751; c=relaxed/simple;
	bh=hTePFMj87bd5J1h3gKIsd5JNLguhvEIR5DdTpXIpzyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKzpxzsmC+HbGeFPGSLIjwN26FUHNTXR0r61meqCANM1Fc5PSRH/r9lCDV7l7YNOFrOrlfpEH22eZzxaFBsA0u1zoM5X4e6eN6wU0vLY1CBAc+uTmU59jAI7gRyBLcpd9Nug0SeEuB26Bh4/OhH7lBgUpE+Pwchl0/q0nJmQPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGWddIQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55430C43390;
	Mon, 12 Feb 2024 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780750;
	bh=hTePFMj87bd5J1h3gKIsd5JNLguhvEIR5DdTpXIpzyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGWddIQ7KNE+XGdPA1AS+oulan+hVx0MBVsysPyfYAVOLqgBD8ZftPFEBjkiQeXLt
	 Pk4ePLHTNRUosVB2p3yOKVHyhpmOOkp9sCFQojGCNvnWxRZUhMXkH3NrukxUTjOpXo
	 Mkd7wH2RaCtV3ac4Z/D2ryK0ETtrdb+gGKF914PlvirGvIpZv6KCj7aixcF3HhajaI
	 X4rXur3ocuKVhtH3MP3b4SZ4FQXfCzeGXiD+6UtGoZ1sTvOYCmMs+6N6x0Nsz9ei72
	 jWZzvyCC7HL7wusK9IXOMkMpIzYyvBNmyU31LZ1jehMaYEM7OGujqT+z1VAPqfvzr0
	 IuY71niGAp3hA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX global arg
Date: Mon, 12 Feb 2024 15:32:19 -0800
Message-Id: <20240212233221.2575350-3-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expected canonical argument type for global function arguments
representing PTR_TO_CTX is `bpf_user_pt_regs_t *ctx`. This currently
works on s390x by accident because kernel resolves such typedef to
underlying struct (which is anonymous on s390x), and erroneously
accepting it as expected context type. We are fixing this problem next,
which would break s390x arch, so we need to handle `bpf_user_pt_regs_t`
case explicitly for KPROBE programs.

Fixes: 91cc1a99740e ("bpf: Annotate context types")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f0ce384aa73e..da958092c969 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5695,6 +5695,21 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	const char *tname, *ctx_tname;
 
 	t = btf_type_by_id(btf, t->type);
+
+	/* KPROBE programs allow bpf_user_pt_regs_t typedef, which we need to
+	 * check before we skip all the typedef below.
+	 */
+	if (prog_type == BPF_PROG_TYPE_KPROBE) {
+		while (btf_type_is_modifier(t) && !btf_type_is_typedef(t))
+			t = btf_type_by_id(btf, t->type);
+
+		if (btf_type_is_typedef(t)) {
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (tname && strcmp(tname, "bpf_user_pt_regs_t") == 0)
+				return true;
+		}
+	}
+
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_struct(t)) {
-- 
2.39.3


