Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308D64F856
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLQIuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQIuI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:50:08 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B2C74B
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:50:07 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH5r196029292;
        Sat, 17 Dec 2022 00:49:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=lAt4ze7d5AQQRN6Ml+vr+xAvXm4xaTC7F9fdBh3AXgs=;
 b=PQNbfw00o9h3REYPPH26fQazznb2D8ZotZqqSD0nqzfQB0PlCqVKIucpox8IFPAPWMYU
 Td5sW1TWM8txVmJaTLPBP6TGOmkA2KGd5BXDTqGEuDUfPs5+IP6BGmaxBOZcYXtZZQxi
 MWygDrxuxHLtV/KjosMsGNidCaUWTHkl5v3uDQE0SezQukGsz8simKldlaO4bhSq2j2/
 jgqhQi+lALymCAwQ4mM4uobb5Bv3sMbRJxUrVxNqYZLBYOhwQbdoClXUBwuQ+JmRfelO
 s0RyvBOG1M3ZIxci6UgC38iKVurQktvTrC1UYsjrcrgnsJHfxyoYW9/bt6Od7FRJeBZa LQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6um0q07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 00:49:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3iGlnSParxpsUR5PqM2z2whiyJazgxvisn0NS4nJN2wUGRmNgOT2FJ/ZOWm0DA8by+bBydJghJe2Ga602+CupAte7TyOTBAH+uGbI3k6Yt1QCZrGdUookCB6oEXFQwX4b/pvNIP//o7L3eKkfA2gCK5UBt3bxOD9XRVdn3ZgVjSIb+X2/vVmPzcVy1S7ojJDvzV5fvCOiNRSTIMTwF0/BIBuvs/1AmWQ037q4nR4T0RK1Q4rOEFR1TLTYEgkYLNxSPvObrQA00kxNwThrtrNSZN+o8+viQMcIeRXhYR8i2qVM3bKl83rOggEK7gGrS+pKsyteVEN0Z+1+baQpGAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAt4ze7d5AQQRN6Ml+vr+xAvXm4xaTC7F9fdBh3AXgs=;
 b=LPMX3ndltUqpax+PcgfFXaYu9+gPkNArH40Jve40rT92K4IYl0PH1lLAEQvqmhslTN9VMM6zj+XtQoQjl0JDudf9lFoJ2namytH7UWAaB7yVHrU2gRvi2PJ+VRha2wNGyvMomhc4cLiL/CkO/VyhFJEwpD+qQXBtY+gDtwp3rn4Yb23YeijEvalORfGZDkWwyb/UAbT7XAa+oaugHWYBZlAToy3Ao3nRbAxIWmkKd3V44zy5B29CCYwYAsuHhhKIIJi5hWzrfYPu0ASD9bp6mKUD0TJ0yc3GurSId7uRdL91PZN1hBcSndwODdQLIJWwLqkBTTuOZ7uhatj2RDvTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by BN7PR15MB2420.namprd15.prod.outlook.com (2603:10b6:406:91::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 08:49:49 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 08:49:49 +0000
Message-ID: <3ad6e0f3-6eae-c664-26bf-7440c24af71b@meta.com>
Date:   Sat, 17 Dec 2022 03:49:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 08/13] bpf: Add callback validation to kfunc
 verifier logic
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-9-davemarchevsky@fb.com>
 <Y4/z54TrZgQUvc2p@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <Y4/z54TrZgQUvc2p@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|BN7PR15MB2420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc1d129-f91f-40c9-6f3b-08dae00ba7d1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmzRINzZOqE4ro9tyn6g0k/gu5osVvOh/TqIofZ5/2OlJI163S/+XGq+DBxgm8Rt9hEH1jvCAByP0GgVfsXEWegaWtDmBnwepAbuhk10Qt9FCW2IKpHIgcv6ICziPRmPKezBJGkuZ5BUIjS1PF3Tlp2zEncaYIRncs0Bod+DFEL7qwD5yERCACmkZk0RIdONUKOIaJzm4CpYRdhY4wd36NjBQisHLd9QolbDiXbBQPYcMk4+dGt5YEi+V+U+BGgAaN26RYOm6glSuCtjnBUnL8q6cwE5UuAnhI3xuH3v6Kpv7P7Z9PhO33ru273bEvCV0ti//ABg+BVMEa7l8j5T40zzliZ4o84l4JB6rcpMAGarlHPHoUZVBDdkYzbnUFLWIETujar1HKUEuG8jquY9lRPWr3EB9hAnnZZ3Sw4r8vrfOX04/KWJrNdFCykzqwfz21wkhFNVCAyx8n7PYOauudPvGpwKZf+t+CRR68eBydT8yIZTVxah9RpIIzz11sRwTkDQfD7mXhOp144dQhuPLZ0V8sTg5JbHDsthCzUH2SxspCDMoq8TOqSdOoJ8UhmD8SWZ7cwV+WpsbV/jifriILNYEQ+/0GTu3H/ku6mKfq2pIGoIifK+M+3T3fennlF02xvgHZA+G3fpHaV11xQuHqV2b66r75l00mZOTmqOphU0m2MCFizz0D2BOc/QHxfFnKkc4I4Pu664lmp+yw/xqGLaByv18F7xXZk1aYlGkHCfYIGl/3quckefafBecCCL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(36756003)(4326008)(8676002)(41300700001)(66476007)(66946007)(54906003)(8936002)(66556008)(5660300002)(186003)(38100700002)(6666004)(966005)(6486002)(83380400001)(478600001)(86362001)(2616005)(53546011)(6506007)(6512007)(31696002)(316002)(31686004)(110136005)(2906002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pVQ0h4TjhZMnJnQ0VLaVJwLy9sbnVLdkUyRCtjemZ2cXh0cjdCVTBOODQ2?=
 =?utf-8?B?L0JycURvdS9FNnY2eW1PbnhPM0xOekNFTkdsczJLa1o2ZnlvQ01nVXFEOEZY?=
 =?utf-8?B?UWpzeHExbFdvdFFyUDFZZU5nYngxYWJ2aEwxSldJMDNhdENxaFg3V0dKY25x?=
 =?utf-8?B?OHl3L09iRWIwekRnaU8wV3pxRlh4elVJWnZJQWxUMzd0bElQQ3FFeHhQRDNZ?=
 =?utf-8?B?RHJyYVpNZXR3OUZ5eHN5Tkk3eFZKMVhhRzRQT3hOWWpMRlZMRjk2ZlJ0cEVM?=
 =?utf-8?B?QnA4VzJYTksxZVVNMnhZNXV1WXY5ek1QeVFnVXZOWGw4RUNPRnB3RFY4cU9E?=
 =?utf-8?B?VElkVERjejZFRjlQT2ZFWjlwV3VxSUw5TDMzYVZJTFQvOVRJN2FaUkp3d1oy?=
 =?utf-8?B?VTFXSUlybWdIYnkrNFZReVVHRERzajI0NTBjUW8ydHNzUUZrSVRiUnNxTVBp?=
 =?utf-8?B?ckdmUGdkb2dyS25aTTg1UU55a2N5NlhQVkJtQ2pmMUpFQk5HaHF2RTZRUnJI?=
 =?utf-8?B?SC9tamlxYTlFUGNhWGg0dXd4OUhXSXJhVlFtM09MRUM4ZjdyWlFmTVZ2dDdo?=
 =?utf-8?B?cW1iSnVsS1E2dFFBc1RxUkZJMnJqb0pkajladFBTYUhoQXNQTXZ3UURsZXRU?=
 =?utf-8?B?c1ZlZVhNazdac1UrRHVYM0hFU1dXeGRuY2ViUWlQcFEwTXRIYTFxaFhQa2pZ?=
 =?utf-8?B?dXhZdjZEeDJoSlp5d29oQm5PSXVWZXpLam5NR1R2OU54aWpyYy8vK05XUXg5?=
 =?utf-8?B?TTl5a2V4TmhQbUNKczFMVHdldnRRc1A1WkVqK1pDUWxidzc5VW4vM0Q0K3hJ?=
 =?utf-8?B?ekQ2UDhPcys4SjZxZzc1SGkwaWtaQTBFTCtkRjlkclE5bERJdUpVYjZXWVY0?=
 =?utf-8?B?MHdJemI3Q254c0Y3bXEzNFhOU0VWQmozYUVvbVZOVkxwVGQ2SmNEaVdYNEty?=
 =?utf-8?B?TFRMbHFsRElJVW15dWNKVnBFWEdkc3paMVVzamx1N1ZFMUl4MTN5dG5ncy8v?=
 =?utf-8?B?cDhUc1A3TlRLaVpvTFBacnBrVFptMGh2Ri93Z2ZxYkUzcVhrZHE4TFZPN3Bn?=
 =?utf-8?B?a1dNQnFEYTFLNjMybWFVaEZDTzVsY1Y4amJFU3lzQTdPdlFSRTI2Nll2NUV6?=
 =?utf-8?B?MEsvK1hua2FzK09RZkJJUFN4dmJpQTFiNEZhV1lPSDlDYndITC9HZW9yWWpJ?=
 =?utf-8?B?TGFoZVR5eUxyV3FmK0I3cE0rZjQ0Vk53VFV0eWR2SHc5TVlSTEZ4blVtQ01F?=
 =?utf-8?B?K21tWmxMUTdKVVVkdWRPS29yRHFTcUdVYTNmUXFhZStkd3FQR09Ed29yUGlM?=
 =?utf-8?B?Q0NoZHVtelVPa3I5Q1luaDVNMmtqN0g2M0xDaDFxSHV3Sjd6K09GZ2tRYWQv?=
 =?utf-8?B?VitKbHVnZ3lJVGhzS1hRaXpBR0xQbVMwaE1TWjhueG8zLy9MTGNlTWw1MEFi?=
 =?utf-8?B?YVhaeWtHWU9PQkdERE1FZzJzdjE5ZEtXdDNzZ09tT0YvVUVKWjF2UEt4L3Qr?=
 =?utf-8?B?RVRweW5JSFJha21UUzNCd2lJMm82cS9BWXZrOU1WeUhOM0JaamxzSndpOVZs?=
 =?utf-8?B?bUlUUXF3YUNIbFNFUGNzT1hwWFVOUWgwd1BON2VId0l6UkpwTkU4YlVVVlBN?=
 =?utf-8?B?LzgxTFJBNlZrdDI1NGtSZjZFRVlVNHdhZXFqbmJISnFiaE1qdmxrellQM0l1?=
 =?utf-8?B?MzZpU3lSN2Vxd3BHVkIzT1dVUkhOU0F5Zm1SRnRZNkZqbjNrR0hZZWVQdHNX?=
 =?utf-8?B?Q05ERlBkSzJQd25FcFJzQXpjOEk1Yzl6blNValRiNFFxZ1RQQlMvU0ZHNjRk?=
 =?utf-8?B?WnU1K0o2ZXhuU05ySlJyaE5lUHkyc0UyOElpVGg0MnhScFBYQ05KZ0RnOFRu?=
 =?utf-8?B?aXJEZWRtR1o2TldBY0NDRi9WTWNJL0V4MU10UFZZaDNKc29LWlJvUEJFYnBU?=
 =?utf-8?B?SDBGODM2ZGdGQ3RrS2FSaEVBTGk0ejBNWDUyVjlqL2docER4WlY4SGphaEUz?=
 =?utf-8?B?NGZLSDRzTGJpc2FEV3h4UEs2S09lQVlNc016OTNuT28zSUJPNGFocjMyN0w3?=
 =?utf-8?B?aVRpRi9mNElQSWh4Mm0xTGJMWnd5Q0cyV2pvMm9pSDc2MTB6cEFrVUF6aTdq?=
 =?utf-8?B?NkEvY0lTM3A2aHVRRHlCM0VlWitsbEVOTnFkQXk5LzNhRzJXSU5zajcvL0ZP?=
 =?utf-8?Q?RPGLpKumaRsBNqu/lXVpWPQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1d129-f91f-40c9-6f3b-08dae00ba7d1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 08:49:49.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlGY79dPh1mgcEQxoReSilzHuWVDs7NxFry+TwTqjBx7n3ROb9FOLhhRg+RvsADJ4TUiGA5r9q8mBJNz/h6Uug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2420
X-Proofpoint-ORIG-GUID: Amk_igR3Q1j1rQ4n_IvoA8H4bVR-PMt0
X-Proofpoint-GUID: Amk_igR3Q1j1rQ4n_IvoA8H4bVR-PMt0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/6/22 9:01 PM, Alexei Starovoitov wrote:
> On Tue, Dec 06, 2022 at 03:09:55PM -0800, Dave Marchevsky wrote:
>> Some BPF helpers take a callback function which the helper calls. For
>> each helper that takes such a callback, there's a special call to
>> __check_func_call with a callback-state-setting callback that sets up
>> verifier bpf_func_state for the callback's frame.
>>
>> kfuncs don't have any of this infrastructure yet, so let's add it in
>> this patch, following existing helper pattern as much as possible. To
>> validate functionality of this added plumbing, this patch adds
>> callback handling for the bpf_rbtree_add kfunc and hopes to lay
>> groundwork for future next-gen datastructure callbacks.
>>
>> In the "general plumbing" category we have:
>>
>>   * check_kfunc_call doing callback verification right before clearing
>>     CALLER_SAVED_REGS, exactly like check_helper_call
>>   * recognition of func_ptr BTF types in kfunc args as
>>     KF_ARG_PTR_TO_CALLBACK + propagation of subprogno for this arg type
>>
>> In the "rbtree_add / next-gen datastructure-specific plumbing" category:
>>
>>   * Since bpf_rbtree_add must be called while the spin_lock associated
>>     with the tree is held, don't complain when callback's func_state
>>     doesn't unlock it by frame exit
>>   * Mark rbtree_add callback's args PTR_UNTRUSTED to prevent rbtree
>>     api functions from being called in the callback
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  kernel/bpf/verifier.c | 136 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 130 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 652112007b2c..9ad8c0b264dc 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1448,6 +1448,16 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>>  	reg->type &= ~PTR_MAYBE_NULL;
>>  }
>>  
>> +static void mark_reg_datastructure_node(struct bpf_reg_state *regs, u32 regno,
>> +					struct btf_field_datastructure_head *ds_head)
>> +{
>> +	__mark_reg_known_zero(&regs[regno]);
>> +	regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC;
>> +	regs[regno].btf = ds_head->btf;
>> +	regs[regno].btf_id = ds_head->value_btf_id;
>> +	regs[regno].off = ds_head->node_offset;
>> +}
>> +
>>  static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
>>  {
>>  	return type_is_pkt_pointer(reg->type);
>> @@ -4771,7 +4781,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>  			return -EACCES;
>>  		}
>>  
>> -		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
>> +		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
>> +		    !cur_func(env)->in_callback_fn) {
>>  			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
>>  			return -EFAULT;
>>  		}
>> @@ -6952,6 +6963,8 @@ static int set_callee_state(struct bpf_verifier_env *env,
>>  			    struct bpf_func_state *caller,
>>  			    struct bpf_func_state *callee, int insn_idx);
>>  
>> +static bool is_callback_calling_kfunc(u32 btf_id);
>> +
>>  static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  			     int *insn_idx, int subprog,
>>  			     set_callee_state_fn set_callee_state_cb)
>> @@ -7006,10 +7019,18 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>  	 * interested in validating only BPF helpers that can call subprogs as
>>  	 * callbacks
>>  	 */
>> -	if (set_callee_state_cb != set_callee_state && !is_callback_calling_function(insn->imm)) {
>> -		verbose(env, "verifier bug: helper %s#%d is not marked as callback-calling\n",
>> -			func_id_name(insn->imm), insn->imm);
>> -		return -EFAULT;
>> +	if (set_callee_state_cb != set_callee_state) {
>> +		if (bpf_pseudo_kfunc_call(insn) &&
>> +		    !is_callback_calling_kfunc(insn->imm)) {
>> +			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
>> +				func_id_name(insn->imm), insn->imm);
>> +			return -EFAULT;
>> +		} else if (!bpf_pseudo_kfunc_call(insn) &&
>> +			   !is_callback_calling_function(insn->imm)) { /* helper */
>> +			verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
>> +				func_id_name(insn->imm), insn->imm);
>> +			return -EFAULT;
>> +		}
>>  	}
>>  
>>  	if (insn->code == (BPF_JMP | BPF_CALL) &&
>> @@ -7275,6 +7296,67 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
>>  	return 0;
>>  }
>>  
>> +static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
>> +					 struct bpf_func_state *caller,
>> +					 struct bpf_func_state *callee,
>> +					 int insn_idx)
>> +{
>> +	/* void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
>> +	 *                     bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b));
>> +	 *
>> +	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add is the same PTR_TO_BTF_ID w/ offset
>> +	 * that 'less' callback args will be receiving. However, 'node' arg was release_reference'd
>> +	 * by this point, so look at 'root'
>> +	 */
>> +	struct btf_field *field;
>> +	struct btf_record *rec;
>> +
>> +	rec = reg_btf_record(&caller->regs[BPF_REG_1]);
>> +	if (!rec)
>> +		return -EFAULT;
>> +
>> +	field = btf_record_find(rec, caller->regs[BPF_REG_1].off, BPF_RB_ROOT);
>> +	if (!field || !field->datastructure_head.value_btf_id)
>> +		return -EFAULT;
>> +
>> +	mark_reg_datastructure_node(callee->regs, BPF_REG_1, &field->datastructure_head);
>> +	callee->regs[BPF_REG_1].type |= PTR_UNTRUSTED;
>> +	mark_reg_datastructure_node(callee->regs, BPF_REG_2, &field->datastructure_head);
>> +	callee->regs[BPF_REG_2].type |= PTR_UNTRUSTED;
> 
> Please add a comment here to explain that the pointers are actually trusted
> and here it's a quick hack to prevent callback to call into rb_tree kfuncs.
> We definitely would need to clean it up.
> Have you tried to check for is_bpf_list_api_kfunc() || is_bpf_rbtree_api_kfunc()
> while processing kfuncs inside callback ?
> 
>> +	callee->in_callback_fn = true;
> 
> this will give you a flag to do that check.
> 
>> +	callee->callback_ret_range = tnum_range(0, 1);
>> +	return 0;
>> +}
>> +
>> +static bool is_rbtree_lock_required_kfunc(u32 btf_id);
>> +
>> +/* Are we currently verifying the callback for a rbtree helper that must
>> + * be called with lock held? If so, no need to complain about unreleased
>> + * lock
>> + */
>> +static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>> +{
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +	struct bpf_insn *insn = env->prog->insnsi;
>> +	struct bpf_func_state *callee;
>> +	int kfunc_btf_id;
>> +
>> +	if (!state->curframe)
>> +		return false;
>> +
>> +	callee = state->frame[state->curframe];
>> +
>> +	if (!callee->in_callback_fn)
>> +		return false;
>> +
>> +	kfunc_btf_id = insn[callee->callsite].imm;
>> +	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
>> +}
>> +
>>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>  {
>>  	struct bpf_verifier_state *state = env->cur_state;
>> @@ -8007,6 +8089,7 @@ struct bpf_kfunc_call_arg_meta {
>>  	bool r0_rdonly;
>>  	u32 ret_btf_id;
>>  	u64 r0_size;
>> +	u32 subprogno;
>>  	struct {
>>  		u64 value;
>>  		bool found;
>> @@ -8185,6 +8268,18 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
>>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
>>  }
>>  
>> +static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
>> +				  const struct btf_param *arg)
>> +{
>> +	const struct btf_type *t;
>> +
>> +	t = btf_type_resolve_func_ptr(btf, arg->type, NULL);
>> +	if (!t)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>>  static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>>  					const struct btf *btf,
>> @@ -8244,6 +8339,7 @@ enum kfunc_ptr_arg_type {
>>  	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
>>  	KF_ARG_PTR_TO_MEM,
>>  	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
>> +	KF_ARG_PTR_TO_CALLBACK,
>>  	KF_ARG_PTR_TO_RB_ROOT,
>>  	KF_ARG_PTR_TO_RB_NODE,
>>  };
>> @@ -8368,6 +8464,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>  		return KF_ARG_PTR_TO_BTF_ID;
>>  	}
>>  
>> +	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
>> +		return KF_ARG_PTR_TO_CALLBACK;
>> +
>>  	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
>>  		arg_mem_size = true;
>>  
>> @@ -8585,6 +8684,16 @@ static bool is_bpf_datastructure_api_kfunc(u32 btf_id)
>>  	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
>>  }
>>  
>> +static bool is_callback_calling_kfunc(u32 btf_id)
>> +{
>> +	return btf_id == special_kfunc_list[KF_bpf_rbtree_add];
>> +}
>> +
>> +static bool is_rbtree_lock_required_kfunc(u32 btf_id)
>> +{
>> +	return is_bpf_rbtree_api_kfunc(btf_id);
>> +}
>> +
>>  static bool check_kfunc_is_datastructure_head_api(struct bpf_verifier_env *env,
>>  						  enum btf_field_type head_field_type,
>>  						  u32 kfunc_btf_id)
>> @@ -8920,6 +9029,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  		case KF_ARG_PTR_TO_RB_NODE:
>>  		case KF_ARG_PTR_TO_MEM:
>>  		case KF_ARG_PTR_TO_MEM_SIZE:
>> +		case KF_ARG_PTR_TO_CALLBACK:
>>  			/* Trusted by default */
>>  			break;
>>  		default:
>> @@ -9078,6 +9188,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  			/* Skip next '__sz' argument */
>>  			i++;
>>  			break;
>> +		case KF_ARG_PTR_TO_CALLBACK:
>> +			meta->subprogno = reg->subprogno;
>> +			break;
>>  		}
>>  	}
>>  
>> @@ -9193,6 +9306,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  		}
>>  	}
>>  
>> +	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add]) {
>> +		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>> +					set_rbtree_add_callback_state);
>> +		if (err) {
>> +			verbose(env, "kfunc %s#%d failed callback verification\n",
>> +				func_name, func_id);
>> +			return err;
>> +		}
>> +	}
>> +
>>  	for (i = 0; i < CALLER_SAVED_REGS; i++)
>>  		mark_reg_not_init(env, regs, caller_saved[i]);
>>  
>> @@ -14023,7 +14146,8 @@ static int do_check(struct bpf_verifier_env *env)
>>  					return -EINVAL;
>>  				}
>>  
>> -				if (env->cur_state->active_lock.ptr) {
>> +				if (env->cur_state->active_lock.ptr &&
>> +				    !in_rbtree_lock_required_cb(env)) {
> 
> That looks wrong.
> It will allow callbacks to use unpaired lock/unlock.
> Have you tried clearing cur_state->active_lock when entering callback?
> That should solve it and won't cause lock/unlock imbalance.

I didn't directly address this in v2. cur_state->active_lock isn't cleared.
rbtree callback is explicitly prevented from calling spin_{lock,unlock}, and
this check above is preserved so that verifier doesn't complain when cb exits
w/o releasing lock.

Logic for keeping it this way was:
  * We discussed allowing rbtree_first() call in less() cb, which requires
    correct lock to be held, so might as well keep lock info around
  * Similarly, because non-owning refs use active_lock info, need to keep
    info around.
  * Could work around both issues above, but net result would probably be
    _more_ special-casing, just in different places.

Not trying to resurrect v1 with this comment, we can continue convo on
same patch in v2: https://lore.kernel.org/bpf/20221217082506.1570898-9-davemarchevsky@fb.com/
