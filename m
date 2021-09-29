Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2441BD8E
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 05:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhI2Dkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 23:40:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240701AbhI2Dkc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 23:40:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SM2JHU024857;
        Tue, 28 Sep 2021 20:38:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=I86WnSBdQz0rPxcRgXQ9XgVt7LiPcCSPXLJMUTNMcHo=;
 b=LT1/UCAhtAs5CN1WHe0XoeAb6uqCmyRsFXpS+kf6VLHmoHEkHpnUIowubu9sy606v187
 fksxJShA3JoIvaAuv+rv7nMn4xVgYWQCjU6OK4czmYVJbJULqJny4lFmCgojCUzsA7nE
 nBomsAIIJWI3+5S068Xhn67PgxNTcsfaqOc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcbfjhnst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 20:38:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 20:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3f/9ExhZhTZGJYBKP1IX3nl5I6/WDvq6kVgnDEHvfgKFirvigZNpVWtoDLedLcOT3kcv8u4Lfls7XE/R9RvkPg06jkem2bLLB4yIL7H89ZRaambAMlpicf1bvozdUwg7qiQo5uKvfctPzxJQpLknJUwhDLdXlIbRKDbiszwtTpZAcGAQJRgBYpA7erl9t8ptfBvotAw5N0/MNqPFEfs7WpF0/ZIrReWxKQF5DiylW1W+AzYbVvbvlP8+UD7bXJe4NtyBeQzTrO9JhJB7VZVK+yW1o/OgM9ikmZHfiPMIe7D+hriipufzXrsbAZKyUpY0DtsGYTk/hepu2r8HfSZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=I86WnSBdQz0rPxcRgXQ9XgVt7LiPcCSPXLJMUTNMcHo=;
 b=f4h2eB8F8A2keYEexBp3bObrldjjoVeCWIGhMHCZoAMwQkJTbtmSukeCzOyH8Q4xgTNB55ysvcjAarFWBezQHvQPwhbGw7zGbncGWJO0KHMvXJNRkMUpj4WdmHd3wY+ruqWUUzegSzs7/2P9ZtnycDL67vWnaxxx53k442gA2POLMtRbX2ZVsrjiiA2vdojzADb4Izcez6FJiqmq8EQXXD4PVAEyNe1k1aJzrvUWjjilFXAgPee74PZ6H0458wPITBrEMtBJO15C5GS+UU8Q//zbrKCZQCgKOaj3gZwquWqmXR3mUavL8E243kNBj8Isc6+4u4t1S/zgr7aeOVN5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR1501MB4143.namprd15.prod.outlook.com (2603:10b6:805:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 03:38:48 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%8]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 03:38:48 +0000
Message-ID: <c74f5df1-4953-29ca-2217-e63c3f112463@fb.com>
Date:   Tue, 28 Sep 2021 20:38:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
 <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbH8v2m4tJEz2hFU+PGxMxP6QrFXcRmD3ESiQi_jqBbtw@mail.gmail.com>
 <20210929031715.wvicuaf6iixm7xsb@ast-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20210929031715.wvicuaf6iixm7xsb@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21d6::1597] (2620:10d:c090:400::5:f796) by MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 29 Sep 2021 03:38:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3323a06b-66b5-42b3-ea81-08d982faa59e
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB41431FAC967D3872DE411BFBD2A99@SN6PR1501MB4143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7XR6ib01lLrF+n3lhBU5RG5Yslj7ekwQvVIo/tXREoZZP9TJs3r4oQdZZIwe5GD9bFiYQ+Vfy1d6y2z+EnhpQPgJRJodTyP1mxnxZLApXsa5OFs9PZekt6EHX/GI4x6i7DVdc9x37dTtn3Y9FjLDZy4hAJTY7dKRZ3WzWH0NBocXZU1avTewBZrTUkGcrO94brMWR4uiJAEJBomUoDQ5mI5MgwNFxd1AqEHTCZHNpnsSD3unOD1q6NXZ2ip8J2JCFfCjfAVsLc3sr05L3/mLMVEhgARB383c3eCkHSoDRgk/3Pn3fhJ6SdumA4ZBASZNIYcD+vXVGuaXiWfhY8fJMErCXp2aE2VSLLNOPgcyyUm655UAFukYr//LNeMWyzqgPLa2f/y8oav+mCMrr0JPVfQ4HuIyulFKuuXtYKP0eZJ+3hfzc+PCPW1ujeoHFZmB1TjIOgf00X5HDEj+r0BZZyF7GpzRQmGdLZdBIJdbMyWFfra+Nk2fMoqseAFzJOrmUnktfPn5leLtLLekKF3+1cBQQvYiVpZMub3QQsG/xCLJvGP0cS6hUgaRYzf5VXJH8Zpockuiz0oy2FqZwaroMnisgXOPNn6bNC0fpkyv3v44T8mUhF6/a8eiguqyPs1gg0vulVY2vfmgwYqKixlSJVhhMrh4HJvQtrbf4CqfRLeAZu+ONBMkclJ1ZWhQRXTWHvEqv0C385U1Af9cfcWXcKz42SSO4vd7UX+/AwzfdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(31696002)(36756003)(6486002)(8936002)(66946007)(4326008)(86362001)(8676002)(508600001)(5660300002)(66476007)(54906003)(38100700002)(53546011)(186003)(2616005)(31686004)(2906002)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTF4M3l5WUZ4QnZhaWJac056TExrd2NmU21CcjgzVjJlcUowcG5NV1VNMEdn?=
 =?utf-8?B?RW4zK3RUaDFaRm04UE84Qk1heVJoaTdQL2ZEOUR0RXpIaWZmckx5Sk9qOCtP?=
 =?utf-8?B?QmQyamk0L1czVEJqWVBLclFjMkJaS01SeHpKZFp0Ri8xZzNTallPL3NETWFz?=
 =?utf-8?B?TEhGVFE3aEJNQ2RoTFZ1aEdkdkk1cUNDbHVEWWZiclYxdFNtQUJWWjQzcGE0?=
 =?utf-8?B?YlZnN3JjaGRVeitJZUhyUkRTa0RKTGpIVW1BUnhuQlBRajZuMmtFQWhyNitT?=
 =?utf-8?B?Uy85K1BoaUk5VUR1L0hUclZyNFMxbVh2TDFKbHV4SXRCbDJsRFhnZFRCSzFw?=
 =?utf-8?B?K1B1YkJWRGRxODZoR3gvOHhBUkR3NjhIK1Rid0Q3dXI4VUN6SW9YK2hma1Nl?=
 =?utf-8?B?Y0QxdkNZU2tUMU9DMnkzSzY5ODRTL0IrRVdDblZVWVVlWFVkcFJxbmJkTHpJ?=
 =?utf-8?B?NkV2OFJnZFlIM3lETjBIRTNzU2JVa1NMYmR6MWEzeDZZYlN2OVExZjNUdStN?=
 =?utf-8?B?TldOaHd5ZWgvV0k3TERwemhTVzVvUUhHTVkwM1BqMkM3R0lrUWE0bVhzRGFL?=
 =?utf-8?B?dGhUZHBFQ213R3hRVGlwOGI2Tk0rM2R3MFNZdnlycDI2a2JDM0ZnSU1kNXlv?=
 =?utf-8?B?dEFxOXV6aVdweWhERHFwRVBpNG5SQ0F5YWgvNDdOMTRtSFB2K05oUjh0WHRU?=
 =?utf-8?B?Q3dCOUZJZllPenUwR1RlUnlkT1NzY2JSTXhRaFp0VExoamgyZFYvcWM0ZDFP?=
 =?utf-8?B?eVdZSVNTVU9LQk5FaEthZlIrbnlnZlJZalc2TXlBeldoQlhPeVVmQU5pb2Yw?=
 =?utf-8?B?SFc5QWJFUUVMZE5yMnRWZ1N0dndIR3FvODF3ZHl4SjZUM1Y4UDNpdGVhUnFG?=
 =?utf-8?B?WmxVM2F6NlFBM3NNaVR4U0lacUZ4a1BubDhQSW9oTUVvRStIaXdzMk1uUk5u?=
 =?utf-8?B?NTZSeHVsM3pwR09sckxLanY4UXZHMEpybTQweUhabFhkVnpVMmpjNkIyQ29U?=
 =?utf-8?B?WkdVR2Z0UUpVWVlNSWxYNGNDK1pTa0hoSGJjejhzMmg3NXBRWC9VbFhlK3Q2?=
 =?utf-8?B?NkNUczhTMzZxTGg5RlNlZHF2eWRuYzIzN2R2T2gzWmoxT2d5eWhqMzNrY25n?=
 =?utf-8?B?dTNseVhWZlNyWU1sdnZIRDMwMnp1a1E2RjJDRWI3WE0vTmdmS2ZVMElzc21V?=
 =?utf-8?B?STA3aVBJRndVQ2lkbnh1NFUwSjVjN1VBM05tTTZzZjhmWDdLbU01QkpOWVpr?=
 =?utf-8?B?ckM0VHhHN1pBeGoxQ1U4YWRhNHdhZ2gzL1pBRjZZamQrcGtFOWVqOVBoR0hM?=
 =?utf-8?B?Z00zbEk5WGNIZ2ZQMlBwZFdNaTdOaU02Ull5RnZvcFFiTDlOMHl6WG03SCsv?=
 =?utf-8?B?UVk3bUMydUVMaHBSUDF3dU1iS3NuRW1OL0NORVFjcVZSeGtKQXplZ2xJejFM?=
 =?utf-8?B?OWlyVDVINXJ2SHd0a0ExNlJlWG5ybE1HeXpEeG9IZWlCTE4wZjJHdGFnWWdI?=
 =?utf-8?B?WW5CeVhNbG5HRTVKMmh6VjluY3pNRng2bkY2Mm9GYzBnRm43N2xCWVlmSzRE?=
 =?utf-8?B?MVpSK05CdUZUYTM2WEFUYU82ZWYzY05uamcvYm5EbEM0dFV6NlkvL3BwUW40?=
 =?utf-8?B?MFFyTGdRT0tCbnhvZU94OUdMdUFDNmNhZTFhZUlqMUE3c1JnMzYrN0Z3Ny9h?=
 =?utf-8?B?REtySDJGNnBHKzVtTFRUZms3Q01BejM2Nm5IOTFNVGtRVGsrSm83L3hKM2Rx?=
 =?utf-8?B?d1FvUDJiRldDQVdYdTlqWFY0OXZmS0dNNnd4MnFhMGFuSUdiSks3RUVESHJN?=
 =?utf-8?Q?R+gxOpvRuU1Q30kgVVizavJ7HuHe/KG6ag8bc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3323a06b-66b5-42b3-ea81-08d982faa59e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 03:38:48.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3Arf5Q193uIq8+4Oy0DviUpPfHPxvn8L2oYZzbauTWyU/bOZ4NCQPv10aqN3xqkGWH5wGyHTSJffYpy2G/uBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4143
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Vd3HAjrYxy4O7xEzq1_9bDCl_TMacTdx
X-Proofpoint-ORIG-GUID: Vd3HAjrYxy4O7xEzq1_9bDCl_TMacTdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_01,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109290020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/28/21 8:17 PM, Alexei Starovoitov wrote:

> On Tue, Sep 28, 2021 at 05:14:55PM -0700, Andrii Nakryiko wrote:
>> So for Bloom filter you get performance advantage from a dedicated map
>> (due to having just 1 helper call to do N hashing operations). For
>> pure bitset, there seems to be little benefit at all because it is
>> basically ARRAY.
> I brought up bitset only as an idea to make bloomfilter map a bit more
> generic and was looking for feedback whether to call the new map
> "bitset that allows bloomfilter operations" or call it
> "bloomfilter that simplifies to bitset" with nr_hashes=0.
>
> It sounds that using bloomfilter as a base name fits better.
I am in favor of calling the new map "bitset that allows bloom filter 
operations"
and having the map be BPF_MAP_TYPE_BITSET everywhere.
To me that is more intuitive since the bloom filter is based on top of a 
bitset.
And I think more people will generally be using bitsets than the bloom 
filter.
Additionally, for users who don't know or care what a bloom filter is, they
might skip this map type altogether and not realize it also can be used as
a bitset.
>> I haven't found SPDX header or any mention of GPL in
>> include/linux/jhash.h, so I assumed someone can just copy paste the
>> code (given the references to public domain). Seems like that's not
>> the case? Just curious about implications, license-wise, if there is
>> no SPDX? Is it still considered GPL?
> I believe so. Every project that copy pasted jhash from the kernel
> add SPDX gpl-2 to its source.
