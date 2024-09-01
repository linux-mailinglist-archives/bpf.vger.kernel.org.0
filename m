Return-Path: <bpf+bounces-38689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7973967C53
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 23:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B0D281B0A
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58F86126;
	Sun,  1 Sep 2024 21:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79A1E87B
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725226261; cv=none; b=kYv4DjuW2hTwPfJAATOLfCQPiDdZZtoKOoHzaavqBCfqdxgLXqECm/NZKzZQAimUHL1u9219Lv5DNOxVpxM5JkB+uahhELDB8Esb9Akz/RMrEpOt+UmsRYoiUYlUD0OXR/M6ClsLsdfEB3kIzsXz2WD/Y7DFpmzUhfTyY2mSzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725226261; c=relaxed/simple;
	bh=3cl2iGeT8e8Fb4olUAud3qwB+Ne97nJzV7tbxRyhifg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVx3qWtMUuK2KmjzEveVDj87K8zkRmbNspw+/1cqlAVXUXTr4l++YQ167s3KV8si3Kc2OR4yWU4dO7bPYwBN/0sGAWfDlKXjz+8C3QpVrwhUoS/oP/ZFruSFVL5QJR5/v+sO31IhET1geoY9BoxX4a4s/DwaF3khzImRSGSow/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f4f24263acso53018991fa.0
        for <bpf@vger.kernel.org>; Sun, 01 Sep 2024 14:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725226255; x=1725831055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q97AXyut1QQEk43wGOaj/ltaUmGYuhMqvyklA5F6mOI=;
        b=lRRaAFJ+KnjJyAGaOPjzU4YeESzwdG7lKOkI8Aue144HLDbawazXNKDbvWG3wdit7j
         Dq6kJOrHAkAM70ibIIvT+sRoNKOt8DsgaUESjlUsibDhX7o5ot1b+wy6aTi3CKfUF0Qc
         hxiBKtiRzKJyipbUMqF/WhHK4uws1Sk/s49RtaMd9Irx/+UWlOPl5RhdaYUZYjocVSMJ
         wUt3ZNobub5VuKyIiztcDaqiI8SZ+yXfBToH/Ym3VNmn6ZI+2MdMmatHsT9qnLtk34M4
         kV4v2petAgIh5q+vaiuzh3M/nZtZMU4FFvfk9k6h7xCvjeMz2KW/ZddhtQ/SSVUkZxpg
         9YyQ==
X-Gm-Message-State: AOJu0YyHXgR5T/aDEUHnWmMJaC2Jw7A6l4FQBQpSUn1uS0ofxWuYzO5F
	wwHlEgNmW+9TNM6+6LQqqWVBPwZR+R3RPqzJHl+oPcnfrjRtiOE3C7Y/oPXb
X-Google-Smtp-Source: AGHT+IHimgclbkuRZ5GXXhG+Y8o1rKNaTNK3E0IvZ53VAJsLo4M/D+nCWhmhOFI/9dXpBMtxn08RBQ==
X-Received: by 2002:a2e:4e09:0:b0:2ef:2555:e52d with SMTP id 38308e7fff4ca-2f6108ae923mr83323161fa.45.1725226254533;
        Sun, 01 Sep 2024 14:30:54 -0700 (PDT)
Received: from localhost.localdomain (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3d60sm475648466b.123.2024.09.01.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 14:30:54 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
Date: Sun,  1 Sep 2024 22:30:40 +0100
Message-ID: <20240901213040.766724-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Wrong function is used to access the first enum64 element.
Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/btf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6789c7a4d5ca..b0f12c511bb3 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -557,16 +557,23 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
 	const struct btf_type *t = btf__type_by_id(btf, index);
 
 	switch (btf_kind(t)) {
-	case BTF_KIND_ENUM:
-	case BTF_KIND_ENUM64: {
+	case BTF_KIND_ENUM: {
 		int name_off = t->name_off;
 
 		/* Use name of the first element for anonymous enums if allowed */
-		if (!from_ref && !t->name_off && btf_vlen(t))
+		if (!from_ref && !name_off && btf_vlen(t))
 			name_off = btf_enum(t)->name_off;
 
 		return btf__name_by_offset(btf, name_off);
 	}
+	case BTF_KIND_ENUM64: {
+		int name_off = t->name_off;
+
+		if (!from_ref && !name_off && btf_vlen(t))
+			name_off = btf_enum64(t)->name_off;
+
+		return btf__name_by_offset(btf, name_off);
+	}
 	case BTF_KIND_ARRAY:
 		return btf_type_sort_name(btf, btf_array(t)->type, true);
 	case BTF_KIND_TYPE_TAG:
-- 
2.46.0


