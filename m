Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBD45B2ED
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 04:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhKXEAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 23:00:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232269AbhKXEAC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 23:00:02 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2HbQW015157;
        Tue, 23 Nov 2021 19:56:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cKg/NYVHbLFlMckoX2+TnraUylG8UIQrlqc3r+fXS3Y=;
 b=RBPkjBj1V9qae3ftbix07Ant0836UnjUJDDtmfj3rT2FBvEPqr29tZ1gJeRCykrL0cw7
 b9A4IqeA41deo17SjnVz556LTYBRXFNsMmWUG14LkCd9FeDNeuq4iXyA/Svq5dOkWpi8
 f2fleU+NRzYEPmyfrrRnlvM/8L2hOruCg34= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3chcfp8crm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 19:56:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 19:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez0j9CUHO1EWmpPEZ0MgwnCTzumN68tCNZsKUH5WS88oghbN2gpN4WHbKqPE2ZG0zJS92CuIkh6nBdsLiwb2yNFygELVHxGrHD9rTTy/GyjJ5CFWjwsENRC9KuPOaH/5yVDekMKTvcPa705phrGzqSZxzVi2g3whlSVWXa4hZppI2VckQkhkbj/N1NSxDy8mlsGPTYDjkaDGUpgcJ7REjzZ2xt6UO2miwImmejmOWWueiiFQ1WlS7a6f1Fv49cnnPmyAVuMY0ZvM9tDIJMAGm5BggC3dQ1HO1ikAj1iTsX37Im6Gcw249G11LaKMLjckWud+lWx0FucFx40oik/+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKg/NYVHbLFlMckoX2+TnraUylG8UIQrlqc3r+fXS3Y=;
 b=IVIwYNNPCvjYuOt4k3EPG3yM0XiBCH9iGibGmKtU0mXf4TvvikjXtmqs45Sm03DxwLRyPsSqavzXlW3oK/yaqBLE09LS8/GvwJ68NFOlferTXzj/kv58J8KVcM+024ikWzhpcqtNhCCPk9VT6oD8vgyndUd6jF91Sws1ClGeToUug6b3/EnlzmzDvjbcpCQ1F4JF++nutGYExcgLzSDckZYhww7bd4IKgcDkwenE4McvK8lBIQJDT2OnNXWfzO+8Fb4OhTnjlnHJywtpR2Qlti+tmezt/+ivMfRcrEKs6qXizwN/2/5A0+2AbEr1niJYNbk+7SjngRIs4hgtIup5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2157.namprd15.prod.outlook.com (2603:10b6:805:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 03:56:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 03:56:27 +0000
Message-ID: <f4ceb6a6-f469-209c-28b0-fcba4f9c4026@fb.com>
Date:   Tue, 23 Nov 2021 19:56:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH dwarves v2 0/4] btf: support btf_type_tag attribute
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211123045612.1387544-1-yhs@fb.com>
 <CAEf4BzbEMzpXKQ18FmFxgozAmbx8Mz87YamONpbAWaKDCULGjg@mail.gmail.com>
 <YZ17F85k9Ddhjgnc@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YZ17F85k9Ddhjgnc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::116e] (2620:10d:c090:400::5:8385) by MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 03:56:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8abadb56-e1b8-47be-3454-08d9aefe6426
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2157:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2157A624FA8FB12CFCC5858ED3619@SN6PR1501MB2157.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2JIXiZBLQUgJm7FYtCimdxmtRfvWi9hN9HGDVPozTvXT2klExN+wOfFFVO56ohHzlWc0jLxaF6KU6lAAe5/Uy5KgX/NvJrN5hlJ+3nDA8rezbKaGSdy2z9+KhjzRY/y9NtYYLeADxEbsX3p52zPpIWN409clHhnWf6LaULbyIGTWKkqrZqVe6pQMgd/IjVE7vGJlS6R//n7dd+NOFL2Te4YcaR9h876+89T6mCI1q7gP8l6EgBq817FlW2hI7KtYFNo54Ele9CLiLlJZp6ivuqcwNAUVF8XKNU4JkEnPfX003Hun4o5TK7TXaHfXFfeVSpn92V9BRfplFkS2DVKR/wW8TATH1VGoM+q/4JPflIKhPSUXb/I28A11rFD1fKSGOnZyCyOJhsCRsWP0R8Od2YI7HS+DsQmmxfdRiO+fLUvVfKjDjr8D5tT3K2Y3EHIII4Y879hvcdlwHpA0UiVmroE8Yb8T7sNXHQNTQFKa+wU5b81VjZYhMjVamcKw6BZrUOTt1wnwi7ir4+k784nf6ReUYVovT7bIT4jcmbwd9RY4GaXyfJQTNYy/fqVpI6yWMWzV94lsA+2QsTuppxhkiyvTgmMPITV78LoEwvnCYlOI3dgfIbl81ibcOF2PP6gqhtKi3n0vdcouTUVfr62FD2+srHjwobe1lnF0Epl0NY2PMwuQnUA4A8AgR79E9yXguX5td6XPtL8CPd1ZyRYXRZGxGq91XT9jfmwXJzonL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(2616005)(66946007)(4326008)(36756003)(8676002)(186003)(2906002)(86362001)(8936002)(5660300002)(38100700002)(316002)(31696002)(52116002)(6486002)(53546011)(31686004)(508600001)(54906003)(83380400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTgwVFppM3B5eFJzY0FMbE5zS21vaEZTZHNvcCt0SW84QiswZUVFS2IwUUJN?=
 =?utf-8?B?d1ZzbGVoRHA3ZWpiZk82U3dYUzBVK1dlNmozalpERDJabGJrbm4weHpsdkJx?=
 =?utf-8?B?UStPZDV6Q3NXQmZpeUdNQzB5SGlFL3ZBL0ZiUkFNZkN1OEJhbGczc211dENO?=
 =?utf-8?B?dloxeVhaMUQ4ZnhiRlhVVnN0Umg3SSs4c25oNTFXY0EvUGMzYUhxZTB5VTM5?=
 =?utf-8?B?T29JaFlydHNnMXRocTFCRTZva3pLQWg5WUU5aHJFa0ZVN253cDhhT3R2ODdn?=
 =?utf-8?B?d3NKVUJ3cjRzcWNLQXlLcGVSejFDbHN0ejJ2dkJKUE44SmhiUS9CTCsyUTlG?=
 =?utf-8?B?WWY1YlREWmc1ZTNHNkk5MXkzcHhKUzdYNHNyQUljYWgrVXJLd3kxZW5IbTIz?=
 =?utf-8?B?QmQxMmJhNnk3emd2YTJQcnZTR2hrazk1VjNsZmMvQXF6b2pmektwejhBUklN?=
 =?utf-8?B?UUpRakJVS2duNGFRdUF1NEw2ZWVKYkRYL084SGk2bDk1K3RoV2g1WjNrR1E1?=
 =?utf-8?B?QnQwaVpscjlxazhjWkplQ1NXTmN5bnVVb2o4Z0k3ZHpvcDNxcWVOaC9sS3hW?=
 =?utf-8?B?M1dmWmkvdFBlcEpYdW5pNFFCMDdzMGtWVmtMaGZQc2VJWDFGREV6OFhhcXBi?=
 =?utf-8?B?MTlOUmRSdkJlSkdLY0l1RUcwdlNiYzNTYVhudFJtN2taeTJQRnAwU2VROE9Y?=
 =?utf-8?B?bnlQWWEwZWZJZmxwZ3R0NG55TUhUTTk2ajVvVkxWVzMxaXIzZ2o0dFlPZXY3?=
 =?utf-8?B?SmFJYVN2clgzdEJZN3M1VVhyQ0tseTNkbVVVWjhFbTV0OUlBSlMxZFJwVElX?=
 =?utf-8?B?dkVNNU9ySVlNN09PWHBkQWRtcFJBVnFWRU53STZySEgvLzVYQW0wKzBwMGRZ?=
 =?utf-8?B?Ly9jb2o5S0xIS1BuV0taMC9qcFc1UzRidUE3cm51Q0xSeEg0aW95dWE0OUV0?=
 =?utf-8?B?aml1azNGNHhDOFZrQlFOTzJWSFdaN1VBUDVReU53MDQyTythTjFYY00xM3JM?=
 =?utf-8?B?Y0dudm1kdFNvb3EvY0JzdUg2Z0p4V3RMUEdyeDUyaklyQlZxNHpNVFhPVUhm?=
 =?utf-8?B?STU3THVVYm1mbTBIaFI5aWVucndPMnZmb1lIZ0lCdWZZaktJS3ZQcmdSR1RO?=
 =?utf-8?B?ZFZ1VStHZVh2VEltMGFkZFdvQnNOQkJMRDJZSUphZTNKT2k3elY2QVdJK0d3?=
 =?utf-8?B?UDN6OFFRd2tjR3NWNFNuUE8wV0pSaTB5OEV3aTVlaDg5WDg4OEZRR0EzZEo3?=
 =?utf-8?B?VFNQZjlSRVJtalUyUFNsclg3OHFXaUNHSm55ZGVocUMwZml4aVhWZjk5RmVq?=
 =?utf-8?B?RXkzUTBMa24rWlN4TDZpZ25GWTVuNVEybjVCZG1ialFwS1NOQkNXVlB3L29T?=
 =?utf-8?B?QzcwcGtkdW0rMzdQNUc3NzRCcmlXVmR5MmZBWVdPYjF4dFp2ZVdYTDA2c3hp?=
 =?utf-8?B?VXVKazF2YWpRNUR0ODB6TDJNd2wxVjVvMU43R0pwVk5Uem8vUlFycDZvZGdE?=
 =?utf-8?B?WlhKbGE2UXZkcGdRMitCKzNaUDI3dDl0dUJkYmFNWWtnbEVaSmZidTJkQitq?=
 =?utf-8?B?U25zN0NQbmtDSEV5U1hKZVFMQWRXVGtjU3MyRURnWm9tV3VjbmMwVlVCdzVr?=
 =?utf-8?B?WDBVd25Ebk1VUkRkQkwyMzhwTktIMzZDam1KaS9VdVo0U05qZmpjU2pJSE9W?=
 =?utf-8?B?eWpjNkRGMU9YQlViSnljK1BSeWdSaDNRWjFrN1pRdTJ1VVMzMkp0MWJLVWh3?=
 =?utf-8?B?UjZQSDdqNzh5aWlHeTZFSkNqbjNnK3VBNmR0K1Y2dDdEWFJHRE15VUN0Z0lO?=
 =?utf-8?B?NitRQXFVTWpHWWtCS1dhYklxOFR5Uk1ZVUJTRTBxYlBDc0hXVEQyUUtnTmM1?=
 =?utf-8?B?dlJMaWdMQnY4dUxQMVdFTTN5ZnJXK1h6TUNodFFRNzZWTEFFRzNIZDFMQ2xj?=
 =?utf-8?B?RDFyTUZGWTR0bU9BS3hyVDkvem5YK2VJNzdTbDBpRmtmYmFPRUtJQkpnd1Nl?=
 =?utf-8?B?NFRuTjFKNGF5V3RBTHVsV0d0ZnhCeGd6K0ZGdHRvTkdPa0hSRHlFaE9vNnY1?=
 =?utf-8?B?N2ZUd0s5d0ZhaXpVRVpiUXFmVGdlbVJMQjl5WFFPWGNZK3BIbHhUdjRVV2xl?=
 =?utf-8?Q?5WzgXxW4iNp3HXtw5L5BHG8Yi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abadb56-e1b8-47be-3454-08d9aefe6426
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 03:56:27.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 843n8cKh2YUsizv2wTw+3H2Ig+4GCYI56HPXc6qzn703kb37S4qJKRY3HxMna66t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2157
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: qE2bxXCc38WsUmIZl0u-FdtQN76x5bwE
X-Proofpoint-ORIG-GUID: qE2bxXCc38WsUmIZl0u-FdtQN76x5bwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_01,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/21 3:36 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 23, 2021 at 10:32:18AM -0800, Andrii Nakryiko escreveu:
>> On Mon, Nov 22, 2021 at 8:56 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> btf_type_tag is a new llvm type attribute which is used similar
>>> to kernel __user/__rcu attributes. The format of btf_type_tag looks like
>>>    __attribute__((btf_type_tag("tag1")))
>>> For the case where the attribute applied to a pointee like
>>>    #define __tag1 __attribute__((btf_type_tag("tag1")))
>>>    #define __tag2 __attribute__((btf_type_tag("tag2")))
>>>    int __tag1 * __tag1 __tag2 *g;
>>> the information will be encoded in dwarf.
>>>
>>> In BTF, the attribute is encoded as a new kind
>>> BTF_KIND_TYPE_TAG and latest bpf-next supports it.
>>>
>>> The patch added support in pahole, specifically
>>> converts llvm dwarf btf_type_tag attributes to
>>> BTF types. Please see individual patches for details.
>>>
>>> Changelog:
>>>    v1 -> v2:
>>>       - reorg an if condition to reduce nesting level.
>>>       - add more comments to explain how to chain type tag types.
>>>
>>> Yonghong Song (4):
>>>    libbpf: sync with latest libbpf repo
>>>    dutil: move DW_TAG_LLVM_annotation definition to dutil.h
>>>    dwarf_loader: support btf_type_tag attribute
>>>    btf_encoder: support btf_type_tag attribute
>>>
>>
>> I thought that v1 was already applied, but either way LGTM. I'm not
> 
> To the next branch, and the libbpf pahole CI is failing, since a few
> days, can you please take a look?
> 
>> super familiar with the DWARF loader parts, so I mostly just read it
>> very superficially :)
> 
> I replaced the patches that changed, re-added the S-o-B for Yonghong and
> tested it with llvm-project HEAD.

Thanks Arnaldo!

> 
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Adding it to the csets.
> 
> Thanks!
> 
> - Arnaldo
>   
>>
>>>   btf_encoder.c  |   7 +++
>>>   dutil.h        |   4 ++
>>>   dwarf_loader.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>   dwarves.h      |  38 +++++++++++++-
>>>   lib/bpf        |   2 +-
>>>   pahole.c       |   8 +++
>>>   6 files changed, 190 insertions(+), 9 deletions(-)
>>>
>>> --
>>> 2.30.2
>>>
> 
