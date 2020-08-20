Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9156024ABD2
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgHTANe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 20:13:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44958 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbgHTANd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 20:13:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07K09x8I003971
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 17:13:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9y+etqO9sBJKXPOq7icEU7PZmKHO/+X7lwULsNZesGQ=;
 b=Ak6grs+1XSPF0eYS7DONK4jG6Fk7yQ6C+gSRtAm1hTnYuCNJidjhU40zdf4FmDIFOe3h
 +/RVAEMiYAN7+XB305vOoKYlzc15atY6sRhTwP+ok/pxFtud/16hv+3gQFTfy1nAkVx4
 3VUCT5/x3hXupmiEfU/BhvOKEQMLuESoCyY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3318g0hpn1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 17:13:31 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 17:13:29 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 028B637053B6; Wed, 19 Aug 2020 17:13:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/3] bpftool: implement link_query for bpf iterators
Date:   Wed, 19 Aug 2020 17:13:25 -0700
Message-ID: <20200820001325.3741202-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200820001323.3740798-1-yhs@fb.com>
References: <20200820001323.3740798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_13:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=8 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190193
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The link query for bpf iterators is implemented.
Besides being shown to the user what bpf iterator
the link represents, the target_name is also used
to filter out what additional information should be
printed out, e.g., whether map_id should be shown or not.
The following is an example of bpf_iter link dump,
plain output or pretty output.

  $ bpftool link show
  11: iter  prog 59  target_name task
          pids test_progs(1749)
  34: iter  prog 173  target_name bpf_map_elem  map_id 127
          pids test_progs_1(1753)
  $ bpftool -p link show
  [{
          "id": 11,
          "type": "iter",
          "prog_id": 59,
          "target_name": "task",
          "pids": [{
                  "pid": 1749,
                  "comm": "test_progs"
              }
          ]
      },{
          "id": 34,
          "type": "iter",
          "prog_id": 173,
          "target_name": "bpf_map_elem",
          "map_id": 127,
          "pids": [{
                  "pid": 1753,
                  "comm": "test_progs_1"
              }
          ]
      }
  ]

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/link.c | 44 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a89f09e3c848..e77e1525d20a 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -77,6 +77,22 @@ static void show_link_attach_type_json(__u32 attach_ty=
pe, json_writer_t *wtr)
 		jsonw_uint_field(wtr, "attach_type", attach_type);
 }
=20
+static bool is_iter_map_target(const char *target_name)
+{
+	return strcmp(target_name, "bpf_map_elem") =3D=3D 0 ||
+	       strcmp(target_name, "bpf_sk_storage_map") =3D=3D 0;
+}
+
+static void show_iter_json(struct bpf_link_info *info, json_writer_t *wt=
r)
+{
+	const char *target_name =3D u64_to_ptr(info->iter.target_name);
+
+	jsonw_string_field(wtr, "target_name", target_name);
+
+	if (is_iter_map_target(target_name))
+		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
+}
+
 static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 {
 	__u32 len =3D sizeof(*info);
@@ -128,6 +144,9 @@ static int show_link_close_json(int fd, struct bpf_li=
nk_info *info)
 				   info->cgroup.cgroup_id);
 		show_link_attach_type_json(info->cgroup.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_ITER:
+		show_iter_json(info, json_wtr);
+		break;
 	case BPF_LINK_TYPE_NETNS:
 		jsonw_uint_field(json_wtr, "netns_ino",
 				 info->netns.netns_ino);
@@ -175,6 +194,16 @@ static void show_link_attach_type_plain(__u32 attach=
_type)
 		printf("attach_type %u  ", attach_type);
 }
=20
+static void show_iter_plain(struct bpf_link_info *info)
+{
+	const char *target_name =3D u64_to_ptr(info->iter.target_name);
+
+	printf("target_name %s  ", target_name);
+
+	if (is_iter_map_target(target_name))
+		printf("map_id %u  ", info->iter.map.map_id);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -204,6 +233,9 @@ static int show_link_close_plain(int fd, struct bpf_l=
ink_info *info)
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
 		show_link_attach_type_plain(info->cgroup.attach_type);
 		break;
+	case BPF_LINK_TYPE_ITER:
+		show_iter_plain(info);
+		break;
 	case BPF_LINK_TYPE_NETNS:
 		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
 		show_link_attach_type_plain(info->netns.attach_type);
@@ -231,7 +263,7 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len =3D sizeof(info);
-	char raw_tp_name[256];
+	char buf[256];
 	int err;
=20
 	memset(&info, 0, sizeof(info));
@@ -245,8 +277,14 @@ static int do_show_link(int fd)
 	}
 	if (info.type =3D=3D BPF_LINK_TYPE_RAW_TRACEPOINT &&
 	    !info.raw_tracepoint.tp_name) {
-		info.raw_tracepoint.tp_name =3D (unsigned long)&raw_tp_name;
-		info.raw_tracepoint.tp_name_len =3D sizeof(raw_tp_name);
+		info.raw_tracepoint.tp_name =3D (unsigned long)&buf;
+		info.raw_tracepoint.tp_name_len =3D sizeof(buf);
+		goto again;
+	}
+	if (info.type =3D=3D BPF_LINK_TYPE_ITER &&
+	    !info.iter.target_name) {
+		info.iter.target_name =3D (unsigned long)&buf;
+		info.iter.target_name_len =3D sizeof(buf);
 		goto again;
 	}
=20
--=20
2.24.1

