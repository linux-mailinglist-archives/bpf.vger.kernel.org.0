Return-Path: <bpf+bounces-2741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CB733752
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D12817FC
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E061C779;
	Fri, 16 Jun 2023 17:18:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AB182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:48 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4832120
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCiFl5021230;
	Fri, 16 Jun 2023 17:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=qjao6FoOxureuae5cH9nbW7rHVD6WCZX1yIkGCUg2sE=;
 b=rlH66+0A3LfH8DJalDTKx2vxDdaE1zeWYG1mvwoOas1nfgQuC6Hv44x3GBfiig7eX1kb
 XiJ7dBz0z8KeoyoaL+bmwuIi1CfG3Fs8vhCSstIU4hXWd01FHAR67I1rJqmUo1i8lSTU
 nMwIEa4J4Vmky03T9vRYnR2oKcJ743tWxoSM4QPWroL8gXKsYWRIiiZxFi8PYzC5R9f1
 qukTPqYfKDVwJlmPZeUj/+rBHH0NZDYFgIwG4Ytq88R299vN7ZnGy0tbjDEfMnXXiAP8
 HEnw0qX6JMkfpIzYctMaSyu1gma7em51842xC3PEibiMGPywhEgXJu90ZXGBO6jAxY6Q WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdvh3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GG5oiV012461;
	Fri, 16 Jun 2023 17:18:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmeru08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPk007608;
	Fri, 16 Jun 2023 17:18:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-8;
	Fri, 16 Jun 2023 17:18:23 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 7/9] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Fri, 16 Jun 2023 18:17:25 +0100
Message-Id: <20230616171728.530116-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160156
X-Proofpoint-ORIG-GUID: l1VQHaOp73nCgO7AwaTaIZUY9s1xpoqe
X-Proofpoint-GUID: l1VQHaOp73nCgO7AwaTaIZUY9s1xpoqe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a way to dump BTF metadata info via bpftool; this
consists of BTF size, header fields and kind layout info
(if available); for example

$ bpftool btf dump file vmlinux format meta
size 4966513   
magic 0xeb9f      
version 1         
flags 0x0         
hdr_len 24        
type_len 2929900   
type_off 0         
str_len 2036589   
str_off 2929900   

...or for vmlinux with kind layout, crc:

$ bpftool btf dump file vmlinux format meta
size 5034496   
magic 0xeb9f      
version 1         
flags 0x1         
hdr_len 40        
type_len 2973628   
type_off 0         
str_len 2060745   
str_off 2973628   
kind_layout_len 80        
kind_layout_off 5034376   
crc 0xb6a5171f  
base_crc 0x0         
kind 0    flags 0x0    info_sz 0    elem_sz 0   
kind 1    flags 0x0    info_sz 4    elem_sz 0   
kind 2    flags 0x0    info_sz 0    elem_sz 0   
kind 3    flags 0x0    info_sz 12   elem_sz 0   
kind 4    flags 0x0    info_sz 0    elem_sz 12
...

JSON output is also supported:

$ bpftool -j btf dump file vmlinux format meta
{"size":4904369,{"header":"magic":60319,"version":1,"flags":0,"hdr_len":24,"type_len":2893508,"type_off":0,"str_len":2010837,"str_off":2893508}}

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/bash-completion/bpftool |  2 +-
 tools/bpf/bpftool/btf.c                   | 93 ++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 085bf18f3659..4c186d4efb35 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -937,7 +937,7 @@ _bpftool()
                             return 0
                             ;;
                         format)
-                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
                             ;;
                         *)
                             # emit extra options
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..56f40adcc161 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -504,6 +504,90 @@ static int dump_btf_c(const struct btf *btf,
 	return err;
 }
 
+static int dump_btf_meta(const struct btf *btf)
+{
+	const struct btf_header *hdr;
+	const struct btf_kind_layout *k;
+	const void *data;
+	__u32 data_sz;
+	__u8 i, nr_kinds;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data)
+		return -ENOMEM;
+	hdr = data;
+	if (json_output) {
+		jsonw_start_object(json_wtr);   /* btf metadata object */
+		jsonw_uint_field(json_wtr, "size", data_sz);
+		jsonw_start_object(json_wtr);
+		jsonw_name(json_wtr, "header");
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
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    hdr->kind_layout_len == 0 || hdr->kind_layout_len == 0) {
+		if (json_output) {
+			jsonw_end_object(json_wtr); /* header object */
+			jsonw_end_object(json_wtr); /* metadata object */
+		}
+		return 0;
+	}
+
+	if (json_output) {
+		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
+		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
+		jsonw_uint_field(json_wtr, "crc", hdr->crc);
+		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
+		jsonw_end_object(json_wtr); /* end header object */
+
+		jsonw_start_object(json_wtr);
+		jsonw_name(json_wtr, "kind_layouts");
+		jsonw_start_array(json_wtr);
+	} else {
+		printf("kind_layout_len %-10d\nkind_layout_off %-10d\n",
+		       hdr->kind_layout_len, hdr->kind_layout_off);
+		printf("crc 0x%-10x\nbase_crc 0x%-10x\n",
+		       hdr->crc, hdr->base_crc);
+	}
+
+	k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
+	nr_kinds = hdr->kind_layout_len / sizeof(*k);
+	for (i = 0; i < nr_kinds; i++) {
+		if (json_output) {
+			jsonw_start_object(json_wtr);
+			jsonw_name(json_wtr, "kind_layout");
+			jsonw_uint_field(json_wtr, "kind", i);
+			jsonw_uint_field(json_wtr, "flags", k[i].flags);
+			jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
+			jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
+			jsonw_end_object(json_wtr);
+		} else {
+			printf("kind %-4d flags 0x%-4x info_sz %-4d elem_sz %-4d\n",
+			       i, k[i].flags, k[i].info_sz, k[i].elem_sz);
+		}
+	}
+	if (json_output) {
+		jsonw_end_array(json_wtr);
+		jsonw_end_object(json_wtr); /* end kind layout */
+		jsonw_end_object(json_wtr); /* end metadata object */
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
 
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -553,6 +637,7 @@ static int do_dump(int argc, char **argv)
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
 	bool dump_c = false;
+	bool dump_meta = false;
 	__u32 btf_id = -1;
 	const char *src;
 	int fd = -1;
@@ -654,10 +739,12 @@ static int do_dump(int argc, char **argv)
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
@@ -692,6 +779,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1063,7 +1152,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-		"       FORMAT  := { raw | c }\n"
+		"       FORMAT  := { raw | c | meta }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-- 
2.39.3


