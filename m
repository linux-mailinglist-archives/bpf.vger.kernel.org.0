Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C27148F39
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392066AbgAXUTI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 15:19:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387535AbgAXUTH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 15:19:07 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00OKJ5An015443
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 12:19:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=0md6ZpKHsYxQIdHh5seR7GQxOsXFrOjGlHCjyjawdjU=;
 b=OYZYp7amGlevSJ+fFCHj5WXfDfEBnKJE185RD/GlJJvDAJ5Xx6HZe6Xs5bqTrvzh2aUh
 TexfwUcMHVoGf1ltC0Tudgsf1ANTlzvsle3E3bI2ANhifqUsCg4gzUCQA6NskrvQw4ku
 fwWPFYqywvXY3JB0J6HSMVZArOdMheE8RUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xr63a8dtr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 12:19:06 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 12:18:54 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 21A792EC1AD1; Fri, 24 Jan 2020 12:18:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <williampsmith@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: fix realloc usage in bpf_core_find_cands
Date:   Fri, 24 Jan 2020 12:18:46 -0800
Message-ID: <20200124201847.212528-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_06:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=8 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=755
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001240167
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix bug requesting invalid size of reallocated array when constructing CO-RE
relocation candidate list. This can cause problems if there are many potential
candidates and a very fine-grained memory allocator bucket sizes are used.

Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
Reported-by: William Smith <williampsmith@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae34b681ae82..b581cb52ee5c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3870,7 +3870,9 @@ static struct ids_vec *bpf_core_find_cands(const struct btf *local_btf,
 		if (strncmp(local_name, targ_name, local_essent_len) == 0) {
 			pr_debug("[%d] %s: found candidate [%d] %s\n",
 				 local_type_id, local_name, i, targ_name);
-			new_ids = realloc(cand_ids->data, cand_ids->len + 1);
+			new_ids = reallocarray(cand_ids->data,
+					       cand_ids->len + 1,
+					       sizeof(*cand_ids->data));
 			if (!new_ids) {
 				err = -ENOMEM;
 				goto err_out;
-- 
2.17.1

