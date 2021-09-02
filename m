Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484C63FE92B
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhIBGRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 02:17:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54328 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhIBGRr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 02:17:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18264UGB018341;
        Wed, 1 Sep 2021 23:16:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5p7KF8yUuw1qb4aHR80nCwOqK2a4Cv278jUlYuvrNhM=;
 b=UMm/orWd0nj5Urx1EBF5QRRi6BaX3xczSQyAwtdqSw0EhTgzxkI5VslVkGo0bFPjHK6v
 PRKibgy0/VPr1224aqCWTMMsed1y5R3tqEnC6gRhbLJAEHPtL3p7XznDvZcygF44tePP
 KHVuewtbjRRDSkI1rgU+aOmiFaq1iUY+8fc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdwtyr40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Sep 2021 23:16:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 23:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXVDNOTcFl5VsUdFiB2m/OGIRd/aRsdzFoOrtQFK4NRJMNY2Zh6hqAyjeA+NNZif9pqgVDdZTwFPN9diOdK9uB/r6PxNzz7zLk00lNJIydHxh/n5ya62SZu9upRmdrqPLVzOOHDsNdgbqxaLcLnpfsr83oGap6KmlCvDzVSPZPjkzeEtc/1fus2nG5y2h10sLI+I66d+GAR+aBmD5Fpp1Au0i01Wqnodfeqw9LK7qu2sslTww8NlY9oYFzfPuIBRxP7ugY97k9oIueeYhyaUMIdG7eKaX+CW2gl7BWcCEHgtSXi1Pni147NoyWXtric16tsMb/f+PvOw8vlWrT18ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5p7KF8yUuw1qb4aHR80nCwOqK2a4Cv278jUlYuvrNhM=;
 b=Mvng8fs6lu9EagbpPu25xVpob5OkzqE8ggVZcJ2Q1C3FBKjVjDUmSHMYGBKP5FetyvDzS/eqEq52UO4jYutC9/E8KMqbccvohqvYRXBKLSO+K8NXB5/5K3BDXdn6I7WFqOOIeW61MajgBZGBoA6p9dQrYb4rXalWBsDO3VTSJLYtut+lk9PUSTM/dYx6wLBbnx9fbKQeMb1N2X/aHw33NTjPm+Ic5HeRs14tgQsypmAzkPS5ZateGEFGdKgwEktMvf0aAY7mbcEZF6Kt5hQ7A9ejI178wNcgIGDPBv4+qFiG+Ee2jkQ3W/RnsQ50yc9FJ+viOYyCQK1witpibUCuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB4142.namprd15.prod.outlook.com (2603:10b6:805:e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 06:16:46 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 06:16:46 +0000
Date:   Wed, 1 Sep 2021 23:16:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210902061643.h2o67abkwn26d66a@kafai-mbp.dhcp.thefacebook.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
X-ClientProxiedBy: MWHPR17CA0074.namprd17.prod.outlook.com
 (2603:10b6:300:c2::12) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a1b) by MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 06:16:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0bcb52-9242-48e2-57c0-08d96dd93df7
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB41427570DD5F788D16C758D4D5CE9@SN6PR1501MB4142.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS8aEPmoRVmmaGW1pp9131WavwgrEf54j6lPSMKiVYq3NFe2TGmVZG48YQiQxf+bM94GO6dLszHl0ZOgwFOtNjjwBiCxk9dSGzkA9FdP6T32/OrPb2VUG4Qo7dUdhGsUdlOwcC2CAia0NSoe5gbQk0Ep783M8IJKZD7qVNI6MHovVhQS9vthTrscpOIjyv4Rm5bQQs2LKhtVnc42LMpkuTAUsbHXgIgx+Urb1/TMTR9mZBodLZfH1qtg/V8IeJn+GVdmLy0ZAmrBJxgz/INW+f3AtLYYWhU7rhGyhPNBieN59xFnFT3IvkO2SYw9Hjkf189eMG+jMqZrgAVvNpekkMsEmWMfB6ioNOC1tV3o49HNB4Xq69OC1j2hM9j0qOUc2JbVf0WzCo60m9TOLqLFvfBvc1RfFYO5c2Yvistrf/ODTtRUGY8EhjnaLuImtqrCgtN2wWHfeN857v06QjOgnMsmaNblrCfe6SQ2cLBpPYUDloo8T0eXT6ZQI42zO5UkTYAJKNI4tTtWKYxFGd0jhQq+oorCCfcCMc68HrWI/wqKtKC99pse8KpwAOP0Eqh2ulUqzI9NvSxbbkwI8lmfezNi/Gr9yKk/rwsJoC2fE6zPukawzvodCejNwDs+jLwymPyE8lnH3iJl6W6VG931oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(478600001)(55016002)(316002)(6916009)(54906003)(2906002)(5660300002)(4326008)(1076003)(83380400001)(66476007)(66556008)(66946007)(9686003)(6666004)(86362001)(38100700002)(6506007)(8936002)(8676002)(7696005)(52116002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbIKxNAF2Fz+PUOe91ttku387sdRzbdRGtQCAXm3S6eTxKfU9GZ+SNxuZCFZ?=
 =?us-ascii?Q?SICkhwHU+3cQPxY4PFBySksf/kQh4A5zv8Ix47AY5rKV58HP5j7z8wNi5TU/?=
 =?us-ascii?Q?wlZbvY/Dm0UyF1Iq8kYikEACJN/cvpuK87K0q/X48Lg2Izk9xdziV+T/fX8b?=
 =?us-ascii?Q?ZkMkL8O1utSNMksr2EEnfcZLHEGg8gPPK8TvaHG4kvB9hbqhV4RehnbPRQD0?=
 =?us-ascii?Q?rbUyB2Mld8PBCI2GGZOtov2ymw0fCnouEZ+9ET96yqozfhSROXPa+WcylJ7c?=
 =?us-ascii?Q?F16BM/w3t+X1gFxq5y3zJHNlIKculABBarFGC5R9iahzMx9zktJjom+Ke6Nf?=
 =?us-ascii?Q?XS720JFJYCRWa1eGLqen+1z6Z/KqNR2CNOyggUV4Ff/7ZHgv/sLpQUF4sZvg?=
 =?us-ascii?Q?6jE93MA3qsrqLnkOkOYrn+XG2yL7Q2JVDFGbH9n/tcroscncVH7QnJu5/EmE?=
 =?us-ascii?Q?X8w0/8I91zPniLGVpBOUR1jpWE+y/pF8G4gQwUVsaxXmNcQzvgacJ6Xd4CKh?=
 =?us-ascii?Q?p3N8++j/KvmfL7RFyicYQ0jEKorWCPHwQJz2+5suSSZmZ2lInXzy7xrbsEes?=
 =?us-ascii?Q?2Okl8Q4ZAba6cXTSlhL0aqOiH3PU0pORDHWC1qcEtc0LGF7sCLgcqQ3T9ODD?=
 =?us-ascii?Q?TZzkLt9kn7i7U1qUGMgu5Wd/mmmLVWzAc0WUNB6JDPGQZ0hFr1AkqZNI29J2?=
 =?us-ascii?Q?fSJQJjUZ/6RNJagpOrFgxT2mvA4ZXPTUYp077MJVhUUajrH7yaQ8AtEPLV1g?=
 =?us-ascii?Q?OqQm+hRDza+EmJlRBHOHEs7722zKdghRn+FMo/SPKDc56LOBtSE7PMdrG0PZ?=
 =?us-ascii?Q?oVMMgmvq5PffapL+yxx65C2pLMzCYl+blr24KSJLAOVLH4lJDVbdVQdJwhf9?=
 =?us-ascii?Q?YsEErv2Ir0h3Jhi78C4PQw0caQAxS0ZMtHMjYVbKTm+TsMFdid4Gda/DwBhk?=
 =?us-ascii?Q?xThYyLsjvRcaP9OAbMDo2PTv++/riwaqVVZBVUjVcH8N8GuLXkl2EmLkd26R?=
 =?us-ascii?Q?Ecg8mBZtWA0OORNGhk7LHjY5VzqR50fUcV4iEcKv4d0QjUyGL5B40daPlwnB?=
 =?us-ascii?Q?lOzhGdeSbhq75XXynVs3zHTxWj+qQcLfAag1PudtsPk8TD5vWXlSW+1haOGa?=
 =?us-ascii?Q?vWzvmQM/BjK2EEN0eH8NgwrKnBqhwTv50PC3RTPk5Vzd7mEvpwZBCBY7jrgF?=
 =?us-ascii?Q?1N+66BWM9Ftw0StushJKImXyIe5gSc3TRENZZjIf3sOj7HKffXMo/6W+Mx4T?=
 =?us-ascii?Q?HKKbCdf7a1TTryea+pNE+aE72kleCooi0IdxDr2CAQC31fFEBrp4oDf5365L?=
 =?us-ascii?Q?QrkwW24wGv6dICzBeHxrsTmfMosrHaJmasyyj74lkIaEeEC27RUym7ggHX7P?=
 =?us-ascii?Q?9uUz3P0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0bcb52-9242-48e2-57c0-08d96dd93df7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 06:16:46.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u04R1f22bPjtwDuXvZm208Cb/YyWvAvoCaE25H8namHr0tA/arY8L7wlJvEH5N/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4142
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: VKJlSQumQ4CYG81Cmtqid66IvF2xFBkm
X-Proofpoint-ORIG-GUID: VKJlSQumQ4CYG81Cmtqid66IvF2xFBkm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_01:2021-09-01,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 01, 2021 at 10:11:20PM -0700, John Fastabend wrote:
[ ... ]

> > > +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
> > > +{
> > > +       int numa_node = bpf_map_attr_numa_node(attr);
> > > +       u32 nr_bits, bit_array_bytes, bit_array_mask;
> > > +       struct bpf_bloom_filter *bloom_filter;
> > > +
> > > +       if (!bpf_capable())
> > > +               return ERR_PTR(-EPERM);
> > > +
> > > +       if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
> > > +           attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
> > > +           !bpf_map_flags_access_ok(attr->map_flags))
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       /* For the bloom filter, the optimal bit array size that minimizes the
> > > +        * false positive probability is n * k / ln(2) where n is the number of
> > > +        * expected entries in the bloom filter and k is the number of hash
> > > +        * functions. We use 7 / 5 to approximate 1 / ln(2).
> > > +        *
> > > +        * We round this up to the nearest power of two to enable more efficient
> > > +        * hashing using bitmasks. The bitmask will be the bit array size - 1.
> > > +        *
> > > +        * If this overflows a u32, the bit array size will have 2^32 (4
> > > +        * GB) bits.
> 
> Would it be better to return E2BIG or EINVAL here? Speculating a bit, but if I was
> a user I might want to know that the number of bits I pushed down is not the actual
> number?
> 
> Another thought, would it be simpler to let user do this calculation and just let
> max_elements be number of bits they want? Then we could have examples with the
> above comment. Just a thought...
Instead of having user second guessing on what max_entries means
for a particular map, I think it is better to keep max_entries
meaning as consistent as possible and let the kernel figure out
the correct nr_bits to use.

[ ... ]

> > > +static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
> > > +                                     u64 flags)
> > > +{
> > > +       struct bpf_bloom_filter *bloom_filter =
> > > +               container_of(map, struct bpf_bloom_filter, map);
> > > +       unsigned long spinlock_flags;
> > > +       u32 i, hash;
> > > +
> > > +       if (flags != BPF_ANY)
> > > +               return -EINVAL;
> > > +
> > > +       spin_lock_irqsave(&bloom_filter->spinlock, spinlock_flags);
> > > +
> > 
> > If value_size is pretty big, hashing might take a noticeable amount of
> > CPU, during which we'll be keeping spinlock. With what I said above
Good catch on big value_size.

> > about sane number of hashes, if we bound it to small reasonable number
> > (e.g., 16), we can have a local 16-element array with hashes
> > calculated before we take lock. That way spinlock will be held only
> > for few bit flips.
> 
> +1. Anyways we are inside a RCU section here and the map shouldn't
> disapper without a grace period so we can READ_ONCE the seed right?
> Or are we thinking about sleepable programs here?
> 
> > Also, I wonder if ditching spinlock in favor of atomic bit set
> > operation would improve performance in typical scenarios. Seems like
> > set_bit() is an atomic operation, so it should be easy to test. Do you
> > mind running benchmarks with spinlock and with set_bit()?
The atomic set_bit() is a good idea.  Then no need to have a 16-element array
and keep thing simple.
It is in general useful to optimize the update/push path (e.g. I would like to
have the bloom-filter bench populating millions entries faster).   Our current
usecase is to have the userspace populates the map (e.g. a lot of suspicious
IP that we have already learned) at the very beginning and then very sparse
update after that.  The bpf prog will mostly only lookup/peek which I think
is a better optimization and benchmark target.

> 
> With the jhash pulled out of lock, I think it might be noticable. Curious
> to see.
> 
> >
> > > +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
> > > +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
> > > +                       bloom_filter->bit_array_mask;
> > > +               bitmap_set(bloom_filter->bit_array, hash, 1);
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > 
> > [...]
> 
> 
