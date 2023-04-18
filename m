Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74136E6B7C
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjDRRzE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDRRzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 13:55:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FF10E0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 10:55:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IH4Pnl025021;
        Tue, 18 Apr 2023 10:54:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=p7vz1vKrlpevWh0nRawt36ZOe6zsgqyekAf7cv34Bhg=;
 b=Nu699N7FRNWo7HwgO/QUC9O4/wYRgLAvrt04EgVNR2sC9NxcIs5yEYaPfs7Vq3JyvBrZ
 C82BUHOuew6w7t0x9atvdS6OysAwdA4gkwY3wrOUlXBBvZaF6BQrPQFNMIUZ4YW0g/h6
 vL9pl2cCW/kWei6V9bXjTYMP6nWRNM3np0qC2Fuy+iQmYMskGOJkJdoG7zltFimicVjQ
 CQ4yOe3kwC1SarYii4w4z+jYkij/fNz9qC3pHK8vTq453h9RTN4PcfyvysKcx5+WREjq
 WA4ormKEi2NEYPacvjga9W/rEohS8Y7OfD/YNgHZhXKc3hayJohAkxRzB/CKrD5thFmZ PA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q1k9dcsa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyq1ocLO5Y/JMBBcgMqg1IUjAWDN/JIxLa65D+oZvToiNhoLNs3T5/pXmUNZcYMlrqKLHpnbbwRW+8mRYuRrtTIFon0Wm5JRX4EnkmxAOX8dBsVNDffaq2+48sASEpeUVq+X+Q5U6eZFePaYFVDe5DNTp5Bl+jpw1k3OodUjnUG9AOIprH3sr9zJ5HxAG19DJedy2BncSt+Z6/jywCVG6xvWmGllAYU0xtCIdG8YTOdgnEE5/FLRmzlXxxjZLlAFQ0eugLjcjROlb7UELCflRb2xxES8AGsGK3906ZVAuLE9dUo4GMBlOg2fQcaRzfgQ4yvFF2Lukhi64FSpiTyqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMSFgyA9gGpwUVfR9efZK56fJBUKa7M4iyvJEEX6eoA=;
 b=O4YbYnyl+xnJ2GK4kKWJxQ62Zo2TcmY528NwlEAiIi0dpQfnqi3S2fLp/0KDgTBaGIrLMMMfT/7xqpz9uL5InRj9CT1/cOH+yGbc76QcFDioqN8OjvjLgBb3yHvpt/vzbw+9ZAyGaSefrvBAjpYHZpWq74Ng8BdnUJLXu/jbEk0wMLKdLG7AWrfqjTgGwgFBuYUJk4T93iLinjkNGJ2vkLv0XcGLf/Li4CbGfI6hhFPHt5LQXV3VTkxoKmCDL66/Apy6FaKXqyxtrgxs4IUvwMuOOUYm8XPaTwG0KE025tdiUOTMwIDBbTieldfMtv8nFwMfb4VtX4fZJEjoF2u4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3801.namprd15.prod.outlook.com (2603:10b6:303:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:54:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 17:54:42 +0000
Message-ID: <0378bb31-dc0a-f656-c0e7-733ff1c78990@meta.com>
Date:   Tue, 18 Apr 2023 10:54:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Improve verifier u32 scalar equality
 checking
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230416232808.2387432-1-yhs@fb.com>
 <ZD0+ULVuyhDtl8Aq@syu-laptop.lan>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZD0+ULVuyhDtl8Aq@syu-laptop.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3801:EE_
X-MS-Office365-Filtering-Correlation-Id: b8882741-bdc3-4a81-bbff-08db4035fcec
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLPahglEOt3+fQdWN6VlYBfTYHU5afL32oxxLC62VDR7V2E//unvUZ2o2O/v39UQ7mg4n30eNR8ezXYQ5DrYEY2OTK9EplJcyxP9tyLMkHJwgG1Om3hRQAGOLa0JsR9dgPLauayiuSLVy6rZKxWazP2hRKRTRdypg4e7rnimDgC0QohHhCyB/q5aQoosCs/LPctKBKS3VKnikFnK16fjSHS/7474BwahSriCdVoAi/islSNEspfk4MKBlFJO0tQk2aAX8S2n19Av3Xp0RNu2epU1RJjzQ7m0H3qfmCNLGVPmdD0YXJKc13nC4JuXdbQIcpq+FhxPCaAcWdnLwW7cV3hIcY85sKkFH4vzukaTHAUM/k3GAem59sjYzbsNf4XMZPg2kjafU2J+ToXqB1ogtiRoGvnQhllVIzKuhP5HmM7b+v1bV6itnd1IRocy/tD3DrLdQH9EZr2ZSyskPY0Ga82vQFcph6sldKO4og1AKvJrHzx9kST3bQk9iEmKg6ANvIapzxcJ3NgUF4z05s0ja6GDpFUYyj2qBj9hNmy0xjKMAHyYStMCGH+ouOVapiydoA3eS13Scap/uqTf/kBF7fn7vDU5P/02WuvjLkolrcMhGgAvrANdUbNfvOaFQ4yi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(2616005)(110136005)(6512007)(54906003)(53546011)(6506007)(31686004)(478600001)(186003)(66946007)(66476007)(66556008)(316002)(83380400001)(966005)(6486002)(6666004)(4326008)(8936002)(8676002)(41300700001)(2906002)(5660300002)(36756003)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFFK2dCbkxhcDVYdDNSTHNvOG1kU1ZPdnJCZ01kQnFOL0VBSWRWTWNrR0ta?=
 =?utf-8?B?MWh4TlNqM3VZT001alNrM2VqL0FqV0ZvdVdRc0duSzhxVEN3TGFmdXBmc3hR?=
 =?utf-8?B?QnBNVFNBNjNGREgrWEV2YnVRaDNydGlXV05xM3VRaVdycC9sdmVuUHJQcG5k?=
 =?utf-8?B?dkhWMU1LNE1nKzJYM29RUXRjbHBoTE9VUDhhTno4dHN0OHBna0MwY3JINVNa?=
 =?utf-8?B?NG1qYTZrZnQwbXFZemNNampNWFdBR0svdTlOYjNnOFFoOTFZdHFsSjAwaUlh?=
 =?utf-8?B?L2VNb2x0QTYxeWFBajhXakFuTzJsVmJoNkpkYWdYci8vUUYyeS9WOEx1cjJY?=
 =?utf-8?B?bmVtTVNrRXVPQ1gvUlkvdUxKS1FSek5RckliTEdHeHFMWmRTc2tQTk9xVDNm?=
 =?utf-8?B?WkJ3dEh4b2w0MGQ3L3lxYkc3ZVhIbHhZUVRYcGJiVkdLZ3F2aGR1Z1FrUnRG?=
 =?utf-8?B?ZUJHSGkrZk5vZjBtbWhTblJ3dW9tUlZpTVZVS1FNSWd6a2d0N1RlU3BlcjY0?=
 =?utf-8?B?eXl3aHpDRHZ5blYvWGtRYmpEQi9rWTlPaWJCLzVGZlVtdkxKTUNmTmxQek1G?=
 =?utf-8?B?QWVQc3JVTHZ1dVN1MEpjaS80S3Y0YVEwWmRGbzVtVTFuTW1BeFdRVnIrajNO?=
 =?utf-8?B?ZlhrcEc0ejVFVkFyMXNEZ2V6S0p0a0hTbnA3T1kvYXlHNTg2M0R5SzAraDZY?=
 =?utf-8?B?bDJyVzFMZDRTY2RldC9aZ1ZoRDdWVGtFYlBiMG1IeEdlSHh1TG5YOFdJR3NG?=
 =?utf-8?B?RGtzZTNnZ1BiekhmaVVZK2pwMUYwU29DR0VYRmpRMkZBaUltMExRZ2puWmVk?=
 =?utf-8?B?dGpVeDdIaTYzTEpOczZ5bTFwd1lUbS8xVDBYcU1xd3NmaVFid1JzdTljM2cz?=
 =?utf-8?B?d0lVbmtRZWVJNTA2aVBscXlYOHluK3IrQmRtQ3BndTM2VVZWdG9QV1JPRkty?=
 =?utf-8?B?VitVLzRROFNLUzJwWmFmOEJUOG5vUDRRQ1JzWkVsTU5jQ2VmMXd5dFBCRU9r?=
 =?utf-8?B?c0Z0NzlFVDdybmRGOGFTMUFRVVZxRE8wSytNQWJBS3RYR0M4MFZqNFJEQVE0?=
 =?utf-8?B?N0ZCSllPQlJpM3FDenQybXBvbUhNRnJoUzdJVmNQUW45aUIvcTBqbDRoYlhq?=
 =?utf-8?B?THd2SGd0OTVmNlFhcHJIWFpyWkRSdkJSaDJtNmRZYlErZ1ZhaG91UDNFeDNJ?=
 =?utf-8?B?NU11MEoveS80b2laV3BrMUk4YjRXSHA1ZmR4WXZ4R3ZtQXp1ZjR0cERPN3A0?=
 =?utf-8?B?cVNuZjliOVM0aVVzdXBtRjFjamVLQ1dPTk5BQ3E1a1hJTTdFQVNrc2FGQ1VO?=
 =?utf-8?B?QXJGZ0dXOGFyUFFLK0ZyUzVLd3BVUTcrRUZkYkZDUUczcnFtTE9UWEhWbDdU?=
 =?utf-8?B?d01kbG9HQVIwWXdsSTNXZjgvbkFaWUZoZE1HOWJPQzZZTlJxOWxkRkFPLzE2?=
 =?utf-8?B?VTFSUkUvejIyUHhqNzhmWnpkM0JzV0lPS2pjODBuUC9OWmJrcDV1RE4xeHo0?=
 =?utf-8?B?bzFpL3QyWnBvWU9kYWs4YlpwY1hQQlM4ZFZ4MFRkM1F5SUxwUkN3ajlrQTZt?=
 =?utf-8?B?Lzl3bWR4WFd3a3RMRkNaTDYyK2E2MGlpeThqN2NrYmdBSTdOTGtFRE9mVXYz?=
 =?utf-8?B?TWdMd3ZPa1Vud3djcSs3MEVsQUlFbFA3aVdSN2FJOUNNdjJ3Nkw3aEUxK3Fk?=
 =?utf-8?B?RjMvSFN2SklESHpCeEg0RjVIYUx6eUt4c0hVVFBNb2lMY1gyUE42Qi9pSC9t?=
 =?utf-8?B?VVJVR1JUOEpWOFdsaitrSGFZODAzWk0yMmVIY2hjYlVQL1R0aEhEUnZoMnE1?=
 =?utf-8?B?ZjRIeENFRzg1YitKWFlnYjBwYURaT0xHbGs0S2JqZFI3Q3dkdXdOVzg5RjZH?=
 =?utf-8?B?L0ZQMzZVVWhsUmFYZk5SbllETkRLSCtlcHl6MVJxZmlHVUphaURzWDRuTFJq?=
 =?utf-8?B?VVlRcFFiZDY2cW5KU3craHhCVFZXbTFDY3lQUTBmYWJZU2dvQTVqQTdxSlJ2?=
 =?utf-8?B?aXY0RkFPSDRQU0tZdWJ5dHU5NGRLcFFKQlhNSjA5dzVhbWNOMStPckNLQnR6?=
 =?utf-8?B?RXpjTSt5YXpSUTYvYnJxSngyU3A4ODczcjBKczNyVnlYV21iTGVoSjVKeGJX?=
 =?utf-8?B?Ym93TTE4N2FEOXBZdkx0dUlyOUtXeDhGbGhTeXk0bEhhejJsemlMNy85bFNN?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8882741-bdc3-4a81-bbff-08db4035fcec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:54:42.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6t7EqlkFHeCo8lewd1UfoTjnelh2QSO07yS/h6dTNftS/rpjrVjb1pCgIdwRobn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3801
X-Proofpoint-GUID: SZd-PB6VZ9ETUdexELTY-ZKAtWTE7mZ7
X-Proofpoint-ORIG-GUID: SZd-PB6VZ9ETUdexELTY-ZKAtWTE7mZ7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/17/23 5:40 AM, Shung-Hsi Yu wrote:
> On Sun, Apr 16, 2023 at 04:28:08PM -0700, Yonghong Song wrote:
>> In [1], I tried to remove bpf-specific codes to prevent certain
>> llvm optimizations, and add llvm TTI (target transform info) hooks
>> to prevent those optimizations. During this process, I found
>> if I enable llvm SimplifyCFG:shouldFoldTwoEntryPHINode
>> transformation, I will hit the following verification failure with selftests:
>>
>>    ...
>>    8: (18) r1 = 0xffffc900001b2230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
>>    10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>>    11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
>>    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>>    12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
>>    13: (bc) w2 = w1                      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>    ; if (test < __NR_TESTS)
>>    14: (a6) if w1 < 0x9 goto pc+1 16: R0=2 R1_w=scalar(umax=8,var_off=(0x0; 0xf)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(off=0,imm=0) R10=fp0
>>    ;
>>    16: (27) r2 *= 28                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>>    17: (18) r3 = 0xffffc900001b2118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
>>    19: (0f) r3 += r2                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4) R3_w=map_value(off=280,ks=4,vs=564,umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>>    20: (61) r2 = *(u32 *)(r3 +0)
>>    R3 unbounded memory access, make sure to bounds check any such access
>>    processed 97 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 6
>>    -- END PROG LOAD LOG --
>>    libbpf: prog 'ingress_fwdns_prio100': failed to load: -13
>>    libbpf: failed to load object 'test_tc_dtime'
>>    libbpf: failed to load BPF skeleton 'test_tc_dtime': -13
>>    ...
>>
>> At insn 14, with condition 'w1 < 9', register r1 is changed from an arbitrary
>> u32 value to `scalar(umax=8,var_off=(0x0; 0xf))`. Register r2, however, remains
>> as an arbitrary u32 value. Current verifier won't claim r1/r2 equality if
>> the previous mov is alu32 ('w2 = w1').
>>
>> If r1 upper 32bit value is not 0, we indeed cannot clamin r1/r2 equality
>> after 'w2 = w1'. But in this particular case, we know r1 upper 32bit value
>> is 0, so it is safe to claim r1/r2 equality. This patch exactly did this.
>> For a 32bit subreg mov, if the src register upper 32bit is 0,
>> it is okay to claim equality between src and dst registers.
> 
> Perhaps mention in the above paragraph that this works because 32-bit ALU
> operations clear the upper bits? Some along the line of
> 
>    A special case where r1/r2 equality can be claimed after 'w2 = w1' is when
>    r1 upper 32bit value is 0. This is because 32bit ALU operations always
>    clear the upper 32 bits of the destination, so 'w2 = w1' in this case is
>    the same as 'r2 = r1'...

In BPF documentation (Documentation/bpf/instruction-set.rst), we have
   ...
   for ``BPF_ALU`` the upper
32 bits of the destination register are zeroed

I asssume this is known and that is why I didn't explicitly mention
this in the commit message. The patch has been merged...

> 
>> With this patch, the above verification sequence becomes
>>
>>    ...
>>    8: (18) r1 = 0xffffc9000048e230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
>>    10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>>    11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
>>    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>>    12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
>>    13: (bc) w2 = w1                      ; R1_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff))
>>    ; if (test < __NR_TESTS)
>>    14: (a6) if w1 < 0x9 goto pc+1        ; R1_w=scalar(id=6,umin=9,umax=4294967295,var_off=(0x0; 0xffffffff))
>>    ...
>>    from 14 to 16: R0=2 R1_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R2_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R6=ctx(off=0,imm=0) R10=fp0
>>    16: (27) r2 *= 28                     ; R2_w=scalar(umax=224,var_off=(0x0; 0xfc))
>>    17: (18) r3 = 0xffffc9000048e118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
>>    19: (0f) r3 += r2
>>    20: (61) r2 = *(u32 *)(r3 +0)         ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R3_w=map_value(off=280,ks=4,vs=564,umax=224,var_off=(0x0; 0xfc),s32_max=252,u32_max=252)
>>    ...
>>
>> and eventually the bpf program can be verified successfully.
>>
>>    [1] https://reviews.llvm.org/D147968
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
>> ---
>>   kernel/bpf/verifier.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d6db6de3e9ea..468f002d3248 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12409,12 +12409,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   						insn->src_reg);
>>   					return -EACCES;
>>   				} else if (src_reg->type == SCALAR_VALUE) {
>> +					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
>> +
>> +					if (is_src_reg_u32 && !src_reg->id)
>> +						src_reg->id = ++env->id_gen;
>>   					copy_register_state(dst_reg, src_reg);
>> -					/* Make sure ID is cleared otherwise
>> +					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
>>   					 * dst_reg min/max could be incorrectly
>>   					 * propagated into src_reg by find_equal_scalars()
>>   					 */
>> -					dst_reg->id = 0;
>> +					if (!is_src_reg_u32)
>> +						dst_reg->id = 0;
>>   					dst_reg->live |= REG_LIVE_WRITTEN;
>>   					dst_reg->subreg_def = env->insn_idx + 1;
>>   				} else {
>> -- 
>> 2.34.1
>>
