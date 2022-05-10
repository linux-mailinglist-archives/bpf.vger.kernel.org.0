Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1265226B3
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiEJWMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiEJWMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:12:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB94268EBB
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:12:07 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AJU0Ah007801;
        Tue, 10 May 2022 15:11:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gkxXfoGzSTJUe8wc3owCzJfYJMXqJIYRDRdN8jmel+o=;
 b=aX9o80YavF4zCWM8/V3O9975+/eag6s1nQXFvdci2LdrFoDMgO9gnpQJTxkyxBYObHnU
 af2KybuNL2khGn2e8ShjyY4ZsczV+n7FE/3ZZWRsW2yAD6gp04nDu6p+XUVt+NJR0Fom
 TsWNFiDjyTM03THV9/zJjEK72z/2J+2lmFs= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyx8p12vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUpTZgDEL6v7mnbqpkViVeHk1/IejvKBfky8PzMTSudjDNP52AsuVP2hYDi9GcZxIJEIfj1GSVMiIY7YLCcnkL+tIrTPI3hKpKwJFxSxxEiLSepB8d324giVhbeaB5LBVsQIvMIGTYAOSzQu1FROnuEO5SCQ3BGPA4cq/pGJhB1rIPdQm1VQSKfRmWxAma3MfmQTKQcSxuqFdW5DuIaJfYojI4vgW3Ozp1HyR7ZWq1HDfscnyTFnmIUqwU5oHNNAXabEHjWnOxqVpqJujgvL+tYIvzxKy+msvO6ReOFnJMR0VPJT4VVUj7GIIbySLq2ao5FnTvQIlpHYUEENqGT1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkxXfoGzSTJUe8wc3owCzJfYJMXqJIYRDRdN8jmel+o=;
 b=WgU02F71xg6PNTRz8MUUuKeU0m96FHRnixpcz45EKH8YlMjkrLe3A0YhoEt+w3KKD1dJYR5Dscv53bFAmcJAGJ3ApwYRuklvCEA9PJ69UPCxhfqqvkgnCzdMr8vb5qHrffRhXqaPyfEa4AjPjZr3zVY0Ka5QN5N6rWG+drz2XwLgRwOafrllzEDiZ0IOGXVDQ+QOvq5oDVPitFdhQBoeFXU26dNtAw7Z6drmwoOhvcdsOZUeXudG8+oG81y9vQ3wu/byFP+k5P8XfP5IsEGrWnSY8JYXNy0Xgw28lSal+K7ecXL0ps4HpVYQukL7dU8cAselF4SntgcdOpUkdMTK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4601.namprd15.prod.outlook.com (2603:10b6:303:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:11:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:11:28 +0000
Message-ID: <8eef9730-ec70-fa95-8e00-8b2db2b4c099@fb.com>
Date:   Tue, 10 May 2022 15:11:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 03/12] libbpf: Fix an error in 64bit relocation
 value computation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190017.2577688-1-yhs@fb.com>
 <CAEf4BzYYC_QDAM0BpErtmioLUu89t7qUUTVBi2YkBmQ0Lc_vkg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYYC_QDAM0BpErtmioLUu89t7qUUTVBi2YkBmQ0Lc_vkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4c3c2e7-62f3-4d41-017c-08da32d207cf
X-MS-TrafficTypeDiagnostic: MW4PR15MB4601:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB460126A97685CAE64FB13F16D3C99@MW4PR15MB4601.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uv1L4X+5n0Zxj7t4P+LDc+6D3VX3QBPbNDaZ9YYsYT2fpLR8cO/hbxZD6NSfW3hrZuUx55DKI2K72x6QYfDVxTxdZ+VL5K+J7OvbS9fc0JIJfN1+lqnyYOnK6oHXzRxHQJq1phOpJwr91p6HfxMGI13bPrfooy36IVGfXqvuhPWYktwIZF/GaVyxnStJaZT4ghBvO7FKwXwvfIH4ptAlAxRB+dhXH3gyEnNtYNKHgOk3+xen91fIliBj9dKx/ZNgSyRU5RztI/mfUlMSdGghvj41+uTs8P5cLSQY5XuTfkImYPniBHAgzLOwSqyGhSjRBZsIM7qVecCIYJZ/H0n3tdcJzNdMRpz1pxrTzutCK8M/BzBcg+0Wb5REPXQ4QhVPrJmJpeitJJcz+YedPDprxJHXga9nowgs3ymabLbOHPbDUsMPk/BgXt0EAEqbMGg6cTJyP0jfX4TSkkLj9//ElJluVKLlQ4f1GHI60UIHHSQA/mIX1xibrmOV9FiBM74mGIRdq+CscrlGWLTVtZpGuPL8Gjcmmx2fQnQwFwZ4b681UPrSeeYQ2jg9bS6YxZO7FbdR6wkU8FZtZ+4MGhmWLOCFpYUQ1n1OyE4FwqTlu44hiwllFCQEEYMbjDJ5Id28q/NWP0o6AJMrbSFEuCnxEyiH0uvhEKc+nzycNR8gxS6eKHEo9fCIU48TV3BMtx++MqiQe1PJ6LtGDPylUjTRD+kjET4iYPSQ9ypTBCoGoIMjQIS4y4qZwzPkQDidMBvY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(52116002)(53546011)(6506007)(66556008)(83380400001)(6512007)(5660300002)(36756003)(186003)(2616005)(2906002)(316002)(8936002)(31696002)(38100700002)(508600001)(6486002)(4326008)(66476007)(86362001)(66946007)(8676002)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJMWlpwM1MySE9FTmNVRk9JeFJ3eUZmY2Y3TCtPMGYrbTA4TWREYTVONGVI?=
 =?utf-8?B?U1FwT2ZSVDRXc1ptc0JqUTdDZ0lVSWp2a21oY1F6RGZEcllQM1ZmbWJXOXVs?=
 =?utf-8?B?TVY3VDVEbUpVRDhRQkNsL3M5ZVY4UkptQkRUODJwaGpOM0hST1VXdmYyOXF6?=
 =?utf-8?B?Vkt1U0RNYk5BN3hZUTJ2MkdobkxVZ1h6SU92TUpld0w2eHJQQ1NvK1dFeXdT?=
 =?utf-8?B?eFZKVjFXeU5xL0RRM1h2QmczZzFCM09RWmVGTXlJWEZVSU40c3RMYjZpcDVj?=
 =?utf-8?B?b3NhRHBWdDB1bFJpOE04MTIvZWc2dmlaWHdtdXRzUjVFOXZURE9KT0tiRUVR?=
 =?utf-8?B?Vytxbi81ME5JUmFpcFBRNFBVUVpwRktqTGVPVWhJT0hLc0lZSzZFelkzSFQ0?=
 =?utf-8?B?YWdJSGc4S3pINXkxZ0VjZjlwcUVKaWMyajhEYVNJRWpZOGxGeXVVMjVUZko3?=
 =?utf-8?B?VVlQdWRwT1ZkMU9TSmZ0OVNxSGFVNStaWG1rOHBtRGgyb1BydjdlSXdKbkRz?=
 =?utf-8?B?eGJFTDhVekwwS21sbzFacW5VOWlWMXBTK1hsWFhaVldhMWh2T2Q2bEE4Q1JF?=
 =?utf-8?B?aE1MejVPWUpoS0xMb0dHY1FKalQvVmdvdVR5Q0p6NVRHeXNUdkwrdmZWWW1Y?=
 =?utf-8?B?WEc1MjdsQlc1WTQzRDhYSDd4QnVtRjlUeGJkNUVnMWpwYks3cWtLQTFLTThG?=
 =?utf-8?B?Zytod2JEN1VzSC8xdnhOdXJNY0xHQlpTSDBsTEladGJianpmbngxc0ljOXE0?=
 =?utf-8?B?NWYvTEwyRWlvbERZSEFPNmQrRGwveVhneXdqRnhMVGdJMmlsRmpoK3FmalNh?=
 =?utf-8?B?N0VRTlhkbXM0N0xHTHArcUd5a3orYU5KZU5jR2FZOVVDWkRjbnZSb1JVTlZS?=
 =?utf-8?B?NEkwMzI3VDhqMld3WlhPTGE3ZVZrQ1VBVGY1VVRCNEpEVkJYWDMwTzdlQ2RZ?=
 =?utf-8?B?TnQ5QnJ0c3UxVmZnYjFmS3d3VTlldUZ2U0FFY1FoQ2lXN1pjT0JLb01tNE1I?=
 =?utf-8?B?blVES3lWUFpuRzlPQnZOV2ZCNTR1dHhnNy9JcVZtblZIOVJBZkVuV3dLdmtI?=
 =?utf-8?B?WkEvNzI4STBvZGdlS3MzSURSSktLem9Yb0hLM05mOTkzMS9QTVNXcHozcjho?=
 =?utf-8?B?b3crWHUvM0pLcmVsYkNmR240YUprVG0rc0REbTMrWkNNQVVNeDA2VGFKSC95?=
 =?utf-8?B?NlRHRHZyYkkzS0JvaW9PeGtCTWU5elk1eGVDUFA4TktpT21rcTZldzdnc2ZH?=
 =?utf-8?B?U2FrcUplUm9Jd3dHMUxqS0pxSmt2M2V0OTA4bGNTQXp4Y2QvSEpTQXh4dU5E?=
 =?utf-8?B?OS83TzBNZHhhRE9nSWZMNFFsY1poNnNRanNkQkZLVDdZZTdyT1E5QXJmMXdU?=
 =?utf-8?B?OEFkVGs2elkrUHlndXUxYnplRzVvQ2RZeEh6QTVhSk1KNnd1eUtWRzNCb1Bw?=
 =?utf-8?B?cUFWT0NMS2pOV0ZGNTJhNm4xYjlmbzZ0Zm1qcDlUb08vYkxsRVYxOElEZExC?=
 =?utf-8?B?L0tuREdPYUFQYWFFZ1J0Vkl0UXJIOStEWlpOMjB6bnlrZm9tZmxoUWpzR3l2?=
 =?utf-8?B?d1A2R3g2cjJhSER3ZjdMd0VpNkNGL0VhTysyMjNnWnIveHc0N2RWZElXNXlj?=
 =?utf-8?B?Q0ovVEdvanIwQWh5d1plS003V3NNR004MjZGZW1ncGRDRnR3WlBuVGExL1pk?=
 =?utf-8?B?b0RYbTRuNDJlTHEzUjArMDZPejY2dVIyS3I1ZzlLR0pESW1CQTRxZ3hKc252?=
 =?utf-8?B?cHB4QzcvNjNJSjlKWXRDMXlla1lpeWlMdXM1ekdvbmV0alNpdDErbTJVU21u?=
 =?utf-8?B?c0JEN21wOHVZOXhxdlB6R3JUMkQzR09SVWppV25DS3JtUmh1S2E3eldRNWxF?=
 =?utf-8?B?b0w3OEYvRjhuNGh6UFF5OVNRclNaWjlQNGg3V1pqbmc2NWROSGFpc09GV2Vt?=
 =?utf-8?B?NFJPUjlMTzRiMUhxb3MxQ3JxRTVINkEwUGRWUGJmcGVTeFV1MmlqVldvTWFX?=
 =?utf-8?B?TTdYVGYxdVYwMTNEeDVrbmkyMXhSV2g4a1VEK3Z3TVVLU21WYkRtMEUyejRp?=
 =?utf-8?B?NklxTmh2SGtDM2dvUUxTY1czYW52VUdldFE1NE80SjdMY3hPNlBhbno3TFQ2?=
 =?utf-8?B?WU53b0VtMFcvVmU3UjhkNVJaVDFUVWVIbnl5c3NXT2pZOTVQbnR6dHg2ZXhy?=
 =?utf-8?B?Nm5Xa1ErVWlSS1J2SVZ4aS9TRUtPbHlwNDRZS095U2pCR2s0cTZ1TU1xUWJi?=
 =?utf-8?B?T3BwMlMvRVpnVlE3dnBybkRVc2laWkhvK0c4WDRtYnIvUlZvWFRhcHdOKzln?=
 =?utf-8?B?bnFrSHVWY3A5ZzdqQXFVSkdUUTRFU01UVW5hZjdra1hwT2dYTS9uNEQ3bG90?=
 =?utf-8?Q?l7RjiGiCDqUIT+Qk=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c3c2e7-62f3-4d41-017c-08da32d207cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:11:28.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvX9x31wTDk54W9PfmgV7ZXBzU1LeoD/O0SAfvQYfJkSKz1B6DGwBXb0GAZcKE+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4601
X-Proofpoint-GUID: 7cVCO7-iLFtbUpmnQFKiK8uMn6W4AkSE
X-Proofpoint-ORIG-GUID: 7cVCO7-iLFtbUpmnQFKiK8uMn6W4AkSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 3:37 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, the 64bit relocation value in the instruction
>> is computed as follows:
>>    __u64 imm = insn[0].imm + ((__u64)insn[1].imm << 32)
>>
>> Suppose insn[0].imm = -1 (0xffffffff) and insn[1].imm = 1.
>> With the above computation, insn[0].imm will first sign-extend
>> to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
>> producing incorrect value 0xFFFFFFFF. The correct value
>> should be 0x1FFFFFFFF.
>>
>> Changing insn[0].imm to __u32 first will prevent 64bit sign
>> extension and fix the issue.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/relo_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
>> index 2ed94daabbe5..f25ffd03c3b1 100644
>> --- a/tools/lib/bpf/relo_core.c
>> +++ b/tools/lib/bpf/relo_core.c
>> @@ -1024,7 +1024,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>                          return -EINVAL;
>>                  }
>>
>> -               imm = insn[0].imm + ((__u64)insn[1].imm << 32);
>> +               imm = (__u32)insn[0].imm + ((__u64)insn[1].imm << 32);
> 
> great catch, it should also probably be written as | instead of + operation?

The '|' also works. I used '|' in other places, so will change to use 
'|' as well.

> 
>>                  if (res->validate && imm != orig_val) {
>>                          pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>>                                  prog_name, relo_idx,
>> --
>> 2.30.2
>>
