Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7F61A568
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKDXLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDXLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592312DA97;
        Fri,  4 Nov 2022 16:11:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj7bw012094;
        Fri, 4 Nov 2022 23:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9yq7RzDVaOaach9SdztdcML/yFxc9Zoiy0B2WaUD5Sk=;
 b=cVnKLTP5G8atg4rAxb9GeTCTHNJKkumkJTMhWMtxdn0YvZiUfQTyYmBPTPNSvg1Cwd54
 80X2w9L5apfQSyA9qM+Kva5qVfumcWVm3UYJZg2hvPCcheQX8qgOPdOxWHY0k24m1a7F
 W4NzXdriaSdf3JNxyiL7AfnE55cevlg5EaPmC5txomAaVO8zaRuWGReRb4WBMNBdK2Hw
 u161WyxC+7ywpTnfTJDauEMnvprRSm6cpq4eP/3Aqj+O7FTEjSnKPscEQOWTqFtl9CmB
 +v6WUWDnnqKI6lvQcOUeYlg8v4DhfprogvKDmiOL8V4yTDIwS9Baso+jHTvKaAmKVrqb +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtshkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Lr0n1011892;
        Fri, 4 Nov 2022 23:11:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwn87fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+G8L7+0w+0lfZ3Ga+EyLRNsjs5nA41BXCqCVJMTlNweDuc0kAEJjvismYwGY7B8TysnUNoVhuRgBlI3V4EYsNDHRvLbDZSU8TyPO/YeJ05Sm0/an5abVj64LYmfG2TKdSSH4xKZIGX67v+m1L+m8drkUvW/NXGh5N8j9CD22XC3fMNyT+uZzSSSU4Vs6b6bVQ+veKMF9xN7LgU4X6P71d9qttgPHAH4vYW6P5sn2Utv3Hd09rn6ip7gh3LkvcAhxJ87dH7pKCM8unEyT+y2s1AARtEwpyQ0Dv0ju0NhYXbkM+vu7i9C+s6ako3CIpJXUKa990jbrPvEePYW4Tr/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yq7RzDVaOaach9SdztdcML/yFxc9Zoiy0B2WaUD5Sk=;
 b=ghMUW1twdvSkdYRNNCTrWqQ3MY/Fe9n600A+XP5oriq1eyScUVLreNaFBveLACTHUeRusROO0FhRJTvxIffgZ4wJJ1b9Z37g15Jn+pA/fpLtp0vB/cSpMPn8XH1bvFopg7ADYCzBx1b8tTkYrMOkk6tyacFCu99WSkrgx/o+paeOhVY7SazjP4OAoo7+kmhsnTluEWaKMlZ36mwzXT/GOgkZ/Fn+FLXq3tEWWILw2NS4TQLo4ELukYvcoTnAFz+tUuT7zyBBUz1jHxpefTjDJUcVkWQC+iROxDvFYArlARsiN5ZRdg4/T/V3hQ4hrO2S5qSPiAsWs8xM9agOfXWQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yq7RzDVaOaach9SdztdcML/yFxc9Zoiy0B2WaUD5Sk=;
 b=IVfvU9UQaahtxLiW7P5r7mOrYBbz5Dzjd5/57ODvJApSs6dMjOzXmxkXhKxfKsweAMOJ9wa7GC29p30OkETCPUDCRs9b+O2RuHCA/3Xd5iKhz/LI/PwhxzCT8Cjs0PP+dx7XmQiXck3Y0YgTis4hscJ35eZk3qY0ah8gR7bxok4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB4172.namprd10.prod.outlook.com (2603:10b6:5:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Fri, 4 Nov
 2022 23:11:13 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:13 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 4/9] btf_encoder: make the variable array dynamic
Date:   Fri,  4 Nov 2022 16:10:58 -0700
Message-Id: <20221104231103.752040-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|DM6PR10MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: aad59341-0963-49fe-2310-08dabeb9de20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8LJ3nzUBIdVoOfJlsQYJpUzufpSdvuAxmUUNd0SMQTBWnQukBQPPW+iu6RNTxHG8ar9DIFlQwRUlpOb7YyOG3LMRkfk8FEX654wYkPsdhI+Lmisp7HHW4nT2dbojfzR1hYCrLXvJJjVeHfMZX9QWbXOyYux7+EA2/nGjgIzU2VIojCMZim7ewoKADbqfN+2pwj6fc5PahVgvjhiCNKr8SsYkwTDAGPdyK9wnp26Q76gmAU9uIlIOzj1PLpvW/yWNC31ysa4aqdUO3jNLWtG1UPmC2qS4C4iQ4YvNbsjyKfYBQlqaxnknbsHukwtv2ronKTeiArpKsKhLYMNyXOmlW5BdUNMvVlPLmOk+Qk4XK9v+H7V/KQhbKPU+Ww1zWykxFALutuZdjomD1jj4oIDNAn5mdEWGCsgxDnsAkWbwb7rPudq2mDfosYuWqjf32pHK+X11JOgNNic41HsPpw2DfuCMwlDL3Xk7obqZIVrQ0pIT99uu+kCqG0Bbyx3z6J8MH7Jcr6HYb44QHL4r7H9Jue1ezjaRa2tlecCikurVvfBd0qF38U3Kim0i09Zol0J3SkTiaATCAiaXeWlFMU9odZRuk1rlncIjFfdtLLKCPPXlPAbyG7z/KlZMehJKz/84G6bVyuf41N9EEi0tpDI3Kwe+JQ96f8GFLfYL4+112+k8q4n7BShOHUkP17mJHObed10NLpOZWMpNjKNB66Dvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(6666004)(316002)(6506007)(6512007)(478600001)(4326008)(8676002)(66476007)(54906003)(37006003)(66946007)(66556008)(6486002)(26005)(8936002)(6862004)(2906002)(1076003)(186003)(5660300002)(2616005)(41300700001)(83380400001)(6200100001)(7049001)(36756003)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bPKA4nXSdMhqolotBLonB08Ex+RxzyuZ9e652F5AQmQRWg8StOW6pVqt0/F?=
 =?us-ascii?Q?NHN3Lavosk+gTf9bN/cp2ehYIEhLH8ohEqRbAMWYznc/eilSIwsme6IIu+Rz?=
 =?us-ascii?Q?GHlfCWleiRN/cLdp2mffDNiYL7Wc/8RzomLyIQKhzbwTr18OfKCqLUHLQIY2?=
 =?us-ascii?Q?GeEpWoWuvLMc1WpicuI32Aj2rX9g/QFH/ow9pAlheWXs1XbiJ/3jw+XZTW+l?=
 =?us-ascii?Q?g8aRXCeIqXa3IxMUzaoHh6DMwSL8Ki3vZuK2ESTTSYj6B8/7FgSbMGySzXS6?=
 =?us-ascii?Q?OUA6Wr3n6XUVFwXdGP+9lScF+ZXcSKE7AXGLGVMG6T0It+pSx9rNiQWeT7kH?=
 =?us-ascii?Q?AAbZ7gUUEdHR6g8Rhe7IWZJM/rsT0yf7ZW+lB5quCFdPLEhj9z7fQGNnbW30?=
 =?us-ascii?Q?3SFZgwHypiX9THGkrJetU23ne3O1XiQbE5FIgM/o23aPjB0YHelTAkAxPy17?=
 =?us-ascii?Q?R0sl7wF8FLapxISJKyxfwE65iTQSht1b+GW4UfcPZmCB8b3BqaoAFGUH5ndH?=
 =?us-ascii?Q?dph/yWgOiWFloAPS+1KGu/9hFRH+NC6J23PTcvOMMVVhEejFdwE8sdSG4iiE?=
 =?us-ascii?Q?/GYd400G/V2vvT6ZI2hnZtUFWIvPZIytkvw+QedaWN7z92QxSJ6BVlJ3rK+y?=
 =?us-ascii?Q?TmOSvvHpR2ca2WamgNs5wcT2HxVNHWGJ6EK20FOj6Yay3HiKpogVUcAe9gUt?=
 =?us-ascii?Q?iQ2IwSNy9GDRPLRpFr3HzNLWv7wG5PzMgKt9uU01NZo6iNzB7CW3RfvrLpv/?=
 =?us-ascii?Q?H39rnInhAC30E4V8IjR8SPyNlLrTFE8lSyfogPur9VsJbuEcoPP+sa6Ln+sY?=
 =?us-ascii?Q?W1a6bOf8BHRh2q45dJF5ysyL9RQZd/QF0ah4uBsmyuzFrAAnH1mKfgMRk/TE?=
 =?us-ascii?Q?FwkSlZw/nw5FJTML1tJkRdIIIrOjfe3Qf3PIbWsQD4FV4Si//xfkdUgeab0P?=
 =?us-ascii?Q?hT4GpeTu2v35CIgVF3vWgZSAGM8KmqHalt6EcYd8cAMCw8iYpcp/wzWQmWJB?=
 =?us-ascii?Q?ERjzzxn7+CVjDV+UtWm9/QEjrrzeU0llohVert6j1a32Ax5vVkfiB2/qxWGv?=
 =?us-ascii?Q?Ukf3q8cptHZdKlLhkijaJn3iHHdxyQZCqB3pPwdSBeDyhF0yUldwGySF+1LU?=
 =?us-ascii?Q?fRiI0cJOZSRhbhAuki1PgLUil85uVwjZS1xK7AAEWLlkXymXRppqkgxWWQAA?=
 =?us-ascii?Q?jFG0jlJn6RfADEUX+sr9rmbmPywjen6Zzr74JQ2MuYrhoG/glriswvva6juJ?=
 =?us-ascii?Q?rkE9hH1vRTsco5Nl8UtunyCLGHh/h0H8vyb2hgRnICRnNvls7jGvKpH67RoV?=
 =?us-ascii?Q?hdeeco40CNX8U0QlzXJRnqNTPpBWaJX2jB8gg+oOX/JKpZoUCu+FMVq5DaYU?=
 =?us-ascii?Q?Lw24o3Bdh6F90CBx3L3UKm3Wmfv+lRW+449l4grQP+Z7LFoVfNIv6JVRfmZx?=
 =?us-ascii?Q?xMEVbbkIqgaGkA7/qFAdejVBn0L+jTwt9y0rtuLfuDwunSO3OcU17tHkzfjt?=
 =?us-ascii?Q?ymk1KJfeXXTcWYmWk72VwumdT0C1Q+uvr8QPJ7VsEpZdubVRVlP4Lregxeu8?=
 =?us-ascii?Q?7GMBZ9r3bDiUPoqpTLuEC317/EuigEDXFf1mV3hKpHsLpUR1kdwRV/spJzAm?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad59341-0963-49fe-2310-08dabeb9de20
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:13.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PnlFHsh+0h4EJiVTjWM5FVzXdUHNnst1to29hYtkroglSFIYuvt6rsN9mAJOgxlI1zTwQvMWXvYlI1PKPYIM17MlkXr2s3YabGgqjI80rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: FeOcQ52itw36odVkfwOJkv9qxWneq4K_
X-Proofpoint-ORIG-GUID: FeOcQ52itw36odVkfwOJkv9qxWneq4K_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To collect all variables, we need a dynamically allocated array to scale
with any amount.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e0e038b..5cd247d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -37,7 +37,6 @@ struct elf_function {
 	bool		 generated;
 };
 
-#define MAX_VAR_CNT 4096
 #define MAX_ELF_SEC_CNT    128
 
 struct var_info {
@@ -75,8 +74,9 @@ struct btf_encoder {
 	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
 	size_t		  seccnt;
 	struct {
-		struct var_info vars[MAX_VAR_CNT];
+		struct var_info *vars;
 		int		var_cnt;
+		int		var_alloc;
 		uint32_t	percpu_shndx;
 	} variables;
 	struct {
@@ -1206,6 +1206,15 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	if (elf_sym__type(sym) != STT_OBJECT)
 		return 0;
 
+	if (encoder->variables.var_cnt == encoder->variables.var_alloc) {
+		struct var_info *new;
+		encoder->variables.var_alloc = max(1000, encoder->variables.var_alloc * 3 / 2);
+		new = realloc(encoder->variables.vars, encoder->variables.var_alloc * sizeof(*new));
+		if (!new)
+			return -1;
+		encoder->variables.vars = new;
+	}
+
 	addr = elf_sym__value(sym);
 
 	size = elf_sym__size(sym);
@@ -1232,11 +1241,6 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 		addr += encoder->secinfo[sym->st_shndx].addr;
 	}
 
-	if (encoder->variables.var_cnt == MAX_VAR_CNT) {
-		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
-			MAX_VAR_CNT);
-		return -1;
-	}
 	encoder->variables.vars[encoder->variables.var_cnt].addr = addr;
 	encoder->variables.vars[encoder->variables.var_cnt].sz = size;
 	encoder->variables.vars[encoder->variables.var_cnt].name = sym_name;
@@ -1520,6 +1524,10 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->btf = NULL;
 	elf_symtab__delete(encoder->symtab);
 
+	encoder->variables.var_cnt = encoder->variables.var_alloc = 0;
+	free(encoder->variables.vars);
+	encoder->variables.vars = NULL;
+
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
-- 
2.31.1

