Return-Path: <bpf+bounces-21093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7D847C0C
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97FC282AB5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A68593F;
	Fri,  2 Feb 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtuAk6DX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641418592E
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911525; cv=none; b=C6VE7hokkRnNRoYdK55WTLQ9yXLcsU3UELMsT54q72ZWTCWH+vcB8/dH+h5PJhPcglZNNjb6YkaO4U/8sn8GGKZie9zwH/OuLctrC6Yr8/KpgpJqKouYX4pbLbPk8ivdFpGiFzZ27dDhCeGXgyWMDhIAhO/g3n8CLt3KjT5y6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911525; c=relaxed/simple;
	bh=O1oCBvlxfg7NF4j4lRYnyl6XQ03nTIus2l8vfZpP97s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8IxIiFop2kbfluuiSug6HSdMQMpChYyGy4Y1oJuzYKz5zENPKLywjSE57SfgeS5+5NVjLcKBtPlVJaazaHI2I7pHRATjeg1s35JmFMCT3ERgNCnC5ZWgHodAd43DnCS+MkuMHviLBpNLfBPECCusxiXzg9YyDL4c+8YgOQa4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtuAk6DX; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso2255575276.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911522; x=1707516322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TCCXGmiVXsI12H0OqHGgdlkTz9E0m7mXP0GU0SssLQ=;
        b=VtuAk6DXAq+NQGyfYZHx/FHPxn5YBZGO9UrbwXMQUYqm6Zjy0fAcdKFuBMct/AKcgd
         rAC1uR3BiNZysbiNGFW5Au8W59O1FR9kwLDFgo3pJLmu0etGccBkNC0NdeFb4rW6OMPr
         Tnw8TZWsr+FbqBq2J+dpx2ZiMCblgwtme+TjZV0ZItWuzJTi2cOl4AC/HtVtQREq7r1Z
         hvZqVHOsLjbfizpAynn7t31h7tWz8K7YgZboxAcYz52jnBqJk4G4KIGFu3SgpFWKzlAO
         Q3gKFHQAODOyhvhsDZJ39KBYIg9ypWvRQywueVxpUEe0AO6TjDzDFUUinx96Q8x2q0SI
         Sg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911522; x=1707516322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TCCXGmiVXsI12H0OqHGgdlkTz9E0m7mXP0GU0SssLQ=;
        b=jTEnl38dlQ+xDaON0FZl3lM5vydzdZX/XCzyPkuonIWiTNFpQZpu7PUPixPTGpoa1b
         dce/orF1UnoL5PikRcZzu5txFzXR18YfDHQw5zdndZ+29pEWOM8Ew9/OQZglgM0EYtY8
         f005SPTJ8DzHnQ1sp/Vk3132BRA0rDBukIht7EeCHz5LQ8x54lNebdGSdxC/Nhgd2A26
         9Mf8mdLAtqxSZkkwIYtTE3LuJNOXiwx9DOnUQZNZXrZOv6ORIYudg8ttpXoubLu9EtFx
         pX/gvE/ZC9NhzoLFcc2KYkuxdmRGqOYZEF6BEP5K1EP+Kr44hOtdsmyXNSVKPhXJ5uFb
         jvZw==
X-Gm-Message-State: AOJu0YwFRtH/b05meuzlcvadL0+jnh4oGaIaXsBDZMf+7MO9GeaDMV5E
	Xk5mlX5sczXx3SvBjG3MZsXLAExl+CUmwPFzWjh0Ily1MWXolG3lBa3PPSBdbGg=
X-Google-Smtp-Source: AGHT+IGP/uS0ocx0F7Hx/sxpLRpfIJ8540iNzUuTpfthusLMJgxJ2CFCsrzAAit4qwyKZ7Hw4XYkZA==
X-Received: by 2002:a05:690c:d21:b0:5ff:9565:6777 with SMTP id cn33-20020a05690c0d2100b005ff95656777mr3612000ywb.37.1706911521753;
        Fri, 02 Feb 2024 14:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpJj2cSRUort4JilehSd1MZw2wZIO+a+bwUTnYgkvSX4cppNBy/P+300N17h4l9ZYXMCM6CUrtGd7j5UetTh9OkbTtktG4Dt+K6Xxm2YhHdEJyvn5DGd65tQ1XNG/TqcovCRo8rr/JMhSXJXmffR40HCnx+cjNdExI3xkkneN1ldhHM1VUu091TZGuJNXETct04n0+zhCH6bYjI/9gxUQnJLxHehR49FIGCT4MNq9+Fc2XWuX8hnWDjex7kiHpPzU14+UFL4qTf5/EUc9koQv7Xu900kAGCPUSAbRSO1TVWWM=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:21 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 2/6] bpf: Extend PTR_TO_BTF_ID to handle pointers to scalar and array types.
Date: Fri,  2 Feb 2024 14:05:12 -0800
Message-Id: <20240202220516.1165466-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202220516.1165466-1-thinker.li@gmail.com>
References: <20240202220516.1165466-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The verifier calls btf_struct_access() to check the access for
PTR_TO_BTF_ID. btf_struct_access() supported only pointer to struct types
(including union). We add the support of scalar types and array types.

btf_reloc_array_access() is responsible for relocating the access from the
whole array to an element in the array. That means to adjust the offset
relatively to the start of an element and change the type to the type of
the element. With this relocation, we can check the access against the
element type instead of the array type itself.

After relocation, the struct types, including union types, will continue
the loop of btf_struct_walk(). Other types are treated as scalar types,
including pointers, and return from btf_struct_access().

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0847035bba99..d3f94d04c69d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6590,6 +6590,61 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	return -EINVAL;
 }
 
+/* Relocate the access relatively to the beginning of an element in an
+ * array.
+ *
+ * The offset is adjusted relatively to the beginning of the element and the
+ * type is adjusted to the type of the element.
+ *
+ * Return NULL for scalar, enum, and pointer type.
+ * Return a btf_type pointer for struct and union.
+ */
+static const struct btf_type *
+btf_reloc_array_access(struct bpf_verifier_log *log, const struct btf *btf,
+		       const struct btf_type *t, int *off, int size)
+{
+	const struct btf_type *rt, *elem_type;
+	u32 rt_size, elem_id, total_nelems, rt_id, elem_size;
+	u32 elem_idx;
+
+	rt = __btf_resolve_size(btf, t, &rt_size, &elem_type, &elem_id,
+				&total_nelems, &rt_id);
+	if (IS_ERR(rt))
+		return rt;
+	if (btf_type_is_array(rt)) {
+		if (*off >= rt_size) {
+			bpf_log(log, "access out of range of type %s with offset %d and size %u\n",
+				__btf_name_by_offset(btf, t->name_off), *off, rt_size);
+			return ERR_PTR(-EACCES);
+		}
+
+		/* Multi-dimensional arrays are flattened by
+		 * __btf_resolve_size(). Check the comment in
+		 * btf_struct_walk().
+		 */
+		elem_size = rt_size / total_nelems;
+		elem_idx = *off / elem_size;
+		/* Relocate the offset relatively to the start of the
+		 * element at elem_idx.
+		 */
+		*off -= elem_idx * elem_size;
+		rt = elem_type;
+		rt_size = elem_size;
+	}
+
+	if (btf_type_is_struct(rt))
+		return rt;
+
+	if (*off + size > rt_size) {
+		bpf_log(log, "access beyond the range of type %s with offset %d and size %d\n",
+			__btf_name_by_offset(btf, rt->name_off), *off, size);
+		return ERR_PTR(-EACCES);
+	}
+
+	/* The access is accepted as a scalar. */
+	return NULL;
+}
+
 int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct bpf_reg_state *reg,
 		      int off, int size, enum bpf_access_type atype __maybe_unused,
@@ -6625,6 +6680,12 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	}
 
 	t = btf_type_by_id(btf, id);
+	t = btf_reloc_array_access(log, btf, t, &off, size);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+	if (!t)
+		return SCALAR_VALUE;
+
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name);
 
-- 
2.34.1


