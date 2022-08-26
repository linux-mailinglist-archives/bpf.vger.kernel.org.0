Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD75A2F5F
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbiHZSx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbiHZSx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0108FF23F8;
        Fri, 26 Aug 2022 11:49:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIEuOX020114;
        Fri, 26 Aug 2022 18:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CrThpEzg4BRhP5LveZJCjkZlGI9SHTu/3+Y2iSRdA4o=;
 b=jhJ1nAugxeFu6bWu62+auxfY+mPCq9XpRLhDfmVEB9G9wkkRwnf7ywusdeGg+kH8DRjU
 SgOimjSzr38wSIxhdZFhdRj7ajAh7jnV8fWqJ29Nk+h6P4Y6yxcfRthXHdTr1gOmEo6F
 oLPhR3TsZAkw2CiRjoA9WqSJeb0bwUSEfXQwrN1CM/KAQJ51l9gcTqvBtRFElsz+LMN8
 MftlmJLSHYBEuXIHvyj27ZHCXNND/t3rGoOl9EBwZbDOXlJSmtPBodpeB2dv5IXrKwrK
 xZPQDb2Q4JUpW9BiacjYj2+bl2sfWdA53DQbA2FQZmqq79/XutbUOCWyepM4YgSEmSD9 IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nygptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGm6OO033589;
        Fri, 26 Aug 2022 18:49:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6r8kd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEVdyeRGKxDYqVTrT+lr0/eATz81wnUOf2xs8i37nUHQ+p1/rKTYDJGEM4YytoydMLzVoHAux4ovzezUE12S/3rf6XMvj5xYrOkpZL0V1Ea8/USVXLUasAc4xmeLenqOXXGp1uMZPN4wViunQ0K7nR+Ky7XYoays0q0BdO4edAEehkO1B3JZ7rRn93NpmdbT4ejedCXUS+3sNEE+ZQ9rmwBWn7OeK/lzmDVripaZF8YJBYQtdvJgiyyUQhv7si9Hz69or221O/0hcGWhQamRKEaWWL8izRmncWuzw8kzTG58/E4pd7B8vUnsuvjDlIl0TKKGhiu5rCXgYEsmASZ8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrThpEzg4BRhP5LveZJCjkZlGI9SHTu/3+Y2iSRdA4o=;
 b=lz1+sfIW8dLB/6zoBPG4RwL5J3RXGcqGO51JYMyb7Lg/F841CNuu8CIyLMQOgmJtYQuFMfQAOAo+mG5lYr4IDKTfNHnEgEpItLi1ha/pwJlAnHziZlecHy2HFimdvVxKH6VYeylRhI2rZMMtjh18lM/znYc6vz0OibDmXJbgsuy6uFmmgneZdh60VR+rmEEeShRhPbcEUs83982+eBMHo8hg801ZDl3rPd7VzghIcWwkPF98lVmRANocRy+OtlM7+I2u/IxxArZIIW6C47aJqGq5f4y9MFoG24viWaI8LPS5QTFI/amyE5NReZoPG0RxSAJFkUygFQXPR5mtMEK6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrThpEzg4BRhP5LveZJCjkZlGI9SHTu/3+Y2iSRdA4o=;
 b=QxWKVhkpDs1Q2ux4vb7qVoAilyUaoRPsYQNCngDzKNzQxbBg7aVi35Ahz+cz6yHmWTDQ/zy65iEkGRHLBx6FeBDrIj6ZuI37LzcWHBU1On1JNQeVyyxgsHieRAQT97rPt7uURIO6AJhN8sgfZHKdGKTEkKpdV/e27X7IaE0b9oU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:16 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:16 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 1/7] dutil: return ELF section name when looked up by index
Date:   Fri, 26 Aug 2022 11:49:05 -0700
Message-Id: <20220826184911.168442-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dbac266-6e0e-4c98-e1a0-08da8793acf2
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3ovlRjoqOkpzdn1jPSsCrot68srljQXUu1Cpbh2PeNtwbgZYsc/hAEH3B/Dnqud0adZ9nZEMKrQOrPR7yaKun9wGs3ONSNkjPiEtfDPMi5aoZU4U1m/HRof+3Ddyb6FpCjQX5tRW10sehF9YtcRCthw82/Qz5NReTy1A+u2NItet7fDHCYqxi9u7HKhHFmt2CSdn8z1tjbdx6jnhe9RctrnkBmvZOaOv2qwctAID9z1bFygSZQUByFUWJ/153zljEo+ofTJ1sFZeiD6xYT7foWlXVsSaUgcgKjANjS2wkjTRuNZWwXrUP3taZVnzuARQJlkLAW9hF1uxLrA/X+Tm92TmxYmBPQgiJ/RFSG76aO1iu5KvW6c2UAz+k71RGPcyhs3pMxo6RLJ6/+Fg+BMEaa4PkWhexCVsmn72LFl6p6nec1kGY6XKYDM02Fn/q7c7m7bwTiKQs0M6+mX+6oyXcoohmv19l8u4Efkb5oxAv2ai4BXtPuVlBL+nkjKCn9FkCsacnLF5Z8Wt+qyqMIoE5O5L5ydTiJv/8RNw0CKpCEL8o8w3iBWQtWTJjEAN/rLUcjBAvmwxfFgNE1aWGUUU7QvkW0HgWdImjgGfNeh2Mn1QpMkaUVI/ZFdYT7QIeRHbnwgzspq250H8kRNNdY8vUOry3I7m4q7c0sFVRBtgQ2EPBQsuaxSpx77zH1dpaM1wJjncxnopeZzj3RczRgH4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqSqicF9399UAaEcIwJccm4GoPjnxj1QCxyXYhrIhUcbZ8kkuY00B1AQ3ciH?=
 =?us-ascii?Q?/vX3pfYADcyc6S0sdmrRC3do52zDAbsKk1BtvaB3yGnNmO95yS3B1tsCKYia?=
 =?us-ascii?Q?+4C5ME3XIOQ5c5T6en8LLbOH19V4TXfflhPXabJJ9TecM+TJowywQNI+DsWh?=
 =?us-ascii?Q?6KpdPbUXwDe+D9rdZNeV658GjBLXeqK/vw0SJqCfzLDcRNqlDXe/z8fDOpyI?=
 =?us-ascii?Q?fmhY+FZDHtxAd9K8FWJn1EnJ9N4pTor54RJhzATQ0HzCC668qNz7GIOrlWB6?=
 =?us-ascii?Q?vUOAv84wRPhNGFqkmWA94t7bK9AQA0q1iH8uU19MLCDlViZs4Y8RWcrqU2QE?=
 =?us-ascii?Q?c3T9N54esLOk+T+QR1WsiqKTPdLNawkHekYpY+lY73fP1wieKOFw0EoaisGC?=
 =?us-ascii?Q?EpCSRmrFKRme9whmvEV+5MOgnI2MlYO0jih1clOw70E8eBfQ/9NpEsB4SplI?=
 =?us-ascii?Q?+d+wrFo3op6iY753r0SXsCn2WkLuyI+xlENjoQru3/I4EpjKRSdSkDuWVYm9?=
 =?us-ascii?Q?6RYzOfjin4HZ7UfrycFF4oFuTAL0zfZrnmTLYtWwP2T9ACgVU7qcDUM7qprk?=
 =?us-ascii?Q?HRIqQXo+J7etlVaffphATUThAJDc32CSrZZ7asL0fBc7LrJkfXW6ms8IsM86?=
 =?us-ascii?Q?7Tvj1kyNgnPrwuI5hIKCwEEazzrkECFN9eLRISPbllx26yCn0OIrJRtmXia8?=
 =?us-ascii?Q?igC092A/maawkpGdVn4oB7rQN3sUTstSa/h68loqGK2cvXAr5audL0hHRqT2?=
 =?us-ascii?Q?QvBe4GnwIY0zm+anMPi0oahj+eHKrSynwQzlT6dh5/nZcsntGzgaB3QJdmMZ?=
 =?us-ascii?Q?pbN4OD24SwdvoF2QHxMtkkzCd4xpgiTQEKXJy6vkdal0mPVG13H48aVE61j7?=
 =?us-ascii?Q?rCqn3/kF4+/So/SXCy9ch8Pha6PuMc6xA0IJUdOMG+BQapn/hHt+XsYGArzi?=
 =?us-ascii?Q?ZTGGO6Txxc4s02bcnI20l/X7wGHsfRu8qHcm+l8kehKhQToYYrHvePkTbzA+?=
 =?us-ascii?Q?asvLr3lV1eX5UJWn+cgSIc6DCzV/XxP7W7fFxsyVwj++2h3GijJxLNElhsJp?=
 =?us-ascii?Q?CiYwthVtwVgj4tvrVR6FwMbLQHJ2Oh1n0DBaABwtYMWZOA69621zhtI0FO8g?=
 =?us-ascii?Q?nTY0GRYMcYonA4CoWpHRf0zMRDETFnoHrYPhax3HadDdt9t8AkqPR/gKIAdD?=
 =?us-ascii?Q?j7zJdPQ7YKeOghG8Mp7sjY8HL39bKKWRDTP6LfNeQnvjXp00SiMBBXE9CQOe?=
 =?us-ascii?Q?d6emyLcUnc92z3iVbrpK4QwQ/rSLoHMA+OBaxM1TvKhirknxnGU/EhPrGj1u?=
 =?us-ascii?Q?RYrFahaqmZZYGHlEquJotoXC16OdHzNGYb3o2bmF+AfymZhBDgkjqN9Gq9ql?=
 =?us-ascii?Q?D7EzZyowEBExnJB+Hqlsf2mzR+qJ+vMtAR09pj9oIp1EDNVjPlmBBVKLjtnw?=
 =?us-ascii?Q?up+Qjqc3Ea6FapiXNbzLq6vGfJCZrKNQwBIxWcH2LuHfi1Mc0mfiVv5Rw9IR?=
 =?us-ascii?Q?+/bHke0QUxWcONdNS5LYEekBbEIfxJe935DDsZi8e9EefoX1Dw+/wM2dKW+B?=
 =?us-ascii?Q?skqsFI0IFUw1em1NlIIdzxd0MwByxHzWlAEFvu/7hSCMIes+3ON7QXm6v8Aw?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbac266-6e0e-4c98-e1a0-08da8793acf2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:15.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqw8bZ+yS06r+hw2y3AgRa1MMCdzmL8dgC47V5AXydOLRy7ynyWkBGe4eii84h3RywHqkQbZJ7SdTQgkFlKVHFwNa/JKlwBH5g/H5ivTRl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: iS6g_935DJecx2sZm92w7Uf9zKz5ib8q
X-Proofpoint-GUID: iS6g_935DJecx2sZm92w7Uf9zKz5ib8q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dutil.c | 10 +++++++++-
 dutil.h |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/dutil.c b/dutil.c
index 97c4474..a4d55e6 100644
--- a/dutil.c
+++ b/dutil.c
@@ -2,6 +2,7 @@
   SPDX-License-Identifier: GPL-2.0-only
 
   Copyright (C) 2007 Arnaldo Carvalho de Melo <acme@redhat.com>
+  Copyright (c) 2022, Oracle and/or its affiliates.
 */
 
 
@@ -207,13 +208,20 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
 	return sec;
 }
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
 {
 	Elf_Scn *sec;
+	size_t str_idx;
 
 	sec = elf_getscn(elf, idx);
 	if (sec)
 		gelf_getshdr(sec, shp);
+
+	if (name_out) {
+		if (elf_getshdrstrndx(elf, &str_idx))
+			return NULL;
+		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
+	}
 	return sec;
 }
 
diff --git a/dutil.h b/dutil.h
index e45bba0..2dcf986 100644
--- a/dutil.h
+++ b/dutil.h
@@ -328,7 +328,7 @@ void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
 
 #ifndef SHT_GNU_ATTRIBUTES
 /* Just a way to check if we're using an old elfutils version */
-- 
2.34.1

