Return-Path: <bpf+bounces-19085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482F824C0A
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EC7287293
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B819810;
	Fri,  5 Jan 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHvs2Iiw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408DA32
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D42BC433C7;
	Fri,  5 Jan 2024 00:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413358;
	bh=4p3xtUlbEwADr2WgRkU7C56YHHqKCp4YFEXGZPE9v88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHvs2IiwOZRjJQ0got+7Sr/04SC8kD7qSgtUxYWPSZPFTOLdVogv3nhIlsUGQPXcK
	 SkTQaTBcDFSJ9lPSaasetTjf4ug3jpn161jkhzjr99npH6P9y0sruvlxkoW+nGR30w
	 SbhbZmc/cqIW9wlk41YBaIb4ylBfi/ozdkHGgtx/3DBZpkzOmvNcyRu6RjmpAyxDgJ
	 8XKwmY3csuRw5rOQ/QJCyWdgRkaqiEBsJxBLfRZtKM8S6Qz/FFveygQ73Pn3FNtZEI
	 rNEOD200QlyfwMUkAkP2OJDlFy/h9YjnqwnwiH7ILWuMGnQuYNzZbknIUb+2rekKpI
	 9PJgxHgWZHedQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 2/8] bpf: make sure scalar args don't accept __arg_nonnull tag
Date: Thu,  4 Jan 2024 16:09:03 -0800
Message-Id: <20240105000909.2818934-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move scalar arg processing in btf_prepare_func_args() after all pointer
arg processing is done. This makes it easier to do validation. One
example of unintended behavior right now is ability to specify
__arg_nonnull for integer/enum arguments. This patch fixes this.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 51e8b4bee0c8..47163cb28b83 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6896,10 +6896,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 
 		while (btf_type_is_modifier(t))
 			t = btf_type_by_id(btf, t->type);
-		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type = ARG_ANYTHING;
-			continue;
-		}
 		if (btf_type_is_ptr(t) && btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
 			sub->args[i].arg_type = ARG_PTR_TO_CTX;
 			continue;
@@ -6929,6 +6925,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			bpf_log(log, "arg#%d marked as non-null, but is not a pointer type\n", i);
 			return -EINVAL;
 		}
+		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
+			sub->args[i].arg_type = ARG_ANYTHING;
+			continue;
+		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
-- 
2.34.1


