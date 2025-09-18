Return-Path: <bpf+bounces-68760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A0B83D06
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A44017997A
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141ED2F25E9;
	Thu, 18 Sep 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HleH8z4u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9321FF5B
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187971; cv=none; b=ZgYoIzKtH5DeRvnPjeo2gceysrxhdmpGvsvAG2x4uHBrD7JHdaZbz2WDD9ZFp2pXIpU3K3BgjcoF3v/3EFUIbnkkLWjaHf1mjWbRUAno/SyBvPCwbInQtwobuh4Pukea7IYyXHHW4YKno2hp23b5jRwJrX5BizLWbTImc0+ODsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187971; c=relaxed/simple;
	bh=g0e4y6z+YU3g2XF/m7bpAkGBaWFTm9fugdBfA67Sle4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjeUvEowcsO549VWF9LyCuLJfNkXpo4lwouAYGCDgt5BM1oh7f7eiXRwsV1aif6Y5M92sV+hYgTiiT4MtsjTMcVcyca9Z9durKOT/HlUq5IEt+o7fYbHcGYk6ZRAHfaomwhGGSQTU3+kCHZEcYCGfId6IwWzz9NFnKsnkIhCDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HleH8z4u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso5301115e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187968; x=1758792768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdFKvvA7uHqidwjHtAQUeNBDXVgzdDVaYKaGFmu7V6U=;
        b=HleH8z4uu6M91hQjMO5y7xo7FZ/DUoyAZZJ6mJRb6hzkdE7/yjSk7mmKWYWN26wtPf
         SAAV9q//mjHNvG3qU0lT2a3d1u7i66zO9xnfcg0yNXkVpR78wqXyAuuI+Iylc11dnxNQ
         cInazSGT0KCcxBa0pAiVMlQ8rNfPgiKo6NT/34vJ11DHBI5qchf+iD3JsGrUWzQHBMQ/
         DpAucKwKG8rDS8vketlk/rMdGvtf+zUuBES3LQZMGRX6jEtHZArsE/y9DY1GZQ5EkdKG
         4u1iXb6EeEritnAMQFSrvwpP+sUH/JDcfs6rxxxnRhnghow7oVaNIhUcsZD1eD5MhlGk
         iXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187968; x=1758792768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdFKvvA7uHqidwjHtAQUeNBDXVgzdDVaYKaGFmu7V6U=;
        b=ZvZiRIL0Wx1CQmY2S2HyWUCqJ4VEEN+rGIJbtJ6fyA+IuSO9OVk1fGALf6ZiE+cCFK
         TpJ47tKa/bZ1rJJ/DPBeIJRGQPHH5kKhHkk5HUkk44m0+GrZJkBhcfhNHvBzaNmuYs3Q
         t8u1kJkurM8FqLKA2Ge5fTfeOMI9r+qsAexskW+ftiHuAO9wpUb0GARwKOzOvKpBSO1I
         qjLB+ztnmpW7KKZZAX8wdrceJvIxLsIC8yfbssp8OJA6/gOF4j6xT/97xCCDt4WQZSuH
         KOMYHWA9fpkN3ePFAUvjaq/jWjEKs+CyLlv/CVZexynjU+0C/NCRWgKELXvryge2e1c5
         ow6Q==
X-Gm-Message-State: AOJu0YzUFfKagCQGJ82LGv4aqiL6vgdPPr6+NF+AeV6BpT38HhZOeJkf
	osuKWUBnpBl1nO4M9Ci/bMn8YU1efhsL7h8BmALpjdEOY7hog8ubarQwsoR45Q==
X-Gm-Gg: ASbGncsI8/HeF0BOent+8JcqrkLsHeDIGFo4qRijOUJ4es80b++BGGJoXlby9xBfz5p
	KHgN8Nuuqb/Uaqvj+5T+Uf6szOwxDvt6fZwKPTkdyRCRYvRDFvyhmlBbmSYP9OESHlS9bjFyQ5a
	OJJL9N5mNvZfhLF8r8Rf9vVMWbEbQGQ5xsGYYgArhWta/iqGTeleLbUFNEiLOMzo7Y+plc35GcV
	+H+v0TIxO2aSQjLwBjOe/yVqWQFum3dnj5qJfaAYjG3uMVGDCaiYXS+uQLMMSwMo/AFgtcoxobJ
	93scKGcrObY3lLitjiCdu2vLE5c8IAWINxbEM1jiNnfq0Jrf1Obt2fSuVrKw+BIL59PRhVBJ9UT
	DiD/4R//9AHqu8BJobvp9ah8QRnFgFuYqsV8V1/rInlAqX3zUxoi+mmh2jI4zJTIwzRH5X/k=
X-Google-Smtp-Source: AGHT+IHOLp3iVCTJjojWz93nPk0k2KAuebYcC7iFNlR7tApW3XXPdKTKKah/TyLrlhM82727LatrOw==
X-Received: by 2002:a05:600c:3b09:b0:45f:2c39:51af with SMTP id 5b1f17b1804b1-461fc85bda2mr46306745e9.0.1758187967583;
        Thu, 18 Sep 2025 02:32:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:46 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 10/13] libbpf: fix formatting of bpf_object__append_subprog_code
Date: Thu, 18 Sep 2025 09:38:47 +0000
Message-Id: <20250918093850.455051-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6c918709bd30 ("libbpf: Refactor bpf_object__reloc_code")
added the bpf_object__append_subprog_code() with incorrect indentations.
Use tabs instead. (This also makes a consequent commit better readable.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fe4fc5438678..2c1f48f77680 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6393,32 +6393,32 @@ static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
 {
-       struct bpf_insn *insns;
-       size_t new_cnt;
-       int err;
-
-       subprog->sub_insn_off = main_prog->insns_cnt;
-
-       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-       if (!insns) {
-               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-               return -ENOMEM;
-       }
-       main_prog->insns = insns;
-       main_prog->insns_cnt = new_cnt;
-
-       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-              subprog->insns_cnt * sizeof(*insns));
-
-       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-                main_prog->name, subprog->insns_cnt, subprog->name);
-
-       /* The subprog insns are now appended. Append its relos too. */
-       err = append_subprog_relos(main_prog, subprog);
-       if (err)
-               return err;
-       return 0;
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
+
+	subprog->sub_insn_off = main_prog->insns_cnt;
+
+	new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+	insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+	main_prog->insns = insns;
+	main_prog->insns_cnt = new_cnt;
+
+	memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+	       subprog->insns_cnt * sizeof(*insns));
+
+	pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+		 main_prog->name, subprog->insns_cnt, subprog->name);
+
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+	return 0;
 }
 
 static int
-- 
2.34.1


