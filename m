Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A75A2F61
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiHZSx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbiHZSxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D686F2401;
        Fri, 26 Aug 2022 11:49:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDva5006723;
        Fri, 26 Aug 2022 18:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Go/210amZQ/jHvLyg4x0RO+A2enJkjN6+7/5kX6WJzw=;
 b=FTrAv+9MKAniSZjL8X9tKK7L4SuwwKMa7u3fqJorpJih3z3KygqH1YLhQUD+frm74/Ib
 Sf5SnlGahOTJ2fth5rUpjwu1LMjHAOUCuYNFhacym4Cuch7f6azeobTbOZj2qlHyOs88
 m50jOqLiaGadGMN+6hpkUcaXMtcYTwFXYo58g2yxaxOjAFI09gPD3VAou8l7apS+8J0R
 qOr8XrsKkJkeXc1Utr2dxGfr3J6GGtq4AWfyRe7arl9Y7T0zfWBGT2kOZ2XDg1odf+05
 qD9y4p4Id7cZkKuJHWHp1MQh+wQDPWMmQn3ApUFFJGA3Dfu+Q53SMrTO4MRDYrhG1AzE mA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p28j6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGnShr036168;
        Fri, 26 Aug 2022 18:49:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6prgx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yyd+amuSVqC4s1uAwoUWUZ01Uo+2RR+KUH/GL+4nxGprFqkptgGESgIPipwd0ShmdDrkojI3K7ZC+eXdVL0fvQbhSKkPm3bN1L9pxAiuJ6Xg6Qs9c9lFMIFG+QKow33xC8mPq9KmgTu2e3U0XoOkOs5xc0RYO03B+7PDHqL/VseUlpcCI6cgVye5UAas8cuUt41MPYPZgLmHOCSNp9RHLQsXQpRb6EqIw9Y1q8e7uGqXLxzgc3G7jfzo8er3kL83AcVrb7x/uFkuSZVbWa+7h8vmPiJuj3lrkMJEljsPq+HSbNKCC98sggg9i/R36sjwzaeX53YNCb89Vnu4Duo6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go/210amZQ/jHvLyg4x0RO+A2enJkjN6+7/5kX6WJzw=;
 b=iWlP1cEwZJI+MNpnNo+Lfr+VD5C4mG1NrL36jxkO0H7wwjHoaRkWnf+7WJ283T5PyX9LwRsg2XtV+gzbeNZVfzcTX5S4kN5Qw3Au/wGjMolyyKw65Jy4jeukOq6FtGnMFkauvga1ZAXpWYR2tdX3YZcwhDpvXwvxh0kg1wG3JoFmHafs/FRGI/NoTv18f4Sd3mxFmBGhcSdePxydqP8027Ks+9D3Hf4GXDNEMW3zpZQR9oMJJBG8bbQnlT+KiKsIvZmZzrgY4dbcOqh/+GBusnw/MnpefWml06rdpcUTNLC7kIR7xGO8t46huCGuyP7tAg+F+4xFmXPNpJVd4uSDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go/210amZQ/jHvLyg4x0RO+A2enJkjN6+7/5kX6WJzw=;
 b=Ht3vaZ78PmXlhj3AGEcxISsrBZpeuPL1bXOmJo10h4xt+NVp+Slk6coBNkPbPJVbLt8wvCJysN4Pco9h/eR90rF6IQn/8aDY/OTjEZtaoFUxkv/st7I7xn5KzYRkXBas2Qxjh1BxvHpboC6EnqobJXdBHbhcuo4ZhFeNFzjwTf8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:17 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:17 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 2/7] btf_encoder: Rename percpu structures to variables
Date:   Fri, 26 Aug 2022 11:49:06 -0700
Message-Id: <20220826184911.168442-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::33) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dab9bc8-e450-4726-6bce-08da8793ae07
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E48kYKM6cK1DDIKwAffH7vfV9xbDcMpLXxX5k1Rtb2AlFaZG2HHj5xuWv387VuK6ZwwTxa+NHQqkXmjlalaGQBzXgLmXgo+Fqgf7y+DuNIIeDWOt0P6RqrLoGIWCr4JlPRRvO76nEEf60g9QudvGqHnl+FbYQI4gIpYHs1+1xB0DgREBMu9Oy0eGNXOPCafj20dtArSS+XPzkPGHE4u1UB9c335p0Lc81JKBjF9/xWdNpBxUistxVn1+XD3bf9OZ/uaGAOl2++abTGMT8U6md92O17Sjohj/8Vj0HS9/KbIC0TUBTvLABkLl4K6KOhCh0fJs/jdZ3x2rjQA7q+bdexi8cE/NrUjxdHNx9ZVkuS0SZZSHEtNNiuakptTJTinBkKtVYmo2eZVhMotDD2KxH3Kto0u0ao/yRKUiUDrwSXcfgaumnWbLRKdNYOtCjJJ+qJyW0RB9zFKlr+XlaulwuwkLCJDXpBpmKf7phv55LkHq9bGlHD65aLQvMrNt/1qeNp+P5yB7eSCgld6Hn7odS37so3nUGuGHYQXQLGCBnc/KkLKCdiHUiVsmcnHvKbRW/yGTeyrYCpyJakMYQhm9+b6p2O7zFF3mT+wo11XH1hXyS5QlePuFju+UPIeUWNJFyzzyWRqeWfMNkng0DYftAWO13Qvf2YWHyss34v+4LT8fYypKolyF1yt96dN9iu5Ljqe3eAJgKBJ2W0l7s5FGNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekfsYNm7sZ7Qm2PU62L4L0HG4FgWzNdVf3pYOKxpIhSTVAE/93lXxTrgotPB?=
 =?us-ascii?Q?L5zmiPY/zfi3cdKJvGeBQmUpjt+rm09hTLe0zx8xX0esLcYloxdpmT7Sr/P/?=
 =?us-ascii?Q?WnVVpPY31v+zmjzGrhPN3lQgi9rmsTWQHPTpzWH/CKuLnfUxM9mVXuD9ctrm?=
 =?us-ascii?Q?9jOu00/1813Mdxa0cQAjUmP1vgSN/iA57tu39rOrrKL5jzfTzZqbnqQnwbkB?=
 =?us-ascii?Q?HurkSlOyGg3zZ3Cqs7QD9kRFY7kfzhkxJQq9goTrLkr/dP8kt7iyhz/ghHTJ?=
 =?us-ascii?Q?/BNuFQZKqRCVbCxwqFEcqhuIGrp97Yiek1S5jv6HREYpZKhjFHwovXig6R45?=
 =?us-ascii?Q?EKLYlOFsK7o+2vLtYmCq+S9Nb/n42xQmAFaQ/3EhNUIoLSqQhQ4pSql24YtU?=
 =?us-ascii?Q?6hEl17qoHGSgwbrkmtL1yUHurgxufkaoU70v1mVyMB51N5wXAspuMJCRaXvd?=
 =?us-ascii?Q?hhFMOOwMJqmj4G7ntUfLHhkioTKF2JMT6DQK4ZaT7xPsNYnHREkVJYuxOEgq?=
 =?us-ascii?Q?kP6dkshMNyCKzyD+o2eSMuIDdlcVMX9U3ZaRRDHV9EdbxQBE27lbSbTtJ1+K?=
 =?us-ascii?Q?SY5vYTxoUvfaP9OKQ8Rg8+YcncBsHBGiZ1/mdBjC75PjYLQyGPLfXZ98Vv7W?=
 =?us-ascii?Q?1xgj1obOGxz6zI5jMZhtqevIJIkQmRg91hUylE4chWxf4Mo4gDfVJmjiW2il?=
 =?us-ascii?Q?CAL+N5KgA0ktC6xi58mlfMxi83grLmz2E86bMWLuKogDjCvn5B/XINUT8Cvr?=
 =?us-ascii?Q?yDPro6tCf9034DScDmwguzOZIlUgaY8QyBVbEuBSMricVXiG8od6yX3S5JxF?=
 =?us-ascii?Q?z4TONhdqWIaKK14R4yC1k43BNq6hHC6XfE1JUASKXJMkWNPZFo0aANNZdFjR?=
 =?us-ascii?Q?VD6LhkrPx5fMZLVKNd2KYvPxckMMork0qQZnGbmnjIhS2Z6zuAnK1D2bq7ZB?=
 =?us-ascii?Q?wKYEaPiu0gh48IdhfCB9q1nh1vXodDKt5WV8XUGL37rUu5dFKP4YVLW9l0Cq?=
 =?us-ascii?Q?6OZh2yPwDnmS22ZbCmv/B6ZWRMo8gXN2OJD27WswL2uxfb5B0cEW78uTSyWD?=
 =?us-ascii?Q?vo8NDwKdjyACDtGSKt+RjS3L/aOuL/Li+GdLM0WOUwbLVVhUk6erd5+rVx+B?=
 =?us-ascii?Q?KkZco4t6lnZAIm/CnUS9lWcTdu23pNI4LSMcnntbT+Bk+4p1C69Ltf+rrVYO?=
 =?us-ascii?Q?SXkE8BzTHWYLyPEai7f6RRMok1b5mw/Egt8Yi1j3TrJVPjr0QZQyt5LWnh9s?=
 =?us-ascii?Q?NJLwAURWvpOXLsv2sfN94A5eMRUW0K6ZQRt4NBGsBdqSbVeJUdwAs54SO+ZC?=
 =?us-ascii?Q?4uCMgsF6kmGZbLqyZ5YTnDj9wYzf0gybqB1OrauOjAHZ1npaBIw9ayGvRg1d?=
 =?us-ascii?Q?uPd6YYpWVNHG95nfroX9HTa6t6+Zt7EBakQ4H7WfFrlUH652nHP39PCTRhFH?=
 =?us-ascii?Q?6E9+3PmQh1Rb94Qsu/FzBJFJzc8MQmw6X/dLLXFz1HzWGqbhDuuxxbwakkxn?=
 =?us-ascii?Q?rriyh1hcTOc/S3atSOOM7weJiO9T34ThtIcf4uBN9W+ui4RKCQGesELIq8Mc?=
 =?us-ascii?Q?L/ozsMRvewCAsZnFS5ytw6FaZAk1awbyPHX0U2QLGWaBxTCfHcWNuE/yjsYq?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab9bc8-e450-4726-6bce-08da8793ae07
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:17.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73UnG2X4V3LUtEqKhzqCkApMac6Egem2eWI5eDRBhwuHo6uL4v7BD2OYWZsVwHAWxvXhOogWCEaq22THjFwvzrCMcV7XMnkTWk6xtTOCXoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: Wrp2ek99jKENJQYVsdsxVuOq3ZJoRVo2
X-Proofpoint-GUID: Wrp2ek99jKENJQYVsdsxVuOq3ZJoRVo2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BTF encoder will now be storing symbol data for more than just
percpu variables. Rename the data structure fields so that they are
more general.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 54 ++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index daa8e3b..bf59962 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2,6 +2,7 @@
   SPDX-License-Identifier: GPL-2.0-only
 
   Copyright (C) 2019 Facebook
+  Copyright (c) 2022, Oracle and/or its affiliates.
 
   Derived from ctf_encoder.c, which is:
 
@@ -36,7 +37,7 @@ struct elf_function {
 	bool		 generated;
 };
 
-#define MAX_PERCPU_VAR_CNT 4096
+#define MAX_VAR_CNT 4096
 
 struct var_info {
 	uint64_t    addr;
@@ -60,12 +61,12 @@ struct btf_encoder {
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
-		struct var_info vars[MAX_PERCPU_VAR_CNT];
+		struct var_info vars[MAX_VAR_CNT];
 		int		var_cnt;
-		uint32_t	shndx;
-		uint64_t	base_addr;
-		uint64_t	sec_sz;
-	} percpu;
+		uint32_t	percpu_shndx;
+		uint64_t	percpu_base_addr;
+		uint64_t	percpu_sec_sz;
+	} variables;
 	struct {
 		struct elf_function *entries;
 		int		    allocated;
@@ -1126,8 +1127,8 @@ static int percpu_var_cmp(const void *_a, const void *_b)
 static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
 {
 	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
+	const struct var_info *p = bsearch(&key, encoder->variables.vars, encoder->variables.var_cnt,
+					   sizeof(encoder->variables.vars[0]), percpu_var_cmp);
 	if (!p)
 		return false;
 
@@ -1143,7 +1144,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	uint32_t size;
 
 	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
+	if (sym_sec_idx != encoder->variables.percpu_shndx)
 		return 0;
 	if (elf_sym__type(sym) != STT_OBJECT)
 		return 0;
@@ -1171,17 +1172,17 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	 * ET_EXEC file) we need to subtract the section address.
 	 */
 	if (!encoder->is_rel)
-		addr -= encoder->percpu.base_addr;
+		addr -= encoder->variables.percpu_base_addr;
 
-	if (encoder->percpu.var_cnt == MAX_PERCPU_VAR_CNT) {
+	if (encoder->variables.var_cnt == MAX_VAR_CNT) {
 		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
-			MAX_PERCPU_VAR_CNT);
+			MAX_VAR_CNT);
 		return -1;
 	}
-	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
-	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
-	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
-	encoder->percpu.var_cnt++;
+	encoder->variables.vars[encoder->variables.var_cnt].addr = addr;
+	encoder->variables.vars[encoder->variables.var_cnt].sz = size;
+	encoder->variables.vars[encoder->variables.var_cnt].name = sym_name;
+	encoder->variables.var_cnt++;
 
 	return 0;
 }
@@ -1193,7 +1194,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 	GElf_Sym sym;
 
 	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
+	encoder->variables.var_cnt = 0;
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
@@ -1204,11 +1205,11 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 	}
 
 	if (collect_percpu_vars) {
-		if (encoder->percpu.var_cnt)
-			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
+		if (encoder->variables.var_cnt)
+			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), percpu_var_cmp);
 
 		if (encoder->verbose)
-			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
+			printf("Found %d per-CPU variables!\n", encoder->variables.var_cnt);
 	}
 
 	if (encoder->functions.cnt) {
@@ -1238,7 +1239,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 	struct tag *pos;
 	int err = -1;
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (encoder->variables.percpu_shndx == 0 || !encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -1268,9 +1269,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		 * always contains virtual symbol addresses, so subtract
 		 * the section address unconditionally.
 		 */
-		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
+		if (addr < encoder->variables.percpu_base_addr ||
+		    addr >= encoder->variables.percpu_base_addr + encoder->variables.percpu_sec_sz)
 			continue;
-		addr -= encoder->percpu.base_addr;
+		addr -= encoder->variables.percpu_base_addr;
 
 		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
 			continue; /* not a per-CPU variable */
@@ -1418,9 +1420,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			if (encoder->verbose)
 				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 		} else {
-			encoder->percpu.shndx	  = elf_ndxscn(sec);
-			encoder->percpu.base_addr = shdr.sh_addr;
-			encoder->percpu.sec_sz	  = shdr.sh_size;
+			encoder->variables.percpu_shndx     = elf_ndxscn(sec);
+			encoder->variables.percpu_base_addr = shdr.sh_addr;
+			encoder->variables.percpu_sec_sz    = shdr.sh_size;
 		}
 
 		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
-- 
2.34.1

