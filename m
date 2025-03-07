Return-Path: <bpf+bounces-53618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D5A5739B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613D516D0F5
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27482580F3;
	Fri,  7 Mar 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrzkoJWi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB82580C8
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382987; cv=none; b=jlM+YhqR1ANL/mHsEx+2ZVe7p4KpMN2zUBUgSF1t1p8NZlK+7Z4V1DYM5GLkedGGFtCgFn8bvN+Z8iCr+qfPOU1YEiwRqXTKTWdBc93Xp4WNlWy7bBHEjU2wLgKmZXvUbqAgVHyMrR+YOp94AnuCH+mNLgQLk4Ut3SUwtop1Dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382987; c=relaxed/simple;
	bh=5QmC5BJ8UOeQoFTqcSdRqOtD07G01V1y4TDKYIRXM1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUOPFVQMvYa1nd7UspOdSV8dPpuFErZXomIVu6m3XHWp07z08QmzconyQd+iUtwGK+W6hYMs3LHioevuJo77qbQPDj2hX6fhEOn8Pd/C1SzTUyR59GTuW7f2in0jbvNBJE2DaOMq9BmlHg56YguEvSTFqdXCxw/8MqCvfn0f5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrzkoJWi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bd87f7c2eso13381005e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 13:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741382984; x=1741987784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDJDYACs7qRx5sQsJQeD1hdwVscTxc3AucrD1zro2f4=;
        b=RrzkoJWi2SNAKXCMX6/Nd1SyySaaDxb6dK5ie9fOBWb5v+3P7lR1+rPgH714MS+qRt
         spSj+8jByN8gnKtb1961VEwMvzVrpwSsdDfevUTd8P7dakG3oFlv/m2GmWmbQv8Lndj+
         Y36R7ERiWs5U6aciRkausm/6Bxh4XatP2NBe7qTdNOPjt/Xu4riP4qwVBC4IbQuXE9U8
         Gr1fxmYsi60Y3IAridHG/DixKRZP2+KIzbxTsYZg7Nu8ruCyBUhaG4xWfSd7n3EVocNW
         eEx49F7IU9TJBaS+m3M/tW63dsnR54R/WOlk9FYa6Yf2W/7W8EiNo4AHe6OaO3YqbRIA
         0p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741382984; x=1741987784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDJDYACs7qRx5sQsJQeD1hdwVscTxc3AucrD1zro2f4=;
        b=MrMNOo/o/DljgEDYU9bZIF0GBqsWYntdudJs5dMSsIoLiWRJqVb//I6lmxNVg2agvQ
         HIz3H0Iihyp9pd7xpBAAkZ46ad2NrK+GTrUdQIWntm3esaZTFjv8wjllvYjsixX8ROjK
         n15i2k9r+YOU4sePMmRDbGI6/tMxM6fuuMSIVcpQlp4zHfxi1pq/lqFuwhlzNrYLqFZd
         LZf+j7xiFfRNlX67tJ7pLaCMF2tnu5IXH6qwylNj3lvykfNFYR2Q0Vt7eQ9RJnnwVb5N
         /F7E1noDww94DKkCbSrPlftSuoa/csqwVxM66eVYvWCjypXP60DQT3mIN+NF/2vT6NqG
         MKlg==
X-Gm-Message-State: AOJu0Yy7MR7OPOTlBfNcbrI1uebiLpJ5y/dj8cMcvRpRvm1PTQ8MydPf
	y+ZFyzlXlT5JzwlJuAhhrxHT5Xm/0mCqH/ENAb9qEP+ZJ5gaaWFwTO1gog==
X-Gm-Gg: ASbGncuTMRY4jmDa2T3umyAzKQGrYX9YDElKnUXDfH5vAuObNVqLsjmxOi0TQKtWc50
	vZ9pFKAZrFw40DPngDwRXeY725cTvx25aTIBK4wLdapb8JZt8Ty+4xGg237ntcQFYIdBDOy0TQ2
	e684vUxXNs0q85qslO5WkTePp9a97rnhRxs1exg/vVXi9wK99VeG7AlEtNOi7AsaNl+VKomlz/g
	ZhEABivnVK72ooxCcrfQw9QvLglHkf7usdtpLQdlXkWz05+jO3dgth2hOJqNrln8lw03CExGAmg
	fyXGL9bCUPFOKDcV6oP+OXUn2xvbC+1Cku4eG06bSHU1RHuEGFJwnac/0euMdOChdaPxrsCCbQR
	8mmDwJkRuzl3DeJsrY1QP/15xXqKQZyW2PACA4HV3Rp5tmjGocA==
X-Google-Smtp-Source: AGHT+IGKKeEFWMdr/hpyac8guhJwtB8S8UBEPIf0+k5lsRmd3KvwfFgE9Z8TfYA1IQjCjqr5cbsHWA==
X-Received: by 2002:a05:600c:4f50:b0:439:9274:81db with SMTP id 5b1f17b1804b1-43c5a5e97f5mr41502905e9.5.1741382983711;
        Fri, 07 Mar 2025 13:29:43 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm92203145e9.32.2025.03.07.13.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:29:43 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/4] bpf: return prog btf_id without capable check
Date: Fri,  7 Mar 2025 21:29:32 +0000
Message-ID: <20250307212934.181996-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
check. This patch enables scenario, when freplace program, running
from user namespace, requires to query target prog's btf.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 188f7296cf9f..c51193ced383 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4749,6 +4749,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4895,8 +4897,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.48.1


