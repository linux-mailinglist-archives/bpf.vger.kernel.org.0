Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53E1403C6
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 07:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAQGIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 01:08:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgAQGIT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jan 2020 01:08:19 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H61b25007485
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=RJoMSeW+6PxNy42HgyDQWPz09EvziKk28klg9Wf/De0=;
 b=R0vVKpl8O4FyB0G3XDLiLIMRk1aIhogfcKGIXl+HGRqUHxJRn7SHEcEdM3jolqDEckit
 2dguJQDLUbRXAVc7vbz/no4B3J6NMkrFLEHNUENaX/o8uZ3gXKTcGJlgVe56hMVyuP09
 2UN2b1f69KZJmy+Tk/HGG2hxzkBtCOjb2V4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0sfsb52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:18 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 22:08:17 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 7E9B82EC1745; Thu, 16 Jan 2020 22:08:10 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/4] libbpf: fix potential multiplication overflow in mmap() size calculation
Date:   Thu, 16 Jan 2020 22:08:00 -0800
Message-ID: <20200117060801.1311525-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117060801.1311525-1-andriin@fb.com>
References: <20200117060801.1311525-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=8 spamscore=0 mlxlogscore=710
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001170047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prevent potential overflow performed in 32-bit integers, before assigning
result to size_t. Reported by LGTM static analysis.

Fixes: eba9c5f498a1 ("libbpf: Refactor global data map initialization")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3b0b88c3377d..fc41c3f2e983 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1283,7 +1283,7 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	long page_sz = sysconf(_SC_PAGE_SIZE);
 	size_t map_sz;
 
-	map_sz = roundup(map->def.value_size, 8) * map->def.max_entries;
+	map_sz = (size_t)roundup(map->def.value_size, 8) * map->def.max_entries;
 	map_sz = roundup(map_sz, page_sz);
 	return map_sz;
 }
-- 
2.17.1

