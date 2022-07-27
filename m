Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695E9583437
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiG0Usj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG0Usi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 16:48:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE74E84D
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 13:48:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJOaUg029853
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 20:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=gs0//ISdEkSJ32LzSulHn1hhaiisWPYKEhISLnq2zWs=;
 b=d5vBT/NEBDsfPydTHKNREOQiRkYPKAWiEzd1AETRsTGRtq+dgH7QATtAOv1LtaxnLD6z
 0vv3v60x9I8jG5o3NePRW2woVTzrC7uqlDgC+swfeGe7GNkmaHbsR1uB9r7Ld7rtuh8/
 bQAygYsIN2VpZhkVfjvvUyH3Zu07ufhMkKWbj6Ya+q23o22RjA/BwRSQkSayByTIsyUJ
 qNE5CKt0KYkXAFOKqtwNK5wfXSa7IfGnrMVcTu9FP7r9hJQ+QGmlgPitTxRPb5Py8GgU
 u6UP9dRF3ESkn3zgRoxHIjOYl7Isdhc0YL5S2WhDcSlrICzT6m40bN8+SnAHKQ+ugxg0 ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsu7kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 20:48:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RINAZj031521
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 20:48:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64tvpt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 20:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFP4xjLsuGldfVzUWIh5iPDrGwQcbNLtL20Gfuc3OALzFgKRAuatsg+V2968BoxIMI0wzhdogimNiu50KL7Ryt4dlnQGaGg0o+L7CRAsfrWfcboPM2jYyQ0+jJsM2XSCy579Rt8EYU0jW5BAqrezRYuccNY6MPRWCh9ugJ7csllq9qwW/0GIQQldyG9vHTGhZbUaivQpoME8x9dPtWq8gboCcbyqKuMgYYhZRM0BUuLaO/xekDY0RQoUBlVgbbtMES/7CojkEnY0sfAUt2GWEzZVw5QLiGsy6ruYWynhKbi5tyF8W0FF7VSxrPU9uHx1HbOi7Ow5UIlCbBKsMboa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs0//ISdEkSJ32LzSulHn1hhaiisWPYKEhISLnq2zWs=;
 b=TiGplvnFss44klTdYhf6Aiv7ay/4KJg1wmChlnMkCPxQ55XkNi1iZclJVaE5VJmALoDZ3clxApxva4Ih5JWbzE6X35NEEkh72qdyd2yJMxbQ5mvdQa4Nl/roYYE3Fjw+00m4vjOgHSQeAhDhyed7j1Z/ewBUG2HQDXv23uslrqC5dFnFHtSEnG450JitXnmjbBHkcqVbNO6zGRFUDVwPE4i3U6aXdR13xSbUCTAT7PhwHRX7yoeSLTVSBXN+1wGu1f7TmlAhaMqS8EtelZzlhnW1yh3Akt3SFRvSpl3Drs418fwi8/zaz3rEmperw504dplQARss5p9qpZsZhyHjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs0//ISdEkSJ32LzSulHn1hhaiisWPYKEhISLnq2zWs=;
 b=S3ldvXrAdkrgeguWVmwRZwqiXRfU/Zl8hOLA/NXJreEohGKB4+q83QbQc8qsVTcqgFJCYZsXuTVyBLvyKrqO5iu9kdE/OJfbLhCF4Yu8wBIVCQRRjR6oPJhfQCh+qaaVIbIvR3bpuPb8+1W8mK1gP0GIlmgLKjFKwqVxE5UbaRs=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 20:48:34 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::b18a:39a6:4e0d:de64]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::b18a:39a6:4e0d:de64%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 20:48:34 +0000
From:   David Faust <david.faust@oracle.com>
To:     bpf@vger.kernel.org
Cc:     david.faust@oracle.com
Subject: [PATCH bpf-next] libbpf: avoid mmap for size 0 sections
Date:   Wed, 27 Jul 2022 13:48:08 -0700
Message-Id: <20220727204808.13210-1-david.faust@oracle.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:4:60::28) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f7565d-1bd3-4b45-1231-08da70115f22
X-MS-TrafficTypeDiagnostic: BLAPR10MB5347:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2c6JVgSAx38zlZd96NTfbZbjg/kaftyck3wAB2M/ggidGrIdFSnsqtjOedmhKzVXaJyiQd+MqSfXcGORNm/dHD4y06kKnrm6+d4ZoGv+00Wl2SexGUWr0rC+h2Ova7ubj5tnlD0BLG+sBj5F3Lp++6/724Fe9oPCT1cmX0lK11kZ85Hjp3jK9xsdTjkWOilLRS9w1v2f/LiXggcX057GFDxCqLbZOLOCaVGU2MhSQlo0ooMUPLHcCWPMrLIIHkaBhbjRdXdx16e4FnT1bdS7m1eaSYCTG+kOm8AfvXP6ctCsaADF1JyNWtEvz8w1DAYAvCe4Td5mquVTe16O1jVWNkbdqmrrvulKc1aMikd2ChtvQzbpcwDM24iuwQ4MvCJ1N9feJYhGNLQA/hJoAkswaHpqQz1TqDjncQ55MRw88KMF+z2/teFMRMNckOuF6ZsYaI2IHfIMKOWLeasmWxuProJf5qBXZ+1+nhtmrk/OiuD+Z09J68oZXP5OicdScVqCjN5xVU7kaKMe8K8OODX4XsgXUGnz7ebbBVMEhmZGnFWfNeupCjpmvGh6pmOc2TDc+zBSEozID+sAAtSYUiEpgl6rFmUwfSRPA1iN7IbEfIL5niK9eqSDOVQf6gr7llmRuNf5yAO+hh5slnypFVrXB/yXq68GGC3qLU8M1NObeZ0NrFVSKGxi0YuPSOitDajDzscwjad5K7qkYz3wznFhqYMgjAL94MGowGjzq9d9821QjEnlU7kGYp+G9OuYm/F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(346002)(136003)(52116002)(66476007)(44832011)(66946007)(4326008)(4744005)(8676002)(66556008)(8936002)(6512007)(6486002)(5660300002)(2616005)(316002)(6916009)(38100700002)(478600001)(107886003)(6506007)(86362001)(41300700001)(36756003)(6666004)(1076003)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKXGTmocnbMnn+2OcpsnIzfnswQmqYHWmS2J+fLrhWfGRF3i/R00vwFAU2QC?=
 =?us-ascii?Q?TXZT5vRtjAEfeOBT8ho59DWn7PlcPgUnyRoUm7bqr0XPP9lYOFmgq3+Relw6?=
 =?us-ascii?Q?aht10DK569XVJD0t3xxqK7ZCPOAGv8bBIx0037aCsXMFgW82+ypgX4ExooKT?=
 =?us-ascii?Q?0vTRmwLtlWi6TW92SieW8cZhlSW+w/h95sGddPOW3T+ONRU+yql0fjmHwOF+?=
 =?us-ascii?Q?AXtbo5YLMGfvPpaS0dCpE+OUqUV6uoebwb2dsWZL7C/IQ7rLAVUcPninxjzz?=
 =?us-ascii?Q?gzQTBCEjig8u2VBXJz1tmbP/q9xOext8m2qFtUzltM6a+U3tQmNMHhcBNJY3?=
 =?us-ascii?Q?P6uC4w0bwBXbmBHX0tVTQW1sQNCykwRvsEFcCq+RtWrXZVT9fCkZ5wk4PNHF?=
 =?us-ascii?Q?hLCd5YrhwBqM+RCDa/nYNsfJGHrG27x/EgSC7MYkIjyZ/atXv4XaKYwAe3Zf?=
 =?us-ascii?Q?W1zXIKiGh3/VhW8bO7mUZIk7cCDJHH00SoQXWiLSes2GQwwU1eXEx6wlZozs?=
 =?us-ascii?Q?QFCfZg6pMWuT/SDzLIN9nv7mmdU2SP1wkKR6qnHpiZFI/74MkTYitP3zueZA?=
 =?us-ascii?Q?S3HXtCzsC0wd8UyGzDSYooE9GQTx+6FkWyoLiITI6raLhfMqnSgIGu7AYVNR?=
 =?us-ascii?Q?q4cCxLsm9SE1PornM/ZmOmUvF+eHPSwm90tJjo/ekDOIyz93A7zItmgICVO7?=
 =?us-ascii?Q?5Jmb/CYoJ/4Ct+9wuvkdRhlk6bTsYkxyjPZMNtN+ATxxqKWd35ureD6+dFF1?=
 =?us-ascii?Q?K8npTGnLrTO6XSkJaVTR1VUI5dH+dQMbIS++WQxVxRUUxXD3EG5V2TI9fokp?=
 =?us-ascii?Q?2Rq3se5G2zkUBqDE+GEi6wuIwAqZeBBwzk2sfDIucPfrgHo4bNHAZIsah8U5?=
 =?us-ascii?Q?64qiZ/mIY68yy+I2Umq7HoCTSPLYQbe6bwvyoX3WYbkVzqP69lKKVjRjdNSC?=
 =?us-ascii?Q?Eg21+0+X74vsB/NmitZSq8iqf83WyjqT6bImRfG1aI0A9aUf12+34v93oMxZ?=
 =?us-ascii?Q?MC4J7I8gy6yyWgvnqIMRBJHlemEgOQXJJ2uWFmN4tvSe+/eD4Z+WyGTzE+pY?=
 =?us-ascii?Q?WDAl8iO6ZXbI2mA50tVCRY7x93Pou1aNA2ukvCr4lCwl+TIJ+oQKBb0trfSy?=
 =?us-ascii?Q?VxbJKzT0yP+o2MjCLJDrSU9L9tRXN4HZ3y+j0Spd7FXEXo0gClQYFdtbKlii?=
 =?us-ascii?Q?kDUrnfk8R3di1F/fCTxHTgCDxlWhMm98MEKCtufou/GYQchrOYTDRBaJpGX8?=
 =?us-ascii?Q?4k2JAWzx0MrlgJEuJEtafyHUVEMzF5LWpvmfPVTi5gUOQNEHgopkLDLSI61E?=
 =?us-ascii?Q?O+5MS9UXDOm6KGV7hs7prnkGQpE8aYwvIOuWjad7xcEMCdUhuSVIjycfQV6r?=
 =?us-ascii?Q?hlQpvuky3bWW3vAFmipWUMGbsYuA3/HpzMlZGOo1ReanjeTrr/YmPBhKnkHW?=
 =?us-ascii?Q?vGZ5RpzyHerdzEHi3K47frH9BAuHPa5v6bhZuDpAAMRVZXx9dL4gxrGjWNhM?=
 =?us-ascii?Q?O7e+HluumZOBlCO6Z26yoiMGNJCBPX2aGevot/CW7JkvAUcu+0DWKJqHhOaB?=
 =?us-ascii?Q?LLh/J6dnpJeS8EslnHpqu2eWwJ1knNTGZ7UmQZHMYHi30mXkbzehrhb+UU/g?=
 =?us-ascii?Q?HdhEFkYzXimytxdXX+ONdE4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f7565d-1bd3-4b45-1231-08da70115f22
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 20:48:34.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chgHc2vr3ZOX5ULiKch3AXl4Vvv48UlGFF5tILOOzl2VZw1azegqaEHun5m1bvQlG6Tq3U1EE54vP9y72lzjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270091
X-Proofpoint-ORIG-GUID: ikfsJYjmTYbFw39DS9mu-LeYb0Vj9deQ
X-Proofpoint-GUID: ikfsJYjmTYbFw39DS9mu-LeYb0Vj9deQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When populating maps in bpf_object__init_global_data_maps(), recognized
sections with no data (e.g. a .bss with size 0) lead to an mmap of 0
bytes which fails with EINVAL.

Add a check to skip mapping sections which are present, but empty.

Signed-off-by: David Faust <david.faust@oracle.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b01fe01b0761..4e7ceb4f5a27 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
 		sec_desc = &obj->efile.secs[sec_idx];
 
+		/* Skip recognized sections with size 0. */
+		if (sec_desc->data && sec_desc->data->d_size == 0)
+		  continue;
+
 		switch (sec_desc->sec_type) {
 		case SEC_DATA:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-- 
2.36.1

