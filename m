Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11F61A571
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKDXLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKDXLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616745091;
        Fri,  4 Nov 2022 16:11:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj7c0012094;
        Fri, 4 Nov 2022 23:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YW5FZ/CC/9qXBOExze1onAUh3IpyArNQEzcHTnOE9rE=;
 b=0w36f1EFlfbuhOAVZNSeVnz61zS/74E6/iVTNOkPpdy5HU2ZnEnwspYN9bJ2K4fud2P4
 o4DLh1ZTodbYU9EY+Z+vl13/apHuPoqnjo54i3+Vwp5MzOkzWwaFV1nfO8qASZKBZbjO
 XdkOe5urd1MozgCJZrfpi1xQTera4gy4PAk2L+S7hF/sCVzXmlkunpSbXoJ9Ix5Fh9FN
 vcYQJHjC0R6d/Ypraoco7akUnidQO++wTczkYUldwkufVYeVrE9gGytf53xe6N2RZqG1
 O3VUBxmyBPGbVKxY5rRzI3VtJt6rD/iofdVswIrE5bY1x/UqqQHTssHXr0xVVNXuWZgR nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtshkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4M1oEM012041;
        Fri, 4 Nov 2022 23:11:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwn87jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfsVMtU+JXk0OKWdUDfkVPpRg7izgOdC8s1daFkY2/YSgolH5DjGfKFPFcX20aCp4TU9q8Pf4McpecqKY5BEe/mrQa7YLaeWpz9frPuR1lAd8bXZYyjAzDXt9rYmhwFsUCDRsxfTlUHCTx594cLwv6jgCyTaEZ3Jb4ezuAATS1gkl2fOUndq8buL1RnVw7muu05n12wNZn/JdHdoYF+OcTW2lXTTRsKGkX2uTlL7sj9g+l49tU/q4wsuoCAcTq0NqinArWQ6ZJFKi6WtlyR5xZUbBvZZbpb/11CWPBRlzMd9FUKmf9ixV8L6STokDSYkCqJysXlpFAFK6fssptR+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW5FZ/CC/9qXBOExze1onAUh3IpyArNQEzcHTnOE9rE=;
 b=bBigWxvTJvmq3cfogu2Gj8TCcBdWPa8ofcAJacc+o/tjrBEDlSPoIDSBqWTaVQ1I49oPlzIIJ6gMqIijVkZkgnsHai9+fKNwKR8ixavmHoE6HQSfGxATn7lDTGUgjUF2sQnjRHwy/c+N1u0iknHyRdxVuB3Ao+STSMm+4WdaMhavQSALArbTFWNv5GlzhkpmRtNR7nNIA4O7B8Cfhcb4+aP7xmTtFK4l8izFnn5a+PjkzcXQGE0RExKLhzsitC0+BZuffFq483bmiw3B0AFC/sSid/1c2+zX3fiGagrrvL876zvMUl5ltX1lbwyPhcfqgF/2ZEnUYO0Zdlj7fSL1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW5FZ/CC/9qXBOExze1onAUh3IpyArNQEzcHTnOE9rE=;
 b=JSllnHO4yIJLtkYnTgUEd1+AWUstxUbhO+mK1lQ2vLU1Cpct5kQmV6iwYAXSVT9FZKOx/8F0gge/ay+tuxXU63v6WYKWX2en8GYGOcZWci9PYO+tLUcZFjX0J/svG9RxpjCyCvueNOxRb/nYxBXgMLm5O3XVQSUtG7hRclBnqDI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:24 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:24 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 kernel 9/9] bpf: add support for CONFIG_DEBUG_INFO_BTF_VARS
Date:   Fri,  4 Nov 2022 16:11:03 -0700
Message-Id: <20221104231103.752040-10-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:130::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: f97cfe89-6bfd-4aec-daf6-08dabeb9e4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KO2d34bbrbMvxprBqJkhCYMxl97yqmFCYqNLIe7BS+e0IXo0HmS9b2P8jgMOaRQx+urMVPp5KfJoT9fzYTqOSx+6JqYPhL0Z7O7pWTfs6/ToD5aAjvLyfqNPSvauqfdj3L5IidLQVQmXJodORdOxzoAivqoueNFy2d0QeWoj9QnW6pl5YJLd7blvVpIiTvbR93gFvopc0GJGLxeGkkq0zj6t7M167Q53ZRtbv1VBavV4zJy8NnfC57Cd6qMpq8cQNvu/pcJlUiOCygFgd2mLJ6uovAB2fS3EjbozlfjpnD2yNAekOUPD1nhFm/1yxjdhpEX4E/IH28w0FC34Zxk2SasHwNjhbm4M7j8V6uF9WkE1TxNy5Dt8ixMozkL67U9PY0JjkwpEoaS7CWHyP/F2zp30r8LJ9aywsCFFF3bm7OODCa9c7NpgIl3vnfDSKcZEyyat3fHjU2+HGBcNNXhkOA4HBRN+WE2Lx8V4Jxe5wmuPBwbUXrBdmMJuYjUA5cLKEDRX4YE6UeV1Xtd9IULaHkcBwqCRgj0hHeFbiyhhAlsDtvN8cZG+VrzqMRN4nyCW2eIzOew7iIs5Drl5O4SFV80azpyXGSM412u8ljjqAN1I0WBH79vNyX/8ME+aQK+0SccVeQvWf7fksY8IURAKg9kRd2arDkKrcfxyT5fJQj4+hpxNQCcVuMq0aBsYKKa+grwYH3hSFhlUBbClMApNRiWs+45i0pcTB7WXl4h/tuBtLbJQlgYhAbM2R6Fv5LEhEwYOWebayUfb3KXPCgy9WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(966005)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrScGp20KRxx0bwEzZKkyF4483kVSdhQMJw0Qp2YyseKvQP8kBKStwtVn+sN?=
 =?us-ascii?Q?y+mJztSuBn8PhW71Ri1u1AdaIhCHyBrnB4wFYbCc/FteEAzGWLkQfJBjT9Bb?=
 =?us-ascii?Q?2HEYwMW7W6gi5NE0vhWEe+9c92tkSb06q3F2ZYlSBXlF7xt+8kezod/wZnNd?=
 =?us-ascii?Q?2zHlyB/1MNprWFy+xcwj0Dmn1pKURTARdK+zyLs+gmf9ISIrfgjmEIRVaXX3?=
 =?us-ascii?Q?5SvKxzJEUcBFl1InDb0v6gcepuixZY84i0/u/Rp5d/ZR9AixWDPbRHCBbKMl?=
 =?us-ascii?Q?vpb4fqBGr2uzwwe98wkToU4OA9HZOP4zEP7Tdd/G98Gl1tN4q8G5I+PgZDYf?=
 =?us-ascii?Q?gEmszju2aJFFXn1AtUN7jbuHvlikrifDWF83n4NII8NUPLOJBNHT9NCKRzaO?=
 =?us-ascii?Q?JYpljtxG5nDEH9ZSVL3BSBbTm3PbcFviBxd2JwcelQnfvj/LTGmS+LLebLkQ?=
 =?us-ascii?Q?aXkiqW24r3f9Dsn3GJjX2zd3X4Iu6nFb6uGtjo0hrxl/rVycvCwNCgMwDmJ/?=
 =?us-ascii?Q?JO9FWMO7n8QWMDCm+qmm4ogQVsbkNjdIeKcdJ+15IZjyINdYJvMc0aVorpkD?=
 =?us-ascii?Q?Sa6CiJQ6W1OjxYF1QHOB1pgjcPKMhISt2vI1oYCIAzc93dv/jTQg06x+9bJe?=
 =?us-ascii?Q?ZlyZBwk3cP/JoTx8CxQWwu3WltRAI7FPvEFD15r5dLrkSbeqg02ZRPZ/zIYM?=
 =?us-ascii?Q?Z0asAUhNPMgz3GYShsiAHlixE8ZNtKD8o2RirgJFtPELcZWo0hoaXP/ic7/w?=
 =?us-ascii?Q?Q7jPCyLCJlmExhPgIA4OylgWl4Ybmoa9cz5Ag5p1hO4aYrRZuwLncqj8r6jL?=
 =?us-ascii?Q?PxrFLnwttiYjSo5+8RJNG0nkXkfdyxl18l3BnyfHjy2a93UpTJq1emlQd8Ea?=
 =?us-ascii?Q?ZuYK6wzlCs9m3IdQv1xLqTn+mrefEZVXCPIvt2prlwgqp8qYQqonr3Meo1AO?=
 =?us-ascii?Q?rc2EhVGWC1cUMCaVau8pm8hOooG/LA+h3zXja7acVIpnn+60Lc9repXECNlW?=
 =?us-ascii?Q?Oz3roH04q9drCn0DdyUh+YTkvaCKqrnc5gsp/V10qF2f0OLvI25NwV/n9Ip4?=
 =?us-ascii?Q?M4+uIbmElOdJWiJsJstSqQhFI805066yEmYEBYmg84nyX6v6WIshMW3spTbu?=
 =?us-ascii?Q?kfKF5kE46jGb/8U7vzvQvh30FSRfcuHxElWRPNM4I95OD01t5eYCJrA/XcZL?=
 =?us-ascii?Q?LBQeSrQ8x7zku5VJ1LUMxsKVbIDqSBVuTwFr0hzZnTyRcBll0fotCaIln3Wv?=
 =?us-ascii?Q?DRxGo4kUGT5mBWZmoIuOs4DTLfCDCTDBArhxJIDG/3TIN1VRKZEfJCeoEOTy?=
 =?us-ascii?Q?MOA+1JkmHQEHUC4kOm0VrGKY/u+VuaB19EvPcj2Bt1yFdyra8b/U3CqQPurY?=
 =?us-ascii?Q?pWSemMa0Zw7ilhaDgP7BRpiyB8UDh4UDg75XSqicSqNqazqeyJqPxk0x2FPa?=
 =?us-ascii?Q?FcAoE9eufmL3PapFOkuzdzUaeBW44GwDiCq2JPOcg5vM71HJYJDsl0kry9RM?=
 =?us-ascii?Q?giZbPfBiieyJ/2ma6zbop9KXXgfm8tJQajxDAi50w+bj0kTqi6sAJAQ5MFin?=
 =?us-ascii?Q?PKI9jjhuuVxV0qWhIn7rRhhIxEQZZ8rmbho6jiGcaTuiaqTKTI8g91cYA7Xt?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97cfe89-6bfd-4aec-daf6-08dabeb9e4c6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:24.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFcH6gKQYduWl5ILueND12A27IFASrja3THQGCGZt5h1R8kUwe5CwG4y/XnrwFXnnygtP4YP0NyCpOdAQH5AN1f60fAMq8cKXKdvaRBdDo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: JSFpNYatYaixuutYDGF8sPTbY__Xu408
X-Proofpoint-ORIG-GUID: JSFpNYatYaixuutYDGF8sPTbY__Xu408
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

This patch implements a proof-of-concept of the kernel side of
global variable support discussed in [1].

Add new tristate CONFIG_DEBUG_INFO_BTF_VARS; when it is 'y'
both per-CPU and global variables are added to vmlinux BTF.
When set to 'm',  variable BTF is added to module
kernel/bpf/vmlinux_btf_extra.ko; as a result, global variables
will be available in /sys/kernel/btf/vmlinux_btf_extra using
split BTF to store variables.

To achieve this, we add a "target" option to scripts/pahole-flags.sh
which - if set to "extra" - gives us the flags to be used for
extra vmlinux BTF generation.  Module building and BTF generation
are skipped if CONFIG_DEBUG_INFO_BTF_VARS is 'y' or 'n'.

Depends on having a v1.24 of dwarves which provides support for
encoding all variables as per patch 1-7 of [1].  To put the pieces
together, apply those patches to pahole.  Eventually, like other
functionality it would likely require dependending on a newer
version of pahole like v1.25.

CMakeLists.txt before building so that the pahole version can be
a proxy for detecting the "encode all variables" feature.

Prior to fixes [2] and [3] dedup failed and was highly
redundant, but with those fixes in pahole and libbpf we see
that in the module case, vmlinux_btf_extra.ko only defines
two non-VAR kinds; one for the percpu DATASEC and one for
the 'double' type:

$ bpftool btf dump -B ~/src/bpf/vmlinux file ~/src/bpf/kernel/bpf/vmlinux_btf_extra.ko|egrep -v VAR
[115981] INT 'double' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[159904] DATASEC '.data..percpu' size=209156 vlen=378

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] TBD (requires resyncing patches with dwarves)
[2] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/1666622309-22289-1-git-send-email-alan.maguire@oracle.com/
---
 Makefile                       |  3 ++-
 kernel/bpf/Makefile            |  4 ++++
 kernel/bpf/vmlinux_btf_extra.c | 22 ++++++++++++++++++++
 lib/Kconfig.debug              |  9 ++++++++
 scripts/Makefile.modfinal      |  6 ++++++
 scripts/pahole-flags.sh        | 38 ++++++++++++++++++++++++++++++++++
 6 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/vmlinux_btf_extra.c

diff --git a/Makefile b/Makefile
index f659d3085121..7cc99a424a85 100644
--- a/Makefile
+++ b/Makefile
@@ -527,6 +527,7 @@ XZ		= xz
 ZSTD		= zstd
 
 PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh)
+EXTRA_PAHOLE_FLAGS = $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh extra)
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
@@ -614,7 +615,7 @@ export KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MODULE
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
-export PAHOLE_FLAGS
+export PAHOLE_FLAGS EXTRA_PAHOLE_FLAGS
 
 # Files to ignore in find ... statements
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 341c94f208f4..8e3ee5c98f23 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -43,3 +43,7 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_DEBUG_INFO_BTF_VARS),m)
+obj-m = vmlinux_btf_extra.o
+endif
diff --git a/kernel/bpf/vmlinux_btf_extra.c b/kernel/bpf/vmlinux_btf_extra.c
new file mode 100644
index 000000000000..9aa682287a1e
--- /dev/null
+++ b/kernel/bpf/vmlinux_btf_extra.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/* Dummy module used as a container for extra vmlinux BTF information;
+ * to be used if vmlinux BTF size is a concern.
+ */
+static int __init vmlinux_btf_extra_init(void)
+{
+	return 0;
+}
+module_init(vmlinux_btf_extra_init);
+
+static void __exit vmlinux_btf_extra_exit(void)
+{
+	return;
+}
+module_exit(vmlinux_btf_extra_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f473f7d8a0a2..3c7df82a37db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -364,6 +364,15 @@ config DEBUG_INFO_BTF_MODULES
 	help
 	  Generate compact split BTF type information for kernel modules.
 
+config DEBUG_INFO_BTF_VARS
+	tristate "Encode kernel variables in BTF"
+	depends on DEBUG_INFO_BTF && PAHOLE_VERSION >= 124
+	help
+	   Decide whether pahole emits variable definitions for all
+	   variables.  If 'm', variables are stored in vmlinux-btf-extra
+	   module, which has BTF for variables only (it is deduplicated
+	   with vmlinux BTF).
+
 config MODULE_ALLOW_BTF_MISMATCH
 	bool "Allow loading modules with non-matching BTF type info"
 	depends on DEBUG_INFO_BTF_MODULES
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 9a1fa6aa30fe..210d7869c14f 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -43,6 +43,12 @@ quiet_cmd_btf_ko = BTF [M] $@
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then 		\
 		printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
+	elif [ $@ == "kernel/bpf/vmlinux_btf_extra.ko" ]; then		\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J			\
+		    --btf_encode_detached=$@.btf --btf_base vmlinux	\
+		    $(EXTRA_PAHOLE_FLAGS) vmlinux;			\
+		$(OBJCOPY) --add-section .BTF=$(@).btf			\
+		    --set-section-flags .BTF=alloc,readonly $(@);	\
 	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a5..44bc714fe926 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -1,6 +1,16 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+config_value() {
+	awk -v name=$1 -F '=' '$1 == name { print $2 }' include/config/auto.conf
+}
+
+# target is set to "extra" for vmlinux_btf_extra module encoding flags.
+# If CONFIG_DEBUG_INFO_BTF_VARS is 'm', we encode variables in
+# the module, otherwise if 'y' encode them in vmlinux BTF directly.
+
+target=$1
+
 extra_paholeopt=
 
 if ! [ -x "$(command -v ${PAHOLE})" ]; then
@@ -20,4 +30,32 @@ if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
 
+case $(config_value CONFIG_DEBUG_INFO_BTF_VARS) in
+y)
+	# variables are encoded in core vmlinux BTF; nothing is encoded
+	# in vmlinux_btf_extra module BTF.
+	if [[ $target == "extra" ]]; then
+		extra_paholeopt=""
+	else
+		extra_paholeopt="${extra_paholeopt} --encode_all_btf_vars"
+	fi
+	;;
+m)
+	# global variables are encoded in vmlinux_btf_extra; per-CPU
+	# variables are still found in vmlinux BTF.
+	if [[ $target == "extra" ]]; then
+		extra_paholeopt="--encode_all_btf_vars"
+	else
+		extra_paholeopt="${extra_paholeopt}"
+	fi
+	;;
+*)
+	# nothing is encoded in vmlinux_btf_extra; no global variables
+	# are encoded in core vmlinux BTF.
+	if [[ $target == "extra" ]]; then
+		extra_paholeopt=""
+	fi
+	;;
+esac
+
 echo ${extra_paholeopt}
-- 
2.31.1

