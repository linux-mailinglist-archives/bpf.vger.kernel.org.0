Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419F6336BC8
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 06:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCKF51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 00:57:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229812AbhCKF47 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Mar 2021 00:56:59 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12B5mFOL012983;
        Wed, 10 Mar 2021 21:56:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=n8KHcQIZaZLZJ3r//5Cug1hX9F4RI3FdI82/whKO204=;
 b=L6jvHyCOchaSaJUz2QJIdhIcfKqQiWuhcNWgvDj0QU8teIdi46yjqDSoMXXkCJMOgPcZ
 WEyDXe428nAShHm/qZURuSu+WEfZsYIgIq34VjnhkDve8+jXBMo6ldt6mmeHEeF4+byJ
 PDzqM75HvPYoor2z4mioxWxYZeQiDqwtO5o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 376dq2suux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 21:56:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 21:56:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2cxHX/DLIQGdxCwyFpxQtFFuim6fiTRdPSyXnduLyNvn1PgHXmqvY45SBudaQetdT1iIyjEVDkSUW3VALrlK9fwoBGcAcPjtM2SV7RuUyVVBTXxALf5TU27MVdJKd07WVwmu8Yaiksw1RxQIleuRnvi5Rxp2HyhDKIpu+wLe6TI8Eu9ZED0i4dHl5vS2mJyKR4ooLWtxH96woEUS+a1G1UjK/8O4mb5PBBYFq9UctfgHsgVMwLNMMRSpDQfjPryU99k82j9n+wNDALcf8cdlgGsAZwey6CV4GjutCwk1WnJVZuNbFHtiH9e+0R0K423Lo5+lUdaBhPz2mqUI6cTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8KHcQIZaZLZJ3r//5Cug1hX9F4RI3FdI82/whKO204=;
 b=V01k8dXpXRN5yLhG/Amaf8P/9ZXeV4V/T3h/tGJr3v0MzXlTiQEo8NpsKLMQ6b+F7D2UwZFchjf/QRaMZmjG/vwOfzzLmx9zQRTi1Ro0wOT3ztZAT2VqTxBrSIXrVefjDfjXhfkwP3C8E0Ug8j00cTwcnrTkjOtDy7eLPImLTRTqiCxZqtn9l60W8DQMVjvpOeil5fY+NsynIbo96LtKvqQiJggwhQuBgjvCbhNFNVgw1NfEVuLYtc5bNTnFcUmGDre0x7EzupDGpFnCxDcCtJwx8xT+9AeMbsZhMWuMRCw0PZ8107qv+ktGRe8k92GIcQLubLKzCKDL8mc9tYEogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2581.namprd15.prod.outlook.com (2603:10b6:a03:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 05:56:41 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 05:56:41 +0000
Date:   Wed, 10 Mar 2021 21:56:38 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Manu Bretelle <chantra@fb.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: Add getter and setter for SO_REUSEPORT through
 bpf_{g,s}etsockopt
Message-ID: <20210311055638.ycmgqgirbhioltij@kafai-mbp.dhcp.thefacebook.com>
References: <20210310182305.1910312-1-chantra@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210310182305.1910312-1-chantra@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:6752]
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:6752) by SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 05:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2074f8ed-b1af-4ba6-b4a9-08d8e45270dd
X-MS-TrafficTypeDiagnostic: BYAPR15MB2581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25813A52C7B7183C6A98B527D5909@BYAPR15MB2581.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lzBR7pyXmQUNz06vLIoooyRN+V28DhDwLr0hcRSL/MkKQ69++MPONSa8Hd9NLm2ZMZuJWLYucaZM+tACxB9rQkRsjH3Oi8ScFNIw+09b7JGbqTNVIOXpsMncq4RsubqK2CKeSWNerYJkqDlqHYwzuE+e+yT52OFebRu8ERpHS4FTGxRDQPg1RP0Ra0r3PbeFMoDkH9/JkU8Emikde1aiV3Wl3pUE3VJFkwxR/79xYwr9xV30PjZOHmQNVgH+RAjw0WZ0UoJXABQHtZFEaP+hwCFextH61aSGEIc4zKt8V3RJvZPIvrxiP77NiT/xDdYuNDnwrw++MKxEnBgXrZ7JR1Pr4JODiuKu/FvvYwdJSPXT91/Nj8sCscHWSGduFsWpAN5FmIgu1wLGZysx7aTp74s1PSokIiYsZBzgwdNa1BNjQUyQv2xJ1t/T10fm5n9g4DbAmCO9L1LHogcb6Skx0hwFmOc9m2tcgIKrFh5zWNqyx1b+0zdxRgADgbHphYrCz7gmwCL7hK/rNNaAlIJjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(3716004)(186003)(16526019)(66476007)(2906002)(66556008)(66946007)(83380400001)(478600001)(8676002)(8936002)(6506007)(316002)(7696005)(5660300002)(52116002)(6636002)(54906003)(6862004)(1076003)(86362001)(4744005)(55016002)(9686003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D9Q6/8lyqT2YSBTXApMBjZ8twZThiRCFOKZlv27TLTBAklClVkyrysA/tszs?=
 =?us-ascii?Q?sx5LAIQebtTrHSPLSll3kZ7C6IlBeggb6nccl08vkCc4rIHbKMkSp8dSURpI?=
 =?us-ascii?Q?foA4JoeNPyvbPbfRzivVJ5kI3eeF6TK6QwBBpyidLc69j+4U5o1bnpUI/aR0?=
 =?us-ascii?Q?tCvvwGmOIrOok/Avn/y4jg7PeAxpaAdeNOanH1uqoCpF/oOSzStRwQt+JUWj?=
 =?us-ascii?Q?ER91o4zH76fHpacdnWJV/JPJV6N6LLkk7FKnpWnZ6GX6XAfziS3NFDZM5I3n?=
 =?us-ascii?Q?MyqBGcPD2mNZxStv9xAgjLaKMn1JEi+5+3cQ5JKJmOiXmfc014Rd/8tgx+R+?=
 =?us-ascii?Q?I51X/vwPniZNg0m21Ym4C/p6LapQ+pRUwNjg4pSuwkyV0CDT+xoRlNno18vP?=
 =?us-ascii?Q?z4eeydWCn8BtwTSjWWUCx3+KY6DQXWF2RA1Tx68Wxtf9A4XSp2m9FqWrdVcr?=
 =?us-ascii?Q?roK8gA5w5BTSMlaamgUuZ7nNP3mJkyqfEHJ1dkrrSW7tAc80lsU7v0Dkc51C?=
 =?us-ascii?Q?gBAFDigNa+nCPMl+6J699G/YGzUA/iW2GxJ1e3md0Ks+mliu+7ZV3561M7zN?=
 =?us-ascii?Q?U7Zpz8aOp2uQY6A8O9lLt7DiVfQkNm0Ga0HhJ84jv7SFXbYVtUvzutyerQuj?=
 =?us-ascii?Q?q4qdNDwwTDUSL1msBExFixzluvd74jvAZyPT/WzmFqV7ImeFaZmK3CsPAC0j?=
 =?us-ascii?Q?lbrz3VusLmTIdZJzFo1dEEJ7nwsKZcSJC/CWikf4gyZZ8QHTg56PHFX30Xv/?=
 =?us-ascii?Q?4xJgvEfVYkpbqBZvlMl6FUYldjtbZuykSEm8lqNWkqlTibKVHCiH7Sd+ilMb?=
 =?us-ascii?Q?XMgPUKMepZ9+O/rq7kBv3Q0OaMmPvGGMMynmpOdidm2v5zCo2CB1mYQXhhRq?=
 =?us-ascii?Q?vNWXPU0m5W/llAojW/3LaR5K79SgnV1T3tkQ9GT6kqCv5IF7/BFNRfFpaOAF?=
 =?us-ascii?Q?XOiFn5LIUXStTvyuPwgjC3A1XXfA35uJ/bmXG2/NUfitX/+R0vZu4LNNCgWe?=
 =?us-ascii?Q?WgRU+s2XpgrAkMDrjOSOEvTyG/IiTzLtTgDK+1MPv+Sq9LvalQ5tYHX8qfZx?=
 =?us-ascii?Q?zMjfkO3lFoMfDvtJ1ZphJKLFsNdeCkgDilhLMsFHckLsY1gAy/WEMgu1V967?=
 =?us-ascii?Q?96NetF04O8iX3MqGJQMOvZi0aI5r02yF2e3O76hqabQl/g8XCeA0KD/4x59A?=
 =?us-ascii?Q?lPOa+EnhMEXbMCqrukegFTSIINWILIR7uU4FUawwkOrDy6fvDrJkq0TUU2L0?=
 =?us-ascii?Q?Dj7gugvMgBiOybE/YUaoHkeA+v+JVq+38EQ6xAnKBsoL2pjLz990zmFtF+xj?=
 =?us-ascii?Q?e3XAaOFy5pToVywq36xoR6xpEc0MoofIZNt1ze9K+W2fNA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2074f8ed-b1af-4ba6-b4a9-08d8e45270dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 05:56:41.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtTwAeRjMf6C6KFfJjca3rLuxzFMH7MYNziWnjbZ3De5X8p/VtudNaYoo1xHdfu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2581
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_01:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=547 adultscore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103110033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 10:23:05AM -0800, Manu Bretelle wrote:
> Augment the current set of options that are accessible via
> bpf_{g,s}etsockopt to also support SO_REUSEPORT.
Thanks for the patch.

It is for bpf-next.  Please tag the subject line with "bpf-next" in the
future.  Details in Documentation/bpf/bpf_devel_QA.rst.

Acked-by: Martin KaFai Lau <kafai@fb.com>
