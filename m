Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557ED1FFF92
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 03:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgFSBMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 21:12:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbgFSBMV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 21:12:21 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J15m17018904;
        Thu, 18 Jun 2020 18:12:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PodK4b9bSE3Pv9Wz+pdiOyR+SH2lF0tCtUsmMgH0sng=;
 b=LWVmbaUgz4LcszEQJGo/EeCHH351Q+7erL2GI5yHODo9Fd2tnj3aBG/Xx8GtqkofY7vN
 JNLlV8NheE7TV0PsE0kixIbQ/H7tCgFE/F02UfmEVQ+MlLl8k82eYR2RJ0jvVAVeGMIz
 I8x/VN6kARuBnkpqj3lTIy+Sk9STOGmAMjU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660ycrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 18:12:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpgapQ33h7S2cYcS6BG+lNdCXzcJz4qwOHwfdCoDiCZx7/npmjCH2aoPSsR89zjvkuZFNRfzvzXz7I1emr3IBwa7mzomWfw8FxgJSQ5+sh4n1yQPstQalLhG2Z9z5oEyafW/FTeSQWdQVsYt26fSG6cR+TaNXo2jmraXgY7pJZcBMyHvhz/svYFKTcBv06lIzEDYjzlFao/C/SFvLokcYOmQLy0YwqcNyToALaN9LNMokTVeuEms/7Cmmww8kVV27diYe5vxsOw+k7XMzoJJDB7dD6B3TMJ8f8nGytEAfiyn032X9mV5kZ5lJ3Z1RlaXFPnX3UkzK1gCC6icH+ub3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PodK4b9bSE3Pv9Wz+pdiOyR+SH2lF0tCtUsmMgH0sng=;
 b=js5g4+nxtNbPylRCPp0TAfCjRkWjy0kHTJB9SQdlAydHxg+GXBO2VHqvAMYOyZS26gowd+EY0xIocLPaFFDXmc3t84OTJ+b2NQ6tfMzQr+Be5z2MhqUSkR8cYaSfT6+uJmcgYcWzqQYUaUjkpFpyVMPYsGGzpAPlsE0iAjPkwo3pa7lxyYnXTH4JqQcSIPfWir01J3tO6mPcwZcRDJ/lCooAytKrbW7j9Lm76yFH5p90cBOgD1kgM0peAPgxEEjepr8S8MmfNfb1WmVjvPIzJbs5oEVFK+veOiMKklwXhKsnwV7aZbEtalsekhCsZ9vybb9tQFZtft+KGH0es5PPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PodK4b9bSE3Pv9Wz+pdiOyR+SH2lF0tCtUsmMgH0sng=;
 b=bFDP7HjTG+xlUIvfsJ2vt1c48fDhd9czmxQJhxTpAde/jFqPzZ2R8HSZQcGxeYxKx87EEf+4vzuULXKXcebOWOwJYaqJnHK7dEXG9fV2yavIOTKujLT05Wyr7EF3f8yjlj8POlbD0tAXBvhLUOQrgZ1hYjjaz2ZqFz2SZB4sjGI=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3189.namprd15.prod.outlook.com (2603:10b6:a03:103::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 01:11:58 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 01:11:58 +0000
Date:   Thu, 18 Jun 2020 18:11:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
Message-ID: <20200619011156.cugplis7r64pwzbj@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
 <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
 <CAEf4BzbHqzyurRnFSiKpR4Tb0v-QG36hmcwYrJUFzNu4nY3VDQ@mail.gmail.com>
 <20200619002743.GC47103@rdna-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619002743.GC47103@rdna-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by BYAPR07CA0029.namprd07.prod.outlook.com (2603:10b6:a02:bc::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:11:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eae9921d-3b05-48ba-b366-08d813edc342
X-MS-TrafficTypeDiagnostic: BYAPR15MB3189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3189B29C42C7E08B5ED09F7ED5980@BYAPR15MB3189.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzi8+W3+x5Z6BOPD94qyV76nqV+qfEnWKM1feaaLW4EHr6UgNq8XJAjouiabZdLmgnHSHwMk8ky1ttspjVtHRblKhan1GkKcBUVNO8ioJdsAbARgAhsv/tutOq88pn8VSWnyQ6m4DKIpdqSFtyHt7q229IE1Ztrifeoc1XbNPlQt+TXMYoxDF0/jHeP7ZRAJhWJzThkEHKBmgxhu1frvBDrXIsFICCCsKfu80Cr6JzD8TJWmv10of14OFTIuXV+zVanRfCxyyCqT5vEmAjCTeU3U3nxdNb5EC1b/SPZvksZ/YMySE07yOhbXwSnXuV+7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(5660300002)(6862004)(316002)(54906003)(4326008)(9686003)(83380400001)(8676002)(55016002)(478600001)(8936002)(186003)(2906002)(16526019)(66946007)(66476007)(66556008)(86362001)(6636002)(52116002)(53546011)(6506007)(7696005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NLTjArwcVSDvpIVQaPmOB+H3/IWTxMcslz4IxZdb2qHgTCdECBqxpNzvRmZbz/lZ1q13bxgyTMmIgOp7YgNcMICwXDUfqcXepbkdG8BlEHtxjANsHCiBeAFQQRNmtq4SivNSGDMcmeRH/g1oiBZCNvm1kJ1dBD9lS0VBCsUCqtN6o3CVMBCiJFTFksh8dJxBbXt5oYLUssE7SyAWZemNok987dpF4rZY9PG98l5nGRTFChuwHq7LuqdG/LAqr9X/ecqkgkgiiDqWCJ6mLFHx3HMGxXupV74OeXL00r0aLWKO6BxmYcSD2gkcV0bFgyBs+lf9TXaUNqEuRxR5PWmeWbtEFuu1rdJooq2ZAnkoJuf16e9hWpM5IhTIRR7Di6neALYH1ecy8zAR1h2H9gd9h2X/2I04ywq2rGmWs4uxLwWrf/jYmt9qiKeRg9uQrQY4rjTw+foh0BrpBJfK/BPHAAIIfDROMKB+VRp1yVf94TFoC3DJWdbmXGZ2BfMHdnoDoH1C6499uZ0S+n8gpB1pfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eae9921d-3b05-48ba-b366-08d813edc342
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:11:58.0028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo6wX75NLC/vLTfCZCQDikq1J3LXflglVDJEokNcpgjOZKXKi/cF6p4UXlNIkEgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 05:27:43PM -0700, Andrey Ignatov wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2020-06-18 17:08 -0700]:
> > On Thu, Jun 18, 2020 at 4:52 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Andrey Ignatov <rdna@fb.com> [Thu, 2020-06-18 12:42 -0700]:
> > > > Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> > > > > On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> > > > > [ ... ]
> > > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > > index e5c5305e859c..fa21b1e766ae 100644
> > > > > > --- a/kernel/bpf/btf.c
> > > > > > +++ b/kernel/bpf/btf.c
> > > > > > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> > > > > >   return ctx_type;
> > > > > >  }
> > > > > >
> > > > > > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > > > > > +#define BPF_LINK_TYPE(_id, _name)
> > > > > > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > > + [_id] = &_ops,
> > > > > > +#include <linux/bpf_types.h>
> > > > > > +#undef BPF_MAP_TYPE
> > > > > > +};
> > > > > > +static u32 btf_vmlinux_map_ids[] = {
> > > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > > + [_id] = (u32)-1,
> > > > > > +#include <linux/bpf_types.h>
> > > > > > +#undef BPF_MAP_TYPE
> > > > > > +};
> > > > > > +#undef BPF_PROG_TYPE
> > > > > > +#undef BPF_LINK_TYPE
> > > > > > +
> > > > > > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > > > > > +                             struct bpf_verifier_log *log)
> > > > > > +{
> > > > > > + int base_btf_id, btf_id, i;
> > > > > > + const char *btf_name;
> > > > > > +
> > > > > > + base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > > > > > + if (base_btf_id < 0)
> > > > > > +         return base_btf_id;
> > > > > > +
> > > > > > + BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > > > > > +              ARRAY_SIZE(btf_vmlinux_map_ids));
> > > > > > +
> > > > > > + for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > > > > > +         if (!btf_vmlinux_map_ops[i])
> > > > > > +                 continue;
> > > > > > +         btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > > > > > +         if (!btf_name) {
> > > > > > +                 btf_vmlinux_map_ids[i] = base_btf_id;
> > > > > > +                 continue;
> > > > > > +         }
> > > > > > +         btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > > > > > +         if (btf_id < 0)
> > > > > > +                 return btf_id;
> > > > > > +         btf_vmlinux_map_ids[i] = btf_id;
> > > > > Since map_btf_name is already in map_ops, how about storing map_btf_id in
> > > > > map_ops also?
> > > > > btf_id 0 is "void" which is as good as -1, so there is no need
> > > > > to modify all map_ops to init map_btf_id to -1.
> > > >
> > > > Yeah, btf_id == 0 being a valid id was the reason I used -1.
> > > >
> > > > I realized that having a map type specific struct with btf_id == 0
> > > > should be practically impossible, but is it guaranteed to always be
> > > > "void" or it just happened so and can change in the future?
> > > >
> > > > If both this and having one more field in bpf_map_ops is not a problem,
> > > > I'll move it to bpf_map_ops.
> > >
> > > Nope, I can't do it. All `struct bpf_map_ops` are global `const`, i.e.
> > > rodata and a try cast `const` away and change them causes a panic.
> > >
> > > Simple user space repro:
> > >
> > >         % cat 1.c
> > >         #include <stdio.h>
> > >
> > >         struct map_ops {
> > >                 int a;
> > >         };
> > >
> > >         const struct map_ops ops = {
> > >                 .a = 1,
> > >         };
> > >
> > >         int main(void)
> > >         {
> > >                 struct map_ops *ops_rw = (struct map_ops *)&ops;
> > >
> > >                 printf("before a=%d\n", ops_rw->a);
> > >                 ops_rw->a = 3;
> > >                 printf(" afrer a=%d\n", ops_rw->a);
> > >         }
> > >         % clang -O2 -Wall -Wextra -pedantic -pedantic-errors -g 1.c && ./a.out
> > >         before a=1
> > >         Segmentation fault (core dumped)
> > >         % objdump -t a.out  | grep -w ops
> > >         0000000000400600 g     O .rodata        0000000000000004              ops
> > >
> > > --
> > > Andrey Ignatov
> > 
> > See the trick that helper prototypes do for BTF ids. Fictional example:
> > 
> > static int hash_map_btf_id;
> > 
> > const struct bpf_map_ops hash_map_opss = {
> >  ...
> >  .btf_id = &hash_map_btf_id,
> > };
> > 
> > 
> > then *hash_map_ops.btf_id = <final_btf_id>;
> 
> Yeah, it would work, but IMO it wouldn't make the implementation better
> since for every map type I would need to write two additional lines of
> code. And whoever adds new map type will need to repeat this trick.
I think bpf_func_proto has already been doing this.  Yonghong's
tcp/udp iter is also doing something similar.

> 
> Yeah, it can be automated with a macro, but IMO it's better to avoid
> the work than to automate it.
> 
> Martin, Andrii is there any strong reason to convert to map_btf_id
> field? Or it's "nice to have" kind of thing? If the latter, I'd prefer
> to stick with my approach.
I just think it will be more natural to be able to directly
access it through a map's related pointer, considering
the map_btf_name is already there.

I don't feel strongly here for now.  I think things will have to change
anyway after quickly peeking at Jiri's patch.  Also,
I take back on the collision check.  I think this check
should belong to Jiri's patch instead (if it is indeed needed).
Renaming the sock_hash is good enough for now.
