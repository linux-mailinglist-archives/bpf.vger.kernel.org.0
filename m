Return-Path: <bpf+bounces-13284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E97D7824
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902F8B212E6
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127228693;
	Wed, 25 Oct 2023 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHxEthc7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E20125DC;
	Wed, 25 Oct 2023 22:41:57 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C7CC;
	Wed, 25 Oct 2023 15:41:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7a80a96dbso12706127b3.0;
        Wed, 25 Oct 2023 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698273715; x=1698878515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6TpQRy2A+ysOT1SNmKEivbC5vkNQz1BOTcdobs1VUs=;
        b=SHxEthc74ozKUW+ldZ5VARMUux8GK9XQ+yUDxN7El1BwIayY0feY0S5lmsbeRqMwop
         HkKnSDcfwTk3gv2U40nEu3JYmm5VfTePraFCZk6xXRyqXDVcj98xMH+UANDzvfg89Q7C
         CYdRfQP7eHLWHkZDLod5Ky7Tdn9MSHq5H/wVtHrm4ma+kekK/J+kA9qm8o6grh0dRLKg
         +hIeumMxGPtUqaBXP4eQQpzFPiRF9yZRk6eFk1rNMJN3N4qqcqucvjZ/qT+UhQ/f5XPH
         mF1iE910yp4G1Kn7vhI+e7LPRJJE1mRtifwNOscCcODfflDKV1FdRjzK4uXqUojqjUd1
         lSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698273715; x=1698878515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6TpQRy2A+ysOT1SNmKEivbC5vkNQz1BOTcdobs1VUs=;
        b=EogCD2lwd2DGuprasi0zSeim9ZGUBmWrOZXxtavHrpqUGupmmFchvsxSdLVLYCZj5p
         NF63zrSfwMTSvwb95dPpEJZku7WCgEtelyGNJXRBR4/qK/8Pf+hgANiFIa+OwaoxMV3E
         0qELlwnZYMOapnL2M23pNGKGjGoDeJ8HRocEdmptxBEH76na9+c+aoVEwFzt1rKLRLyE
         hSOMa4KmBF8hXoOj4LOZTkhtHWNFrJD2xM4sfwLA0pBX9fIaid79UzK3+7X387CWmFNV
         AvBOkLLN6NAih4SQlTAlfrPEA7kcFRv262GfYWNLGSjV3QoeitKffxAU1TeDQx6ISQR/
         bCiw==
X-Gm-Message-State: AOJu0YzNUvHVAUwNlzGNgqUwMOW9r8EVHAZtjJq8umm0TZ9Edj0/9eHI
	tcY7WFU7BoFgAO1wRe7wF/ledIIRFhM=
X-Google-Smtp-Source: AGHT+IFieZai65RoqXTA924HdRVyaH05ilAYCnu1Y8diumA/+Km+LIlUWvXpe8tRENlXFsa8sWINCw==
X-Received: by 2002:a81:eb04:0:b0:5a7:a896:3f54 with SMTP id n4-20020a81eb04000000b005a7a8963f54mr1389396ywm.26.1698273715025;
        Wed, 25 Oct 2023 15:41:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1545:3e11:ea38:83fe])
        by smtp.gmail.com with ESMTPSA id e126-20020a816984000000b00592236855cesm5385526ywc.61.2023.10.25.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:41:54 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	netdev@vger.kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] bpf, net: Use bpf mem allocator for sk local storage
Date: Wed, 25 Oct 2023 15:41:51 -0700
Message-Id: <20231025224151.385719-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Switching to BPF memory allocator improve the performance
of sk local storage in terms of creating and destroying.

Here is numbers w/ and w/o this changes.

 - ./bench local-storage-create --storage-type=socket
   - w/ change
     - creates  552.474 ± 1.186k/s (552.474k/prod), 2.10 kmallocs/create
   - w/o change
     - creates  469.960 ± 2.501k/s (469.960k/prod), 4.18 kmallocs/create
 - ./bench -p 4 local-storage-create --storage-type=socket
   - w/ change
     - creates 1236.614 ± 2.833k/s (309.153k/prod), 2.09 kmallocs/create
   - w/o change
     - creates 1120.524 ± 1.527k/s (280.131k/prod), 4.16 kmallocs/create
 - ./bench -p 4 local-storage-create --storage-type=socket \
      --batch-size=1024
   - w/ change
     - creates 1416.437 ± 37.679k/s (354.109k/prod), 2.06 kmallocs/create
   - w/o change
     - creates 1302.636 ± 13.649k/s (325.659k/prod), 4.12 kmallocs/create

Overall, with bpf memory allocator, it improves
 - 17% for single thread and with batch size 32,
 - 10% for 4 threads and with batch size 32, and
 - 8% for 4 threads and with batch size 1024.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/core/bpf_sk_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index cca7594be92e..fdd9ad15cfe9 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -68,7 +68,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &sk_cache, false);
+	return bpf_local_storage_map_alloc(attr, &sk_cache, true);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
-- 
2.34.1


