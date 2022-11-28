Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD363B1D6
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiK1TFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiK1TFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:05:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F727FE9
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:05:04 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI0mWT008645;
        Mon, 28 Nov 2022 11:04:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=4gc6BMeWtT/FHUZw7C4XzhT2/asE4rTpSlbdwIWXq10=;
 b=MVsDNl5kY3wPOT9ADkx3GprCb5KKDivI+G88NMfzfVveb5L1cgTNEX4dCzqqJSVw4M3s
 jGW1gLQvVevQZMsLmlNT70WF6EYz3TD1Ireqj41yTwZyUq/NTH1Jt/N8ew1ztYvzoyDB
 Mvaneq6qkYELAsGMhz7MSF/uERakqSYSnifkoTTtGHPfqJpFvRZQO8lIRHWIIvlNuPlV
 tyXv7OtakMWWm7KYhxvsc6fD+yPiXjIkfpP5I+SFWxTM6X/RmTG9bA1vTzWGLDTXjCKY
 JfBDR6IYtWGyBjA6TLLoOPcPPZt7gA6K5zofbpnAaXZGG0ZIbfrk8A/S/JHVDQ6Vgz1b Vw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3gt00wga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 11:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw9L7uU93a/Zn64sY8n5/V1uiFrj2JS8Vph8UuDZ3GqCMta5dhWbe1qLWpC7sZ7p9QIK5yxIg0UjiUY1xuM04xST8bPyUN2P6Uqmc/HYu9vOZe+YoOg61BOBHJpqr8lBPx8ebLUjIS/OFw4YHy2/WQSuL+AXWi+5v4hwz+FHLwYDWoOdVg7dCZp8kPMcaVrYdD1b6D5OhlFhcHIHsFb1RD+sxMlVH2rB56MvxZ70FDgRrlpgbYmI+dY52u/9JEwh49Bg4zkjmMwkjYqlCVtqAgL1be5tc5ZQDKR3LnzcTHTOB+veE498L+25DWm4YYb0d+afbVgVMFTSTpEnjDt57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gc6BMeWtT/FHUZw7C4XzhT2/asE4rTpSlbdwIWXq10=;
 b=ogCWXdMFrBOaNNSfl9BGjHGLxcez62alxlGldYkrVO/omSvU+EobkKtOJGVkkMQ8tDjntqCG1eX3zpSctkJi21crHuze2/1u8qWnzT19/m1WIaXDA9Z/5D/YoeIPb1VWWI2+ViX4669yVI8b97x3cYcVfBzLrxhd9/fUwpT6N2P4gabGWnb6jHmgR2CKvFoSvtrat0nTYB6EknQyrSKzScnXImFZQ3QgTQTxjLqSDeL3aWxp7QwaiF0Q/YwbntbPZYQRKQ6RJVPuQN+zYUrYbbYVwiqos1OOOpGt/HEblln/F3w2J8opTd9F71FfdbiftSnpYPbrQd5EZLBZQR18PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4471.namprd15.prod.outlook.com (2603:10b6:a03:374::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 19:04:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 19:04:41 +0000
Message-ID: <f4b16d4c-9ab9-ad3c-c518-294b564a6348@meta.com>
Date:   Mon, 28 Nov 2022 11:04:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCHv4 bpf-next 1/4] bpf: Mark vma objects as trusted for
 task_vma iter and find_vma callback
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20221128132915.141211-1-jolsa@kernel.org>
 <20221128132915.141211-2-jolsa@kernel.org>
 <CAADnVQKED=Ue_s88Ru25s1UQ+xe2eWXTq_02v_h=qiuxXTck=g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQKED=Ue_s88Ru25s1UQ+xe2eWXTq_02v_h=qiuxXTck=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: b6545bc6-af3d-474c-6434-08dad1736759
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fpM+ai5IGm9S2TINyidQe8P4TNUAby7+RuVoG8FXqjfTCHTB5RN+a8vu8QY2VsgOTsHEqnF4/a03SVCiBs5F1H3Fkm+tJpIxXdFW7hOV7Hg2JI4eYZ5Mls/ZtDcD1rgMl0HxWX88j+KzKgpXKfMcLzPNhxbXgHC0glpgbtyGukt5uRYgOAH9z+KqQmdT/lopUMTE1y4r1jCgGhF3BVyT/Bygf3ZLckGggQkU6y131LDxjSYyUCq+K4zyGxgQzdDY6DRJozCyuB6so9GO8/2eJdko7Pa5n3X2gSdUqLVBJUgQxDPGmTVlW8F/ebG0FI1KHqSeeVpfq/RgxguW1aJWsAiHjK7pDVbeQToLzoU6NQgFqZ9jBmra5C/CBb8fKL47uLc/fUrx7D1Pw3KvtlYa80JStz9gMWrZhN8KM+HVVkRyTnzPNZcdkBTq+ytBnH5b1Tdt+Acek5LWpv/5nX2GU0u2fqBUqLxP2AKBZDq2TyRARX34GEY8Do40OYtyJ+ZMve2mb5L5UmFzefiBl0Ej7vTyBX+xmiCJvrAnXcrHkseRgtI0npISPCauzEoMR4nyaKmrrlERQqxcFYmzBgWe1P3p2pLSSEqwrmJCp1Pse76DDBdh6sQaptlGzsbOqRLU9x/MWov7UxP8z9pAXu33ncYL9wneeQHLoWYTQIsQh5aSfQDlIka/q3+lAAi5IfADeRsSPOSwX9EqukROdM2rGFxcbHBh4DPzrdn8WbLNJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(2906002)(5660300002)(7416002)(31686004)(36756003)(41300700001)(66946007)(66556008)(8676002)(66476007)(4326008)(8936002)(316002)(54906003)(38100700002)(86362001)(110136005)(31696002)(6486002)(478600001)(6512007)(6666004)(53546011)(6506007)(186003)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGp5Q043c3Jia2xFL0pVVFlvQXZoZjdQRHFscnJiUGxHTUh2aUx4Tll6OVB5?=
 =?utf-8?B?b2pXRHhqNzNXbEtVQlNINTZkb2xXdnJ0V1BnUGNyZlFBQXBRdU1LOTFuNVRV?=
 =?utf-8?B?QkJOTzIrK0ppcmptbXFFcmpEVFgxSkpNUzNRRllTSFpiTWNINm81d0ZFYWVz?=
 =?utf-8?B?K09yNVRmVW04VU1MZ2dSYlpmbmpkcmp1T2Y4MFJDSGExYnR5N1BzS1l0NGNu?=
 =?utf-8?B?UjdQSUlQY0hnaFZWY3k1OEd1bVc2aXlkVXI5QXVpN0llR1FRNUN2NVZEVENu?=
 =?utf-8?B?MWxoL1RZZFRHMkdyT3EvQlQ3aEFiWmI2UE9Cak41Z1o5T0dnOGNqWlBPSmpL?=
 =?utf-8?B?MThRSnpUMDZmMFRLZ3gzUGlTOEpvUGlMM1RnREtkRGU4ODZDSGhYZUtmZzdH?=
 =?utf-8?B?cFdoRzRTSDl0TU1uZWRxK3VyR3NkSnh5N3NQaWhPU0o4M3pHY0M4a0daT01L?=
 =?utf-8?B?V3doaVdrTWgzcmdYdGU4UlJuYWh3RnpoblZ1UXJ5N2w1MVBGQTl2ZExjQU90?=
 =?utf-8?B?M0NEeHFSU0pDbDZURGx5UDRiQVFhVkU0NncwbmJuQkpJams1NTc2U3JSQVBX?=
 =?utf-8?B?KzVnK0JNVXIrQUIyMzFpZHQ5eWhjdmlVUEE4SUoxUHJMcG5Cdk00NGhnWUVD?=
 =?utf-8?B?TktiNGxrNy8vZ0RsS1BIbkhZbWdQSGplUDFaWm5DbW1nKy9lUjVETlp4Q056?=
 =?utf-8?B?R1ZvQk1BbWJXKzFJUjQ1VFVVMW5nRjYrTHhvbStncnhGVHhJclQycFFScDhJ?=
 =?utf-8?B?L0xXTzArcVhZdkVYSzRPaE1RZFJYb2tsUlVVSEY2QWQ5Um1xUlpteUlCaldK?=
 =?utf-8?B?Wm80TzRDNHUwZ2RBVU53K3JzamMweFJ3eEcrellieFhKQ2NhWSs2eGRVUDFM?=
 =?utf-8?B?SWZCcFIyUW0xWHdYblpTait3ZUlOUmd0VlZSQXNSb1BUMFpoMzlsOGdqd1pk?=
 =?utf-8?B?UEJXM2R2QTdMaUd3dHhOTm1uMTdKUmFoWGxubzJyRWxxWFlpQ09JWitBS1ho?=
 =?utf-8?B?WWx5UHVmeVhVdncxU2x5UnVVUGRUa1J2Q3ZjQ1Z3RUphQkp6Z203WlhlRGdm?=
 =?utf-8?B?WkFzTTF1VDdXMEZLSXRGMHNwUjYzMHdCTDRjY3E4a0VVR0FjNm9sUkM0Z3B0?=
 =?utf-8?B?RzlSSURRbFI3dWpkK09PS1FkZXFLUytCMkgwYWZnTlRVTmVpbGdPbEFCWkJF?=
 =?utf-8?B?NEx2bXBvdmxpTCtsVFpCaTdUemZ2a0ZsaDd3a21iOGdCM0dyTC9nanh4a3dD?=
 =?utf-8?B?cExzSUtYRjJXbkpXVE1YZVhJUEpRbEpCTDdMbUxMTXZVTk9XMkx6WWhSZEZM?=
 =?utf-8?B?QVFaamlyc214VW1UaVc0TXN0cDhWcTArT3NYbjZjUUJ2MzZQbThQWmtOc2Nv?=
 =?utf-8?B?MTN3UFFOQjRpMzNzeHJNSDJ5aHdOOENKMzFHaUpYVmF6WWxwaDVFc1VmMFFx?=
 =?utf-8?B?ZjFWTFdxMHozWVVEODJUbzRhbzg1b1JyRUc2MDZPQjBCKzYydnlHVlVTRzda?=
 =?utf-8?B?eXpjT25JdW9JL0l0OTRlTndIOWY4RmllS1JZdDV4SnRyc1UwcFRRdG9CeGt2?=
 =?utf-8?B?bEhYRVJEZkMwcVQ5QmpSdDVDTTc3WHQxOGkzNkF1VTAwQlU1QkxVU2ZxZDVN?=
 =?utf-8?B?TU96YkNlRXBvSGV2NjdGQmdXdHA5R0Z3SUswc1RCeEhZZTRnMlJGT2N0b0Ns?=
 =?utf-8?B?c2V0TFZoc011UnlqQnZ6eDlQTUIrTHd1ZmhOU3dCYmsrZUwwbmxzQVBwZVpK?=
 =?utf-8?B?UVNzNnpTSVEyUG02T0Y1ZkllNmFaOTlTN3JmTmtuVUNxTGZCaGpyNzV6cnlT?=
 =?utf-8?B?ZFFGcWxaOW5UNXo3eFpaMTNHMjV0aDhjdTRvSFpVRk8vOEdDSnQybEtvYWxU?=
 =?utf-8?B?QnBQMlhoc1cwdDRSaHVUOUh3TlA1RTlqSDFsMHJUWUx3R3lsWGxGZWlUMEJh?=
 =?utf-8?B?U25TSlE1NmtSc2c4NWloVUJSSGt5ZWpuYXhvam5lbnA5bnVhQzlJV0lMOUtj?=
 =?utf-8?B?VWNYWDRYZ2NaODdha2RGUDNRVUd0a0tBc2RqT0cycCt5THZoajlLTHo1ZEZV?=
 =?utf-8?B?UmI2d0VMRGxxTC9BeHo0cnp2WUd2S0VlSThCTzZBRnFvek42UW1IcjhwT1k0?=
 =?utf-8?B?WlNseEZ3SzlqcnRNN0VlaXFnRnBDcXhBZHRzWWNmTzNLSnpOZkdLWkZIRUZW?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6545bc6-af3d-474c-6434-08dad1736759
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 19:04:41.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJeCU0fDpzxgqx4gW4z9hlSG/YHy9wmiZlam66WYB/Vq2eTh3uP/YKhCucLf5b6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4471
X-Proofpoint-GUID: Hodhkz_n9YWaGkzVIMkCLa_QMPjV_pTl
X-Proofpoint-ORIG-GUID: Hodhkz_n9YWaGkzVIMkCLa_QMPjV_pTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_16,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/28/22 10:43 AM, Alexei Starovoitov wrote:
> On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> Marking following vma objects as trusted so they can be used
>> as arguments for kfunc function added in following changes:
>>
>>    - vma object argument in find_vma callback function
>>    - vma object in context of task_vma iterator program
>>
>> Both places lock vma object so it can't go away while running
>> the bpf program.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>   kernel/bpf/task_iter.c | 2 +-
>>   kernel/bpf/verifier.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index c2a2182ce570..cd67b3cadd91 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -755,7 +755,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
>>                  { offsetof(struct bpf_iter__task_vma, task),
>>                    PTR_TO_BTF_ID_OR_NULL },
>>                  { offsetof(struct bpf_iter__task_vma, vma),
>> -                 PTR_TO_BTF_ID_OR_NULL },
>> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> 
> Yonghong, Song,
> 
> Do you remember when task or vma is NULL here?
> Maybe we can do: if (!task || !vma) skip prog run
> in __task_vma_seq_show()
> and make both pointers as PTR_TO_BTF_ID | PTR_TRUSTED?

The 'NULL' is to indicate the last bpf prog run before iteration
ends. It is to provide an opportunity for bpf program to know
all regular iterations are done and the bpf program can do
end aggregation or print a footer if the prog link is cat'able.

