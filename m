Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4565A2F63
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiHZSyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbiHZSx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240ECF23D3;
        Fri, 26 Aug 2022 11:49:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDjnV025971;
        Fri, 26 Aug 2022 18:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EyFffKxsdeN6S4XpBB/c6UZ4vE2Hcpetzy/SXDuzkrA=;
 b=3GTSRzuLYLuC9r0nCGhL3V17iLdlZw5EKroB43q+oCUUQT/2Ahoe1KcigVFJ597mDQ/q
 h6kMe0QNrk3o8uUcXaHW4sMT66DOLbyWCUVyR/K4JUV6m0LTVXs+NKjRxdZxTihRw/TH
 vJ0gFW9TLIKfwA0RVaJ5+SyqSFP6F20++TL6niF9VEXsyHhEhjhS39ZCpZF/yEgaHutM
 75nzVJz0c0uR4mJW2WnD6e3gEu/4HSVeiynCNIsHQxbpocwoXggQLCDp59Y54jYgkZTL
 +7NmMyIFcHSth/ncTuw+Rnc3BuUh7syfFgPDjjWf5U6SeqmH+81QNmX8262NduiR8Wgv zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25t7gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGQVK1029811;
        Fri, 26 Aug 2022 18:49:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5r73mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBxb2GoIiu4KuGurHfVCzgSZwPuXbGlVmmmYiij5+OFWbSDKXie1UBTYpAR6Fm9deWiCO8X6j50636IBH5gs64opTPxbkbJvDyWRFWhcEOHtuovXFTGbio4dYhgTABaB3N9x29qdxXAQb0INpVmEqxaphZWJl8lVRnkVmIVaqE3hvIzahpck1cPOSCAO8DcVdIKycB6TFVYSDkxBePReQQGYf2BeeILAWSe/vK9snjFozWeLfDMO7sYM6kkxWtdTflO2xqLtQSWPmXpcw0dnfWngVfCOwikpF3+MeuOcWzRuc6kKLzUkDb3wcTYMa8DF0sNGdbs2We8bcf5s5PaY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyFffKxsdeN6S4XpBB/c6UZ4vE2Hcpetzy/SXDuzkrA=;
 b=PNznUdw8C0w/t65SZNdcNMCQVZZRJSkQQhak8OgxKh3VpFg/5ygWKWr9dnjq/i6v/6HcAzxFF+PoT5IOTkLtAk0JEYamR8ngr6rz7ZauDkEh109vyvZbtToZBQEnDwRompoxFtAjEQE1omtgdl8DdxV5h/U4IAkyqZU+Ln8hjBhlfka1vUZ+bDSJFGru8wyukCWBeWAPxy1C5hR1gbW44kqUyAWgj22Zo2Sy7GkjSKeVSLxH6TZ276kHwJY/7EXIQBvx9szG7OsQj2ixlECHtjVvofxOTlYLUb/fHfP69RRuJIoyuipWjbnBnVu3MWCMwSLh3fqcf0d7iwrD3S0Mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyFffKxsdeN6S4XpBB/c6UZ4vE2Hcpetzy/SXDuzkrA=;
 b=D4iwRwC2x5LNQWcS9ZZ2Es64C8n8P6win/arYBtySdJLvEttIOZai3wewZbzWmtfyk8WdjPs6b+aWMSHZdG6RUQOXX3dGhSrGC11e7HRRbcYyV5i3YA5ONYvfIN9B+PjXKgEKbsB1PiRsDAx+FF2E4EXAEp8y9kucXouWe36IW0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:26 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:26 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 6/7] btf_encoder: collect all variables
Date:   Fri, 26 Aug 2022 11:49:10 -0700
Message-Id: <20220826184911.168442-7-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5babb86-edf2-48e9-61dc-08da8793b2e9
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi2DAX0ImMUYDnGLfidjBRQT7BV/3rspEFG0JVP732uvN9HSOBzOuSdyfmUXojiFeoWZMpPNDwqCIltyC2MbJMQJvrRFDJHoeHxR545m7R/iXuZ8DWostL2ZBBss3lrnn0tBImEJUMXQFhdtz7Fr5I2Z2RHVQO5bQmXbiU2H8vBfC6vm0uuqSsmQEgfNwRSZHLcxxK+mCy4uXs4uFp5KR0jcu2yr0sImfCGSTZvEXBYpkwozdtP9s1lzZxVJGLSEHKgwSD1Zk9QvuoDax0R96BQ5x2Cpylu755qFVnrtysICzMaFYZtSD3jcU2jcIukbZGJVTDLgbIjKFIqQUmUmjzcak0mv7ICcoisugatzt6r3Yh0XBYjrCSAlUPp8CE+pjVHxBCw/f8Rqdmxp8+qBK4STp01dwoL/bWX6RX8twJdaT9VghzYjPAkgFek+1ETfNGsUJx7rEnwe4VXAsaITbvfEHOMoNDE3QF7nKkMVQicZy6Z3uA4h/WdDrDwX0jeOJGqYP8RJKsQEfI5Psp3hLWqGLBmlwgOMvwJvRycCvK/Dj4Sqjiq1Wuyfc0tFGYJT50cdKh+tmGr3UeVK7e+TVg5a9DtLBl7TL1rJuoPbPwX3gbEMp18y06+P2iSE0cbMiH2Qh9m4KgCf4DRHrrjFA9JaMEU+W/jvYPEFOuSM1W8zxAq+GUjXgf8ttrcRFUEcPKwZNjWG3grHCSNcGCbUOWVUxDY+xAz4l5ZDbG2UyaNa96CqL2eofvQwFK8A6u8d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgOzG3RkITQRb0IkMDcfZmfrt0sMYktA5Ise2rBRGhOgk15doAyixn+V9U9q?=
 =?us-ascii?Q?4GJ+wFSspmKR1Yvnp37E2otLNmnW6JcgUUXmDq01OCUfNByU/bDhTnhRrKws?=
 =?us-ascii?Q?81mSnehuPustAEn8bHGc8+H/iLb69IbWz6drvBsXIP3EfyxXWVmmuGyWA5F0?=
 =?us-ascii?Q?7uZ1BdGSYWjoimUXf+5XIvBZhgGBQI+5wMLIGOdMkOe+aDlQq75U/kqJzi6L?=
 =?us-ascii?Q?pRogbBkCTWD+48HtM+DN0g8/qaVNy5we+3NJFguYWF9f0PsFIo+HAN7aJn2i?=
 =?us-ascii?Q?L8eERpzY2nyTHJJesZhX0eWZtzfdUsEX9SCSo4HzEg3GXsLjkwkg37qZ/O24?=
 =?us-ascii?Q?o7kchEgzanzNYkahDCL8nXGpgbvvPgfhdJTj+IbZDYoHG5friW4XqF+2S2Ib?=
 =?us-ascii?Q?AFc6TDR6KiF00DDM2EGFnJorv6Obe8o3qOrvve/rCJBR+CflhuJtwylP22Ne?=
 =?us-ascii?Q?uEOuYolywXPqr7rsA7fgqr3H32GChEuUbaQ7N3c+Lq97a74b5FxF4U8e1jD0?=
 =?us-ascii?Q?XmeqBqBP84DqtToRWVB54JhWOVxl8VjLnuaZcPFRrZv2xcp0vuzdxf9WFi40?=
 =?us-ascii?Q?ZcS+QBsTrUaQdHhp7XNf75Wed+lEPWA+Q3a7m8sw2f+3amawyL/4oBbmBEjj?=
 =?us-ascii?Q?WZzf+QTQxTUvwm7n4KLf/CQEidG+KWQ2oDJ6/BF4VBhRQiSwiMgIBqACJkUa?=
 =?us-ascii?Q?ZsrpdfA5+iM+ILCxA0qEjmuQHVEg1j6/o3YD3FeIa3nmdguF1IrCY4cHJ1Kn?=
 =?us-ascii?Q?7w0mlFSnKjjMnb4xDEqG99NbSlJ/sf33jJ0Sme+OvCyOWdTO5UrNNTfiCoDQ?=
 =?us-ascii?Q?IUuWy+9U1Veo/cQZ4FChCgVZs3xFM3t0LMMaC469xC6edMNT4uxG5CIcOWGN?=
 =?us-ascii?Q?k4YenecTNGXqgfzuJqNbU2zaCto8jLHyRvR7v5JBQBuSjk2BCqXWWMplF41s?=
 =?us-ascii?Q?3iZN4tzAhXzBJG/PiihNTLdLI0cCZy4cblEozcQ55LdRWdLfX8Iq4lDE/raZ?=
 =?us-ascii?Q?NkFskk3gyaFr8nx1rcvVc6Ol7zrW3ls0Yq10VpYFhj24VrgANQKu8t/X3hiy?=
 =?us-ascii?Q?as/0dzsKHmON9LdH+B/2cWi061bmFHexxVJ9+4+rqgKtFPz3ID0k4DyRh1pn?=
 =?us-ascii?Q?A3ibHFzBfXIfcS0NQywGFiIbZdjQlJSv3KT8Jfa503sfVLzWp8diO7r+7KLw?=
 =?us-ascii?Q?kZ3YZUrkf37Mxwt3p4MgLA59OyCkK428EEo8U4GzuHC+K+zD4RcvaVT+zssV?=
 =?us-ascii?Q?JHbaUbBsmIK+fTCg7WMSFno5FXC16iQkSzbA5uV/EqQigzmxK1GfsdiVFP7a?=
 =?us-ascii?Q?42+R4F7w6YEIU+DD2yWVd5sAW5qrQvTEJt+lW+YjeJVyNakb9DOOOEx9zReO?=
 =?us-ascii?Q?j9bQixFYWHp0ciAAVS/7Z93C9cOsuCQFab5IVt3XKOVRnq45kby3OyX0uRgy?=
 =?us-ascii?Q?NgO94Tr2FbG77B8VmlUhh/sW4vBVPjS059SxzaKII9rPpz7rFLceBdWc1c3b?=
 =?us-ascii?Q?E+Re/kb1FOZlhWoWDVlkaVKYoW0mTsfESqmniROdOilkIoYVRoBVM+BAQLma?=
 =?us-ascii?Q?94HhkLDG6Bkb1K9Vbth64m36+XZwV52baC8ImStVbRilDDH0iMnvV6tBQQM4?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5babb86-edf2-48e9-61dc-08da8793b2e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:25.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlphJn2oBW8C1PWuYUThuTFSjbHPYmIA3slAfw7LW0F6QiA2601dYYr/IZvEpooOnlm/Zv06Ld+EjXHnySeAnjGGg3jmGJRFRXkuaofHjII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: 6gXfDsP67k3Xzg0m7XzhbFBAvR1oZuWc
X-Proofpoint-GUID: 6gXfDsP67k3Xzg0m7XzhbFBAvR1oZuWc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 83aca61..1804500 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1123,7 +1123,7 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
+static int var_cmp(const void *_a, const void *_b)
 {
 	const struct var_info *a = _a;
 	const struct var_info *b = _b;
@@ -1133,28 +1133,24 @@ static int percpu_var_cmp(const void *_a, const void *_b)
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
 
@@ -1213,7 +1209,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
+		if (collect_percpu_vars && btf_encoder__collect_var(encoder, &sym, sym_sec_idx))
 			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
@@ -1221,7 +1217,7 @@ static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collec
 
 	if (collect_percpu_vars) {
 		if (encoder->variables.var_cnt)
-			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), percpu_var_cmp);
+			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), var_cmp);
 
 		if (encoder->verbose)
 			printf("Found %d per-CPU variables!\n", encoder->variables.var_cnt);
@@ -1263,17 +1259,19 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 
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
 
@@ -1281,13 +1279,16 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
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
@@ -1306,7 +1307,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		 *  per-CPU symbols have non-zero values.
 		 */
 		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+			if (!dwarf_name || strcmp(dwarf_name, info->name))
 				continue;
 		}
 
@@ -1315,7 +1316,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
-				name, cu->name);
+				info->name, cu->name);
 			if (encoder->force)
 				continue;
 			err = -1;
@@ -1325,7 +1326,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		tag = cu__type(cu, var->ip.tag.type);
 		if (tag__size(tag, cu) == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", dwarf_name ?: "<missing name>");
 			continue;
 		}
 
@@ -1334,14 +1335,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 
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
 
@@ -1349,20 +1350,23 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
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
2.34.1

