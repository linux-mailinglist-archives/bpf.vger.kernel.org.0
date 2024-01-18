Return-Path: <bpf+bounces-19786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731E831117
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92521F216DE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960EA934;
	Thu, 18 Jan 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiikFk1m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957119455
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542607; cv=none; b=fRhXT2l/ZTgDy5/5hSu7/7g7uK2iErjsXFBIwkBDOSleYMauXV2a0GxDYUWJMmR5IPqK/rnZrVO/XbcxYXbckIZUW0AbDrJtTggCVsBblXUvbVvQTegBpS+mCcWN8uupVz/KbP5TlrfGoo/OnExTDIsmHiXcrW+hWdTNTGX57NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542607; c=relaxed/simple;
	bh=qV/bNE7mVSdiBN51PE1Eq8GIQzmn+HJcIEvE8ef2rCI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=YDx5PCSoqPaR5dmX6D0tzEvkZIiLsu2RIjvS+DVrnc2Pkc2I3xZwho4wiWCvGKX8hi/7y8uDF1oI6BeZ9rcY9CflpEbwCJzQt8qmt1wldPZ52ikczwQy7cnl4FelOHdME2ijuUaR6l20kBWS151sMYjHBsG63t93giMsabKbmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiikFk1m; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f2aab1c0c5so2503707b3.0
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542605; x=1706147405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNpUUEEGm/sXghb4A1ayJ7iYZn64QQerqvktJXH1aV4=;
        b=iiikFk1mvzJ+XOMic7cFgBQ+CA6uV0gsCOMI/giNPkxt/Ki3xyYMs7AyX6zkXs47FL
         B909oD9CAzChtHrgfhDJhKzMK/yR7eMNNGITj30q5urKnWrCgjlZK3sK8h3CyrqDGglk
         mq1h4sOcmC+QjB5K3hXaWhurYIHaCocOPTnz/fAURE1eoAxfqMG1GrywDWRQ0V8mr/qZ
         V+8WYYfTiPCpybQSPVposJQ7atCNNZnnrc4syKBR98nrorkkTaQ7mwA4Iz1ma3bvipcZ
         /U+eTAcHzO3/ScYc2CclhwAVKmCQOFeDPFFjEBu6oNqV9jLZJfyFkQjKo61iZyUR2xDx
         8ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542605; x=1706147405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNpUUEEGm/sXghb4A1ayJ7iYZn64QQerqvktJXH1aV4=;
        b=cezoiPjGIETp4UZcDv/NCOGgPLtlMtV9IQoFPNTZIibSAOPNcw+GvBJNVEcgvtDXjJ
         4Lz2CKaWlZ9eRmKdqlxazifJAwhmKVFJ01Oxl9kIeHi6PADWx/KIUSV3FmD64emzcchN
         pJrZaFQQO06aIH389z/B7mBI8gh++K9AMQmV5BGHQeFPVWFhI8sCe9URBvWnkMQ5e4r2
         7Qr5+pcb6Xmol8ju5RQ8JaUUUghTyozx2aKcFkms7uLbAZ73a4wIewZkWOiNkirw5MMZ
         tbH4MJynFLnAQES8CVqV7X/JNGHQxyaZm9YqYmvT2OUICb6fVwuAoPy/0rMUCmsUA0AM
         74XQ==
X-Gm-Message-State: AOJu0YzTLeJEp4ngMbXv6AwOeaJpzxf04EolYQRSXmm2P1SVniTdd5a2
	Ox6EBKzYyrmiw5YP0y+n2ruE/9cL4lo212ttsWw+2IHLGmD60SBprVKO+jRL
X-Google-Smtp-Source: AGHT+IHB3WKAaZWTBpu0GJwwsL74OgeLMurOT+GB4rA4ejsgzUBBk74FimJplB0lV8f3p7EK2JbrLw==
X-Received: by 2002:a0d:d843:0:b0:5ff:88b6:8775 with SMTP id a64-20020a0dd843000000b005ff88b68775mr88644ywe.44.1705542605234;
        Wed, 17 Jan 2024 17:50:05 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:50:04 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v16 13/14] bpf: export btf_ctx_access to modules.
Date: Wed, 17 Jan 2024 17:49:29 -0800
Message-Id: <20240118014930.1992551-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 860b2946de3c..81db591b4a22 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6142,6 +6142,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


