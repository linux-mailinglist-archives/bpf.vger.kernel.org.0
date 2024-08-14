Return-Path: <bpf+bounces-37144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1B951315
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620D51C213C0
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3A3BB59;
	Wed, 14 Aug 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ2lpoQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE91EEE9
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606217; cv=none; b=Vp200LqHALAkkT/3OM0ro6HwG6i4fea9ykWwaapf3VDxVADR60TZixsNpv7ngUUV3Ic4u/cByaXiIkItbCwi6FAE4fvvwpj1IgCraasqxT3I49F8sVnkDQwVgZVzpWevxVZlYs+ZB9woW8VFrQtX2g0P1ejSsnzqJ1vVOE/lbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606217; c=relaxed/simple;
	bh=6uguzTwBipT1pGt4iZ9oV71qd0fpV8tMOJjn79NSbc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+wGD9kKAx4lfk2bIeRYRzrtvzPoxAZ/bEgC/mf5zZrQhFu0WlVFClfEM1qiJkkbnM1eqirbT0e6ZhE+oL+rQz49MdSpzKma8kII9ZmQ8jIXP7JOLWDB0x2ZJX04d3Bi8UagNP+j0L/eUujRoVQq4l7o/HpnPg5CgIdmcWQU3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ2lpoQr; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-690af536546so62017067b3.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606214; x=1724211014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4W3sp2O8bZa06ldyNi6Xkm8a0QLS7BrI4ar8WNRouE=;
        b=kJ2lpoQrP0aYOht2aV/e9rrVTDIDXEwWWW05LkrZ/PRD1LqUFXwwAgVT/T8LSJN9yK
         6r6XuA2nvSopMIuMkA3SrzRL2P2RlI/bVTH2XrL3rOoFeTpyXJkhr/kEDM796L2Wu2+6
         8XK6UZjJV3QkfhLBCAVbLEHKmgWi6+Ks0thuC2McwQ0Vj+/Vq8ER2IM/p3qoFIiy6Zb4
         x27H4hTE0kgAZzfx6KsIqwJABp21+W/ORUoXgkcJ+ZlrRhwCAX7SNqjhSSR2823/vGvS
         EPnwsagXuB38GkwaEWUq0bMnVn6aMM5t5xzsTbI01l6JjSL+j1g5COScwL9zFYDSQ+5p
         NNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606214; x=1724211014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4W3sp2O8bZa06ldyNi6Xkm8a0QLS7BrI4ar8WNRouE=;
        b=sR9k9Cee4g7kgtqMisn1ECPn+Dcrk19IpJy2K9tzvfLJ7mg2Ab+nPZzr8m2TcQjug+
         Y5NDWUmZjX1Yn69lurYjaPzb1tljLvAm59JFBW6+7mQ80jTO2gcPtJLI0Bi3TSrnZ5Lj
         bp0/DFo8fZpDcEOM+QWYjPjDXpuKqi/JHOGhQO32czSDPBR0wp3cHydMplMudBgtGqu+
         VgiBsxxV92GInMs00hAbsuGSihABgdbX8KSf+TYraIwSi3Dz0u5+avGfpRPUlSF6UNM/
         swq/NxyHrYqYUTLhzevytxvlHKqFBYmI51sfJcX72+uVgaLqn92j6EtS0HIQtweMhcVY
         alWA==
X-Gm-Message-State: AOJu0Yw1AL26neHs0P89epw4kKEJCswgzR8JxXrMWL+uwsg/v5nwACEr
	PosJVeyXwqWsU7FPXkmCLDiw7rSbak7/kD2A5U1lGGxYOijQovJGUn+PwqKx
X-Google-Smtp-Source: AGHT+IEJFczEH9ELL9G9xWR5BRbkZDpPLOKkKg6K9OPH62H2oYV6Q4FhRAARNJwGqOduPFrzdjKmXw==
X-Received: by 2002:a05:690c:3302:b0:651:6888:a018 with SMTP id 00721157ae682-6ac9764531fmr16074917b3.26.1723606214374;
        Tue, 13 Aug 2024 20:30:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:14 -0700 (PDT)
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
Subject: [RFC bpf-next v3 1/7] bpf: define BPF_UPTR a new enumerator of btf_field_type.
Date: Tue, 13 Aug 2024 20:30:04 -0700
Message-Id: <20240814033010.2980635-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
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


