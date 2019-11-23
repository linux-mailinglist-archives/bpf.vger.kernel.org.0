Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014F01080AC
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 21:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKWU4c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 15:56:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbfKWU4c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Nov 2019 15:56:32 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xANKrK8j032556
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 12:56:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vSTyDD5gwqiNkYWqQkznUah9pnLCXFXk2PksJunyf7g=;
 b=jPysO3s8Vr87YfvTZy77va1rsPDS9DoojRETKlRPk5CEWXyd5wPRc86gtBAvxGQ9Z55p
 PUiHgnHMoTFnvtDKXDjcZyyn1jwtp2NaRRg7MeVI1gABg63LQAHVOpLPz1JjNmGleW6O
 2nglw4nfi1gsNxgOBdQ5B4ZoRyN7SyIADNs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wf4xw9eyj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 12:56:31 -0800
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 23 Nov 2019 12:56:30 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9E1A42EC1D49; Sat, 23 Nov 2019 12:56:29 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: fail mmap without CONFIG_MMU
Date:   Sat, 23 Nov 2019 12:56:28 -0800
Message-ID: <20191123205628.828920-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_05:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 lowpriorityscore=0 mlxlogscore=641 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911230178
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mmap() support for BPF array depends on vmalloc_user_node_flags, which is
available only on CONFIG_MMU configurations. Fail mmap-able allocations if no
CONFIG_MMU is set.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bb002f15b32a..242a06fbdf18 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -156,8 +156,12 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	}
 	if (mmapable) {
 		BUG_ON(!PAGE_ALIGNED(size));
+#ifndef CONFIG_MMU
+		return NULL;
+#else
 		return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
 					       __GFP_RETRY_MAYFAIL | flags);
+#endif
 	}
 	return __vmalloc_node_flags_caller(size, numa_node,
 					   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
-- 
2.17.1

