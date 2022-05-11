Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82791523414
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiEKNUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbiEKNT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 09:19:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8132415C6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 06:19:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BB5iQ7024475;
        Wed, 11 May 2022 13:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=1Ag8t1+w06Il6DwNFDE9M9U67h9++93rZedsVO1NpdI=;
 b=imidyR51Zh+KnOZaml4/tD52bsR2PwAEJAc13Y9h4uZBNqDBddjCvqSYXjFZWUtMVQ0j
 +CKb+6HqapW0xepcWjNakIJULuuC8/PBWhiDAvYp2KkCwWoobWd9FAPmcRiUOlsNevlo
 ksCkGsCtRoPM+UYwt1oghj447i8ATrUEgselrF1WqhXLotYaEJf9wbTMqFm9TUuGZlFv
 8EsOVa/wyUZpPV5NzGwpL9ctGoyOJwXMmzOPpXZskTn3iJBzmZP+QpZR0sZusAxV/qi6
 9RMXGzdd5sD7kkCEbK9gXBKerqsfojoDqOa+5Yd+7Kh3e8YWa6m8IR/kh2P4dOLo0gtG LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0sqav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BDGPLd028618;
        Wed, 11 May 2022 13:19:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf742x70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/AAEXcH/Mahzb75bOz/t69CK4McH4xJpid4UCM4tK2QBrdCXzxRnU2AdoFe49QAnAPBOa5XNrUrvUOXnJfshk4A0h4IeD+3YdCm7f6c2Bhh6edUEGjouhJ8Jh855iVbrtGdBzXB2Dy7sPF3hoSpCyHzR01ZSAQzmOSRiXs8RGNKfr3NVgrHqlctENSJ6qm/XRBiBXF8yel7Jg/afN/Uj4n4SmQehtticMICNnLsvD/n9k9YVTNqSj7CbR5jg0qjR9NO8TNTeyoSIKZ+UDnyUxJlQCFP1tq+/zQH5O41KAm0c8hdFtBghHXGdlU3C8YFtlvklb8f2Bo/SsPjjzrsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ag8t1+w06Il6DwNFDE9M9U67h9++93rZedsVO1NpdI=;
 b=cfhTIST8taGV2FNIwaC9LOqCei2VBr5j6kLRq/YErR+Xkroce/1JYGaBJ//6d/6cFGI8ojy1+1jdG9BtWibllD32o7srunci/qAgFwdx5/C/pbL7QBI5gRpIaxjp7tQ3HbGHGaDQbSOJPhW745fIll11foWk+nH+lFfqaXczcLHdJHpTJ6/G/qlk+ZP5hGcN/IvMKraTkQt8tEu8tgsQulO9gfGAabkHQQrduQIxZ/xp6nfsvPi3MvXDQX53SEXC45uj7KHz4hw+xmV1jnsBeizbLSbjrCwvf0jIGZJyTsLByMUMkAn9yx0BxfLi6iKAEeo3RrD+3mcG0JZNqKz0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ag8t1+w06Il6DwNFDE9M9U67h9++93rZedsVO1NpdI=;
 b=k8EeB4nKO/IS8kBUokcHf6Z4W+B1ihHUoQ+Dkr5djdqCSD6xLerfYqJaUUJkaDoAbLrXxx7ebYwy+I9cEcCkmN4OCwezoHFmgn5qqACWf8jpFIz8TISQ8dX7lVefIFCuMK2IgwoBiOD9RErwN5YFwohfqfZw5+5fSpKjQAHiT/0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 13:19:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 13:19:32 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [RFC bpf-next 0/2] bpf: allow unprivileged map access to some map types
Date:   Wed, 11 May 2022 14:19:26 +0100
Message-Id: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe3a656-f06c-4bb2-e5fd-08da3350e2a2
X-MS-TrafficTypeDiagnostic: BLAPR10MB5154:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51548B2DB02E3D7D25F3D838EFC89@BLAPR10MB5154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzJHi1U8Fcz2axWrnLbrnWHH4OMSAC7rVN43XqkILpprN5ilN/D3kImyZPUmtlNOGLyEWw+a3/+/UNpaZUxqt3js99BcoLhBGf8B1lUnXxeAxFRBiCAovMWOrJrQwMZtpp01kCrA6a6f/Ao9FYiqxnIEC8c9zI9kupxbI+LqjMFuJg1PYnm5g4F3/fbYmX3bJdje1WIIruo9jFRmHF1tTI6TyMCt26tztNDHvic/qjQnzsyzkKSn7C76c80ZiOsHVTfkDtaPN7/eTIG3pChivhI4MT3tYNVl0qzOlxfLhUYT4tztm0vDJa+VkOj9/rPfHXItTPDIQRqOWjF8HENKaCxC1xCfzOTSVEzYw1DQt2WINl6oRiGBymVNKdViU8hJtUlE9BFUVHfqh/UgRAo7FdqiGzNiWN750fRuXBe2mvdO7Rza4VrAoU81kTPAXbvBtNOlrDycQBpMvTeZZv42qYS3yg9nNBDTUiO2uSgvhuzJ/Pmn94RqWGbAcMiRukRuuxmUo5CT58G7etl9eI1Cog8PjBa8wIftcuGAfag/MQjWcu38vHgpxCIE86RupPScnrvr5NI0reaJ1rHqablkXNG1MxjV6qDZ8sZywxpBqDpQ3L4EnHZM3i4M7C+ERhC9uqemZ2bImsF3jpj9tDyBQsCapttRjDOqJDcekXE7hiineaurXk1uVZ4BzvwvrIfJ9fgqys3ELhj3ujvi5YXkjQcdDcbDMzrJPH0B3I0xQqAR0KiUCav9frT75VYFZTCk+vA+ue9gj7F+MZo/8CT+Bv2L3kWL9zVKoLr3U+gAJQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(83380400001)(2906002)(38350700002)(66946007)(66556008)(66476007)(7416002)(36756003)(44832011)(8936002)(8676002)(6486002)(6506007)(52116002)(6666004)(86362001)(26005)(4326008)(2616005)(6512007)(38100700002)(508600001)(966005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fn7+ltoKq+XJ12wT3Opnq4WqF/eL8gaX5ZUDku85C0Ztk81h8w4PXosGdPTT?=
 =?us-ascii?Q?+PIWrA+H+L7kKYaH480H4IBZETz/KKCoVQrJLWH6URxntQLGW/CxJXf44aBD?=
 =?us-ascii?Q?n68Ib+B6U1mJA5VD9UXMxsQQD8XNfspviZaD3FP0YVwE6Xg5mr58AAr5S9Dq?=
 =?us-ascii?Q?Yb7RyjwCzVxKvw6JQY8v7u6+vxQS+YYCyjG/ukkJRz49CiZm2g2vl9hBawfY?=
 =?us-ascii?Q?KARtexaEgbC/ukSJZIAKtuAgCkPPCGnVS+WeZsrM0q3T5ayjS4TwZRg5IfjG?=
 =?us-ascii?Q?+4tKTup59GPYgst5Knczsmz4i6kFUWmmVOmY6K3HlMYls9EFwX33u5q7SGgd?=
 =?us-ascii?Q?9URnxtrwaCdML9ulaQjPvyF4z6xqWpIsl4d6nYpUtXW/xXVQ3VzL0J7sfIE6?=
 =?us-ascii?Q?0vbhKL7C/gubzPXiUfqbJIWFvTXP0jyvf7Dk3eMNixhGbJiTeVpGRR4BAKAA?=
 =?us-ascii?Q?PfmsyuXZgWXBSghD6opwtFPIgFpcnjXmN5c+z2EcE6iWMExdWQnON3/gueQL?=
 =?us-ascii?Q?uk+u41TqETT25RWDh4vA9c6I1T1+iFaDiZAEVi47WVYgVpEchXY5Kikm+nnq?=
 =?us-ascii?Q?SN4JY4myPQWPobiQrj19cMnssahfLG2bC+TW4CK0O3CAtg6XQl3num4CuXxU?=
 =?us-ascii?Q?eLXSoAlqhYyMaGA4qdCJgRD7G5eK7u858RIFawzOI2kW8eVtvB1GXWZu8jEE?=
 =?us-ascii?Q?gyg2Z4V0IhrTWiQ4L7xx63ssMflJLp6LTH8+F/BdDPmhKxrpHhiiVzUhrx7G?=
 =?us-ascii?Q?wbfJWbji5TfNcoVz1KoBZJzRbcsmsOAmhgrvguuyAboadf+UNmXkhe7dbjUs?=
 =?us-ascii?Q?UaOT3dil8IUTQ5kdqE+gnOpW9/Fm4BfgJfKd6fmLcQI0S5l2CF0kCbI589BJ?=
 =?us-ascii?Q?ez0JaCfd37iUJE79sYyHwusYCE2M5RHUo0WoDiTj1AmP9OmuOajnYpygC1Lx?=
 =?us-ascii?Q?ks1FlFId/iaVmUXlMw78nMMx+nVcbNNdalvQPNh6JxwUGhhO5ZgdJq1zFihT?=
 =?us-ascii?Q?hkvJIxiqDGSz7w0YUOLagnNkTCTJKj8rLI36DzCoHlmvHoQW2B6VAU3FDlYm?=
 =?us-ascii?Q?7sh6rD39p17GDTu0Y672gBghjbTwTOMPEjb5gGh6rssu42BCX74L/Kmb4dw/?=
 =?us-ascii?Q?yrWCH0scmrx6/jB13nx3XolbX7Fp8eDQ2QNUycTiMSff3+LPDLH5UO7DjmQO?=
 =?us-ascii?Q?sPE15vDRkNUianBBWwY3UcxsGred/UxmsrFqOd5uqzNAupRm5IuHKqUGFo2M?=
 =?us-ascii?Q?S2b/QHeA7R/249T217abKh5xeLazskNMU5kz1tWnT9Vb6mj6y/hEmyT4TiWn?=
 =?us-ascii?Q?G6PTFJoVmQDcb9eZKaHVGVc+EnRj3LSfGCB0orZmGF4C6OJP1bB0I8uZl/Qv?=
 =?us-ascii?Q?xTpKe2319tBhn+VwtBmmwGnSJ5g6h9uqul2MRkIeMafudyIwUaQM5NiT6ZeQ?=
 =?us-ascii?Q?flcISoi7fbYwyfjUKl4rcK8RQDAx65ZKMF3VIJPoG2QpMX7qBNhu0ZJ8f2n0?=
 =?us-ascii?Q?JogQLqJ8A3XFF0TSN3x1FR3tFbGUBtij7KMXN30BCcYo4aZIyUuCYpa9vkA7?=
 =?us-ascii?Q?8ASbSgoYj5Bqi9VRQfrm0LZ6Jlb9YwoyFFj7pcdNTGXqKf26KZzTwgU20AJ9?=
 =?us-ascii?Q?lTIiFG7rLuJGUzSLJsBnwKEV/I6tLSDzCgyr1CLIz958DCrGeba93QjZMR/4?=
 =?us-ascii?Q?uoM1t2MRfzt6ZwxYYiOyH1Kc/7DZG7ihKcIc3Fpr9N+jVLSotOD0NuDrckIO?=
 =?us-ascii?Q?1ld7R8eCumF09wQ/P51cInBohPXse54=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe3a656-f06c-4bb2-e5fd-08da3350e2a2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 13:19:32.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1AHbRIBtpGzyK3WRCCJMYhnl6UboLD6EkFgUaMUNSetF1Tf+z+bNnEVhmVEeSz7K27SWMbpHHXon1pVD56aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
X-Proofpoint-ORIG-GUID: x9my6H9xfN6kkZvADu0YxQjrwQ6ZoKtC
X-Proofpoint-GUID: x9my6H9xfN6kkZvADu0YxQjrwQ6ZoKtC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Unprivileged BPF disabled (kernel.unprivileged_bpf_disabled >= 1)
is the default in most cases now; when set, the BPF system call is
blocked for users without CAP_BPF/CAP_SYS_ADMIN.  In some use cases
prior to having unpriviliged_bpf_disabled set to >= 1 however,
it made sense to split activities between capability-requiring
ones - such as program load+attach - and those that might not require
capabilities such as reading perf/ringbuf events, reading or
updating BPF map configuration etc.  One example of this sort of
approach is a service that loads a BPF program, and a user-space
program that, after it has been loaded, interacts with it via
pinned maps.

Such a split model is not possible with unprivileged BPF disabled,
since even those activities such as map interactions, retrieving
map information from pinned paths etc are blocked to
unprivileged users.  However, granting CAP_BPF to such unprivileged
users is quite a big hammer, allowing them to do pretty much
anything with BPF.

This very rough RFC explores the idea - with
CONFIG_BPF_UNPRIV_MAP_ACCESS=y - of allowing unprivileged processes
to retrieve and work with a restricted set of BPF maps.  See
patch 1 for the restrictions on BPF cmd and map type. Note that
permission checks on maps are still enforced, so it's still
possible to prevent unwanted interference by unprivileged users
by pinning a map and setting permissions to prevent access.
CONFIG_BPF_UNPRIV_MAP_ACCESS defaults to n, preserving current
behaviour of blocking all BPF syscall commands.

Discussion on the bpf mailing list already alluded to this idea [1],
though it's possible I misinterpreted it.

There are other ways to achieve this goal I suspect; for example
a BPF LSM program attached to security_bpf() could weed out the
disallowed commands, so setting unprivileged_bpf_disabled=0 + BPF
LSM could support a wider range of policies (not sure if we
could easily determine map types in that case though).
However, as a starting point I just wanted to see if others see
this as an issue, and if so how best to solve it in the general
case. Thanks!

[1] https://lore.kernel.org/bpf/CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com/

Alan Maguire (2):
  bpf: with CONFIG_BPF_UNPRIV_MAP_ACCESS=y, allow unprivileged access to
    BPF maps
  selftests/bpf: add tests verifying unpriv bpf map access

 kernel/bpf/Kconfig                            |  15 ++
 kernel/bpf/syscall.c                          |  57 ++++-
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/unpriv_map_access.c        | 194 ++++++++++++++++++
 .../bpf/progs/test_unpriv_map_access.c        |  81 ++++++++
 5 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_map_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_map_access.c

-- 
2.27.0

