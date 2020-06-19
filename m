Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B011FFFEC
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgFSBxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 21:53:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14078 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730714AbgFSBxf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 21:53:35 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J1o5Ac020470;
        Thu, 18 Jun 2020 18:53:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oyA/OShy2eYVYecOLHcz7SWu0tgau8cs/epnLg+o/fk=;
 b=Nt+0NbkHJIKqVZlKD9hxpsvnElwotyj+5pS+6r5t4Unv//JGdoXOmt1VbkLQUVYuOZBV
 5T2tWpKf60T4waAA8RH8S4Nc3uLVJItY2XfiF9Q8YPQ5cNkr+wKUPFZ2nrMxTapOpeeU
 Puy9A6mLaLjp53LSRe/Pp5o5n5/nLH6ae18= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656qaee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 18:53:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Daz1KTRNs8DxoUkmrUskNTAPIYhCJhOzN9NjX6l84wiyOBoRrJwtFCQCV4E6cGMKJ9kF2JL3FnKPaxwf0FJnlAW4yG8MDglhGDF8KVchn76Tt+tpq7vZnyolY0nPQ3RI6UFKoS6+7iK5Ig7e5DXJnCgL1jZ9+bRXD9i1pYR02r7nywAjvXaAV/ojXcWeHBboNA6Qq1Tx4k2yFPEf5dXiKXinLTC/RzMlBsoLLCdyQP9SoJreqZfMJ4b09Z4n3scWi99JFo1GDTln+5ts53ut4Ki9OGTRjjeFqJ59p44WepBW4GPV+/6h32FSPawGuIDORLPMc0Q4/wmKlHWI+ajtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyA/OShy2eYVYecOLHcz7SWu0tgau8cs/epnLg+o/fk=;
 b=KPgI6tnSIMEdxgbMSz/gWWTiQVqqECUjTrKoD4DBQQSDp8Lbzsx2tkQUrF+Z1mGDCEbKMa3NtqITvsMs4SYX9LANRn0Dhkh2EnoDUizX9wZjJ2XbIahIkrzysr3mgMg9V+YISBZCUPiw1sLgh+GebDnnvumwKaoG+NpRuNs5pMLEdvOxNHZE6DF4zJlCbMihQgYeOOXeiL0GCOFKFTwNffLH06SPbysHrsFHFqXMD4kcBWdWonydq8P54WJ5OliDouG/uUoxfDTuV7LPzcpyt/1VZfna8ZrBS1nKeSDnIWGcMBC+1I5uK6gCDP1N4cX111fciw966So3ib+rNjrTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyA/OShy2eYVYecOLHcz7SWu0tgau8cs/epnLg+o/fk=;
 b=kOezR0GXq+gytvN7JDqZ7miw5NK+7c3U74pqHvfr1wFmdTOrq2N0d2eQNIt7DiyjFPW4snMIO/K+8oM2o91ZVFLjjAw5tmyuFbMCJKHnqsWRKUZLqcrt0FUARGllob6JF61BH3S7oJBYbZUXDTa7WqL8kVWM10uL+TkfT4ZJ9SU=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 01:53:17 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 01:53:17 +0000
Date:   Thu, 18 Jun 2020 18:53:16 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
Message-ID: <20200619015316.GD47103@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
 <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
 <CAEf4BzbHqzyurRnFSiKpR4Tb0v-QG36hmcwYrJUFzNu4nY3VDQ@mail.gmail.com>
 <20200619002743.GC47103@rdna-mbp.dhcp.thefacebook.com>
 <20200619011156.cugplis7r64pwzbj@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619011156.cugplis7r64pwzbj@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:142a) by BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:53:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:142a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538404db-ddd3-4c95-5ee9-08d813f3891e
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3512B7A5B3C8E3CF609AB5D2A8980@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPlIcdwymXVK6/mQdiaOKx+ZZWwpsTbPHlfMS72aToqLso1fh1DTX45/eHPkaALqSdzqKDoHDqVvPoZA2hBziF94CCWQ9H4xLPjtxOBYCRULp6YrcUtjgqZuZLhit1F1ZfqoZUxUhheyDuSKR0YlosHm5cfU9GjlON6t3uuPBr89E25pVXOUyt1XIUefj3TNW86CeAnmjMubyJGi+Cs0Ltmu8USKF9qnee38M6I+tM/IXAuwlm45J74lhrGH7aYVfgdm3m9vd54ZTAjxIBYOCbOk+slWcNajpDZ8CNNwTfb+w6arA60b1LwiDfoX6cKj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(1076003)(83380400001)(186003)(16526019)(86362001)(478600001)(66556008)(2906002)(8936002)(66476007)(66946007)(8676002)(33656002)(5660300002)(6862004)(52116002)(6636002)(6496006)(9686003)(4326008)(54906003)(53546011)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /eXAQvoZyWUY9D6aZPp0Q93qNyPxFaCmiYWhBIeFw6sShG9/tAPjaZDSRSk5sdw08OKtx/9rVK5BbNFHkwTkwmj263jo6OZ6uo/8Y1cZU1xLVM6FrH/AfSlepOMD4vZZCyzr+3DRY1hj5tfurQoiiRchnYcrtIicp7Jd/iRQuX+knkUVEY8pldtRHyTnRUZpU6xoB3il3Jh5Eaii0f+tdoBW+I94xxZx0hIQ2w9nD7wtItVZcD9LEE17ae822td3sbngG73qkrjqTgLJ2pkn3yZI4aYd7WDT3eCzM1lCY9UaESKtPNGW/PZvpTzQy5zpQmK0DXyKvXmfYOqe9OY7tG/KpOuhaFhoKJg0KEiXabd3pYsdZBM7F1Dvmz/1TDp/XEoU7fZFCHkagcK2Vp5kQtoY2vRXl1kmsotdCjnyHkljuJRNH8dMtqln852yAY8oePEQe95sOKjxfFKOTH3belhWS3tBpqtdcZczhBLpGwCAGEF4oy+ztpcWQomVNliTzTx0qNfMvRz4EWMCLffcgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 538404db-ddd3-4c95-5ee9-08d813f3891e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:53:17.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onR/90MYqabLzwse/sRNZ7InT1WwjksV6kdVKmn2EvcwmRTcYUqhw9d1F5dYucY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190011
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> [Thu, 2020-06-18 18:12 -0700]:
> On Thu, Jun 18, 2020 at 05:27:43PM -0700, Andrey Ignatov wrote:
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2020-06-18 17:08 -0700]:
> > > On Thu, Jun 18, 2020 at 4:52 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > >
> > > > Andrey Ignatov <rdna@fb.com> [Thu, 2020-06-18 12:42 -0700]:
> > > > > Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> > > > > > On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> > > > > > [ ... ]
> > > > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > > > index e5c5305e859c..fa21b1e766ae 100644
> > > > > > > --- a/kernel/bpf/btf.c
> > > > > > > +++ b/kernel/bpf/btf.c
> > > > > > > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> > > > > > >   return ctx_type;
> > > > > > >  }
> > > > > > >
> > > > > > > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > > > > > > +#define BPF_LINK_TYPE(_id, _name)
> > > > > > > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > > > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > > > + [_id] = &_ops,
> > > > > > > +#include <linux/bpf_types.h>
> > > > > > > +#undef BPF_MAP_TYPE
> > > > > > > +};
> > > > > > > +static u32 btf_vmlinux_map_ids[] = {
> > > > > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > > > > + [_id] = (u32)-1,
> > > > > > > +#include <linux/bpf_types.h>
> > > > > > > +#undef BPF_MAP_TYPE
> > > > > > > +};
> > > > > > > +#undef BPF_PROG_TYPE
> > > > > > > +#undef BPF_LINK_TYPE
> > > > > > > +
> > > > > > > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > > > > > > +                             struct bpf_verifier_log *log)
> > > > > > > +{
> > > > > > > + int base_btf_id, btf_id, i;
> > > > > > > + const char *btf_name;
> > > > > > > +
> > > > > > > + base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > > > > > > + if (base_btf_id < 0)
> > > > > > > +         return base_btf_id;
> > > > > > > +
> > > > > > > + BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > > > > > > +              ARRAY_SIZE(btf_vmlinux_map_ids));
> > > > > > > +
> > > > > > > + for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > > > > > > +         if (!btf_vmlinux_map_ops[i])
> > > > > > > +                 continue;
> > > > > > > +         btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > > > > > > +         if (!btf_name) {
> > > > > > > +                 btf_vmlinux_map_ids[i] = base_btf_id;
> > > > > > > +                 continue;
> > > > > > > +         }
> > > > > > > +         btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > > > > > > +         if (btf_id < 0)
> > > > > > > +                 return btf_id;
> > > > > > > +         btf_vmlinux_map_ids[i] = btf_id;
> > > > > > Since map_btf_name is already in map_ops, how about storing map_btf_id in
> > > > > > map_ops also?
> > > > > > btf_id 0 is "void" which is as good as -1, so there is no need
> > > > > > to modify all map_ops to init map_btf_id to -1.
> > > > >
> > > > > Yeah, btf_id == 0 being a valid id was the reason I used -1.
> > > > >
> > > > > I realized that having a map type specific struct with btf_id == 0
> > > > > should be practically impossible, but is it guaranteed to always be
> > > > > "void" or it just happened so and can change in the future?
> > > > >
> > > > > If both this and having one more field in bpf_map_ops is not a problem,
> > > > > I'll move it to bpf_map_ops.
> > > >
> > > > Nope, I can't do it. All `struct bpf_map_ops` are global `const`, i.e.
> > > > rodata and a try cast `const` away and change them causes a panic.
> > > >
> > > > Simple user space repro:
> > > >
> > > >         % cat 1.c
> > > >         #include <stdio.h>
> > > >
> > > >         struct map_ops {
> > > >                 int a;
> > > >         };
> > > >
> > > >         const struct map_ops ops = {
> > > >                 .a = 1,
> > > >         };
> > > >
> > > >         int main(void)
> > > >         {
> > > >                 struct map_ops *ops_rw = (struct map_ops *)&ops;
> > > >
> > > >                 printf("before a=%d\n", ops_rw->a);
> > > >                 ops_rw->a = 3;
> > > >                 printf(" afrer a=%d\n", ops_rw->a);
> > > >         }
> > > >         % clang -O2 -Wall -Wextra -pedantic -pedantic-errors -g 1.c && ./a.out
> > > >         before a=1
> > > >         Segmentation fault (core dumped)
> > > >         % objdump -t a.out  | grep -w ops
> > > >         0000000000400600 g     O .rodata        0000000000000004              ops
> > > >
> > > > --
> > > > Andrey Ignatov
> > > 
> > > See the trick that helper prototypes do for BTF ids. Fictional example:
> > > 
> > > static int hash_map_btf_id;
> > > 
> > > const struct bpf_map_ops hash_map_opss = {
> > >  ...
> > >  .btf_id = &hash_map_btf_id,
> > > };
> > > 
> > > 
> > > then *hash_map_ops.btf_id = <final_btf_id>;
> > 
> > Yeah, it would work, but IMO it wouldn't make the implementation better
> > since for every map type I would need to write two additional lines of
> > code. And whoever adds new map type will need to repeat this trick.
> I think bpf_func_proto has already been doing this.  Yonghong's
> tcp/udp iter is also doing something similar.

Right. I see bpf_func_proto.btf_id now.

> > Yeah, it can be automated with a macro, but IMO it's better to avoid
> > the work than to automate it.
> > 
> > Martin, Andrii is there any strong reason to convert to map_btf_id
> > field? Or it's "nice to have" kind of thing? If the latter, I'd prefer
> > to stick with my approach.
> I just think it will be more natural to be able to directly
> access it through a map's related pointer, considering
> the map_btf_name is already there.

Ok, let's keep it consistent with other struct-s then. I'll switch
bpf_map_ops to use same pointer trick.

> I don't feel strongly here for now.  I think things will have to change
> anyway after quickly peeking at Jiri's patch.  Also,
> I take back on the collision check.  I think this check
> should belong to Jiri's patch instead (if it is indeed needed).
> Renaming the sock_hash is good enough for now.

Good point. I'll remove duplicates checking.

-- 
Andrey Ignatov
