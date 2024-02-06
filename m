Return-Path: <bpf+bounces-21375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84F84BFC5
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD4B1C24367
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150481BF3F;
	Tue,  6 Feb 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qve+Us7j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157E1BF2A
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257127; cv=none; b=PdncmG8uaosjumE82yQAsE1ACPwC6H0O6abEUXYRD7vt2JhyCxxoHVKxe2vlmKeLj1tu2QNLn01LVCwhGDqMrQ2ibSCByGpW6qq6L7xq4tQ44r8zvOPmTOjIKi0fq74eJuw0FjYktxKwn2UUS8ErQ5I7EnBr9tCjCmAzDkvjM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257127; c=relaxed/simple;
	bh=B9RYqjZPOWV6C0GMRY3SkdIHMqd4rfBrkE8wPVtghus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX8Mohokw2DakOMZI1OLwdzYaBZ9FF6c24tqeubuS4cBRgctvfTcyms0ACNd5tw3rwEvceerAB1GXB69seGZdx3t0uQ0Qv8RJFRdzu78Ojz3Nm3mmP0b3/yMIsGZAWcjzNNKXE9VG8dd6F8/F4yLHxpRTwZNvL9/0hOdmvyNt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qve+Us7j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d746ce7d13so251745ad.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257125; x=1707861925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyKA4wCImIZZ5xJE04KmfmUkjYhSBJW7+tRHKBcOaBI=;
        b=Qve+Us7j7oZ9dywQEK4BChKkAEZi4ZQv3yaMVU0tHd4HlXoIUI7KCaqImoNokbERcM
         9iY2/3VCOHggrdwvLbEFqrQImtsBKJJobrYUGh76LMMCkL+ktHQ9PznrW7jnfWoHJayI
         kPmYqRAUqyy8zqi1JztsWd6Sf3WP7M/9XLNUbVdJK7AqVRk50XfiKScLLh4LTpE22tXt
         dR97s7FrYDwTdjIaSY0u0fkImUpDzwv86S4R0l0MfUiNWWdTYDC2Z+vS0yrkCSpaDm67
         z7mczB1/fn50YWP7IBTEPJuRnMTb7khF/egijiXwKKmJo/GGa4fhMXnizP7ztWiMFGiT
         Flgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257125; x=1707861925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyKA4wCImIZZ5xJE04KmfmUkjYhSBJW7+tRHKBcOaBI=;
        b=qaUJMYuPC2pGkrOBGdV9qbTGq5xFlYvePJszMRo60zaX4fH7Bm05DFUA5uGUMIAmnH
         Mn8d0vrLoIFbclmhIkUrwwMA6b8uhkDJQcoMBWEIeXoTFAcn9sLvoMumPpaktVsytXid
         en+bVL0THKrgTvl14C0sjNQ9cZlNWiqbMre8lNXm0NsT8Fo4nWxB8Egu72JN1utMlS02
         z7eAR2Jc53ooczXB3R3dcFlr8rMyxlXuPwSoxUnml3goja4rkJ42rsvrsUnsBBxJm9n8
         hYPjVMpHxn3tze4pEblp+MJBEzhTlBupOwUzlp9kVtZgGpUkkhqDqs7Jib0Wq9jRXQbs
         DWxQ==
X-Gm-Message-State: AOJu0YyV5LHxr5G77xWhHjvP/20dXsMDr+GfarZpPwLsyl+286QCV1Kf
	rLvWlRtRXcdyMeK8Hh9p1cbtAwOs0j8aR37/pQKR/hrer6UY/Y6kqu9dE8kF
X-Google-Smtp-Source: AGHT+IFCXZo1wWd12w2djsRFUVDKXDBOg++Oi4WlWVJBWuRKgnQggkaBieLi7zmDvrE2yA+j9R0Veg==
X-Received: by 2002:a17:903:2344:b0:1d8:94e4:770a with SMTP id c4-20020a170903234400b001d894e4770amr2939440plh.51.1707257125081;
        Tue, 06 Feb 2024 14:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTg5DTgGf7yruJqB/WI8D3C35qukvbUy1OcPrsmlNmRj3bMZLrv6ZKXl+1ZliwY5Yh+RSrbBH5jJH4p9m8Da+qCe4R7jQ30NGMqR05TYm6hYqiEn8rHQLlMXL6NgE36kXCg7GqxrsrdtD2zHMjjnwBdDAYT6ffHki+e2V66HSHGIdS3pm2Bi07FjJ0b371OAyhqlw/auRDkPE0BfpAnLuFVa4mCeL/MsiaPAHWAYGJs0SX24t1cZkpz2mX/gCglBvOUJsHd/acn6fNCiNO1QmPODy2sogSJAE7
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d11400b001d91b617718sm8619plw.98.2024.02.06.14.05.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 10/16] libbpf: Add __arg_arena to bpf_helpers.h
Date: Tue,  6 Feb 2024 14:04:35 -0800
Message-Id: <20240206220441.38311-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add __arg_arena to bpf_helpers.h

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..9c777c21da28 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -192,6 +192,7 @@ enum libbpf_tristate {
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
 #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
 #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
+#define __arg_arena __attribute((btf_decl_tag("arg:arena")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.34.1


