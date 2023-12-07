Return-Path: <bpf+bounces-16969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97295807E06
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E6DB211F3
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B84C8E;
	Thu,  7 Dec 2023 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbFIc3HJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C0D65
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:20 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d8e816f77eso1766537b3.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913219; x=1702518019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sjjYs0SoUIMGBIggG2RmbInOgfFHHKp5K529V1i6nE=;
        b=UbFIc3HJIKv0kmG7nwuVayAeBemd3bCuPXnVrXt9igNyzAyIXGJbAjAFut3x0Eta7x
         3yMAeCnjAo70TtCDvj0O/25epwEEh1nm7mvkqiZnTOcXbwANDFEG5u9xOC9VYuPCOYOI
         4KO2fHGOUGbRgoddjotkQDLpqNhXJ3eDTqjeiunfLWdUe5b6R5L6rV5MsYawwJVeys/H
         vndwuEX4Gqaw3uOcivxD7s3EBG9lqovRKwCBhsZHVge8Z3TAYRqhrEUj1tInolwXH54H
         f+eIIa1kZEbgsEmfMLAY8FObFDbrCdJewD5HwLjzfpEmieNleCaPHzucMoWjxF6KOgoJ
         Jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913219; x=1702518019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sjjYs0SoUIMGBIggG2RmbInOgfFHHKp5K529V1i6nE=;
        b=MHgxM2t1zcoRLI52tw3bAwCfyHWuB7lCneP1kedW2W8JOMiNbc/1aXjw8nTFLDjq5N
         Q6LUSCvw/WGKoxwaQdQQKC3qbFLkHaYYm9TvPSv43FTeQSf0kto41I3r2xlZdzJS23h8
         SL19NffhXmPdFZEZKPXZ8Owcia7VMI9cAzuRxrOYlhzfFKi0YB/nv6xtWq6sBsKdrZTL
         wMkq/zwrwHUh5yOK8sQbP+gqh9Lcq3D82Psz8R4Vnsx7zE/S0STVCiBfgOvRMah9Rd5n
         KKvQ0EGa2jv2WI+eSX/JEZxnSOQbvMJBmukEsR4KelX7zG83kToPe7eXrdhSr8x+x80t
         H+aw==
X-Gm-Message-State: AOJu0YwMLeiYlb7sv4HyMf27jajt6tarzyx5mmSbKddn45J1BDoWZaEn
	+iMDn1XVtZ1bDMqu8cCRPMyNEjZSbKk=
X-Google-Smtp-Source: AGHT+IEw4AplwopDBeMMomwhkPSkd3WQTwP/9mJMPJ6E65N4JOQsKlSNNPDpqiGt+SbeFllOxBcc6g==
X-Received: by 2002:a05:690c:fc9:b0:5d4:fc0:79f3 with SMTP id dg9-20020a05690c0fc900b005d40fc079f3mr2028058ywb.23.1701913219286;
        Wed, 06 Dec 2023 17:40:19 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:18 -0800 (PST)
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
Subject: [PATCH bpf-next v12 12/14] bpf: export btf_ctx_access to modules.
Date: Wed,  6 Dec 2023 17:39:48 -0800
Message-Id: <20231207013950.1689269-13-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
index 5545dee3ff54..d9cdf41e8f34 100644
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


