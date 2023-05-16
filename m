Return-Path: <bpf+bounces-653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0D7051E1
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA31C20E45
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEF28C37;
	Tue, 16 May 2023 15:16:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8F634CEC
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:16:59 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F75FCF;
	Tue, 16 May 2023 08:16:57 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GD9hGw024391;
	Tue, 16 May 2023 08:16:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=46uCrpssAkgJG6EJTsZU7aR1rQK6t4G4cmVQldkeRTI=;
 b=QRyUviqfW7isp1w/aOguN9Q9qL3Q/1qBEZ0ZzK08dEXptjsEaE1C9TivuR+6U3yQnxx+
 0HZbAwOGDN3cnE5yJXqtnroAnxNMIKKOB6yiuceWNskM7Gbo+7Jom/j8/2rTc5soXYTS
 GWURKrZwB2vM8X8YPM2W/ZPnvYiZuKiQVgSYcBrSTftj0moqN6wDOGQRdbiZc1eWwMns
 zVh70uguwe4hm1O/CNN1FYTYUPegNHbg18yZNUAUmw00TBjqN8Uy9u+9VuvsMjwBCxTV
 C0cpXLmRucJcaCiardIDLsruXr2jNhGRxwuo/5B00UlcVG8w2eYQKY6oA4gh7eKAu5nU 3w== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qkwa45h5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 08:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoOrODeOeBN0GgDioVVxIu2CKJK4F+nXYsxxIQVISrtydxPfPqCCTtVJm0ruPjap2CjwC/A1GjG2c9Whd3Op7lmHYP1mp6Rp/JsPY5PrLCBk+XqW53mMqYLgcHQThdaxYeeuDYXmM4J8jxJqm4B88xV5C4FlVTAmwDY0gLiV/OGGFAiIAQ3T7gOC59SLjJXrq+2NJMXpI0XGu4RmV4s2KgNECA+7G/HYWL3D+VK3ublRLD6YWzFR4rqbYdpE7fNSI7kWdnzWKQJ5MznwMNgDcYqtTfFDeUYth1nYKGAeT5Ue3XeMvDLOlPNqjP/kTixoV42I5wl3WUQz/w6sBBlTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46uCrpssAkgJG6EJTsZU7aR1rQK6t4G4cmVQldkeRTI=;
 b=FEo6sDKEdADyXRcT9hPcbampzCw839FYxUDKHVU4Y2plcFckZt+o2TuxZAiMPMnIQMn3+ks64CWtY/Usk5CpFe5+pjNISmu47Ax0+J0399a7HNSPzJoRFr7YJztpAH6DB2/cJ8CriPF5fZIgePSGXtRL0mQxj0wb1+tVw6t5j9tr7LS/AzjvPNw6fbd23cbh5sMwgHMUoUa+AvMG25moNQqG2EodxLQS50w6xfCqd1OWz6xKI+1kCa729jeeTYdFik2YJsgA7t+Y45O3loR/Snqx0VAjHkvL7ujQrd0jlppwlDz2e/Mx1vyuRt1wulSo0TEMsufhRCYvwKgMKX7xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6341.namprd15.prod.outlook.com (2603:10b6:208:47e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:16:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 15:16:09 +0000
Message-ID: <9d211c94-5108-e4d3-9e6c-7060da710c35@meta.com>
Date: Tue, 16 May 2023 08:16:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com> <ZFvUH+p0ebcgnwEg@krava>
 <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
 <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
 <20230516144908.f062ab19327634fc40cfc3b7@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230516144908.f062ab19327634fc40cfc3b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f5b5eb-b818-49d5-95b6-08db562079e3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l9r8akIeV/kR4p9+txFASiX8l9HIjd9INegO0kLBobJPEwqL4PTaeRh6Kt+jL8Avrz87WLZtNnLrXwGAkEJIlXBnnVrZo3Yp6pS6QL/3cU+hqOWQIYPVmwVK7Rvv9haQht36dvP0KOdFXSjBI7qCFCMntPy5EUHu7YE6Ou5HAoCp8Z3pyNERNWuKZ3tvNr4BK8FQIOXIT5yERbCN2r58eNFxYpx8uIqVRdPbLno5Nsd49OJFwUEutLeCYVPtUC1WW4YlcPXTn+OawKKL9MWUgsfPE46XZuW0p0rkQy6vH7onK1f95GLzx5DFnmwg9Qn7ZK7zwvUvhoF3Y59hi55v3o9BFiKfwhhFD6Fiej0/Kzn3C/cvUbBEZ+fNewNSGPN2FWS/dy4Op8bfJ+dJxQXVUI4rKWIZ0MKxaFd3bTlKKoLnOjFFJpgNUhmHFKOPJ3DRDb5i8oGO46CfjWvdnBjDAI3uYGV7YXkqPOGJg60PSnx+sDMC/BvXJvM6uBV6KewFMqwKTMFlO7eNPjaWg21WAQflJDSDwjc/pLqMdzr8oDRJ2MG4KabxRVlMStQKT/v/M7zFj8pthJTvOnv6lQU6AZzDNDeu/rlhDDH/Cn0q6lXVY78S0uF+j6fIqrzCQ3Jbr22xjDgy+feI5T5gmDOBAw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(478600001)(54906003)(8676002)(8936002)(7416002)(5660300002)(316002)(36756003)(31696002)(86362001)(2906002)(6916009)(66476007)(4326008)(66946007)(66556008)(38100700002)(41300700001)(186003)(2616005)(53546011)(83380400001)(6506007)(6512007)(6486002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnF6alRsYm1lTDZMV2haOElQaVJ1OVVtNldjMlhreElFMFZhbkphOFFwaUhG?=
 =?utf-8?B?VitEcVRsQVE0QWhtaUNPRi9Gb2h5RzBodWVrdDZYWlBkZU5JQnFpK1pXNC9n?=
 =?utf-8?B?c2dOeThHS3BoK0d4NGMxSDIxSjBuZWRzRit6RVZNcURxcFYra2cyaXVmZzVi?=
 =?utf-8?B?Z3RNMmRlNjNPVW03WjJ5QWRaWTduTUJqZ1kzSDVXc21KaGdPM2IxdGZIZkFk?=
 =?utf-8?B?NmNkZm5qSXFGS3JwQkRoa2g0TEJHL0JWd3NzT3ZhTXgvZ3hjY1NyOW9mMFgz?=
 =?utf-8?B?b29GbVRPLzNveGMwWmpkemJHLzFrWjBtWE5KRFNwendQc3o3QUVuTmYweWVM?=
 =?utf-8?B?UVV1Z0dFQ1F2bFBGVjlZVHpiQnVDdzR3R2NVanRtQXVuZ0pRMldiNUFBVkNK?=
 =?utf-8?B?S1JaekVpaThzNWpjdGlOOExGYmhRVEVkMllCa1JoQ2RHUGFpd2hGd0lBaUUw?=
 =?utf-8?B?SUlORnZTMlVvdFpWWTV6Ykl3Q1ZDSWEwdzdHRGxHN2g4K2JQUW83OGlHbVFF?=
 =?utf-8?B?QnhJeXFOamREQSs3NDZRUEtoajN6RU9Ncld5eUFqZCt1YWlibG1mcGZ0TmxI?=
 =?utf-8?B?VGx2Rmo2YmRFVWpLTUhmZytIMkd4MUJjSFRKNkxrV2lXUEFRSitZNWZXVVNw?=
 =?utf-8?B?MEFzQU11VDVXTGdEbkZjclpBVCsvem8wcHMyTXBhMUhCTnJkNW1MeE9HV1Zq?=
 =?utf-8?B?OEd0cEs4endyZ2VNeHFOUGxWNDkzcHVCOTlqeFk2cFNDMjNLMkxKR2E1akhk?=
 =?utf-8?B?dERxMHYvQUlKNjFLbVB5dVBUSjg3aGI1dTJzZ1BFZWJuUlBManVlWTR5a3Za?=
 =?utf-8?B?dlJidTB1ZVd5aVlWclM4UVhZc0FvZHoxNUhIejl4cFVIaFcvUnhiT2toYmtj?=
 =?utf-8?B?WEkyVWxWbnVtTFRlZW5YSzUyNGFjSjIrdnJUVUFGc3ptUDd2TnUxWnNFUlZW?=
 =?utf-8?B?L0lpZzJlelJCM3gvdnA3Y3MzTzdIQWtrSG5GRzRJZFl4Z2NjNmN3R3Yrb2px?=
 =?utf-8?B?VlVsK21Zc0dKS0Fjb3lpZ3E5cTR4MUdQMVlSSyt5WE03SnAwQklESm5RcEY3?=
 =?utf-8?B?N1dnclgrWm5WOURiN1RHV1dwZ3M3Y3NvTUJWaVNHbi9BelJpNk9VL3pkL2tw?=
 =?utf-8?B?UVVpZmI1TnZ2c3A5bjRrRE9MZWFySGx6RHRYYTVxK2FtODkzM0lUVFZoYThX?=
 =?utf-8?B?eDUya3B4VWtvRkJEQ1hObFdHWmVCMDhFK211aG5RS1R6WjV4YURqQ1VCREZ2?=
 =?utf-8?B?cDV4Q1p3TE5CZitHVkN2MlYyZG1OM2dRU05sd2NVMW1xL3FON3dpc094blNp?=
 =?utf-8?B?VURndXRSVjY1dDRGL1JCd0R6dkpvVHYraEkvU0l2MzFuREhjWUpBa3pTRE5K?=
 =?utf-8?B?K0wwRlN5V1RvYklmRGUyc0J2dWhxUVV5cTZTY0YxOVNMVk9BRWhuMjhSUDlI?=
 =?utf-8?B?enl5Zy9EdGlZa3F1VC9jdmFRK2VqSURvNlNsYWFiUTU3azdlTzJRUVprUm9B?=
 =?utf-8?B?bTdpMEdzNTZsNTlZSHFEWmY2NmF5SXVLMHgwdWJ0SDh2TzZxQlFRYng5ZDR5?=
 =?utf-8?B?YjBMMFM5emkzQTl1S3BxMWVHUXdpdjlrL0Z0a0s1d0hjNXV6djZicWwrc3Fp?=
 =?utf-8?B?NGIzNDZDYVFySnpDMGc1NnRyMDhFK1huS2lxTjlpdnJLRjhQRmZFMzl0bUlD?=
 =?utf-8?B?YkxlVVFQQk8vUUV1d0Qxc2VFRVFISVk3RlJUM0JsZzBSN2NvZHZ4MWEzUXJT?=
 =?utf-8?B?TS9pN0RkSnQ1UmZvMUptczNLVVpmcVJWaEhtRHlzaEhqS2tpTzJzT0poRENl?=
 =?utf-8?B?cC9Id3dlR3EzcXFaN0haTFBNRFI4SDdrOC9LamIvdklxUXdnRDBVWG9HUlBL?=
 =?utf-8?B?REUxZjhnbmw3QlZqT0g5QVVWa0piTTNoSWdEOTZsclJBTTdBcWtLZGtJQ1J5?=
 =?utf-8?B?NnFsQitYR1NvcGVZbm1BNm05QmNOQk1JakpEWWZoQlg1Nkh5dys2WlErejRW?=
 =?utf-8?B?Sk1GWXhXdXNuS3JUMnplS3pVZ3U0MEttOHd3RDlIMGpzMkNHa0FKVUQ5eTNQ?=
 =?utf-8?B?MVhJUng0aDVQUDU1MURCT3VWaWVIamtDQzJUVjB5S2haMTQrSnJMM0p0TUp3?=
 =?utf-8?B?QkQyQnpzNUFVSy9EeDhrRkMwQ1FJSEUvbjI4YlRhOFY2Z2gwS255UVAzYkFl?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f5b5eb-b818-49d5-95b6-08db562079e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:16:08.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NASqNVKxDsSwP8BxTltP4gnI9dJSjyxyxzIVOoYv2gPRp1LLct7ICbLZHK5cujNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6341
X-Proofpoint-ORIG-GUID: YtA-V-6UlubOABtAeFotg4rZPNxR8sgR
X-Proofpoint-GUID: YtA-V-6UlubOABtAeFotg4rZPNxR8sgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/15/23 10:49 PM, Masami Hiramatsu (Google) wrote:
> On Fri, 12 May 2023 07:29:02 -0700
> Yonghong Song <yhs@meta.com> wrote:
> 
>>
>>
>> On 5/11/23 10:53 PM, Ze Gao wrote:
>>> Yes, Jiri. Thanks for pointing it out. It's true that not all probe
>>> blacklisted functions should be banned from bpf_kprobe.
>>>
>>> I tried some of them, and all kprobe blacklisted symbols I hooked
>>> works fine except preempt_count_{sub, add}.
>>> so the takeaway here is preempt_cout_{sub, add} must be rejected at
>>> least for now since kprobe_multi_link_prog_run
>>> ( i.e., the fprobe handler) and rethook_trampoline_handler( i.e. the
>>> rethook handler) calls preempt_cout_{sub, add}.
>>>
>>> I'm considering providing a general  fprobe_blacklist framework just
>>> like what kprobe does to allow others to mark
>>> functions used inside fprobe handler or rethook handler as NOFPROBE to
>>> avoid potential stack recursion. But only after
>>> I figure out how ftrace handles recursion problems currently and why
>>> it fails in the case I ran into.
>>
>> A fprobe_blacklist might make sense indeed as fprobe and kprobe are
>> quite different... Thanks for working on this.
> 
> No, I don't like fprobe_blacklist, because you can filter user given
> function with <tracefs>/available_filter_functions :)
> If the function is not listed there, you can not put fprobe on it.
> IOW, kprobe_multi_link_prog_run only covers those functions. (white-list)
> 
> At the tooling side, it should check whether the probe is defined for
> single function or multiple functions, and use kprobe-blacklist (single)
> or available_filter_functions (multiple).

Thanks for clarification. So basically fprobe blacklist is similar to
fentry, not able to trace functions marked with notrace. So agree,
the checking scheme could be:
   - user space to check available_filter_functions
   - a few other tracable functions but may have recursion effect
     handled by infrastructure for fprobe case. fentry case is already
     covered by verifier to deny a few functions like preempt_count_sub
     etc.

> 
> Thank you,
> 
>>
>>>
>>> Thanks
>>> Ze
>>>
>>> On Thu, May 11, 2023 at 1:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>
>>>> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 5/10/23 5:20 AM, Ze Gao wrote:
>>>>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
>>>>>> however it does not takes those kprobe blacklisted into consideration,
>>>>>> which likely introduce recursive traps and blows up stacks.
>>>>>>
>>>>>> this patch adds simple check and remove those are in kprobe_blacklist
>>>>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
>>>>>> check_kprobe_address_safe is open for more future checks.
>>>>>>
>>>>>> note that ftrace provides recursion detection mechanism, but for kprobe
>>>>>> only, we can directly reject those cases early without turning to ftrace.
>>>>>>
>>>>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>>>>> ---
>>>>>>     kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 37 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>>>> index 9a050e36dc6c..44c68bc06bbd 100644
>>>>>> --- a/kernel/trace/bpf_trace.c
>>>>>> +++ b/kernel/trace/bpf_trace.c
>>>>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>>>>>>       return arr.mods_cnt;
>>>>>>     }
>>>>>> +static inline int check_kprobe_address_safe(unsigned long addr)
>>>>>> +{
>>>>>> +   if (within_kprobe_blacklist(addr))
>>>>>> +           return -EINVAL;
>>>>>> +   else
>>>>>> +           return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
>>>>>> +{
>>>>>> +   int i, cnt;
>>>>>> +   char symname[KSYM_NAME_LEN];
>>>>>> +
>>>>>> +   for (i = 0; i < num; ++i) {
>>>>>> +           if (check_kprobe_address_safe((unsigned long)addrs[i])) {
>>>>>> +                   lookup_symbol_name(addrs[i], symname);
>>>>>> +                   pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
>>>>>
>>>>> So user request cannot be fulfilled and a warning is issued and some
>>>>> of user requests are discarded and the rest is proceeded. Does not
>>>>> sound a good idea.
>>>>>
>>>>> Maybe we should do filtering in user space, e.g., in libbpf, check
>>>>> /sys/kernel/debug/kprobes/blacklist and return error
>>>>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
>>>>> requesting kprobe in the kernel.
>>>>
>>>> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
>>>> some of the kprobe blacklisted functions are actually safe
>>>>
>>>> jirka
>>>>
>>>>>
>>>>>> +                   /* mark blacklisted symbol for remove */
>>>>>> +                   addrs[i] = 0;
>>>>>> +           }
>>>>>> +   }
>>>>>> +
>>>>>> +   /* remove blacklisted symbol from addrs */
>>>>>> +   for (i = 0, cnt = 0; i < num; ++i) {
>>>>>> +           if (addrs[i])
>>>>>> +                   addrs[cnt++]  = addrs[i];
>>>>>> +   }
>>>>>> +
>>>>>> +   return cnt;
>>>>>> +}
>>>>>> +
>>>>>>     int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>>>>>     {
>>>>>>       struct bpf_kprobe_multi_link *link = NULL;
>>>>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>>>>>       else
>>>>>>               link->fp.entry_handler = kprobe_multi_link_handler;
>>>>>> +   cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
>>>>>> +   if (!cnt) {
>>>>>> +           err = -EINVAL;
>>>>>> +           goto error;
>>>>>> +   }
>>>>>> +
>>>>>>       link->addrs = addrs;
>>>>>>       link->cookies = cookies;
>>>>>>       link->cnt = cnt;
> 
> 

