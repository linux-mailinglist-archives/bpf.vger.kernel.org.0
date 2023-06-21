Return-Path: <bpf+bounces-3040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9772F738A7F
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC6281635
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0751990B;
	Wed, 21 Jun 2023 16:09:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978D18C35
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:09:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80E1996;
	Wed, 21 Jun 2023 09:09:12 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LAnAkD027210;
	Wed, 21 Jun 2023 09:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MOZXvh4cZHO+BhDu9KZqtG8g4mFib5difjlS9+/Vm30=;
 b=V7opiwgoo219RjanvMYIeYVt0MO4nRhdO8hOmvNknuRmwnyPhDRSQrw0OgFJ/E+KBFdM
 Tv2VMr3uOmCBveCnwo02AYKDM0wAMU3Of+rLhGZ/je0dCDhh3xFElwZ13Y4eZzccOI4P
 ykQqUehGOrbkweZRHdaHI83FTRJ3JD1OjIRsPBLNlKh4nJutkstk5AFlXcQgPF0knJ0n
 ic/pUk3WBUQZt2C07a+AdA9/4s3fFjgbe7UFr6NCwFdK/y+ft4cXeu+gBjIbGDNyQqd8
 NqDsjr8sN+os4hcHuns40b0GfXQmwiS3rhD/CWqPyrvm7DmlsRs6xjtTeyz7rD3IdWBq iA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rby4cjean-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 09:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRa/pEWP4KqyWM5bbEapwysKDESEw2OfvODOnPH4yZsTLFqVrBaqeknWbcMKCQg8+7Qnd+DZZwJWcV1PD7DPV9aGYerfkzp0XhohGqWwYbt1DWYfj4gdIVYT/C642tcyL07sIXGcSWG/fZE0WX8/ODINfiOBzRbFx1iG47PLDyUojmygyTelVy1EETF0yezVQJvazW7KEUWA1uysLVVeUMNB6wiN97Y7cHuQpThuIFmD2crBMyjuZyDOKoasa5R/fwvZE+W+4EJehJNtfLIAE5kmj2XojsUz1qIuBiq4V4ne3WlrqNNKA+EeC25DYT1So4YDanhy6bOH210WEuc63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOZXvh4cZHO+BhDu9KZqtG8g4mFib5difjlS9+/Vm30=;
 b=Onv3Hibv/97TWDniveg5IHHTODGSBRzZWKlUeR3oqqNPCFdTGPswsZAWzxNclISfzUq5T4Yw4VSRlaBRy1sgLbRuLzRIO06mjb0WAPXMSz6fvoNPYmK8cNasFeUnPDiyam4OM3ku5o10dFXyvhSlMqtpKkAxGUeEfPqQwHcwzasfOocO1Myk2+P6VCk/KgfHTNeL4eMHAICr0+e521sX/He2H+PYDH/FEIl3QueCaeiQaXSg01wxm9g7Y2VL0fH221KkwhTOrUXztO+c1mowHGUv7vDUdUAv22yWI5yEkHzFNarIGCMBWWkSzYt2N3d/Uuy/14zfM0yOKX3wDaVOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5745.namprd15.prod.outlook.com (2603:10b6:8:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Wed, 21 Jun
 2023 16:08:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 16:08:00 +0000
Message-ID: <f0f3fe74-0d0e-e428-e676-2eb5911bbcfb@meta.com>
Date: Wed, 21 Jun 2023 09:07:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v6 0/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: menglong8.dong@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20230619114947.1543848-1-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230619114947.1543848-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2461a33a-f3b1-4483-c604-08db7271ada7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VpKJd4XDBKOKkxKf7mzU6Z9cqjddZb4Lvr1U04aUHeSQDeD9KBffsU8HHm+CdpP71AhuCL499tN2vRkXZA886EK+oQgd5OQB42S6J56YRCxag4Ajdm1pffnU7y3vHX9oUMSMTLnFHcXTRpJuOV/9i3NdozBd8ElO6vNJCBpjWBrPWnfwQh4JPODC9bWFBbOt6emIwwQFrVCBDL/LnpM60X5oaF3qk7grdIZ5oQaUimu1rMtFp+mfdSwq0G0Uy86J9soKL69aefVNG7S1z6FHFgPVYu0QJlBXX4u+Z4QP0WW6u6bMTHcRvDv70+SQdXgQiu/aTicTHGsIX67dxnpdRUtHfoth/hltTaMDBsw+o6WQFQKm1aYm0B8xBBg66ff32Ty1FU6WplnPhjXtb9Lee08XCsWTZAbCt7SgBsAG6MSAU+dVqx/MAS1hWiU+g26tYXLfQ1DdH9sOCmOkwLCq23I2ZlL/PUsuJZMEwoUY2F0I6jHLh5/H0WfmVOhTUpxk2tbX05jQuOj/mbzqjgzKge4oPioFah1zTvv3KGOn4YD+oCgB8JgiWaeRBZmDBctBYLFY4L5aBJIfbv/We5ylKKwbYCjcKL5k0Eoe0jjD5YSOcqEq5LmRTPAITq9pjrtnSv/GDIPqR9G6qd914UJblw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(38100700002)(83380400001)(53546011)(2616005)(2906002)(6506007)(7416002)(478600001)(5660300002)(6512007)(66556008)(41300700001)(6486002)(316002)(86362001)(66476007)(66946007)(6666004)(8676002)(31696002)(4326008)(8936002)(186003)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDZvWVArS29CeXBNMzg0ZEZ5dnQ4V0NGRlBpR3ZLOG9qdUtzemp6bDNWTVNr?=
 =?utf-8?B?K1JqSzdWVjZEalR2UXRxWDdaR3U4ZlBJZlYvbXU4eVk2NlE2ZjlDNnpobjY4?=
 =?utf-8?B?dmxCa2RLcDN5b2hyT05QektKKzNwVzBOLzFWMm5jNnpaYUthWC9ReWxFLzcw?=
 =?utf-8?B?M3pZVUplVGNHTVlsZDVBUURWc1hkcmkrLzREMUVtamRxUnZIY3BURUNxejVt?=
 =?utf-8?B?U1lxUk9BbFBMUkFHZjdGY0VWQ1NWZ3UrSUFoUXg0QmVGRzF3VGs5Y0xCS1Ba?=
 =?utf-8?B?WVlHYW5LOURDUitOa1EwdVMwbVNOZWhWL0J3RjM0b2l1YUlSTWdCZHYxdThn?=
 =?utf-8?B?akQrcTQ2aTMyM3BraWl6T3pKZGJ4N29ONTR5UlUyalNnSjlXS3NqYklkWjJP?=
 =?utf-8?B?c3lYVytxVlNEQ1RRb0JhS2tFWVJuMFJQTlM1ZFRVTkNTTG51ZTJrV1BMeGsw?=
 =?utf-8?B?ZkpmcUI4YVd6NnVlQm0rbVMzQTJQZmx0VERuWEkwR1BBNEhuTTFSZVZQRnR6?=
 =?utf-8?B?Yk5oS0dPYkMxanpwVXBNUUxUZlRwWnRYc2laOUxXZWhVVXJvRFJ5cUZrN3FM?=
 =?utf-8?B?L1R3cTFCVjgyREpCQU1VT2hjMnhHZm5ya29tL1d0dXl2UUpFMFlCdUNFNmI2?=
 =?utf-8?B?LzRVTXB4NTcxRnl3SEY2Q0c5TWVnd2FVRUxyWkxoa3RYaGxVZFdxQzVuMFBr?=
 =?utf-8?B?Z0V6bXdhZzBvL0ZuYjczc1J0L1B0amJxdmhZbXI3dkYraXIydjNZenZEeTBE?=
 =?utf-8?B?K2g0MnZWWVZHZWUrUUw0a0xQeXVqWFhUOGRMek4zWENhTEVtbXZrY1JKeGp0?=
 =?utf-8?B?MmNLNTVTQUxYbFZacE4yaHpwTzduc3BtaWhMVFNORnkwWmVtZ1pxUkE3Y09H?=
 =?utf-8?B?U0NFQU5nOVZITDJaU0VadGJUb2NySjFSTnFwSndKTVZLc0NNUmdvUmpaZHJj?=
 =?utf-8?B?ZisvS04zMFpwSmZzRGpXZGpNQUVxQ2pvZEZHZGJQREZZbnFPQ2Nyc24rWjU1?=
 =?utf-8?B?aFhieXRmd0pGSXBmd1ZwREZTS1N3aGw1MHd1NlZlRkw2Vko2emI1b3lRa1VL?=
 =?utf-8?B?WklVY0xBNVVURzdyc3RlT2RzdUV6VmQ5cDZKTUZwTGQ5VWl0aEovK3RXamFj?=
 =?utf-8?B?UWZzZGpsaG1UOXBjV1E4Y0Rkakp4bTBKOTFEWkdidjB0SnRTaE1PclJOejNP?=
 =?utf-8?B?V3VqTG5DMFQ4K3dRdUlidUZmUE5Hek5SaWVjaTloYkdIamNvcmYxKzloL2hz?=
 =?utf-8?B?VkdzY0JzZU0rbXNLVjhnMlFVclI1QmZ0cVZ5OFoxNkJZQkJ1ZUszbGdrU0x3?=
 =?utf-8?B?TzR4eGcxbzlMRGQzOXE5RE9xRDFnRjhxL1Z6MFVSamJyM1FweWhrbTBpdEF0?=
 =?utf-8?B?dDhlc05STlJiNUhTU21nY0tRakJwRWdzY0tIZ3RTQmlKdkY1UE1CSFVraUNN?=
 =?utf-8?B?S3dtNjdzaFl6M045UGl0NGxYdXJ3emZ1ZXNRbitnUmNGYWxzQmI1cjBZMWhU?=
 =?utf-8?B?SUFaM3hPRGVYa0JCY0FOQ0hvSVdIV2crRVVxMmZEWHl6bWk4VEl5d05PMnJl?=
 =?utf-8?B?d2ZBNUJFZ3Fsd1AvTTh2N1ZZeEFLYW9icFV0dnFpNWc1dDlqc1NNNE8zVm5w?=
 =?utf-8?B?WVp4YUJkNjlGV0dzQTh0aU0yTEFoRTBBNEZ2cThteE5GSXFlS0M0SEo4VC9k?=
 =?utf-8?B?UWYxK3RHZGd6eVFmNVN3ZHhOUzlpODJmRlJ4QmFuTlgxbHJZbzUxRGU0ZXF3?=
 =?utf-8?B?MnNKdmEwSVcvZWNZMk56K1luVWMyMTlIcFdEenJSeDZFcXdlWDF4cVRHQk85?=
 =?utf-8?B?LzFyY3pLVmJCLzdRaGhHQU5pMDd0b3lTQndCUkExbCtJZGxJNGgrQjkrOHJV?=
 =?utf-8?B?WlZkbEpub3paQmZiWm5iYzR0OGhQVHlSVC96bEl5c2pZeXkzbUEyendDcnFF?=
 =?utf-8?B?ajF2cUE0OGMydkNFR0JUazFWdFJ3YmtuRE80SXYzVUpSa1RuKzA4N0FOZk05?=
 =?utf-8?B?WUhiSWR5UFFvQWRFRUxpcUp2R1ZmQnd6SFlYL0dQSUU4VGpqWVZLbk1lL2pZ?=
 =?utf-8?B?STZtTnhpSFFYQVcvRTdYaVhOOFgxczZFb1FBUUQ4SG4yU3dZUHBYWjN4bncr?=
 =?utf-8?B?Y1BhTnNXWHkzVDMzUTQ5M25sanFSTTduVDE3UUJ6MDU1OFVoWDc5MGxoOTIr?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461a33a-f3b1-4483-c604-08db7271ada7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:08:00.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPuyM844R+hF5X4vg/fwoMAK3zfBgjpjU65QvC17aaCe0A4khUdr408AGVJP+Q08
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5745
X-Proofpoint-GUID: yt3s_hKvtT1OuFWsqBvP3q76aDAu6qs6
X-Proofpoint-ORIG-GUID: yt3s_hKvtT1OuFWsqBvP3q76aDAu6qs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_09,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/19/23 4:49 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not

less than or equal to 6, if not considering '> 8 bytes'
struct arguments.

> friendly at all, as too many functions have arguments count more than 6.
> According to the current kernel version, below is a statistics of the
> function arguments count:
> 
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
> 
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> 
> In the 1st patch, we save/restore regs with BPF_DW size to make the code
> in save_regs()/restore_regs() simpler.
> 
> In the 2nd patch, we make arch_prepare_bpf_trampoline() support to copy
> function arguments in stack for x86 arch. Therefore, the maximum
> arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT.

for FENTRY, FEXIT and MODIFY_RETURN.

  Meanwhile,
> we clean the potentian garbage value when we copy the arguments on-stack.

potentian -> potential

> 
> And the 3rd patches are for the testcases of the this series.

the 3rd patch is ...

> 
> Changes since v5:
> - adjust the commit log of the 1st patch, avoiding confusing people that
>    bugs exist in current code
> - introduce get_nr_regs() to get the space that used to pass args on
>    stack correct in the 2nd patch
> - add testcases to tracing_struct.c instead of fentry_test.c and
>    fexit_test.c
> 
> Changes since v4:
> - consider the case of the struct in arguments can't be hold by regs
> - add comment for some code
> - add testcases for MODIFY_RETURN
> - rebase to the latest
> 
> Changes since v3:
> - try make the stack pointer 16-byte aligned. Not sure if I'm right :)
> - introduce clean_garbage() to clean the grabage when argument count is 7
> - use different data type in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> 
> Changes since v2:
> - keep MAX_BPF_FUNC_ARGS still
> - clean garbage value in upper bytes in the 2nd patch
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>    bpf_testmod_fentry_test{7,12} meanwhile in the 3rd patch
> 
> Changes since v1:
> - change the maximun function arguments to 14 from 12
> - add testcases (Jiri Olsa)
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> 
> Menglong Dong (3):
>    bpf, x86: save/restore regs with BPF_DW size
>    bpf, x86: allow function arguments up to 12 for TRACING
>    selftests/bpf: add testcase for TRACING with 6+ arguments
> 
>   arch/x86/net/bpf_jit_comp.c                   | 249 +++++++++++++++---
>   net/bpf/test_run.c                            |  23 +-
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 +++-
>   .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
>   .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
>   .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
>   .../selftests/bpf/prog_tests/modify_return.c  |  20 +-
>   .../selftests/bpf/prog_tests/tracing_struct.c |  19 ++
>   .../testing/selftests/bpf/progs/fentry_test.c |  32 +++
>   .../testing/selftests/bpf/progs/fexit_test.c  |  33 +++
>   .../selftests/bpf/progs/modify_return.c       |  40 +++
>   .../selftests/bpf/progs/tracing_struct.c      |  48 ++++
>   12 files changed, 471 insertions(+), 50 deletions(-)
> 

