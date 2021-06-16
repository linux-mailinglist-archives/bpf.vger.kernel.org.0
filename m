Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5056E3A9176
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 07:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFPF5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 01:57:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhFPF5b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 01:57:31 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G5r4Yv006133;
        Tue, 15 Jun 2021 22:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=htW/IthAwcj4vRrCrz7kK10uQmNh3VeKUmU0MCuqfuo=;
 b=q63psD80/XZNt0NSIbr3rp8fySOGEeFcHNs0YVL5a+dVp+W6EdtIVgZFfRuXzY3sOWzd
 eB2O0iHYNd1Ttm5bFCE1IMH+AOksdrHBSaVsmbW31wuudCyIxrIQkGJCmqHJeO1QMF0l
 5SkDBop2Izq0k3+HOzB6ssxia2esXbaSFzQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 396g010qv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Jun 2021 22:55:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 22:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXbrctZsjyMamzrOL8M0aEkV2xxqBdRDHrO/ZUHoyQNQKEJTDE5dDLyV0ELdzjAE/bpcCazrUavCdzI0HS4JVVfl5IV7XHaKp45wWC/cobp2zNRciTtEZB3kFKAz7QolQZ7eeDYmq5XtFBxEV/nVMPp4oiOSzDNTvzwQ2plEA1TQmemBCR7JrK0mbaokBUBrsKA4WpO5ZaHE2Ndlazpl77QMalBV5zQgig/btm7e2UXTEBWhBEbBXPTflYw0UtGpTJuqI1blHrKGwCXB0Kwh3ojqFC5xnj73HNpj2GJT1g03axz6IwOWMJH5KujiQr/aK+iFrUC0MQCISy64CKnMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htW/IthAwcj4vRrCrz7kK10uQmNh3VeKUmU0MCuqfuo=;
 b=FuUFMs2KSH5fbkkJdRdE6Qc49125P5TWaNdar/JJGN+Gb73OKASKra6iDGSWqdvT8Ut8bL1ZgNWuA3qat964eRuIFn5G2KR77XD0KC2poamgtoJpKp2Fl0KHxaICoHOmKBoZ11n6VIYuvnmd3De4Zn4p1WpXkTpqb6nZwGA4gROGBLV9+aOOeFJWbUHvoTgYh2buHBhsLJX6wA623pSru71fG1+kzBMLUP1F1p0XR79BezSWEWuGU2jp279QxMPIhUm6R8s06Ye2uzeXeiZMfPZdbf08WsGdoC1EydBV40bWDZXDAtv4fXim9NOeYwXZwEMRuAeytEoxepYgVIBTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2061.namprd15.prod.outlook.com (2603:10b6:805:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 05:55:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 05:55:08 +0000
Subject: Re: Kernel Oops in test_verifier "#828/p reference tracking:
 bpf_sk_release(btf_tcp_sock)"
To:     Tony Ambardar <tony.ambardar@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
 <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com>
 <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
 <4ec3c676-e219-6aaf-fe5c-76abbb0c9535@fb.com>
 <CAPGftE8d03K4_S1pTyRVWZL7w67FukES_PV8SR=0_6DXhXzjQw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f888e1ef-acef-2b3d-3ac8-06a051f979d7@fb.com>
Date:   Tue, 15 Jun 2021 22:55:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAPGftE8d03K4_S1pTyRVWZL7w67FukES_PV8SR=0_6DXhXzjQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:99ad]
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1441] (2620:10d:c090:400::5:99ad) by SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 05:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ebbac4f-87c5-4af2-9a0c-08d9308b4ba3
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2061:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20612167845C255165FA37B9D30F9@SN6PR1501MB2061.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCJCEYzgPUvWeC/qtJUz7+pjSE46ib2w6pnxaRnqDFHC2jMkz3duWi+hBqsN9jJxBBaVzeEIZ8NO+uiWMSSWLPbl31JB0ABooi8/QXCz4cyCli6GmfDVlozrOI5gR0tkPgNADc2a3VbciCctAyX3Pj1LR86u+FEbriHSrBrnNCzLVLZgyFZc8HT+PLBKvoliMoAio7a1vrDy3shfPhC7TUaJZtpMr0DiLnHRoJrDtjle39Jc/UJDpVbPZ6sfQMYSGTLJ6LeHkg+xf1GHK621rmE+deCQXzzMhb5kRjLX0sUrC2hL88A4O3lho4ZI1e1b+g2qPqh31/gF6XPy7R0BmhPZh8zmjbF4GDQy9ZcTqm1LuOCa+tgQqCl5JH5CUz+zg5V7x81z+MwAl31G7231LT22bNBlZZww926ka4odZz8ssFxPKrfAf3lGzR86pZ7YnAczX4ENSny0wO3qig40FIUtRCjlKcogT+xibZ853Ctx4SW5zMkIj8yZpLLjFHPJbknSFAtYn6OMm9OJWklzHeWLy5TiQvmZJ048wHLKCpbgtpdJFTolt2D42xTGYis+mqjyto7kBjwH2YknOkJbBwnQzAZJDMeGFmbblS5iGC187rzJ/WovUE9YDACuCbxzTGPRhMQ1sRaxE9BPgu2esXQOmSqjBGChnHOPvO1v4b+S6j2pPn7bsYcJI27QeylF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(31686004)(2906002)(6916009)(8936002)(16526019)(83380400001)(316002)(31696002)(54906003)(6666004)(5660300002)(52116002)(66556008)(478600001)(53546011)(186003)(38100700002)(8676002)(2616005)(66946007)(36756003)(86362001)(6486002)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZ3Zk1zVGpSV2tGTkhRSzlFdHRUajRFVW13NjAvV3dBQjBYd0hiWWR4cCtR?=
 =?utf-8?B?TlduS081dlRTVjBtWkJQbHpqcUV0ZTNTeE5WbFFiRG9NbFo0NnFIdU5uZHd2?=
 =?utf-8?B?aGFkZXdaZ1BJR3JqTUR2aWhBZjFHMDdhSlZuY0FJWHA4SCsveHNONkxBcENG?=
 =?utf-8?B?ZjByV2gzbnJDZ2RpQ05GQjJMOGxYSGRMcXZySVU3dVo1aHpWNzVJRWJEOFRl?=
 =?utf-8?B?TFRqb2hBcjZINkpoQmlyMjJ6NVpsU29qWW9CK01SMkpxRHpRdXVYa3puMUVp?=
 =?utf-8?B?cTg1TEpueWwvcEJzb3lIL2R0WGovOWllVStwcmJuQTRES3BEai9XWEd6UDJM?=
 =?utf-8?B?aGtCVXdKcDA0N3QvZklvcVF5dC9oamEvbkpqL1liM3R3clRYbGJlem9pYTRs?=
 =?utf-8?B?dG5URGQvVjBsZXZXbXU2eWF2K2IwRGF5WGpHV2N4ZGdua3hVZG5rMWFJWVdw?=
 =?utf-8?B?YlY4TXQydkVkQXhISW1uNDdhalE2U3RvempTU0JPcElsbUxRaVBzR1d2cnRt?=
 =?utf-8?B?ajFYWWV5TkdZNS9oUUcxSVBZakZEcDBsQmhwbTdNU0lXdldvUnBKcjhqU3I5?=
 =?utf-8?B?SHJ3akFmL1E0UGRjMVp2eW1TRkhoSHVmSm4xQTBxMDlKRzhaam5jQ2hhN2hh?=
 =?utf-8?B?ZUpxcktsNkp2R3hPaFJ3Skw1MENIR2V5QUlKOXI5dXNFcXk3c2I5eVpTV3Bj?=
 =?utf-8?B?V3Rqc09yZVVvUUpCVmJUT0pnSHZESWpqeVVjRk9vdHBWL2x3eGZML3Ivc2hq?=
 =?utf-8?B?U1ltUEpjYmR6VWx5bG8rZzFGNHFpeGw3M1NOOTNnWm5iclZ5Tk5HLzRUajBK?=
 =?utf-8?B?OG5wRmJoWC9Ra2t4VE42bmZBc3N3ZDg3Vy9mYW1RVThZMEZ1NzhSdllPZWp6?=
 =?utf-8?B?bEl3Zm1MN0dhQnZXTk5kNkQxem9vWktiZHIrSmd3Vk9BTyt5ZDVLMFNNWlVp?=
 =?utf-8?B?U3RJNDJzU1lvaytLdXVsRWRCU244OUJBRUlJSCs5RHh6UTZ0aDdYQnY2VlA3?=
 =?utf-8?B?bEMxbEdXUzIyOTVhUkliTFp2ejdOV2tQNzV5ZStsMXZyQ3YwNWVQU3lzUm90?=
 =?utf-8?B?dUJ3N1g1OFJydE9memlkbzRlaGppQjA5WWMxY3lDcTFqMUxhY1lvWktrWlBY?=
 =?utf-8?B?T3JCa1RhaUg0STBERHNoZTdrbzFPMlRCZVBMU1l3dmRGS28rYkVHQStkcWkw?=
 =?utf-8?B?ei9hNkVmZE9Wd1kwbnBvMGwwdUNEZ2k4T041NE1hQU5CQ2VzQllGQ3BMZ3JY?=
 =?utf-8?B?S0lxSXV6SWFTK3gwdHNZUHRQcTZBSWkwYk5CdnVWRDFwamJjek5oVXJhU2h5?=
 =?utf-8?B?Q3pJalJTMExYeTAzUE1NbWVoL3JBdmFEVXNEV2JLNVNySGdacEpOQUJKeU9P?=
 =?utf-8?B?T21nSWlwdlFNbVRRaUtVcmR0UExEVnM4cHUzTCtQV2U0ZksyS0JVY015STVR?=
 =?utf-8?B?K1dLNVA5QlZGeDlyV1FCQXNtc2s5WktGbmRKSE5ka1FUSHptaVhiQ2ZMa2RO?=
 =?utf-8?B?dW16bXZYVGNKK0xPK3lwQkMycDhtbEthRHg1ekRYVXc2VTlIaWJoOEFPYUMw?=
 =?utf-8?B?MWtwazJCOGVZZUFwRjlvcEI0RXFrYXZSK3czSnpCNVlOblZmRjIwdjVNa21D?=
 =?utf-8?B?VVFHamNTYm9pYXFMaVcrSExRNzVCYzFzdTVnUHJrcGhHRlZTR2E4MXdhc3V0?=
 =?utf-8?B?MUppZ2ZRcCtSc09MRVU0eEZQUnk1cHdtUDNhbU1JdWFjRnFjSFpRY3VIV1NL?=
 =?utf-8?B?UXVMcTRYK2ZMb1loQnBOODcvVVJ3Z1I2djMxOVpleldkRjhlZmR2VWxRVnFQ?=
 =?utf-8?B?RS8vL1hibDkxdDdhcjFRUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebbac4f-87c5-4af2-9a0c-08d9308b4ba3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 05:55:07.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy5rekFSAisLblAANaB65fM7kvFYXHxqUwT7qOJ1Qh+XjfaQF5EYOKU/E9qYCpti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2061
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: SVwKmkrBlmj79r-GYzTuQEACKsO0CQlm
X-Proofpoint-GUID: SVwKmkrBlmj79r-GYzTuQEACKsO0CQlm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_09:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/15/21 7:21 PM, Tony Ambardar wrote:
> On Sun, 13 Jun 2021 at 23:14, Yonghong Song <yhs@fb.com> wrote:
>>
>> On 6/12/21 5:07 PM, Tony Ambardar wrote:
>>> On Fri, 11 Jun 2021 at 08:57, Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> On 6/10/21 6:02 PM, Tony Ambardar wrote:
>>>>> Hello,
>>>>>
>>>>> I encountered an NPE and kernel Oops [1] while running the
>>>>> 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
>>>>> observed during development of a MIPS32 JIT but is verifier-related.
>>>>>
>>>>> Initial troubleshooting [2] points to an unchecked NULL dereference in
>>>>> btf_type_by_id(), with an unexpected BTF type ID. The root cause is
>>>>> unclear, whether source of the ID or a potential underlying BTF
>>>>> problem.
>>>>
>>>> Do you know what is the faulty btf ID number? What is the maximum id
>>>> for vmlinux BTF?
>>>
>>> Thanks for the suggestions, Yonghong.
>>>
>>> I had built/packaged bpftool for the target, which shows the maximum as:
>>>
>>>     root@OpenWrt:~# bpftool btf dump file /sys/kernel/btf/vmlinux format
>>> raw|tail -5
>>>     [43179] FUNC 'pci_load_of_ranges' type_id=43178 linkage=static
>>>     [43180] ARRAY '(anon)' type_id=23 index_type_id=23 nr_elems=16
>>>     [43181] FUNC 'pcibios_plat_dev_init' type_id=29264 linkage=static
>>>     [43182] FUNC 'pcibios_map_irq' type_id=29815 linkage=static
>>>     [43183] FUNC 'mips_pcibios_init' type_id=115 linkage=static
>>>
>>> After adding NULL handling and debug pr_err() to kernel_type_name(), I next see:
>>>
>>>     root@OpenWrt:~# ./test_verifier_eb 828
>>>     [   87.196692] btf_type_by_id(btf_vmlinux, 3062497280) returns NULL
>>>     [   87.196958] btf_type_by_id(btf_vmlinux, 2936995840) returns NULL
>>>     #828/p reference tracking: bpf_sk_release(btf_tcp_sock) FAIL
>>>
>>> Those large type ids make me suspect an endianness issue, even though bpftool
>>> can still properly access the vmlinux BTF. Changing byte order and
>>> looking up the
>>> resulting type ids seems to confirm this:
>>>
>>>     Check endianness:
>>>       3062497280 -> 0xB68A0000 --swap endian--> 0x00008AB6 -> 35510
>>>     bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[35510]":
>>>       [35510] STRUCT 'tcp_sock' size=1752 vlen=136
>>>
>>>     Check endianness:
>>>       2936995840 -> 0xAF0F0000 --swap endian--> 0x00000FAF -> 4015
>>>     bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[4015]":
>>>       [4015] STRUCT 'sock_common' size=112 vlen=25
>>>
>>> As a further test, I repeated "test_verifier 828" across mips{32,64}{be,le}
>>> systems and confirm seeing the problem only with the big-endian ones.
>>
>>   From the above information, looks like vmlinux BTF is correct.
>> Below resolve_btfids command output seems indicating the btf_id list
>> is also correct.
>>
>> The kernel_type_name is used in a few places for verifier verbose output.
>>
>> $ grep kernel_type_name kernel/bpf/verifier.c
>> static const char *kernel_type_name(const struct btf* btf, u32 id)
>>                                   verbose(env, "%s",
>> kernel_type_name(reg->btf, reg->btf_id));
>>                                   regno, kernel_type_name(reg->btf,
>> reg->btf_id),
>>                                   kernel_type_name(btf_vmlinux,
>> *arg_btf_id));
>>
>> The most suspicous target is reg->btf_id, which is propagated from
>> the result of bpf_sk_lookup_tcp() helper.
>>
>>>
>>>> The involved helper is bpf_sk_release.
>>>>
>>>> static const struct bpf_func_proto bpf_sk_release_proto = {
>>>>            .func           = bpf_sk_release,
>>>>            .gpl_only       = false,
>>>>            .ret_type       = RET_INTEGER,
>>>>            .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
>>>> };
>>>>
>>>> Eventually, the btf_id is taken from btf_sock_ids[6] where
>>>> btf_sock_ids is a kernel global variable.
>>>>
>>>> Could you check btf_sock_ids[6] to see whether the number
>>>> makes sense?
>>>
>>> What I see matches the second btf_type_by_id() NULL call above:
>>>     [   56.556121] btf_sock_ids[6]: 2936995840
>>>
>>>> The id is computed by resolve_btfids in
>>>> tools/bpf/resolve_btfids, you might add verbose mode to your linux build
>>>> to get more information.
>>>
>>> The verbose build didn't print any details of the btf ids. Was there anything
>>> special to do in invocation? I manually ran "resolve_btfids -v vmlinux" from
>>> the build dir and this, strangely, gave slightly different results than bpftool
>>> but not the huge endian-swapped type ids. Is this expected?
>>>
>>>     # ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux
>>>     ...
>>>     patching addr   116: ID   35522 [tcp_sock]
>>>     ...
>>>     patching addr   112: ID    4021 [sock_common]
>>>
>>> Do any of the details above help narrow down things? What do you suggest
>>> for next steps?
>>
>> We need to identify issues by dumping detailed verifier logs.
>> Could you apply the following change?
>>
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -1088,7 +1088,7 @@ static void do_test_single(struct bpf_test *test,
>> bool unpriv,
>>           attr.insns_cnt = prog_len;
>>           attr.license = "GPL";
>>           if (verbose)
>> -               attr.log_level = 1;
>> +               attr.log_level = 3;
>>           else if (expected_ret == VERBOSE_ACCEPT)
>>                   attr.log_level = 2;
>>           else
>>
>> Run command like `./test_verifier -v 828 828`?
>>
>> I attached the verifier output for x86_64.
>> Maybe by comparing x86 output vs. mips32 output, you can
>> find which insn starts to have *wrong* verifier state
>> and then we can go from there.
> 
> I realized too late your test output must be for a different kernel version as
> well as arch, as the test numbering is different and doesn't match my test:
> "reference tracking: bpf_sk_release(btf_tcp_sock)".
> 
> Given the problem is seen on big-endian and not little-systems, I applied
> your patch for both mips32 variant systems and recaptured log output,
> which should make for a stricter A/B comparison. I also kept my earlier
> patches to catch the NULLs and print debug info.
> 
> The logs are identical until insn #18, where the failing MIPS32BE shows:
> 
> 18: R0_w=ptr_or_null_(null)(id=3,off=0,imm=0)
> R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
> fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm refs=2
> 
> while the succeed MIPS32LE test shows:
> 
> 18: R0_w=ptr_or_null_tcp_sock(id=3,off=0,imm=0)
> R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
> fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm refs=2
> 
> There are then further differences you can see in the attached logs. It's
> not clear to me what these differences mean however. Any ideas?

The above R0_w is to capture the return value for bpf_skc_to_tcp_sock()

const struct bpf_func_proto bpf_skc_to_tcp_sock_proto = {
         .func                   = bpf_skc_to_tcp_sock,
         .gpl_only               = false,
         .ret_type               = RET_PTR_TO_BTF_ID_OR_NULL,
         .arg1_type              = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
         .ret_btf_id             = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
};

 From the above func_proto, it should return the btf_id for
btf_sock_ids[BTF_SOCK_TYPE_TCP].

It does like the root cause is still endianness of btf_sock_ids
written by resolve_btfids.

> 
> Following your earlier comments on the large, endian-swapped values
> in btf_sock_ids[6], I noticed this is true of all btf_sock_ids[]
> elements, based on debug output:
> 
>      btf_sock_ids[0] = 2139684864
>      btf_sock_ids[1] = 2794061824
>      btf_sock_ids[2] = 2844459008
>      btf_sock_ids[3] = 1234305024
>      btf_sock_ids[4] = 3809411072
>      btf_sock_ids[5] = 1946812416
>      btf_sock_ids[6] = 2936995840
>      btf_sock_ids[7] = 3062497280
>      btf_sock_ids[8] = 2861236224
>      btf_sock_ids[9] = 1251082240
>      btf_sock_ids[10] = 1334968320
>      btf_sock_ids[11] = 1267859456
>      btf_sock_ids[12] = 1318191104
> 
> If these are populated by resolve_btfids, how could we re-verify that
> it's being done properly?
> 
>>>
>>> Thanks,
>>> Tony
>>>
[...]
