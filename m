Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474B58600C
	for <lists+bpf@lfdr.de>; Sun, 31 Jul 2022 19:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGaRBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGaRBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 13:01:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C0765E
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 10:01:01 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26VGR2S0010964;
        Sun, 31 Jul 2022 10:00:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KRwOwQ5aLAq/+XsBdjDyKKxXge23lQAicgCcNjPny9Y=;
 b=T86cGHN5eizwoTuhR5xo3DlZ+RmSy7y2CQlbP6jLV9b0bHgitI+ebDgPK9iGgfStsxFo
 zxrxYpw34IM0MqHQB5K+EulOIHDr2h8KdCk4wLSnnMAhNht/veLMjNRYT74GA3Hor6Vw
 NzjUC8/uVcTyojgJzU+DSLBTtnGvOAHNrPI= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hn0auq03q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jul 2022 10:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQSavY/CbT4ssJd9m9boYgj5v/Una2jgqRtl1XIjHdwc/sBNeWX5riCmC7yrmuOvl7zLWtGgqJ9UuI1vYoFW14dmXMUvM5h6tPCL0k2wpRmXuaR38toiJZQn0J8MFeehpgNXTNNkfBNLe5PRRJx82yk0l7L1wnjvuhH7yIhc35vks7/GH1wR2PDwu18lMkagYFhK0yD/G7mmIYbgHxX7paOBPowgbu9bvOA93JqW6SyG+JheKTvcnZkT4Tq5b8auCXraQLEIR0/SUsMHf3nNufBjVvOU1HjAXgDyCNwbUivWnpGrzjJgrZkT5coPY+2vS0oxzxuI2N6Sw577RbNz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRwOwQ5aLAq/+XsBdjDyKKxXge23lQAicgCcNjPny9Y=;
 b=BV4day994Nd/JB0RVXdjvOeFxxRnmwwqsMxPzZE8d8tpDZZjmnp+15iHRNbiN8ybetuZxJrlO32So9Au1hijK78uj8J4aMb6q6K6+1+r3YzwCt3OKABL/MBPUZr2OAYRGNTEzzlAsdF5Bl/JOdTHvd7Nh/T3Eox4RLyz1yHyQ7uE7q1y3c8NiCB5IaZMGvoHNVJMIMVi34GdbYoaFmjw+QyC1IFAoS9pPy6qvtd8ELbAhuMNsAglNtGYFF4D3G1NDSw+P7aRN3R+Xi2lc1aIuRbIViiz7+wlmBFj6Raj9EWHMkN/FIA5I+NbNSgjHfuKEnaZoK0NJhzSfHn0knYrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4095.namprd15.prod.outlook.com (2603:10b6:805:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Sun, 31 Jul
 2022 17:00:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 17:00:42 +0000
Message-ID: <25dbc437-e84c-548f-1809-d266da709ea7@fb.com>
Date:   Sun, 31 Jul 2022 10:00:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 4/7] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220726171129.708371-1-yhs@fb.com>
 <20220726171151.712242-1-yhs@fb.com> <YuPALUYnHcZ1drB5@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YuPALUYnHcZ1drB5@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68685863-9bf6-43d1-cca0-08da731633c1
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4095:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehPSiP1A5OWS5IHZmRaKIwKYL0Gmuf0g+nlfH5KSxKe1XCHvXpb+sPy7bmGmYcuOvOudjgWnCPORecPFYR+zMBQev8H6rEOc9TMHzNsyvHfqHGhhjgmccHJkpvFT2rvbEYYvGzdjQiOMSaLZf53aACPhIQiS9dcRLckv1EIXBg/zwvxJ6M3HljERuzFcL4zbpuDy1JkYtWRAVXT+e8I8df9Ok2zO+uRGT+/UzxZ4oRzBusvgxRzaWAm9WqNlQ8rup1YicJDmJoNIIWOHbFp4KTWnlMCAqRyTmyPHRRCGbdYtPL+/ZKm9w3wbiXXHkm8RgZuQiRKEUlycSDxOuAdtfgAExcsRpcCCzANlfxk8D36JvjJkC4ZfEk3TvGUUSm/lvPA/NQ1eO1vmSppHUboBLZWN1MRTxrALcYigG+CyoS9VWu4NfI7eJ/TO68VpOruJ3U0vo11EyjFay+D5nKd4NZBnp8JS9ANhsXAUK7VXKFMCo9zjNzk21aeiWPBimY7Knu+pTfxhEnOqJ2yP7XywmddP7Ib0Sw6NTtLOKt8n7slXjcoYV0z7pNCje0URI+eooKPROzEtEUcotH7Qt7CvhnTcKMsSRQ+oqUo7s2WD5O7YrkLeQsjPQ4s9M8MUjRnCj6m64vScqxg35k5AmHf3chVueqgCyIb/78c31002aV5XnsyEcQIXn+Hf9dxpS1BvI6pNt6CMVYc0/9zQqPll+1HGTF+nzFzgw7GsPvMy2SYY5FeLlLIEfFDV7cPXFcuvk0Ou+3UJ97YmCza2deh4WXK4jjqvOOVQvWYGni+H3vTjsIlcJAYXvGm4x3NrDV7QxNb903BCjv71QzyQIbWKeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(54906003)(316002)(53546011)(41300700001)(6666004)(6506007)(36756003)(6512007)(6486002)(478600001)(31696002)(6916009)(86362001)(2906002)(8676002)(66476007)(66556008)(66946007)(4326008)(8936002)(186003)(2616005)(83380400001)(5660300002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZMcVhJYk1VQytBZHNjYlZkRE1rSzVnS2ttb3o5OG1rYkplYWdJRURFMWh4?=
 =?utf-8?B?cGQyVDhJQ2t5aXpKR3hxSC80Y0FJVnRZVEtUNnBFR3VmN1d0SUpZb0FzZWww?=
 =?utf-8?B?UzJJSkVnL3dHTVBMdWc5QmwyaVY3U0Uwc2xBbFFGVW9SVnNaQnozcmlSb0ZC?=
 =?utf-8?B?ZWZGUjM3V0xhdG5sZElRQXpSQnVFcWVVL3duSUJIUjh2YnA2YURMbksxNVpO?=
 =?utf-8?B?dmtXNzA3U1pIS3JxSkt6eTM5K0tmWncyRlI3NlZvZnVOTXVJbzgrNyszdlZX?=
 =?utf-8?B?WjdSOENjVlozMnoyOXJYb0VzQkg4N1p1UEp0K01aS1BQVzkvWHJBS3kxN3Vo?=
 =?utf-8?B?M1ZZdkZlakpVMm90Zld2bjdwS0kvdDBVeVcyTlVIU1pudFVzVHR6dWZhd2Zi?=
 =?utf-8?B?OTBLU24rYjZnUEpyN1BkTkdRam8vREJzeUViejRsd2JzL0ZmWndDRmhsUGN5?=
 =?utf-8?B?Uis3Z244SzNxN3BXNkZHemRVVWpyaE1ubW1xa1pEb24rWHkyTjZGN2hvNmox?=
 =?utf-8?B?ZHlFRWh6VVVlcnRtMHFGODgwbE95YWFRU3F5cjdXQnJPck11M2c5aGFYYVVE?=
 =?utf-8?B?M2xnSzJTS1FLWEs4Sm0zQ01VOW0wMTNYL1FoVVJOaUw3cFdERkVmbDIwd3Vv?=
 =?utf-8?B?R2RmbDBXemJFMHVLZE43Q2JaRHlSL1FDQUhMUFRRRENjWTh6bWF5NXc4SDg0?=
 =?utf-8?B?Q1duZlZjZU42OFRhcUdrZzllTXI0dmR0K1FMRHhuRnFjNlJuM3N5Vm95K3FW?=
 =?utf-8?B?UXBSRkV2SEVobDYvS1RPSDFUVHQzZ0tYKzN3VlZsYTA1b01CZXJHSmJoTVBD?=
 =?utf-8?B?L1NxV2d1YnFJVlNQZEczSnR0Nm10QkJ1by9wRmdJSUd2TnpDR2ZiN0ZIeEZK?=
 =?utf-8?B?VU1SLzhIdUhWVHN6M2xWYUlta3VFcUtacDg2S0hPTmt2WWJSbkhFSG90SXFO?=
 =?utf-8?B?aHNXNXlVcHBEMkwzclhtcXJCSEl6UzQwNVpnSDFwZkw1bkFwcld4SWc0Z3g5?=
 =?utf-8?B?RjB0UlFIMzArL0M5b0M1SndIOHdKVE50VDV6dFZKeXE2V1kvVG1CelJZd2Jj?=
 =?utf-8?B?MTZjSmZRV0NXQ3NlNzVvUDZ2UmJGWGZaVmhYSVgzdExtQkpJQzRrNjg0M1l1?=
 =?utf-8?B?SFNjK2VYUjJ0Q0xiNVRITW0yVFNMNXluY25oWVducXdKaWowMXJDd2ZhYkJW?=
 =?utf-8?B?UzNyUmNFM0Y4VnZwbW9PcldtcWpOTmtxYU1yNTI2SUFGUmNpT1kwd3prOW0v?=
 =?utf-8?B?cEI5UDYvT3JFWFdxQ1pjQTd4YVFHTVh5cXdUeFQ3U1c4Y3YzYUJmRU85THlr?=
 =?utf-8?B?R05scDQ5SWF6anM5YkIwRDVEdW94OERmVGRHN1NsQmhQaHpxMzdTcHpJaTFB?=
 =?utf-8?B?azhCem1uQWYrQllQU2VvRTFXNjVWUFlKL2l2aWJ4OTB6YzBmTE1qRzJ6cGhi?=
 =?utf-8?B?UjRIU1B3NWFXaG9aNlh6d1FJR1VFZFczV3dMWGQyd082akhSc3VUc2VyY2t0?=
 =?utf-8?B?a0xqUTdCbHBkdUFKYUJVRy9SWmVJRkkvSEZ5T2dlYUlEWFZNMXJVc01FK0ZQ?=
 =?utf-8?B?N2wwOVBEejNXY2VjK1VhLzh1YzJNcTQxYVRWVC8rVlFqUFFwYjhoZTRKVUNQ?=
 =?utf-8?B?MTgvWW1VOFhkemNKUHdXanZZUy95MjYxTDBHVk96ajlTRjJxaExaZ3NQV0d2?=
 =?utf-8?B?d2dCRXlMNVV6YkFxb21Ud3FZZFhHMmlOQVF1UWtTSTg3ZkZMZzF4YlJpME9z?=
 =?utf-8?B?dmNCTURoUlM3UlAyM1NQMXh6cUxDeXpueVMrUVNMdkloRFFQeEJqZzJwWXpI?=
 =?utf-8?B?MmM2Z2lPcTU1QVdFN2xOc21pWUFGQ1BnakN5bWI1cUYzNG9tNUIvNm1jUHZj?=
 =?utf-8?B?TWRydTlkanRGVjgrektkRlVpWTBCcG9kRDBwWE1vRktMaFkzNm12Z1FBak52?=
 =?utf-8?B?aTZZcm5QQ1gwWm1VaXNMTVJnR1VIOVhtYXF5WFRPWXArSUpJSTByVFIxY2pa?=
 =?utf-8?B?VWxHdlVlVFZZc2cydU5ndXU3Ky9UQlVNV2RmbVlaWlBsaC80RmYyL1dXL2Vn?=
 =?utf-8?B?YzZZUE1EUXNjM3FmbjU5a3pnWjN6bjNGTW5hNG9sK3c4T2F3TVNLaVZJUWJj?=
 =?utf-8?Q?wjvA1eJXR+/QMpsdwnXvad24P?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68685863-9bf6-43d1-cca0-08da731633c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 17:00:42.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkVuHp8DAxlPjEUc323vpS10tcdhXhG6LIga65/mLQ7FsVMjDEUAmcDMHfONSS3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4095
X-Proofpoint-GUID: Z8zNLdpBkbtl5Rdf_Ljq4MFAARGM48hW
X-Proofpoint-ORIG-GUID: Z8zNLdpBkbtl5Rdf_Ljq4MFAARGM48hW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-31_13,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/22 4:10 AM, Jiri Olsa wrote:
> On Tue, Jul 26, 2022 at 10:11:51AM -0700, Yonghong Song wrote:
> 
> SNIP
> 
>>   
>> -static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>> -			 int regs_off)
>> +static void __save_struct_arg_regs(u8 **prog, int curr_reg_idx, int nr_regs,
>> +				   int struct_val_off, int stack_start_idx)
>>   {
>> -	int i;
>> +	int i, reg_idx;
>> +
>> +	/* Save struct registers to stack.
>> +	 * For example, argument 1 (second argument) size is 16 which occupies two
>> +	 * registers, these two register values will be saved in stack.
>> +	 * mov QWORD PTR [rbp-0x40],rsi
>> +	 * mov QWORD PTR [rbp-0x38],rdx
>> +	 */
>> +	for (i = 0; i < nr_regs; i++) {
>> +		reg_idx = curr_reg_idx + i;
>> +		emit_stx(prog, bytes_to_bpf_size(8),
>> +			 BPF_REG_FP,
>> +			 reg_idx == 5 ? X86_REG_R9 : BPF_REG_1 + reg_idx,
>> +			 -(struct_val_off - stack_start_idx * 8));
>> +		stack_start_idx++;
>> +	}
>> +}
>> +
>> +static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>> +		      int regs_off, int struct_val_off)
>> +{
>> +	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
>> +	int s_size, s_arg_idx, s_arg_nregs;
>> +
>> +	curr_arg_idx = curr_reg_idx = curr_s_stack_off = 0;
>> +	for (int i = 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
>> +		s_size = m->struct_arg_bsize[i];
>> +		if (!s_size)
>> +			return __save_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx,
>> +						      curr_reg_idx, regs_off);
> 
> could we just do break in here instead?

Thanks for pointing out. Yes, we can just do break and later call
__save_normal_arg_regs(...) will handle this automatically.
The same for another place you pointed below.

> 
> SNIP
> 
>> +
>> +static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>> +			 int regs_off, int struct_val_off)
>> +{
>> +	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
>> +	int s_size, s_arg_idx, s_arg_nregs;
>> +
>> +	curr_arg_idx = curr_reg_idx = curr_s_stack_off = 0;
>> +	for (int i = 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
>> +		s_size = m->struct_arg_bsize[i];
>> +		if (!s_size)
>> +			return __restore_normal_arg_regs(m, prog, curr_arg_idx,
>> +							 nr_args - curr_arg_idx,
>> +							 curr_reg_idx, regs_off);
> 
> same here
> 
> jirka
> 
>> +
>> +		s_arg_idx = m->struct_arg_idx[i];
>> +		s_arg_nregs = (s_size + 7) / 8;
>> +
>> +		__restore_normal_arg_regs(m, prog, curr_arg_idx, s_arg_idx - curr_arg_idx,
>> +					  curr_reg_idx, regs_off);
>> +		__restore_struct_arg_regs(prog, curr_reg_idx + s_arg_idx - curr_arg_idx,
>> +					  s_arg_nregs, struct_val_off, curr_s_stack_off);
>> +		curr_reg_idx += s_arg_idx - curr_arg_idx + s_arg_nregs;
>> +		curr_s_stack_off += s_arg_nregs;
>> +		curr_arg_idx = s_arg_idx + 1;
>> +	}
>> +
>> +	__restore_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx, curr_reg_idx,
>> +				  regs_off);
>>   }
>>   
> 
> SNIP
