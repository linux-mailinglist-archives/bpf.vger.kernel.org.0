Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A666A8D3C
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCBXty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCBXtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:49:50 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4D22DEF
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:49:49 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KUrG9023782;
        Thu, 2 Mar 2023 15:49:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6vs+UbuNmCFHacjOnMIN+6NaT0bMkE04Mq4/OUc7Ul4=;
 b=k64/oNB8ji5bCHL2ZXaGpez2M2ULm6Q45UshjI/KBmyIP0wpn67D0Qae/6xdprn2nMMC
 z9lTiC78WWx0s27T3Av2Ne3+cXAtqd+qV+EBEl6/3aS7FhrIq5q94d6evZ1sOCXdHF3J
 NbeNPfeCnMuzyKcsH2+/4qpQgtxvBdudPLes07oqwjX1PSg82/V8iY+2oSGth7NSWkjU
 T0uM5ukf7bIR3ZpkraGihBZc7ybELPadShBZ0fHQnZns2iF/Y99V7NNkQJPNE5Y4u0HV
 a6+DTyzH8LxXkVUVIE3uq/6wMj3gIySMLfojHULMioLfcTR1BECsls+0S8/saaT6s/EG Og== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2kwwq2jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 15:49:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+TdoZnSQrORkwuRs4jFt3y+8WDgXKaBSMV3NiWbYYJdsrfbSuWySa9vg2UxWGH3vhvpAShXrzcwhxqAp6t9fAufWV/oRjVVvcg4n0DZ7UAomXbr/VhrWl+7xVsexWwYrWiiguQi55WTDEoUDGRge0RGXkgtVNypgp9L3AriuLo3k/JiNlro++0ZwWkdZQcOn0AONVkGxZlGv1fyqYce+rJ7ObTCyRYYecpMbm8PLXVEQO/Uicbrof8jUOUt5qkzt4DWOiGpFp2mThy7JXzAoSGNNJ0R/k7yv94qqhUWH7hO90AFOcrIOuzhqxsL8nIlXXGOiB5DDKI1zKo4Zc80og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vs+UbuNmCFHacjOnMIN+6NaT0bMkE04Mq4/OUc7Ul4=;
 b=EBiEuiNp159SmVRdDZyczOYJRYbwtX76leu2jjvQtccbaMkFlWpVdGJyiSWUXQzksSFJmhynsTk48l+WTO8tYon45Dd+bOWLV8BF2bj+ZOE6PqjpS/ZWtW/p2vN2q9Xqmfhq5zwQy39PY3kzDiYRlSANSseTep1xicLhcGiFDEhTCCPaL2nyWlF4D0r/HDklA5o8iBfbn9I7IC4C/1HO77YOAZg2YwTt1IeY7c5p0oc2b2OpYyrDy5yBs+WUcgIMh90UG8HjvBSV5BE50kfJGfxxuxdPMcc7v5Lz4nAae+zL3hQWaXVxrTV4gpFox35dCpYCpbOEICkBmFUXnsvUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 23:49:31 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81%8]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 23:49:31 +0000
Message-ID: <884b0fea-7f59-9d4c-522d-44bae82d3af9@meta.com>
Date:   Thu, 2 Mar 2023 18:49:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add -Wuninitialized flag to
 bpf prog flags
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
References: <20230302233528.532299-1-davemarchevsky@fb.com>
 <CAADnVQL1Lh4r1TJe5LH40m6uRV9jV8FndFbU2AD0oXLepFfDDQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAADnVQL1Lh4r1TJe5LH40m6uRV9jV8FndFbU2AD0oXLepFfDDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:208:239::35) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SA1PR15MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c1d3d5-5346-41ea-2963-08db1b78c45f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+L1rVqfz+m5NDyFQ1kZ0pR87wdClnb+kyHz7LyUaLtGHuu75sIaRsLQ3DTezjbyMxf1a1EpQyp8I4wci0tNWIcL53MzCKy34r9YypWs7omWcTFsgU4W6gqis+rrC5V3ME8ZYE8bI8qLEYO2L1DIrYVPs6IfWjTBKc23N7gCxBV5bphNw6EzIQq/EtdVzGGDZP1jLOSHmEfS3qW/0wWbbNvPjQzJdQ6Mx3YbVuZ2YvwyPfnwmE2as1iREwpN15WltokFYxwh8n/c6z7hnecLGvDa/rwjkw04eWdJ+X7z5mycP8WAfGp1uVoyMc4Ql4qxEuYaDxKyYJmM6Uy0f1bf4a+8zYz4CJx5kAsL7azfdPD0VxsmV8oQpvyBVV94VNtW2uvoHCtEDQGnF9s9ohHZqJf8uGyX3UCKWTHLpSdQAGZmx3hXcUJbSnbGEmk0nfRMD5kIy77VelVVODP1QlQHL2kR8YKi0r+g1dUL8fhilM/CZ6p94yTzha/zbGVEEuk+1m65M7GG2Dbi28JYyhArPGxj0H4ah+xdm2NEM42SgcQZLOGUBbcK+P/YiYNyfkuvVGVMBPf5d14rf7+jmtFtNg9AMrWrMV2ozt5mjtyBL5M4Vi7wX+RZ5gHjbMBfa1flbIFk7pU7gRBfE0FNNXf7rV+GMQSbKIvmga75YjmOuwRIqhgEwXDF3FJKZx7I0KW6TxPJAsh+BHyR73niH5KX4i4sibCH0+Fmn7Ks2ZmXVko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(38100700002)(36756003)(5660300002)(31696002)(86362001)(4744005)(2906002)(66556008)(66476007)(66946007)(41300700001)(4326008)(8936002)(8676002)(6512007)(6506007)(53546011)(2616005)(186003)(83380400001)(110136005)(316002)(478600001)(6486002)(6666004)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJDM2xYcThZUXMrODVJdnkyNzVFU1FSLzVrbWJaSXdnME1WSTJNVW1SazZp?=
 =?utf-8?B?K1BrRzJpcEg1d3VzVzhQSVJKQXdDYWZIaEhUTEd4U0N5YnpWU3YwMVEySmYx?=
 =?utf-8?B?THErOHVQem1pSjZlWk0zZXJVRkJGa0UxamxFRFRnRm1GSUcrMWphZmsvNnp0?=
 =?utf-8?B?VndBNnFFNXBXeDFVamZJSWk1L25DcmZQRHZGMEJHWVAzTG55OUtQUlhiY2po?=
 =?utf-8?B?RXYzSUlmQ0ttNW0xU2Z5MHlkbGdhRVNkSjBBSlYxMmNrM0Zoa2RSQktxWGov?=
 =?utf-8?B?Y0tHVXYzcFJpZVNZdit5cHk0b09oanBvRTdWV0tSY1ZGdlAydStDYnMyNndG?=
 =?utf-8?B?S3pXYW1xUE9CbDRJSEJmeVM2ZDViQmtXN1ZHYXNvMXhpcEQ5Sjd6cnR2SkN4?=
 =?utf-8?B?bkRlQit0ZktQcExkbG1FYVdSakJiUWMvM1pBVjFWRUNMSG1TZkhvN0FJbjNN?=
 =?utf-8?B?enlHZTUwcHVNbytVVWFrUnFUbGNnYWE2TDBsZ3p5aVE4cC81QnVoYy9mUExO?=
 =?utf-8?B?ZldyMmZLSzk5UU5VRHJQdGxOcW9DZ2NGcnpyQ1V4NHJVRk53bHFxQ1I3WEgy?=
 =?utf-8?B?U3lqMHZyWGFzTWVENUtBVUFkSFNBeW5wUFVlYUVtd1BMRlJVRSt4VldSVFFL?=
 =?utf-8?B?UVppaVhiQSt3WWFIR0V1Rm41V0ZZTVZhOWplbVphZzdUL0ZKbFR0a2NCc3JP?=
 =?utf-8?B?OTRwOFNQZTNlRk1pSkp4eXBGOW9lZFJyUFBmeTdlbUI0VVFRcTdFSXRtZGJh?=
 =?utf-8?B?RURHNWszU0NZaTZhVWp5eTBqMnIxWFB5YWxWeEh6MHZ6T3hVa21nZmdERnFU?=
 =?utf-8?B?enFhbFhaaHkyRW1IdTAvOUxjbWNOcW53NnNjdmhicUhtKy9JMWgwaTcwMWZh?=
 =?utf-8?B?RTFOVENhSjlockNtc3hwdnFKY0FSaUxLMDExNEFaenJZY25iSVNrYmw0N3Bo?=
 =?utf-8?B?akcveklDL1hKYUI5a2NQdXczWkM1OWR4MWM4a2NnYTRVK0hMOEx4UHlIdkxZ?=
 =?utf-8?B?UTB5VWdHNFlsck1LVVpkMUJ6OUpMTlRNZW9XcDIwUTJoN1lhVGFEa3RueVFo?=
 =?utf-8?B?VWw1SzBkUm1UYUkyamUrdVRsVW9oY1Q5WHpnKzlFNVE3Z3c4eHNzbFFJemU1?=
 =?utf-8?B?eXQ1NEFOZi9tM0NkZXlFZ2xOZkpYQzFCNUpvSUMzeThLTXhYTU0ydERLV1ZL?=
 =?utf-8?B?UnJseWM5WWpXZ2t3WHhGZEkzMUowY1RqNGVNUnpKTmhGZHNlNEhLNndhOFN2?=
 =?utf-8?B?UlpyQlNrRGdRc1BtVW1vSUFMdWt1R0MxYnc3aXlnaEhXemRrTDdEOFE2UVFk?=
 =?utf-8?B?LzVkdmc1MEFXeFRoQlhIWS9wSklSVG9XTjdqZzZjd2Z5cFo3TXFEcGhWekk3?=
 =?utf-8?B?b1MzakJyT1BjTFpwZVhyaDZKQ3ZxVGsrMy9PMEdiaG9WZDhZNTlpYjlZNkxi?=
 =?utf-8?B?d3o5MUFEVlZDbEwwOS9PV2FSMzZjeXJMd3crZGtjSElhUkNYY1hIRE5vMnJv?=
 =?utf-8?B?TmpMcjBlQTQ1eVEwYXptNC8xVWV6WVNza0c2Y05RZWM0dFdRZ25Vb2lGdkx5?=
 =?utf-8?B?S0dURzMwMjNGRVBuL240S3lHeldGMXI0QTVNWXFwaDBrTmRnNXhIcThtK1Nm?=
 =?utf-8?B?NlhKQ1lSWS9Zdmc5dDdDRG5uVTVFaW1IZVM2NFg5WUZBNTBoakVUeFJrVk90?=
 =?utf-8?B?bWVQa0JLYktPTmdsRWJwSEJZdEFRbVhNSG5ZN21lR0RONjBOM1dhcWFKeUds?=
 =?utf-8?B?T0haSDJJZGtmVEpTZHI3aDRhUkJ5QWk2SjFwQmhlYm92enNvamVKRU83U21P?=
 =?utf-8?B?TUkrM2hFVWc0U2J2aHVTYTJTaVh0LzN0Y2RLZXBaM0p6em85RTZjQjA4cE9T?=
 =?utf-8?B?TVNiakYvOGliNDYraHFtWmhRVStwd095SWVPSDVrZTJCaGFLUWRqK0ZGeFA2?=
 =?utf-8?B?WCtkcStwTTZldnhFWkZlakVRWTk0STR4dlI5TDNjeitidWl1UGRtaStYUFFI?=
 =?utf-8?B?U0JHMUh5eXpxNFF5M0d5NjJGMlZCbG5XaGVJeXU1UjByWnlCdDVrZmViR2dw?=
 =?utf-8?B?RllGQnJraElIeUV3VmhuczlaaEZhM2Ntc3BUTlZTN1MwMzNUQkRZTEU1ZjRZ?=
 =?utf-8?B?bWtjYXpUMm1tUncyOGlna2VxNlFtVHZEdklMYVJtZW9GbDIySnh5eE9kbW82?=
 =?utf-8?Q?s4kUW2g0Xga8fdIYQfFmFf8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1d3d5-5346-41ea-2963-08db1b78c45f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 23:49:30.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWKYzwFhubG71jLBOS75T1JDKhlEy9entjT2Ijk7Wy2QTUCw7WpykQO69B9BevDcIaYw6n9R9uBwd170IMjODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-Proofpoint-GUID: 0t-rlIAcD2ZO532DMzgc_9h3zS9JVi8d
X-Proofpoint-ORIG-GUID: 0t-rlIAcD2ZO532DMzgc_9h3zS9JVi8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/23 6:42 PM, Alexei Starovoitov wrote:
> On Thu, Mar 2, 2023 at 3:35 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> index bf3cba115897..4614cd7bfa46 100644
>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
>>
>>         bpf_spin_lock(&glock);
>>         res = bpf_rbtree_first(&groot);
>> -       if (res)
>> -               n = container_of(res, struct node_data, node);
>> +       if (!res)
>> +               return 1;
>> +       n = container_of(res, struct node_data, node);
>>         bpf_spin_unlock(&glock);
> 
> It has the same issue.
> I don't think we should rely on the order of basic blocks.
> If 'return 1' block is happened to be a fallthrough
> the verifier will error on 'lock is still held'.

Whoops! I understand what you mean now. The issue
is that I'm returning w/o unlocking here.
