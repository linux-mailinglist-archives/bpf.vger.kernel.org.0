Return-Path: <bpf+bounces-3118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA227398FE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424231C21058
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88B15ACA;
	Thu, 22 Jun 2023 08:07:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A7134B4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:07:38 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44810DB;
	Thu, 22 Jun 2023 01:07:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b4f9583404so52231565ad.2;
        Thu, 22 Jun 2023 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421256; x=1690013256;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bE3N/UI7ZUwen2f+LeNQb5BD3FLwzMmTY3rL27DjvE=;
        b=i+FNykShYH4jFcW3TH3D6qVUD8GYa2TuyJft85fNgUu4Qv5JIjyoCffqwumCHJM3Rm
         qxuRBkLfEz6K0utBAqS1fz4aoYBwWcq3EpGnxHDQOR0k5Rn5DvnQzs1BJgGSoinQkbDI
         Oge474VnLaBQGLIqOLpUTMjDwVkOgp33iyWlWQGtE+ob++mffNYlsyX+1YWmOYb6et7j
         aDy1bxcxBcvcGRJK9dEzghG63fP6LDku7+LTjM0mlUk6JAPtZup6fAGd6nRN7aSmlcq8
         D5NuaOmrwkbdir/AuCyzqLQlAetqlLAe6W/NKl0S65ZkKqbmAppOsReU1zCW0csNWj/C
         y2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421256; x=1690013256;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bE3N/UI7ZUwen2f+LeNQb5BD3FLwzMmTY3rL27DjvE=;
        b=C/DxyEscEl41ak5WSJpfxXGu/+Aw3rA3G8INSjrGxJxVx4PmZqkVUpesaW38HBI/9w
         Os35sst/zoosDdTtNXDoLhlU/ly/C6a1dnk6h/3sCEVGNMwAQ5w6/wm1uQLysTCi7/a9
         CC7hb70UZiV7qIHhS+9L+K07z8zD9n4Uw7Ap/kl7vO7fJ3t7o7aerwzp6IURr5v2lEbT
         rqh2vu302oC8NvUp1iQjKkYCDiZPhCllgWhYyqszYtDTTSC1ynuwMJxnB+byQTbMkRgG
         Re05D1rLVJPnsWXXFWVlIl4GnboQFBLF9dPbkRa9UQ1Ibe4Hp4Y/Y/qJbJLc75wB04+7
         ZmKw==
X-Gm-Message-State: AC+VfDykanw2wHeU+ceDAcQz4u5BWlBlniFlFPc6B3xlgfOzMfMEfmWH
	1vYGMRI4jsFeqx2Yp98g2OM=
X-Google-Smtp-Source: ACHHUZ4z8GVwnVb3URT4P5uVyCV/p8NXmq2tUChLjyJVdkL2sTYs+bNGDyA7P2txMeYBuoTeJKUdfw==
X-Received: by 2002:a17:903:18a:b0:1b0:1095:f4f6 with SMTP id z10-20020a170903018a00b001b01095f4f6mr21510085plg.24.1687421256536;
        Thu, 22 Jun 2023 01:07:36 -0700 (PDT)
Received: from sumitra.com ([59.89.167.84])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001b51b3e84cesm4760568plg.166.2023.06.22.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:07:36 -0700 (PDT)
Date: Thu, 22 Jun 2023 01:07:29 -0700
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
Message-ID: <20230622080729.GA426913@sumitra.com>
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

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

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


