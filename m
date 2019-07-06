Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8EE61294
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2019 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGFSGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Jul 2019 14:06:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbfGFSGg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Jul 2019 14:06:36 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x66I2t1v032765
        for <bpf@vger.kernel.org>; Sat, 6 Jul 2019 11:06:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=XUnnOq+sSxxU+8Hc3cCbfXM0n6EKulwyWas5DKUPMxE=;
 b=daBvstdI/KlSALTEtBub8kgTI5tZMsbbmTRuLtms5NXjEJaadIf9HHIMyg5yCLHfiEXm
 JHVn+eit6qdiR7f2Hrx03EfFyBl1WvQvlB1dkD0WaL7Lc90TEn6ZPVtwi5GMYHv7sq4F
 vCXlRdCIPzJcWqgZvSmzywY281mXj0XdReI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2tjqf2sb8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Jul 2019 11:06:34 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 6 Jul 2019 11:06:33 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id ECC1386170E; Sat,  6 Jul 2019 11:06:32 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 bpf-next 2/5] libbpf: auto-set PERF_EVENT_ARRAY size to number of CPUs
Date:   Sat, 6 Jul 2019 11:06:25 -0700
Message-ID: <20190706180628.3919653-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190706180628.3919653-1-andriin@fb.com>
References: <20190706180628.3919653-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907060240
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For BPF_MAP_TYPE_PERF_EVENT_ARRAY typically correct size is number of
possible CPUs. This is impossible to specify at compilation time. This
change adds automatic setting of PERF_EVENT_ARRAY size to number of
system CPUs, unless non-zero size is specified explicitly. This allows
to adjust size for advanced specific cases, while providing convenient
and logical defaults.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae569b50e2e0..ed07789b3e62 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2116,6 +2116,7 @@ static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
 	struct bpf_create_map_attr create_attr = {};
+	int nr_cpus = 0;
 	unsigned int i;
 	int err;
 
@@ -2138,7 +2139,22 @@ bpf_object__create_maps(struct bpf_object *obj)
 		create_attr.map_flags = def->map_flags;
 		create_attr.key_size = def->key_size;
 		create_attr.value_size = def->value_size;
-		create_attr.max_entries = def->max_entries;
+		if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+		    !def->max_entries) {
+			if (!nr_cpus)
+				nr_cpus = libbpf_num_possible_cpus();
+			if (nr_cpus < 0) {
+				pr_warning("failed to determine number of system CPUs: %d\n",
+					   nr_cpus);
+				err = nr_cpus;
+				goto err_out;
+			}
+			pr_debug("map '%s': setting size to %d\n",
+				 map->name, nr_cpus);
+			create_attr.max_entries = nr_cpus;
+		} else {
+			create_attr.max_entries = def->max_entries;
+		}
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -2155,9 +2171,10 @@ bpf_object__create_maps(struct bpf_object *obj)
 		*pfd = bpf_create_map_xattr(&create_attr);
 		if (*pfd < 0 && (create_attr.btf_key_type_id ||
 				 create_attr.btf_value_type_id)) {
-			cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+			err = -errno;
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-				   map->name, cp, errno);
+				   map->name, cp, err);
 			create_attr.btf_fd = 0;
 			create_attr.btf_key_type_id = 0;
 			create_attr.btf_value_type_id = 0;
@@ -2169,11 +2186,11 @@ bpf_object__create_maps(struct bpf_object *obj)
 		if (*pfd < 0) {
 			size_t j;
 
-			err = *pfd;
+			err = -errno;
 err_out:
-			cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-			pr_warning("failed to create map (name: '%s'): %s\n",
-				   map->name, cp);
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
+			pr_warning("failed to create map (name: '%s'): %s(%d)\n",
+				   map->name, cp, err);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
-- 
2.17.1

