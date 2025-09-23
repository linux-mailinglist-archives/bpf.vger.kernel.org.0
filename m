Return-Path: <bpf+bounces-69461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0965B96DC7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ACE3B112B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B886328599;
	Tue, 23 Sep 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="yDYyqEZR"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459925A34F;
	Tue, 23 Sep 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645751; cv=none; b=cwB5kHHazwOwH8sSbkzx6IdDC18H+C9+UxZZTxIah5UzDu2Kh3gnfUzr8Du83GagCMMyk92Pu0N0cOzqIGmAoKEoBtnBkYsYROvHbaPvaBgGwxqqXhJIY2fekep37QHsNrhT0B+pl+XRRHxpgWrOGoHuzg24jqMYau6nLXnargY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645751; c=relaxed/simple;
	bh=DvOjd7uurH6rsixweYJiRWI6hX++v3CAQUr8GbDx0EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rvk4pNM8hllMwK+CT2lTEXX0CK+qffMm4pIWjjPyprtLa9BBFZNCeNCefAqtvoXgQKE5i+33XMueuySFccWpVA37/M0ghy4kwa2ZkTjBiM/yHAqDppw0uMgVUa/5s/m65kPcTZHgCjzFmF4q7WuWmiWceEpA0A7hAv64nBCqFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=yDYyqEZR; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cWQkM1C09z9tRS;
	Tue, 23 Sep 2025 18:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758645739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmmrxfPm9Zhb/sagqXwU5Na5q9iLweF8bB3KFYMUa+s=;
	b=yDYyqEZR8LZnac0rNBQOO37sSIHKSlYgnajP+JTWZOEUwFXjPPXhpUcNiNSosPBiXiI9S6
	IY3pCPQfSIHbik+aaWV2VMsHnL31+8MnTMoQ0jwvbPoCzMnaSl5onRKxwovzsZQy+FwEWG
	pLFbFq0gsL2rv/BSUVyC0I9MKnnI304zfsvSN6a5xa7WZGrF1lX6avcHsc07DjpKpiPN/w
	O4Jlb/44O7Nnq56sYY8wnqfVwauUYES9DOdNnoCpy/m6MFfp/ItlgKZi33qaLcMyydZSzG
	O8x9hYHtQmTF8BfyKt7XV/vh8VaduK6LkpXEdBazfoZlwroZedLu8uCz9SGWCw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=listout@listout.xyz
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
Date: Tue, 23 Sep 2025 22:11:44 +0530
Message-ID: <20250923164144.1573636-1-listout@listout.xyz>
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cWQkM1C09z9tRS

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
 kernel/bpf/log.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..a2368b21486a 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2016 Facebook
  * Copyright (c) 2018 Covalent IO, Inc. http://covalent.io
  */
+#include "linux/printk.h"
 #include <uapi/linux/btf.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -716,11 +717,12 @@ static void print_reg_state(struct bpf_verifier_env *env,
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


