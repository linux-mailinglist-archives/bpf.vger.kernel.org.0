Return-Path: <bpf+bounces-22643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A88627F6
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BCD1F21990
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 22:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A24E1A0;
	Sat, 24 Feb 2024 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4h8e1uV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D861E506;
	Sat, 24 Feb 2024 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814065; cv=none; b=DoyYN49rr5dVePM4OAJJuyrxyW+OrmMPTVex9H6E8EptA16PmR+QusKsf1lUSauKYRDEtnM+AdACkL3xrimrTsO1ki07ToEs+xE0Ll7RhRagkqjG1/eRAa5+lfnuknb+HE7AnO2Z0iqONqtkY4V6DshRfNLZxcUxyEJK41yzeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814065; c=relaxed/simple;
	bh=jXerfatU1CwpvAHcMsYW6bl9Jwfiynfb9mgqJKQr9DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1XbO+0J8dxkJCZasO9KkNwYYKh7KKrIEzZs8FzBeqt2/BRVaj3RxSbEmm3A65CkErzXWa4WU91x/AeCRpGHahtGEH3K/4gtO2QuyoeHVx3ZN1f5h2CPgJbiBnjs0gJZvm9rwI0oFiNk9Vy8B0mDmapctrTwhr0ZAMRhoQzpD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4h8e1uV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6087192b092so22493487b3.0;
        Sat, 24 Feb 2024 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814062; x=1709418862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+FzNhVAX6d9zH/SLJZqcPC5xjwLaY0Izc8sijWP4CQ=;
        b=k4h8e1uVsQNnAl2NWB/F1ZdPoOrS34lwV57Qo1mIqNjjGCTonGCId1WC3NTNhKotS1
         phDraH4qA6pJ0pz/mcJ64VP7IdY9IcvDTo39aMVxw4J7KxsGO8Fs2NBjtbtJmti6vqWt
         p+1EtwM0r6LYp9RcvbDrssA/fZrz72J0cTclOp2ISuZ/mZFipBr8DvUx0RdxrQkATNCE
         wX1DCnTlrTJkSATaHykSzpciArHJxU8A4K1BSCZU4PSZ67E67M6lrc3Fv1mzMkf+VeZb
         fHitzaxEeNQLxKycRvUFnDVxEvwkbYangv4zNOTun9FCRAZzXE1BJpQbRSEFUUZEEl/w
         ZyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814062; x=1709418862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+FzNhVAX6d9zH/SLJZqcPC5xjwLaY0Izc8sijWP4CQ=;
        b=BCBbWxw2TVogndT3XaE0xwEddhJ8QQdOr4bWVfSTnTNy4F+IJoOj87hzuNMXuEBfD6
         Px6Wo13qxMLP1PEp1pJm2lmShxbZ3siz4JwGlr4QM5rbAJRzN8D34GLOIUnzM0qq8vTt
         pj+hjlmLeu/xrf5MV6LjX7jskFKIYHrAjz0skS6uK8nG+o7s9JIBaTT4QUjrxCyiejON
         OdrfpMymh20DpqfDBu25l5RRIghBoNq7P8Ge0BrPXZaTGnYo6BGidopY9j4oQtEwjsYT
         QlKh5p8953LkC4ZZqg6ZWguvHGv/NHhbr3XxeDRafKURIfIlRU6pH6WpdyTo00Psw9Yu
         02og==
X-Forwarded-Encrypted: i=1; AJvYcCWwPwkJqdCw9IFQFq6qXexENMbUL3hmGxawSpeHujH4NMMhKuhShDUKKAek2hs46whqzHNvXFuRoBZ+xc8RJysuhq6w+EXS
X-Gm-Message-State: AOJu0YwEh5jeDfFcd6mAxVl1wvhIDUW2FUd4v8dw1dCSnfGiai9t68x2
	RX5+j2zeJJ8wc3Y4v9lOdd4ja2ZSJ0CcBi+yqhHzqBUFV/KzfYFcWAyu7KY7
X-Google-Smtp-Source: AGHT+IGm4ZpMqVb3y5ZIHakdGdUawkksLkQislQtMiFOxIXXIctRVMFX6u0s1yBZC2vV4gxWBHD09w==
X-Received: by 2002:a81:48ce:0:b0:608:b59a:6292 with SMTP id v197-20020a8148ce000000b00608b59a6292mr3071912ywa.9.1708814062275;
        Sat, 24 Feb 2024 14:34:22 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9221:84d5:342c:9ac4])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b00607e72b478csm474010ywd.133.2024.02.24.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:34:21 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 1/3] bpf, net: validate struct_ops when updating value.
Date: Sat, 24 Feb 2024 14:34:16 -0800
Message-Id: <20240224223418.526631-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224223418.526631-1-thinker.li@gmail.com>
References: <20240224223418.526631-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perform all validations when updating values of struct_ops maps. Doing
validation in st_ops->reg() and st_ops->update() is not necessary anymore.
However, tcp_register_congestion_control() has been called in various
places. It still needs to do validations.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 11 ++++++-----
 net/ipv4/tcp_cong.c         |  6 +-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a6019087b467..07e554c191d1 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -672,13 +672,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*(unsigned long *)(udata + moff) = prog->aux->id;
 	}
 
+	if (st_ops->validate) {
+		err = st_ops->validate(kdata);
+		if (err)
+			goto reset_unlock;
+	}
+
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
-		if (st_ops->validate) {
-			err = st_ops->validate(kdata);
-			if (err)
-				goto reset_unlock;
-		}
 		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 1b34050a7538..28ffcfbeef14 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -146,11 +146,7 @@ EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);
 int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct tcp_congestion_ops *old_ca)
 {
 	struct tcp_congestion_ops *existing;
-	int ret;
-
-	ret = tcp_validate_congestion_control(ca);
-	if (ret)
-		return ret;
+	int ret = 0;
 
 	ca->key = jhash(ca->name, sizeof(ca->name), strlen(ca->name));
 
-- 
2.34.1


