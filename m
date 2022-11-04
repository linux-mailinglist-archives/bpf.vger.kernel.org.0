Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B361A566
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKDXLQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKDXLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E62DA97;
        Fri,  4 Nov 2022 16:11:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KhvCk026462;
        Fri, 4 Nov 2022 23:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=57Y33Ql7G0ZQhSLfkJnFQR+BgFa6VrYeTYMVVAgeDro=;
 b=taNUfKkSkAL2TAX/pV1lLQ6YDruuJozph9qR1OpI+c8+1PK1qwk/qoWh9g+Gb20W96Ee
 0aamDF1nHYmL3hWJmW+X51n2hN/qikRHpPgL+QNYFYccNwA3jAYv0X0xL5Xzze9+9b6O
 V8cYB87QHR5RNmLhN+wRfsDxdJYa2yZOv+EIgt/I+ubUkoLRBn6+DflX2j10EMf8Wn9Q
 85gTDyg4LXol7W7nXGTmzNot2UzafMEiGXN9ZWGmPYT0wT6+40WSXZXbOyHpveWkxTjw
 Pfg5Z5AHr5Af0Ly3amLpHo7vo3EhStjFNpgJUhMWlZy4NkGiRn7nPreNiQ5JBHZwF6WA QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkdgend-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4MM3o5013931;
        Fri, 4 Nov 2022 23:11:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr4t3wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duc/tVT9UY5hx1dkecld77EnQxPM/jYuCStRvhugq7FQ0CTPSILAw21A3SSqlBTpEWnKg8lWl+VVDi2smDijCe95GHyqetxVQOvrLKsK5A16/TcXCIQxWd+EvlLsMdzIOws/dOkEP8SsRBm5S81P3XWgOfrJiKXhVTKGsIL9LerRlZk7k/HqeXGyVU+nwAzuoTO0FLCCx4Edl+ZaG/MZwnSiAnom2XpfZ3KdnQUp7XdjzA62xQ50lQPMQr7XnJBFuym+5V/QfPyPwVvimlIFSFJBjWMAgvT6rSha/XZhSO+jG8aDX/fBBxAr0JTMBUdwBSwPWTMj9If/ySPw+MktOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57Y33Ql7G0ZQhSLfkJnFQR+BgFa6VrYeTYMVVAgeDro=;
 b=XJQ2vcDtS2ev0h7SUb+fz0C50eLbt72160lk+qnmd8rJ9HoXeLy6K6wLkTykdzhKBKU7jZzTVWwVPwF7VNaAQWuQV8Khc8cBCLqDfFgsbeWhnT8ifvNgDv6wHbKFnA8ADGc3b3qjKz8pYS5PTPHG54d+Jh0DW9kVyoITnlrwDTPPv+D1WIaxD9b7hXsU7Ntbt1N35mKupUgXZ8MVO7pR30GckTZnPw6knVvXhXcvlCCy8ar1q0WbaMzgLBX8Gpwor4UTjoS2XuPrgXY1Qu40m3n1tbXpMRAZUufzJ0dLI+jNuToQWf64BU6lPc06V6jbX0+N4GyXCxrP/cNCgiurjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57Y33Ql7G0ZQhSLfkJnFQR+BgFa6VrYeTYMVVAgeDro=;
 b=zPTbY0po0lNs7Zelu59G2P11RG898HMda2JgfE8VpLXxyCoSDWymXA9MJi8CeFzBjZlmxjYCu4Zr2OHQR8B8lIgioSfuV4SllVVLk0vo/Lq1SFiuEnL65mezFy+dSasnGmy5FoJNRQlc53N+3EtkZ3yrXV1Nza8wm+2KhNnpfAc=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:08 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:08 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 2/9] btf_encoder: Rename percpu structures to variables
Date:   Fri,  4 Nov 2022 16:10:56 -0700
Message-Id: <20221104231103.752040-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d54e16-8dfb-4c51-fe32-08dabeb9db11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy6Rnst1RPyFeYkaEHlzZJ3NNgE7oKTG5F8ic8eVPbqfWZUfFberO6z1gxwMVtegtaqjDDAzctMXk1oxX7nAORnZZ7Xq6l6V/NJErLGb59/zeHPKHHRqAXt+i068Rxn/4Z4Sp65ZawjcH+Tqp3GJ2xoGUQ9i5ZKZKSg6Yo93zjes5oEY0xN1wfLbE4eG15OEYPQ4faNSAKUHApxm/BuTxow4jgZ78cVLfzMaCi4dsIcaQFgtxo+uDoTzhSnBeYhNiQiD8RSJmdNGEQABS6w/fIPZBx8B4qiiB2YqGgUMsfSrAKC8uCnGg+LO/qhW3Ly9QIbdBKzZ2M5PJOB9B2NjmGKyMndhKMSsumvAwDZRUg6xCYi3EhI8ig9QWxlXninSnTfdRKN7aMlw5OywAJQ0Gp3qeAyBE3e8Gtno484G3ADR0lOH2jX+T+9JNxH5Bhrz5Po067hA8dNBWSn6fLMcTJNK0RJyoAKAfjrlqTsYln6Wz5K3uoJw607f2q5TS7cLZFwO26CGG8RC/MbG5RGSBNscqKjVbVThDnNxumPVEmCNVc0rzJMkS1n2DYz+3Iv6XnZsUnZzUNsFkdg0t2xV0FjRFQyiuLLm7ILClcBw9RNFPULmpmytlvKpY3PIlkvzr68h4FPlKb0kA/Ididp++v3p50B2FCLNDzwBXpLq7HyMAWB7i8waNyjqoHyJfV2QaESxsxm3jK8kkfBGtPXO8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRrGmo8TZsecjU89NufnBUHrOtSJzJsgCsl8npY1AIu0nzKwL6Dzb+Gh3NbD?=
 =?us-ascii?Q?qczvGMDURSS92TZyUX2hviqYeW4Mrr0Nsbw3egT8Z8ItEwtsD/Yt4bVERRxx?=
 =?us-ascii?Q?DdRQnGax1ak7/H5We0+yeS7aJdhZ/CtEm+biCKBl42iFs0PH3KepC49Vm+qU?=
 =?us-ascii?Q?Kg2gTJYtPtbUurGu1W0LDXInF0HqHo/BWidzQgSiux7TJfGdll20tpzUE+rl?=
 =?us-ascii?Q?xE5OZJZhXOvh/OlFjAZ57k1KkfCr8djKW+bG1cPHzVrOYiJqgIydHVBvUPIn?=
 =?us-ascii?Q?QFXEDtRaeokpdXgukAvZFX7FCtHW97Peft0J7cbICNfRnt0WhD5jRtIM7ols?=
 =?us-ascii?Q?qxCsIkwB9I88zLG+IKvvQEfSNsRzJGgTwx0YvJdEqgx6ffzngG4BIy+F8bab?=
 =?us-ascii?Q?TObNRgaof+pIo5hk+sFldQxjRX07gU3bQG9Pkgho1U3sZBESDqljn+7cN0fg?=
 =?us-ascii?Q?TvHVV+nor2RKgWZ2tFEYWleOH53Ijk0XLSBjvUWLUXiOVD/gyF0Vh7wH4Uve?=
 =?us-ascii?Q?yh8ia4+13YXsVCR+8Qas0t7nx929glsIeOVH6F165hWjJgslgWJzuv9vicYJ?=
 =?us-ascii?Q?FuCR77heTWJ7bvZBON79YY8CQyt31tsVSL2x40Ua+1nSf0Nc5MaDaqkgaLIS?=
 =?us-ascii?Q?wpX/bF6xffnFxf/lE09AaJ9m9zrwXol97jbGCNU+QWahBxIZTep/UvmkE8kF?=
 =?us-ascii?Q?CldZrhURuGWfX1x5295fb0UHtRtAlPnWme4uBXSkElPZX2/Lr/beOX9jYxQT?=
 =?us-ascii?Q?j0bPF4KHVWe6eczivy6jgJTFrbevm9XGEU2TK8i8aMoDR3ePb/TLNXc4oaeu?=
 =?us-ascii?Q?fU88fdue9tlj5XZthp3m8425ZXgnQlPzy3xOlZ1TjBnT99Nw6lK/TRDP5PW/?=
 =?us-ascii?Q?7xlgPleIWN6gJZ9SHiGagvoZSAMagRGjIR7SpWttB+bToM8YAiMvMxn4uCO6?=
 =?us-ascii?Q?K7rFmp4yCp9PAWih3IsETE7ByJ0Gko8q5I6WXaJppnTB7idqmFoTvV5ICQU9?=
 =?us-ascii?Q?kviV4VjNXEHYsWkaoSTUFeMPCALdmBirFfkylui7A7gtgPuFEoCowciuCHJ1?=
 =?us-ascii?Q?pedE+cbRDxbLwFAMlmKH5sz0N8S5+Y5tvI2eMApmzRZa81Pb2Ffu3PPNM3a/?=
 =?us-ascii?Q?394WxgJeLJQ/LQd1WHjgCyKoFNb9FDfys4MzvNE872IYpPlBHijynwh2rb3O?=
 =?us-ascii?Q?ECjsZtUyfC0QScUp9OYmzRMtxZ7Z0CP3fCBPQqd1oHExjyHFUHXUI4S4iVZQ?=
 =?us-ascii?Q?vE+MpLfmqiM/MOtsocWgewb8dQRFoJSjEhWU+GNiNFGXjSKSsMyzuQAc24T+?=
 =?us-ascii?Q?0VEuOQRJknTEZUPWmp9Nams9pRqJp8/A52oRqgkYhTApyg5VzNpDUpOKwjrn?=
 =?us-ascii?Q?UNc2NvkZzK0RyEpZKVD4v1MsXEWgDnufc/mNFuNE+vBPXRyxTy5didu5R8lf?=
 =?us-ascii?Q?xr0Jlwz3AlK1gC8y3AFhWzRfkEi0OmhyCLaoyBZcgYYom15kvEWnmEmWj4s8?=
 =?us-ascii?Q?yi1WHL9SBBI5qKjUTq0Ee3ytxorDg1+G9edq8iZEYrVUodtqoTnQ1la9b+aS?=
 =?us-ascii?Q?sngHZ8cXXG628oCZi1K6WwfBYVhNGhh2VRQ7mkbwFrdu7DUmQrPBN8PTEE9g?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d54e16-8dfb-4c51-fe32-08dabeb9db11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:08.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkatUO7TRIx8J1MOC6T9/PkLRPBE1FU/J1kLincAyCYMMD2x+/SZPaS+ursuyQMxmsaFlP6ggiTlDAwedIyz5QDHcv+p4GtdBiEGxJ1gfCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040142
X-Proofpoint-ORIG-GUID: IsELa3COdVLHQWrtYMR3Eg4zSRy4OcAM
X-Proofpoint-GUID: IsELa3COdVLHQWrtYMR3Eg4zSRy4OcAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index a5fa04a..c914647 100644
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
@@ -64,12 +65,12 @@ struct btf_encoder {
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
@@ -1175,8 +1176,8 @@ static int percpu_var_cmp(const void *_a, const void *_b)
 static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
 {
 	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
+	const struct var_info *p = bsearch(&key, encoder->variables.vars, encoder->variables.var_cnt,
+					   sizeof(encoder->variables.vars[0]), percpu_var_cmp);
 	if (!p)
 		return false;
 
@@ -1192,7 +1193,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	uint32_t size;
 
 	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
+	if (sym_sec_idx != encoder->variables.percpu_shndx)
 		return 0;
 	if (elf_sym__type(sym) != STT_OBJECT)
 		return 0;
@@ -1220,17 +1221,17 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
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
@@ -1242,7 +1243,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 	GElf_Sym sym;
 
 	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
+	encoder->variables.var_cnt = 0;
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
@@ -1253,11 +1254,11 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
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
@@ -1288,7 +1289,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 	struct tag *pos;
 	int err = -1;
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (encoder->variables.percpu_shndx == 0 || !encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -1318,9 +1319,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
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
@@ -1468,9 +1470,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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
2.31.1

