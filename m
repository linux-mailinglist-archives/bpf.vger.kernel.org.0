Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118D23EF418
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhHQUcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 16:32:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230459AbhHQUcT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 16:32:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17HKHqTk009478;
        Tue, 17 Aug 2021 13:31:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lAGaOBTW12krmCykvpMRQ1fE3v6jkK7gTVn1UNvzSRU=;
 b=ELkJN+LzRf9jO97PSaYMrm6RWfKwAEXqF1XDdGrMJDXcn5HsqT0ZjjCpYp10AVuxPFmE
 GzFGAmf9YM2cl5tka5b/ib14C00W+9VBhpzs6f2j84BXtLOQk1TNt/7QIW0Mq94iD/fy
 dBlvwivQFakyaVP4uK34SmySGdE/FJcT3f8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3aftpf1245-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 13:31:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 13:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIPqzAD/JHHYOw+V1KA4KpFv7L3sC0i9pis5UlM7PiIt8inljK1/3gIuqUqOdFcLBbmL2FrOTvexZrOwSbPivKm59UA/kTiNU+yTR+3u5Fd4hmPf92YitYJp3+cUyDRvx7Z/GcG9h7FqJ7CCcpffDtO8JtX4ixxWfVf7FsXS1CGBHHRaVhZjTBe8vE47Ujx8pNJjqXoPNX/rXJkh2hJzx/FFX3Cb7MbwKpE8s1wsTuARZEvmlRkl1Mw+FZIwa7VS6KgykKYrciZWiYs1Ew2gAkOp9ei0vr8FbYU2+93NYGWdUekHFE7b61DEjuJlzzig0zKe+/hfVbTq3hUqvgXpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAGaOBTW12krmCykvpMRQ1fE3v6jkK7gTVn1UNvzSRU=;
 b=OzHqJwZ0whu6B+1tld7lRGGIR85Pm90uMZtxT9F9UJX1m/qVqccUtn8HGmszg3efxWm9C07T+uQZAwIKs45yrjVDTEk9i5TU98jiZXDvVAW3wnQ/EL128KL5bCKpGJVt/Ldg4E7O4F4qhFj+Mp83T0nIntFMlrtgBenvUgClddGIint/HIyHfU18PZmdV+780d2CBn30XnUNhwehp0ecrlKXWRwk5jXv8uFOUmIkAdD2C2aAMObEXk1SnQtzBSw5Cbok5TagN2BJwOc2AZGBRHpeYCG4rFMJVhcznUTY4HYEAHk0qUDQqdVmSyQ3ULcbzq0/N3EcH46L8MB0XJ1EOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3791.namprd15.prod.outlook.com (2603:10b6:806:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 20:31:30 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::293f:b717:a8a9:a48f]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::293f:b717:a8a9:a48f%4]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 20:31:30 +0000
Date:   Tue, 17 Aug 2021 13:31:28 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Prankur gupta <prankgup@fb.com>, <andrii@kernel.org>
CC:     <andrii.nakryiko@gmail.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <prankur.07@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket
 options from setsockopt BPF
Message-ID: <20210817203128.ytofbt5y4pjf2cnc@kafai-mbp>
References: <CAEf4BzacXvT5tsVe-xYSOYrxrf8B_02jG=Hv67SXhC-8rWcxrw@mail.gmail.com>
 <20210817194921.2317212-1-prankgup@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210817194921.2317212-1-prankgup@fb.com>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:daea) by SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 20:31:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea8f6cc6-c6c0-45af-4790-08d961bdfef4
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3791F51BD37609280CA69067D5FE9@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xgm8uYNg/hg98xjPA6zb1FoABNRRMHFl6NOKIFk2xJrEQk/gRHKwBPvP+tfSYpYCkyUhX1z1dUqaK5S8vv9SE4fhpxP4dcLA8mbPZFmq1yTwC31reCkNgS58ynpXDXYm4p0KdRuhT13uBNHTQePOuq5TyGGk9+GBMk6EqfGNPtHOr6qOT7ZH4DI1UngEfh0gd8UIaLNXTSu8jglgdLgNPUyaIbn7Ji00P4nMhBSL6OTyNu0bJRxx9FetkHq5+Fr8WmQNnGQZmviEKk0FO0wPBVG+tW1wd4sRSDaVlG/2B07T1kFY3Vrk1YoEw/iki7g+Uvg9PDEgn6+sBHhE1Hv9CXyPexcs7yBBFmgcDLQ1eMe5dasUQWIVWSVMLFxpQhMZZ7iG8KqCFZbWPonpFbXKoAJ7tCmmeSH0RvnvlhtVH65djwAyRey0ln3ZFgzm54l9wV9Z8mSiY283haDUdar+wpBO6GrtAciTJ1U1ddZmbdQM8CADkm/+vRfcjSXxZUSTN3IemjsxJCN89YWYktghw+QMB05akFsoOpy8mjGfKmlx4jfV67SDs36k4wfIAuZ608h/GW/2iYDUB8GHS5JNr+2Xg5EbImNbgomptnaObToTR/TyldpvdMAcgKSVc83SjzIxtSd/4AdcQ86o5rVlzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(1076003)(8936002)(38100700002)(5660300002)(478600001)(316002)(33716001)(2906002)(66556008)(6496006)(55016002)(66946007)(86362001)(8676002)(83380400001)(66476007)(9686003)(4326008)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBXIxuuQ2uXxaqHPR8PBcbiuDigQDi8ZSaYPsONpf1/NGX2XBB2ZYRVTZO2l?=
 =?us-ascii?Q?vnRa6/DXj/fYa3HUSMAwT2JkyEswigXE1AUtIPMOzZkd+HZEwLvQGWz3tJZv?=
 =?us-ascii?Q?c8uZLfm56spaYicnMI1NKEa4W9R+UcrYwdk+dBX5hjekyCiPi4psf64Sk3Bs?=
 =?us-ascii?Q?MVcbEtuR8vB+qjtdBdAk432M8/fdFe0n2oUwPZBHQ/Ff2Chxe/8d8MWKnQo2?=
 =?us-ascii?Q?LldaH85K3vG9NyDk3y/vl+6FOFHTjYsUXUj5jzLgkJunHq/y9mERro8U05iU?=
 =?us-ascii?Q?qplwE52t8yVanWPkfH36qjuoDwaL1uvdmQywp8AYHFYYnZcxq7fKVmU2hjFx?=
 =?us-ascii?Q?9BuYEQzb3Qny34K9UN5seOsC5JM4B6Mfu9/E/tWm2BEC2d3bxmw3cwVk8Rcy?=
 =?us-ascii?Q?y65+NctqRraVSqjePYxevex2+k9qGUC1riytlYRHajnUf7kiJa0jnBxIa3Ao?=
 =?us-ascii?Q?NIR9CPRnp9JVrBOYFfPhgNZwdXRASLn9WbAU++xYwgCj4wRodrrbsP7QywPf?=
 =?us-ascii?Q?hR/jBPjA34c7Fnp3weYTCtlg/NNWu0+HoojeKGHzXiFhZ3u5FRXRVx/1I/Hp?=
 =?us-ascii?Q?yJBbxM1J/U3zKxr2Zi/V5p3OZ+IHYtg/7/QwpYQRpZhz6sX2N5dAR5maFFID?=
 =?us-ascii?Q?mhqKNRdq/48Pf8dtxqPORvO0tzupoUctlZ4p+Z7zMbl2BBL8ov3rT4vAZcYm?=
 =?us-ascii?Q?I5mjaj5MNC4qwhq771XXx6fH631IM/f2lxydoQltdg01mWmQtMVxlXq184/g?=
 =?us-ascii?Q?/CFKZEzhEQrqgOqVVOBvdyJQHz7o19xjsZAh+XFssrUmxcqBnT8soUJgcvbx?=
 =?us-ascii?Q?Z4uNn1IkHDgYB0q96Y8YhbhvnYL5nK/w/XwnFOjKDQOioO6niMWGAV6Ohdcf?=
 =?us-ascii?Q?DWg7EjGorJrU3ur7hv3Ibd7mJzTZ6d29s3XqKzyUzKBsfotgu8AN6cfy1ztp?=
 =?us-ascii?Q?C79yQbKmltmEskhJ5pcAL14yLFFJC+ez4kFKv+9NWUW6NmjPfVSRCKopEaZE?=
 =?us-ascii?Q?mo9jB1HfR3zuqw8my4vvVlE28HJnVyXHAKDhRELEyOgLF3wUPHZ0CLgr50zl?=
 =?us-ascii?Q?QmaNm9WwueDfLm8xWYfh3JBW0aA8gDvVoQhTShIgeCbzujyH6vs8c954RU84?=
 =?us-ascii?Q?TufMWv6OW0Qf/tpANEy22Z/XZO/auLWgBJY05ohzFy2zlmiKP8DEnw6/RtKt?=
 =?us-ascii?Q?zse28ytTQiSBOfojLrPPkuMfdlVewAwq/SPhpY5n3Me8WmK8b9w3mXuUQdOp?=
 =?us-ascii?Q?OyFOFkvdronQmH1m5XEpQ96WiZOU2eyTbXN/PYnuvITC8BNuqnjRrvVE7ts8?=
 =?us-ascii?Q?SHgqHjqusa0TYhbCy2VXowmaYcu5x2StTDNwvDOomRJl8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8f6cc6-c6c0-45af-4790-08d961bdfef4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 20:31:30.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oabTAgApNj2H5YbH5DlkOjIoAxIvbBXOcd9lHcQJgTWZJ83WcU1pO7c9ML4Wr8xn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: I-QbJQCz0fUCztP-YMKnOqvUyo-03i1P
X-Proofpoint-GUID: I-QbJQCz0fUCztP-YMKnOqvUyo-03i1P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 17, 2021 at 12:49:21PM -0700, Prankur gupta wrote:
> >>
> >> Add logic to call bpf_setsockopt and bpf_getsockopt from
> >> setsockopt BPF programs.
> >> Example use case, when the user sets the IPV6_TCLASS socket option
> >> we would also like to change the tcp-cc for that socket.
> >> We don't have any use case for calling bpf_setsockopt from
> >> supposedly read-only sys_getsockopti, so it is made available to
> >> BPF_CGROUP_SETSOCKOPT only.
> >>
> >> Signed-off-by: Prankur gupta <prankgup@fb.com>
> >> ---
> >>  kernel/bpf/cgroup.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >> index a1dedba4c174..9c92eff9af95 100644
> >> --- a/kernel/bpf/cgroup.c
> >> +++ b/kernel/bpf/cgroup.c
> >> @@ -1873,6 +1873,14 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >>                 return &bpf_sk_storage_get_proto;
> >>         case BPF_FUNC_sk_storage_delete:
> >>                 return &bpf_sk_storage_delete_proto;
> >> +       case BPF_FUNC_setsockopt:
> >> +               if (prog->expected_attach_type == BPF_CGROUP_SETSOCKOPT)
> >> +                       return &bpf_sk_setsockopt_proto;
> >> +               return NULL;
> >> +       case BPF_FUNC_getsockopt:
> >> +               if (prog->expected_attach_type == BPF_CGROUP_SETSOCKOPT)
> >> +                       return &bpf_sk_getsockopt_proto;
> >
> >Is there any problem enabling bpf_getsockopt() for
> >BPF_CGROUP_GETSOCKOPT program type?
> >
> 
> No, there's no problem but there's no usecase (which i can think of)
> where a user wants to set or get some socket option for a getsockopt call
imo, user usually expects that bpf_getsockopt() and bpf_setsockopt()
are available together.  It is pretty much the only reason bpf_getsockopt()
is made available together with bpf_setsockopt() in this patch.  It may
actually create usage surprises if it only allows one but not another.

To read members from a sk, it is more useful to make the
bpf_skc_to_*_sock() helpers available instead of bpf_getsockopt().
Then it can read the sk's members from the returned PTR_TO_BTF_ID.
