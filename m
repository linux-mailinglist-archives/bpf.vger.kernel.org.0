Return-Path: <bpf+bounces-22048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA18558F1
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC66C28F3F8
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D31C06;
	Thu, 15 Feb 2024 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ091itb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA421392
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963848; cv=none; b=C6GGMNOfA2AHBlUA0Egjuo2emsRkkz1LxXTbB9HmOmDrMqFhEcWTRI+wrG0D1YDDKWh2h/E6qx5wYLKyXvCWWMrZkXjIJrgVupJEVPxO1jVqRB0kIXSlkWZ6cJAuJ4RDGx9aJqPQouKyo0NMpUYKHtUqsfWTGKmQeIt0HehY+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963848; c=relaxed/simple;
	bh=XL1oV/oDVHT21E0pZFTXCPJ4tx98GzpndorHJ8aYVd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iWzqcP+0+rttOWe1cB27unoWxtwAiq3NStMIgn+aFHF9DxG+gljWretCrrpVUSCQxpyULY2RuhanwM+Mhdg0iat9C9BpJdNu3uC9Iyc0OT65gKyJ/Nuyp6Xzz6Z0ZNsMIVHDl6q+rO+FEAY/IElYsuLrLpTu7ZdbfuSjX39oyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ091itb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74435c428so294472276.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707963845; x=1708568645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jO3iRhMBz2n0K3g1h5S+ohi0clTPy6tmg9Fvmq5N/EI=;
        b=FQ091itb+HkCYa810AgfIJCVIOVzsmWxDhD5BSk8YrDtGbRfwoN8WY2PnE7+jnumd7
         oV44IumdU6UW/oNmsCcmypVTaQQulrlHG7xvfL4kvChLv2zyzr2PkhvYA4pLvRyqXHJs
         ZT2nNBMQsCGiBGanAZIllN4odbR0CfuKmHOsGY/OGa4+SV+nu+GBTRW3a0c+zxcxLY0C
         GFmcdKvCqMjz6HbszZoZc8EnkxM9IU8Du2pRmrMRRA5g2Ob/ndGripHhoR7QGFiPEzOD
         eCWHHxV6Pf4bJVMeqUvhskB69kXhJU/ykcUWpNch008m+/ncamoN/sKibqX1kH7AqAb8
         LzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707963845; x=1708568645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO3iRhMBz2n0K3g1h5S+ohi0clTPy6tmg9Fvmq5N/EI=;
        b=atwuWcxItFDv1bI2gVw5EhvIV8jl3CjGJsz/E9CZ5ZLoibAaWnGOeCREODNVyzt+EV
         c36z/F/3QNab+l5ZQq9icaKYn1l4bUluhh+tD2uDBeH5t7AFXR9wpJtN78pBDYvyD1jm
         P4YdSc3x2GP4xg+ZNDOVvdpAy+qmQfDirUP2cHIpXkxVZ+z41cIC2LbBl98KZM+3/16M
         ymO56xKl6fx+JcFJ5wy1G9iHFepFqAiw78arfXiVT/+sapdid/VPQOMub5wtKYm2TVWW
         e4WveOICADOfyNxBWY1qEJa19gLWAo81rkT+HaUNQExbwk68Z3UujnYX7yD77illODZY
         0Ctg==
X-Gm-Message-State: AOJu0YzdlGz50NLWJCs4+wKQAHf86ftWCNvYKfF2h6/EoWfbxzX/9FE2
	Bcd7BkgSckldIxcFD4bKtqYHMHRZFPp20N+jQ+uR3tZN11Q9Y6LNkpTLVHy6
X-Google-Smtp-Source: AGHT+IGz5Z0plAYx8JAiTSfylZSvu4ZyRnh7OXmfiRUIVrnNQEw19PxFjuoBkg7Wzd1RtsaCwX/G0g==
X-Received: by 2002:a25:f203:0:b0:dcd:b034:b504 with SMTP id i3-20020a25f203000000b00dcdb034b504mr334289ybe.27.1707963845299;
        Wed, 14 Feb 2024 18:24:05 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d584:8b21:ee08:57bd])
        by smtp.gmail.com with ESMTPSA id r12-20020a05690204ac00b00dc7496891f1sm35627ybs.54.2024.02.14.18.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 18:24:04 -0800 (PST)
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
Subject: [PATCH bpf-next] bpf: Check cfi_stubs before registering a struct_ops type.
Date: Wed, 14 Feb 2024 18:24:01 -0800
Message-Id: <20240215022401.1882010-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 kernel/bpf/bpf_struct_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..e35958142dce 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
+	if (!st_ops->cfi_stubs) {
+		pr_warn("The struct_ops %s has no cfi_stubs\n", st_ops->name);
+		return -EINVAL;
+	}
+
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
-- 
2.34.1


