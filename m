Return-Path: <bpf+bounces-1546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A581718B0F
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87251C20F1B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C223D398;
	Wed, 31 May 2023 20:21:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480D34CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493D134
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK2Omj027743;
	Wed, 31 May 2023 20:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ol19eRQkoVVrpX2aGsZ286OEGEfhsIKyIEy7NBNLfw4=;
 b=zrkl/DY/EZ1xi7gYyp69IaISbSt+53ET8hfvUopt39mo5aRhOMBXsDmCsXe7IuZ5d5xz
 8cSWHFL7miOLAUtHpHYSwoRQ+phyPQLDnNGK/v2eAzRQ64zgSh4mI1j7DdA52RPQhwn8
 +v+nQlyr+ooCpz9fsUAGr91p/07DG/biokW1hejTyiTORHMjYO42UIHVBIqDWvykp2pK
 tSWCFTWa/j/kZ3Ch78YTnxzmcwJpKu8Fl+SuSLys1gPgUTw08B1IP6Tl8BxyUCcHcjs4
 +vBv9E93cUP/4HXJooowSa2NgofepR47AqnzogEkTXmiKxsmZ1myrnTxZvC7cc+RdPSu Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwweucy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKHccB019873;
	Wed, 31 May 2023 20:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6dk17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEZ000653;
	Wed, 31 May 2023 20:21:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-8;
	Wed, 31 May 2023 20:21:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 7/8] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Wed, 31 May 2023 21:19:34 +0100
Message-Id: <20230531201936.1992188-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: NNUG5CoxLXm4xruWdAmFYHv9_8a44jVQ
X-Proofpoint-GUID: NNUG5CoxLXm4xruWdAmFYHv9_8a44jVQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a way to dump BTF header and metadata info via
bpftool; for example

$ bpftool btf dump file vmliux format meta
BTF: data size 4963656
Header: magic 0xeb9f, version 1, flags 0x0, hdr_len 32
Types: len 2927556, offset 0
Strings: len 2035881, offset 2927556
Metadata header found: len 184, offset 4963440, flags 0x1
Description: 'generated by dwarves v1.25'
CRC 0x6da2a930 ; base CRC 0x0
Kind metadata for 20 kinds:
       BTF_KIND_UNKN[ 0] flags 0x0    info_sz  0 elem_sz  0
        BTF_KIND_INT[ 1] flags 0x0    info_sz  4 elem_sz  0
        BTF_KIND_PTR[ 2] flags 0x0    info_sz  0 elem_sz  0
      BTF_KIND_ARRAY[ 3] flags 0x0    info_sz 12 elem_sz  0
     BTF_KIND_STRUCT[ 4] flags 0x0    info_sz  0 elem_sz 12
      BTF_KIND_UNION[ 5] flags 0x0    info_sz  0 elem_sz 12
       BTF_KIND_ENUM[ 6] flags 0x0    info_sz  0 elem_sz  8
        BTF_KIND_FWD[ 7] flags 0x0    info_sz  0 elem_sz  0
    BTF_KIND_TYPEDEF[ 8] flags 0x0    info_sz  0 elem_sz  0
   BTF_KIND_VOLATILE[ 9] flags 0x0    info_sz  0 elem_sz  0
      BTF_KIND_CONST[10] flags 0x0    info_sz  0 elem_sz  0
   BTF_KIND_RESTRICT[11] flags 0x0    info_sz  0 elem_sz  0
       BTF_KIND_FUNC[12] flags 0x0    info_sz  0 elem_sz  0
 BTF_KIND_FUNC_PROTO[13] flags 0x0    info_sz  0 elem_sz  8
        BTF_KIND_VAR[14] flags 0x0    info_sz  4 elem_sz  0
    BTF_KIND_DATASEC[15] flags 0x0    info_sz  0 elem_sz 12
      BTF_KIND_FLOAT[16] flags 0x0    info_sz  0 elem_sz  0
   BTF_KIND_DECL_TAG[17] flags 0x1    info_sz  4 elem_sz  0
   BTF_KIND_TYPE_TAG[18] flags 0x1    info_sz  0 elem_sz  0
     BTF_KIND_ENUM64[19] flags 0x0    info_sz  0 elem_sz 12

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..da4257e00ba8 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -504,6 +504,47 @@ static int dump_btf_c(const struct btf *btf,
 	return err;
 }
 
+static int dump_btf_meta(const struct btf *btf)
+{
+	const struct btf_header *hdr;
+	const struct btf_metadata *m;
+	const void *data;
+	__u32 data_sz;
+	__u8 i;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data)
+		return -ENOMEM;
+	hdr = data;
+	printf("BTF: data size %u\n", data_sz);
+	printf("Header: magic 0x%x, version %d, flags 0x%x, hdr_len %u\n",
+	       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
+	printf("Types: len %u, offset %u\n", hdr->type_len, hdr->type_off);
+	printf("Strings: len %u, offset %u\n", hdr->str_len, hdr->str_off);
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    hdr->meta_header.meta_len == 0 ||
+	    hdr->meta_header.meta_off == 0)
+		return 0;
+
+	m = (void *)hdr + hdr->hdr_len + hdr->meta_header.meta_off;
+
+	printf("Metadata header found: len %u, offset %u, flags 0x%x\n",
+	       hdr->meta_header.meta_len, hdr->meta_header.meta_off, m->flags);
+	if (m->description_off)
+		printf("Description: '%s'\n", btf__name_by_offset(btf, m->description_off));
+	printf("CRC 0x%x ; base CRC 0x%x\n", m->crc, m->base_crc);
+	printf("Kind metadata for %d kinds:\n", m->kind_meta_cnt);
+	for (i = 0; i < m->kind_meta_cnt; i++) {
+		printf("%20s[%2d] flags 0x%-4x info_sz %2d elem_sz %2d\n",
+		       btf__name_by_offset(btf, m->kind_meta[i].name_off),
+		       i, m->kind_meta[i].flags, m->kind_meta[i].info_sz,
+		       m->kind_meta[i].elem_sz);
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
 
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -553,6 +594,7 @@ static int do_dump(int argc, char **argv)
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
 	bool dump_c = false;
+	bool dump_meta = false;
 	__u32 btf_id = -1;
 	const char *src;
 	int fd = -1;
@@ -654,6 +696,8 @@ static int do_dump(int argc, char **argv)
 			}
 			if (strcmp(*argv, "c") == 0) {
 				dump_c = true;
+			} else if (strcmp(*argv, "meta") == 0) {
+				dump_meta = true;
 			} else if (strcmp(*argv, "raw") == 0) {
 				dump_c = false;
 			} else {
@@ -692,6 +736,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
-- 
2.31.1


