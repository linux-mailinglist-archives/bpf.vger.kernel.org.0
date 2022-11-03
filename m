Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54C618A7A
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCVWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKCVV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:21:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D01A20B;
        Thu,  3 Nov 2022 14:21:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3KwLEe003488;
        Thu, 3 Nov 2022 14:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IkOxZo+AsK/SBriYI/QVLOKchqqabbuBAmVDZLxf5YU=;
 b=ESj70d63B7gddHmoEMWpxZohAC0hHUUlXEBQI3sz+UILenZtAKSHD7AzaiZav/stzXp9
 +mqvg+phRv/YrNTbMQj1+msPE1iBxEO2aoCJgnL7/6CAImNGyElWTQsppNe8rhHEJJpH
 mRt+umTYwaGl5JcvLoXNmbdhY7qfJXQMKdv50vOQA1PiEPbpYc5BSS/Z9V0DQWoAlOSL
 WElJmVrNYBL1EHTiNADxvRA8BMbal6zFDn2qhqQSZSBDd8UZH4jmmlni1agcnw5uShBh
 ROYK5s8NNH7ICdwJuXpihFJ+By+qPLnLJU5HsnjkxifoGJpEJZDsPpBZJR2cc7MOaWUj Hg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmf7nc3ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2LakxB3kgMKLqUNrm44NwWVU+t0ymP2Tc+tRd9/xShjArVqHqvrjC/rQx6eMGfYpfB2EynHPmlUEn/VfeQNEppY/bUIQ1HbsYdXNyBVmW3vShEX+xd+i8FXTQm7BEYndPdw+RvNhWuyBqJhaLrYMwLRbWZ/PzZ6U2OI+oqGDq6mwckKiuAfwgj6xuS2XXqLsYHqN9xMtwoL37MXG0jND8SlHRtoLO2Fb1LnLpgHDFHCAeT5oYUkGudn5MJSqiPR8JfMY8FhzfmJzK25c0LeR9Y2j4Q5ac5c6bTEG2h6I2m/BxAni1zppvevL8ZiWp7rzqHp3lEGaEgZMVha7ael9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkOxZo+AsK/SBriYI/QVLOKchqqabbuBAmVDZLxf5YU=;
 b=IG9NGFpInQAF7xo0ohS/Z3bHnJe3pxN2YCjyjbyaayR7qWyUu/r603nFZPrzfGmz/WmsexWxMYl1SAmkFUbqS2D+12boeWK7tkJ3wweDI7F86BoWuYAVtJ8hJ2kBQMVuVpj0eA4ajQ7py4N95PaHfGSLhHd+/HvTY/WLyeUun9DAPQHCGU6BAu0Kf+ZfVZGzSnE0CPP0SuenFu0OtFP0ac4JcJL7l1ufe8GSxB3mY3E6ULtj/1iRaqSIJf7eKfPOp7Yqv0Bw/DgOAC2Y3vUDOhB6sfPTx303bYXTK/H5FuhfZxjBoQG2W/Zc4PMSjeAyEF3Ekyi0UFvcrW2ZL5pRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1766.namprd15.prod.outlook.com (2603:10b6:910:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 21:21:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:21:35 +0000
Message-ID: <ad15b398-9069-4a0e-48cb-4bb651ec3088@meta.com>
Date:   Thu, 3 Nov 2022 14:21:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
Content-Language: en-US
To:     Song Liu <songliubraving@meta.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Lau <kafai@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20221101052340.1210239-1-namhyung@kernel.org>
 <20221101052340.1210239-3-namhyung@kernel.org> <Y2DuzmnUm6NIh25a@krava>
 <5b0152db-8a8e-0d8c-0304-8c48b735c3b7@meta.com>
 <CF3D88C5-4D62-48E2-97AB-F6A7FF9CEF9D@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CF3D88C5-4D62-48E2-97AB-F6A7FF9CEF9D@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1766:EE_
X-MS-Office365-Filtering-Correlation-Id: faca6853-5c65-4eb4-759b-08dabde1630f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5tmURg3iuVBq7cuExXuF6Wja0U+uxKgxCORnKXf2iSpjd5/cBOrsCR7k8+JIok3Wt3SjF7iPTZuPh+MkRaOvh0ElD01wqu/5oJSYOy46vGk8mWf0+13aIFyE4JWbNN26reiao4oiukQDCxndvNfG40u7YQV5ukv1PaYVCuhofKSdrUQbT22GC7ZEV0avZwNwLisqg2KuY+4NZs6KSX/XSQE5e/hmDTQ4kxTXyCmX/7xBiUjpLhO2/2b9NLrkORXGRR9Odow4bx6UgD9tXHCmWA9TTHywPgQ0DqQLozA7bwrgS+425IVZOXgjPKbN166nGthtNRbBPXig52VpyEiMJG5kuFE9b5unJ4bd9OhIQe7f8sML1nKUJSXqjiIXMPzW43063OUGwxaBcZ5n4dNAPoDg4zDR8yF+WvOa3JDsraQLvrRn7t2QmJkhZebQw2tXQOYw7QQ/AjkMmfg2hW+OZoRHv00EmRHttOSYoVSgs9dPKQgCCEm4AD1DnkmIrNAXZrxGx75ZGDMO0FYr8ZfXF9EdY7sUj02tyCFv87wqjI6U9UlFoiyDvdbo5Ujylh75OyytmWAQe6QxgFCUp1As4QdcMfueDYIC/qW5m98PN73vuvVZNC+BpqdYTupRE1jVkgJFeUyKLnYZLmpyyTft8B+XptmbcjACsqq7AnoXGTK6krLlCfiCV+32bcuqj1wqCSOKU1fZGrOyTM6ijDc2/Tr2qjfcghdGrrTMKzkY8j+QRKm3qamPHU3FfklzXbNkOGhlTMlp6rMBf+LPCzupUIzO/ABWeSxzXrXI2Ja0+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(2906002)(36756003)(6512007)(6862004)(8936002)(7416002)(41300700001)(5660300002)(66476007)(66556008)(38100700002)(66946007)(8676002)(4326008)(54906003)(6636002)(37006003)(316002)(83380400001)(31686004)(478600001)(186003)(53546011)(6506007)(6666004)(31696002)(6486002)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEpITDY1YXFMV1Rhd1pjSGlRR3hvRU9pdGM5a0M0U3NCNEFBZHpQVGZTTGNz?=
 =?utf-8?B?dkZmS2c1T1FZRU9FWXFwWDVNMnpCRmYvSGl3SGVOanFlZTByVDVkNlVmSEtj?=
 =?utf-8?B?eUxkRFhKWTROKzViSUxPL2daRzFGTFQvN3lnZTNqU29sNHBLWnU3WTErNkw1?=
 =?utf-8?B?c01QdEtCNWRBUHRZWTRYRnJXcGNubW9zdEtENUxyUkJBTkgwbzlCYjliV1Rr?=
 =?utf-8?B?NEJ0eXFKNTNqZjdJRUc1NGNPMzFWQ2tZMDJlUURveE5lZ3lJMjlEM0h3Zk5U?=
 =?utf-8?B?cmtaQnhLOWY3UmdSMVJNWThXY05KMU9VeGpkVmpzbTV6bmNMbFB4bXNZbGIr?=
 =?utf-8?B?WFVTUHpWckxkV2JyenFXTHFkbit1bWh0ZktBWE84QWdMdVY3eC91a2NNL3Vj?=
 =?utf-8?B?YnhaK2FFVlpabTVsOWJwL1RaZHdXNlBQV1ZhYlZrWTkzRDQxQzdIaTFUbGk3?=
 =?utf-8?B?dTl4ZWczWjNId2I2WnQrQldpWVpZdnV3a3Z3RHBjMVpoSmhLTXZCQmRBMk4v?=
 =?utf-8?B?NE1sMlBkYUU4M0QzWWJOQktXMVpxdnlZTVBxTTlRNjdkSXhLQWc4eXRzblFI?=
 =?utf-8?B?RWFDR2NiTitTZG44dFVNN1gvRGhyeUdWRnRINkhnNHdyaC9GSnB3V1RLMk5j?=
 =?utf-8?B?M3ZDZDc3elVEdXlMSXJtVXFQVEIzSGVqZ0I1MGlUYXJ3RkNveEVHb1QyU2d0?=
 =?utf-8?B?ZEF0SEZMZURlK05JOE9id0I1WnRxbGlXa2hvVlRiRHRLQXQrc25Ld1h1YnZs?=
 =?utf-8?B?V2puQ0tVUjNVZXBaVkw4RTRMd1JST09tMnpzUkxQM0M2amRQVGhOK3JpRFN2?=
 =?utf-8?B?UmZjKzMrY3krUWYrQ2prVGRMNGE2ZFpuenpaTk5WaGlINWpacVR3Q05VYW82?=
 =?utf-8?B?Z0lwTWF5UTZXVjVwV09tK2ZkK1MzekZ5dGpoeGFMT2FyUm9TWVp5WThGa0o3?=
 =?utf-8?B?bzZTZzNMeVdSK2VjNExxc1FSdTFaN203Uzlpdmp3eEUwSzRSNzdWTlpLNk5B?=
 =?utf-8?B?MmQrR2Mzc0l3bTcyeDRLelJqT0owM2JsOGRWWDBTWVVaRXI0dG1SOE5RMnN1?=
 =?utf-8?B?TE9BWXVCRzBtSzRPWE1GTmNRZXNoWW9JNW1uVG8rN0NJejNKWXRBdnpLTmF0?=
 =?utf-8?B?c0VkVkxrMzVFREhsRTBtc0lDcGl0VDFNcDg3aEFTYUk5OEkvYXN1V0xiVG9l?=
 =?utf-8?B?LytGUHRLKytoSUxHK0lKTytBR2d5bkl6TzY0bkF0aHBlUWxhU2k4ekd3S3Bh?=
 =?utf-8?B?bEEwanIrZFNrdVRNczhTSjlsNHYvZkFDWDhNT3J3clIxWFlwTXVDV1A2azk4?=
 =?utf-8?B?bFJaeUgrWXlvajdLNmVzWmM5THFOb0NxeTJnZ3MyWDQzM0NtSWIzTnJWS1dP?=
 =?utf-8?B?L2lNUWF6a3NCdUF0WDE2WGF1ZEhFa2FtMXNnTEdLUXdpd2ZuOG9iZ1paL0Ro?=
 =?utf-8?B?OFdRRHVJNXpwNzlScldHUWNiTmExSUtpbTBzOTNyR0dJaS9sWjI4Q0VaSyti?=
 =?utf-8?B?RkluTWJoRVBjRDJXYVlZaTF2TlR6cVdFSXFiT2wrMUI4OGNKMTBuVS9hWjRm?=
 =?utf-8?B?dWRLREs5bFVvMDJNUENGVlJnMjhCSWxoeXJUd1dUbjVER2ZpZHUwc2pvQlRR?=
 =?utf-8?B?WmQ4RGdXN2crS1FWeHdERDBvSDdQTFMrTnd0WElvU1dXUGJRSHI1emt4K2dH?=
 =?utf-8?B?SlN5SzFIcnYxVXNkUEJ6RytRbXV5bnMrODNVRlFTREljUS91MFRMaUc0b0p4?=
 =?utf-8?B?cndmV09xeWFCeEU5ZmJGQnpPRVlGYlR4dDNxekpFdXdEc3ZjbUtWTU12SXkz?=
 =?utf-8?B?SHNxT1REWGNFR29xYXEzTTlCOCtmZTQ3OEt4ak5tb0MrcTc2QWVmcFpwWEVJ?=
 =?utf-8?B?OE1Tc2pOSUtjMnF4QVE2bzAvZzdzS29Dd1lJTFhISVl0UE55NlA2cHFQbU96?=
 =?utf-8?B?US9HM2Q4dXY5ZVF5a1FRakM4T3ZscDNyd2dkMmNORVREZXloUHdLVUJpVDFF?=
 =?utf-8?B?VnFYbzE0aXYzdzZLS1BERi9TTnhRUHU3Y1Zab0dUZ1BocFpRbEMyeWR6NnJx?=
 =?utf-8?B?SDZEY3RDV2RVd3kzNzFmYklpcG13L2dZbDVXa2NiTlJtSnJtRUZHZUZPWE9v?=
 =?utf-8?B?TFhuTXY5MDcvL0xDMkovTWZtYlpSL2V1aEVNbHFXZTNGc0I0U29WR1kzcjI2?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faca6853-5c65-4eb4-759b-08dabde1630f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:21:35.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRheupMFrXLStBMZlsXSQoYEMxPIK1SsFPOfiC/2EKiBA7u2vFTBgLwAfWSRbT9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1766
X-Proofpoint-GUID: o9Jn6AbfKX8l8CFQljz-JaiMBKMRIy_o
X-Proofpoint-ORIG-GUID: o9Jn6AbfKX8l8CFQljz-JaiMBKMRIy_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/22 1:55 PM, Song Liu wrote:
> 
> 
>> On Nov 3, 2022, at 12:45 PM, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 11/1/22 3:02 AM, Jiri Olsa wrote:
>>> On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
>>>> The bpf_perf_event_read_sample() helper is to get the specified sample
>>>> data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
>>>> decision for filtering on samples.  Currently PERF_SAMPLE_IP and
>>>> PERF_SAMPLE_DATA flags are supported only.
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>   include/uapi/linux/bpf.h       | 23 ++++++++++++++++
>>>>   kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
>>>>   tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
>>>>   3 files changed, 95 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 94659f6b3395..cba501de9373 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -5481,6 +5481,28 @@ union bpf_attr {
>>>>    *		0 on success.
>>>>    *
>>>>    *		**-ENOENT** if the bpf_local_storage cannot be found.
>>>> + *
>>>> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
>>>> + *	Description
>>>> + *		For an eBPF program attached to a perf event, retrieve the
>>>> + *		sample data associated to *ctx*	and store it in the buffer
>>>> + *		pointed by *buf* up to size *size* bytes.
>>>> + *
>>>> + *		The *sample_flags* should contain a single value in the
>>>> + *		**enum perf_event_sample_format**.
>>>> + *	Return
>>>> + *		On success, number of bytes written to *buf*. On error, a
>>>> + *		negative value.
>>>> + *
>>>> + *		The *buf* can be set to **NULL** to return the number of bytes
>>>> + *		required to store the requested sample data.
>>>> + *
>>>> + *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
>>>> + *
>>>> + *		**-ENOENT** if the associated perf event doesn't have the data.
>>>> + *
>>>> + *		**-ENOSYS** if system doesn't support the sample data to be
>>>> + *		retrieved.
>>>>    */
>>>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>>>   	FN(unspec, 0, ##ctx)				\
>>>> @@ -5695,6 +5717,7 @@ union bpf_attr {
>>>>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>>>>   	FN(cgrp_storage_get, 210, ##ctx)		\
>>>>   	FN(cgrp_storage_delete, 211, ##ctx)		\
>>>> +	FN(perf_event_read_sample, 212, ##ctx)		\
>>>>   	/* */
>>>>     /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index ce0228c72a93..befd937afa3c 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -28,6 +28,7 @@
>>>>     #include <uapi/linux/bpf.h>
>>>>   #include <uapi/linux/btf.h>
>>>> +#include <uapi/linux/perf_event.h>
>>>>     #include <asm/tlb.h>
>>>>   @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
>>>>   	.arg4_type      = ARG_ANYTHING,
>>>>   };
>>>>   +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
>>>> +	   void *, buf, u32, size, u64, flags)
>>>> +{
>>> I wonder we could add perf_btf (like we have tp_btf) program type that
>>> could access ctx->data directly without helpers
>>
>> Martin and I have discussed an idea to introduce a generic helper like
>>     bpf_get_kern_ctx(void *ctx)
>> Given a context, the helper will return a PTR_TO_BTF_ID representing the
>> corresponding kernel ctx. So in the above example, user could call
>>
>>     struct bpf_perf_event_data_kern *kctx = bpf_get_kern_ctx(ctx);
>>     ...
> 
> This is an interesting idea!
> 
>> To implement bpf_get_kern_ctx helper, the verifier can find the type
>> of the context and provide a hidden btf_id as the second parameter of
>> the actual kernel helper function like
>>     bpf_get_kern_ctx(ctx) {
>>        return ctx;
>>     }
>>     /* based on ctx_btf_id, find kctx_btf_id and return it to verifier */
> 
> I think we will need a map of ctx_btf_id => kctx_btf_id. Shall we somehow
> expose this to the user?

Yes, inside the kernel we need ctx_btf_id -> kctx_btf_id mapping.
Good question. We might not want to this mapping as a stable API.
So using kfunc might be more appropriate.

> 
> Thanks,
> Song
> 
> 
>>     The bpf_get_kern_ctx helper can be inlined as well.
> 
> 
