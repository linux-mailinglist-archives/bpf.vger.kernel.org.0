Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5495757AF
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiGNWdf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiGNWde (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 18:33:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023619F
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 15:33:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EL4Gta032708;
        Thu, 14 Jul 2022 22:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=dbJSuCxoYwIU44WaHkkDjJoXaNd22aKUEAfxuwXbBF0=;
 b=aQXW/t6HsDYl/6jJrouOgo9mhI4Jf44kpfwaXuF/5Q9jl28Amzm+j1s2HGkP2Vj4GE5r
 yu/Nwx3lyDBharZkgSGV3iH+oDgEonTpVBNjeKmrO6a4DyPY0at2OSPX5ebTaeQxZhmP
 x9tNQ5k9X8zaaVcsQ237KkgT8WXhnAo/bfnSPJINGM5ohE7fTBBrZLxqG5wY4PazpdeV
 h29vgAATbtDAR4CKG0c5mmycLKXYM9DKUi/yAbk5vyiAxXik1lPY4rMZKX4DwrOh/0L/
 F0YWMZ3cF5f8uP+SxwcbabhPqXAIS0lkPt1Z2uk1LENhPCdJDZLYiD1nNtH3XgSteJ44 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1e0s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:33:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EMURbL025276;
        Thu, 14 Jul 2022 22:33:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046ve7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNUtLdiNBweq102UTNlxgoJg/1M1EnAQuGIpmU3n6V9z/Wiwfyn2YMR+wAJiUKdN8KKkqg02P4K5rj7gkn12+6nvkySN2s1PAhnTDKOCfB+qlIrRYMfEigHbBpcB/ff+xvAGLHJl6a5httOdz4Qz7fC3D6Saftw4fimx0fWye9+YmUlTObm8grC88MOpuggGWCoMmWckFhxGw6iZNN5fLOddVQ9Q4N5QLgZpZlYOmQkrkkt9Ofo3515IKCIpHxz9pcxyFUn5iDUNK9ziwL0CoLnvQO8HRd4N6lW1Tg4uAI3vG2aDNunhc3D3nWtWNKwmGxRGi6VdgZCmZo5yQTeRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbJSuCxoYwIU44WaHkkDjJoXaNd22aKUEAfxuwXbBF0=;
 b=meFzkPQVCRwY6OwAaL3QpOQw6kh2OdkUUNFVbO5SCL94bndvkaJrUavLw+MurfuzUKUcrXy+cZAltb8Pg3GJ1C/VHnjE0ScN40c5E80ngXCksfx1QpBt6MDCVHE2V7wdmIlj1j3xm1ZlwknB8uWi9H7A1dIx5H+Oz+/RtqjaDVKStSwRTb+GU1A7nfEYTx1doAXpACJp5ogjbMi41JwtCC91kIfsmQ2I6KOW1Ei1suSlZF9h6bTSj3G/VQbNYkdlXRiNYp22lgth1q6bj2WqTk6Ee40tfEhhRGv6cl7IqZ62CblKlNtgpU6Fb28KXRFrXahJKWDN6Jagde8SEXMEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbJSuCxoYwIU44WaHkkDjJoXaNd22aKUEAfxuwXbBF0=;
 b=yHlY+Sbb6y/+iPJ7Oa+sNE8k8kMtJHZKwQOGwzLFth93Bfd2Q2fcvKQgLFrLGmvY8/sCV0+ZGTxT021/8NXzdsW+wUjUUK5t0FiyE9UQTDW8cOpeper7vwb8P/mM5Ycac76TM5Yz+SmED5Oc7oxjzpVZyilu1ip+vw629lXPul8=
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) by BYAPR10MB2597.namprd10.prod.outlook.com
 (2603:10b6:a02:ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 22:33:26 +0000
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b]) by MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b%6]) with mapi id 15.20.5417.025; Thu, 14 Jul 2022
 22:33:26 +0000
From:   Indu Bhagat <indu.bhagat@oracle.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, andrii.nakryiko@gmail.com,
        Indu Bhagat <indu.bhagat@oracle.com>
Subject: [PATCH bpf-next v3] docs/bpf: Update documentation for BTF_KIND_FUNC
Date:   Thu, 14 Jul 2022 15:33:10 -0700
Message-Id: <20220714223310.1140097-1-indu.bhagat@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd07b7d-4edf-4bd1-57d5-08da65e8de13
X-MS-TrafficTypeDiagnostic: BYAPR10MB2597:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ay62JP6SmpFSWShJ9TMECcYZnODpx80WVHrLEBeX6OCXGmFI05yp9kotrjRpxOTcA8k5FvHi/BqlQ1q6jMA4OuPZ9NLos1t7uB0W5Gm/VbqlzSdtEWbhsw9U2n9K8wEzQ85PV9Nqhg2K/TfWtsHcs3rkLdpMYCa62oAX9+GRslYK3G2HF777rvWkF5oHdxk3qJcbjGzEQgFUEEHyvumrTxuRmMVw8MEDCdAQd5b/6w88hGm5qKL/BxFTQDTWFd6UrvZ4sGOnSYR6fV35kKX68hd51tQjVaiC3bzK1y0ERMotnvx0RacTld2v98NOZNzczC2MjecdnpJtPY4M7o6fqnG9NR5/8x5Bd1N80Z3cWxIfSE6pNC5/rHAHQmuBeSu9quEu7jlDEjmU+HE3GQgKJfHZYkSz1FV4GdYcEn0p8C4eTIFNZK9g5Y6RJfD4hP5sCFhYWzlL9Olwa2x6nPsAGu1QWj6MdRGq+ZuYk8qHu3WA1i+1xXJ8q3277Z3EXAb1APlERphDcaFRo9xno/3HuKYDgTqJOrqkmKb+zeykBGLfAv1SWbBa4FNtNhzIGfxsJ/dapQD+jV7m3lymVWW2hgPLAitnFd8GKOhE4FSXE+PL4p3xbHlGhTnPG+aRwRorfGGiqcKQEkVSswoB0G2p2dQb+VPY+hE39pwlBIojmmFL7fcmKcDPKHXF1Hxlz2yFNeY0aSuk0AVVYz/EJvkay7142sQwusdzEfJ/ybElgnmHxBT/gqTIt5qM7iOeYoW7Eu3gVNrQnj76h0vsvboyHd33nf3P2+6WCOc0N75c+/Gvm5QPdu2v8v/D90DF3Y2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(396003)(366004)(6486002)(478600001)(6506007)(6916009)(86362001)(52116002)(66556008)(66946007)(6666004)(5660300002)(66476007)(6512007)(41300700001)(26005)(316002)(38100700002)(38350700002)(36756003)(1076003)(83380400001)(107886003)(2616005)(8676002)(8936002)(2906002)(186003)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLrd4v3lzWgb1LGnydMtAnOGMVJ2V46HrWXGsHAE9oU+tTa/Htm9SEh99pS/?=
 =?us-ascii?Q?B5kWpfyT5DfpLdi9eYktB0ebOdB2BK2lhdXDVvp7nbelJyMprQ2iZVgJmGKG?=
 =?us-ascii?Q?dVQmjwkVuFFOdTNDMFS7QTma+GjnGN8yh5DJfC5QFf1ijBCtt579bBFkzbrn?=
 =?us-ascii?Q?9sWd2jsRSdw5qQQAO99XktaImznw1ZhsjAC3vifX9M7Lap48kD6NTWuXHLOg?=
 =?us-ascii?Q?LD86B04rvVjL0g99sjBx3pguP04P6oqP6vSmBSGkSuhsD7F/PRujyfSArHeO?=
 =?us-ascii?Q?+RH/NtEKWj49S+v4MYPsQB/KRPAB2pD3G5FINsL5dofUI76fAaaWnSIHCMQk?=
 =?us-ascii?Q?5nHdU6k2XJlQnRybdn4BOoZDn95Duk4bQAlDg1t03bAeDG6iXD3fmaaRlvU3?=
 =?us-ascii?Q?m91pWdcG7P0q9ejg8bZL7fVsfNw7sZOX3Kzy1OYj+PMxjx4p2sxlze1iCHo5?=
 =?us-ascii?Q?mLlA+oKVuDss02ARto0DwAWAdZG05F7MqqmrNlK/zt/IrRvEE3oEAHPvfu1p?=
 =?us-ascii?Q?rY2dUo9lKiwk/y+KwfB8Te26ROd58hvRuRC1WL2pJcXNHKSENveN/A29G0xz?=
 =?us-ascii?Q?APj8uhk/PSWiZgvv3Txei6LHh+TsvhrtwCpgMsdRhmEE4jU3l8eHpoHqRdSW?=
 =?us-ascii?Q?/0i8GqU+oy8LcRsCMSiDh5jxNTmT8EqxfEUYn6F1NlottMWFQiWTsVcLlw81?=
 =?us-ascii?Q?swDS4OAROPoXIFtCQIWGGy5EwRaEPJK9O0Gj4wJ10gmu/3kg+DdBAaP91uyD?=
 =?us-ascii?Q?xrLYytSVBH1FpORM33Sm6vwezP1lwJChvWQiphlU9U6q/QHM4UHvWc5YSCjV?=
 =?us-ascii?Q?aWG68hkhYSV4+cpaB4RBDybNebslXd+xpKKcc1+Gi4+N0GDdXVH+WHafA2rs?=
 =?us-ascii?Q?5fS8wkaImZwQpTB1CpXzfpUBVmE5kZCGX0+b5Qxt464MXln7zw24lmbNU5Fo?=
 =?us-ascii?Q?64Qjo9kb++8JzNfy8/Xh71Fm5+euJc7eLmHmp6hHGN1NoaqE+9weobJFh9no?=
 =?us-ascii?Q?aXCXaeyn+H5+kgDBgRXJzMwpU/bZHwqjZH1as2mKm0cqXDFHSoe/6dc9il7+?=
 =?us-ascii?Q?jOJMaxAdveDmvSprCGKnralR6R7NI4VVZcEvDKEvsLF0GQa6B0ogL8qsdek3?=
 =?us-ascii?Q?/MN7TU2d/hJqwhCFcxlnQWFlyljm/AxpiPRkCVe8BqlLRETDikEy8xJXJQzG?=
 =?us-ascii?Q?NoSkc2XdPYv//y54GgzT3K7bJFG7HWNCGzeI2WytZZvHDZkV61p7nbJeC5vs?=
 =?us-ascii?Q?dDyJIbAbeO3u66fSYPtp2APddeJK6WEg0A/KhYHaSeCkDSR0E4G/sgAf6HuJ?=
 =?us-ascii?Q?8lpi5vqGDtL8cATaiyy+yrCAUVkQcAU4x5ifvsotp9cKaYRJeAxKeVBWbr7A?=
 =?us-ascii?Q?V2vS2jLyhbLz3pzMwm5b/Wz7Ejqd8nnJsd9Zm4DV/7gF9XkKk47ZnC2HjNH+?=
 =?us-ascii?Q?KQjCOIBThyzaR+sSXNFvsPrYgGUbAWVBSVYIP3ZiFor1RkxAxU19cY3n5Xrb?=
 =?us-ascii?Q?jqemhAXHfUPSwKKdz23+aZVtg20uwxaZW/oWXm872paa9s9jvxobM1jIGtpf?=
 =?us-ascii?Q?QgVsqWko8xIFOjjrZzdxwxISyHZiLV7ePJWjtK74?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd07b7d-4edf-4bd1-57d5-08da65e8de13
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 22:33:26.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o8GhSFSeJi8cb/8gOj2mWyR9PbGP17POFvp3RYN8C7g1qfgTwYdtGfDecnblhiMyFT7LVKhSsvV3CjVY8WtPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2597
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_19:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140099
X-Proofpoint-ORIG-GUID: wYZI_lZ9HCcAJLvuxNvI8yUXuq9jQU_h
X-Proofpoint-GUID: wYZI_lZ9HCcAJLvuxNvI8yUXuq9jQU_h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
linkage information for functions. The Linux kernel only supports
linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL at this time.

Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
---
 Documentation/bpf/btf.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index f49aeef62d0c..cf8722f96090 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -369,7 +369,8 @@ No additional type data follow ``btf_type``.
   * ``name_off``: offset to a valid C identifier
   * ``info.kind_flag``: 0
   * ``info.kind``: BTF_KIND_FUNC
-  * ``info.vlen``: 0
+  * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
+                   or BTF_FUNC_EXTERN)
   * ``type``: a BTF_KIND_FUNC_PROTO type
 
 No additional type data follow ``btf_type``.
@@ -380,6 +381,9 @@ type. The BTF_KIND_FUNC may in turn be referenced by a func_info in the
 :ref:`BTF_Ext_Section` (ELF) or in the arguments to :ref:`BPF_Prog_Load`
 (ABI).
 
+Currently, only linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL are
+supported in the kernel.
+
 2.2.13 BTF_KIND_FUNC_PROTO
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.31.1

