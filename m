Return-Path: <bpf+bounces-2380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4372BF26
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E5028117D
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18795AD3C;
	Mon, 12 Jun 2023 10:34:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D1134DE
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 10:34:16 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4849E1;
	Mon, 12 Jun 2023 03:33:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-544c0d768b9so2823150a12.0;
        Mon, 12 Jun 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686566029; x=1689158029;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfpZtHxfMfNOA+nAShm6Lv54zYUDy4unPqc7jTzW5IY=;
        b=g5MQrV06tGnu5T49c+fqlRVbz+4vl6lTs+B5PSv26UDs8SmwuUjbtgpYvi4XYvsfXs
         g3Wc2jiZquREb5ZwSnwRH1DOO0gSmxP4ZhQb3LUz6RactKq1Qh1tXR07KR1JZ3n9uWCT
         OmsqK5utFoC85oyQFK3hSzIZZeudEFukchwPhsPYdiKrxiULBo149J62DCxM9rqD41OP
         2n7nwRHR5sp/jW8AFmWtySZQaZxDatBrFk8cg247NVR8wSaZAu6PlfoyvC/ViMgBDKkk
         RAaGZwoamqew0CIJp9D6bhGrbvVd7HtX1+WQ2KrieFtv7QreWGEkuOXnHV8eTeMGwGfH
         vGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686566029; x=1689158029;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfpZtHxfMfNOA+nAShm6Lv54zYUDy4unPqc7jTzW5IY=;
        b=klHY3KT7nsVYH+OCPVC1Ij0lO+Bvv+rJHOh+YuF14SskOsX9HrNW/NMZiwes24SjGO
         2RgE3n2OleroGM4C7yxbey27X/cd0nJS+NtAsi+ar5xh01uT3MuVCF9xk3e0JMGDEyXD
         sTtTwmff0CCWfFaLLCMh120PeNZ7HXea7p8457JA12Qp4xJOpNKg6HjAs4fXfSt4Ev1o
         PDBtQNlMRbb0CdkB3X3X7fjVcC7+g7xTUVRUeCTMoi4igQPn0RKKKp+NTH7PthHONQRQ
         uTbhLzycgfnQVkhJYSKuQJewy35+m/JN33vC7yd4y5Hwx7W7PhwJdCUiglBOcm/X72ME
         W08A==
X-Gm-Message-State: AC+VfDwhdoGDcY6xVuGWRbCxVgYzbfLdXlJ1fv/DlCsLnfJR/O2uPu9o
	iJI7toM3BuFOZDzfzyg4XIo=
X-Google-Smtp-Source: ACHHUZ7KCgzwwzt/+U5B3rtE7WuKTwMKF7qrktbVjO71FDDyDZXzkAmBeySxeqnVrqprjbrMQuTzgQ==
X-Received: by 2002:a17:902:8d8a:b0:1b1:9d14:1537 with SMTP id v10-20020a1709028d8a00b001b19d141537mr5845271plo.55.1686566029363;
        Mon, 12 Jun 2023 03:33:49 -0700 (PDT)
Received: from sumitra.com ([117.212.94.125])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902968300b001b0266579ebsm7866299plp.194.2023.06.12.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:33:48 -0700 (PDT)
Date: Mon, 12 Jun 2023 03:33:41 -0700
From: Sumitra Sharma <sumitraartsy@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
	Deepak R Varma <drv@mailo.com>
Subject: [PATCH] lib/test_bpf: Replace kmap() with kmap_local_page()
Message-ID: <20230612103341.GA354790@sumitra.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kmap() has been deprecated in favor of the kmap_local_page()
due to high cost, restricted mapping space, the overhead of
a global lock for synchronization, and making the process
sleep in the absence of free slots.

kmap_local_page() is faster than kmap() and offers thread-local
and CPU-local mappings, take pagefaults in a local kmap region
and preserves preemption by saving the mappings of outgoing
tasks and restoring those of the incoming one during a context
switch.

The mapping is kept thread local in the function
“generate_test_data” in test_bpf.c

Therefore, replace kmap() with kmap_local_page() and use
memcpy_to_page() to avoid open coding kmap_local_page()
+ memcpy() + kunmap_local().

Remove the unused variable “ptr”.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 lib/test_bpf.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ade9ac672adb..3bb94727d83b 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14381,25 +14381,17 @@ static void *generate_test_data(struct bpf_test *test, int sub)
 		 * single fragment to the skb, filled with
 		 * test->frag_data.
 		 */
-		void *ptr;
-
 		page = alloc_page(GFP_KERNEL);
 
 		if (!page)
 			goto err_kfree_skb;
 
-		ptr = kmap(page);
-		if (!ptr)
-			goto err_free_page;
-		memcpy(ptr, test->frag_data, MAX_DATA);
-		kunmap(page);
+		memcpy_to_page(page, 0, test->frag_data, MAX_DATA);
 		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
 	}
 
 	return skb;
 
-err_free_page:
-	__free_page(page);
 err_kfree_skb:
 	kfree_skb(skb);
 	return NULL;
-- 
2.25.1


