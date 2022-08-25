Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB75A074D
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 04:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiHYCfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 22:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHYCfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 22:35:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EFC6F54F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:35:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27P0ilE3011975;
        Wed, 24 Aug 2022 19:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Fs0FpCeuMIZ8tgm4HRK2on5sYBSFbiPA+UnkESGsaaI=;
 b=GIBVbBtPUALNGIIB4XDHByD4OAwQTUW3DoWmxsLPdKPp0Sb+eqf4poXcmtFtFutMaSGV
 5speEvNYjpNpHHkC9K9oCzF0kJLVEtVgxBcPJZ2xKbaPAnB4w+oya1RxIMV3ccwCwVPv
 CxWpd3jz6/Bv38CjLoABObjQmvzSJZFM/YY= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j5xcggj5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcywrC7+szUzK8/pQNWlYGcZBsrbYVIiqxHD0KYoVHyi7JlP+BRph18UMrwgRpEs9nZchWVX670Bw7ceB2HCd2STNa+C63cTwac73TQ/fRWFhKa9dtl+sIMLXDuTjxHWxeRiduNpTPiZODok/wbpp5YyUY8s+CuBHY0oGNY9ZQ8hmBuUOrv0cjszA0fObIlBsOm9pxksiI8kXdrgAWDjNo/nmiUrM9vZq+Qo0WhwoWiuOXc6Miz/OH6IZsH/7igC7DoRs4VwQMi8WmwVLjvhhzuCnFp4By0fU2YeefD2xyvg4n4LtilaD/X2YNaPbTu9lZZCYTTD23LE/pz6olkxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs0FpCeuMIZ8tgm4HRK2on5sYBSFbiPA+UnkESGsaaI=;
 b=OUjExd9xFqGeKakHJVWrZqYI5CVhjsKm9Bg5EvLdRtUaJ1tn3Xya7WK3elhFiwrk0WT3zxGzDB9g1pT2JaH+gV4N2TkJNyd8lN9ZUIisz2EELTZWhH8+Exoh6y8nKBktH1dVakClqSwS/7+gcbyXA6eB0B1LpOa9EFmGqkXyrrwvyV1fVWEQ7Uc25XoPRrUxzRFCeu/HHLHJi0wQDcIJJw4pn7K9Z4r1F0dxLcyHYx93MyyGW3S2C90xnuTMpYy8g/hkEjxq5zfOpDEMAIF2cSr5AcDQHmKGQWK11giNQlzBaOWqvU+0h8nssUJsLruUn00IioqTQPGXTcLX52SLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3240.namprd15.prod.outlook.com (2603:10b6:a03:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:34:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 02:34:52 +0000
Message-ID: <e55d7ad5-4d44-0575-6a07-1c4a6eaf36ff@fb.com>
Date:   Wed, 24 Aug 2022 19:34:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-2-eddyz87@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220822094312.175448-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 068f24f6-c67c-43bd-d208-08da86426378
X-MS-TrafficTypeDiagnostic: BYAPR15MB3240:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Da3qiGezrQBW6QftHY70S+mUug+NOuuGfNHlABnBeDCnJu+6cTosR1TPZsw46DzJDRzqVrBiCe+e0Jv47RQfUPNFcJzCgmmkmn4iyRG5Wgs2KyRB0qjWRHxtzERMy0S6ogaPnYU5dZNFPBSER3EM1b9jocYBn1qio+5sK0+TcikV1q3qxgUac5rHsGIz9+PiCGYsdgpiyarNwiKJCU6qmcRsWDM6VYkDQT47rg0YKRu/SlVcGJaytlBnE8UmUAYGKdSkHcKWZlqTHsSrWqv30MQeQRK8JsDJT9A+B4yXRAZK9NpamFRHZwPgHBuQHs+7N4QxVCxWNY5KO9frZ/N8Mj5ECvDIq4xf2eiZ61v12ZRlz/fv2yUBNcLagnHSrfLbDJ/MN21wVjnzFL1mkhTX8wGB9qSUIbO7ctGQlcAeIcX2/wFsH06Iod6WaI8/cuuV8ub3tmfx/d1GpAG3gD1Dg9ePT7Wm1QuPEdyrqsXgm0xJb7wPISndp/S9f5tjbXMpMcpp30JbANnnQ4khGvGeCDeYupMzkOUG9FrDTWj6kBop8FSKWP6gsGU8KvrK+NbGnxhxkkNlcRbnqPIvhhB7cW+w2hm84wvLENU2Ll30faPdBX3hBlHzATxwgSyr6oDCd2BekBfoYet0blFSfLFWHCNCi+huVXyYvQICPvHeZ3cxpiuFQOIXe7laewG/2cuPZfA/Dqw8bE67vhUGNzMjmmFIVsQCICpMLpZ6Rtkt3ggc3rP6Z7Qq8xSLRHELN9Qbrswe7w5P8HltUNdm7gww2rda8FwAicO+FaG/3/4f2OI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(53546011)(186003)(6506007)(2616005)(8936002)(5660300002)(6512007)(41300700001)(83380400001)(478600001)(36756003)(31686004)(6486002)(86362001)(31696002)(38100700002)(316002)(6636002)(2906002)(8676002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lNa2dDY0xYK01IcGhCNVdqSHh0Z0FiM0Q0amNGT0laV1hXUmhsUHZ1OVlS?=
 =?utf-8?B?NnFDdzdPclJLTUVSdWpqQnBEbW91bDczMVhOZ1p0WTh6eG82eHJSbkFQeDlK?=
 =?utf-8?B?ZWZFaXd1NDA0MTN3NFgxMFZscDBaRFY2a2Q1a1c3VFd1MUJOQk81aHA3YTJa?=
 =?utf-8?B?azMxb1grTHE2TDFsWkFjcXlZamtTcjdYdHlkd3RQU2pQb1RiNVRkZkdTYXpE?=
 =?utf-8?B?TUVtVUxNdHlEeWJaaWVPbGdKU3hzb0NTUnp5bjRrS0d5Q0pnNGkxL0dLNCs1?=
 =?utf-8?B?T3BuVElMN280Smp3ZDhZbGM5Tk9BREUvRVVqOU5EYm9wcFhBUXA0d283QTNs?=
 =?utf-8?B?VWZDTXFsd1dWd1Urbk5relF1UzVWbFRyV2d1ajRPRm9RMk4vVHJsMmhlY3px?=
 =?utf-8?B?MGRrWnJ0bkpJeDFVK3VlRjdNaTZvQmRKYVNwVFJmZVhlVFFoUGhCbEpaeHll?=
 =?utf-8?B?QlBuVUxjS3p0VWVKU1BHNUMxQjJIeGlxYXlnWVNnbm11ZE9EaC9KTjRXakRw?=
 =?utf-8?B?VHd5VDhualRwTWtQVUhuRytwbFBjUXh3R0RMcXV3bWVrUDh4RG52cUJHTGhC?=
 =?utf-8?B?blpadXk4VXJHZElLT09oWlFUaWt5Q21uR01ROVhyU25WamlJMXlXNGhNemZF?=
 =?utf-8?B?S0ZRT2lYNzhtVlowNDMyem9wdmczZWF1OFppZkdLTngzckptYXE3aExDS3Bu?=
 =?utf-8?B?L2RJbnhRc0cwMHNHaGZ0Zy9TcUQ3ZUU1UWp0WjVNOENYdnBzQUlVcklOQnNW?=
 =?utf-8?B?TXZiNTFNUVJQYWhjZUhiSVBqM0lGc0UxWGlJWkVJdG9sS1pRT0ErTUxCSTUv?=
 =?utf-8?B?ZkxtUEpwODRNWStNSW5pMjRZdkV4aDd1elNzTTdXZ1BHOW9nVEg4MlZnVEd3?=
 =?utf-8?B?Q3hVWjRJS3JTK2E4K2h6VXF4RnpiTUc0alhYQzJCS0t1ZHA5ckJoSlNOVkFE?=
 =?utf-8?B?bmRja2kzeUczSVB3OFhqdFFtR0I3TC94cFNkR1lweGVRTjV2TEErVEF0cHBS?=
 =?utf-8?B?dVdUdkRRd2VTU3o5TU8yZXpldnZ5ZkdaTFFMN0M5R2R4TExzMWcvb0NrcVRv?=
 =?utf-8?B?RFd0QWhIUzR6bkFWR210V05TS3BCbWkwaWpuc1VkRXdWWFh3MVpJRGc2dWY0?=
 =?utf-8?B?dzNGcDN1elBGdm5XQXUrVXhsVjlON0RyTXNoMHdJaHlTRWZUZS9senM0REQ0?=
 =?utf-8?B?Q2pxT1ZTWGNuZXpHbjU1TTdUZStjbzFPaVlNbTRrbjlwcUVUNktXZzRuYWRH?=
 =?utf-8?B?ZFA4K29tMWxWVmdEcFAvaElYVCtaOXJKMkp1aE5oZllQOG1OQ0lFQWczZmdL?=
 =?utf-8?B?anBnS0FCTmd1b3J6RFBTeWpOOFkxQk1tTGRNcW1hc2hxeU0rOE1QQUJodjc0?=
 =?utf-8?B?YzNvSy90QmhpT1pZRWI1eGJLTmVweVgwbitNbGdOU2JYWDlveTR4MWdTbito?=
 =?utf-8?B?UWkyM2RQemlROEdOTUw2dVEySFg5TXVubTFzUUNZYlBlL2pMYmQ0NDI3dUk3?=
 =?utf-8?B?MGlTZEZmZEp6RnpNOTdMZU5ZQlpVV29JTjUwQ3hSbnMvV1VlUHU0amxkN2s3?=
 =?utf-8?B?NGlETmpEYlovVm1sNkQ2amY4L2R0R2I4cmkrbHQ0OVViY3BTUE5seVR2Z09H?=
 =?utf-8?B?MjA2aE1OVUlMUThGQ1NLSGRMTmJmWUdzY2l0eFNua0VpeFdRQ0lMRkNBTVYy?=
 =?utf-8?B?bUlWYy91b1E2cnlzNGNBTGgrblJJZ2VoVk80ZWNPNmdiNUJkRFBkMlI2M0RG?=
 =?utf-8?B?c0REcDFmUkEreVJjQm9iNFpSMGNPZFRETUxmTDkydlhMaFU0czJSRGVZU2Ns?=
 =?utf-8?B?RFpTTzRuUVlQbUxlSnE3OVhUclM4UWRYS1pvQlBnaWZ5cHRxcysrcEFkQmZF?=
 =?utf-8?B?b3o4L1IyUjJoelB4WVNkTDVEdWRmVi9uaDZrZXZvdStuQkZlQllNV3VjNGJD?=
 =?utf-8?B?YkZlWWVkclRZWmdjYkFvWUNCTjUxVUhDd2RFUUtlN2owUmZtL29Fa2pudVpt?=
 =?utf-8?B?aVlJU3JtMmVzMWFYaSsyOUNyMzFDR3ZjN0pIbzIrbnI3cWh1dWNJQ2FYUnV1?=
 =?utf-8?B?ZTlGaWJmdXY4MDZFcHVLQS9KVzc1L1ZTZkhPNnFPQzdXdVlyRXFuSS94dndL?=
 =?utf-8?Q?dfkj9pkEAuu6fT4IzNh7XubBR?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068f24f6-c67c-43bd-d208-08da86426378
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 02:34:52.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxE8zfiSO9EtablOX+3lsEJ6nByzxObrm/UupvbLEQo4Mzl141vVZm56KiOhYegD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3240
X-Proofpoint-GUID: OBnp4zT88fOP_337zmLKMeoOHZEWiChm
X-Proofpoint-ORIG-GUID: OBnp4zT88fOP_337zmLKMeoOHZEWiChm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/22/22 2:43 AM, Eduard Zingerman wrote:
> Propagate nullness information for branches of register to register
> equality compare instructions. The following rules are used:
> - suppose register A maybe null
> - suppose register B is not null
> - for JNE A, B, ... - A is not null in the false branch
> - for JEQ A, B, ... - A is not null in the true branch
> 
> E.g. for program like below:
> 
>    r6 = skb->sk;
>    r7 = sk_fullsock(r6);
>    r0 = sk_fullsock(r6);
>    if (r0 == 0) return 0;    (a)
>    if (r0 != r7) return 0;   (b)
>    *r7->type;                (c)
>    return 0;
> 
> It is safe to dereference r7 at point (c), because of (a) and (b).
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

You can remove RFC tag in the next revision.

LGTM with one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c1f8069f7b7..c48d34625bfd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
>   	return type & PTR_MAYBE_NULL;
>   }
>   
> +static bool type_is_pointer(enum bpf_reg_type type)
> +{
> +	return type != NOT_INIT && type != SCALAR_VALUE;
> +}
> +
>   static bool is_acquire_function(enum bpf_func_id func_id,
>   				const struct bpf_map *map)
>   {
> @@ -10046,6 +10051,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   	struct bpf_verifier_state *other_branch;
>   	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
>   	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
> +	struct bpf_reg_state *eq_branch_regs;
>   	u8 opcode = BPF_OP(insn->code);
>   	bool is_jmp32;
>   	int pred = -1;
> @@ -10155,7 +10161,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   	/* detect if we are comparing against a constant value so we can adjust
>   	 * our min/max values for our dst register.
>   	 * this is only legit if both are scalars (or pointers to the same
> -	 * object, I suppose, but we don't support that right now), because
> +	 * object, I suppose, see the next if block), because
>   	 * otherwise the different base pointers mean the offsets aren't
>   	 * comparable.
>   	 */
> @@ -10199,6 +10205,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   					opcode, is_jmp32);
>   	}
>   
> +	/* if one pointer register is compared to another pointer
> +	 * register check if PTR_MAYBE_NULL could be lifted.
> +	 * E.g. register A - maybe null
> +	 *      register B - not null
> +	 * for JNE A, B, ... - A is not null in the false branch;
> +	 * for JEQ A, B, ... - A is not null in the true branch.
> +	 */
> +	if (!is_jmp32 &&
> +	    BPF_SRC(insn->code) == BPF_X &&
> +	    type_is_pointer(src_reg->type) && type_is_pointer(dst_reg->type) &&
> +	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
> +		eq_branch_regs = NULL;
> +		switch (opcode) {
> +		case BPF_JEQ:
> +			eq_branch_regs = other_branch_regs;
> +			break;
> +		case BPF_JNE:
> +			eq_branch_regs = regs;
> +			break;
> +		default:
> +			/* do nothing */
> +			break;
> +		}
> +		if (eq_branch_regs) {
> +			if (type_may_be_null(src_reg->type))
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
> +			else
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
> +		}
> +	}

I suggest put the above code after below if condition so the new code 
can be closer to other codes with make_ptr_not_null_reg.

> +
>   	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
>   	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
>   		find_equal_scalars(this_branch, dst_reg);
