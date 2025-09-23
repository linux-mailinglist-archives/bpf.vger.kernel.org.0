Return-Path: <bpf+bounces-69468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F8B97168
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E540918847E7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF62848BA;
	Tue, 23 Sep 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="kaw/iEkp"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579D189;
	Tue, 23 Sep 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649681; cv=none; b=BK+SYmUQeLgLnmd6hqZpIdjKVbOtZfeF/YyhQExoqFifme6HZY2wApWNzN/ZD01M4eN68DUZUP5b0sXKh1iAq4NoblyO9iQicTodutdAN80nir9bwx67WE6kQMQqw+cdIYehN/wV6TrYkNotrxteH7TxFAP907aDFb2EqmhS084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649681; c=relaxed/simple;
	bh=0U+qcw47Gb99mmWIilRmZ+BdsLzSaKAFRWUHM7uLbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUFnaIs3uBrLzkZft+CzpGincdHuUlBaYBrCIhvOHuimnHL1uB+2ZfTQJLClGFD8gifNzxsxjfU6ZV+tV2xjgp3S8T7SjmMj3GTUfIiJbVIhPS34jX7pvNMkNSVhTBLPVr5+LQifVkqEscJ/wKSmhWxP/keb/N14I+PXX5xFX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=kaw/iEkp; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWSB32zhjz9tN3;
	Tue, 23 Sep 2025 19:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758649675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFyFey55MDpnI+OOuv4n39LgjuIXGj/u0Ei1n9svAKM=;
	b=kaw/iEkpfdJt9kjnA4wVXjnQ5PPji9vfmo+aQ9t2DtbiDMrvAzwb421BF4YcZNRG1bHaIF
	q2qO0LWVnpFAMLYhKeuitNfXSh9/0VC1IUQCbCxr762uqkNX56N0wVFc87/2bki2BVOjnd
	OTUVWvoIGoWB+BmUhI8VK+Fr3zNkXGUoJnJsQvHrS4VvpSeJ7IgTMejWWShFItshoVP8QZ
	xbv2C+bApilKXtWZknRU7pfECgd1Jgq2+g/2ZZgFDFrJpNt/ePhlGn4qN6ENVhvoHrwj/U
	ShJRcnemXYV4AbMcZ64zycXBAKKltcjKRnhK6yYpviNe66OuG1jlj2+ENa1JWg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
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
Subject: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Date: Tue, 23 Sep 2025 23:17:38 +0530
Message-ID: <20250923174738.1713751-1-listout@listout.xyz>
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cWSB32zhjz9tN3

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
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f50533169cc3..5ffb8d778b92 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -704,7 +704,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
-	if (type_is_map_ptr(t)) {
+	if (type_is_map_ptr(t) && reg->map_ptr) {
 		if (reg->map_ptr->name[0])
 			verbose_a("map=%s", reg->map_ptr->name);
 		verbose_a("ks=%d,vs=%d",
-- 
2.51.0


