Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A979E61A570
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKDXLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKDXL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7863FB85;
        Fri,  4 Nov 2022 16:11:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj7ca014044;
        Fri, 4 Nov 2022 23:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=500kHVvNpjLERXwFHkww0pUF7hsApnR2IlUPDBUZMaM=;
 b=DZUZY56V+OIgyfZ3Ol1w/us2hCTIckDDRqwozb8yrTK2Is8q7UOzZhSCCbIw0Tzf10xF
 S4CXqe+XokBJ0SXFCaY02x1N5SBOOMbpoW+RL+tezRx21xRw6/BVg2RSUCfayJpZIP52
 mVWi8Pay0nksYhIiQdKPWXDT7kVBQC+GDiD63dPfZshABvsZyAH2oM39J+XhFyMvz0jT
 Ae6IBKPaXKTqviS4KswEd1UTPYpy1UVt6nYHNJgKARfLAPPVaiTPT1cXiF1VNdVluJct
 HTPdZFjYVRpRZwFVGm5zWnwZVTuvSLDN3/WgzWZJdABrBR+MjGyfkmdWx6fEZ0sgmNA+ 4w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1hgp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4LATDI031957;
        Fri, 4 Nov 2022 23:11:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmqb6r51m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHQVmePMbY+T96moRLdUs/QBBz8kT8zwQj2WD+7xex6oyGccy7/w8CO+5u+UyyRhDyd+TwFl23qpRyeDwaspS3u22+4ezTqEqTiLhZ8HVGTCsxuVeTmvZJ83gESHoSyfA/LaxX/3WwAaBcniOHN2o9TMGje/axgG0YEo8w6jaMUjKW/MzjA4fip6yELG+G2ix3VJ1LNJwsO6W8eYXZVGtNXkLreOthWsmsMwm4IPW1XNKNhwDDCqdpkawvfojTGgLxfYp3sQGWb+0HjS1vJ4XxiIAyFg/42CqBDNUkbdQope8LpOMAQyAK4nb3POI5eKqgYxPT46DIsuDxKftJndSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=500kHVvNpjLERXwFHkww0pUF7hsApnR2IlUPDBUZMaM=;
 b=YNPemdxn6k4KyaIXWp2eo11mfvTEP842J4zwa/HyYCt4gEzGEi5YhZkT9LUHjOnf6818YLZ3BJwtNs78RHfjv134ZMd5T3cgiKLIVoBqDLkAghwM9739Yoch9qKe37S8A78zHH8pFmQdLefvAMb/Ilx+dGZR4/4m7vIUJs/2CV88vdczXtqXmOm7QAL5m4SmPfzkzUnxNuYPH6MkW4Py1lMv8B1OGuMdBMPqozyVay3Jup9Mz3Y0/jrXwDaEx1lO1SZpADCmfdHGeXM7afGJ5OKzQMPcKZBKDCnyaL8jdCO4LkbOj+711qfhAGMhddADrcBdoyt5yFvWY+wNq62CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=500kHVvNpjLERXwFHkww0pUF7hsApnR2IlUPDBUZMaM=;
 b=CwBUSrhwojAyAjl0Yc50/pfxRFQjt+s4yE3finfm0FWD902hf/wN9MuLphAieM4zZvssOPwktSUHfLus7v/TW2D4hR4bZcWcfK2SiZ76wQZmLubuo/WQVjwXyAm8BTKOSYDSm5Z4rQYIfw69e4LvuenjQL1a/6DFfYtHp3/GC7M=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:20 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:20 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 7/9] btf_encoder: allow encoding all variables
Date:   Fri,  4 Nov 2022 16:11:01 -0700
Message-Id: <20221104231103.752040-8-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4e1d1a-2981-46f4-cc73-08dabeb9e22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2oJbnQYcTd/M1TfHe98/kGNwl9UzM3V3sB8xWcf8VENN3unMZ1wYBgstnX0PzBbmUL4vrQ3Z/xikwH/v5/5hr6kPGoGJGp2iFEt3jTtGM1RO6Mb+94mTkbK+7lD6fNprSJTSMtZM0PrxqmPVs4Olwh303gYQ3O3Zs1/+vPPknSwOWIh2nZQG6qUiLOtPLnTdPhjnrFtMIyzpGPgaVnMnXQ/bPipdqN6PNyDaXbOsWCSP7wfwgO9sPmxMWWP1JcH+hk1W/8e3vMUlLNNfJrhV4KgureybZx/ItZ0l2RxsL8u8b1tNUBTHdXbCRSbvQ+mq4SL+4TaF3L0Y6+3Mh2y4osfFoiYmFH7i0lOhHbRnOJVsFjfLqaH3ipQZ7yYnaoeOe558Zju+V7y3FArSxwgjnKLpe6HUrLwc37641Nz+DrMNIVrA4k6GQqptXpmlAvSyfwnghT73xQs7o8TStIucl1+FXSwBQT51ZDaQYMnJSy5/kQ6UDbrYk1bGWvTNHdsFFPm2cca6bbLVW8gH6//IgOEQn0Vp+ddheTtc2Uv4PxV8j5m5OA6cQuCbbL5EBraAKWbYQn4Zkrs2D38XyE+3+eeekbGQ2pRnACN95O+PWKDM1Pnmd5hBJ3K7ATEoR0yM53QqTzGBhv5qi8wfrghIJpbL9KyoyJZqJxL+t97yI7eSRFhO2OzB3eE2LZt/W+rQVy6yWEtNj/rB37DYXe63A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sP7dLj6VNMAeo5z+YlnHyr4bwInFEhwurohZkGquko5vTOrtqpUdzqB0dV3u?=
 =?us-ascii?Q?WmT5L6b1Rp4bqdaIpj/6sYsgOsPMM1NXygMEd54mJnCJFFqFulzniUETe4QC?=
 =?us-ascii?Q?IgXxYCl6Ty9Iej537A+gwBTrOnf5IHIpJW7qKbO5T30M+b/nYndAbjzFGws8?=
 =?us-ascii?Q?knKi9Y+Q5VLx5QeHydzF8oKqF1a+rhc6/dNP0EEaNoVWk/hbJXpkfeYFcaDb?=
 =?us-ascii?Q?3B5ZYX4vfOO6O/PHyldoZf8oB6H+LkcIiJ9BHQTAVZkMISjc+dg/afvnkDUV?=
 =?us-ascii?Q?xuNO2NrkjerO83I4YHmVypXykvwyXo5u9Z35FtNyX9dJgZwLm6ZJQRlo7ivM?=
 =?us-ascii?Q?tOhbT7MPM+ITcEeACZflklDFsRlSYBHIwjgR3Z82r0KvnwJJHZ7ox2S4Z9C4?=
 =?us-ascii?Q?9dUaE8Sl4l2pRJdGU+2QXcrOt6qAzkyHqH5HHH28fb661pTj6vb3R/XevOw1?=
 =?us-ascii?Q?nRMrl/oJuvhv2cGWaHiTUkyGPnKkjE9NL2nDTzNgqqw9mYjdt27HZwdimLOo?=
 =?us-ascii?Q?PoqCOujQ+gAjuQRgr9rFkDRY9Ahd3sOqHe1FQAoSw/sptKDrdN+XIrrBJQuQ?=
 =?us-ascii?Q?9Um/2taUnWm+n+kW6QKCvJFA6orqbWZYFkD5zGMOVJA57oehU4NvAYt9RP6f?=
 =?us-ascii?Q?8mz7ZW6v3k19Ks0GzngWaiK3yuTobNUeBa4m/2Cf6OzrzCsLoGkSS77iQVxA?=
 =?us-ascii?Q?GwDt9wkuUOxZ29ZG+vlnpV/bCHO87sF/qo7fHvfybBGV95nEquU0Gm9IoFsn?=
 =?us-ascii?Q?KEQJCZ6jOf/eN5ufAuwrXdSKs0sy3LZWCwmJXsEn7riTZWAO6wo3juIWSZ/j?=
 =?us-ascii?Q?mjqWjQIOm0O7Kn+JaUrlS1F306TlM62M0eqVHBXj5jhJgSZR3/9sQdlTOgrc?=
 =?us-ascii?Q?dckQA5HMxgAdyksGQk66GxKseD3GWooQyRpMvZhcVtH794OEXFfDNAI6BMIz?=
 =?us-ascii?Q?iWw2rVnndZvcWdXaAXFFBAbjGin7XC0ZjIhgKL3s0JC0/yYcK8OlNVHOxOvU?=
 =?us-ascii?Q?h3K7Mn/3ONSqPdbsPBaA1Mk5YkxjoE1C/ajrf86amBVnBV3/VJkCu+KdujkY?=
 =?us-ascii?Q?aSK6CNJ1bedVDeFenfcQCY3iKKstE4gfbzZoIB7QsZQoC3FZAyYOINo6tHPK?=
 =?us-ascii?Q?bSW4CbBYdJ11rF8b7MVscn+6341TyPdt+DcEjVCEevcOwYi54DQJ7y58xnLU?=
 =?us-ascii?Q?HqxwL8Ko5n/jpaXHN3XEfvmZePhQsFZLjObmK/ukFjd1SkVYDenm3/NYiEQB?=
 =?us-ascii?Q?XR804qyyJwN1NQ5k4BGEcf6CtcudPBA64RcVU2/ZjsrRGSUjaxPK0xf2xp9W?=
 =?us-ascii?Q?/B9ECaJnBBXXvRWy4Xi1iUjj9BB5ulyPo3ufrYVKBR5c9mBz8XCKvYobhx4N?=
 =?us-ascii?Q?OINkK/4+UozCMASe/DIwNfYwq0bOMaSMhe2TOOXINaHBoiwdQ0BisPtX7uhp?=
 =?us-ascii?Q?tDV6V9Xr2tnVLuIsWdp25x0wZc5BqUIwcVglDk6fNKXoow1WaIn8hWJIe97E?=
 =?us-ascii?Q?hlOhEXvLxVVBngoH6gDLgP/oBLrefqLmoYHQWsPwvfPeQkWKN8tOCtL264qs?=
 =?us-ascii?Q?uqFo0pdpe001SyqjZKi+YSMfXjIfsWgHUwP+tadmWmk+OGLxKpQGp+rqcGAB?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e1d1a-2981-46f4-cc73-08dabeb9e22a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:20.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zi15OSaSniD9Bc75KsvJKgEU2sFPGLr0oN3AmazQF8n1SeQk1nW9JF82rTVYE6YXJMmn+80SfzBPUKUlZjatxtFmcTYifdkqlikZwEuMBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: a8WHorO9N_zXDyPs29VXZcBOWXVHSW6O
X-Proofpoint-ORIG-GUID: a8WHorO9N_zXDyPs29VXZcBOWXVHSW6O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the --encode_all_btf_vars option, which conflicts with
--skip_encoding_btf_vars, and will enable encoding all variables which
have a corresponding STT_OBJECT match in the ELF symbol table. Rework
the btf_encoder_new() signature to include a single enum to specify
which kinds of variables are allowed, and add the necessary logic to
select variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c      | 22 +++++++++++++---------
 btf_encoder.h      |  8 +++++++-
 man-pages/pahole.1 |  6 +++++-
 pahole.c           | 30 ++++++++++++++++++++++++------
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index f7acc9a..b3ede15 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -65,7 +65,6 @@ struct btf_encoder {
 	struct elf_symtab *symtab;
 	bool		  has_index_type,
 			  need_index_type,
-			  skip_encoding_vars,
 			  raw_output,
 			  verbose,
 			  force,
@@ -74,6 +73,7 @@ struct btf_encoder {
 	uint32_t	  array_index_id;
 	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
 	size_t		  seccnt;
+	enum btf_var_option encode_vars;
 	struct {
 		struct var_info *vars;
 		int		var_cnt;
@@ -1247,24 +1247,25 @@ static int btf_encoder__collect_var(struct btf_encoder *encoder, GElf_Sym *sym,
 	return 0;
 }
 
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
 	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
+	bool collect_vars = (encoder->encode_vars != BTF_VAR_NONE);
 
 	/* cache variables' addresses, preparing for searching in symtab. */
 	encoder->variables.var_cnt = 0;
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_var(encoder, &sym, sym_sec_idx))
+		if (collect_vars && btf_encoder__collect_var(encoder, &sym, sym_sec_idx))
 			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
 	}
 
-	if (collect_percpu_vars) {
+	if (collect_vars) {
 		if (encoder->variables.var_cnt)
 			qsort(encoder->variables.vars, encoder->variables.var_cnt, sizeof(encoder->variables.vars[0]), var_cmp);
 
@@ -1425,7 +1426,7 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, enum btf_var_option vars, bool force, bool gen_floats, bool verbose)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
@@ -1441,11 +1442,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		encoder->force		 = force;
 		encoder->gen_floats	 = gen_floats;
-		encoder->skip_encoding_vars = skip_encoding_vars;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->encode_vars	 = vars;
 
 		GElf_Ehdr ehdr;
 
@@ -1495,17 +1496,20 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
+			if (encoder->encode_vars == BTF_VAR_ALL)
+				encoder->secinfo[shndx].include = true;
 
 			if (strcmp(secname, PERCPU_SECTION) == 0) {
 				encoder->variables.percpu_shndx = shndx;
-				encoder->secinfo[shndx].include = true;
+				if (encoder->encode_vars != BTF_VAR_NONE)
+					encoder->secinfo[shndx].include = true;
 			}
 		}
 
 		if (!encoder->variables.percpu_shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
+		if (btf_encoder__collect_symbols(encoder))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -1671,7 +1675,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		}
 	}
 
-	if (!encoder->skip_encoding_vars)
+	if (encoder->encode_vars != BTF_VAR_NONE)
 		err = btf_encoder__encode_cu_variables(encoder, type_id_off);
 out:
 	encoder->cu = NULL;
diff --git a/btf_encoder.h b/btf_encoder.h
index a65120c..e03c7cc 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,13 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+enum btf_var_option {
+	BTF_VAR_NONE,
+	BTF_VAR_PERCPU,
+	BTF_VAR_ALL,
+};
+
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, enum btf_var_option vars, bool force, bool gen_floats, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 7460104..e7f5ab5 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -215,7 +215,11 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+TQ
+.B \-\-encode_all_btf_vars
+By default, VARs are encoded only for percpu variables. These options allow
+to skip encoding them, or to encode all variables regardless of whether they are
+percpu. These options are mutually exclusive.
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
diff --git a/pahole.c b/pahole.c
index 4ddf21f..6ff4e22 100644
--- a/pahole.c
+++ b/pahole.c
@@ -37,7 +37,7 @@ static bool ctf_encode;
 static bool sort_output;
 static bool need_resort;
 static bool first_obj_only;
-static bool skip_encoding_btf_vars;
+static enum btf_var_option encode_btf_vars = BTF_VAR_PERCPU;
 static bool btf_encode_force;
 static const char *base_btf_file;
 
@@ -1222,6 +1222,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_languages_exclude	   336
 #define ARGP_skip_encoding_btf_enum64 337
 #define ARGP_skip_emitting_atomic_typedefs 338
+#define ARGP_encode_all_btf_vars   339
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1533,7 +1534,12 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "skip_encoding_btf_vars",
 		.key  = ARGP_skip_encoding_btf_vars,
-		.doc  = "Do not encode VARs in BTF."
+		.doc  = "Do not encode any VARs in BTF (default: only percpu)."
+	},
+	{
+		.name = "encode_all_btf_vars",
+		.key  = ARGP_encode_all_btf_vars,
+		.doc  = "Encode all VARs in BTF (default: only percpu)."
 	},
 	{
 		.name = "btf_encode_force",
@@ -1763,8 +1769,6 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.range = arg;			break;
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
-	case ARGP_skip_encoding_btf_vars:
-		skip_encoding_btf_vars = true;		break;
 	case ARGP_btf_encode_force:
 		btf_encode_force = true;		break;
 	case ARGP_btf_base:
@@ -1803,6 +1807,20 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_enum64 = true;	break;
 	case ARGP_skip_emitting_atomic_typedefs:
 		conf.skip_emitting_atomic_typedefs = true;	break;
+	case ARGP_skip_encoding_btf_vars:
+		if (encode_btf_vars != BTF_VAR_PERCPU) {
+			fprintf(stderr, "error: --encode_all_btf_vars and --skip_encoding_btf_vars are mutually exclusive\n");
+			return ARGP_HELP_SEE;
+		}
+		encode_btf_vars = BTF_VAR_NONE;
+		break;
+	case ARGP_encode_all_btf_vars:
+		if (encode_btf_vars != BTF_VAR_PERCPU) {
+			fprintf(stderr, "error: --encode_all_btf_vars and --skip_encoding_btf_vars are mutually exclusive\n");
+			return ARGP_HELP_SEE;
+		}
+		encode_btf_vars = BTF_VAR_ALL;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3037,7 +3055,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * And, it is used by the thread
 			 * create it.
 			 */
-			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
+			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, encode_btf_vars,
 						       btf_encode_force, btf_gen_floats, global_verbose);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
@@ -3067,7 +3085,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 				thread->encoder =
 					btf_encoder__new(cu, detached_btf_filename,
 							 NULL,
-							 skip_encoding_btf_vars,
+							 encode_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
 							 global_verbose);
-- 
2.31.1

