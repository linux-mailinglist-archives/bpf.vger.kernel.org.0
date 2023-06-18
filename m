Return-Path: <bpf+bounces-2819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD4734932
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 00:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52133280FD7
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0919BE46;
	Sun, 18 Jun 2023 22:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6256AD54
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 22:53:07 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0631BB;
	Sun, 18 Jun 2023 15:53:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35IMKKUd007655;
	Sun, 18 Jun 2023 15:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=U52w7Duulz2+oZvCeWQJjJh7Dt3dM0299maQbomdyNQ=;
 b=UjdrVeTseRoak/qdRoc5/RNSighp5RPMLW7NWzoJEUD6vAJ2O/pFeQqE6capau4uqhAu
 LJYfs1OADxj3iAs7B8XSdcqVhJW0ytLIErV4hRdPwCd1XQf5w5AelcHjhJFWu/YmB0vJ
 UhfvLhhAw0+clOrZanGqxTWPvbzwZF5tfNIrLYLT5n25WX5ujc8kA/Dc0FzNQHuPoeRd
 xnVKkjgmpsRS5Zk+Xj7+R6nPjEq4UACfZNegI0C/sT0CjzlpEBYjDkGTwMnEhdFa1NIk
 Zz7nJHL7clWFVof4lqGHrPBhRoDrCKknUHDtzTnhYEgqq4ljaxWM8CVoz/20GLwvxMCY vg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r9ac302ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jun 2023 15:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiBY/4ACtDqPpFIocI3mE17deZNaE55F/HPntFvJfL0bsLSjZzEGkJp0R0TkdLqegiv+52ORQtD6YJCIy8sdg2NcLLXH72a26WWYXKID1JOsBMYjmQ/Ys0YqV2e0Cfh65ugnQ0EQKBIGiLtfsemxk3wBD7zNvnGkNHyKuHsLfhOUjGzIbO/GccqqUP3kVYopQSy/9JxhtD9olfNOrmjw0FMtD25/su6rNSEQEQSlaf1TQMVgnF+p6Ep2stNzNEATpyBW4Jy6eCv/Ds80uGuO1fFUesym93jAPxR4coD9R/5kvPQKaXeGlH7+ZUzraALMHdu0yqPpVzGsKWW941rzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U52w7Duulz2+oZvCeWQJjJh7Dt3dM0299maQbomdyNQ=;
 b=aMBSvGKJqZ/rMr82OYulpOHXQyE6I2p/32E9b7LOFm/4M9VZQ0q9dHUqylrhKNmK7Tte0KDbxRELOiACWF5xQSGP+iSL4n1ZOj7YarSg7iaICaIOYdUNHnWVA6aRKYZJkNs7UrzT1r5hJZ3+ZnnyK5CQ/sF6JaCjFSPZPjvkMdUbrNL1VkRsSQnmRfsfdQi2ShilSmvj1RuXxhD45J/SIP7KW5hZpPB29Sf0pDZZl6U5LvNrkKC7SlkVgX0uj2w26P6scXLBKCVuY1KSnqqWSIp9YRlavIAsBtpoSGVjyOO8tyvby+hJkRQYeaznUAiZ8SY5sN4UigEHKzZ21PmykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4908.namprd15.prod.outlook.com (2603:10b6:303:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Sun, 18 Jun
 2023 22:52:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 22:52:15 +0000
Message-ID: <12ff965a-12d7-e7f4-a577-5e645d4ff6c0@meta.com>
Date: Sun, 18 Jun 2023 15:52:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v5 1/3] bpf, x86: clean garbage values when store
 args from regs into stack
To: menglong8.dong@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-2-imagedong@tencent.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230613025226.3167956-2-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e218ca1-986d-46ad-df2b-08db704ea930
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QMECN4w7RX5F6G5kbt9aFYaFZqyXjaFpYQCo3p4hk5Kff/50rj5WVquGm0HWGkuCQx8CQJ0qKlHA2OaqujlKydaLNhOy/PcyLssaMs5LpZvp3NxBPXpmVdD3GSg74fZu5Bt75otl2v9WQDOb3svJOtzoQ+oxhur4jYwTfbV0URuTFTS4bDdk+9PEPO9Diwb5mmi7s5Vc0N1vPX5mqh5HrIG9TesyLdKISr8ohji4lATvl4hWAEefF7+iLjG+LbYAu/uyEGM+P787EJjUrZdBO9yFQ9E8pDDTDIkPnKRO3LTlyDTdY+NNLfFglmXksTJ8Snd3BpY/mOZf+8nj4i1eyRF2RHlCmTYfPw5sY9p4TzxbQvi+9S7HQGHQrEnBPa6vNsQexcugYan1AbJ6PbW73vGECjFDy7mpM3TxEBxihQfYJXXvNZNJ11qdCpiYLSwYiaaDmpKEg7s6dii3P3jt+70ywpqXwvOA68gaBznTYFtyc1lB1BF8Zwc8bK5zlalWxqR8uiPEGT8EkOwGCscItqBl3zL+CdubHzFcG2NNlhPkhxrDvcy17Xjn7CsFSdchzJ6hoXC7owOAZzG1oZWCEdYLDOj8qogklgGXZ2QZ7LCnXdZ9XCEue5LuqBs5XEGB9h25q71gQHFmFFxMusA4NQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(478600001)(4326008)(6512007)(186003)(36756003)(6506007)(53546011)(6486002)(6666004)(2906002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(316002)(5660300002)(7416002)(31696002)(86362001)(83380400001)(38100700002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1Y5eEhKY2xzMUhZRWV1QUZaaWpBUFNsSTZNTXhFK2Z4eGgyengyZmg1Qklt?=
 =?utf-8?B?dWJRT0dnVVU1Y09pdXBGY0JDOFhqWnN3RU1MdXl0T0hvNzdBSUhDZDFocGEz?=
 =?utf-8?B?ZG1KSXJ5Rkp6aVVVTVFxRjVRTC9wNGRhRHU0NUxRZWRUdGFHNkdqSUJHRjdL?=
 =?utf-8?B?MXorMDZ2amZodmEzREZFOTFwOWlmSlo5K2xXd0hZcEwvZDJ4Z3hFd0E3VEZS?=
 =?utf-8?B?RHNkZWM2VTNDQ2lOb3JFWWxmRlY0RGlaaVRoMFlJU2U4bUkrM1hUc09RQWkw?=
 =?utf-8?B?amFCcGJVQ01BRm9hVEZkY2hHZ2x2WGJVU3Fsb0gzVjRwWFBybWZjOU5JWWtS?=
 =?utf-8?B?MmFlTVhpTzhtMFppSmlGRlRzbU1zU202TjZMemEzTVRBNjlBYm9lUWJ4NUFi?=
 =?utf-8?B?TFA2WjRyL2VOS2l2Q2tiUnMzbUg5d1duUHRWYmFqS25QL05raW10bUtWaDBJ?=
 =?utf-8?B?ajJSbm1QZzdXTG1aUE5Wc1hwWG9ybUNDb1ZWblh0YnBVSDdwRklHb0RoWmRL?=
 =?utf-8?B?dTllQXg5K295NmZOMHplZVN1c3ZBZkVLdi9NSjhEVGUvaTEvbkw4eVZzalQz?=
 =?utf-8?B?ZFEvVXltT2JKQzIzK0I4QVc3VmlLSlFmOC84UFFkNmh4K0dYMnZaajd1V0x5?=
 =?utf-8?B?KzBrMjJRT2JPbmFZMlBOY1paa3BwaGYyUU4xRjNyY0E4Z09qWE85c1FDc25H?=
 =?utf-8?B?SG5MNWdUSTVSaXhSWDFGaS83QmdEc0NDcDErT3ZYWTZ5TkVHL2pPVHN0R3Nq?=
 =?utf-8?B?MTFubHIyeERFeEVYdVVLOFlaMTczSThZOUQ3WitLUVBjWVVHWU5kRWhTZmx6?=
 =?utf-8?B?ME1uRmN0NFcyZ01wRjBMZXAyTGNwUHFReS91Z3ZEK0YyRFFjeVlSS3JRajRF?=
 =?utf-8?B?K09wVjVzL3dsc205OURMR2NKcEZBQ2k1VTQyUTl1TDVXblErQy9zYkVQZGFa?=
 =?utf-8?B?MmlkZW5zWEFIZzh4M1ZEYjUrT01uckI3SitDQnptTWR4OE91Nk9mMnV6RnZX?=
 =?utf-8?B?MTVjZ3lxbHJuOGJkSUZmRWtZZVBTaWVNNkRtUHdTb3dPNGlsVEVZaStDMTQ1?=
 =?utf-8?B?TjhMTmNHN1lKWEMvNmVYOXJMOUpiY1NsdUExZ0F5ekJhRkdkdmdjUTg5dmFw?=
 =?utf-8?B?eGswTTg3WFEzL1hSeVA1b1gzZzhLZGlNTGNEUHd4ZG9BYVFMRUVsbUJyK1VO?=
 =?utf-8?B?Uk9VVDduT1RtakRNRDJlZmdxWEJWT1FsVzBiN1V3Q29aeUYwcnh0aE9sRDQy?=
 =?utf-8?B?ckFrQmdESTZNMFdmK25rVmRtall6RUloYUZlRFRlaXdLWGhaMkVEU2VRY1RL?=
 =?utf-8?B?SVJWNXhnZ3lOb3RyQ2xncFRUMGV1Q2xuV1lSRFpLaThqcU8yTHFRcCt6NStW?=
 =?utf-8?B?NisrN1dlZFNsSlF4cHJtKzVFTEQ0Rm9zejZlNFNjNWJNcVoxcFhQS0dmZnd4?=
 =?utf-8?B?OHh6SGxBNUZJdDVVUTRZTERoWmx4aEVFbjBMQ2EzaGhuUXFTWkhKVGw4K1lG?=
 =?utf-8?B?US8wakMweGY5Y0tvTXBrWlRZRXdkdXhYUFRKOWhMTWdjZHN2eGZzWnFCSjVY?=
 =?utf-8?B?eEZ1NkxzMnQ4V0FCcHdWc0F1bWt4Q056QXdaVGFtUzVvaHdnTzlwOHRiajQw?=
 =?utf-8?B?U1lqWFJmVHhUNEVtSWZnUmkvMGJtVWR6aTI0dkVRUzlJbTZWdGFoYkMrZ2h1?=
 =?utf-8?B?TWNjVnVYcDBmR3lSdDJmVSsyVGo4MVlmS0NqbmRFU3o1QmZpaHREN3RzRE1v?=
 =?utf-8?B?Nmx4c0tMRE5iQWUvRW9lQkZQcmUyemZJT0pMNTRXa0lUUlAvQVRnNFF3cDdU?=
 =?utf-8?B?a1lEZ3dFNFBFWjNUTjhsbEZYTUNzTTNqWDF3cmUrZEJQSVBpNlhzeityWHlJ?=
 =?utf-8?B?M1dkcTFLTHZ6bGNoUy9vVlRoMDVrNWNYdkg4N0JrR0VsWGc3R3RXM2p3dkRO?=
 =?utf-8?B?dHVlRU1xSklSU2ZtMnA3SW9ENXYyMkphZkMyY05nMlBrSGJKQk8vQjJyWE9S?=
 =?utf-8?B?YTV5c2dOemZjZzh6NnNTc2lEUlUwT25XODNOOVh6ZnBoQ1lJTTkvZ0ltV1VC?=
 =?utf-8?B?bUp1ZlV5bDJaMkl6Rnluc0tlNEp3cmVUbG1tUzE1TDdQYnFCM1B0ekk3bEg2?=
 =?utf-8?B?WVJEcDNMY21IemtQazl2T1hmc1JML1RYTFQrVUFidG9Bc21qcmUzWGlHVWRm?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e218ca1-986d-46ad-df2b-08db704ea930
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 22:52:15.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwx5APEBJ68WHhfytcYfQ7H6ZNwflanSWv+9Qblhpmi20TKwR8FPs9Q+JWVKw/dx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4908
X-Proofpoint-ORIG-GUID: HzWc7AWWvB53PgVADZJ8UkOTzDkU09V_
X-Proofpoint-GUID: HzWc7AWWvB53PgVADZJ8UkOTzDkU09V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_16,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 7:52 PM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> There are garbage values in upper bytes when we store the arguments
> into stack in save_regs() if the size of the argument less then 8.
> 
> As we already reserve 8 byte for the arguments in regs and stack,
> it is ok to store/restore the regs in BPF_DW size. Then, the garbage
> values in upper bytes will be cleaned.

Please make it clear that there are no bugs in the existing code
since for each argument, a type case will happen like
     (parameter_type)ctx[stack_slot]
where ctx[] is an u64 type array. The compiler will generate
correct code to do type casting so garbage value will not impact
the final result. But indeed, uniformly
do save/restore with BPF_DW size can simplify code.

> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   arch/x86/net/bpf_jit_comp.c | 35 ++++++-----------------------------
>   1 file changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 1056bbf55b17..a407fbbffecd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1860,57 +1860,34 @@ st:			if (is_imm8(insn->off))
>   static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   		      int stack_size)
>   {
> -	int i, j, arg_size;
> -	bool next_same_struct = false;
> +	int i;
>   
>   	/* Store function arguments to stack.
>   	 * For a function that accepts two pointers the sequence will be:
>   	 * mov QWORD PTR [rbp-0x10],rdi
>   	 * mov QWORD PTR [rbp-0x8],rsi
>   	 */
> -	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
> -		/* The arg_size is at most 16 bytes, enforced by the verifier. */
> -		arg_size = m->arg_size[j];
> -		if (arg_size > 8) {
> -			arg_size = 8;
> -			next_same_struct = !next_same_struct;
> -		}
> -
> -		emit_stx(prog, bytes_to_bpf_size(arg_size),
> -			 BPF_REG_FP,
> +	for (i = 0; i < min(nr_regs, 6); i++)
> +		emit_stx(prog, BPF_DW, BPF_REG_FP,
>   			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>   			 -(stack_size - i * 8));
> -
> -		j = next_same_struct ? j : j + 1;
> -	}
>   }
>   
[...]

