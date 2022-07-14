Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD8575720
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiGNVnT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jul 2022 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiGNVnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:43:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48796EEB6
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:17 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26ELZgHs007525
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hamy3k3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:16 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 14:43:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CD3F01C583BCA; Thu, 14 Jul 2022 14:43:13 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] bpf: remove obsolete KMALLOC_MAX_SIZE restriction on array map value size
Date:   Thu, 14 Jul 2022 14:43:04 -0700
Message-ID: <20220714214305.3189551-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714214305.3189551-1-andrii@kernel.org>
References: <20220714214305.3189551-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pEJ4Kh3w_8niZpchYajM8NiM8ozmDCuJ
X-Proofpoint-ORIG-GUID: pEJ4Kh3w_8niZpchYajM8NiM8ozmDCuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
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
index af6b1b528239..ef3d9ec510a5 100644
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

