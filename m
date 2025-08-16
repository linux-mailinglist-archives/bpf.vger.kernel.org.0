Return-Path: <bpf+bounces-65815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA3B28EC7
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701A81CC4A52
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D32F0691;
	Sat, 16 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4crsuB7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F233F3
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357086; cv=none; b=H49oBHX5bn4fdAgyzb7EOORa2SV80Ca4L3IwnUx/6UHZYTVDTaQhH04cCcah6mEov1F1gji1qffHBjgXXxVoajanSCU1uJFQ3dUUg+S+UkN/YD0vO39W5VLb0FoAomXZfCWMgffcf7NWQUaV1i7ivOleI1w2i1aA5YiZZ6vOg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357086; c=relaxed/simple;
	bh=EN1CSKg7wI0ESOpyeWM0EhjynZuCoSDmBFZA/qckxpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPl6EPl2pMaMPdhyV7lZcfcYcFMamoB16zAzJ4tsHf9wf8UCKoeeL98gt9bNog2FClXdyGP886Zd6a8BVnG8RRUxP2+yIm//bd0TdOexdR1bJrlkJwNT20rzKKrAewto5oTCsKZqFnV8zFbwV9GOm9y2OFYukD84BIF7qdojzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4crsuB7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso2090760f8f.0
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755357083; x=1755961883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHLMxdVhOJk+sEjcIgkaGWNB0DsbYr3h+8t2mQTpt+Q=;
        b=M4crsuB7VykE3HHbeCnxrhlIMC96fD9DVV2A99x/ytUchHJXjoSOpfZzLTyFthaK1O
         I1ZvL/wTFOudn1epO3sQJpOXcdXTu5SJVuJFmMqoHwHYJJ6R9vXMTS4X4DuXTw9DwgWN
         RwmVP99tQptXeiLScXZkhIkXbo8yUf1JMQuJb/eml/3Yen4h5Ji/TOLPBwmKFqs4sTcT
         lfhphXSengjSF7ZepO/ZTYb//grejMuIz/qZ1fWTHuBWM8U3aiU6b4Jx5yDBhdNz3BG0
         q1er0pDZVXUqwoVOhBskXzzBYx/tHJM7ytwaXo4+Zqkfaymi0mIwqVRNHXCKh48AxeJs
         KSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357083; x=1755961883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHLMxdVhOJk+sEjcIgkaGWNB0DsbYr3h+8t2mQTpt+Q=;
        b=XwyUzNk7yZcK1n2ZwsLj8YjkjJJ1CBFMV4ZIXD2E8PK4lngWUFcSUX7QdtVSKN4+yX
         +Cmr7RrzmfIViDyWcNiIWpvUhQrjb1mYLqyTAq/TKoB8LLFxSu/C4SxQfl4WouHH2sg2
         EPP9Q74s6YXFICvDTDeGJllxV2KqBj6xqNpaCzxbAOpNWOuU+uR3v8NeV4o2NhZGgMxg
         XgxXI9J+7V/6HabwNeEnN/5PgMXijEpTHY4WthzZUr6Rzw5dn4iG8fJRwL9IXsOVln83
         FBpQUIzbC9FgCNEFTRukeuqSJYFAZCKY3klyFUOkVNEywyIxxocwP+L4d6Jwg285ZxRe
         pH+g==
X-Forwarded-Encrypted: i=1; AJvYcCVGFMbIMyhIfkQYv8Rz07IHFCr7AuZnwhbKj6RuJKZrhWnJTkYzoxIj7K222Et/cFGTaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMagx0yaanG5PuJawV1aYlNOP6lDBiaMFi/w/e+0NHlNtDZRJj
	jxLvdzDciXs9WN70NCb8oj9tO6ae3OfTLR/ycK4VraZEsqUa1FcH8Gtf
X-Gm-Gg: ASbGncvfst47lAJpDPprphRHfAIsnA0A/U0wHF2DW0I9dKFqiJBmdOI39GssSEiwN0t
	rR2z706dIBVTZ0TyVCNSTX0bnLm3+DOJpPRy20zf5qo9LmHyWKEW7r1eyrtCGcPP/1JdZkjsdtD
	U/pTtR9st8HRs8G3sJ9tZnM6oo2CGYtsNGQc9GA+yXW71d1bTyemiZlob5RoGInuqlk01ZSwW1f
	e6ePT1jAgPABjgwiPTZfo022xPHHuj2cwXB4n/CC6Nx7PkARSu6zU1eJNkv6qzd3ueKHNg5Xcci
	59/04Gk08RLTYJNen7Z0j/VzUv6vI3LXQb9qFRlecikIDGqty1HJtMwr/0bXwuA1BIFBYYiNQUn
	KvW/eqLWRayH8O6RGTXE8qVODcYb91vRTX3aINtyHf9E=
X-Google-Smtp-Source: AGHT+IHRI9iiETDRVtqdD39xBQwv1RjeOamaMuERtfBE/vQ6ev9DRcV7Nr1o8ENR0/OvpCMdJE2Nsw==
X-Received: by 2002:a5d:5d0f:0:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3bb68df070emr4717850f8f.44.1755357082758;
        Sat, 16 Aug 2025 08:11:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23323c56sm29179685e9.9.2025.08.16.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:11:22 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next] bpf: add a verbose message when the BTF limit is reached
Date: Sat, 16 Aug 2025 15:15:54 +0000
Message-Id: <20250816151554.902995-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a BPF program which is being loaded reaches the map limit
(MAX_USED_MAPS) or the BTF limit (MAX_USED_BTFS) the -E2BIG is
returned. However, in the former case there is an accompanying
verifier verbose message, and in the latter case there is not.
Add a verbose message to make the behaviour symmetrical.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a3982fe20d4..07cc4a738c67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20193,8 +20193,11 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 		if (env->used_btfs[i].btf == btf)
 			return i;
 
-	if (env->used_btf_cnt >= MAX_USED_BTFS)
+	if (env->used_btf_cnt >= MAX_USED_BTFS) {
+		verbose(env, "The total number of btfs per program has reached the limit of %u\n",
+			MAX_USED_BTFS);
 		return -E2BIG;
+	}
 
 	btf_get(btf);
 
-- 
2.34.1


