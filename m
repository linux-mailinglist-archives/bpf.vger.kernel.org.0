Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B39165797
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 07:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgBTG0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 01:26:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgBTG0r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Feb 2020 01:26:47 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K6PXxq016992
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 22:26:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IXpJ9hl7vCDT0Qh+irXKQWElg6tkm6FkFFlOMabWx+Q=;
 b=U0xGAFjtJ4SLQf5ynNUKTiCWDjExl7D1KD+SyoTGF1xbZqtfXsDMExFbEvooQaODDMRy
 2RmqK9nlXMccpQztCsN0dzt8KA83EPMo5CZ6Ajwi+rUQNBCPsApbKbjjZ8knmjpo6R8F
 CfRIl2D5ozLtoxuOzoIdTPd3VlYkwHL/oIw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ubtq0f3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 22:26:46 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 22:26:44 -0800
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 391B2862D08; Wed, 19 Feb 2020 22:26:41 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <hex@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: relax check whether BTF is mandatory
Date:   Wed, 19 Feb 2020 22:26:35 -0800
Message-ID: <20200220062635.1497872-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_01:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=8 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BPF program is using BTF-defined maps, BTF is required only for
libbpf itself to process map definitions. If after that BTF fails to
be loaded into kernel (e.g., if it doesn't support BTF at all), this
shouldn't prevent valid BPF program from loading. Existing
retry-without-BTF logic for creating maps will succeed to create such
maps without any problems. So, presence of .maps section shouldn't make
BTF required for kernel. Update the check accordingly.

Validated by ensuring simple BPF program with BTF-defined maps is still
loaded on old kernel without BTF support and map is correctly parsed and
created.

Fixes: abd29c931459 ("libbpf: allow specifying map definitions using BTF")
Reported-by: Julia Kartseva <hex@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514b1a524abb..0eb10b681413 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2280,9 +2280,7 @@ static void bpf_object__sanitize_btf_ext(struct bpf_object *obj)
 
 static bool bpf_object__is_btf_mandatory(const struct bpf_object *obj)
 {
-	return obj->efile.btf_maps_shndx >= 0 ||
-		obj->efile.st_ops_shndx >= 0 ||
-		obj->nr_extern > 0;
+	return obj->efile.st_ops_shndx >= 0 || obj->nr_extern > 0;
 }
 
 static int bpf_object__init_btf(struct bpf_object *obj,
-- 
2.17.1

