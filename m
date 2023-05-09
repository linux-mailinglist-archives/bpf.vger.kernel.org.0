Return-Path: <bpf+bounces-243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5556FC7F2
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D791F1C20B74
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCF182D1;
	Tue,  9 May 2023 13:33:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACE6116
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 13:33:19 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FDE6D
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 06:33:11 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 349DDW7f032037;
	Tue, 9 May 2023 06:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=DTI08bLka0CHV3QTDty8vVttyfMJ1dvabU3Hpbp0+xY=;
 b=c79R4BhRFbwSYNnODid+AuehkS+iFN9FLHK6KVAXNVhlsnGa6tvpyyK1RflRk9MWM2G0
 IeWEiY7h1i1jZR/V6U4A446NCdEfPov8h0Cc/2KokiYyh6259pOFDQVob+MMxK9T9rd/
 hGExxfJoP3TdoMlUD5nM0NVvtGw+4P41AWDbsHWsz4E4KdE0Fpnq6g4n6oSWMTHgeuUX
 rArm8L4vYEhuNq7AzIPsZLaclmkdITSYVpe8JZGytxEarQE5ip4SDjDZcYDYdmRoi5hz
 cc12UGrw7081tdBnhs7pwEU+Ho/x/H6gdSCaCY5rSdLEgtpvFjH9gtQBl/4H9eA+ruu+ JQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qf7a2wfan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 May 2023 06:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV8dokfmDsfzI29rqWdxc+/rSbPXcG/MQ9ZyMv/CtsbZ8ujqvWCqIlRlk5e+TRiBrUammvHD+B424HU5nFJiXGihvw7ACNZZphlIAUUFpg/0f8nhgAR+Z/lbol/rxBWlg812lAqwuWZjyopfq8mYVVlRbtHWl+q82cxj6tYeipcZ/2u5PVYHt9ro/OPC7ovpxfWf4s40P5XphlRo0zy6KGzLDfn9foM34CpzJ9Or8QqlC89rOAGUNGrJIVRsxrGGhxpZWGs0L6frigNP0I+XDpLpf+IYo0yvlRENCHwSHFPAaJcvUI1CZcJCTF/pVOOObYw0sKhLICJOBRbY3jtLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTI08bLka0CHV3QTDty8vVttyfMJ1dvabU3Hpbp0+xY=;
 b=PdWnn0rJ/y4SQVv1GIKDOIBt5As8hK9Zwaslf2M97ITnyR2zRINTcucVth3bk5bmvkmuhPIamUbXAnQoFEWkAvMXhaIDtpF/XwqspHL/N1DA8qfMaFq8mpdneKNyKoOD2V/NNKCxxmMVCfuW7PHFKHXUSbN4HNsYaxWJRsdFsMkGMY7b6Uf9oC9WkpWQYe+tb9UFd7u/FSfiI/YNyUqJgP96WlJztMp3a1SEx8ZkqREJVXfpDwDGNArx78Pm1y1YavLmQjjb/5OeTV1XwVqozgCdcw7jXOqySQ5k7U3QiwcuSAY5KAi+Vh9TZrZzbDOAy4/NHZl57zPBHBxq1TY0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3974.namprd15.prod.outlook.com (2603:10b6:5:2b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:32:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:32:32 +0000
Message-ID: <2ce2dbb1-20d5-cd4d-9e84-97d505b57bb5@meta.com>
Date: Tue, 9 May 2023 06:32:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] libbpf: fix offsetof() and container_of() to
 work with CO-RE
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Lennart Poettering <lennart@poettering.net>
References: <20230509065502.2306180-1-andrii@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230509065502.2306180-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3974:EE_
X-MS-Office365-Filtering-Correlation-Id: 651488ed-9ed8-4807-840f-08db5091d7bc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o/YZ0UPG5R4IPtsTxRl6ZOvkeLwiG40LsqTFjtHsctdHjtbuRInFr7oLF3248Sqi0FxkQ+3LcujK6aKdD9Un/WN9+U1rUqJGgzczfvEGps8Wkmb07XBRUvbpC3MYhVfWWKI14bIgCK6yCPY54NkzkgTvU01opio+WqatCDoGtjdN2AkytDyW0+b9/zvwHolCxL2/GjSbl+gMi1K9TW1oc+E0po/63JvOaxKx60fTDuckblzcYbwST+i5ib5Q8Nxv6J4Lu4zLBOoznK+IFq84OuxJ4Xd9rgx9UKsq4C0DrFTB1IhR9Jzaww9MgOtBRXGvt+fxPCKD48nvPCzlMMr7YVgFfylPh9VveDIFgHWefJDGV+C4pUCT8+5PehVO4SOOB4mlAEiUUZRoNJpHHHdQaGWpCximlc6kti9eNlMxtcgyuTXIbu1F87TwkrGPgl+BsE2g9W0y0idiwnBbDgyRZMsX2V125k2cnw3Shoui+QgrOPG1Oz7Xii8vwGteM7EOLumAL3la7/QP8T+M9ihrHRLE9fAoOzNfw0qyaKvqzOa0QkPLaZ1fvVmcjXLhFaPPf5eqJg1oNkBqdVGBxk8u0oHyDkVl3mNxbLZ8wCuFpCF67R8xROrp1UF1SzW030p6wuZoJckh7h0p1TXgQNmJYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(2906002)(2616005)(86362001)(83380400001)(186003)(4326008)(41300700001)(36756003)(66946007)(66476007)(66556008)(6506007)(6512007)(53546011)(31686004)(31696002)(5660300002)(6486002)(38100700002)(6666004)(316002)(8936002)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2VTWnRzZmZjRUhEWTZKbDJvenlPeTA4bDdkVVlLZFhTOFNVTHpFMGJLelpk?=
 =?utf-8?B?OHRYRThPUEFUeFJoVXZFOWJsZlZpbGE0ZktGS1BUSHJmWlE0NThoeUZXcnEy?=
 =?utf-8?B?bVZLMUt3ZmJoTXV5d2FXc2JrdjdqSjZEZVU4cE1zbFpTamJmVmo3bFRpVjNP?=
 =?utf-8?B?VlRaVnF5Qm52TFEyMCtZMUdWMG43NVk4dWxYYkg3em5yZCtjbHJIT3AveVQv?=
 =?utf-8?B?cnpNN2p2eWF4NVAybWRoZkk1VDBlaFhPbHNicE8vZHBwcHY0UTVCaFFpbFlP?=
 =?utf-8?B?bjYyWG96RVhESWhHMHZhTFdzVmlxeFQrRVhqVVNqK1VmNVZVL043VDNDWENO?=
 =?utf-8?B?ci9OL3ZUaUpNYklxVjdsTGJGeHVJYlBqQVB5Y0E0RU05R0pUbGk4a2x6K1RM?=
 =?utf-8?B?NjVyVGxKZGVwbnBqUVNLQks5NHZoMTBjckV4QWJ1cjRFRlpGd1dNN0VFY2Q4?=
 =?utf-8?B?ejZqN2svL1lmSHFOUzRLTzFMTUpiaTZIMlpXckxxVm1uQzNxK1pTbkg1eFBQ?=
 =?utf-8?B?T2Zwd3RLUG1uRVh1ZE90NGZBaFJONVlQVE0vZEJvdHUzUnJuSWVIS0RqdDlK?=
 =?utf-8?B?L0ZnVjRxang4MlhOR2FHbVRtN3R0cXdzY0hyVlVueHladVprc2dhbmhZNzZw?=
 =?utf-8?B?bW9YbU9LeEVEREhPNTdyckgwN3E3YTNua3lxUEV6UFRRb3NkaUJGT0dURXU5?=
 =?utf-8?B?bEYrZTA1ZmE2QkhMaWlxNlJpMUtVckFncUVVOGpzMU1JaU5yajNxbTFHaU1t?=
 =?utf-8?B?eDlrU29FMk9GRDc3NnhMMisxK0lrVDR0bU5QU2dMNm1VUVdDWkpMKzRpQ2gr?=
 =?utf-8?B?WnJ5d29VZUFvU3BDR3QrbEVMT1FVUEhHUVpQbWRuOUo4QTVvcWtDSVBJMFVV?=
 =?utf-8?B?RHVBK3FBMTZHcFZOanZJSG10ZkozZndVc3NtKzNzQUY0MTVwM0tBNWloWlpy?=
 =?utf-8?B?NDFqUEJTeW45ZU9BMW9tRVFTcnF3ZDhhOHpEalRyV1JoVWx6WlBEdTdlQkZJ?=
 =?utf-8?B?dkJ3NDcybThsM05ZengrNG1VZ1JrZ3haMmdFeURVRkc3bVZpK1VBNGlncEtv?=
 =?utf-8?B?OStEOUdDNHU3R0M5RThaa25ZQTk5UFcyYkQrMUUwQlRpL2ZyMVV1ZzBpSThq?=
 =?utf-8?B?aExhS3pEREVyTHVXUFJYV2NtcFZQY04zWEQ0RlZObW0zNXQ0UVZOVmZtLzNC?=
 =?utf-8?B?S1lIOGs1NnU3N2h1U29vWnFzL3E3L0dmTDZ2MFkzSTJyMUhLZHc2ODM1ZVRB?=
 =?utf-8?B?OEg2MFo0WURaQThwVFV5d1JOWVV0UVB6Qk14NGZOVHdOZ09lM0tTZGJWWmty?=
 =?utf-8?B?MTUwSWNlRVZOMzc5SUJFN2xDT3JkNVQvclNzTk9NUVNYdzBsRCtHL052U1A3?=
 =?utf-8?B?N0NMZHYzNVhiSmVlZ2duSTE0Z1FDR0FLdnJpc0pZekx0WDJhdTNpZW95Mnp1?=
 =?utf-8?B?VndyVEFvcmh3Z0VzUjVzNFdRTDdGNjkzUUNBVlBUSkYwcCtpZklwbWFuWERr?=
 =?utf-8?B?UU5nU0ZHb1NtT2c3U1RWRklKU09XTHFub3Z0QUUwRmVKRnEyVC9FSUdpLytz?=
 =?utf-8?B?QXJtdURmdWxpRmVHMVdTQjI1eE8vVTF3cEk1d2k5UHdsZy96a1JPSFo4cWE2?=
 =?utf-8?B?WkFSK3dHa09QeWViTHY5UVA2Tk90OGM5cWt6SXBYM1JIcmFvdG5VYjZZV3FC?=
 =?utf-8?B?Zjc4K24vWDRoS2U0RXdXalpXclRGdllGV0FhaGlhTVNyWXIydmszblZod0Qr?=
 =?utf-8?B?MFpKb1lNcUZVRTZiL0o4dnZvVGlBUGl1QlppQlhPSUdFdC9Zd0crOGpFc0JD?=
 =?utf-8?B?cHIvUmNnWmJ6M2ZJMnZLdmthNmg1K2ZVZ01Rc0Q3Z25EdEwxR3labnJDZmVa?=
 =?utf-8?B?Y1phaGVLVlJIZGJjMUtGazRpYURYaXFVRldtQVlKYlNlbzhhdlVLRk1xU0Rs?=
 =?utf-8?B?S05IdnVxaE9GcXNVWnVlRW9LTSs5RmZSRGRvaDg2Zk4vVzFrOVdDZ3FBblJD?=
 =?utf-8?B?alk2OUVpUGRsSDRhbFo2eWgrTVZkZitsY3hET3dBN1RRaVRxRlhUempCSy9W?=
 =?utf-8?B?MUdpY3lrdlozUHFCdXd6VVUxSjBETjhrUXlieVdqYUhVUWZrd2lZcUFjS1Fl?=
 =?utf-8?B?ZlJXL1FtOXJYWVAvMGFITVJvSGxjRHFTZ2tnVW5WMzZESGJVUzFmUHpGVmZ0?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651488ed-9ed8-4807-840f-08db5091d7bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:32:32.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erAuF5UYYpSQN3ySsWgoQEjakGR4CJZ/F3+2yK3ElI67Dq4roS/+lafj+KDyVdSt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3974
X-Proofpoint-ORIG-GUID: vazpXUtsxPr-OKGXyeqCuCDG9ZYcxGRD
X-Proofpoint-GUID: vazpXUtsxPr-OKGXyeqCuCDG9ZYcxGRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/8/23 11:55 PM, Andrii Nakryiko wrote:
> It seems like __builtin_offset() doesn't preserve CO-RE field
> relocations properly. So if offsetof() macro is defined through
> __builtin_offset(), CO-RE-enabled BPF code using container_of() will be
> subtly and silently broken.

This is true. See 63fe3fd393dc("libbpf: Do not use __builtin_offsetof 
for offsetof"). At some point, we used __builtin_offset() and found
CO-RE relocation won't work, so the above commit switched back to
use ((unsigned long)&((TYPE *)0)->MEMBER).

> 
> To avoid this problem, redefine offsetof() and container_of() in the
> form that works with CO-RE relocations more reliably.

I am okay with the change to forcefully define offsetof() and
container_of() since this is critical for correct CO-RE
relocations.

> 
> Fixes: 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro in bpf_helpers.h")
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Ack with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/bpf_helpers.h | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 929a3baca8ef..bbab9ad9dc5a 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -77,16 +77,21 @@
>   /*
>    * Helper macros to manipulate data structures
>    */
> -#ifndef offsetof
> -#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
> -#endif
> -#ifndef container_of
> +
> +/* offsetof() definition that uses __builtin_offset() might not preserve field
> + * offset CO-RE relocation properly, so force-redefine offsetof() using
> + * old-school approach which works with CO-RE correctly
> + */
> +#undef offsetof

I am not sure whether the above 'undef' is good or bad. In my opinion,
I would just remove the above 'undef'. If user defines
offset as __builtin_offset, the compiler will issue a warning
and user should remove that macro or undef them.

Otherwise, user may get impression that their __builtin_offset
is working but actually it is not. the same for container_of.

> +#define offsetof(type, member)	((unsigned long)&((type *)0)->member)
> +
> +/* redefined container_of() to ensure we use the above offsetof() macro */
> +#undef container_of
>   #define container_of(ptr, type, member)				\
>   	({							\
>   		void *__mptr = (void *)(ptr);			\
>   		((type *)(__mptr - offsetof(type, member)));	\
>   	})
> -#endif
>   
>   /*
>    * Compiler (optimization) barrier.

