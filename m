Return-Path: <bpf+bounces-37391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15495513D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C981C2289B
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A01C3F1C;
	Fri, 16 Aug 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agLmOfbi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C631C0DC5
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835541; cv=none; b=jdx5RKVCtdcf13s0Wvjw2/MqJDeCRyXOPMhB+2cyD5w+/OC8mbVmcJiRiPKdKozZqiyjzYJZx5NduKW4S89fW9vOkyeflJ5AKVDe2JgzyuIypKXLeCTwnUvZNoDNGZnk36laTfGyxTxdfpm68zK8GCmP6ZUaQbl/veT8OWx9WHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835541; c=relaxed/simple;
	bh=6uguzTwBipT1pGt4iZ9oV71qd0fpV8tMOJjn79NSbc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nq6ELS8Y071y3r8XHz7RbT3bGHE0ODSG7e+XFmqGOQjeFiDu5RgD3Z3G5TtP/+KZGFfsa/JjNpWSg0DoZ2aJZbnBbnmatDmy+CIEMORpFiODKp4cVdYHvQTHmyW335zt43Vv45p0OhCqSa5TBkFBF7xSqmODXozMAD8LsN+auZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agLmOfbi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-691c85525ebso21771977b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835539; x=1724440339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4W3sp2O8bZa06ldyNi6Xkm8a0QLS7BrI4ar8WNRouE=;
        b=agLmOfbiyGviHVGqiUS/gaqCTWMZ99AexdqOsvSXBqGMHcBAyY4kbldEQRQxAy0XaV
         f2cEcbQmq2gyec/eLV1SKEGvH+6+VuW/bpULaykzAfpdPhCj037m7BcwEGwio7rsWzFK
         b8b0dSnBGLQUsNVDZis+iUBetmR+8gShC+R3O0c1d6/rUx7iQKHEuq1VQsDLnL41LAH7
         xw8213rtBLYAJXZiI6u4iL8f9WsBngKQGDXpCsAdqWgc76AhSNmwHj+rRqr/OBkJ40Pl
         c49EsGUxbAWw0e1pmn8ayvr6r30aXGdTfDpIdhNM126NTufYE7cAH5FJaqt/ONea/BMD
         ozwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835539; x=1724440339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4W3sp2O8bZa06ldyNi6Xkm8a0QLS7BrI4ar8WNRouE=;
        b=xTS99aEMHhIL5/SHpB59ppQowAkyUa3lJ9AW6iQm7PKRlWYCVd3u6R98N6a57wIDAh
         8UZb8gGpCt8ZaaUx+M/qkVG8DoUkt3xZqJu1lY5SPVwov+OF2Bnp0Bi4sNNTq9XRx+4v
         uW7nNKTtQOpVZJeq8WZE+4+JQ4rRZsmk92J+BGJUGlBkKvMNhMb2zHISh6KuFafY0PfS
         i0xtkwuQ881NqmUBAl2BWwyCBeoQme7QYFrk1ZP0OZDrIHhR0iAk6JWlLkvbLhgwaES2
         TFfM/LILnSJdTu55GXypyuA7xSofDCbSoAqZECx2OGR20/i16RmqVFEkyNjIf4C+hJ0U
         a2yA==
X-Gm-Message-State: AOJu0YxypRJXPxuqzv/WzYOmBpbq/hkskah7qNsNkljnFFmTJj2dHzUJ
	ap4lO0i0yPBl6E8ycwE5S3a+KOQd3LztVpKrive/ZL8Bvj0lXzRkEseEEKe+
X-Google-Smtp-Source: AGHT+IFH+nD0eKEMowN01UBhS8kXcuXYok70WwpicjgrHW4yiUDaCX8Aupl1o03bGMwY2MkHno/1ew==
X-Received: by 2002:a05:690c:ec5:b0:62c:e6c0:e887 with SMTP id 00721157ae682-6b1b9b5aba8mr45138867b3.9.1723835538781;
        Fri, 16 Aug 2024 12:12:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:18 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 1/6] bpf: define BPF_UPTR a new enumerator of btf_field_type.
Date: Fri, 16 Aug 2024 12:12:08 -0700
Message-Id: <20240816191213.35573-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define BPF_UPTR, and modify functions that describe attributes of a field
type.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9f35df07e86d..954e476b5605 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -203,6 +203,7 @@ enum btf_field_type {
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
+	BPF_UPTR       = (1 << 11),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -322,6 +323,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_KPTR_PERCPU:
 		return "percpu_kptr";
+	case BPF_UPTR:
+		return "uptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
@@ -350,6 +353,7 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
@@ -379,6 +383,7 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
@@ -419,6 +424,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.34.1


