Return-Path: <bpf+bounces-53701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A347A5899B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 01:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC25316430A
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6BC28F5;
	Mon, 10 Mar 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQaSNyVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2E101DE
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565631; cv=none; b=GLeLnvGxYP3l4BndzwO0Z+IG5PUi8ietaxi94bREuR4OjV49qbGX44TQZB1EkczBDge1y1/ud5VqKdNlbd5gjQXTBvIlI3+ddRsi8nVjBStdqB0w5cpqi5K4IlSDn2nmOIWWdl43R8KGRyrLJWJK2OKNzRv2WFrVdJOG5p2Y60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565631; c=relaxed/simple;
	bh=wOlpi3Zy/WO68TdaXGkCtss/2YZVtPQKxA4/TPQjA0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmRWYt9oh45WPzPQrCc0pTGypqVZRzHqYDLeHZR8ybwRQ8adpX6QqcdT8s8jZQATzofJSQyzOfuC5Y4Ny59wuguur8No/MJ4g9bUni/1pdD+XkCNvP+Bg1TWT/m+RERG0UASfbeVKebl02fFbGjnhvO/S4h1YcRFIjMVWYgISxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQaSNyVF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso56228f8f.2
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565628; x=1742170428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5rOxfVbTn8+bu8IRFdtEps5cs4BX04FRt9YrVz+YvI=;
        b=fQaSNyVFOMsHMgan7z0BUKiGuEAURTmAUqGfSn7ZlAx+4Piz/xOoycOfdEzFwuhPNW
         ie9yhVll2SGHl+Lkn9tR4P0l/SaQoVrWyUu9VIrq0wIudbLMa6JQUzIbm3MUZM0Ft8vm
         0fVjsmpQQXKljKqDadNYR6wYDH2+JFlPT3PMj6tIylJDxCzQ2eMnVCnsi5X0WO5js5md
         kHvrGQXCOeeUY0WxsWptO3RzRCKuPvZ3Rx/yBmDOdqjXqZ4eVSVgcLGA+mVf0HayGbaH
         b5WIaxmYCzgmx6bOFJySsKLWxEqU/Apra9NLoQ3S0LzPYH1gtJZmZ9wzWMXbewvqxcGj
         L9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565628; x=1742170428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5rOxfVbTn8+bu8IRFdtEps5cs4BX04FRt9YrVz+YvI=;
        b=QLJbPflYv7JQmUvMBOP39drvIey/ZHCcfC8FcS6tj/TfryvZC2BMiC/dSIUrE4pm82
         vPdIRcimIgvV1hTGqu1Io7aE/6nGtTvnO3Rw3QQjhXGmA+Le8CAT+uqZqzSzF70ejv7U
         kWAvnLwi90p4YbN1qTDBhsN0xXJTeIzV5toanfZsLXIYr+WKduBDloWJX7s8qNCyHAR/
         UCpmiv1lRToW/liPNJO/1+MG/VHSBLUq3Jqtd/Dz+/gO2TaC0BEpKiapf/6sLTJ4puvL
         r6jmdlVhju+zPHHNwexty8yC8uXdd6Q6OzhHzYZPQBGSWGDYIZd1lDkc1YWivP7YhzVN
         /Jbg==
X-Gm-Message-State: AOJu0YxhyMbeMmqAw3r+6hVscrxThLllLBzWBqE7Men1Wr6XbYiWSVSb
	UKzj0ga2P4w78tatfqJlIhpFnGJfqeCX2QAVnln0iuvfYfq9M+lox8DCyw==
X-Gm-Gg: ASbGncsu/jmxTcOKUFu1DfL0p8xGCQoFQMdzVPhlyOB0uYs+Vlx+toPpPcaWkPbHk5a
	LNRb9oue9BVHI3eCHB/mJ9unt5TiT4Aa6S9oki1cOdKYUyrKGXZWhxs5KfS2ngVphRGieTxccyx
	nK+SsIP1w0AKELmBC7BvxKP47+ZwwZKfrntPh65t9yIT3MPROZ5HmqBGTxXxvSXChcxRFRTDM+z
	+JRsm/ylPPMHD6M6PNV6K44nffmtEZsMWOiZWA5mCb3qU0h5JcD00SgLLkGz21NFMqYgZJype7Y
	m5dCIz+WJ6K3484t7NoVDdLLO/PoX9nNTPW0r9/hoSgTikiJLpzYtSNHN3+caTjEdFvr1gtupvJ
	9UFI3SLhLfHVcwC2vgdpL1ol6Pi6+biMUxNLs2nAcolvproQQo7FR/gOzVai0
X-Google-Smtp-Source: AGHT+IGsal/Aw+WoJX+MAglnrPuFuYDW6UkcsK4jdtrkF4yoD8E/VJ+7fBp1uzFHIFvhe3otpLt+2w==
X-Received: by 2002:a5d:47c8:0:b0:391:2889:4ea4 with SMTP id ffacd0b85a97d-39132d06142mr7426692f8f.9.1741565628021;
        Sun, 09 Mar 2025 17:13:48 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm13181050f8f.0.2025.03.09.17.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:13:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/4] bpf: return prog btf_id without capable check
Date: Mon, 10 Mar 2025 00:13:17 +0000
Message-ID: <20250310001319.41393-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb3a31aefa70..9dfe6859eb5c 100644
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


