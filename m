Return-Path: <bpf+bounces-46007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2369E1E28
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C45B16698F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640E1F4272;
	Tue,  3 Dec 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UX/oUB9n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9171F12E3
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233728; cv=none; b=UwQbYzNj7Otn1NRV07Z+GrJugC5A1ZMdnTtjswX1G3N567/EMKrsWlQ6T8KL6QYr7PIJ+ESN3yDzbJgKWFT+2k6r7RfxYpCPBiDnEgLvpM5+BY3Ym0c2vVFApXtTTREtEq81LnuUFlw5E17mO6bBXgMfLOrSxhk0C8BGXvOyY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233728; c=relaxed/simple;
	bh=5M+9sZ2uOISCSb6KW/FXzpjBYHwIs149KFBIoWPdbV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dees4EFWKzbpVcJ+VWWJf4Bg6x6xv9+scM9YZdcsHugPgb8vJAeoCmVUBzF8ggh3N6mYNTQP7scZfNLZIEN68fKLvGIoeHiXql03v3D6BAtlRH1WbPaX7i3l/Gl5JXP3cj7lCRz/Ku1rXL1PoVDsCrb+DEa93GhNV4KedZWMbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UX/oUB9n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1570729f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233724; x=1733838524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=UX/oUB9npM+lbSOwGB2xFRmOJ2MiS3dg+qk0BuKDRqoT1ToxJMpRP4+qy+Xs41PbwO
         kUoLm3RJxC7Kbbw6NBiErASyjdo03dvjviC8/SKjfrU5v2kZE96C8aBa1OXYDL84XuOt
         ckrqH4C5vBuKzHacqOuGfi3W73z3433fUhtqspBQyw47mTzSlA/QmuIa2DcO0TMmdZSJ
         Ayc3AYvybhhOYa1IruP6Hr6mkaPE41O1v+Gl2r5qyiKcy76DD2v3hzj3PJTFEonKKhlh
         MmHYDouvgyncB5+CCuBCpDUaY+ovcNx1gSgiXe52hx3wQf02YF9GctXXf2lK62ihoKMv
         1OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233724; x=1733838524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=tUmuF0KqRfXcUvPz1o7wa5Ouw8jUkzUL5Zd4lFAr/Uyq/JxYLB+azC0o76QqPfnenI
         KDsnl+3mpXIV1nwyxwZDyGm+Wu/Dod+F3Tz+ke3oH3upZuFSeM3KsE4mAYlIQgWQVeqn
         TrUlwEzIftkaHAQ1LfQdAIiwQREj29MCOqW51/d4pN0UfPhFTLYpn7GWSJi+0mMhoGg8
         IEgJZ5EmKtnmxpYQeAhQ+9BOX+pLBQypTur9FD3VnocB2iKiPtD+m6z4IlYdb2B8oUtj
         /28q9++YVwRCHlXob30dpFfogDrU/IQ+EUKZvrRQvb578ebnWuQ0h/zqA99f5ciLizrg
         OUXg==
X-Gm-Message-State: AOJu0YzSj2K8ZavET7YQPS689ObJwqcef7zQc0y5PkQuIsb/uAjEivQ9
	C5QT4biyYA0+awmOGVKwGC5Bt9QFHSgZ1/RzqWUCjntlV+2cpyhiXuwFa6pSQQOu+WiLRkw8ECo
	S
X-Gm-Gg: ASbGncvr3NUxQBFpVwCc1BtINoGUbRuSdDBuHcpq0H0kHdZPsX3NcbK04d53cLpLDPL
	l9pJblY8j48BbPLrAZXFeFY4MM+Su7BM/uiV0N80Ak2v+FC21TWy/fGVf10rSsagA+n/fvYtlWz
	kP+rRcL9M6TxB0ng8pumctsX6d59vknbxqDCmeqj/h9IfmkHSidcDmJhdljY9Fa31QhOvpZKHNl
	+Y7XAAOZS0DO1HmFp8NvYPHMFwAh0S7K/Z13Zs2S5aFzsorEDS7ZKZn/H4rEmM=
X-Google-Smtp-Source: AGHT+IFruPw6fU165DSoj1vetOUB3CI91wqgARxs2n70XmWwljt+TRZBjH/hjUSlZtgG5t+v/c654A==
X-Received: by 2002:a05:6000:440f:b0:385:e3b8:f345 with SMTP id ffacd0b85a97d-385fd3f23f5mr1521787f8f.30.1733233724456;
        Tue, 03 Dec 2024 05:48:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:43 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 7/7] selftest/bpf: replace magic constants by macros
Date: Tue,  3 Dec 2024 13:50:52 +0000
Message-Id: <20241203135052.3380721-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic constants in a BTF structure initialization code by
proper macros, as is done in other similar selftests.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 0f4dfb770c32..b698cc62a371 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -76,9 +76,9 @@ static int btf_load(void)
 			.magic = BTF_MAGIC,
 			.version = BTF_VERSION,
 			.hdr_len = sizeof(struct btf_header),
-			.type_len = sizeof(__u32) * 8,
-			.str_off = sizeof(__u32) * 8,
-			.str_len = sizeof(__u32),
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
+			.str_len = sizeof(raw_btf.str),
 		},
 		.types = {
 			/* long */
-- 
2.34.1


