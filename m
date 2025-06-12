Return-Path: <bpf+bounces-60536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF3EAD7E3F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D021895499
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185812F4314;
	Thu, 12 Jun 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6Xuz5i7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B7222593
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766270; cv=none; b=JKXpu47Lg4qSVfrqszjHR1KfEF+GvB1a6zboeXqoNo6Xh5RYQByeN6MYtrQr9lPF/rrulRQm+CP3TFcEoemcMgRJaO/CVghNZC93IisozTTHLTQYTFF/z6OF/ujP8UpR3+TCXvrHKm+PqLMDgdotFpTiND1kkuX4iLhzQR0QMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766270; c=relaxed/simple;
	bh=h8LRtIZJ+8VX7fh67jCNLldTIZIC3MaBi21629Yod88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRtEh9SW1RO1WhPrL9A8V+fdRlLLtE1STEtKrLCMebjcGUJoJqMaOBFh0P/SHPC2q5PR4tWJpzh8mIQYLhe+GWKYg8E4PqMAMOW/lLOi1VXpjscdcRLRLim1qYMSdmtf01HkN1Sa52c1DUfbs28x4V6kDEu3t9xGksqOKFtRrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6Xuz5i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4775C4CEEA;
	Thu, 12 Jun 2025 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749766270;
	bh=h8LRtIZJ+8VX7fh67jCNLldTIZIC3MaBi21629Yod88=;
	h=From:To:Cc:Subject:Date:From;
	b=s6Xuz5i7+eToBISeB1IPl4Q8sWdUZuiQwQQPL5liq6Dg6bd5WOE9I1K4TstG13nxr
	 4JfOUAv4b8xhDB65wjgIvMwlhKok1VshMF3DyjlZyJdrphkBqF5etjIbSzXvamSEdj
	 hLTK+GEIaA/kQd98eC1hvsQsSyzjUNgaFRpLaFfJJfWi3FA5ec0yfLnw5Y4W1gxeE+
	 myARsWzOm2ljnr1N1he8Fg/0v0FNxjqHiCAmEDzzqWruN/IUTqyMl8Hga1zk5W3Fwd
	 aMRGXO7EkZrFYoYVdmRJZbrf4P0iEZproXKGxaugPWnMhmfWkptfq+OBqDukSRNufv
	 FlT8XazhIoJ9A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: Initialize "tmp" in propagate_liveness
Date: Thu, 12 Jun 2025 15:11:00 -0700
Message-ID: <20250612221100.2153401-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With input changed == NULL, a local variable is used for "changed".
Initialize tmp properly, so that it can be used in the following:
   *changed |= err > 0;

Otherwise, UBSAN will complain:

UBSAN: invalid-load in kernel/bpf/verifier.c:18924:4
load of value <some random value> is not a valid value for type '_Bool'

Fixes: 6b3f95cd99f8 ("bpf: set 'changed' status if propagate_liveness() did any updates")
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 047b922f8cce..2643583bd6b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18900,7 +18900,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
 	int i, frame, err = 0;
-	bool tmp;
+	bool tmp = false;
 
 	changed = changed ?: &tmp;
 	if (vparent->curframe != vstate->curframe) {
-- 
2.47.1


