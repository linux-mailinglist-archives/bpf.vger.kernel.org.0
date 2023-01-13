Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831166900D
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjAMIE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 03:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbjAMIEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 03:04:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA994102F;
        Fri, 13 Jan 2023 00:01:37 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CM7XNJ001398;
        Fri, 13 Jan 2023 00:01:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CEAmYYMGgPQuKIyRSKZbvpp9otGjaEKqz3w0HvDk27g=;
 b=ITLHV3pDV14RG+EDDHgeuERLqGOa8Mv3t/pakPVwsvRcmx3PVKy1rUrYTR+mh5kP23zf
 fQ2dJa002jU5cf8B5GctrbiEy3GVGLU7vR/g75mxH6QKwRNIUZE0z+YlylNL8zFc7kce
 xvvk59HEJ1125wbhL1An8ApeKbyyKpGS6mqDmKBVnMhonkubupIppXB090k1HzhOy9w3
 YWe/zJHPr2ka2WwgOADZBgQ9X91DiHiDFkeiTEbpY2PVFjT8OETpZdGkSMFu1w/2gpKt
 6WK/nzaRXG6ZZKbDxnrcuf/juB2jopIX5HLu91fPpzO92Ckuo3Sc20m09Ge54uMmLLHE 9Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n23bq0tt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 00:01:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTljmDDNRVjijjig7pz+IeqfounKHfV9lo5SLO0WD7PuVkGAias5yVmjhW3nCuLIn7SRE5ZBltaxDLoObywg0a5fT3i66ozv73/RpSw5gvAZR/RxkN33itJeTDXy2pxgXy7ksQKf+74x0e5FD5O6j37zFskbWA+hnz8gNV4/Awzcvf3/KTLCyrhFA4XcmqqOZpqLmNNsiMffBQPcX2VJ6My1RPVdO/Yg1IRkGzwqcwFSjbqO9cHoevOajLB7RQ9j21nEaNlUlm70k3bOPISDDzrpKN/9/iAmHFtRXS8U3ixmYmgWQ1j9GFHFZcwXD6Cm3WNqER+Hie933qkmQ090Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEAmYYMGgPQuKIyRSKZbvpp9otGjaEKqz3w0HvDk27g=;
 b=edcD1KvLan6aEubIGq0/lGyHdisERj9I6a3ktueE1dNpDdJXP7IOO8+zChPYm8m2YkB0k2A97vBBfIXJjzWImXZiRpJy6Lkpojrqi+clH4ymE59uTI0SEAxOH7+9LdJ/9o+T2kf6W+Dy9j99NJO78oqbMcUrr/umxdZ3yqBR2pRfcpNfCpnG3rhqVGMwW1P3l3Xh95B7TODGoCzZUYESzwWYAOzhsoKcJItfKenZLVnjkAU0K+Y+nv9brHsdYwzvUccM1hylj45m455jGhLOds4dQJzDL6fBzvALVn+lzW7Ip+EDG4RmNtPSp5OFIYEj70gKIzmZRStUsPvs7cvn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4892.namprd15.prod.outlook.com (2603:10b6:303:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 08:00:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 08:00:59 +0000
Message-ID: <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
Date:   Fri, 13 Jan 2023 00:00:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for
 kprobe
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e3a361-f8dc-4605-a73f-08daf53c4e5b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfWg+wmJyyIVuPgI4QDxrKmpQOJpepb7lskfWpt6XEhUXCXpeUKOUBxiiqz0FTjP27BZTuRwXhvJz8wJKen/ihYUogkV8TNjPmUCN8TYqzN+XLgtXFECFcC5mrGkneXsWyvznRvOZOYwLjo7jZfCOYlVGq4gpWG8i9tTOPYMV+9dAWLhSHFCbAiMDshKTyc1xvTzwBswLLtmL45+/HHKuKkGwnypXZI/GQQ0dIIc1gPFVj1E3OMesIjvSEpqMpy93UkaWJqRRi5c0KaNEQFCvDFlDxwBvu4VJT3QifeFBeEM0ZfimYztxVton01jLswJgUKwm8xXYlK8Cv213FDiQjbPrwszjqK++Wd8OngQ/EMSDxKh5zeWJm0k+WC+srgLDFq4AieHn/J54GRyoQ6yZmkiDEYsyjRqpdLIwi8NLKckx8AA2tbOZbcR6h7KzDbidRNx11VUGrrG375lp+Rm05XWZQltyaixN8RFk2QyXDSEmpyjCZyZeXeoYiB22UEcueDi+lgmu+zrSp2oMpmCLl0hypkinCYh8l1mtW5i7gK9Pt37V2q1l48AQqe9qqfvU2YHnimlLApUnyEVrOwp7FwBKkYWPGXVjbWUCxdIFv0tJgOix+VKfPNmXzJ2YSVtKUciONlZMfl+xWbt6hcBR3yPlisYtmOUH82rhoHs2iD0cowdCvEAQApzzPq2i+83Foc4SIBFgonSdUhijE1e19OA0H+xPehKMSk2Tnqe6eG1Axr/yOfLGC+zfUPEC1nf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(8936002)(7416002)(5660300002)(41300700001)(83380400001)(38100700002)(2906002)(36756003)(31696002)(86362001)(186003)(31686004)(6486002)(478600001)(6512007)(66899015)(6506007)(8676002)(4326008)(66946007)(66556008)(53546011)(66476007)(316002)(2616005)(110136005)(54906003)(6666004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJBdklBTnJncTBsajJEMytyV2d1QTFRS1lsZTlsSnJwOWtoODBqTWc1djdy?=
 =?utf-8?B?bVBCaEhGS0g4My9vV0I5aXJRMTViMDRaRUg0TUJrMllEM1ZEbXhjQThSUHZu?=
 =?utf-8?B?bDBXYnFVNWl6eEp0RE4wRTU0K1VKWG1JTmVEQ0EzaVE5dXBTZFNnVG5vcTli?=
 =?utf-8?B?YVdyYUdhcTFWcFFob3NwOEV4UHZybnV1UjVTTFpuaW1FdDAydGZWbVg4Z293?=
 =?utf-8?B?cTFnQXY3M0R3eVVDWjZST3JOSUlNak1ibGxIR05nYjV2N1pGU0xTdm53ZTNi?=
 =?utf-8?B?aW9vRUwySVlxQUREMUQ4QUgwaG9Fa2h0WnJvNkV6V3NEbmlKRVh3Q3MwNUlk?=
 =?utf-8?B?ZUhTSFZDMzkvekExUG9sTEdUNWpKK3hNL3E1Nlp6T1BKcWZEWjJPMjhOVTBn?=
 =?utf-8?B?cEhsSjVCQ0c4dFRpcENXQVJJRlh0RHc1ZEh1Qno3N0ZOR3cxdkVBQU0yU1No?=
 =?utf-8?B?MjR3MGhJUktOalhnS2QzaU5RUnY4RTVvelJ2Wm55bHJRWXVWRTgzRVl1TUxo?=
 =?utf-8?B?eDlPT0FuY1lVbXZPU21GWFladnIvSFlOZ1lxbDI2ZFFHT2oxemxUUGQ4Nmpw?=
 =?utf-8?B?YkhtSXV0NUlmWkN0UlFJbFE2bDh2czZjY3BjTUVrV3k4NUhjbHl3WXcvQkdV?=
 =?utf-8?B?a0JuWVZsdmNzc2lqbmgzd2tISVFDckEyMGdLRVdFbTEzTngzT2tkV0lSc2NY?=
 =?utf-8?B?ZzQ0eEE0a0RUT2NCWGRCRkhndHFEb2Y4aGRBaTEwRG5rTlA3VmhUNHZaTkpQ?=
 =?utf-8?B?a3JRVWs5YmhPWDcydkxiMC83T05LZDhJYTFMdjNoYkhWblJZem9ZZjlpc3ZM?=
 =?utf-8?B?Q1lvV1kvQ20zNGNHaEpEdm5lT1dtNDI0WVdmdUFMZmJ4Z2ZCQmxXb1E1R2tG?=
 =?utf-8?B?MWcxZE54Rk94dTZvRlNqYWZQYmRJVktVMHdHTGNGcUNDRHFSM0FadHE4OE9k?=
 =?utf-8?B?aGR6WHg2VjZhUm9xSXhMdlA5eWxKUDZVS1RDbUxVZ3loY1ppbXhhRHJxY1VE?=
 =?utf-8?B?S1ROcUdycEJlRU52K3ljSzNUMmZOVFpURFUwMXNNZVBIVXh5amtiZVQ1T3hK?=
 =?utf-8?B?QllLcnVGQzREWmpsUWZlQzRkODJrRENLU3BFenBxajR2eTFMcEhKRmcxUytr?=
 =?utf-8?B?ak5mL1I4OUIybTA3cGlQWVdUWjVpZ3o1M1hocFdBNlU4bDBMZ1laUm05emlm?=
 =?utf-8?B?dkhDVEdmV3I2cVY1N0FFZDVGV0MvdkVORElmc2h5WS84TTFadDVIYW1DR3RZ?=
 =?utf-8?B?bURWMWt5Uzl6UGtEVERUR2ZyMVZ4QUhhdStZazl5VC9hWmE5Rzgydm1nOFNS?=
 =?utf-8?B?RDNFSDRwdS85bFZEU1lsSzZpOHB6SG51ZDBBV1VUK0o3MlAxaXFHa0o2aWhR?=
 =?utf-8?B?VHJqRlJVVFU4QmNkQUNkd3NJTFNsVm1sUk1vcGdUbHZ2TUtkVXJjVWNvMDNV?=
 =?utf-8?B?NkVvaHJHOVBNbkNoa0dtOW9HbVN5L05lQUhUbUE5SkdnZ3k1WmU5b0JodEpJ?=
 =?utf-8?B?S2tJcGhwZHBCOFNzTkxGQU5wQmtpb05id01QSDRaOXFJQi8zS3pjNFhUNk9o?=
 =?utf-8?B?MCtiZDhmVmxRMllaQnc3RTltellURUltblIwcTZDNmw5S2tpNVg0eHR3YnUv?=
 =?utf-8?B?cCtLcm5BOVFjdTNLY3RsNnZuajhEUG9DUDl3UUh6VGNPNk10NWlPcktwVGZn?=
 =?utf-8?B?cU03YkgwOHVJMnJCbEhqRlFub2JSUCs2eGErcG95SEl1QU5wSi82N1IxY2RD?=
 =?utf-8?B?Wko4L3lnbTRIQjhZMWVLd2RKNmNMMXJMd210eGFWZHNYQ1pZRVp6Q0drTWlr?=
 =?utf-8?B?bVZ6UVFzaWpKSUJYU1N1NHNuSDk4dnBpOTBUSUpydEJ5NEZxb1VmOUNKUE84?=
 =?utf-8?B?dDBUL2JCbVhKb1BMUThEWkRTakNKS3dhMXNmUDFYLzBEYlh5OVRuUzhPM0NK?=
 =?utf-8?B?N0RkS0VhbWdNaEpSYndlRU5xZ3NCbC9leWkxM0ErRzFReGxWYnpUeGlvdHRr?=
 =?utf-8?B?UXhPQjJpcURnaGJSRll1WWRwYVZCcnU3NUNjazhmV1V3Ym1lWlc1NVcxNjEx?=
 =?utf-8?B?YjZzYVNCeUJGZ3MrSGNVVk43dzJqSWRwTVNuNllqcHJRQXgrMlErckNQeWNl?=
 =?utf-8?B?ck02dnUvUTAwQmlPYXc3OWNHVFpOQ21HOE0rZTdzSy84QlBta09QL3pjcTUw?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e3a361-f8dc-4605-a73f-08daf53c4e5b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 08:00:58.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyz2ziDzkaS+EaIeM89mqjOb+lvpBb35NG9Z8asXTs+TCyBNVOXleYLhxILQ2XsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4892
X-Proofpoint-GUID: r5de66iUmKUokRG7hWIubOFr3PT_nSNS
X-Proofpoint-ORIG-GUID: r5de66iUmKUokRG7hWIubOFr3PT_nSNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_03,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>
>>>
>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>
>>>>>> The function name in kernel may be changed by the compiler. For example,
>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>
>>>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>>>> should conside this case.
>>>>>>
>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>>>> retry.
>>>>>
>>>>> This might produce incorrect result, so this approach won't work
>>>>> for all .isra.0 cases. When a function name is changed from
>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>> uses the original function signature, the bpf program may
>>>>> produce unexpected result.
>>>>
>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>> by default and offer an option to users to enable it? Such as:
>>>>
>>>>       bpf_object_adapt_sym(struct bpf_object *obj)
>>>>
>>>> In my case, kernel function rename is common, and I have to
>>>> check all functions and do such adaptation before attaching
>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>
>>>> What's more, I haven't seen the arguments change so far, and
>>>> maybe it's not a common case?
>>>
>>> I don't have statistics, but it happens. In general, if you
>>> want to attach to a function like <foo>, but it has a variant
>>> <foo>.isra.<num>, you probably should check assembly code
>>> to ensure the parameter semantics not changed, and then
>>> you can attach to kprobe function <foo>.isra.<num>, which
>>> I assume current libbpf infrastructure should support it.
>>> After you investigate all these <foo>.isra.<num> functions
>>> and confirm their argument semantics won't change, you
>>> could use kprobe multi to do attachment.
>>>
>>
>> I crunched some numbers on this, and discovered out of ~1600
>> .isra/.constprop functions, 76 had a missing argument. The patch series
>> at [1] is a rough attempt to get pahole to spot these, and add
>> BTF entries for each, where the BTF representation reflects
>> reality by skipping optimized-out arguments. So for a function
>> like
>>
>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>                                 const struct in6_addr *gw_addr, u32 tbid,
>>                                 int flags, struct fib6_result *res);
>>
>> Examining the BTF representation using pahole from [1], we see
>>
>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>
>> Comparing to the definition, we see the last parameter is missing,
>> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
>> where the callers have a struct fib6_result on the stack and pass a pointer -
>> is reflected in late DWARF info which shows the argument is not actually
>> passed as a register, but can be expressed as an offset relative to the current
>> function stack (DW_OP_fbreg).
>>
>> This approach howvever introduces the problem that currently the kernel
>> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
>> that introduced optimized functions containing a  "." would have to be opt-in
>> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
>> without that change.
>>
>> An alternative approach would be to simply encode .isra functions
>> in BTF without the .isra suffix (i.e. using "function_name" not
>> "function_name.isra"), only doing the BTF encoding if no arguments were
>> optimized out - i.e. if the function signature matches expectations.
>> The 76 functions with optimized-out parameters could simply be skipped.
>> To me that feels like the simpler approach - it avoids issues
>> with function name BTF encoding, and with that sort of model a
>> loose-matching kallsyms approach - like that described here - could be used
>> for kprobes and fentry/fexit. It also fits with the DWARF representation -
>> the .isra suffixes are not present in DWARF representations of the function,
>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>> and not add the suffixes. What do you think?
> 
> Sounds like a great idea to me.
> Addresses this issue in a clean way.

Yes, the second approach seems a reasonable approach. If the number
of parameters for the *actual* functions equals to the number
of parameters for the defined function (abstract_origin),
we can roughly assume the actual function signature matches
the prototype. Although it is theoretically possible that
compiler might change parameter types, e.g., from a
struct pointer (struct foo *p) to a int value (p->field1).
But this should be extremely rare and we need compiler emitting
additional dwarf data (might through btf_decl_tag) to discover
such cases.
