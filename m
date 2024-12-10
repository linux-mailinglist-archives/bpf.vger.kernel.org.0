Return-Path: <bpf+bounces-46483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4AD9EA714
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE2188AE3D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB92248BF;
	Tue, 10 Dec 2024 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDYNSHG2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FE13635E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803876; cv=none; b=Rk2hJ5egq8p7mUhK2OopfaVFVPTtwmBEKcOZeuL8yndgla28OREKUVkq1BtPdDNKNvhXRz4LNfHK7XFWvRXV2+c1vSvEHEIlm16/eLV/DYlgyngV3zzR+Ic8F5hJ3ZPS3DO7xktxgByDahHh61IbAEthj53fyVMF9YSV3FMjeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803876; c=relaxed/simple;
	bh=TlC1hQwWMq+Mk+iKtgbwNYHf3xze7SGO+PXOV4DIyIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkm76pbhOQPtn93Nn1hOyoiXfw5X7ogDHEf20Ywm2sp7TvEFcMNRUeUxaBV9zsb7qgohN/KfTWiK2yAlpeNATdRo9Y8WkZnk4biZRmQ0F7LVwCud3BMfo2vLZJMflxGQHR2GFTieymCclSho0FeD8GHQkiq7Vyp2gmVVV1Slfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDYNSHG2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163bd70069so20329405ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803874; x=1734408674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCeClI9N6IGYROGb0Jn7lpSIINKCLvjsqLrZAWgTIeU=;
        b=lDYNSHG25MnNuPePchaFV7AhDQEo3eTsKsGgTNxHV3sywU5F5ax5yKDknYkUzPG1gP
         MaLr+dHSPjopTXAIasy0tWoOWazRauAahpcOh0C96Ebfg99hjcBLorVH2byC8jTP6tl9
         Lv9+Jtzb37Yb/nMe8z/3olwuvA0+vkcc9rVz1z9WJ8BxVbEL2oyTz/iKcGnlt9/7h4V9
         JPBCah8Oeqq9OMtMbru8J7zY4FtPq1wGbhYjGM+i2WWBx4pPh6+BB7zJ/nyYoiANt1Ic
         +Tz/UXJGBxdHifck30UtgZi1dXC+W2ZZ/B67JBdC97QDtrO/Z8Pg0fvT19hKdJj6tX1j
         iPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803874; x=1734408674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCeClI9N6IGYROGb0Jn7lpSIINKCLvjsqLrZAWgTIeU=;
        b=XGF7fI94x2D8O3ATyTLu1bMk+a+oM2XmT6zF//2eqqpUEjSdTKB1523hhUETqMIo8G
         bOOTJRWOdoBrosTLOjnQCS5+cf0wi2TtMOzy470EuQ1VTs4aJltBvwIxuGKLWSFaj812
         wkTjr4MvtmZ+4fwKOnXaVZ5Ntn5/qZRu8Yzfv8/97TziDuHN+sw8kWvH6KFt8GXHbu2c
         ci7gvEp+NrE9J+RnqHiLgSWZjwG3b601PHRXbKP+CM0m2tnQ8JdqGRWn0/Gt7X2bwauI
         C2somYk6pCxVJTZzmFmsULItvaSRaSJ2T3giLRiEPDxHXne/tAOEAKAmlmMwxpN0dDJF
         35Hg==
X-Gm-Message-State: AOJu0Yw1QFFl6up/OBIHSAXmpMFnyMnsgIRFAugyER58Zlq+zkf99nBV
	FNSiNCcnJWiLS/uktFCMZsbsNWkdE1RnpBb9/9XhZ8vrL6+SIYiF4us1fg==
X-Gm-Gg: ASbGncuX8Q04PLaNGtfU+JcbxjMzuDOEobnKlOTWvUtsHDdCbqeYXgFkCEHPs/cj333
	LR4E+RN1kdhNmKEDygflHR8/oRG119gsbe4f1JgkQvuwFFYJz0dFYMtA12vyV9iF2KD8vw6GWnO
	/E9I3g/AeCJ5TIw9RIuTMENxMqqfZzBmWMDjVoO6rHuP8D3lwnVSXsprARPbMRKwhGTqv5etvd2
	BLb5ArmF8PDL78ir+mZbByVehBMiFF2a7WaHJqmIFY1mnl5Pg==
X-Google-Smtp-Source: AGHT+IGuPbJdR3X3sCHtYaOxvjUKrboEu7GV+BLb7uA+Vr87gy1ztVCF2XHxUaD15/TbD6of7mBNww==
X-Received: by 2002:a17:902:f552:b0:215:a412:4f12 with SMTP id d9443c01a7336-2166a01661bmr35043895ad.33.1733803874157;
        Mon, 09 Dec 2024 20:11:14 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:13 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 1/8] bpf: add find_containing_subprog() utility function
Date: Mon,  9 Dec 2024 20:10:53 -0800
Message-ID: <20241210041100.1898468-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a utility function, looking for a subprogram containing a given
instruction index, rewrite find_subprog() to use this function.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01fbef9576e0..277c1892bb9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2597,16 +2597,36 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
+/* Find subprogram that contains instruction at 'off' */
+static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *vals = env->subprog_info;
+	int l, r, m;
+
+	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
+		return NULL;
+
+	l = 0;
+	r = env->subprog_cnt - 1;
+	while (l < r) {
+		m = l + (r - l + 1) / 2;
+		if (vals[m].start <= off)
+			l = m;
+		else
+			r = m - 1;
+	}
+	return &vals[l];
+}
+
+/* Find subprogram that starts exactly at 'off' */
 static int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
-	p = bsearch(&off, env->subprog_info, env->subprog_cnt,
-		    sizeof(env->subprog_info[0]), cmp_subprogs);
-	if (!p)
+	p = find_containing_subprog(env, off);
+	if (!p || p->start != off)
 		return -ENOENT;
 	return p - env->subprog_info;
-
 }
 
 static int add_subprog(struct bpf_verifier_env *env, int off)
-- 
2.47.0


