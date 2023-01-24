Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F9679A83
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjAXNth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjAXNtX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 08:49:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C546700
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 05:47:13 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODHhk1002539;
        Tue, 24 Jan 2023 13:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=G+I7KnrQ/H/31Cfswrotey4N0yvpKVUFFC/LA3Hr4mc=;
 b=IunItGn+locyyCbSuMAck5lhsUmlv3YNAqsAt6St2rSlMEtJawiPSkmvN8IBHzlMIa2Z
 jzvpPMxFyW3I8TZlYPaFj4vubo8pQ4qhctv4jb5lxpeS05VOTq9g2Z2KRjYfnMoEZH0y
 kHUxYZhxapP0j4qEb0LYILPbbxgf/caDBNazZwv5swL1ju2NdCG4rpgDfKaAmWuGfoYv
 0wf50Dpry6GJyWkcACRwFXt7HNWbtKRq5XcD0+3IM0IhuloAWm6EIM2W9lT4pGCbjBrw
 V0MlwFASibM56k1pr16yW9v7nySs93QxQt6nKICKC7e1KHDULjXps4HzmUIEqUxRgzbV Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c5bun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmnvW021048;
        Tue, 24 Jan 2023 13:45:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbr5pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODjZ3v037951;
        Tue, 24 Jan 2023 13:45:47 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-161-98.vpn.oracle.com [10.175.161.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbr5fj-4;
        Tue, 24 Jan 2023 13:45:46 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/5] btf_encoder: child encoders should have a reference to parent encoder
Date:   Tue, 24 Jan 2023 13:45:29 +0000
Message-Id: <1674567931-26458-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240125
X-Proofpoint-ORIG-GUID: 4DH8C4S4Gpyb5r29sHL4BRSi-Y2aDKA5
X-Proofpoint-GUID: 4DH8C4S4Gpyb5r29sHL4BRSi-Y2aDKA5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The parent encoder will be used to share details of local functions
such that we can mark those which have optimized parameters in
any CU.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 4 +++-
 btf_encoder.h | 2 +-
 pahole.c      | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 15a042c..449439f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -49,6 +49,7 @@ struct var_info {
  */
 struct btf_encoder {
 	struct list_head  node;
+	struct btf_encoder *parent;
 	struct btf        *btf;
 	struct cu         *cu;
 	struct gobuffer   percpu_secinfo;
@@ -1433,11 +1434,12 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, struct btf_encoder *parent, bool verbose)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
 	if (encoder) {
+		encoder->parent = parent;
 		encoder->raw_output = detached_filename != NULL;
 		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
 		if (encoder->filename == NULL)
diff --git a/btf_encoder.h b/btf_encoder.h
index a65120c..fd5a97f 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,7 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, struct btf_encoder *parent, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/pahole.c b/pahole.c
index 6f4f87c..844d502 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3037,7 +3037,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * create it.
 			 */
 			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
+						       btf_encode_force, btf_gen_floats, NULL, global_verbose);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
 
@@ -3069,6 +3069,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 							 skip_encoding_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
+							 btf_encoder,
 							 global_verbose);
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
-- 
1.8.3.1

