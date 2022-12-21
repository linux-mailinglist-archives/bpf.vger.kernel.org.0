Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B7653600
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLUSSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 13:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUSSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 13:18:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F6BC4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:18:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHEEkt002594;
        Wed, 21 Dec 2022 18:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lb1n7U4uhLWgOzeB0FQaSvvk+FqhEwM+60GTgCa1smc=;
 b=YeRAaGSbjZ5YJVikedglSo/g7EmSNn7HudqZQTmTSHiPD+Q8DrssUJyJDHmIy4g/MKFV
 6m1MEcIObTOk0wJjFbgD3sem6ttfBYTi9Axc1bd7C75ZPyBnex3mfISKEsgyhry2sAyR
 G4PhM+K4SOghMh67Ah80zlEO2qjyqp0I7HQQNWcLlu2MnGgUIYQnHoHnpF6V7/7jkZc+
 6UUOJStJoHktUt9r52unjqyIhKrjHxLfM8jI8z5n+AgkG4QvbFz+8xDoNcdp5KVaagCq
 I/RrKPe6QlgaNsQE0PoKmPeYy5PFuF9bOjQgSeCxDEULIgnjZse/CbFlVxjVx5ijyucF PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpsr7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:18:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLI2ZIP008122;
        Wed, 21 Dec 2022 18:18:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47e0v37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbxgvcrSiBT4EiGEGA0d4oi6yBnM3Ex/7m9PTubLgQnEW1pehCCU62SfLA25yzx38aJuZoewJf8TJuiEktALjhL+WHyg9Ym775KAT+9u9FXkAe3Xf42PISKaLSDtj44Et//GZmplakBm4qMDe9W6NakD9EV4SAf/5FUWNZK6PEmSkSuE/nZtGUf4a2ubXgee68J52eL2rdCPvgeZisCM+sRfvO/kvUiIIYOT9sKOjJrfc+CFkYXXpccO0gs9bNPKvXihJ8vWzfvwSvKst34jTfBYi/G6Evje6wpltbpB/bTU4CFro6NM7lpgfYymN48kd6y6HGFEdQxGOilq75M37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb1n7U4uhLWgOzeB0FQaSvvk+FqhEwM+60GTgCa1smc=;
 b=FfvLOtFzUkV1wng32f+2WcWe9HuJH/rJYP7kMvJk4S14p5tyaLjzsfV3/Y2NBJR6eWsu+eGypI3NTfRV9KzkZtaHrRPhEZ1LI8QKpkpFiReBIO6J5Hr6gaMvwg/6NdUh1ECX7mK9vtE90Jo9Tdr2UtdVC1weiIzYHZHvTPryw90Jof1pGu+zDwkO1dEUidQXb1SMof3zMOouVVtmwUGE3Buu/SV2Ysgp8z2ogUuCiUKbEvdb4dE9xnf+FckZXsM7uuxUtK8vBedEpqfeO0ZVw1P+BA5j6s5SBhgbJBvGBLKQecb1MiepCJpd3lSfyV0jmwcJleGLZgfADgmbOGpEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb1n7U4uhLWgOzeB0FQaSvvk+FqhEwM+60GTgCa1smc=;
 b=I+P3D7ixKsDKgyW+wGimo1GQ8YTRlJjb+lz923yw00m1hF3Vw4eJDDbMcRqZPmak8jnOTrfwcTxqiMIXNaiZmX+EKUgPfjm0unTpPx9mrQ9t5J02SOdlvSWeJXMA+mH/zUC/A0/5BNX6bn2AAhxgsuVL7kGZ5U4v1S/LGTYg0I8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:18:33 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:18:32 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     SuHsueyu <anolasc13@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Support for gcc
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
Date:   Wed, 21 Dec 2022 19:22:39 +0100
In-Reply-To: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
        (SuHsueyu's message of "Tue, 20 Dec 2022 19:45:31 +0800")
Message-ID: <871qosy5u8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::34) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 536212d3-bfa9-43cc-b626-08dae37fc4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqFTJaOSwnkAbsAsgmqHjJXA5OQ0ccGFSt1+fmyvXyUebxb6+39JpNYjOjGxvUQqpy+eIRcBhhVagexSZQpXYWBKrBgvotYkpgWrSG9uod3N2HeC4cvZd2AkAHFPkX2+OByo7TffTm8vus5FpQho8NDLCQqDZkhDtVBSsL6aXo8V5jb1phi4IZvuGy10HTJ2dP2mTR1NygKQSbc98HsgUsboqfAGo0BYdvGUqdM1E+YhaRy0T6BtubrIWM1/6vsCzFiS6gjDR5o2MeANPSZW0wQldpqTW4n3OKmMxHyi1exot6tSWUVTSgZuRl4aTEANE1Y1e6kBvLrWqpuZObAHV4w7ayBwL14or6Vp/uVykjMFb3rn2+HNgx/26XKbOLgaQcLMhD/b7Xs/yVtG5b4927Gc4uW3UxWdLr7zZ2eWiX9qiy/OOZpWwR9vhxwa5vJT/IEa0G162vUYNYE+zbemYtkKqj7um7z2Z1V5nQLjCKkdAm67G6pHpwCrXO3S64vUG0dgBvSEQwZQrQSL13crHTUHF0oa0/7nkz/kc38+G8MR9C6PG3c6KjkMU5V1jLb10P0Kxx8EaHIdw4ECbk/iGXAMEukOwLucWUTGHhenfOq8CVuITGb/gqpRuC8+g+6mN2jgWzfRqU3XXtzvjSBUpKN+HU5Kp86jSNF83nBT//8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(478600001)(966005)(6486002)(186003)(6506007)(26005)(2616005)(6512007)(6916009)(66476007)(86362001)(316002)(66556008)(66946007)(36756003)(3480700007)(83380400001)(38100700002)(4326008)(41300700001)(8676002)(7116003)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Gt83jFiDkSxx1057i46IRHltC5fessPTDgOpQGTAA3N66ghoa7FeGYmwBNl?=
 =?us-ascii?Q?sKtNvDp02ooGWQvW2KkxXYxbtGrVZmKj0h3MpfinxvjSq5A4IAgKLDCqKE2/?=
 =?us-ascii?Q?+bCSgrdhMPxEXxqywkBszhgavdMPko8IDXq2mZnOLzsZdPaAc1DZ17TB8UW2?=
 =?us-ascii?Q?D/Ip9t6LhVpXfnvhloyghVntPqAUs52dleFG5gxhvn8OGivKEl9EjO12Q7Qf?=
 =?us-ascii?Q?5BAIhtVN7eYPTWOJl/OaUzlSEL7PvLk2PhBfxiao0ezDjEMHTEzEuvTWoElC?=
 =?us-ascii?Q?pghnxeMVpVMCbU/hqIj0coKX5KexQsUdk84ih2fn2nS18GEdsquRSgvlLfwe?=
 =?us-ascii?Q?0j5J0l58DZTxgDjB/V98ZOcQfdDAiuE/0HwNiysZfecPtSaeD/O6g0mEGtP6?=
 =?us-ascii?Q?B1f7W3BVk76q9XShmUgptK3GSPv2/iT084fU/proqt29XihEpzNmRoCd4Ax6?=
 =?us-ascii?Q?OxOIgLlSjI2DEmQOB3tI4XuA6MUa67NfPfP8IzbzqDnBfejLXsfOh4Wj/1I4?=
 =?us-ascii?Q?du+o7A/0FsChy6GQ+dXVYpOmbzeus8tzxLrEhb1wrIQ9fjflUg0bm+Z7o6eZ?=
 =?us-ascii?Q?3Ijf5qvHeJdrSP0BDSbzW4D7Ve/yQBQMRRUQbEEIuQaWSlJxtRjfQjbJ8AEd?=
 =?us-ascii?Q?4KTOmeJdvufboWCo3W9DOLpQl/MyOzHAgGi2O7zRhWBJralgRgg71BwP4rD6?=
 =?us-ascii?Q?PccBmRdseNsxllvTOfJ9T525ggC9ruMXe5+nJp+vSZ7Dn0P2xCWR16jefEiQ?=
 =?us-ascii?Q?P1gIfBw4vTdNWQGcE9E1N+mozC/0YNwEjM7XbbFwI+34dcqSbpLN56dNWuHU?=
 =?us-ascii?Q?lYx0FM+u7fg0tWNIbHg//GcPjNS9Y6N8R/urvzkmcYpsXQJROPswmoqM6er9?=
 =?us-ascii?Q?OYWm2MekSDIDRftR8l9hDoZRPEcF+Tvebfk2EV6hwPVOeZmBMgU1U1BCt6P3?=
 =?us-ascii?Q?T9U0hlYScX0fdtnNSN3VbjsdeoafGbCLzAU4TnYh5NNgUVsH9vvOdxTO8TOc?=
 =?us-ascii?Q?mYB79OSxvLDHKsjDeOXZpDXmrgmWZZTJX1w7beY2sP9jAB4Lq3pSSww2/Cua?=
 =?us-ascii?Q?mTBbxNVZW33AivJik82nis+1HxiIq4HQ+JiWOp3PnYDFgG7lGbXDabPu6Zwo?=
 =?us-ascii?Q?wLpIEIy4+IcSOs2tPDGAIAbUhYDzVjkYAu5zN7B0M7+mkjJ2UO/yZS99Uhtc?=
 =?us-ascii?Q?ehuOvEEc7BWOdFu+PCqqYOc7vzp1mFz4Y7KNDAw7v/bRL0myQWishOzG46r5?=
 =?us-ascii?Q?E3s2DYBq1OVRTP29RoqsNmEegS5GrzHDzTL6bLIOIyfdfwne2YjScqpzvETE?=
 =?us-ascii?Q?WoDMlu01w1hjoPPejAc1LCa6bleJH0jeViL1OAr922U3VrkTpoEcwv5MhSGM?=
 =?us-ascii?Q?FR+NC4qL6bg9AXn2vP9Vrw2s8hSRs2zUNw6Zs5K5oadjaXOE4V13FFQfRg+h?=
 =?us-ascii?Q?jTLB0AGS6EptwwEYI3EYXEM78bF8qfV0dLvgDgn7cYGMcWv0I/YzJRgSMkK0?=
 =?us-ascii?Q?dQ2WHB9jBtbYkrPSrEIOuJ5V5+FbiBENTEJ2PMGHqdh95qrXMCMQ7ZR/EoGs?=
 =?us-ascii?Q?S3C6uj3nnGoKFBaHH5dk9t+lqve89wu/rDsbtxCESzCDiYfgmTruhdWHiMfb?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536212d3-bfa9-43cc-b626-08dae37fc4b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 18:18:32.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs9rR4u1qP4pv4k/BN45nq8aTeNhFavdWnK6smls12e/fXpN1xEoFQyhx/SXsV5g7pkyDRMwr6kmkWcrFcfmsNCDgxxEZDX8It/3rCTfh2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210155
X-Proofpoint-ORIG-GUID: FBWevPjkQ1SbzqVxRvDHPUOowd9FMznc
X-Proofpoint-GUID: FBWevPjkQ1SbzqVxRvDHPUOowd9FMznc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Hello, I use gcc 12.1.0 to compile a source file:
> t.c
> struct t {
>   int a:2;
>   int b:3;
>   int c:2;
> } g;
> with gcc -c -gbtf t.c
> and try to use libbpf API btf__parse_split, bpf_object__open, and
> bpf_object__open to parse and load into the kernel, but it failed with
> "libbpf: elf: /path/to/t.o is not a valid eBPF object file".
>
> Is it wrong for me to do so? Due to some constraint, I cannot use
> clang but gcc. How to parse and load gcc compiled object file with
> libbpf?

It seems to me that you are most likely using a GCC targetted at your
local architecture (x86_64-linux-gnu perhaps?) instead of
bpf-unknown-none.

(Note that GCC can generate BTF for any target, not just BPF.)

So you need a bpf-unknown-none-gcc toolchain.
You can either:

a) Install a pre-compiled cross available in your distro.
   Debian ships gcc-bpf, for example.  See
   https://gcc.gnu.org/wiki/BPFBackEnd for a list.

or,

b) Build crossed versions of binutils and gcc, configuring with
   --target=bpf-unknown-none.

or,

c) Use crosstool-ng to build a GCC BPF cross.  We recently added support
   for bpf-unknown-none there.

Hope this helps.
