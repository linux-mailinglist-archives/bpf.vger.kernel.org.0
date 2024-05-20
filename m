Return-Path: <bpf+bounces-30043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3A8CA367
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B78B1F21EB9
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421913959A;
	Mon, 20 May 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hna+16y2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF2139583
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237626; cv=none; b=OLeiEh/RHZKL78UKIOk7nRlIsLusA/lBB7sd42uo5V4WtugkCpwNgEiXMJxCgEXSA1jY0MIirfm2KSO3pCM8oYfKwR+DxMPDQx+raQR9aB9FPHNs0kbkGjTl2/nvWNyFlTFcrnjDBW4uOqjt8vmpbZGD1Idp73hRZDuA0ppUP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237626; c=relaxed/simple;
	bh=qqggGaC3A0xzhmB4jpLtjhbNT+5ro/jXBMnCfYwbGzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuvZpRlzf/mOxO2wcDdABmyZc8RPHb8u0b9HcZD4/bzMGx9VxdjW5CXYE8xpwqH6KwqoPDGOxEXZPjW8Vv2DVHiunQAQDQnaF/EIC57VKNcDUCvAMHvZ6/sVzhoaQTvZajhGqWYc2ui4nxnFqbD56WvlFp+qswiDescNF2FO1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hna+16y2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61be74097cbso29257207b3.1
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237623; x=1716842423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEJYwvgNo6RYhVquU9hRkea7EjQyUP61ZP8HQ5pKYfw=;
        b=Hna+16y2aZeDbJD96z8tPpNLtew8E3nWnOcqBvGGW9yMjg6tTm0+aSvT5A+Z8faQKd
         v8hp3hMCvDxk2gyUovxS/SPLw4j9tLGuMI91AtsNbQxghcjxVlMKpNzF/rxFajaFEPXh
         O0dONf89xCO7SOUHGxUDWgPqZ+jisof9am0QOkHTeHf77adUDHO1yn8HBYHsaIPRINf2
         6djubj/d+WguMC/O2iBpjOXRoCDfN1SGwE/NL4NrE7cNFoerY53KPW2ola3WXubX1iZW
         voaQpPV5y5+LewcKT+erU2uhyVnlNtTrLT5vHIruhVNLsv5DjpnWj88alH4kLm+He/43
         VrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237623; x=1716842423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEJYwvgNo6RYhVquU9hRkea7EjQyUP61ZP8HQ5pKYfw=;
        b=sp1QpfBh5C/HBBGdqKSgNqyZJSpVIf3av3Ie5cfU15TEhmYVhqZFFQzZ0IFmQ96Dfo
         LQIb6gYlZBHavHpIFfCPv/QmG+TldlnUSjAc+g7LbWCgpggbUUd2+EpbUXxmMzbE3LLZ
         EChMEdDY3L9ioflB+DxPtkbUSEW8yJrwBQ9HS/5Jq/hWQB2f4btd57K2FML5wX9M0Z4o
         83ZVnS+rDK0laEuT5A0KX8fok6yX5JuoLexxMl8nJQnVEZDA3mIWtkrZpAzkxTrLUOAF
         ZBVgb7lg/vTIdodcXdSEPJBGxjbl0OLXUbwbe1z7eSmPubESttExtmw/5gkDFofbDUmH
         WClg==
X-Gm-Message-State: AOJu0Yw7QeLSP3kdeORzdjUvFmMTqxPzlCLKBcWOR6c03LGGcdNypJZB
	BgdMFNoDhymOCp7EJ944neJ2q805lfSfyo8DRI6jJuxQ3e6M3sO8ErVAqw==
X-Google-Smtp-Source: AGHT+IHY6/O6dqg+wfIx53DPTjADjP2trBupwXH6Fc9N99+e9neInMjYX6gTE+zzp/YQ0q+IFa2KVQ==
X-Received: by 2002:a05:690c:700d:b0:611:9622:46e7 with SMTP id 00721157ae682-622b013a1a5mr293220397b3.48.1716237623159;
        Mon, 20 May 2024 13:40:23 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:22 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 1/9] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Mon, 20 May 2024 13:40:10 -0700
Message-Id: <20240520204018.884515-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520204018.884515-1-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
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
index 9e3aba08984e..3cc8e68b5b73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11640,7 +11640,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1


