Return-Path: <bpf+bounces-984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A670A2F7
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DEE281A69
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78014A82;
	Fri, 19 May 2023 22:52:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F925210B
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:24 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD301BD
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:21 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JMOnYn008234;
	Fri, 19 May 2023 15:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gFCBOwp2KHi+v3W0C9I1+CwPh00wNBb2CGrTRmpyZ3A=;
 b=KFFahq6O9tqY0YXuGgzW+7hRwxsQMzFEzUsrksu6jvFLr2xMz3EkJnTNISaOVd7XdAIQ
 NLFPclm7ugNF+kojGZhow0hqQq97m3tF3HUecwNHZ4zP8dTCRcdzYbPE/da6aYM1/QiE
 /TzZ+TYqtc72cpob+NH+CAUI0fROeLxGUdxPf6Qxw6enH/bD+rAcSDIzGklh1iP8iNta
 K4BKl4IVVsUHKu7ezdaVviVN0Juau7bOGo0PUSc888uUEoFXIpEAPQuJb2kvAcA7tOrg
 lxKlzmGq34isKgn7ciy69irhe82uGcD55XKQW3NgRHftP9rQct9ZGXwrdu3Z0yySvEFq MA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpaujb6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 May 2023 15:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMOEowatmRHBXK+2NSz51ofs+8sHb7ASd3mHKjzsWU2f+JJcd9ApSDCAd9+6+JEpMNG7YkHHSRzwef+N34cMDSK/5krhKAezXNRXpqK/MawKFJ1ywJL3hg6o/d+o78lanXTmPEGJ28ts/n85azHL1YLSrrQ4Q4ibiADuQe+g+qbDMq14m1GwRbv5CsYhVl3vH8tO7fTMFEvNAtKMQTcmIRKcA3t+wdw6gYe3vJ7cjv7a6/LmZpMbF5X8K7BsIkqH07w1Saz5b8TSKB1Mb3pfjqVQ+sLqrgMRryIiSN59/EdQ5FzNq7sIkbl3lFUJzPlSmOV0i4AUQbuEZn9nU+qEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFCBOwp2KHi+v3W0C9I1+CwPh00wNBb2CGrTRmpyZ3A=;
 b=HV7Xjvbsfsq4TFGqycci0crvsbjXP+0jf2TBTd7yyB/G7DFKWgPJZ9lSVEIBQVgs37+Te30Yv4e6iI4r+jwC8tXHhxICc0nRqiLfeKkPUazlTbqEFtBW90AVvnfoIFBfgW4/G1OVo/nmXHo/Znea2r1MN9vhZez4yG9q1qEE9kQShgBb/IdgcK0F5foO5PURVCaUqQGn0Kw3+3pXG6ZtVQ61z88SzUZJ5DB3LdfABMoeVBBBS9b9pfmmryAJkVV6/OuzxreP2cpPFIL4bpsvo0I+v0jE35xHaWDThCDkHK7zAlSlYV7J3V4XE2aX9HDZFsaLL35vMrr3RjonK3m0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB6323.namprd15.prod.outlook.com (2603:10b6:8:185::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 22:52:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 22:52:16 +0000
Message-ID: <d5082488-588b-93ec-5d8c-731dab0217bc@meta.com>
Date: Fri, 19 May 2023 15:52:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v8 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock
 in iterator
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: bpf@vger.kernel.org, kafai@fb.com, sdf@google.com
References: <20230517175458.527970-1-aditi.ghag@isovalent.com>
 <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
 <CC590F34-1A80-41D2-87BA-9247910D0434@isovalent.com>
 <2fb9b408-0791-4a33-bd0f-298703c740c5@meta.com>
 <9C2CEA58-12CE-4B30-982E-043F37B1BEAA@isovalent.com>
 <E861CB20-306D-4F14-B29A-4482C3190765@isovalent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <E861CB20-306D-4F14-B29A-4482C3190765@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: f8408682-ef20-4e85-f81e-08db58bbb133
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1peMFS0vhx4GYSKtjdqji82Bq2RhryrU/AtgUcaizGpRMk2bDEmEwC872tTbVYDqszN61L7jMElMupWkbBJC/evrkcQz76FBiNveraPiRcH5QGTLxQuDVTJ5B0ScONrLz86NpEm9jxbF5FQC4qqStIxA60a2fXUJR3rslIK8lSBjGu2SiLKXOPBCn18VbvbQZ61GIvId1YKa0zWlZ68Eqi1SVHH7wTshFAnd8zP0LMH1fJJV0hDH818fsQgQh8EAiza3KXRomrmtrYxp82XMiUTQWaMUDvU5f9dMyoLPMmJArAWBNCtNYCccPfQ164uWDAK58S9vQMc5Pm01TQMWf0youOQ6pu0EDMmFKmGASR0noTrjPUmVV9uPtKP9yv9i9SqKaLVovbZi8HpxiYs6i+PzLQDpmBbO0cFA4DvwcgEfHDs3Ojqgy8n0DyzOBxi4QrDRla//cQZxFecouh8uZbjag00VGSQlJpn9XcVb8R8ePTF7x7ju5GBQlfFTFbpXe/9NknKQwoMNTQ2fm8o/v/y0nlQqYnLMK9v90+F0yDutD9HrIKddPPiZxXIgnGqmx7gH99rcI/2gVQwDC/0uc+k5rqabOaftD/WOcHD7v1IrPpbrOkJ2y9ae0IN5pkPulmkwA1CFidCNfTHbET4p/g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(6512007)(6506007)(6666004)(8676002)(6486002)(45080400002)(478600001)(316002)(36756003)(186003)(4326008)(2616005)(86362001)(31696002)(66556008)(66946007)(38100700002)(53546011)(66476007)(6916009)(83380400001)(41300700001)(2906002)(30864003)(5660300002)(8936002)(31686004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXFYR0orTGFvaDczdHIzSEhRTjlmdE5DbWgvc29nV0NNNG8wcmxycFhuc1dp?=
 =?utf-8?B?MTNHWTlsOEl2TDI5dndpMTJtYWV6SjNLS3huV1JtR3ZGeXVpQjNsWEgxOUsx?=
 =?utf-8?B?eUQ3SGg1eXhoT1d0R1lSNFFUMGJSQnhUSkZEMGE2b0hORE1WTFlNZEpoblln?=
 =?utf-8?B?aEs5VytnNm1EeXd2L2pTNGVXczZvQWVPQVVKWW5RRTREc0U1M2Uvd3R1N29x?=
 =?utf-8?B?Ykl5c3lVTVVMcEd3TytvQUlFZUVkektYeUNXWVlUeDFmYlYwU0lkczZvNElD?=
 =?utf-8?B?SFp1MWx1SlJLdVhvQi9BSWFZVWdOWGRIWjJTM3F3RFkyZHVWM1l3NmJybmNC?=
 =?utf-8?B?dkVXaWJURitYYlJRd2h6czBMRnZ0amRJdi9vY216TkZSK0dpSHdqRUhheHVG?=
 =?utf-8?B?UVp0RktFNnlDdE1mZWVzSjVuL2hsc2pPWnJhSzlXRFNScTVWUEVKdVZ4K3gz?=
 =?utf-8?B?YkNDV1pPODNRSFU2QkhlUjBBMGZRWThrbk5mY1QvcnliMUZJK0tBVUR6bE4y?=
 =?utf-8?B?N3VtSGJ3cGg0ZUhaU2QrZ3JsRmdWQ1FramlrZDlVWWp4c2NGRUhHeVFCYitO?=
 =?utf-8?B?bzVkNks4bm16MW4zTnV6M29nU2VSek4xSDhtS0NQbU8wZVZaaGdIV1IxUUNB?=
 =?utf-8?B?VTBlbnI5cGxid2JTWmtQalJKNmRCa0JUZGt2dThUdlZOenBwSjZTQXlvaDNV?=
 =?utf-8?B?RGZmNkljeFZPY0F3YzZybGR6SGRqS0lxZEVwNEk3VXJDVk01MVpneUpJZ2RB?=
 =?utf-8?B?SVozVEJTTGM2QmpjOFN0L3hVbkpyTWhSTHg5c2dJUFNiRXNFa2g3WndUUjBY?=
 =?utf-8?B?bDBRZkdNSWZ2S3k4NDFhVldxVTFZckpZd09NQlhHQWphUGhaeFRnUndZQW5U?=
 =?utf-8?B?Q0cwRCt3TXhGTjBqc3Zwa3BrZVNvMUhpNDVLR1pJYWdvUmpCNGE5ZzJIYlgw?=
 =?utf-8?B?czVtT3JyY1BKZkZ3aGN1eXBlTmllTUdOaTk3bUhzcmZKUStJWDhZMHFUV3RD?=
 =?utf-8?B?WjlZQ3M2V0xHQmRGVXJyTlhWblRVUkp6MTBXNno5YmJCRVhsaXRvdEpmRmlQ?=
 =?utf-8?B?cnArYmVac1JHQktHUWZnTm14WTFJZElxT0piOTVRRDI1RkhPV1Vtb1RnV1lr?=
 =?utf-8?B?bTZlZGhYemQ1cW16RzA4YTcrQy9BTjVHNWhGSGYvTFR1aDlvZHlkQjVUNHdL?=
 =?utf-8?B?T1RrdE1tRllTS0t1amxkbThVZFBZYS9EWjNRRnpKK2o3dXVqek5oVG9vZENl?=
 =?utf-8?B?M2wyUE9SWER1cm5Va0JCQ3VneWh1dmQ1SVNuWXh4WEpXV2xvTk8rQ21nS3Zr?=
 =?utf-8?B?SENLbXNYZndERTRYckxvZ2psL0JsTW1nSTA2cXpneEJST3l0bk15Q0hGNGdq?=
 =?utf-8?B?Q0EyN3J5b2ZCdEZ4YVhCU1o4YmJKbEcwOExnT25tQUpIdHZLVTJBSXZSYWI0?=
 =?utf-8?B?SFZ0bFRBVUhBYld6ekxjWlJmUmJoOU5YZlhnenhVNVBvUjh2TU5vcGRtbHFs?=
 =?utf-8?B?Sytlb1ZYQUdZaTBSUlJKamR6TGltdWJCVm1nWnFXSUJUVVJXQVA2RUl0U1A0?=
 =?utf-8?B?KzN4WVI3TUYxN1ZZa0srQWppekpHUU5jdWpGUmYxTlkvNytpYjJBY2dJbTRT?=
 =?utf-8?B?aUtaOE1nMFEzcnlqUlF0NTRvRHNSa1E4UjRCSnNnY2JFcUNJSlZHeG9CMS9j?=
 =?utf-8?B?L0dwbktZVGJnSkhJZDhmK3RCUTM1Ly9qZWNOLzBQWEJmbnBRQ21mVFZ6L2Jt?=
 =?utf-8?B?c094K3lTSVczcm5oVzZTR1ZuTzdqU1pibHBRTEp3MDFKd1VzRXJDM2lwSFRI?=
 =?utf-8?B?SnRDQTRlUjIreG51ZXdVVXEyeXFHdHdGYU9janR5cWdhaWN2SmU1a0EzNWZK?=
 =?utf-8?B?UlY2c211bkI0S1ZDMk43SGM3U0c1ckhkRkhJUm90cjVPaXFmbXZsbGE4OTdS?=
 =?utf-8?B?NFNnOTNZbkpwMkozalhwWXkyVGsvUXR5Nld2VWtlSExVYkdTSGptMkVVcEVP?=
 =?utf-8?B?b1pKUnVJeER6OVY0V24xWVZ6WFJ3cktycGVhZ1g4VHBQc05ydVFWYXBoaTJL?=
 =?utf-8?B?OG5YeUM5ZnNnTTVaRHN1S0oyRGF3bTBoajk4TW5oOFo5d1dnV1BGNE1WdVRT?=
 =?utf-8?B?c0xuell6YnFrTHVldE1QUzdjd1hPR2FrTFVmVnRXUkVYMDM5UkxNVGlBSU1W?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8408682-ef20-4e85-f81e-08db58bbb133
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:52:16.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkzbPbJ/b52Af3sX0U5uMjGYQSimkE+e4EJGntsWdyUI2h8qRJepXdLjgZAggL8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6323
X-Proofpoint-GUID: AQY2hN4MjJDHmtjr47H9FVT0bAjh2t3O
X-Proofpoint-ORIG-GUID: AQY2hN4MjJDHmtjr47H9FVT0bAjh2t3O
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/19/23 1:24 PM, Aditi Ghag wrote:
> 
> 
>> On May 19, 2023, at 7:55 AM, Aditi Ghag <aditi.ghag@isovalent.com> wrote:
>>
>>
>>
>>> On May 18, 2023, at 10:45 PM, Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>>
>>> On 5/18/23 4:04 PM, Aditi Ghag wrote:
>>>>> On May 18, 2023, at 11:57 AM, Yonghong Song <yhs@meta.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 5/17/23 10:54 AM, Aditi Ghag wrote:
>>>>>> This is a preparatory commit to replace `lock_sock_fast` with
>>>>>> `lock_sock`, and faciliate BPF programs executed from the iterator to be
>>>>>
>>>>> facilitate
>>>> Yikes! I'll fix the typos.
>>>>>
>>>>>> able to destroy TCP listening sockets using the bpf_sock_destroy kfunc
>>>>>> (implemened in follow-up commits).  Previously, BPF TCP iterator was
>>>>>
>>>>> implemented
>>>>>
>>>>>> acquiring the sock lock with BH disabled. This led to scenarios where
>>>>>> the sockets hash table bucket lock can be acquired with BH enabled in
>>>>>> some context versus disabled in other, and  caused a
>>>>>> <softirq-safe> -> <softirq-unsafe> dependency with the sock lock.
>>>>>
>>>>> For 'and caused a <softirq-safe> -> <softirq-unsafe> dependency with
>>>>> the sock lock', maybe can be rephrased like below:
>>>>>
>>>>> In such situation, kernel issued an warning since it thinks that
>>>>> in the BH enabled path the same bucket lock *might* be acquired again
>>>>> in the softirq context (BH disabled), which will lead to a potential
>>>>> dead lock.
>>>> Hi Yonghong, I thought about this a bit more before posting the patch series. My reading of the splat was that the deadlock scenario that was specifically highlighted was with respect to the pair of bucket and sock locks.
>>>> As for the bucket lock, there might a deadlock scenario with a set of events such as:
>>>> 1) Bucket lock is acquired with BH enabled in a process context  (e.g., __inet_hash below called from process context)
>>>> 2) the process context was interrupted before the lock was released by...
>>>> 3) Another context with BH disabled (e.g., sock_destroy called for listening socket from iterator) tries to acquire the same lock again
>>>> contd...
>>>>>
>>>>> Note that in this particular triggering, the local_bh_disable()
>>>>> happens in process context, so the warning is a false alarm.
>>>> Right, the sock_destroy program is run from the iterator as opposed to BPF programs being executed on kernel events. However, my understanding is that because local_bh_disable is called, the lock dep validator treats it as an irq-safe context.
>>>> Based on my reading of the documentation [1], there can be a deadlock issue with the bucket lock by itself (ref: Single-lock state rules), or deadlock issue with the pair of bucket and sock locks that the splat highlights (ref: Multi-lock dependency rules).
>>>> Let me know if this makes sense, or I'm missing something.
>>>> [1] https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst
>>>> -------- Posting a snippet of the splat again just for reference  --------
>>>> [    1.544410] which would create a new lock dependency:
>>>> [    1.544797]  (slock-AF_INET6){+.-.}-{2:2} -> (&h->lhash2[i].lock){+.+.}-{2:2}
>>>> [    1.545361]
>>>> [    1.545361] but this new dependency connects a SOFTIRQ-irq-safe lock:
>>>> [    1.545961]  (slock-AF_INET6){+.-.}-{2:2}
>>>> [    1.545963]
>>>> [    1.545963] ... which became SOFTIRQ-irq-safe at:
>>>> [    1.546745]   lock_acquire+0xcd/0x330
>>>> [    1.547033]   _raw_spin_lock+0x33/0x40
>>>> [    1.547325]   sk_clone_lock+0x146/0x520
>>>> [    1.547623]   inet_csk_clone_lock+0x1b/0x110
>>>> [    1.547960]   tcp_create_openreq_child+0x22/0x3f0
>>>> [    1.548327]   tcp_v6_syn_recv_sock+0x96/0x940
>>>> [    1.548672]   tcp_check_req+0x13f/0x640
>>>> [    1.548977]   tcp_v6_rcv+0xa62/0xe80
>>>> [    1.549258]   ip6_protocol_deliver_rcu+0x78/0x590
>>>> [    1.549621]   ip6_input_finish+0x72/0x140
>>>> [    1.549931]   __netif_receive_skb_one_core+0x63/0xa0
>>>> [    1.550313]   process_backlog+0x79/0x260
>>>> [    1.550619]   __napi_poll.constprop.0+0x27/0x170
>>>> [    1.550976]   net_rx_action+0x14a/0x2a0
>>>> [    1.551272]   __do_softirq+0x165/0x510
>>>> [    1.551563]   do_softirq+0xcd/0x100
>>>> [    1.551836]   __local_bh_enable_ip+0xcc/0xf0
>>>> [    1.552168]   ip6_finish_output2+0x27c/0xb10
>>>> [    1.552500]   ip6_finish_output+0x274/0x510
>>>> [    1.552823]   ip6_xmit+0x319/0x9b0
>>>> [    1.553095]   inet6_csk_xmit+0x12b/0x2b0
>>>> [    1.553398]   __tcp_transmit_skb+0x543/0xc30
>>>> [    1.553731]   tcp_rcv_state_process+0x362/0x1180
>>>> [    1.554088]   tcp_v6_do_rcv+0x10f/0x540
>>>> [    1.554387]   __release_sock+0x6a/0xe0
>>>> [    1.554679]   release_sock+0x2f/0xb0
>>>> [    1.554957]   __inet_stream_connect+0x1ac/0x3a0
>>>> [    1.555308]   inet_stream_connect+0x3b/0x60
>>>> [    1.555632]   __sys_connect+0xa3/0xd0
>>>> [    1.555915]   __x64_sys_connect+0x18/0x20
>>>> [    1.556222]   do_syscall_64+0x3c/0x90
>>>> [    1.556510]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>> [    1.556909]
>>>> [    1.556909] to a SOFTIRQ-irq-unsafe lock:
>>>> [    1.557326]  (&h->lhash2[i].lock){+.+.}-{2:2}
>>>> [    1.557329]
>>>> [    1.557329] ... which became SOFTIRQ-irq-unsafe at:
>>>> [    1.558148] ...
>>>> [    1.558149]   lock_acquire+0xcd/0x330
>>>> [    1.558579]   _raw_spin_lock+0x33/0x40
>>>> [    1.558874]   __inet_hash+0x4b/0x210
>>>> [    1.559154]   inet_csk_listen_start+0xe6/0x100
>>>> [    1.559503]   inet_listen+0x95/0x1d0
>>>> [    1.559782]   __sys_listen+0x69/0xb0
>>>> [    1.560063]   __x64_sys_listen+0x14/0x20
>>>> [    1.560365]   do_syscall_64+0x3c/0x90
>>>> [    1.560652]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>> [    1.561052] other info that might help us debug this:
>>>> [    1.561052]
>>>> [    1.561658]  Possible interrupt unsafe locking scenario:
>>>> [    1.561658]
>>>> [    1.562171]        CPU0                    CPU1
>>>> [    1.562521]        ----                    ----
>>>> [    1.562870]   lock(&h->lhash2[i].lock);
>>>> [    1.563167]                                local_irq_disable();
>>>> [    1.563618]                                lock(slock-AF_INET6);
>>>> [    1.564076]                                lock(&h->lhash2[i].lock);
>>>> [    1.564558]   <Interrupt>
>>>> [    1.564763]     lock(slock-AF_INET6);
>>>> [    1.565053]
>>>> [    1.565053]  *** DEADLOCK ***
>>>>>
>>>>>> Here is a snippet of annotated stack trace that motivated this change:
>>>>>> ```
>>>>>> Possible interrupt unsafe locking scenario:
>>>>>>       CPU0                    CPU1
>>>>>>       ----                    ----
>>>>>> lock(&h->lhash2[i].lock);
>>>>>>                               local_irq_disable();
>>>>>>                               lock(slock-AF_INET6);
>>>>>>                               lock(&h->lhash2[i].lock);
>>>>>
>>>>>                                 local_bh_disable();
>>>>>                                 lock(&h->lhash2[i].lock);
>>>>>
>>>>>> <Interrupt>
>>>>>>    lock(slock-AF_INET6);
>>>>>> *** DEADLOCK ***
>>>>> Replace the above with below:
>>>>>
>>>>> kernel imagined possible scenario:
>>>>>    local_bh_disable();  /* Possible softirq */
>>>>>    lock(&h->lhash2[i].lock);
>>>>> *** Potential Deadlock ***
>>>
>>> I applied the whole patch set (v8) locally except Patch 1, running
>>> selftest and hit a different warning:
>>>
>>> ...
>>> [  168.780736] watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
>>> [  168.781385] Modules linked in: bpf_testmod(OE)
>>> [  168.781751] CPU: 0 PID: 2331 Comm: test_progs Tainted: G OEL     6.4.0-rc1-00336-g2fa1ad98e6e8-dirty #258
>>> [  168.782570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>> [  168.783457] RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
>>> [  168.783904] Code: 00 ff ff 44 23 33 45 09 fe 48 8d 7c 24 04 e8 0f 54 ca fe 44 89 74 24 04 41 81 fe 00 01 00 00 73 28 45 85 f6 75 04 eb 0f f3 90 <48> 89 df e8 d0 51 ca fe 80 3b 00 6
>>> [  168.785503] RSP: 0018:ffff888114557c00 EFLAGS: 00000202
>>> [  168.785964] RAX: 0000000000000000 RBX: ffff888113fd0a98 RCX: ffffffff827c84a0
>>> [  168.786576] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff888113fd0a98
>>> [  168.787192] RBP: 0000000000000000 R08: dffffc0000000000 R09: ffffed10227fa154
>>> [  168.787837] R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888113fd0a98
>>> [  168.788505] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
>>> [  168.789119] FS:  00007fc34f075500(0000) GS:ffff8881f7400000(0000) knlGS:0000000000000000
>>> [  168.789804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  168.790306] CR2: 0000559382dd9057 CR3: 0000000102ab8004 CR4: 0000000000370ef0
>>> [  168.790976] Call Trace:
>>> [  168.791218]  <TASK>
>>> [  168.791434]  _raw_spin_lock+0x84/0x90
>>> [  168.791785]  tcp_abort+0x13c/0x1f0
>>> [  168.792125]  bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
>>> [  168.792701]  bpf_iter_run_prog+0x1aa/0x2c0
>>> [  168.793098]  ? preempt_count_sub+0x1c/0xd0
>>> [  168.793488]  ? from_kuid_munged+0x1c8/0x210
>>> [  168.793886]  bpf_iter_tcp_seq_show+0x14e/0x1b0
>>> [  168.794326]  bpf_seq_read+0x36c/0x6a0
>>> [  168.794686]  vfs_read+0x11b/0x440
>>> [  168.795024]  ksys_read+0x81/0xe0
>>> [  168.795341]  do_syscall_64+0x41/0x90
>>> [  168.795689]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [  168.796172] RIP: 0033:0x7fc34f25479c
>>> [  168.796514] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 8
>>> [  168.798197] RSP: 002b:00007fffc299b5a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> [  168.798891] RAX: ffffffffffffffda RBX: 0000559382dc77f0 RCX: 00007fc34f25479c
>>> [  168.799552] RDX: 0000000000000032 RSI: 00007fffc299b640 RDI: 0000000000000019
>>> [  168.800213] RBP: 00007fffc299b690 R08: 0000000000000000 R09: 00007fffc299b4a7
>>> [  168.800868] R10: 0000000000000000 R11: 0000000000000246 R12: 0000559382b2bf70
>>> [  168.801530] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>> [  168.802196]  </TASK>
>>> The lockup seems true since no further progress of selftest since the above error/warning. So we hit a real deadlock here.
>>>
>>> I did some analysis, the following is what could be happened:
>>>   bpf_iter_tcp_seq_show
>>>     lock_sock_fast
>>>       __lock_sock_fast
>>>         spin_lock_bh(&sk->sk_lock.slock);
>>>   ...
>>>   tcp_abort
>>>     local_bh_disable();
>>>     spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)
>>>
>>> So we have deadlock here for the sock.
>>> With Patch 1, we use 'lock_sock', sock lock is not held, so there is no dead lock.
>>> static inline void lock_sock(struct sock *sk)
>>> {
>>>        lock_sock_nested(sk, 0);
>>> }
>>> void lock_sock_nested(struct sock *sk, int subclass)
>>> {
>>>        /* The sk_lock has mutex_lock() semantics here. */
>>>        mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
>>>
>>>        might_sleep();
>>>        spin_lock_bh(&sk->sk_lock.slock);
>>>        if (sock_owned_by_user_nocheck(sk))
>>>                __lock_sock(sk);
>>>        sk->sk_lock.owned = 1;
>>>        spin_unlock_bh(&sk->sk_lock.slock);
>>> }
>>> EXPORT_SYMBOL(lock_sock_nested);
>>> void __lock_sock(struct sock *sk)
>>>        __releases(&sk->sk_lock.slock)
>>>        __acquires(&sk->sk_lock.slock)
>>> {
>>>        DEFINE_WAIT(wait);
>>>        for (;;) {
>>>                prepare_to_wait_exclusive(&sk->sk_lock.wq, &wait,
>>>                                        TASK_UNINTERRUPTIBLE);
>>>                spin_unlock_bh(&sk->sk_lock.slock);
>>>                schedule();
>>>                spin_lock_bh(&sk->sk_lock.slock);
>>>                if (!sock_owned_by_user(sk))
>>>                        break;
>>>        }
>>>        finish_wait(&sk->sk_lock.wq, &wait);
>>> }
>>>
>>> The current stack trace and analysis likely from some of
>>> previous versions of patch.
>>>
>>
>> The current stack trace is for the iter_tcp6_server test specifically. As the commit message suggests, the potential deadlock warning was triggered for the case when TCP listening sockets are getting destroyed, which is what the test involves. You should see the current stack trace when running only that particular test without patch 1 (which is how I encountered the issue when I introduced that test in one of the middle versions of the patch series).
>> Thanks for the additional pair of eyes on the stack trace analysis!
>>
>> So looks like this patch ended up resolving the real deadlock issue as well.
>>
> 
> Here is a summary and the revised commit message based on our conversation in this thread that'll available in the next revision.
> 
> This is a preparatory commit to replace `lock_sock_fast` with
> `lock_sock`,and facilitate BPF programs executed from the TCP sockets
>   iterator to be able to destroy TCP sockets using the bpf_sock_destroy
>   kfunc (implemented in follow-up commits).
> 
>   Previously, BPF TCP iterator was acquiring the sock lock with BH
>   disabled. This led to scenarios where the sockets hash table bucket lock
>   can be acquired with BH enabled in some path versus disabled in other.
>   In such situation, kernel issued a warning since it thinks that in the
>   BH enabled path the same bucket lock *might* be acquired again in the
>   softirq context (BH disabled), which will lead to a potential dead lock.
>   Since bpf_sock_destroy also happens in a process context, the potential
>   deadlock warning is likely a false alarm.
> 
> Here is a snippet of annotated stack trace that motivated this change:
> 
> ```
> 
> Possible interrupt unsafe locking scenario:
> 
>        CPU0                           CPU1
>        ----                                ----
>   lock(&h->lhash2[i].lock);
>                                             local_bh_disable();
>                                             lock(&h->lhash2[i].lock);
> 
> kernel imagined possible scenario:
>    local_bh_disable();  /* Possible softirq */
>    lock(&h->lhash2[i].lock);
> *** Potential Deadlock ***
> 
> process context:
> 
> lock_acquire+0xcd/0x330
> _raw_spin_lock+0x33/0x40
> ------> Acquire (bucket) lhash2.lock with BH enabled
> __inet_hash+0x4b/0x210
> inet_csk_listen_start+0xe6/0x100
> inet_listen+0x95/0x1d0
> __sys_listen+0x69/0xb0
> __x64_sys_listen+0x14/0x20
> do_syscall_64+0x3c/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> bpf_sock_destroy run from iterator:
> 
> lock_acquire+0xcd/0x330
> _raw_spin_lock+0x33/0x40
> ------> Acquire (bucket) lhash2.lock with BH disabled
> inet_unhash+0x9a/0x110
> tcp_set_state+0x6a/0x210
> :
> :
> 
> ```
> 
> Since bpf_sock_destroy also happens in a process context, the potential deadlock warning is likely a false alarm.
> 
> Also, Yonghong reported a deadlock for non-listening TCP sockets that this change resolves-
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
> RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
> Call Trace:
>   <TASK>
>   _raw_spin_lock+0x84/0x90
>   tcp_abort+0x13c/0x1f0
>   bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
>   bpf_iter_run_prog+0x1aa/0x2c0
>   ? preempt_count_sub+0x1c/0xd0
>   ? from_kuid_munged+0x1c8/0x210
>   bpf_iter_tcp_seq_show+0x14e/0x1b0
>   bpf_seq_read+0x36c/0x6a0
> 
> Previously, lock_sock_fast held the sock lock which was again being acquired in tcp_abort:
> 
> bpf_iter_tcp_seq_show
>     lock_sock_fast
>       __lock_sock_fast
>         spin_lock_bh(&sk->sk_lock.slock);
> 	/* * Fast path return with bottom halves disabled and * sock::sk_lock.slock held.* */
>         
>   ...
>   tcp_abort
>     local_bh_disable();
>     spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)
> 
> With the switch to lock_sock, it releases the lock before returning:
> 
> lock_sock
>      lock_sock_nested
>         spin_lock_bh(&sk->sk_lock.slock);
>         :
>         spin_unlock_bh(&sk->sk_lock.slock);
> 


This looks better. Thanks.

> 
>>> I suggest to rerun based on the latest patch set, collect
>>> the warning message and resubmit Patch 1.
>>>
>>>>>> process context:
>>>>>> lock_acquire+0xcd/0x330
>>>>>> _raw_spin_lock+0x33/0x40
>>>>>> ------> Acquire (bucket) lhash2.lock with BH enabled
>>>>>> __inet_hash+0x4b/0x210
>>>>>> inet_csk_listen_start+0xe6/0x100
>>>>>> inet_listen+0x95/0x1d0
>>>>>> __sys_listen+0x69/0xb0
>>>>>> __x64_sys_listen+0x14/0x20
>>>>>> do_syscall_64+0x3c/0x90
>>>>>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>> bpf_sock_destroy run from iterator in interrupt context:
>>>>>> lock_acquire+0xcd/0x330
>>>>>> _raw_spin_lock+0x33/0x40
>>>>>> ------> Acquire (bucket) lhash2.lock with BH disabled
>>>>>> inet_unhash+0x9a/0x110
>>>>>> tcp_set_state+0x6a/0x210
>>>>>> tcp_abort+0x10d/0x200
>>>>>> bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
>>>>>> bpf_iter_run_prog+0x1ff/0x340
>>>>>> ------> lock_sock_fast that acquires sock lock with BH disabled
>>>>>> bpf_iter_tcp_seq_show+0xca/0x190
>>>>>> bpf_seq_read+0x177/0x450
>>>>>> ```
>>>>>> Acked-by: Yonghong Song <yhs@meta.com>
>>>>>> Acked-by: Stanislav Fomichev <sdf@google.com>
>>>>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>>>>> ---
>>>>>> net/ipv4/tcp_ipv4.c | 5 ++---
>>>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>>>>> index ea370afa70ed..f2d370a9450f 100644
>>>>>> --- a/net/ipv4/tcp_ipv4.c
>>>>>> +++ b/net/ipv4/tcp_ipv4.c
>>>>>> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>>>> 	struct bpf_iter_meta meta;
>>>>>> 	struct bpf_prog *prog;
>>>>>> 	struct sock *sk = v;
>>>>>> -	bool slow;
>>>>>> 	uid_t uid;
>>>>>> 	int ret;
>>>>>> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>>>> 		return 0;
>>>>>>    	if (sk_fullsock(sk))
>>>>>> -		slow = lock_sock_fast(sk);
>>>>>> +		lock_sock(sk);
>>>>>>    	if (unlikely(sk_unhashed(sk))) {
>>>>>> 		ret = SEQ_SKIP;
>>>>>> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>>>>    unlock:
>>>>>> 	if (sk_fullsock(sk))
>>>>>> -		unlock_sock_fast(sk, slow);
>>>>>> +		release_sock(sk);
>>>>>> 	return ret;
>>>>>>    }
> 

