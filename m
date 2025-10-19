Return-Path: <bpf+bounces-71328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2A9BEEC18
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8143BD4E5
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78E2ECE9B;
	Sun, 19 Oct 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhxrFKP9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74052ECD32
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904939; cv=none; b=MasL/DLCDVcXoD7FTcQhd1YVE6zmqAnW5W63/OJkP09/5Uouds13y35iy/CntJes9rGk4qjziyxChq4JIgUrYXhl0eYPyYI86czi1TTbLZRw7ra7EQJRJYnC6NpN80dl2z/NwdtlCAisVP1wQIM83/+HKRuSUKBVUYhpnyyU2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904939; c=relaxed/simple;
	bh=AcJLbkg1UfhPZpkamVpop8g7IUNndRU91fVpQNxbvlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IphXmz6UX49wDzwnbw7wV9/56UnlhbE0onIOm+ZrTJtyciROrwSz4vtd02jNYRq01VSUT1jbDldX5Qzx/uru0FbZOeoEZWrT0hpLRwxtPf1XWISazZqiEbw/cK00cXsud000Y3/w2R3SrImjwY+xcIuHc75iHqfl2pACwGhaAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhxrFKP9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-427015003eeso2669976f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904935; x=1761509735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=577npZYQF4rNn5LxRB45gsYnpdOaeV9L0LxSrgRT3QE=;
        b=LhxrFKP9YdYMhTFGcfaXmih9mIo6ncftT2am6zSoNHTBGoSOQHR7O1A7iCEe9DlqtQ
         aUSKGMUg+7XfiXuCfdFsIMGNwQ93iV6LreX3wRAiRW85rPRA0n0MR/U3X8J8qtHogXpA
         HgFr65BbVjH4Sh3WVXYckpC15Rlyp1GQma+wwBf4FjH/63JCuerX9TeIUd014UFft81/
         M+a2bvQHY1T4Fqz/npKXENep0bsQw6FvPax8PguVP5Vim2oS4tS4drZfk3fx5E+ckpm1
         Y+itErXW96DZwhG+eB9rkvX6yMwso0WuawtkmX4lUrf3khk2EXJXkWw7+FwPFWMHBg6m
         vPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904935; x=1761509735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=577npZYQF4rNn5LxRB45gsYnpdOaeV9L0LxSrgRT3QE=;
        b=UKDGiLQyfaUrEviAng7du5kDvjQRrtavcTCUvGa6r0RUoYb7/fyW/Rn7fTt0lNr0MW
         dydVL+clutIMpBHv0IihSR5BUmWCLzfJWewXAeAiloTKsiqzHnLEcFn25/9eIyrOyAf1
         oZiAk0FJrCb6BKjeHGxGWWFWktqtfmT58S8UrDwZda0Y3xYo1eSS3DciwjVQmCTpqUQQ
         PZUZh3mV0sON6z+ZdOmBdRifNnqOkT2rVEwB/PJIvmX7k4yQdfiBSr8HPScHIj9nqdrP
         Q4Ip6a34KuhT46w8K4vP+o1bCvw/n6bl59GatTAzdfXb5wklkbxDo2qG3XU5TwlM9iJy
         4K4A==
X-Gm-Message-State: AOJu0Yxp2VISzuZO/h7LK0okT1JA/1kav5VQarZaTqVliK/k3IHF94gD
	FNm+1kA4z55Pil7PEKFRNJmXwwSAJ5eY/WJBPCgJEJG9pdeETJ5QcCao83tjSw==
X-Gm-Gg: ASbGncssPYzujrFjdq4B8H9qdKXCwczo8CHKBtjb0JGJzQI2om+6k/3NtxvxHj8QOdG
	3XWglDIeHgRJo2H+xJQBcuW31dkvxF3VtVm9rJr5LxB5TEqKiKSY6kzvzpFDepbt0EM9V9kQA2+
	tYKZVAdWsaQRYIW5aW9vVtuOTBDYkpTFrYOq4jrCKp1uY0J/SAwqA3QRJSRWWwV23lthSWWoUz9
	vGR3zqNWcQ3DKEeK4ijgzdJ2WMSVd4iL4ZjcU1+tdjnXwx3ztZ6gKUevtjI1D3FbjF2YWkHD9m9
	KclBtE7shi2PSTvD4+KUg6pYMQbQnU3PJK5EAeofn6hywQ5RgmsAn8FV/ZarSO+aLO/4+93u3Do
	0JL8pa/9K56LmlOFCAy+73GS/vuwfIKV721lWBv1TtBnPSCFpXlaZDPEbmMpGGSsP/4y3R9mgS/
	5Jgy89EbQBM1JZvKQ5KdPS1PLGYCkdAg==
X-Google-Smtp-Source: AGHT+IGvKhT3gJ5OIV//kNHseJE2G/H3/wQwPzto24SSyPwFcxvww+3Llywmeviv2fieZ9vE39+oJg==
X-Received: by 2002:a05:6000:705:b0:427:603:715 with SMTP id ffacd0b85a97d-42706030721mr5143032f8f.18.1760904935453;
        Sun, 19 Oct 2025 13:15:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:35 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 13/17] libbpf: fix formatting of bpf_object__append_subprog_code
Date: Sun, 19 Oct 2025 20:21:41 +0000
Message-Id: <20251019202145.3944697-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..b90574f39d1c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6436,32 +6436,32 @@ static int
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


