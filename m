Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637561A567
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKDXLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKDXLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BA45093;
        Fri,  4 Nov 2022 16:11:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KhqTo032442;
        Fri, 4 Nov 2022 23:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MZyQaqsBqs8xlx4aeVUe/+ePpT5BKB3GcK2MunKrlYE=;
 b=WE0htxSRlJsaAs2KfwDOZ19FVrvvJI1a6R9oGlPUYoI59WlSdgB5fpS2ywXkYch4yzcn
 PXbl0j8+i4RUjLo6t0MhSHzWUjFb5sEpzZIbdYFRlnim1JyD11nDG8DdW6m0lpBK7oU0
 qoClB+pB5wEw/JWp4WzgwtWGIVgJQqYV/B+0eS5wIhNklwrpWjMobAhPYb/LqP6Wg0TZ
 8G84jcxfn/Jrj4YM0qIv4xDhVkTEGVovCoO/OZcuTLDxuS6ysAoJwpphzZdTjM+I2n4Q
 PE778gTKXKyPVj1EI4DEjU/jhkfyiHrcHnrgUhZJALpwjEu/u9sMJGMEQaEpe+YvIEDz ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty3980f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4JDuPV016531;
        Fri, 4 Nov 2022 23:11:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr4t3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyvoylcp6kt/krgceP2aLddOi+Up5lYWCMAE5ndrYF4NfxR1ADHCYk/T1iBNfG6rWSh1trWUuq/xCTvWABus/xSWoAYClkJeZXqMy2wTXy5YmN33Igxhi6m7UpvbjQRUOtfXbid8r0u2Jxf9vPS8LihX7yuAY3Cv2ecRfnz160+Z4UNWTifD7JEi9Hw7FHbMQsT9oVcwHXC8kGOKKbNkim/xZywIsNH+MpUPwUQ8oSlFLIjosDCu3Xw2Ea0sF1pDwWeUTYj0M8qD+Glw1hrNXWs4HS552yPNVSGmSuMs21DUcIRCB5xpyOLoUgDHPqjJ8pPzvjXLhu3pRZYXS71jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZyQaqsBqs8xlx4aeVUe/+ePpT5BKB3GcK2MunKrlYE=;
 b=hut1FgrHfNKPr+l7wRPmT5UTKKGjlqIuUFDc0ubE6FCHBu8qxERaUr9swb87MHKBhqnMSl/EL3LaU4Ifqd91KMcNx91kvpLwubkpb/rrpJrop9M6wwb0ajmHbZGBeyUyXEfAn7oxM8rX+COlY15Lbto+LEimXCE11+WgARTSpp8lkXWz7FQ/m87wjM2EgIBDiY4blUAFJU8EPoNjoUFbclvfvdUWzCYKi0GhcrgPHedTJcE45AnB1G5FBXLZ68eQQbDv+GzMyQRVOyYBdws/HDJ4aB+LB5krxhfbsP7FHHRzZHKbxENsXhN2FeOvICt1cUZrCicvKCxERd4Am+7/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZyQaqsBqs8xlx4aeVUe/+ePpT5BKB3GcK2MunKrlYE=;
 b=q4+7u2W4NqEBuxGfKpmh6iETZ9krfcAwzWqL/Q3y+vj4j38CHDbxI7ctLlMoeV5g8lfUNmlvPGGzsv69Sme+fICnc67eNV7NVw+yTo27rpFkf0Zy+k1cx4wchDyAM0dNPGEVUnfwWZb2Rev2Rq5YVZivN/lYSUjO7yU1mvI+Bqo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:10 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:10 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 3/9] btf_encoder: cache all ELF section info
Date:   Fri,  4 Nov 2022 16:10:57 -0700
Message-Id: <20221104231103.752040-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: ae41c101-5aa7-46a1-19e9-08dabeb9dca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiGXgkBFNMC4QaRc1LemGbmSpeI0YmJbHask/SpUY7prM1DDREso+aJqIQCx94/feA1Vey+jsRwK+ytOTFVSu4+O6WWUMPb0Xz/GlDO3DdBxiPMPcAeBIzXx9CRYGvxrWVPBj4hbkKnL7yE4r0P9Itp+Z19kFDtf16a2KMkCM0j27nRzCp79A6VNoOl07+i3G4i68GsA/yZuOpBpwnqUnDGl4x5GwPNhRIyeOHqP/ZHi/8Rimynz5+NtH+pyLY3sDhAAKKlTV/ECSVja1IDOfi1IUJm1di8Ucrl5Q2a16sFtfCaxxQXHQ+Qedu+s9rFDmXz0TeEEiTOzYpydBPq01ccVQgRPHs90/ZEMIsqlDE6F+EPp7HHUYMt4h4Iw8CGxzlEYRUL2m6muT2BWDiZZ/8ZjYVFd8MzTJK+czCNlhIprXzTeVdhfznfTUldx5cwngWOCqjSl7yTywOxpXS2xmCwJqAUdeJp3f8XvXs19FaPdbh9qNA4GixECD5WpOQCMAp6KVW1IgiL+bRiwL3YYQCJYgLnhr0g1KrSD60mVR4wsh7E2+Kyj1pMiRNKvI+5rZPHsKYbDcBrIN6dp8H27Z+7ASvvFOpVkNkZ8lRR5tZrRRWQZM+xB4eTJWtM1CsNlnIdxBxK4nZYF0Iuk69pXoK9WKBTGSt0P/l/Hk2usr2nOvwCZNhSACB4KovQ03dowH3ytTGan8fmWu6a4K9aJKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W71uJvYeP8ibvcOD7t79IwCFnIF7Gtp5JYF5dRRtShMZq35zId82BMwpnyyt?=
 =?us-ascii?Q?VuNS2J/hsYy3i5H24HUDvUwd7eJyfbum/zRcHvddd94lKohk+hF5u3b6b9Lh?=
 =?us-ascii?Q?uj0RODZx8DDMjIc118zNYVZT83bWZfe8WOnRtjXH7t4Tb6/XTkV9rfFoaqL+?=
 =?us-ascii?Q?2AnmxUPucewtIl4B9dXK2ej7ph6SL/GjbJiz0rNp0E+cTNHA3mQw2p8QTJPI?=
 =?us-ascii?Q?ymapHBj64zyaaBLcUWyNTeCQel5hZB6oTuDvkrPzHiiUTIobW1roCxYgGrYM?=
 =?us-ascii?Q?gwepWq9bUFxAlCdm0+oyzPFxdLJPhO1CcwWduNbaWt2T7Sb1M5mIQdaGUrOG?=
 =?us-ascii?Q?jyHVNPZ2Q5ORmlLfORyLasW5Jqc60SN5XM5oVjymsytH/JLtmGrAoUikIaWH?=
 =?us-ascii?Q?OjSHMyGXm1YCFUz6BO9pzgav9KL2LNqwgBJtq6Dl7dmeaozT7/0Vd86+XRGH?=
 =?us-ascii?Q?IT5+ZyMhKuFBlHqELmbS9XrqwCbXoYTjqg7i2mKCK+sb0AdmILNEYOyAPyyt?=
 =?us-ascii?Q?tGBW5ZVyBjl/kdaS391JYD02xbng4tgL2k0Mif06L80mmKKNkQz8kxbDCCOT?=
 =?us-ascii?Q?BaaJDjzirmNPHuR6AJTDUORFo/WfxYSprczuFi8ClP/3zsE0dhcpwDhc6/oM?=
 =?us-ascii?Q?mpVTN1sZ0TuDwBHi9Jr2sB1bcAmzkbh7il8ICIA3UV2eTxE7iji0X8Xr/o3e?=
 =?us-ascii?Q?VLuayQSMnl7LROXaZvWraJZJzNaOZPaz9TQXkqp4fRFByz38Dm5vsEN40J0F?=
 =?us-ascii?Q?tacM9RL2k11R8KC7jMsvis5r/pL0kzgd9iXuydkhSWuUy4wT5+FtPLTxDobA?=
 =?us-ascii?Q?wFlZLU6mt+4g49hetCjs4V3MVCXkI5nPxUiHyp8fj4MW1ftmsQEm9JSNRGXT?=
 =?us-ascii?Q?ZaXpdQfMZKSlWhAwT94DyxUSuRQZ32pbtfTbYwfvRPa6LvHbxmMK9R7jAJNQ?=
 =?us-ascii?Q?bo96KBvi7rW3LqWgJIwUc0TpsVswJ68G2yGLPJpmcgciroUjx+UFDCbT8boL?=
 =?us-ascii?Q?XhJyl2SnbtFgol1utMfBHEyq9AD2v2VL3hfnHnoVhEkLEX9X8AJNW9mTqEpg?=
 =?us-ascii?Q?RSyV7OBNfaihVKCOYfR8kQ2XJeXbbdwTM3xGcH4MFFOOFkQ+5dPpCctIUaBX?=
 =?us-ascii?Q?1xHNwFnXh+o+2+3qlgKEQZjxG3IeKQ9gPjZUivdQVIOo8R5XGO45H30EfFTW?=
 =?us-ascii?Q?lpXYjyUzUvU3cZnyGnAvegE87XCZHBNd/+SALhLO/eY28iT/wSufKUqHziT1?=
 =?us-ascii?Q?sospFSf8i/zPWRIlTU36uC+QhUjd9RJmNzxaN6RJx6VUAsulJ4lvHWFgEvs0?=
 =?us-ascii?Q?zwVqxM/88gprLWopZ0VDUhLeJ9ZB2ic4FRLVr/Sm5g3ymcvdnaDLZtetZ1/r?=
 =?us-ascii?Q?2htZM/rEH/5rJJblPQTlih19TnrcZ1XX9EyigEKGYdpdYOljkMjScf3kHdoo?=
 =?us-ascii?Q?YneE1ajNNEW0/Q4vIdUEQvtio/zFxWtYMTczchwcMaU/fy+fjCptBTtcrOje?=
 =?us-ascii?Q?JTfpBdYwCFU2qH9IbqdSvwI9EB8lL8OoNG/I4zZ0GY5TwHpKycPdgbNdHOVN?=
 =?us-ascii?Q?e3yoCboh4OCAN/IhubNxl4wvVUlg2Zx2h5ZADTFkKqQGubDK7WpCsy+H2ro8?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae41c101-5aa7-46a1-19e9-08dabeb9dca7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:10.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVGROONktehqtcAAqvuDxacqSmJ7A4Hnh1rapi0Q9/IerhiWw0XlUd63RDZ8oHFJzXSeGtOCcFf2uhmcmTXXE3JaJOYS3oL+7Vpc7scNvQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040142
X-Proofpoint-ORIG-GUID: vKzZuDJVf5atiZIRjo5tGeHTh4dsSH9I
X-Proofpoint-GUID: vKzZuDJVf5atiZIRjo5tGeHTh4dsSH9I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c914647..e0e038b 100644
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
+	uint64_t	addr;
+	const char	*name;
+	uint64_t	sz;
+	bool		include;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -64,12 +72,12 @@ struct btf_encoder {
 			  gen_floats,
 			  is_rel;
 	uint32_t	  array_index_id;
+	struct elf_secinfo secinfo[MAX_ELF_SEC_CNT];
+	size_t		  seccnt;
 	struct {
 		struct var_info vars[MAX_VAR_CNT];
 		int		var_cnt;
 		uint32_t	percpu_shndx;
-		uint64_t	percpu_base_addr;
-		uint64_t	percpu_sec_sz;
 	} variables;
 	struct {
 		struct elf_function *entries;
@@ -1216,12 +1224,13 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
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
@@ -1288,6 +1297,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
+	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->variables.percpu_shndx];
 
 	if (encoder->variables.percpu_shndx == 0 || !encoder->symtab)
 		return 0;
@@ -1315,14 +1325,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
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
@@ -1397,7 +1402,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
 		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, id, addr - pcpu_scn->addr, size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
@@ -1461,20 +1466,35 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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
2.31.1

