Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C85A6BBD
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiH3SGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiH3SGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 14:06:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAB6DF80;
        Tue, 30 Aug 2022 11:06:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFrW3P007713;
        Tue, 30 Aug 2022 11:06:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OPpkmUXn2/cHKRCRQ7UYmzLZevUYAERLAk5ElvMyIIU=;
 b=JPhPBndgqMZZ+hwllMNUTx1QhMP4B+i/xaz0Hfcht8tcfCXew6bLaY1ZonJnnRld/uNZ
 uo3+RXsuNMYDzWqv6IlLq4yoM7f4qjSkr/BCgXIHcn2rtz8MvIbBsWYk4wVJ9JYXtL4P
 kKkufV4BIxkD1GydtgC6TrGHY2tXea6meX8= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9ykgjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 11:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdAOWRHSzuXa8WUjrSn5wNISc383gqODJYU+dJZlgDFMGnF61EIm2TcReD2LikRF7YrE9KoDjp1aCd1Ez+hERvxaQVhalSRsKDDMLxQ/jdD8qxd3yQHpJwlmREKVXf1Jcsyqb8XkibcSCeh3nW1oMmuXRoqwRFblPd8edvq4QeVp6D2OSGgooP2O7Q2R8j+Kn4jZpxqnwM7klUGnsVOKADVNXitSZDfz8ruWc99pIaArlbsaGY+TuAPb9e43jYdowTaE6/DqXWDFLVjlpI0n8rB7TUQnKWfofwcJR12J91tqfiVldqkIn9gCWgV+ErNkYsC1oo7fHR1HCkouVhlnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPpkmUXn2/cHKRCRQ7UYmzLZevUYAERLAk5ElvMyIIU=;
 b=EjuRzs9UWBykCAexVVSVBslgYBSNJYA9dCL3GofInt0/IQw8eHfHdunH9Z5lvipajP+UQXvVUwiTGjRWOsfjIxqihlChdTCvxtyHYbHBTWRZizsGL5CHEIjfLI+t2TqT41FTge6Doa30LyMo8jZxP4dtVzkihtHM2P8UogqyGDdeuwcfDAT24m+mZTObu+z/fYwt0ndp9FlZKop6MapPKL1GUTCtpaDcxJ23b49JJbYLdTaIhe8CPHL8o/xBBgfPWbtVDRE/4ZgzgajhMojgbW6AMXpbMWK1n3SWpdFHRhQdmXSv6OQwb3DPcwRP8lq9gK1jiPLFpvo89i8ELrMHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB3319.namprd15.prod.outlook.com (2603:10b6:a03:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:06:29 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 18:06:29 +0000
Date:   Tue, 30 Aug 2022 11:06:23 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Quentin Monnet <quentin@isovalent.com>, Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying
 cgroup_iter link
Message-ID: <20220830180623.hi6ma6nql4by23sr@kafai-mbp.dhcp.thefacebook.com>
References: <20220829231828.1016835-1-haoluo@google.com>
 <016bdefd-ff75-35ca-52a5-0e058e0a5d04@isovalent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016bdefd-ff75-35ca-52a5-0e058e0a5d04@isovalent.com>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f61475bb-b5ec-4f9c-296d-08da8ab25b12
X-MS-TrafficTypeDiagnostic: BYAPR15MB3319:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLFKMsaIDcCYz7rmYlF9dpwkbC4blwgvTlcc/7QyjkpMSJILIVMas3I4z5odkLSNzDvsrFLgQYi/pjWCe9uIkt6uTkL3GMUYV2paT1XlgFmGGCbCNGfZuMQmJY2Rc7ON6yJjhtgrRIhw4o1I3UKIRAuoRazyI5bR35URqISY87sxel0P9b6Km55MgF8XWglu7clBeKmBocjE0kVzsUMYKswWztH3NMxykvMi66FaS8LZpbrR1B03em8PBFtRXpVuYOCC7k6ptXxJ6WRYtoa15Ut9DUVggyiTyt/ZH0a6UbaQ/7WQqhoORBauOsiWfEB6c9eeK7xGHQneBTOKH1ebXAc/bdLIbcrH2oCblScoTrs0vk6ruKAyH9LY7I8l4hpIY+ds8Tqej4GV0WUUg+xb7MOeoU7Fz91mh1LBG9x0d7vUaBuHBzIiFP50HL2LhUIXbZjdnrYtripaqCNJSYwFVVBKrvXxtGykyFzucTPClYFPxRsihvOdoetFJhOK2TaSDbWgHdCqAryXK3/dpmfZ0/k7VsUkImY28j3mq/SMizUFU1setJYLkQeS3e1cte6PVTtf60VID8RpnXIAkjANDM95nNdmiJSYbw1soznE3wH1FAvky/CbiOEW4BVKVCKZlYUnt/9hc6Rd9MMgwzyiq/1Rybqa9yhfNP1x/J/luJEAkuJsqYvlW/6xai4E6PcGk570d3dGhF5Ex+C/U08WAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(38100700002)(1076003)(2906002)(52116002)(6506007)(4744005)(6666004)(83380400001)(9686003)(6512007)(86362001)(66946007)(6486002)(66556008)(4326008)(66476007)(316002)(8676002)(186003)(110136005)(5660300002)(54906003)(478600001)(41300700001)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKpIbAbRFtCmEphYi2VZ9nWOQI7R2bykNKQvkC3lLktndilLf4zt+Uy/5DxF?=
 =?us-ascii?Q?+f9jkOcQ3sRHOljduMkZOn61Hy+8XafuKxaE9qVsd582u6O9C75LRNGsUdEK?=
 =?us-ascii?Q?h4o/n8n6k9xm9WEbLTt7AutY73rNksQDdJoe6CDR28jkEnmVnTtQ+SfNxNFX?=
 =?us-ascii?Q?eISN/c3TP/Wlge03sEY8sft0XZkBVFEx7rtnI4Ut3HBE5KFmjBgJy6lon+Gr?=
 =?us-ascii?Q?h+K/UjEmoNKvPg+cEsq3g7BVSBV9O17I9jP+eUnp6HBIsVADBwWDJx4mFz1Y?=
 =?us-ascii?Q?h0Y7mAxhP52KgtNh9FTKxVJf3t++uXUpjT79UJYxVV+2GiFJuZZ92RkR2QmL?=
 =?us-ascii?Q?TOMnhunvi510E84EPWd5ttltTiLzKrnp9XxE2b2oZlAAHKLUZybVtYITxfbG?=
 =?us-ascii?Q?3Aa0nI6f1fOgV5zUjg/LvB0gagIvxe3kcateZ0ThNTQDp+XZIbFs/Pm8DWpM?=
 =?us-ascii?Q?QnhSVu09rqNhY/TTE0zBiUlAOD0TlMiKbGppm4UIiPh4/CNNPXn4QHB26wFk?=
 =?us-ascii?Q?Zd3lylRUcaOuM0yQl9l5FyB+VzBszxmI0GaHiX0tv7kTU99LU59tX8FUFz8l?=
 =?us-ascii?Q?IbrXoBO5odpid+TaYKFBSwIOjvz1MFXqioBkpepPER4GUuMx2rZFqs4gO5jf?=
 =?us-ascii?Q?lPa65TCBcd4pH4+gEV1sjPetLqhn8plyt9V/8/8nMya15UB+7R9r6DokOrdW?=
 =?us-ascii?Q?VMmQWKhQiyKXu2mI6xFnBK2TFVlaM/gP/Cx0Hx9oQh7Zhbi6DItWgrQZKmRD?=
 =?us-ascii?Q?2h3tCtWLaJbh127T2x7w53ReRjOa/+qAY5P9GcGir2+hIT7eXYy9tjhzA335?=
 =?us-ascii?Q?wsOtyoIRWctd5pnI1s3fa4nyn0JRkq2o5MDxNn4WOSR6DxdugJUa9qXrzIG2?=
 =?us-ascii?Q?KpkQmEOKh24Zh/z8yPlJWKU7zF3kkWFKK4lLtlCwpRDXPzAlr/lIyT+eSONI?=
 =?us-ascii?Q?c7LmZ/+vSSxZ/u41rJFVxLGgWNpYlToQC3x/UR4juSdLxXaS0k7VgcSwKVqs?=
 =?us-ascii?Q?NdzOKS5UxdzYhQ3tzAFy2QTYFEowUjaPAyMmbB5avHe4s2C86d7HSzhm8/IK?=
 =?us-ascii?Q?TfxgHDsKjSG8Ou2NFGWW3Li07hoeDTT4QGUm9iRLBqXuZ1WXLZ2g8WOZpqeZ?=
 =?us-ascii?Q?Sk+juJ5cIECMWhzUyADPDxX8i/QqYCjgmLoCzw8Mfg3+tqRyVZPs3U87kQJu?=
 =?us-ascii?Q?3CPvEYG9LLJdF99HQxkWfvmB10dXViuHvTowA1185Ull4uD4yAhgMdiYZzox?=
 =?us-ascii?Q?OIALMKz/djL2Kd/nHqeY3GsI2rxi9fJfVNXgqsE8XeVumKbjXedhXIHwN/dF?=
 =?us-ascii?Q?Z5VMn3b8jsUe+XFZb+GQZRJrGTo8t7kewYdHQuTDELvGfFfZj4WGjVS22cZT?=
 =?us-ascii?Q?zENAowoUgiPpkD8vSoh0fppu4i2rJ5WM3EHQYfFYciXo3jU5UsF1gMua6fFi?=
 =?us-ascii?Q?O/jE8p8oi0RcjmikxmJwm2K5twrnC3UTbMiD1ZLU1ve20dTq89YQbm4DhkFy?=
 =?us-ascii?Q?5dIYIlU5gdn2jEdbSY2ORpiHFCQ5vAFGdg82FR5iV6hTM/L60II8rWsxzXSB?=
 =?us-ascii?Q?xP73e0gJIbPvlnRRmwvb9rXflX9TeCIjimfMR2WskLxmhu7l0BqWeZYjsI7R?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61475bb-b5ec-4f9c-296d-08da8ab25b12
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:06:28.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d9uRx7rNnqETulj6DdOrocFleFFWpPC2QCC+hO2Z3vC9WknrQICgnFPYeqfrHLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3319
X-Proofpoint-ORIG-GUID: pt-5oBfS3hb4CUsac3OT7Zf9Ei_nRF-Y
X-Proofpoint-GUID: pt-5oBfS3hb4CUsac3OT7Zf9Ei_nRF-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 02:33:47PM +0100, Quentin Monnet wrote:
> > +static const char *cgroup_order_string(__u32 order)
> > +{
> > +	switch (order) {
> > +	case BPF_CGROUP_ITER_ORDER_UNSPEC:
> > +		return "order_unspec";
> > +	case BPF_CGROUP_ITER_SELF_ONLY:
> > +		return "self_only";
> > +	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> > +		return "descendants_pre";
> > +	case BPF_CGROUP_ITER_DESCENDANTS_POST:
> > +		return "descendants_post";
> > +	case BPF_CGROUP_ITER_ANCESTORS_UP:
> > +		return "ancestors_up";
> > +	default: /* won't happen */
> > +		return "";
> 
> I wonder if that one should be "unknown", in case another option is
> added in the future, so we can spot it and address it?
I added "unknown" and applied.
