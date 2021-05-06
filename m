Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18093375C0E
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhEFUAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 16:00:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhEFUAR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 May 2021 16:00:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146Jt9DV016890;
        Thu, 6 May 2021 12:59:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oY+vHk6WUyrMkUkHYiUrDiJC4vtrKNETN/QNR6bIxkQ=;
 b=Knu6EnQb8JLF3WEeAE/Jli01j5PYd/zdC7DbK9tDV7HspRq44mPpKdIUl3zWW6a15lip
 dQF4adotTOfFI46FQBepSh1IrjehCvMzCgrQoFG7TZrs0i1TjudbHWLEDTRyjyiwlx3D
 l38U7KY6d6rU/eZUk/bIgJog/2OgTo6iuJA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38cmq08w8y-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 May 2021 12:59:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 12:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj/Lyb3dkYMXjWsF7f7ZnbTP+ONNr2yMWpXXybTS0fYiS+wQr68J1LJtjqD9m/sphlG5ylea6teSsz73FraJR3Ma+e4RD2vx1jEC2jg5fAPo9OLKKyYXQTlKQVdGAfmMONt3X3Fx4roTvET8uXAI5Ocp6/mWeuvuQECOsbhFTgMicOmnRcI0TrE1zkMHM9tCHohwhz+jRNxAGN/GTf2xacF49WBlbkufxVUuqjZ1DsBMXwiekzMkfMhKIBl28q03udo/BnA/FoboKOEV+UF8XcWqUMprCS8lxa9pew/LY6U2s6+K17AjasDzFkjZJTpbRZWlaFKAGhaKsS6qnm92ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY+vHk6WUyrMkUkHYiUrDiJC4vtrKNETN/QNR6bIxkQ=;
 b=e/Wns7ieLS3PnYqoiWfIIdekOTpr6vTk20dB630bRUC8D1mHtrSrKJzhGd2ZY4z2SObdB11ppGbSXQqB6W0yaa6hM8TMXjyJ8EP9T6JyktfVDWdH3QCEiziT7bpvVSkIGQfMugO4KZm4/uUPjRiZSj15mBqPBeSG2W2F2KsDgY7fj3BRzPx1msytpUA5j2O9uleAbH3FeRtaFFR3S/jrU6BxJZ8O3uwz3jWM4a4hkyiKDGv7MPRRK+fl68igOoAN6rCf1s3ZQjzknrY+CAFX90W1lu6nO8qJOmwjXuD73V87wRceVpd4rjI5wPvPkx/r5Wwi99NWmdZIBEoqTxs/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 19:59:12 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4108.028; Thu, 6 May 2021
 19:59:12 +0000
Date:   Thu, 6 May 2021 12:59:10 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf: Remove ftrace filter
Message-ID: <20210506195910.qtaz2h3xpbeeojoj@kafai-mbp.dhcp.thefacebook.com>
References: <20210506015824.2335125-1-kafai@fb.com>
 <YJPr4ykRPCCQ4s0P@krava>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJPr4ykRPCCQ4s0P@krava>
X-Originating-IP: [2620:10d:c090:400::5:7865]
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:7865) by MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 19:59:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe16878b-62d5-4ca6-922f-08d910c96b30
X-MS-TrafficTypeDiagnostic: BYAPR15MB4119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB41192228A57A40053D0AA3C9D5589@BYAPR15MB4119.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/v0j1FfyVdRmnOXcPWJP7f+uglclVIkvgbMW+mS6OnFW9BSFNR0sz6+vhHUpJshrXKYfMr6UJt27rTl5k27DsiN3hLFaHvBsi74GH6DJ1xijGnncihL7438cIJRCAsEKmz8JlxapbAwN6SIq9SeiN8uF8tkiY5ufu59MgH4ZWdV0QDeHYflxJgY6tLHcCdKmy4jQIdCZVuZ8Mvo+8h1EN7oHmWql2PoaLfF8mpF7ktyepvc2wOusbzFgPbtckd5zCV2npPhm+L+CfR4xkG2VBTapteZI9GKHsKBwOAraBmGZqgzlRkmY316pMe9SDNxs4ZZCzBPl6dxrFZVNEfJ/OxT6YknKLKhH+MhhvaOuuOQWrk+B1bQZsy1qFfThdKlfDNBINw5FyVsG8XmhUlmOu4VAtRWHP92HcZ4WsbOEEVEhZ97wbhr9Fjv+hBjwZ+lLvxjSTEt/5PlJCwV1cfMMIsSUor3t45AQAc2YfPj+gvvd2ZSBmrLgOgmU+ysswrba+3CozdZt6OvEjwqrjFDwnfNxn6KdxmeS4TrIlumexCKdXWdmp3Yj0sh6rQg9mlh0bvaxY62I5MhC1f2QcWgQK3cIMv29N0gnbLvTUtsZTTULc3UrlOqfwAK9KWZ4hM5AHeLX1ABMgY5kSNDaZzMLeLvkWw61HEwKYMzD0QD8yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(7696005)(6916009)(316002)(8936002)(16526019)(6506007)(52116002)(8676002)(66556008)(478600001)(966005)(66946007)(66476007)(2906002)(83380400001)(4326008)(5660300002)(86362001)(9686003)(54906003)(1076003)(186003)(38100700002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HFb73GjnOcMcf4VHEtGxmrKPnaUshhZk+qdxqpsdKbS6AyhfksDPA1vp+mCT?=
 =?us-ascii?Q?dQhLvyCggZVrcauTSsiDqjfIzmUl1a8Ab1aE0MJqgrQGgasHO+16DYVVLhvj?=
 =?us-ascii?Q?zt3sKIAI2QtQ06qlCQmHDgRm/Qvj4wGac59YLjKQ87xPiM8YI+29aUX45awX?=
 =?us-ascii?Q?59b5P38zZ4eNTW/Y45xxnoc2txYoDz6Un3ZnCCzGYv6c9+IpIrn5HxEKU2nG?=
 =?us-ascii?Q?HKz8z0I7jn0uS3Dks7PUCab303n6UsG5i7sMhojloH8XlHhShVnSRE7GpoQ1?=
 =?us-ascii?Q?AW+OYDParVmTEMhoKzByIiitpSZ42Usg1jEzVA4NO0/vy8uXHnAhD8qHfE9s?=
 =?us-ascii?Q?TAnG52JR3teDDyhXnhAYBD7ZG+WfQc7IsaqOgBl9nZS0MpuT6+aRhpMQry2j?=
 =?us-ascii?Q?R4G+gI72YglBOA2NxqJcOuKp57DzWbeXM6Kdh5nLzyrs+K5ynRkGWQKZeJtU?=
 =?us-ascii?Q?p4TZkQaRlNi4jexiLVQ4T82UqoWwndixxsTU6rHNSpP7QeOoWGlkRg1RP9Uf?=
 =?us-ascii?Q?h0Wu+zLRnQY/D/ZGu2THIIFlgk4IyDKL4+XO6z8ya4YFhsDdmmdDHZYMduD8?=
 =?us-ascii?Q?supIn1QJo6SZyqQUMzYU857DeBnil8Be4ASBXOtvPwaji147JRwAQFVw9B3U?=
 =?us-ascii?Q?KfoRq6OerrnE9ipM1cgvofWEg5Pqxw3s3rVj7ziaxxRZeIh7q88g59UKpF48?=
 =?us-ascii?Q?3fVk2+SaChDa4WqWsUu+huTKTS9QDx8+WyWICZ+i9UK21mmnIuXCBAdOGK0v?=
 =?us-ascii?Q?gBAqahfVtkhh7Aw8gazNpgaHpM+LNaHyP40TE27KDJzRuDHKKkSvDCFLSIsG?=
 =?us-ascii?Q?DQ29QrON+CHtygiOOUGRRTACbX6qdnt9CPTy5MLK9cZAGMGyrjalhVhapQgA?=
 =?us-ascii?Q?OHV7ON5qocTT52hwFs/sOj/4DgnrngiLOYBWOYfFmNvc/p2vT3wGKYgHTokA?=
 =?us-ascii?Q?WOvxvwejazxpZ/jUzby5oxVJsc+Fe2WiRF3J4Y3mOkjjkhf+u8cbVKPWG8pI?=
 =?us-ascii?Q?UPywnssvyKykpJCCmvCsmipRaxqzoyWHMWcV8PxIMWF7O+J+VruAgwzjiUne?=
 =?us-ascii?Q?9o8qVN1moHTKtvgLjiWuT61e7nHF2btKoXuZHoyo1wjSwOK4OJmYNxl+KaVb?=
 =?us-ascii?Q?VNzYdwHER7U5lKSFqdR5DhJPGD5DQT7Fg6EUHb0dJBQMFBGxSjjEyCmgj00K?=
 =?us-ascii?Q?WQpSB9lYMQ7k2Af1OhPRHnHw7pfz/KkW+6jPWD+7eBlkKv6kk+7WAzSwVP4L?=
 =?us-ascii?Q?V/1WMYphvMOnrdXLqWTePKQkAwEVw3NG/6FdWC9coR7W+HwE/O1Rya8whf6H?=
 =?us-ascii?Q?q2+xCzWp7H8cMbPWFi1DsBLwZWgKhUQo1fnBtaW9Z0KgMA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe16878b-62d5-4ca6-922f-08d910c96b30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 19:59:12.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzAo7XQ1CWdi+cymniO9Xv+MbpsKQjDjYGvQlPe9J7+pb3RUN8ce9hDJ63D44dnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: aAu-Vs4QD2Z01g6F0OxiP4Y_xOyR29Ix
X-Proofpoint-ORIG-GUID: aAu-Vs4QD2Z01g6F0OxiP4Y_xOyR29Ix
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=950 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 06, 2021 at 03:15:15PM +0200, Jiri Olsa wrote:
> On Wed, May 05, 2021 at 06:58:24PM -0700, Martin KaFai Lau wrote:
> > BTF is currently generated for functions that are in ftrace list
> > or extern.
> > 
> > A recent use case also needs BTF generated for functions included in
> > allowlist.  In particular, the kernel
> > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > allows bpf program to directly call a few tcp cc kernel functions. Those
> > kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> > is set to ensure they are in the ftrace list but this kconfig dependency
> > is unnecessary.
> > 
> > Those kernel functions are specified under an ELF section .BTF_ids.
> > There was an earlier attempt [0] to add another filter for the functions in
> > the .BTF_ids section.  That discussion concluded that the ftrace filter
> > should be removed instead.
> > 
> > This patch is to remove the ftrace filter and its related functions.
> > 
> > Number of BTF FUNC with and without is_ftrace_func():
> > My kconfig in x86: 40643 vs 46225
> > Jiri reported on arm: 25022 vs 55812
> > 
> > [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> > 
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >  btf_encoder.c | 272 +-------------------------------------------------
> >  1 file changed, 5 insertions(+), 267 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 80e896961d4e..55c5f8e30cac 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -27,17 +27,8 @@
> >   */
> >  #define KSYM_NAME_LEN 128
> >  
> > -struct funcs_layout {
> > -	unsigned long mcount_start;
> > -	unsigned long mcount_stop;
> > -	unsigned long mcount_sec_idx;
> > -};
> > -
> >  struct elf_function {
> >  	const char	*name;
> > -	unsigned long	 addr;
> > -	unsigned long	 size;
> > -	unsigned long	 sh_addr;
> >  	bool		 generated;
> >  };
> >  
> > @@ -98,250 +89,11 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
> >  	}
> >  
> 
> we could also remove sym_sec_idx/last_idx right?
> it's there for the sh.sh_addr, which got removed
Right, I will remove them.
