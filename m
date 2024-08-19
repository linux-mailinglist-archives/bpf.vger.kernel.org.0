Return-Path: <bpf+bounces-37524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8402957009
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24A7B291E4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F316D4EE;
	Mon, 19 Aug 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7ICdLvd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F848287D;
	Mon, 19 Aug 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083690; cv=none; b=VewLxqahePS54z9v7JVTYTPvHCK9QsZZ2fn0VhVI3LEDy7eT5j6pXhMe7oc7FXeoZprtN4eoxnte93soa4Hy60FtWT9pQtilcKMC+XWnJn1a352Tt0L11lpc8TqLq7/gM55Aoo9CNWdTMvg/6NcwbwMI7mYOvTHgxGLGk1b3lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083690; c=relaxed/simple;
	bh=yoBkZXERKr7bqbNe+5gAs9ggqERpCzVHPCNNXnlqfUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRrZZEysrEG5gADWj8IvldW75TW5+up78n0X9JncsM2jpfPERzOT85umZXUnSPGyISy/WK/lgc9KVx5n+e6Z8/BZOKIRRzJ3gBF+zHU2pHvyMigeFWnRxCzdkO41sY0O67wmOk8R66PSW61ZgFtJWd8LTDxE4UffRv9lUEUXQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7ICdLvd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso2619622a12.0;
        Mon, 19 Aug 2024 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083688; x=1724688488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWG9imhLWmDvDlk9mM25jvvBh/M6NY5p5kOC4fBkFzE=;
        b=h7ICdLvdGlg+F2Y6jjeyrZGTMG7Q5p+JXW8G5HWF/Hu1svLfoDWUrx6rBBNESbLyDp
         w6UD3XgFVVjblpuq86P8SUkGXqU8zzEuT0sSMjsLpLk4yRdXoxs3qpG2tg+BN48JdMzj
         7HhMgaKOT0FBvc7kdBBtVK3miGf0EETnUkdfcSy+sp5g7fiKmGVWP7JBUFSNNrkKq8Yd
         zihyMat1jJJQd9J/2oEC8zQvu1KSwA5A2vuYNup0jFnpnlPrn4V4D2kKI5PiISee3Bab
         0fsjSrr/58J/BJF56m4JFbERLPP7PDgwYtlnJ09oft7b7DQMQsc7v4kGqvTvRbcMmX5a
         ER9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083688; x=1724688488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWG9imhLWmDvDlk9mM25jvvBh/M6NY5p5kOC4fBkFzE=;
        b=RZgPn7CNnc5cD+Mz25+iETTEy61bWrzvy1lqIkCF288FpjBjU8To6X0JrwnY0LcH6y
         1JAuUtPt6rRitAWYTRdFNihh1RgpzBdZhItmX28gY3dDmPyJAGB/rZrh2SyTDgxCecq0
         8x0XQc8fCmjeGFQW3PdirDw5YDMJsE+WG+GZl2URXaG7vBEQUoSButM6WGbTgVDwaO1v
         G9UsMxI00WgoDZhlwbEEO1ySU8G6f1XN4dDzvcbotFISXVI8OupMUhdqpnyGh67bH9w6
         OspuhGJiZFF9KmObeynv0U/D8aZ03a6iRMVtXs55WnCmtTFCNPsaySHhdIGdu3uZZFCc
         lrzw==
X-Forwarded-Encrypted: i=1; AJvYcCWhV2SBdNNfEwAOtJbOXfHcY/Bev7xj8naT/KqHC+N14S5R4yZ1+71IzyNlprz15a3pLT7rJMIBVzPlXi6h7HyHRNSaPMbc/xyZDMJx8QSmCXZ2HgbEljwbQZhp991oO7jD
X-Gm-Message-State: AOJu0Yz2jST/CVfQDufEBRvJbmTJMtO1fj8jugN7Od3I5Z5p4aGR2Cqe
	DU8SraFUrDbd+7p4yjcqM2IvSKLdVg4jk6x0j5NCLaBqHV4GXd6LOGojKxyoROc=
X-Google-Smtp-Source: AGHT+IEm5K9AGKyTbpO1cOvx6o6INI1yTHRJPO7R31ZUmQX3rnMpnVm5D7Mugw+hTvEOc6AoZzIaAg==
X-Received: by 2002:a17:90b:190a:b0:2c9:6ad9:b75b with SMTP id 98e67ed59e1d1-2d3e0e4210emr8406848a91.40.1724083687820;
        Mon, 19 Aug 2024 09:08:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3274642sm7332961a91.33.2024.08.19.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:08:07 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH bpf] bpf: Refactoring btf_name_valid_identifier() and btf_name_valid_section()
Date: Tue, 20 Aug 2024 01:07:58 +0900
Message-Id: <20240819160758.296567-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, btf_name_valid_identifier() and btf_name_valid_section() are
written in a while loop and use pointer operations, so it takes a long
time to understand the operation of the code. Therefore, I suggest
refactoring the code to make it easier to maintain.

In addition, btf_name_valid_section() does not check for the case where
src[0] is a NULL value, resulting in an out-of-bounds vuln. Therefore, a
check for this should be added.

Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/bpf/btf.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 674b38c33c74..c1e2aead9141 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -794,21 +794,18 @@ static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
-	const char *src_limit;
+	int i;
 
-	if (!__btf_name_char_ok(*src, true))
+	if (!__btf_name_char_ok(src[0], true))
 		return false;
 
 	/* set a limit on identifier length */
-	src_limit = src + KSYM_NAME_LEN;
-	src++;
-	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false))
+	for (i = 1; i < KSYM_NAME_LEN && src[i]; i++) {
+		if (!__btf_name_char_ok(src[i], false))
 			return false;
-		src++;
 	}
 
-	return !*src;
+	return !src[i];
 }
 
 /* Allow any printable character in DATASEC names */
@@ -816,18 +813,18 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
-	const char *src_limit;
+	int i;
+
+	if (!src[0])
+		return false;
 
 	/* set a limit on identifier length */
-	src_limit = src + KSYM_NAME_LEN;
-	src++;
-	while (*src && src < src_limit) {
-		if (!isprint(*src))
+	for (i = 1; i < KSYM_NAME_LEN && src[i]; i++) {
+		if (!isprint(src[i]))
 			return false;
-		src++;
 	}
 
-	return !*src;
+	return !src[i];
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
--

