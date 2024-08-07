Return-Path: <bpf+bounces-36641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147594B3E9
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4517A1F22C5B
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7515667E;
	Wed,  7 Aug 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtcU/Q3K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8A146A9B
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075094; cv=none; b=PvY7O09bKfU+GpCfmVI/Qg2nhEdNuVR0mgpdLU+zVrBEMcE9ZtBSh9WQLhYPFG696UHaOSgALAAQ/HUDvyzrxPLAce47ifFXjuXx10fsb6Qqd/0uERXTLHErEVz9gdiWYyr0cmRQUTr7Z4ataZKv4o5CqkEgKdNDYhjmK1l42ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075094; c=relaxed/simple;
	bh=IsM9L8gY+O7L86yZcvnneAGcxmYcS//7qMiw3CABlO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcExNEpKq3Aijr7RKvCQK0IQhLNPtoBwlxoJcsPtcuHRQaBYMpMZvZnvmUG+r5v+wblk9y0eAi2nnZ9FATOeLrsoH8bmvc2kZ2RYKSg2m5MslOQElQ5ZshDuOj+pp8Ll2qZKBuVXFJm5/9u37CgfW7kEx7p4kt4JBfPwIJTcbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtcU/Q3K; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65f7bd30546so3144577b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723075091; x=1723679891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBA5FHZdsY9kGUeAtOyYrFTtsEIujr4bE1qZ7e/u1Jk=;
        b=AtcU/Q3KPgZH7W8nnmZmWzjKFdCovtTzWuj+d/Jsgxvx/0GywFQ4wO/0+W6nz0Z96d
         An6E9PX3fsu6LsILm+pLXgkzvBNuMiGLMVKXTB3uWw3MNmhAHEgiw3FTDxHEYVEfCoyO
         JwBrbYh+9TltvJ0TavuYhoMMYonXPVfJaw8+Fe+ktmkWaHl+isLoApkZTgo9RSfxAKAE
         Odhwrr3LjNtTSfLJaANGmTuKQ88wv7Lz8ELWCf4zt3xfOLCdblK1QKEOXZ9WqoHLRyAq
         VF9fmXlnWGQbEg5aeR8s1wA1+qPN3wGBSwtm8lX3ZSvKv6iHeO/Ouj+3yUitYYsCfZT/
         IQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075091; x=1723679891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBA5FHZdsY9kGUeAtOyYrFTtsEIujr4bE1qZ7e/u1Jk=;
        b=IiZk/XxQ7Zh31MA0u9MYqkzccTjFgkZ/Ge64ds+olsn559KrKPFIrZJQ3IWHUl4zhM
         Mca0hPxyLsdA/6XRw6MzgWcaYPqdJI85pe+Kj/odDxPbzj2FXB+2pvCXTI4/MChxvTR9
         U6+n9ApyxeSoLwZB1V+3E9+cMhT8Q5tUNfdFEj9by2+GI8o1hJf724e8lyaxi4autU0B
         6nqAk/0Won4M7aazJyqH4gh7bVt61JwPhLrbHTiXAzFx1BdYWrBo1g1g/oyMpVKmZUgf
         0uw7pnhkQztqSH8ylxik3jFL/jB+rslHawKZie0BSEQeCXNsnlRTZDe8uNyqbZHgvvmZ
         jnGA==
X-Gm-Message-State: AOJu0YwAb4+u4Cy24ZzDJjrjhIMM9PaTJXDltCvPOOeGebjqOaREMQmT
	2CRXPcZ88HmE3SPdW8Ic5TQISorQXSDIjRr2iJowG7ee0uduTInkdIalOOnF
X-Google-Smtp-Source: AGHT+IGZtR2IJZnUHWs7OFUsGVUN8IY8XgEyq3g1mXy9msGsumR4/Mr1SMNW/5+1ashrwFeUM6zGKw==
X-Received: by 2002:a05:690c:6e0d:b0:62f:19da:a53f with SMTP id 00721157ae682-69c07fc0249mr74117b3.0.1723075091237;
        Wed, 07 Aug 2024 16:58:11 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419358sm21092477b3.26.2024.08.07.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:58:10 -0700 (PDT)
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
Subject: [RFC bpf-next 1/5] bpf: Parse and support "kptr_user" tag.
Date: Wed,  7 Aug 2024 16:57:51 -0700
Message-Id: <20240807235755.1435806-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807235755.1435806-1-thinker.li@gmail.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse "kptr_user" tag from BTF, map it to BPF_KPTR_USER, and support it in
related functions.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  | 8 +++++++-
 kernel/bpf/btf.c     | 5 +++++
 kernel/bpf/syscall.c | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9425e410bcb..87d5f98249e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -194,7 +194,6 @@ enum btf_field_type {
 	BPF_KPTR_UNREF = (1 << 2),
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR_PERCPU = (1 << 4),
-	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF | BPF_KPTR_PERCPU,
 	BPF_LIST_HEAD  = (1 << 5),
 	BPF_LIST_NODE  = (1 << 6),
 	BPF_RB_ROOT    = (1 << 7),
@@ -203,6 +202,8 @@ enum btf_field_type {
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
+	BPF_KPTR_USER  = (1 << 11),
+	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF | BPF_KPTR_PERCPU | BPF_KPTR_USER,
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -322,6 +323,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_KPTR_PERCPU:
 		return "percpu_kptr";
+	case BPF_KPTR_USER:
+		return "user_kptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
@@ -350,6 +353,7 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_KPTR_USER:
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
@@ -379,6 +383,7 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_KPTR_USER:
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
@@ -419,6 +424,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_KPTR_USER:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..3b0f555fbbe6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3361,6 +3361,8 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 		type = BPF_KPTR_REF;
 	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off)))
 		type = BPF_KPTR_PERCPU;
+	else if (!strcmp("kptr_user", __btf_name_by_offset(btf, t->name_off)))
+		type = BPF_KPTR_USER;
 	else
 		return -EINVAL;
 
@@ -3538,6 +3540,7 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_KPTR_USER:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			break;
@@ -3664,6 +3667,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_KPTR_USER:
 		ret = btf_find_kptr(btf, var_type, off, sz,
 				    info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -3988,6 +3992,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_KPTR_USER:
 			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf6c5f685ea2..90a25307480e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -548,6 +548,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_KPTR_USER:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
 			btf_put(rec->fields[i].kptr.btf);
@@ -596,6 +597,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_KPTR_USER:
 			btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
 				ret = -ENXIO;
-- 
2.34.1


