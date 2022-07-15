Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F57575B00
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGOFb7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOFb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:31:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B879EE5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcgk9007395
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5g87qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:57 -0700
Received: from twshared18443.03.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 22:31:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 82F431C5C58FA; Thu, 14 Jul 2022 22:31:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: remove obsolete KMALLOC_MAX_SIZE restriction on array map value size
Date:   Thu, 14 Jul 2022 22:31:45 -0700
Message-ID: <20220715053146.1291891-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220715053146.1291891-1-andrii@kernel.org>
References: <20220715053146.1291891-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tFwGuHqusi8-MTsezSbbdc6ccUP92UOO
X-Proofpoint-ORIG-GUID: tFwGuHqusi8-MTsezSbbdc6ccUP92UOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syscall-side map_lookup_elem() and map_update_elem() used to use
kmalloc() to allocate temporary buffers of value_size, so
KMALLOC_MAX_SIZE limit on value_size made sense to prevent creation of
array map that won't be accessible through syscall interface.

But this limitation since has been lifted by relying on kvmalloc() in
syscall handling code. So remove KMALLOC_MAX_SIZE, which among other
things means that it's possible to have BPF global variable sections
(.bss, .data, .rodata) bigger than 8MB now. Keep the sanity check to
prevent trivial overflows like round_up(map->value_size, 8) and restrict
value size to <= INT_MAX (2GB).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 98ee09155151..d3e734bf8056 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -70,10 +70,8 @@ int array_map_alloc_check(union bpf_attr *attr)
 	    attr->map_flags & BPF_F_PRESERVE_ELEMS)
 		return -EINVAL;
 
-	if (attr->value_size > KMALLOC_MAX_SIZE)
-		/* if value_size is bigger, the user space won't be able to
-		 * access the elements.
-		 */
+	/* avoid overflow on round_up(map->value_size) */
+	if (attr->value_size > INT_MAX)
 		return -E2BIG;
 
 	return 0;
-- 
2.30.2

