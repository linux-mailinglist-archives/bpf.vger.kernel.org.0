Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5B5A2F64
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiHZSyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbiHZSx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2AEF2C82;
        Fri, 26 Aug 2022 11:49:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDjs8025982;
        Fri, 26 Aug 2022 18:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2CC2vTW+p33cEfrXC9oOJ4lF/EDb7hgO9hM1oeIz/1I=;
 b=RRzBLKfYx/LJCnnYT2dIltMRIC5QQeRcHPpW2g5b2O+DEkoTQQvbtXqobvcUIF4oVAYp
 GAsqhsDEoCbA5mTrpQUdiK645Gjsz2QkcRdu/koCaYJqJSo4mboQFGXlAD3TAVIVz65W
 SCJITA4cVmtN39ol2QQF83U0goNeYNFbq0VFpxMe1AelDL8s9ahydXAdm6+yD+PE3pnh
 q74XmgbljvgxnKFIAg7lKKYaYeZ5jNzv1r4hjw2ti/ChduMDxITgoQjh/DUZB7PF4y1X
 QnrmheVv9KfEECUjoRyBy1EpjpPFMNHbMQvWFEBC/EOtiYnLkY8ldw5px47laZkrSpJT 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25t7gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGYPpU018831;
        Fri, 26 Aug 2022 18:49:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59fb1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWrAMNK7Yh8Abmk1YflRqhWTKUNu7n9OUeq9oKdIGt+//7fAEUGA+h4eKSIRjjkKSa+bYfuq1YenCO8BCpL7xu7aaNh7phORroPlJxOEQqydo9zrKtH9s7C3Wxss290FoUvmFkRyDAwnSdd5vXsrofNeliBvKQMjcBJO8+XF0kn7SCGx81kwQu/GAO3pfHDyBTZC3V+iOWd5Wefi1APn3assuoy5OlWvddvVw1oDThu2fT+DKJK23WjhRvAarSkxokzUycpOo4o99FfCNCyhq3zToijItWYGZ03u67+pQbDM9IFTLAO1Y9ShWhnwrxgSvCq2Gxmc0EI1hBcULlNj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CC2vTW+p33cEfrXC9oOJ4lF/EDb7hgO9hM1oeIz/1I=;
 b=emJoaWLehMIU0OP5iqlvI1fhLbs6K4AXgE8WUXyIFC6UG/RS+1MAOsvmHCethPjFRWY8xY6DcTZZ8jWUwwurdUJ4o/3lwoFvLgb4c+v9o4SBP0Y3ZCRVLFkRh8ImceNKc2lG38qSTnBC+LI4njqI/Ptl/Gqtoh+Pk5iFl3KsjOGuOTb2n2Mx3I5JjqD0xuymGX8D2lf2v+qST3kD96fK2e4Y8hzF6TcjdeYmQlI+Jxm6R3rsDuQsItaHTM7CGJzn83hir9TcbCgVShOpUc+fiDi33jmaQS5HlgoKQb+EYFMN/bSHX6biu5Eo1Vi6Mrs+NH9Ie4OcMq+AeM31nQZUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CC2vTW+p33cEfrXC9oOJ4lF/EDb7hgO9hM1oeIz/1I=;
 b=ReVFVhRO8DcS4efv+Bj5rxpdvnj35VQ/yc7PCT3bwLve11lvOt0FWWlFm92xV2HkKWe8W5jDh9N30RNqxXCl0qYC7Ch3NHKlx01drPIyjqgbuFAxA/gHRk2eklIOJSDs98xeMNq4b/ioYpVAatjk1GGc2ZA6ERgcqQaAaT4mMTE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN6PR10MB2558.namprd10.prod.outlook.com (2603:10b6:805:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:28 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:28 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 7/7] btf_encoder: allow encoding all variables
Date:   Fri, 26 Aug 2022 11:49:11 -0700
Message-Id: <20220826184911.168442-8-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:6e::8) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d4f2229-12d5-4fbb-e3a0-08da8793b43b
X-MS-TrafficTypeDiagnostic: SN6PR10MB2558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtfP3KdYskNPLbzL5FB5aIdtd/88GSlqYOJ/iirIk/0AMNt7ogg0OZ08iu12OYcfYC5RAAbJzxPe2FmYScXeOBzLlu3Z6PDy6h0b/vhmTJp9pXHKX4Gjw0x7fsY3dMyrc7pvHPFP8eTRdXOkKaTSfkmU4isAIlLa3zOxD4Jt2UZ13BDuCVNYh7AhwaoVBOCgkccdvgnczeThBtma+9k3PYiPJyFzNvfTnO6Cm7yBAQ34tO0b5NvpBD82AKjenmulTfIbrOjPmiqRhnDQ15kjX6tC0N6xh7xrOMx92gRI/Qodb9RddDoWIj/IkgHwLHdw5pC1I/r2rsnWwG+9frYJcmFsKdxoVoPd5jGZsAUMWlxGiiYzyGTTxTvFgHZb7LWjGZUyL1vXOPgqWFULHXTjigkQY6/KP12iUU3x7YqYPQQDO1h2jTrKbqePAS79gAGHRjRtWShvtN1j1G5gBHWAdTVUa/zu1dBdSEZWXbFklQdFXHCkq5uhKZui5ehl/PA2tqN2mMFISZp1fdRQJlvoxzJaazTxzEzluFvFWO75Jn5yG9hV/eCOPpxKFse4/JJ8uF6XowwaUIW3JJHsZH95s2ygyrS61aq7QnHIHVRH7qWsR2DeycS5xI09PivfLwLXXzmevYpftNBeotGEe1J3V3KB69YMAUxB/K3ETUNx9jz6rTVT++QTJfrMxSt208zUzspyFY1ZQ4TfwlSYpoZ8xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(366004)(136003)(316002)(41300700001)(6916009)(6506007)(6666004)(6512007)(26005)(478600001)(6486002)(66946007)(8676002)(66476007)(4326008)(66556008)(8936002)(5660300002)(2906002)(38100700002)(36756003)(86362001)(103116003)(1076003)(2616005)(186003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DnVPxIn1SkAouOpBaaGIO2ikROSq7kIzJmz2KDlMk7yWb2nyumcMzwlgFuB?=
 =?us-ascii?Q?ONjECpMtbAId0QSgADExt3U3DCkspR770/yRVsTT0K3tGmYQxcWvlAtMXtc7?=
 =?us-ascii?Q?Y8/4GbBi6ptPc08QZCl0VV0yKDEQZhpnXuOOELFODXKoUKat9XNpqu45B9uI?=
 =?us-ascii?Q?Tbv6eBALcBz++2IzElSOuEcj3QSbnkNzlkqQQRvoZZw0In4/h5EnvDA2HWnt?=
 =?us-ascii?Q?3B235AzlNEX7BjQ5gffPWElW2pGGRgMsnQC+K//2Q73mFdwEU5WU9nfnas8T?=
 =?us-ascii?Q?dxefKx1JACu3ekYjhIEJ2jmmTy+0/w092qQPuYxGvzDJAAvVfkvL3vYAiY81?=
 =?us-ascii?Q?UiD1f5JcuJXEALNB4mPi52gX738xRYO9qGN4Cb9lwH3RT8S7aPhcXmM/9zwk?=
 =?us-ascii?Q?sFqRMJPxMCT+Ph/h2x7YtxPHIOyueV1Uj1rTBUZ28ytNLOB2KLkTxD3Xd+2T?=
 =?us-ascii?Q?3/dEDnyToRMQ0XCQAXYIK+cab7LbRGdtDMyvpUrQ/wOjeDughasf4V93rjYU?=
 =?us-ascii?Q?t49We6WJOsi8M5hp9CiXSlf78b+YQ+A/I18GVUs/yFN4wRsQYysNfbQyY5e9?=
 =?us-ascii?Q?CvCkIeRM3DP/EBENk0wVKr//9JhLxe4KnLzIhkfLfBLXtTZODIOmMr3wnuBV?=
 =?us-ascii?Q?vqvzMsvfgmKNVzk7q8mVVYFiJtGGn6EEZUnwJ4SngJcf4oH5GXvcRxOV/lUD?=
 =?us-ascii?Q?vZqr2tSC1kzzp6e8iNBotnxkyXS+qli/X6msFZTZ0hU1Hn9DKewP0/3NQURB?=
 =?us-ascii?Q?MavHksmgdvKIjzF/FuFDzX41rhJWnLne1Hd+35iIVNG8WeHGMIzI+pjJHVME?=
 =?us-ascii?Q?ct+6wsevzOBPHG6ZEpA5WkX1CkOBBHoSpUfnPpnnTfyggmhyQQlMBIDg7Svs?=
 =?us-ascii?Q?Pmiu5JLRTHTkNrMRMmWVcr8SikhOp2M7ACp3NykN1cIykirf/a/VBYUcG/Es?=
 =?us-ascii?Q?/lq3ZXAXA1RTF+sOd2koeMRFXMZv2S3RtB/rKLGdCDQFdJw8bw6/Ma8jD7l5?=
 =?us-ascii?Q?KQLbr2rKGUDeBbtu7bA1duQKWDzuxbWkw0KQdTEz3PYapN3Yj3tiMaCzUawt?=
 =?us-ascii?Q?oKOhCiU7OxRX7gF/nNp58kljgiR8JeXno8c5E4r0fvqWyb2ALa52evwKgj3V?=
 =?us-ascii?Q?GZPMw98cEmIepxhPYLRlAyqE8Axy2CASfPo/weoGsAQKYl4hduvb/kI7G2Jw?=
 =?us-ascii?Q?d+q0LtLEDqJcfRZMCw7gxgIKZYnxjbiqwPO24a2P5irvvRnlIK/gtNq1Qt0l?=
 =?us-ascii?Q?d5q1WvxypZbcFKrx7oXmNTWe+oESDCqwl5t61wzqAueP7azM1scRNZZLW5mE?=
 =?us-ascii?Q?Vc3oIEbEZeYquhokeYhWWtcrCrMKenoRJbdRkKsnGQEsGtVaxCHFWrYGVACS?=
 =?us-ascii?Q?hDBuYYci/ZknQYbWBeMIvCfOGb5ZMgNnyqpvMNcOhKrwNkfPbFfZ/5joWByj?=
 =?us-ascii?Q?188n/8uwF1i9eNfMC9S6VYcoU4ot1MVgQAmIflM5lfkDoinaoNjdLZo7UHk7?=
 =?us-ascii?Q?8orC7F2qWdvHS0ZnlhDwd8WTKbvwiTCCAF+OhtmYcPsJHAwOni1pmrvOAgMl?=
 =?us-ascii?Q?UMvV0Rl04UfTDi4TgYZTvBx+yiEh3HDI2TuBVs0mQfRBqFvIsfHBTF4OQ1lg?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4f2229-12d5-4fbb-e3a0-08da8793b43b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:28.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dw6vGimUT4eDFOxXDdomMfMSvXIqoXSEfQ7tvohSp3qfMa234pyaD+K9Jes4jdxi9yq188kLLpe0AFnFRD1RXZadi9BBJgpW1/GiY0MKiEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: dP31m1Wq5nuoRTMZmLvSq4wlZPaooyYI
X-Proofpoint-GUID: dP31m1Wq5nuoRTMZmLvSq4wlZPaooyYI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 pahole.c           | 31 +++++++++++++++++++++++++------
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1804500..eabc8d2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -61,7 +61,6 @@ struct btf_encoder {
 	struct elf_symtab *symtab;
 	bool		  has_index_type,
 			  need_index_type,
-			  skip_encoding_vars,
 			  raw_output,
 			  verbose,
 			  force,
@@ -70,6 +69,7 @@ struct btf_encoder {
 	uint32_t	  array_index_id;
 	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
 	size_t             seccnt;
+	enum btf_var_option encode_vars;
 	struct {
 		struct var_info *vars;
 		int		var_cnt;
@@ -1198,24 +1198,25 @@ static int btf_encoder__collect_var(struct btf_encoder *encoder, GElf_Sym *sym,
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
 
@@ -1375,7 +1376,7 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, enum btf_var_option vars, bool force, bool gen_floats, bool verbose)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
@@ -1391,11 +1392,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		encoder->force		 = force;
 		encoder->gen_floats	 = gen_floats;
-		encoder->skip_encoding_vars = skip_encoding_vars;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->encode_vars	 = vars;
 
 		GElf_Ehdr ehdr;
 
@@ -1445,17 +1446,20 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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
@@ -1615,7 +1619,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		}
 	}
 
-	if (!encoder->skip_encoding_vars)
+	if (encoder->encode_vars != BTF_VAR_NONE)
 		err = btf_encoder__encode_cu_variables(encoder, cu, type_id_off);
 out:
 	return err;
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
index bb88e2f..d21af0a 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -207,7 +207,11 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+.TQ
+.B \-\-encode_all_btf_vars
+By default, VARs are encoded only for percpu variables. These options allow
+to skip encoding them, or to encode all variables regardless of whether they are
+percpu. These options are mutually exclusive.
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
diff --git a/pahole.c b/pahole.c
index e87d9a4..1f86ffb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -4,6 +4,7 @@
   Copyright (C) 2006 Mandriva Conectiva S.A.
   Copyright (C) 2006 Arnaldo Carvalho de Melo <acme@mandriva.com>
   Copyright (C) 2007- Arnaldo Carvalho de Melo <acme@redhat.com>
+  Copyright (c) 2022 Oracle and/or its affiliates.
 */
 
 #include <argp.h>
@@ -37,7 +38,7 @@ static bool ctf_encode;
 static bool sort_output;
 static bool need_resort;
 static bool first_obj_only;
-static bool skip_encoding_btf_vars;
+static enum btf_var_option encode_btf_vars = BTF_VAR_PERCPU;
 static bool btf_encode_force;
 static const char *base_btf_file;
 
@@ -1221,6 +1222,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_languages		   335
 #define ARGP_languages_exclude	   336
 #define ARGP_skip_encoding_btf_enum64 337
+#define ARGP_encode_all_btf_vars   338
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1532,7 +1534,12 @@ static const struct argp_option pahole__options[] = {
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
@@ -1757,8 +1764,6 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.range = arg;			break;
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
-	case ARGP_skip_encoding_btf_vars:
-		skip_encoding_btf_vars = true;		break;
 	case ARGP_btf_encode_force:
 		btf_encode_force = true;		break;
 	case ARGP_btf_base:
@@ -1795,6 +1800,20 @@ static error_t pahole__options_parser(int key, char *arg,
 		languages.str = arg;			break;
 	case ARGP_skip_encoding_btf_enum64:
 		conf_load.skip_encoding_btf_enum64 = true;	break;
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
@@ -3034,7 +3053,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * And, it is used by the thread
 			 * create it.
 			 */
-			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
+			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, encode_btf_vars,
 						       btf_encode_force, btf_gen_floats, global_verbose);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
@@ -3064,7 +3083,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 				thread->encoder =
 					btf_encoder__new(cu, detached_btf_filename,
 							 NULL,
-							 skip_encoding_btf_vars,
+							 encode_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
 							 global_verbose);
-- 
2.34.1

