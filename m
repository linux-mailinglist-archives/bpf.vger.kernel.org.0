Return-Path: <bpf+bounces-29462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C691F8C226D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27975B22364
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F7168B0C;
	Fri, 10 May 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B4Wk5Mhi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321F16132E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338179; cv=none; b=UemFQjzVaPihkTHLY5g2L/k24vDAQyMMEh+0/mmct+yR2axMV1RZPtspZ8VfeEKvotNBLKeLz/Y9FrYW4v55FDyWVFIb0qxc+YZ0UIuaRawtnYiZ+tpzyaMAFaivP4r5IxmcvGCYcaA+r0xTMktJgpoyJo6R5MziqTOT/eDV8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338179; c=relaxed/simple;
	bh=iP10LpNtucUKPmynAc6t3lVjPZRy0I/e+WJ5nTOsEzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tb3DNusycd3he3r4027n2Nxg1g6EqkY9FQSMQSvrkvAiOKr3MDzJCGUEXeE3t/7z3IVhJU1Djp1o5XitlwTYPp+/VQ5vcdAAovu8VOq+2bnVMALfMIH3c+yGOq5q2b4AWucVUlQqguFDyOt5QTCEd+Jhwyv8etqpbQSnBY8SBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B4Wk5Mhi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAduDC023702;
	Fri, 10 May 2024 10:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=x3xhIusH5dLjMtU4JIrDCmJU4g41xZXlFKgrIYIF1W8=;
 b=B4Wk5MhiXiAA9P5w5AdleTO9IMLeFnPGKGnpTkHwi8YxZcz3mEBVhGhLBGCGTDuMEKhk
 h2B+0jqw4YEJnpbwAmrTxUFY62FVp8QCv0KIqbvxA2/7sbQ9lWA3Y4B19nqh/liyttbe
 aXi+BZI4joPfxYCanf2x2E5lCQJZZzf0wS/T52y0cYRLHMZ+NTnflHJ5atxAKmgIb3HX
 8FrjSXvbi4tAVtjZOIGSycoyavUR8TZBOsliF2D9fBSUFxY4E/qcJSFNYVDePOGi0Ux8
 krN9xr/DpkNYSK6GWsi2bxf4hcsloE2r+SDftet04c/u77fTZ4DsGMUkvqU3L7vBJdvq iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1f4x0csy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:49:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A8rmIe030906;
	Fri, 10 May 2024 10:48:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpndeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:48:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAmwkf019131;
	Fri, 10 May 2024 10:48:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpnda5-1;
	Fri, 10 May 2024 10:48:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: add "distilled_base" BTF feature to split BTF generation
Date: Fri, 10 May 2024 11:48:47 +0100
Message-Id: <20240510104847.858922-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100077
X-Proofpoint-GUID: rcNfT33UAPHAvp2f6_18W73DdWYLIEuV
X-Proofpoint-ORIG-GUID: rcNfT33UAPHAvp2f6_18W73DdWYLIEuV

Adding "distilled_base" to --btf_features when generating split BTF will
create split and .BTF.base BTF - the latter allows us to map references
from split BTF to base BTF, even if that base BTF has changed.  It does
this by providing just enough information about the base types in the
.BTF.base section.

Patch is applicable on the "next" branch of dwarves, and requires the
libbpf from the series in [1]

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@oracle.com/

---
 btf_encoder.c      | 40 ++++++++++++++++++++++++++++------------
 dwarves.h          |  1 +
 man-pages/pahole.1 |  3 +++
 pahole.c           |  1 +
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 19e9d90..6814549 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -75,7 +75,8 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
-			  is_rel;
+			  is_rel,
+			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct {
 		struct var_info *vars;
@@ -1255,9 +1256,9 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
 	return err;
 }
 
-static int btf_encoder__write_elf(struct btf_encoder *encoder)
+static int btf_encoder__write_elf(struct btf_encoder *encoder, const struct btf *btf,
+				  const char *btf_secname)
 {
-	struct btf *btf = encoder->btf;
 	const char *filename = encoder->filename;
 	GElf_Shdr shdr_mem, *shdr;
 	Elf_Data *btf_data = NULL;
@@ -1297,7 +1298,7 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
-		if (strcmp(secname, ".BTF") == 0) {
+		if (strcmp(secname, btf_secname) == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
 		}
@@ -1341,11 +1342,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 			goto unlink;
 		}
 
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
+		snprintf(cmd, sizeof(cmd), "%s --add-section %s=%s %s",
+			 llvm_objcopy, btf_secname, tmp_fn, filename);
 		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
+			fprintf(stderr, "%s: failed to add %s section to '%s': %d!\n",
+				__func__, btf_secname, filename, errno);
 			goto unlink;
 		}
 
@@ -1380,12 +1381,26 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
-
-	if (encoder->raw_output)
+	if (encoder->raw_output) {
 		err = btf_encoder__write_raw_file(encoder);
-	else
-		err = btf_encoder__write_elf(encoder);
+	} else {
+		struct btf *btf = encoder->btf, *distilled_base;
 
+		if (encoder->gen_distilled_base) {
+			if (btf__distill_base(encoder->btf, &distilled_base, &btf) < 0) {
+				fprintf(stderr, "could not generate distilled base BTF: %s\n",
+					strerror(errno));
+				return -1;
+			}
+		}
+		err = btf_encoder__write_elf(encoder, btf, BTF_ELF_SEC);
+		if (!err && encoder->gen_distilled_base)
+			err = btf_encoder__write_elf(encoder, distilled_base, BTF_BASE_ELF_SEC);
+		if (btf != encoder->btf) {
+			btf__free((struct btf *)btf__base_btf(btf));
+			btf__free(btf);
+		}
+	}
 	return err;
 }
 
@@ -1659,6 +1674,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index dd35a4e..5f5e2b6 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -94,6 +94,7 @@ struct conf_load {
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
+	bool			btf_gen_distilled_base;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 19bf197..dae7050 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -316,6 +316,9 @@ Supported non-standard features (not enabled for 'default')
 	reproducible_build Ensure generated BTF is consistent every time;
 	                   without this parallel BTF encoding can result in
 	                   inconsistent BTF ids.
+	distilled_base     For split BTF, generate a distilled version of
+	                   the associated base BTF to support later relocation
+	                   of split BTF with a possibly changed base.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index 750b847..79d01dc 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1290,6 +1290,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
+	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.31.1


