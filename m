Return-Path: <bpf+bounces-62203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F05AF6587
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E3A176DFA
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A82D63E5;
	Wed,  2 Jul 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA46iomW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D82652B6
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496142; cv=none; b=L1A7nEJzeLRKA6xdM+vZ2ZXnbh/oA94MMCqwVxzWQQDzNCwiRs2RPhpasmN8tAwrftuTl6VVRDymAMdl9k4c9QbvoEGUG/B4PfIEFx2DcEehfefKCNwB898VWVpDEem/G9hZHBEqx7UZCA3Csc6sBNK8xXd30IS7+n2AFtifrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496142; c=relaxed/simple;
	bh=unXQUAxYZatP1XOgKPSMMXM9D6E4JO4tFY5jdSGvONE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP+bzS7xKaUaayLmFcQGks5sz9+B4qv0n329j5sQf7HEyITPkM9vbkmBbIjdn9K7Uq9z0LL7odt8QifqQMVRkqkWRCAtpk2RLwhpz3KwWFIsCD6KCgAz0LQdeb79oPESNS+cvQcCAh7liD9iQmZnf1yhuInDgX6/vbs0fwnqAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA46iomW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81749142b3so5823228276.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496140; x=1752100940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKLLYSrJuxo8AmLqfMp30wPNjYNVy449XPgv8XSmdeE=;
        b=QA46iomW1ZulQD4q3Mkaq3nOGUssi/Vk00vlR9cSeO0xBpiC//CYpc9SHtanZhQvjx
         65VbmQ5hG/dt1mK/oEXGIoVKybHAvVzJEiMXRaC80zq8DhBwnpORC5xCf0tFSTA+Wwzn
         kgDBBB9bNcAEAJI2mZrGVqBy+wgHIzPdNCrYmoZSPHZVpsuePG5CQAWbp/bLwLRidttH
         CGHhFEQgbpgv9BMu+0+2DtQWvA+ZXpqtiIc26xL/xO4kP+jiO3fjVp8KdyWJXtCD6YL+
         8Z+XiiMueWgz/aPjeqYS4qWdey4eb+mPfeDippNW3oeduOFH+oQBESP1QcEZdM5V6B7g
         LQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496140; x=1752100940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKLLYSrJuxo8AmLqfMp30wPNjYNVy449XPgv8XSmdeE=;
        b=dZRSLGjE52ekktzWOELv0anRkIat0pNPX7vq8GVFvOfyh2yTYtNW0tgdcElk+KyRSk
         WeBK0k6222ymCE96NVE4K9H7iUuAZyqdG0IILX7J3UvNclIU9pJ2yZx+RQ2mNkEEFlYY
         91NauGMjk+IXpw9NJ3WaC3ETC5KhCsJDDAyu5hmczlepFZp63UenodEPFqqM6MTfh3wF
         En/+59cUfQHCeiKknE7Ggw8tyKhFeRuFNGmNP7Naz04dXmQwI/LwCoabJNwJ6CupQ9rs
         dqscrVcd0KEcos1UmzDeXCGyjGJDOYVovU2d0jtb73ietUBmnseOL1P6o+qNrL7abQa9
         KB8A==
X-Gm-Message-State: AOJu0YyPI9AotDqKVL7CU+w7zceTlgMQSZ034m2wheWQvnVkJa3ekiOA
	+HAITVzz9CZmhcqrI4SflsZkO1TX2oN2lG2sPTAUZ651i0yKE1M8akYhdGht0Yt5
X-Gm-Gg: ASbGncuBzd0W5OOmr1WOTE0mhcA/Gw2nHwQ8nUOPUa2v5Ff2Lxl/5FVuBa9rP4oY5j1
	KIgO9w2aLz+7pdFin9HmWyvEtiiXxOrPshBhDMA4HJHycaL+0isrM1bP0Bp2RmUmHoAElba1wQS
	ZAh2GrvibVgDZ9AGRAwYopmypOZlDjOoq/VKqD5KQiiCRn04npuODKtnnPszmVKQCuVOhePEbHG
	FJ4guk4h1x/tUorU85jLd1pwETQzc5uP9Q2111zIxA9tNOeWpaGkliQHArUIpi9yi2qZW7iYMQo
	PtTTSjMPUvqNT8TRyLp2SwpS+2A6HgT+yyONL0DQ+EcH08E2MB1+Tw==
X-Google-Smtp-Source: AGHT+IHe1vhSmjRxd2+j/f6qLocrhi/dHBOBukXM+Der1OT7TiAZDVXRH1Cm/AXls98LDLwxNcXzrg==
X-Received: by 2002:a05:6902:260e:b0:e82:4a7:25b4 with SMTP id 3f1490d57ef6-e897e1cf9c4mr5440286276.22.1751496139955;
        Wed, 02 Jul 2025 15:42:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6be5a6esm3980496276.46.2025.07.02.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:19 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 5/8] libbpf: __arg_untrusted in bpf_helpers.h
Date: Wed,  2 Jul 2025 15:42:06 -0700
Message-ID: <20250702224209.3300396-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make btf_decl_tag("arg:untrusted") available for libbpf users via
macro. Makes the following usage possible:

  void foo(struct bar *p __arg_untrusted) { ... }
  void bar(struct foo *p __arg_trusted) {
    ...
    foo(p->buz->bar); // buz derefrence looses __trusted
    ...
  }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a50773d4616e..cd7771951a71 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -215,6 +215,7 @@ enum libbpf_tristate {
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
 #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
 #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
+#define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
 #define __arg_arena __attribute((btf_decl_tag("arg:arena")))
 
 #ifndef ___bpf_concat
-- 
2.47.1


