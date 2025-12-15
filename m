Return-Path: <bpf+bounces-76595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F2CBD280
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD09303DD12
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E052F6586;
	Mon, 15 Dec 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jzzivZ3w"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FD227599;
	Mon, 15 Dec 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790350; cv=none; b=BNicpK4jn86vAx51gYZZpt2w1VYq3caatQYw/o8XV3tK9xyAKNEbFG+rZ6riJijw7LC85xXPFmzfOrLETPDEBk3x+JUQXPGhE5416qFKs4c7kBbfQjo7suMdzh6TJCpPMWZ1olNEjSsPWzXRkCalL/I51xLtKAFsF7q85cbOsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790350; c=relaxed/simple;
	bh=zahR60sSOtqGIJ7Qzt00lz7Evwvekzz0yPYbZo0ABS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ixe0WfCPuSqhAuF9pfdbrqxi1p4qx7rfnNTHHSpSfnuNg4MHzMEvBd/kuE8prlqoOPORIzloN9zM9RcSIlE7JVxJ+VeZUByLQSjaSoEstCE30USMKAII57F3HMtAMFgkX9pWEWy7y9YYk2RbMknIaFfJ+BoUcWNduePdtPuaIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jzzivZ3w; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uvO11724141;
	Mon, 15 Dec 2025 09:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=0tG/B
	guTCZ9Jye68rwKtGVSElfATUx7i8yHxY6EJPFM=; b=jzzivZ3w2hdubJbaRPVKG
	Eb0tnFZNXUIUt3hEfODmeeMGO9T9oxihHoZkXDE+ubvvCqPkVNCRv0OJZsa9bNgm
	06l65UBJgMjKjPlLaDld50mgU+/CPG4Gm6jr0hy+/0iUEWVrvAImM98vAFbcieta
	gV0nEHu3LvN/uTT4PJPUOoYcmPm04pAhYF2+UHkU+sFvnwbSDMaDNYLBHCsyz+PO
	UKp7tqG4zKB5Z1ZVK3i3gugID3yfob/avgPLmR0N5o51VdohZ536IHvp9QY1Yrlk
	uhJ1c7mAA1Rh0TUB4Z4QT8Z0CPDyvrWPvnEfz+bcJ7df2W/M8f2YYDXVn2qoRNiT
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhncb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF94MDN025821;
	Mon, 15 Dec 2025 09:18:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8yh0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9Hdwg027566;
	Mon, 15 Dec 2025 09:18:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-9;
	Mon, 15 Dec 2025 09:18:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 08/10] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Mon, 15 Dec 2025 09:17:28 +0000
Message-ID: <20251215091730.1188790-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251215091730.1188790-1-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX7y/e64TS3N1/
 HH8Cb9j7h2FgVlVzshSB25+NW4Fk0gcx2AMgE/pbWEGNbVEX5g+4KuS4tPjgxtsLJL0SaWtSjOn
 NZKoUyk1SWzEClUCa1OKb2+Lf+JBhJnqB0MzrG2BS6ILfODQA2Nq3+ghQKDU9W/a8sfEYMAlsv4
 7g4pIxBwYz+bUYSN1//jnoJNMK6rPW55m66M/LssstJE9ua5j8h2I6TvaVnHNaVTR418yG12D5H
 yz5cSTKcgGX0CBN9j1pD8Dcl6xTzsMpDVZzciGPTGCUY8ooz1RjNs0iMglZjfKo5HMpGwAie9Mo
 sCkNMG5ro8MLCrkLUVyZ7N7HPa3Hh7gRgyYdjPf267rDXFO5SLE/C93//G7NQnj7ZnirKXP0kar
 PCAbxAk3Ji13SFMoEo7HYiUhzUFvwA==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693fd26f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wuTlCl8tugMN2R7urv8A:9
X-Proofpoint-GUID: 7Jxfp2BC20zj7XefHJRbIPmWrRFQAQQ2
X-Proofpoint-ORIG-GUID: 7Jxfp2BC20zj7XefHJRbIPmWrRFQAQQ2

Provide a way to dump BTF metadata info via bpftool; this
consists of BTF size, header fields and kind layout info
(if available); for example

$ bpftool btf dump file vmlinux format meta
size 5460436
magic 0xeb9f
version 1
flags 0x0
hdr_len 32
type_len 3194640
type_off 0
str_len 2265721
str_off 3194640
kind_layout_len 40
kind_layout_off 5460364
kind 0    UNKNOWN    info_sz 0    elem_sz 0
kind 1    INT        info_sz 4    elem_sz 0
kind 2    PTR        info_sz 0    elem_sz 0
kind 3    ARRAY      info_sz 12   elem_sz 0
kind 4    STRUCT     info_sz 0    elem_sz 12
kind 5    UNION      info_sz 0    elem_sz 12
kind 6    ENUM       info_sz 0    elem_sz 8
kind 7    FWD        info_sz 0    elem_sz 0
kind 8    TYPEDEF    info_sz 0    elem_sz 0
kind 9    VOLATILE   info_sz 0    elem_sz 0
kind 10   CONST      info_sz 0    elem_sz 0
kind 11   RESTRICT   info_sz 0    elem_sz 0
kind 12   FUNC       info_sz 0    elem_sz 0
kind 13   FUNC_PROTO info_sz 0    elem_sz 8
kind 14   VAR        info_sz 4    elem_sz 0
kind 15   DATASEC    info_sz 0    elem_sz 12
kind 16   FLOAT      info_sz 0    elem_sz 0
kind 17   DECL_TAG   info_sz 4    elem_sz 0
kind 18   TYPE_TAG   info_sz 0    elem_sz 0
kind 19   ENUM64     info_sz 0    elem_sz 12

JSON output is also supported:

$ $ bpftool -p btf dump file /var/tmp/vmlinux.kind_layout format meta
{
    "size": 5460436,
    "header": {
        "magic": 60319,
        "version": 1,
        "flags": 0,
        "hdr_len": 32,
        "type_len": 3194640,
        "type_off": 0,
        "str_len": 2265721,
        "str_off": 3194640,
        "kind_layout_len": 40,
        "kind_layout_offset": 5460364
    },
    "kind_layouts": [{
            "kind": 0,
            "name": "UNKNOWN",
            "info_sz": 0,
            "elem_sz": 0
        },{
            "kind": 1,
            "name": "INT",
            "info_sz": 4,
            "elem_sz": 0
        },{
...

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/bash-completion/bpftool |  2 +-
 tools/bpf/bpftool/btf.c                   | 94 ++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 53bcfeb1a76e..a331172cf8de 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -950,7 +950,7 @@ _bpftool()
                             return 0
                             ;;
                         format)
-                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
                             ;;
                         root_id)
                             return 0;
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..fdb9b36fe106 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -835,6 +835,90 @@ static int dump_btf_c(const struct btf *btf,
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
+
+	data_sz -= hdr->hdr_len;
+
+	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
+		if (hdr->kind_layout_off + hdr->kind_layout_len <= data_sz) {
+			k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
+			nr_kinds = hdr->kind_layout_len / sizeof(*k);
+		}
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
+			printf("kind %-4d %-10s info_sz %-4d elem_sz %-4d\n",
+			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
+			       k[i].info_sz, k[i].elem_sz);
+		}
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
 
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -880,7 +964,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 
 static int do_dump(int argc, char **argv)
 {
-	bool dump_c = false, sort_dump_c = true;
+	bool dump_c = false, sort_dump_c = true, dump_meta = false;
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[MAX_ROOT_IDS];
 	bool have_id_filtering;
@@ -990,10 +1074,12 @@ static int do_dump(int argc, char **argv)
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
@@ -1072,6 +1158,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1446,7 +1534,7 @@ static int do_help(int argc, char **argv)
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


