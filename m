Return-Path: <bpf+bounces-2296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FFA72A8BB
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4863D281A62
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F75383;
	Sat, 10 Jun 2023 03:21:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8C1878
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:21:04 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1F3A91;
	Fri,  9 Jun 2023 20:21:03 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359KLcH5020541;
	Fri, 9 Jun 2023 20:20:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=wsDA7mmWwkcCq8giUSmoV6+hsyKqga8Opcd2XapAvmE=;
 b=nigBs/Pyk2MT3g2phmOHRHjfuo3B1S0DvHMv7Gycgv970rBBrr0p+1HB5bCGz1GyuagA
 4Me3UIaZO2Npo8fyM94jZ4wBf5gVRFR+eXYkC48GeFP6fzKWWUMFBQa92SdUvU9J3+6n
 EUZxykenkn4a3hcdfne4aYLieFvhRht8J+W9e1PtKERXAXeyw/r7ZFq3afVig8qyoeIp
 6p4tBgM+J5Yfkx2tV/zO1vK4fzvM9IFbMd9MX9WHXA5+GavGTijQmj08RqpapCVmTSTX
 SrIWDOdZJ2oTF1IREP1DVXXvgzwEgZmh02YoMW2GHsefzo0DFhUB9fkHFiLCNLA/dOkr YQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r4b1uj4sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 20:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX9j/hJQ1+KizGNTYXQYZNzZ7bT4UJ8xYcQTEmlPbJRYQZEJMFv/w4PJEBYJke/xlXoshH4l2ouJimDmbSs5pBoGs3OrGt3M06Q/LHXFd6jYpzy4xsD3jC6kQQLXguLrdLYPwGEIuaXppUxtVYfnpYcKmiLVx6M/kiEhyMbxB0mzlt6Kym3r5zqu9XYEdz/uWLMNhCHDk3LGT6kPkusRvt2zmv+6ov61jSgalyhvpmwJirJk7v6I+OD7OmOnaavH+TUBO8mL6EF5y+MD93SOnx9G9kdFnMKH1Thh1UwINluyIMXotHI8EaVvFzXmPYETHsSJF7XMz812fO2ZMGh/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsDA7mmWwkcCq8giUSmoV6+hsyKqga8Opcd2XapAvmE=;
 b=FrP2+seY2PgHT8pmsyVv7Hz6tNCtrTWJd9SbGSQ/r+t4UZOgQ5mYTko9qbq3vjolYOXaIYCuso23fR17rf3I6rb6IDnxNEPrqP0v87EUdStcoi2BSlvIurKpU0Ez3P0JgsqVoUGiOubUz04tmHl43y7QgjAsIV7Kt2sVb+Lv/Tc5Oecb8ZJJrtNJhxFCdWTMjeUwN0sfqJQxwq1X3PhzgqNdOsdDNx0outafoONC9+gNdV51QnBMfwnBmgH9qWhoWvaRdkL3/FsZL6jvEjzfy5hFCht3Hj4hEqUMApvBdI0bs7wsiE58F9RjvkQDpxGBCWnDKOwErGnfY6861mRedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4149.namprd15.prod.outlook.com (2603:10b6:510:2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Sat, 10 Jun
 2023 03:20:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:20:13 +0000
Message-ID: <6c195897-e2c5-f0b8-45b4-83a0e9b71bf8@meta.com>
Date: Fri, 9 Jun 2023 20:20:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v4 2/3] bpf, x86: clean garbage value in the
 stack of trampoline
Content-Language: en-US
To: menglong8.dong@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-3-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230609095653.1406173-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: e853acfc-e893-4983-5de8-08db69619ad5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/K4cEYc/icCx2D7mFPo4oIOF8wBrDVwGRup+3rfjT81FpbdpTeRm1a76NMBzTivSqk5ZHcbFScSuXaOiCMOovDtO66jvreHrbvTE8EOE8YvoG8SMmQVrDpQOGj4OqR9kt0kHAC7vm1QlDq+vdxJmG/0PZJpU4fMK7UwSeDryGwAkhmSex3ZUYLhCc/VZXSCxgpibj96BreaX6UkNBNRDVcx0r16ECkKLybvtnAan9++/Hoc6hF+ulVhRcaprYoSSYxzjV7PJV92WLFz/Se8uF5HdKmXQa8ueTAgpnEbUA7t30LehAkfZZjFkDW3YAL+O3ja2tWfcjw8iw1uqES2xObTPrVqoFXVb5LIbxeYjbiaIheZx0XFcPAm0oTmrEVtOfkSVss6+cjnrNuhhNNrHgdciWEJgm1Snk+7Aj0kGGsxFFHueADggkEOJwlwyiaG6hx0r7yQ02tJyOyhvHO9RNO7o6x0GvLvWgnm/I8NCblw7fdNtxNhc9SSL2kKmv9iobL4mIP08jay4HF7bBTHlr7DVa+fWqeZUomdtRQbZDr3hXQ81C/OtcWBg7VI9Yy/h7YE4Hb5uiV/LQIG9s7QV8kDc+Z4abD7cYl6bMd4XD5ESg/YqzJmPSnG1dIehMAC8whU5w7WxaZpYykQSEYHnuA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(66476007)(66556008)(66946007)(478600001)(8676002)(8936002)(36756003)(5660300002)(31686004)(4326008)(6666004)(316002)(41300700001)(6486002)(38100700002)(6512007)(6506007)(7416002)(86362001)(2616005)(31696002)(53546011)(186003)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUlxYnoyUURsbXF2OTA2QWVYQzZWejJseEMxSGNtSDNJbERMakdLbnd0R2cz?=
 =?utf-8?B?Um1CODFFL1VFNE1yelVzZW9HOXFrVi9uV1BoQ0pOa2lUZWgrQXo1ekphLzcr?=
 =?utf-8?B?cVpSOWRlS0FCbFFDRHRocnNTK2FHNmFCVWlxZHJzanBJSXhETEROQnpjUEQ2?=
 =?utf-8?B?RnJCcWIxTU5tSS96ZTFkVkFpR3lPWkVURUtKYkJaRWRBUHp0RzRNeEpwS1FV?=
 =?utf-8?B?SklFcDladHArVTMzZ1kzdy9McElleVBWeXhBU1RZZXRSQjJvd3hhSmpHS3Vy?=
 =?utf-8?B?S1ZWYzVhU2E4YjVBVWM1Vll2d1EvZW9KaEFRWVZDU3p5Z2VYcXBzMWs4VFBq?=
 =?utf-8?B?VzFXOFR3M21PL1hiZEpkN1R4NDNGRm1pRDhHcGFObEZpVGk0WWFrSy9iN1Fq?=
 =?utf-8?B?N0JGTTF2T0E3NW5acjh1Ryt0ZlhkbXJVY2VjWXJ1bzNsMm55QUp3N0FNSmJN?=
 =?utf-8?B?MHZZK2QvTllRWjVoTHNYeVFJcVBOMU5NVGp5T3N6TEhGbDBXZi9FV21yNHN4?=
 =?utf-8?B?anFWUmNESStZNW0yaHZtRXdOaHlIb1g4b3JCQ01kaExKSFQzNnBoNXZxaU84?=
 =?utf-8?B?V1p6MFlvQVRtbnliNDJFRUlmN2dheXZtY1BLeGVnUTQyWkM0T2UwOW1QelVt?=
 =?utf-8?B?UU5ELzUwMGNOdytzdTJNWHc1TW1yc0xNMDFZa1ZiYnRtUVhHRFR2MDJvUDky?=
 =?utf-8?B?dENrb3NMaldPcXRKMVg1NGtUSUlaWWxYdStnYjMxT2NZNG9uaUUzS1VqbjNP?=
 =?utf-8?B?WFpHMjR1M2J5SWJ2b3paaGpYU3R5Ni9JZGxkV3d1bktLUnhNUll1Z0JTRTBn?=
 =?utf-8?B?dXV5YS83Z0cxZDF0dWZZRHVESnRFS2hZUnpiWkJFM1hWT3ZnQXg3UHcyMFpL?=
 =?utf-8?B?QndoSEZMUzg2Z2Y0SGNvTzQxdzQwUUZFR1NFb1RXMkVmOWp0VENqemlJWDQr?=
 =?utf-8?B?eHhmbXlYSU15cWRFUjYwMVd5R2VKalBSRi93Ukc3MG1SWjNzTkx0alNmclNC?=
 =?utf-8?B?WXFobHVKL2xhUE9sZXhKV1Y5QXlBNXNTTGZuaks1THE4WlY5ZW9MM25hUmph?=
 =?utf-8?B?VUd0QVNqMXJVZlgwd0tLNWh4SUZDNU1FSG4zbGZXSk11Rm1JVzRveWZkTkFh?=
 =?utf-8?B?RkkyRUdDZ2dzZ1J3TURiZ1dMR0FQWGJLTVhXWlRQdE55akN5bmFMWCt4dFBu?=
 =?utf-8?B?YmVubHVOV0czYVBRRzlmSVg2VVlJSG9DZ3UxRWhxRlFEWTNUdGUzQklDUzNm?=
 =?utf-8?B?VjFlL0dvUlMvTk9BMzNzbWJ0Y090bXNYb2djeVU1T3dxZkdLSW01ODJqWnlB?=
 =?utf-8?B?dUF5dWptWkFVbXhndWVuajd0OFQ5TWhtZ2MwbFVFK2VvWi9nSno0Sms0TStl?=
 =?utf-8?B?dUFWTk0vbi81YzVEZTZJMFhoL1F5ZVUwZ2lvZHR0OUJjdDl0R1NNSTdxOXhP?=
 =?utf-8?B?Qk1DaWl4TE4xQkFHWEZETzg1MkNDcmFTNUNoUk9JMGFDL1NWVkpXYkYvSGUy?=
 =?utf-8?B?b0FVSi9oSThBYmJqR1lFeFFiWWxBMHp2L2k1TWcxS05Qa2RwWDdXZyt2bmNm?=
 =?utf-8?B?Sjl0aDFnZGdtNHV5VWNyMTlXVTFuT3A0NElUcGJvcDRHWmEyWit1bUExdEhS?=
 =?utf-8?B?ZGhFcHZkb01NMkw3Mm5SWkROR00xbjEweXUwT2hTWWdJUWZrOC9hbTNlaTNx?=
 =?utf-8?B?Y2lURENiSkdjM2FETVBIR2FwazFManpUa3NCMzNFalpnOGRLbUlDcDhVQ21i?=
 =?utf-8?B?RERLc1l0K0dXOUVaclpDK1dvaWZ1aU5lRjNTd2JoQmZBbk1FblBwSDhGZ0FO?=
 =?utf-8?B?ZWxZSmFFbEcwTGsrdFc3ZVlrb2VySXhTaEg2ZDlDTG4wcmcrVFBUZ1RYY0xH?=
 =?utf-8?B?cmlSRTM5UDNPaUpUdk9Ccy9wTEIwV3JRSGx4dFllNGRnb0lJeTNWMHRPdXow?=
 =?utf-8?B?WVRCenh1ZTFheENFbmJ3NGZKK2lWUXFyTFRPYkRKd293Y2xsOHU4VW8vc0hs?=
 =?utf-8?B?b0Fqa0FIV0g0V2x2bTNkOC9oZmpkTTg2UWU5UTFtNTNlOVAyU05KekV0b2Vt?=
 =?utf-8?B?V1F5eGhaVy85eU85c1dTL0FYQnRzOTIxMm9lK1pZbVBHK01ycUJKSmx3RWo5?=
 =?utf-8?B?dXlaN0hEa0RGNVZFTXlEWEkvMzMwL0lYeUV1WnpqMUs2WnRBaFlFWk93a3dW?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e853acfc-e893-4983-5de8-08db69619ad5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:20:13.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsZwm5s/bnmTOhmV/sLjnRtgiKkqj8bK6CfvNMDY2jhBPKaIYb2pzijfP/9MN4f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4149
X-Proofpoint-ORIG-GUID: Rd89957PtYcSU-wSmLO698quPRovYBd6
X-Proofpoint-GUID: Rd89957PtYcSU-wSmLO698quPRovYBd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_18,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> There are garbage values in upper bytes when we store the arguments
> into stack in save_regs() if the size of the argument less then 8.
> 
> As we already reserve 8 byte for the arguments in regs and stack,
> it is ok to store/restore the regs in BPF_DW size. Then, the garbage
> values in upper bytes will be cleaned.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v4:
> - clean grabage value when argument count is 7
> ---
>   arch/x86/net/bpf_jit_comp.c | 45 ++++++++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a767e13c8c85..f6f51a5d14db 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1857,6 +1857,28 @@ st:			if (is_imm8(insn->off))
>   	return proglen;
>   }
>   
> +static inline void clean_garbage(u8 **pprog, int nr_regs, int stack_size,
> +				 int arg_size)
> +{
> +	u8 *prog;
> +
> +	/* clean potential garbage values in upper 32-bit. 'stack_size'
> +	 * here is the offset of the 7th argument on-stack.

Here, we have a huge assumption that if only 7 registers, compiler might
just allocate a 8-byte stack space and write the value to it. If the
type of the value is <= 32bit, a 32bit store will be on the stack.
So in this case, the upper 32bit needs to be cleared.
If the number of arguments (in terms of number of registers) is more 
than 7, the extra arguments will be 'pushed' to the stack, so there
is no garbage. This could be true. But please add enough details
here so people knows why we special case this particular instance.

> +	 */
> +	if (nr_regs == 7 && arg_size <= 4) {
> +		int off = -(stack_size - 4);
> +
> +		prog = *pprog;
> +		/* mov DWORD PTR [rbp + off], 0 */
> +		if (!is_imm8(off))
> +			EMIT2_off32(0xC7, 0x85, off);
> +		else
> +			EMIT3(0xC7, 0x45, off);
> +		EMIT(0, 4);
> +		*pprog = prog;
> +	}
> +}
> +
>   static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   		      int stack_size)
>   {
> @@ -1878,8 +1900,7 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   
>   		if (i <= 5) {
>   			/* copy function arguments from regs into stack */
> -			emit_stx(prog, bytes_to_bpf_size(arg_size),
> -				 BPF_REG_FP,
> +			emit_stx(prog, BPF_DW, BPF_REG_FP,
>   				 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>   				 -(stack_size - i * 8));
>   		} else {
> @@ -1893,17 +1914,16 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   			 *   8(return addr of the caller)
>   			 * which means: rbp + 24
>   			 */
> -			emit_ldx(prog, bytes_to_bpf_size(arg_size),
> -				 BPF_REG_0, BPF_REG_FP,
> +			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
>   				 (i - 6) * 8 + 0x18);
> -			emit_stx(prog, bytes_to_bpf_size(arg_size),
> -				 BPF_REG_FP,
> -				 BPF_REG_0,
> +			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
>   				 -(stack_size - i * 8));
>   		}
>   
>   		j = next_same_struct ? j : j + 1;
>   	}
> +
> +	clean_garbage(prog, nr_regs, stack_size - 6 * 8, arg_size);
>   }
>   
>   static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
> @@ -1925,7 +1945,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   			next_same_struct = !next_same_struct;
>   		}
>   
> -		emit_ldx(prog, bytes_to_bpf_size(arg_size),
> +		emit_ldx(prog, BPF_DW,
>   			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>   			 BPF_REG_FP,
>   			 -(stack_size - i * 8));
> @@ -1956,17 +1976,16 @@ static void prepare_origin_stack(const struct btf_func_model *m, u8 **prog,
>   		}
>   
>   		if (i > 5) {
> -			emit_ldx(prog, bytes_to_bpf_size(arg_size),
> -				 BPF_REG_0, BPF_REG_FP,
> +			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
>   				 (i - 6) * 8 + 0x18);
> -			emit_stx(prog, bytes_to_bpf_size(arg_size),
> -				 BPF_REG_FP,
> -				 BPF_REG_0,
> +			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
>   				 -(stack_size - (i - 6) * 8));
>   		}
>   
>   		j = next_same_struct ? j : j + 1;
>   	}
> +
> +	clean_garbage(prog, nr_regs, stack_size, arg_size);
>   }
>   
>   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,

