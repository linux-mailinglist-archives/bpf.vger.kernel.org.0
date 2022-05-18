Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCD52BCF3
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiERNe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiERNe4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 09:34:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AAE166463
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 06:34:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IBn1Bi011872;
        Wed, 18 May 2022 13:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=k9dTMALnxkjmzCR6yUgb26RAoeEdK/JcY23Bsk3mPfI=;
 b=XPidkUHjMBYel3sOvdOAxsCekFBAeTJjHmu4J12E1LTw2wbSzTV56vSknyAtRrbblFOh
 WQwM353iZUcMi8dpR7/1VDX7pOD1Zd+23nASiMZhZwQd9DV771AxPTqaJvOH+wbroOFc
 kSOOAiFhzzfFaAtV0/GYQDPz534+J+tv+hVBO0prxs/POPJhjqePwe2952+YV1eA3S8V
 33LVR7tgxXDY9kuynZlcUUAInujrngh6yQ6u/A65Kx3Ybs5Z6bppGubFhGTJMr5Y3hr1
 4pAfwyFMzh3saegWAzbIPMgJQ4gMI4adO0xo0LAz6bHMZdlLArJH106+q6iHDAh5TW3E Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310sb0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IDVjZS039753;
        Wed, 18 May 2022 13:34:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cqdf11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDEHb7MFN5g1SOMCaHIOo2lp0z7NsyytANRktkfpOwA2nUqBLpxEhO7Jnd7Qj9M21WpMsv/ddE/jy6fOtJ+WAyA+nj87fs9AF8xbjakxufl7fc3iiDmWL4w0STxlDMWILZXTOH5/T67A4+JERAQX7CjKrxGw9q1DBsZC/XkRjaKURqR7ymOG1yTQRVRpOFbmkUiB3ofD1g1lmgSagUJhyQl+0hPwV3DrdbhQGXjbgW9gTFx3lnFW+Tr2nnxW2Yy2ddyQkcPbGVgG//latUi+uUvofpUKZ2h1g3g1PGWFGf8PFBY/Rp2CqEc4NKPZ3F4lWrD6vHvKaX82Lu10b/fdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9dTMALnxkjmzCR6yUgb26RAoeEdK/JcY23Bsk3mPfI=;
 b=FQ05sq91DFSG89EcHOKzrH9OUFikGpGc/b0KVY9wSJf3Ne8P04fkUYS6TM0MdaKr6gn5ouscEXjactdpV0s8aEYTTaclLRXCbBkqEL+9acSwtZlLjux0+4/XQJdQC8a7AgTsIMgD5PoQA6851zckGUYDCH//SFqDl7a1o2LWRUFKLea5Ri6xmzU4LM1qclekVXW/lm/dyk+nv+ZgriDgJvFZMR/cM1voh0Y8ax937EU01thMw02YXGnhsyme39t979TkfXbMOGbI+Vczl5k0wwiy4gpjGmfkqvOoANwmT27GEp7rR09o5jZPsgubtpiv0TzK/G3HbFuHIQqKwlxQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9dTMALnxkjmzCR6yUgb26RAoeEdK/JcY23Bsk3mPfI=;
 b=NMmMSiLRkzWlO+Q3gcWO99OLS1A43KXOkHUrj4jrbFaVT6GUWpf/iRR8R8QmFKBl1SHnoyBpjC60J7srzCPeQoGBtw1IQ9NyzzVlhIWRaMKpVa+9OVzhI0nudBTJTAH8hl1/KEHhFTXtv5fvZ8UrYYQC9ceUcJFyEXZIWWt9qBo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 18 May
 2022 13:34:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 13:34:25 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v3 bpf-next 0/2] bpf: refine kernel.unprivileged_bpf_disabled behaviour
Date:   Wed, 18 May 2022 14:34:19 +0100
Message-Id: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34535149-67f5-46ef-83d5-08da38d32015
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5836:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5836B97F40585FBA46528FCEEFD19@SJ0PR10MB5836.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wa2wtjqher2WM5jt21XkWSZTdlw6x3bQq/chZBIKYzoxac3hJ3QI/iQii22b26a7YQpLgkOGGeopoLe+/2SKDBs4upDmJQE08tFRp+eFPsjdGLmbsDEN8ns5g37ycEgIifgg33ZkfSE+1Aq/VFfNg62Tw5H12ehETXmUg2wpo19SU69I0oqhSTS8W1PrGsXXeVRIR3epUDxI9wEYRcyja44v1UO4pIyTKOp2nbxv/oZ0Wgq3RVmHFFM5ju7lUdAEvpOnVWaWRtuUH7vLajvN4pvXA5zc8vr02FaaO160ejiqTU/taLiTCSCHutkOaRL757S10W8FdYspgA9RriWnkbwZirtMMjsuP45S06a1KyXbu4khLkFgh0fr0jbpXSc1l2inDpR5DFs9xCT+bV6jCqA8swXDJFB/0zcCh0P6QisxNFJ563t+W84SvUVJ8KcrX0/c5CvvgMeUSlzj2ERltV3e8cAuDyn0xx1jyqjKy7buS0HVhCzDHAEqOpnM/KNU/V12c7emX8dVBtMnBVc8jGtjNwnD334whhnrodtGI2G/BN9HLdUHnzYanwvN0xYjRdY3hrfdqI95XH5aP23LQTnJQPAzBbQhHKgk+6RJGHbP1jz6AoNVM/5I5WHxpAfzJUstJHL81KK2SPKptTcgGrum5Lg1qTRGIjWnhGRGKWnBaqayDs9oV/H7TKg8nqHs7NjSROqAiSoF2xI3dOqShMMaaM0ssyrdMWIBKfiU/ydUynjlW6kFFm/rUQekRZudipB15VwolGPdeS5gEelDTxNSIQfs8QLki4YfQn2IZ858ROlR48/Kw18s9M0U3OtiR70Kdoyo7cmWCK86djM0OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(316002)(36756003)(66476007)(6666004)(4326008)(66946007)(186003)(7416002)(38350700002)(2906002)(6486002)(508600001)(8676002)(6506007)(966005)(83380400001)(38100700002)(66556008)(2616005)(8936002)(44832011)(5660300002)(26005)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QhELwiO4MyYG7KSbNPAh4Ti4zZ5inpTgVKiPSGDk5UeMtfU32KSey1MDgGK?=
 =?us-ascii?Q?tSMWquq6Rnoc5AaACiFJegDg5PeitdsuBF7NkdmuuqWCRpvnPVoblUnDsAJc?=
 =?us-ascii?Q?Eq7n5eIuhLxFUNkzJ/+rRLV6rOmKEllp7cnui78/MH6xwujFQa6rvg2JJJCQ?=
 =?us-ascii?Q?XHptSZfV9hj2JyLqLFHMqamnb13syElF2i9G3LI94ou86/jDQp3ToREPgi91?=
 =?us-ascii?Q?+FOw1Dg/ZgpZ/LCjztj5TVfBKensdNXVPIRXpItT+OC/2G+itXzeSsIvCQij?=
 =?us-ascii?Q?BpZas5ufLRwnpCmtU1dX1tz18aXIuoQwtgIUlzkbH+KGAHiwN9I5rRz5R8IC?=
 =?us-ascii?Q?/WN9msWvAwlfloxvG8uWKrwbZMqi/ZJ3+kg4/+owJc/IISR3DgLUuzWCowTM?=
 =?us-ascii?Q?Vv2nZ9yob61bGK3v4yzZo6UnUFKGN40UG1ZlbYYW3IxGosc27XWRXJ6KR9w3?=
 =?us-ascii?Q?ApAMeHWYKyYytOyYPck3kpK5yDaZlsKfsFwtxS2hRliS+mLzYJ5QsMXZyEXU?=
 =?us-ascii?Q?0P+WHrlyo5W+5wgnIEuPayKwzskkdlflc7OBiBwNRQhXNHs0r4uoxAQs5Hfp?=
 =?us-ascii?Q?BSeWrVGXbNuSH+8aZyO/XaFDrLhCUKiQ4YiGC6QWm8gJl3HTzqBNvrJ1Hpgy?=
 =?us-ascii?Q?LBeaaebLG9ZxerPhlSUgIYuHiqot9oHHvSI38SB0+UFjU1ddURLu5UXYpn5b?=
 =?us-ascii?Q?R6gl7qBXChoFDcnc4EUetlTtAXEWDt8JgEcFn7t/hktPJClWzKwBEfyla5P0?=
 =?us-ascii?Q?hqxUrO+ocNwbEhHd2LZQ4yoYtjWiTOYVA1JiMhMHFHcFDARlD746X/UGkUFQ?=
 =?us-ascii?Q?ZfKcbPN2FT46flfMUwhYJ/152eMZIXNw3zlb62ajEpd+jh8IvOTYNYspOKb4?=
 =?us-ascii?Q?TiV/baFZVSzJnmoBUe7Qd+4LQ9QrbtVcyHng/Es8JWA0KVTZli+flHpG2Nio?=
 =?us-ascii?Q?AfyMw0VNXJkDbKA6rSIO3Id7I60HsAn12ZYgf1ESLOAel/1fgld8mQ9FO9tE?=
 =?us-ascii?Q?xyI76B6AOuWYGHCImCS5yZNDRV1OdtVaJuJJZ6iKX3GE8Ouns/odGMalgtZs?=
 =?us-ascii?Q?PRb+VmoaW/8s52ZKLYPel5ACIKqb87DarOMGHng8mjSKPGWchiHp6dAv3Vtp?=
 =?us-ascii?Q?4Z7GWnsOi5LqLASPZX4bq5J2N/l7BrcbTU5rQJj8U8xPbhAC7V0HXiNwWoq4?=
 =?us-ascii?Q?dLBU9YboRczDUJUk0UlEECAU2Eu1wkGzfCCF8tcBg2u68YvN8qLGdyOvKcKX?=
 =?us-ascii?Q?lHQATHpWj7X1m8b6EIK+cBvZVSs61Bq1/ezQjGQXBnPt3KOZY0SmYw2AbHMF?=
 =?us-ascii?Q?n1L4Qr9g03YhrCc57fk3Vgy6mttHEKj+7+F0z6Bgqx16Uh1FmhJykSnSxqcu?=
 =?us-ascii?Q?w+6IAJkY+Wk30u5KQcV0+gpMoGOOTY4wurSPRG2YXJPbXDGDCV629JSmpzBT?=
 =?us-ascii?Q?cQA3iH9nzEEhHIFs9jtXS7CDXiyTffOceNk12/UVWXC8AP0uSilfsO0nsEUL?=
 =?us-ascii?Q?AuFbraEZdG2wHRG3i7KZewr24n2nRtMSKVG3Exe/0iyUevsXkCLJ7rUYCJsZ?=
 =?us-ascii?Q?CdWEfN3fCMQCWxevk8KnBhBSJIFdnCyhPl6Cq50N0VqwfyLuyEFsUwg/f3RW?=
 =?us-ascii?Q?P8y/nrg0Tb1ddwXKdf2FEEYMcadd8k/7b0G2K14bRGRUhamYOgPAbbBrNWtC?=
 =?us-ascii?Q?vUU7dVCKnEMtSZY1FQQDXHzNZ797Xafl4/ObofQq2RJFFJbtLOyVl4vjBLB6?=
 =?us-ascii?Q?s7Lrwethg5DOLCb7bQh6Q7Jror30ph8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34535149-67f5-46ef-83d5-08da38d32015
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:34:25.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqMbPFSPDqcd3iolRD/wcqU/oURynib+w0OtK+dx4U7oMeklfqh2ZtfJk5w+3QriTnvaagCrhEHcIqyuda/dQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_04:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180079
X-Proofpoint-ORIG-GUID: 3C70_jm_dKfT2IxXGCy0GbWYAwGJMJDb
X-Proofpoint-GUID: 3C70_jm_dKfT2IxXGCy0GbWYAwGJMJDb
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

Changes since v2 [2]:

- added acks from Yonghong
- clang compilation issue in selftest with bpf_prog_query()
  (Alexei, patch 2)
- disable all capabilities for test (Yonghong, patch 2)
- add assertions that size of perf/ringbuf data matches expectations
  (Yonghong, patch 2)
- add map array size definition, remove unneeded whitespace
  (Yonghong, patch 2)

Changes since RFC [3]:

- widened scope of commands unprivileged BPF disabled allows
  (Alexei, patch 1)
- removed restrictions on map types for lookup, update, delete
  (Alexei, patch 1)
- removed kernel CONFIG parameter controlling unprivileged bpf disabled
  change (Alexei, patch 1)
- widened test scope to cover most BPF syscall commands, with positive
  and negative subtests

[1] https://lore.kernel.org/bpf/CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/1652788780-25520-1-git-send-email-alan.maguire@oracle.com/T/#t
[3] https://lore.kernel.org/bpf/20220511163604.5kuczj6jx3ec5qv6@MBP-98dd607d3435.dhcp.thefacebook.com/T/#mae65f35a193279e718f37686da636094d69b96ee

Alan Maguire (2):
  bpf: refine kernel.unpriviliged_bpf_disabled behaviour
  selftests/bpf: add tests verifying unprivileged bpf behaviour

 kernel/bpf/syscall.c                          |  14 +-
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 301 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 3 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

-- 
2.27.0

