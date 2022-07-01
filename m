Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28707563008
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiGAJ2C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiGAJ1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:27:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468A192BC;
        Fri,  1 Jul 2022 02:27:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619HQCK003301;
        Fri, 1 Jul 2022 09:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=WC8e2dY3nkWVkLM10BghkE3k5oVYQq6il5T4VfHiJgw=;
 b=R+UQaAsfnmtHq4vUCB0tZ8uXAuax+NJr7V+Ex5bujaeCWGB7r7h2G4fkhYy+fdC/jeZo
 LRWIBVz/l2wTX1keCbunng3YOe+4xaJdR4YCU0fD2txn3DQcHcfREAQdPcnUkGNdqAq1
 x32SraUFqe8R290b+mSCVZXu2iqsjl/wvpuE535yMzlmJB/FeSi13hrPHeNXsPF0EbnS
 hBko/AzxK8UBOafTYBWW/7WEwORt0Xub1JvNbdjr3dNR2Zi3MEs63XGp5feNieDp03e/
 F4ZPDluSJWup+O0tOiEC7N9cLNZ0o/VoYBwhhTXSVq9FntBV1NgImL9/lHWmctugl7iF JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscpd61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2619LGMC026259;
        Fri, 1 Jul 2022 09:27:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtat9s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgHiPXmM0bwXr9vDvVndUv1h6K8aX08WIIBXYYORj89be2NHfgDSwh6rIIc1RwNniFY1+/I64Nq3/keor3IMJa50A6O39r1A4JWDd3JTEKQqINmQIsLYcoaln66bJtnRDJ8w3ZRgKJAvBHsqz9Kj+wLh4OOQNSQ6efxy6rrnupmsQBAjYIkMx791iw4+M2Zmyley2YGLEelPxknJB8C8AbCPF1LSDDx0nR2RShFYDnVOmcmvmLwBeROx67tVxyapNYqMPaiaVBMF1afTc/HWg13muFt7xbjRg/Syhwhnn7xZ/HgkbXkLSmD2rZA2qGCEENuxJLw4hw2ccBy6lkJHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC8e2dY3nkWVkLM10BghkE3k5oVYQq6il5T4VfHiJgw=;
 b=XzjgDYziSd7dS/+9rIsPPWPyNBXpBwhON2qWPfrmLutTO9kSOgDIBD+K4Lj6ms8yuuzfRbCB1JhWUDRAMDKTiv/2kNYNVnjOCe06KpawyO2hnX1DiGObH1UtmGfirwdZpN2+sXhhIToGqT3v+LS5zzmjy5rGP8FInalVx8agvAFZo2avf11411de9aPSL5zRcrJu5KY3HhRdhgVIJDm8Aspl3BxRYwk1JGLpIknqeNXJcFKz3n7ybFa2s00ayMyYJNPIQ3Fuafy3UyIbtlG8BRFu4bVI1AD2ymm/zwdNqwCamDA0ClHowUxGuG0P/iVMoTw70THUKiC5HEX2S6AZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC8e2dY3nkWVkLM10BghkE3k5oVYQq6il5T4VfHiJgw=;
 b=rcDtdrIbG/2egVGiQn6aooAue2PRL4sJbXUMyD9BCF6kiFcy6d5rV/V2SQNZ2mtpQMGEuyBFYJit8DI0Yu3OPLR9gYTm2P5VyoLprEVyr3DdlcGwLEGGIhgNofkE7+Q8gxDfmWOWym6bFDmQ1t7IHRRuyOBNQH8N5gJO7egaM0M=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 MN2PR10MB3951.namprd10.prod.outlook.com (2603:10b6:208:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:27:06 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c%4]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 09:27:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/2] bpf: add a ksym BPF iterator
Date:   Fri,  1 Jul 2022 10:26:58 +0100
Message-Id: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179ad253-db52-47b0-5afb-08da5b43dd37
X-MS-TrafficTypeDiagnostic: MN2PR10MB3951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqPU5iK+NvFoi4mxwej6fOn/eglmuxZkxjeDUMtxFnEo8lPvibpzB/R1J4ywt4WIn8y98LSPmU8l9nRdUwTGC5XrQVqyg0Ld/VE7CmjGxLhSCcpT+XNRVqQjvxrwjtkRV0Qi8kexY4rlagCuYIuhlBJgjA9EsESP9MtSCXieRAWH4y69w1y+Cv43tB76s8t+gJQnC8iU5p3UZncUngqDqDKO4hvXIIcgPH7lEGihKT5ls6NL+kan4/xMgTUBx+1eoAtXALcBPYor20H3OOYcVJR2Hz8Q84LhsoGRCOzmQxtrajyupJhfhzq9XwUniblmQN6VJ32Jt5xtWrKl3CFfeWxWWkFteUY+/eFZdP8xlv/0ew4xUGlTogRmH9aL9KYYawH7tpJatpss1YxaWmDOKVaKXDwxRf+asU9G7Y5lG3o+74KDmcNMNpxMhYH5d0S5hKpFWnC+ib27RygV92mIPXnny+RTybBBgPD49rqNcyWM6QehMkT+bXSphEOqebbELJtGn7hLEuyz7lMkBPYYV4uLCfruucuWUURmzqMtLZ7nVoQxiwNLG+A27Rad4hvLeo5nv7AfgydxvNXWGoDXT8OuyUhDinLG1evG5A3YuMrCutxr3jIYfQOACwUhyIRMflZwvU3ZiCXrcebQ6v72fgOM+O3m5y0YBuTcaI7WXvceI0aVX7afagfYWahvk/YsJWrDefis1VSG5wHnIL2nzmuxYGym9A5V+ny8fIZPB/Xmc3D8G6H4LmWI+kaQVkyRMmbD4rZHdCWvQ4pu/ykOruNk2KQsw23zNIKasPb12JNkXeFGS3/YLSwxwSZRzxzGPZn4AcKypOJdsHmMt3T8ZhH3cKO82+EKiqCyMV6IKGIrf32P+GdeBZoxxYMo1v0t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(5660300002)(2906002)(86362001)(316002)(66556008)(66476007)(66946007)(6666004)(8936002)(8676002)(26005)(4326008)(38100700002)(38350700002)(41300700001)(6486002)(186003)(6512007)(2616005)(36756003)(478600001)(966005)(7416002)(44832011)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBV5n3poD3IvEjC9UGPkiIP2c+HkQPu2X0vjMOSfhO5j46YwxQt5s+ZykvuB?=
 =?us-ascii?Q?ChhEfFebBsCbjNEHNNbZZZKQ63/DmSLbpjG+RzPhh+zX/vdXZwKqmFRVegta?=
 =?us-ascii?Q?cUl1cCsHxwKdNpltpUXs7HWJsi4xCM5jeQ7nwwBXWTu4gJXsg4F19+69fV3F?=
 =?us-ascii?Q?cmPd8+8IyU1FzCsdhsXBqFSr48GmjAVQLtyn7uIR5cobQ1jfC/Y6jG4eXHXy?=
 =?us-ascii?Q?jlMCzuXtDiKk8oYjukt59gK7XqD5w5dQi2j3H9sf/Pz4vzTB8Ba1S5i3cRoa?=
 =?us-ascii?Q?2ZUUpD5XFoli76H6ct15DF9GeeTsaZJndV7W+narHxkszRS69tkRgQ6cNf6Q?=
 =?us-ascii?Q?1lhk970ZtBFVCILCA+g/ZJxB2msiCJlRV/3tQigOfQdHvRx5Ij7j3Yur4lwM?=
 =?us-ascii?Q?VUHVJVBA2vkIGKPmTMjF74A9vE6z0dsxW2XUwuQLh/Q9h2reh1IFe9pWCZ93?=
 =?us-ascii?Q?jHIWp6DmoRDeNL53W2OPRnrz2RelhmU07Gya/kdLdr3+LgsvsppCfe1i5Hti?=
 =?us-ascii?Q?aTwlhkYhTmgXHgZnhCc8K4chJOkHoGKeK4VowA6642GbGkr1qIXPL1AWJReZ?=
 =?us-ascii?Q?OUlXV0KvbHkzOT3kpjnaStYM/GJFv1QfrfgcEvyii77xuRjidlj0Hfldwhjd?=
 =?us-ascii?Q?yeFTk3w5GhgHdoFK19LQGu8iKt1DLpDm3NWH8TlZuqWMTQOYVaYTEnBC9T2/?=
 =?us-ascii?Q?po91b8fsXaEMxgj0jleJbB+cnMA+9CSQnxzihQxShvZN0EPPrUrcCsyzJgAp?=
 =?us-ascii?Q?DZ+lOep3TIV4BTrF+UmLarYu+28JFkFTa8X4cdlwmZh0fHO2K1GvE0S4XLvL?=
 =?us-ascii?Q?FLywxCGadYFZ12WP5XfPdMuKlHMzVJhwntD2Qs19RWQEvBIbiOovuL70wnMX?=
 =?us-ascii?Q?H2wWneJeF+qdaqp9oQ8vq/qOjxAPUq7Oz0dFoeFEm4oSfRPcGSgfRAVEOf3n?=
 =?us-ascii?Q?p7LmCJE2FaygKlMzyr8J8UriP3P0dObIJ/KhJ1fwvkaWdQoVOurNPNpCc3DD?=
 =?us-ascii?Q?mS7V80RMMMWVlqDSlttrZUiak3VQcO2SQLtgjZagt/Jbq0xITnFyicFa+rI7?=
 =?us-ascii?Q?QpYFp6za8NFssbBUFs5RqEAo9k/80IbG1ruVwv22/3Xin1FtPcYAJco7tD0L?=
 =?us-ascii?Q?XNZ+v0FVi6VHnBrBiAYfgrWvu1lnmyWXkrZqnF8O3YsNZF3PUiSIuqrS4BVz?=
 =?us-ascii?Q?gqtCwm7x4slcn8G6lmkej4nKMlIvFK+j/gozWaAeifZvhAVBGSA5A5XFgT0o?=
 =?us-ascii?Q?dSV4iMkWdOWqOObzRd2HcgoJgF3uLw6QRQ/2T3H4HdJ3AGKKx336VbmkGKKz?=
 =?us-ascii?Q?v+EKKDa0I0rvfee4DJk0PzidPPznlngTIYl3OOWOVwlqCQYxe2RSXzkBS+J7?=
 =?us-ascii?Q?4k6LQ4sIGPrs6gCbO4GaEeytVATgY46xYSuMBYZEFCdTBUKv5E+knIzwkKxX?=
 =?us-ascii?Q?JfUliqVIKuwiLqB44AnO50Imwbrvk4+VWHhdnciDLtzjIi6L/77yq5rDe/w5?=
 =?us-ascii?Q?PtjPW1Ms6cfLyyyViAAr+amvmxCEfqupjmOJmFUDsfuD7YVCJQ8OGeb4G0zS?=
 =?us-ascii?Q?xeMPifCQCocITRqEXagDg3hFj/3PEzPGhcJXlG3T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ad253-db52-47b0-5afb-08da5b43dd37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:27:06.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yj9JRhuT0ie8ZHyDXVF10hd/IbwNmeUTLacCld7ZdKRKP6AbvQeymmv3FtBLJCbK12F5RFlhy0+xZUrW95L0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_06:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=901
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010034
X-Proofpoint-ORIG-GUID: jQFXUDnG2nB9zjfdUrklCMhY3PLnBFyJ
X-Proofpoint-GUID: jQFXUDnG2nB9zjfdUrklCMhY3PLnBFyJ
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

Changes since RFC [2]:

- change name of iterator (and associated structures/fields) to "ksym" 
  (Andrii, patches 1, 2)
- remove dependency on CONFIG_PROC_FS; it was used for other BPF
  iterators, and I assumed it was needed because of seq ops but I
  don't think it is required on digging futher (Andrii, patch 1)

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
[2] https://lore.kernel.org/all/1656089118-577-1-git-send-email-alan.maguire@oracle.com/


Alan Maguire (2):
  bpf: add a ksym BPF iterator
  selftests/bpf: add a ksym iter subtest

 kernel/kallsyms.c                                 | 89 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 ++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 71 ++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

-- 
1.8.3.1

