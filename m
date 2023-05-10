Return-Path: <bpf+bounces-307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35B6FE4F4
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 22:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AD52811C2
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD218C02;
	Wed, 10 May 2023 20:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877A8C0F
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 20:21:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7A230D4;
	Wed, 10 May 2023 13:21:13 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AHqMK0009447;
	Wed, 10 May 2023 13:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZyB2BM9y03a8im5zcybivrvxbCDbIgL6k9xXiNcjJss=;
 b=lD1DFTWpqXcRoq9YuC6qpnt5SwEocobA0BDo3ZBOwed/9l5R9oZ1LsmosszBeOyJeZOf
 fJE0h6NAhbgdJUajsdTIIvBgjoTdHoB8evDUD6457sS5CV34kkFd7dviAV0JzfaZ8a2I
 JtDRslQudt+pfmaO+ogt21331rzCx/rbgMe+jDwNrzijulylC4YYkppbY3/SAUOpSY22
 OqZc1ChivP/ErqCf8bHKTL/VyoR8HoGF9Kx/LBkj3IosBq/wMqZrOjvTrR7DDxVoYmTy
 AcXLJaXPcYfWrh+fHOzWwtfo4i/szDKNvf73tKBoSDOq2hSlm8+nOfbrXhAU+mK0RN3P lw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qg28kxfa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 13:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERrfAhY4DwYOxDl6Utp0hpke4k3cfGjV3F9cw6tIjtgZWR9b/GPNcwjqcZ+vUp2OvluyRDdbaEaYif+dTCtZH22+uNBbu2l6Y6jpIiYzuS5A2O5AqiJGu3KmlHjA2jI5CGLhJqQUPV6C7Iz3ucrhEseVZ287Jq+z6LZexOqViCgkoQthR6i34Qb34RzZQ8Lmdo6VDRGOfwSk9JxSgrYrVF/pAZaMg/EkUTjyhaOP8ytlQBgOurt448B8eLm2PRVK+0l4IdAbzdmvibywURfs7roQ+/coaZNPTAjiImL4JlppxzxyZtZIjrngdxdKswGNYLFWu6ZCQZTqEf7RjW1LOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyB2BM9y03a8im5zcybivrvxbCDbIgL6k9xXiNcjJss=;
 b=LufpmM0nXhkc0iuZjupogsFVJVF7qjYLCRRvBUZ1IUpQ470jrPBDHeTNZkxp2U9Sa5NKSPKpBvvF98SujCAYzW14CF+fG5jZzCh0HdVcjZOKuODpPyDxaPAunkCI8qJdTJ9p9wmJW/rokmwYv4Aig3lZ7+/juFG6L+zvJxvCvpMiLculUT68wtpNkA/e2tNgllwhrPR8T4JcvFU9PQop+SKtuS0Fyn/K/lWxWEAiXxTB/whv7ZaTc0hCoftwHOxyac33YLfcKS2TFD1DLmdBeqCajZO8yuZFXlVAoT2sBXooBZ+jGS6OOkS+1dnwoljHuNTaWAG5AsmgKxoF1L7tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3859.namprd15.prod.outlook.com (2603:10b6:208:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 20:20:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 20:20:34 +0000
Message-ID: <1195c4bd-ef54-2f1d-b079-2a11af42c62f@meta.com>
Date: Wed, 10 May 2023 13:20:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
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
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ZFvUH+p0ebcgnwEg@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3859:EE_
X-MS-Office365-Filtering-Correlation-Id: d39e2250-071a-4f54-b751-08db519402c4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WOBH/Njb5srNPmhmoJ7ALxJrD1QdslweR6UF6nXg44Cd8ljHM7NXvpiMkngH0U7MY5Mcp5+XHVQBFdycYe3NiUR20yd6sNuuQwpxeC0Y2C+qwTiWdPB37su/v2dQaDo91y5d0cAbPLbyteDnjRn8zRfC4xE5mdsd2hFfb1WFcUdn2K14GfjABFzxNX9tdqhbQwmp+EgCrFYVpE0/8cVmuJCLXCsnNN0GdK7p2YtGhIIbB2INnnrS6U9/8sT4DB8X1RhUQot2dDWM3k9IK6GzzSHKSSewWdagGPm04ICiYFQVOXX8tJtE5tS0KZiRtxX0iei1055RKLNnmkYpRFnKD/W+u1iV7wXRY/NxEPF4AYvLqshjPiW44d/gEWd/GZF+2K2rHoMxBx5Zt5sPbT8e1jx7ORETVYDAxOjzHFtb2kQgKwpBSBrnqDN+/gt4d4HUAVtNOLRawcDNtfyigAovddBHdfo3kGFq1vPukWGhQEczaGDcfwcfg7FjLb2yNiPapPlzAeHejqS3NCZvnRYz3BVqcghe2eO26FKl3MM4nWDiBVipc7DEriUxeUYjAIaZ3hqco1E6zCeavFyhHAc5/I+6odvMD8hhlFoaU0ZUbXuEhmOsQXebg9WWwSgRCYBcDyJDLhOhyqrY8xocxv/88g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(4326008)(66556008)(66476007)(6916009)(316002)(31696002)(36756003)(6512007)(6506007)(53546011)(66946007)(186003)(54906003)(86362001)(5660300002)(7416002)(8936002)(2616005)(8676002)(2906002)(83380400001)(38100700002)(41300700001)(31686004)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlpZWjFhSGdTclRnWFRKa0dBZFZNSGRMb25zc2grREtPQVpyWFV3YkZYUEJz?=
 =?utf-8?B?bTFZSWd5Vnk4ZFdxWmpKMGo0aTkrbTBpZ1JKWjBRNjBkRVNkZVdVc2piL0gv?=
 =?utf-8?B?c0lFUDJrSXMrRk5UVWdhS04vV3RyZkZzZmU5aXZSZTNyOWF5RVhNcmJzVzZz?=
 =?utf-8?B?c29zSFdMeDVhYmNxWElhd1dRZzdTQ3lhN2VHbkVPa1lseW1pUmhVVjFUaHpy?=
 =?utf-8?B?WHIwL2xFaFBKSXg3MDkwWUQyWElTdlBoZVg5R2ZDTHplWGtpaG55SmYzZkRY?=
 =?utf-8?B?bklqZElqS01MTGJDWklOaTJMTVNjZ0RqNTI3eFNSaG1qbWljdkJRckk0R25P?=
 =?utf-8?B?TTlqc0F4Y3AwcjM1RXBGUUdUYmJ3aUZmc3F1aTYya2dQQ2FwWmswRGhrcEhZ?=
 =?utf-8?B?aVNoWlRvRXZiak9Qa1FDczFpMlVMN1ZqNUxQMzVLTG1YVGl5OTFmazByc0tn?=
 =?utf-8?B?VGlOMEdLWWh3bXBEUDBFZWp6dXJOM2pWeFVaME5GWHhMdkhHUnNQWjQ1YU1i?=
 =?utf-8?B?NG82N09JNW12cHA5OGtSR2xpZ1NmeEpLMVJ3R21yMm5NK1oreG1QbmNHZlJQ?=
 =?utf-8?B?S1dmcC9aamFRMnF5elZUSjJvRGFucGxPUnhwTWdveVZUYlFKQmd3Uy9sVHFz?=
 =?utf-8?B?anhlZTJ4UFpodmE0ZWM3S3VuaUJ2UEVDUXltYlkvV0YvL2IxbWd3QUVPODZS?=
 =?utf-8?B?YittN3RacEx4TTZ1NWZsandkK2xHbVNOTitLaXo5Y1RHdGd5c2RWOW92STQ5?=
 =?utf-8?B?S2E1YWs1WEtpb0FMMjBBS3UrNFpjeTN1eDQrSXpxeG5HVXdQODlmNE10MTZr?=
 =?utf-8?B?dnJXM2JxMmVFYm9Wc01BYjU5ODJTMzhWaUFVcjEzNmVkOWtRR2tpVFhpdVhR?=
 =?utf-8?B?MkE1bll5MlNhQ2F6TWN4WXJORkZtL0xUOXhJM0xMWVpKZlV3bGhFV1pLdGVQ?=
 =?utf-8?B?Sk03TjJMWmxHYmczNGtPaFpPUkVIa1Vjb3UzSTV2OHF4eHM4djI2bXI0T20r?=
 =?utf-8?B?RCtwUmN5VHpTWWV5dHdtYkVPMTkrVGFOeVpqVW5tNmFTa1lyM0tGUXhqQXlZ?=
 =?utf-8?B?VEZNeEFLYW9VVEp4WTJDNTZjdFl6MFVJTmRZY09CUVExcUJEUHJLWm9Xa3BC?=
 =?utf-8?B?WDY5bW52bXliRldtZzdBaU1aYzZVak11V2N3OWpkQ3JlU1QzaGJkVC9rcjJH?=
 =?utf-8?B?MHEzVVA4K1FGS0pmUi9udGFobzkyZTNoN1BRV0J2YTZjZnROc3BWeENkWCta?=
 =?utf-8?B?ekdTdjVrTTNrUHdkb20rVU5TTEgvOU0yNkRTNnRWWGlxZTlpNDJHd21qMzV6?=
 =?utf-8?B?YlhCUHkyb0JaQnNLRUt2K2FYWndpY1pTczJyTm5nUjBvbGNsMnBIQjVlWGtU?=
 =?utf-8?B?OE8yU1VncnEzcDJOcDJiYmJNdkJjb3JzcWQ2azVtdGhycGJoNUZFdmlPN2li?=
 =?utf-8?B?ZEtyKzhLU3hhTHAvL3pDc3llN0lnT2hRdkR5Y2l1cjdEUjVZWm5Bb0dTVVVZ?=
 =?utf-8?B?R3ZyeEVOTUFackJzSU1vMXA2WTBudUtiTHcrNXpsVVpwc2VKS0FXd0h1ZGw1?=
 =?utf-8?B?Um4vekM5bFh6SWdGNjFxaml0UkVvSU5iK0tUOVB3eVRISlkzNUVKdVIzZlYy?=
 =?utf-8?B?QlNLNkZNdkFFNzF1RWRtSlFVaHlaZWhWRXZJOWJkTHpUT1I1amt4MkdJdm1o?=
 =?utf-8?B?MzVnT0VmeE11blJjWllZNE5jREpJSk5nWUFOSXhEOTZycU9ReDNTUjUyUkN0?=
 =?utf-8?B?VVJWb2p4Y0tVYzdqZk43R0VOTjNhN1RqYTd1YWorRlY3UGdXR21lRkROVFdh?=
 =?utf-8?B?YVJudytUTnJiYXEwMUlBUDA1QXI4VERHTmxaMGFQdEd3U2VGOXBFL0R1RkIr?=
 =?utf-8?B?aXZpenhCN0NNZ2NZMmprOFlaL2JGS2pyL0N4RDNXVDNjMlBsMUx5S0YxNGZq?=
 =?utf-8?B?RXQ5a1Z4NC83WWhNbzAwNWwvaUZWdElVb3YxUHdDNFJEd0NkM3Q1enI4K1Zl?=
 =?utf-8?B?QkZIWktoUWpUcm5lcWowRDJQK3o5MzFEL2I3NW50dDMxTERac0lKQ1FLZzg5?=
 =?utf-8?B?T3FtdXJ2N09WdWFvcWllYVZ3cjQyZnBhTDQrbFd1VFlGRFA2M0tmN0M0YzdO?=
 =?utf-8?B?bi9NTno4a1pJaGxGTlFNNFV4cmNKbVl4azV0Z2NnTU1NQ05jNmx5eUVGMnZS?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39e2250-071a-4f54-b751-08db519402c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:20:34.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdtOiI8CZQp0Z5GRkz+/tsSP3gxklSvHyISA5ZA/IIjTmi6jb6a0sF62wmuLyDJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3859
X-Proofpoint-GUID: bWN-3fyqV8N449bdHH6upYe3g5-R4rKe
X-Proofpoint-ORIG-GUID: bWN-3fyqV8N449bdHH6upYe3g5-R4rKe
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



On 5/10/23 10:27 AM, Jiri Olsa wrote:
> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
>>
>>
>> On 5/10/23 5:20 AM, Ze Gao wrote:
>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
>>> however it does not takes those kprobe blacklisted into consideration,
>>> which likely introduce recursive traps and blows up stacks.
>>>
>>> this patch adds simple check and remove those are in kprobe_blacklist
>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
>>> check_kprobe_address_safe is open for more future checks.
>>>
>>> note that ftrace provides recursion detection mechanism, but for kprobe
>>> only, we can directly reject those cases early without turning to ftrace.
>>>
>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>> ---
>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 37 insertions(+)
>>>
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index 9a050e36dc6c..44c68bc06bbd 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>>>    	return arr.mods_cnt;
>>>    }
>>> +static inline int check_kprobe_address_safe(unsigned long addr)
>>> +{
>>> +	if (within_kprobe_blacklist(addr))
>>> +		return -EINVAL;
>>> +	else
>>> +		return 0;
>>> +}
>>> +
>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
>>> +{
>>> +	int i, cnt;
>>> +	char symname[KSYM_NAME_LEN];
>>> +
>>> +	for (i = 0; i < num; ++i) {
>>> +		if (check_kprobe_address_safe((unsigned long)addrs[i])) {
>>> +			lookup_symbol_name(addrs[i], symname);
>>> +			pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
>>
>> So user request cannot be fulfilled and a warning is issued and some
>> of user requests are discarded and the rest is proceeded. Does not
>> sound a good idea.
>>
>> Maybe we should do filtering in user space, e.g., in libbpf, check
>> /sys/kernel/debug/kprobes/blacklist and return error
>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
>> requesting kprobe in the kernel.
> 
> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> some of the kprobe blacklisted functions are actually safe

Could you give a pointer about 'some of the kprobe blacklisted
functions are actually safe'?

> 
> jirka
> 
>>
>>> +			/* mark blacklisted symbol for remove */
>>> +			addrs[i] = 0;
>>> +		}
>>> +	}
>>> +
>>> +	/* remove blacklisted symbol from addrs */
>>> +	for (i = 0, cnt = 0; i < num; ++i) {
>>> +		if (addrs[i])
>>> +			addrs[cnt++]  = addrs[i];
>>> +	}
>>> +
>>> +	return cnt;
>>> +}
>>> +
>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>>    {
>>>    	struct bpf_kprobe_multi_link *link = NULL;
>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>>    	else
>>>    		link->fp.entry_handler = kprobe_multi_link_handler;
>>> +	cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
>>> +	if (!cnt) {
>>> +		err = -EINVAL;
>>> +		goto error;
>>> +	}
>>> +
>>>    	link->addrs = addrs;
>>>    	link->cookies = cookies;
>>>    	link->cnt = cnt;

