Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88563AA1FA
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhFPRE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 13:04:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229547AbhFPRE6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 13:04:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15GGxnfb030826;
        Wed, 16 Jun 2021 10:02:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=spaPVe8e5u+7DtfHOIeCuArY3E/ppSLB1KpKryk9zuU=;
 b=S4prikvs26ptSvJpoyVMe0Fscvx3R+t87AxbOnWqsnjDIDQY16oO1Xj29eAijP/qajt1
 PviyLTh+r9M7b22+8MOe3kXsqhf4M/d+vb6UvdnaNA8ZHUVKxRWk7YQea2Mh/syubOqv
 AtBXytk/oJ5XXTPDUWXPeOuJvhDETE5iWto= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 397k8vs7g1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 10:02:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 10:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8yt3zLowcMJPYFsSSuurTLoNvR2q3BoYE3eIZOQf+TLKCgx9JltdAdH0Me67vloF0IDlsHu668QkUcuIyZlS+gkfWtqhUOK+TjHyPi2CpaQU/gEv56oXGcXgLzUO2robhqxpzNbeP1NNn4w46VzrN6T1++xsLYrOba2xpPiuJSyKK+pqxvrGU3hHS27z6ZoKEZqNC3EF2F527gSnZLZzRubUWWHCTLyqfKqDBiV9C/vpm+aj+jTZ2LNjt7OgfA9vuKE+HCF/tT2G/lK/si1xiciUnF0yem5QV5LeU9IgmSzoYvjyBO6/Hu/NUg1DFbhM19htOjGcNbmn/ah1QMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spaPVe8e5u+7DtfHOIeCuArY3E/ppSLB1KpKryk9zuU=;
 b=RcPeVnvT1fEx1qycNY0BhjUkgGYjtBRh6wZHewfTDx8x2PuhKgoINBN1j6v4uqQD1DNzxec1a1cZC80JiAjspZTfZQ5hl5rluHZ+FMTB5a+NUvgleO8lccKBqFTOCPcqLgBb+kNFOIe8p9yKk5L3C40cQr61hoMz8BVlu36z6tFG0KzET5GjbjNsIpBXPAAC+5ORLrzlC3tsoEXKCnNDjzL7dd2CVhvLwUGZ84S8qJ7m5IzXZn44N7hZhwNKOI5Vw+I/yCs3smYUBzYATxLXfdCowoTLjeIqA2V2do8lKKPhHbrlmMAkKtzUzT6IcjIS8aVUv2+TiCKrcQfTQTE8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3968.namprd15.prod.outlook.com (2603:10b6:806:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 16 Jun
 2021 17:02:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 17:02:46 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     carlos antonio neira bustos <cneirabustos@gmail.com>
CC:     Blaise Sanouillet <blez@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
 <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>
 <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c176cb4f-26d9-28b3-3f6e-628c1a5fa800@fb.com>
Date:   Wed, 16 Jun 2021 10:02:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:b5ff]
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::11da] (2620:10d:c090:400::5:b5ff) by BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 16 Jun 2021 17:02:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95fdd34-7658-43e0-abe0-08d930e8906d
X-MS-TrafficTypeDiagnostic: SA0PR15MB3968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB39685A7B9517420329B50BBDD30F9@SA0PR15MB3968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fd0rVjJUC1n0rt/FPwn9VsbdhfSejDlhKeelRkLkIx13IgDv8Jo1DVaFk+8Evp1uvsZWGHPt2Mb74Wq3aJwWEU3TE7f8jjqR1hNiox5ut4QkczrQY2Uvmf5W1kBHgWOfMb9s1+AsREvTSgC7KWaSHql6ZTaPLtdI0kPaiz2cDTF5o58qb7bIxbhkvy42ZJWF6ZUkXgd6dRWpKwgqbzxX7vM1U5Bbu2vMakmN5U/lA2jx1aY+s5krrD/D/mXQiV3GZPan6d877Tslhp+wcbuy795W/xGw14V62FJyRi6ChF1kYOaY3ssZrVJ009/iAmpTfB+gwfden8faN2blRrvpcZc1Go86Ctwncf99FtFT3gLC3B72Jd64jyuj6nwvvivRsL5borC3oW/BLtJBF7dNGFbkGy+OTdE0J1lg62xztjqgIR2pDik8NaQBjFuk5w0hSnQE09KZl/8kwcp4Ej/NO/WWfT7J8lpDGgVcrq0E3eIg+9EVLvT8eKBajaTEz7yTN6N8mxQxoLVaOCGxMIPwxvJ7nf8rx9Bj6e6EO8k6uEx4k/IoYRpvVc3JmgYf6K2DX05+l9vRhSElrgjLnL7cW9P4NhuZ/nYxYCvBZvIfA/n9dQV95PztBDr91fhabgcsZw+totNJQV0AZOAnWfgOHQ0sHB6pAEJvxdjH3qZLDEvZELcaVnfR2u2qW9nl/gWg/9nW+ni7i2hlUKDx4uLGg4nlsDtrugugxybDjrRKghF4bX9w5JE1azzFT5VFsTaTRh5Bq2WdQLWdzvBSs8b/X/fJQwXeJGUd+Y9FIiTbmmiQgNRl6/HDA+6UEYhTFb6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(54906003)(31696002)(86362001)(31686004)(316002)(2906002)(2616005)(6486002)(966005)(16526019)(53546011)(52116002)(186003)(5660300002)(66556008)(38100700002)(66946007)(6916009)(8936002)(478600001)(36756003)(7116003)(66476007)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0dqNVNvbjNkM0Nra2JqQUhJcEZmK1B0TVkwYTl3UjNRQVRGbExRWE94UDRK?=
 =?utf-8?B?SVlnS1hSM0sva2dyYTJZQVdpL1Noa0dBNk1Hb0JDM0NVYVZVMUd2QXZqU2xM?=
 =?utf-8?B?U0RDWVdSUThPbGFDcXI2YUNyZ0ZaSFJVY0c4L1lHK09kRndsa3FGRGxDM2Yx?=
 =?utf-8?B?RXZ4Nk1YZXZ6Rng3clh2N2RlR0dlVzZSQXIzRXpWYVU3TlEvN1cxZXcwcGpY?=
 =?utf-8?B?czJHWU9JeVpKVGFCZ0dtakRqS09WdEdsbXhZaVVyaWVqVk9sOVF5ZUUwTzVj?=
 =?utf-8?B?a1ZxZDdUeXZhODlRc3NSSDNyK0pmUncwVHVPNGhRNTRsWWhmdUZPbjVDREE3?=
 =?utf-8?B?SjF1WkxhZXpjOE1jeWRTOTd4dWY5dGNEdVFScHR0WmpxeC9zdk5VTjhQckZB?=
 =?utf-8?B?OWI3b2NZcVNYQzJsZk9Ic2RLeXVwQy9WdFI1TmRHTmE5VnZpclpJNjU4Mit3?=
 =?utf-8?B?aVV2Y1RKVU5MU1cvZ3M0eDhyand0S05aYUc2d1pPRzZTTzliSlRHVDRpYWkv?=
 =?utf-8?B?WW1aaHo5SkFMcEEwRm95bk9GdUVyR05PS3NMWTNvV1hxbWtIWlVJYTFZL3JG?=
 =?utf-8?B?SWd3OTEyNmVLQlFMaFArUlVyTXpuY3lKRmlYSmhJZ1FMemNYVXVvby9FY0N1?=
 =?utf-8?B?eThldzA3MVN0UDhUQ0JGNTNKMjFGaXRXcnUyYnYrU1JwRE9WNFMyUk9Vc3pU?=
 =?utf-8?B?NXBtNis4NkN5R2IrNy9ZVncwbFBFaks3Ri9YWnU3LytKMEF3eVVYUWNEeEQ5?=
 =?utf-8?B?Y3l6dFUzdUZzUXVINklPWVhBcndlOXNxYUFkUFFQd1VlUzJGOEZkbnFGcWRW?=
 =?utf-8?B?eVdJVG9qcy9pZ3gxRVhzcVFOamd3NFJnNHh3TnlaWTJmSW55Q3pTYWdQdnUv?=
 =?utf-8?B?RHFFQWZBR2VnOGV1dGlNbGpuRXMrRlpJMDU2MnowcjR6WTJPbm1LdWRHWU15?=
 =?utf-8?B?eElGcHlIVGMrbFlqaHl6UkY1S3JmdU96d2thUUhtaVp0SW5razZGeE4vN1M0?=
 =?utf-8?B?Tk4wYThTZGd1L2ZZRlV1dUU1WGVBQTN3RTZQeWFEcVIwNG1VTlZ1Y0E2Uks3?=
 =?utf-8?B?Tkg3NUpXam1QR2N6YjluWGgxbWw3RE1QelBLbWI0RGQ3UEttWTl1LzhGS2Jh?=
 =?utf-8?B?SkR6d1k5U2FrRVNQRnE0am5VRkFjaTZsZFgwU0dNaXNmWXZCTGJTT1ZXYlVZ?=
 =?utf-8?B?THZRcDlKckVIeHlRR3M4K2x6WTVUUk5RQ1NZdDlMRlVSNE5mTi82VHM5eCsy?=
 =?utf-8?B?cnNVeUxHd3hnaEljZmFhYzQ2YjUwblhmWEYvSlFtY3U0ZkdleC85Wmg1Yko3?=
 =?utf-8?B?UkJSSWxoUkRBS2ZBODZjQUZoMVU4UURid2FoYm5aVjFCQVlRYkhXelZXejR5?=
 =?utf-8?B?c1pXVzdxaEN5UWVBY2YwYWtiSzJHN2lLYWxwZTJPcFRnU3Z3ZDBuOVJ4M2Fs?=
 =?utf-8?B?SHFFdTUrbytPNVdmQ043TGlsL3RTV1NtRVY4YkNQemlCTlA3QXZ0N01oc05w?=
 =?utf-8?B?NG9kSTN1enVRZVhDYzIvcUhwYytmUTdGaGxWMjBtVUR2Zk13NktGUzNNcTB0?=
 =?utf-8?B?R0xyclcwbkR2QTZqaDlReVIwMjNQcE5ud21LSFZrNmlGUzhHSkgyMmRld0JV?=
 =?utf-8?B?SmdKb1RrOWFHYm5LVTRrbUVzNDZmL3RBL01LdUFuOWltbUY0eXJhZjJPMlBJ?=
 =?utf-8?B?YWo2dDVRRlhwN2FaU3dYSE52SWVWUzg4b0JBT2dLZEZXZzAyOTlIWlhwRWxC?=
 =?utf-8?B?WFZOLy91SXE5MUpaakMzc2F3eDBNckVQZVhWZjBxelA5dFp5OTBmUDhxeXBY?=
 =?utf-8?B?blA4TllqM1F4MUdKS0hlQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f95fdd34-7658-43e0-abe0-08d930e8906d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 17:02:46.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHDH48UBzepATlteNLl1dQJBvK7PZhLOtxvBxCJRrK8Y26ZYPX2EA8zxILfUbIa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3968
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: opPQdg_2VO0uBCbxxHFsSbKXgqDvCSOr
X-Proofpoint-ORIG-GUID: opPQdg_2VO0uBCbxxHFsSbKXgqDvCSOr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-16_11:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/15/21 6:08 PM, carlos antonio neira bustos wrote:
> I'm resuming work on this and would like to know your opinion and 
> concerns about the following proposal:
> 
> - Add  s_dev from  nsfs to ns_common, so now ns_common will have inode 
> and device to identify the namespace, as in the future namespaces will 
> need to match against ino and device.
> 
> - That will allow us to remove the call to ns_match on because the 
> values checked are now present in ns_common (ino and dev_t).

I understand its benefit but I am not 100% sure whether adding s_dev to 
ns_common will be accepted or not by upstream just because of this.

Note that if adding s_dev to ns_common, you then need to ensure s_dev
contains valid value for all usages of ns_common, practically all
namespaces, not just nsfs, otherwise people may argument against this
as existing mechanism works and the change brings little value.
If you go this route, please ensure other namespaces can also
take advantage of this field.

> 
> - Add a new helper named  bpf_get_current_pid_tgid_from_ns that will 
> return pid/tgid from the current task if pid ns matches ino and dev 
> supplied by the user as now both values are in ns_common.

I think current helper get_ns_current_pid_tgid() can already do this.
Did I miss anything?

> 
> 
> 
> 
> 
> On Fri, Nov 13, 2020 at 1:59 PM Yonghong Song <yhs@fb.com 
> <mailto:yhs@fb.com>> wrote:
> 
> 
> 
>     On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
>      > Hi Blaise and Daniel,
>      >
>      >
>      > I was following a couple of months ago how bpftrace was going to
>     handle
>      > this situation. I thought this PR
>      > https://github.com/iovisor/bpftrace/pull/1602
>     <https://github.com/iovisor/bpftrace/pull/1602>
>      > <https://github.com/iovisor/bpftrace/pull/1602
>     <https://github.com/iovisor/bpftrace/pull/1602>> was going to be merged
>      > but just found today that is not working.
>      >
>      > I agree with Yonghong Song on the approach of using the two helpers
>      > (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) to move
>     forward
>      > on the short term, bpf_get_ns_current_pid_tgid works as a
>     replacement
>      > to bpf_get_pid_tgid when you are instrumenting inside a container.
>      >
>      > But the use case described by Blaise is one I would like to use
>     bpftrace,
>      >
>      > If nobody is against it, I could start working on a new helper to
>      > address that situation as I need to have bpftrace working in that
>     scenario.
> 
>     Yes, please. Thanks!
> 
>      >
>      > For my understanding of the problem the new helper should be able to
>      > return pid/tgid from a target namespace, is that correct?.
> 
>     Yes. This way, the stack trace can correlate to target namespace for
>     symbolization purpose.
> 
>      >
>      >
>      > Bests
>      >
>      >
>     [...]
> 
