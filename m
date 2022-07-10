Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254C56D1BB
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJWKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 18:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGJWKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 18:10:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6921A462;
        Sun, 10 Jul 2022 15:10:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AEbk5G013807;
        Sun, 10 Jul 2022 22:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=UvlNghox/nuy5PFR9AHbcJiopFf5sF/XgUHDM/oJobs=;
 b=ctuNKHB5tUy31YtaLBJN4yGyarDzFEXacFri8rpzimqw3jmFq7gjHu2Qc82tp1s2/bY0
 cfCG/jk8yhntXPVdoOP5KdbSUB6in17gRhcb9oWLldZq1teLB9gt+IleVY+F0MLPAUYC
 BGaTFvXYZGf2LEy9ktbBbwkv+OSbXgSJFJGN7XZ8trO3nhGNY0KLjhI3haazV+EbNust
 Xyrtjhw76XqPFnF9YrPfSb56zLt+vjsiDRimMjiE/pG+/v0hefyVrK6itp/caA+wIj2C
 DAByzmHhQsDHOHYHgAMU0RH3v1+QPNANFebLDXONwPGP6+qKAoIAtaqiT9wfC8WurFFO WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sghwtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26AM6XF1001226;
        Sun, 10 Jul 2022 22:10:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704161dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b95uwchMQK4jw/pFep6AdkC3c7ljWT8QJzWdCQhaNxrY78FWNldHJ/wvaZTnj6rB18bWkla6ZHIwDm4hlrf6wreZegDUywBIfOqYTwKZchisw9mgeilECkPJChDeMYfq4rCAJFCK/wVpPxVhtDNmLhFelaHPs/JDXwWoweq44S1ycgXXERbbDDrhcoW9eYzbtsJMfTYShHAkY5yyeqrcV9hpVchK3A4/OYt6wpaJg6jGeyqUPqkCsTTYBmzv/ngwIH+2zAT96JW+6vlyEOHWNyRK7QEqOKhKOEitDV5NnrflsPC79AyFsu9EwE9ARWF0Q5s7JGNXWuQt65bDthap2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvlNghox/nuy5PFR9AHbcJiopFf5sF/XgUHDM/oJobs=;
 b=g41msiyaoV0Li1Ls0ZHa2XgZGphBR4YdYX70i1SVssIY6wAJIxq/QnV31q3wKpy9RkdWodywrKLlzk/IGP8E3AoJCvHA2m4u9UrGLaSs68FjURAvhhd12X1qqcyEFUGK3rUxJoWimzWTJ3eQb5jMQT6p6KcdITH2iTDrv3w/aZRP6fleI89CT9K7JliEL3D9u9E2UFhgNcoAvh4kWM1aBXvhhuWSf4kevTyQZqLty3p+qqwDH4P3diF479kI663acAla1g4NuVsJ48qCkZ7LAVoyKeowYlYTFT7nuQnoD/aezfFS8oHDYtX4Tqg9K+2YzfqIDGQfdOJzN/ohCNuv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvlNghox/nuy5PFR9AHbcJiopFf5sF/XgUHDM/oJobs=;
 b=BiO+NJwLPJGnZVrUUPhl6LI5NMGTSdfFnIVi7qdCkYlUeZcPEhc2UBPI/b+Qyv+gOujy1ZGUBII+phhlrAFJS9Utdxtnp18zGS2ENCpJTJYUQb7ocjYecB6b2Y/VxeZLphpOVycernapf0aeVR1VB1FX/tCDNF5zHjmtqPNO99M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 22:10:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 22:10:03 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 bpf-next 0/2] bpf: add a ksym BPF iterator
Date:   Sun, 10 Jul 2022 23:09:56 +0100
Message-Id: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07cfaa31-2f66-4484-3562-08da62c0f06d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUtFnOsNdNb1hpzl8eGqPu7Msz7BRcR0Z0NfuvUdozq8Lod9Ni8sm347wyC/mIqpk54meDWPdoxL/kT98iw8iRKLKr0LhFHDNp8mmxsd/Ay+ngVVAumy5CwpUf0i3leaMGC08BDAjN3VR1cOXxdnm31UxtPVPQquDoCVgsdSIKcGEXndybWyP7hSPt49Gen1tOkGKrT7Fss4TgK3clrr5+p8IUzKGQcdVyWPkt6nmedJD/n3b2jYcsn2Ztzbc64iYzIUlaG5P5wQcreA0/OCaWOa+Hc5RqUNJpVGaAHhIwWS6DCxu/tciCuRrAOAAaeb+7zWhAVsa7xSRfPoNVyfdbqI8M81DZCv/gTgCWytFoyV57gSEqLBPvPf/+XnIebxddyOuTJl4ANXoLWoxGaJtU2e4J2BywqqkG/p/Jk1YSTtoDtDOITnmIMaddv+FGPMzEeyxybjySVWtqh19sCEG2lkgvTKG9rg2nLy3dDEv8cTsQnrJnbt5+r2EoFii+1pNl78PXj2uPZAgTeszlp6k273FrKtZurdfyKmaet1i3lW4w9OL8XgQOp2+1z2CpQC6t48o0VPIgMlKwwPzp4JsksSNahkSF25454MyJYSjVIYiTGoC2wUoA15Sf045TXCleuqcz0QMg9i88b4JU8+cpB20OvVG2JMx24NJTWmhmWedfv+nHqCZ0+HYevAB3olJ7xQI+bXVuE8Cxc8ahOYjmEc4qF8L7C2p5NVRcE8G7yFHQph8VGYSe9ERiGMA04g9gfrBqiO11AGBU7p6dZCutDp3yxP5gePV8mPZO/l9s7dfmqTr7OlY1Dh6JEKTCAKfuWZ09UKiwl4aI5wxT/MG/fjUS0gb4BjN12fcnmDjjoif55hvpS5qCua2yHten5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(478600001)(6486002)(966005)(44832011)(6666004)(36756003)(4326008)(41300700001)(66946007)(2906002)(8676002)(5660300002)(7416002)(8936002)(316002)(6506007)(2616005)(66556008)(66476007)(6512007)(186003)(26005)(52116002)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6MC6D1bQCRczaYeJgag3lan+pr4dLuCcrymgKac9OoePRdT83W8o0hO4qqK?=
 =?us-ascii?Q?lBlawvda2JQNHvk3FKTNcEgmVTQcy0O6NNxBMvJiqsPzj43ZxdjaCx94CTh7?=
 =?us-ascii?Q?QUGMSHldlTVadq4/dCCOdwnycARJobkDaKWmhTTZ4YSma/oiB837PkHiClfX?=
 =?us-ascii?Q?Mrdq0Cw+OEusHvDVeST0a/LnBgUU5CnvgWoNPC+8+iqDHFsQEK+WAzkrRgFa?=
 =?us-ascii?Q?OuvqcClthyu8jydm4XtBFPkgVfb4v/jzuBy6Eu7WhH2E7rKNhQjcb4yhlSNS?=
 =?us-ascii?Q?5ZsYN7jTbk2pUgxsA71vYiiMtR6UcQuFNJ26gnR1EVfzU+uqIt3ekNO74Tp7?=
 =?us-ascii?Q?zclqtLvubUSjXGayInHZvId9gKrENME4iusNV2MH/TwqglF77ZNhMmb40Hi+?=
 =?us-ascii?Q?bEfWkSfjsh89n42GwkiXx/3jh3G2c3YXx9vX8f1p70K+Vi77jHBQRvhzI/eV?=
 =?us-ascii?Q?IJ9HD+S11TzcSAeYASh8gZb1gC2/Gbr2R7PaowpnhF6wxHMdgIdLTbsFGVXX?=
 =?us-ascii?Q?DNAC0bWfsfuf5YxCfALXZ72QW9BaL4TZgCS4GMcbSRwL4QcUoTSgbWYw6g9m?=
 =?us-ascii?Q?wBME0hUfNvjQwffc/3idCu3s86wpOIi2cVMX6+xyPo3tyRZe52INxBnwQFbE?=
 =?us-ascii?Q?JSJ/F45y6OoOfdrCLpoB8hh0Uc1KH8BoTYGlG5p6bFeet802NLCKENRcVV7I?=
 =?us-ascii?Q?O0j1vHn0DhAZPLYeg5v5/WKvPy8u50x5KWqS/TzCiGHqrhFNZbw0TPvncr3w?=
 =?us-ascii?Q?sxghvH0YvEQcD1vITrAbzQmIFewnkyJ2XdIBJM5HMei3myueXnYLzpDya0fC?=
 =?us-ascii?Q?QwLCSl1x/JwjCdzDwI4LtBWsrUpEu+uneOKLAG97oMZxXNC6cjH7qhNvA4FO?=
 =?us-ascii?Q?llUWZxLrun+24wD56KjqLk28BE9FQwUHgiWsqGCn0R8/M2eo9Rk/KXQqLh5E?=
 =?us-ascii?Q?Yp+omPPDEG7Y3ubYe/CxM1pPAbAM8+VBplfilOvpC1mNQU+FZ4LVHrUj6G2f?=
 =?us-ascii?Q?fTMiDEEUdd18mawuq2qx8EvRSRqf9KZsZd07EBSOUm/9tbg42JmC9JkPjleY?=
 =?us-ascii?Q?b5G47WnkRZ4/BbI7Os8COpfCELAOvR0PMjyQ+Sp37sGMGHYjqSwJSE8aXhhV?=
 =?us-ascii?Q?P8xxaWkVVyETzTZ/6T51tfxxtp2X9Ibnr7Tjs0JyRDUyvk1JnXlgbtw1Q1Zm?=
 =?us-ascii?Q?fhSx1s8TrPpfH7FZDlk9cc501+BqwV97GtWO0AdlfT19zf/yScWYrHM9lQOU?=
 =?us-ascii?Q?qtaJMeO9/fFSwSdGlE/X1q0jzDdrrwPAmGzEe3tJfvP4F9PgPZfWVF4P7L0E?=
 =?us-ascii?Q?nA9r1XMSM1RyTHA7nLHScahonEZG2NOVis1fIPlcwOBhB8jZswNs2pnqaB0t?=
 =?us-ascii?Q?0lU86ITLCyCEUdI5SMwtlevRzRbALDloDHxB3Z2Sci7/yO8b13sjj+DnNirs?=
 =?us-ascii?Q?X8WadmDGLBQAKh8YziXGhWxQw7R+aDJxIIm3UqaXwJ6l1Jhivq3QC520gOgq?=
 =?us-ascii?Q?fJUbzAtb5ox9sE8lJGiMiuRTGXhHtuoERBkrO4TS/Jiw+k1pCELjKL8dVAkC?=
 =?us-ascii?Q?srt2mA0SoBGJm0eeg2Jjgc6jukVHgxCZmKngGvGW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cfaa31-2f66-4484-3562-08da62c0f06d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 22:10:03.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV4y4nNa2Mt5oCLlzjkfJNn3AmH2lb5gyqw7T/pkQmJM+cRwNDAKd3Rl6FfT5U/15lcHpN4zCd5jXdZ1Iu2tWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-10_18:2022-07-08,2022-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=754 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207100102
X-Proofpoint-GUID: gpCWj-_3v4dtSeVfUXU4Xv_Xok8etHrH
X-Proofpoint-ORIG-GUID: gpCWj-_3v4dtSeVfUXU4Xv_Xok8etHrH
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

Changes since v4 [2]:

- add BPF_ITER_RESCHED to improve responsiveness (Hao, patch 1)
- remove pr_warn to be consistent with other iterators (Andrii, patch 1)
- add definitions to bpf_iter.h to ensure iter tests build on older
  kernels (Andrii, patch 2)

Changes since v3 [3]:

- use late_initcall() to register iter; means we are both consistent
  with other iters and can encapsulate all iter-specific code in
  kallsyms.c in CONFIG_BPF_SYSCALL (Alexei, Yonghong, patch 1).

Changes since v2 [4]:

- set iter->show_value on initialization based on current creds
  and use it in selftest to determine if we show values
  (Yonghong, patches 1/2)
- inline iter registration into kallsyms_init (Yonghong, patch 1)

Changes since RFC [5]:

- change name of iterator (and associated structures/fields) to "ksym"
  (Andrii, patches 1, 2)
- remove dependency on CONFIG_PROC_FS; it was used for other BPF
  iterators, and I assumed it was needed because of seq ops but I
  don't think it is required on digging futher (Andrii, patch 1)

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
[2] https://lore.kernel.org/bpf/1657113391-5624-1-git-send-email-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/1656942916-13491-1-git-send-email-alan.maguire@oracle.com
[4] https://lore.kernel.org/bpf/1656667620-18718-1-git-send-email-alan.maguire@oracle.com/
[5] https://lore.kernel.org/all/1656089118-577-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (2):
  bpf: add a ksym BPF iterator
  selftests/bpf: add a ksym iter subtest

 kernel/kallsyms.c                                 | 91 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 ++++
 tools/testing/selftests/bpf/progs/bpf_iter.h      | 32 ++++++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 ++++++++++++++++++
 4 files changed, 213 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

-- 
1.8.3.1

