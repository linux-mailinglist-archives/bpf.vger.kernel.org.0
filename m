Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A991F2D330
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 03:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE2BOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 21:14:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfE2BOs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 May 2019 21:14:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T1AbO3014498
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KujhMGj4nycZ2YeDKvNOVpoUWFsOgloeTpOHomLnSok=;
 b=qxvHutMAmhz1xHUwrdiApH5IJJPv2Dm2h/M+O4IyBZJf/7wGUnUIIwEgnma4qvl2tj4L
 /NKYoajTqokHQOo5GEI+lM8a3ILC813uUtm81BBFjAkTNRZwpcPQiEqxfsmGsTLd7Ehe
 Jqp0MlJSnD0e6v3Yk8+az4MnL6fnGMBrw0Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ss9209hxb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:47 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 May 2019 18:14:46 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 37CCF8617AA; Tue, 28 May 2019 18:14:45 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 8/9] libbpf: typo and formatting fixes
Date:   Tue, 28 May 2019 18:14:25 -0700
Message-ID: <20190529011426.1328736-9-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529011426.1328736-1-andriin@fb.com>
References: <20190529011426.1328736-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of typo and formatting fixes.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e3bc00933145..9d9c19a1b2fe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -505,7 +505,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 
 	obj->efile.fd = -1;
 	/*
-	 * Caller of this function should also calls
+	 * Caller of this function should also call
 	 * bpf_object__elf_finish() after data collection to return
 	 * obj_buf to user. If not, we should duplicate the buffer to
 	 * avoid user freeing them before elf finish.
@@ -574,8 +574,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		}
 
 		obj->efile.elf = elf_begin(obj->efile.fd,
-				LIBBPF_ELF_C_READ_MMAP,
-				NULL);
+					   LIBBPF_ELF_C_READ_MMAP, NULL);
 	}
 
 	if (!obj->efile.elf) {
@@ -594,9 +593,9 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	ep = &obj->efile.ehdr;
 
 	/* Old LLVM set e_machine to EM_NONE */
-	if ((ep->e_type != ET_REL) || (ep->e_machine && (ep->e_machine != EM_BPF))) {
-		pr_warning("%s is not an eBPF object file\n",
-			obj->path);
+	if (ep->e_type != ET_REL ||
+	    (ep->e_machine && ep->e_machine != EM_BPF)) {
+		pr_warning("%s is not an eBPF object file\n", obj->path);
 		err = -LIBBPF_ERRNO__FORMAT;
 		goto errout;
 	}
@@ -1438,7 +1437,7 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 			}
 
 			if (map_idx >= nr_maps) {
-				pr_warning("bpf relocation: map_idx %d large than %d\n",
+				pr_warning("bpf relocation: map_idx %d larger than %d\n",
 					   (int)map_idx, (int)nr_maps - 1);
 				return -LIBBPF_ERRNO__RELOC;
 			}
@@ -1797,7 +1796,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			}
 		}
 
-		pr_debug("create map %s: fd=%d\n", map->name, *pfd);
+		pr_debug("created map %s: fd=%d\n", map->name, *pfd);
 	}
 
 	return 0;
-- 
2.17.1

