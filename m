Return-Path: <bpf+bounces-5530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32E75B895
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE141C2148F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BC1BE86;
	Thu, 20 Jul 2023 20:15:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248161BE75
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:15:14 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773C270D
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:15:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEGvZ021595;
	Thu, 20 Jul 2023 20:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=LyUB1F0in10jA2XieHb2yZ7pRxLRRuvJP4TqAChCLmw=;
 b=1dgIEGY6MF58bBUA55wc39rm/gPZZ5d/IUsQOt/VJV6rAbeGI7pht19Tj23CKW3/wNlz
 uVa6ZORI00z0IEzMnvJK2IHIqoKqX+OhKdrIwwDD4br0fi47qFrUc/K5Q758h7jZEuOz
 qrxROb7iLFRjAufmKZAc9J2+rsaclh/PwKv7Y3vdnKLI+/CL2elLBtqbR2j0OLZyJ8hj
 HewQIN5draGlcYpMsfVaJXkFBPR69pgOqnyq9SQLDwv+IkuFip7lU2Q+O5yi2NZ7LZTs
 GoAZcqEciAr0NmRAWgkCSXjsR1OL9MKW494dHxd9Zs7zgUMcb6UCbyqbO5Pdw6qb18nN 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ry1m4hcjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KJqns6000827;
	Thu, 20 Jul 2023 20:14:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw95tvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KKEmZY036089;
	Thu, 20 Jul 2023 20:14:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-199-137.vpn.oracle.com [10.175.199.137])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw95tr1-2;
	Thu, 20 Jul 2023 20:14:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/2] dwarves: auto-detect maximum kind supported by vmlinux
Date: Thu, 20 Jul 2023 21:14:42 +0100
Message-Id: <20230720201443.224040-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230720201443.224040-1-alan.maguire@oracle.com>
References: <20230720201443.224040-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200172
X-Proofpoint-GUID: 9nr5v5HwkIr-VpcrD-SaPqMqXQyF9JDY
X-Proofpoint-ORIG-GUID: 9nr5v5HwkIr-VpcrD-SaPqMqXQyF9JDY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

[1] https://github.com/oracle-samples/bpftune/issues/35

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


