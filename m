Return-Path: <bpf+bounces-76431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6DCB3F89
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133A73051321
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A6D329C48;
	Wed, 10 Dec 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PATReXCR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4732C929;
	Wed, 10 Dec 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398822; cv=none; b=OQKUiVhcdp+VskTLrEzQ4wc1VF02l6cqcLEbRdwSB61LpLhQMmUQ226aDIYgRra3SAxDb7vA+TGIR+u1YwhWvcUvt4ITQspJH8QfUfMUSABgxo8YcPFeM/XqEia5N38NxXglGIg/cMDVDvVKCjhGFsG5XalChcRYnde+9JKICKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398822; c=relaxed/simple;
	bh=5hN+t3JLIG8VwePO8oS6sUp1CwCUn+uvmqf6Ox6mOlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB3WO92+qjKihf90RxU+DuSxUdFRnvo6W1h/HH0dyfI/vLeKeWZaP+IaTKqdIxy77W40r8l+uUttt2EwihxwAgsNjIDQ7cxixLWgq8Np+f7a0CzdWrSjMaJLbCPmjsuHcBj316rDNZsNJHIVWE9HFDAORuILyudecnreIwh1FrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PATReXCR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYWP23758589;
	Wed, 10 Dec 2025 20:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+K0uC
	vRjuhJMXipE8zOR2yLj/vMmyCodjMFUonzTPrE=; b=PATReXCR9uC960HPt3cKJ
	PfwLhAo7EsMDUjlLwF8GIFPrie7mQT/7dahJwT7A6+YbwqnkNDGkDlKNHljUSve3
	j+os4CdMpmv2DhEbL6oqcahwyOqL/LtrPY3L5oXecSSZNSTfYUUbFfDHTT9L5Unc
	bHzeBm4QPfrZf8vRQo5yXLGo55dFz6OX6nrAgzRylMVm47Fe4hT3qhp6KZ0O/0VD
	8FA6a6uLXbyLOYkBmBlWhLeviPGDSTPERa6me2KLRG2tzX1qBpetfH6syLZQ2b5E
	gpn4Qww7mV0yckae87VlvM8NuwpQWm2Qb4rK+V1jMldMGI0lUnfKbxo2sx12mObm
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aybqv0h7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAK0s0l039890;
	Wed, 10 Dec 2025 20:33:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrq4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSj001635;
	Wed, 10 Dec 2025 20:33:07 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-9;
	Wed, 10 Dec 2025 20:33:07 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 08/10] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Wed, 10 Dec 2025 20:32:41 +0000
Message-ID: <20251210203243.814529-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210203243.814529-1-alan.maguire@oracle.com>
References: <20251210203243.814529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfX6A6Y98dV2aWv
 WwdMhOJUJmniesr4zpgNGpiP3KUa8VgFKNXQ4+b+T91siQGEpmd5jy2BetpbWRL3eGBhdV1n381
 UB23QfVfHSExXp49lNb09pWlnMFHBhwVuwKMlf5YHJISXwn2NawH4VA2l5so9etrpR9tS4yVPfI
 7CESiHUbA13FVM4eAPo5ZeBMDJO9d5JEsVgqbLB+3/yaEU+MNNsGz3mhzC9b5Tk2wrVYGfAHHdN
 bUluU8IAVvQb9frO3ENbdAu+GNncysL4C7F2rQO84dg1J0vFfjCh6Y89QRe0UtDyDy4U7sHMp0Y
 1JtrrJAZwZp/kiQIqXTty8vgh668aF0ZCXt+tHIxBxdgiSJj3FYu+igvLw3UDNgzexLrDzzqt5a
 vwaVoCvDMSeORuvNx37w1kp+Kxm4TDUNJ3o1ZPChAK9CQtFYVz8=
X-Proofpoint-ORIG-GUID: YEnR4vQr5cuJX5L2whTLziutKKfALgnv
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=6939d905 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wuTlCl8tugMN2R7urv8A:9 cc=ntf awl=host:12099
X-Proofpoint-GUID: YEnR4vQr5cuJX5L2whTLziutKKfALgnv

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
 tools/bpf/bpftool/btf.c                   | 89 ++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 4 deletions(-)

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
index 946612029dee..028448c0c7a0 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -835,6 +835,85 @@ static int dump_btf_c(const struct btf *btf,
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
@@ -880,7 +959,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 
 static int do_dump(int argc, char **argv)
 {
-	bool dump_c = false, sort_dump_c = true;
+	bool dump_c = false, sort_dump_c = true, dump_meta = false;
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[MAX_ROOT_IDS];
 	bool have_id_filtering;
@@ -990,10 +1069,12 @@ static int do_dump(int argc, char **argv)
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
@@ -1072,6 +1153,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1446,7 +1529,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-		"       FORMAT  := { raw | c [unsorted] }\n"
+		"       FORMAT  := { raw | c [unsorted] | meta }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-- 
2.43.5


