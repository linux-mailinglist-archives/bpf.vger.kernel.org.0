Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E557A5333C3
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 01:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiEXXEP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 19:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiEXXEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 19:04:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A31703EC
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 16:04:11 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHW6Pk027355;
        Tue, 24 May 2022 16:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=w7r5lctme8RtEb78zqSF/RsUdeqHRMMVXarMkOSSziw=;
 b=WIePwUb8TUw3kwtd8NxLW/uNQvApwt5v2bHv4iMhStaSIWVylmAZ8PzRPRsbq/gKGdB6
 DJIuZ2WHTHfUyDQxuhYh8KimcfHVYXCTL+5uQ35SPxXwDW9aYlOF5nLh4YDGkErWTSF3
 VGYFSYvcur/dTXRIoCs/djyNIj0aKLuJ2pg= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93uht7b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG5H64aukW0RoDXWNoep2djeGSR7x1uRpWqBd4e9bWhqwIaMODkDynhgFSGR91d2vJ9LLjoUbaEAjGumO0kfGAe7nRRY7APXtm9y+GRUcYkgUPBdZlFoshcZcAz3ITEFaxNzlqaO4ABKWAv85XRPzC9c8jmuRHS0ieYbnW/MciWKSV/THsgDOGp5BRovVcUqmIj2xYrbAVOnp4x0QKI+bC7r42ED5PeLSqOzv2eNwoDbSXBQvptbPYW9Ps3I2m/ZH23ZlcHiwIExt79NwoQiqcBaPuoFEfo/NrAhWLRzRz/Nhf2NchGR6cCugPUIJn0+PooMGke+zndSWeMaseggaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7r5lctme8RtEb78zqSF/RsUdeqHRMMVXarMkOSSziw=;
 b=GAZdzGOYS6xW1W2S/7vYgpS/BeHM3Omfm3CDvBisFm8xstryWnyrQtMHvu8vh9B4LbnRAllJYf8clAW9+SPGO1CV4LXiJalrGaBFnAfr30SGSsC9D0r8eeSVliCPNG9l7vw3zGcyrf+neHnzFw3zrup0yRpVNLzK0mizJb1w3/hnww4HX8IzYRjIrIv6a9G0UVE6JRPVaJoXbWZJFZ83rvXFslsE2HwkgqNhr2FLk28WNLp9+0RopLvLvUefRS7NP1F5GGjCOCirVWtdXMbk+DhCM151s3uqWnEJPhBHPEVMzs7/JUaun0YMEHlPtvD0TJcT51YB78a5NOCarH33pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BY5PR15MB3617.namprd15.prod.outlook.com (2603:10b6:a03:1fc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 23:03:51 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::44a1:2ac9:9ebd:a419]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::44a1:2ac9:9ebd:a419%6]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 23:03:50 +0000
Date:   Tue, 24 May 2022 16:03:48 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Message-ID: <20220524230348.5lkt6ufx6b4nfde6@kafai-mbp>
References: <20220510205923.3206889-1-kuifeng@fb.com>
 <20220510205923.3206889-2-kuifeng@fb.com>
 <20220520205118.cw6g2ozxzub52otf@kafai-mbp>
 <CAEf4BzbxjUqFRcF8qzEnqhJ02GWrqS4ukuEC8m7SnXAPGN=p_w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbxjUqFRcF8qzEnqhJ02GWrqS4ukuEC8m7SnXAPGN=p_w@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb92ed2-7e02-48b1-aca1-08da3dd9aaac
X-MS-TrafficTypeDiagnostic: BY5PR15MB3617:EE_
X-Microsoft-Antispam-PRVS: <BY5PR15MB36172D736D28F7216582A3C2D5D79@BY5PR15MB3617.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrXw394xhCDESQL1k58i3I+qzr4xdzEZhUr4OMF67L2sR3p6m7tpdfz1CSoMgvsIVZlxfUIyNmCJQd8VS1CPEW3saWBiyDq4UkjNO9TsalwMzYoVG4ikPFf3c/dDy4aPQAlnTnFZNse9mGNiINykRcgp3AqP+45TXUq3eHiRbWflm97AiNT968XhynGwy6hAlE5UmCL2Z5X58O9zkaUfCHZNOTK0W3e+gCdkCPFoESJTvqEbqEU7GFTjcdSj79LL/oW8f/DOwXpRwqSD9LI6oI4/ucAaKS5spL1tjaDn7+40+OeQGeNgjMSWZNKydnxOKzHTa6O/19XGdRD1L4gXno/NQC9H/1INKVLCoQ+uyPIH+rflXr8bqekDLSyS4CZJT4ACgVWo1TL5iGbAKfA606hDxJK/DUs6Oit0xEIhWQr+xFZKJ64X83ttbE/JgJIHBqZRbkRF04wXEsOYcm7vIRznj1oyOGDb3XVHlFyPsnRbPNYEsLh8DjnepDeo6RuOmBmRVTiJ273/YTuXZe0eTb1rBLPzzwL/x2UcmA4g3jYRtK25YZzClnVjnPjelNfvZgVIPHPYiRw7GQKYQQRY+GMYvbEoJP4Oy9JKE+a+fcBBCuTNqICyZXec+a4/xZ6KSRdY0YRq2zQXRts7lUvVUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4326008)(66556008)(6916009)(54906003)(5660300002)(66946007)(86362001)(33716001)(66476007)(316002)(8936002)(8676002)(2906002)(53546011)(52116002)(83380400001)(1076003)(508600001)(38100700002)(186003)(9686003)(6486002)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzbbVczt+79/bp2SxU2GUv0axbVaCELQp9D0P9jjFBd5LXps/qmYandc4EEz?=
 =?us-ascii?Q?hko0ROs1fWrRWVz2xcSFrOOP49+YCH1Gm6q9lVV/ArYS2uN8EISbkU2QS96n?=
 =?us-ascii?Q?4XtAvNwdz3Jx3zCwb945d99qx2ft/m5kujYA6IblCERmIxyUL8eYonKbpkJy?=
 =?us-ascii?Q?qllafLPmCbJG+c+w2Uv+smIn1pXurw9AkGMtBr54IUOQ9vWGwaQil0PXkxIp?=
 =?us-ascii?Q?GgQPyn3mja9R0x+kFZes42mr5HIPO8DWcuUjUJPLsLhiyB6pWLDvXeVF+sNI?=
 =?us-ascii?Q?DO7I+QkRUxuCgSsdfbK5/zR9u5RXD3RRVCB5lzE176RQUjJKuE8VdBU5P+1T?=
 =?us-ascii?Q?OjY1Yv1eLPyFUYov7REE2NT5/52jPNNVgfa7aHJ4JOkJh4aVzrcp7kQ5bxU3?=
 =?us-ascii?Q?8pHWsP8d9plnVC2Rdi4WC24mmkwbuc6YGYcMncnfCQK20Bgvl0v1T0flQe5+?=
 =?us-ascii?Q?upbArEHrauZpcUjjM2c/+uL8BAJsErfrUgAKDLq4gAVU1LMs8c85phykWHZO?=
 =?us-ascii?Q?A0LhkCDZJ/K2MTVzIbAPwLw+90djh1P83UUl5KmvouK32WNGdSSpfPsKjwLO?=
 =?us-ascii?Q?HGrljPq4vtGbbbBSoJ8dNwggD2CuAvLmRZJS+E1biEudG/WLFwMR9dtYD/sz?=
 =?us-ascii?Q?CTkWZtrHG/DcLhpBP440g2MljqozzcFK/5vaPf5AX/+T2saK9QL+xmf6B4M3?=
 =?us-ascii?Q?rqfJgd+lm1Zohn4tUu60voY7XYPLA1o7drr+vvfPByaLsqhkK3ca11qe/r7P?=
 =?us-ascii?Q?cZ9Q5K1QbYhpD/JCuV9fpO66VeK9NkqIREe2SDVe0gfWTVMz3IVPOgj6lcXQ?=
 =?us-ascii?Q?4Kbsu8zWhO3P7I7cGUV5wOY2LrOS354LDr7Bi5RZZTVYPeHP2NAsz7d6hdHH?=
 =?us-ascii?Q?NQ5dNpQtSfds1sSEVjaa712KjbgtRlt98asnq97CYR+Se7I10gBcnEemiYsG?=
 =?us-ascii?Q?O/6dZRif/E8aMI/6i+86G4++zC5BsQuLDFs16m3MBheImPSdaElU8SlmsT68?=
 =?us-ascii?Q?OsleXPG1Qc0yyOeTSXZ2OcA0dUZbwLhYWpNFRafFBB/6qpJ8mBCDpaweQ6+d?=
 =?us-ascii?Q?eesoXRc6/llgedMtBsO8bnHn+lk7PB+b9vqlJWMJDQc+wtOeS8PfTOSUa1u4?=
 =?us-ascii?Q?OTK1O7kNMVD63xr/iqz4y3FU+6ocA5+Zj36e10liNhwfyvEeDUrNACPFtgZD?=
 =?us-ascii?Q?cyClPpopyDTOZYCm2ZAk63W2dAc/lHCpe9/fnAhWpp26fxj657/k53eI1LNH?=
 =?us-ascii?Q?JdksR/ukEs8lT8Ssv1ZC1C9bbVZumG0KP8OFzfN2M7b9+fpdYjwtOa38orsB?=
 =?us-ascii?Q?R6Hn0EtCjQqTxgxHx/8OrZUCnmsdyzIkLxl1ZpAb3BAwFQY1ag2VgfXp6saZ?=
 =?us-ascii?Q?1y0pRyFKqpc8mgz5Tl4lN48VshCbDrMJ0VFty8n5zJmCaJ4x4wJqGEMqpQaP?=
 =?us-ascii?Q?Ci3Nd8ERGCPqVAv2CnBlcT+ojU+zxilQn2hhsxI9P83KIX8LvNuRJu5/RYG/?=
 =?us-ascii?Q?vqVJigeMFl2o401IiHl0TQa0CttSjfDIHQQIOSqjevenmJYI9KYyhmGfntrs?=
 =?us-ascii?Q?1TxkW7KFn/qUS5OI6p196EZh03yLnSBqyCQbvhFEVNP+QxP2wa0uLCh4eNfJ?=
 =?us-ascii?Q?yG33CNS/ZnA8lGIgMY+OU5L6HjM0yK+k5KMk15Qywwx/5IWbIRnHJxWO5h9y?=
 =?us-ascii?Q?AV+k18S/4XMTwU5WHa5MljOvxJyQhWH51JN2L/Jec8umwcxlS1KiXclrFAKI?=
 =?us-ascii?Q?fVTZsk/BNS/L7IT2h9wz7kvVkmo03ss=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb92ed2-7e02-48b1-aca1-08da3dd9aaac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 23:03:50.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW0pyhzUCZEwGga3dAjdWtaYxfB39dRBZNFkRwsEZlyByY4y9gVon0TAcVg1AcH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3617
X-Proofpoint-GUID: Ety_TV66C1gQ7VbLjKO4xPlJne5-pdoN
X-Proofpoint-ORIG-GUID: Ety_TV66C1gQ7VbLjKO4xPlJne5-pdoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_11,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 24, 2022 at 03:30:31PM -0700, Andrii Nakryiko wrote:
> On Fri, May 20, 2022 at 1:51 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, May 10, 2022 at 01:59:19PM -0700, Kui-Feng Lee wrote:
> > [ ... ]
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1013,6 +1013,7 @@ enum bpf_link_type {
> > >       BPF_LINK_TYPE_XDP = 6,
> > >       BPF_LINK_TYPE_PERF_EVENT = 7,
> > >       BPF_LINK_TYPE_KPROBE_MULTI = 8,
> > > +     BPF_LINK_TYPE_STRUCT_OPS = 9,
> > Sorry for the late question.  I just noticed it while looking at the
> > cgroup-lsm set.
> >
> > Does BPF_LINK_TYPE_STRUCT_OPS need to be in the uapi?
> > The current links of the struct_ops progs should not be
> > visible to the user space.
> >
> 
> bpf_link_init() expects link_type to be specified, so we have to
> provide some value. We probably could have specified
> BPF_LINK_TYPE_UNSPEC, but that seems wrong. But right now those links
> are not going to be visible outside as they don't get their ID
> allocated (no bpf_link_settle() call), so we just basically have a
> reserved enum for future STRUCT_OPS link, if we ever add it
> explicitly.
I was also thinking BPF_LINK_TYPE_UNSPEC could have been used
since the user space cannot get a hold of those kernel internal
links which is one link for one struct_ops's prog.

I was asking because the current bpf_link libbpf api for struct_ops has
already caused confusion as if there was a kernel supported bpf_link for
the struct_ops map (kernel supported bpf_link is where we want to do
in the future).  The new BPF_LINK_TYPE_STRUCT_OPS in the uapi here may
have added some more confusion on this.

I don't mind to keep it here as a enum holder.  just want to double
check it is not useful to the userspace now and can be reused later, and
probably need something else for the current struct_ops's prog link. 
