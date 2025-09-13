Return-Path: <bpf+bounces-68303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADFB562CB
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FA17A57E5
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE88258EED;
	Sat, 13 Sep 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKkj26Gz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C60253B67
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792031; cv=none; b=KBlPsED6Msc7J2jAMt6Y85TWRqiekKgf222xosprxCGRUilRzNcW6orkUKZs4rm3iPZ5jUb+oI2wlcp6tf9WE/zrwcI35/JkBSYKkRhOCtrPAawCaLD6PkmmTaC9Ux8epWYTQ8Mq4a/dGkQ/2KkXFMN5ymmqINqf+5n8omPQQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792031; c=relaxed/simple;
	bh=g0e4y6z+YU3g2XF/m7bpAkGBaWFTm9fugdBfA67Sle4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+3jqPWADd8WgscTVLzbiJ0YBL8/XcO0bgR0smef89nepckra6V21JTrtiIajGB/s4XAANBtHGvSeDXs5cFDtGWvPnRxWBqJ764sNSjur6K846dP8RxZXIXRf1pYpgpEY9Cz0yLVFdOn8W3laSNBfWFNZDFvMKOw05fdx2L5sZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKkj26Gz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9853e630so27877085e9.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792028; x=1758396828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdFKvvA7uHqidwjHtAQUeNBDXVgzdDVaYKaGFmu7V6U=;
        b=IKkj26GzMIwYg6k0VnT8sZBcrqcDaS0eoCCpLPaU0Jy5YnyHD0gCsRvF4Sw3SH6hkB
         xqdU6plfZjXx4hCwiFB2ZKNmptp451yVLtWZAfo5bxl3nauuMOI1n870WuvLUlXRIdKx
         ASj1xOVIi5bIdmZXvBmeoziQOpXB2OfAXkZtLqLHd8492ybNDe/qIYMi3YnsQVFErSt7
         gvhmjf4J0NNaq0UTqO46B15v+RccLU0NjjycSdW/0OZpL3erWLi5CTEYNJB6wZNDGGww
         4H+dXXP4dKSxDcM0tsSWZ93ZzghuiHnfZqYOQeAsCtN9HCNFaz3dEuYp7JZLGEPFuUPk
         pajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792028; x=1758396828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdFKvvA7uHqidwjHtAQUeNBDXVgzdDVaYKaGFmu7V6U=;
        b=BfhqO9dY1Jo44/W5KwO77TMD8XgcG24kxVsxEs0i+ft+j0d51UkxsA61Z3ur51vI2j
         hdZoRBT+6ZmM41r1qKyucxHfv301Zy7F0ZpaImptkfQkT5MhJcnFXgxBjOZBKKxsZxHa
         1G6xjPob9hjPsFDHwd+JSo5oiZCcI1IwlIC2IqI3VCl3eC3KkffQVKRdCCjRt2JPWaI7
         4/DTWA7AhrIFclXKB/lQ441fR3Box+hdhaZKIlybs7wRI7C7nDLtQRholwY85RXR9+dP
         tV1clWPELpsqGLbo9WeEv33QqkEo6YDaWhWtdIlq/DrX9JcJ3l2dVjJWbqHCh96Ng5nP
         1s7Q==
X-Gm-Message-State: AOJu0Yzubt6GR7HNHa7vVY+ojuq9DUPXZQYHFgOaJmL64pg/amXLb/Ps
	OhTPnfLKhNR/LD4NYVNiGyy0jG5x+5H7L0X7XhJt4ADN7hcq0RExVa40OeCjtA==
X-Gm-Gg: ASbGncsaPR3YACK5MfaP86BamYuwWsBm6yecW9dIC+ivj2UNwI4ju16p8XgMFVY8+zE
	jETjO0hozavuXPFuHCAmcTtxaxChvVBrG+UZ3xPxhTGk27S62zgZ/859ERk6fnCHG/sKFE0LmJD
	L4K/6MQ0/B9xfuQISRirHfFGfl5QF2WzdsDsfSQRRDUWLraPZaOgpkkOVTF0z4WiILmBoXGikRF
	tAOlv9zezto6s1MnNkzPcbiXEw+gy5QAazScRCkzUnUnAH5jbOwGwB2VqC0xUapUfxWePOZJa3X
	hrJgTbylr+rY7tKf/9Bdw/Ioj3iOoI9Wb0oY4cbq9+FAJP/xbKmvyzY5E7c26VOP8gPaeOFEqLP
	sCXq6wli+yTuYVY3k6OvL62jXo/Yn4fwyncllFbFNIQ==
X-Google-Smtp-Source: AGHT+IGNz09hTlrvu/h/17NAtJpxGh6tESwdreeyumQ6xiQrZI/k8AxZu3yq6ehvNOBIlsOJ094h6w==
X-Received: by 2002:a05:6000:118f:b0:3e7:e0a2:1478 with SMTP id ffacd0b85a97d-3e7e0a215damr4029184f8f.26.1757792028145;
        Sat, 13 Sep 2025 12:33:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:47 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 10/13] libbpf: fix formatting of bpf_object__append_subprog_code
Date: Sat, 13 Sep 2025 19:39:19 +0000
Message-Id: <20250913193922.1910480-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
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


