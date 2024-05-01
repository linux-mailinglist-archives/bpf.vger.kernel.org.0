Return-Path: <bpf+bounces-28400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069808B90CE
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB972284B38
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C781649C6;
	Wed,  1 May 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY80SS4m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832E1607BF
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596462; cv=none; b=MpcilqP3vYVZd4cUFTYgBDVwVp7wwy5ZVbY8CnysHXsPCJGKE5lwF5p8uojXnONR8qTg7wClwWERT8ubgz2EDXLOYUzVCkIQK8+csWPlxmaKihI4D3x0asBa3YzBrGF0Swj9rj7ijUAcqzFObTkpXUeriHg1kT4tPFb9LuO7Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596462; c=relaxed/simple;
	bh=wh9ihHooBolmYD5Y0JBZxAzE+AhNKO2PCA+fwt2rxKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4dfc3GiN0pRGKi7dipe8E/ktczCL/vt2LUZhhdqbqhkMD8iM5H9LZPsAWi9EdhYwvjsPBlUV0AJooTFlLnwo5xVxLVirkge6CnGFZXTskbBdMZo1Ra2K1rrW0W6C1dSCLzzxRJvOykN+7ckXxD3DsmXIaYb2OALHItC+IMmwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY80SS4m; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ee4dcc4567so1889511a34.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596460; x=1715201260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjHwE/uFFV7JIdhGZvBb7+FIgW4ZliZQGnsM23KacUk=;
        b=WY80SS4mk0hOyFEQfmSqXRpV/p/G4MAZyFy385+nQ+7lc8gaUO0FlOKC4JXvYi4zjW
         MM62hPygSPnVmpS9CaUkzYSxvyRSfBGoEhLpJv8cIDt7Gx8r2lfRTWRPK6fJw+g0JfSg
         iAaNCDkCL7ybtNfhLVbGx6qeymSYspwyqOaJaqoO8clrVUResNb08bgY8R6ku+0FUMsv
         YVgw/DTwl1ETzj0C/yOZzDONzLcuzoXsdFsnX+22Y3MgV0lmIyzEVoszc36nlM4Un6eU
         Yn6Tr+9uFNBA2ieRZspVji9E727ikEvV88OSmFDSOkpyaGOgEUHCk6X6IwLdMYUSVeek
         lZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596460; x=1715201260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjHwE/uFFV7JIdhGZvBb7+FIgW4ZliZQGnsM23KacUk=;
        b=nRqykywOzBOivi6MEjzH0yzPleg8LY0t90YQp4qODRnGSJs+S22OVxu13xyy7NG/+Q
         LZZ7EDeYis8z3ggvFRi6rnNF5ipzAg8Vdso9td3HAC/CJmIaEdPbJTh/tCyvWJFIkkFA
         tdGcdpzlrTtImE2OYj1cjT3Iv93VFaP5B7GSaoE4SDx3HvVWJrl1XQyLO+krULzmXMQG
         4YnYlKhESkRVGPTrHGCDWS18zXggwTX86qvkZlVrgH7PkYOOKH6GEkcIvfxozb+OL0vl
         j4JbP2bq435GoxiSDSUMMJjH542KR9INGcNmO+yJiNqhg5J8FMLWuFkyBGY2GXpOF/zg
         pSxQ==
X-Gm-Message-State: AOJu0Yzk7KrD+HQIhQx+4ud42d/kFpEdrulhxV5KpsJ3SzZ0Xa2dtCMt
	HfOqX2x9VXqdEKrGSipoTJd5VKxuBauYaOrqKFdlBPUwdzbcH9h63kTkMw==
X-Google-Smtp-Source: AGHT+IEHDgoeK9LSrPmMksqRWV4yGUH7qZhUiLVNYeLc8K2ko71uT1QFTXJYZgbL2eAAV7LLeK8AHQ==
X-Received: by 2002:a05:6870:2006:b0:22a:5bae:9cd5 with SMTP id o6-20020a056870200600b0022a5bae9cd5mr4084319oab.48.1714596459776;
        Wed, 01 May 2024 13:47:39 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Wed,  1 May 2024 13:47:23 -0700
Message-Id: <20240501204729.484085-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501204729.484085-1-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_find_field_offset() always return a btf_field with a matching offset
value. Checking the offset of the returned btf_field is unnecessary.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d42db05315e..86d20433c10d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11638,7 +11638,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1


