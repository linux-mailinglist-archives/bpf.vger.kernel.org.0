Return-Path: <bpf+bounces-5531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE675B896
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C3281FE6
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE591BE8B;
	Thu, 20 Jul 2023 20:15:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E511BE75
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:15:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAAC270B
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:15:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEHH0025059;
	Thu, 20 Jul 2023 20:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=FIMKp7Mtt9rvWtMqIX4x8QIFlnWg42yPRAgam+DmULk=;
 b=r2b9clCS2etApIsfoDtYzWDclzZt62NsRopgox6FPtArfTjq4q8gwTsWrXGVbv2FwSTp
 /C+RwlUdCoasF3P5/dUEs42eeFEdHFTfw7QjAvDLaeC8dfsD4qZcC+hYnpW+hb2l3yW+
 GeP4OWfFcuDirjXwGftZEZPZVzzGkl3579CclgCHErh8+qBCwYfU2vAZTFcO46SK7fzb
 jRLUlSw0p9YN4lkJJRC65BORTMeTVzg6p+auS4EQQ2qO0BRJ3a1/Ud6hq01dAyV1oL7X
 iGl3IEwFUJm7vmU7KiAUmfGGcrdKbkb0VWjqkORfIZ/8/Gns++pnV/3GX2DlToyKKEhF jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78agds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KJIuWB000815;
	Thu, 20 Jul 2023 20:14:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw95tyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KKEmZa036089;
	Thu, 20 Jul 2023 20:14:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-199-137.vpn.oracle.com [10.175.199.137])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw95tr1-3;
	Thu, 20 Jul 2023 20:14:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/2] btf_encoder: learn BTF_KIND_MAX value from base BTF when generating split BTF
Date: Thu, 20 Jul 2023 21:14:43 +0100
Message-Id: <20230720201443.224040-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: QpnBZZAQggMC_0miTFxR3Oln9c1skDlI
X-Proofpoint-GUID: QpnBZZAQggMC_0miTFxR3Oln9c1skDlI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When creating module BTF, the module likely will not have a DWARF
specificiation of BTF_KIND_MAX, so look for it in the base BTF.  For
vmlinux base BTF, the enumeration value is present, so the base BTF
can be checked to limit BTF kind representation.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 24 ++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 98c7529..269ed48 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1901,3 +1901,27 @@ void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
 	if (btf_kind_max < BTF_KIND_ENUM64)
 		conf_load->skip_encoding_btf_enum64 = true;
 }
+
+void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *btf)
+{
+	__u32 id, type_cnt = btf__type_cnt(btf);
+
+	for (id = 1; id < type_cnt; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const struct btf_enum *e;
+		__u16 vlen, i;
+
+		if (!t || !btf_is_enum(t))
+			continue;
+		vlen = btf_vlen(t);
+		e = btf_enum(t);
+		for (i = 0; i < vlen; e++, i++) {
+			const char *name = btf__name_by_offset(btf, e->name_off);
+
+			if (!name || strcmp(name, "BTF_KIND_MAX"))
+				continue;
+			dwarves__set_btf_kind_max(conf_load, e->val);
+			return;
+		}
+	}
+}
diff --git a/btf_encoder.h b/btf_encoder.h
index 34516bb..e5e12ef 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -27,4 +27,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder);
 
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
 
+void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *btf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index 6fc4ed6..542921a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3462,6 +3462,7 @@ int main(int argc, char *argv[])
 				base_btf_file, libbpf_get_error(conf_load.base_btf));
 			goto out;
 		}
+		btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
 		if (!btf_encode && !ctf_encode) {
 			// Force "btf" since a btf_base is being informed
 			conf_load.format_path = "btf";
@@ -3505,6 +3506,7 @@ try_sole_arg_as_class_names:
 					base_btf_file, libbpf_get_error(conf_load.base_btf));
 				goto out;
 			}
+			btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
 		}
 	}
 
-- 
2.39.3


