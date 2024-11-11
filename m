Return-Path: <bpf+bounces-44513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12649C3EB7
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B121F22635
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C919D8BC;
	Mon, 11 Nov 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC82gex6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5D19CC28;
	Mon, 11 Nov 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329378; cv=none; b=NT/W0hrhjPhKTQQ3wnRLP1xUWFZGIX3BOAoC2SreFoFHlVn2HW4hZ38szDPxK7H+QUoRWtfELIZ8yG6m4Ke+AGIflHnnXGuuIIRtjnFM1HTTeX0EQUZ8FSoSB5r5BlTwlkUv9GY1yBuZO117evCaJb7dH9aJ/Fz+++eCBreE2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329378; c=relaxed/simple;
	bh=o4x7aN/mdlbSSlNZEem8kx2O7vSxle7DNvQD16Zo7HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qj9IaO9gBhCA/Vizce/uvempMtamA4wbuY2PSBFwZKHqWRDHMjWwsZMHbTmfJUATHh3ddVbbrblhP+Bf4Efd6tuH76yC6z0VfmTyOo1ffG2r8xV1v/sWY6k0ytTBsXMnpGSwLV4uzQkV9qIvCVm2xAiTm09PAOwfbsQV7OcBbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC82gex6; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cdb889222so45351895ad.3;
        Mon, 11 Nov 2024 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731329376; x=1731934176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6rbBAhxvbSFqxCj/b5GrosPob3CSa0FAsJOQC6Oc1I=;
        b=NC82gex6oOEYYb0S8GQ7hq5S2dBcHjq/h6ykOiSZSwF6/tOPpTazaslM6peKJ+BQEy
         hOQz+1T+tN3AJkTYzxl4rAPS7Vp3R1z/kGOKiTtfE6+OWjrqOouTG7TQUrpfLyybUADY
         //IGqDezUPgNHr89DNslpoa1tz7vW9hTZHaKwqGoqNeQA8y3MHHdpP2QUaHeG8teiDTM
         AaxnZA6V0ot7udKLqRL3eiUZ1KpEgGTJoN2ucw2sifMddw6KiJk+mqunSHAxsrers/KK
         YZzyLKT6VOpTosgH4nSYP0LMpLkylCqjnb9zBgu9HJ01+zYPrzHR37p/bSBoPgiL8H/z
         Snjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731329376; x=1731934176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6rbBAhxvbSFqxCj/b5GrosPob3CSa0FAsJOQC6Oc1I=;
        b=qLuKmB8aUHrKOTYRW9nFKpfOsc7w9vmnNrdAdUKznwsMu7ANw6eO2U+Q0xoqgDLPx9
         29xNaQNYt7WFZEmezwdvJXqlxnsVrJRXXNtzC8tSPIhvj0L4kAeyhLh4knUtlb/zqvRJ
         ZOk3NSJ0ehAKriW2x0hvxEC1LF+uzbpVTMjobQcZRAzjvN2SRguCY85TgW/zy3pyp+nz
         2dazYV+etA51iOZfee7HSF2hi5Ut7tbV+Qb3fJrzLDt9jBUmmYgLeeR1X+hd1nn9mE6S
         1K70sdW3oJrrTFjY6c9656oVLRLzWD2fYm9PsQc24jfqYFtpCi8z/84RrTURHYYgym+U
         tmlA==
X-Forwarded-Encrypted: i=1; AJvYcCUJv167h5LTVcKwLTIGYO/4YlVJu/ZaflqlmrFWYO4w8sTqxX3sdBdN14TWf/w20td5g5I=@vger.kernel.org, AJvYcCWl1GqkVsvgZ3jyZKRCGG/NnXypJp6WhYLCUt/Z8TJxIbjeGSFpBD5EltkIljKJd5OtXPTbQV3CMkYOZCGN@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSDwwy2WiZ5Vu1rLJyArzGnEQ4er35PYdXPG8P5Jgkvszyvu5
	Z/EpH9JbpYO8wHdeTeF8xHubMTUKV2/UzhP2wk9poJitCriP9KQY
X-Google-Smtp-Source: AGHT+IGT1hcUc7CuZIgFiyXHvNaYulWkM/6y5QszBwgDWM93sWBfS6Qg02PssrINipLhfAdakTZtRg==
X-Received: by 2002:a17:902:c951:b0:20c:872f:6963 with SMTP id d9443c01a7336-21183560518mr183396705ad.33.1731329375794;
        Mon, 11 Nov 2024 04:49:35 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62d6acsm10550794a91.53.2024.11.11.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:49:35 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next] bpf: replace the document for PTR_TO_BTF_ID_OR_NULL
Date: Mon, 11 Nov 2024 20:49:11 +0800
Message-Id: <20241111124911.1436911-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX |
PTR_MAYBE_NULL") moved the fields around and misplaced the
documentation for "PTR_TO_BTF_ID_OR_NULL". So, let's replace it in the
proper place.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..7da41ae2eac8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -932,10 +932,6 @@ enum bpf_reg_type {
 	 * additional context, assume the value is non-null.
 	 */
 	PTR_TO_BTF_ID,
-	/* PTR_TO_BTF_ID_OR_NULL points to a kernel struct that has not
-	 * been checked for null. Used primarily to inform the verifier
-	 * an explicit null check is required for this struct.
-	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
@@ -948,6 +944,10 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_SOCKET,
 	PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
+	/* PTR_TO_BTF_ID_OR_NULL points to a kernel struct that has not
+	 * been checked for null. Used primarily to inform the verifier
+	 * an explicit null check is required for this struct.
+	 */
 	PTR_TO_BTF_ID_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
-- 
2.39.5


