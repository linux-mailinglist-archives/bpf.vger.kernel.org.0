Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CB416612
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 21:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbhIWToN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 15:44:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242796AbhIWToM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 15:44:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18NIt9Z2015841;
        Thu, 23 Sep 2021 12:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KEqNYUJsKCNkjLutPgzZrDY+TKz4OqNrhAShF1nsBCc=;
 b=TP+2OJUOIUtLApyWjYtqsgGvN4qIPOLtqZZ5EdW9T3QtZFbCzF/AtZ0t9Co+y02JLKuZ
 o722i8XNwZLHov4DGj6fHY7E34vDN3DmWuX3VwpW+fUu4ZCcE63BDKPGaP9jDslsqfZl
 9+h6kSyy7fbw7XyZJHZlysUr7Mh1aiPgHfo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b8j6x5s50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 12:42:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 12:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRNkOm6AeQZhmv3gyar/gBDns5w/3yOOtrduzEgASIUVkLy4jPHn06XK8/dyvYr7KxwioSkx7wGm2oi+rbDFsciJBsNl6ov+R9YHeM5Qv7H/Nv5NveV+e0WOb4T/EGawGwqFoGH5ZDzq7zSfWHwN6kR+5LOjh/QvSmA0j7BYHZs9SeJ4xP2f/LqhxLH+ShcvNklLzhEMajcHD/VgAHHVqFoFyF3aqoH4ccWxy75o0F2E+yYmvkISQ+IAemEN+FhcdOGs4OHezcLJWSnIdlRuH7AIxc+nv1BYvJxncFYV1Vtd8IBYlRmbWo3EEKgP9ekBVbmQHrrxptpzt7u4MWjzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KEqNYUJsKCNkjLutPgzZrDY+TKz4OqNrhAShF1nsBCc=;
 b=ZtUmZNox3RsbdyF7lUGCZ490v/KAomM+vZ/LViOjjxT/k4UKHOWLxte85PfuYND4ulZOvLbvhGHllbyPLQnM1b56LTl7AlvbIJWlJAUYDu4XlbrfxZ1pd4F6IPPi9cgw/fAkqbkqhLiWBVtJF4fDszu0o8HdQHXHn8M+EcH8YHp597B2dApVcRtbJOKRBcEV7eN2qludQy1y4xV3pphpHr+rHJfkUABEptMPo7QBgzSM4Yd2gTdD5Jx2s/0S08VJ7itCAVBGyBa/fyTW43kh5SH/YAn+F7uUOF0JCYCJSqSJ02HYJotCdbt1BD4A7LL+KHCGpLCh7RDr0S3V8Jve9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB2109.namprd15.prod.outlook.com (2603:10b6:805:3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 19:42:36 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 19:42:36 +0000
Date:   Thu, 23 Sep 2021 12:42:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
 <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp (2620:10d:c090:400::5:f3c9) by MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 19:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56161ebe-a94e-4335-3416-08d97eca4b7f
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2109B79E7DF68D27D1F80153D5A39@SN6PR1501MB2109.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isWSL+AdrI4PY3AHPZAZPGQWsPlUNCcSOQoxECwIRJdfxFtUCc1CYCOonTMVvHpgnCrdh4XmNZ3HY4YxXd9Iif1qPNAl1j0Zeyesz74lWU2mCONJg/om5fZlxUfskO5xJ6Mfus0mudZONCVdVPVsOOgG7NrRfIivKuvFuSG/x7FovSMBK9Vk0BJyJ5ai3dY1vi7jcgFeRgAD6N5v0gt4D2bs5dgAJsjEWgcN62JfDuhYLG4ow9jiyWWWl22is93EUWvbdNgnMy+uY1kt8WbECzszowCZyTTO+xcrVxT1DYtZjrsltX1mHIhBPJfSCmdxCp5FPWmb2sOYpr7ywbADzKCuu+mjN0NPTJfRtyLUHVC2j6Zj/DCrlpcw7a6pe3i2cJT74hAL6fHPozuv5QmR/FNTQPTxtqGA40RCgoB7ht0K3MuZrQKuJgV19WnCGvRoTMkTeqSc/1tF+0EO8R1FjJNheQ96/n5Fl+pgV40q6HNuakb/RW732CC0y4wag2xtbAwBtDnGTx17SHATEtndZlpLqSnyOJdD4nMK8j/2eXXaJ0mFo6LntHz5EK0ctIk7mi6YBwcrxC7k/iYKObvu+2fTcoy0LXze5Y2vb/oJ/gPkjkyJujejdUFsubbwUb1LqSsKbA9DlIZ4/y/O/lwc/dsq6XOE4GNEKd1osFaQctbDma7SseKhZKAhwj0ajBmI3hvYWtbrT2GY/SVI1TE/++SwrTcG7hKUOBRHFycExKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6496006)(83380400001)(508600001)(6916009)(55016002)(966005)(6666004)(9686003)(38100700002)(33716001)(86362001)(8936002)(1076003)(54906003)(66556008)(316002)(66946007)(66476007)(5660300002)(4326008)(8676002)(52116002)(186003)(53546011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vocYR1SxrDvdopRfltDnlCV8FNGcOIJ/GR+DQsYX/JnUxQmQS8ZCObj3A9Z?=
 =?us-ascii?Q?du+kfHOWwmzcBZEdiMkMkTRlxsfDLhbrqDVjxWehOZnSefaHBjxkok2Zdo0k?=
 =?us-ascii?Q?AfVpbhBv7Ws+a6gBsLBXU5RzZDqPeAr1oMIWGZ7e6Kqn68aDC7kBys6v0wBe?=
 =?us-ascii?Q?rjWMPaSGIRNCdCLp3AtVftEv73J18EEk8Q9utqM3/qAiLY7mBCqRM6fau3xX?=
 =?us-ascii?Q?vgPx/kQMPeRnla33xnd0BVnE4rGF6xtfXi0+v9l1GlSFxAEbM9LAqGv72RyK?=
 =?us-ascii?Q?Oi/G1uFSWhF6GT82b4/XC2CchSX8tgOFT6tKnQpycgaFjv7IA48CPScNQDZd?=
 =?us-ascii?Q?a4Jb/D7dHAd6M/WYhTSaXCBYjh6jiRWF6HSvs1Xzk2MnEBvIQPIzNOfDM+bY?=
 =?us-ascii?Q?RDC604/YE15kemj8u/s8NJzYUu+btQ09BEEpVSvNbqdHhbtjn/dGucRLqRuA?=
 =?us-ascii?Q?E448hZ/EIDinB1PfW9Cq6WcHPn9+InS5sm0vcTyAnR/8i4RM427tHvMcDtQY?=
 =?us-ascii?Q?yhueCxZY64FITDrdW4AVkWE0ZVqPv/RJia6OtZQY1EhvF9zXSxHLymibBQ6f?=
 =?us-ascii?Q?wxYQ/nqs1Pr4RdpaIjdKFwI/qPOaWzDgAY8ZWq3ilZ63DL2RPcKlHjQWWDvU?=
 =?us-ascii?Q?2w8bZBcsPfkR2fJeHyjwykdTRPCQkUlIS4tU9txIIUSD0VE8cC+WA1zc+UAN?=
 =?us-ascii?Q?NB2IE77P+JrMu+G3HSZzkVAo0f8Z6fWsusLnULLMeYwKsmbOE2aC8BDkBRc/?=
 =?us-ascii?Q?IZapEp8/UZdcUjupusMIrh0tWftpeazCnuNKxG2PbYagINrJcZolfP3qBXKJ?=
 =?us-ascii?Q?csT2oUMFZ/vZoJKKJ8b1yy+1z72C93WTS4hhvBtJR1XdySHvkTiFJwqfRFVA?=
 =?us-ascii?Q?BhGSKBEgAuLRM+BvPBP+LMPeHCJbYeXFio6H/r0/4KI9tKQ3wQTI+m+u/LeI?=
 =?us-ascii?Q?ZA8BN2inpFQ/stFzDvqdkcuvK2fjufHGavH6gqBWPlCf9U9BJmxZ1K5icrcH?=
 =?us-ascii?Q?qMH26Pr3YQ+BehpPnwvwnIU4jXWq4cek8063FyDww7HhegjPE4ZBVkn4Gdqn?=
 =?us-ascii?Q?Z+4/ZewQhYCkUOHyw+PxbxrwIUbJjWuxVpizCD8Jb5iQl/P/qKtpQCURxnQn?=
 =?us-ascii?Q?LSktsY/bXdktWSGfA8FNwcN9d2EW4EXrjvm/4z+IVuMzNR0SKWxNyUgHU4h/?=
 =?us-ascii?Q?y6QoIISmIDBUmgdSHMGYxGtE/oJ6fD8LW/koSbgyHUmVztTNZf1W6YnCRN4w?=
 =?us-ascii?Q?nZqLcchLW/XvqDissH78S/7SW05nJbUFqdBmZoJpmzceKbyz04mJYUBXNiO8?=
 =?us-ascii?Q?5bhxmlG4Q3fWvDO3szqOUcBGTetwxrrhBK6W28x9MHI72A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56161ebe-a94e-4335-3416-08d97eca4b7f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 19:42:36.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2KCgciM7e6k7LxQCKgnhIX4HRDPzvMCI+9XB2k1Kv9seTxKixX82dHOFGshQYUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2109
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: b_epTS5KgfzAP0cVpeI4xEkA54s1BofB
X-Proofpoint-ORIG-GUID: b_epTS5KgfzAP0cVpeI4xEkA54s1BofB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_06,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 11:42:55AM -0700, Andrii Nakryiko wrote:
> On Wed, Sep 22, 2021 at 6:28 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Sep 22, 2021 at 04:07:52PM -0700, Andrii Nakryiko wrote:
> > > > > Please see my RFC ([0]). I don't think there is much to coordinate. It
> > > > > could be purely BPF-side code, or BPF + user-space initialization
> > > > > code, depending on the need. It's a simple and beautiful algorithm,
> > > > > which BPF is powerful enough to implement customly and easily.
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t
> > > > In practice, the bloom filter will be populated only once by the userspace.
> > > >
> > > > The future update will be done by map-in-map to replace the whole bloom filter.
> > > > May be with more max_entries with more nr_hashes.  May be fewer
> > > > max_entries with fewer nr_hashes.
> > > >
> > > > Currently, the continuous running bpf prog using this bloom filter does
> > > > not need to worry about any change in the newer bloom filter
> > > > configure/setup.
> > > >
> > > > I wonder how that may look like in the custom bpf bloom filter in the
> > > > bench prog for the map-in-map usage.
> > >
> > > You'd have to use BPF_MAP_TYPE_ARRAY for the map-in-map use case.
> > Right, another map is needed.  When the user space generates
> > a new bloom filter as inner map, it is likely that it has different
> > number of entries, so the map size is different.
> >
> > The old and new inner array map need to at least have the same value_size,
> > so an one element array with different value_size will not work.
> >
> > The inner array map with BPF_F_INNER_MAP can have different max_entries
> > but then there is no inline code lookup generation.  It may not be too
> > bad to call it multiple times to lookup a value considering the
> > array_map_lookup_elem will still be directly called without retpoline.
> 
> All true, of course, due to generic BPF limitations. In practice, I'd
> decide what's the maximum size of the bloom filter I'd need and use
> that as an inner map definition. If I understand correctly, there is
> going to be only one "active" Bloom filter map and it's generally not
> that big (few megabytes covers tons of "max_entries"), so I'd just
> work with maximum expected size.
A constant size defeats the configurability/flexibility mem usage
argument for the custom bpf map.

> 
> If I absolutely needed variable-sized filters, I'd consider doing a
> multi-element array as you suggested, but I'd expect lower
> performance, as you mentioned.
yep.  I also expect it will be worse and it reduces the benefit of
using bloom filter.

> > The next part is how to learn those "const volatile __u32 bloom_*;"
> > values of the new inner map.  I think the max_entires can be obtained
> > by map_ptr->max_entries.   Other vars (e.g. hash_cnt and seed) can
> > be used as non-const global, allow the update, and a brief moment of
> > inconsistence may be fine.
> 
> For single-element array with fixed value_size I'd put those in first 8 bytes:
> 
> struct my_bloom {
>     __u32 msk;
>     __u32 seed;
>     __u64 data[];
> }
> 
> For multi-element BPF_MAP_TYPE_ARRAY I'd put a mask and seed into elem[0].
Yes, it is the thing that came to my mind also but I was very hesitant even
to mention this one extra thing to remind the user that he/she needs to do
to avoid potential false negative during the map switching and the user
expects it will not happen for bloom filter once the map is fully
populated.

> I'd expect that hash_cnt would be just hard-coded, because as I
> mentioned before, it determines the probability of false positive,
> which is what end-users probably care about the most and set upfront,
> at least they should be coming at this from the perspective "1% of
> false positives is acceptable" rather than "hmm... 3 hash functions is
> probably acceptable", no? But if not, first two elements would be
> taken.
I am not sure a constant hashes/false-positive-rate is always the use
case also. but yes, another element in the arraymap will be needed.

> > It all sounds doable but all these small need-to-pay-attention
> > things add up.
> 
> Of course, there is always a tension between "make it simple and
> provide a dedicated BPF helper/BPF map" and "let users implement it on
> their own". I'm saying I'm not convinced that it has to be the former
> in this case. Bloom filter is just a glorified bit set, once you have
> a hashing helper. I don't think we've added BPF_MAP_TYPE_BITSET yet,
> though it probably would be pretty useful in some cases, just like the
> Bloom filter. Similarly, we don't have BPF_MAP_TYPE_HASHSET in
> addition to BPF_MAP_TYPE_HASHMAP. I've seen many cases where HASHMAP
> is used as HASHSET, yet we didn't have a dedicated map for that
> either. I'm just curious where we draw the line between what should be
> added to the kernel for BPF, if there are reasonable ways to avoid
> that.
I think it is pretty clear on the ups and downs on both arguments
in terms of performance and configurability and map-in-map.

How to move it forward from here?  Is it a must to keep the
bloomfilter-like map in pure bpf only and we should stop
the current work?

or it is useful to have the kernel bloom filter that provides
a get-and-go usage and a consistent experience for user in
map-in-map which is the primary use case here.  I don't think
this is necessarily blocking the custom bpf map effort also.
