Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3752A102
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiEQMAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiEQMAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 08:00:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733343AC6
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 05:00:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAqfbW003221;
        Tue, 17 May 2022 11:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=BZMH4sqqFY9B6BVElWpMa4hgozTaaG/U0j8UgjoLXYM=;
 b=LTzuI76K2VnKV3ye7Ek5b8j+IPbPOEpSHOQ23mzKPlHtMabUnmm9m0c2AsDbFDhZt7km
 N3e3q69kbyU7XaxJCIsy0H/SasicKE3t2Oi7MG0bQLQozG+D35pmJKhqc4Y9R8b9IltI
 fBLbocY6Bnnj4dmzRxwGBeNPEVUMkOTAQymxVhm+gSZ5437gtNTauPPlZFJX/pbafG8H
 aNicBAj5KU2PuDPZmwL39y9xnBgMiHnXFNxI6S/ecOorfzDWobrCVRSbG5U+T2PP9E/g
 U2exPglVFS3ZJNG2ZeDlCkoDQY/WwJp/dfd08XIQeBMbuVcsaCgfGxwgZR4MomlTMt81 yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aadxfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HBtUkV005004;
        Tue, 17 May 2022 11:59:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2s19s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IowS7yUspw2cgkhla6wjyxiHvGeyfEfRYT5lm1by54gR6j5IvD9xRJh0kjnOaUXmj2FXERU4ydf7GSL1nXQ3Y73FZ6XjWSIJ54ePsFGE7g+CGc/zbn154O8jVX34sfGz5Y+Ap4+wSWFePD5xJ+H/2G68Tgwb3rj4oFIReX+wApyrLbQYsMOKzCLSMve2GImFgnuuEoA0GlCwI2PFyFx2ssPuvIHkxfgxThzJtAx/9B9bKRoYKkz6K4sZ92eLw7KNu/viVTfLV2wEUDIF2vuVADEZfXLvzQYQsbzLbyapJ0ctHHG0p60Kjz7X7mkDf7V2oDrdhoOe76HWhH5eDpd0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZMH4sqqFY9B6BVElWpMa4hgozTaaG/U0j8UgjoLXYM=;
 b=MnkreR7zphX4Yc8QUiMSgYVYwoPLDp7hJhSqdIKU31IoWWz8+xZYqNVHEY2H2um+ojPaFoBHV3pNx+pSEY9o9+V0Rsn1AYNF4vTT6VjzU7Vb6AJ30JpUWpPOra9+/op32s1pH0e0IidcFbHOg3DLo4MmthPQt+/tpqUrlnfKNZe1o3754kYi2QDxgFT23PUFkvTUrDUT0j6OP6uZiiegqXD9KKHSK5JfHSkRxk1CDxoFCZdLYpeDo7L8hl++Ov0F/tXLtdUYCdxjUYUKOx+vRy7/rvMDc/8yzGG/wGtlrFBfm2Af1uffT+zOIGoRH0XClkrONjOVvhvyO7qRXOvWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZMH4sqqFY9B6BVElWpMa4hgozTaaG/U0j8UgjoLXYM=;
 b=XLrKfk+8/VcxRj+G71QrmJVgsBtW8VbSAwGPaKM9CkpaFyZ8seurqkKbkQ3cXv8FHeU6VuEvRuUqxVEn4zxpzar6v3etAXVTFAO6Dq7IhVaPCL7nyiBVIjo96QBkRFBtnzUK30eD1EbqpBc+cocg22QjPe6COUJGY3Yw14R4BD4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM5PR10MB1305.namprd10.prod.outlook.com (2603:10b6:3:7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.17; Tue, 17 May 2022 11:59:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 11:59:45 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/2] bpf: refine kernel.unpriviliged_bpf_disabled behaviour
Date:   Tue, 17 May 2022 12:59:38 +0100
Message-Id: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4270ad31-606f-4a31-c2da-08da37fcbc54
X-MS-TrafficTypeDiagnostic: DM5PR10MB1305:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB130523C12526098FA73143F9EFCE9@DM5PR10MB1305.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8EWSky4i4+sZWu/wp37PCAVNymdXbAj5sKZDsfvk2AwDOw8ypiosXc81wYKcIGrsTU8fhbQjet+8spWMAX34kC81IppX7h4VUvRWHLwlDl62cWbn+FRek57khiza9BhLpZo+z4qZMYQAcCV00kVNU/QHwK5AoumLBmZXA5My5AKjwHBlhX9DapqO9+OLct6xVYaKdurI5TUUFUx4gcoefrD5UYIYd4XNE39I9OOu501gQV+C8s4bC3ycNm0gmTZtymURLiTsKoazjkrPZi3AgBd9TxGG0cPnw1UCQ80bMs5vbRlk/llnov/H56R7twHJKEWrePsMXdsFrQ9q8n9XhnAq6yMVP70tmlu0OjGB6VtbAflcS5wanIi54WN2POr4M/EH/1o44jVXEAfSBVe3BJCAmnMxMQUyJos4smT+L+g3MlGBgRFj5AHX9XfVq6P+1fMPakhaNQOg4bmW3upnWw/AC5OC0p6Xi9ZR4gqb2/Pu8Mb7u/WZv57sjdlnEblMffBR0IeT33RqwZjkBgyFQbJWdulh0PrlHDSQo75xjVXheNrBAK+JsKPQaBx4UUcXYXu6HgSChRQTY1DMRcbvX0vqOCfDOMEN44deavhyEeIaRw0KuyHeU0PJOzbGHKSR3iKefyNIVgpxKE14S/TWNGaCbV14/9K5NRTd7BaZwU7hqt2oNYUUPCtarAMPXbYUrh5+bmICv9mnyYZ4FYkEriRspmV7WylngVAeW3gNV6Oht5hiPC2IDpVWDxo/5wI1HCYpRhYt3ZAvCPpuqtX7MSfXLRjfl18Lx7hmZ0a01VtqGTc4QTMJKeEgjw0P4X9iqTbmz2cD/aLy4KuqVU7TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6512007)(83380400001)(966005)(2906002)(38350700002)(38100700002)(66476007)(8676002)(66946007)(4326008)(66556008)(6666004)(52116002)(44832011)(6486002)(186003)(86362001)(7416002)(5660300002)(8936002)(36756003)(2616005)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/6EffQ4hietCdgk3C6V9smryGyXvKNK61KwVbDUul7OyOOvqr805sdILvgJ?=
 =?us-ascii?Q?5GgSls8opYNTF7RC5Pxu7vc+wB15ZI1xBxnjdtHIbQVOltVIfTlg2rGO2RrG?=
 =?us-ascii?Q?sbLxa4u7Y8//2J0IcIVxQXlC1Mck8qZyVwoAT+kX7+oG8rdKs/bQ6J3vXfFN?=
 =?us-ascii?Q?CCB7ZeSBf19XONx6RtaPQcrEB/5zvV24pqasm9mnVyC5pmkpnb1hZ5rlmLHh?=
 =?us-ascii?Q?1Jj/H828rThR0o60socT33yXnoXWYgwbOT++Y6rXqaId9b8OUTZnvjBHMKcJ?=
 =?us-ascii?Q?nQirT8f3WQUEOCiNDI+DgQf0OVplMHq8nxMrMjnGqLrlWnVI5s/dbp2C3uiu?=
 =?us-ascii?Q?pqHUaEiyalJ7oX5OaNyPFt+h7dIFDT1W/erNSklAXMHWT+EfCakJu3Rvz4dZ?=
 =?us-ascii?Q?O9+GUNadOegwxubY4rXkn1vb9VT7v+6uiucwctxXXDfOnDYknMCq9LSUJTuE?=
 =?us-ascii?Q?gX5dQ0nyb13lm7ioTeJxGlQJILyHwC1C/Zra15ntfXFfN4BwqfnjcgkKbvjG?=
 =?us-ascii?Q?uTMXKk0ROmqkMqq4qOuP3g3W2gn9DQ946QLmqrUwRMeXVFwGExLGpoXqaeJZ?=
 =?us-ascii?Q?EfO9bYpkTDAajPGkTrXmY0xYDg0cY0kW03YX6l6ebKCP9wCmgASNynh34T8U?=
 =?us-ascii?Q?j6yKv9icP2zXg8sG2//AG/CcWhifz9/bPs22RMK9Rh897LgpsERbH31FRlar?=
 =?us-ascii?Q?ysYNCL5AuafoModiKVtYGL4QThaEKdpgsCiAAP3w7UBSP9liH0DTr0wxpPV/?=
 =?us-ascii?Q?eZrMqHbRViKmArxrF4xA6ooUg05LSW9iXhwM0xRYwwuZdY6LX6K/IKFOh4H3?=
 =?us-ascii?Q?VtPJmwdjB1xoty0OEz3CYK9jzlHSj7zFbC0WpJD+bOHSjB/rqtkHXsLKeEQP?=
 =?us-ascii?Q?5y+tLotOvvjJrFjMjEDHjyYIFQhY2qiDTElcNrCI/j0wnBY9Bbn5y7glhJGS?=
 =?us-ascii?Q?ZpM34/n/sOsIjPa7TRtxpJIe9pEFjnQUxBQ0oVdFMrHxIcnbtYT+C1Yq70M0?=
 =?us-ascii?Q?3tnOYptkYU07kSCfIa5V7IKbhhp8c9GzrsTQ/lPzUdMxSBVhvxajrDpqm66W?=
 =?us-ascii?Q?L1ZnttJgmhyrTbSmP1S9yeiNxHKBLs1EW06k+KIXlMX3jdP/adl8vVb4yHjb?=
 =?us-ascii?Q?8h4TDVSKkE/33CDMiRHDFaqBfmQdzqHQsxM7A8/JCWusbmcnHTEj+WiTRzwf?=
 =?us-ascii?Q?kgqYmc9o8jrtq2cw8mj4RqCr5bZKCTyfbX/Xh2YCgBzOSOGXwD0+Fku/DcXt?=
 =?us-ascii?Q?ua+GnpsetuhgM5idedrfq6IU0j52GUvlhcpTp9PooCd8YvKsQhlDcJ8mU/Do?=
 =?us-ascii?Q?kxV+BcmimmCPA7XjDa7H/KaXoRHZIFdD4AZ40zexHBhJvwSDPso4ibwSj/Pf?=
 =?us-ascii?Q?ihU+WimoSXIuwjwnYL+Cm4N41nvPeSh5sQyUnbbxP232mfSEzzgv4SJ/Wn6W?=
 =?us-ascii?Q?t+vbXzN0aVTl6GpL/FshaAUipyGsKZ5CBE6axIVFI3lQZcAWEFF2TCeTnU85?=
 =?us-ascii?Q?oZRABDLeMtvBWeX+PGGPqP2+Bsg2fRxDRx2rlKVuHORPmndc+3fYvQCkXjSs?=
 =?us-ascii?Q?oVEFCsaT9zhYYOMe3rBqQPNsHoTw2VURcJ+TPkrU7Bu3y/s2dc4XbKyCNyp5?=
 =?us-ascii?Q?vVVU9K/XGEnLgzpnZhaxR7Wh1PwqOB+HxYHJ+oSy+p+dNJ7XKiOKl5UYnSDh?=
 =?us-ascii?Q?UU7nlntO+E5Z9eyWcWpd7zQLPrQcVsYexHp/67MGFyeG/8l3n1VWENol1IHW?=
 =?us-ascii?Q?GIM2u4XH/2z/+zjmoKZcpoKJKcg9y/c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4270ad31-606f-4a31-c2da-08da37fcbc54
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:59:45.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFB0qCAwQW4HZjAPUE+Y7UuGQFCqES8DxEsX+PaoniSjuMugPIUZ9jauMO2TOQd0fl3cNIJ6AUWHb08T3+P7Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1305
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_02:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170072
X-Proofpoint-ORIG-GUID: g8U7KWZRCCGzCk39-oZ4VwxdHsyuGeCi
X-Proofpoint-GUID: g8U7KWZRCCGzCk39-oZ4VwxdHsyuGeCi
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

Changes since RFC [2]:

- widened scope of commands unprivileged BPF disabled allows
  (Alexei, patch 1)
- removed restrictions on map types for lookup, update, delete
  (Alexei, patch 1)
- removed kernel CONFIG parameter controlling unprivilged bpf disabled
  change (Alexei, patch 1)
- widened test scope to cover most BPF syscall commands, with positive
  and negative subtests

[1] https://lore.kernel.org/bpf/CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20220511163604.5kuczj6jx3ec5qv6@MBP-98dd607d3435.dhcp.thefacebook.com/T/#mae65f35a193279e718f37686da636094d69b96ee

Alan Maguire (2):
  bpf: refine kernel.unpriviliged_bpf_disabled behaviour
  selftests/bpf: add tests verifying unprivileged bpf behaviour

 kernel/bpf/syscall.c                          |  14 +-
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 308 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 3 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

-- 
2.27.0

