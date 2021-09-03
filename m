Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7E3FFADE
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347518AbhICHOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 03:14:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234713AbhICHO2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 03:14:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18379xD2025556;
        Fri, 3 Sep 2021 00:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+Y1d4X20+HOrvURMe/ruvo6VixOaKJT4Tl7QnUC+qD8=;
 b=aEOuogbT8JaGwLKkcG6DU4cmAJtlMfxIUmU7v4ttaqYj9Wu0gjD/gXvbm5V0yq60fu5X
 lsjs1iUFJa6U24WJ6m/AB13a8CdPyF3JUFiLl5T/2nqW2/4RYue1TZZp1W83WZTgFIZ2
 34hCWc0/BOEtb28j+W11tXLqiSCjQODd3Ak= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3au5khwfwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Sep 2021 00:13:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 3 Sep 2021 00:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au39Rsj+AwPAL+SjNEIR+Z5UV44fNxnsNu2i6N2UEFOso4yxH+fMSXAANIx1gPukasIN2CKvIncx969eNeyaeaF29My/0y8BiqHyJ3xwWpNe4WLVY6G4cpjXbBHvczi/BOxAvVI92DLJC8OIPSp11UERNG/CE5M1fSxiX5eyWZ7tfqkV6srcH814AISVc+1gnLFyDyTN74NanYolllMh7GPpTIfx3eoStnI9Xr7JGxiEioOf2zqUHBF3l+NT91dy9QPUkN1qopZQZ6PQhmwiM0ESk+nuurh5htNPS324jh5HClRbowothVleyxN5Rqrbifh0qbg7gCXuiebyzmzx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+Y1d4X20+HOrvURMe/ruvo6VixOaKJT4Tl7QnUC+qD8=;
 b=JsUKhX428TkANyHaBfg8joP46LDBW4CXHbDSq7jcZXeGxTTEu1Na2o2TXA1lDy7rJedDid/7jMqAmT0JMOX5QKOaO72Jaeos9+q07seKcfTgJ5ZiQbN5SCA/b0EJMnCTN+JFpLgLw7aKC8VkNBjaC6w9NGQKoP19EhNkfSNG1D2NwkQlAPcR38COkUGW6AqQXn9azrnACnS2YDCpoQZX/XvwK5Bnk4LdG/XRaehhTi5uNi6MkUk5Rp13Qm6fOflwbUkWtihsg4a8iT4Ix/6JKUvyjn5JLpAWC4mXu9R+o6qCjdMfAuGVwn9rIYE4u/cD4CvjXtX2Q94LWdMftIEsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2350.namprd15.prod.outlook.com (2603:10b6:805:23::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 07:13:23 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 07:13:23 +0000
Message-ID: <0beca6da-7444-fdf3-8dc4-c9126b7779de@fb.com>
Date:   Fri, 3 Sep 2021 00:13:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0.3
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
 <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
 <20210903005611.pnkvybwsc5uxddyx@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20210903005611.pnkvybwsc5uxddyx@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::12dc] (2620:10d:c090:400::5:b76f) by SJ0PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:33f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend Transport; Fri, 3 Sep 2021 07:13:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574eeaf0-b6b5-4de6-d548-08d96eaa5118
X-MS-TrafficTypeDiagnostic: SN6PR15MB2350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB23504FCBE2693D0648AB5A8ED2CF9@SN6PR15MB2350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm92pf65dJab4Osa34BaTIgd/t3IRHKUDdXsQrfG3ltjn3IeBMFVcEMhyIHKk+NcE3kagB4l6t4sIbKN002kVPmY/9M06jJgMvc//FEUsq2P72O3MM3RPsBWFNFZKQJA/sHuzQGhWq66tW64KBx0q3FY4MrQyJMBOwXqnzopf0SMv3OKrPwCnRaA0c7cY8PLaW0iN8iY7zL4N/H28/gzSP89WU4g6l7OEHoPUFWLa3VNub7h9SvQ/eb8Yy58TkPtYCQ/JcdV9RSOKx46idjvZnw9G7X42R+k3zf3FGIMUDloLmNOVsZHgiLDaSUpI/9zuzFnRqsLDM1HLwuWpdOl399hyDUzDHvFACYIrcsHns3D2Ay4nkbYbb4DWUw3kWufLhv/72eprzouIpwfu/v2Tt3IfiB7k3WSNQCf4MlbGhs4AZZpJxm87mycMXdB2rLmXhVBlNe8ZiE13nZm4P5a6zfybw4YT8DenB88frJvs15ukjs3LmOLpztkvIY0CIy2rNULQEe35YQp0/2aKl842fH/E6pBNKvp5nLlh3nLvbQ+K4p623jUj+zeLFghgu9dQlwwew/XmlFUr5QVOALDisb52DF8dGsbevuyIPWk0ZNJ5a1dlWvjQaN3QEMhx70vC6Wj1hBjlqruNBdqRYbsmyLemrx18ZMoegAQyIpUT5/nXZQUAsQcLtuxsoxewMBt3jARdLC/9YLKjlx4Lc93e9Cew6qwpoH/J3YdfkoLtSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(53546011)(8676002)(2906002)(316002)(66476007)(66556008)(86362001)(2616005)(66946007)(4326008)(5660300002)(8936002)(6636002)(38100700002)(31686004)(508600001)(6862004)(31696002)(36756003)(54906003)(6486002)(37006003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVF3d3VlSTFoL3N3TWtYTU1UU0svUXRjSVJtL2FJbzVDZDk1eW1kMlFrU2xK?=
 =?utf-8?B?V082alEyZGN2NUtQVUhYVHFYbHZBamlXUTJOQ1VuRW1lZ1hma3ZiREdMank2?=
 =?utf-8?B?QndUWVlnNVhqdkdNUy9aK0o3R0xNeHc0UXNKNUp6OUcyV0VyTFRuVjJJdUxz?=
 =?utf-8?B?bHU3Ry92WFZLNUZPUVl5a0ZsdTNJZjdFOVAzbWNpanRVeVkxUFVqNEJwSzdx?=
 =?utf-8?B?K0s5SEtzVEhFSGNTdDVad0RzazJwQzc2cXFvYm1Ta2VjRGlHUlZKUTM3OXBu?=
 =?utf-8?B?L1NvOW1nUnBEK3g5cjhjNlJlQ0VabjI2Tkh4enlEOVRBcDNXdnFmRlk3L0R3?=
 =?utf-8?B?b0lQRFlndEU4TjArV3hYcHUxVExJRUp1a0R6dHVjQUgzVm1NUTlaYkIyczFz?=
 =?utf-8?B?aGxHZkxyTkFpbGtrdTR6VU43QzhOK2NERnFPQlZ5TWFxY2hGYWpnZDBka2tp?=
 =?utf-8?B?NlhRTWtKa1dRWUowR3BrcFRGS1VZWEIrWlB0Y0wyNWt1U2lvbXNMNXpmbUhN?=
 =?utf-8?B?UjY3YnF5USsyR1lLaXExSVlOa24xN0lncTNMUlJhRWNtcGRHV0RTQWEzcWx3?=
 =?utf-8?B?TnFiNkVQWis0TnliN3NjOE16RHluaXcvd1B2ZllYZ2Y4WDdNTzdUS0tzY2Vh?=
 =?utf-8?B?eFB4MUp6TDQxbmhXVVRLR2hDY1FOVHNaeWQ2aCttS2J6WHhxUTh6U21PSStF?=
 =?utf-8?B?bkJvVXI1TkZOTVp4bWd0SmxvdUoxSXRiYlQ4NmVmblZaRFI5dVNVSTA4K3dG?=
 =?utf-8?B?WlpaR3FKQVNpTUk1OWFvbkNRZmtOZE15TkxzVFVUUG5JcStzRTVGYXBoUFJ1?=
 =?utf-8?B?SDZqTC9YMzJmd0o3VVY0VWU3OGlodFJROHhwZUtjaUZ6MkpoWi9VQmFDT2dn?=
 =?utf-8?B?WFdnV1FrSXRZQjJzdHJwNTVCbDJHSkxxUVpXRWtyZDBFQWg3cG5aZFFuOFkx?=
 =?utf-8?B?OGpxZzVGTEl2cnBJUGlVUzVocnA4azJWSXNKYkV5Qmp0M3NhVzd3eVpBdHZV?=
 =?utf-8?B?T1J4ZmNlOWhNSVk3NktKOGJycXNPeHhWY253ZmlNdi9iZjIySVMyZkJzVXFZ?=
 =?utf-8?B?aUFwRFk1QWs4Q0Mwa3haK1QwNDBOZWlLMCs4ckU2akwwVmgwQnRKa1FRM1N5?=
 =?utf-8?B?NHNEOVFZTXUrUWdDZTFleDgzN2lqMmVPV01OaS9SMDRkaWV4dTNmMEM4YU5z?=
 =?utf-8?B?VDBEVFpuWEI3czVsN0Q3YUNhaVRWZVNPVmlRV0RocUd3K3VZZmxCN1Z0Vjli?=
 =?utf-8?B?bFNSRVVJaXQrU3ZYNVlFekY1eGtPU2ZaYUM1dzRHVU1aVW1TM1IyN1RCQzRw?=
 =?utf-8?B?WVVMamFXTHJka0VLNFpUcTgyWWcweUZLam43eWVkRkJOMWxEMFoxYXpSQ3dV?=
 =?utf-8?B?Z201S2xZclNwa01tVThFaVFzelREdE5GMlVhZG05UDdyTzlLRk1pUDFJdEYv?=
 =?utf-8?B?dTJwanlCM0VCUXY3OUUwV00vUkl3cDNSNmNSVk1RRkIrd00xemEvRmtkaUZ5?=
 =?utf-8?B?eHZwdlFGN0ZiWHRSL2VaUXJ5SVR2eGhWd1VlRzNGT3cvNXUvZFRtblF3eWRv?=
 =?utf-8?B?OGp1UUx3b05STlR1T28wV2tjUnJJeFU2MDBqUDNKdlRzVld5NUV1TVdxMjU4?=
 =?utf-8?B?YmxXVW5FUFVTQ25lYzNyeklhLzJKRTR6VkxGMEJ4ckIrSkpZbW9Mb0sremJm?=
 =?utf-8?B?cTRTSHBiNXJzalY3RnRnc1NEdStkaFJpR1k2LzFDekw4amdOY2tDYVVabW0x?=
 =?utf-8?B?S1FlVmdKVkVhWStaemNVcWU1K1liZXpqaS95ZEVWRENlK3ErSmgvS24xSVRK?=
 =?utf-8?B?WDRSY2RoWGFqWTY0R29sdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 574eeaf0-b6b5-4de6-d548-08d96eaa5118
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 07:13:23.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r7rFlbzIdcMQDv0NpYODmwUV/5yGgA77H6gSEACyJP3VUgojQTJ8vsKf+TLj3gccQhU7EblnRwyAhO9s0vXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2350
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: suD1qLwt3t4COl12xmpo_Kw-DWfPDCqt
X-Proofpoint-ORIG-GUID: suD1qLwt3t4COl12xmpo_Kw-DWfPDCqt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/2/21 5:56 PM, Martin KaFai Lau wrote:

> On Thu, Sep 02, 2021 at 03:07:56PM -0700, Joanne Koong wrote:
> [ ... ]
>>>> But one high-level point I wanted to discuss was that bloom filter
>>>> logic is actually simple enough to be implementable by pure BPF
>>>> program logic. The only problematic part is generic hashing of a piece
>>>> of memory. Regardless of implementing bloom filter as kernel-provided
>>>> BPF map or implementing it with custom BPF program logic, having BPF
>>>> helper for hashing a piece of memory seems extremely useful and very
>>>> generic. I can't recall if we ever discussed adding such helpers, but
>>>> maybe we should?
>>> Aha started typing the same thing :)
>>>
>>> Adding generic hash helper has been on my todo list and close to the top
>>> now. The use case is hashing data from skb payloads and such from kprobe
>>> and sockmap side. I'm happy to work on it as soon as possible if no one
>>> else picks it up.
>>>
After thinking through this some more, I'm curious to hear your thoughts,
Andrii and John, on how the bitmap would be allocated. From what I
understand, we do not currently support dynamic memory allocations
in bpf programs. Assuming the optimal number of bits the user wants
to use for their bitmap follows something like
num_entries * num_hash_functions / ln(2), I think the bitmap would
have to be dynamically allocated in the bpf program since it'd be too
large to store on the stack, unless there's some other way I'm not seeing?
>>>> It would be a really interesting experiment to implement the same
>>>> logic in pure BPF logic and run it as another benchmark, along the
>>>> Bloom filter map. BPF has both spinlock and atomic operation, so we
>>>> can compare and contrast. We only miss hashing BPF helper.
>>> The one issue I've found writing a hash logic is its a bit tricky
>>> to get the verifier to consume it. Especially when the hash is nested
>>> inside a for loop and sometimes a couple for loops so you end up with
>>> things like,
>>>
>>>   for (i = 0; i < someTlvs; i++) {
>>>    for (j = 0; j < someKeys; i++) {
>>>      ...
>>>      bpf_hash(someValue)
>>>      ...
>>>   }
>>>
>>> I've find small seemingly unrelated changes cause the complexity limit
>>> to explode. Usually we can work around it with code to get pruning
>>> points and such, but its a bit ugly. Perhaps this means we need
>>> to dive into details of why the complexity explodes, but I've not
>>> got to it yet. The todo list is long.
Out of curiosity, why would this helper have trouble in the verifier?
 From a quick glance, it seems like the implementation for it would
be pretty similar to how bpf_get_prandom_u32() is implemented
(except where the arguments for the hash helper would take in a
void* data (ARG_PTR_TO_MEM), the size of the data buffer, and
the seed)? I'm a bit new to bpf, so there's a good chance I might be
completely overlooking something here :)

>>>> Being able to do this in pure BPF code has a bunch of advantages.
>>>> Depending on specific application, users can decide to:
>>>>     - speed up the operation by ditching spinlock or atomic operation,
>>>> if the logic allows to lose some bit updates;
>>>>     - decide on optimal size, which might not be a power of 2, depending
>>>> on memory vs CPU trade of in any particular case;
>>>>     - it's also possible to implement a more general Counting Bloom
>>>> filter, all without modifying the kernel.
>>> Also it means no call and if you build it on top of an array
>>> map of size 1 its just a load. Could this be a performance win for
>>> example a Bloom filter in XDP for DDOS? Maybe. Not sure if the program
>>> would be complex enough a call might be in the noise. I don't know.
>>>
>>>> We could go further, and start implementing other simple data
>>>> structures relying on hashing, like HyperLogLog. And all with no
>>>> kernel modifications. Map-in-map is no issue as well, because there is
>>>> a choice of using either fixed global data arrays for maximum
>>>> performance, or using BPF_MAP_TYPE_ARRAY maps that can go inside
>>>> map-in-map.
>>> We've been doing most of our array maps as single entry arrays
>>> at this point and just calculating offsets directly in BPF. Same
>>> for some simple hashing algorithms.
>>>
>>>> Basically, regardless of having this map in the kernel or not, let's
>>>> have a "universal" hashing function as a BPF helper as well.
>>>> Thoughts?
>>> I like it, but not the bloom filter expert here.
>> Ooh, I like your idea of comparing the performance of the bloom filter with
>> a kernel-provided BPF map vs. custom BPF program logic using a
>> hash helper, especially if a BPF hash helper is something useful that
>> we want to add to the codebase in and of itself!
> I think a hash helper will be useful in general but could it be a
> separate experiment to try using it to implement some bpf maps (probably
> a mix of an easy one and a little harder one) ?

I agree, I think the hash helper implementation should be its own separate
patchset orthogonal to this one.

