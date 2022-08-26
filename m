Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E545A2F62
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbiHZSyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbiHZSx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91AAF2423;
        Fri, 26 Aug 2022 11:49:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDtJM006700;
        Fri, 26 Aug 2022 18:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0ruRXZ7WRJP9qd5Z3A0KR2iyc2JhvqKbSEvMz0I7AlE=;
 b=j1SzLn75FOmjfa/33IxGzyNOGhJNchAmQMvecUTAhbqwxQrNZYFieqRpxJC2eBguLiRz
 OGw8KXJgAG5QElAxmKtsPWYKy2uNmhrEQS1Cs0pyKd0OvNuPK5YDfLcJyWlv6sK27oWS
 VSYZnWg4/t/C6Xc7SLuMFLsGGiszCDiArlnd62V2yVXmWLJ6/TIKaY7vx4bLa4XKFm15
 DS+OovTnGBJbH21N4yjol70j13S+ueKDyRYIubbRmruYTJ4cSKoyQTkZnJQJOINNU83c
 GbAdVLexsuPP2DcQR91yPxKqAvuT90SkMPcDhCLHHSD5RQc+P/+TiDntvT1oB+AXraOS 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p28j6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGopL4028138;
        Fri, 26 Aug 2022 18:49:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4p7m7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6tOBXWO6hjAGmLmt+nNYu38RHBGUAHAzUDcczRPe1co0TMGNFICvFPAbPu2p5ZCNmXPF6alpI7BZHyDddAJ0rqyXsZHjhDcRTob3zps6wmgoMQWiZaz1G8aWTEA1vaqJQeqlt35vRG+pT/u95DsM5L5EIaYTNMYOGdf73Or6qCcJFi3qWdbHhkVzmidauZcUVEWBiPqXeZRlOBf25pZxDqrFk5mwZr1y+hrJBL4VKIlyPNADasCIkMBHIEvdtQ282vT95Dfa3GcWz45QDFI7O2VFpo4sNBZ+3/KXiyQnz++aMotF1TErvrCz0Bui6GW0/aWLgS9wbTNRZ2Vq2mR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ruRXZ7WRJP9qd5Z3A0KR2iyc2JhvqKbSEvMz0I7AlE=;
 b=dGcgd3YjeZtGl20qi7n8hLqZr8lGWg+34DEyu5rjEWVw3nX2s9eeB2nnk6iPRW23q0qydrlvvQ1u643FjP773HPdFSc3l21nKaSlB8QYBd7384SDtkg3F+hNv1gLQM9x8KE64pa8O+kdtm+/moFPfCOmdb2EZxoW36BBSu3BuZrY8yPsrogrXMu2gEHMSHs81zJtLno+bu9UTjbpbaYwcZVob6xoQ8vudmki1s+pJSIvcSr0BFj1SNjQw9renQ2y1/IDEKigJASx4kLWLGHdW26uWluEa2DKR7Lb5xRtP53abWoUtBm1jPt2YynOwzmWieO/Xh9pDzcpiFrtHHmzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ruRXZ7WRJP9qd5Z3A0KR2iyc2JhvqKbSEvMz0I7AlE=;
 b=eJwX+9ZqlwlpvVkpZrZ2chcFFbS62So27wL3YzTxmJcqW+DHnMn15maPNJzzoDVTJAKZ6rp7hyimEZYl9j6IHcPTWEYlXQHzjfY7ouBnIoeNm3HNjc5Ai7etBLmfhpQKEz01k/56eDOKeHirOFRYDqLiC6bMICiS15K4fbEEtVE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:23 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:23 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 5/7] btf_encoder: record ELF section for collected variables
Date:   Fri, 26 Aug 2022 11:49:09 -0700
Message-Id: <20220826184911.168442-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b167d098-3916-4ee0-141b-08da8793b199
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORDN2Gz72Yi/eaOU/goVGIHIvg1JQRkrrV0R3jzPLdfvrfKnUKAuQrg51S9SFOUTMkh8Zkjijrd5YQOga3B6tVGhts4e1Eh6xHPjKnK6JbkI35eqJzStJaDvABYkcArjsFhv0rqdqGKXajmsz4QebOD58qTiHXanD0HwiRzHtSUS3dQBPE7cxfzLHAYzndvpnRNoqZFicVbhFs/mcf8jxm54EATVCGy0JnPYSSYS7w3NPrHsOVtMVYd3crzzJ1xZHHUcd8mhgZitkAMYEO/+Ikt07Z4rU7TZXT3vSzasdu+1gaGczPrbO7UisJO7hco5Vt8tvp07UtRgoktRuKWAgLYrZR0IGRlxpMVJcAf4K55ZymHKf7X9zhLqbPlb7rk8Dr0/JxVRmvc8R0tyf0A1iqD/A2qAL4cFivJnGk7tmK4W/g7wsSNeoGef0cAYpQAC4EZcuWxeijswfRD52D+aqbPrk/N+e+Uy9U+gmZYCgfw6JCbkyBu+HOFZDdOB68nKhszuKPBcpoIZ/Y2vx9eFR38B6h9GmoA2gyG61ZYzCXxskrVIb2H/jpK8HOhSHBZErDfsJGjuHj/WYK18eH08WJVfAIlKZkzZZIQMOwIPRJxBne67zSn/FXKWgwtB+GN32tcu6bpMkLAh+btiwfOb90hOzz+3AD3wDJw6KBISuIxHhw8DNATkMXls21+A9GqeFH2lIxc7e2RsXBcjmv4wvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UW4vcQlfQe4HtAPlmsZjOM0YvOT5zOv/rYW1aESV13hyzZ3tEdd6L6AYqOPC?=
 =?us-ascii?Q?5wZAJquWL4j+3AbwH1TXZNxh/1+m9uA7UV/m5mkQbis7wBMCIpDP2QS9j7Vt?=
 =?us-ascii?Q?87cJGTsEy0KhfUBApQZgZ1RoozsS3GDora1Mox0/Kplg38I6qaaQRtSsBR/l?=
 =?us-ascii?Q?kmLiL895/jZXFlNLq5m1+DNevY3m6WPCniEm+vGkPeJnMkaKN0fNpxm0v/kn?=
 =?us-ascii?Q?vOZPZnQCpWHUY1Gco1HWTUY8T4R1p55bsaBitpubs9l8CIPsa0iVCGEWmGZk?=
 =?us-ascii?Q?PJ3EmLcs3hCcuSIBBfMbwgTHRemLs3Ezsr6YRqGxIyXAF2KPSYjR1kkLA4+O?=
 =?us-ascii?Q?kh/099yXrfPzEzyMsHRksBZqiPvZ9Il8ogLAyrpj8qsMxDgiVYtu0yT0Dx5E?=
 =?us-ascii?Q?/bNPZJcat498UMR3+/7tz0aTU6nQ2Bcw3h2Jdz4UDka5+L+Aajw8SKT36qMm?=
 =?us-ascii?Q?xIlYbHy5TFDXg195IMAvnBT3h/uukaD1Jdsrwse7/6x6gm2ZsLWbKINaIcxW?=
 =?us-ascii?Q?cvVKIZ8ahspu2p/dlwTOYuT9sZ/Q8sT63u2aZCCCotr2SRspV2pTTfjeFFhf?=
 =?us-ascii?Q?4f1ivUxxvK1lTp7QVn0AbGALVKbK+N5lsw0p3u4ctVoCGOFdeXm7+ueSPwd1?=
 =?us-ascii?Q?nVn3iiRrwmbxsF2HYk1vEvXwjbKYd6kFYk4FHms4I3td7BJAQoo2Kqq9LMCK?=
 =?us-ascii?Q?8OIp0Ar+LLKZabiL3epKIOrMAsUtsIuTl84/mOfdt4+9lD1pnloZDrJIxKBl?=
 =?us-ascii?Q?iky4/f8F2vfk5vzl+Qd2HdblyDLlNDQAqRPJQ2bP/KrWN9/tpH4eIqqc1Pcf?=
 =?us-ascii?Q?yFg99Ez2vqe0JTbGeYdUbckHyaryJCu4o1WCkWxX6m7VlJ9Z3EUi2dRIJrBV?=
 =?us-ascii?Q?XZu8t50DR6pVSf7qp4H6+9O6199rAUAIjS7X8ZlnzigoKtqWm5RGtZinsw7c?=
 =?us-ascii?Q?Wk1U+4NS0oPh4h8zixZPw5U6JGmTZc2wxK+FWffIpUPM1itZEcgYslvqJrnX?=
 =?us-ascii?Q?ds2XDrDOXt3L2Qxc6dz5zGQ8Msr8JSjKsRaAUVIlsXvB1rcWOl3Gkj+O8M5T?=
 =?us-ascii?Q?jDly0zAkGyIqxEc32SeHLIYPBLAJ/WekfRfPpd7Pv0e1i8Fpp7JPolic5s/b?=
 =?us-ascii?Q?bzzqKPDLBN3qbqt37mWnYUh0jOhHRCmMDPZOOz12D7C/Ct5lOmKjdkeS7LU4?=
 =?us-ascii?Q?YQ3BOEq6uOkVBYdJEl3X3c0OVjpLXSawqlX/juFmHjJCFgzJ+Paswe+P1zbx?=
 =?us-ascii?Q?9MbVqVxTwPLr9SfDIYAXc5AQHEz0Y9FYqWD0GxQrVg3tIBP3oIn8YqXeP696?=
 =?us-ascii?Q?sdy/4YX+2b3l8K5ylMbhO+YFWlfwpNxHIj0Exxopm8PEVXTRUDKEPs4nQJTk?=
 =?us-ascii?Q?RqTb8DwvBtP4e8qkM0pfCed3EPvLbjxVdjjd894Gg/9oNtB05SaE7zekwmpm?=
 =?us-ascii?Q?FaI4KE4CI0eL8Wgh1uGnwdr39SUp273sSE0iEjR58VZIuP81Ut/knOnjnkYI?=
 =?us-ascii?Q?qcrWERlKZlPAkrh0Y6S2nqXPJAVMKvuCJ9Z1j2/NvwkX/G/5dsD48aFj/V/f?=
 =?us-ascii?Q?OM37s97tQLW1A3+q2Lakv3oy+CvzwdtpSKMchm6dxlzwk2rT6/GzopWb4qRw?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b167d098-3916-4ee0-141b-08da8793b199
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:23.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koj8o/rIdP8EWInaRpW3fwhEUHFjY/HKMDWzAinwxGseQpPZb/wvPrzFabCs5M2d8Nsq+F9rLZKSP6l8NhDtqzeGV3oO+ZIByusjYZVdRZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: sKJLwbDvcM8dad_Gqz-e1aTdkEzw0J_z
X-Proofpoint-GUID: sKJLwbDvcM8dad_Gqz-e1aTdkEzw0J_z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ddc9d00..83aca61 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -43,6 +43,7 @@ struct var_info {
 	uint64_t    addr;
 	const char *name;
 	uint32_t    sz;
+	uint32_t    shndx;
 };
 
 struct elf_secinfo {
@@ -1145,7 +1146,7 @@ static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t
 	return true;
 }
 
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
+static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, uint32_t sym_sec_idx)
 {
 	const char *sym_name;
 	uint64_t addr;
@@ -1195,6 +1196,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	encoder->variables.vars[encoder->variables.var_cnt].addr = addr;
 	encoder->variables.vars[encoder->variables.var_cnt].sz = size;
 	encoder->variables.vars[encoder->variables.var_cnt].name = sym_name;
+	encoder->variables.vars[encoder->variables.var_cnt].shndx = sym_sec_idx;
 	encoder->variables.var_cnt++;
 
 	return 0;
@@ -1202,7 +1204,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 
 static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-- 
2.34.1

