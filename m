Return-Path: <bpf+bounces-69462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE6B96DDC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D72694E29AF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E332859B;
	Tue, 23 Sep 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="U8YDgu7f"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005226CE26;
	Tue, 23 Sep 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645865; cv=none; b=bkKftqiUUdwz0ofAWLD4fuCeOZvYhBsATknBzdjerXYgx589a4keDb7NzyWvxWi3lclM8ictEEdN5NEmmDyGjgpJynq4+jNFu37qULNHIbGM2Dge7aoHV2umkN1WbSp9jIsjC9cqRJocb6IencWsslyrT+vtTFo3xngozrgxTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645865; c=relaxed/simple;
	bh=wwQGUX67SXUgd19z026AaJfNPsdTs79YkoW7C9G6CGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMmlaa9SnK18cJ7bYnsRGh+6wZGozUbQCN8UI2oMWTJSUjvbUUVGTF4WE4NRZIyku20igi7ur+3xhCbuLcgSPWNWwedGmfs4FFQxLbU2A/jh/6io8jhxnwGODGzbuuYfAwp4rmY2Ic7X+94Vmhs1QU8rl3dGWF4Z0gVJlT6rH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=U8YDgu7f; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cWQmZ63KFz9t7M;
	Tue, 23 Sep 2025 18:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758645854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1u+lufeuVfPK5/r4HgAV14Pb6sm9+d0eSksOaw4q24=;
	b=U8YDgu7fzxRDvgBqxZLyNR6b9+ccFF9crov0/UC5TNq4c6FuPRzfdDfM6TERcPhVt40uq3
	TCObwDvQ3DEFmzXI16Q74ECeU68MqC+8kkyFoL49UoMk/5WxJ5rFDEowKu4ahIyFOoVqEj
	zEaD+JHWmT+aa6EEwMNFlAK9m5xk9F0r0wESydegqZVMEnebnH+ASMmeDwst3XqZ11wpLy
	0bFuefHl9Caq6Zvnn8CMcBoyiDSirx2pWUnZAaIVEJGbhb7i0WtNzpL48XHR2/ddMoyaQF
	yQkZEjik0FTKIs2X/gGMy+OsQXQOhXp2XhRD17QTTSrQLlPqtaGPH1vIuWKjJg==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: listout@listout.xyz,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH 1/1] bpf: fix NULL pointer dereference in print_reg_state()
Date: Tue, 23 Sep 2025 22:13:57 +0530
Message-ID: <20250923164357.1578295-1-listout@listout.xyz>
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a general protection fault due to a NULL pointer
dereference in print_reg_state() when accessing reg->map_ptr without
checking if it is NULL.

The existing code assumes reg->map_ptr is always valid before
dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
reg->map_ptr->value_size.

Fix this by adding explicit NULL checks before accessing reg->map_ptr
and its members. This prevents crashes when reg->map_ptr is NULL,
improving the robustness of the BPF verifier's verbose logging.

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 kernel/bpf/log.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..b38efbbf22cf 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -716,11 +716,12 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
 	if (type_is_map_ptr(t)) {
-		if (reg->map_ptr->name[0])
+		if (reg->map_ptr != NULL && reg->map_ptr->name[0] != '\0')
 			verbose_a("map=%s", reg->map_ptr->name);
-		verbose_a("ks=%d,vs=%d",
-			  reg->map_ptr->key_size,
-			  reg->map_ptr->value_size);
+		if (reg->map_ptr != NULL)
+			verbose_a("ks=%d,vs=%d",
+					reg->map_ptr->key_size,
+					reg->map_ptr->value_size);
 	}
 	if (t != SCALAR_VALUE && reg->off) {
 		verbose_a("off=");
-- 
2.51.0


