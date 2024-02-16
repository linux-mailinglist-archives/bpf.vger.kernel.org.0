Return-Path: <bpf+bounces-22180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B1858635
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC31283341
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E5137C3B;
	Fri, 16 Feb 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM/h0Zxq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDE1350C7
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112085; cv=none; b=lo+2yh2UsKDP5PXNCgnN+CLBx+fsGXfGUOiQMHu2EJZ9yXPMGSiffNaJ+LwG8UdEjY1ImGwSDp+x7bdSX92iGTKToPR3WRN7qyqn7lU1XhXI54IC35xEVhvarlpW2+EojF9sLrC+Xf/S/qGFhhmpXj2jWYvlQKSa6rAncqSpSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112085; c=relaxed/simple;
	bh=EOyRPT/S91vGSnocOPw62WHR15k/E3sGrnl6g83ByHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwedLxY/p7E8hWIosUNoHGt7WfGKjZDuMGo5IR2EOuB1vTLE1o9ioIwJUd4nJMJlE7oFp/0ONiMss35XUMtWzXF3sfZ+3DskX2OTMnEXKpK7/qeo9UVVW577ZCczbqekOzQSVCBpJZ8DU9U31KSIC+JQQmIEydvTWBvuXxQ3hFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM/h0Zxq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607bfa4c913so23141237b3.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112082; x=1708716882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POMF8gdVHCtMvnQ/4suPykXis7dVQbWXMcgnXSGuvdA=;
        b=LM/h0ZxqRev/yZ6X0HHbwCnlP5YW9ijhY10a9mhg+M+7yQen+28ZQZOLfvp/4WsX/k
         GGDdMDCW7oVtcbWYx1nJJOMyzZdFiQpso6o87Cmydfaipk0VzjJL28OO01xj7azhGJ89
         +TevGnRCgVd9ijjHRf7C3rA9evZ0GcgBQ2gkN5WLtO9OE7hi1zPAv2KKGF2Dp9H1B+ns
         yGPjkvqsgOyV6+adv60EbjzKOW8cyAVF9QUVLCd8FxlYpsHXqQ8byBk2msYzEVgVfyQQ
         7lZQ6l7lhvB6xNn4QU3TGaMhn3nY893S9bmS9xAbnkh5uB7XPbBBYYH8ReIKhQYL7Wm2
         zSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112082; x=1708716882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POMF8gdVHCtMvnQ/4suPykXis7dVQbWXMcgnXSGuvdA=;
        b=ky4zo91Xjqyqli2+JrwzZvM4Fsf9lVlSSq+MeTeKewCdfTsYaqqwthPTdlME0zcQMp
         s7vtoT/gzztwUtqAkujRZZQvlgaZ7YkGkmmvvVufkjKZzxuFlkfsBOi7gEvALrLKq3hA
         GMR3OgPdhmbWk2XGle7tt8wFNe/B2VZUpPWZn5Ch9aXqiMaPkcXE5FzbSVkGZwTydYt6
         OR3/QrrA3IpYQg3JfK/ODY1hRIWYzCXP9eZL4knw2SuP75G/2ayLe7gTNNks7yU3jqpJ
         E371kF4IOnB92kW5YCgyko+Ox5qw9Un7OmFH3ymwvs/Du3usMjDHf8IdBeyKA/dUbWn4
         v1TQ==
X-Gm-Message-State: AOJu0Yxt+QtMqbORd2+rk7lfr7AoWUItt5xu+dwEOJPJefOUYkEtDtbz
	MPIMhtLFtxheaUQ8Az9Rr6ZxEdZbsdocwotrpv61SIltxDLgdztzB0/IkwlP
X-Google-Smtp-Source: AGHT+IFD0lSL7oQfWD/3Z/6RztRywBXp7pFHNQ6JbLCdEZ48sNSXWXM4L1u8aCUI19ZS13P9OR4r9w==
X-Received: by 2002:a05:690c:3692:b0:607:8d16:dec6 with SMTP id fu18-20020a05690c369200b006078d16dec6mr6393412ywb.51.1708112082356;
        Fri, 16 Feb 2024 11:34:42 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b00607c2ab443dsm470785ywf.130.2024.02.16.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:34:42 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Check cfi_stubs before registering a struct_ops type.
Date: Fri, 16 Feb 2024 11:34:33 -0800
Message-Id: <20240216193434.735874-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216193434.735874-1-thinker.li@gmail.com>
References: <20240216193434.735874-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Recently, cfi_stubs were introduced. However, existing struct_ops types
that are not in the upstream may not be aware of this, resulting in kernel
crashes. By rejecting struct_ops types that do not provide cfi_stubs during
registration, these crashes can be avoided.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..9febd450d224 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
+	if (!st_ops->cfi_stubs) {
+		pr_warn("struct %s has no cfi_stubs\n", st_ops->name);
+		return -EINVAL;
+	}
+
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
@@ -339,6 +344,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
+		u32 moff;
 
 		mname = btf_name_by_offset(btf, member->name_off);
 		if (!*mname) {
@@ -361,6 +367,14 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!func_proto)
 			continue;
 
+		moff = __btf_member_bit_offset(t, member) / 8;
+		if (!*(void **)(st_ops->cfi_stubs + moff)) {
+			pr_warn("member %s in struct %s has no cfi stub function\n",
+				mname, st_ops->name);
+			err = -EINVAL;
+			goto errout;
+		}
+
 		if (btf_distill_func_proto(log, btf,
 					   func_proto, mname,
 					   &st_ops->func_models[i])) {
-- 
2.34.1


