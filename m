Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D528AD3877
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJKE3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 00:29:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbfJKE3o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Oct 2019 00:29:44 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9B4TQMZ019186
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 21:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=EgOqgrQAbyppIvN4MndunnpAUTFB9Ecgr6cW5nMK22E=;
 b=N9KYSOZINiLy5IVYV4Oozf2HgI8e7qR+/9Kj6rMg6avXYUN21TbR93OSUFRu9JaKlrZd
 zN+Aw2R5GFXm/N2j3LrrFjxf68zR4oNNsVJFUlB8Hr/a2XqchoN8txH1iwCKRKlv9V4t
 FDaOdZCBR9KGZlwu/ByK0y0GPqcLLCzyqtg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vjekprxdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 21:29:42 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 10 Oct 2019 21:29:41 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 19C66861907; Thu, 10 Oct 2019 21:29:41 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: fix cast to pointer from integer of different size warning
Date:   Thu, 10 Oct 2019 21:29:25 -0700
Message-ID: <20191011042925.731290-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_02:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=857 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110040
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix "warning: cast to pointer from integer of different size" when
casting u64 addr to void *.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b818fed3208d..d3446f018b9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2753,7 +2753,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val)
 	err = map->ops->map_direct_value_addr(map, &addr, off);
 	if (err)
 		return err;
-	ptr = (void *)addr + off;
+	ptr = (void *)(long)addr + off;
 
 	switch (size) {
 	case sizeof(u8):
-- 
2.17.1

