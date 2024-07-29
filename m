Return-Path: <bpf+bounces-35880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AB93F3C1
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F714B21FFC
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C4145B23;
	Mon, 29 Jul 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rl62v+wD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB2142915;
	Mon, 29 Jul 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251635; cv=none; b=c/z6wM3KSHDrn73/73XdshK5JA3IFuDEncL/4UQ71jZdd9Yd11ifsmC2pYi2A0BFSk/WDPGNn0M8EuHZ0npwzEudWiEF7EM+2IG/jf9xeAs2CBFu5sleSitDTuoLPsgTl1xd2sVNQydZ/WwusJQTb0CswDqLzQ2tsV+uy3IwNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251635; c=relaxed/simple;
	bh=6UmEi7HQgiwdJgbduHSlEpGBeNI+pIRsR+el06g25Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+OZ7HMYWLE/7yNFnOiR9+IECZFKxtSogBO4Q/PLD9lth8sQ6vs5vB+mPp1V23FCq3gWAEUWHTrhwkTElstEXVFeB3BamPielaRBrKw32c9e04+yTUT0QyXMGxjwfku+Uejp84Hj/YH46+1Qzik8E+tUnvag9U39Pch4M7JCoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rl62v+wD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MVIg006548;
	Mon, 29 Jul 2024 11:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=t
	hJQReTRX7Slh4IzW/eCud2wcXMGqJB1CzIOnptwN7w=; b=Rl62v+wD4QrqYq5rj
	DQXy6oT8AoBkLZ5M9sHplZwEiZg+roVycA/3wGLYKyV527FrVfF45bJTJ7w7GfPt
	buoGYfj77WDPPal2fkvs6IyqdGFqWTgct/wPpqURk3c4srfy62NiMDWgqu4X1bdP
	KX4tCTxuL5ZPB31StafsJOiR3Z58xRnoIta3H1PgGSoyS7m72v+Jb6G72BTjh7z4
	AewOJ76xNKl2f/fkIbTeKzROSClB+Wpf6zuDGav7SC18Bv3KN1Q+K5hSHnjX+VBy
	UxarVQGzl3kdtnp81OD9mU5JgcAsSORSiDKjnJ24tQPGiLM0AnEAGAfPc2uxbrBu
	F4AvA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1taq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46T9YCX4003819;
	Mon, 29 Jul 2024 11:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxjwcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46TBAAdW008724;
	Mon, 29 Jul 2024 11:13:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-42.vpn.oracle.com [10.175.161.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40p4bxjw3w-3;
	Mon, 29 Jul 2024 11:13:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] btf_encoder: add "distilled_base" BTF feature to split BTF generation
Date: Mon, 29 Jul 2024 12:13:17 +0100
Message-ID: <20240729111317.140816-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240729111317.140816-1-alan.maguire@oracle.com>
References: <20240729111317.140816-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290076
X-Proofpoint-ORIG-GUID: j_-CJTqUpRXamMtHNKzH9vny8Hz7q6Vs
X-Proofpoint-GUID: j_-CJTqUpRXamMtHNKzH9vny8Hz7q6Vs

Adding "distilled_base" to --btf_features when generating split BTF will
create split and .BTF.base BTF - the latter allows us to map references
from split BTF to base BTF, even if that base BTF has changed.  It does
this by providing just enough information about the base types in the
.BTF.base section. See [1] for more.

One note - with non-embedded libbpf, we need to guard against versions
of libbpf (<1.5) which do not have btf__distill_base(); in such a case,
silently skip distillation in line with other unrecognized BTF features.

[1] https://lore.kernel.org/bpf/20240613095014.357981-1-alan.maguire@oracle.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c      | 50 ++++++++++++++++++++++++++++++++++------------
 dwarves.h          |  1 +
 man-pages/pahole.1 |  4 ++++
 pahole.c           |  1 +
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c2df2bc..b8b1adb 100644
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
 
@@ -1755,12 +1756,34 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
-
-	if (encoder->raw_output)
+	if (encoder->raw_output) {
 		err = btf_encoder__write_raw_file(encoder);
-	else
-		err = btf_encoder__write_elf(encoder);
-
+	} else {
+		/* non-embedded libbpf may not have btf__distill_base() or a
+		 * definition of BTF_BASE_ELF_SEC, so conditionally compile
+		 * distillation code.  Like other --btf_features, it will
+		 * silently ignore the feature request if libbpf does not
+		 * support it.
+		 */
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 5
+		if (encoder->gen_distilled_base) {
+			struct btf *btf = NULL, *distilled_base = NULL;
+
+			if (btf__distill_base(encoder->btf, &distilled_base, &btf) < 0) {
+				fprintf(stderr, "could not generate distilled base BTF: %s\n",
+					strerror(errno));
+				return -1;
+			}
+			err = btf_encoder__write_elf(encoder, btf, BTF_ELF_SEC);
+			if (!err)
+				err = btf_encoder__write_elf(encoder, distilled_base, BTF_BASE_ELF_SEC);
+			btf__free(btf);
+			btf__free(distilled_base);
+			return err;
+		}
+#endif
+		err = btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
+	}
 	return err;
 }
 
@@ -2037,6 +2060,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
+		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index f5ae79f..ad26951 100644
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
2.43.5


