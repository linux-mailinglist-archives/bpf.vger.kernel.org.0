Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F318D68A6CF
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 00:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBCXLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 18:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjBCXLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 18:11:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4778D63E
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 15:11:25 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313LxM5V005564;
        Fri, 3 Feb 2023 15:11:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IU3LxoHEpXsyix5ojL3GTuGSlxWj4M5sB94aMkxT2UM=;
 b=Tvss2tPU76EvSTNEi7G8+aDvl+FzqHbzOQ3UsOMkel8XjdsRSkeQL2vE645pLRaNG+iO
 H8JcpMzaOdtrSNxnpaDMm1W2822Yiwj0/4EUwTqLga2H4lIO4tvBtE19BnNwuWy5H6d1
 V/zLGS9psx7tNS6fLLc7edebFeX0JXuP0yq/3bkQpmOpcTC+KfkJlpJjtirQKD+YyDQo
 jLRrUfi/Bd3KRdxqhxtXLiPalUA/Zvl/rmUnhdG8GK2tlPXCfvCv3tIJT37J8Rz0/GhT
 mo+59XgycBW0lfYRwMMZMbCZLHD3Rwe7TL61x+L9pmqbXGDqWHdr0YVvYk5VRW0movqO mA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nh44qbbns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:11:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6nBqhxEAyJVD+5dQ9C4P/OgpmZxBqNBzSVYfWXA7rLeQergO5b7IKBtN7Nkj0iY4ZIO3YT8b4fjYMY9tVxhDbd+t9paYbPkDnnMEqmCvnw95CKz/1UdeHbD9nklLwbKBEp3cEPTfHO3vmsokAvvLhyR+9YKUzLlWTKm/U23bXq2dgpx1xyAfEdO7LLBnjTrTWATdRtOSuFTEago1C/0RiKgZyLG+nwpA/XBvN4ykdWaf5MosYUKNE6XahPzNYz84bmbxHmL1WWtWvlP4Yxq5T9qX3WhQG6BfNejiZH6LA0B5kr9Bca2jbnXYWaCw+Bxmfs6gDAhHIOO2IwFJibEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU3LxoHEpXsyix5ojL3GTuGSlxWj4M5sB94aMkxT2UM=;
 b=S1O5pwESMjMH0Yq3JqIpWq7kYYqOAPAzEReC1RofrXc7Av8bcw0mgImv/PdK/TcNiNUY9PXC/23/Wj8vFjFYxPQkjiJT8MYqpHD8qcnXKc0vfoFhtFuomCs9I//24q/vQYgWAQss/d1ravoR2L8PXZs2DRAziE0OS9HgL4n59Yd+oWHiSK0Bx/L41Lz4McLzOe/gHI9s1pNPWD6oj2U39ijXpFTzXiOr4hohlrCEEuI6ezP6w240N2JBoX4qlHqJH6fBRa5HwkRAy/LsI+hKGXDkAFr4L+txi1vjUvUu8+0wiSbCsogZNbALIF4aCGFLxJr7aiARHDXAawtAD1zSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA0PR15MB5596.namprd15.prod.outlook.com (2603:10b6:208:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 23:11:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 23:11:18 +0000
Message-ID: <e325b5c7-663f-89c8-8e4f-a5676c66f5e0@meta.com>
Date:   Fri, 3 Feb 2023 15:11:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, Jon Doron <jond@wiz.io>
References: <20230202062549.632425-1-arilou@gmail.com>
 <479c7e94-9502-6f94-c465-ac051f99b2ae@meta.com>
 <CAEf4BzbGHucDcFEyjDxSeW1fJxKDAt2mt9WXFagn=y9B+pqBSg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzbGHucDcFEyjDxSeW1fJxKDAt2mt9WXFagn=y9B+pqBSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA0PR15MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 81796b10-9205-4538-4e6f-08db063bf4f3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sFbf7quawJJ01w+4ncWZjI55D8Qeb/JSSxq3t9Y9sQuBofR/lQTPlEv1zhUOsB9bk93wrtz26xIcRpGOfYvruYzwEW/516T3kgs8JcqUJ9txvKjlLLWlHZsOE8wc+sis5Ms+SQGU2NfMB0i0pMtBHGEtI5TxQm/yzP0A/+SnWiSR7VaLpNx9zKAjf1G8e48QPkNTKYf6gridUzVYDbUa73R/Wwj1abh6KoYPh1s06BYP6ioDUvn/fP3aZGMxqnQXyoFO8AyJKNiUjYnMvw03ui9NsKyg+KOm0sFqVMuxiDmk6TyXi/ixXAp+gat7WsE7qu2nMer760DGjGav5RA2SLpPVby2RxmO/k7WzY1rwp/HA+yOEztup38RTxJL7wtcZFP9JlKrqybeD7MB6MRrdaxP+HnCELyeeI1La9AtXRepw5uqCAO/5HMhtI54CKP/Srm936UBgtf1EipVYZ4lOcrRF8pyI0TgpLrrOfGoIMh2PS8VOW/Vrf90dFe6SOzuWNuFlrf4WS8+uq+TGBdB8AQLgj4LdhATQRS5w/NmL4BYNqtFxCcVDwa3KnnLpaspcyc6pgBaenIqgEynsD8HbpfcSg9GTOkBmDM2A0SWsFzFMplIdxBXv8vKXIcEyzz47e5c4llOey/tCvaqqZoRhAtZy05SSvpL05n5v9e1ySqTppdBaDUsnne2MFDJIjqNdq83tJ4SJkzPtXYdHWUQU9GnuNdy1tK6XbsMPiBNqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199018)(38100700002)(2906002)(6486002)(31686004)(478600001)(41300700001)(66476007)(36756003)(5660300002)(8936002)(8676002)(4326008)(66946007)(6916009)(66556008)(2616005)(83380400001)(31696002)(86362001)(316002)(54906003)(6512007)(6506007)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXY4OG5zaGg2MEhkdDEwcklHNTYzSUQzSkRJby9YUC9rMzlvSlJOaU12VFJt?=
 =?utf-8?B?aTQrU2lLZytKbVRRUWJYSjRnWkMrenZuY3d3bG5TZU45bFBJRmxYUzdVM1RS?=
 =?utf-8?B?L3hhQndDMHRjMlhnZ3l5ZFBTRUYwaEp3WncvR2Q1djBJM3U0S0lPcUZvbjlt?=
 =?utf-8?B?SFYza054SXJLZEwrYWI5STZEazUyR2NqUEM3M01qV3RPaDRZWVI5YjltWE9z?=
 =?utf-8?B?c0FQV2lVVnRQaS96eWRDWmtYVUFnb0V6M2svOXVEa2JQV3g5amROaEpGbDRG?=
 =?utf-8?B?U2plZDVyWHEyT2E1OVV6S0ZXR0g4bnRLS1A3VmNzSDhCdDJiZWxaV2RHNVFx?=
 =?utf-8?B?bnpRWitVL2U5aGd5c3crRVNYTStvT2JvdjdLdWt6ejg1NVB4Tk9PZU1xbWZs?=
 =?utf-8?B?dWxab1l5YTR2eCs1SUhWMkdSZUNrNEVxT0VBTjMyQTdsMThreHVoYUtFUkd2?=
 =?utf-8?B?bVlQOHVwQ3NQWlErT0hhZU1NR1pDSTdlcDV6TUsrQXVVMERJLzVpNTdrMUFz?=
 =?utf-8?B?dUcveEJCWXAzamtJUmowTVM3MEZoR2ZZa1JxckRiSmgzK1ZaUVRxS3R4MHB5?=
 =?utf-8?B?czU0VjVoRUdEVm52bSs4T3FxV3JLbWF0Y3ZoK2JJbWVXVjRKbU5wSFVtZWVI?=
 =?utf-8?B?dHh5ZDdDeGVvaURyT1pCUGxHZnZOMEpITUpRUlE4cFBlS3JEdE5ibjk4V1BB?=
 =?utf-8?B?ZHNsd1I1cU5uUFdEd2pDeDVzRzhCZ25qUzRjSUpiMWp0bkZScHF0c05PR0gw?=
 =?utf-8?B?MG1pOTU4ZjNkT1ZHczZGVlFGTjRKVVg1T3N1OWZObHQ3R1d3S09CREp6VzA5?=
 =?utf-8?B?MWpaZEwvdWFwNEFDeVBhV1FvWjNIeFlGaWxtYnYzZ01VT2F0ZG5hNzlFYjJW?=
 =?utf-8?B?K3k4a3Z0Z2J1c2R5cHFkbUIzWVpENm1rd005bHl5VjBtUHQ2TUJBYWhpTW5l?=
 =?utf-8?B?YnhqdnlGMDIvNktIMGJPSjJkQ3ZKUzQ0ZXBTNGJnU0YrS1lqeDJyWTRtSjhB?=
 =?utf-8?B?alRsbXhOSzFJWTFrbHpDR1E5ZG5qMXZSdUFqRWF4Y3hhMnVxUjk3aVZ1eTFR?=
 =?utf-8?B?eG5pMFUrMXUvaVRRempVNHo1ekpsRXlVMTRJMUpLdWdXM2ZTV1p0cFBvUmZ2?=
 =?utf-8?B?V0pkdUt4Yk9CSEpCQ0plWGV1TnJCZUZWclZmb2tUYU1aaXQ4cVBxNUNpSzM2?=
 =?utf-8?B?ajVhekllSHZYemJvVFpGN25uVmNtVW1mQW5QWm1jYnU0L1M5SWlTRS9sNjBo?=
 =?utf-8?B?am9mNDhLU2s0VEdldmxkYzExUVpJVGxTdmcrWmZSdDJMbWxuZlhSYnFuVGF4?=
 =?utf-8?B?ZktDcVRGa1ZwL3N1cUQzci9xZUFDSHc3ZzZuTDR4VHFYUHVKUDBVbEtrS2hr?=
 =?utf-8?B?UnZZcHZmc0hBTlRXZUh0cktFMEhOMThlcGNGY3RvdzBtTHM5cWkzclNBcWFT?=
 =?utf-8?B?b3ZsbHJBV2t1WlI5dnU2RlFpTjMrNjM4cDBCWVpOaFZRSWZFOWt6M3d5MmVO?=
 =?utf-8?B?dXIxenQzWDhpaGhrbTRPMWd3U3BRb2VuZllncEMzQ01rQkpmOGg3QnFCTFdk?=
 =?utf-8?B?UVcrZzQxam9seXdheXZQTVZzeGZ5T2RWWnZlaUVkZU52THlLZkFlUmlJb2Va?=
 =?utf-8?B?TGtaeHBzZWJMQXBwVzRQNlhaYmFaSkZFSGxSbm9KN1dlY2hCd200RmVaMHZI?=
 =?utf-8?B?ajdVVzFDc2REbEdVZGxuODBKdUl0MUwvVVJNd1BWYkJkMWpaSXZUOFp2cGpV?=
 =?utf-8?B?clpzeEtTSTJYYjJVSURjanNWbWtLNk5Ka1RqVHVrVDRHUmYxbmRNb3NpUEVt?=
 =?utf-8?B?Um1DSk5pb2VneDQybGdQYU5QVHNaK1djano1djBzOEZMNEUzSUhIOUtGT1dx?=
 =?utf-8?B?VDc1THcrWk5LRmlQcC9BWXdIWmFWalJZVVFYa3dHckVEanVnUDlXYXZEdE12?=
 =?utf-8?B?NU5FSXFTeDc4dnExWnlqRDNZMS9EencwenUrK1lzeEVOR3h2RC9LdnlhSTFB?=
 =?utf-8?B?ZXpKdG9WQUl6aUpDcExyVlNRUm9KRFZWL0pkM2JwQmhDbGFIb0VYT3FMUjY0?=
 =?utf-8?B?Qk43UGNNcTJ2T010NjllSHI4ZE1FZ1hxZDY1TkRlaW92anFRek56NWNjeFEy?=
 =?utf-8?B?R3FQZ1AyMXVPTlpHS20zc2JtV2d6ZlFDbDlJOEdHOVkxeUlvMkd0a0ZCQXF5?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81796b10-9205-4538-4e6f-08db063bf4f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 23:11:18.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXnGTvraGYE3IMEL0dmOKCeTbDu+yKiEZNX/RuRLXtK6hvNgfvLp8eqTcodaSgPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5596
X-Proofpoint-GUID: 7EPXNeP2xhDYM2yyXsfbuCkJCWSYCP2m
X-Proofpoint-ORIG-GUID: 7EPXNeP2xhDYM2yyXsfbuCkJCWSYCP2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_19,2023-02-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/3/23 1:42 PM, Andrii Nakryiko wrote:
> On Fri, Feb 3, 2023 at 10:31 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 2/1/23 10:25 PM, Jon Doron wrote:
>>> From: Jon Doron <jond@wiz.io>
>>>
>>> Add option to set when the perf buffer should wake up, by default the
>>> perf buffer becomes signaled for every event that is being pushed to it.
>>>
>>> In case of a high throughput of events it will be more efficient to wake
>>> up only once you have X events ready to be read.
>>>
>>> So your application can wakeup once and drain the entire perf buffer.
>>>
>>> Signed-off-by: Jon Doron <jond@wiz.io>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 4 ++--
>>>    tools/lib/bpf/libbpf.h | 3 ++-
>>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index eed5cec6f510..6b30ff13922b 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>>>        attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>>>        attr.type = PERF_TYPE_SOFTWARE;
>>>        attr.sample_type = PERF_SAMPLE_RAW;
>>> -     attr.sample_period = 1;
>>> -     attr.wakeup_events = 1;
>>> +     attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
>>> +     attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>>>
>>>        p.attr = &attr;
>>>        p.sample_cb = sample_cb;
>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>> index 8777ff21ea1d..e83c0a915dc7 100644
>>> --- a/tools/lib/bpf/libbpf.h
>>> +++ b/tools/lib/bpf/libbpf.h
>>> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>>>    /* common use perf buffer options */
>>>    struct perf_buffer_opts {
>>>        size_t sz;
>>> +     __u32 wakeup_events;
>>
>> Since you are adding wakeup_events here, do you think it make sense
>> to add sample_period to struct perf_buffer_opts as well? In some cases,
>> users might want to have different values for sample_period and
>> wakeup_events, e.g., smaller sample_period to accumulate data and
>> larger wakeup_events to wakeup user space poll?
> 
> It's not clear to me from reading perf_event_open manpage what
> "sample_period" means for perf buffer. What will happen when we have
> sample_period != wakeup_events?

The following is my understanding. Let us sample_period = 10,
wakeup_events = 100.

Every 10 samples, kernel overflow handler is called and the the sample 
data are written into ring buffer.
Every 100 samples, the poll() syscall is waken up to give userspace
a chance to read the data.

In this particular case, it is possible that user space may miss
some samples at the end if no special handling (I forgot what it is).
But if the user space doesn't really care, it might be okay with
such a configuration.

It would be great if some perf expert can clarify whether my
understanding is correct or not.

> 
>>
>>>    };
>>> -#define perf_buffer_opts__last_field sz
>>> +#define perf_buffer_opts__last_field wakeup_events
>>>
>>>    /**
>>>     * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
