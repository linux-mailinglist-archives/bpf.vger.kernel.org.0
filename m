Return-Path: <bpf+bounces-26659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113638A379F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F1B285D6E
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7015442F;
	Fri, 12 Apr 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVcpX8qA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26116153592
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956101; cv=none; b=pNxcxdWdhC9S5Iywv4Myiu+D2k11/O4DTrqRRtjtU9c74I20yzKcVV1yd8NIHZDiFoZ6q/UG0r4chV8PlzRgu28DXk53wbrxhukK3Q2pbTTRlotk45pXm2dyTEyltkugoG88wTGXnWhpbFwLDaVYm6uDUjRfzUT+EGAFWGgaMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956101; c=relaxed/simple;
	bh=G+Jrm7+AOL2oUoXNz8kcAREXelsRshTV6bWcfElhI1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZy2emrFLm/Hpem7ejgdLXrxQ0gC8uM7h+uDSshOPle6hhsIqWWkZNQtbVIScCzuZGsoEBV+dKdY5rd4BqxoTeTaBr3i4lf5lGWlwkoydP3MbTZKkP8YJnTD2iNvL9mVVBHtO6UT88nKZmms0fwh1SelvI6PydSpmrhX5yR3Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVcpX8qA; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-233f389a61eso275421fac.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956099; x=1713560899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B8ubEPEvjOe4glCCPznp6yUG163aAy+zIl8t3hudPM=;
        b=PVcpX8qAHoFN7wIvA7BQ/QQG2Qc7oV7DlCwDi5ju1ZJ4pEn75GvUSFxOsfRqPVe4Te
         RL/AKIzJoS9mcp/DpbA+qAtSS5fmRyYJq6KdG5oyytERuY9VlsRuBufxoAU0bnQh2npk
         yfQ5ZOR8FhCvls3GWDNXjou1gTAbEDCyHZeMuVfJJhV1CbSWXfSUZZpda7XrCqx/lI/R
         UrXtKUR6tN9/1IR/RaS7kzDKiOepqah52kGyvr+A0d123RIy55NxunvZC8T0u8ecdeEC
         UuDDeCpiR+BcoWFl+Spuo5KCYG3fd3DH74rslMi5TzEc9W+WZAvfWNvLbRgXYr+nY2Pp
         l9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956099; x=1713560899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B8ubEPEvjOe4glCCPznp6yUG163aAy+zIl8t3hudPM=;
        b=S6j32Y3sv9o2forAyR9O+vudlO1pA/fKs7itrZCabmlGL6i6F3DfesuLLT3K1CQYGg
         AniFzBT3QTnqQXytNjZCwytoaxM1jx/n2Seuv0a0mzhNU7fe8zOHquWtspJLXzB/CZfA
         ioMi1tk79IcPw9kVmf8guc8YrXAMk4ulnpoTJYiHC0ikmQfWK72pB+RlxrToOUQrkwmr
         FG3NHxbE7g4dgtllXv3vAF0XUdtnGYz/yDx5P4sxXbuFL7WnIAJMcqerbR+rUyJSkXIT
         LxLCxhwOwU3b6xtxv5hHGrfUi7ov4Igk5aKw0gLDXp6ZfOF/YzPuhkEhqPQpdz7dYhHX
         o8Tw==
X-Gm-Message-State: AOJu0YyKPm6aEH23lU4Rr9xO53+p4i6CiUbRmJ0XOn39T3N3RscwGNdS
	fMgj6kChtbv2rmZVKkGVFXtbgNY8cKsk9MGyM111SRGCxrnartoG2RG/wg==
X-Google-Smtp-Source: AGHT+IHxzUQBwxHjWwi28sAKQqt8LA62wJ3YLyl75A0YWfjg/rpbkkCyGn41o8uJPHe3L+CsrK4taw==
X-Received: by 2002:a05:6871:7382:b0:233:b5b3:7610 with SMTP id na2-20020a056871738200b00233b5b37610mr3523734oac.51.1712956098746;
        Fri, 12 Apr 2024 14:08:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:18 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 01/11] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Fri, 12 Apr 2024 14:08:04 -0700
Message-Id: <20240412210814.603377-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_find_field_offset() always return a btf_field with a matching offset
value. Checking the offset of the returned btf_field is unnecessary.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..0d44940c12d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11529,7 +11529,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1


