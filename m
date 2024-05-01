Return-Path: <bpf+bounces-28401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B68B90CF
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64910B22A25
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6221649DD;
	Wed,  1 May 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQZ4dJMW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21C163AA7
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596463; cv=none; b=Yszz/+BtvxVzO+lPoH4ERxpnPZ/UP0rOnIirLy0Ur0IMkTaZGjVtv3nMXQ5r8vkDseUypUcBeh/cx+m3ScsZPeQ9qeudoGZ9MPT0c/fPnDZHQtQg9gm9R4AsainBCgrZM7qYxqw65v6nLGzOKt+Ewm2Hh79Hbo6fvbcbL8CNj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596463; c=relaxed/simple;
	bh=HR0BZ5/nRStZ4K4LeiV7Tlj8QBA0mggCUyHdcTcT5Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB70vE49bipJZKtRNAiyIkjiLo48E2LQKSf7w5fx5+TaJlLkHt97UR/FHWaFjuNN3YQuHGBvN9vzVPncFzWYCmTIQPomAzn5E7n61W1NWUlAL7Ix/vVXkLvBdwXyj7t4SJRRf75tP9L4sTsxJuMK8JWXDbOokNbft9MQIuRBoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQZ4dJMW; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23d3afdcd71so800000fac.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596461; x=1715201261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTl8z0Qr3BLTdPqJ2qKa7KSFvqh3z2sPFtoSfzE/nzg=;
        b=aQZ4dJMWGJnz3Kf6TUsR9nqlDvZvhOVTwAGeLpb+q9WUOrVK3UaDnXTtCx5bRitJry
         x7tyxTnzUgAIwsM5VM2pA70QtwFTDbuzwVRzDkXNxoTOn0hyJqc4N6y2Zpq09AKmckaC
         y4sqwYS8wUFNXVztHGBD4EnMPAUtcljwEBu6p38qXbhANSQbPZni0/+81R+3J+R0qvxF
         pETxhfRrg6J+eer88jlAfekQtx+N1j8QQhysYGsdH+Szn9n/ivQx9Uh47IckE6B193aI
         Y7mYLiOStBHyv9b2CWw88qZxyj5h0dvU4Qe2IpnhI352hw8o4Zpba6aJAYkxIErCNpD5
         +hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596461; x=1715201261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTl8z0Qr3BLTdPqJ2qKa7KSFvqh3z2sPFtoSfzE/nzg=;
        b=RYWfAxad3w4s9rDwCPHgD0oTwcZTpNPOzLNeWCPtUpenlVBcxBwORYPYG1gt2kwGv8
         qWu8Y5otXvJ8cKaXBV6HGExMKHoFsrs+pUim77mM2VmG3BuPUDW1Deki/1YIiKI58ocr
         yWNhFOZ6Zz29GV7pJ+iiKT53PIfv3VO8ZXGfpVHxZ4EnWhKLmfjiUPPMZYgWfwve86Gf
         /pl01/nbJSOBmxqurZglOFCx9UflZZv2B6FIuYxce7z9Ng+3uRNOQncb/Esj1gxoUolF
         jsm+JsiRi+MwvZZg3Lm1xMR3ABe3E4Pv6m3qlPQwZvo9btODwlEucCZOQ5rt1h169A1k
         /nBA==
X-Gm-Message-State: AOJu0YxV7nFrrXZk4Z+BpQFYCNO/P3GXx3CI8bjDC7G+TTpQAdyrwSaU
	Ie+OVHg/jEoK7hyssv0PwIoxxVkWvBDD/dWRghAN4GBrH4GL8brne1lsUw==
X-Google-Smtp-Source: AGHT+IHqLo3ouAutLOPCNhiVXtpJ+tvThshANe481J75q/6XRcGGalmDRShVFtgx4MhpstIp5/QkMQ==
X-Received: by 2002:a05:6870:558d:b0:23b:e418:d967 with SMTP id qj13-20020a056870558d00b0023be418d967mr3955360oac.12.1714596460904;
        Wed, 01 May 2024 13:47:40 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: Remove unnecessary call to btf_field_type_size().
Date: Wed,  1 May 2024 13:47:24 -0700
Message-Id: <20240501204729.484085-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501204729.484085-1-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

field->size has been initialized by bpf_parse_fields() with the value
returned by btf_field_type_size(). Use it instead of calling
btf_field_type_size() again.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8291fbfd27b1..d4c3342e2027 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6692,7 +6692,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + btf_field_type_size(field->type) && offset < off + size) {
+			if (off < offset + field->size && offset < off + size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86d20433c10d..43144a6be45c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5448,7 +5448,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 		 * this program. To check that [x1, x2) overlaps with [y1, y2),
 		 * it is sufficient to check x1 < y2 && y1 < x2.
 		 */
-		if (reg->smin_value + off < p + btf_field_type_size(field->type) &&
+		if (reg->smin_value + off < p + field->size &&
 		    p < reg->umax_value + off + size) {
 			switch (field->type) {
 			case BPF_KPTR_UNREF:
-- 
2.34.1


