Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A011768FA79
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 23:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBHWyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 17:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjBHWyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 17:54:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605B12F07
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 14:54:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kwpt3010848;
        Wed, 8 Feb 2023 22:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ywwq9Y/KSov+6ClQUXW65RZv+LIzDSjcJ8ddMWqeyNc=;
 b=23P+toNWGae6QzdPAwgzBOVuKYumvAsAL9AfDqywJuwlntUVH8vzzdUgFEvQl9Me047Z
 YEomodJ7Ci4/Y7Xvr6jIoObsp+NixMP5k1W3gP790rnyhiM2o9ObbKZj1hhKtPCY9u2L
 UKUqthKZfKdcJEjlEJiDw4Z10QvU5w8tU/ldZFYu+6Gp/F5OZA5SWa4kqpgUJvszJir5
 tO1OlIkOsLBMZN9Qv/iKk9mJx4iek+ns68aDSMCyRMi1tEMSSXrbS3i1PC3e1wHf0GZY
 m6aOgasifQjzFTiVinYD7sUq8pjCRAPwxOYy3R5T9jZwRCdDo3J5898oMK+xIcIujfvt Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdsggm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 22:54:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318MY6QC021344;
        Wed, 8 Feb 2023 22:54:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt7w5yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 22:54:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318Mo0Ha039811;
        Wed, 8 Feb 2023 22:54:32 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-222-60.vpn.oracle.com [10.175.222.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt7w5ww-1;
        Wed, 08 Feb 2023 22:54:32 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: ensure elf function representation is fully initialized
Date:   Wed,  8 Feb 2023 22:54:28 +0000
Message-Id: <1675896868-26339-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=912 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080194
X-Proofpoint-ORIG-GUID: HoCpSvaOYVfM226xBgDfnbXTNOEkYR86
X-Proofpoint-GUID: HoCpSvaOYVfM226xBgDfnbXTNOEkYR86
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

new fields in BTF encoder state (used to support save and later
addition of function) of ELF function representation need to
be initialized.  No need to set parameter names to NULL as
got_parameter_names guards their use.

A follow-on patch intended to be applied after the series [1].

[1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 35fb60a..ea5b47b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1020,6 +1020,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 	}
 	encoder->functions.entries[encoder->functions.cnt].generated = false;
 	encoder->functions.entries[encoder->functions.cnt].function = NULL;
+	encoder->functions.entries[encoder->functions.cnt].state.got_parameter_names = false;
+	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
 	encoder->functions.cnt++;
 	return 0;
 }
-- 
1.8.3.1

