Return-Path: <bpf+bounces-26663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FA8A37A5
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881DB1F22EB1
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59B15531A;
	Fri, 12 Apr 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYhqpqaH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7115532C
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956106; cv=none; b=HTpTiWv/A91VzL8llG7UttYLpYGXAOSqdyZ5NmT5lL70PDIOfw+zS3PnImjg4t8x7WRmPFHGTguzdKpALTLB+RFaEEjYUahH9eZcvzB/zsEuvZR3R/DO9DhVhnIHTAOgALr8TOi4vrq8Pw8/BV/nI5vQ6RXvvrm5+ej2egWcfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956106; c=relaxed/simple;
	bh=cegdf/GB4TUTwqgkozn+YfKCbNRABusidh9A0N5MHTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+FIpdTA9sToTzNEVXU5PcjJBlHZurQVpTTm7wXXqvHgu4bItbUXWUpf650gVp4xaC0wf9qb0zbv7KRzsY1V8hgHpv7ZnQES6xXQokX0f3ppWXKwGXffcUnQSDLnHFOePkDuBLLOwV1LaNNMLfsjOqvI6R7bo1sDW8ObpDi+aCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYhqpqaH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-232f2b86e4fso729280fac.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956104; x=1713560904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVe3JxZE6Z55O1rHODqgNOrrk4iw+fYt2hDBvI/KiNI=;
        b=XYhqpqaHGeYJD8hOvxdDR6E4a0vK5qOeE3g3YUzMOaNxAWON+ts/LUhaGrzUBA2r7L
         UWMu5BorCN/uauOvjQs3Kgk8LWeiRHMU3nKWLYQ2Fgdd4heMvb5YayE6pPCc75EuXZMx
         7AZW2WTVLSxBolBDL6GpTl5Vgwd9LoP5HFSGyQj5yHjGiBaxFG/WVz8qlAtEX86K3a5U
         v1yCDzC9VlEHfr9et4BTYnCPnsuk0NWAtQwYL3EtV3MtUEIslx9Gh3SrI05wPBM5bwFA
         vEw5WDhcX/i+Cz9NBhJ0HY0bbjefo06i9n9dBSdrGVTcgLQFCpM1i8vNdEboVJggfYV4
         lUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956104; x=1713560904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVe3JxZE6Z55O1rHODqgNOrrk4iw+fYt2hDBvI/KiNI=;
        b=kT/GzSIxrtwYu6rwDX+ZX+qOG9j9tT1qMptn5dMFCSgeWXfx8GbR4gyu392xZlkyUJ
         PMsuHhVQ925gfkbADMH5CnLgNI9M2NrNdtfRf5AnyZWPfHWS8FDYxP5PX4WQ/NRpxFAG
         hGIvmeoKZkhc3UkbwfdW++gmC+p8o+2um7gJc6uEqKzRLx7Ti9fh8RJ78F8FO5V1nsSb
         WawdxFTqBV9NBMqoH3UwjkCLQrssEl4h56zfkYanxnYz0dOR8p+nMsapSaDm3PBlqSmd
         zzAmj8jOJpKDVR2g6k+9bUKc+G3l3S7mq+a+sq9z6TCnfTwD4471Ekt0qUo+6xJyq7zy
         Z/DA==
X-Gm-Message-State: AOJu0YzAoHOo8DtKOcyq86pZUmIU4Bmz9puwy5Qx1JvHe9zuqTKFkBp0
	UuqKZc98TgZthuMBpTEouRQ3vfrKh6s3AH/BKAd4Fsu1Dcast+PEGh2w9g==
X-Google-Smtp-Source: AGHT+IHj/ZwEkeY8x7KAPCerj3zFIxD7vhBayAVU3X5KLeb8/MAwtmWBAiQlYrRKNXM0BGyewo3CUg==
X-Received: by 2002:a05:6870:ec90:b0:22e:b7d3:fbb3 with SMTP id eo16-20020a056870ec9000b0022eb7d3fbb3mr4518245oab.4.1712956104140;
        Fri, 12 Apr 2024 14:08:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:23 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 05/11] bpf: Find btf_field with the knowledge of arrays.
Date: Fri, 12 Apr 2024 14:08:08 -0700
Message-Id: <20240412210814.603377-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify btf_record_find() so that it locates a btf_field by comparing the
provided offset with the offset of elements, instead of the offset of the
entire array, in the case where a btf_field represents an array. This
update is crucial for accommodating btf_field arrays in upcoming patches.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/syscall.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cdabb673d358..1c8a9bc00d17 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -516,11 +516,16 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
+	int gt = 1, lt = -1;
 
+	if (f2->nelems == 0) {
+		swap(f1, f2);
+		swap(gt, lt);
+	}
 	if (f1->offset < f2->offset)
-		return -1;
-	else if (f1->offset > f2->offset)
-		return 1;
+		return lt;
+	else if (f1->offset >= f2->offset + f2->size)
+		return gt;
 	return 0;
 }
 
@@ -528,12 +533,19 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
 				  u32 field_mask)
 {
 	struct btf_field *field;
+	struct btf_field key = {
+		.offset = offset,
+		.size = 0,	/* as a label for this key */
+	};
 
 	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
 		return NULL;
-	field = bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
+	field = bsearch(&key, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
 	if (!field || !(field->type & field_mask))
 		return NULL;
+	if ((offset - field->offset) % (field->size / field->nelems))
+		/* not aligned with an array element */
+		return NULL;
 	return field;
 }
 
-- 
2.34.1


