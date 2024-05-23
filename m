Return-Path: <bpf+bounces-30412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89B8CD93F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69777283877
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78F7BAF7;
	Thu, 23 May 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPcQSust"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45F12E75
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486133; cv=none; b=Ak+ooFTXG1TfLsIvwZD/VbyLLnojTaheq75a7obGwPBOWxpIXfKeE1spjIGZ1y41ybtS32WgjI3rTLD8RbQbiFOEn2s/BhoKZ0UQECzGYM0z7iQveaauSkUdQWIKZrw4me3GbirSozwa20BtoFTHBAle4ln/I1hZXqMTY7J/XGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486133; c=relaxed/simple;
	bh=lSwhg2euaILyL0bcxrmxhLOF+u20nsB/9HP8mjIYgt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biK/8moNN4ChoCBPDRsAffhdlOVhIcaZoPMT+hpNnVg5yTG6acSwq6KO5ToyhZdlr+XVPA3zrejF0VRkneUj84coXuMWlfwaGefXY4g7F+iOxr6sWlUOc9fAesXkDRTTjikYrKzGq8Uu99YNBSFXis+BAydn/H2HwUcNk59OEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPcQSust; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-627dfbcf42aso23439737b3.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486130; x=1717090930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JuzWBhGt4+85t6yr8ntSpXISasRyZbrXWnkL7PGYWU=;
        b=dPcQSustaZM4B5srULOnS3isLq8qkDw1g6Y6zgqupmPfAQwtQeIfHQ7c6xFULyWb/+
         BZVfw21jKP8k9eX4r6a9kQ47SfuUo98pAMOIkfrsua8wwNkfKfc7t3QTMZOYv9Pp74D7
         k3PhQBJbJ7UOlq58OOjUHeNAddvQmKTs6iqJpy94/Y3C576ZDYJ9WXMjazW+P9qbILej
         QMBgCEJycSMctCeGg/21iD0vUbJhMBiU643nf+i300zSFCZ14qYgdkubxOm8KsewnEIZ
         bB9qDJzuQbbKhu2TaHeb6l56xO0T5Wuf+pEP4kCAiwywLUAnbT0B+fK0EAD6Wi1y8BVm
         rz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486130; x=1717090930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JuzWBhGt4+85t6yr8ntSpXISasRyZbrXWnkL7PGYWU=;
        b=pUdB99ggxB01vOmlD2MAC4nZeNgjMzTTCxaQypE4qM8MTGXkMEsEIU68zWx2dSZLDT
         /z3/mvZ8hiHfqZDFE/MpcGQJugbdBmH4Zjbbq/ZrG7JLLK9GTnzLUg1GLJi884yoCeHl
         9XoxU8C9zw5wkvOkAKmowtbIcRA+42NHVUgRVOoaTJQuMpdShvt3V1U0oWUf4Y4XPtFL
         k5aUwEc5QuAm989Q9a4nnPX7Ec5ikrvfwKaOGj8JV7IIj0fu5HeSIAIpzX0MCW0DTS1B
         wAjZKZZ2Xvs8OzQ4bB86XWnA3v8qwbuvJyU2kBmJJXG5ZEJgoX/XG0DREOCGf1yOVbpG
         WVAw==
X-Gm-Message-State: AOJu0Yx0vYfvlQpgJv3QDbgazxwlJnaAQe6R31i+fHUAiuMStGWIBYkf
	kP1+j51NtsInLGb/twHnKBEqxHMRsU+vu5t/3j0vRPnBaSt5JhH0/blsjQ==
X-Google-Smtp-Source: AGHT+IE12MVqlkD01VYZT1yvdmKRMheIxt1Vb///SHEvs5LlUJd2oeRMCrTtDMtuKeyXEyCMsG3skQ==
X-Received: by 2002:a81:8457:0:b0:61a:d3ac:5b51 with SMTP id 00721157ae682-627e488cfc3mr52974757b3.38.1716486128992;
        Thu, 23 May 2024 10:42:08 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:07 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 1/9] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Thu, 23 May 2024 10:41:54 -0700
Message-Id: <20240523174202.461236-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
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
index 77da1f438bec..57c0c255bf4c 100644
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


