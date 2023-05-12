Return-Path: <bpf+bounces-403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB7700A50
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FF81C21230
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443AA1EA8B;
	Fri, 12 May 2023 14:30:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65FA920
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:30:00 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAD9272D;
	Fri, 12 May 2023 07:29:59 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C56U4A004409;
	Fri, 12 May 2023 07:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=wzH3I5Oyi8VDrQTeW4ecYYfCdXsw5E2myxayovTiTgc=;
 b=EE93GQfUIo8ZJguKs1SwpqxMlTp1zIvezRfqEQFVPlmKVC4WyzOrq32yMvYmahv+eFvx
 xn296hdHNPYmGqesrFr3Noc05NJSMC4QMVZI44p97Xo5lXDKfdm9FIdiqumzsG2edXOb
 YJJFg8V1tdYspF3qoEfP/2gqHzSdChZ3z/8IWTp5iAErM2hq9GUHEj/ZN8cOL8FD/Aec
 tRqULdpMjTOAEPANQWVMXOGmyYzuRvU3coRFCOvAhFGlhYWADp4RwyqBozONcQN9QkeW
 Y9zdUapc/ulX9eNpE7/ab3HCrAUdmUg7Jd1vfsVd+GlTVDVWcGnljprjtyXQLZwi8+Dw 9w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qhaxb5c6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 07:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNEk63ENNrqiSkHRQ4NnVZfhXVZSWwreKtT3gK+p3X/pqKPuBMkjv1Di9cIBfmcfJYRTcUG6UqHLuOp12SV4y1ORJcTIOBC4hFoPXcCs4fOY5D2pe/2npGkG5CMtdxS8MHvJdUVnUZkNHW1I3EuR8yMwJAiZpi59w8I0EvFBNE3qiuWD1GYdRBj7H9pDiT/eBdLhBB0lZaGge+2ikhfz7S2FYVZkCSUl45GbxVxeSTtfEgS02pIM6YnIUrAGAkyg57uBGyl439Q6AvcvI1gZWtZ2sbgxVLco/MOn/CXolzdvwa6TNuLmeA8b/gGlYFXEqxRdynRvtsDE7+Uh7WslCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzH3I5Oyi8VDrQTeW4ecYYfCdXsw5E2myxayovTiTgc=;
 b=TbjPmnzKM5ZQQGxTXFvt2FlylIrAQt2FFphi1EFBY3jXFp6peb/Uru9la8jnKXqEVom+xWTU7iXhT6MWKLAYyBW6t2GmH6imtlxI8DfvNlPh+x6p7ZVI8xbKSRsNcXPXz+BPTfWN1T0IcXkb5IN+ZbQtUnhdFrWkFrVY1QdEbvPOOo9wOjTVbXAGSZ80XHhCAkLB0o3nIvOXYx0rUwah8jI9qtDT/w2MYjl0LM2gQP//olzLuFjnI1gaVZTQqGw4WgHSyUpGHMRdmTRtwGWYU1V7WClLkRoxy1CDiCKIF5dNag3DeIKvPf/GxfyvFIBEVHUpBLq2SkxSr01Fwm6gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5667.namprd15.prod.outlook.com (2603:10b6:510:277::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 14:29:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 14:29:06 +0000
Message-ID: <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
Date: Fri, 12 May 2023 07:29:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
Content-Language: en-US
To: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com> <ZFvUH+p0ebcgnwEg@krava>
 <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf2fe4c-042b-41e6-792b-08db52f53dda
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gbBxRMYuSUa1XZAF5f5A1g1WbvSRuGQ1+4lhixS3mh25eV/u7ybpCAvM7VysCIV7pW1Pked5j3vGYhrb8JU6wnky3/Uv1S0ldSTI5C2T1WXrfVj9jibSAikF/tI/1y15A+s+WNQfOemhei9jbfH9q2vEps8JnrzXMMhdR5jtrtnpi/g65O6NCYQPifdH6s/YNbUAr+10b5OP+8Uv1u01jmVMy4n83JYxMev4FGV5PJzPMMmtwwLHOXZSb5UQl7SVMqnOwunj/1RjwelTclzGtbYPHyY2/Tu2vOZdeWBG8xxl1z27OH4CP6BFZdzAymaziQ9eQKDFKGXc+LH/nbZjB5Hfmdn+6xc67d7lDyc1ufoTFIv5haDEENuuBmbbMtSHvHfSMgh49OUlvIwyJyzqSBikuUq5TzMIoRjJWl9ljIwWX9ayzNH3E1nQmacOuV3+HhrzpAgvRhMFc48Qx75XcXsZwc9qaE7EmpyfbUIM4DKL0NKmlF4eKegzcI/t8fKd9brBqHZOp+FPifKEvIYPA/ULSgZS59bl+2w9EN2iGjwZ7s9yFsLbb2IZ3Wk+NJefT8zocZVkesbblmgFcliYwo7qD8uSmLpRRzmb+ARcPpsRDISkk0MQV3Inrs6nCUW69cXxnRaLQ1+5SA5ASLR4Nw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(86362001)(36756003)(31696002)(110136005)(54906003)(316002)(66476007)(66946007)(66556008)(4326008)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(6666004)(2906002)(7416002)(38100700002)(2616005)(186003)(6512007)(6506007)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm84aTBKOWlsUHpSUFl0aGtvbnBMekRRQ2pOaU43dm1yaTNqNUZBdXRtTXRS?=
 =?utf-8?B?OE10NHdRdnhub3VpeHFpRmg5UndsaFUwY0IvKzE0ZnU1TlBlMzFHV1F4dlp3?=
 =?utf-8?B?NERLaDlZMkZ0WTNxMnVTT2FhY0ZRdldkS0QzQXVETEtPQlY5bWdrekZOcUNt?=
 =?utf-8?B?M1h4VkdOQTM1ZTNmUVFEOEtyampPaU1QckZtYTBUOUFFa2ZXclBJMzU4SkZX?=
 =?utf-8?B?QkRjRVM3amVRaitiaFAxZ2NxdzlvK1Q2MXBJdVFRVS9rdUlEa3hWcGlFK3NY?=
 =?utf-8?B?aTdUaWVZS0RWMFpwTC9NTitjRUFqZ0JoUE5PbG9RdjlodXRzVmcvT3dMVWE1?=
 =?utf-8?B?R252aEJHeDNnWHVzR0ErOTBYRnBHR1pMYmNTcHE0SnJIcHdsYVFDUnBWV3Qz?=
 =?utf-8?B?SjkwQ25TblJpMFBZNGVWdVAveENudTN6RE1CUUdyU1QrcUNqd3J0Uzgvcko4?=
 =?utf-8?B?a0NGd2ZGcnVNRlFBSXRNY0UybEFhZXRoRmNOdEx2ZjNLV2orM1RFeUp3Uzd4?=
 =?utf-8?B?b0UydUJ1R3Y5djhVQnBxanNvRVFpYUVSWXNxdUdEZno4RzhwTjlVK1d4cmVX?=
 =?utf-8?B?WTRMUTRjN05ZMTM1emtWcGtiTy9KbUYvNDdGcnFwb0I3b2QwVmdXMVJPTEdj?=
 =?utf-8?B?cWFkLy9kY0FuOWdrSUFFWWpDU2owd2ZVR2M1bHllQi9sNHZDeUthZnFpNmpz?=
 =?utf-8?B?U1AwRlArSlpZcm4zZ1RXc3U2MThTQmNpazNlc0kvVmsxWmFQS1JwR2VEeVo1?=
 =?utf-8?B?U3B6Q0JnZksyVlBmWVRpUjBOQnJIZ2F5VXliMUdnMVFLaHpxUHFXRW5KK2JV?=
 =?utf-8?B?c01GMGdzODQrcUtEeUZuc3kxTDVDWittRVp4ZWZTZzdlQ3FFOVdjakh6MmFl?=
 =?utf-8?B?L1NGVjBSZ3ZtV0U4NEFuVnFaYndSbFg0L0tMUk92OW0raUVnSUxKb3ZFS3ho?=
 =?utf-8?B?UG9nZFNaWCtkUXU4S29CaHNQK0VsTVh0Z05DWVJKajBBeDkrODhyZ1F3dGs2?=
 =?utf-8?B?Q0JrNGtJbDNPRGp3KzVwcmZKQmVBLzdvOWtuck5iejc2RlJsSW5KUkQrSTEz?=
 =?utf-8?B?R3phVHRUZVEwK1c5STdlOGJyYmRWRDE2UGJaUEgxWVoyYTMzd0gvYzJpNlRu?=
 =?utf-8?B?VTVoMXlEalZkUlJITTUxTnNJUVFQWXJkeFdmYWJGMmJReW52M29wWkZ4Mmow?=
 =?utf-8?B?L3pkc1FpS3MxM0ZrMVFIc0Mreit3YjN2YmNKcm5EZCtDZEJpOTExM1FHL2do?=
 =?utf-8?B?STFuLzhLTWx5Vktkbm5DNm83RWIrK0UraW5QTnZFMDhqR2k4UlVKSmliczg2?=
 =?utf-8?B?MHB3Vm5NcDFDczlVclZQK2h1YzlhKytuM1NRbHFmV1ozNi8wK3c2VzUrdStl?=
 =?utf-8?B?YUlaR0k5NVJyRFR5M1B0SGNwcFFRYXVQa25nMzJxUFlld05McGI0REVoOUlB?=
 =?utf-8?B?b0Y1TUUzYTdDdGRmaTcxaVhJMUlTV1JUUnQ4bmxNaGNKcU5FQnh4eXVzWU52?=
 =?utf-8?B?N2lwQUJmYlNJS01OS3NxMlpMVUYwMUpnbEt1eVFTM1ppUjRJYzVUQW5TQTA2?=
 =?utf-8?B?ZU5kVmlrNk9JRmZXdzZDU1JvSjE2YmtHRSt2TEFtSS9GVUl2TUlpdVN1eEli?=
 =?utf-8?B?SXF3Z3RGbDdOVGJaSnlzbU8yRjQxRkpWNStRbmZYZXVTWFp0ZkRVbVdCY0gv?=
 =?utf-8?B?WGxoeVpCOGNPOTZXSTFsWXVzVEhUTmhXREZCUkZpeXFRblRHM0FTRUVJNFBE?=
 =?utf-8?B?b0hyMDFkUnErUHVSZWlpdk5iaUxyK3MvSkJHcURvaWNlUEQvNlZYUWh3NVpz?=
 =?utf-8?B?dzFpejl6aTgraHc3RFBVbWxPT3RaeXpOMVE1T1hMR0ZicmNBMGtobGRXL3R4?=
 =?utf-8?B?RDZ2NVNSRmU1Y3RKSW9nWU1FNFAzVDNvYisvSGNxR2F4c3RXbjFxZWpvUDRR?=
 =?utf-8?B?bzdJU1c0SjRQUk1RQU5NcXFCSURDNGxHcDI5K0srL0tGSVM5STY5cGc1KzQ5?=
 =?utf-8?B?NjdnT016VU1iaVYyZExGV0EvRjFYelozZFFnbjc4RDg1ZW8zVU9FUC9DSEZu?=
 =?utf-8?B?KzhFV0lOdDhsam5kZ2liR0FzMFh1Z1dWUXdEaXNINjdtdUxoQm1JeFdNMjJB?=
 =?utf-8?B?TnZkN1RKQ1FHTWgzRWNYNmJWV1JERnlkZXR6NUlKcFUrZE9EMXNpb0pSZkNj?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf2fe4c-042b-41e6-792b-08db52f53dda
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 14:29:06.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvRiSTS050HUKqMGe4OiTJ3CsWU7eoZNA9Q/sFXWLegwwkqhqP+FKnEAtXpqq6a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5667
X-Proofpoint-ORIG-GUID: qsMJvfu_GVrqOqEUqJoYwXQJ00Rw-7Xk
X-Proofpoint-GUID: qsMJvfu_GVrqOqEUqJoYwXQJ00Rw-7Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/11/23 10:53 PM, Ze Gao wrote:
> Yes, Jiri. Thanks for pointing it out. It's true that not all probe
> blacklisted functions should be banned from bpf_kprobe.
> 
> I tried some of them, and all kprobe blacklisted symbols I hooked
> works fine except preempt_count_{sub, add}.
> so the takeaway here is preempt_cout_{sub, add} must be rejected at
> least for now since kprobe_multi_link_prog_run
> ( i.e., the fprobe handler) and rethook_trampoline_handler( i.e. the
> rethook handler) calls preempt_cout_{sub, add}.
> 
> I'm considering providing a general  fprobe_blacklist framework just
> like what kprobe does to allow others to mark
> functions used inside fprobe handler or rethook handler as NOFPROBE to
> avoid potential stack recursion. But only after
> I figure out how ftrace handles recursion problems currently and why
> it fails in the case I ran into.

A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
quite different... Thanks for working on this.

> 
> Thanks
> Ze
> 
> On Thu, May 11, 2023 at 1:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
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
>>>> only, we can directly reject those cases early without turning to ftrace.
>>>>
>>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>>> ---
>>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 9a050e36dc6c..44c68bc06bbd 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>>>>      return arr.mods_cnt;
>>>>    }
>>>> +static inline int check_kprobe_address_safe(unsigned long addr)
>>>> +{
>>>> +   if (within_kprobe_blacklist(addr))
>>>> +           return -EINVAL;
>>>> +   else
>>>> +           return 0;
>>>> +}
>>>> +
>>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
>>>> +{
>>>> +   int i, cnt;
>>>> +   char symname[KSYM_NAME_LEN];
>>>> +
>>>> +   for (i = 0; i < num; ++i) {
>>>> +           if (check_kprobe_address_safe((unsigned long)addrs[i])) {
>>>> +                   lookup_symbol_name(addrs[i], symname);
>>>> +                   pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
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
>>
>> jirka
>>
>>>
>>>> +                   /* mark blacklisted symbol for remove */
>>>> +                   addrs[i] = 0;
>>>> +           }
>>>> +   }
>>>> +
>>>> +   /* remove blacklisted symbol from addrs */
>>>> +   for (i = 0, cnt = 0; i < num; ++i) {
>>>> +           if (addrs[i])
>>>> +                   addrs[cnt++]  = addrs[i];
>>>> +   }
>>>> +
>>>> +   return cnt;
>>>> +}
>>>> +
>>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>>>    {
>>>>      struct bpf_kprobe_multi_link *link = NULL;
>>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>>>      else
>>>>              link->fp.entry_handler = kprobe_multi_link_handler;
>>>> +   cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
>>>> +   if (!cnt) {
>>>> +           err = -EINVAL;
>>>> +           goto error;
>>>> +   }
>>>> +
>>>>      link->addrs = addrs;
>>>>      link->cookies = cookies;
>>>>      link->cnt = cnt;

