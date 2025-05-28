Return-Path: <bpf+bounces-59163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38786AC6683
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A901BC67F6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815B27E7C6;
	Wed, 28 May 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RG6kyWsW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57D27D784;
	Wed, 28 May 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426330; cv=none; b=HNd9FUGsLKiBfcxem9+gn3vsjnVqWJ6hnmwvlACTPwI3TuNsxfqusifeq4R2wFlhUdmOCvWSucrQpqKd8gf2+VxSfX+STrBq9QDwY2hp9LeZouNj3aonY9gMkiwNXgz/egREd4oNYR2DzTCtOnV1bFyr9gihwDL8YBzjZVZkQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426330; c=relaxed/simple;
	bh=86cC9fTRW5f6+AIr/s+G3JZ5mmeZ1x4zzPHe7k7dNz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cei1H3UcfL9cn8qHaWQ9L4nYEDqaBpg0TxE+u5gk5NGAB3yxp96mB9C2GVyMyFpTXp5oydFwo8QeeiQmSHt+9JVO3a4djccXA1o4y+TVRMJ8EfOs7Edz1m7mcy9m7uUT8OLpJr1Nh5nu+8in7z7hcx+gXQ5z9BLxfajsTypkGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RG6kyWsW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1hWkD013251;
	Wed, 28 May 2025 09:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Ndvdk
	v5ndQVjThVBxnX0SOKMFO+LVxwtHnWO/VX5DCM=; b=RG6kyWsWszlTtsU5mnTxd
	UHPoMKlyX1OmGT/93Ox4D6egbgzuXpep3AGg3PzpNNafgabrep4QTWmtGJhlOpDr
	VK4/qjJp1JPm/MvFp1PsZxM/Mtu63xNis51fRbF0GeVA/5u9WZVaL9CPyInbI27o
	i0844sd4tBCDbzXJoJoqrkI6RtdoVkrlKNI6oGjJM+cNh6ZjdeOuCjmLjBsvRiME
	V/BUpkoheXSYBkB8FcuPBVDvk4O69c4Yl9BKUn3SDAthTt5Y635L5r9Ji0NJqvQC
	yLSRQcImVKQYRtMZ0BIx4uCHFPNthngDTQMWYFJLzU7PqTCvhFEQkR3FWgZg0+Dz
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd5991-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S8G5wC024428;
	Wed, 28 May 2025 09:58:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwW2007194;
	Wed, 28 May 2025 09:58:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-9;
	Wed, 28 May 2025 09:58:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 8/9] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Wed, 28 May 2025 10:57:42 +0100
Message-ID: <20250528095743.791722-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-ORIG-GUID: K5VaRCX2UlfEsGZyqW1yz3VwZLYMYKOx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX/urB9Mcc55g4 0IYkj7G51YTafOi+Cyo/mlAn4GuhblirwW4TAXweisFQG2Fh0KIUaGUh14BW+P9scOCtXEbuxZ5 JxNWYuoJyVuF7+bt5PgMvPHfz0ttJcKI882Q+YciAXv8Yd9k1U6eeo+mgk+Qa8FWplbS+8kqwAg
 GMnqXxO3Tk1vDP1LNruPnerzLz6B94CxyAx3Xi5kq6DJGccu1REYT4aV8pAtPz7bgbroTt3f/G4 EAOIAAvU/0ZGQsk8unRQzw1v/+D9531JxcniFPLuYPGy5otM6GnadrlpbAIv69bUT5qNqolnGqm eKORk03tJGxha34e4Qn5Dc2BVK6t3/bJOfwTqXLJH0xJuJZktEIqapgC90Y5A+frYPZM2H87n57
 SlfS4CYnv7SpDTMpI7EW/VVdqc7wCY3qFz7ZDBwRYSI2SoNK/Otg+il3fzkN+H1donpgJnrH
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6836de33 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=WkCikOrPkrds4MYFgYoA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: K5VaRCX2UlfEsGZyqW1yz3VwZLYMYKOx

Provide a way to dump BTF metadata info via bpftool; this
consists of BTF size, header fields and kind layout info
(if available); for example

$ bpftool btf dump file vmlinux format meta
size 5169836
magic 0xeb9f
version 1
flags 0x1
hdr_len 40
type_len 3041436
type_off 0
str_len 2128279
str_off 3041436
kind_layout_len 80
kind_layout_off 5169716
kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
kind 1    INT        flags 0x0    info_sz 4    elem_sz 0
kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
kind 3    ARRAY      flags 0x0    info_sz 12   elem_sz 0
kind 4    STRUCT     flags 0x0    info_sz 0    elem_sz 12
...

JSON output is also supported:

$ bpftool -j btf dump file vmlinux format meta | jq
{
  "size": 5169836,
  "header": {
    "magic": 60319,
    "version": 1,
    "flags": 1,
    "hdr_len": 40,
    "type_len": 3041436,
    "type_off": 0,
    "str_len": 2128279,
    "str_off": 3041436,
    "kind_layout_len": 80,
    "kind_layout_offset": 5169716,
  },
  "kind_layouts": [
    {
      "kind": 0,
      "name": "UNKNOWN",
      "flags": 0,
      "info_sz": 0,
      "elem_sz": 0
    },
    {
      "kind": 1,
      "name": "INT",
      "flags": 0,
      "info_sz": 4,
      "elem_sz": 0
    },
...

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/bash-completion/bpftool |  2 +-
 tools/bpf/bpftool/btf.c                   | 90 ++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1ce409a6cbd9..8accc9e153a7 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -928,7 +928,7 @@ _bpftool()
                             return 0
                             ;;
                         format)
-                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
                             ;;
                         root_id)
                             return 0;
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6b14cbfa58aa..686608fb7b6c 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -835,6 +835,86 @@ static int dump_btf_c(const struct btf *btf,
 	return err;
 }
 
+static int dump_btf_meta(const struct btf *btf)
+{
+	const struct btf_header *hdr;
+	const struct btf_kind_layout *k;
+	__u8 i, nr_kinds = 0;
+	const void *data;
+	__u32 data_sz;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data)
+		return -ENOMEM;
+	hdr = data;
+	if (json_output) {
+		jsonw_start_object(json_wtr);		/* metadata object */
+		jsonw_uint_field(json_wtr, "size", data_sz);
+		jsonw_name(json_wtr, "header");
+		jsonw_start_object(json_wtr);		/* header object */
+		jsonw_uint_field(json_wtr, "magic", hdr->magic);
+		jsonw_uint_field(json_wtr, "version", hdr->version);
+		jsonw_uint_field(json_wtr, "flags", hdr->flags);
+		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
+		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
+		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
+		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
+		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
+	} else {
+		printf("size %-10u\n", data_sz);
+		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10u\n",
+		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
+		printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len, hdr->type_off);
+		printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hdr->str_off);
+	}
+
+	if (hdr->hdr_len < sizeof(struct btf_header)) {
+		if (json_output) {
+			jsonw_end_object(json_wtr);	/* end header object */
+			jsonw_end_object(json_wtr);	/* end metadata object */
+		}
+		return 0;
+	}
+	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
+		k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
+		nr_kinds = hdr->kind_layout_len / sizeof(*k);
+	}
+	if (json_output) {
+		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
+		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
+		jsonw_end_object(json_wtr);		/* end header object */
+
+		if (nr_kinds > 0) {
+			jsonw_name(json_wtr, "kind_layouts");
+			jsonw_start_array(json_wtr);
+			for (i = 0; i < nr_kinds; i++) {
+				jsonw_start_object(json_wtr);
+				jsonw_uint_field(json_wtr, "kind", i);
+				if (i < NR_BTF_KINDS)
+					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
+				else
+					jsonw_null_field(json_wtr, "name");
+				jsonw_uint_field(json_wtr, "flags", k[i].flags);
+				jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
+				jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
+				jsonw_end_object(json_wtr);
+			}
+			jsonw_end_array(json_wtr);
+		}
+		jsonw_end_object(json_wtr);		/* end metadata object */
+	} else {
+		printf("kind_layout_len %-10u\nkind_layout_off %-10u\n",
+		       hdr->kind_layout_len, hdr->kind_layout_off);
+		for (i = 0; i < nr_kinds; i++) {
+			printf("kind %-4d %-10s flags 0x%-4x info_sz %-4d elem_sz %-4d\n",
+			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
+			       k[i].flags, k[i].info_sz, k[i].elem_sz);
+		}
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
 
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -880,7 +960,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 
 static int do_dump(int argc, char **argv)
 {
-	bool dump_c = false, sort_dump_c = true;
+	bool dump_c = false, sort_dump_c = true, dump_meta = false;
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[MAX_ROOT_IDS];
 	bool have_id_filtering;
@@ -989,10 +1069,12 @@ static int do_dump(int argc, char **argv)
 			}
 			if (strcmp(*argv, "c") == 0) {
 				dump_c = true;
+			} else if (is_prefix(*argv, "meta")) {
+				dump_meta = true;
 			} else if (strcmp(*argv, "raw") == 0) {
 				dump_c = false;
 			} else {
-				p_err("unrecognized format specifier: '%s', possible values: raw, c",
+				p_err("unrecognized format specifier: '%s', possible values: raw, c, meta",
 				      *argv);
 				err = -EINVAL;
 				goto done;
@@ -1071,6 +1153,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1442,7 +1526,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-		"       FORMAT  := { raw | c [unsorted] }\n"
+		"       FORMAT  := { raw | c [unsorted] | meta }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-- 
2.39.3


