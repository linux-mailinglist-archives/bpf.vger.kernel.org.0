Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304EE592912
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiHOF3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHOF3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:29:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A01582B
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:29:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27E41Nr0026595;
        Sun, 14 Aug 2022 22:29:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=buZFJh19S49KUVwuwZTkyEGPyRJEkoIKSPyqMTd+BGQ=;
 b=fG6zS3LqxqqjUaD9EgGUdWndvYX2J9PxH4eloSFZi2GhP7WEsmYHbbHosNzhyX4AfXNn
 PCM8dadCkPW10Kq2QWYv7CJtfl/EhK48XUoJqkNq18e7hva4JuWKNoepLDpYGNBInahf
 pCSKEblf7d79dnS//WAW6Zi/cAu6B7nPrTY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9pyg9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Aug 2022 22:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqBVplZGso4KWmh9sBmXs51r0FP5rdpwrWEwd2zwbm+Yab4XKX3daHFrJ9XQ9ChYhWRbQCcOdixehmBHN2278R/L6HrmnjI7bt7FhUOXmqZBLsbKxRUCGiH94AjIu+1PWaBaFUTKjJ/9LG4T/d/9UYfANP6tIyiNdK4vsMC/6gTKj2K0/xhhhrgaoR8Cy83SADTQ8gry3E6IZVJS42Yc6cFX8ROh5BXQsbaDABmMIjPBO+vF7kbPu3az6cZbtFgts4Y1wgD3v8wOoGQov/Ci79SgvyYl/nBDc3ktiaiKSE/RAOrogG8l1+9WBiJLfEDEn+PjO0GT+StvHw+7RekyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buZFJh19S49KUVwuwZTkyEGPyRJEkoIKSPyqMTd+BGQ=;
 b=dHtsN11wqKT/k8E8fH1dOtqG7iNRocnZ975ZV3TZQ5ZJwNMFmGg8LPb/jwTs8Q34JGpGB0DlEDW3Iajea9dhwvKtPiX3qodAia8+7qnOPPo2rSbQjpbPiObdPO/wJtAVOZJtbBzhEVvf8g1GfiQdb1KyjRQe+YxHSTs8PwMBms1Jz1PAjyUHKQq57j6UnfJI6QjktwQvPC8p0bHDL8M0eWDcLHmMt/7IV2h6x5gvgaMmc7O/YfpuM+gdjMaUObHXilPCoFcKMxyT6VixUcgKEFEwQDl1Kg2G/1Q+JTEt5hlP/wQPcwqGdTp7RKxW0fUTgaA9t8UCCECy0nVRiNUo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4581.namprd15.prod.outlook.com (2603:10b6:a03:377::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 05:29:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 05:29:14 +0000
Message-ID: <ddc5550d-b820-6975-a4dc-53e3656a66d0@fb.com>
Date:   Sun, 14 Aug 2022 22:29:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com> <YvlZ+ETaaTD3hwrM@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YvlZ+ETaaTD3hwrM@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cd525b-4fbb-407b-21d6-08da7e7f171c
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4581:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwKB7v2usbenC6XmpljterTQBmGCN64wnxUIgzxW4/QZ+pOX7IpH/Gi1Xpj0fVozx39PTxItysJRyvuZITsqgvpd9vgH0nNhjy2gCuiqcnbyt7HVD8TRHTbemgGHG4Fn6VMTrl5To6qZ7/MnOEQjQuHYGk7r6s/Cw67s4HhOSY9OJWkR77HxNbpHOkW2wyDKrF8rYPSNrZD2KvOKaxQyVQGtIyasZn072wBVkBRvHSDB4a+I9CHdkO8Bc1Af0BpXCgbkV+eUBP1c+kcyA/0cYvKh3p5q/uRK34I8iqMvY/mU9rD0x+aEptPc7iYxWJE9BwS1kjlt2/ugD7hsBml33Vm3rtj7TYi9IwZv1Nn05vVZbG2jq0SgHh+Hk785piTn3vbkYJR5p8LpRP3ptk5PpTwWxoY3w/YuFBHeFU6tfXJazNW0NUmgS3IIaHRPQRU18ObHnCan1taBPMBlqoxC/CrdnOpJ1AxItF09kZe+/hjbOplQZtR5bB5Mcymq9wqSYfMz4Lj9LJAHSL4pvnYQBfykpo8Tvb1RtkiLWRGRa37BNon2LSkU+YyVYmFtAcUY7YreS5uHZ1GdzmKS/eZAyjK794OD16H1IgONnzEIM4WRdWjsJfOv6wKrOmP942fEy8b9kM2G5jOMfTJ/4kStK7bA9JlCCLt0dfoy6jv8HPveOIQgWqSx1g2/xpaIkdF+Ia4QUcWmXYdZyXHa4nsP9aps4NftLFNjKP/7rU6NpXOGh5jWIWEZr48LoAwvnTj8uOQj9ggXuA+jiTlMEudpCmTMxu9KAAD5533yeOa6ot2F37PadU/lYHE1TnhoeVQawaW3KzgrN0roDaf9/xkA/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(6486002)(31696002)(478600001)(5660300002)(86362001)(31686004)(2906002)(8936002)(66556008)(4326008)(66946007)(66476007)(8676002)(38100700002)(54906003)(316002)(6916009)(36756003)(2616005)(41300700001)(186003)(83380400001)(53546011)(6506007)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBzdVFLdVc3ajhERnd1R1JJNXN2YXNSNHdVMGtCd3loVEZoV1pTN2d6WlRK?=
 =?utf-8?B?VmpxWmlyVENCT3dka284T0l5SGdDT296ZFBNenBaZytYbW11dXc3QlRERzZC?=
 =?utf-8?B?Wk54MHdxejBtN2tlN21rbDJ4bEhGK3N2dWhFdEtybHhmYUo0YUZ5a09YQWll?=
 =?utf-8?B?b29XZ3d2OFRoRTB2TnE3R3o1dzVtRElWWS82YXJOUGlMS3dMb2x6bmJhSmdn?=
 =?utf-8?B?MjcwK3p2ZzVVZmQvcWFvYlEwKzYrQ2VDNVRDcUtEZXR0cmt0dUJSa2luM3Fi?=
 =?utf-8?B?aWw0dllMSzM0MjFBN01kczJxM0Q4ek5MVW5aM2FOeWxNTjF4V2pTbnpxNkFH?=
 =?utf-8?B?UDFwRUVhZTJjUWQwbzR2dFdTTm5ncjNjWjMvU2o3Z2tQdlA2WXlPZjViQmho?=
 =?utf-8?B?bWR1V0pyVkYvc0U3N21ldnNjZnNQM0prNk1OTStLaHhHMDA3Yk9hTTJkSmpv?=
 =?utf-8?B?Sm9GUzdiVHR3Zi9xRnVvUW1PdUFVcGxVcjNycHk2eUUrWUw2OFljNFh3VUNQ?=
 =?utf-8?B?TzhCcWF5SzVHY0QwRkUzc1Bua3VuODR3TUtPSkVqUTlRdFR0Z2wrbTlKc1VB?=
 =?utf-8?B?MG1NK3ByRndUV2RlS0RXT04rQmZWTll0eUxLbEEvN3d2ZUYyUzB5Y04vZmJZ?=
 =?utf-8?B?bWtVWUI2bWVCTm0xOHhKR1p2OXBOUEJ5YnFsVVZ2blRnNm03RnVZWVZpUFVv?=
 =?utf-8?B?ZHF1ZkZRVFR5bTB3dktLTmt0ejRhQXZPSGxwVDdnT0hyYzhFdnNIUkd0bmlx?=
 =?utf-8?B?VDFFVG4zVVdySjVLVkV1ZVp6TTNYdHdmeUZuTks1dER5L1J3eXZ3endOK1No?=
 =?utf-8?B?V3RaUmZzc1FHU1EwOGdXbmxjODVDWVRXTTZzWlk0ZGF6Nnp3NGYzclB2SlVC?=
 =?utf-8?B?dFdTSkhIR1VQSkdpT2lpV0JZT2VWK3pBTUE5SHJsNFBKL2VlRldTT29rdXV4?=
 =?utf-8?B?UUwvVmIycThubFUzZGFIcHl4NHhWdGRURnJiaC9mVUV1SWtsMkRLTkUyblp1?=
 =?utf-8?B?MXI1ajdXS0VjZnhQVFNCTUdLdS9FYWVoaGhuWmpITEw5NzFLcXRYbHRWUUho?=
 =?utf-8?B?ajFnVHBuREFLUnQ1TjFyM2pnZlZIM1RmNkhsMVYyQWlCVkNZaTFTTmNHK1By?=
 =?utf-8?B?ajhPT05FT1lrbzRMWVRMT0ZveHlBNU1rZ0ZINEFZbG9zL0lsRjcreFVITzZL?=
 =?utf-8?B?cng2dVJ2YlJmeW1HdGsrOUltakxBZmQ4OGNmOHNQeTJIdGZ1elRXM2Jwckk4?=
 =?utf-8?B?WnF0Q0ErZmpSMVhzaUwvRzFGbytrUnRwcGl1MnByeHVwUHl1eUdiQXpyK2dJ?=
 =?utf-8?B?VXJOYTVwMWN0WXhKZkZMYW5wNGhCRkN3TW9ua3hyamxQcWJjeGVVQXJzajB2?=
 =?utf-8?B?bU5pL0hKNktnVSthYlFPSjlNQjRRRUVGMFZMK3U3d1pRTzRnSTN5KzlmVktQ?=
 =?utf-8?B?NE1FWi9BRkFqUEZIeGNLYmpUVnRBTytVeDB1YmhpN1JLVEpKY1RlVjlRVm9P?=
 =?utf-8?B?WFEwVFNKZ09xemZYYzJiVGFUenRSeUVBS243c1N6Q1NDQnkzUFNLQzJBMGNl?=
 =?utf-8?B?NXpXZ0JsODNGRm1DSVZtVUdmR2tMTkZReUEraDdXeFFnVU8wWGtBR3NGS3hV?=
 =?utf-8?B?c1FVbjd3UWdxd3BvaEtORDlSTStMNkRVT2dWaGNoTUs0UHZxc21xak9jczdB?=
 =?utf-8?B?MWhHdzlQK05UY2Z0RkFwNExiemNjQW10TjQzQjRBOXVvM2ZMQVJma1NXc0lp?=
 =?utf-8?B?MWNEL1M2NGJQeWVnVHBMOEN3V3JneWZBU1NSZGNRand0ZmFuVmdQS3FKT3hv?=
 =?utf-8?B?VkRzOU9Lb3BxdkxUMjN6NWJxWWJoNEN5Q2d2eURVMkpBcnZuUGFIdDltaWM2?=
 =?utf-8?B?ZUxLeXpObUl1aGpMemZFWkhKS3RMRTlXbTJybFB2QXIxaGREN2N0RGR5RXZq?=
 =?utf-8?B?Z0xIMG1WWWNlVGFBTXJsZW9RTlNhSm9lMTM0TXd1anlkWUkrWUxVZEZtRkFl?=
 =?utf-8?B?Y3RUK0NGbk8vZTdXN1ZYaFRYR2hiQ0s4RnYyRlRGNzhwNmxqZExFM1k0YkYv?=
 =?utf-8?B?R2FIRTNyU1ZBSjdTd0l4WVVSc1l6Qk5LVTQxb1FIOEJwQnE2NkE5K0d1RFUx?=
 =?utf-8?Q?RK5W3nCxBaqjDyeFbJ+HGmPnp?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cd525b-4fbb-407b-21d6-08da7e7f171c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 05:29:14.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFG1fy9censNv2Md2A2cy0+eMXwBmB+HirwyjZqgwL5kt2NUtDI9d1FxS6T56Ak6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4581
X-Proofpoint-GUID: Zp20pFEOwpoBs4sbOmYaBn4KufQBS8Nx
X-Proofpoint-ORIG-GUID: Zp20pFEOwpoBs4sbOmYaBn4KufQBS8Nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/14/22 1:24 PM, Jiri Olsa wrote:
> On Thu, Aug 11, 2022 at 10:24:35PM -0700, Yonghong Song wrote:
> 
> SNIP
> 
>>   }
>>   
>>   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>> @@ -2020,6 +2081,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>> +	int struct_val_off, extra_nregs = 0;
>>   	u8 **branches = NULL;
>>   	u8 *prog;
>>   	bool save_ret;
>> @@ -2028,6 +2090,20 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   	if (nr_args > 6)
>>   		return -ENOTSUPP;
>>   
>> +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>> +			/* Only support up to 16 bytes struct which should keep
>> +			 * values in registers.
>> +			 */
> 
> it seems that if the struct contains 'double' field, it's passed in
> SSE register, which we don't support is save/restore

That is right.

> 
> we should probably check struct's BTF in btf_distill_func_proto and
> fail if we found anything else than regular regs types?

The reason I didn't add float/double checking is that I didn't actually
find any float/double struct members in either vmlinux.h or in
arch/x86 directory. Could you help double check as well?

> 
>> +			if (m->arg_size[i] > 16)
>> +				return -ENOTSUPP;
>> +
>> +			extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
>> +		}
>> +	}
>> +	if (nr_args + extra_nregs > 6)
> 
> should this value be minus the number of actually found struct arguments?

In the above we have
	extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
already did the 'minus' part.

> 
>> +		return -ENOTSUPP;
>> +
>>   	/* Generated trampoline stack layout:
>>   	 *
>>   	 * RBP + 8         [ return address  ]
>> @@ -2066,6 +2142,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>>   	run_ctx_off = stack_size;
>>   
>> +	/* For structure argument */
>> +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>> +			stack_size += (m->arg_size[i] + 7) & ~0x7;
>> +	}
>> +	struct_val_off = stack_size;
> 
> could you please update the 'Generated trampoline stack layout' table
> above with this offset

Okay, will do in the next revision.

> 
> thanks,
> jirka
> 
>> +
>>   	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>>   		/* skip patched call instruction and point orig_call to actual
>>   		 * body of the kernel function.
>> @@ -2101,7 +2184,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
>>   	}
>>   
>> -	save_regs(m, &prog, nr_args, regs_off);
>> +	save_regs(m, &prog, nr_args, regs_off, struct_val_off);
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>>   		/* arg1: mov rdi, im */
>> @@ -2131,7 +2214,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   	}
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> -		restore_regs(m, &prog, nr_args, regs_off);
>> +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
>>   
>>   		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>>   			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
>> @@ -2172,7 +2255,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>   		}
>>   
>>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>> -		restore_regs(m, &prog, nr_args, regs_off);
>> +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
>>   
>>   	/* This needs to be done regardless. If there were fmod_ret programs,
>>   	 * the return value is only updated on the stack and still needs to be
>> -- 
>> 2.30.2
>>
