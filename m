Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0418568929
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiGFNRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 09:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiGFNRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9025F1;
        Wed,  6 Jul 2022 06:17:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Cn4O8005437;
        Wed, 6 Jul 2022 13:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=GdKH0k4TRT/sd5H2bq7kll58kFfSVHHwemhpJGo/qzY=;
 b=NKYL0knNgGTpIM81uz7bx8kf86vnSz6VLjlZIQLpx8L1XMVPwZQ4pOqKd6bM+yKJu6lR
 UDOwld2vq+5ejGtVaRhSB0iH9JQnlFlmyBdkweG+HAuB5gmHAGZLAaJutj+/HdgZKwxy
 pUAeBYvjH8XiQWmJ4hEQhhZlioElA56A4uG+WTwZNpRKFbINv8gUs2TfEc1GmR3rKD1A
 KzmBSn+bMvpNK7qi2pTHAqT8ckRFOWlJmD2CuCotxR4v7pLQGUI2Ge7v2h6ZCucsLeVk
 3XGPmJZlb3mPbSpkC/nIVs/dPWs1NRd8E+v1qzxpGHCsgUFLuHPTT+3IANTPOSDPuDH9 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyswuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266DBM5a038688;
        Wed, 6 Jul 2022 13:16:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud62uk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgKlZY9MxPgK99k+3XC59N7PPeoR+WKhf/1DYFyYAMJV9nbKmqBM0RKCZICsBMeVnwUz+x+P4AlFEZOxyhywVIRzrKwKuaMy05jMXjBnlQ29iOGGvWWMzr4QyIijuJqk0yBRCxndv6Sfo7z61oedSsLN9yl1q3xakqaTLXBdZubtQiGCom18I8wRdnd2dPDelgMIfrpwSrWWSJf8f6S4kCYXEL+OVcLA9uf+40I7MsFOFfcr62utQ/2n+R0GBsRh3NZha4m+arKdVOcs7Rp4TirvUHQNz7CmEsv3dPVFogknCdNADXPjGNw5H/yxCq4erV8RvoAj5Mx2S1+Je+GM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdKH0k4TRT/sd5H2bq7kll58kFfSVHHwemhpJGo/qzY=;
 b=e6eHDoCGfD+p5mGIsEo9lIi5ZSkpRcw8OYftU2ekJDaq+EjN8hApc6a6rpPDI84oZch5wbiLyxR5q9uM2XRQHUBtNRMUGgdRHvuBmbZUfpk5lMg3gmGDUfqnQhgeWOrLTscPZ9JY542CCuNreK0GdNDCCcUj0PMizZpp2ACeci6NQkqALsE1sAa0M0gsUmsFGU6MrUdnLMtHosSNBOj3ng/j89yLz6kK06DcMZSSz3Z2Y6qmslX0Dhel1+9ScywRWFMymG/zA5+qnFSxquOrqPhgpU4hzdZhMFBZpMw40oeJmiidmxHYsXsh0317dSDdM0D8iHmoSMTiqiuLa0D4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdKH0k4TRT/sd5H2bq7kll58kFfSVHHwemhpJGo/qzY=;
 b=DN+LogC1ZJM63ATRBSO0dLs+1uCZpJ/rvyW2QQgZsqkMqEqPkiPQSJCsxrqHwrYF24WFpna38GYBnrncbgVe2pW5t2IgeQV4aEacgHU1nZ3D/QJelim3n708drThPbxR2bjD7gYyoZu4ishfH5yqLZTS1LP9tz3YikNVbt5qVrQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR1001MB2163.namprd10.prod.outlook.com (2603:10b6:405:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 13:16:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 13:16:37 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next 0/2] bpf: add a ksym BPF iterator
Date:   Wed,  6 Jul 2022 14:16:29 +0100
Message-Id: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8bfb84-47d3-4ee0-35af-08da5f51c17f
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymMVoaiykxVawsOQ9/hCksZOifeziI5lZpNHr9wrs8DooLYeam5sQVBXbcHZtBL8sIsCfJ+duwkmucowV+W6vQn5l5YyMJ3dw0rnojNQefF1SokQuc19Bcpgp1kTJcZWxUiUYg78JvB9t5GosRlO53FHWsN7ZiWUB/TSIJuFYr+PEXOOPBBSAZ25qYVW56XizbSmEoxGhx1TzzjtEcW3un3QpcjZFWSe8q3YrCh/ndkl/a1xvl+xJ7b/W/Tsm9b67obuAzasX87TOdVL4hrhjPIfr9P/X4BxdqcLrUljDEQqxhnLkmtQPbSARDvk7SfqdozJ2+OXkt0bbf6iRP7x04HRdOV3ySyxsMyqL5ppY+K3ElIlCgfbvwNRkdfq/dQ0vLgTL+A3fV4z8DqmkdmLkYV8n+2Py6zjXEy53zzdgLeMWy2ygAuJNtjcWNJRwd77BhpYmdcN5J77mVawGKbQkSHy7i86CxipPJu0eV5lg+YyO3UHeR8Lsbr1uOBfSyqE5/AIHHiDQ2E4qw43yiGYojPzjsYBJKThrXgiNBjLD28EV574aE3kmwENppjumGbu2K6gObPIHVmIdOeu2gltjtihsjQBqf7e3eSNjyciJk+ku1GQxte6x/XA8BgpQH7XIkvj8imKr8SK1OG/NCw4Gtyfp8NGR57dY+iqZnpdj0PTFbNRciKqpVWDwk5K6D+rQmzS20Em4zjegN30cmpIA9tWXMoRjnJiPuCoKJVaK4SGKRVcvv/J/ASE1Z/m/V4Y67vqFM4xDPh5KNQdov/mk/Z/OS/FPFB1RS8QWnAmslYgEG86N10aOQYJM2Y7OLrW+yzYCk5xO9eFKZJ3GsmMGdl1oPyrE2LXG0nwLICTyCmoUdZcTNDo5F0jWjMR8mga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(39860400002)(396003)(2906002)(38100700002)(6512007)(26005)(6666004)(2616005)(41300700001)(6506007)(38350700002)(86362001)(186003)(8936002)(52116002)(5660300002)(8676002)(36756003)(44832011)(316002)(4326008)(66946007)(66476007)(7416002)(66556008)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaDKAMyrqm+qwfNHqRlBHpPcERLSt21DfVK7i635Br4cIzr3hv8UIcnkn09g?=
 =?us-ascii?Q?QhLyDltTVgwz6auVDRYENIUaRnq1ABGjYl4mo3JrE2OokLTi3QDQcqiAW2Gn?=
 =?us-ascii?Q?qWU8iQKYrHqBq2EehZUuMOVolcWLD/68UcGARiI49Ks1iAD+oe0mNBkmhvVR?=
 =?us-ascii?Q?Zx3Z9/jhQgxkOR9BWyb9L8QJjDaC2aG7lOVqnCpPRzsT89HHzoKFoN7c1uXl?=
 =?us-ascii?Q?7mKF5HA+rpKZSo9D1TDJMIrf6RZlHYyUBPH9tzFmoZ1l3zzkvyCN8tzTkQgi?=
 =?us-ascii?Q?CrWHX/Q9j8EskVCdzHv68mIfbbOhITu44c+BcD0FXK2Pxse7qnHWc4Okx5jc?=
 =?us-ascii?Q?udFxE5mObEGuq39JHZf2lEqsfCJ7+IDcNEBf2XwXrOiSGXwkuVutJUFcUOps?=
 =?us-ascii?Q?HMcd7JXhgpGSAYqzJzO2UyzoJ6rAI/Xu+wWBdGEdBbnfshTM8StYlx+5b9Fz?=
 =?us-ascii?Q?GAgmXgky9/ZNWC4J3B28HAiXtJy3GxhOIVijICrU71I5deXSr44aUCh8Talp?=
 =?us-ascii?Q?M5K6x3v038qEC4FeYyvEmH9m/JgrCALUGv1E6F81LyYEjQuSoNJR9cIW7HnD?=
 =?us-ascii?Q?JjGSU4AieMfG6YYfi25rF5VsAxD7TZ+4vZ92V7ZOVM6Rs6XseKaSQM+amJvx?=
 =?us-ascii?Q?tIwYGnZ1IuiTdJO+62WgmgA80GHT0B1SCfR7/7o+ZexT06n31aRItEJ0yVZI?=
 =?us-ascii?Q?zOwP21uvl6sO4qQcxrcAIow2g21TVcWyL8Gvwv0D+YK3t3SBN8XZjmpENg4c?=
 =?us-ascii?Q?6+Xbg2ysW4DBC5IL7CJaL++q6hF32+g/nryi0DwcR/eGRtn3DX+MPLUjIivU?=
 =?us-ascii?Q?KuIRhjqiE0Idj58L74pLdWz5gcZUwVwxnEY0OXkmxwf3kQ7p7iwA6zfku+Zc?=
 =?us-ascii?Q?EBJ0klbDKPgoCcKmS/k7EAITFFWsHyO3vLIQNFP4GqkBYsVNNJP5L4r+IYfy?=
 =?us-ascii?Q?+mdR5YCTyMOFSeTyszA4ESKqPtMsx4XOgiVAdTFtfH0C8kiS8WiCqdyuf6Z/?=
 =?us-ascii?Q?ibFJ+xPWcvoWnZbCFRV3W/B8W3xWYLiDyYWP+L9XJD8ZL6GrXCWOF9P6V5yp?=
 =?us-ascii?Q?4XVK4KQCjLNpBnI2m1pyaMaszoMPr4UHi318RR24lZaPUMEZJyh4Oa7UpfSg?=
 =?us-ascii?Q?z8Q4Z2Fd0JloxqpBrZPiN1BNHvWYeHWnejbegvTJVFQ//Ih0qgyCYku6d4vj?=
 =?us-ascii?Q?Ee2B+fxLrUc2fCV4J/kAXwuKUXxwZgtIKESuk+8TPTLe2vEfwK9FzD+9tNqD?=
 =?us-ascii?Q?IIpZyPV+af7CziSKevIouv3FBD7Qx1lKjC3vgxU8HiyzJqZvQxzuBqthkdcq?=
 =?us-ascii?Q?sfZUXOjVrOuYLtW7WElOU/MsewtB2Rr95rc5/BBGeZPbvAWFLDDZZcomQ4pS?=
 =?us-ascii?Q?oUtCwoT+AXjAGa6fuV7+UcwrIkjDXM9UCWYhZgV/aMbAJGopF4fhuEYb+0X2?=
 =?us-ascii?Q?/VFjWWqCMC63DpqwQxRxinZwB7jKkYQEr6QfpoDlIisDHh8tMWVSPFrCUKCp?=
 =?us-ascii?Q?PRNG1/XRUwukdeggw6nAtLRivwR2LlfYF8QN52/qaR9GWEuSJ258bnbgvT1e?=
 =?us-ascii?Q?r0FLsHVoaomq3cbtGyHPltO6T8aOC6Cb6bfLEQfZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bfb84-47d3-4ee0-35af-08da5f51c17f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 13:16:37.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldI6HV/+UspNUDiLVZajxvqIC8VoDCW3nirKNdZPgTb403fiRwZOyyVtCZpRtyFLQP2ngn4Kcd1f7ZMJ98BMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2163
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=904
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060052
X-Proofpoint-ORIG-GUID: xdK5r0cwZKZ5XTiGcDX3plfjn3NejOkx
X-Proofpoint-GUID: xdK5r0cwZKZ5XTiGcDX3plfjn3NejOkx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

a ksym BPF iterator would be useful as it would allow more flexible
interactions with kernel symbols than are currently supported; it could
for example create more efficient map representations for lookup,
speed up symbol resolution etc.

The idea was initially discussed here [1].

Changes since v3 [2]:

- use late_initcall() to register iter; means we are both consistent
  with other iters and can encapsulate all iter-specific code in
  kallsyms.c in CONFIG_BPF_SYSCALL (Alexei, Yonghong, patch 1).

Changes since v2 [3]:

- set iter->show_value on initialization based on current creds
  and use it in selftest to determine if we show values
  (Yonghong, patches 1/2)
- inline iter registration into kallsyms_init (Yonghong, patch 1)

Changes since RFC [4]:

- change name of iterator (and associated structures/fields) to "ksym"
  (Andrii, patches 1, 2)
- remove dependency on CONFIG_PROC_FS; it was used for other BPF
  iterators, and I assumed it was needed because of seq ops but I
  don't think it is required on digging futher (Andrii, patch 1)

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
[2] https://lore.kernel.org/bpf/1656942916-13491-1-git-send-email-alan.maguire@oracle.com
[3] https://lore.kernel.org/bpf/1656667620-18718-1-git-send-email-alan.maguire@oracle.com/
[4] https://lore.kernel.org/all/1656089118-577-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (2):
  bpf: add a ksym BPF iterator
  selftests/bpf: add a ksym iter subtest

 kernel/kallsyms.c                                 | 95 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 ++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

-- 
1.8.3.1

