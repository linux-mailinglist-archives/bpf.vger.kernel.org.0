Return-Path: <bpf+bounces-26338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81C89E700
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A11C21021
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3CA5F;
	Wed, 10 Apr 2024 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLu7jKU9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAD38F
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709718; cv=none; b=fRDmMvpw3Gq/l7yh/03bTfhgUvtbuJh635GLjUq7N3fHVI5X0xHg3dDxQdCGKddjp7gM1MLbYI9Rl+hled7lNXD3lmX1ZAl7iOo2C5gfRtFnlYvmlmEj72jFcdc6VR/KnbSqAI/hhJsLT3tNs/kLkbQEbHDdV87oQwFbi0KsT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709718; c=relaxed/simple;
	bh=ez44W3aeluU84egFnXW3H2uRN0yUjOERuV+O0SQ+Z7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofyhvqD7VhmhfFbgABCz2QgQI31kBDVa6HdJmFcP017in3h5jqvW+ggNqrP4sIn59q5IRLRDJzfomZEtdnN3cVzcy9tsfLOwlE/RT2LDfBUWAczm+tGG0HsAVqRs6NmkDW+U0qDoimxrvpLkCXULAmYVsyDJYNhPBhIeMT1fcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLu7jKU9; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c5d9bec755so3021967b6e.2
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709716; x=1713314516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y04/wrtZsljnjAE2JVt4GSsZDYcg6TqZhVLlNiRQsU=;
        b=cLu7jKU9ZWMAwEFPZULF5EJzPgGPe4k52Pukl1AvyufHNZ9N/1c/4iUM+dFhu2sw75
         eRv4uHamckEi1ppq3h43rQf6byDKVcsCcgJjZNHLJB2GpmistHxEQrhdtDOoPLKp7DKr
         0ygMYKRu0nmUuLks5EX+BqWT6lekC0Pl0IF9gNnFzPIi1+kS5pMUwP2EWbEAxT30JRa8
         iUOBHD/cmrNQHDGgn+iYN9m1DeTnMCo4FTPvZqn6BHY7qArXHHzVFfsavKFwxIzgIgDf
         QP2YUtHHeqJmWtD1lbS64u1FhbGgE0WbOvbT0eM4S6dcucriDRyXJQ7mQ/obfpVkY1M3
         gMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709716; x=1713314516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y04/wrtZsljnjAE2JVt4GSsZDYcg6TqZhVLlNiRQsU=;
        b=YxzCL7O+8O0hRzcdOYtAAg9w51KwiRTVXKd21I4mcsANudhwJu9MEwpL0rrIfVEUEs
         DbM9JbubM9YdE7enGij+Ka6Jp9MKyFwPbwvla3JAvqGBUxCO9J6VMepoKxp8vkieirq7
         bRuJ7aNWiHhnVdCDhmC8O5NYtPaEpYAfczqcvZbiN+xLNUfjNIrtyCzajwCtiO9tENay
         UCJMq/wfmq1cVT1y3qcjFFayxN1yThJUNf2RBuKV6UgJaj2rMKXAAppG965qHT3+CJXQ
         xSbQ3paOMqgUBAgj8N3Suu1V/hsQtLgH+g1nNW1aoJWkDlDxlox0+esSgrpZY+KWc52U
         kkFA==
X-Gm-Message-State: AOJu0YwYlr0p9zmWty6v0TcUpbnPV5wSLxu8divQzEmk6EYsUZZYLPPS
	Giunxxgdd89tOto9eErT086nCN8VwmXZg3IS1cawimzKbnqJRIfDKmc00ss6
X-Google-Smtp-Source: AGHT+IH5n16Ri1UjUsMYwlttYgxM6aix9E0MpOXd5zkDv28LHe15W8haqxoc6+v5fc53Rt40dOdlXg==
X-Received: by 2002:a05:6808:1144:b0:3c1:e8d4:e16f with SMTP id u4-20020a056808114400b003c1e8d4e16fmr1474891oiu.24.1712709716069;
        Tue, 09 Apr 2024 17:41:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:55 -0700 (PDT)
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
Subject: [PATCH bpf-next 02/11] bpf: Remove unnecessary call to btf_field_type_size().
Date: Tue,  9 Apr 2024 17:41:41 -0700
Message-Id: <20240410004150.2917641-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
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


