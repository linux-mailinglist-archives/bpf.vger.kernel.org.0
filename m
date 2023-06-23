Return-Path: <bpf+bounces-3281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9493373BB61
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED05281C5F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97373AD4F;
	Fri, 23 Jun 2023 15:17:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40BAD41
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 15:17:21 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E1E48;
	Fri, 23 Jun 2023 08:16:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so427084b3a.3;
        Fri, 23 Jun 2023 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687533415; x=1690125415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1o/pL8VifmRkhg9N/fLgEY6Kfl6O6cZ7IhXs/6AQWA=;
        b=f3tdIYRj/Qnjj4wTj6d5h1filcc0g7aVJ1duPxCvWWLV6nk3TzSLMBJAcz05+mwBXd
         EAW9lrn0Z1BQGEYyJnxuhDDhNgwWcEVkQVyjMhoG/NCID9nZGaFO+EiIQqhCwpLWTwIe
         676Dmn/Pfg6VVm5mBQfhYuo1qU+G5aK1bDUrQbSJQdVD19Qhaw/akUXlTrKeeaP/EwvY
         fV5J7jhIRsWF0o3I2U2y2OgGavOTsmLXAmBnuZUd/D1TFfLizibYdTy3q8CLhFk/641S
         7heuiRQv+thHKvQyHO1SUFP+1lKJr0Axr7mhatleBGimkng/1jWk1oYTt6GU4OY/hh3p
         3noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533415; x=1690125415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1o/pL8VifmRkhg9N/fLgEY6Kfl6O6cZ7IhXs/6AQWA=;
        b=VgNxWxMz3PF29jZP1FOgW+CxwIdwc8D+TfLHy+xs/9Vn67YwH9D7IuLl5wd7kIdVSv
         HUimCPev1hyrN26zl5gJYrnYeGCAQkgyFq613VE2GPn8D4jPThFj1WpaVrx1QxsuUF+M
         MrpYsjn15390XM80ck16kB+hHl4UXW9ELTKWu96cRbmnHB2JrRBK1q3exU8ag2njS+Nq
         93AnV2mv7oYG52fQvISjQXo1OwESvnPxV2A4BnEHQzH+lGPLBJhp2jnsrIfq6qGbfYMq
         fdJz1Gqww/4BWZAQn5qApZmBrLoUQMM40L7m8QsuRmDctVwwkgAHhze+IO5gISXxxJjn
         Fg1g==
X-Gm-Message-State: AC+VfDx3n4t4/HBvi+FJ+Bqt97APNHuNbFOVj3NTwDsuYYOs1Cu2UQsE
	zWwrhvn9yexjNQiJQLI2toI=
X-Google-Smtp-Source: ACHHUZ5IRGokayu9WQG701u41H3ifU3+Nlm2eD6n9M7pPACGCw6oF90m6riV8Q7SAviIkxVR8fq1Qg==
X-Received: by 2002:a05:6a21:78a7:b0:10b:e88f:597c with SMTP id bf39-20020a056a2178a700b0010be88f597cmr12054883pzc.44.1687533415380;
        Fri, 23 Jun 2023 08:16:55 -0700 (PDT)
Received: from sumitra.com ([117.199.160.11])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b001b39ffff838sm7431770plb.25.2023.06.23.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:16:54 -0700 (PDT)
Date: Fri, 23 Jun 2023 08:16:44 -0700
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
	Deepak R Varma <drv@mailo.com>,
	Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v4] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <20230623151644.GA434468@sumitra.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
The GFP_KERNEL is typical for kernel-internal allocations.
The caller requires ZONE_NORMAL or a lower zone for direct access.

Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
no need to map it with kmap().

Also, the kmap() is being deprecated in favor of kmap_local_page() [1].

Hence, use a plain page_address() directly.

Since the page passed to the page_address() is not from the highmem
zone, the page_address() function will always return a valid kernel
virtual address and will not return NULL. Hence, remove the check
'if (!ptr)'.

Remove the unused variable 'ptr' and label 'err_free_page'.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

- Link to v1: https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/
- Link to v2: https://lore.kernel.org/all/20230613071756.GA359746@sumitra.com/
- Link to v3: https://lore.kernel.org/all/20230622080729.GA426913@sumitra.com/

Changes in v4:
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306230559.hU5Aonpl-lkp@intel.com/
	- Remove unused label 'err_free_page'.

Changes in v3:
Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
	- Remove the check 'if (!ptr)'.
	- Remove the unused variable 'ptr'.
	- Change the commit message.

Changes in v2:
Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
	- Remove the kmap() call and call page_address() instead.
	- Change the commit subject and message.

 lib/test_bpf.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ade9ac672adb..a5cc5f9fc4e8 100644
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
+		memcpy(page_address(page), test->frag_data, MAX_DATA);
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


