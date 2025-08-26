Return-Path: <bpf+bounces-66521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A4B355E1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301033B0AC3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28762F744A;
	Tue, 26 Aug 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UQgnUXh3"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396821C167;
	Tue, 26 Aug 2025 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194008; cv=none; b=ts857B26rVEbXMyWaOQGIdvpnTwq3zGPwIXn0Pd7wvizIxI3J2BqQ8FcrEY3PEUnXluNdT3oTxbUd7DKPxFESen29NO8XXp1Vyk83vQ0mNekaZWdp6MlxoxmZtJ2V1pZ0nInZRKc3wJoUXQXRi5rChh85QicFbwXRryZR8ntqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194008; c=relaxed/simple;
	bh=Gbr+jEBr+Ui7oFx/a1GxRAqZdTd57yGmujsbY9w9Sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ib0Etp7fKBnJ+/DGWGNXGiz8MfEe4pb9XEYnm02I84X3Xe171t+FruogkxFS6GHSxI5e17U62ZdByFjSG5iZ3jdlPA2K/G9HipgrH5T4mTxJ/dy/wESLEvKsU176IVGgHwylG/gc/2BiSI1MNWVZjCA37oXUELGuYpSBNkXTTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UQgnUXh3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Km
	nePVSe1ZPRh2nW+LroC/MoDmAxDrPzlwFp+K6R0bQ=; b=UQgnUXh3l9qu6YJVhm
	2op7oWnaygQ41sIQUQAjx9aee1sfOaNsyckOBZHvOHGNeB5StB8Y58YK4aCGuPk2
	iGR9agu8r9QP8+kX29+4VwWspCgYgVsqPjbNnc6hb5iaB0yqul/hbaKJ6KBVpAd0
	lT9gLT0qhOFd7mNKv4CNBr+uY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXUA2oZK1opPzJDw--.63934S2;
	Tue, 26 Aug 2025 15:39:22 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Replace kvfree with kfree for kzalloc memory
Date: Tue, 26 Aug 2025 15:39:20 +0800
Message-Id: <20250826073920.1215368-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXUA2oZK1opPzJDw--.63934S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWrWw4ruw4fGrWfKr45Wrg_yoWDAFX_C3
	95Z3W8Kr4UZrs5A3W7C343ur1Ykr1DKF40qws7tFWUArWDJwn8Xr1kXrs3XF98ur4rtr9x
	JFsxurnrtr4rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jhF3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZRe1eGitZDoMYQAAsJ

From: Feng Yang <yangfeng@kylinos.cn>

Refer to https://lore.kernel.org/bpf/20250811123949.552885-1-rongqianfeng@vivo.com to replace the remaining part.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c9dd16b2c56..b9394f8fac0e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2021,7 +2021,7 @@ static void free_backedges(struct bpf_scc_visit *visit)
 	for (backedge = visit->backedges; backedge; backedge = next) {
 		free_verifier_state(&backedge->state, false);
 		next = backedge->next;
-		kvfree(backedge);
+		kfree(backedge);
 	}
 	visit->backedges = NULL;
 }
@@ -19651,7 +19651,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = maybe_enter_scc(env, new);
 	if (err) {
 		free_verifier_state(new, false);
-		kvfree(new_sl);
+		kfree(new_sl);
 		return err;
 	}
 
-- 
2.43.0


