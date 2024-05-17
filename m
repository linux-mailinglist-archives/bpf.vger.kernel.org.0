Return-Path: <bpf+bounces-29942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F68C84CC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DA12830AE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27090374FB;
	Fri, 17 May 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GW6n8FHj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9862375B
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941667; cv=none; b=PZ+Hnl5xuIHYzXjb2yfO7l7+3kbiaPvy7xkbOfBI1avri8y6d8QQyaJgsSmHE8CWyqjXirQk7eVYflhG/IPm5Q0+aBqEB4RCuJQj3S/BMgBRu+4aIli+bFTBOORiwIDhEO27I0QXx8bAIpIYK8YFsx/5ADGCtnwLMw7JrFfx5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941667; c=relaxed/simple;
	bh=NRFlZyCx5J+zJw4uqcv+go5B6SNCaH4Fdpk7BalvHwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vv4v1NzSa1LY9BvS2+C4xWj9+X3W8Mp+JEavTzOfOMBZRRLUgP59s2U7MKKHvmXbjO5W/vOGiL2F6AgXwsGqT3SuYRFDKz+FCUEttitVf5rZizUY3vYBcq/NRx9yW5y6KcvM1V9xj/Gu+jQCE7y8dulPoUTNvKAulwpHENnO5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GW6n8FHj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H7naC1013697;
	Fri, 17 May 2024 10:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=5Aolg5JEq+dlevOvxXW3iaOpJrJCPbcwTM4ckB/VBsw=;
 b=GW6n8FHj0WQvni7fy1DH3CwEXg9Yc26PUtkXj4HrC3ALfdp6tg7jj8fW9x+LUqolgRxK
 caOG2Wx5wMKOyURMGGCLMnnGYvoe+mDepF0/g1guIwg/f93IurEhETt1RMu05NKQmA5C
 msPqMxHGh9flsuKpqvwv1opANttj68aP5etAoJQrtNxPaw117LjgS6mgUQQuRg7uzf6w
 H32XE+hVxBLl3ulb1pI21p9Dg1QbzlaDi1XMDiJT76N34bC187dlDSuNVbC9+2e6co/9
 zx+3w7z2leP9o+fIgg+5Nf0+2DtQP9zBQzFYzQui9865w2XLgTUYW3sTjgsD3aIVzVHm Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7hmtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:27:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8dNux019319;
	Fri, 17 May 2024 10:27:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r88yfp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:27:21 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HARKrr027058;
	Fri, 17 May 2024 10:27:20 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y3r88yfk4-1;
	Fri, 17 May 2024 10:27:20 +0000
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
Date: Fri, 17 May 2024 11:27:14 +0100
Message-Id: <20240517102714.4072080-1-alan.maguire@oracle.com>
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
 definitions=2024-05-17_03,2024-05-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170083
X-Proofpoint-ORIG-GUID: -WQeCg2gJcVTBzbhKlWvaqnuHKEI3hnM
X-Proofpoint-GUID: -WQeCg2gJcVTBzbhKlWvaqnuHKEI3hnM

Adding "distilled_base" to --btf_features when generating split BTF will
create split and .BTF.base BTF - the latter allows us to map references
from split BTF to base BTF, even if that base BTF has changed.  It does
this by providing just enough information about the base types in the
.BTF.base section.

Patch is applicable on the "next" branch of dwarves, and requires the
libbpf from the series in [1]

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/20240517102246.4070184-1-alan.maguire@oracle.com/
---
 btf_encoder.c      | 40 ++++++++++++++++++++++++++++------------
 dwarves.h          |  1 +
 man-pages/pahole.1 |  4 ++++
 pahole.c           |  1 +
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c2df2bc..0d7c657 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -93,7 +93,8 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  is_rel;
+			  is_rel,
+			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct {
 		struct var_info *vars;
@@ -1284,9 +1285,9 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
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
@@ -1326,7 +1327,7 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
-		if (strcmp(secname, ".BTF") == 0) {
+		if (strcmp(secname, btf_secname) == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
 		}
@@ -1370,11 +1371,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
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
 
@@ -1755,12 +1756,26 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
 
@@ -2037,6 +2052,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
+		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 7d566b6..b9e88e3 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -95,6 +95,7 @@ struct conf_load {
 	bool			btf_encode_force;
 	bool			reproducible_build;
 	bool			btf_decl_tag_kfuncs;
+	bool			btf_gen_distilled_base;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index f060593..2f623b4 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -317,6 +317,10 @@ Supported non-standard features (not enabled for 'default')
 	                   without this parallel BTF encoding can result in
 	                   inconsistent BTF ids.
 	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
+	distilled_base     For split BTF, generate a distilled version of
+	                   the associated base BTF to support later relocation
+	                   of split BTF with a possibly changed base, storing
+	                   it in a .BTF.base ELF section.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index 954498d..fdb65d4 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1291,6 +1291,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
+	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.31.1


