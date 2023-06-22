Return-Path: <bpf+bounces-3113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04667739886
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8996281809
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C6C8CF;
	Thu, 22 Jun 2023 07:53:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244863A4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 07:53:11 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163F1FC3;
	Thu, 22 Jun 2023 00:52:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25e9e5f9e0cso3901892a91.0;
        Thu, 22 Jun 2023 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687420372; x=1690012372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zvHJttdtiCO46p+k5M+Fw9sy+2nAJFqu/9noB7Z5VY=;
        b=A/8+Y5aZUmT/FJHf7VZQZDImXfjS8v2Xesr4SFZO5W0RMcwQADwQFJpnrfVOTItlI6
         Jso3SwSF8TJlzVGc2hTa+T4X3VWy9PrJnyGZTFbEE2kJS6Pk49gQPO0BrUHRlquxOe8x
         roalo8anv5CtyBrHvDV3dmWi2yLM2w2NZAfE+LeeqvHRJVfdwydCKHM5/rw/Q2RNOr8X
         EGvkZg16WCU/ISbmAH4PQlIGgSkvR2S9rJvGYN1HcWIoUSt3rGwKwt8CfyptOqwlH8gE
         +NCwv+E2ZP8AdF6KpfiZDdYvd2FlGmGBBypIMHnhTZuug4U5fB6KrtsqDEBhZWbqrpM8
         m51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420372; x=1690012372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zvHJttdtiCO46p+k5M+Fw9sy+2nAJFqu/9noB7Z5VY=;
        b=V3C6F0NUkpdCzZyljFV87mb8rJVvmMOnp8/YYtIoceIhNL6z4bFfaL+JmXlbRfCFQx
         sIKENMqFUeQA+GU24aW4x2Tbqi+6w+4/1sTBBWy4dyPTP7i96BoqsKx7Yo1cwDXyr3ep
         1I7SjYTpyRWn07Qe2VAQX/6Ul25m5NSER+EWtnu2nQRncJGlrgkJkkdpq3rK9CoBmiFU
         7gmG0pNR8BaAfQSBrNx6wc5YnSpKDzmITUhBRrSpnAPQY92KxOkRha+s2qAUL9VWTUT1
         QddtWhd2QyXjIL6x0RtUrTqUn+pkSVKN1NZmUCG7r8cc/eBGTNk/XyvvKgo5/Y+Fj/hQ
         KJzw==
X-Gm-Message-State: AC+VfDx0iAvqs4jW9DU+QExVJzUWN4LiMFttRuJRaImlELlZ5OEPPFEf
	2nlo4T1ekoeVLzjNgypC6p0=
X-Google-Smtp-Source: ACHHUZ5Cq7hLqb63EB0zYMu1LZxRizxqR3fW77sTUixr6RNC/ul4FXs68NMHfkfeOXiaYm8tHf1S8Q==
X-Received: by 2002:a17:90a:c7cd:b0:25b:e081:54e6 with SMTP id gf13-20020a17090ac7cd00b0025be08154e6mr14006745pjb.37.1687420372288;
        Thu, 22 Jun 2023 00:52:52 -0700 (PDT)
Received: from sumitra.com ([59.89.167.84])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090b078200b00259b53dccddsm4281769pjz.34.2023.06.22.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:52:51 -0700 (PDT)
Date: Thu, 22 Jun 2023 00:52:44 -0700
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
Subject: [PATCH v3] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <20230622075244.GA426694@sumitra.com>
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

Also, the kmap() is being deprecated in favor of
kmap_local_page() [1].

Hence, use a plain page_address() directly.

Since the page passed to the page_address() is not from the highmem
zone, the page_address() function will always return a valid kernel
virtual address and will not return NULL. Hence, remove the check
'if (!ptr)'.

Remove the unused variable 'ptr'.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny
@intel.com/

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

- Link to v1: https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/
- Link to v2: https://lore.kernel.org/lkml/3564297.R56niFO833@suse/T/

Changes in v3:
Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
	- Remove the check 'if (!ptr)'.
	- Remove the unused variable 'ptr'.
	- Change the commit message.

Changes in v2:
Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
	- Remove the kmap() call and call page_address() instead.
	- Change the commit subject and message.


 lib/test_bpf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ade9ac672adb..448bc1b0b8b5 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14381,18 +14381,12 @@ static void *generate_test_data(struct bpf_test *test, int sub)
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
 
-- 
2.25.1


