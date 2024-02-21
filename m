Return-Path: <bpf+bounces-22388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC085D1C9
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585C7B25F42
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F03B790;
	Wed, 21 Feb 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFzaKRXk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BF3A8C6
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501943; cv=none; b=ZuQb1R4NynSlBvjehX15gRNrfxC9OPjFPggheA8XKg0D2nqQVv84T1YC8qLkALAtaVww/UT+dlo1cLH/ImdKm5RhTvdoWEu+ZxuAcNlF4wW+ihxKkCPcv3v6cPAiNs3OuGAznZf2G5IoHIKauNRSiZnwSrYmIWfb2RcuZWpCEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501943; c=relaxed/simple;
	bh=bv/1hRkM3Caeiw9XdPyvgeh3USah0jq4oHlt2TAEppU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JuLf5alao5lEXky6W+MzibcHuekrREckqZOh8uMmER45naNkgSFGeYcAUQUKbE7Y70av3Ainu8wPAXzrB6nOvzIg9ebIwODHDH+EnH8pnIRzQG5Ve5r5FrkADvGTsLz+k9152EOJX+mzklyEI5MB+Q/eUbCrJRmYtsnPIihV0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFzaKRXk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60837b7a8ddso32380287b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708501940; x=1709106740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMO9W8z6RNVcVp/YfmN+vB/3ruzOzR+od+1NltACVoU=;
        b=KFzaKRXkP2HbERPCJSQeDtAM7AaZzF+0l/haprkq+EDIMr+FiTnO9zzhCMpUmLo8jn
         YrSrfGQqx4kX2WT2AUZkAOGTpJIY2CJeaPsPV5WJ9YULc/JxZWuqLOoXcDX2llTomeM0
         Pd5CVzG4VBjizl2xFZA/C/0eal4oz2+IzB3JNJFLQ3ZxppV3p7JacZtGDRGIERjTQHFK
         QC8x1/tcB9E/nccvPvihNz5Q8UwhdhLAWY1rkRqkRbR9oGsAwpbHGxg3rLxfAgTGteeH
         oX/m+QYyufYWU1u6A4JTObQYmB5AiIiBCmZIEyLxVTfGiCrq+r0MoWoXV4P7PzkW3Cu/
         skRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501940; x=1709106740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMO9W8z6RNVcVp/YfmN+vB/3ruzOzR+od+1NltACVoU=;
        b=WGWyr7e+x5JzZGhXxB+K0ya/RP7CPRZSDT0dFWstR2eRw9T4XhO3U6Ra40fspoG1K0
         ZKVfXv4df31hLfsQAgjdiV6hncYOkhxFUBI9EXH39RJoEyVKeltBfHUu31mHhIEmbLI/
         qAPhIGUgMJsg5RP3D0i3SHXWHwBu/P0K+r5ECzkmqziqfo3W1ayGeJVL3A5bsWmS8CYm
         uz5iCHmXhTlcORY1dqo7tlPTYS/Jnpz312ieqX7kVFYY8Z3pGih9h9QFbNcKwtUody9H
         Wyfw3Du9wB54SUhGJeGJJNcKuKBWRvEwpv18aEoA04ROXaX3I7KVKyMbwjZaIpdSrga7
         9z8g==
X-Gm-Message-State: AOJu0YwOg7g5JEkAZSMwJKCv42h/RGiiw6ZsMUHMH7+O7cPkRNBoAaTr
	yP0FHA4Xjpmt4Cm/allekYpTQ1l2n2X0xhKQIRAIaq8Q/8mrcI5pC3o7IBpn
X-Google-Smtp-Source: AGHT+IEMxgWNLbWlIuyAXEGIusaKmPyJn/3493UN4o94oXzPEhUJzBDKCysyleYM+9f2/Q9VZTem5Q==
X-Received: by 2002:a05:690c:3609:b0:608:2513:64ab with SMTP id ft9-20020a05690c360900b00608251364abmr10923191ywb.8.1708501940523;
        Tue, 20 Feb 2024 23:52:20 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b006048e2331fcsm2488715ywc.91.2024.02.20.23.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:52:20 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/3] bpf: Check cfi_stubs before registering a struct_ops type.
Date: Tue, 20 Feb 2024 23:52:12 -0800
Message-Id: <20240221075213.2071454-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221075213.2071454-1-thinker.li@gmail.com>
References: <20240221075213.2071454-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..c1c502caae08 100644
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
@@ -361,6 +367,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!func_proto)
 			continue;
 
+		moff = __btf_member_bit_offset(t, member) / 8;
+		err = st_ops->check_member ?
+			st_ops->check_member(t, member, NULL) : 0;
+
+		if (!err && !*(void **)(st_ops->cfi_stubs + moff)) {
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


