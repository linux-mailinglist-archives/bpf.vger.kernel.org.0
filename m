Return-Path: <bpf+bounces-30044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5898CA368
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF001F21E90
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BF139CE1;
	Mon, 20 May 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL3dAuW2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDC139588
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237626; cv=none; b=YwsnXVA/HgQSRRMgnLhUyD8qicQVB+WJNLmriHeI4k3hDXCwiVKRkonwdbvQKcafhioBWes4kwHUtqw8EZtvKBnuC3WOsAWIjfT+esjVkMtDRdtqHXHYiacykYw7oTrbEP7+h9jfz3LsQzi/mlqaPaxf1eAKjmRcUKIaHQt0jmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237626; c=relaxed/simple;
	bh=2xfkYFldYvZvPKiTXacO80MKDZrrQYMBUHBKmZTcdbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qm3CNqylEEVgfXHWxSsYWWBExNiKcbs6guowcbi9Mwvn3yNZ/kMcQlwVaygS18RPPYI2qxokp1WnoOuagnwoLILuOa++GrmlawVTy5xp1RQZTku6EKHDwGdSVxzhyRNv+fxjZqjEcvPvV+OqcU5IP+r77vPZVeiGgbPsP+HZqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL3dAuW2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61e01d5ea74so29914737b3.2
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237624; x=1716842424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oByKvxTobDLu+nJ0pkp9fRC/p41vrPlk7tpSQ/k6wLY=;
        b=OL3dAuW2AIaW6eOfgHz0Wc5FThASsUDXoOv9XUaGCAG5akLryFRFQMOcjEpFrgZF2j
         zmDULiz5G/Rp7HHzUcNtT5e9UzuUv8BeMdJ53NBg1RKoAotHMg0VfLljpV4FZVc8wOx1
         ZoqI/Z4G6fsGIJ8kW1gbayVPpFxdadYBQlZZ1TmDxHQ0n7SZ29qmAU9xlV8BnmsI7UAS
         LtSVlDDUrI/g4+er41b3gE8fjbIYK6uoQCbWM0u7KXNhADCB72epBFWlMjtyPPvTEAnz
         WQ6z8uQbmUF7tqbN4aBsXhIvUuZS8yr3BFScpzDNKXIucmgNLvfxnUaQUoo3NkUgiOzg
         e++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237624; x=1716842424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oByKvxTobDLu+nJ0pkp9fRC/p41vrPlk7tpSQ/k6wLY=;
        b=pfq/RlQjXrDhN0YpnrCCb3n2cjlZzNShXjAvcXJtOpIiI7L2IY+dfYapOOzzW227HB
         twPiJ9skW3o5ZqwyY+ePlgvf81AfnI9SqxG8kNFF4V8VYiWVodpDE5uJf2doQ+ZP+iCT
         OZxX9rknlV+clMPlr7PHiXl3VjQPUP6JVVP2NmCh2/rcOPYIZyEDcVXrbgfNZDMm5Efq
         CzWEFHzBkGdpzauXJKfKMjBY406DUq5Zf7f68j1oS84Um7Rg0/Y9JsmulqZrW58jW5RL
         b7NPPOborn9JIqDXIzUoj9k3ocj7aOO2Zt5oMRWrNrOttPfkE+ZsjqvPiCUacrWPP8gw
         ABKQ==
X-Gm-Message-State: AOJu0YzYYqFHfuRZQ/xC9nouL2Gxwz2ZIWRoGIxrjIZxlP7BBmSZ1f4E
	Bb6FElFop54d+1QibOYaEr+O/UyJe7p3rHfoSzd7axzdeA2lAdqSfQ4/Zw==
X-Google-Smtp-Source: AGHT+IHAAh1je8VXT4vZQMx91Uztc9/y+BH7jWigqym0DefDM+Nhke5vYJOrWBCAyxkTn3gR0o9xSA==
X-Received: by 2002:a0d:dfd7:0:b0:614:719a:501c with SMTP id 00721157ae682-622aff921e8mr276106967b3.14.1716237624353;
        Mon, 20 May 2024 13:40:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/9] bpf: Remove unnecessary call to btf_field_type_size().
Date: Mon, 20 May 2024 13:40:11 -0700
Message-Id: <20240520204018.884515-3-thinker.li@gmail.com>
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


