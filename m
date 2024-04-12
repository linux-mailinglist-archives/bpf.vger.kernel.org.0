Return-Path: <bpf+bounces-26660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10268A37A2
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55338B23E1B
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE2154C08;
	Fri, 12 Apr 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK8oU/Af"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F3153BC7
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956103; cv=none; b=n5hAW59rc33N6pqujQaFQkZ9m2+a2b7jkoVcRNbUj4dOHv91wP7ACOPvOdz90VW/P5OnAq7LILbk8Gmhk/PSDdfGCeZObYML6OL3kMBiYhACVG9brnswiKWiiRGDhtlyL3HyppdPfOKmgksPnRgH3Zil+qqWJj32iJTa87Qz96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956103; c=relaxed/simple;
	bh=QRgI8tt1lXF2UVb1h2GidAFomEe46UYdNaLGIMYmRPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2gHpMn5nuh/PADuu37Yd+IJtWns+tCJTHbEFBNL1MfPg9EF/cWdHxz+5ipjQhdEQhXdUlNkTaFaV670HGK7xyFhCYzd2mW86c0/R3byRiT89j+Noqj2SvFCqN/s1I5Y1WH+w54Nw3mzQlPtJM6J3hD1D/v8WZoLwpbybR/kYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK8oU/Af; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22f32226947so776987fac.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956100; x=1713560900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJpX3nqLTwHBotbGdz4JsE9nEMIz3OLoljTf3Ghn4kQ=;
        b=gK8oU/AfrGixfS+MW5E8hwBkjOxFAqwzjNE1Ek7RUal+IyN4ByUyVl8l/ek4dcMUHM
         0vTP/WkmEvgSFRAzSxfmEAWf3a4/6uuzNkCwcsVgG15yYW99CdwTb8AK/px282au2BfU
         xtezp/bXuSMHCk4M9Gyj6J1ZRArHKbQSefzoCOeAfWlK94rMhzjPsShI03SJfFSCnMpF
         hfZcH+01ivv2NodoxrS2X35vPh1groaTMZ1dHcc26OC9Qwm/zepKducqh81fQ+wKdI2I
         2boyrQ648ungzkH2w7W4MLLsnl+RJZkWzP9h8NOLZzcKrmUkKsNCeWVXp6EZabnPu/cw
         /bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956100; x=1713560900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJpX3nqLTwHBotbGdz4JsE9nEMIz3OLoljTf3Ghn4kQ=;
        b=t01Mf5K8HYLFY/pVMIbb3dlqSyl65rJBEYPe2xuN571oJtmTfvMwr/2B0SgtBk8X5w
         NbR4u4HdT1kV1NiqW7R+igJlq52S/D3k1boSCQElCR18SgWHxsX/fjyR8qG680LhQUIY
         t2KPzey4SkR/mL/h8H1RyPTP64oveqWfwy3Rk27LVkkRsnNip/6TUAHHDnW34RXxKSLR
         tskxJ6F7uRfzo7FnvvijwfoPFF5cvRaJkivUAs6wcXqorpSNzZtV0gS9hfSo8+y2xlPC
         QcNknpDbWDToCiz7qxFCmO79az7Ohrj3gyXgC4w7Q4KaDOZaOVDIJL6uoA2H9V0ike6Q
         MFIw==
X-Gm-Message-State: AOJu0YwNPTwUyChMZfR42FsjoXVdkUG7WsJX6mnzQbXaGANrOowawFEM
	aJVkYurEPhDFTrymtIvOQvAcHV5nNWSP7Pu+toDfojsruqME92d3YPs/OQ==
X-Google-Smtp-Source: AGHT+IH7uSmDp/2RQXo33A8u6U8PdWClcve5apByXhesDOZjOSKJnx7VyO3p9o3YSN85hnT2eZrOxg==
X-Received: by 2002:a05:6870:1650:b0:22e:ed14:3e3d with SMTP id c16-20020a056870165000b0022eed143e3dmr3992691oae.33.1712956099998;
        Fri, 12 Apr 2024 14:08:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 02/11] bpf: Remove unnecessary call to btf_field_type_size().
Date: Fri, 12 Apr 2024 14:08:05 -0700
Message-Id: <20240412210814.603377-3-thinker.li@gmail.com>
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
index 90c4a32d89ff..e71ea78a4db9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6672,7 +6672,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + btf_field_type_size(field->type) && offset < off + size) {
+			if (off < offset + field->size && offset < off + size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d44940c12d2..86adacc5f76c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5432,7 +5432,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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


