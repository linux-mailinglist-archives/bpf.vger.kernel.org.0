Return-Path: <bpf+bounces-46238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7029E653D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED122281A8E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF89193409;
	Fri,  6 Dec 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biIDGLUH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308B339AB
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457806; cv=none; b=L8zotfj6lb45FwtCEFCehvfXLdCWsTQ6Ej6A/TXnjrvUMldlBeRLVmZwht+nlBJOzdtuom5D12UihXAIwlbtDpz7ivb85xteC4eJzZHyUH8pMwIvuRXEoiBRErGEbh57l2n20tGP8QCe62+CrRDP0K5IhqHZGxrdlBh6KySeCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457806; c=relaxed/simple;
	bh=TlC1hQwWMq+Mk+iKtgbwNYHf3xze7SGO+PXOV4DIyIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZQz4Z+uhNJalR6at0bONQACvmDAKNM9a4RcHRL4MhURMT+GqD8VB8ynX9T7Elg9tAlMogASjMrxonHeRRtzf3l9f++KPHUomP/oXW4CDlgSX44ry5uOdaNVJIWdbbhIesul57UsEaWHV6IVu1ScMB5upCUycBEVuf7MiTdO+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biIDGLUH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eed4fa2b3aso1313116a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457804; x=1734062604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCeClI9N6IGYROGb0Jn7lpSIINKCLvjsqLrZAWgTIeU=;
        b=biIDGLUHACoBC/mNcXM/fC+uKcgnWDfpC80M2ofyYWBlVzF1uz5khT4hjaNVFpceA5
         dRTiLGu6APnGucXYedWd36lqf3qeidSATybNDCGcRsTNteh1XdnQPrvUp3YudTCAeV5T
         SGpenhTq6/rHZR5C5QxBXQ15go0S1mGLvJdN/gIsFCQGL4N5GGYZqi4NIYTm6wWtYDRe
         BVt4EcDCLlIzRcETjmH6FCmISO8Wgc9rURaS5Lpdyi37f1z3YwblZTSFcq/8XL9jpHVq
         mH1kND2PxCuu4FapIz5WaxQ6PBfVSYgrWIY88W4T+phdrgVNwCMP7MpDxHf65dhLxgvM
         k5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457804; x=1734062604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCeClI9N6IGYROGb0Jn7lpSIINKCLvjsqLrZAWgTIeU=;
        b=on6r/ymghDFxZ6NHmsVBYYIPHB5qGRJmcFASeoj3/OfYEiyywKPh+P2sssK7b73MzU
         InlpncBpWiWwpLCgB8bm2X0vWgijOGTEeq8rXhbUJ3FWs5H7yfbdPhGkv+r3KY7+gpUD
         6/ON2xLZHJKk/cBiR4f7XUBqnmVrviZoJtWx6G+781EPuPopkFu37pa3RVgeqjb1h3SB
         5QcHoT4hUqamHOR2qe7bvAjapEdrkOqIDUFmpFQorKH/WP9jqUc5m2dx4qQNRndHXwl5
         TXWhK8ptJpbmfMZNDERYQip+017dzKD+hhe/pn/E/VUUCH2ZX+/5cdMQmv2ExouOuw3U
         RLHQ==
X-Gm-Message-State: AOJu0Yy9vmbeMZhdUJUa2OOd/zOLBjHNGZ3m5rmMpNT3B8tzfDIZ4f/g
	gRnzP2+aMnb4MXekZI6hDaUY60c43skgM2RsG5RwKq5HdxtimTOQILiBOQ==
X-Gm-Gg: ASbGncv6Qscz3Rxo6kxK38IIM+FeiURfhN7jl+MujGG0TpcNdNfHCkDzqk1ySKonXC5
	QtFRKKrXItPAPodDdZgtUq2R0u5+DvJItt6Zeq71r1hxBzLzatvN89WI75UDWDWylrSkYjVpncw
	VoSDqNhPL9GDeHERGPr1Guh2VMp68iJMlxEaMnZdJcsW0P5Svlv4m3HpHnpwkL3mYH5pLfXRJAd
	ZPfCNJga2NlFT/ERWE7FsSAogkgDeqPKvF+Gb4c4hM2kg==
X-Google-Smtp-Source: AGHT+IGTDESjykmtNVUxiOHZ9hQK3VVjEo0wccEUHlkmkmzDpHfGPTEcfxU46BcIm4dfIRfUCs+HXQ==
X-Received: by 2002:a17:90b:2d43:b0:2ee:ad18:b30d with SMTP id 98e67ed59e1d1-2ef69654504mr2152790a91.6.1733457803789;
        Thu, 05 Dec 2024 20:03:23 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97ffsm4101846a91.10.2024.12.05.20.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:03:23 -0800 (PST)
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
Subject: [PATCH bpf 1/4] bpf: add find_containing_subprog() utility function
Date: Thu,  5 Dec 2024 20:03:04 -0800
Message-ID: <20241206040307.568065-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206040307.568065-1-eddyz87@gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
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


