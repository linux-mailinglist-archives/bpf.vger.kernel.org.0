Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074E6D9DF9
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbjDFQwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbjDFQwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:52:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D583E2
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:52:04 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EEk6t032694;
        Thu, 6 Apr 2023 09:51:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=42Qv5AE7/phnGNBTLZW2Uq49M16xc86s975R3YkXUk4=;
 b=KIJ2CeKLJjn0FGWEVydA1ZyNo4ghuGYd/jbj7yMhcNinDHDtw87RQlLcnJyZp81hLEw2
 6rkMTdYJLvDfgXYfguOKPX/q4DsFXo18vG65UZ8ciJrGwX0EqmxWbIi5ATtX+gGjsU03
 OrIWswtSppo3GrO51Ac54rpoQsb0TTX7yx1pXo/+eCMAu0Ed+eMsNdsWCQ/Cf41m8l+b
 CxcuplV3YlMbEX8errhwD1e3Dsdw1jpDHolNZ5iUi9ohFJ8MhKMvAuuTp7c55ssxloUf
 HSQhrnU8MZzcaamln7tE7NSn4M9l4BTp+MQnzKtXWGLWrgiFPT7sqrsm/+7BLJJEDyhT 1Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psynn151m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 09:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOyQOk4rwruJVCESF4fHGhEf0qnB28EJeTGonuByA7DiBZ8GdZ1whWbt0lEaLo0bTYu79GGg1Kc0wqBTug2O2O0JaEAeJkWJ7W03AfunxUKy0y7Zmc67dsVxak0bxxaBmHpqa0cu08TePXe4kPEQr6W7xtb1oOJQCrcXYI5d03ToOIAkuUX4MMeap4Z9gWDoCjMwARNekk5VHkMuDOVaMEltPkS6l6YLmk3VrbAzXzGQIoRgiP+tH6pHAWDtWzdOKnBVJsOoylFXBkPYOn6iBNLjIEXn+VtrBqmgeUGgxojBius1+Mf9EekoXdtBv5YsogfPaRaDxrrfLJMef59rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Qv5AE7/phnGNBTLZW2Uq49M16xc86s975R3YkXUk4=;
 b=DDdHyexlM19QWm9hDhoypxjx1dkCWqh5sSvGGh8Lfuh3dQiblLeiVKbVcI1BXzf2x2YDJofn7fpUxrs7ukgXFrJwos1De1aWDIF4/jhWcen56/1BN5W0fASywj91tKlPWnO/ypXXH7CW4o5528sFQHPKU3C/zNW6+AkZbcmKHW26d0IptocXSdb8VptG6/xAUwcwmJHY8c6P+UJ7/zCcYIaYy+owE4ddJoB80ARgGyz7ubWUhRx9DBtsnVVYPhwWGX4cBHhnrAS8jWbTtYLlejVzOvuyGaGycUUPsuD8N+zNQwJ6NcNdMiun2vYatCwSQGSh9ue34tcH7bMqak4X4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5269.namprd15.prod.outlook.com (2603:10b6:303:16a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 6 Apr
 2023 16:51:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:51:47 +0000
Message-ID: <88ef7544-31ea-4d37-a145-375812657aab@meta.com>
Date:   Thu, 6 Apr 2023 09:51:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 3/7] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055615.89935-1-yhs@fb.com>
 <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
 <CAEf4BzYLchw-SKxStofoq0bZYAHwGxrOXO-YY17UOMXZW41yeA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzYLchw-SKxStofoq0bZYAHwGxrOXO-YY17UOMXZW41yeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 821a5e98-83f6-4e89-c398-08db36bf35ea
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1w9SNbSvyDlEywuwB2jrqGI572eRqeNwXlAsYqKOB6q9bTsMCpjB+ofzjeTJbUv0bsJRrn3gKF3zeyN3lhx5wnoZUBwf4mSXfjlfS1L5k963X19e2aqnj7ayeM4HtElEmv9GFpeXX+u1Zv73n7SiWw4dN9JzcXzZWV5QwMlJg023lIG06SsG0PIDLzSP54UAmJ3+0s9sBGJSlTTPt/FTIP6X4nUKMd9yY1cUjmKjgxp/ou+fRkos7l9YosWtCTrD4sM/FR8bV3JxpQ6p9X11haQt8NPOUk+JYYEfJ6UJoOtjpLCnylhru/M0RmdA+HksHYEg8osmthG7UCxYdqNhgI1JR9P86R/zcGwH8puAaI02hnlbLqtfffPDNXV107XqkI6YEiwGTOKh1EGRGiGDWEwVXcDL6X9ZbW9FjqktKxXAw7bAb7IyA4GRxbjYUyjil8Sl8FTzmzTTDP9z68cxt9RC8oB4UJ9iOlW2zOgvEq27yhOP+27zlilD4LkDIa1Zlga/J/nNbLyGgjqKDxkmQqbahlPFL1CNkz3mti9Ujd4YAfy+L1crCDPd+69dYs9iW3e6H7lfMkbeQh1W73Hgv1PLAEAuj62WpGvQdIYptlBcBlkv8SIb4kjJZjIhWBucjhY2h1N3a3dHEz0yjQNRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(31686004)(478600001)(6486002)(110136005)(36756003)(31696002)(38100700002)(6636002)(5660300002)(316002)(86362001)(2906002)(8936002)(41300700001)(66476007)(66946007)(6666004)(2616005)(66556008)(53546011)(8676002)(6512007)(54906003)(83380400001)(6506007)(4326008)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFQOW1qQm0wdjNDRjJLQ3E2YzhBbldCMkVpbk8xMXdjM25NenRqVE5tZWF5?=
 =?utf-8?B?RjBUa0pNT3lyKzd6Ykt1MnlaNjh4Y0R5cjhvWENnaVJ4T2poRWk3dWtrTksr?=
 =?utf-8?B?QXJmSUJzWFJTYktxTENHWGdXOFBXNDZnbzVueTRUTlBDR0kxa0FLTXhIV1FK?=
 =?utf-8?B?VlZyY3BzQ3lqK2tYUTBMcnRieVlZUFJBSlhvWnRCV3V6L0V3VGZjcHN3UUVK?=
 =?utf-8?B?WXhTOGRQMGpzSHFRUXNwZUU1UFM1VStOSWdaSkkwOVBnUWhnNU9MSTFDakp1?=
 =?utf-8?B?U08wWkZQcFdSNmJiNE9CWGt4eXBPaWQyWlUzM2h0UUgzY2VibUVnYXFiQnF0?=
 =?utf-8?B?dzBJQm82VnZTZ1A0dW1NV1dqbzdnL3BxQ3lIanFSZlN6RTJqNllDWEZYb0Fs?=
 =?utf-8?B?K2loMHFxMVdDM3pMZUk1RG1yOFQ4SEhRWnhSQzRiaktWSlV5RUJraW1OZ1ph?=
 =?utf-8?B?U3lVMUNFcHEvUzhkWmE2aWh1UGcxMEdjVkRQZzJ6M0tVSktMbVlFcnlnYXp5?=
 =?utf-8?B?azhEYjZZaThGbUpUS1kwaElFLzNaOVdESTI0MWU2RTU4RWhqYWFhNWNyOGNi?=
 =?utf-8?B?M3hWdFRyRFgxYnV5dEhIaElwendKSmxQeU5Xd2FudUlUREpjVW85TVhRUmF3?=
 =?utf-8?B?c3ByTGNnT0FHbkhVR1dMVWJrMlUyUnY5aWRtUStTNTZBa3RoY3B0S3MzQS92?=
 =?utf-8?B?bmQ2SnFkZXVzZWVPM0hBeHdBMDh1RXNxaUNmazZSb2tlQitTZmt6dTgvRkhP?=
 =?utf-8?B?NDJZdjlVSnhNRnZOUWswNzJDMTVXRFFKTVVOUHJzWUJwbmxWamlMTTFiYnZY?=
 =?utf-8?B?ZmFDRER4STJhT1NuMDVsZHIyVm9kWTZKbkoxMEMxNTlZd1g0ZFdOYjBNbjI3?=
 =?utf-8?B?OE52YzJ2aE1LTThLQ29rRG9QaUo0N0NCVm1LVUp0elg4TUJWbzhBeXJrNU5W?=
 =?utf-8?B?TVZVOTRvWVZzTUNhSTVBbXRDMHJ5OExxUFlCamNHdCsva01OQTFmZmZqcUpV?=
 =?utf-8?B?ZksxK3kvc3Y2Wk5peWozZ21aS2xoa01tZ3VPeGZXekc1Kzh3NGRMbHBWV1d0?=
 =?utf-8?B?OStlbmZaMExXS0FUNHZ5ZXpyUG94dG54dmw4N0dkTU5NZHlRZTNjSzE5Z2xM?=
 =?utf-8?B?aTBYVFZHK2E2bEVHVkt4V0Z2dlgvZHZuZG1aSUVuWnF2R3lWcTVVNjJKeGxr?=
 =?utf-8?B?b2dHeUtsQVR6bDZuVmFwSTUvbEF4dCtOeG05SjAvbUpQQ3FUZnA4Y0R3UVlX?=
 =?utf-8?B?QnM4cjlhTUViU3grOFZpeUk1MmNrVXJRTnYxOTlEdXVxYmJDRGxxWTU0YldN?=
 =?utf-8?B?blR1aW9ERXV6OVkrU2I1THJnNWp4VzBvSnluaHNZSzJ0VWd0K3JjRUtiWmg0?=
 =?utf-8?B?Z2VkejBybFJQekY2L25yTitkTFp3RHpRSU01czYzdVZmbHlRMDlUM1lwZjZE?=
 =?utf-8?B?T3R1M0lsaVhYQm5jWlVKRk5XN1hNMjBUMGJkN0MvN3ZnWW5FYXByUE55K2tn?=
 =?utf-8?B?cDJQUG0zakJtZ3RTYVFIMWZCeE9rVU0waGtmN0g2YXZCQ0VTNDkrU1daVTZr?=
 =?utf-8?B?WTVaN3dieEJZcU8yTFJlTkFwaHJwS0E5dHY3Vm1yQURWQmNURXFIZ2xyZ1h4?=
 =?utf-8?B?eE1tbnJySk15WGZodEp2bGlqRGVrbUlxajBVeCtQQXovUWFVcGMxSmZ1ck5S?=
 =?utf-8?B?WWNSUnFFdEZYcnpLbnJzUlp4YjQyOWxRTVdBRDhUVmdpSmwveThwWTZkTzBy?=
 =?utf-8?B?YkF2WWpld3JqaG5LT2FRM1had2FUbXIvTnZUWnJtaXdNRHZGUVRvWWZ3UXRG?=
 =?utf-8?B?TlVFRFZwUVllRW80MzEyZVFPc2xGVnZoS2d2VXVDcVJLZWhnTmNqNnhvYzB2?=
 =?utf-8?B?UU5KYlcyMlhFR1E0UTdmRWR2RFZKSlAzNVhCOW1wdzlsQ0RMaFVtSVM3TlRM?=
 =?utf-8?B?NytGdUsvaHNwODNyOWUweGdNQTF1TEQ0SSs4OTRqL0c1WUxCZFpnY3RZSkg3?=
 =?utf-8?B?WHY5aFZ3MzV0dTYxOHVDRXRyWlhqODY0RHpHQnVKODYzWGQ0UjJYWE5HWHJu?=
 =?utf-8?B?VnB3UWgra1hsR2Z2WVE3eEVMZFFyTW1vRDk5MjA3NG1RMlVKcWlNdTlCb1VO?=
 =?utf-8?B?blBEcjlaNUlRUXBvcDBxNVI5WlBUU0JHVzdlWEJhQzlFQ2FMd09kV3k0UkNG?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821a5e98-83f6-4e89-c398-08db36bf35ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:51:47.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 843FlEpy4RNm+jYUZ1Y97pDY2v9p/4YgnKjfGbCH9GCOS0BJvP+h3Jjm/cu0o3Qe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5269
X-Proofpoint-ORIG-GUID: MaSYcj0fK6ItII40gBbZzCiTIPHSq00h
X-Proofpoint-GUID: MaSYcj0fK6ItII40gBbZzCiTIPHSq00h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/23 3:04 PM, Andrii Nakryiko wrote:
> On Thu, Mar 30, 2023 at 3:55 PM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>>
>> On 3/30/23 1:56 AM, Yonghong Song wrote:
>>> Currently, the verifier does not handle '<const> <cond_op> <non_const>' well.
>>> For example,
>>>    ...
>>>    10: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=scalar() R10=fp0
>>>    11: (b7) r2 = 0                       ; R2_w=0
>>>    12: (2d) if r2 > r1 goto pc+2
>>>    13: (b7) r0 = 0
>>>    14: (95) exit
>>>    15: (65) if r1 s> 0x1 goto pc+3
>>>    16: (0f) r0 += r1
>>>    ...
>>> At insn 12, verifier decides both true and false branch are possible, but
>>> actually only false branch is possible.
>>>
>>> Currently, the verifier already supports patterns '<non_const> <cond_op> <const>.
>>> Add support for patterns '<const> <cond_op> <non_const>' in a similar way.
>>>
>>> Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing signed and unsigned, variant 10'
>>> due to this change.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   kernel/bpf/verifier.c                                | 12 ++++++++++++
>>>   .../bpf/progs/verifier_bounds_mix_sign_unsign.c      |  2 +-
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 90bb6d25bc9c..d070943a8ba1 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -13302,6 +13302,18 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>>                                       src_reg->var_off.value,
>>>                                       opcode,
>>>                                       is_jmp32);
>>> +     } else if (dst_reg->type == SCALAR_VALUE &&
>>> +                is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
>>> +             pred = is_branch_taken(src_reg,
>>> +                                    tnum_subreg(dst_reg->var_off).value,
>>> +                                    flip_opcode(opcode),
>>> +                                    is_jmp32);
>>> +     } else if (dst_reg->type == SCALAR_VALUE &&
>>> +                !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
>>> +             pred = is_branch_taken(src_reg,
>>> +                                    dst_reg->var_off.value,
>>> +                                    flip_opcode(opcode),
>>> +                                    is_jmp32);
>>>        } else if (reg_is_pkt_pointer_any(dst_reg) &&
>>>                   reg_is_pkt_pointer_any(src_reg) &&
>>>                   !is_jmp32) {
>>
>> Looking at the two SCALAR_VALUE 'else if's above these added lines, these
>> additions make sense. Having four separate 'else if' checks for essentially
>> similar logic makes this hard to read, though, maybe it's an opportunity to
>> refactor a bit.
>>
>> While trying to make sense of the logic here I attempted to simplify with
>> a helper:
>>
>> @@ -13234,6 +13234,21 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
>>          }));
>>   }
>>
>> +static int maybe_const_operand_branch(struct tnum maybe_const_op,
>> +                                     struct bpf_reg_state *other_op_reg,
>> +                                     u8 opcode, bool is_jmp32)
>> +{
>> +       struct tnum jmp_tnum = is_jmp32 ? tnum_subreg(maybe_const_op) :
>> +                                         maybe_const_op;
>> +       if (!tnum_is_const(jmp_tnum))
>> +               return -1;
>> +
>> +       return is_branch_taken(other_op_reg,
>> +                              jmp_tnum.value,
>> +                              opcode,
>> +                              is_jmp32);
>> +}
>> +
>>   static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>                               struct bpf_insn *insn, int *insn_idx)
>>   {
>> @@ -13287,18 +13302,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>
>>          if (BPF_SRC(insn->code) == BPF_K) {
>>                  pred = is_branch_taken(dst_reg, insn->imm, opcode, is_jmp32);
>> -       } else if (src_reg->type == SCALAR_VALUE &&
>> -                  is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
>> -               pred = is_branch_taken(dst_reg,
>> -                                      tnum_subreg(src_reg->var_off).value,
>> -                                      opcode,
>> -                                      is_jmp32);
>> -       } else if (src_reg->type == SCALAR_VALUE &&
>> -                  !is_jmp32 && tnum_is_const(src_reg->var_off)) {
>> -               pred = is_branch_taken(dst_reg,
>> -                                      src_reg->var_off.value,
>> -                                      opcode,
>> -                                      is_jmp32);
>> +       } else if (src_reg->type == SCALAR_VALUE) {
>> +               pred = maybe_const_operand_branch(src_reg->var_off, dst_reg,
>> +                                                 opcode, is_jmp32);
>> +       } else if (dst_reg->type == SCALAR_VALUE) {
>> +               pred = maybe_const_operand_branch(dst_reg->var_off, src_reg,
>> +                                                 flip_opcode(opcode), is_jmp32);
>>          } else if (reg_is_pkt_pointer_any(dst_reg) &&
>>                     reg_is_pkt_pointer_any(src_reg) &&
>>                     !is_jmp32) {
>>
>>
>> I think the resultant logic is the same as your patch, but it's easier to
>> understand, for me at least. Note that I didn't test the above.
> 
> should we push it half a step further and have
> 
> if (src_reg->type == SCALAR_VALUE || dst_reg->type == SCALAR_VALUE)
>    pred = is_branch_taken_regs(src_reg, dst_reg, opcode, is_jmp32)
> 
> seems even clearer like that. All the tnum subreg, const vs non-const,
> and dst/src flip can be handled internally in one nicely isolated
> place.

I kept my original logic. I think it is more clean. In many cases,
both src_reg and dst_reg are scalar values. What we really want is to
test whether src_reg or dst_reg are constant or not and act
accordingly.

