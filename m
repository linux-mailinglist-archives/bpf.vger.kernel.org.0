Return-Path: <bpf+bounces-29422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F738C1BEA
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E318A1F22CB4
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8D13A898;
	Fri, 10 May 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeqvvWmh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EF13A884
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303599; cv=none; b=AJVZLK7JCXAu+4ngqfRAez7GoRSKys+Chxr7Bk3BIhmm3HrZE30K+s0LHHlW5gkYE1xX84xKEP5HJ+qDfVEPtQUoBcyicWpn6X17cfBDZhbSBUXsEgDA9qhBbkRWe8uqSAuLdGA6udoMJ08cvc2ylEttZZ3MsTTNBwlKiIqvxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303599; c=relaxed/simple;
	bh=2xfkYFldYvZvPKiTXacO80MKDZrrQYMBUHBKmZTcdbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+l25Brb2eWQLbL6xYxIkdrAafnhW+64OCePjyrVflLimDuPYCUkAgxgMpSPpkei557LjYiS15UsgGF7BUJcpsCgr7OeYjw1GSP9GoDCYiS9CPcfFZzG4UsZ1erCXdtf9ssx4OBgzsu0OB/RYDl1owwZC7lXa+gOUscmVjQ771o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeqvvWmh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f055c08220so816577a34.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303597; x=1715908397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oByKvxTobDLu+nJ0pkp9fRC/p41vrPlk7tpSQ/k6wLY=;
        b=HeqvvWmhKN4i+dFoz9MO4Ob+K5QFhtTX6DxHea23i3b6MC/3CTwGahadLsfzHSK+mw
         wPzVaq559CmaFSt9pMvefyuOdm4uYNkEqUJCvMCST4rQIPH9AR5MsWDTZaJwoOwksmPI
         vVGYAuJ5xOV8LydCPX+eDg9J9FIc6zjQqTNfgCsUCSJHXwcGGH1QL/9h2AS+xbBFjaF8
         kN9IDd3ZvclMSwQybyo8lDGY9e8dnpJOauGxxUtUcxrKxnj3N2FXI6JEhC/ft7V/KVy8
         P0i3hUv7zM4i0+v0wzz9ITuokHdszG9rsSYSoQlLvyLM3nfvi3BZsGA2USMlV3JprVHT
         eR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303597; x=1715908397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oByKvxTobDLu+nJ0pkp9fRC/p41vrPlk7tpSQ/k6wLY=;
        b=jJApC7Im8SqmOAcGdbo3nYbGaynfq+/qbwzw4tC0jc35hDBPLnxPa7jYraWDi2zqkY
         iECQVLTARojpElC1MC11M6ktIWp1IrmFcPlduNm5gb24Q+NCQ+kwzFmBNceuPtsOMy61
         7ccBLRwtb5sdSY26Z+R6DUWFykNJ5LaV78XzUA1o8e/cprCIpYkfJmMX4JkfRA6o4BHD
         OTaIgoKMuomNhFUgjxFdg8hC1wVKt6fOAb37FJrtm8T+KlvigHt7wvtAArWkOmtln0qb
         K4oI2GvcD2oYQyisNA7EAPKhmm20UQHSfcfCL4iwY5ufrvIS+/8nGGzOJ+Usx7641dr3
         eGXg==
X-Gm-Message-State: AOJu0YwoswKUeRy+EDnVgLl5+YS3+32y6j97oT9BH5XoSLJ3ryR9LP/2
	YTycqGY0rE3NoSYuaROlluUMXhFB3E8rpqqRuQ5JlVXRhq3vA/XD/ALaUg==
X-Google-Smtp-Source: AGHT+IFXZi+AjyOFMzgEmBVdUC7lncs/+YFgEK09Pe9+aYRUHcNIOuBYpIms6Wtr4MNkOKC1A/TDWQ==
X-Received: by 2002:a05:6830:1e0f:b0:6f0:7504:616f with SMTP id 46e09a7af769-6f0e92a2e77mr1495895a34.30.1715303597133;
        Thu, 09 May 2024 18:13:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/9] bpf: Remove unnecessary call to btf_field_type_size().
Date: Thu,  9 May 2024 18:13:05 -0700
Message-Id: <20240510011312.1488046-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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
index 3cc8e68b5b73..7cfbc06d8d1b 100644
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


