Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020F864F517
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 00:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiLPXaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 18:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiLPXaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 18:30:02 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A167D8C
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 15:29:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671233398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ve0I986q1cYOI6K9oQnN/e153zhBn0Lvql97uWVxwc8=;
        b=nWkyVvT9CsAloouLTow0BHp0xaAJ2P0IcQNLDpI8eTXocgTdbP5+66qprClwYVUJhR3ZSt
        BEVWkv/4+5f+F1YkkLVOFndRGoDchseZHI23ot0WW2NDAjcqwtWVNnPuzZvo8fsHtoO4s1
        TIxhqnBn0TdCLwzYZna68Frg3EzLvXs=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Reduce smap->elem_size
Date:   Fri, 16 Dec 2022 15:29:51 -0800
Message-Id: <20221216232951.3575596-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

'struct bpf_local_storage_elem' has a 56 bytes padding at the end
which can be used for attr->value_size.  The current smap->elem_size
calculation is unnecessarily inflated by 56 bytes.

The patch is to fix it by calculating the smap->elem_size
with offsetof().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b39a46e8fb08..cb43e70613b1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -580,8 +580,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size =
-		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+	smap->elem_size = offsetof(struct bpf_local_storage_elem, sdata) +
+		offsetof(struct bpf_local_storage_data, data[attr->value_size]);
 
 	return smap;
 }
-- 
2.30.2

