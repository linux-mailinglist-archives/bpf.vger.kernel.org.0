Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56306523419
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiEKNVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 09:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243669AbiEKNUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 09:20:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6C24824C
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 06:19:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BAETtp023623;
        Wed, 11 May 2022 13:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IVK9iLkB04KnEzNBgtKkfBGMUlVKP0lVfZ/CbmZOAnk=;
 b=ENcf119EZ/H25ZyWpp2ItS6W1EqJkG9UqcT56PfcOykD7iL+T3bORz7ZtMkVb9HVcQZ2
 ITc+T/MiMElPcbAX1tsZmJZokBkC8nkcdpKvl4/9hhpqHFp3Z98TNav+e+uG+UlI2Bmb
 zkmCDnvO41PUTdKo3FnHpd28GsSXNgW/qrBwVteX23+CznxaKCrWBPk5LZVuYvQuxzAq
 xVWHK7c/Z3+7NZltsghK47pu7Ok+oDrdFTt35fUTkDexnYg+1W/STHCdOngsXV3FuoCq
 xBKBCUgaNBiG7aB8ecvNazk7xDHNRVfqgn5rfOiM+r7E1gqhBdEOfFxb/wcIsStVU/98 MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsstwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BDGPxt028577;
        Wed, 11 May 2022 13:19:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf742x8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcIYyXAj5eOd3f2/V1GnCWAWdobcrOZEzlsC1WEmvfyWJtnNKDHGnflN5BWzeFP1/wMirXP3V4YFXCBLnIuvzclLWEGrsby86Tz0lpA8vskrA0RGU9T07srxNcOananjUmIQ8/qkXh18EOLmOQu/Xqt1Vk2YVjaPPlziStRZv7HW6ZLTSHCTCZN7G7slhyVAmT4DZYNi/s68miQEN2OzuVidGxcgKTb7Di61BBKQ0dRwl+ko392zzig62P9CXlY52gvPwiyMlk2iEWTGp4GBpwX6Pe+/VP9Kz8vfxNRLB145yP3M7p8fZcDa9fScGEO8UK6W1Epa1FEvknw8GN9lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVK9iLkB04KnEzNBgtKkfBGMUlVKP0lVfZ/CbmZOAnk=;
 b=kmwlQHUU0lwafCDYyV3T7GFfNUfBEEqiK/VCpeZTl0CTyofqjF2J1I8phFxosaa5twd/hrQZ7LjAXT2xCljkRWxAU4FeOgtZbDyEN102k7js6hOqxdLZf2RUlZWhhWRk7htS1h+Y4qo7lT2EOIRilfNCV9pLLvIK1JCsK6gWGsH9w2zgqRp/k4RfJtLpIDJGWdv871v0LcTu1t7YYWOrbOH7nKjOaDrD2rW5gR3kuwDw2AZSBAr35Gg/HtBKOJZnAnRjrW8gJk11Tc4QHm/mq2ClIoeSyjRlYdcz/rPYg3oFuP7lLUC0423Psb1fCXGaD7zoeYSzSeW9XEDvxZhTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVK9iLkB04KnEzNBgtKkfBGMUlVKP0lVfZ/CbmZOAnk=;
 b=w+W5+3WV22uuZTihj8SM9fihRTFz7nYwiT+8LkCz+x6XFwt2pVwBh2SgO+ImvMxsytudUWJvawKPQaN7J/ir9rSDebjCiB9SlO5mQCHo8nBCxZvKbIIg9QwzNYU8FzPQzHlOaYb1mAZrBXoiWj8l5cbjHwQGX82FF836fWP9lNY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 13:19:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 13:19:33 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [RFC bpf-next 1/2] bpf: with CONFIG_BPF_UNPRIV_MAP_ACCESS=y, allow unprivileged access to BPF maps
Date:   Wed, 11 May 2022 14:19:27 +0100
Message-Id: <1652275168-18630-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
References: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042e1923-f2ae-4f6f-b2dd-08da3350e393
X-MS-TrafficTypeDiagnostic: BLAPR10MB5154:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5154C75B737A9BCA66BFD466EFC89@BLAPR10MB5154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMKY1nl6BpLa6BpvTV6ekjuqQrjw9D/2Np/bIwInEKgSTmEMHKJjoc3WcGUVS4DY4gvw0j6As4seOxCNhB19DUn8mDHHeT8yreyhNXYaf7xCqSCAEYJUudIPWgLw1e+XLR9gKjUlKHbh8TNX1DFtR2nuRQYHY9JYEZX6xt5TD2El53NQJw1JbA2Xht/LFPOkxul91xFF5A0osrVAG51gyFe3mvotLx98719oRj+UIuB7JGPTXQ05vTGQiHXfyLD44847KOW/bEXvM4J2pod77XzdJLit6W7Q22mlUpvq2zHXc9lPKn+RVzdORnljx4ndSDS9Wq3cfI07P9Q/AwInTYLb4ZKpCPgcz9Xnwk1AVZYTs2QCA/noiPlAODYt/GU4CqHoONebP/mW2NMW2tQzBPH8f8Yhgc4dCkRpVkKImN3B0oKWphEK1tEQTdCFJQIZv4p80KDT6glXe82JnzaazMSL413+meHyKqvJ2ILJ0yukpBztAgJck1sZm4Obu3Z0mx1OZwe353URj0KW2sGsr6/GS1Xv/ggPOvutsvy6l2FYtgti3ZbJSe0zRPzIRTK5FFBpsGGhoVJ6+3rhsgt00Ta054O3+t0v5w2ckzoxy13JveBrVu2Zhzk75R/WXreW1/S5cuaiIMhrfnrW0MZMOe62aS2Xb7S4K958OpBm5jtsrjXpYeei2shF95L0XpSwzt4y7e7+o7RXpJTuxACIQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(83380400001)(2906002)(38350700002)(66946007)(66556008)(66476007)(7416002)(36756003)(44832011)(8936002)(8676002)(6486002)(6506007)(52116002)(6666004)(86362001)(26005)(4326008)(2616005)(6512007)(38100700002)(508600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pVsPi7CgAd2zMDgZzwCfAt063kr4KlGcTy0zMCA6fZC6h6NeWbVtY/TL1OfQ?=
 =?us-ascii?Q?R7sqxrwqIpXhxTvSiDRFJEh7s11Qh1U11a7UEFCwx+gbWdCjlawbgLOrDJwH?=
 =?us-ascii?Q?dDQO22HdzSh3unuUviTcrug1LMtLItCl5DVi64kv4Xy0eyZCjQ6XS5wionAP?=
 =?us-ascii?Q?But4F2rV1Vg5kuhf2Kl650N/DzbDP3WfoHiIhAELMUEY7SkU5qi0cje2RBP1?=
 =?us-ascii?Q?y4l57Ff0oqjWdRd5RO0NQWk3ULeKaHErN0yiP4yUX+kK0uY6E1MTMPwZlwcA?=
 =?us-ascii?Q?R2KUkQNSEQxmBAJB49+DNtABnCE8hktLzvBGEZ4DxCTVgnrQYBzsu5R3BgW6?=
 =?us-ascii?Q?QJvMXhTXsjlQcTqBVDgXXTVkjU3ONmwPJ9HNQkwYnrddXvpgfHpqGCr59Izx?=
 =?us-ascii?Q?JkZjUij+XpqXka62ITjDokCSCg/VWeIYI7B02wBmTEwzsX5zXI4K6KMgZQXj?=
 =?us-ascii?Q?BQeDrRM9NvY+rs5s+mcYzCmR4nKb7TrUg0L7qI/1sevPQFg3k7dbF9PTgxMG?=
 =?us-ascii?Q?gQhZd/NEnPKLwfkKKEBO/xQ3H+j3Q0HeTGPIaZmA6Csfh8cAPcM2Ib/37Yb4?=
 =?us-ascii?Q?utNQ9g8MHXGC2YOicv8X5DIceoYULiAPZmZc4P5Hpp9j5Q65VuE7j4kgu0kR?=
 =?us-ascii?Q?EBQDrO/TF/QaiDl3gLTLcCux8rba4cCUNCEy3mEdosBX8yU1grKNmVgC2EuA?=
 =?us-ascii?Q?3MPg+WJe9b7NZTMxTJs4rFgcX2LlFgTyf9Pw+AjJ9ZadrQibtXsQ+9yvDEH6?=
 =?us-ascii?Q?VWFaK+ZFEPLHKFeKXhXaEQvIcL41AhVNPIcRPQUqV6MDMrnQN18FKp5lgGv4?=
 =?us-ascii?Q?XkxGmu/d3Tz0u0KzSxuWqC9v6JcaysEB3Jaq/ebOWy5cqsm1jM58zpwp3e7K?=
 =?us-ascii?Q?LlEquV6Rzr8oxgyh7whkfLYF1dnqtPfwRtU0+yODWWkG8wjMnI8y6TQv9BwK?=
 =?us-ascii?Q?NWRukQT6QeEQYsN4bf9hkC7gX7zdHJJY8mSuYaqlcumkD1SeERxod1D4WbTw?=
 =?us-ascii?Q?Mk9YFTFHvxxYNm7Qt5/UOA6HkUqiRs61ZEeN3y8dDAx5T4fvSGMoYUYWbhNZ?=
 =?us-ascii?Q?fehbjG7jc51fjENSPJl3+8IMs3E9spModATuF5TDXPKG7G/sFuHmNlfIUXL6?=
 =?us-ascii?Q?fEYmzn5aW3Qu3dtd/ScogOzc2KShN1dI58CwkUkU3Gxq+01mwnQNFwmvXWJi?=
 =?us-ascii?Q?exKJ03V3fSG8lrCVf0st2BmoEKBlwMVVtN++Uq/nNw/kX0XFJZCxmN6S9388?=
 =?us-ascii?Q?TrS/Ph+24tlqYw7WnLkCdvTZgbdlz42F4c9ih31kiG4+7N+ffodMbbR4Dy9N?=
 =?us-ascii?Q?v4llR5xMdClLkboAOIBnXK9xVBF07cSDJLaVVmJ5cRT8gBeNQ2fDkoY25b0J?=
 =?us-ascii?Q?8z66VO+V984lS1i3bLu1LxtdswXQu8TZ/PM8yUcQj8AHdt4W0drKkuhTHqQD?=
 =?us-ascii?Q?OeNIvfce7ZwrlbYOYznA2JMR5ZuL8zjEk7lbDfLhVBYfxr/SemOfFxBTl7E9?=
 =?us-ascii?Q?TuT1/47uc3FA0lyAc04EDQuAY61KLAR02aN9BP+Vu5JOI8AGgCAM62KkMmle?=
 =?us-ascii?Q?hYZHHA3KmFByqdrN3CjoLDdy+Td61Fi7JQiMCuZ+caDmpRYwXskdoI03+xzy?=
 =?us-ascii?Q?fhZseLohD3y1AVS4PuzmQVuf41vwSC4041edY7lcO5EvD6WVO/T5mCLS16Nv?=
 =?us-ascii?Q?wjOIsqkpCqjzP9rM10PTnu3xuyaWEsPsmNBRfW00bWbqJ3NGm4teSVyD5Uv7?=
 =?us-ascii?Q?NATw5XJJcP0f/CcnNt9/FYvCZG4Mkp8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042e1923-f2ae-4f6f-b2dd-08da3350e393
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 13:19:33.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCJ2CTczTAEH3EcfKSmmt9LwukvGldV7H0x270ETsB36cEGy1iIlJEOaz31OubKG2SHyjATNVFXlUifTSJbRQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
X-Proofpoint-GUID: b5xDlqegEMn7ou6YGqUzOyXEw4U3d6g7
X-Proofpoint-ORIG-GUID: b5xDlqegEMn7ou6YGqUzOyXEw4U3d6g7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With unprivileged BPF disabled, all cmds associated with the BPF syscall
are blocked to users without CAP_BPF/CAP_SYS_ADMIN.  However there are
use cases where we may wish to allow interactions with BPF programs
without being able to load and attach them.  So for example, a process
with required capabilities loads/attaches a BPF program, and a process
with less capabilities interacts with it; retrieving perf/ring buffer
events, modifying map-specified config etc.  With all BPF syscall
commands blocked as a result of unprivileged BPF being disabled,
this mode of interaction becomes impossible for processes without
CAP_BPF.

Here we propose allowing BPF_OBJ_GET (to retrieve pinned map/prog) and
BPF_MAP_* commands to work, even in cases where unprivileged BPF is
disabled and appropriate capabilities are not present.  This mode of
operation is not enabled by default; it depends on setting
CONFIG_BPF_UNPRIV_MAP_ACCESS=y (it defaults to n).

Note that the program responsible for loading and attaching the BPF program
can still control access to its pinned representation by restricting
permissions on the pin path.

For map-related BPF syscalls under CONFIG_BPF_UNPRIV_MAP_ACCESS=y,
map access is restricted to the following map types:

BPF_MAP_TYPE_ARRAY
BPF_MAP_TYPE_HASH
BPF_MAP_TYPE_PERF_EVENT_ARRAY
BPF_MAP_TYPE_PERCPU_ARRAY
BPF_MAP_TYPE_PERCPU_HASH
BPF_MAP_TYPE_RINGBUF

The set of unprivileged BPF syscall commands that are permitted for the
above map types with CONFIG_BPF_UNPRIV_MAP_ACCESS=y is

BPF_MAP_LOOKUP_ELEM
BPF_MAP_UPDATE_ELEM
BPF_MAP_DELETE_ELEM
BPF_MAP_NEXT_KEY

..and the following unprivileged BPF syscall commands are permitted
in order to allow map retrieval:

BPF_OBJ_GET
BPF_OBJ_GET_INFO_BY_FD

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/Kconfig   | 15 ++++++++++++
 kernel/bpf/syscall.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d56ee177d5f8..30e6f559ad08 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -84,6 +84,21 @@ config BPF_UNPRIV_DEFAULT_OFF
 
 	  If you are unsure how to answer this question, answer Y.
 
+config BPF_UNPRIV_MAP_ACCESS
+	bool "Allow unprivileged access to BPF map-related actions"
+	default n
+	depends on BPF_SYSCALL
+	help
+	   Allow unprivileged access to retrieve pinned objects, lookup,
+	   update and delete map elements.  Only specific BPF map types
+	   are permitted - (per-cpu) array maps, (per-cpu) hash maps,
+	   perf event and ring buffer maps.
+
+	   This allows limited use of the BPF syscall for unprivileged
+	   users; note however that this does not include loading or
+	   attaching BPF programs.  Pinned maps can also specify
+	   pin path permissions to prevent unwanted access.
+
 source "kernel/bpf/preload/Kconfig"
 
 config BPF_LSM
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72e53489165d..951491836bbb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1278,6 +1278,22 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 	return NULL;
 }
 
+static bool map_type_prevent_unprivileged_access(struct bpf_map *map)
+{
+#ifdef CONFIG_BPF_UNPRIV_MAP_ACCESS
+	return sysctl_unprivileged_bpf_disabled && !bpf_capable() &&
+	       map->map_type != BPF_MAP_TYPE_ARRAY &&
+	       map->map_type != BPF_MAP_TYPE_HASH &&
+	       map->map_type != BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+	       map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
+	       map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
+	       map->map_type != BPF_MAP_TYPE_RINGBUF;
+#else
+	/* earlier checks prevent unprivileged access */
+	return false;
+#endif
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1313,6 +1329,11 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
+	if (map_type_prevent_unprivileged_access(map)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
@@ -1386,6 +1407,11 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
+	if (map_type_prevent_unprivileged_access(map)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
@@ -1439,6 +1465,11 @@ static int map_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
+	if (map_type_prevent_unprivileged_access(map)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
@@ -1494,6 +1525,11 @@ static int map_get_next_key(union bpf_attr *attr)
 		goto err_put;
 	}
 
+	if (map_type_prevent_unprivileged_access(map)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	if (ukey) {
 		key = __bpf_copy_key(ukey, map->key_size);
 		if (IS_ERR(key)) {
@@ -4863,10 +4899,29 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
+	bool capable;
 	int err;
 
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+	capable = bpf_capable() || !sysctl_unprivileged_bpf_disabled;
+
+#ifdef CONFIG_BPF_UNPRIV_MAP_ACCESS
+	/* A subset of cmds are allowed to unprivileged users, principally to allow
+	 * them to interact with pinned BPF maps to retrieve events, update map
+	 * values etc.  The pinning program can adjust pin path permissions
+	 * to prevent unwanted access by unprivileged users.
+	 */
+	if (!capable &&
+	    cmd != BPF_MAP_LOOKUP_ELEM &&
+	    cmd != BPF_MAP_UPDATE_ELEM &&
+	    cmd != BPF_MAP_DELETE_ELEM &&
+	    cmd != BPF_MAP_GET_NEXT_KEY &&
+	    cmd != BPF_OBJ_GET &&
+	    cmd != BPF_OBJ_GET_INFO_BY_FD)
 		return -EPERM;
+#else
+	if (!capable)
+		return -EPERM;
+#endif
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
-- 
2.27.0

