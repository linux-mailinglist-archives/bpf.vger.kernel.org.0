Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333F4652AD5
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 02:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLUBPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 20:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiLUBPv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 20:15:51 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A5C09
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:15:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671585345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z0+lcomwj/it/3Y7HQ65P1R/9Jh8Tj+AEluAVKDgE3E=;
        b=aqRfiCBPBhbAjlp9KgzWWWgaGNCJV9KWMuHzjJcnjea4tu5p7cELA3S2sVJpYW9XEeHbD/
        GRcYsi7OLubkeY8dodS62C88d1EhL3rpCN3rQE6Fs3Rs1SIy3jUoZDdMwAuAMNUZhjhtgy
        E8kBpm+DEJjikwiEqTUmkGsanVdjj0M=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 bpf-next] bpf: Reduce smap->elem_size
Date:   Tue, 20 Dec 2022 17:15:38 -0800
Message-Id: <20221221011538.3263935-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

'struct bpf_local_storage_elem' has an unused 56 byte padding at the
end due to struct's cache-line alignment requirement. This padding
space is overlapped by storage value contents, so if we use sizeof()
to calculate the total size, we overinflate it by 56 bytes. Use
offsetofend() instead to calculate more exact memory use.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
v2:
  Rephrase the commit message (Andrii and Yonghong)
  Use offsetofend instead of offsetof (Andrii)

 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b39a46e8fb08..e73fc70071b0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -580,8 +580,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size =
-		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+	smap->elem_size = offsetofend(struct bpf_local_storage_elem, sdata) +
+		attr->value_size;
 
 	return smap;
 }
-- 
2.30.2

