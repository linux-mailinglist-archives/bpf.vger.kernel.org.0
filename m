Return-Path: <bpf+bounces-62454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9707CAF9CAB
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76469546FBF
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8014B28EA6E;
	Fri,  4 Jul 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrbHc9Xz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C928DF3D
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670251; cv=none; b=kHL9qxdQn1GCzPFBzofOi19O+sthPhf+fVawVphMi9/7KK45CvaC/woC3bzT8VNWPrQ+q+MhggBEaxj1SAcbgM5jm+qr/qPJ7cIq2Ui+eyPdBVUMcultx5hpfaIPQzcnkXgac0RbNUk59HLduNk4yWy4RIyzyGrXJMfyXSCNf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670251; c=relaxed/simple;
	bh=kIsk+PVYbT4ap5cObT4ugKcwyrjV+jwTg0KnUqq/BsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCguMR7OpuhRwHrSoIVVGEgLYnDlLyxy80SpXKvo40sFfG8oOeu9o0vls14z6ImZTPK83Ij6ge1SJWBcy4PDRHcW+knyVOK11g+rf6pOxHpAwGa+BxyxlDOqv5Mu0gmV7LTkCFjiwhgNvSWGAXa6RXH8zV6s7AGkhvzLvDJQ1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrbHc9Xz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7494999de5cso868793b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670249; x=1752275049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwH0ekoc2nms/7N/sFKwyfhQIiCtKgoxOjP+kMq+Uy8=;
        b=JrbHc9XzMCHXV5IHOGRd+8zv97mC9QxPUWz5kKkvvwh4SWFSzqA6tExeRLOIv9+dIL
         AO7TMvO7Xa+rB5cAkPxWYrtpf5thfxuhm/NwVo0s8oshAViaV5/sSzv3DWS1PUDDH4IK
         5wguZ9rq4efxb9zJAha78lzFs7QELFyAdLTq/vqRYAmhchIjn/j3BbybZApuIJeC4j0g
         KGdo3OvXu0uEYoWmV+roIu/DHDGmdAVq05EwAo8YPRy6F8X1hRNOu8fvMN5XMLgRrOll
         XA9o90TbeUVDBI6tBHr2r/Yf2xk03BtqexX6TWOVFa1mG1Rw1+GbfsfYFqwhLTxr5ElA
         vpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670249; x=1752275049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwH0ekoc2nms/7N/sFKwyfhQIiCtKgoxOjP+kMq+Uy8=;
        b=tvAYR6RWjOTGQpPTnMPiIemd0Pv/A3hP+dd9Biwzz5pQpW3sJ3YT/hikjK59+mwyYe
         17FVWIcy9AG/dz2KFUjE9qrjvSFL9oKWNrZie6a8nZKu/w2KutyOmMVcX+dtkz1YSflD
         BUUpkHfsKJMj12jsC3672c01MkSu/9WA9Y79zFZ2cWVS6PoL5Igdr7lx9eMffouoDUkE
         0kbPG1y2WQzYwuJHEWMiypksqe5XBvKLw0ICosvhExEz/LRZqOljbrE0s0+1bo4sxrph
         yM4wt4QZCU6Q84sqF3SjH34L/XzWUbeI2t47xOrJSzirx8XKJMCDejA7B2IksfCMcHQ2
         ku1w==
X-Gm-Message-State: AOJu0YzMGyeJwBsdIzTwRKGMG7LeHlXhc3SsS166Gdk8BZ+pbezSIfRi
	3lx6zOtolT9zdtssflKtMTELW/Hauy0mv0B9Zd1VK6lQHEwEd+6z1+wtEcNclA==
X-Gm-Gg: ASbGncsBqGl5ihuVNb/517vaECO9flDqSdjrm3EQw44HHejucCZ50hvd7DaaIEdTGtv
	51egle1X3rw2vnicwk9EzCNgFGD4Df/lWBrsmaMNn3nLwdkW0MZQ2eoisbQ1fLDVgTaAzuarS3e
	OtKKw+HP/sQld4B55jt9F/dGDhEk2baIsKfrAQgjjehVqxGsgUYveyIQXMzOPaRWX1+Y9EncLZS
	tATql2snsFn0c+JjOLcjl/x8luY0JAGkNXlI8p6npHSU8m1zxXtHx/W7rf6MPs63oUFpP4k/8Xr
	yPDrrPA6Y3mbl9Ls2GBTAEszHGIepumue07APWgxqglzRVVfCqIfsmUU8Q==
X-Google-Smtp-Source: AGHT+IH19ugrPQGYQ0/HLAhjrIvy8VywHRuzR8ODa0FLFMFdxByYa/W7a69Eut8kkaU20/ewhwFjcQ==
X-Received: by 2002:a05:6a20:3948:b0:21a:ed12:bdf9 with SMTP id adf61e73a8af0-2271f1ceaacmr593805637.17.1751670248825;
        Fri, 04 Jul 2025 16:04:08 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 5/8] libbpf: __arg_untrusted in bpf_helpers.h
Date: Fri,  4 Jul 2025 16:03:51 -0700
Message-ID: <20250704230354.1323244-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 76b127a9f24d..80c028540656 100644
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
2.49.0


