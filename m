Return-Path: <bpf+bounces-30413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E228CD940
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692561C20F10
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80A7E579;
	Thu, 23 May 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abUD1GuK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC977604F
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486134; cv=none; b=qlAFOEszf43530A/pOcw6j/p0pb6Uj7rhJ2ZPKPqwCZ2C5ZX2SlhpvFTo6WSKUq33JbFfv7G8PeWdD/WwA6+CRksDRFpp3LelZIepExz/jJmGoqaNDtBNOT09HgTTRNZb1zRPHJECbxHZaPBGxoHU54Z6GtgfAu1dckPnWI0lA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486134; c=relaxed/simple;
	bh=7gprEONVxlTPxtpiE/RSBBqr7chsjcIUU2wLyzf2a3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rj2t4VJonEqm9iG06k9fFgnEJYgxSYUva34/ulhwijaETEnLirzUTJz9EVBg1UC3jaV+mLqXyalLibO/27+DVKflwwfSI7xWdeioARYBicO0hBMgBEYyg2438HTQ/Opc2G4kc7ADXesWT5/h6VvHWNnnspYjEJ7GYOC7lhYJ1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abUD1GuK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-627efad69b4so19023457b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486131; x=1717090931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQXWK1Yh+km0U2s78YJTSe+dMvqdnLtgISVHfad/We4=;
        b=abUD1GuK6o4omhCIwiJxJoXNBgIvoY2e3nvCo9Rcea1cFeQdXdPh6z5sn3quZC5220
         0+IoBiYdHuWFRVVFspOKyVqvJ1nPCqCDXX3eEjtU/LvqhdMiBB0+vGYkBrMEIZVD+Vtt
         Tk2DZqvP4b4b40tUPK6W3R+OQ+OjYqrSoIaD2qBxwFqAF8nKWyc84rpuaeeAdyWyNlyF
         WnCWe7+RPeegIYW7CwGoGj7VwvBt5MFu2+qYj2LDUK7pExCb6x0LP7SsLXxUZFqWDTKN
         J41yx2w8PGHL4h1pdxswkdSDHrpZCDK+SwlzGI79luL8P4QHiyg39BLhFXEx845WpQX4
         P21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486131; x=1717090931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQXWK1Yh+km0U2s78YJTSe+dMvqdnLtgISVHfad/We4=;
        b=CjWfKFe/dlPE7+MCS1QUu/LWIKWcbuxMaDnDfmGcpKUfC/Ty8SLQnUH2364A6HRZTG
         yGqd5fBJkju8hQmgLqWZ+FHr8lWBy01srdrbLAjRUA4EvGSpOFQLEXys79zmina8+eL9
         7u8Ss2SFS1iDGRVVsAk+63hPe3hCbUz+54i4TytvxaHvcmC9gbaKRXzK+EDkC0XqoAb8
         B06mWKrdOFuArjxLJlzBEynQpJR1YJFUty/CIyIXLDWyGV+XlMkliZh0snvKBcvo9hB2
         CHdA6YWW/8Is4G2TC421sFpZfrPqYQgc/lvUSabDv1iMGwxej81VEOAftv2aL4XicHpo
         IbJg==
X-Gm-Message-State: AOJu0Yx1cEV6NlCuw/4bAdxuNsxOUtUWHS7zDoQQmUhxjwtjqeayyS56
	UTlFLNknYsLkV5QvKoJrVJq349wNT3RKFD5Z8MgdpG16+1rN4wwL8EIqqQ==
X-Google-Smtp-Source: AGHT+IHBs3b6AO/VdPJe9ijNbLUAjPqBHAxXVxvJYFRATtrFbxfi3WeJi9smmYT+lpa6JXttkTxBQA==
X-Received: by 2002:a0d:d5c7:0:b0:627:d0e8:1775 with SMTP id 00721157ae682-627e47152a1mr58886807b3.39.1716486130157;
        Thu, 23 May 2024 10:42:10 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/9] bpf: Remove unnecessary call to btf_field_type_size().
Date: Thu, 23 May 2024 10:41:55 -0700
Message-Id: <20240523174202.461236-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
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
index 57c0c255bf4c..81a3d2ced78d 100644
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


