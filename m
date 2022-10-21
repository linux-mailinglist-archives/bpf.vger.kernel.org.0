Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3F607A0E
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJUPCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJUPCZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 11:02:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592772250D;
        Fri, 21 Oct 2022 08:02:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LD4qJ6016588;
        Fri, 21 Oct 2022 15:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=cbzQlmdyn+pS1z6URGMPjcCqsBu3TL5vN/BBm8MMhEU=;
 b=1wRsrGjUYCj356II2xMnhBsIeBDn/IFcf5R+OCkxIvkvjrf0XQEz/ZGV4E5/7V56SbDy
 vDl8xbHCdnza6Qw04LVk53L3PIUwgztmaPwu0OoAtuhhS7nmB96mypADLZJAV84DY5pZ
 KSrc8tsljFV3BcjgSRjptzPLpeJhv+Sii6ZW2Uc4WhZscxijf7ynezxhCMjgl3ytl8i0
 0ZjY3ucUhy2OTnzHQd9BelPU0hhE2ftS/iYvTRFD1yM7yKmm9X/9K0ruUk7zZirC1Pal
 GoaCE5TsJ8zdGdzyym99saLQVHO7p18sSKuAkztjKNbNCgMRXWz22rKVdnS7z38uSSib +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntmv98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 15:02:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LCrDVx014834;
        Fri, 21 Oct 2022 15:02:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu9tup0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 15:02:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29LF26EI032219;
        Fri, 21 Oct 2022 15:02:06 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-208-221.vpn.oracle.com [10.175.208.221])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3k8hu9tukx-1;
        Fri, 21 Oct 2022 15:02:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, dwarves@vger.kernel.org
Cc:     jolsa@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] dwarves: zero-initialize struct cu in cu__new() to prevent incorrect BTF types
Date:   Fri, 21 Oct 2022 16:02:03 +0100
Message-Id: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210090
X-Proofpoint-ORIG-GUID: LyK3FFLvQ3YYda-ixajuYUacGDeTv4yb
X-Proofpoint-GUID: LyK3FFLvQ3YYda-ixajuYUacGDeTv4yb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF deduplication was throwing some strange results, where core kernel
data types were failing to deduplicate due to the return values
of function type members being void (0) instead of the actual type
(unsigned int).  An example of this can be seen below, where
"struct dst_ops" was failing to deduplicate between kernel and
module:

struct dst_ops {
        short unsigned int family;
        unsigned int gc_thresh;
        int (*gc)(struct dst_ops *);
        struct dst_entry * (*check)(struct dst_entry *, __u32);
        unsigned int (*default_advmss)(const struct dst_entry *);
        unsigned int (*mtu)(const struct dst_entry *);
...

struct dst_ops___2 {
        short unsigned int family;
        unsigned int gc_thresh;
        int (*gc)(struct dst_ops___2 *);
        struct dst_entry___2 * (*check)(struct dst_entry___2 *, __u32);
        void (*default_advmss)(const struct dst_entry___2 *);
        void (*mtu)(const struct dst_entry___2 *);
...

This was seen with

bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")

...which rewrites the return value as 0 (void) when it is marked
as matching DW_TAG_unspecified_type:

static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
{
       if (tag_type == 0)
               return 0;

       if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
               // No provision for encoding this, turn it into void.
               return 0;
       }

       return type_id_off + tag_type;
}

However the odd thing was that on further examination, the unspecified type
was not being set, so why was this logic being tripped?  Futher debugging
showed that the encoder->cu->unspecified_type.tag value was garbage, and
the type id happened to collide with "unsigned int"; as a result we
were replacing unsigned ints with void return values, and since this
was being done to function type members in structs, it triggered a
type mismatch which failed deduplication between kernel and module.

The fix is simply to calloc() the cu in cu__new() instead.

Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index fbebc1d..424381d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -626,7 +626,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		   const unsigned char *build_id, int build_id_len,
 		   const char *filename, bool use_obstack)
 {
-	struct cu *cu = malloc(sizeof(*cu) + build_id_len);
+	struct cu *cu = calloc(1, sizeof(*cu) + build_id_len);
 
 	if (cu != NULL) {
 		uint32_t void_id;
-- 
2.31.1

