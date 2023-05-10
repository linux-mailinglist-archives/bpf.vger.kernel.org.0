Return-Path: <bpf+bounces-293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1E6FE0AF
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572A62814FB
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C114ABE;
	Wed, 10 May 2023 14:44:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273326FBB
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:44:17 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F461BC
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:44:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A8KUW6022212;
	Wed, 10 May 2023 07:43:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ah/8m1q4erWucAggSUrdv6DeOQq5yXdflS1yHfevnPQ=;
 b=WN6CKJzaDB4LbfRwj1YqtTzJBym5fPv3akuFnCjOxqsk7S68zAsv/NttpRxbd4Ob6H2E
 WQ09ajJHvGvCzGTgzB8yiCDh0Gbq6W+INjNC0N50ao5XA3isFEOlANkMJyaRuUEtzk7S
 c5/Z6B8e83FGGm1lPki7KMYl1cYnM5rbdWWCL8agCFrb+eVLzr2fzFTcgOHx4RpwUC53
 5edYw/S6jbnXKDKxorVqJOGACNlxY+aP1GoqMMsY+yREI57U7Zk2uDBJg9g6ycSUTfQD
 uHf7e+H6PBVvIVUPCjFKo4k+4eNM5G1gHORs7cSl50XGq19IZvdKJaJWKXtn1QuS1Ypa 0g== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qfvekx570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 07:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2zfm1WhzzTqGb783uSCbIxnCHMQZIPnpMxTmhMIkl16/TKyDSZlebBBVClfmK/nVTyHePDchTe8ZuHNSeFIJIG/AAP/K7TJkXKy9bncGGVEBW5aqa2DRlnVAaevY7awuTJIUOa6Kn915TKs5IqGLUU8XOjuaXCmB0enXYvxmNiwums3qgVM88KxNBxccAjSlBtU4dND2C13qX6U6buNpJBA6gAhgmneVEKeLd5xWP3QSRkp3PSrtdjNl/559ZepA2l13ZmsR6Cvj/1OXSyePqn7IE8syaqABnSbqQPdKKJBr3ZScqCVBTlw/KpYm0kDzgDS2sAPfuIcoGfxtr8j/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah/8m1q4erWucAggSUrdv6DeOQq5yXdflS1yHfevnPQ=;
 b=Fy7yzkCnvilMO1VP2ll+DuDJ7DqN9hbLskxlQD+m+ZXVWfLhz56V4jo5fwvKlqHZL/Jg62vrb22ZKbF1vwx2l0dz2998leMrd4KP5tz8xyk2W612HLRK1ph7Hn+hSj6TryxwPhyovc1T1K7QJCa6/Nyy5mOmIPhTUXovdLuka+h/vpIScY7o35dytYNyx933tWwR401l2qWq+hR5IKMWMWxjvis7sGqIcc51D8xfMCiWQKAcCWAiEvM0vrupy44jccwRI7uQM5E+8BCEWjdGXczcx19lzvOTGqxPLu9bt5VAg9wT0YPCSKE0OcEUmxKFQWRnV2gxvouvqAh0VyDmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY5PR15MB5486.namprd15.prod.outlook.com (2603:10b6:930:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 10 May
 2023 14:43:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 14:43:50 +0000
Message-ID: <dae5805d-d240-7219-6e96-96922fda361a@meta.com>
Date: Wed, 10 May 2023 07:43:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] libbpf: fix offsetof() and container_of() to
 work with CO-RE
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com,
        Lennart Poettering <lennart@poettering.net>
References: <20230509065502.2306180-1-andrii@kernel.org>
 <2ce2dbb1-20d5-cd4d-9e84-97d505b57bb5@meta.com>
 <CAEf4Bzampv=wkcdJct2BR3VmAPZvx8_S7RJ_3dbzVo0H2U+Mpw@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4Bzampv=wkcdJct2BR3VmAPZvx8_S7RJ_3dbzVo0H2U+Mpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY5PR15MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a490b8-886c-44ef-9546-08db5164f7ea
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fkDVz2Z2MVaRn0dsD20UeqL+kpt6lRR94pGS5SR5VT8WX+zi/dn2paYpfVsDZG8NCZwnGiuKKtI2BNqrQulWs7qB8UeINPif2z8UqWG7rdbsshl1vZtxcVf2BY2uPj3yz3tMZTQrvkpldW0DPZJf9MAJAqATtYpMvjliMNot0V51XoTd4rRC67IpYai6F8lFToomn6D+xAyOyhRew2HNHBdr9F1lExTzCm60XrRUNtvxnfLQWuGfNCldDfSlm/tEQtsafZdRwmZG3KD3JGb/T3obfM5Az/jzI8ULHi3UQohqIkOLcFxoQFChKLJPI3FkpPILHKjPfVCk8HrrlQ+kxuODjlAnm+vPtPur8ddPO0IOyT80vY+SRtvK3vwz9FjF38az7NNBiTpb8WcRBBDB9n4AMKhOcvE10US7tEsmRXvoaVxOyH0aKjV/cmRKPAL7fvfvCTRZB7licXwHkHQRM8CTdinlkPCjHeoe7OGsnxBgyJ/QYnxiBdHbiuNigqom/Sye7qq3JZLJmRs8h/JeKE0AYwJ9BnJbGjSEeOif4IHqOVRHgUiu+jinWPJClBk75lNqH69wg4PyUT1/funJjo8ZjJBI3x0juCq81/d4ASy5KX8RNAvxeA4EObs0CXawKx90OmuFZtIKMOnz7jMuOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(38100700002)(186003)(53546011)(6506007)(6512007)(36756003)(66946007)(2906002)(41300700001)(66556008)(4326008)(6916009)(5660300002)(6486002)(316002)(8676002)(66476007)(6666004)(8936002)(478600001)(54906003)(83380400001)(2616005)(31696002)(966005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1Q4clBINmhsL0RxN1JucHY4K1piS3pUczhBa1JubFdETTZ2ekJWL1p4NnJH?=
 =?utf-8?B?Vk50anJMNHF3Nm9wK1hHanRZdzQ1cTRmS0VOcXEyQTZSWE5ENndsd1RWS1Vh?=
 =?utf-8?B?T2MrTXcydnloanF6ZHA0dVY4VFBTY29ZRUtZcWplcVN0aFpZeTdhZFE3SjNn?=
 =?utf-8?B?ZlBOK3NHOWx5dUErMEt3Z283QzRFQUxnR0d0aGxyMW02K1BKV1JSYmx1NmJs?=
 =?utf-8?B?RzVsTlFaaU9QSGVyQnl1Y0xadVpTSncxdVpQU0FJR1A5QlgxTjQ5aDZoN3Bu?=
 =?utf-8?B?dVU0OGVuSkVpZFRtWFE3VjQzZGhRekFkaGNHamtvTG1aYzZEa1RNVnlzbktk?=
 =?utf-8?B?RXFQdHVwb0swRVR3VDdqOCt6M2I5NWlHN0dZZ1ljdGtrSkpTR1NYeHdERUFY?=
 =?utf-8?B?T0Nlb3V3bXdvamhrZHVROVllb1ZVVmxFVEVxYUZ4dUtrTDZOSGQ0Y1BjS1Rh?=
 =?utf-8?B?S2prTUh1U29jTUowSXJFT1djZnhPakowUmt1UE9DbjJIdHJOZWxaRXhZdmU3?=
 =?utf-8?B?bDdaNGMzRkhweFp1WUduUHR0K2JZeDVkb2pOTk1BdHF6bjFOUTFrQWlUNDlP?=
 =?utf-8?B?aThpYUxEdWFTVSswZnhORXk4MVI2RkNoaHZ1dU5VTDBDL3ZSczkwakpUVnUy?=
 =?utf-8?B?RFVsYThxdFhZaVo4UVJ1MWdUTmZZZnZyUHN0YVNBQjUrMWQ1cHFta1JyVkRT?=
 =?utf-8?B?SXRPRHlZVklBeTZPZ1FHUytaZzNYZDIwVjIzRkJhWGJsUWpwV1ZPN21YUW1i?=
 =?utf-8?B?RmxWMmx0MTExeVRCZlpGK0tFclEvTE9hSnRIZnpqOVprWmk0ZnFMQktraHVH?=
 =?utf-8?B?ZE8wL3N4R2M4T1FoUGhtYkFiRWRzUWxucW40UDBMVzhQTEpDNVVXVG9HVXlT?=
 =?utf-8?B?YXJ6L3BnTXF5aXRmMURGTTVuT01DYnZGTU5oTUFRejhOWWp5a1V3MmhwQklL?=
 =?utf-8?B?di9RbnF5Y2szbDM0WnNvUzhvdTRRZTRnODluOThSZUU5N1FWNTlwZWVQUDZP?=
 =?utf-8?B?cVBaQWdhQzY2c3YzWm1QR3BZckVsTVRjckZObjZVVS9ycUtJWGRqZUJzWWhG?=
 =?utf-8?B?RmxRY3NzYVZiWlA5VWhqWDlHT3EvU3BSV1ZLdXNjejY4Vlhpb1NieHVqVUJl?=
 =?utf-8?B?R09MVm5wMEQ0Qm5yTnBRT0JyY2poNk0yNk1pQ2dhOEhaTkc2bUJpOFh4dGdD?=
 =?utf-8?B?T0RLVXNwL2ViM3Vod1Q4WU9VeG5Xd2JBemk2ejVKRGdoTHZvTWlCUE16UXc0?=
 =?utf-8?B?bS93enRydUZUckRxR05PNmJzNTBjaXJnZTJ6UGdzVUkyK3RoWk1tUzFSSVFR?=
 =?utf-8?B?dEFqYXBpOHdEeDRXeTVtUUlYWjNRNndzVFU1WmRrZ0xrdjIxTzh6M0V4bVJ0?=
 =?utf-8?B?ekFlTzNKTFFjZU40RnNORzhZb2hERjg2VFRPWllwYkoxcjhOeGZpWnl0N09R?=
 =?utf-8?B?TjFBUXQ1REMxUnJyclVlUmc5K2ViK2laOEFUeUkzekNsSUcvU2pQMWlrYTBW?=
 =?utf-8?B?dXpGR1RJQmhxajRDRmpiazY0MUNqQW00dnZpMTJyeFZjd25YbzJRd3ZxeGN6?=
 =?utf-8?B?cU1xaWwvV05jWWZWNUk4dE1mcTlCQXNDMFdwcUF4VnJabk5sQiswNi8yYlJz?=
 =?utf-8?B?MXZiSHZkQU5JeFAweWxNcllGNW03ZVgyVk1kMi9XTkNRRkZEbDVJaWdGQmVT?=
 =?utf-8?B?SG5kL1NKWnFPS3ptVzlYTzVzOUJNdU9HQVNnMzdNT29LYndRTkFPc1NhY2pS?=
 =?utf-8?B?TDNyQThublJRckhpYVR2UzQ3VXA3RDl4dkcvdEZMR0NVS1NaTTFNVEtBRGJM?=
 =?utf-8?B?NnI1L1YzWFI4SHJwa2FPbUgvWjRHYVp0Z2thaVd2RU8xOVBNMmtQUndabHRp?=
 =?utf-8?B?RnlzU1M4RFRWOVFDeVF5Q253YkhDbnVlY2RETS9hTVl4MDFGWUlPYnlIZGFH?=
 =?utf-8?B?bXY0ZE9DVXh2b1F4T1NFRGl5b09CWWdOOERYdVpuL3daTVVOSCtUTGxnVjlH?=
 =?utf-8?B?dk1YZXhkL0xKMi9OemZwWmVZWVBwcFZVMi9DaW1ocGR5TmtPcFR2NVF5cGdv?=
 =?utf-8?B?ZmczUXVJWkxxSDRQZTNPMGJUeEFZMmJhZ1pVVXR1OHJYU0wvRFdYV2NVRmZs?=
 =?utf-8?B?K1B2RGwxMkoxQU1RZjRPaFErcC9ldmhrNThDTGxkckJnV1VOb3BEVGI2RjZB?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a490b8-886c-44ef-9546-08db5164f7ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:43:50.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6oYYO3/xtRGAjx4sOmhu4Tqfkn4N0urFfETTsn0JvZGssipOptfcKLqHVXeGXiW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5486
X-Proofpoint-ORIG-GUID: 3je1Puivg7Lod1zFeTMyAoA0sWCJioC-
X-Proofpoint-GUID: 3je1Puivg7Lod1zFeTMyAoA0sWCJioC-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/9/23 7:59 AM, Andrii Nakryiko wrote:
> On Tue, May 9, 2023 at 6:33 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 5/8/23 11:55 PM, Andrii Nakryiko wrote:
>>> It seems like __builtin_offset() doesn't preserve CO-RE field
>>> relocations properly. So if offsetof() macro is defined through
>>> __builtin_offset(), CO-RE-enabled BPF code using container_of() will be
>>> subtly and silently broken.
>>
>> This is true. See 63fe3fd393dc("libbpf: Do not use __builtin_offsetof
>> for offsetof"). At some point, we used __builtin_offset() and found
>> CO-RE relocation won't work, so the above commit switched back to
>> use ((unsigned long)&((TYPE *)0)->MEMBER).
>>
>>>
>>> To avoid this problem, redefine offsetof() and container_of() in the
>>> form that works with CO-RE relocations more reliably.
>>
>> I am okay with the change to forcefully define offsetof() and
>> container_of() since this is critical for correct CO-RE
>> relocations.
>>
>>>
>>> Fixes: 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro in bpf_helpers.h")
>>> Reported-by: Lennart Poettering <lennart@poettering.net>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Ack with a nit below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    tools/lib/bpf/bpf_helpers.h | 15 ++++++++++-----
>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>>> index 929a3baca8ef..bbab9ad9dc5a 100644
>>> --- a/tools/lib/bpf/bpf_helpers.h
>>> +++ b/tools/lib/bpf/bpf_helpers.h
>>> @@ -77,16 +77,21 @@
>>>    /*
>>>     * Helper macros to manipulate data structures
>>>     */
>>> -#ifndef offsetof
>>> -#define offsetof(TYPE, MEMBER)       ((unsigned long)&((TYPE *)0)->MEMBER)
>>> -#endif
>>> -#ifndef container_of
>>> +
>>> +/* offsetof() definition that uses __builtin_offset() might not preserve field
>>> + * offset CO-RE relocation properly, so force-redefine offsetof() using
>>> + * old-school approach which works with CO-RE correctly
>>> + */
>>> +#undef offsetof
>>
>> I am not sure whether the above 'undef' is good or bad. In my opinion,
>> I would just remove the above 'undef'. If user defines
>> offset as __builtin_offset, the compiler will issue a warning
>> and user should remove that macro or undef them.
> 
> If we don't #undef, we are almost guaranteed to get a compilation
> warning. See [0], where I repro this problem based on Lennart's
> original code.
> 
>    [0] https://github.com/anakryiko/libbpf-bootstrap/commit/2bad3e7f48e4e4eea1a083620f21eba59aa75b1a
>

Okay, I see. They didn't use vmlinux.h...

>>
>> Otherwise, user may get impression that their __builtin_offset
>> is working but actually it is not. the same for container_of.
> 
> Can we just fix __builtin_offset() to generate/preserve field offset
> CO-RE relocation?

I checked with llvm17 source code. The __builtin_offset() is handled
in two places:
   - clang/lib/Sema/SemaExpr.cpp: func BuildBuiltinOffsetOf
   - clang/lib/CodeGen/CGExprScalar.cpp: func VisitOffsetOfExpr

As expected, the above two functions process __builtin_offset()
without any arch specific handling.

I guess we could try to add CO-RE relocation to them but not
sure whether upstream likes it or not.

But the same issue exists in earlier clang versions.
So I am okay with the current patch with
"#undef offsetof" and "#undef container_of" although
clang headers does not have macro for "container_of".

> 
>>
>>> +#define offsetof(type, member)       ((unsigned long)&((type *)0)->member)
>>> +
>>> +/* redefined container_of() to ensure we use the above offsetof() macro */
>>> +#undef container_of
>>>    #define container_of(ptr, type, member)                             \
>>>        ({                                                      \
>>>                void *__mptr = (void *)(ptr);                   \
>>>                ((type *)(__mptr - offsetof(type, member)));    \
>>>        })
>>> -#endif
>>>
>>>    /*
>>>     * Compiler (optimization) barrier.

