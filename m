Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FE52D5F8
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiESO00 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiESO0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 10:26:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556D37002
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 07:26:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JDA43p005159;
        Thu, 19 May 2022 14:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=mXPRXN0zsMTrlTEssoBU61CinSWs7za2NDJr0m9gZPw=;
 b=iBdVyR1RBpZSGzzOsS+3f3D7BLGl/I3lYOKL0fSUbDgTo78FKdhE6Ou3DUT88rSH1rs7
 IttvRYb4T8hKYPqrZbbhMPC2T7MzYzzv/3bwJTTLBKf8stvIH25siq8UdWlfKbJ+WkBd
 szeKgI3nBqqA4FxDLHxUAw0MKICDhjwYLSSLZP1lTG1xlnzQ9I0L1nP7yVY0VbFx2rDC
 wNdurcmogd/2iJK9a7ZWwmAgdDgJpDrHQdUUueinxd2iJnfVed0jETUTVSHRLxB5XPtO
 N8Dp+XQpIQBBASb9w35wU8gZ4JVTvthk+XAb8it9vrKO5zxFdzaBWciL4cFOCYxBaMni OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytve8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEKD94007334;
        Thu, 19 May 2022 14:25:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vavjvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQQFYkcuZCrpdrMRkcZ4iCb3Ik2XzSyPTmVhyA+Rc3GJQWd1WwBwoQ1BysUO4x1YtEcEHUMNXH23FkDsDyoO2MhVNrp/TEiuix0nuvQzIxxkAIVmOGuuJOIRYL4EU9PufUxqBMEa/Ks79RhzPjwvTqcRsXrMpvYa1o98dZt2IyjjJJUSDjoisZ+ipgj+tJIzcY6HHSmDrhQZFQybozzi1EWHHxBFVaQXaDlaQ/Si6FKP0t3hL8dh+pkPT01uyqUwRreAbFIYK4Y/W0F9AhSv8QFBCw3KY+D5TisN/aRztWJxacs5kjkFDdyeHEdXwgICSLGoZV5mco+ZeaLuoiPNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXPRXN0zsMTrlTEssoBU61CinSWs7za2NDJr0m9gZPw=;
 b=nBWrX+jXKB9jvP8Zq0mCqNPiSrudgi0Bt7Wo+WQ7MkLjNuZQfqQOlelAcUTRInMHFjU9dYLo+B1YVAj767PgNjgp1t+Lvr8lf0YhXD5n5ARCOPmaH94TOMEwTCERniI82ixw7K9bs1sNpIvjeUQF4a2DPl/O54Fa3mZpKI0sZchDk2GpcRJ5vu1TD1M2IAi+6WHbuRjstawSRDGuGhDeeeGs4bbRlQeX0oq4b7trir6F0+QdnEHzlY9e3ATTB0QvlHN8wn3kikJdRas/8QAm7aAwepIQZ13jqEQipfJkEW2VKItdcZFZzfkHUt9tbh0Vt2o1Hx0hhZGcsBYOmMzfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXPRXN0zsMTrlTEssoBU61CinSWs7za2NDJr0m9gZPw=;
 b=vZXFH2ojdwjgHskOaWuyIsuidpjc4+WgwFZ/GZZ4kpbWHSznEz5U1+8+SiUAxM5DJBJdaBd/nGjy1wHf5x2N2d5nBLjoC1YzWsuwCQyk3dsv/0j592Vi6uvjIgK8Ga2kd9dA4flhX+KO0ExqNA/Mc+peft4wupziafW9FwVCoGY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN8PR10MB3588.namprd10.prod.outlook.com (2603:10b6:408:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 14:25:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 14:25:39 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 0/2] bpf: refine kernel.unprivileged_bpf_disabled behaviour
Date:   Thu, 19 May 2022 15:25:32 +0100
Message-Id: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90497670-8e03-4b6d-629c-08da39a372be
X-MS-TrafficTypeDiagnostic: BN8PR10MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB358891A0F9AD99F169DF60FDEFD09@BN8PR10MB3588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDcIceT2dGEeAH7HA7F9OF1Dwe3ffnn8gHSwtVMtVN2G4bSwsXU9IqB81cpaKARyVO8ZF36LWAcjuz0BkWPzJj2Zp+GLtP+uSym7HUqvXo8hbE/qFnq9LaXbsDybdZymxXZ6FjR4kTGJT683PfqgUqG4T9agriAjZYUdKFpedNJCDlekPYergX6J82gayKFgr12DTs6icBq16ZCq/xFPYLnSlUkVUFM7JHIfvya8zM02ehf5U8yWfTbPtoZ/M2CsjtPncEex1eqdhROBpazic5bVOjRlJ1ht8BKP2ufr+G/CtJbgsCGOdNy0F7klwHVwPTEQmzHxuq6xMAK9G2GdTIQmsw0XVYH1UDCmxeSfb7m2H9xDUuI3bPLxYr2YgH/TZW8CDQ+fgqMVpdf9PNiyxcWFUVHAMbtnZgdmrnJPmihAyQvwZ4kwV+BAj3KvwtuIFILrWydKcIVOEY69UKYWCnsLSbwIK1y3zJ2fGAn5P1rfbb9D4X0WbJYyhXhWtBUekLu4kPwWjMDJgJE5v+MEjb0T/WVAPnpnAMvmTZSQnJntCq65pQqHxyW9E7wV3af981pb9Blbbm+bf34Mscqp7kj8nEhFVICHMP5N0uJRrPAfsLa/GGMWnnoHDV4dtEV61APvEhVZSX4pDU3Z9gY9C1wDEAy5RsYyBXbXT9D9hh3Vs3FPrBas4ffAYNQwIk//Q+tvWTe4fkP1Zj37bnclXLCBQzA4KgDqkG40UjZlk2Vh1uvpkU5Q+EtWgwgx2Ty+jhu4Mz5w+NVh8ecXbKLiZgD6xxAQb9sI+QpgpjuJgl6DKrhCtU1yFb8k5TGYzgW53S6/xQuhmbvPc+pTbnBtpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(66476007)(36756003)(8936002)(66556008)(2616005)(6506007)(107886003)(7416002)(83380400001)(44832011)(26005)(38350700002)(6512007)(186003)(38100700002)(4326008)(8676002)(316002)(508600001)(52116002)(6486002)(966005)(2906002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/hjQbKYiHka6S0g6UR1yecC8R3y54UU7dpXQK3X+NOf4m4eLGqQM7X/JLzf?=
 =?us-ascii?Q?XuKTMQ4o5yvmnM1QvCUz1RoCDmmUvdqsAEZUMWAYCbC98HKLpDc0sae9jW/A?=
 =?us-ascii?Q?08OJ4jQgdxt+pMnIFGmSD4Uj2WpoP9DiZNha2B9aoGZ6I6unf70rz+J95/HW?=
 =?us-ascii?Q?vjs+g6dbfKk2XgLgzYvS7tk+2Nkk7Mv85IGeJWov4LKHWVmk+D6iPwmM/Juh?=
 =?us-ascii?Q?M1DCFc7yTlfYz3EFz9al7C/tsJI0/tIyI01ejltJCoTnvGu8pnAdnr+O6uel?=
 =?us-ascii?Q?rA0Vqsf3K6++Kh6kvpd3r25mb96e+un1e7iJRSOkLCh50AuJbM6RK7DO8iew?=
 =?us-ascii?Q?igxUvGKXsqmwcEXBA8WBMEdRsgn9zAnQMp5tbobRxNg6YxZXLm4VVKIFB1jl?=
 =?us-ascii?Q?LIvByqX2QcjJC3UNn1lmW2cFCtDXye/J5huaIGmwE8mr3vV6Hgr3iDa89B1v?=
 =?us-ascii?Q?PdWOJGiLf68xBadlU3X/MaEGkqj4VYlCbb6DNEJEOuXKcsC+otvjJZeM1xy7?=
 =?us-ascii?Q?EERSCT3Naq1tlmvd99iSWr3QZFQzzqxtwH7BpBmx/cmBcSpprSawV5OoCV2r?=
 =?us-ascii?Q?GFC2jCQfn4bMUPygzF5Ce44CXLf2hTcMP90U5QLsYqgcUWzKvPzyJY8Dxzuc?=
 =?us-ascii?Q?uGnQ0CRy0ay5p/ne8orziuGcbY1vGrQdiwvOJkCuF8aneS3Zrk/zHq6HwY3+?=
 =?us-ascii?Q?X9wJ1l3DJEPTXLR5xEiAokfh3Q/ivl1nOUNrRjsQSR7NJt8bI34QXYdhwpfU?=
 =?us-ascii?Q?pxtZnd3tw2LlNznl4xrnCylNO8nA+vrdR7DqJ1jMFYpNly8qa9h81u7pwty6?=
 =?us-ascii?Q?cC8erMhFK98S4PfPQetdpzSt0voG4XTSzLB/J6HQVLgn0eh4nBUGrUsgHKah?=
 =?us-ascii?Q?BKOB0KC0V0bC1QZz4KHSI2cvFEfoBY9KFaacnTQdyXejNavOtlBUYEyTwJV3?=
 =?us-ascii?Q?V85ell/luSPpvvJtIhYdoUdAMz36B5sQjSiYjgi8zRgoCj5RUBhY3s0Wab+O?=
 =?us-ascii?Q?cu6RKjMbfsxyeINMGkbwG6NH25ubQFwXbMBhyXssNAtlwlCWVPZsChmVkGQe?=
 =?us-ascii?Q?/xKYHK6ku114OrjW5DftgcXYPVgjS0jMk/wuL1kQ8/pPyrdlnLfs5jAfaNRJ?=
 =?us-ascii?Q?npYPW0kBkMfBE9I3C38VC+UEJCF1x0X8YWkdNj2CC16oJ1SY8FlFSbUd9VMu?=
 =?us-ascii?Q?IjAjgc0PfrocBmQItbYbmQWtiYPYBIqH8ZN3cVq9vUCwSAVossNy8mI52+xm?=
 =?us-ascii?Q?U6CWvH8s/SOyORoZ3fbwDVazOSJicKta8BMXxXbenlpu/IqM3kIkwfPZ7C4W?=
 =?us-ascii?Q?RpqjY2lYjdsX/7lSYtS7M/H/8WCgBnTfQ+L4JB1DjcKrprA+YVoe+d58t6/E?=
 =?us-ascii?Q?roD9bugLvHMO1R654JDuw4f6gZpc60QnlFxeppCL0xMiL+Pf3sgbZdHkryol?=
 =?us-ascii?Q?d+nNkFy/QY0cpEmBrZS9GjolhU8naq1QF+j61rZM2dvL/FYU59ZrosLgmyKt?=
 =?us-ascii?Q?bElTELdwdS6i4IvGe1d5CBXCb7zU6G2bzMwryC5kWGFQVpRBMv01gCCL0AtL?=
 =?us-ascii?Q?BF2QdcFytN5PvVJTQz4+PFVxMxXIFZPAWP2BZHSsstJQbsJUnhkC6OcAHhjp?=
 =?us-ascii?Q?mS0CE+UwjeGOrsrgXIpv7idpepXxja1z8mpLoiVTj0ApDjmce7x8pjwvkGDa?=
 =?us-ascii?Q?klZkknVN0FpjRPgbjNjr3ZvIVI4Z7djiSRoiKuYO7tPxt3NRIGhgCEpWgo9M?=
 =?us-ascii?Q?+mhKnYcefA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90497670-8e03-4b6d-629c-08da39a372be
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:25:39.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFmWU5shstk+ws2i/A4gOau3x/mzQTch7B+c64BT6U+JQXjBelJzg5pbSpQ1uvrJmk44wCDIoVFy8uPcoJEd5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3588
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190084
X-Proofpoint-GUID: CDNLs8e0xMISzXCIsy81TSgY_o5FQ67L
X-Proofpoint-ORIG-GUID: CDNLs8e0xMISzXCIsy81TSgY_o5FQ67L
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
blocked for users without CAP_BPF/CAP_SYS_ADMIN.  In some cases
however, it makes sense to split activities between capability-requiring
ones - such as program load/attach - and those that might not require
capabilities such as reading perf/ringbuf events, reading or
updating BPF map configuration etc.  One example of this sort of
approach is a service that loads a BPF program, and a user-space
program that interacts with it.

Here - rather than blocking all BPF syscall commands - unprivileged
BPF disabled blocks the key object-creating commands (prog load,
map load).  Discussion has alluded to this idea in the past [1],
and Alexei mentioned it was also discussed at LSF/MM/BPF this year.

Changes since v3 [2]:
- added acks to patch 1
- CI was failing on Ubuntu; I suspect the issue was an old capability.h
  file which specified CAP_LAST_CAP as < CAP_BPF, leading to the logic
  disabling all caps not disabling CAP_BPF.  Use CAP_BPF as basis for
  "all caps" bitmap instead as we explicitly define it in cap_helpers.h
  if not already found in capabilities.h
- made global variables arguments to subtests instead (Andrii, patch 2)

Changes since v2 [3]:

- added acks from Yonghong
- clang compilation issue in selftest with bpf_prog_query()
  (Alexei, patch 2)
- disable all capabilities for test (Yonghong, patch 2)
- add assertions that size of perf/ringbuf data matches expectations
  (Yonghong, patch 2)
- add map array size definition, remove unneeded whitespace (Yonghong, patch 2)

Changes since RFC [4]:

- widened scope of commands unprivileged BPF disabled allows
  (Alexei, patch 1)
- removed restrictions on map types for lookup, update, delete
  (Alexei, patch 1)
- removed kernel CONFIG parameter controlling unprivileged bpf disabled
  change (Alexei, patch 1)
- widened test scope to cover most BPF syscall commands, with positive
  and negative subtests

[1] https://lore.kernel.org/bpf/CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/1652880861-27373-1-git-send-email-alan.maguire@oracle.com/T/
[3] https://lore.kernel.org/bpf/1652788780-25520-1-git-send-email-alan.maguire@oracle.com/T/#t
[4] https://lore.kernel.org/bpf/20220511163604.5kuczj6jx3ec5qv6@MBP-98dd607d3435.dhcp.thefacebook.com/T/#mae65f35a193279e718f37686da636094d69b96ee

Alan Maguire (2):
  bpf: refine kernel.unprivileged_bpf_disabled behaviour
  selftests/bpf: add tests verifying unprivileged bpf behaviour

 kernel/bpf/syscall.c                          |  14 +-
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 312 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 3 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

-- 
2.27.0

