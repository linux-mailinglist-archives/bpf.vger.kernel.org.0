Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100A068DEBF
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjBGRRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjBGRQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7673E63F
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:16:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Gns9A000470;
        Tue, 7 Feb 2023 17:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=snKeriiGA2pAFMRQpKK+bUr69rjXvxtjwCvtoBdthhI=;
 b=iwSpbUUUMNr1jdriNdMuwMpVrj+MYq/oQmMGN2cR9827Q1vMT42ctLTgugm22UYAH3N0
 cFOLsR1sq6t6HAocH32deKXs2yMscFJZktUZiWScFlF7GvfTjQ+5Y6SjA22B5yqLYkRN
 d+FeUei5eUUg8vtxFsT/e5aqquxtiV2KnFNuXdzmiFaSFAIQCNwmHttYWBlea1RZ91e9
 5+oavVNDYUuEcCnOrjwgXr5xRpGOwf9e1WmrDh7pb9te7P9cGN/F8Yp/Nf6LmAcp/ymO
 GMKYtwSWM00zcUmG7fNycCy5aS49r54PRDEejs9OWn24MsWS1kG3bXpQFBE7l4fhhXZG Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy165mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GWgYb008568;
        Tue, 7 Feb 2023 17:15:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e8f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gc007936;
        Tue, 7 Feb 2023 17:15:38 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-9;
        Tue, 07 Feb 2023 17:15:38 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 8/8] dwarves: document --skip_encoding_btf_inconsistent_proto option
Date:   Tue,  7 Feb 2023 17:15:02 +0000
Message-Id: <1675790102-23037-9-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070153
X-Proofpoint-GUID: 2j34l7y7Zvr5NsUvbQqk5p5LL97l5SGa
X-Proofpoint-ORIG-GUID: 2j34l7y7Zvr5NsUvbQqk5p5LL97l5SGa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Describe the option in the manual page.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Timo Beckers <timo@incline.eu>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
---
 man-pages/pahole.1 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 1a85f6d..bfa20dc 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -229,6 +229,11 @@ Do not encode enum64 in BTF.
 .B \-\-skip_encoding_btf_type_tag
 Do not encode type tags in BTF.
 
+.TP
+.B \-\-skip_encoding_btf_inconsistent_proto
+Do not encode functions with multiple inconsistent prototypes or optimized-out
+parameters.
+
 .TP
 .B \-j, \-\-jobs=N
 Run N jobs in parallel. Defaults to number of online processors + 10% (like
-- 
2.31.1

