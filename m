Return-Path: <bpf+bounces-318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C1E6FE83D
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 01:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A742815DC
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07C1E537;
	Wed, 10 May 2023 23:55:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A82F23
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 23:55:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CE30D1;
	Wed, 10 May 2023 16:55:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AHqITA022410;
	Wed, 10 May 2023 16:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CHFK+HHdIkINolpjdjOvyqghmFJUHGE7cISCQ/xt1Ik=;
 b=T30+Adc6bz+cI0ieEMJIqdCwPReon33UzZ77VEQ8BFLWyUmaNFsSFwS7WuxCyE/hVyv6
 tNVjAkwCbf/k87Pue6ZI9wuKrRDtPY1OBrh62f5ya6JYmh024tzX8HduSdP54sN7GyzE
 rDvFdxVpM7giiM96tgfF1hyOgOqBD0k/hS4k2sd2xSe8gwCpW7WwXe5gVR40CUhCtAHm
 Pw8d5Lao8YKhyylcg3kz1MeVym6ktJHRt3goHLr0b0+RS8qohmwlun6DOPz9hQWwBZm+
 L6h1umMfKA7HiVHu/x4Z3qBLsS8PTuc8C3Me0pArZXNLCE5MU3CumSCUCO5+zNJh/Ush Bw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qgeqjayw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 16:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQMKf6fr46NQxPspcAY830EMkeOmaT6Sj9p1s35W/0jJmq2loN1votyOUaJJDAUaINcX2EFVMWQQJ/1Y4UPo2FZSormGfj4iEhepl4RdrPUNy62Qj0B8ssG6Wzb0ewTTrIE0ww02B++SinmUO1gNSoKN2uoEM5RsmwUwAFocvnjfFkj6bJrsz+eylk7fCsNGEENKGVvBSi62WP9M/6IOZB2O3+ZwsjmHTp9O6YOWAkrKmPbrbCPfjVybRYGEcX1DugYP9QexI7qHGgiKDG7U22/mecQ6QS6tFpTMJK1SIE27dhnyIfEbEVMzLeOlR+H9+GH0CkZ90QuI8SN759p3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHFK+HHdIkINolpjdjOvyqghmFJUHGE7cISCQ/xt1Ik=;
 b=GTrh6aE/lEiyTrZ8MXT08u983UL/1N5wL5YhQrWH/kLlg64EibQmL9jMSX5fjQCeGpL6WQ60HqnvvSIu58xVXtBNXlgRRddN6IXTfNTftiMwU1J79oSTX+lqrsFxp9SEljWAUcKz5/BR2kpiG38hF5Bfq/Y3UtV5ek/Jm1zNSoJyfqVwv+tQ4EPhaoKHgiMUPOZRbkhpCmt9JIN0u62BZ7RtW/0OhAhAtgv2xV2xP/ajsbTW+aAv9JWNxp4ifIxEBAmIM/QjV3Krri/RL53f2Rz5ZId7kwdjmu7hcVfLNJkjuwxSbX7jZCx55x3S/P7O+oYmt2pQMkQ0V98hX+v1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3924.namprd15.prod.outlook.com (2603:10b6:208:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 23:54:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 23:54:15 +0000
Message-ID: <89159b33-3be4-487b-7647-0cbbd20c233d@meta.com>
Date: Wed, 10 May 2023 16:54:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ze Gao <zegao2021@gmail.com>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com> <ZFvUH+p0ebcgnwEg@krava>
 <1195c4bd-ef54-2f1d-b079-2a11af42c62f@meta.com>
In-Reply-To: <1195c4bd-ef54-2f1d-b079-2a11af42c62f@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3924:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a14f94-3172-432d-5f8a-08db51b1dcae
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WJaJwjn1jnhrikmMVgniVXcFmZfzSdIvHoCus9HiUP1uyGKfYwKtDtvBK6MI3H52u1mVSx8Emm13yTodvZAQ9qIb1OopCNp4SLTagOhSbXzfvKqoivzqdJTod5dbk6jCMp1mzfZjA9C574KrYqUoGzb35D68MBl8YOnk2aZwqYofmwh+vt7MeXueYyhdLlXTZ3MYdNyjlMX24M6GV8w1k4XTQJW9HvRGaWZk56ooYXZAEFkxgb1h1r5HTpNi/F5F61Gi75Egkclt72FV+hpQRF1YaSSNTdXo09MBCz2i5GdeZHPkk+hKYRn1+gqpD1bgrt+xdcoVuDR5NXoXT1BFFc8lyah/7Uq6H85iRQM3DtFfaYFRisVXxA/D7Q2RMjkS3EaRePrQmua0bGm2jq4Yhgmok2gwZv8hdFt/G1xwxGx4+92WSXOtxW+Sg23KPuwr43Khpl+h8kZRybU6MCHe9U7b7teUz3RWte0K+r+5ZetP0Lk/+1rygLLbYugl5fOwzh+CNX+lXh9Z+wwvg5PdLY3kK8V/s3Q2xXzm5dMEpZtbIxi4uaXBArDpV2q8+Y6Tijd8jbxacYjdvY82dHv7JLA8/ELufqXjgMKcnDE4W664FL702lM4NMka5Az44CiIOuXoiHp5sbvUbqvyh8msSw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(86362001)(38100700002)(36756003)(31696002)(31686004)(8676002)(8936002)(7416002)(6486002)(478600001)(5660300002)(6512007)(6506007)(186003)(2616005)(2906002)(83380400001)(41300700001)(66946007)(316002)(53546011)(66476007)(66556008)(54906003)(4326008)(6916009)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmIzRDBLdGZISC9xS3JITTZCTTczZXoyZnFQYVJ3RHdxRDU2N2ZOR21JaTJP?=
 =?utf-8?B?Yjhta08rMFhtaVlJbFg1NlV1UmhjZWxxSk9kcVBuc2lmWXRETHRIMGpLN2E4?=
 =?utf-8?B?aUk4WkxvdDVpK1VpQUQySXlpUDdZWDJFVnJjUGx5Q0pRd3VjMEZhUUpLZGgv?=
 =?utf-8?B?RU51SHc1L0o0V2YxS0JXb2lWUlZpNGF4YVJrbWNWcFNNRnYwdW9OT2JGR01U?=
 =?utf-8?B?aWo0QlhhUStzcGpWdmlMaTFXNURjNTNockVTeHdUQXQ2aG1hVk81M0ZuZERy?=
 =?utf-8?B?aFVtUjZjUG9UTlpjbW5DZS9rYkcvYlphUkROWXllSEJIOHZEemJldDlsLzhC?=
 =?utf-8?B?WE1veWdEY2F3OU1FaC80eTRxcDFPK3FFZ1U1cFdYTER4VVdDc0YzaU1ZZFB4?=
 =?utf-8?B?ZGhRM1RPUHNyeFp5bm11bko1YzFidk53U1hUTVNNaEIvL0JET0l0Yk5vYUUz?=
 =?utf-8?B?SU5pMTJRVmlaQ1VTWXBIUTZVUE9OdzY5Z2ZpZXA3RGwvTmxIT3FxSFZmTXp6?=
 =?utf-8?B?UzRlcUhFSTNuOWJFZ2F3Wm9JYkZhNWtSMDBXTHMxd1pDTUhVTEx5MHhRamNj?=
 =?utf-8?B?SStzK3hIRE5jQXYvSklxNkc0SW15YWxtMzM4cC9mV25JYWx0bFJCdWFSMTNQ?=
 =?utf-8?B?ZHN2MmZVSy9BRGJCUzBHdC81a2hJSjZZU0J3VzgrSmp6VjBpNTRkYkNNY0sy?=
 =?utf-8?B?VlBRUlVrVEZGOWF6cEd4K3JpNU1ZRFpKbnFDMkVpeTAyUjR2NXFTa1NZUkx4?=
 =?utf-8?B?M3ZzcWhoT3ZoTDI4VzYvcWw2OWhjdzNZR2VnZVQvcVdCdTBRRm5TdU9iTU9r?=
 =?utf-8?B?WXNyQVZDZUwvaHl2dWI2b0NDb282L3pyTFBFMjNnWWpLZ3FCSHduSnMvR3pu?=
 =?utf-8?B?Q1Y4RzRhOWwyRkRsejBzQ0VOZGtkK0RBZDFrSkZOa0hyekRYSURMWktqTUtV?=
 =?utf-8?B?d1dlb1J0M2ZSTTRicnVYa2tSMjd5aS9VRDhxWm8vL1NRVUtGRFg3dmFCYUNC?=
 =?utf-8?B?aU9RUmVPaEJJSnpFOXVVYzVlWk0wNWcrNUtjZ0NFdHZPS3FFZ0Y1SGFwWWUr?=
 =?utf-8?B?UUxUcExHd0RKdnBhaEQxcnFZM3FvZERwQ2d5T2d5ZHQrN2pjZ2JHazV5L01Q?=
 =?utf-8?B?OHBNT2FXWjlHQkYrVjdYajF6dzY3d1dSanR0eW15aElOcDRaS1dlM2lkT1RW?=
 =?utf-8?B?U2xEWEQrTmttQS9EMGtKKy95SlNoRjIwdGpFa1oydVFoaHhzUnhCUmdZbnhO?=
 =?utf-8?B?RXJ3aTB0MFNWYWNRQ1hlUXVSRkpKbzZuelFlQmsxUDBEdEZiMWdBVE9Samxp?=
 =?utf-8?B?SzBQN2F3WDJuV3BDT0dFVFFNbUEvL2hwWFdvRjhuZjVVUVRSeDVoN05BRHph?=
 =?utf-8?B?cmNYbUFydVk0RURYWkVnYW9QRERDeXRTa2pSU29tTW1CQXo2VWRPYTYwQW5T?=
 =?utf-8?B?bDEvYzE2Z0ZzNW9zR2owNTlYeEt3STY1ZktpQS9XZmo1UlgzVnlGT1lXYlNP?=
 =?utf-8?B?L1NzWnRDbXlIZkhNa0wzYmJtaE1VNS9pZTZ5M0ZlRk5BYXAzK0h2OTNaYXoy?=
 =?utf-8?B?MXFEOUdvaGRYd1lwWFVkeUdDQUx0MEFWWlVsRG1reXA1WU9uUEVkZVd2eWtt?=
 =?utf-8?B?eVBUeVIwR0N4M2EwRUN1RTJpa0NqK1FteTFtRDZ1bE0zRy9qU0MzVTIzQ3pN?=
 =?utf-8?B?dWEyNWl5TldEUmh4T25rTzZCMjl6Vi9xZXUvblI1R1gvazVyOG54b240RDhZ?=
 =?utf-8?B?bTFjdXd6emFpbzVtQUtROHorQ2t5NFh3VktCV1ZwV1NSQkZ3NzhMYXVvK1lC?=
 =?utf-8?B?OU80dDlyNWFNOUlTclJ0Qk5STTU2dDNKajFtL1o5M0dqdUs2eXE4aEpaY2Va?=
 =?utf-8?B?QUZ5QzJ1VW1Qc3ZJV1pRVjRrYWRuRkVsWXVJTFdraWhKQVlWZUdRMnorNXRC?=
 =?utf-8?B?Y2o5R2EvOEVEbU5WN2kvU2tyeXhGbTFqYWNwWUN3c2FMUE4rbXlwQ1RjWWx3?=
 =?utf-8?B?QkU3bnk2K2g3bTNqc2NvMFBWNzFRM0s0MXd1cWxlaUM3RURUWC90OCtMRFFG?=
 =?utf-8?B?bFpDRUFKYUhab0xoTk9BdmdHSWZ0MU1BT1NNYW10cjM4enhtT1RmdmlZQUxa?=
 =?utf-8?B?bTA3Z3dDM0FTTGg1dDJ0ZmtYSjNUZ2UyVDR1OEdjOXBLR2p1b1F0MmhFNklU?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a14f94-3172-432d-5f8a-08db51b1dcae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 23:54:15.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzJ0gRecLSlcod35iKhyhivZ7tw+AtsvGPO1bOZmMGQ8jbkqR/NAI+piT2600SG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3924
X-Proofpoint-ORIG-GUID: oZtrdEr3YgHwqbt5e17M1pgr8XUgNsF2
X-Proofpoint-GUID: oZtrdEr3YgHwqbt5e17M1pgr8XUgNsF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/10/23 1:20 PM, Yonghong Song wrote:
> 
> 
> On 5/10/23 10:27 AM, Jiri Olsa wrote:
>> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
>>>
>>>
>>> On 5/10/23 5:20 AM, Ze Gao wrote:
>>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
>>>> however it does not takes those kprobe blacklisted into consideration,
>>>> which likely introduce recursive traps and blows up stacks.
>>>>
>>>> this patch adds simple check and remove those are in kprobe_blacklist
>>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
>>>> check_kprobe_address_safe is open for more future checks.
>>>>
>>>> note that ftrace provides recursion detection mechanism, but for kprobe
>>>> only, we can directly reject those cases early without turning to 
>>>> ftrace.
>>>>
>>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>>> ---
>>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 9a050e36dc6c..44c68bc06bbd 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct 
>>>> module ***mods, unsigned long *addrs, u3
>>>>        return arr.mods_cnt;
>>>>    }
>>>> +static inline int check_kprobe_address_safe(unsigned long addr)
>>>> +{
>>>> +    if (within_kprobe_blacklist(addr))
>>>> +        return -EINVAL;
>>>> +    else
>>>> +        return 0;
>>>> +}
>>>> +
>>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
>>>> +{
>>>> +    int i, cnt;
>>>> +    char symname[KSYM_NAME_LEN];
>>>> +
>>>> +    for (i = 0; i < num; ++i) {
>>>> +        if (check_kprobe_address_safe((unsigned long)addrs[i])) {
>>>> +            lookup_symbol_name(addrs[i], symname);
>>>> +            pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", 
>>>> symname, addrs[i]);
>>>
>>> So user request cannot be fulfilled and a warning is issued and some
>>> of user requests are discarded and the rest is proceeded. Does not
>>> sound a good idea.
>>>
>>> Maybe we should do filtering in user space, e.g., in libbpf, check
>>> /sys/kernel/debug/kprobes/blacklist and return error
>>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
>>> requesting kprobe in the kernel.
>>
>> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
>> some of the kprobe blacklisted functions are actually safe
> 
> Could you give a pointer about 'some of the kprobe blacklisted
> functions are actually safe'?

Thanks Jiri for answering my question. it is not clear whether
kprobe blacklist == fprobe blacklist, probably not.

You mentioned:
   note that ftrace provides recursion detection mechanism,
   but for kprobe only
Maybe the right choice is to improve ftrace to provide recursion
detection mechanism for fprobe as well?

> 
>>
>> jirka
>>
>>>
>>>> +            /* mark blacklisted symbol for remove */
>>>> +            addrs[i] = 0;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /* remove blacklisted symbol from addrs */
>>>> +    for (i = 0, cnt = 0; i < num; ++i) {
>>>> +        if (addrs[i])
>>>> +            addrs[cnt++]  = addrs[i];
>>>> +    }
>>>> +
>>>> +    return cnt;
>>>> +}
>>>> +
>>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, 
>>>> struct bpf_prog *prog)
>>>>    {
>>>>        struct bpf_kprobe_multi_link *link = NULL;
>>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union 
>>>> bpf_attr *attr, struct bpf_prog *pr
>>>>        else
>>>>            link->fp.entry_handler = kprobe_multi_link_handler;
>>>> +    cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
>>>> +    if (!cnt) {
>>>> +        err = -EINVAL;
>>>> +        goto error;
>>>> +    }
>>>> +
>>>>        link->addrs = addrs;
>>>>        link->cookies = cookies;
>>>>        link->cnt = cnt;

