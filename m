Return-Path: <bpf+bounces-17348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5496080BDB8
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 23:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDF21F20F11
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 22:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170F1D550;
	Sun, 10 Dec 2023 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdYqlgei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39004E8
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:52:21 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77db736aae5so200134985a.0
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702248739; x=1702853539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9ijvsy/vuxKNH+E0yYimZ6YUBwiTTikEQcABULg+Ck=;
        b=gdYqlgeiJ9wUOrxRhu6ibOH1ESmZnO93l+oBXQampMn/lyWhXBYiZYvv7jx0ZHaH6p
         3BK4lmL7DicJYt4k8l+wjhmO0YHoZTxUKuVTs2lUHpGEwUK5gllUJGSVcq0b1QTWc0U8
         nQ4qkWChwUjZR6X3Gb3DnB/O8g4VYdRPEmkeFnVwngKr56n3Tl+7WFVx7oiydA/rOD6b
         /mAL57A0Tl2J/85weS8EqeH/Ggs0hN3dvLMTODKNludnPCHZIZWEZ0nXOlWimZQhx7gW
         bpauQ/jmh/GihlhlJ9juG3vnWPMGS6nyAEcyOuy0eck2F3OJWDbb8Qxzb/brnKkU3wsi
         FB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248739; x=1702853539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9ijvsy/vuxKNH+E0yYimZ6YUBwiTTikEQcABULg+Ck=;
        b=rXBUMEWIMOJ2dhKB2cEpzj8qEYwuHc+wYtT9ArowaOX+SIbPghMgzIGEz5otKoKDQR
         HNcu1yIuUWuCmNzl2XSpEgaqppX7UX0qkjorpIUPnWOITnSoz52AmtNxInFla9UJbrDY
         KNzpIEdeGBa8WP/2DUSg4F/tIARxkxOiQf/qAaKi6S74lqaT7p8AYQxGwj8hKGMEOnxN
         PT5uXEE10UWFXWotBE4DShT398I07UD3iz7tTOXQ4DebKYD311XSSPXMraqoOp27rwVm
         z2WNZd3oQt7v0YI4CIlMsRgt5NafO83wHqsnedhelzCqCkyeIH8myxKCUBcgXtkSoJtk
         tAHQ==
X-Gm-Message-State: AOJu0YyHg81iDEPZW3bCoULO4+NRFNiChs3WE9r3PjeHOfvJnLCmc1BU
	tavE5Ksa0E/6s9z0JxO/pLtdomVsi45TKA==
X-Google-Smtp-Source: AGHT+IHaT9RuEm8W3lJisIqHVxMH7RcmU7B9X0En8vudC14henJ2rJ0iBc1cAmcs7cFa3B4Q5Qkc0A==
X-Received: by 2002:a05:620a:ced:b0:77d:7b08:3f53 with SMTP id c13-20020a05620a0ced00b0077d7b083f53mr3681027qkj.68.1702248739394;
        Sun, 10 Dec 2023 14:52:19 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:60a8:b515:8d17:4f21])
        by smtp.gmail.com with ESMTPSA id p8-20020a05620a22e800b0077f289b92c6sm2427950qki.123.2023.12.10.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 14:52:19 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next] bpf: Comment on check_mem_size_reg
Date: Sun, 10 Dec 2023 17:51:50 -0500
Message-Id: <20231210225149.67639-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a comment to check_mem_size_reg -- a function whose
meaning is not very transparent. The function implicitly deals with two
registers connected by convention, which is not obvious.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb690539d5f6..8b2f29d8e0b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7252,6 +7252,12 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	}
 }
 
+/* verify arguments to helpers or kfuncs consisting of a pointer and an access
+ * size.
+ *
+ * @regno is the register containing the access size. regno-1 is the register
+ * containing the pointer.
+ */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
 			      bool zero_size_allowed,
-- 
2.40.1


