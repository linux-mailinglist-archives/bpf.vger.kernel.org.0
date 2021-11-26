Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD745E77D
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 06:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbhKZFnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 00:43:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358571AbhKZFlg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 00:41:36 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ3hfK0002006;
        Thu, 25 Nov 2021 21:38:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G1tjHBwhuzjMOY3gYe+IS2zmO8dzCA+nlZeBL/kBnjE=;
 b=deVNbJ+09Fz8/G8HHQ2kHSP1oABfDT9qOCPbdgDzf3LoCWyhhF7WB8N/vY4xEjufMWDO
 iKD+dqjWQXLTozhajo8QKA2txeyxj0mvm6SbsOiJrmyyxSEYKlWrdEaIRD6E8+NGNoss
 KbQPsoUxhQXone6f4B8IvU0itLvdPBBACJ0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cj8txcmjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Nov 2021 21:38:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 21:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVuQt2I4ZE17qAxou3i9oSEpgARkE+CKq/JXR/QyqU5hryvxWlVgiq5p32x/Lh5VHLuws1GkKHErAllxAQ7ykNBd2zXxFR/Vnpyx+BPC7HVVrLsBnGc8bqFcBCRH6NhpVrJBulJDNC7VZuCBpRIgX7+DoYKLCIbgyYufGe+bkBT2XR8v1VsrjdqeaH0vPGudBfdcuA6Y5FavaMhyaAL0wRUwSjK0ujGU+zr/Y989fcAR54bVgs2R1baFabmfHnf8q3M1eaPn0SPn+9xIkdXQQ7SDQQ1jpqbZu0HrKQjhyBLdsuPvgqTrpzlQW2mB9Tc01ZMm7jdnnXatGKHBJ9mT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1tjHBwhuzjMOY3gYe+IS2zmO8dzCA+nlZeBL/kBnjE=;
 b=nMwhsF+/NTaWRCzd9o82Q+xYjHgvPfWDXn11fpneDk8lcvfZIgh/rHVFrxBRLxFYCBw7c2fuwgscTxa+igXgaRQl56QCCxJV+XQju5r/i4W1Vy4M9LcwoiSpN1RBI9DkFdz8pkfNFRv4ilIzSqQbLj13wemfVppalnXirXS6dA/+ndQJHPKhVZaSq4OwxDdL6DJbY0OMW1vFklfrnwLajrXndkPdfgJo4V+jqBzv/1HNWxo6sfuNesYu7Rs1rzbjfpzLcmkcBRf9uyRv/3uNnl76A3MQAE4burrQfqwX+v5dnIpiJ913xFAqp8Ao8/74EHey2LT+/Q1bqWm/Y/OIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4920.namprd15.prod.outlook.com (2603:10b6:806:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 05:38:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 05:38:03 +0000
Message-ID: <fde40fb7-f88f-bcc2-f9d8-2ef55e61b16b@fb.com>
Date:   Thu, 25 Nov 2021 21:37:59 -0800
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
 <CAEf4BzYH86PEKA0EDs2VkMCXrKjpLqxB+5Ry0Jsr9aoO+Mi88w@mail.gmail.com>
 <YaABLmIMey52fotW@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YaABLmIMey52fotW@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:300:12b::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e8::1060] (2620:10d:c090:400::5:b5af) by MWHPR14CA0032.namprd14.prod.outlook.com (2603:10b6:300:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 05:38:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b47c3d1-576e-4cd6-1917-08d9b09eea21
X-MS-TrafficTypeDiagnostic: SA1PR15MB4920:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4920E3B2DF20DF573F27143ED3639@SA1PR15MB4920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpOGr3/fcOkQs9eT4nrHUYi33VwopGcAQ5l95jg4Mk85XxSW/rdYGaHSXVlOT0cMDvaEU2dBuezcHcnGdLQDhjEmBobte6BNlZtkL9Pa7WEwfysNUEKRAx1Fz+oKk3b0gYrSZEP8kXv2HzNynDu1QLrb7nA4jNB0ov+yFJxLvURp0LLvtdPAQGv5IlnujczE0o2AkkkivOz1LqNWMFz/LJ59WPJUJUAnEKt0vWLbuWCLB+8DCS/PVDYLeY4NVYpschX+Sp6E0zFc+7+CS8i1zw0KroMvb2RMiWOIGLz6rqzUPfIZGtDtpXvRdbJsShIfU3GvbAgbOEo5W4S9LWwZBm50RDqXMn7k+muR5ul/7M4WxDWnJjk8/M22Bu5/saU0hsVRgrr0Tj4dr0diyUxGS8+mucs/45JbZjqVm9MRyX61OkFQwjGt51N+0N036WQDO6kFEdfVeyVZdqlb6NXbIUkTEa6I91dW+Z/TfT6m2NHqeXDJQkoikIROoNTBMYviCONM2sZHxMDwBfdcSDdC2PAMw+loKWIaywAxoI/B4XV08xzSgUJLVBPXlHloV1RVnTXRHOPl7Q/qmVHCKdFQSu7dQjMhecOABUekOkmMqjEjSrGChEu4ale6YonkiL5/gVJoN3VSZmWiyOT4zX30xDIU6iBY7DbqoDjeVcp1Z27QPxNkEefizkaa/3PavmfZ+yzLXkM6X1iFW7BcC9aIA9c3x8HALdeZS/M0FglZt9/Mcw4eKSBlfPe92OB3swrd4K3EWNZs8EhTA3aGXHB2/OjiDAUWdBJQHv8/MnOoYDy03WRxuzUObEywkCekbytF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(38100700002)(83380400001)(36756003)(5660300002)(508600001)(2906002)(31686004)(316002)(8676002)(53546011)(66476007)(66556008)(186003)(4326008)(2616005)(52116002)(54906003)(8936002)(6666004)(86362001)(66946007)(6486002)(110136005)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWFyOGJ6S2N0RFNuMDB5eXBtelNodHhxcHRkOVZUdHlEaVVJazlYNHM0Q0x1?=
 =?utf-8?B?b1FzNlhFc2l5ME10QXBjclRRTmZnd2RIUkc2dWt6ems2TmdQRWVXbkVPTFUz?=
 =?utf-8?B?VUEybXNkVGwzTVdPMlVIN3pHTjhoaXNrUEtaZUkyK2FkcXB0UGw1bXk2YTJL?=
 =?utf-8?B?SExJL01YTlJoY2xQNU40elJtMVZodmdMSWIwVFpYa2VFWnpISmx3ZjFKSFhG?=
 =?utf-8?B?L2NjaXJpaThIWElCQTlkRkkzYXRjdE8vOGRqUGJTa29UelBHZE1pMUw3dUZ5?=
 =?utf-8?B?bUFuSis0d3JNMUQ3VEdEZ0xCUVNTeWZMdjJOdENqc2VZYUtyclJ1V0s0OXVy?=
 =?utf-8?B?eUw4cnNKQkFYQ2IxYWJjM3BBSW1KSmJ4eEIwZFVRQ1ZOcGJzOWR0VlBtL29O?=
 =?utf-8?B?THEwemdFbnRQWnFqRnpzMnJvaHNyNmJETVRyM0lLYmloOHZ5RVhNNy9oVHJU?=
 =?utf-8?B?eWhTZ0ZKTVFQMzBvcENNUEdYWUhZNW0za3QxODBVVGVUTDBUM3J5UnRUdllu?=
 =?utf-8?B?eHVLdEY5bzJrS052a09wQUFhcXhTSlNsb1NicFlwWFZaZ1JSbTJhTzhIMVE0?=
 =?utf-8?B?OVhLdkZ4VWg5SGV5b3RBR0R2a3JjMW1XakZtY1hva0dyNmh5THZmS014YVBZ?=
 =?utf-8?B?V0VpeEU2aUVOWlU1cXQ3VTFKbjBEdHk0Ny9maDF4aEorbE1RUUV1QTdvdXRK?=
 =?utf-8?B?bEtaWVNPb1U5VWtEcWg5TkRZRUZ6V1BraVBoMk81Nm5nRVVsQUZlQnNIbnJP?=
 =?utf-8?B?MythR3dVWk0xSEU1bTdWRnVGek9BbEtTdTN0OEszM2gwM3NpVEs2alI0eGE2?=
 =?utf-8?B?amhhU0Jtc3ZwWXkvQ1lNTzh1SWhnenhqV2NFMjJJUVRweFJzMkcxMTNLU0VR?=
 =?utf-8?B?N2tIUmZaNHpkMnVMUXE2YXhyTTc4SkhtMllOcmlnYkhVMzhzK3Q5RmhlREQy?=
 =?utf-8?B?R01FUnR4cVRFUEs1WkxzSG9hWjI3R1hRaEpSMXNMZHArcU1IMHQydGxOQVJp?=
 =?utf-8?B?M2RjNlNYSXlTQnRNeHpha2xaVDB5WWltMWZrSUFQQUxvbW84N1FEMi8vSWJN?=
 =?utf-8?B?bUloM3Rsanl2TVFXRmJGMHcrV1dXZmNmQnR6Wnlrd2l5R05CZXdabHBCSm5C?=
 =?utf-8?B?NDd6RGJKTHRINlgzcnNUWk9hRFN5N2tnSUFVbDBXajE0L0ZGRndmeVFhaG5O?=
 =?utf-8?B?dnRGazY4YlRMVm92V1Noak8ySUFYMTNKeDFIRXg4WEIrd1JqYW9Ua0xuRlpQ?=
 =?utf-8?B?Ylh0aWlocm5jcTZIV1kxcnFKbk0yNTltQWpHcExzaEhoNE8vVUMxaFN4LzNF?=
 =?utf-8?B?SjFhd0hkd2ZZc3ZFRStOU0huQ1JyTGNVbzdJMFdQamJIcHNBdkZHak85VHZj?=
 =?utf-8?B?VG1kQndSRGQrU2xtK2pHWjV0dGE2ZWFWUCt2SWp6MWlqdkpwN2N4ODZhQTJw?=
 =?utf-8?B?SHk5R2F6eFQ1K05lWmFWMktYVFV2UEhST0VOR2NlUmtsbWdIMitJUkhVMEgv?=
 =?utf-8?B?cnhDYXU5N2tiQ2dUNlRCOFRVbm0rZUc4cnJlS2hFakdPN2w5cndLdXRzVktL?=
 =?utf-8?B?c0F4T2JtSHdGaXJWVmIyWERUWnZqRlBHazN3cFNOaEl1US9UM25OOE1xRGZD?=
 =?utf-8?B?V0taRmMrL1lKWkNPNjQrYkxZQ1FsVmlpT292WXFxaURxYVFMeDU1UlNweUtK?=
 =?utf-8?B?WnFBWXlHOUVoVFdrRm5BbCtzMnlwNlpnN21wc2VMNnloTDV0cmxEZnhiREFm?=
 =?utf-8?B?UGc0SHc4eVk4eGE3MWpMMkJRMnNzZW5oNjBmV09iNkhhZTZpNkw0azFqNmNR?=
 =?utf-8?B?VkZqWUovRVpqSUNBSzl0R0V4RitIUXcyMWd1aXdCamxuMkRZaXRrMHJ4YzdF?=
 =?utf-8?B?WkNWcWhhRTMxb0I1ejNkTGR4eGpzVkpBQXhxMUNFZEg2UHd0aDhIUFVFdldq?=
 =?utf-8?B?QXloYmRiM1V4S1VndUhzU0J6SldDWjYwNXlhYjl6L0RudTQ3Z2NLTHM4K2Fa?=
 =?utf-8?B?dEFHeC9DWEszaTl5VXVSNzE2UW01Uzh5eDZiOUl6NXp5RnZpbGE5YkxKQnJ5?=
 =?utf-8?B?WFh5TlAxWm90bDNCWlRVbnBNRFJYVEozQVIvVlp5QWhka016NTRFR0dXZkdm?=
 =?utf-8?Q?fhGSwJ10JYSKxrGRQeQtDRVG+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b47c3d1-576e-4cd6-1917-08d9b09eea21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 05:38:03.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ykr6UcSxSM030M0exkTWFPpJdAQWU/Hc+dBzmM8iUmwsk+rhNS878xn3Er1H4j4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4920
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: N14mkWJ_1fRFYwBX2lHAKIzFsIS_9GR4
X-Proofpoint-ORIG-GUID: N14mkWJ_1fRFYwBX2lHAKIzFsIS_9GR4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_01,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/25/21 1:33 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 23, 2021 at 08:49:17PM -0800, Andrii Nakryiko escreveu:
>> On Tue, Nov 23, 2021 at 3:36 PM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> Em Tue, Nov 23, 2021 at 10:32:18AM -0800, Andrii Nakryiko escreveu:
>>>> On Mon, Nov 22, 2021 at 8:56 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>> btf_type_tag is a new llvm type attribute which is used similar
>>>>> to kernel __user/__rcu attributes. The format of btf_type_tag looks like
>>>>>    __attribute__((btf_type_tag("tag1")))
>>>>> For the case where the attribute applied to a pointee like
>>>>>    #define __tag1 __attribute__((btf_type_tag("tag1")))
>>>>>    #define __tag2 __attribute__((btf_type_tag("tag2")))
>>>>>    int __tag1 * __tag1 __tag2 *g;
>>>>> the information will be encoded in dwarf.
>>>>>
>>>>> In BTF, the attribute is encoded as a new kind
>>>>> BTF_KIND_TYPE_TAG and latest bpf-next supports it.
>>>>>
>>>>> The patch added support in pahole, specifically
>>>>> converts llvm dwarf btf_type_tag attributes to
>>>>> BTF types. Please see individual patches for details.
>>>>>
>>>>> Changelog:
>>>>>    v1 -> v2:
>>>>>       - reorg an if condition to reduce nesting level.
>>>>>       - add more comments to explain how to chain type tag types.
>>>>>
>>>>> Yonghong Song (4):
>>>>>    libbpf: sync with latest libbpf repo
>>>>>    dutil: move DW_TAG_LLVM_annotation definition to dutil.h
>>>>>    dwarf_loader: support btf_type_tag attribute
>>>>>    btf_encoder: support btf_type_tag attribute
>>>>>
>>>>
>>>> I thought that v1 was already applied, but either way LGTM. I'm not
>>>
>>> To the next branch, and the libbpf pahole CI is failing, since a few
>>> days, can you please take a look?
>>
>> We've had Clang regression which Yonghong fixed very quickly, but then
>> we were blocked on Clang nightly builds being broken for days. Seems
>> like we got a new Clang today, so hopefully libbpf CI will be back to
>> green again.
> 
> It is back to green, so I moved next to master, i.e. this series is now
> on master.

Arnaldo,

Is it possible that we could cut a pahole release in the near future?
My kernel using btf_type_tag patch ([1]) needs a pahole version check. 
In old pahole versions, a warning about pointer type subtags not 
supported will be emitted and btf_type_tag attributes (as pointer type 
subtags) will be ignored.

   [1] https://lore.kernel.org/bpf/20211118184810.1846996-1-yhs@fb.com/

Thanks!

> 
> - Arnaldo
>   
>>>
>>>> super familiar with the DWARF loader parts, so I mostly just read it
>>>> very superficially :)
>>>
>>> I replaced the patches that changed, re-added the S-o-B for Yonghong and
>>> tested it with llvm-project HEAD.
>>>
>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>
>>> Adding it to the csets.
>>>
>>> Thanks!
>>>
>>> - Arnaldo
>>>
>>>>
>>>>>   btf_encoder.c  |   7 +++
>>>>>   dutil.h        |   4 ++
>>>>>   dwarf_loader.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>>>   dwarves.h      |  38 +++++++++++++-
>>>>>   lib/bpf        |   2 +-
>>>>>   pahole.c       |   8 +++
>>>>>   6 files changed, 190 insertions(+), 9 deletions(-)
>>>>>
>>>>> --
>>>>> 2.30.2
>>>>>
>>>
>>> --
>>>
>>> - Arnaldo
> 
