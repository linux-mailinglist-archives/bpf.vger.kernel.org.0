Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58136D2BBC
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 01:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjCaXjw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 19:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaXjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 19:39:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B44EE7
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 16:39:49 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32VIipH5007820;
        Fri, 31 Mar 2023 16:39:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6QV0mIougd4lcOzkIKFbr6GulU+OH2ZATrrHuW/W8jM=;
 b=ie52O4hYjHX7km3g7v6Ikuv2cRlNtlqSocIRoTGyD36bBTcplbp/PND0CDxAF1accHUz
 Nb+njsljr6p+L4hsoBPRwd/GHq8dh+GryZnPOMV9TkpjyPn1szLdAjUj39Xc/EBvBf2q
 Wwfx9IoUGHbdrtdXoeA5iKSOWbaMtiw/KoBUA763bVsOxE3pFsfDSMsebKhKM8Zb90pG
 +rKL7N9+ghHHzaW1KEabVLLM+TwPVtolr327Oj4vFCM3pIUdqEvDfPBMRA9aOf+9Xdi8
 gEwfDEA+luAl+EbfPTIb1YOJ/Ed49t7RlIravrMixDsJrI1qNWxF8L+BI5FjDTFQp348 Qw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pns0qx2ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 16:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayyZ1Mcw/7UCHNV2GyzfDVMaNEIX3Vf0GuH52UzPzxgoYRKKhkTg3iPipxwad62EKP1XGCVxlNQ2jUv3eIVt5O5rloX4RD4A+qOTe7DNWkmaJAb2DACfaoZAQs35HGfj4GGHe08kpXnTI7DpLQItxHg03eo6Mg8y0Hh9GhYRsdCK725OpEk8wze7yhJYsrgTJ4DyfcdBlSePyUGx02UjUMHbxgUqfEf19/4AMJ4tmHV3OcHfpkl1vXOG8SoYOUqfWqEEdhelWwB5+r0ykcigSYwNTuFdMv+BSHKWSzBi00UO4scExx2e0BiaIHlw+DPZsF+ULNzWwMimopf77C96Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QV0mIougd4lcOzkIKFbr6GulU+OH2ZATrrHuW/W8jM=;
 b=RuqyeV3GK/4AS4iiXpbZpVR1lwswQ9uiaurilimQ3PYdNJsaW80gIUXROpl2rsejGmTsHJCe7ECRYvqampBtXYmbUFdqTQoM3l8COqYrBFjaZA3XIh3H5Lt2epaNTv5Ze6kEmz9kVJyDlxqsokI36VrE2KIGrwpTzb1RQlEDIkB67EeF71GmwCpltzLAWk5qFyRlRfAfYkvBYYkrGRAJ+pl0/gsy9kS+C7HD2llVsCLR0E5KM3Hc2pQbtItp805pNE01SSSyO2tUoDoIdex6ObFbT+gSqT4s7YG4NcFjndtyyIUMuehGDhaNotqaeJjpWOr2SaB4dwzR7oXxuwJJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4063.namprd15.prod.outlook.com (2603:10b6:806:86::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 23:39:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%5]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 23:39:32 +0000
Message-ID: <8adcc374-8128-501a-555c-5f26f7e44746@meta.com>
Date:   Fri, 31 Mar 2023 16:39:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
To:     Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055625.92148-1-yhs@fb.com>
 <7a5563bbbb29288588413c551effa6bca90e0670.camel@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <7a5563bbbb29288588413c551effa6bca90e0670.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d417b2-96e5-4d55-1e3e-08db32412d95
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG7DyPF4nSUMI8bOcnk1NbQ4hMmSz2XY08V5v132oiGrSluDTqnUKrcjT29qaXWZjYa/I+0PJHPWyHs8uXZD0xwDnrjCe2z/s6t7Mnpp3E1/2snksu0TcAmH2vBpwoDUiZqk5KIT9ENPVpxdC3Xrorom3ZiF5fkNDiPV8qKLtIZw2cCj45ZV/EGQzE7QFr40042PFLfpchOZmSyh1bJTTWiuHNyO1/OmxGlI3vw/8DiOjvgvBg21hRS0uO18rFVjzgEPBggtUhwERhyOGhu5/c1QGtd36rZf94/L+8sVdCE15ldmHJ/19tVDq2gnyH7bH6tNiswoPKezTkc6baubM78scHoe+j4ICB7dIfDhjsBYUUvXmSNg4aUqu5wz+x7zK/SJsCCh84vvCcKDe/u9DP1EV5sVoAHLf+8Ftalwmb+JwcHy+LNxvNVMOA7+8Cas5RKOYA8Ypr+ZywNBtSlZn4oNBdWq9KmPoznIeF72+VpTpK5JLIWXuvcY9n44qp7Dzersay7tl4DhNOIqEp9HTs8/w6fYPlr5hlmCfyw66e85kInRmetbyq0UBhj48No+YrUY04a6cXVg2Ak9eMPDeyHHxaWwbnJ6UDr7L7Sq5BwXDDgvQJZhAnGyGBFCVUQf3e/uyc1onmMv5T4HYUVW4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(2616005)(83380400001)(53546011)(6666004)(478600001)(6486002)(31686004)(6512007)(6506007)(110136005)(66556008)(41300700001)(54906003)(66946007)(66476007)(4326008)(186003)(8676002)(8936002)(38100700002)(5660300002)(31696002)(86362001)(2906002)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxTdUJkbHVOazZzZ2Q4elMrYml5SENHcmxCN2hDRmhCSmtlL1UrWFVna1ZP?=
 =?utf-8?B?amFpSzEyTzlQQkFvRWUxQWJVS2VyNHBLR282Z0EvekxwWVVvTHUzbzUzanFE?=
 =?utf-8?B?VlFnYkZLbFhwZS85NDh3emlHNk9qMno0aXZGVmdDWjliQ0ZwWDY4cHRVWHZm?=
 =?utf-8?B?Q29sak1nUHRVcUlzZE4xN0ZMbFFuWHR3NFdlSVRtbE9IZlVzZ1pRbmlmQjQv?=
 =?utf-8?B?cm1YWFBSNjBCZGt4eEpITEN4NndQS1VabVZkci9TbnhMOXJhU0pSMTErSGxL?=
 =?utf-8?B?M0xnUFRZNXR6d0YyRC9md0E2NlB1d2ZVcVRBbVNMSU1YVDZ4VzVZNG5BZFhD?=
 =?utf-8?B?SnhoOTZIa24zMHlLY3lJcDh4QXlXeWJrNkFmNVNHOWRkTFZVODFZcGZrNlFk?=
 =?utf-8?B?SUFKYUxtdFVPc1I0SGU3RVFacG1BLzMxdFIvNGY4SHdNYjRmRURYb3dCZi8y?=
 =?utf-8?B?UXVwWlJrOXJqT3hZdnkybERvVjhEc1UzcElXVE5HV3R1d0RPWmplNGtDNlVX?=
 =?utf-8?B?cU5sTUVCblVLNWR5bWUxUWM5a0RMcWQ3OTRDbDJHM2pkNzZ6RkJPYXpkNEdM?=
 =?utf-8?B?RTRXd2E4bzNIRnkxNStiM2ErQm5DdkgrbGVuM2lJUEVDRzR0VG0rb0RhemlM?=
 =?utf-8?B?clA5MUdQblcxZzVyK3h6QmZOS3p3b1ZDY2JURlJ0RU5ZbjA1cUQ2eFVKc0Fr?=
 =?utf-8?B?YnpUcmQ4cjN1MGFrR1F0QVp1YWZReFJhb3NveXUvREhwdlgvUFVjQkFrNVho?=
 =?utf-8?B?TTR5V1NaeWtnU3JrTUQzbXRBVXB2aXB4WUNlVVVLQUt4UFR3SjlMTllrU0Zo?=
 =?utf-8?B?eGY3NzFrVEhFQzJwa05SVW1FRTc0cDgyMlp1c2tEbXVIRFB5OE5WR1RvRS9Y?=
 =?utf-8?B?T3lEVHBVazQ3SUNGM05sdC9FRVdHSE1GbytxVFExYjlQOGZ6cXN2QjNlemZH?=
 =?utf-8?B?TUFDZkMwQktIVUl1bjlsZlNJMENvTlVVREdjdTRqdFdkSWsyNHpidFhJd0dj?=
 =?utf-8?B?MUw4V0QwZ1d2aS9wVUxxT3BTcFI2KzdnQTV4MVJ2YzJKMUcxZlp6amJZSnBj?=
 =?utf-8?B?RkVOS0VwZUZTSVlzWmQ0RjUrNmFHT21XVXMxSFhTMGloczZwcjBRYks4cmR3?=
 =?utf-8?B?V0NGL01EUEUxSFE5di9Vd1ByTG5iS2NEb3lLWFAxWmhpYTdEK0JGWmVxK3dj?=
 =?utf-8?B?SmxVTDdtN2ZHVk1aVkJpdWY0T0ViV2EvQmdrQlIyOHZ4MFpCbUVWb2JxYzFm?=
 =?utf-8?B?b2pRYkNnemVtZGNLeUxySnl0d2VHMFBsaGJ0TGFjV2RHQk9uMU1UdmVpZzU1?=
 =?utf-8?B?R1gxRWM2WmlmK3RkYnFnaWtYQkVHSGd4bHJyaXR2U2hlUk9oRkZqcDFnYnBv?=
 =?utf-8?B?bUI2R1BsS2lLejEranJDeHF4c0h1YnV4aGp2N3g4NFdnazVBbVJFNFVrWjNa?=
 =?utf-8?B?bThRbXdTcXhLdVg3MXlwdmtCdnlPejVrOGFVWFRDaVNhM0pHdEFYb0hndFF6?=
 =?utf-8?B?VThhUm1HUStqSkxXVU1KNmZ1WUVsSWFBbzd6T1Zmb01MU21sWHRneExPdUJU?=
 =?utf-8?B?MUZqVDlQb2l0V1FnYjRRNFk5V0tGTW1kazkrZWV0ekp0TGIxd2h5dEI3NjVI?=
 =?utf-8?B?NVIzUEhqOTg3Q0hNeTBUSnRlekNjbWRFUUV6VDhOeXM0R3ZJQ2pqWHNrbHVp?=
 =?utf-8?B?SWVzSEswVVkyaWJNdVJ3Z2J6Mk1rQzR3cVppeW4ySEYwVnNtMU0ybm5hbjZC?=
 =?utf-8?B?dm4rRnlRbTZobzMvQWsyTy8xZkNyT01MYWhTNkRUbHV5cUM0KzdlRjlmWWsw?=
 =?utf-8?B?SFdOaUN2YmgrYXBzRnlJY1lSQlZjWlJ2RjJsNFY1bVBTVGZaNGNTTXJmY3lO?=
 =?utf-8?B?cDVFVkNLd2lreVRLN29DQnl2T2N0aVRLY2ZNNFBXbUgvZFozL28rc0k2K0Nq?=
 =?utf-8?B?bVZxVG1PQW1RV1RZK2M4ai8zdjUvMS9hOGpscXo4VlJ2WGZGMmk0N3JTOFA4?=
 =?utf-8?B?a3RrcHNSdlRDUk5UcXY3RFFpSUI4M1J1ZzJkbHZ2RGlrVFN3QWpRZldFZ0xT?=
 =?utf-8?B?bFFVS01XSk1rRTN1dGRrTFhXK0lSSHlpbUdBZ2dYQU92ZXpkbTdIMmRjSVBq?=
 =?utf-8?B?SStQQjdZZFJEcithNE0vVUlReFpDSVIxMWMzcm1CZUl6WE95VmhnR3M3NEpG?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d417b2-96e5-4d55-1e3e-08db32412d95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:39:32.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20/aj0nnkbQdmlK5raBDsYMcj2CsL7hohb1o+xAqfIqgrAWtem8pCRR3LASOoC/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4063
X-Proofpoint-GUID: XRDiv3iqzVGT--3TJDZbthKiMMmWYJiN
X-Proofpoint-ORIG-GUID: XRDiv3iqzVGT--3TJDZbthKiMMmWYJiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/31/23 2:54 PM, Eduard Zingerman wrote:
> On Wed, 2023-03-29 at 22:56 -0700, Yonghong Song wrote:
>> For a loop, if loop index variable is spilled and between loop
>> iterations, the only reg/spill state difference is spilled loop
>> index variable, then verifier may assume an infinite loop which
>> cause verification failure. In such cases, we should mark
>> spilled loop index variable as precise to differentiate states
>> between loop iterations.
>>
>> Since verifier is not able to accurately identify loop index
>> variable, add a heuristic such that if both old reg state and
>> new reg state are consts, mark old reg state as precise which
>> will trigger constant value comparison later.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d070943a8ba1..d1aa2c7ae7c0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>   		/* Both old and cur are having same slot_type */
>>   		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
>>   		case STACK_SPILL:
>> +			/* sometime loop index variable is spilled and the spill
>> +			 * is not marked as precise. If only state difference
>> +			 * between two iterations are spilled loop index, the
>> +			 * "infinite loop detected at insn" error will be hit.
>> +			 * Mark spilled constant as precise so it went through value
>> +			 * comparison.
>> +			 */
>> +			old_reg = &old->stack[spi].spilled_ptr;
>> +			cur_reg = &cur->stack[spi].spilled_ptr;
>> +			if (!old_reg->precise) {
>> +				if (old_reg->type == SCALAR_VALUE &&
>> +				    cur_reg->type == SCALAR_VALUE &&
>> +				    tnum_is_const(old_reg->var_off) &&
>> +				    tnum_is_const(cur_reg->var_off))
>> +					old_reg->precise = true;
>> +			}
>> +
>>   			/* when explored and current stack slot are both storing
>>   			 * spilled registers, check that stored pointers types
>>   			 * are the same as well.
>> @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>   			 * such verifier states are not equivalent.
>>   			 * return false to continue verification of this path
>>   			 */
>> -			if (!regsafe(env, &old->stack[spi].spilled_ptr,
>> -				     &cur->stack[spi].spilled_ptr, idmap))
>> +			if (!regsafe(env, old_reg, cur_reg, idmap))
>>   				return false;
>>   			break;
>>   		case STACK_DYNPTR:
> 
> Hi Yonghong,
> 
> If you are going for v2 of this patch-set, could you please consider
> adding a parameter to regsafe() instead of modifying old state?
> Maybe it's just me, but having old state immutable seems simpler to understand.
> E.g., as in the patch in the end of this email (it's a patch on top of your series).
> 
> Interestingly, the version without old state modification also performs
> better in veristat, although I did not analyze the reasons for this.

Thanks for suggestion. Agree that my change may cause other side effects
as I explicit marked 'old_reg' as precise. Do not mark 'old_reg' with 
precise should minimize the impact.
Will make the change in the next revision.

> 
> $ ./veristat -e file,prog,insns,states -f 'insns_pct>5' -C master-baseline.log modify-old.log
> File           Program                           Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States  (DIFF)
> -------------  --------------------------------  ---------  ---------  ---------------  ----------  ----------  --------------
> bpf_host.o     tail_handle_ipv4_from_host             3391       3738   +347 (+10.23%)         231         249    +18 (+7.79%)
> bpf_host.o     tail_handle_ipv6_from_host             4108       5131  +1023 (+24.90%)         244         278   +34 (+13.93%)
> bpf_lxc.o      tail_ipv4_ct_egress                    5068       5931   +863 (+17.03%)         262         291   +29 (+11.07%)
> bpf_lxc.o      tail_ipv4_ct_ingress                   5088       5958   +870 (+17.10%)         262         291   +29 (+11.07%)
> bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5088       5958   +870 (+17.10%)         262         291   +29 (+11.07%)
> bpf_lxc.o      tail_ipv6_ct_egress                    4593       5239   +646 (+14.06%)         194         214   +20 (+10.31%)
> bpf_lxc.o      tail_ipv6_ct_ingress                   4606       5256   +650 (+14.11%)         194         214   +20 (+10.31%)
> bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       5256   +650 (+14.11%)         194         214   +20 (+10.31%)
> bpf_overlay.o  tail_rev_nodeport_lb6                  2865       4704  +1839 (+64.19%)         167         283  +116 (+69.46%)
> loop6.bpf.o    trace_virtqueue_add_sgs               25017      29035  +4018 (+16.06%)         491         579   +88 (+17.92%)
> loop7.bpf.o    trace_virtqueue_add_sgs               24379      28652  +4273 (+17.53%)         486         570   +84 (+17.28%)
> -------------  --------------------------------  ---------  ---------  ---------------  ----------  ----------  --------------
> 
> $ ./veristat -e file,prog,insns,states -f 'insns_pct>5' -C master-baseline.log do-not-modify-old.log
> File           Program                     Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> -------------  --------------------------  ---------  ---------  ---------------  ----------  ----------  -------------
> bpf_host.o     cil_to_netdev                    5996       6296    +300 (+5.00%)         362         380   +18 (+4.97%)
> bpf_host.o     tail_handle_ipv4_from_host       3391       3738   +347 (+10.23%)         231         249   +18 (+7.79%)
> bpf_host.o     tail_handle_ipv6_from_host       4108       5131  +1023 (+24.90%)         244         278  +34 (+13.93%)
> bpf_overlay.o  tail_rev_nodeport_lb6            2865       3064    +199 (+6.95%)         167         181   +14 (+8.38%)
> loop6.bpf.o    trace_virtqueue_add_sgs         25017      29035  +4018 (+16.06%)         491         579  +88 (+17.92%)
> loop7.bpf.o    trace_virtqueue_add_sgs         24379      28652  +4273 (+17.53%)         486         570  +84 (+17.28%)
> -------------  --------------------------  ---------  ---------  ---------------  ----------  ----------  -------------
> 
> (To do the veristat comparison I used the programs listed in tools/testing/selftests/bpf/veristat.cfg
>   and a set of Cilium programs from git@github.com:anakryiko/cilium.git)
> 
> Thanks,
> Eduard
> 
> ---
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b189a5cf54d2..7ce0ef02d03d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14711,7 +14711,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
>   
>   /* Returns true if (rold safe implies rcur safe) */
>   static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> -		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
> +		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap,
> +		    bool force_precise_const)
>   {
>   	if (!(rold->live & REG_LIVE_READ))
>   		/* explored state didn't use this */
> @@ -14752,7 +14753,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>   			return true;
>   		if (env->explore_alu_limits)
>   			return false;
> -		if (!rold->precise)
> +		if (!rold->precise && !(force_precise_const &&
> +					tnum_is_const(rold->var_off) &&
> +					tnum_is_const(rcur->var_off)))
>   			return true;
>   		/* new val must satisfy old val knowledge */
>   		return range_within(rold, rcur) &&
> @@ -14863,13 +14866,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>   			 */
>   			old_reg = &old->stack[spi].spilled_ptr;
>   			cur_reg = &cur->stack[spi].spilled_ptr;
> -			if (!old_reg->precise) {
> -				if (old_reg->type == SCALAR_VALUE &&
> -				    cur_reg->type == SCALAR_VALUE &&
> -				    tnum_is_const(old_reg->var_off) &&
> -				    tnum_is_const(cur_reg->var_off))
> -					old_reg->precise = true;
> -			}
>   
>   			/* when explored and current stack slot are both storing
>   			 * spilled registers, check that stored pointers types
> @@ -14881,7 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>   			 * such verifier states are not equivalent.
>   			 * return false to continue verification of this path
>   			 */
> -			if (!regsafe(env, old_reg, cur_reg, idmap))
> +			if (!regsafe(env, old_reg, cur_reg, idmap, true))
>   				return false;
>   			break;
>   		case STACK_DYNPTR:
> @@ -14969,7 +14965,7 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>   
>   	for (i = 0; i < MAX_BPF_REG; i++)
>   		if (!regsafe(env, &old->regs[i], &cur->regs[i],
> -			     env->idmap_scratch))
> +			     env->idmap_scratch, false))
>   			return false;
>   
>   	if (!stacksafe(env, old, cur, env->idmap_scratch))
