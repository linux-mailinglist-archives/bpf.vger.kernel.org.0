Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3965A2F5C
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbiHZSx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiHZSx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02DE9927;
        Fri, 26 Aug 2022 11:49:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDohs010635;
        Fri, 26 Aug 2022 18:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pTvj7L2x7IRjDdFH7Z9M/bRmJvetzjp8NUWrLkP5TvY=;
 b=EvZ/XnIrnY5dDULR/eJvE4MSIYWzhkagwYapgCE6bfLm+1EF5FHeRw2rFpEIPg4gwVcS
 93QIioS0Xxr+PyVcLWrPqKBU8p1DFlTJ9asnZD9Yo/ZY3ZBjSJUvALuF4021OS1iBjQG
 XOTZEgpIqJXeLImua5lmhUHV0XC3BqtCcMyTmSF/uoW1yBKTR5fmE9dVBiZe4WG/vq5R
 FttlOrx3yq7ZptLuf/k61ipMoGZowdzHgAcK6kuy6pJKtgdVyU7XZS/x1YKbxkM2xaan
 QvuvOFVMuWSoT53oGuZNbvW61qqQuAYywUg1lVkP2thHI9J7DeZ78A41QfV62BPD8wvD 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w242e04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGIxYO033694;
        Fri, 26 Aug 2022 18:49:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6r8kgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEhwcSJoCBPSqgyjyJfAhy0OlJ5QAlo1g/VdOuIF+dAQZ7w/zvgw9AKeaUQNKUtGZs40sWi3uFWB6Nr7MRxNcR0EhKnlKf5a841/i08hE9z7qbaKj4XloJoyEDb5MSY3ScWxv4QXUNiEeF/SKQLQMIjuZUvjbY94E+SvcLTIPwpRZpPeoonfKG6lz7YRMO7ILGO09lNfMJOB8lZvxtovHZiV6cd1kfaBL7T//5ojItf9O+gtYrskl1T7JzhivEvWjAj3p4Yvex81Mm6YZO2Ww9BAKjWXTk0iwYvx+HbguTm9474J/qArE9swEEDWVM0c4ER81OdyMZY9Nv25fzQs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTvj7L2x7IRjDdFH7Z9M/bRmJvetzjp8NUWrLkP5TvY=;
 b=O+6ObNRLF8W6yNEl7L9GPWvlqCxYYFFGz3+pyIpiV7xONsZA5784cHe+1HUQuuaBwfou/KP2AgkqrOQgiPnsFImr8GY645DRYwFf6AUu0jzZwJPVqG6RWskWIDpZFH5pdU0mvtUlGoeUVs+FnTMMbwXcnji11H+gq7ciWYGGvo6v1sbzB6XHTeEq5Y9ASGZlPd8KU00mSlbLtZlSl9d14TSAdLnC0ghfpQOB4pPu4pdstdY9HX+5tE9UP/tp0YCore3fMY6a1YpfviVnmGEUJPf/zFfrqDJvch0hXH7hoEWe6IMSvZIeVQVdRz3wDLJGi+c4VrQHYczt1KuKfu/lzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTvj7L2x7IRjDdFH7Z9M/bRmJvetzjp8NUWrLkP5TvY=;
 b=WykZ3hRLmMW5QCJQF+sVUNYeOPLi7pMoQJBPRKwHOYyr4vjY3QqYV/kGYbKczUZ27lXaz+3xyP9KfVb6BXHmZIYL3f578K2xshDKke0sw197O6T5azu4Brp3rdwKg5/I5rwsBT/3+WG1vbpNv/ec2FNKmNMoycFvQ3ZQyp/0tGI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:21 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:21 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 4/7] btf_encoder: make the variable array dynamic
Date:   Fri, 26 Aug 2022 11:49:08 -0700
Message-Id: <20220826184911.168442-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:5:337::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d89b06-a0e2-478a-2a62-08da8793b04b
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Klf+bxZUwOpsUirj+tzoaoc+9pxJiggMJjePpCt9KZY/Fs+k6xVJ2LpVw9ZngLClibxy+DWZAD/XD2/3CsVxtSBpQzABz5M9l0AWBybIFfJV/zD06m9H2JRyPm9WRXQeVU84j79a/xwSdK54hhlM8eKXcFqUc0XgJ+ZwQ/plSJemusUmh50Q1eeWRxPxIbIW5e032ltB/nHGR+X6/yOi0Ns9LWgf4VviS+GJ7dIfHGTlvZ/whqhoQy3e5V6dDY8HvRHBLhpHuG0UAolaYpIXikvRNlgGJe7yfpv4P9+XX9nBsRtPJV/Y4RaGp7dNsFC1gbksQZukscf2fMDeVbSBXgze0RWI67VoWCC3DoqS1SmNZeGTFJNvFxIK3HpWlTB5S/JhN4rUL2CaBKxVACNRtVMItLELWpyfq99dXAYVGE442rjvo4vyEEU0IQKqw3RmmXHjordBNX6A21UVXWE8QdbHx1Cugx51Ul/jhnlAQ394nwLcXwkrOlEGA+IUh8/eq7S2chF8PFKp7OkVj7wKLo2WlrWbPifwnNPQV56QEY692JQTm2Zc7pDMYaygH6cdVTI2BGiPUi5Qfg/V2cdCtkyXcV2RDsshK1p/BYE72Q0yam2MrPA2HQDGPInNvM2P+5vTThHNYHRi7BsM+dHE7Z2yq3i+vrZYiWpaI/CCD1BpCC1nZFCfkUR0zzHHhIOtDNIxHC4DZ/zuhyLBJVU9kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3bJignZ7hiURKkIhciJdbx+q3MbHUE5filHUCQOWQ3xDcbPdqJr7/tYonbb?=
 =?us-ascii?Q?WE25qXjldRZFsQ39VjZUpB2v5JKE8XCmVa+LkaXA1mjrA7rr51dolVIxHzAT?=
 =?us-ascii?Q?Px0qjB+GveQ7Kior5u0RBs/kanANe409kogwAk3KBrXqwaKj09By0OT63rcD?=
 =?us-ascii?Q?GbC3b+icTKW68VZkVkSdW9ARAR2v+ZSxPrVjJOX7PYymLbzGw93tYCcd2U6X?=
 =?us-ascii?Q?v2BdRRXTN/4SlUz/hcMtcyyaYdDd+P0e6FJDb9OIRKSD9n7tXBRAHjzKQ6uZ?=
 =?us-ascii?Q?TVG0Th9nd46MrjaNAvqQBvBHsPzTOTyQnpf4f8n/QhghNcg/ZdH+ohIaGbKJ?=
 =?us-ascii?Q?ZRtjkKVY+F6hkG7m4ZKyvpkSr+xNDW8esl6sMAToEbsdZcY/I4wHpJkU46zh?=
 =?us-ascii?Q?MSi5JRlpJW6suxmtHejnUJ/cyZu0dQa9V4XHTcM8cvK+aSGLGGIDURvCmZhL?=
 =?us-ascii?Q?8mMNpM7/PcUi5bSGt2VQud9tN8ABEh2ekofczMnneGONCr+ngeqLsMhDJQZc?=
 =?us-ascii?Q?+ECfa4Ku6z5aWOXwy+/d91oMGQZlSsHyQzoAsxhgBAg71/6CqMZn9juqkjQY?=
 =?us-ascii?Q?hYNa47cwi7wlJpelBLnrFZgkbVuuvYjTOofIKOKbEiWNPK/u7o6HmbU13JqS?=
 =?us-ascii?Q?wulNj8GfEk6d0OWyhPf/48g7pupH2Hll98+CYpBO0ILmRmvczGfewJpTlY0F?=
 =?us-ascii?Q?gw++5gX+2mE5N55KeQHWZ23G5E17orfnQn9DnFkPf//x2Y1cLBXb1r1X2eYq?=
 =?us-ascii?Q?QKFyN5+dVFr1dzCbCDL5MzXV81rDyxts7cExD8t7IAO6jQqOOTsBmHfjvEVh?=
 =?us-ascii?Q?Gugc0WeBLbOQhgE+bl/gPeqn0qkidXFciOdcwRYzFH0L9YrFBZ206jKZks3s?=
 =?us-ascii?Q?l+zxElDGzoranT64c8FadMhb7T/I5mPhzTTAHDJyZe39zNj0BJxy29vPKy32?=
 =?us-ascii?Q?roYkV2/KivYcdzurXyO8DLSnh+SzJCYnHO2mUQEtdeQJEzaGtAIKqi6tnh8c?=
 =?us-ascii?Q?YzFIjkWy5EtrO1hldtohaF9h14qENEq4oXYAED60EYxddMnkZCEEu38PiI8+?=
 =?us-ascii?Q?NTIpVvrODlTm651K9fcuR447fWvwApCyy78pZZFG2OI+Dc2QM3vM1YopQiaM?=
 =?us-ascii?Q?B6QuOvDKQBvABJRqsfGfUG0bLX1ovbxPnqybBJIn0r3BfxRIsJQouXfLAgFR?=
 =?us-ascii?Q?XUwULj6qfL74wjJGmilXViEr4RPPggdtnjUZEM5gzHVSdtL2KeUzOKCF3dTg?=
 =?us-ascii?Q?l4WOmEWUy/UI920v5lX4JNwBzmJOFAWkaBejZVFgq5ww6LOWwqyBblzIYQit?=
 =?us-ascii?Q?De2l51mRMeVKbhOoTR0vTycPEd3WK7dKUr8QUN8h7U+nAtz8tVNOOxwPprmR?=
 =?us-ascii?Q?WBc0yuKSy3blIF6gXu93X1ZhpSvlSyBTvP6sIw5flUExY1omqWGhdUN69c58?=
 =?us-ascii?Q?v63iVtkU3Ptd4+cCr6cok9A4Gakalx7VE0ldrYQU9GTtnJYAkHL2x0lvLWjt?=
 =?us-ascii?Q?4QFhaSjOwrgTtQfcmdYAF5gu2ClmqYcOqpmUxZaGATlUlWKJvBu2vM9urgpz?=
 =?us-ascii?Q?3vOHa1juzWRs3E06lAiJVnOZ6/4XGg7nx1QGCk5bSOGNbHPINkT+REuM3FjJ?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d89b06-a0e2-478a-2a62-08da8793b04b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:21.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/vWXDXE0ZTK3fnjoomdWuqEZ5vjl1Zkxo80oyKs1EZi3zSg11a7Z6w+41ub8wjw/cMcktxcgNPNOPZegaYkb0oZPGQGy/ha5Y0pi7vGw6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: 5OpfzfSqeUXxKV_YmjO0SL0D2tAy7Yhr
X-Proofpoint-GUID: 5OpfzfSqeUXxKV_YmjO0SL0D2tAy7Yhr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index f67738a..ddc9d00 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -37,7 +37,6 @@ struct elf_function {
 	bool		 generated;
 };
 
-#define MAX_VAR_CNT 4096
 #define MAX_ELF_SEC_CNT    128
 
 struct var_info {
@@ -71,8 +70,9 @@ struct btf_encoder {
 	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
 	size_t             seccnt;
 	struct {
-		struct var_info vars[MAX_VAR_CNT];
+		struct var_info *vars;
 		int		var_cnt;
+		int		var_alloc;
 		uint32_t	percpu_shndx;
 	} variables;
 	struct {
@@ -1157,6 +1157,15 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
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
@@ -1183,11 +1192,6 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
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
@@ -1470,6 +1474,10 @@ void btf_encoder__delete(struct btf_encoder *encoder)
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
2.34.1

