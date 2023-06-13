Return-Path: <bpf+bounces-2479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A372D8EF
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4F62810FD
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 05:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1961FD6;
	Tue, 13 Jun 2023 05:04:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5ED361
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 05:04:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020489B;
	Mon, 12 Jun 2023 22:04:46 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CMkD9w005316;
	Mon, 12 Jun 2023 22:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HWl807mcNWywM2R2FFZnQmbtyBHZc3Kgc//f6goWLjc=;
 b=KReeOrzNtms8olgrd2WU5qmplz4vCBXtqgllLTH4hJr9fE2kaJsOQ93Z3ujFYykijVl7
 61LncA5byiBjl0fiiGlGv3aKuQ5/+LGWSgkeRh2R7aVJGmDZGQ+YODmyyGWkN0OEKSK5
 hyDrppO0+fse7i8DwwIRmpPpPNP1vgp83LvVRKSRsjN6T0Cp3+qGchtO+MbbGreKoyf6
 yxdDBmUBcQpSRAYrbkYmbx3MKkvECwd23UgE1uU74ENwOnzHVuQoEOQH+GlKA+kKoZCB
 1AZ79rBH4/ZC266gnUKYSKP3BXNESKGX3ufwpQlU3sNSV8FWm3olFWAZU/jZXrvtiSlv Tw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r6cayhv6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 22:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d685h9x3P85S/29S9+wFkVoEsxRuWQkOKxjsyhm9xYd+NUREDhhQWI+VzK4ZVlDtB8+E7OJP00UAit+CKNP42MjGF52L1V7ykmrcs5SqyNav3MaLUJDyj7Ko1yz3cTrk/Td20FygFYqeTmo2Bnbc1J4rkYIPBvJ00KJbPzUyeivm5Ve76Rs8sAgVbfLB3zli/TaGtXdAtVeHJP8IGI3NU7SFRZH7dgNSXbiBnZEn2KlNqRIDgqBDQxllFSougbW95yfcnrcKViLFzqAWKOKy5CrjD4Vh7nkFGnyBORbpgl6LBjvCP3plPZVQ+yhzZ+tth5pCfEG5+j5LqyCtGGNifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWl807mcNWywM2R2FFZnQmbtyBHZc3Kgc//f6goWLjc=;
 b=MeKx2g3QYAx7Rx+6I26xj5vTAOQPcS43TK5txhuu10y0rGzhAh7Ho/WZT9caZHOw6c5UEy+p0PC8qAh73m9zXgeG/LbNarNqAp1pAGLIE6H+DqnkejC8T+7FFz2497o+M2/eSDQit0pYnrqFnCYxAxMqpxv6zKn4wjfLvvh+UEAxuq/t3m0N/59ONWOaInJ6uQp8Ub/ghEnE3YMs+/Vl8QmV1I/bTgyb0CvRmw6iIg1TjcQnxACXxDTOOG1RaAOW8QsEmQNTE0mf3r02VVaJlzzKgw41A53eXvXQQfLCS+g8FyGB4cagy7SqVKhqwH1fbpeBkZ/p6EqDvHVdK+vUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB6247.namprd15.prod.outlook.com (2603:10b6:208:450::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Tue, 13 Jun
 2023 05:04:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 05:04:32 +0000
Message-ID: <4c87727b-0b3f-ffc1-d55b-90e75dcae52b@meta.com>
Date: Mon, 12 Jun 2023 22:04:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
To: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
References: <20230611130029.1202298-1-jolsa@kernel.org>
 <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home>
 <20230611225754.01350a50@gandalf.local.home>
 <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
 <20230612110222.50c254f3@gandalf.local.home> <ZId/UL/iujOdgel+@krava>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ZId/UL/iujOdgel+@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 2feafcb1-54df-4084-4654-08db6bcbac61
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dk/LgylLU5Ktte4DX1WR4VVe3QYUh3ksKpHCtHITAIS6sxJJoKZVLTVhGT5Xw6Fh3Z16ttzuMVIe5iuHI7SuUFqyTFRk7b08JQEjiXQeE+NSUcjpAvjYNGD92Bh3Ci57BD/clHeMUoGuIxBkvKfZuUXTncttsr9jf9L1eKi/g3xuJYJF3utSMUdofYENBgSCebgYeLyJVJyewT2PnaEvCKJUneT8kQYTQX/xqfpxkHwkwJlKne+ZZV2uvbgEyS7UCPNwsEUkVOjQweK/GzYItIydmr101yHsPmkeUoIrs5Qf3pc0b0ldUubG/7AxfPItI4VvtAHIAa2aYoY0Ch+ThHM7bKbkFEE4V4qJke6vOkxYE3CYiBJ6QAnghReKYnkrpj5xB+pTXQoJ/qvdEFGe8NCLYswoSfS7AtxuARKCHs5YbBcpQo+LbHpAKGZIMQGuWIKP06RTgU0qdYlJiIxIpoBjE5jvpWprXXTOfBI4MCfR8fJmgI3+62MXO9u2bruK2D+zIFajFlaVH0Yh3Fc6ezRc4bHktuGRUvLRnY8gf08S1bE54CijIcweJacrPQiY48G5F58UA8lPYECTWojkINx58GMBqgl8hJg+3i8I+DJ8nx9yHHEdYA9Q65wdUrXSzrp50Ff17kd4eRSGhVRTmw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(31696002)(86362001)(7416002)(36756003)(2906002)(31686004)(2616005)(966005)(6486002)(6666004)(6512007)(83380400001)(186003)(53546011)(6506007)(110136005)(54906003)(478600001)(8676002)(316002)(4326008)(66946007)(41300700001)(66556008)(8936002)(66476007)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REpEWk5pQzRVQysrL2JFUWVCUEVDSmRxbEgweWVLenQ4bEZ4OVNydm5OeGZD?=
 =?utf-8?B?T2h3RU93TjZScHZldkZvK1p3a3dZWE9Iak9oVVVxN2xRSURZdmFaMHdjdm1t?=
 =?utf-8?B?Tk13NjU3VWQxdFBnM3pRYnExRENYN2JBN2dtc3pQNTYzdjlFekxnd2RTSGN6?=
 =?utf-8?B?WGJUZDZwK1MwSERsQjA0NVV5M2d3WStwRzlhZDZiWkNPNlJFQVhTUE9VYVcv?=
 =?utf-8?B?V3dUL1hOaGhHRzdSSmNWQW5teDlXMHFNalQwbFN5UUFHeEtUMkkvU0tYR3JF?=
 =?utf-8?B?eW55Z3JndWZsbXhkY1BxVTM3allwZzF0ZjFRbkZIQ1J2U1k5cVI2VlpQSFVU?=
 =?utf-8?B?SkZYc3hmWmNHNENvU2VQd1RoaWV5dGh3dlRWMThlaFFKSG1OeGV5ZDEwck5l?=
 =?utf-8?B?dW9MZ2x5OWVWNmV6Q3dpTkxtbUZHdG9odlphZG9DM2JsTTRTM0wvVnRrb1Rw?=
 =?utf-8?B?YjYvV2ZMeGlpbUZtMmsydGhxcHZQcHdpYmwrQnhwcFpDSEFBOWh1Rkt3Z09i?=
 =?utf-8?B?NW9veTh1SElJMmhGMk44dDFSakVBN2FSeGY5Sk1nWGx2MFRaS0l5Vk9GUGtU?=
 =?utf-8?B?SE4wbm1RZVVqeEJ1dEhnUGJLK3pVZkNXS1FQc3JQMFpYMVovTXY4WVZSYmNX?=
 =?utf-8?B?U24xU1FsazRGNWtyNitKSWMyOGNTUFpHUHdrTlhhTXd3VFh1cmt4dEcvSWY5?=
 =?utf-8?B?WjdUamVmYVozTlRPRzJRVjdERm5BUlEwdE1UZmRpNTFkaXZaYVZoQVRDREVB?=
 =?utf-8?B?QS84ZmZwNm1ac0JJNDBoRHdoZlVuakhJQk1Qd0VnU2paRUFCQW5ualZaSEFy?=
 =?utf-8?B?T2tnZitBZGZQckVmOEc2VER6S0JKRjhvRjlaTFlZbEZqRng0b1M4SDlYQ1JI?=
 =?utf-8?B?cnhyRGRwSmF3Ri93MDJpTjgwL1F4Qmg2SGRaNmU2K2ZRTDVvZ0tqSkp4SGZK?=
 =?utf-8?B?TUtOUlhiTjN4S2RXaG5waDdyUTJ2aVBHMXFFeXZIblZ1aWZIM3JDUE5GOXIw?=
 =?utf-8?B?TnpINjRBakJCcjNpTjloVGplaVdWRVRjMXkrVjRRVnJsNjdlcXowWTlUeC92?=
 =?utf-8?B?Nk1JVzhVdFJONmhjZnZmWUtWYzJSY3kwL0V4bHJEOUFIdXBHc0p3TE5CQTJn?=
 =?utf-8?B?MXBwc1FhOUlMbzRJaUdJMzZ5YlRVc3FKdEllbmhJdEUvRmlGNVZDNDBBRVRm?=
 =?utf-8?B?dktJcnFGbFRDUVVkTDlBdmR5VTNjTjV1N0RmbU1IekhQYlF0V3A2c1hPd25o?=
 =?utf-8?B?bWN2K2ljQzd6R3ZiUkR0ajVpOVR5NHFlRlQ1Q0VFa1Rscnc0RVpLUllzZTg2?=
 =?utf-8?B?c1g3bExiOG4yQ3ZXQjVMVHBQdVpWTDk0OFVSbnQ3WEgvN29va3ZNUTEvakRr?=
 =?utf-8?B?VWJHT0NGK3N0QWF3MjY4ZGpuOThUZmE0aDRqOVpXU3VaT3pZRS9qQWp5Ullv?=
 =?utf-8?B?TTZ6OWQvM1dtNm5ObmFoZFBUUC9rS01ORkplLzVDKzg1ZnIvTjdBY0trZkZs?=
 =?utf-8?B?TXZuTXMyS1h2WjFIdUkrSThrRjRZMkV1RjFySldmQnVaNGdoa05NVitMYnU2?=
 =?utf-8?B?Z2wwRCs4NFFWR2R1bjNZQ2VrcnhjVWp4VTBrbk9lT2hFeVV0K0dncFpxa1pE?=
 =?utf-8?B?akYrYXZJdE8vY1ZhOG9uektVVVJMTGdLcDUwbFEzUVUyMFFXc2FGakt4T3FY?=
 =?utf-8?B?K3Q3UWtSSmZjSVR0YXVmMGxnVmtHZG4wVHhEZDFuMFNJVjRHYktNZFdTdlBC?=
 =?utf-8?B?cXJWbDRESDBLNzMwV3FKQU1FVi8veEZwSFNsZndNY0NNSStZamxpck1sTFRo?=
 =?utf-8?B?TXBEbm04OHRnQjAwSVdZcHdFSG1hZzE5M3kzQll5VDZkR3Arenh0Ti9uK3I5?=
 =?utf-8?B?enAvZ01mN1o0enZrVXZ6UERvUGlpUGx0SjJXWkxEVGhjQzBuYWlNYzdXZzln?=
 =?utf-8?B?dGY2NVZldklsam52TWM2ZEdSSThNNEwwQjZhT3dkbmgyNFFEOHEyVjY1SFdS?=
 =?utf-8?B?NkFUVkdjWEs4a0RzZUt0MkNyUnM3dGRJWHVTY0Fkd3VKT1NMZFpqdmcwbGdS?=
 =?utf-8?B?MUxwWTZyQVE4NXZUbnAvSXBWWC92K2E2SVFUdkI5VEhtTytIMDkzZ0lSREZ2?=
 =?utf-8?B?WWtDNU5QczdFQmNObDE4dGk2aVN3eVd2MmdiNDNHTW5hVnpDdzZnSnJxN2h0?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feafcb1-54df-4084-4654-08db6bcbac61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:04:31.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIgWx3usvrPjKv8qsVzn6u5UM6RqOBZQcN3xy8OjciWHSTdbqqdgQ4xBd4feUEdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6247
X-Proofpoint-ORIG-GUID: 9e5S9dDCp-J9pG1a16q5qr1MoEWUch-D
X-Proofpoint-GUID: 9e5S9dDCp-J9pG1a16q5qr1MoEWUch-D
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_02,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 1:25 PM, Jiri Olsa wrote:
> On Mon, Jun 12, 2023 at 11:02:22AM -0400, Steven Rostedt wrote:
>> On Mon, 12 Jun 2023 07:49:53 -0700
>> Yonghong Song <yhs@meta.com> wrote:
>>
>>> I am actually interested in how available_filter_functions_addrs
>>> will be used. For example, bpf_program__attach_kprobe_multi_opts()
>>> can already take addresses from kallsyms. How to use
>>> available_filter_functions_addrs to facilitate kprobe_multi?
> 
> the problem is that we need to do 2 passes:
> 
>   - through available_filter_functions and find out if the function is traceable
>   - through /proc/kallsyms to get the address for traceable function
> 
> having available_filter_functions symbols together with addresses allow
> us to skip the kallsyms step
> 
> and we are ok with the address in available_filter_functions_addr not being the
> function entry, because kprobe_multi uses fprobe and that handles both entry and
> patch-site address properly

Thanks for explanation! It would be great if we can put more details in
this email into the commit message!

> 
>>> Do we need to change kernel APIs? It would be great at least we
>>> got a RFC patch to answer these questions.
>>
>> I agree, having that information would also be useful to me.
>>
>> Jiri? Andrii?
> 
> so we have 2 interfaces how to create kprobe_multi link:
> 
>    a) passing symbols to kernel
> 
>       1) user gathers symbols and need to ensure that they are
>          trace-able -> pass through available_filter_functions file
> 
>       2) kernel takes those symbols and translates them to addresses
>          through kallsyms api
> 
>       3) addresses are passed to fprobe/ftrace through:
> 
>           register_fprobe_ips
>           -> ftrace_set_filter_ips
> 
>    b) passing addresses to kernel
> 
>       1) user gathers symbols and needs to ensure that they are
>          trace-able -> pass through available_filter_functions file
> 
>       2) user takes those symbols and translates them to addresses
>         through /proc/kallsyms
> 
>       3) addresses are passed to the kernel and kernel calls:
> 
>           register_fprobe_ips
>           -> ftrace_set_filter_ips
> 
> 
> The new available_filter_functions_addrs file helps us with option b),
> because we can make 'b 1' and 'b 2' in one step - while filtering traceable
> functions, we get the address directly.
> 
> I tested the new available_filter_functions_addrs changes with some hacked
> selftest changes, you can check it in here [1].
> 
> I assume Jackie Liu will send new version of her patchset [2] based on this
> new available_filter_functions_addrs file.
> 
> I think we should have these changes coming together and add some perf
> measurements from before and after to make the benefit apparent.
> 
> jirka
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/avail_addrs&id=fecaeeaf40bae034715ab2e9a46ca1dc16371e8e
> [2] https://lore.kernel.org/bpf/20230526155026.1419390-1-liu.yun@linux.dev/#r

