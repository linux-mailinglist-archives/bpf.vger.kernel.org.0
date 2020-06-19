Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2991FFF3F
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgFSA2C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 20:28:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728919AbgFSA2A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 20:28:00 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J0EMlO024120;
        Thu, 18 Jun 2020 17:27:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=It5IZBo9QPhprxtR/xBnGjbdHX86MXcaoMzET4BVqMQ=;
 b=pSEgp2DEnQUpGNEh8rKyPYQwFRDOwvTiCFdvIV2hkjXrjmvI9skIZLOeYA3XFgKegZ3j
 8SwPc5wNpEElXpOHbSe2BxSiZuUNLingUgAciNQeW2chjH/o6aEVyrG54bYzMjriIWz7
 SWloD58UApwQtoLZuT87TfHsvUYMeC8s63U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rg9jrn5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 17:27:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 17:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzgOrz6H1WqUHDylCNH5aPJKzBmB+Tlr+rzfbjF2ruUm/J64TKeUAQXLvNTbkqOvwYfS/K3In1qnClZWw1CIRoT+vs6fz6WiN1D8JAWjzH5QeFe/Zsstw4bkhO5ZatLD33ams1sasGvFH6/Rzzh0ICZBO+ldqJYN5BH93JO7DCxuM7b3WPwbqHSfTQiOq4gxEds5JapqRNX8/Vw2mUS2ZGaBlZNrvgWdHVO2q4aXRB+tAsPGIrnehU0WbSq6pAyORFBVG7WfDZfKJ2n2TYdON78bEFXM6v0eQJZEHkE/hcQdQI3breu0cfKieYNOpM2r1pENa7k+2qCFDOLivYjhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It5IZBo9QPhprxtR/xBnGjbdHX86MXcaoMzET4BVqMQ=;
 b=Ht9rmGqTrD0oFLdZVIU6xCoQh/FFOMCQ4EYxopzWJwnhiumhteOUEn6wghm54yKo4RYXGe4tq/Iux66B2mh0B+n0OHJxfNo1AUtJ5vJk+Q74c8TkTRZ7vVenrUsprm+e9qgtpTepMnKlKNDDr+A9zWynqasIYsd1Asym0Atk7T8UHEhUtLUycKB4Jq4PCfVYst6l6rgvUW7WV91tqtujMcfdMaDSw4SVBgcx987pWNGs7ppF8dZYVg0iF0b/upwhIF1/5wfN20aX66Sk9uUUbt7JNEA1ayGpIe/CMyPte5diUw87JK5uYgfNLUzWZW6VMyXWI4XjUKi3wu4tZ+QI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It5IZBo9QPhprxtR/xBnGjbdHX86MXcaoMzET4BVqMQ=;
 b=VsYhJsLNfesSlM/y/uryCTRjtMrwiDOJZRLX5a4R9klvqBRZh35GMFqCMDPwDJRSXsZ8tQiGI5SCbmBCR5fswgO+WUOxfQanMuOkw8ob/YUajTkVH4wB6b0y6+CGJXJXZ7DTo4/grrWATNGrKs5NMi/67cE0dSC0sKAH90Nl7Bo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3093.namprd15.prod.outlook.com (2603:10b6:a03:fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 00:27:44 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 00:27:44 +0000
Date:   Thu, 18 Jun 2020 17:27:43 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
Message-ID: <20200619002743.GC47103@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
 <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
 <CAEf4BzbHqzyurRnFSiKpR4Tb0v-QG36hmcwYrJUFzNu4nY3VDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzbHqzyurRnFSiKpR4Tb0v-QG36hmcwYrJUFzNu4nY3VDQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:142a) by BYAPR06CA0044.namprd06.prod.outlook.com (2603:10b6:a03:14b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 00:27:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:142a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebf59a37-ff81-4f75-ab3e-08d813e795bc
X-MS-TrafficTypeDiagnostic: BYAPR15MB3093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30930A638D281C7671C789CBA8980@BYAPR15MB3093.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ori4ruvgLN6GgswoV9d+2fXIQ8PIFIgiAAfyKZN0ZVQ+DPxUakC17LzUKAfeRjHTD4XHt8fGo/FFhdHzCQzz8nLovPWYtsgDGncLbz5u2igNq4+HQKqgSlSeIDLFozcmIeg+IJVLo/KDqYDK59ApJIiFO849ztDJ+VE2WlILo/AfAcesWbPyy0laSdVQXDkBrS5ob5DbpfD3AtOTmkOVXT5AwHT5MfkcxOs0/+Oif4l6j5DzPu6n+5Y2ZiHgLeYuibIn/jQhyqho/AA7w1l/c09GC7DQyVaL8WzssSbAtGPrh/Rfym+I+SddKYi2PjME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(52116002)(478600001)(110136005)(6486002)(86362001)(6496006)(66946007)(33656002)(54906003)(66476007)(1076003)(66556008)(316002)(5660300002)(186003)(8936002)(4326008)(16526019)(6636002)(9686003)(8676002)(53546011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wHYkKO+1pyQUoHwFGfAXa2Mmvz8vNsnuTuYPiAVSONQXqsbTgfaBQGkFIXJ4RTsFXSPLRH2kOHAed+4lqK2ph+aze2NgQYrsqQjLY6h6Rd3pvA3DbBz9IhpuvCbTU02LDHuBWplDowZoToo+w3/00iKC2gvSpS2kuxwOFWN2xcmnAPduBskiSjX1i7bKmBZ1HNhAsd7dGBHLjAIf8GQn1delT/5arqSuGAvYEGyesxGl1+lJi4vbNH96SRHOIA+g1PTMCQ9rTgPrbWr8ohTX3NWz9hCG0W7pLBkXMbHdHO4eNX5DFP9XkobgTqmqYWD7VkJ/ITuWpi9nBdy8u0O223nEVy+U3cctsajVyJ6Z0aj4IttXAgQDH4dzZKXcJvr8HPwHs3e+5cBU0W/3AOQwaI0q3wWEC7LrgjSPtYDab13glfb+LFLvIV8M4HpZLfWAaZbJ52/CiI0WxoNXTmGrk2tJU/+lsR5eiP3U37pOzgOHliRzftraBPq4sqUGQT/IYgDpCbc2Xu5QCL+tEmrhIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf59a37-ff81-4f75-ab3e-08d813e795bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 00:27:44.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B05fsK5IR/SLM4exvZwf+qmvJwtFLmalVMOPJcpsPstDP+6LJKWUQxRdaBDVJBSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3093
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2020-06-18 17:08 -0700]:
> On Thu, Jun 18, 2020 at 4:52 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
> > Andrey Ignatov <rdna@fb.com> [Thu, 2020-06-18 12:42 -0700]:
> > > Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> > > > On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> > > > [ ... ]
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index e5c5305e859c..fa21b1e766ae 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> > > > >   return ctx_type;
> > > > >  }
> > > > >
> > > > > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > > > > +#define BPF_LINK_TYPE(_id, _name)
> > > > > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > + [_id] = &_ops,
> > > > > +#include <linux/bpf_types.h>
> > > > > +#undef BPF_MAP_TYPE
> > > > > +};
> > > > > +static u32 btf_vmlinux_map_ids[] = {
> > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > + [_id] = (u32)-1,
> > > > > +#include <linux/bpf_types.h>
> > > > > +#undef BPF_MAP_TYPE
> > > > > +};
> > > > > +#undef BPF_PROG_TYPE
> > > > > +#undef BPF_LINK_TYPE
> > > > > +
> > > > > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > > > > +                             struct bpf_verifier_log *log)
> > > > > +{
> > > > > + int base_btf_id, btf_id, i;
> > > > > + const char *btf_name;
> > > > > +
> > > > > + base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > > > > + if (base_btf_id < 0)
> > > > > +         return base_btf_id;
> > > > > +
> > > > > + BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > > > > +              ARRAY_SIZE(btf_vmlinux_map_ids));
> > > > > +
> > > > > + for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > > > > +         if (!btf_vmlinux_map_ops[i])
> > > > > +                 continue;
> > > > > +         btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > > > > +         if (!btf_name) {
> > > > > +                 btf_vmlinux_map_ids[i] = base_btf_id;
> > > > > +                 continue;
> > > > > +         }
> > > > > +         btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > > > > +         if (btf_id < 0)
> > > > > +                 return btf_id;
> > > > > +         btf_vmlinux_map_ids[i] = btf_id;
> > > > Since map_btf_name is already in map_ops, how about storing map_btf_id in
> > > > map_ops also?
> > > > btf_id 0 is "void" which is as good as -1, so there is no need
> > > > to modify all map_ops to init map_btf_id to -1.
> > >
> > > Yeah, btf_id == 0 being a valid id was the reason I used -1.
> > >
> > > I realized that having a map type specific struct with btf_id == 0
> > > should be practically impossible, but is it guaranteed to always be
> > > "void" or it just happened so and can change in the future?
> > >
> > > If both this and having one more field in bpf_map_ops is not a problem,
> > > I'll move it to bpf_map_ops.
> >
> > Nope, I can't do it. All `struct bpf_map_ops` are global `const`, i.e.
> > rodata and a try cast `const` away and change them causes a panic.
> >
> > Simple user space repro:
> >
> >         % cat 1.c
> >         #include <stdio.h>
> >
> >         struct map_ops {
> >                 int a;
> >         };
> >
> >         const struct map_ops ops = {
> >                 .a = 1,
> >         };
> >
> >         int main(void)
> >         {
> >                 struct map_ops *ops_rw = (struct map_ops *)&ops;
> >
> >                 printf("before a=%d\n", ops_rw->a);
> >                 ops_rw->a = 3;
> >                 printf(" afrer a=%d\n", ops_rw->a);
> >         }
> >         % clang -O2 -Wall -Wextra -pedantic -pedantic-errors -g 1.c && ./a.out
> >         before a=1
> >         Segmentation fault (core dumped)
> >         % objdump -t a.out  | grep -w ops
> >         0000000000400600 g     O .rodata        0000000000000004              ops
> >
> > --
> > Andrey Ignatov
> 
> See the trick that helper prototypes do for BTF ids. Fictional example:
> 
> static int hash_map_btf_id;
> 
> const struct bpf_map_ops hash_map_opss = {
>  ...
>  .btf_id = &hash_map_btf_id,
> };
> 
> 
> then *hash_map_ops.btf_id = <final_btf_id>;

Yeah, it would work, but IMO it wouldn't make the implementation better
since for every map type I would need to write two additional lines of
code. And whoever adds new map type will need to repeat this trick.

Yeah, it can be automated with a macro, but IMO it's better to avoid
the work than to automate it.

Martin, Andrii is there any strong reason to convert to map_btf_id
field? Or it's "nice to have" kind of thing? If the latter, I'd prefer
to stick with my approach.

-- 
Andrey Ignatov
