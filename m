Return-Path: <bpf+bounces-50608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15AA29FFB
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF48164CF3
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E322330F;
	Thu,  6 Feb 2025 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTlr0o1A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FB22258C;
	Thu,  6 Feb 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819098; cv=none; b=r9ZiJp9OXvHB9RFeSz9TyR4fXInzsfzvuFmztLAif7cGmlu8Xolqf9G/2LXpB3KLIRPyFj5hef7SeQ5VOfAoOKyK112UxgFQDd7tcYOxtLIssph9Xvj0RlCuKWy9VTF+QVYvyPQJq+YbxwffhYB32uo+V5dzLoUktKT3veTROiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819098; c=relaxed/simple;
	bh=gCSkhghV4FSQv8s+RD3+Va+foCnFjyb66eHvLgkiuWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dGbd9IgEPaU/eP5e9cVQ6pVtn5QCBFWGwAlWnRn5lEQ4pX9mEzp1eoATha8+NGlTySTh4tFsGGylBhNNoO0V930/Uee0cUbsrjp3Jix4RlMGeVVus4LcgRWEKtQ9wM0A+5ODLnMgDfhK2VJ0n5yWN/fmSugpBPXkqcX1w8RjGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTlr0o1A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166651f752so11783965ad.3;
        Wed, 05 Feb 2025 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738819096; x=1739423896; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=lTlr0o1AZ8r8s59mNiX7jseGXArn7tluJpXPpoeWeWUuAgEeZO39DrtaHJMLnbgEU2
         Emf0UX2mDbAViLZAArjeRqpyj6iHk53N1dDqGpWi/JMPcjE1PEZ5mW1DIduJaJlR18rP
         g+hjxSd4amSoXvyLG5VJs99Ka4iRT4WoZqXB8jU1dZIgZTvxm5I7BUhhpBDuROaNcotI
         VIv916hUtEIExI0VKHpkDFepQGWuGlIH3Xc7KcQ5S/n1hK28SWIYi7VI1M0/H9gWf2t1
         Uxl/KUJvH+rOVwcibGw0XAseF7DbbOPRxpP8Ka7Nb0AKE5sJlZhGGIfpPdGdSlLrtZcQ
         S/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819096; x=1739423896;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=sczml82kga0ehQ0Yt1uxes4Z2utNVRInMAdCMpvacGvqKp1eNkoMrP8CKnKaMT/3dv
         Oztxl3AlRG0NUhkqz2lo/wIOjIchoksKci8so0ovU9woYQJYgs924mkdSBPRLpswrD9E
         GeXAOJIO88Dmkz1bu3SUyCHBUhHNvGqCxBJZm0ASk7jTr5cs//VU0rKZVt+5AMzSJd4j
         W+FRG/fBvIJZY6Wxpw+Mzke7nCe0cZfKmzyP8+qFk4Yx70B/7KTQJObYrD2S5Ph1Y+JA
         C7Oq7wOjn8ukVAlIi5J6Z0AbwDq2SGAAs1GW8tL8BlVAN5s2bT5BVMsMvDu7taMmm3gn
         m3ww==
X-Forwarded-Encrypted: i=1; AJvYcCXzfzzwYU2b8Q1WCnXkbyZNUSdnDF/HJKD8Qrxw/FKRbCQOlZq4d0F1mS9ptvu57B3DYwteCiFPS4p2NSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1V+iv4cSzfCaoxgqOezPa1IvPeezfNYysjhlex5BZEcyEE65
	bdsywzC4a8CcHuIiiNXwrdE8HG4AmwCpcWxkOVKOCMJ+3p7XhZn+klMsTQ==
X-Gm-Gg: ASbGncsmZVnB8r2A4dKl1N3fQG4FEYSXLTr+HhOUPY0dCK6HLJ4Ky2DE37GlFGd3Y9k
	cxZ9OKbyBPG6d9DsaLL9558LCIBCwxDE0HUeyM4UuqHsvp/lkRrhfLWzSbW0zpzePhLWauQt6GY
	jjfCuHeT2O51qEHPprzSKqFFlVfUfep4+1aDWZ8BH+D8VJyd3K7jyKjH8V1ZDQYTmgEUnc/1S+U
	WxM1uOJTVUVEJ8PZ4jFkWE8n828zYprLGKTX90pN2RiN++nwq4PZsgYtEsT6jbvOMQMPU+s3S6X
	L/PSdpA04OS1b1xY
X-Google-Smtp-Source: AGHT+IG718WaHI/zyVKjFrVcEcSmpN2DRdpWXZQJJcpkenwFSpphzFwiQVBsUkUYk0c4Qhuccfrciw==
X-Received: by 2002:a17:902:ce86:b0:21f:55e:ed58 with SMTP id d9443c01a7336-21f17dde8b7mr95825255ad.11.1738819096203;
        Wed, 05 Feb 2025 21:18:16 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36560ee5sm3295015ad.96.2025.02.05.21.18.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2025 21:18:15 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v4 1/4] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Thu,  6 Feb 2025 13:15:54 +0800
Message-Id: <20250206051557.27913-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206051557.27913-1-chen.dylane@gmail.com>
References: <20250206051557.27913-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..aeb4fd97d801 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
+	if (!can_probe_prog_type(prog_type))
 		return -EOPNOTSUPP;
-	default:
-		break;
-	}
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


