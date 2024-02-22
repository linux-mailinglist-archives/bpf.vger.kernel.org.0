Return-Path: <bpf+bounces-22482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02E85EF02
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 03:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F137A1F2325D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AD14A96;
	Thu, 22 Feb 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHekkZhp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34167134A1
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567872; cv=none; b=orBSGj52bxqu86ExdIT5dTI8zlfe+OXWYBcyX3pcilEq/zJ9L2nSMsL1tYflHDX8tYUOBwtMLj2Ic3FJ6/5NdZOl1Oo8kE0G36I8W0h50vYnyW9h5Tr+XgfNRnhNR6jDPkEd3y/Uzebu3UX5B0L/LlmdNhyiKBvl8A9ZHiIVHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567872; c=relaxed/simple;
	bh=wIKWUO2/CBkyoBTjqWQL/SV84QezxJtJ5poS3T8Gca4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDQoN8eB648+AwaqI879pdTRF7hF1VKTdrgyWai5RpiBnhMo0dLCm4RV7xceNxUzs94tNVoRN36E+3oRUBDQMvMcjD5Q/VETlQH7VmwoJIZxE4lur476XMz690Ogrpr4+bPbMJYyjM1Qf1Whm56hMY8ZwgQspWEIm2lrtRSSdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHekkZhp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so6594835276.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708567870; x=1709172670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpd7CcJSzuo6eCnI5D93fAgBQbayeNI025jXNT3EHW8=;
        b=OHekkZhpXYpQrpzczw8rOaLrS7/cT50BHC7nMCZ4/eX3GBMW4cHIoTKIUqy5nX91Td
         PMHn5uB0wtLItaFKHyO29MIthktlPLYOW/dIRH5U3DANCa0rnPzs+FoZqw1cqvHyLY+F
         eiCWTnSRAf/h56c/ypDhtzBGtp+IQTsyKteJEbpB4wsudZoXmLSeMMAfaO8BSbV2HmZZ
         43UeTBqOYAupD8cVAAfP9WrqukbmUZhmYKaCJie4UYRYdTZ0r9Fq5VwbETUvnRQQJp9A
         U32KdPpVkrcck8FWIRczRJbPXYes12KiXdZ8WM05xfJgVnHgqe53SVjNh758lyVpnVCO
         J1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708567870; x=1709172670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zpd7CcJSzuo6eCnI5D93fAgBQbayeNI025jXNT3EHW8=;
        b=xBPOar7El9/+QQqD+Muck1Km4LBC6WuEYCMUqR5MX0aMe/ZnqR/W8s/A8REnNInTM5
         de5Rgs98kGCHsRZp4tRC6wEFD9sq1lJrqhW0FeOnfbtityeX+wXrj216zXplmIJhqs8+
         V7ty0xOFwcRtMPan8if5kdic2BbBv+ahvdeF7teXMf4zQaitI27d/ji+t3JHZ72QMy0a
         6h+h0EqBKrISwL1n1BQraZXRQejBG1LiPprhY1hYlP/YJoAK9Ul9Hw5cKigtv62XHuWJ
         T+LYL4861QBDP1rManxw2nspTIwA7DM52C3ee45pu5f2K44563oaOBbGjXv+Tlq+RunB
         o+og==
X-Gm-Message-State: AOJu0Yxv3ZOV76WZyhiQg5NvLZeX3zDiqEqNFsGJ7kQKPHbwVARduKGn
	l6mT5GvPLyMnu99xh8bl+p4aD/Cp2tZPxz+OCCmyrDUvQCIWmtn/eRUH4zWT
X-Google-Smtp-Source: AGHT+IFMknPnak1APdNDB4tYLtyAEesObFQo2G2P66Ly7yBGmHv2LN94rTVYoAMZC8NkVDEXSLRhNg==
X-Received: by 2002:a5b:a43:0:b0:dc7:4806:4fb with SMTP id z3-20020a5b0a43000000b00dc7480604fbmr1155830ybq.8.1708567869747;
        Wed, 21 Feb 2024 18:11:09 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id t34-20020a25f622000000b00dc73705ec59sm2613590ybd.0.2024.02.21.18.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:11:09 -0800 (PST)
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
Subject: [PATCH bpf-next v5 1/2] bpf: Check cfi_stubs before registering a struct_ops type.
Date: Wed, 21 Feb 2024 18:11:04 -0800
Message-Id: <20240222021105.1180475-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222021105.1180475-1-thinker.li@gmail.com>
References: <20240222021105.1180475-1-thinker.li@gmail.com>
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
index 0d7be97a2411..796cec701708 100644
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
-- 
2.34.1


