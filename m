Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21E32078A
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 23:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBTWvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Feb 2021 17:51:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhBTWvV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Feb 2021 17:51:21 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11KMhv9H022777;
        Sat, 20 Feb 2021 14:50:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wM/uAyYugoTvIBSJOJtuGIiVNAe1WZ0rb5u2w8BBki0=;
 b=A4edRVcBzZpRYYtEfjWaeIi9BMkt/66BRB3EJGel5l+ybXIeSjH3uhn+SAiY0FijNjR+
 eod7PWdo82xJULqFwlewjc36BFQ0zgZlZU+pvpbHZT9+KttXOliRnmyQCjo7FqHrkLe/
 pDnDY5l90y8uzBrtle13csk6JtDaSqHInnQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14psw2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 20 Feb 2021 14:50:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Feb 2021 14:50:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOd3IUOlKEp+BBI6mtT6NU95Q+4JFQob39hT7dAU4czVnJg3/CCp2jHD5a/9z+HJJPnSlU8E7Wz9upn7g03m2QwYWvv3MAqxmQV6zrSLeyy9/69SnQ6DcuYgLDB76wzKCMmyPB1/sXGitcLHSLkdF4ZvuTRWEsRGT44WNEOypA8SWdR6aLxLPaFZFAcNOclKyHb6MNDuy3d+WtwNick9/38Hs7BrQB2mMKhU4t0sFyEVckNj/Q0EIJIiCqeBygHaMEam6bOm3FCX7pouj4ShSba84LmwSLDgoQfL1P5DlJUVolcl4m78HUFG3sl+KgmCOu+/zszOzp1cMj/VHTeAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM/uAyYugoTvIBSJOJtuGIiVNAe1WZ0rb5u2w8BBki0=;
 b=Pg+oKQH+qMm1QSkNC29WX3rbXD1AosZtFZ3pkCPdPhdIfzoBPq28BzDb6a++ldnUjiQ4oRgh+DUz7okDckV+Jind3hsCIhZsFSiM2/PiBoU+283gbUY0yHsna4IveFUOJP9IU1HQj/gni7OML4tNsEZlX4b5KnKHRA1z1UONWEorzN/rpHOrv/rjx/NHJ1yZBL5gfSu/kjFTzvLylamSrvbUwNy6WP550r/GcKX/MQ6+JIG6zi5Rcm8+yoVYHpD66KVFPSGLOnqrL+/uNxNmi1025vIqEaTR3/gKw9zKJL7VdqGfkbtmiB927UDOqSAMxfKWeZgysP9fVAgGTsT4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2773.namprd15.prod.outlook.com (2603:10b6:a03:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 20 Feb
 2021 22:50:22 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c585:b877:45fe:4e3f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c585:b877:45fe:4e3f%7]) with mapi id 15.20.3846.042; Sat, 20 Feb 2021
 22:50:22 +0000
Date:   Sat, 20 Feb 2021 14:50:18 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
CC:     <andrii@kernel.org>, <daniel@iogearbox.net>,
        <songliubraving@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO_BTF check to bpftool feature
 command
Message-ID: <20210220225018.oezm23abceggcy4f@kafai-mbp>
References: <20210219222135.62118-1-grantseltzer@gmail.com>
 <20210219223639.ml445wsp5otz5cqs@kafai-mbp.dhcp.thefacebook.com>
 <CAO658oUwgX-aVutTn+3f=gZ5ZfdTuHUakAetfpXo_LN=Va=SyA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAO658oUwgX-aVutTn+3f=gZ5ZfdTuHUakAetfpXo_LN=Va=SyA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:1418]
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:1418) by MW4PR04CA0313.namprd04.prod.outlook.com (2603:10b6:303:82::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 22:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f7fe5a0-1d9a-437e-2204-08d8d5f1e771
X-MS-TrafficTypeDiagnostic: BYAPR15MB2773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB277351BF73A3E90944B51A08D5839@BYAPR15MB2773.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7EJc518UKjvSA5Tkkxakel3iVvr6ES9n+sNej4YPBifE3sWfv1x7o3G4AeyzMKZMsnhz6q81L/ByBOPiZJAVmaemonNRoYoRtvDpbVKvuUg2NlJxq7iEU6wTZBmaIRJ4glmkFcVawgdZBZcOqMkoGeowAcr+yPuwsYAroZOKGncAAs6cTIoLJsRJ8/Lxi6qOs9J+tU94DlxkPdEIFVngI2ZE0ew3dy6LwM8+rcPKwZevq5LSKiSi1ToyuCenySBvrfXEIBZZbNMhSQMpNil9kSvRnrbh8pGKEAmBzN/oW2qXAQnRplvNZ/VO7O1046pj6Rtn1pfoEL6b2Nsp6VSku5T5rh152kTytOa1TOSo/JNc6f+Ywdsuhmy21Y03HeNZgyvkIALfH1EbqbPv2XHFP3hQSNTppZdYurYLvOCBpMOd3ANeXrHZj2Y4UDYrfuANgryqBi3tUtgvQ/8dzU9RMdMcN7bj92Yo+pVyQoUWnGPxLbaHHzOCofq7+qmG6WEBUZz0unZH4Nz9rUoSVSPDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(1076003)(52116002)(186003)(16526019)(8936002)(4326008)(2906002)(53546011)(316002)(8676002)(6496006)(83380400001)(478600001)(6916009)(55016002)(66476007)(66556008)(86362001)(6666004)(66946007)(33716001)(9686003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BTpsVQwRbVWIuyp/e0jW9kmG5WIe+sqopziPBPZua6Uc7r8tQvCr80077Rx2?=
 =?us-ascii?Q?nmHx5mQAm+BQazEdUbkxeUqEmIVtg4h76HOSSnMQXRjIPIU3Cvz7OoNP7l7k?=
 =?us-ascii?Q?bxMkZD4kH/UTmdCT9Qf/KYCr8RmEegEOIBi9QKEKZd2atz3ps+l4rZqI46pW?=
 =?us-ascii?Q?ZBu25AzGcKyDvuTOrEeDxr2ZqwmJCp6ZwRibgDbofmczhKEE3WakKaCLQ9iW?=
 =?us-ascii?Q?MT1V/u0cUIUwrQ4OiO9SZYBwmzfYlitSglTHYFebVMhwe300qq5iAtIucswG?=
 =?us-ascii?Q?Eg7+9dK/J9ze/iUoq1KkyoWJYq2+tWfVNrZAiBxtddSYv9iW1LsNCrkAgMUY?=
 =?us-ascii?Q?sEayjAX8njEkodAoGFnCfqSaJael0LZY5l0vZLhYf/jZ0Rz0vUa7tgQw6/0l?=
 =?us-ascii?Q?XxUPYi2GOP8CAEsPto168m44jT+YL6alZYSP2CVnLqzmBUrb3963eJU7k54O?=
 =?us-ascii?Q?Q2968OkW0YA0rzBqgGbkGxcCd/89ynPaYHMMjUoTO/syit0Bf7LA4BluGTRK?=
 =?us-ascii?Q?dj9Q7biZf5q15M3FkMrYekX4M8ExC/h+I7SUeACCw5WHizaUE6szS87SZduk?=
 =?us-ascii?Q?lS40dVit03X+vs1Hka9pwcI6e/nWWx+qncGxw7pxmbx1MBmijrF2k5htwuQp?=
 =?us-ascii?Q?rnrbneV1Lg91IPh4Wkn5nsGKINHYRYf6sbdDSRZqOAF1SRliwUlnjkxntrrj?=
 =?us-ascii?Q?qZxLshhH5GZsBiR5OWWGmtVf8gn4KqHhfd6uxu05Fk+vWwdYPkit8h9wSklT?=
 =?us-ascii?Q?52YqClS6/jlXNccJLtvLeQWOYUw4PYEVec4CLGJ0OBa23Nsmo4QukU0khyKC?=
 =?us-ascii?Q?i2rVOtwBNnncoA+Z/xR71ulbEGdQfsjCeKHypQM84U6BCfBCRg2UKR2huYDW?=
 =?us-ascii?Q?dCTC2Ut1/nAcfAqXWHY9sXVTkPpd0V2OtClPyPrEGWV76XdSiakGSw/9TR3j?=
 =?us-ascii?Q?jE8L7V8zmArNsRQcjEQilc8QFQatsIdFX09lS2y4DrjZfdwbRcIStF8MJ2hY?=
 =?us-ascii?Q?zsWz2izsZmKZcVErJsYZZ+miIsWyUET1gwpn3uVZ0ixXk78BnQd2RRc4pj43?=
 =?us-ascii?Q?pKhApFGiJU9yHoipa3gu0ygqK5V1KcU2l+buHkKdXb2coLjOgoMcd4yMj3oz?=
 =?us-ascii?Q?tAiLAX8CpmcspuSjA1gRPkTyoQyre/y2xg9SQZK08CgAQGnI4pOrfH/CnYBv?=
 =?us-ascii?Q?4rhPvfqV4ziH/22EcaGRNfQRZstg+2THIKUrcgGBEbI7GV8NjTw6/r1UpEFi?=
 =?us-ascii?Q?URuwajddczWfosehO9pOfeqRe7MxHuK3jcwR2bNydz1HT1OR1HSasgtyFO6y?=
 =?us-ascii?Q?nCT8d86j8LdY0s1x5zwLQuVDq2vBD2UWuwVPxFv05KcicA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7fe5a0-1d9a-437e-2204-08d8d5f1e771
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 22:50:22.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PW7Jd+Q10XQx2dGDR+RN4/35CCe7JbyYHwJQkf9Oo6N4Qb9YeqlnIoXWR//r3EW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-20_03:2021-02-18,2021-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200210
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 19, 2021 at 05:43:00PM -0500, Grant Seltzer Richman wrote:
> This adds the CONFIG_DEBUG_INFO_BTF kernel compile option to output of
> the bpftool feature command. This is relevant for developers that want
> to use libbpf to account for data structure definition differences
> between kernels.
> 
> Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> ---
>  tools/bpf/bpftool/feature.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 359960a8f..34343e7fa 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char
> *define_prefix)
>                 { "CONFIG_BPF_JIT", },
>                 /* Avoid compiling eBPF interpreter (use JIT only) */
>                 { "CONFIG_BPF_JIT_ALWAYS_ON", },
> +               /* Enable using BTF debug information */
> +               { "CONFIG_DEBUG_INFO_BTF", },
> 
>                 /* cgroups */
>                 { "CONFIG_CGROUPS", },
> --
> 2.29.2
> 
> On Fri, Feb 19, 2021 at 5:36 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > There is no description.  Please provide a commit message.
> >
> > On Fri, Feb 19, 2021 at 10:21:35PM +0000, grantseltzer wrote:
> > > Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> > > ---
> > >  tools/bpf/bpftool/feature.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > > index 359960a8f..34343e7fa 100644
> > > --- a/tools/bpf/bpftool/feature.c
> > > +++ b/tools/bpf/bpftool/feature.c
> > > @@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
> > >               { "CONFIG_BPF_JIT", },
> > >               /* Avoid compiling eBPF interpreter (use JIT only) */
> > >               { "CONFIG_BPF_JIT_ALWAYS_ON", },
> > > +             /* Enable using BTF debug information */
> > > +             { "CONFIG_DEBUG_INFO_BTF", },
> > >
> > >               /* cgroups */
> > >               { "CONFIG_CGROUPS", },
I don't think this old reference "> >" part can be applied.
Please resubmit a clean patch instead of replying to the
old one.  Documentation/process/submitting-patches.rst has
details on the how-tos.

It is not a bug fix, so it belongs to bpf-next
(Documentation/bpf/bpf_devel_QA.rst).
Please tag it with bpf-next.  The next revision will be v2,
sample commands would be:
git format-patch --subject-prefix='PATCH v2 bpf-next' ...
./scripts/checkpatch.pl ...
git send-email ...
