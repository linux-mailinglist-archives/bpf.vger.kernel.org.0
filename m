Return-Path: <bpf+bounces-14929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F8A7E8FC8
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3CF1F20F58
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF260137A;
	Sun, 12 Nov 2023 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FD577E/L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D80811
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:41 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1A2D64
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiXNR016532;
	Sun, 12 Nov 2023 12:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=+7SYwTlS0f6ebaZX+IjeUrhJyi11t5OYODVExiUdP3E=;
 b=FD577E/LiLdLgyd5NnCXp40zyKuSOA0DJnC+diKbSpqgIKN25HAd1k5TX6TAvaOrC6/b
 3+v9hWQqQscRfXCQSVPoW62KvBtYnBpzIGcoiXdllkloxiWU4rOIJnJ4rxnjm+wiVZS8
 OmYkbbVt0rc4wewAmWO1hMS+MmVyVbTYShaAMSgNEpOlWLRJtd/S6/GYyndb//VxDkdS
 M4lYG0bmd3ghlO0dE4OGHO2v+vhEb6oWV4I39Pa39QfggKwSqmP1iIi4HLFRtwmrUII/
 rZu8CDOZbajlLGwJpHmE4n9jCmzDUG90C0gKs7/+OEQ0JYteCCoRIB2DNo3uEmsYYEI6 SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m29e8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEZeL008972;
	Sun, 12 Nov 2023 12:49:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:21 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceM029718;
	Sun, 12 Nov 2023 12:49:20 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-11;
	Sun, 12 Nov 2023 12:49:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 10/17] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Sun, 12 Nov 2023 12:48:27 +0000
Message-Id: <20231112124834.388735-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: R-Q1hOToc5e5nLrQhqS-KADRyKNSUwU4
X-Proofpoint-ORIG-GUID: R-Q1hOToc5e5nLrQhqS-KADRyKNSUwU4

Provide a way to dump BTF metadata info via bpftool; this
consists of BTF size, header fields and kind layout info
(if available); for example

$ bpftool btf dump file vmlinux format meta
size 5161076
magic 0xeb9f
version 1
flags 0x1
hdr_len 40
type_len 3036368
type_off 0
str_len 2124588
str_off 3036368
kind_layout_len 80
kind_layout_off 5160956
crc 0x64af901b
base_crc 0x0
kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
...

JSON output is also supported:

$ bpftool -j btf dump file vmlinux format meta
{"size":5161076,"header":{"magic":60319,"version":1,"flags":1,"hdr_len":40,=
"type_len":3036368,"type_off":0,"str_len":2124588,"str_off":3036368,"kind_l=
ayout_len":80,"kind_layout_offset":5160956,"crc":1689227291,"base_crc":0},"=
kind_layouts":[{"kind":0,"name":"UNKNOWN","flags":0,"info_sz":0,"elem_sz":0=
},{"kind":1,"name":"INT","flags":0,"info_sz":0,"elem_sz":0},{"kind":2,"name=
":"PTR","flags":0,"info_sz":0,"elem_sz":0},{"kind":3,"name":"ARRAY","flags"=
:0,"info_sz":0,"elem_sz":0},{"kind":4,"name":"STRUCT","flags":53,"info_sz":=
0,"elem_sz":0},{"kind":5,"name":"UNION","flags":0,"info_sz":0,"elem_sz":0},=
{"kind":6,"name":"ENUM","flags":60319,"info_sz":1,"elem_sz":1},{"kind":7,"n=
ame":"FWD","flags":40,"info_sz":0,"elem_sz":0},{"kind":8,"name":"TYPEDEF","=
flags":0,"info_sz":0,"elem_sz":0},{"kind":9,"name":"VOLATILE","flags":0,"in=
fo_sz":0,"elem_sz":0},{"kind":10,"name":"CONST","flags":0,"info_sz":0,"elem=
_sz":0},{"kind":11,"name":"RESTRICT","flags":1,"info_sz":0,"elem_sz":0},{"k=
ind":12,"name":"FUNC","flags":0,"info_sz":0,"elem_sz":0},{"kind":13,"name":=
"FUNC_PROTO","flags":80,"info_sz":0,"elem_sz":0},{"kind":14,"name":"VAR","f=
lags":0,"info_sz":0,"elem_sz":0},{"kind":15,"name":"DATASEC","flags":0,"inf=
o_sz":0,"elem_sz":0},{"kind":16,"name":"FLOAT","flags":53,"info_sz":0,"elem=
_sz":0},{"kind":17,"name":"DECL_TAG","flags":0,"info_sz":0,"elem_sz":0},{"k=
ind":18,"name":"TYPE_TAG","flags":11441,"info_sz":3,"elem_sz":0},{"kind":19=
,"name":"ENUM64","flags":0,"info_sz":0,"elem_sz":0}]}

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/bash-completion/bpftool |  2 +-
 tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/=
bash-completion/bpftool
index 6e4f7ce6bc01..157c3afd8247 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -937,7 +937,7 @@ _bpftool()
                             return 0
                             ;;
                         format)
-                            COMPREPLY=3D( $( compgen -W "c raw" -- "$cur" =
) )
+                            COMPREPLY=3D( $( compgen -W "c raw meta" -- "$=
cur" ) )
                             ;;
                         *)
                             # emit extra options
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..208f3a587534 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -504,6 +504,88 @@ static int dump_btf_c(const struct btf *btf,
 	return err;
 }
=20
+static int dump_btf_meta(const struct btf *btf)
+{
+	const struct btf_header *hdr;
+	const struct btf_kind_layout *k;
+	__u8 i, nr_kinds =3D 0;
+	const void *data;
+	__u32 data_sz;
+
+	data =3D btf__raw_data(btf, &data_sz);
+	if (!data)
+		return -ENOMEM;
+	hdr =3D data;
+	if (json_output) {
+		jsonw_start_object(json_wtr);   /* btf metadata object */
+		jsonw_uint_field(json_wtr, "size", data_sz);
+		jsonw_name(json_wtr, "header");
+		jsonw_start_object(json_wtr);	/* btf header object */
+		jsonw_uint_field(json_wtr, "magic", hdr->magic);
+		jsonw_uint_field(json_wtr, "version", hdr->version);
+		jsonw_uint_field(json_wtr, "flags", hdr->flags);
+		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
+		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
+		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
+		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
+		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
+	} else {
+		printf("size %-10d\n", data_sz);
+		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\n",
+		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
+		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type_off);
+		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off);
+	}
+
+	if (hdr->hdr_len < sizeof(struct btf_header)) {
+		if (json_output) {
+			jsonw_end_object(json_wtr); /* header object */
+			jsonw_end_object(json_wtr); /* metadata object */
+		}
+		return 0;
+	}
+	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
+		k =3D (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
+		nr_kinds =3D hdr->kind_layout_len / sizeof(*k);
+	}
+	if (json_output) {
+		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
+		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
+		jsonw_uint_field(json_wtr, "crc", hdr->crc);
+		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
+		jsonw_end_object(json_wtr); /* end header object */
+
+		if (nr_kinds > 0) {
+			jsonw_name(json_wtr, "kind_layouts");
+			jsonw_start_array(json_wtr);
+			for (i =3D 0; i < nr_kinds; i++) {
+				jsonw_start_object(json_wtr);
+				jsonw_uint_field(json_wtr, "kind", i);
+				if (i < NR_BTF_KINDS)
+					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
+				jsonw_uint_field(json_wtr, "flags", k[i].flags);
+				jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
+				jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
+				jsonw_end_object(json_wtr);
+			}
+			jsonw_end_array(json_wtr);
+		}
+		jsonw_end_object(json_wtr);	/* end metadata */
+	} else {
+		printf("kind_layout_len %-10d\nkind_layout_off %-10d\n",
+		       hdr->kind_layout_len, hdr->kind_layout_off);
+		printf("crc 0x%-10x\nbase_crc 0x%-10x\n",
+		       hdr->crc, hdr->base_crc);
+		for (i =3D 0; i < nr_kinds; i++) {
+			printf("kind %-4d %-10s flags 0x%-4x info_sz %-4d elem_sz %-4d\n",
+			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
+			       k[i].flags, k[i].info_sz, k[i].elem_sz);
+		}
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] =3D "/sys/kernel/btf/vmlinux";
=20
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -553,6 +635,7 @@ static int do_dump(int argc, char **argv)
 	__u32 root_type_ids[2];
 	int root_type_cnt =3D 0;
 	bool dump_c =3D false;
+	bool dump_meta =3D false;
 	__u32 btf_id =3D -1;
 	const char *src;
 	int fd =3D -1;
@@ -654,10 +737,12 @@ static int do_dump(int argc, char **argv)
 			}
 			if (strcmp(*argv, "c") =3D=3D 0) {
 				dump_c =3D true;
+			} else if (is_prefix(*argv, "meta")) {
+				dump_meta =3D true;
 			} else if (strcmp(*argv, "raw") =3D=3D 0) {
 				dump_c =3D false;
 			} else {
-				p_err("unrecognized format specifier: '%s', possible values: raw, c",
+				p_err("unrecognized format specifier: '%s', possible values: raw, c, m=
eta",
 				      *argv);
 				err =3D -EINVAL;
 				goto done;
@@ -692,6 +777,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err =3D dump_btf_c(btf, root_type_ids, root_type_cnt);
+	} else if (dump_meta) {
+		err =3D dump_btf_meta(btf);
 	} else {
 		err =3D dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1063,7 +1150,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC :=3D { id BTF_ID | prog PROG | map MAP [{key | value | k=
v | all}] | file FILE }\n"
-		"       FORMAT  :=3D { raw | c }\n"
+		"       FORMAT  :=3D { raw | c | meta }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
--=20
2.31.1


