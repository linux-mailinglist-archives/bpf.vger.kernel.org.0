Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78E32AA0AC
	for <lists+bpf@lfdr.de>; Sat,  7 Nov 2020 00:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgKFXFK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 18:05:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728933AbgKFXFJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 18:05:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6MQe4O007589
        for <bpf@vger.kernel.org>; Fri, 6 Nov 2020 15:05:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5rfmbd7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 15:05:09 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 15:05:06 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B86112EC8FA7; Fri,  6 Nov 2020 15:02:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 bpf-next 5/5] tools/bpftool: add support for in-kernel and named BTF in `btf show`
Date:   Fri, 6 Nov 2020 15:02:28 -0800
Message-ID: <20201106230228.2202-6-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106230228.2202-1-andrii@kernel.org>
References: <20201106230228.2202-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1034
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=9
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060153
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Display vmlinux BTF name and kernel module names when listing available BTFs
on the system.

In human-readable output mode, module BTFs are reported with "name
[module-name]", while vmlinux BTF will be reported as "name [vmlinux]".
Square brackets are added by bpftool and follow kernel convention when
displaying modules in human-readable text outputs.

[vmuser@archvm bpf]$ sudo ../../../bpf/bpftool/bpftool btf s
1: name [vmlinux]  size 4082281B
6: size 2365B  prog_ids 8,6  map_ids 3
7: name [button]  size 46895B
8: name [pcspkr]  size 42328B
9: name [serio_raw]  size 39375B
10: name [floppy]  size 57185B
11: name [i2c_core]  size 76186B
12: name [crc32c_intel]  size 16036B
13: name [i2c_piix4]  size 50497B
14: name [irqbypass]  size 14124B
15: name [kvm]  size 197985B
16: name [kvm_intel]  size 123564B
17: name [cryptd]  size 42466B
18: name [crypto_simd]  size 17187B
19: name [glue_helper]  size 39205B
20: name [aesni_intel]  size 41034B
25: size 36150B
        pids bpftool(2519)

In JSON mode, two fields (boolean "kernel" and string "name") are reported for
each BTF object. vmlinux BTF is reported with name "vmlinux" (kernel itself
returns and empty name for vmlinux BTF).

[vmuser@archvm bpf]$ sudo ../../../bpf/bpftool/bpftool btf s -jp
[{
        "id": 1,
        "size": 4082281,
        "prog_ids": [],
        "map_ids": [],
        "kernel": true,
        "name": "vmlinux"
    },{
        "id": 6,
        "size": 2365,
        "prog_ids": [8,6
        ],
        "map_ids": [3
        ],
        "kernel": false
    },{
        "id": 7,
        "size": 46895,
        "prog_ids": [],
        "map_ids": [],
        "kernel": true,
        "name": "button"
    },{

...

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/btf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c96b56e8e3a4..ed5e97157241 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -742,9 +742,14 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 	       struct btf_attach_table *btf_map_table)
 {
 	struct btf_attach_point *obj;
+	const char *name = u64_to_ptr(info->name);
 	int n;
 
 	printf("%u: ", info->id);
+	if (info->kernel_btf)
+		printf("name [%s]  ", name);
+	else if (name && name[0])
+		printf("name %s  ", name);
 	printf("size %uB", info->btf_size);
 
 	n = 0;
@@ -771,6 +776,7 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 	      struct btf_attach_table *btf_map_table)
 {
 	struct btf_attach_point *obj;
+	const char *name = u64_to_ptr(info->name);
 
 	jsonw_start_object(json_wtr);	/* btf object */
 	jsonw_uint_field(json_wtr, "id", info->id);
@@ -796,6 +802,11 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 
 	emit_obj_refs_json(&refs_table, info->id, json_wtr); /* pids */
 
+	jsonw_bool_field(json_wtr, "kernel", info->kernel_btf);
+
+	if (name && name[0])
+		jsonw_string_field(json_wtr, "name", name);
+
 	jsonw_end_object(json_wtr);	/* btf object */
 }
 
@@ -803,15 +814,30 @@ static int
 show_btf(int fd, struct btf_attach_table *btf_prog_table,
 	 struct btf_attach_table *btf_map_table)
 {
-	struct bpf_btf_info info = {};
+	struct bpf_btf_info info;
 	__u32 len = sizeof(info);
+	char name[64];
 	int err;
 
+	memset(&info, 0, sizeof(info));
 	err = bpf_obj_get_info_by_fd(fd, &info, &len);
 	if (err) {
 		p_err("can't get BTF object info: %s", strerror(errno));
 		return -1;
 	}
+	/* if kernel support emitting BTF object name, pass name pointer */
+	if (info.name_len) {
+		memset(&info, 0, sizeof(info));
+		info.name_len = sizeof(name);
+		info.name = ptr_to_u64(name);
+		len = sizeof(info);
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get BTF object info: %s", strerror(errno));
+			return -1;
+		}
+	}
 
 	if (json_output)
 		show_btf_json(&info, fd, btf_prog_table, btf_map_table);
-- 
2.24.1

