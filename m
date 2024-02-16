Return-Path: <bpf+bounces-22123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919068573A3
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D59A2845C6
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA62FBEB;
	Fri, 16 Feb 2024 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhPbUXYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C15DDD5
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049037; cv=none; b=MM+sc0ReM6trO51OwJliYmhpJFBRs6XeTPjlfl3I5pwiemOP6gpwbosS2ghV47VLG7eyUEQptOsPsBkTdk+wnVswnJb3rH0LEVHNK4pHWC8Cn6Pdpcnzf12Z+4yRsaLFiXIntZbM3uRIKbBUW3XK7hBHUYxZUKLDOE7o/X1ICTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049037; c=relaxed/simple;
	bh=EOyRPT/S91vGSnocOPw62WHR15k/E3sGrnl6g83ByHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPSwosdcrOHqslyAk++HsphlckNUpaZ43i5bhzsXneAZZtmtNhmwAzgYAPcaN8Zedw60xzI0zu143x/cSrFnxWK4qmIzXcXZhnqbSX/l9InrPlbnYUVuyq9FLnO43DD9s0P73tauQeduZ+ftDxDem7HqCNk9/GWAx30fgqrdg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhPbUXYo; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed0710c74so245821276.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049034; x=1708653834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POMF8gdVHCtMvnQ/4suPykXis7dVQbWXMcgnXSGuvdA=;
        b=dhPbUXYoD0rbZJIAyrBnLoU3Ic9Zs4OCBR7fFwQw5wFWsj87lSdeFOekhoB409rXqW
         osSc2ZcLEP6IHwAWaZZwyQWM3iLRTD92y/4aDq5IdhAD4xXIlHGIzg3haqn7ulUiaKPD
         iQWzgXqpx8H8we6/uFQ/JPfbSBHqydf8FWSdLIuhjK3Nh8GXU5m/h5l0BM3/huYspTfI
         E/ALkGT2bSglEX0wv0OqZrg/2MM/oFOYT3uexkq/4pqCmQcE/8TQh+P84QiLbZ26H7cA
         eMg0YN05MMxGQtxJx268lg0AbZad96HmigKxrtWXE+meneDv9JmYrXeybvxgs3Ab69fe
         OZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049034; x=1708653834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POMF8gdVHCtMvnQ/4suPykXis7dVQbWXMcgnXSGuvdA=;
        b=P2AYczzovEz02nAOtNStq6Jg1xn73RYqUx93yWg7eRg7Gf7WYALxxSrDgGZEp4G0dp
         iSsaZmbBPJgE3LSlApCeKp/4zDiv22XCzL8K9jDBJZ11RjQ523Jt7JxUk8Ywlqn5Be3r
         lotlYINjVCskrBWhel5iCi2E5T1hHAk+w44iBs+QTPE/c+C0qbtK2LVMgbGdSL3r7eUK
         4Hxu8MpMBBRtENZGMSDsXpX7WRF7TUQL4sZ+EYdqvhU+5NS5Plnw/LhE2Cx8yHBq4+sq
         iR2JudM/vzSo1CkER8LuXnransVXEmGuN0enQ6Tz1wsB3lCl4q+PK0xUyi2TemsNmiw6
         hqzg==
X-Gm-Message-State: AOJu0YwTBOuDRaAYg1FWK5X3DG5mQCFb/4cgEhznaCBkflNZr7BDfMar
	YPo128bg0ZVQgF5l7GA0s1JsbkHi4/yCCJ6XoByG/zIMDeepIKtWhSHtYy6V
X-Google-Smtp-Source: AGHT+IGSH+vVgr94aesOrKXS/0YE9FPGtvIg+iiVmh2ZZhzX1osRFqCEU74uH5EG1OohUZJHXoTgmQ==
X-Received: by 2002:a05:6902:1ac2:b0:dcb:e0dc:67ee with SMTP id db2-20020a0569021ac200b00dcbe0dc67eemr4311674ybb.45.1708049034303;
        Thu, 15 Feb 2024 18:03:54 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77])
        by smtp.gmail.com with ESMTPSA id d71-20020a25cd4a000000b00dcd2c2e7550sm133211ybf.21.2024.02.15.18.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 18:03:53 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Check cfi_stubs before registering a struct_ops type.
Date: Thu, 15 Feb 2024 18:03:49 -0800
Message-Id: <20240216020350.2061373-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216020350.2061373-1-thinker.li@gmail.com>
References: <20240216020350.2061373-1-thinker.li@gmail.com>
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


