Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225861A569
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKDXLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKDXLU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA12DA97;
        Fri,  4 Nov 2022 16:11:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj8qx012149;
        Fri, 4 Nov 2022 23:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qLOdeY1fFim8ihP5Q1df1e0hBCppiSAPmtlDZF6xqiY=;
 b=qTT5zj/EyswCwE1QIsvWiUzXEZWaHoAh6JzSylxrxTFA3HJv/u18ynt8aToEiv8FYF3N
 ms/VUiE73LWTyOfCc1zaEGq8AL43An5vcWH03OGQDW9kMA+v4E9yHT+vH+d/cJu2zBvV
 5S5+vTjRu5Q7pVdfrtabfq4G+M5LGuOnO5MrlQ2VSSFTlCD/Y942k/AIwQBCwB/OInKp
 9oXwLDzaulyh02bIjr8TOd4dNfKU3ln5ZF4zqW6vu8aelAKRV67AHGC2cV90TLZdGZKE
 c4UT6+pi8gJ2z5I3mldomOl/v5ZuO+tAKPP1V6mxRTX/hZl2NzbsqdocnXoG2Qi1mvGj WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtshkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4MI2DB012011;
        Fri, 4 Nov 2022 23:11:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwn87g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJgtMyrVu02fx+GuXK2aZeqhP3xRsNy67B35Lltzj5/uxwni1FOZFQwMg0OTC8acwnzi8PQywXJcqxvL4+X0dXU1PU8CJDNshnxwCoU3oVmwETIchosspWqVUPpwyJtu9yzkrOl4FrTl62vdoRUuSodlRUMNvDpBHTz5aTjk2YwYHXL0G8tJgI782SA4JsauWpmXz1i4LtNEYCoZwZlxWsdcEFBfJPa0JhRbl2SfRCpYAsZKKHVGxsVIT0dRBvWTNZ2NPBowr/o8hJG4Y65M3qICGts455a+m5JD/gPk9k15PcZ8PMM2CtGnFaw04pqOa2zUB0Tl1QfXCG84t65mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLOdeY1fFim8ihP5Q1df1e0hBCppiSAPmtlDZF6xqiY=;
 b=ZZlSHn76noLUFhD74vNJMF/DxicKap+OfwPu5ZkQSFLcBK8MGvevjPmJ6Y3NVtTHYrI52HIty4VCdXspgOPohcjqplp8Msa79qRTL02EhH8mLmdIC+P+bTGcF5pHlr2JzJG+5Mc4rJ0/InzYJoEgrPRqRN9rfSQHAQfQa++vf7AQfhYfs+F3gPxiDn76Sc3HKnTdlPORs838EyMw7QRPfGF3FrgYOYyn0M7AT8NICsMAZuO760zqGwxRlJa1+ucvSitqjZAqgpmgtmo+h8IG3jgDTf0TqbKIS4Y8Q5eIymy18YjZUD/bIIv1J+XJAarkD52dGDrelkj2SgLtAvCeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLOdeY1fFim8ihP5Q1df1e0hBCppiSAPmtlDZF6xqiY=;
 b=hD3+s54HAR4ow1hl90GBSAK/wkvwr0Z6fda8YrerA2zrvg13ybb964HZIAoRx15zz2GYVk1RQqcXqEBil+Q4O5ykZQpmVR+iJi5/Y0h7Sm2d+WLUwe/SJh5unZmeDRfoBBkIB35gzZjUI7KcUcLHgGc2sFHIOrbchh+a9UIq7JU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:15 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:15 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 5/9] btf_encoder: record ELF section for collected variables
Date:   Fri,  4 Nov 2022 16:10:59 -0700
Message-Id: <20221104231103.752040-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 619f7005-5941-4c38-bb07-08dabeb9df6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qavYlu/LRKxsVsOkDWxg42MCk3p7pfmklldLtQE4wAwMXjBv3Z5dbXKkSz5AZM9yj3V4nDGk9lMQ9OsoF1sWBbpBPnqxolQnM0PlPKUUu366wYyeblfUlCqTdyv4D4R1jL+hG1Ha1tadboqYZ3r7v5f2wQOwzeO/hbDytt4MFWPBuXZSBWkcJRmjsBppWuxd9TbMxknUQb4P8JgRTwtZtWWmUa5U9g4x0o/VaYQd12+1IG+EYxfRvqH8DUlF0o8l1oLqzZApJRNNxR0/C4gsWyHGVJ2AzcmbVzExZxauAyBIgvl29l+7LNgOtt5VpNpaP+44QCgBgk40WhaNd6NOXF/uVVz5lKmtN1V6yxTj7Tx911fdO+LafAzf5XlY7ZKrn4bBp2kLSI2bh+tjtffezHtNNiUaaQgb0nE0LepX7HYwX0n5r/gURtfnKvbYb38f6gHaQeVxTv/lrvxpG6cJZJ4qPRwgTYDbe6JYaTQQt5ELtzIeAkY0hTab2bF6qf4k5RxuQSpfx7MqyGqM8wk/RsUasReksMgPExG/EDogSeo73Jf7fWtRTjY0Ns1GJkRfCog6HrwouMjBmJMyZipQj1bJpwOaKNH+k2wK2G+vZLdUWfdSNBkpIA9ASiuKde2K6aSaB6HT+cCCTfpYQ0BfSgrYVGN9ymTOcXXwmF0a9e9tLPOud4ZLUGDqH95MwtXdJ/ND/R4urjTVkZeXHCAAxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06vAiVSlfit7WtwOmX/d8sk/zRo7eo1zFhsh7nGeTaxnFvnYPjTmjVAWHQfL?=
 =?us-ascii?Q?riF4tCi4llnPLpJkZtL5zAlrPR0KBYk2gXEWM/4jKAh4E0j7GF2OUVlvizXz?=
 =?us-ascii?Q?iRgrh1p+j3A01kOAY/DCNPnqzpHabg0R4G4hXypvpQ1IicrJP1EplDV0WEea?=
 =?us-ascii?Q?LOzvrOV35QJMmkYcRUSHH6O5uLhU9a6woFasC2EfSbWelSYaMY0QZmDCGa9p?=
 =?us-ascii?Q?7vz+LgeIPVp6vfS8OmE55HRz6evUngGU1Jno0elcuHeY7TvklTDFWubIclDu?=
 =?us-ascii?Q?0UhEmzp0K4u5jsiNV3CfugDVXQO82JLuV39efJYk2WBsNa5MxmM84zg1es3w?=
 =?us-ascii?Q?RVBNEDFTYe82FEf4iuQdjDnP5tGFhM1L/x4owEDb6f8gLZ/6FCEUeqViL3Wg?=
 =?us-ascii?Q?bBISvq04ryn+FVnQdTqZ5mYJEMuXIxZvYCNYQgBJY111MhOolwy3R1spA2/4?=
 =?us-ascii?Q?Sk40o9WiiD6JWk0SyJhd+5xbSAJzKEsv0H+YMUT8a2TZJ9mikJa87Hq2Qvw4?=
 =?us-ascii?Q?emBYh8ivRJMKbN/RBMlfeZrrbzsG6Y5SFGm/MGPldVaJK1Lfx1UujvJGkQsK?=
 =?us-ascii?Q?Up7JOyV79rj08J4uX6qXSx7fM3am5+PqHG3/FDMg97OnVK/U3WeUiUbLjCIv?=
 =?us-ascii?Q?43Y/iaArFofImgP2nB1ETCK5XEdxIncGZYT8H4BmnJ5C7BIjQtkV2fHbaIel?=
 =?us-ascii?Q?EIMYdBpTU0ZmBsfFMB05uV/adzV4I4tMF1rF1qAjwTn1H6UloM75tmofLRbY?=
 =?us-ascii?Q?kkzqY7fUOaWLm68rPuhapsDpfrAGvS0tzJiJ1ao/Gw/A//fTTN8QECzwCwcW?=
 =?us-ascii?Q?V5si+oJ6CaFrWJZldnrUeneRJQsUYHnZiEb/PXaMTpP4rGAbJFXsAAI1icFX?=
 =?us-ascii?Q?INEJ+jAyHTzbIVMMXT26TFsQpsXqAZrMpNUY5cqzLaIQd729Brjnug0z0HLv?=
 =?us-ascii?Q?ZbfwgXbSMg42nDtKrdCbN2r6RUZM6ty3/iESPDncE+ZQJWU1TiQQ+G9Cb9y8?=
 =?us-ascii?Q?cnQd23WaDGL+Otpqkst3aUNjcRbvphf3EMjlLbkPyNIkimwuDNFlJtxwfNVL?=
 =?us-ascii?Q?jW5ttjSll/8UhDK1fR/Zy0n+1f+e23xwPSKOjKhE/AK4ThnyolwG0LObJiox?=
 =?us-ascii?Q?t7mO0hsGUx5trodYBqbEtx4B3U3Bged6uPvU0Zq1C4uLlE8XWtqPMIRZAZlf?=
 =?us-ascii?Q?4W1BMIdMJJC58MumCRijneZBsL5COeDD4hAcN/ncg266qXgpU6hF2r7x2jm+?=
 =?us-ascii?Q?yAf6pv7A69n/i5HysEEN8rBzVT4vKUSVylgWEz7BJRhW/b0uWlLnL0vhVbO1?=
 =?us-ascii?Q?7ebu2iHmlqzihw4Oh1Y2VW1Q+2QrxcNNEzysxccmHa1Yt2A1pAA4zi27n93z?=
 =?us-ascii?Q?pmL4hhkxnoW4aayQm9avaMU9VaKdy/xWehNG+Hq2T37HsTgJm+lYQdeytIf0?=
 =?us-ascii?Q?EoiOquil7ONmGomGuatck3C+v6glqzONZjsyUVtDXqI3r2c+R5KBN9U6SW/i?=
 =?us-ascii?Q?MX+kgGbOutK9PQTMLSm+hboLQuKUzhfZmJN08kWz99WernMLEtHbW7oV/Q6G?=
 =?us-ascii?Q?Cfk+ujMXQbEX+pgzhKbIOqg/WXLsj/XLGYDa59m/QIBAef1g1++PKN0J5aP3?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f7005-5941-4c38-bb07-08dabeb9df6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:15.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiCgO0a+EQT176tcokSDuN09mBtVUHPLXInjQ8BG0bcdn+alUokTK2R6F58KJ8uAQfiODdTFePoFMaWUazaennqiGYTdjF9Y/v8FcSemb/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: oXogAOEffQa49Y93hna1UPV1t9Qr7VyU
X-Proofpoint-ORIG-GUID: oXogAOEffQa49Y93hna1UPV1t9Qr7VyU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5cd247d..d1f2f38 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -43,6 +43,7 @@ struct var_info {
 	uint64_t    addr;
 	const char *name;
 	uint32_t    sz;
+	uint32_t    shndx;
 };
 
 struct elf_secinfo {
@@ -1194,7 +1195,7 @@ static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t
 	return true;
 }
 
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
+static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, uint32_t sym_sec_idx)
 {
 	const char *sym_name;
 	uint64_t addr;
@@ -1244,6 +1245,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	encoder->variables.vars[encoder->variables.var_cnt].addr = addr;
 	encoder->variables.vars[encoder->variables.var_cnt].sz = size;
 	encoder->variables.vars[encoder->variables.var_cnt].name = sym_name;
+	encoder->variables.vars[encoder->variables.var_cnt].shndx = sym_sec_idx;
 	encoder->variables.var_cnt++;
 
 	return 0;
@@ -1251,7 +1253,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 
 static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-- 
2.31.1

