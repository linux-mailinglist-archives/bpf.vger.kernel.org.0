Return-Path: <bpf+bounces-66623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA53B3788A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A83D1B280FF
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4C308F1B;
	Wed, 27 Aug 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qFAu9Vch"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AA2F60B4;
	Wed, 27 Aug 2025 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265344; cv=none; b=aeQll/3E6GMDI3BoBJ0KFkecdrFc5irs06tpIJt/90jscwothFARBD0GxxJLMCR3CthqNA8Z+EXBcH7bPaSLhpdz8nhzLDJnrOnJTqQepDwWXHUTv0V1Jxl+c2t1uh/4EqY1mz8V2EW9dZibZxGJeULzinjIAApzkpV0WkAc5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265344; c=relaxed/simple;
	bh=nnQv5qVpxeHIq4GcjPz1fWTl4vFpNwQGXWgwRqdOVRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ied+h4vWnWT7Qu7a768uAnqlnx1XoI/Q3nFuaPJWGWAX7krJ/vxIpFvQfVXnBcNrEKPEJTf39Xj11u724zGGfxRlEvzzxBYHCoL7YqVtDCOpX4k/Vmyn8c3Gnb9RpIVvrvpgiusF3+fW0sUdA8PaRUd6z+qfrDN0s/cLpMrs0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qFAu9Vch; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ho
	97x5wVkXo8pnoO/XNqFweCT71Ev+bvIlScmLgdN70=; b=qFAu9VchkaQH/rAj5z
	3wGfR+cQ1VFnms4kO2HxXwyoNeVKK3Bxx+9qFrZDF3PfPVBK3CHE+iDJMZL3KbxP
	iRi5hQ+Fdf26IQmBBNBA228Hgs+LXOfp1PKeL7aUE+V8/MuYxTW71D+MAfeQzK84
	zzv5EkjIGOOdMRzPkqVccn3mk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAng6hNe65oUa90Eg--.1751S2;
	Wed, 27 Aug 2025 11:28:13 +0800 (CST)
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
Subject: [PATCH v2 bpf-next] bpf: Replace kvfree with kfree for kzalloc memory
Date: Wed, 27 Aug 2025 11:28:12 +0800
Message-Id: <20250827032812.498216-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAng6hNe65oUa90Eg--.1751S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4rCFWkWF15AFW5XFy3XFb_yoW8Gr4UpF
	sYgrnrKw48JF10gFnrCF4UZFyUXan8Jw4xG34qyw1SvF1rtr4qqryjkryF9FyaqFWIga1F
	vr12vF4jyw18WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjCJQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZRe2eGiudCrnlwAAsU

From: Feng Yang <yangfeng@kylinos.cn>

These pointers are allocated by kzalloc.
Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
check in kvfree().

This is the remaining unmodified part from [1].

[1] https://lore.kernel.org/bpf/20250811123949.552885-1-rongqianfeng@vivo.com.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- Add commit message, thanks: Daniel Borkmann.
- Link to v1: https://lore.kernel.org/all/20250826073920.1215368-1-yangfeng59949@163.com/
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


