Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC225A2F60
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiHZSyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345315AbiHZSxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC5E8689;
        Fri, 26 Aug 2022 11:49:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDu0O006711;
        Fri, 26 Aug 2022 18:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MiBn9Rg/Wt0I5XMvmyEXs0xBCJsWWOGWqe4hTbmDj/g=;
 b=DQrekDFl37q2cRrj8ch1aCPP9GiqPdHFdtRy9zYQLdEhv4ludc5PSJ5v8TsC+eDlu2k2
 SV4uf1COI+ljxt0DuqL6o2C3TzCWvmr0Xp374vy+c843gF27oQ91wgyOzr8GyBA1U9F8
 WhL0zrNil+rzwrwQ0NxYwiMclfFACb75BqEJzdSmFYpmhmILwafpz/5zPvQ8Ot0Sjzkr
 2cUINq5+5X8zLSOH/Ilmj6ETJgw03sDhAUxu8qr16lS86g+qqg9LqdtvUND86BFV2qek
 Kwchx+dmdFXchB8ub2jYd4+NvoLiHyBs64wUcUtPnwMrz1sCbzipWTJkh1IshZCACwYp SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p28j6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGohKi033607;
        Fri, 26 Aug 2022 18:49:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6r8kft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f17KRdz68/mdjbQ2RinoI945KnsF46PAFcCnADB4xNoYGVg86dD6oPrqiUJmgF7GN1XvpXpttQgAbLmHt4GMwkAXUma1fvb0qOU2j12QaadrG4ChecOhMakvgROa45SZ5ErCKI6Rdc/UGOZxisk+eIzCDRqiist4ax1H/VeRjxhcsAK0Jg+iEXr1CZpxlmiFb0He3Q9LSjwpHhvF2YV/oz0TOE9cxGwdysYRupviSw9u/Y4vNF9//kPArZizyD9cZCSHxiNDj5/wrsJBwXhbBm/tcbPpk90S3qWOpMFU10sAxxsrsdT/VlL73StOUsT0JG1at9fByZj0PYbHG7p+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiBn9Rg/Wt0I5XMvmyEXs0xBCJsWWOGWqe4hTbmDj/g=;
 b=CY9Lz6eWqcAorpDFo9B5M15TV2yEMl10EX365Kzz1G2/hu5C+2srR4fBy2AlvETSUHXasaaCnmVnnSSQTuscse6I6SBJQTHBp2QOYKGI1mA533J79WA6MT96afbAfa3qB/vT2koDTCnn7Msxkc2q+pR47e4qfXTgLN9g8Zo7CoLTpEah30mHcTDLCIGopzYUH2Lo2qc0eYWgiComjTHB9dq5s6hEblSTR+eNSIm0bhqKT6+Zqf8AQ8d/KvegzVv8vwLtPxLIQddlujspZpGlBdXB46/mFzxqd2DvpB7g08BNiFx/y3Yy1BI9qagT8LEih0n7IpFI9lQaPwnftAoPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiBn9Rg/Wt0I5XMvmyEXs0xBCJsWWOGWqe4hTbmDj/g=;
 b=VEuTRmE6aR+ENDqs9g3h6rWpuEv20eRCHVLcP/gG5uTJzmPWH55nh2eZrO7J9tAfJ9UhEVKYQR4B686IgtEl6M8nq9D1FucZcwgRoTX79o3kldbtBHkSEbWNK77hKEtB1wN7aEV8k2VvsfkiCL4urqLlVnc6H5ld21aLcALWyjo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 3/7] btf_encoder: cache all ELF section info
Date:   Fri, 26 Aug 2022 11:49:07 -0700
Message-Id: <20220826184911.168442-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:5:134::41) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83aa6262-d75b-46ab-98d2-08da8793af31
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwEBc67Haj1e5AOgO+tsagRG0fFgoVUll8I64yHNgVGXtjcQrwSCIV6c8uri2VdZAvS3yUdoFOYbgOKVUYAFkgOH90ak6SZKQpv9A+oBCVgiO6Bw4lwz5MbglkwUFXo7lDmxezAXTlvLMaxNE2kmwcVEzYvaRjPtlLfF+gA1HsbIEdOh1s5u85j69hpAs3q1jgk+wgH2itBe5QBCnkIdB1F+fVY0LWvOEmSlO7zOcjJsB6ZxD/lziKZh8goE5pNulKOcUkYH+TnoKwbA73/3ioTvBrs3xDODHrVj8CjCtDeMK0Wx7OXAg+J0wRoAuYF5dVfaUBm+53JQiAuAVcBEaWv/sKS0w1QoNAygTtJuxf7WptDAetNU5Mo0IbO6YmyGrpCQHpkn1msRo7j2AsQWE/ujsyaQM10TFJCN00fbFYG1EZo4YqlQRmYktt7mQTJUN/ptugEiiv4CzvCWoDKNu0pROwVfITdQFlIvjwj7fkeGtO86MevjvARY844PXxmeoqovIgUXiYIWsbtWoxCjybIUyC+xYtkhyvPt/kR8FUSd0SNJTCiyj6HxQOMCRxy63v/nByeMfpvu+f0764dCipNdW28US9p03n2lqz0t4s2mB6ezQ9p32AfzLALXrGy/gUaetpOD2rAmvN8op2+VAe1BvAVAU/yGBTUUUKSd/VEMN3QreqRBb/G7c/qD4FYizQy3OV8sWtn2/laMMravFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b6sFVo8TmRPeOt1Y4uxcJZM4WgSmFH8aX2vDOnhTjKL1usJASaeH3NRFtKuB?=
 =?us-ascii?Q?i/NQDZF0Ezap1ordFljXtnXJcWbd5sayAf7XNl3+oWW63cYxeVTyVMSiF4IN?=
 =?us-ascii?Q?a+Ts4ufrx/7pxCm0l98Psope5V/eSBItDcmzFTnKAILBZ7ivJQWBeh6tz/q/?=
 =?us-ascii?Q?nMBnVNJRF8dSt2aK2TVuccM849ojZ9NJc6Pz/rDuF+VP9sHKxdeB7cPJnlE+?=
 =?us-ascii?Q?bCJfJlXu6W26h3ouRyiIZUaDVGr/LZaLENz9Gi4e4BrBeVU19GvMjmro8aUB?=
 =?us-ascii?Q?uPf4hsem9d86WADbhgjEH4rK74P3Lcxu6yxEDPzMf4LpOc13Y8PDWpYt0+/i?=
 =?us-ascii?Q?i4i7RReEKkmc7pLnm3YGn1g6ImHbN6tynFR5FXEHciBJGy1Rg6xTzjep56X4?=
 =?us-ascii?Q?WJB/ZVFpMBPyN8kwp1euGVAg/yFmAnosVP3A9F0XaZ9vSGKca7UxhWGiQYYJ?=
 =?us-ascii?Q?0f3tRIOcnWf0VQRmznw3OU5ZCwriGCmcPKN7PCHUYA+300+prgV8Ca1BzC6/?=
 =?us-ascii?Q?PQivCSHabavOqLPWVgATunNETGh048S91MBfiAq3hEPRxjLX9CfX5Zl8/eRV?=
 =?us-ascii?Q?UrindPNrxL4P1Ct+PsGHRzekz94t+qR1NEAYre0W+uLEPXLyCmaM9ttuAps6?=
 =?us-ascii?Q?35P0RzYvFpDaT+kTOYrPwOsBIJN5w2gPy2RJ/H3as+bGdNaPOTtrr9e7a3QB?=
 =?us-ascii?Q?ks5GIr7GbwoYRinNzPlMBrKK2EfMnaUUlZeOZ5LYqwFi4dQDXqywI/07JYqw?=
 =?us-ascii?Q?f9j5HFCTfmOXwtjyzq5X+Lc7GcoctWzypzwglLeA0CHUYWXMiLiYTZUomXrY?=
 =?us-ascii?Q?NwBgzr3x4oNGew+4QZPMy1hvcUwZlgsXwaOTyV8pA/OeFp5uVaieldCXyKly?=
 =?us-ascii?Q?+gDkLh6Ax7Iv9O/20jUcFts5m9mJq6NI7qNOb7xTM2Jz75FJGcpxpW7jIdPE?=
 =?us-ascii?Q?B1/g0yyYEE8zgrfQ+gwdQMIirdTX28QER0fxkbPqV00VyTSN+Q9ULgh7NB64?=
 =?us-ascii?Q?ToENImaWphuaifb7mH/qU8zPHO2e1fqM1O4nSatMzCiNhrRQLnHyOuthH0Ws?=
 =?us-ascii?Q?IxI/SnYYjNZaVf9VP7WtFXQH79iabKXqLz5zYKCVta2Vl0LXiCoxhh0G8GH/?=
 =?us-ascii?Q?yAuiig7QiB5Qe26Kd4eOV7Dx+40fUbgpNxevxgsaFUnZk3pxz872TcmFGelG?=
 =?us-ascii?Q?VRc2OSE7yHECgyEORqwpf6SW8qF1gVO+EDOic2BrqDi2n/72YZt7VFEz9liL?=
 =?us-ascii?Q?C4rV20Ak4k+SB+KCX9aivQWmVPb4k2SgXLyhLowW4ZbU4mjkLAq0/YfdJhi4?=
 =?us-ascii?Q?I9F2ibnMs1e0FomCbxF81+TMMqrjU1IVgaHZVqYsc5LUDa1BBZgmxqMzvdS2?=
 =?us-ascii?Q?peUQGStA7TKY/U7j/cn6mad3RT2E+ESXPNKQpB4g/sKXVispJ3AnxROWlgJ+?=
 =?us-ascii?Q?vl/AiP3U8a3Kwhu08IQvBqkdT2BSJSHFf92UF1OANRupQtCnLH4STqDNpnhH?=
 =?us-ascii?Q?WN/p6W0VgIJcnaDv/yJPW66IGXDOwKfrEUkKMsLZ7xdy0Ef4eM7STSZsdX3Q?=
 =?us-ascii?Q?ubB7UD3xDDvD/BgAfo+MQAW/3I64YtLCMoSK4UMn136oB8jutluXy+nvMGrm?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aa6262-d75b-46ab-98d2-08da8793af31
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:19.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYkQA4XxP2FV3r7LLBHKhhygrCx5VoZHhULg04PTsi0NN2ZrurDHKnwwd6eteXU62E5LlPP9CvlHcWUjIfM0zi49Q4WpD0gtAVrQUyQz4YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: LulBbNsz_oGTeN82gs023lg6NWHdij5V
X-Proofpoint-GUID: LulBbNsz_oGTeN82gs023lg6NWHdij5V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To handle outputting all variables generally, we'll need to store more
section data. Create a table of ELF sections so we can refer to all the
cached data.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 68 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index bf59962..f67738a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -38,6 +38,7 @@ struct elf_function {
 };
 
 #define MAX_VAR_CNT 4096
+#define MAX_ELF_SEC_CNT    128
 
 struct var_info {
 	uint64_t    addr;
@@ -45,6 +46,13 @@ struct var_info {
 	uint32_t    sz;
 };
 
+struct elf_secinfo {
+	uint64_t    addr;
+	const char *name;
+	uint64_t    sz;
+	bool        include;
+};
+
 struct btf_encoder {
 	struct list_head  node;
 	struct btf        *btf;
@@ -60,12 +68,12 @@ struct btf_encoder {
 			  gen_floats,
 			  is_rel;
 	uint32_t	  array_index_id;
+	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
+	size_t             seccnt;
 	struct {
 		struct var_info vars[MAX_VAR_CNT];
 		int		var_cnt;
 		uint32_t	percpu_shndx;
-		uint64_t	percpu_base_addr;
-		uint64_t	percpu_sec_sz;
 	} variables;
 	struct {
 		struct elf_function *entries;
@@ -1167,12 +1175,13 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	if (encoder->verbose)
 		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
 
-	/* Make sure addr is section-relative. For kernel modules (which are
-	 * ET_REL files) this is already the case. For vmlinux (which is an
-	 * ET_EXEC file) we need to subtract the section address.
+	/* Make sure addr is absolute, so that we can compare it to DWARF
+	 * absolute addresses. We can compute to section-relative addresses
+	 * when necessary.
 	 */
-	if (!encoder->is_rel)
-		addr -= encoder->variables.percpu_base_addr;
+	if (encoder->is_rel && sym->st_shndx < encoder->seccnt) {
+		addr += encoder->secinfo[sym->st_shndx].addr;
+	}
 
 	if (encoder->variables.var_cnt == MAX_VAR_CNT) {
 		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
@@ -1238,6 +1247,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
+	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->variables.percpu_shndx];
 
 	if (encoder->variables.percpu_shndx == 0 || !encoder->symtab)
 		return 0;
@@ -1265,14 +1275,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		addr = var->ip.addr;
 		dwarf_name = variable__name(var);
 
-		/* Make sure addr is section-relative. DWARF, unlike ELF,
-		 * always contains virtual symbol addresses, so subtract
-		 * the section address unconditionally.
-		 */
-		if (addr < encoder->variables.percpu_base_addr ||
-		    addr >= encoder->variables.percpu_base_addr + encoder->variables.percpu_sec_sz)
+		/* Make sure addr is in the percpu section */
+		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
 			continue;
-		addr -= encoder->variables.percpu_base_addr;
 
 		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
 			continue; /* not a per-CPU variable */
@@ -1347,7 +1352,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, id, addr - pcpu_scn->addr, size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
@@ -1411,20 +1416,35 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out;
 		}
 
-		/* find percpu section's shndx */
+		/* index the ELF sections for later lookup */
 
 		GElf_Shdr shdr;
-		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
+		size_t shndx;
+		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
+			goto out_delete;
+		if (encoder->seccnt >= MAX_ELF_SEC_CNT) {
+			fprintf(stderr, "%s: reached limit of ELF sections\n", __func__);
+			goto out_delete;
+		}
 
-		if (!sec) {
-			if (encoder->verbose)
-				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
-		} else {
-			encoder->variables.percpu_shndx     = elf_ndxscn(sec);
-			encoder->variables.percpu_base_addr = shdr.sh_addr;
-			encoder->variables.percpu_sec_sz    = shdr.sh_size;
+		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
+			const char *secname = NULL;
+			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
+			if (!sec)
+				goto out_delete;
+			encoder->secinfo[shndx].addr = shdr.sh_addr;
+			encoder->secinfo[shndx].sz = shdr.sh_size;
+			encoder->secinfo[shndx].name = secname;
+
+			if (strcmp(secname, PERCPU_SECTION) == 0) {
+				encoder->variables.percpu_shndx = shndx;
+				encoder->secinfo[shndx].include = true;
+			}
 		}
 
+		if (!encoder->variables.percpu_shndx && encoder->verbose)
+			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
+
 		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
 			goto out_delete;
 
-- 
2.34.1

