Return-Path: <bpf+bounces-21366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CA84BFB1
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82531C23DF4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880E1B978;
	Tue,  6 Feb 2024 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsC3nEWw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B21BC3C
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257092; cv=none; b=ngVk+yZVOO1fyyGDk/1QExE1WKEdX1pdBOd8Zv1rbX+PkQRL29KJRYDBxbiVwq1TVe+0PKLMF1C105fAOTt+sTsqKmVp5/JybS3IivpTQ6edCpjxtcYK+eNWGxLKFj/WUVUIPgtrGtzSR/awqkYPoRfhQcRl8IFJZpL+sEHrrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257092; c=relaxed/simple;
	bh=qGKZjyE8pLTNZYk7vAnLaSt08GEVKgE4wxNq3AWKiJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDHFXdiGp7pYvWOeESD9p26+lM96pROC5KIZr7gvxI/UABKftMqX1ZdHDxQOAREb2gS8twTWXzPZtoN5W7vzPMi3H37pJfmWxCdXDlIsGywCEnDRQLM8XQXMITogNW2IQ0Poa9qJMVWTFPPLUVlg7ffKVfpOe7GWTx92IrCwEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsC3nEWw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de3141f041so24703b3a.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257089; x=1707861889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTdQC2aUXQJJJCr+aCpdI86HWrK6Y2hTgBNTwS7bp1E=;
        b=ZsC3nEWw4HgEb7XupCRXJt3Z3xK/bLBEz4bIRtA+y0rGp8S5zhqBftYk6Yiubtcrcv
         u57OYXCYJbKHjudF7jjx9ZGZbhEUXF5JhCNwag9zG2Lenkh1fO0Y3abM6NqhM8Rl0AYA
         qjLp8h/b0Arkc7r6pwAzXTE8ggWDSU2YjuKFIq0+LzFTIKeBgdAj/vsaSgkMPzt+Bjzs
         WglRDXJoggiasVIvLXKA9AEzrr811iFgpgHcVIHxPH62vQARtVwDOwUdtOQ4Azt/oQLM
         aUp+cvFhnhk4pDH5dx7MVPr0O+8L3g2kHOUtXOTzV1HEnjR+mn49mat3PXfzV1OsPKvH
         RJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257089; x=1707861889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTdQC2aUXQJJJCr+aCpdI86HWrK6Y2hTgBNTwS7bp1E=;
        b=BLftxSihoE0dRH9U5gxr0vReT+CQqRhw68GqAhBwX+hMzd8/10IERGIVy5waoWG+Nm
         FXtuYkPsC7kplYRRuwiPXbMuyEP3KuejX21VOjZtqH8a+2nnfmBAxZ4gfKQZPqNtrJu7
         SJXboEX+xrj4FbB6jaTuTK+vFtRZL5a8beUt63Q+f8qP/+R2H3TPwyhaivFSGvcLup9z
         aR0ag5rfdGgmEjyu4CGVd3EKjbUXW1cOJB4g9bbfWhRlvMKl8/tftZMk4jBUPDufnGWV
         6Qs/ZAmszqSOi5kiMn/SFgaQXxPX2fCwgs1tXO/P2pbWZs9fiKlP9PQnIS13i2yjqDpD
         Axbw==
X-Gm-Message-State: AOJu0Yx+4OibXUcqARYXJEHPnmXZm4/gTPVyz2Bnbb5P3P/ZSZZJK+tQ
	JPjWMsMmuBfo1seDcmBb59hMSEFoNvwcXDTykVNGw0EDJJSs0KujW9rHqBpM
X-Google-Smtp-Source: AGHT+IEOBWDdHBSn6MYZcDsMAjg06YN4MswMauxkUU1AohdAC2pdYdWD/fKtCiGD2UT6AxSc8zBdng==
X-Received: by 2002:a05:6a20:9687:b0:19b:56f0:c880 with SMTP id hp7-20020a056a20968700b0019b56f0c880mr3151794pzc.39.1707257089523;
        Tue, 06 Feb 2024 14:04:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKAdt7d7meDWiqsPZBETrzTMdLFa3A8xeHxysTX4BnJCCUBehTYcyFmzK/mu5UhvwvCiGftMYGrDP47TFLDjE660wuY1T5GY0wrbXx4X1S03zWbWSXrOQ+tdSlnAu5YJXkDcgBFW2A3CDYdLKDKBnFqYTMtQA2EY6Myv9mLdg8OuDd+rL3sbhg2fdft6PrbNQoJEP1c/MrDfcTHtSmtmEH1NCKjDvOzx4UtVeD0UtYuEuc0aiQfVw/iVuyTncavF/YiNn57WBDn7q1VeXkmEMUcE3rFGnER8Ry
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id y192-20020a62cec9000000b006e02ce964b7sm2560051pfg.184.2024.02.06.14.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:04:49 -0800 (PST)
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
Subject: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
Date: Tue,  6 Feb 2024 14:04:26 -0800
Message-Id: <20240206220441.38311-2-alexei.starovoitov@gmail.com>
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

Recognize return of 'void *' from kfunc as returning unknown scalar.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddaf09db1175..d9c2dbb3939f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					meta.func_name);
 				return -EFAULT;
 			}
+		} else if (btf_type_is_void(ptr_type)) {
+			/* kfunc returning 'void *' is equivalent to returning scalar */
+			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
 			if (!meta.r0_size) {
 				__u32 sz;
-- 
2.34.1


