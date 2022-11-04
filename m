Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721661A564
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKDXLM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDXLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCAFBC3D;
        Fri,  4 Nov 2022 16:11:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj8qw012149;
        Fri, 4 Nov 2022 23:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aLkIebTrAX0eLDCczskBmTOAqODqSM6eQeh1Ond8LoI=;
 b=XZt9GhxPecb9BsGQnZng5pNbbfbm/c+9SmDUpQR/AodRJ57Bd/lCQe9EKo3DFWSeYxGJ
 7PrSEbYeBVWRlSDhxmIAyjHCUwxNwS5Rvo9NSey34qxjF/LA8RQITA8CjPFlOM2HEVns
 bfdiq+tKo9XL+44peIxpoLrkg7xLz5mea0x3d7FOmMypmBO9dGYX6Pod5Fb2HjLLNLXY
 zqrF4q8jPsouqTo/VvnoQ9gJN0o9hjaHzbqN/sasR9O3vjoCmF/OD9Md5nu/nz95ZOAh
 TwHKYu71thjaKSZBBKbVCyFWT2QqvS42l/W7HloeQ7sWR8XU4n8C7UcHfqKCWmil6+tH /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtshkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KwcgX032161;
        Fri, 4 Nov 2022 23:11:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmqb6r4v9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO2fD9ATUtB2UnJKi0vu/XCWFhI+EhE9C/0GALI4/XVwFG02zivaHGraZDbpI8erKZBRnrid4pkSu2HMToIVgI+VwN3NpvoPIRt1nR1zB3U5IhDxXKPV1ZwpbQrdy7myrmEnlfjDLDj5q94EVLH9N5e0wG9MCtYl/jtmUiCURdlEgbQHf0UoPxEit7bTa09DzX3WjVmox1VUcdPwBSzkrd3QJEeUZibktzgjjQfdyC0p4GQnbxxHYDOQ6rhgAjs+5fh/S9SkSPdomJ/eqYdAlMqG7kmk7+AiyBmqgPhhWEGpiLPzTQA0RRD6V7hYFNCIe5HygEIjQRZNYUuRSmyPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLkIebTrAX0eLDCczskBmTOAqODqSM6eQeh1Ond8LoI=;
 b=MhfLih9fNzvvnpWeUg1rrCEu/CeJ8DnzL/yl0IMp5KaHeKpuR6dNJLsuIt/lQoBIgu0xPhA6mkreP6Q4BrGiJDCG72SEF7E2Nk6MX4POGKYA34NKfA9IG0ZnoP4CzQpfJQ/itUO+/w8g6/g0ZGNMd69W23amuJumt5dy5Othrg3XqXFDOqkrjPD3nrTPAKBiWXDlfZS/oOb42/dnPk8zNGjF3+1xRG9eJUuGIneCpvBa4CJxjNgZ+ImTZ1ZHlXnBm66n+Zaw8FnCZO7hJNJcFbKWdpoLYTc2sBTOS0eEmZaPvcDjD5J4nhrV0k3HVOvqRICyf6VgaECRRRSBMSKgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLkIebTrAX0eLDCczskBmTOAqODqSM6eQeh1Ond8LoI=;
 b=dzHpzeYeAOYu+MB+Vvk3CV4jBE8oGzKSEz50y4mgFvh9LQeerujXb7nGufOg4RSB/Uqr/4TBsDdAhv9DE96oU2jBe5QN39Wa+kkTEozScUyog+WspTkBxceDfNGWPOzPYuuxU+LMg+LBJ272az1fEZSbFq7aJOpWdXsc26dGZao=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:06 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:06 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 1/9] dutil: return ELF section name when looked up by index
Date:   Fri,  4 Nov 2022 16:10:55 -0700
Message-Id: <20221104231103.752040-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 773f3fd8-965b-49ce-e704-08dabeb9da19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ2wPspb0GNhsmkHG/qfqoJKh9OZNwSt618Gprz5Fg4M2aVkEteD8LV24A6M4wQd2GQzf8je7TKoKL7JVAfvKZPbedMeSLk0kYw/2VkKCofhAKtY9fUvIm0ScLiW9aRfhsX0XS7qqssCXniqUMK7Vz+iSi5voX0+/hK5Siy/WH+78uKQyw/3iGxrZ+9q6sovT1Xc7ZExdu+VcTAMh5VGQzXJclKrPpVQVSgolP7+nPBoCv4Q0+Wr1TOcakeJxCxF3FO+gbqdN7DIieL19Lc2GD8eYLIfflN+c5rN0QbFKqvRvj0LX+q4FzLRoi/VMtG26j1rRIOlKM8OnzSUBKQTCtXPsUQEWp2y3CMeFISTRzqnvGISKVXuUaAJ/r5WekG/ytE6XdtmkZkViEKf0c9OltYt6ZLEckGMwT9EiaBGy3vY2vHW7+N28S/pDzh5Xi82yzJl6thsw74CaImHO2jm/h5Iu3t5T/k2qeAAWVatxDmpZZdf6w/E3ht4QAkMVs0z6OF5Z86NwlusRV+s7aiScZFUJGIjQ+BzKyV8wkQR8wYUT+1t18fIbjeDD8uy2TKjeYyNFIdy4UOvYm2V/vbfjYLu6rVz8X3gcTs6Mp8lL4/XdQ+gSM9TenW4lliAPTkjw/wX8b2jQ/wD1rraY8FHONkCo9/LgS0vuxpbY9q+iRoHDvmg5mFdtzeTsDhFwiGUePo/sokX5WucctFANddVeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5d5LAfWySYrkTKg6VAqHut9SN3QbvE272mav5xxedXswLSuV8V4G7lqy2Sc?=
 =?us-ascii?Q?3T3uXM/IHKEoqtuXuubQCNK2Z/pUDKx1E/WtL88ciOXJZ2v601lHSym164O9?=
 =?us-ascii?Q?k+x32MvZyfj4Doc+iCnmDVn7v8VDZT0IZwZCSeGr8aBkitmNXE2P6xsjEFtV?=
 =?us-ascii?Q?l2qJa7CFdbxmFaGaYAiWu/zTnSjOa7zSP/BO0FugTqYHIwLaG5GVMWs1AnI5?=
 =?us-ascii?Q?jUv9uXzkJQ0Ed6qyEIeUahF98JA7qDD3MM/R6DWSPqKB7sVyEJCJ4Hmvp29N?=
 =?us-ascii?Q?GbqDiKaXFPx45A4yLP/7swELfPJCKtfMYem6pbSeM3tLiV7o7ea6tSi1UcTo?=
 =?us-ascii?Q?r/yAh64lUXQj7Z3GW0+DLzIyTQnm8CekYNNPBs059mfP4pfwDjSaorrcqGra?=
 =?us-ascii?Q?EH5SNiXUdO+gQmEzAD3hySiJ4EAvnNZU6vXnNw1/iPjSXFIYhQvym/2vreno?=
 =?us-ascii?Q?+wu1JIFMIQSsDFbHK2+5oILIzrpfD79qJku+IxgLfctrh/NHOt9gg8+u9O1S?=
 =?us-ascii?Q?jhpb5OlR+T5qnq3LmrHxL96sUqBWnyB/ZMOpvEIPIZlbdiZOBCiL3+UBew9t?=
 =?us-ascii?Q?UO0ReNOzkPewJ9ghMR+xFkeZr+AZnGA4UyYNuiJYbNurfJ0tiaih2Idw3snJ?=
 =?us-ascii?Q?rJZEi/IdQbzxN/pLfqONxFgnmyMVAP0FlYI0+61etaiRCEEkfDuBAnhzF4gW?=
 =?us-ascii?Q?akhhfVV7KNjOwNcsYjuCCdq/K3pzq0HhK96sY41JX64toef5StIptc85Jh/z?=
 =?us-ascii?Q?dGJ+9AinjIsv3JnMXieoDcXOioBUiSQNSkuoETN/xcsualuqCk75CdmWEf2v?=
 =?us-ascii?Q?SZBAgUbMmtpLcN2k/FhlLNMLT8FSalJpyU6J5B2KPTg34RWIgBn3l+tSDwLo?=
 =?us-ascii?Q?yE0xThy85uwCUnZ9jDhv50pQeShu7nInApR0lWJIkuzprNKeMDJiklIkn8Zy?=
 =?us-ascii?Q?9VM6A6RSFEOzSr6aG2DESI1VdtPjQWCdub6OclcBPoQ5Y/GiH7bdjlbSMkp8?=
 =?us-ascii?Q?htI6gWRc8ye5MkCE127Jvb+/5iPB/UNmz11h8DWJWlEWEGzIGu2XddFxyFic?=
 =?us-ascii?Q?NF/sD8ReDTzg2V47cMhvo4O6Xlb8Ykeay3xl/bYcxg76SSE+yoyPnrC/Psl9?=
 =?us-ascii?Q?uBpTZDcEz4BkPUV+oatbcy5rh1hRxrE6sgIYkRmjfi9vNLirhIQ1lOm/WKTc?=
 =?us-ascii?Q?Inqq71Z6DII4GorAcdFXUih517Pb5YvvofaKBh43CynYR8dK/Y1x9BoDDPCA?=
 =?us-ascii?Q?oB7zgX1H8dtwn8gjdUiwaxcEoppub4xDBwp6MuVfqP/3DHGdZoPx6vvhlgJI?=
 =?us-ascii?Q?vUNxLXRjcW8dIEZEoWzsoJx3Q3x0Kak+j4Rzxatxq0Vxn8s7JSLd8vzSa7Ni?=
 =?us-ascii?Q?G6WGBhl8EAarAvKZiO4DPFEskTJ0DrRE00ttAr+OgtVxwhRXsfkkO3CQklZG?=
 =?us-ascii?Q?ZPI/kfA9vdXbxzR+dT94DgJEPG6Omrex05Bvx/4bNf4yGXcMZEnL4cBWSv4u?=
 =?us-ascii?Q?G7MBvAmw4ucb0oV9yw3JnR2OsjKicRDm/9p9LxqJxI+xQKx56sIf4v1loqkT?=
 =?us-ascii?Q?wrBnmQccd++IKkHbnVtUp55tv9gc8KX8GxYdaGLcBzQnIOgzL+s3Jzdip2zE?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773f3fd8-965b-49ce-e704-08dabeb9da19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:06.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjFI2FLq+mu7u6Dl1vurhiAb6KtHVCxk6+zh5OxLH7YFkRvKylTmoVdTc9UQ+eIfN0++6+b3uoN/uFrHwphMn6CgGeN+zmvqJZWfYpAC2zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: _HW45WktzzNVoCH9gQxoDnKpn3zUYWNO
X-Proofpoint-ORIG-GUID: _HW45WktzzNVoCH9gQxoDnKpn3zUYWNO
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
 dutil.c | 10 +++++++++-
 dutil.h |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/dutil.c b/dutil.c
index 97c4474..a4d55e6 100644
--- a/dutil.c
+++ b/dutil.c
@@ -2,6 +2,7 @@
   SPDX-License-Identifier: GPL-2.0-only
 
   Copyright (C) 2007 Arnaldo Carvalho de Melo <acme@redhat.com>
+  Copyright (c) 2022, Oracle and/or its affiliates.
 */
 
 
@@ -207,13 +208,20 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
 	return sec;
 }
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
 {
 	Elf_Scn *sec;
+	size_t str_idx;
 
 	sec = elf_getscn(elf, idx);
 	if (sec)
 		gelf_getshdr(sec, shp);
+
+	if (name_out) {
+		if (elf_getshdrstrndx(elf, &str_idx))
+			return NULL;
+		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
+	}
 	return sec;
 }
 
diff --git a/dutil.h b/dutil.h
index 335a17c..ff78aa6 100644
--- a/dutil.h
+++ b/dutil.h
@@ -328,7 +328,7 @@ void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
 
 #ifndef SHT_GNU_ATTRIBUTES
 /* Just a way to check if we're using an old elfutils version */
-- 
2.31.1

