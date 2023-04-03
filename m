Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F86D3C48
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 06:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDCEFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 00:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCEFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 00:05:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DCFAF2E
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 21:05:45 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332LvxP1032046;
        Sun, 2 Apr 2023 21:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=r70VuzeXWgetKtSQ6wBvxUaVelefkW32+znNpeL8rbc=;
 b=EnZ5CLhWgmaU4o+tXnLW2nHFFm12uxJn8DFjeSq2XSZS+SQOxceR2rCjxYUA9wokc3wj
 Sy8sSEncQjnwj8skro0p1MK7iZGiRgpVaiojvhEbSi/vPSKuU1iBGIRYgMI4NYOg6UmF
 InHlCmsAiDsO6N25osTUk6b+GxHbg3h6kB+6g1MOSiNsBg4cE4YMBAADEUMBGgnyRoEz
 0EDJ6xD9SOD/UPGM3aRM+naTcRMF3qoapFVbV2aDo3chh4lfH46SerQ7E9n+agYCwKBW
 Po9KF6u18LafS2lGLa/Rjs8jtP9btiHylODyQVsG2pJzn5Mr3uIANiGWvdBlA6Xc6fV2 Hw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ppfxsfevt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Apr 2023 21:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+gBCB2ODnuwzIOXhs84gBQ2U6p3ugtktSVZd1rBkdhDEpYa1r9CzOkQg/7zpmHKh0dTrOm33dN8G+UJOgcs9lWuJLQ1bcgLaM90kwmDDmeChL8/aP1jFInCVZHSEm6rYUDqtATEk8Dw/Pj9vRI6EW3C6gCHzlanDLQCHwrTI1YEB9vlaE3KbkQZSA4ybDvhUihIjzpYFk6OoRWaHR0BXvCVaoqAG7WDWWRzXFTLpQ3Arqy7TPk0cQ3zcfm1T+7ykU9hKpUnY7J27l6B8mzx/uFIJaI/AnQqWDXSf1BtOQGB0Cjn2xUVjsDlMmUS81MleyYBAkDy+DnmZieaMOXOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70VuzeXWgetKtSQ6wBvxUaVelefkW32+znNpeL8rbc=;
 b=lvxdhAuI3lC9rKIdRVlJoVhJJNvRvhhn1isTbzWV9hAhYjCtRDxEY2swWiIx4gOXa79oVSv6AK9+FoXdbhho61jWCI9kXl1Q6VOl2fhSCGqOqaB5nT8lz0fcbDwBOL9zkdPwj4aEuQmTQM9fm2/383hKNcvTZHMhCphsVYJY/VTCKgzj6wWBe1aFs0Jypg1I1qKXmt2pavCwz59kKx/ojiJZycHtpekL/iGs7Zvq8xB3LJMaQMN7KDC1wnRtDSL6wRsPTVzMJMEscu35PSqFZyk+vnmt2LdToi7a/nPqXhPU/jpjzHJSH/iqua74iKNNn1qnS+VwFwvcKT6YfesYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5305.namprd15.prod.outlook.com (2603:10b6:510:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 04:04:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 04:04:57 +0000
Message-ID: <5a9dd246-9c56-6e36-94fa-fad743213d9b@meta.com>
Date:   Sun, 2 Apr 2023 21:04:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055625.92148-1-yhs@fb.com>
 <7a5563bbbb29288588413c551effa6bca90e0670.camel@gmail.com>
 <8adcc374-8128-501a-555c-5f26f7e44746@meta.com>
 <20230403014838.vzkfeq7qjqrp2rbr@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230403014838.vzkfeq7qjqrp2rbr@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c7ff78-6f12-41ee-d6dd-08db33f896a3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0eDRUjdh5hXbF6CMIOYQk3Wjp0vzhUE8pScqcmbmDyi5ZrrRIPJe19GNF0FPuQIN6lcekHbvRDfbBZWot9YROCMMdWVExCnHYKZSOrEHiB0e645NaUIg2lh+bstGHeXkslo6/0/tvuKuzrhpoigIq1Nn4gJougHLe+zSoKvdPHJszjm4xhXvtCKgHbO0MKs4ttYtokPueFNRFxYFuj4LHh256whAO3r88A64CLx+zvAfiXukHcDHe3OQWtqt+hPsfFvvt5APojOnoHjmU6d/XKJJofNtdNFgRLc0qKd+CDGR96CcWPYDkEVAJ+OI+5rUTZMonaL1qr2tK+Hvsd7qgWWrs20R6dI+oc3/PdilfN0+c69Bx0Vo2HTbpRXUfu3ZgPBOLUxXre6XeHBEmsObQF0EE3mc8tW42s1TXBX74F4VGlMK7uqVoNSI6nLczB5UimNsAWWg/jy6gPg/5qAD0BgKa+XNt5SsP1P2zunKpaFBihZ3iHhBuGmWKR4Vjr0HVMt3CTDQ4tb90LdR2ib7jlwYoOMb9VJN16SSyVP6VW3VN6OxPr2axsRfmty53zLxDXYqe6VOg1jdpW0oG1zEJ+QI62u2H7DsKlGdmSmv6jTy2V3tGeJ2BBGLDv2Q/9yIaHow90Hgx7vOTUOEG9NKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(2616005)(53546011)(83380400001)(186003)(6506007)(6486002)(6666004)(6512007)(8676002)(6916009)(66946007)(478600001)(66556008)(66476007)(4326008)(41300700001)(5660300002)(38100700002)(316002)(54906003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElFZHBvRHl4WWpIWEMrUnRiNFgzenpMT3Qxd3ZvL3FLMEY0anZ2Y0NUZDJX?=
 =?utf-8?B?RDVUeEU4c3IwRWZCMVB4MWZpdE9GdDhLNjVHeDJ2eHZmWnZpK0dxQktpUE1h?=
 =?utf-8?B?NXpPTkFhTHAxWXcxYzBKbUNPeGJnMmdFVzRjM3VrbGNKSGZSMWdFQW5Zb3k3?=
 =?utf-8?B?NzUxQ0tGVG1Xa3ExekJzemM4VkdNRHp3MVZHS2g1MkcvUXpjMXpZSjRPaVBq?=
 =?utf-8?B?OWZGaWpGcHM5Zk8zZUVxdSswR0pPcmlOTTFBMDUyemE5RFRBdXlZRC9BZjFi?=
 =?utf-8?B?UlNVQVFEd3Joa2hiMHdjcWk1WkowV1JlNm5mdWlSQ2xEQ2NlTk5oZldMZDl5?=
 =?utf-8?B?dmtjRTlqYUVmV2F5YkRGWmQ0d3JBU1hkNnpsdThKcVZaOHpUQzFDWDkxK1Fk?=
 =?utf-8?B?QVBOQlJTbW1qUnJmN1ExLzFOY1A3SXdBVE9aZDA5eE9NclFOSVpabitpMGx1?=
 =?utf-8?B?a250MGU2NFBrdlhTWDFzRy9lay9UWHNXdkZiMUNadzFBZnc0S1UvVmZTOTdn?=
 =?utf-8?B?UjhpU3ZNNkFTdUFSYVVYK2h2Ukk5dXg0ZEY1UW56Z2s2RVFXb3FMTlZFZCtK?=
 =?utf-8?B?WFJwUkQzTmlORXlHU3d0UjhkbEt4Q083b0VpMmNwVUhsdGZvdkFGUFExbDdO?=
 =?utf-8?B?R29tK09taDNhdlhGbW84RFBmaWt1QW5VRzdONGFtQnpicW1HOW5UbzVCVTNE?=
 =?utf-8?B?WDNUOTRUMlB2RVZiV3p4djlPQ2RSS05qb2JMNkMzeXBxbnRMYmtlN3ZUVGRS?=
 =?utf-8?B?SkxoQ0hoMFA3ZVJsb3ZwcWsxcmpROCsyUTZJS0g4bzdyZFpxdlE5dDdLeUdu?=
 =?utf-8?B?cFIwWElXY2hCZmF5ZGt6T01KMWExRjIvQkRrS3BWN2ZNRlBwOG00Z0JLbi9p?=
 =?utf-8?B?UTB2MS9VZUdYY0o1b1orWDdSVzNGY3ZRR1hNWldWUVB3T0M3VDcxdUVQREdY?=
 =?utf-8?B?VDNPWlRHY2dwSmx3aUVVcUtaK0xwd25XR1NRK1h2aWJrRlFKUEhnY1ZsMmJR?=
 =?utf-8?B?cndvbkQ5VWxIeThlRG5EemdFLzRvam5nMVhwVG1sNWRLbmFyU1JDSFNmK3oy?=
 =?utf-8?B?QmtWUXgrSk1jRG45OHlWazVqM2JPWEhIUFRiSVJ0SHVxNEhFZWJoOG8zc0pZ?=
 =?utf-8?B?N0psUENJYy9YY2ZlN3k3bmNSSHhCc2pvQkZIelNmOGw1WnM0Nm96WHc4Zllx?=
 =?utf-8?B?dGd1c3dIZUZMb250cTl0UGVscEhOT081T3R0bVBlMHRtSU1JRHhRYkdvUTRh?=
 =?utf-8?B?RzZKSTFYdDJLWmVmUWdlNkpMb1BTZERUL2hUNnVaNnNzU2NwSFpNZDJ3QlpV?=
 =?utf-8?B?Qkk1dkJqLytCZ3ZLZHF1NG45QjV6U3hxZUgwdlhOSFpER0JEL05QYkdjNDh1?=
 =?utf-8?B?UnRmYk9JaE9WeFNxSzQ2WFhrcDg0UkNJeDA4bWl4dVZFcEw2KzFhVDNhMnla?=
 =?utf-8?B?cnNQNzBLZjQvMnM5M3ljY2VHeFNOWERqYzZGTGxDdmx3ZDBQNlh4K3ZnSUlK?=
 =?utf-8?B?cklMV3d1Z0s4SkZ5bXRZQS9OaVJ1b2VNU0pJb0h5cUNIcnNBRjR6alFTZU9l?=
 =?utf-8?B?Q3kvaFV1T3R1QXVLVVg4RjJCdmVZSWl0aUhpQXFIVy95dzEwbTlTaExwRlBl?=
 =?utf-8?B?TWxwaUZJR0NyOXhtK1J2L3JkY29OL05yZFlKbGRIaUV1SWlUZHF4UjVWYTlN?=
 =?utf-8?B?a3EzTnZ4eVdzOFVSeVFMY0dQQzB3QkR4c2NJQXptekdzNkJ3WVVpWGRaOTdB?=
 =?utf-8?B?azFHM3FGZlI3dWVFMlFVNlQ3ZnZjYVg4ejNNck4zaE5QaUNvQmFqeFEwQ2tB?=
 =?utf-8?B?VFhycE9nY0xhaGZrbThhUCtYUzlxVnlTT01abGpvZkp6UjliYVJZWjZTNUE0?=
 =?utf-8?B?ektMdGZpZno0L2Rra1dJWkk2aHNsRHdxZ09rWmF5VTFMSjI0R25PNGo0b3Mz?=
 =?utf-8?B?WG8vVlB2ZGV4YUtBWVVpdzVvd3RUTG14TG1JVE5weGl6U2pQTldBRXhOcUY4?=
 =?utf-8?B?VTJTbWlpRW9GVWUyeWRibkNQUTBzM1FUalRWYndXWTVRbERIYlpNSGU5eHNk?=
 =?utf-8?B?bGNZeTdteTdnZHdsUFpQcDlXdmc0bUJLQjN1c1diWmR4Vy9WMU9vTnB0R2FM?=
 =?utf-8?B?ZHhJeFdSUXFPeTdrQzJoTmI1Q1k5ZUpPQWw5QXRFOEl6N0VZNVIxNDQvcW04?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c7ff78-6f12-41ee-d6dd-08db33f896a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 04:04:57.6285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwohbAulvPf9jl5T9FclTlGUoNtZV112umgEeOKazfx9msNuIQxuj1em6Ah5o0q4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5305
X-Proofpoint-GUID: iFWfASTwFn-o2HenE98lgw7bet1IvOHD
X-Proofpoint-ORIG-GUID: iFWfASTwFn-o2HenE98lgw7bet1IvOHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_01,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/23 6:48 PM, Alexei Starovoitov wrote:
> On Fri, Mar 31, 2023 at 04:39:29PM -0700, Yonghong Song wrote:
>>
>>
>> On 3/31/23 2:54 PM, Eduard Zingerman wrote:
>>> On Wed, 2023-03-29 at 22:56 -0700, Yonghong Song wrote:
>>>> For a loop, if loop index variable is spilled and between loop
>>>> iterations, the only reg/spill state difference is spilled loop
>>>> index variable, then verifier may assume an infinite loop which
>>>> cause verification failure. In such cases, we should mark
>>>> spilled loop index variable as precise to differentiate states
>>>> between loop iterations.
>>>>
>>>> Since verifier is not able to accurately identify loop index
>>>> variable, add a heuristic such that if both old reg state and
>>>> new reg state are consts, mark old reg state as precise which
>>>> will trigger constant value comparison later.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>>>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index d070943a8ba1..d1aa2c7ae7c0 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>>    		/* Both old and cur are having same slot_type */
>>>>    		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
>>>>    		case STACK_SPILL:
>>>> +			/* sometime loop index variable is spilled and the spill
>>>> +			 * is not marked as precise. If only state difference
>>>> +			 * between two iterations are spilled loop index, the
>>>> +			 * "infinite loop detected at insn" error will be hit.
>>>> +			 * Mark spilled constant as precise so it went through value
>>>> +			 * comparison.
>>>> +			 */
>>>> +			old_reg = &old->stack[spi].spilled_ptr;
>>>> +			cur_reg = &cur->stack[spi].spilled_ptr;
>>>> +			if (!old_reg->precise) {
>>>> +				if (old_reg->type == SCALAR_VALUE &&
>>>> +				    cur_reg->type == SCALAR_VALUE &&
>>>> +				    tnum_is_const(old_reg->var_off) &&
>>>> +				    tnum_is_const(cur_reg->var_off))
>>>> +					old_reg->precise = true;
>>>> +			}
>>>> +
>>>>    			/* when explored and current stack slot are both storing
>>>>    			 * spilled registers, check that stored pointers types
>>>>    			 * are the same as well.
>>>> @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>>    			 * such verifier states are not equivalent.
>>>>    			 * return false to continue verification of this path
>>>>    			 */
>>>> -			if (!regsafe(env, &old->stack[spi].spilled_ptr,
>>>> -				     &cur->stack[spi].spilled_ptr, idmap))
>>>> +			if (!regsafe(env, old_reg, cur_reg, idmap))
>>>>    				return false;
>>>>    			break;
>>>>    		case STACK_DYNPTR:
>>>
>>> Hi Yonghong,
>>>
>>> If you are going for v2 of this patch-set, could you please consider
>>> adding a parameter to regsafe() instead of modifying old state?
>>> Maybe it's just me, but having old state immutable seems simpler to understand.
>>> E.g., as in the patch in the end of this email (it's a patch on top of your series).
>>>
>>> Interestingly, the version without old state modification also performs
>>> better in veristat, although I did not analyze the reasons for this.
>>
>> Thanks for suggestion. Agree that my change may cause other side effects
>> as I explicit marked 'old_reg' as precise. Do not mark 'old_reg' with
>> precise should minimize the impact.
>> Will make the change in the next revision.
> 
> Could you also post veristat before/after difference after patch 1, 3 and 5.
> I suspect there should be minimal delta for 1 and 3, but 5 can make both positive
> and negative effect.
> 
>>> +		if (!rold->precise && !(force_precise_const &&
>>> +					tnum_is_const(rold->var_off) &&
>>> +					tnum_is_const(rcur->var_off)))
> 
> ... and if there are negative consequences for patch 5 we might tighten this heuristic.
> Like check that rcur->var_off.value - rold->var_off.value == 1 or -1 or bounded
> by some small number. If it's truly index var it shouldn't have enormous delta.
> But if patch 5 doesn't cause negative effect it would be better to keep it as-is.

Sounds good. Will further experiment with more tightening like 
difference with a small +/- number, which should further reduce the 
number of processed states. But as you said we can decide whether this 
is needed based on how much it will further save.
