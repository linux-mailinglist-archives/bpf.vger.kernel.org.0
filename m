Return-Path: <bpf+bounces-29021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB848BF647
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22ED1F238BE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7022318;
	Wed,  8 May 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgCNhATp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE21DA53
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149948; cv=none; b=CmhFnVQbCFZg55MjcP7vsWWTOV+Y55RlQkZmDwOTuXU143X7FADY2KdjZ5Qmb0/QM+zpuR8QlW4ghAFaFFjdINh5C3MRcRilyhdIa3+ml+BQ2JUdLWT6Cf5EJ0kA5B/e5S2CMZw3kq5KH+kdyTy/P3+TLuXGrMGPv1rbOiQGJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149948; c=relaxed/simple;
	bh=kCgappnLf09hMPvITmn+nEcPndSFxpBnw/V0ZLEwpSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFy/MLamIpEXsCEu7/zzBDh453jkqgRhZcrQuy06Xsnqm8+li80Wl/iOkXpvGGUB3SLwOwDrUsvjVmG9EK3s3fSop2mlnugZnnSZR38VU4mqgW7XrJhbim3jQ7Pg3PBZk3Bcrd0gSaQOPiDnWpUpARwB0F4Eao0hEoOSn5/nUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgCNhATp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c96a556006so1776543b6e.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149946; x=1715754746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OxWvA/tKSbMBMe3nvCIcsidoEQ4eab8W4E/mkVKEqI=;
        b=KgCNhATpSdTGhuHmlXWjTIwykEMRuzBOrmfHeCClVadsuZnJNagTnwrEqXhfc7y7um
         nph1pfuPWq0npw87Bd5N/iht6krCW5dntxlbnOwUajuFLSTbLhMQrE66S0VlZPstXrz8
         ikeWcHgZ3OhHa0y2wkTfZmR2Iry+OaUmIFmjL5EOy2SJlZvp4c1dQPj4+L16ckgdQiG3
         0FBN6JiRf26hPOIQciXoaV4nA3k7oc8GfY4ZfFmogwSERvp1olEvrzcaJtlcawG/ANjO
         e1lJFgb5AJn1gYhqDHcor8SlQgbWFosvzs+fsohrGayU/E+N62NjzYsT1yzyGGoCnjf/
         Dhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149946; x=1715754746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OxWvA/tKSbMBMe3nvCIcsidoEQ4eab8W4E/mkVKEqI=;
        b=qSx9MxCgBXoZwphYQBbBIhfTjs2AVfP8jJBPo16ihpPRDb6GGrtLJVFvPUuYjdBeVY
         1WT4N/eYBd2mTG0wbToue/vhrmAO9uTf6NoRs7+KJX6cSsSP46VQ9ydJeaOH6jQ55uVF
         VcdfwaBMI9Q3ayW8L0tcStC40s5KYpPu2kfDo8F4yq7vw4+ydoeN2VF28MMhWWSIC3ZV
         UY69zxAmfRqJMsovskFdREC93h29JuJfYh1R50usC1hHet87Ef0wsXgjty5us31b6Ejn
         FvNa4/g1G3hG3DE030uEhGix/3NAmK65VXK+Mv2dpTcd7GefVVbMnWOLHqCZxjw1WFt9
         rJAQ==
X-Gm-Message-State: AOJu0Ywa7VqqhR5YvBUX/IYCYDcpJGAL2f/uO4A+phUtf//R+OX5T5Ir
	+jwsmQvX13NqfDiQMcldHfN6vMQpsT6KNL1qoirFNUrEP1DVSLEv8ezGiA==
X-Google-Smtp-Source: AGHT+IF90pAxB3YJxxTWq+57ldHWg48onuV6MiWM/a1tzln77FE0tFtKR7WIgW6mVPUp6szCTzVVZA==
X-Received: by 2002:aca:1311:0:b0:3c9:6009:87d5 with SMTP id 5614622812f47-3c9852fd64emr1623391b6e.42.1715149944830;
        Tue, 07 May 2024 23:32:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:24 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 2/9] bpf: Remove unnecessary call to btf_field_type_size().
Date: Tue,  7 May 2024 23:32:11 -0700
Message-Id: <20240508063218.2806447-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

field->size has been initialized by bpf_parse_fields() with the value
returned by btf_field_type_size(). Use it instead of calling
btf_field_type_size() again.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..226138bd139a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6693,7 +6693,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + btf_field_type_size(field->type) && offset < off + size) {
+			if (off < offset + field->size && offset < off + size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b731d00cf1ae..94eeb1366a65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5448,7 +5448,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 		 * this program. To check that [x1, x2) overlaps with [y1, y2),
 		 * it is sufficient to check x1 < y2 && y1 < x2.
 		 */
-		if (reg->smin_value + off < p + btf_field_type_size(field->type) &&
+		if (reg->smin_value + off < p + field->size &&
 		    p < reg->umax_value + off + size) {
 			switch (field->type) {
 			case BPF_KPTR_UNREF:
-- 
2.34.1


