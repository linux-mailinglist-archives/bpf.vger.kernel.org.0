Return-Path: <bpf+bounces-18454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A261081A931
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4405B1F23CD1
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8724BAA7;
	Wed, 20 Dec 2023 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uop7geBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675434BAA8
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e840338607so1902447b3.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111233; x=1703716033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNpUUEEGm/sXghb4A1ayJ7iYZn64QQerqvktJXH1aV4=;
        b=Uop7geBsEnIn1YgurDsDHB+7ef10izLOEe3R9cc2YWNS7B/INUNCM6zAQFgouCtv7x
         vg1ydxV0Lp9oDbP4qZcbnYccbPyFzUFrWegwdMOu40oVolI7LRN0g9W1A118bkcFKlqM
         STQxwSf4jgbCDMaDnaOfuKZaY/d4DSqd03LoDCDd8KbS8cI5NlxfZ7sZ4cKdce8Z6K8z
         4wptn6rshgSaviROurg72iL4YyYJ5+joNRZwgedXntOkpfY2YVl8cIvR1xXVqOYgx7WY
         84xDQ5qXW56bhwImqVg7/ntdLyhM97WTT+RIhMdSYc876VTHXskZ5gnbmYwO3Gnpag0Y
         ZXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111233; x=1703716033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNpUUEEGm/sXghb4A1ayJ7iYZn64QQerqvktJXH1aV4=;
        b=c0aHCqBGQu9YV0ng//AGyhI0qAYCUgHy/OTa0wwLky66L4uXKB87ucCDFx9wVnBBz0
         2s6/MsNL1p4+GwCip+imKr+r8C/ssQxlhxJJtVlT+gtdNeTAxfYOrD362JJr9J/Y5wM7
         xyR1Ak/QyPED/zEOU7BlKnarlC2aA5HfB9I93quo5OxPX/4UI+OwKo1Zrz/WEtAXzHMe
         4T7EethJOxL8GN1oib5kJOJM+i7a8XXNQKx0msXNIJY0kyqee25Tdnh7HvFl5xsdV6Pb
         PvuoY1ts+iqFdaQjpIZI++BW579m1pyB7iz5CHkAvBMIE4xvfoVOgRYG2fGg0JEsd/N/
         Cqwg==
X-Gm-Message-State: AOJu0YzaJjt8vjkBq//+veKwwsm9Y6s3fVXLv4uq2YZCaoNI0G2ij9t5
	+e5OC/fIpP21ZdD7L0W3seOkSRum7IE=
X-Google-Smtp-Source: AGHT+IH5Ez/tqxOfiOJVwnPSKnVnz/yts0lIuTt0X8JDBTsr+/wjuV95MC6dlGQ1UhLtTyaVn75Dyw==
X-Received: by 2002:a0d:ca0b:0:b0:5e2:5b5a:c369 with SMTP id m11-20020a0dca0b000000b005e25b5ac369mr391747ywd.29.1703111233064;
        Wed, 20 Dec 2023 14:27:13 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:12 -0800 (PST)
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
Subject: [PATCH bpf-next v15 13/14] bpf: export btf_ctx_access to modules.
Date: Wed, 20 Dec 2023 14:26:53 -0800
Message-Id: <20231220222654.1435895-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220222654.1435895-1-thinker.li@gmail.com>
References: <20231220222654.1435895-1-thinker.li@gmail.com>
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


