Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5663F766
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 19:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLASUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLASUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 13:20:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15815A430F
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 10:20:13 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1GY9bU012116;
        Thu, 1 Dec 2022 10:19:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6YckXKYZUC7FMZOZZhLadFgVebN3+R3I7vlAoQL3cwQ=;
 b=dEPbfFUQL1phpM0c3VtTekMDBwhfM1FvziuOAzgjZW3VjsCZZB0xND6M5HqCb8G+SXSa
 Bm4hD30ScBZzNSPeBS4ewvf2IHjvSf8lLBfyb+nqE9ru2GDJc3se5rIO7n+MAy5y/+pN
 tvZdafTOZMIbY3vu6y9deguJUOKeumXPZ/NmMfeKISYoKzQruYjwRgXDhPsb8FtK5hF/
 xACW0nYYsUomJxWmGi4DDuPrwyKrUuGKyUvLGgga2pW9jM4hDsOJi6rIe/J30hVwIZE5
 J9Mhu4Jcrlmpfsq8s6HSR1fHDnDI1HfZ9QQ3Smf82Qa/NkpaTlcm1n4bVfJu56I9lsjQ YA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6mbeefmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 10:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8AvPA/iHn5n9i9BIDTuRyK4CTVbttU7KJntGqDzn3Dv51/zYooQyEnEv4PpIs73ma34fRZRrcpVebuLnQ3Iz9xfXnlNETo/DZBRdmRuURNKcGbJFS3qw8WyZ7u77yMvHCe7iw9DQHzoZrB4p/eJF9UDci/zIMCWkbk8rYK/r8o/KYppOhjoA8GWE1utU5ee8VCvuGFqn5tyANqmXrHznwAKHWm0N8v1sHy8CMYphk/TaAywPEztrinIfvnQM7ymRJImjpiF6dMbh/jDta4kI/36H0Zh5iTDbK7ok/h1W4QttEsaVgGM5S0L0QVVXsZK/hJamO7/WBN9dvZeIC1RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YckXKYZUC7FMZOZZhLadFgVebN3+R3I7vlAoQL3cwQ=;
 b=Bq13jhOTBLkrp4TqtrjB7lrikpR+NKT7lRU3tKghFiub/b+XkxfaRNDRWwhDkcVH0ivqQSeqJDGcRyGYjc5zoub0MCPr4B6fKFX5pTz5l8lmAQ9KqMK2Z3gjGD25v4x1Kbg69ttpS2OZw8M3TOoO1LaryK6UAeZ41z9Uop+bepAGQ9VNSuYJsdz2OyuBIhAOMAvl4RCnVTOfrbPFm/Mss5SVoPYpuUYnavaQRJcpwVVNYBHte/ueS1rzkb2YHXI33jGA9/6uPOS38mGDoGvYI9WhOn4OAxpkbp338Yh3cPTbF8R6RvtrD5kW7YzkaGtiNa7CgCcfAIyHzQ3uDI4KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BLAPR15MB4003.namprd15.prod.outlook.com (2603:10b6:208:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 1 Dec
 2022 18:19:27 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ebf0:6031:91b7:d20f]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ebf0:6031:91b7:d20f%7]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 18:19:27 +0000
Message-ID: <28e8797c-ff9c-dc35-d07a-52db5a7ed8e1@meta.com>
Date:   Thu, 1 Dec 2022 10:19:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix release_on_unlock release logic for
 multiple refs
To:     Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20221130192505.914566-1-davemarchevsky@fb.com>
 <b5d46fd5-2693-cd46-9515-700fef1a110b@meta.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <b5d46fd5-2693-cd46-9515-700fef1a110b@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BLAPR15MB4003:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a4643c-2d92-4939-1eee-08dad3c894c7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eElEP+ktRPqPVTh4tqToOsBnlLEATUDV+mJdMjqpaiJxh9fo7nbXV8jG6Hi1WynxWtVVRkpuyYBsMPvTbz1efkhSazsS2G//k1zy7kBZYfJULXcS79B6uVdXOqX8ZMM5uGLbM+KBc6Uy5HgO7kkCGfvDJUwfopDOFBWfs/Y/H568elCsXflrhh6sSKTPYnQgVyCoXRTsLnvepVozfD1goKF7aBFBoDUWkwUxAZrgjCNrpX8kOfi9M5zD9ihfXKRjSeOmIJA+O4BoyaNuE4+NYdZMpkZWxMYkdsk9VANwwU+4iG0jD2mMfbrL2omEWnTn2EL41JeueswITYS9B6Qv5YEVP6u7I0XlNNPhwiAymXz6q4a5ObCbivBUaXKecGe/GkcXDVY85j0e2vxut/DaeYDSQSGh2bpZxVeR3QA6l9JuhPb/T7KilRrX1hVbILgQv9jMzAUv3jAQ5ckRrfNt8xLEAcvaOFsKx5YQlMpIBxQqzE8ozjCWBntCNjmsiuybJ5MWrFQp9eSymQR5OObfqRm5vkSmhNfpYboLRjNg350tHzsoFJ6NW3lr1QFlzRV8cCM+CYCTJ0nqsZtpIDNuCe6+MIgwCKMLm1nUSW6EDOSon0+QnPB+WsLQqyc8zcJXy9V23VW0+WydUmAn6ycGrJxCYGe99y7h+j4XwF1JxpN8qbUCmW7jY7p564wCL/f7TuONDQ9Wp4glWZWFJxnVwrF/Grwy3PGp/DEaZCZzaHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(5660300002)(66476007)(8676002)(4326008)(31686004)(41300700001)(66556008)(8936002)(6486002)(110136005)(54906003)(36756003)(478600001)(316002)(2906002)(31696002)(6512007)(2616005)(6506007)(86362001)(66946007)(186003)(6666004)(53546011)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVCRXU0c0ZDRXpoK1oweWxUWjhOdHh0OUdwclgrVkt1dTIyL3ZocGFkaVAx?=
 =?utf-8?B?eXVMR3JHMmtEZ3lneW9QNm4rbzR5cWM1SlBUVytXTG5SZFJiYUNxQXNscTVj?=
 =?utf-8?B?eHdPa2tzcUxyY3ZheWM1UnlCeURNS2UyQmFIZ0NtMmNnalZjYWNncTV1NjNm?=
 =?utf-8?B?VUl2T3BiYjhKcmIwVkx6NS9hRVFRRXpUcjlHN0dxSkdkQ09wbElXREYyM0Zk?=
 =?utf-8?B?SThkaDZ2RWhjcUNFNFNXamRJekJvUFNpUWU1WG1sY041VENqYjZ5UXB5Wk5n?=
 =?utf-8?B?THJhOTZCbnV1aHd6dS90UUNKeDgwSC9kV0RPazAwODUvTkpTdWJnRHYvNzNy?=
 =?utf-8?B?UTM2ekZHR3FCTXYxTG4xcVAxdTJKQWdMeWU0WlQwaHk4d20rY2dpdXhOeThm?=
 =?utf-8?B?VHI4Z0N1VnBROFJOVUhGakZJTk5MYTRMYm1rSUNkU0MxYmhiWHIyOXVjcS9j?=
 =?utf-8?B?Nk1HeTliZFk5VHBwaVdKRUk3VzJwaUdJU3AwSUNtQkxtQWJ4ZlZqcnRjMGQ5?=
 =?utf-8?B?S0xZdU80ck5PS0NnbjJraGlwRjZBS2d1QS9TdUlMS2hJa3dmb1lPUjMrWGd0?=
 =?utf-8?B?NVowRzhVNnhEVTlIUW5CU0NJMG9oNTh5NmJpNHpsN1p1ZG1YV1FNTnlhMTJC?=
 =?utf-8?B?QkVDT3lrRGE0NGlINGlOV0IzWUpDK2FNZWFoNkM0cFFCZWFnTEVWbnlabmRR?=
 =?utf-8?B?dG4vY2c5ZnkrRVZNenZBaFBnM2l1RE9SbnJKNllxL3k2aFh2aDkvSnN2WFN5?=
 =?utf-8?B?ODR1SHV1dW1sT3NyUGxWeFFHbVpWY3FsQ3krYWFPajFUNE4xTHJuMGRCSjY4?=
 =?utf-8?B?U0J4WmtLa0tGdTRSblEzWG56SzM1dGFTOUJrN3hhVFhDUEh4NmZFYUJWNTVR?=
 =?utf-8?B?cExIUFVLSDYrUklXYThPZHQ2NTVGYVM0T3F1YmJqcTQ3UE14UzhBTXhNTkhY?=
 =?utf-8?B?dG9rekE1ZzRIUUhsYXBIVVZkZS9yUDVlOFRKcU5HdGlEVlhZdndRa0NRdlZF?=
 =?utf-8?B?OVQ1TjZ3YjhzcUJNK0g5ajdEdHdDVHVwVVN2ejltYlF6Q3JJalcwTk9ra2NB?=
 =?utf-8?B?ckJaSHlNZFRzSTBseW4xTDQ4VWxNekNvZDVYdmROSlhhWFJ3dEwzOWVrR0xN?=
 =?utf-8?B?cGJ3Y1AwS0pyd3E2QXBrSGdTczNhcE82QWhvbkptUjNzTzNSTVgwMHJqSzZq?=
 =?utf-8?B?VXlmZStoR0N4M0R5elNOdEExaDZYOXBwWUU0REs0T3RhTjdBTnlFU3Fwclo4?=
 =?utf-8?B?TEZKdjMrUUJHeWNJaUlLekl4MWthK1VUTWdKMGdrVUJ1WDRidFZmZmpwZU91?=
 =?utf-8?B?MDlpTlVxd08wQlBmOUVJQmVBOGZVdGkxbnMrMnRLVlUvWXkyTkRVNS9OU0RR?=
 =?utf-8?B?RitmK0VNRlFabHlwVmRoUkZvMDIxSlFtU2tkT0RoSVZGZmlPdHdsNXl1bWtW?=
 =?utf-8?B?MTJka05yQ0cvWkw3YVdkaXFPUGh4LzRaT0VOdDIzdDN6T2g0NVVaRnhUTVB0?=
 =?utf-8?B?V1NEOTVOOFljeDVVNERYYndkZTI3THk2R29qYzNVYm9PcDkwb2Z1WUJOMTVl?=
 =?utf-8?B?VzdHNEtvM3gwZkluOUVPRndZUzAxTXA0YUxwV2ZoemxjeXB6SlVhWjdPWGVS?=
 =?utf-8?B?cnNVUFdMcHRtSGJjVEFNVmVhM3psa2gybWhTZHpqdnNMbURaOWFQRXpTQmZX?=
 =?utf-8?B?dHVWU3NCRWdDekxoaUpwUTZ0ZHltTW9pZnhxcGRKTXJndHNvQ1dUemVLWG1m?=
 =?utf-8?B?OUMwMElqbDFzOUNkcFpubC9pV2ZzemMrOUl3K1I4Z0RmRGV0STZVWE9KTlE4?=
 =?utf-8?B?ZUJVK3hta2JaUE5weVJCalZRV2hna2lJdkV3cjV6UmRjYnVEVmtrOXEyUlRx?=
 =?utf-8?B?RjhxdGlOdDlwbzdEbGdwaVlPM0p6RS95d2pNeU5NOWJwTXhhYllIVC90MHdt?=
 =?utf-8?B?MG9HVWJDTXd0LzczQUo5Tmo0OVdzT05CSk9TakxOSlVTVU9OaDRYS1NoeG9B?=
 =?utf-8?B?emJ2UjlhRXpRYkI5d2F6Z0FZb3Z1SDBLQ2ltMkpXKzRwdkZhTzMyRkQvTEg4?=
 =?utf-8?B?RVJtaDJjZXNzdUk2ZHV4L0xXcjRrZnVRZHpLNE9Lem9QcDFEWXFuWjcxeFlw?=
 =?utf-8?B?L1YxU3k0K21mbzFyY3VzTXh3eGVlZDFJdnRzYjN1RnBOZC92WXRHejVBc2xk?=
 =?utf-8?Q?VddinJ9v/K15VHV043Tk4h4=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a4643c-2d92-4939-1eee-08dad3c894c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 18:19:27.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NCYkjuDXbNp/JFO4R06ZG0qZJ6s/SvTSkkulf+GDhncshbQ3gZL5hBsF4U78muisNKyCAqJZ2S1W9ihphQQLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4003
X-Proofpoint-ORIG-GUID: U9ydZIJIC23xdb7demR2SlPVQ8q8Og50
X-Proofpoint-GUID: U9ydZIJIC23xdb7demR2SlPVQ8q8Og50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/30/22 7:21 PM, Yonghong Song wrote:
> 
> 
> On 11/30/22 11:25 AM, Dave Marchevsky wrote:
>> Consider a verifier state with three acquired references, all with
>> release_on_unlock = true:
>>
>>              idx  0 1 2
>>    state->refs = [2 4 6]
>>
>> (with 2, 4, and 6 being the ref ids).
>>
>> When bpf_spin_unlock is called, process_spin_lock will loop through all
>> acquired_refs and, for each ref, if it's release_on_unlock, calls
>> release_reference on it. That function in turn calls
>> release_reference_state, which removes the reference from state->refs by
>> swapping the reference state with the last reference state in
>> refs array and decrements acquired_refs count.
>>
>> process_spin_lock's loop logic, which is essentially:
>>
>>    for (i = 0; i < state->acquired_refs; i++) {
>>      if (!state->refs[i].release_on_unlock)
>>        continue;
>>      release_reference(state->refs[i].id);
>>    }
>>
>> will fail to release release_on_unlock references which are swapped from
>> the end. Running this logic on our example demonstrates:
>>
>>    state->refs = [2 4 6] (start of idx=0 iter)
>>      release state->refs[0] by swapping w/ state->refs[2]
>>
>>    state->refs = [6 4]   (start of idx=1)
>>      release state->refs[1], no need to swap as it's the last idx
>>
>>    state->refs = [6]     (start of idx=2, loop terminates)
>>
>> ref_id 6 should have been removed but was skipped.
>>
>> Fix this by looping from back-to-front, which results in refs that are
>> candidates for removal being swapped with refs which have already been
>> examined and kept. If we modify our initial example such that ref 6 is
>> not release_on_unlock and loop from the back, we'd see:
>>
>>    state->refs = [2 4 6] (start of idx=2)
>>
>>    state->refs = [2 4 6] (start of idx=1)
>>
>>    state->refs = [2 6]   (start of idx=0)
>>
>>    state->refs = [6]     (after idx=0, loop terminates)
> 
> I am not sure whether the above is correct or not. Should it be:
> 
>     state->refs = [2 4 6] (idx=2)
>       => release state->refs[2] (id 6)
>     state->refs = [2 4] (idx=1)
>       => release state->refs[1] (id 4)
>     state->refs = [2] (idx = 0)
>       => release state->refs[0] (id 2)
> ?
>
For this second example, the ref with id 6 is not release_on_unlock while the
others are. So that ref should not be released and should be the only one
remaining after the loop completes. This was intended to demonstrate the
swapping of "refs which have already been examined and kept".

It would be less confusing if I used a new ref_id for the second example
instead of changing the properties of ref 6. Will respin with this change.

>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Fixes: 534e86bc6c66 ("bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}")
>> ---
>>
>> I noticed this while testing ng_ds version of rbtree. Submitting
>> separately so that this fix can be applied before the rest of rbtree
>> work, as the latter will likely need a few respins.
>>
>> An alternative to this fix would be to modify or add new helper
>> functions which enable safe release_reference in a loop. The additional
>> complexity of this alternative seems unnecessary to me for now as this
>> is currently the only place in verifier where release_reference in a
>> loop is used.
>>
>>   kernel/bpf/verifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The code change itself looks good to me, so
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4e7f1d085e53..ac3e1219a7a5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5726,7 +5726,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>>           cur->active_lock.ptr = NULL;
>>           cur->active_lock.id = 0;
>>   -        for (i = 0; i < fstate->acquired_refs; i++) {
>> +        for (i = fstate->acquired_refs - 1; i >= 0; i--) {
>>               int err;
>>                 /* Complain on error because this reference state cannot
