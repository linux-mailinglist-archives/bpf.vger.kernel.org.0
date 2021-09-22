Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D24415332
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 00:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhIVWK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 18:10:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63000 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhIVWK0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 18:10:26 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MKlfSr011293;
        Wed, 22 Sep 2021 15:08:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4ZrPXBM6ZCVj6n+CbZDWciuKSFkiZE6LIRsk8xST7OA=;
 b=MF8wZqO0LCEaKcQXb0Zd7zqDOpib85yFz9d2lgO+2j+PaUApA+dwR41syAXqaQMxwt28
 Uo0HQ9pa3fJJstk+JM++CQGZRyassFRHdUC+BWJSxKj14cb65t4Lv0aJeZPpVrOfccQF
 FtPVHh0kHpmnRE5CxBxm39ww6r522y5tOks= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q54gfrm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 15:08:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 15:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFsnB189Fo8+pQL7z1vhRN9VHbhuNHnZFy+cs7bMEJHAan3DlqVDO+3FpJ+sKBilRMKevGh+PLh0JoolSSbr+KXnZFA137qR6FY9TwwU7mqNMtjrv0RKE8O3rcnjXIoMztRvp1ydfrxFFlNmvYRI22aVeEr07XbbcdUnQnH+W8uqYwTPbgfWJ9dShsS/MHHk+i12/LJEHm9L04qvvtH2BQcjuJWKelFBejLJMXCszXWE0CPX3NMxzUTpgFLwMYGyOaV2x3T9ZoIeFR7qVZk+FemTgBV4Jx1BDHq3BhbxfAyLJU+pCUVbzLl3VQwBFSkBS3iTsR8EE1f/rutjhfeslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4ZrPXBM6ZCVj6n+CbZDWciuKSFkiZE6LIRsk8xST7OA=;
 b=GfTgELb0WAHPodH8Twlytmu+JTXtVWdooM3sWakuZECBX6ygjD1JIJ7fHgX1HIlRmM1Pyl6fWUaeAh4HqkxHCgIYlCsXuAn/jXdZcg/zBC2dWYGZe5IAwsmmVfXyA7Sw52Qtc2G7iFPuzmNC+2fBS0AFkSmjcJQspE2jv0aiAPJC+PqmqQeZmIyUHr0bxRqOjhygREbkmX6mkKf10e3hGOoEh9EeGmjQhR5plGJuQxnHR25v0dt5+RGOul2oSmavgdvN79WNzXjAjytOQItHxeYaPXFSZwsozi9WtGSgQy/Je74nJGUKpA+zzYF1PJV/e4qGEdcJfCOzp0Wvb6n6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3901.namprd15.prod.outlook.com (2603:10b6:806:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 22:08:48 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 22:08:48 +0000
Date:   Wed, 22 Sep 2021 15:08:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
 <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
X-ClientProxiedBy: MN2PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:208:fc::46) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:1a34) by MN2PR02CA0033.namprd02.prod.outlook.com (2603:10b6:208:fc::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 22:08:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7444f6-10d5-4f1c-67fe-08d97e158d2b
X-MS-TrafficTypeDiagnostic: SA0PR15MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3901ED568A2BB7C79CB07B04D5A29@SA0PR15MB3901.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1ZaP/A/pQgua36yXD2fP4zThc7lynwdWwvblfCeEtoWNnUYBbU9Hw8aZC34RrcdxNfk6lXA4amW5Xvm7pa9bCrzTvx9aCOauzcUmueiSDMdmrKRWC0F7t2GY7F1Sj5/wkqiaEN5/JS0rQX3/WpYe4m9qDvHt52Mft+I+BbhrlRCCO+d3ZTpJdCtbV4jONmPouErPkCh3zBsgfDz+iS7u8GNFVngc+9yP+AvxVBd4nynyHFhikWVnuWbgEGosOv5lvypc1HrEVUZntFVwbZE0qBynXtIbEQUiR/0VW42OK1KthxvaJicMT37101fsmoyoBslikwcatNXabc9Q8O9cw/WdaRC/4UomvXbEL+NTn2uS8gACLYfUrW5HT6LCchg7fljs7ewjcjB6qgqQvpGSz9rsx8C05e74f12Zz8ZT85pb6XQfnpkOr6MR8Uskin0tY5ZMtr4FG5ccckYfIoUQnUeMpyi3vHZdb4/nKgrAZK2ESAd2sGEIADjOejhG5go7hbePegW1AqgpxDmyobNbT5Ig5qneNIsN/d27XiCYg5qvd/yNeGiS1Qz921IGbbc5yigzgHm6H3w8zln82CpxUAnT2sROkFR2qOZf6w72wSNjSWx+AsYnl/ngUoqnxHaA9GMtRZ3NzncCv8LdS68nxgOJ+r+2LLGxTScL1yyp60iuKCkBur5grL81Dz7bkEpkaZosat8tOXQsCnJBb/J0eA7Ahsm6DWDGiRtyAdyDYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(8936002)(66476007)(1076003)(186003)(5660300002)(6506007)(66946007)(38100700002)(66556008)(508600001)(6916009)(966005)(8676002)(83380400001)(9686003)(7696005)(52116002)(4326008)(2906002)(86362001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9MvxwVosAqicBauLDTBRZkp8u2CzBVzyBrtwtk34+WZqUhXHn3/jVbfeLKD?=
 =?us-ascii?Q?8X9nPB9XlmQXLgV+oRdDZKxjvFymBN/sU+c3ImiCiequi7nI4e1Z8VubTyPW?=
 =?us-ascii?Q?BlatMs+O5qzZUnD9fhFyVIiqVMhYl69ruZaXfQ6jkYbB5fnyWlQGZxw6qJT3?=
 =?us-ascii?Q?a4C/ezH94H84+p6n2t63e1HtC/xebdxa6cIG6XOPvJzbga1DD9dlabwwgetc?=
 =?us-ascii?Q?YfwuuK5xreGYJgrXh/ltfhTtOIZKiPIQyF0XA1GWS3pgNP0aZq63QfBE8hXV?=
 =?us-ascii?Q?F3jJpw2/yn0IzF3kI+QIifbqm0md0x+tIvNXbj4jG79BxOGNZZhO/nwUbuUm?=
 =?us-ascii?Q?1C0ml8tdDIv5WhmN/mzDo8YV57pjrqkMx9nb0j31LbHWWxkpoA43I81etXfH?=
 =?us-ascii?Q?GVICRWY/iCbO3VOkFBvpQpgKiddy5XVLbFGwjJjezOKYduwvtCCfdL6iyBwA?=
 =?us-ascii?Q?driNtH5R8euL4ywKZR35DequC3uiLtGglilx6xkxnY5vxa0vsMpJvBg/380i?=
 =?us-ascii?Q?/8XXFYcN5qNlA8x7s1cVMmi4uvEkzCfbzl+SaIIKqaUoma9gBBLrT8wfgDD9?=
 =?us-ascii?Q?pxJe7Lc4KneI56cJ0S1kDVzr9RxEeTer2q0Twgto0wJukaEKH6Clv1XGYmdg?=
 =?us-ascii?Q?n72GD9DVGoRPcxP64a0gJL2FPbkXWheKMVchTLSbmhG9zi6pP4ozN8990ukS?=
 =?us-ascii?Q?M3Tj26B8AIxBpddJtkY/8kKvVcGfgB02ts1FY9Pgh/1OJ8BH81ckID+JA6t+?=
 =?us-ascii?Q?xpGoeRvAm+g4MZdK6fkSWxxI+d9ULOt0bj45ucd+WH5bk3oq9XRDROsd8O+D?=
 =?us-ascii?Q?e5pVgLQBikg3++8KzTDGNRZGAv8jkElncL/NYrdr6kuk/dDZGwhDRGA5dBqn?=
 =?us-ascii?Q?GzZRvo2b60ZIyJCjqWRrvNhoeK3wfKyUtIlfEtQudsUD+DgcmKIUP80b014D?=
 =?us-ascii?Q?9mZBCOUl2WIfT24n/VFeE6JQ1/pOhZPPtau36Bsi2C82xF6HMdM0zsMKHG4n?=
 =?us-ascii?Q?iLR2GTgbB9nBaalmC92AmZFV9Fw2gHXAeRHwjkd6XjcwKxjEa6GIldx5RgLF?=
 =?us-ascii?Q?fhaQszxwzampWsZ8EDJbppId+gwZTvokKT3YoXtlWTVMx9IfqYLpZuK5rliJ?=
 =?us-ascii?Q?8k9+AhYbDB8vhQ+6wo20SAoX4xPrFXkQY99/bXBVtJ7uO8ab3cov3T/40jUB?=
 =?us-ascii?Q?daZ2/5f4xoLslx7wDt2b/JRiZ8G2bMnN3DXto23v5IRq3kV7bBksuqWnqNmP?=
 =?us-ascii?Q?cfBw8c+hTSZZx/720ZAyy4i4xeAnRQ2o2TrH94MxcdY+SmQT825tdVQ9l3LT?=
 =?us-ascii?Q?Ts/b6NMmHL5tc1qZjm3P+SicD21UgO9umQfA3Hvh3VnUkA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7444f6-10d5-4f1c-67fe-08d97e158d2b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 22:08:47.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3kLr2KnmQPtcNKfN6l6LnKuoeGNtI4k7GdVkvbEV9fHi7KLTXNxO6i5csHAp8qU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3901
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qR247sLn7A0O5Fi2Z8cvboNnRFrVVHMr
X-Proofpoint-GUID: qR247sLn7A0O5Fi2Z8cvboNnRFrVVHMr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 01:52:12PM -0700, Andrii Nakryiko wrote:
> > Agree that a generic hash helper is in general useful.  It may be
> > useful in hashing the skb also.  The bpf prog only implementation could
> > have more flexibility in configuring roundup to pow2 or not, how to hash,
> > how many hashes, nr of bits ...etc.  In the mean time, the bpf prog and
> 
> Exactly. If I know better how many bits I need, I'll have to reverse
> engineer kernel's heuristic to provide such max_entries values to
> arrive at the desired amount of memory that Bloom filter will be
> using.
Good point. I don't think it needs to guess.  The formula is stable
and publicly known also.  The formula comment from kernel/bpf/bloom_filter.c
should be moved to the include/uapi/linux/bpf.h.

> > user space need to co-ordinate more and worry about more things,
> > e.g. how to reuse a bloom filter with different nr_hashes,
> > nr_bits, handle synchronization...etc.
> 
> Please see my RFC ([0]). I don't think there is much to coordinate. It
> could be purely BPF-side code, or BPF + user-space initialization
> code, depending on the need. It's a simple and beautiful algorithm,
> which BPF is powerful enough to implement customly and easily.
> 
>   [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t
In practice, the bloom filter will be populated only once by the userspace.

The future update will be done by map-in-map to replace the whole bloom filter.
May be with more max_entries with more nr_hashes.  May be fewer
max_entries with fewer nr_hashes.

Currently, the continuous running bpf prog using this bloom filter does
not need to worry about any change in the newer bloom filter
configure/setup.

I wonder how that may look like in the custom bpf bloom filter in the
bench prog for the map-in-map usage.

> 
> >
> > It is useful to have a default implementation in the kernel
> > for some useful maps like this one that works for most
> > common cases and the bpf user can just use it as get-and-go
> > like all other common bpf maps do.
> 
> I disagree with the premise that Bloom filter is a common and
> generally useful data structure, tbh. It has its nice niche
> applications, but its semantics isn't applicable generally, which is
> why I hesitate to claim that this should live in kernel.
I don't agree the application is nice niche.  I have encountered this
many times when bumping into networking usecase discussion and not
necessary limited to security usage also.  Yes, it is not a link-list
like data structure but its usage is very common.
