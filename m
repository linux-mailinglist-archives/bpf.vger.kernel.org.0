Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C765349E7DD
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiA0Qnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 11:43:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244049AbiA0Qme (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 11:42:34 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RGabFi012946;
        Thu, 27 Jan 2022 08:42:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tUBAI9ju2S7g3vk/4z+YjoUqotbu0/1nmjmFxRaRS6w=;
 b=aOF+IdJSUBRJ60KONlTykvZ0/DqyUWgr/5SA+eIh9SSYhIcNRXUckck4CrpVY/tSyiYd
 RlE5NWMQA7tZL8HGSUw9MTMIR4b859Wv2ptRvAIGTxtgGUfafJkBIqU8o6jEdNBttKXV
 Jhp7y6vS5swDBa9in2gDpDWbFw0OuO24NGw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ducnv5x5t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jan 2022 08:42:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 08:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPkXDbTv+/R+ZJBkSNZeUVi4GedHzeHQHCjh4XNxje2wdSQyRFmnUgDNEfSV8LXXTWZEnryRVc06tYh74QrHQD2A5xQqFhL5TdovxD0dFizDrDiRTOw1EsMWW78GDTKBMmNRK9RdgGC3vJyQ1semRSs4yY4Y3dLjGbLkKzkHsDUBQV+RX2yuUBvseqdnBq9M1gEaunpAQSuDpes8dn2cuo8nYCnmrGtV5nM7iwXYNiUmH/LmFsx0dr+GkRDYGgloZ4dxFC7RIiOuOVRqnd7FYvzbfFHJm5A4RJ6rhjT72pqYAksH4kyi+FH19UPWf+2it+ucZKjWiVrq5wCn/uqBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUBAI9ju2S7g3vk/4z+YjoUqotbu0/1nmjmFxRaRS6w=;
 b=Ogz9VM1BLNYUL7phbvAz5TekGLvF8x9ycUwl4SWCg6nM6l72RN81Cc6jnS8HZPwkXsaUsb7oY+XOCSVbV0TUuyUoZN7OiGKSlILcxyB81T3uBhssPKb1cifjhYIW10gqhjT1L773tQSAZwRhNGoCGHFQmDeLxSw1SvHPReYw0MGGV+cOgYTtUtB5cN0sRcLlbQuv5V7Tyom+d18DMSqrTypOBC+uztNB12Sr3amB4f8gppzzk9WdlwBQvg1Ed2CrLMvdaf3i5GqEsI73dAlwtN4vqEmznFWfNP6ydlE1wvQUxrzW+YIePe+3tyj3LCJnqr42gn/bD8Uc+1SuCuIMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4411.namprd15.prod.outlook.com (2603:10b6:303:100::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 16:42:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 16:42:06 +0000
Message-ID: <5e20c3e3-8074-9a94-ae9c-1ffa3c65ec82@fb.com>
Date:   Thu, 27 Jan 2022 08:42:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
References: <20210913155122.3722704-1-yhs@fb.com>
 <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com> <87sfy82zvd.fsf@oracle.com>
 <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com> <87ilvncy5x.fsf@oracle.com>
 <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
 <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com> <87czlr4ndp.fsf@oracle.com>
 <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com> <87pmodgpe8.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87pmodgpe8.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:300:d4::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396124ba-cb7e-4925-5d91-08d9e1b3f443
X-MS-TrafficTypeDiagnostic: MW4PR15MB4411:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4411F63B51A16192C8F0E795D3219@MW4PR15MB4411.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPM/ywa34UqyoX8YqwePUNa+vCE3ooSzc8foqrtO9XXJZjm6Xr9o+ABHnK6j+zPKdJDt1T8fasvwyCzv3f29tbKwx5pv6r0eQ35fkYsfzuLyVxlc+jdAocUm7Lcyf8gOQ4fXBm1xwY4aUcVf7ISAhCNBTOuxJzvNAdMr1l98fcWW8JyGlHSn5n8lkNvkJT40lMAJktDCcB26JJxYed70PRzzUavJh4tlCyIxykSV+EzCk0JNOqKJUENCCrE/q6exxo5jw8YBg3GBrI9rqiU1szV1kLAp/ENa9F0OfQl4fXhfOCN/QwuQcPLxegCtT3MiBjIL+gqUEURzFRg4JW6Omrv1MRfJVfYxVXjPySd8+rTnku5MdO8E13X0EroqRPkVzAyBjJSqhR694A5i7Xd5K8/Il4gC7uhscovBftOo+L3eFZaO8I+Op0238VzEfR3US3u10//STqPoFYlxbvc226CogeJRa1YMo8Aq+0bx7U/pXJBJ5bC52ensJo11VOeY/14wNp/hjAeqyrC8trJMSZtmvYHkTB+ykail2RlAHdHbxNL6wrmXSJubpVT57kAlkSxVu+jBPhTLudXdBV4JXtMtQzZJKC5eivQXxi61LzEcT6zMYUUZw77+CpT6tIwTtajDaNu1ITIHZLbgFztLodbtqMsD6AmeaD3fPimsvIfOesNMpkuLKcqwZMtjtPFgwfxQPTESwjGBj7GrIMk/0m4crxy1YZNr+6eyOdauGDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(86362001)(186003)(31696002)(2616005)(316002)(54906003)(508600001)(6486002)(6916009)(52116002)(6666004)(6512007)(6506007)(38100700002)(83380400001)(4326008)(8676002)(8936002)(31686004)(66476007)(66556008)(66946007)(36756003)(5660300002)(2906002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlB3RWtLNUQyUTkwNitaRE96b2RjWndpWjNHZ3N5WmIvVTkxYnVXdFBDYm1n?=
 =?utf-8?B?OTBaQnJUNDhKdEQ1MmVxM29nU1hpR0NEN0NFQUppeWRTNW5PVG1WQlFwcVBK?=
 =?utf-8?B?R0ZEYXVyREJHK2h1MHhra0hlTnVUVmJZTEZaSzdMY3VBdWJSV2I0V3lHTVJU?=
 =?utf-8?B?aXBINmVDYTdGd1NWR3pHc1B5Ly91ZTF1am1BVHdncHJ1cU9nUEVVelJWVFcx?=
 =?utf-8?B?eFBkd2toRHRjOGk4WFk5clQyUUg5UXBPMVRjVW5jdEhVK295WTJWSXpmL3V2?=
 =?utf-8?B?UFBieS9raXhJQXVMZ2U3QlFGMmNyYWFMRGp3MEM2d1h2WjZ5TkREREUvUStO?=
 =?utf-8?B?aXc1c1k3a3N0Qm53U285Um5jNUhzZDJwZm9jUm1UYlptaXp4eEdPdFVGR0ps?=
 =?utf-8?B?Q0sxQVFrWG1Yam1obkNRc0ZwVHZScUtWQlJpdCsxbTVhRC9xa2pkcVZZSCtY?=
 =?utf-8?B?REFhc3k4cGJZRTV1aTVycGk4M3NNSHhLRkFQVTFtbUNtMmJrWllUaVBQWlR6?=
 =?utf-8?B?cGRRelFPb2syM2pzM0J0VWVxUHI1V2FaL09sTVJSZ3Z4TWlvWU84YmRucXRB?=
 =?utf-8?B?cEppRXhzNFRNSllkcVJDejdiSmFQRUYxRFE2QWtYZmZobTY1LzVFRVp0amJu?=
 =?utf-8?B?YVFhNEZkcGlHQm1uOEM3UjRjUXRGbmZPN3E5UCtkTTlKUjFCdzhpdTdtZnR2?=
 =?utf-8?B?MkNIUVFLVC9TdUtPeUVSZGFpb3d0eWlyZUFzaVFPZnpRTGpiOVFnTVNxeWVC?=
 =?utf-8?B?LzNudXU5eE1PRkxIVkJ5Sm9zV0lzQ2JrOVpBUi9VK094cFFrZnVIbVJlN2gy?=
 =?utf-8?B?bUNiQWZnY0wxWTRBUHJYOVJhbDlVenZ3bVkraDg0WDlUcVBQN29DVzFEdHp2?=
 =?utf-8?B?Z2l6WmUwYW0ydEF6OWdJMGlVUjc5VmRDK3YvcCs0T0pLWmFSM0ZrdDFwRkM4?=
 =?utf-8?B?YzUyZ3BCd1BmdEJSdTFsSG9ucFFPcXRzMHo4TUI3aFMxZzh6azZoekFnNVhY?=
 =?utf-8?B?aDI0MldNSUJLblRXcUhCM2RiRzRKMnZEMXNhQVhBVkU3Y2VNZ3FUZkFTS2Rp?=
 =?utf-8?B?Sllla3ozS1IvakZ6endpaEdTSWVwYjlLMG1xdFpGUFNrcDRvM0xmSmYvNlRh?=
 =?utf-8?B?MzZlQ2lheEVlaTlQSk1iT1dnZDJkU0p6V0FUY2ZaMmF2YTVyTDMxTFNiN1Q3?=
 =?utf-8?B?L08wM2pTclplZW4xK2dFdTJqODN5TWxVVlJZMVZHZUtqQnZiOXR1MHZCSlB3?=
 =?utf-8?B?VjNKSlRDdjFWRjYvQ2l2WFRxSTUyY21WL2hYbWJlNTNEV2xMWW1zNHlpemxH?=
 =?utf-8?B?MGpaQnRxdGJ5VmNzSzlhWE1zeDBhdDgyZHJYZmxNQ3N5R1hRUU9DVVdtd3FB?=
 =?utf-8?B?NFlzV05rc29XdmdoRGpFQ0lNbWFvNDVkVzAvRnB3ejZTbnZraXpnYUVLNDBM?=
 =?utf-8?B?OFN6cXRRZmRPU2xGY3ltNnFKUHZ0RHRvNzZDck0xRnVJWmtvQ3FEejlMQzlW?=
 =?utf-8?B?RjZCWStxdlo0cndzb0xFM1JXNXFIOWFGTkJRRjYwU2ZOUXMvN1ZYdFpvMEMz?=
 =?utf-8?B?NXlPc1U5Y2pscWhTc2IwYlVNMzI1YTU0T0g0bWE1REhVd3pZNnhycnB5bG9o?=
 =?utf-8?B?TWF3b0RBbTI4K2FNS09nVzZXUGNZbkxDMHp0eThLNVJsdDRFZ1hQWFBxeUlh?=
 =?utf-8?B?dzhDS3M4bjAwZ0o1ZUNyMTZ4RW5FWEJGVnRVbm5pcXlYUHJucnA3aGorbzBS?=
 =?utf-8?B?QktkT05WdjJjY05Lenp3Y0V0eGdvM3hackltYXRucEFPTTZJTHNqQytXN0t2?=
 =?utf-8?B?ZDFKTWFHamRlNUlaZndoLzVZZnJERVZvVFZaTys3M3p6TG02UFFqcUZGMFdV?=
 =?utf-8?B?ZWt3R2pSTUgzeC9sOXBjZGVnb3ZFTzE5YUhYb2FyYnN6dE9aQnc5d05nUGJY?=
 =?utf-8?B?V0N1aTRxaE44VUgyNFA4ZmZhZnpEcEFtTnV6QVYvL2tjY2c2QXhrR01iREZB?=
 =?utf-8?B?SVVRa1ZVWFZhODJUdER1L2hDS29iTVdWR08xRDZMNjFOOEhoeTNWRGJwNTNZ?=
 =?utf-8?B?N2JZVUtSWnF6cW1uQnpyK3JNak54cmFlMmxhMHVvU05hVnE0MXJETWNiVWpk?=
 =?utf-8?Q?Iw8szV15NhVRz7yJQVOzcuPn6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 396124ba-cb7e-4925-5d91-08d9e1b3f443
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:42:06.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR9XORABcWRUgs8pkWSRxrKVSEaPPaH7yev9dlqEZfZS7xLnvRUgAfuLYLVoNVXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4411
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pASsEQnfdcaKMSvdh6oVrXOllldWCC4x
X-Proofpoint-GUID: pASsEQnfdcaKMSvdh6oVrXOllldWCC4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=801 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/27/22 7:38 AM, Jose E. Marchesi wrote:
> 
>> On 12/20/21 1:49 AM, Jose E. Marchesi wrote:
>>>
>>>> On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
>>>>> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>>>>>
>>>>>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>>>>>       as members of struct types.
>>>>>>
>>>>>>       The motivation for this was originally the way the Linux kernel
>>>>>>       generates its BTF information, using pahole, using DWARF as a source.
>>>>>>       As we discussed in our last exchange on this topic, this is
>>>>>>       accidental, i.e. if the kernel switched to generate BTF directly from
>>>>>>       the compiler and the linker could merge/deduplicate BTF, there would
>>>>>>       be no need for using DWARF to act as the "unwilling conveyer" of this
>>>>>>       information.  There are additional benefits of this second approach.
>>>>>>       Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>>>>>
>>>>>>       However, it now seems that a DWARF consumer, the drgn project, would
>>>>>>       also benefit from having such a support in DWARF to distinguish
>>>>>>       between different kind of pointers.
>>>>> drgn can use .percpu section in vmlinux for global percpu vars.
>>>>> For pointers the annotation is indeed necessary.
>>>>>
>>>>>>       So it seems to me that now we have two use-cases for adding support
>>>>>>       for these free-text tags to DWARF, as a proper extension to the
>>>>>>       format, strictly unrelated to BTF, BPF or even the kernel, since:
>>>>>>       - This is not kernel specific.
>>>>>>       - This is not directly related to BTF.
>>>>>>       - This is not directly related to BPF.
>>>>> __percpu annotation is kernel specific.
>>>>> __user and __rcu are kernel specific too.
>>>>> Only BPF and BTF can meaningfully consume all three.
>>>>> drgn can consume __percpu.
>>>>> In that sense if GCC follows LLVM and emits compiler specific DWARF
>>>>> tag
>>>>> pahole can convert it to the same BTF regardless whether kernel
>>>>> was compiled with clang or gcc.
>>>>> drgn can consume dwarf generated by clang or gcc as well even when BTF
>>>>> is not there. That is the fastest way forward.
>>>>> In that sense it would be nice to have common DWARF tag for pointer
>>>>> annotations, but it's not mandatory. The time is the most valuable asset.
>>>>> Implementing GCC specific DWARF tag doesn't require committee voting
>>>>> and the mailing list bikeshedding.
>>>>>
>>>>>> 3) Addition of C-family language-level constructions to specify
>>>>>>       free-text tags on certain language elements, such as struct fields.
>>>>>>
>>>>>>       These are the attributes, or built-ins or whatever syntax.
>>>>>>
>>>>>>       Note that, strictly speaking:
>>>>>>       - This is orthogonal to both DWARF and BTF, and any other supported
>>>>>>         debugging format, which may or may not be expressive enough to
>>>>>>         convey the free-form text tag.
>>>>>>       - This is not specific to BPF.
>>>>>>
>>>>>>       Therefore I would avoid any reference to BTF or BPF in the attribute
>>>>>>       names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>>>>>       makes very little sense to me; the attribute name ought to be more
>>>>>>       generic.
>>>>> Let's agree to disagree.
>>>>> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
>>>>> come up with the best ISA that would JIT to those architectures the best
>>>>> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
>>>>> only. Hence it's called this way. Whenever actual users will appear that need
>>>>> free-text tags on a struct field then and only then will be the time to discuss
>>>>> generic tag name. Just because "free-text tag on a struct field" sounds generic
>>>>> it doesn't mean that it has any use case beyond what we're using it for in BPF
>>>>> land. It goes back to the point of coding now instead of talking about coding.
>>>>> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
>>>>> go ahead and code it this way. The include/linux/compiler.h can accommodate it.
>>>>
>>>> Just want to add a little bit context for this. In the beginning when
>>>> we proposed to add the attribute, we named as a generic name like
>>>> 'tag' (or something like that). But eventually upstream suggested
>>>> 'btf_tag' since the use case we proposed is for bpf. At that point, we
>>>> don't know drgn use cases yet. Even with that, the use cases are still
>>>> just for linux kernel.
>>>>
>>>> At that time, some *similar* use cases did came up, e.g., for
>>>> swift<->C++ conversion encoding ("tag name", "attribute info") for
>>>> attributes in the source code, will help a lot. But they will use a
>>>> different "tag name" than btf_tag to differentiate.
>>> Thanks for the info.
>>> I find it very interesting that the LLVM people prefers to have
>>> several
>>> "use case specific" tag names instead of something more generic, which
>>> is the exact opposite of what I would have done :) They may have
>>> appealing reasons for doing so.  Do you have a pointer to the dicussion
>>> you had upstream at hand?
>>> Anyway, I will taste the waters with the other GCC hackers about
>>> both
>>> DIEs and attribute and see what we can come out with.  Thanks again for
>>> reaching out Yonghong.
>>
>> Hi, Jose,
>>
>> Any progress on gcc btf_tag support discussion? If possible, could
>> you add me to the discussion mailing list so I may help to move
>> the project forward? Thanks a lot!
> 
> We are in the process of implementing the support of the BTF extensions
> (which is done) and the C language attributes (which is WIP.)

Sounds good. I am happy to answer questions if you have any.

> 
> I haven't started the discussion about DWARF yet.  Will do shortly.  You
> will be in CC :)

Thanks a lot, Jose! I am looking forward to the discussion.
