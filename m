Return-Path: <bpf+bounces-9914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278579EB0B
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C7281ABC
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC71F18B;
	Wed, 13 Sep 2023 14:27:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99901A713
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:27:19 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7398
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:27:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBfxxa029038;
	Wed, 13 Sep 2023 14:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=R2yVtBska1nDRKbZZESTqpQOF6w62lyRIG1PdUwP1vA=;
 b=tlTfF0nOu7N1HzfzdDPNLoFh5+q4VwuGCmhJ8pDRQgtjh2P3cnj0bmO/JS/lS0UrBBsn
 W4KqbBTWG67NgZYPUQJKn4wDQ7GEyeBMTcI4fqA/8i/VIEomqCJY3cVn32AeFLSbWF+n
 qta0+ruO71Oag+oWdngpOOrVmdfj5o12vjDspJ/YkwLeayiJCLgQnbSBqtRNrrZYZeq6
 zcAkE8v8WFqCHNXPbFtsRcTF94ybV1CoilQeMKQdsbSFx/XygYRFMsB6A8ewitSJDD1Q
 xO9bN8BYLVg8WEuOchV4/SM6BXZ0GQ+XV5pOm85pILDFQ+GSPYU3JVY9frpZTOrsqAeZ Lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7ka8kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:26:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDxoRc015016;
	Wed, 13 Sep 2023 14:26:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dkhjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:26:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DENxAK005305;
	Wed, 13 Sep 2023 14:26:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-149.vpn.oracle.com [10.175.188.149])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0f5dkhdj-2;
	Wed, 13 Sep 2023 14:26:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/3] dwarves: auto-detect maximum kind supported by vmlinux
Date: Wed, 13 Sep 2023 15:26:44 +0100
Message-Id: <20230913142646.190047-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230913142646.190047-1-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130118
X-Proofpoint-GUID: pLp_Gsjp_en6AvKxXhE8nUaQk4uIZYi8
X-Proofpoint-ORIG-GUID: pLp_Gsjp_en6AvKxXhE8nUaQk4uIZYi8

When a newer pahole is run on an older kernel, it often knows about BTF
kinds that the kernel does not support.  This is a problem because the BTF
generated is then embedded in the kernel image and read, and if unknown
kinds are found, BTF handling fails and core BPF functionality is
unavailable.

The scripts/pahole-flags.sh script enumerates the various pahole options
available associated with various versions of pahole, but the problem is
what matters in the case of an older kernel is the set of kinds the kernel
understands.  Because recent features such as BTF_KIND_ENUM64 are added
by default (and only skipped if --skip_encoding_btf_* is set), BTF will
be created with these newer kinds that the older kernel cannot read.
This can be fixed by stable-backporting --skip options, but this is
cumbersome and would have to be done every time a new BTF kind is
introduced.

Here instead we pre-process the DWARF information associated with the
target for BTF generation; if we find an enum with a BTF_KIND_MAX
value in the DWARF associated with the object, we use that to
determine the maximum BTF kind supported.  Note that the enum
representation of BTF kinds starts for the 5.16 kernel; prior to this
The benefit of auto-detection is that no work is required for older
kernels when new kinds are added, and --skip_encoding options are
less needed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c  | 12 ++++++++++++
 dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  2 ++
 3 files changed, 66 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..98c7529 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)
 {
 	return encoder->btf;
 }
+
+void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
+{
+	if (btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
+		return;
+	if (btf_kind_max < BTF_KIND_DECL_TAG)
+		conf_load->skip_encoding_btf_decl_tag = true;
+	if (btf_kind_max < BTF_KIND_TYPE_TAG)
+		conf_load->skip_encoding_btf_type_tag = true;
+	if (btf_kind_max < BTF_KIND_ENUM64)
+		conf_load->skip_encoding_btf_enum64 = true;
+}
diff --git a/dwarf_loader.c b/dwarf_loader.c
index ccf3194..8984043 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
 	return 0;
 }
 
+/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_kind_max with
+ * this value if found since it indicates that the target object does not know
+ * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel/module
+ * BTF where a newer pahole/libbpf operate on an older kernel which cannot
+ * parse some of the newer kinds pahole can generate.
+ */
+static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
+{
+	struct conf_load *conf = dcus->conf;
+	uint8_t pointer_size, offset_size;
+	Dwarf_Off off = 0, noff;
+	size_t cuhl;
+
+	while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_size, &offset_size) == 0) {
+		Dwarf_Die die_mem;
+		Dwarf_Die *cu_die = dwarf_offdie(dcus->dw, off + cuhl, &die_mem);
+		Dwarf_Die child;
+
+		if (cu_die == NULL)
+			break;
+		if (dwarf_child(cu_die, &child) == 0) {
+			Dwarf_Die *die = &child;
+
+			do {
+				Dwarf_Die echild, *edie;
+
+				if (dwarf_tag(die) != DW_TAG_enumeration_type ||
+				    !dwarf_haschildren(die) ||
+				    dwarf_child(die, &echild) != 0)
+					continue;
+				edie = &echild;
+				do {
+					const char *ename;
+					int btf_kind_max;
+
+					if (dwarf_tag(edie) != DW_TAG_enumerator)
+						continue;
+					ename = attr_string(edie, DW_AT_name, conf);
+					if (!ename || strcmp(ename, "BTF_KIND_MAX") != 0)
+						continue;
+					btf_kind_max = attr_numeric(edie, DW_AT_const_value);
+					dwarves__set_btf_kind_max(conf, btf_kind_max);
+					return;
+				} while (dwarf_siblingof(edie, edie) == 0);
+			} while (dwarf_siblingof(die, die) == 0);
+		}
+		off = noff;
+	}
+}
+
 static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
 {
+	dwarf__find_btf_kind_max(dcus);
+
 	if (dcus->conf->nr_jobs > 1)
 		return dwarf_cus__threaded_process_cus(dcus);
 
diff --git a/dwarves.h b/dwarves.h
index eb1a6df..f4d9347 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1480,4 +1480,6 @@ extern const char tabs[];
 #define DW_TAG_skeleton_unit 0x4a
 #endif
 
+void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max);
+
 #endif /* _DWARVES_H_ */
-- 
2.39.3


