Return-Path: <bpf+bounces-53391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB1A50BEA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD9B16D14E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77D7254B13;
	Wed,  5 Mar 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5fCdMCm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978EB25334C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204197; cv=none; b=qdZkKKL5znsOiqr9ORlDEWns/uzD/NfVzkx0Cgrrr9h2MF1wwXC2ibpgHdplN03yjJqizHJ76RVIwU6GsMdsp/d7VVxNm3fWlvwkjd4wTpG2f4bajG+0deiIlPYy7+nJypLfdKIlvEJH5HBMdUmVGc4FPmLQKe2MpV133UEexO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204197; c=relaxed/simple;
	bh=BDCJYrp+tAV2rO6igjnF9YD9BcTrhUm13/pOi3j10OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuWxYJo8gKuAGz683cK07iVtZXIPS4bexykdQFiagfYMbm05w8WS2gnO0/RAt+NfvFL7MAOJQIf3V1whHS3xroNzL8bbBhxSIAWPCQ+GCmrLIjjnAHr+pMWdE5OjP8PlKWdbga+6da2cZRMQwX1ehxR30kX2GjDh8c3c0y40OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5fCdMCm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4802b242so870889166b.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204194; x=1741808994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKVPakIGUlgrwb7IleApJVVxh5BKFUYiN0tFee3buwo=;
        b=i5fCdMCmhFo3nW+/aaUppPDpSRIcZHgbsnsBJjLt+quI0ZyKxRiS1uumbWVcoM00Ij
         u9TSBdqMlA8OLioe0K7s9W0KOpqCId+a+Q+92eSM+Lqy5QjDkbapvFrh4slgbcQwyunK
         9lp8KgHqzlQRA6IRyOSgfIS556S9JBBqWbWpI4ULksr/ajmYlV6PSx7yzdb7TvNqdzJq
         shrQxZcqsGYTdvszEBDLDb0v/a0R+yT2UfIYWfyQhUlO1D0FXZowkJaK/uPeWppwy1Q/
         YXXSzAQRU0YE7q6dYl1Z8TbvTQzv3A21ci0kZuKgTgcGPV/i46LBjYzd90srkjR6SFvS
         zEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204194; x=1741808994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKVPakIGUlgrwb7IleApJVVxh5BKFUYiN0tFee3buwo=;
        b=awCAfzdBnGYSstt12jNS6UirSbwXdJYhcBhNkVaee88qGzGoP5pesqcoHmpQOqdjmR
         RfAlWN8adkgbuuWsD8APNHAIuFxNxu2mvB7+HJ3oRNoshQymZCRSwndp3bO02zFO3Ceu
         wuBMXd8W/rpaxjazl0pLOAi23zQ1hqBBE1nF6QWE7zEDzT3AWES7REpxLjYLMPUJjKma
         bJU47zefnG3kQabxVk5TaQRfv2ySzvFgFXmW0a6r6Ml8aqXmiLFvfyCFI9AKDEFP+Val
         WcRJsMozJLyLiqgXbhEswyY/CQY1Z50wg8aaRx7gkH4uYO7fLX4ee/mDLEVk1yPEauez
         iHhg==
X-Gm-Message-State: AOJu0Yx3k8xPD0GNZczRXoL51qBrPmzUTWUai6HpJ7Wwx4YaReyPkkzw
	WW9v9C4uDCD9xaG71DlllIECu/8r4cgJqDDVPBdZn+I9c4Jsaskqwyom5Q==
X-Gm-Gg: ASbGncsQr13VSeXQVzqatzDvWKFuQIIuRiMEUTEeudb3s+yE1ZcUMO1PAmu/4uIHnJc
	sdtVrPbbYguIv2YkFktEzerFjJNlP2oLstEL3r/CgyCUxZuQpcdV6hx3vMFTCC42qdUzdq2QwfY
	Jn2BztMZJ3PLdEzZSHOL6HYEN0aFIAVCYDBbpBx2WBQNGFEa7AE5h21P4AOoS4JX0G0fuM9RMoh
	keQwdRsI8X4Rb4IoIXfnHrqoHNvyxbpV6+Mv+3rN+Drx5brYAEjGjBX7a5PsVM2EcsAqlyCv77Q
	ksazaW1FLMq7a7ejPlLig8VRF/JGcH2hqiFEULMAg5XM3fbyTpc3r0E9eos=
X-Google-Smtp-Source: AGHT+IF4mOn0GDJHXbok09CLwwLgf2CvThoX5VKuZJxTMBHd90vHWQdVka/UMFwHeuzqx09MewnYmA==
X-Received: by 2002:a17:906:7312:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ac20d9251eemr381396066b.29.1741204193632;
        Wed, 05 Mar 2025 11:49:53 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4624])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm481584066b.181.2025.03.05.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:49:53 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/4] bpf: return prog btf_id without capable check
Date: Wed,  5 Mar 2025 19:49:40 +0000
Message-ID: <20250305194942.123191-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
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
index 6975d391bb05..ac8b391fdacb 100644
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


