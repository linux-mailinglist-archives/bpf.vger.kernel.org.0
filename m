Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D364F6CA
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 02:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLQBjE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 20:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 20:39:03 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA62EF3A
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:39:02 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJx6OV007906;
        Fri, 16 Dec 2022 17:38:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gGEwL5Q8Utd2W+nrWQUPe70b5VOuvqG6XL/HN2nI0u8=;
 b=Qq/crh135+RmXukzdtKFF+ri987Ld1XR1FuRy4p7hf3Cfj+fWIADNKSuzCZ+55A+s6wK
 wAXKC4t00D4ziksUJW4cdjb89FVlZoHCbDEQ8bJCsf7L5dxYJn5Ohjn6BP9Pd3jCpFlm
 PeHjMnT07HqCbsltKXeV3h5nsCgE8rN10E3nuWnUifN8YN5bNaHyk2+OF135O6FbYvvE
 Sn0C+fvwyAwgXuPyWl42NIbd+w4c0LwqEx9I45YOqioDgwHpx7zMNxYXBYU6mMz1qytG
 DOJyU1W4qw1Yh93WF5XiEdS6eMqfspaGScJ8D2p74kuqpsW+wHGQpgGhjoqxb3PCtC/9 pQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgv90305r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 17:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDfH7sQLnrVfs5B5QVz+x5MzIgrzkwgcq6BZeQgSqF/LGxoE95QbU03+FiJRM7myr/OoTrily+2gI9JdfN1Fl/qK1fFD6Z913HCeG3S+Oe/mB7wF5SresoK1ZDEhsiFBHDd65NCZ3EhzAqAt2ZuHmGAf5DUvlFbRQoS90CbixZFavXIjb81TBfOlADCQ9xKe7i+7rUwimc8rMBMckt/7UJADZOJRxNbn4a3/lVMr9tH9vOuGNsHQvNn2QMDPE+BVgDDM0ULcdKA2i5hrgRlU2MGKaVZUxVfg2Xptpzrz/UXmmb3Q7nTjfwuHzSJwm2OvU7eWsYVlB9Hfz31K1QxXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGEwL5Q8Utd2W+nrWQUPe70b5VOuvqG6XL/HN2nI0u8=;
 b=A1Y79vS/9Nkmt+Kz8iHr67u7BUmpeM5hciZxh9tnzt1Ap8ltI3EtR6yj0wbVR2v7aEk/9Xh9iJvRW8bqz5rhLdnGPmOLmh1rEcLwcTDN0hZr05HT8xvff/83nk0zO/NFHMcF5lDM0sU7GyKyFOzUjRXwCsG+Pts6z2lSh6fC1WeFYmS8H9LSkv7DLSeYiBk9vzNSZFJWnQt86+WslRQ3laCpnuntLW73hQ8OzQ14OSIjae97vKuIuUCBjKo9RuQFoJs4sl2ME0lvQ0IuqFVwMwTpAAqxz+GHZmjVjdZNUAhuiAe8iw0D2wTYDKh7tmKANC3yKfiEQJ8k2Jnd8PiZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2509.namprd15.prod.outlook.com (2603:10b6:805:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Sat, 17 Dec
 2022 01:38:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 01:38:53 +0000
Message-ID: <757e5dde-75ed-80e2-9a34-ff7c2259de78@meta.com>
Date:   Fri, 16 Dec 2022 17:38:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: Follow up from the btf_type_tag discussion in the BPF office
 hours
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     david.faust@oracle.com, elena.zannoni@oracle.com,
        David Malcolm <dmalcolm@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <87o7s4ece1.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87o7s4ece1.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB2509:EE_
X-MS-Office365-Filtering-Correlation-Id: c40ecbba-d590-4b4a-9433-08dadfcf7469
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tt0W+2utL8FcCL5zqU0aGELj6ebq6jp7DRVXtMe+fGpTRW5Ih8uxjzPuZLv4daQxQhEuCxZL/EXIX6JEhSDCoo/V3SBmKPxh+ld6UZikOYOC+Xjzx+OugnvLTzIlaXxlqSp72Z7vCMe4pJIE/Je5miat3pDvIMFwhTzzw7dSETOrNj0LMBP2SFr8BZYS6Ip6ZlOclGsd/rJBKLoV8Ait5KwuXY8XVKsB5Bmm+dZ0jRbX39ZBuKKyv8StUx4r44T+RkBBlIjMmUZltDrCs0itHoX3tx+10w0FGxVkjdvyfOIdIFrt7HdiXS7ThR6lboS/4Lz5noF5FIrIcx7AQOa9xS4bTqJLnjh8Q1hVobWTx0hMo10WubZ+zgGxPFeuj5/tHpvJRnCgRhbC0RmgBP7Z/JF6K4BW9gK/slaCjOzIAgI2kK5EU2DtJ89LQAD5HFo+Z3uypjQleONbh7rGYqeUv4dwD4DBoHWNOcU8UNFCRhmPZmYsjWMt4WzOgDdbAQeKoL83DTJPbeu1V4CthEO7htd5q8YUJ5HISdGgMy94NL+AYRaRIjY8z1eLLLtijl9KBN9d46QKAfIzUMTEYa1yLFdYTgbZxy2vKRpHbEduoP7uHYiwfdE8oZH1inESbrXEmzRCgDZ6oJakEpjoJLiEnmDGamy+gQNgiKVouHRyBHHkRqS1pSDU1TnoeenjuiVxYhg6oOm4am/g4dkSciaLVgFG8+0w4do/Z5xMp4IxxZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(31686004)(66899015)(2906002)(5660300002)(316002)(8936002)(4326008)(66476007)(8676002)(66946007)(66556008)(54906003)(53546011)(36756003)(41300700001)(6486002)(478600001)(186003)(31696002)(6506007)(6512007)(2616005)(86362001)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2V4MktTSFJMVi9iTGx0WTdoMHVpUXFoei9teElxdjgxRGtTZHNJTlIwSDhN?=
 =?utf-8?B?MElURmE3ZSszWG1PMjZPYnY0YXhTK01qM2FXZWJvWkdJaDdlZGZROU1ORVdV?=
 =?utf-8?B?bWxSdXdYTHVhUGx2UXhseGNVNnZDM2FaRHJtblFQSnJwNUVwdHJTRVMzZjFR?=
 =?utf-8?B?R1R5SVZQUU9ITGtDdHcvd3dLNm5sWWJLbEFjV1VxMURKZzlDaFdXdVBLZmFS?=
 =?utf-8?B?UmxRWmNEREZoTytESEpYN00wbkQzTFdDeVVQSW92YllIK1k0eDk0QXZHaUsx?=
 =?utf-8?B?N0JobkhPN0FUTzBIQnFpVUtRRmFJNW52OXpoRHdnN2ppLzBIOXBvWTFTbml5?=
 =?utf-8?B?WTZMQm81VEVjc0gwNVpOYWJsTU1ldTQ2WmVRV0d2WlNMalZzNTBoak1JNTJq?=
 =?utf-8?B?dWNLNnFTdkRtcGowUTJ6T2NYMkluQTgwWjNJZm9uR1lXRHJwcWQ3cjlQeFhO?=
 =?utf-8?B?ZDZkVGhZUTRKNFhKa2U1L2w2eWxncGJvYzFZNzVWS3N1MGxKK3ZxanRRd1Fl?=
 =?utf-8?B?aHRHMXh3NnUwZXdZTytLMzV5VU4wUzdHMzQwRFoxODd2anZNaUtvRUd2Qnow?=
 =?utf-8?B?VG44NkNEa0IrQmVWQWsrQ3NHc0liR01hYTZtRzRPRkRKcGFIbDJmeFVNbUV0?=
 =?utf-8?B?MWhzb3hpUG9YYTRKVndSVkVDeGZIUHNxTzkvTzE4OGtMT1lsenUySDlicDN4?=
 =?utf-8?B?TXFFU1R0SXQxT3d4ODRINUt2ZTZuMmlTSks3Sm1GMDc3cktSemhPS2pQSi9T?=
 =?utf-8?B?dnVoQ2VURWVLWlRnbTI4VXp6R2hEcFVLTTdreTJKZkd6UmJXbmhsU1V4OGRm?=
 =?utf-8?B?eWlVZXhHUVBDSC83QXdnOGoxSGtBK1ZlSDk2Z2VDQUp5bDVlVFJ3NjREWHlP?=
 =?utf-8?B?eEM4T2o0eHZjMGpQY3Rrd3gzSXBwLy95YWJuSnNDMlVCeU05OFpmOXovNGZp?=
 =?utf-8?B?T0d0c2JaUEFZd3Y3dDBhZjJ2TEh2SEtKKzIyVm53cUx3ME85Q01STnZvMnNR?=
 =?utf-8?B?b3ZqZmgwWDNFVnJNcU03cXJKc0pZWm1KcWZGdGVmRkpDTU1VRkd2bVUyMlln?=
 =?utf-8?B?eTdtMTZPeXNVYW8xaHFUOGJZUGc4ZmZ2TFl6M2ljQnEvMkRYUTRYQy9TRHVx?=
 =?utf-8?B?VTA3L1NveHN2ZC9LTXRidDRHYXplQk9CRmF3VHVjUTdqZTB6clNYa0FCYlpI?=
 =?utf-8?B?MGdBdFZnZ2UrZi9ndWgvVlRVSkVzUnpKWE1iUDVuczdHSEpHWUdMZ2h4Skk4?=
 =?utf-8?B?ZTNxSC9hZjd5MU1YNnp0anFhWThvZVdCRnNYOHZxNE1QSHorVlVIczFJblgy?=
 =?utf-8?B?K1JBSUhQU3UyLzNJdXhEbktYcGdGTkJmUVc0UktzVVRCSnE5Y1owQUVpWlJH?=
 =?utf-8?B?YkR5Q3g5V1lIS2VXZ2Z2Mkg0VDBXVjhJYlE3SWdwemNKdVByaXRzRkZPbnM1?=
 =?utf-8?B?eWpsWndrVE5RWmU5dU9RSlFidy90T21HUWhoNmVobGxhMzV1Q05FMWlVN040?=
 =?utf-8?B?VGlWa1BxdkRtM0t4b3BVTFdNVzZINEEvK0x3bDdQMWQvam1OZmdyUFpBNUJY?=
 =?utf-8?B?Z2ZCSUZheTZ4cnRUWGNuVXBDaWpxcVdiQkR4VnpGeWJ6RjhJbjZjaGJ5Vjln?=
 =?utf-8?B?YkdrNm5JdklteUF3ZUh0ckZIdVZ2QlVlLzV1RG8xZjJrWldBM25MK0owT3g4?=
 =?utf-8?B?M3pOSWxhUWs3Q3NlQmlJNkttOXhYeWZUNldQMDhBY3lyZGUzdVk3bXNQc2RN?=
 =?utf-8?B?ZkN2Y2xST0JRS3oxV2wrR1NBTXlJalJyTGQrcjlLT1NJV2toelhzWitnR1dM?=
 =?utf-8?B?dTV6QUoxMEdMbDNYdFZ2dWs0U0FBZjdlUkdUL3Q3MGJzckZHZFg4M0lHc0xn?=
 =?utf-8?B?TlNDNHZzUDRqRlRHNG1DSlhRMU5HYjBHVHBsU0g4T2xhbDBTWWFiWVN4cEhU?=
 =?utf-8?B?b0F3dVovQ1hlMDQvYys3bnkydmNQdVVxdTVhVHg0OHkzOUZZeGZ0a1FmTjdx?=
 =?utf-8?B?NW5DeWc4c2JFelZpYWFkZ3JSUllhMG9lV1ZYemJ3SEo2emZ6ZE9lTFVVa1VC?=
 =?utf-8?B?MHdrQ3lMKzJWbnVxQVRLLytraTZPaHhJQXMvVkZCeHVBRk9SeStHZWNMQTN1?=
 =?utf-8?B?VkttVXdFSEd1Z0c0ajFCTFlEWmpjN2FqTmVmQW54MWhDV0lNZlpLZ0xsK090?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40ecbba-d590-4b4a-9433-08dadfcf7469
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 01:38:53.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OPDmlQGkDDNAKtiRS/X4WWvJ5HiFM1EARz5N68LghAeuATzYZp/UYHtImt0jC9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2509
X-Proofpoint-GUID: 0DeofLsRYvCxvWS3hdu1UZuIOJulKPiD
X-Proofpoint-ORIG-GUID: 0DeofLsRYvCxvWS3hdu1UZuIOJulKPiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 10:43 AM, Jose E. Marchesi wrote:
> 
> Of the two problems discussed:
> 
> 1. DW_TAG_LLVM_annotation not being able to denote annotations to
>     non-pointed based types.  clang currently ignores these instances.
> 
>     We discussed two possible options to deal with this:
>     1.1 To continue ignoring these cases in the front-end, keep the dwarf
>         expressiveness limitation, and document it.
>     1.2 To change DW_TAG_LLVM_annotation so it behaves like a qualifier
>         DIE (like const, volatile, etc.) so it can apply to any type.

Thanks for the detailed update. Yes, we do want to __tag behaving like
a qualifier.

Today clang only support 'base_type <type_tag> *' style of code.
But we are open to support non-pointer style of tagging like
'base_type <type_tag> global_var'. Because of this, the following
dwarf output should be adopted:
    C: int __tag1 * __tag2 * p;
    dwarf: ptr -> __tag2 --> ptr -> __tag1 -> int
or
    C: int __tag1 g;
    dwarf: var_g -> __tag1 --> int

The above format *might* require particular dwarf tools to add support
for __tag attribute. But I think it is a good thing in the long run
esp. if we might add support to non-pointer types. In current
implementation, dwarf tools can simply ignore the children of ptr
which they may already do it.

> 
> 2. The ordering problem: sparse annotations order differently than
>     GNU/C99 compiler attributes.  Therefore translating 1-to-1 from
>     sparse annotations to compiler attributes results in attributes with
>     different syntax than normal compiler attributes.
> 
>     This was accepted in clang.
>     But found resistance in GCC when we sent the first patch series.
> 
>     During the meeting we went thru several possible ways of dealing with
>     this problem, but we didn't reach any conclusion on what to do, since
>     the time ran out.
> 
> We agreed to continue the discussion at the BPF office hours next 5
> January 2023.
> 
> In the meanwhile, below in this email is a slightly updated version of
> the material used to go thru the topics during the discussion.  If there
> is any mistake or if you see that our understanding of the
> problem/situation is not correct, please point it out.  If you want to
> add more information, please do so by replying to this thread.
> 
> Finally, it was agreed that we (GCC BPF hackers) would send Yonghong our
> github accounts so he can subscribe us to notifications in the llvm
> phabricator, so we can be aware of potentially ABI/breaking changes at
> the time they are discussed, and not afterwards scanning bpf@vger.  I
> alredy sent him the information.
> 
> Thank you for your time today.  It is appreciated.
> 
[...]
