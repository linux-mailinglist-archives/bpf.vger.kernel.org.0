Return-Path: <bpf+bounces-36739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7410394C7C9
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB073B221DD
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D91748F;
	Fri,  9 Aug 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOQNjP+8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBB2F26
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164707; cv=none; b=gXxkWmGlZzW0EAvvKLvpmsfzF6U9BuSEKZKAdS7Lq+BppNCG5KPULYqfhg8tVitw/p8MzyyBmR+hGCWz7eWlBaV98OtRj1XwcrbnLkzpUfANvjP7jtYedY8M+oOUmelQMMHPBt8u+UjSnCr0DjWy7ZSfTXiruUBUv874SBwl/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164707; c=relaxed/simple;
	bh=ZbuGl+8slczYMrERdOlmf3zPBD3iy9Dk9eC5UxB3+NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9yckcpOT3lRMdX8MjAgqjvwDY1DXMWPv2wuojD59xKjywjDWgIOoaQ/A5/XzgP6uR/Z21IhRVYiptYYrHgP9qBrGWIs7iYwTyow+2jWJjRzkwD7Z2/lGy7uoIMSbxm+SyOOLSSmvTsYJ624kv2kyY40UfVe8S2VMl732kKzreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOQNjP+8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bb687c3cceso8544746d6.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164705; x=1723769505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f+vxYAkQBb6D65mIrVwyGHBCVZADOdI72CspIF7Izc=;
        b=LOQNjP+8HUoYUPqm/WJo+nX5WH9WXCUKVXSMG29BCASuXZdK8a4ot1mBbq9jaiISWG
         D8IXR17XJ0gXswvaIcBXr/zwJu9c1bpgwurkcGkXkRWUXrzpw/pl8sNezsoTRJxo+abL
         kei9sOiMkXZvyI7PstBrFORTXZDB1dBQYAj0TJ6x1vhpfd1C5iIWaB4aJz2KO/xq9fiC
         TWIL5nnu/foeZ7ggGm492955K+bo65feppyFyRrUld4r8AKyWelcB+GEdLhdmnc7+hWg
         S7W/y+0l2RwCxgpnIThcHPOO+UmveY9fckGRKDD9ZtI5K4cfv53suU/F/UGs8r4gAoyR
         g9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164705; x=1723769505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3f+vxYAkQBb6D65mIrVwyGHBCVZADOdI72CspIF7Izc=;
        b=ILBS7Gc1v3PQ5EZn5LjfBtgyPXKx5gjv8ayd3hjmxKWvD7OkFeV9MDNouei3Uj5fgD
         H7wV9OF7xqJAJ990I6bCMAkjvlh1ZTeV5hNy2Ik0PZEN6kzifZau9rMgOp764bXfjJot
         zRkEqvtVLPIcyS2PZWjtsgsKpQEyeboFWrIHMVpILnlYx87Q8szYwCC7R7jtXPyQA2H2
         oCy4+pR7eWTcJ+W9RxyTsPqfC62UpERKQLsAvT4+s3tCcB6Jnj7VvGdIHM7s+AgsDuWA
         juMty6tVVYriQNFqqbdEhz67tlf6jLo1mx6I9UNo/S3t8YFrbj2NYNBXcTub8SdAmyVe
         ULhA==
X-Gm-Message-State: AOJu0YytRhn66YLTQLxKrsIgQF8B+6tUvFrBgAa86/hROAwlR5g1/PKW
	ZAZJyF/XhGF2YBXvE6TzXObJnr2kUtJD8GWaXoo387V1CU4qYrvleBDRUA==
X-Google-Smtp-Source: AGHT+IF9LkF7HdDe3MsNucAfL3JjD3tFBC8wU6cruFO/+VNkFkMbwbaOtS7qgrB6JLCc7qNVBhE3XQ==
X-Received: by 2002:a05:6214:568f:b0:6b5:e3ee:f804 with SMTP id 6a1803df08f44-6bd78d18773mr132996d6.16.1723164705117;
        Thu, 08 Aug 2024 17:51:45 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v3 bpf-next 1/5] bpf: Let callers of btf_parse_kptr() track life cycle of prog btf
Date: Fri,  9 Aug 2024 00:51:27 +0000
Message-Id: <20240809005131.3916464-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809005131.3916464-1-amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_parse_kptr() and btf_record_free() do btf_get() and btf_put()
respectively when working on btf_record in program and map if there are
kptr fields. If the kptr is from program BTF, since both callers has
already tracked the life cycle of program BTF, it is safe to remove the
btf_get() and btf_put().

This change prevents memory leak of program BTF later when we start
searching for kptr fields when building btf_record for program. It can
happen when the btf fd is closed. The btf_put() corresponding to the
btf_get() in btf_parse_kptr() was supposed to be called by
btf_record_free() in btf_free_struct_meta_tab() in btf_free(). However,
it will never happen since the invocation of btf_free() depends on the
refcount of the btf to become 0 in the first place.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c     | 2 +-
 kernel/bpf/syscall.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..deacf9d7b276 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3759,6 +3759,7 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 	return -EINVAL;
 }
 
+/* Callers have to ensure the life cycle of btf if it is program BTF */
 static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 			  struct btf_field_info *info)
 {
@@ -3787,7 +3788,6 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 		field->kptr.dtor = NULL;
 		id = info->kptr.type_id;
 		kptr_btf = (struct btf *)btf;
-		btf_get(kptr_btf);
 		goto found_dtor;
 	}
 	if (id < 0)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d51..4003e1025264 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -550,7 +550,8 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_PERCPU:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
-			btf_put(rec->fields[i].kptr.btf);
+			if (btf_is_kernel(rec->fields[i].kptr.btf))
+				btf_put(rec->fields[i].kptr.btf);
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
@@ -596,7 +597,8 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
-			btf_get(fields[i].kptr.btf);
+			if (btf_is_kernel(fields[i].kptr.btf))
+				btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
 				ret = -ENXIO;
 				goto free;
-- 
2.20.1


