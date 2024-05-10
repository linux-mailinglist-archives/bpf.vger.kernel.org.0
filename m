Return-Path: <bpf+bounces-29421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A58C1BE9
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3E31C21FEC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADD13A88B;
	Fri, 10 May 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWi/Gus1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36965137C26
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303598; cv=none; b=m2+8FJ2DIJI2ZkGHwNyArHP0pEMp1ri45iVSBiafXfp5fwcbAR+SSFoeF8F+qctTgJiwsZzWQM8TjrfUuMOwdOSYGLlmsLZQtsWZMDfyxULDgHgFKeFEw7m28rc2ABMNWcAHKroa8oKrF73UG/N9zzVbmp/QCS2/+xI21her3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303598; c=relaxed/simple;
	bh=qqggGaC3A0xzhmB4jpLtjhbNT+5ro/jXBMnCfYwbGzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3+gbaMjQZcnGVBLS04N8J0kuC87NngKj3aeQcGEvSxZ6T2YaReEtXgXoJd/7qiF7FSzLHOUXePpp567ZdSt4zWKxvLhZVppovwrwVX1eQrLfdlx2j0Jt61r/g4wVNejzrw91fI0ASyGH4k3rjQkx3Ixgh2CINSDkzgiir1IsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWi/Gus1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f09ed75e4cso797010a34.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303596; x=1715908396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEJYwvgNo6RYhVquU9hRkea7EjQyUP61ZP8HQ5pKYfw=;
        b=GWi/Gus1Pp4Y1FccQfsaM/zZABMjIyr0PiCmr5Fy2bJLFerYPSSbGlVx/AC4iCDPgn
         3emfQQC4/pRqrIbs/DtalfyoU2JMvuMw5RWBeXQKlOdr2i7sLyOnmD6FUDALPI+aVxFb
         iEYy7SWpSXF6mxB6vcgekp00n5ESiHuYmVgx9ALAphxTxBnTDR+7jITsddjkfgs6aR0E
         p384JdB/G0vH3f9DgFX0D2W3HKXSbpF43wEEuVsNMbUTcs0WKDnzRM9Tu0D+AyGoUMWX
         piHoDkpfM0Eo/F4XePtYppxNFQurGLG7Aqr/+YvQDfAFfvNUgou2egFxGLEo7P8b48Ll
         h+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303596; x=1715908396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEJYwvgNo6RYhVquU9hRkea7EjQyUP61ZP8HQ5pKYfw=;
        b=bbehmTg/b2VpvIgN8rI+bbF6gvJj0MmWK5IM0wNybuo5pU1URml2Q4O0SKd0lGnYjs
         C+KudKkI2viYn2d3/MBiiRAI3jOSlTTXjOx9TPEwV8MeF5z8sVqrq5eobA/slkzT5ec4
         NwQxflOx1R1fD7oZsizffn4xrt5Qr+IoUqmPIdQfrmW4v3yjd+lFWZDjhw8qFEi1V5DE
         KHg9NEN+YuTeSTysamJxrDosNTjCaia+UZ8ZA+STG4qmDYQ1v8jMuGltHxstjiVakgVi
         sAh/B8hTbTdQvtuXUmBXkRskY8ENrMMZlzliGRvnWn0LtVSdMMQmYq24GbdUQTVelqMn
         9GqA==
X-Gm-Message-State: AOJu0YwhPXcDkY10qtWln7QXt04vI31fiYzEWDIMIrI5jdm0pz6IpOWX
	r0wus2EMIrJELPqffiKbQJmvPnSYtJIL0GTWZvAJU7Jk6iATgeZvUBDYyw==
X-Google-Smtp-Source: AGHT+IGwqmOHYV2Np2ZRI/pjFWxc5B3NdomIkcFzNI/SZXASbJCHdp3y3f5/HsXsVqh+6sTzKqcgMA==
X-Received: by 2002:a05:6830:88:b0:6ee:3596:ea1a with SMTP id 46e09a7af769-6f0e92d00b3mr1242503a34.31.1715303596012;
        Thu, 09 May 2024 18:13:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/9] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Thu,  9 May 2024 18:13:04 -0700
Message-Id: <20240510011312.1488046-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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
index 9e3aba08984e..3cc8e68b5b73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11640,7 +11640,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1


