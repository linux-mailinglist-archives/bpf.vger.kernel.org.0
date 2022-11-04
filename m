Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511FE61A56A
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDXL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKDXLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD53FB87;
        Fri,  4 Nov 2022 16:11:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KjBAx013373;
        Fri, 4 Nov 2022 23:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2mDDruQQ3d+FjQLfJs1t6LrB3gnIymPbDk58QYGvWng=;
 b=PknsttF/L2vWH2rCPFXr7XIZeckJCwfU8UIwVb0ng/XUWXXo9EfT0J3GWV5UyufnT/fd
 /xxEm6D1R14yF/beJjYbCnKbDbNfSnTJhyiXwK2thFp2y5LnZ10h5nyIei6OzVS3d2Vd
 OGfiT2rpZZVu3LgnSYfxt/QO1W5p52MWKS0L5IE4IiE7wIlrYT5yvPgubDPezpofGvFl
 /jfaxHPZ6J4QU+p7g1Nd2JqVEPK5fw4+PI6F4y+HkG5qyNEjYPb+7m1N0BqPS8IeeQzA
 GnE6AB4p8BMFSj8l1K2L2yqReBg55ngwEkGhj40BxYgGFfrLTYlhZuOBg4xqgsztnxZS jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2as1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4NA3QW013930;
        Fri, 4 Nov 2022 23:11:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr4t40u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgyXH6SO06B/IrkF1L5d27GMgCQkex4yMDzTIBjnGFO3CGforr5Bgxatk6aYrJT8BRkxwT/8EKKAii2b/19FGNhejkGB446x8ss2UAEwjo9gJtqBOGMLim+4sNC+WW9jGdoxLaWYT3jsbtie27QdOC8TvChOsOMsswwmoDL/GlMtE2odsDbDHBC4m4+EHUnJ648w29gRNBclc6mMj3WDUCp7RY9b3y3Ob8bxGfYKIsyKPWKcFdFSm1WwhJW+/TP7jNlxTCZqwENRoJYniIhaiA6kTVkAm1pTTHfKpjPHtaMgGnCh7Byj2dT0Q8JjaB/OhqYspBA8CD1I+4cyE7xp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mDDruQQ3d+FjQLfJs1t6LrB3gnIymPbDk58QYGvWng=;
 b=Ud98Bpewk/ENr5jOWFAsPnpRyNuIJjrfx+5wAyhCSzAMoZygbnaPpYtK2xjtQlkWVtGXZdF5lsRBPpWvK65tSQlWvSChJ1I9W19eLCRY9KsR4gkXAV6CGKHPhf2L/eshk9W3+A0EVhkK76CKKN25wzKTOKWR2NECVy7DnQmWUWS6CvkHyui62A4owelh6MVKdxZBMdSzHaaaJp/+rZCta3Ltr+R5CWPEmSykNJ3Vq4bdDkFjtXaUUbNPgYa8h+7V6qdiXu18yNO+VbETsCzj8S+8/BZGj8LaHwVA3E40GnCHUH6KNo+RsFK/y8D1WpfxqPcNADHDf7DXEmGTYL77fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mDDruQQ3d+FjQLfJs1t6LrB3gnIymPbDk58QYGvWng=;
 b=L8iHXIS06JXUF8LXpwMi2N/DZsOMHOtHeD3QtJWoDfta+6XDL1aFGf2WmfKnSxfcRBq6g1us4HFaAzTP8fDmBVNHrvd3FqtthuLaJxuLJN8hSk4FD9J5os41QyBP/wUEQH75m4GZa2Lf5Zm60iuxeDrn/p7qzGfVTLbw32PU6KI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:17 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:17 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 6/9] btf_encoder: collect all variables
Date:   Fri,  4 Nov 2022 16:11:00 -0700
Message-Id: <20221104231103.752040-7-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2869aa9f-fe82-43bf-30f5-08dabeb9e0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wa5SbN/l9oCzAIY3MWx6iQ88dwAT+rtigsH2NPCYCx/FdJBkeau5Xt10Ketk3Gp+RQj+4jpPTTkJT1X1Wtn1mpsOcHxLnQNebxI5AcJ3Xlsn9KMuYRSE6cbHKFK4/ld32yadSKZti0FMmUV5Q1tKsWUGK4bnIXfPEM0Ll4SOb1+wA+YZpi49t73y8Exw1UNEaoywok+ccnoytpahSF6BTVtEX7qaW1lebIulw+1PYhwBfN83fB4xC9zgd4ZrWmZ+dPjg8eo0MkwYFL/ynPNcgdSWE496UarhE/bi+nMGqPLf4mTkVKebxQCve0oL2ZSWkUsssWBIY4yY0yIKEhjdRqVYUubzzVCGrmWKB+uIghECjZDefeOui+jJ4f0PuWwAXXwEIDQuE7mJoaF6IlNnMufZlcMmiQnA/HD1O9nBUezfk03i3U3lziT9YNEB3zys8pqj3quAeE+yhdQEutSbHZCosVP8MHRtl15/+Nqp60luXdLU9Id48f1v0Bo87PXvjC3y+3CAXsHr72kMkAB4HnciIetBI0iylHgEsRKMvTdCqPbuVqxKFwHGnwLByC+RzFK/6TeNw0eZyt4/xSmTEBMCW+D08W7Kjwi+TT7zHdvnr0g7htFMtqc/1XxoLMukFnZYzXM62mfMhT1e88q3lOVKgpgV3iASPOOuQXrun+11fgKX2mRvyFLA9AYYB/w/0E9rxtE8p9qS0ZSmeaBBVlzEDfyWS8E50ziZqtYZBxUgidv6qB70YO8xnLNpxRg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImpMthO610HE8LCpwtXNvCx40s3Y6cowt6uwgzqv52zLTutZul7FdO6ggxoP?=
 =?us-ascii?Q?WQh4RMC69np1uoFzJkxhVWRPZPg9oNcGq38Fo2f7LiE7s22If72Ybs4wpqpN?=
 =?us-ascii?Q?k3XLPk2t9tKmy+HddAzRiiBE1UzQKEHrp2R/+pczXWkqM2ktoWvsM0UGc8XD?=
 =?us-ascii?Q?iSIsCVtvinBsfcLkspYEjQhrlwMRvugcT+8rZb47GupcR+BAH155CLwvADRV?=
 =?us-ascii?Q?E0XDshu2mEmZbHSgoezuoj1d+0kFfLJ0344JDAalYFy5/TsdBkNANFeIL7lM?=
 =?us-ascii?Q?31JpES7wh3p4FDwVRTekOFwPxR8+qcV4lak6+IDtxq2K3fHLfm112jUY/m7B?=
 =?us-ascii?Q?9GVgVFuiwVKVJC8baB8G1jj5Xb7LwEsWIY+fbEK2wUWZpS96fjyCCDG54pWR?=
 =?us-ascii?Q?abULq6gvuFCCE4mFI14K96WhiPqk53CNKJuae+tWRrEiufOGi/ChsEfF0WHV?=
 =?us-ascii?Q?PkyuIYni3iupz63Jtt0CffotAM1wmzLCscB45QDbnAynNTBIwLy24j07ZXm+?=
 =?us-ascii?Q?dB33yZjjX1Jn10d4zFbF5mCY7mhMDJVJaYC+GSg8LU6NVowXehiDixKBgVlM?=
 =?us-ascii?Q?IYgt9cGkIKLTtisJ5gm+RRskfgEfjsIAXw863p9D3s6q3zPUgseFbNluOTaT?=
 =?us-ascii?Q?3R17cRNVl+I9ZjcOwixWVZJ3uH4lrg4XwlrlIxZH0KnIQVr+s+/hAFzNBMrf?=
 =?us-ascii?Q?HEOZBiyVS+WIUQQvuI25+8lvDSX3VHHTsPTqLbnWu7lrf60XYno31jmxPLoW?=
 =?us-ascii?Q?dUCuVv1fuOiF8cqp4wM2m+hOetaBI7cSPSdEuU9WcvzrMJu928KFe1x160QP?=
 =?us-ascii?Q?ZoEETwJxPY2arqmtUygUpaFcl40RJLLX0PtvFmfJohXyOJF1qKod8yD1Uo4c?=
 =?us-ascii?Q?UsBeHRs28HwA8wJi+hx5NWUYtsHCgd7mECIO9LH7WSylxBH+VsPFOU/gDzOB?=
 =?us-ascii?Q?A2+zGN+mhJOofsG7SWFhlURN+nd/UYir3Q6Oc6yFhjSV49BXOzyP4qtMiHEK?=
 =?us-ascii?Q?M5eMzihPXi5k5jlsTqEBwcdn0/RaZDocRZFU6NOa6qvK38afmQNaOlHsOxp0?=
 =?us-ascii?Q?O5nkrcPkfa5MO030u4GiDzpGBh8pofK7Tqy+p6Ijj083cNe64hWztHZBckzI?=
 =?us-ascii?Q?HPRN4k0N3Zc+Z+pGzlqXnehf0woWu6wApe24v8jvtiwXJ6RUtp6ZC4leKQ/B?=
 =?us-ascii?Q?fjE7mLvS0QQ204rRdsYYg/1AcRmlUUB2snB7kGxq8t3jTOe2m9SgcBMwOfsf?=
 =?us-ascii?Q?lX23ZER3l1M0WxslpogVSpy8XbK5a1iJ3iNMgRUmLOgaSeGuz7vMcxrDGpwR?=
 =?us-ascii?Q?50srtnTKodOIFJ86lAoNPvwfhjR+TvyOQd2xFvyFAqZGXhdaxHb3+L3mVHEh?=
 =?us-ascii?Q?s+nWu208lit6n7yRqbQMSxcj6iLP5oHjMq5Th1aZyHIi0/bmOAj5pABPRG+e?=
 =?us-ascii?Q?TtTHVJkY9h37wzMjcKG3+wDRV96qgs2iA2BHeitm/U1WZEBjlXaDq694pBnc?=
 =?us-ascii?Q?9mp0ymC8wxKGdcqawF2MKTNyZrmDd5RjZ/GK7GcH6qlDT1K4gam4/89KRwGD?=
 =?us-ascii?Q?+TLtDl1TXxdOI6QYIzME4h92F5dySMcLReV2UVIAmlBIZpKswUv5X/hENqVa?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2869aa9f-fe82-43bf-30f5-08dabeb9e0c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:17.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkm080dgP/T6c3Ea2dY1pMyLa3sbLr1bLpkecuf/ZX8ZmnhI2o92Nr4wlg/TocTFRN2+YZyRfPgz8U0yGAthfJ0/PWw7Lr3pILCW+71KvUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040142
X-Proofpoint-ORIG-GUID: LLb8U3G1t-22v-YZZ_B5cc4fM5vnSJOp
X-Proofpoint-GUID: LLb8U3G1t-22v-YZZ_B5cc4fM5vnSJOp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prior to this, we only collected ELF symbols which were in the percpu
section. Now, collect all ELF symbols of type STT_OBJECT, and rely on
the setting of "include" in the elf_secinfo to decide whether to include
in the final output.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 70 +++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d1f2f38..f7acc9a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1172,7 +1172,7 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
+static int var_cmp(const void *_a, const void *_b)
 {
 	const struct var_info *a = _a;
 	const struct var_info *b = _b;
@@ -1182,28 +1182,24 @@ static int percpu_var_cmp(const void *_a, const void *_b)
 	return a->addr < b->addr ? -1 : 1;
 }
 
-static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
+static bool btf_encoder__var_exists(struct btf_encoder *encoder, uint64_t addr, struct var_info **info)
 {
 	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->variables.vars, encoder->variables.var_cnt,
-					   sizeof(encoder->variables.vars[0]), percpu_var_cmp);
+	struct var_info *p = bsearch(&key, encoder->variables.vars, encoder->variables.var_cnt,
+				     sizeof(encoder->variables.vars[0]), var_cmp);
 	if (!p)
 		return false;
 
-	*sz = p->sz;
-	*name = p->name;
+	*info = p;
 	return true;
 }
 
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, uint32_t sym_sec_idx)
+static int btf_encoder__collect_var(struct btf_encoder *encoder, GElf_Sym *sym, uint32_t sym_sec_idx)
 {
 	const char *sym_name;
 	uint64_t addr;
 	uint32_t size;
 
-	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->variables.percpu_shndx)
-		return 0;
 	if (elf_sym__type(sym) != STT_OBJECT)
 		return 0;
 
@@ -1262,7 +1258,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
+		if (collect_percpu_vars && btf_encoder__collect_var(encoder, &sym, sym_sec_idx))
 			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
@@ -1270,7 +1266,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 
 	if (collect_percpu_vars) {
 		if (encoder->variables.var_cnt)
-			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), percpu_var_cmp);
+			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), var_cmp);
 
 		if (encoder->verbose)
 			printf("Found %d per-CPU variables!\n", encoder->variables.var_cnt);
@@ -1313,17 +1309,19 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 
 	cu__for_each_variable(cu, core_id, pos) {
 		struct variable *var = tag__variable(pos);
-		uint32_t size, type, linkage;
-		const char *name, *dwarf_name;
+		uint32_t type, linkage;
+		const char *dwarf_name;
 		struct llvm_annotation *annot;
 		const struct tag *tag;
+		struct var_info *info;
+		struct elf_secinfo *sec = NULL;
 		uint64_t addr;
 		int id;
 
 		if (var->declaration && !var->spec)
 			continue;
 
-		/* percpu variables are allocated in global space */
+		/* we want global variables, or those with a definition */
 		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
 			continue;
 
@@ -1331,13 +1329,16 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 		addr = var->ip.addr;
 		dwarf_name = variable__name(var);
 
-		/* Make sure addr is in the percpu section */
-		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
-			continue;
-
-		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
+		if (!btf_encoder__var_exists(encoder, addr, &info))
 			continue; /* not a per-CPU variable */
 
+		/* Get the ELF section info */
+		if (info->shndx && info->shndx < encoder->seccnt)
+			sec = &encoder->secinfo[info->shndx];
+		/* Only continue if the section is to be included */
+		if (!sec || !sec->include)
+			continue;
+
 		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
 		 * have addr == 0, which is the same as, say, valid
 		 * fixed_percpu_data per-CPU variable. To distinguish between
@@ -1356,7 +1357,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 		 *  per-CPU symbols have non-zero values.
 		 */
 		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+			if (!dwarf_name || strcmp(dwarf_name, info->name))
 				continue;
 		}
 
@@ -1365,7 +1366,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
-				name, cu->name);
+				info->name, cu->name);
 			if (encoder->force)
 				continue;
 			err = -1;
@@ -1375,7 +1376,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 		tag = cu__type(cu, var->ip.tag.type);
 		if (tag__size(tag, cu) == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", dwarf_name ?: "<missing name>");
 			continue;
 		}
 
@@ -1384,14 +1385,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 
 		if (encoder->verbose) {
 			printf("Variable '%s' from CU '%s' at address 0x%" PRIx64 " encoded\n",
-			       name, cu->name, addr);
+			       info->name, cu->name, addr);
 		}
 
 		/* add a BTF_KIND_VAR in encoder->types */
-		id = btf_encoder__add_var(encoder, type, name, linkage);
+		id = btf_encoder__add_var(encoder, type, info->name, linkage);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
+			        info->name, addr);
 			goto out;
 		}
 
@@ -1399,20 +1400,23 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 			int tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' with component_idx %d\n",
-					annot->value, name, annot->component_idx);
+					annot->value, info->name, annot->component_idx);
 				goto out;
 			}
 		}
 
 		/*
-		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
+		 * For percpu variables, add a BTF_VAR_SECINFO in
+		 * encoder->percpu_secinfo, which will be added into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr - pcpu_scn->addr, size);
-		if (id < 0) {
-			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
-			goto out;
+		if (info->shndx == encoder->variables.percpu_shndx) {
+			id = btf_encoder__add_var_secinfo(encoder, id, addr - pcpu_scn->addr, info->sz);
+			if (id < 0) {
+				fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
+					info->name, addr);
+				goto out;
+			}
 		}
 	}
 
-- 
2.31.1

