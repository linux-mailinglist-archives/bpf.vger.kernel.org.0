Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8C60C87A
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiJYJhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiJYJgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 05:36:33 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 02:35:37 PDT
Received: from mx.der-flo.net (mx.der-flo.net [IPv6:2001:67c:26f4:224::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2101057C2
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 02:35:36 -0700 (PDT)
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 34C85160A5A; Tue, 25 Oct 2022 11:29:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from localhost (unknown [IPv6:2a02:1210:22e1:1f00:fb89:69cb:433e:eb56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 131FA160A47;
        Tue, 25 Oct 2022 11:29:09 +0200 (CEST)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: Update max_entries for array maps
Date:   Tue, 25 Oct 2022 11:28:43 +0200
Message-Id: <20221025092843.81572-1-dev@der-flo.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To improve memory handling and alignment max_entries is rounded up
before using its value to allocate memory.
This can lead to a situation where more memory is allocated than usable
if max_entries is no adjusted accordingly. So this change updates
max_entries in order to make the allocated memory available.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/arraymap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 832b2659e96e..9411fa255ccc 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -145,6 +145,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
 	array->elem_size = elem_size;
+	array->map.max_entries = max_entries;
 
 	if (percpu && bpf_array_alloc_percpu(array)) {
 		bpf_map_area_free(array);
-- 
2.37.3

