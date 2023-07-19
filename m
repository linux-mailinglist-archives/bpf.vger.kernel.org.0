Return-Path: <bpf+bounces-5229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB31758ABF
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7432818A3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6917CB;
	Wed, 19 Jul 2023 01:17:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9539ECA
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:17:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1212F
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:17:44 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIwAwO016326;
	Tue, 18 Jul 2023 18:17:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+r8hS3lhUKpBVtZa/Neh2+y8ooR4+5ldo9Y2tYv+F98=;
 b=njf7LUwfhjEhpMbkrwM6lRDt+AYHddUHIdn+/UW93Y1cNWNc8ME/dsBbu1LFDqzg88+I
 s4N9+XUbtcTIc7IsUPo5N6CZpiqPt9tp3IEU5uIniPQYy5CTNZovQSSvkmNcISfE3Ske
 we0d+mzvgWyKVIfHJOGvo/n0Oup8yXwrGBJhbRciB0W76QPGzJjvGyGHRBiMQknjdGfA
 BM1gbfRzANFHgud9dcViGo1rqEqgWDHZIxmUF+9iJ/oBLE7yk0t3VESpM4hKXydAQ5FY
 nEAlG739vpxTdRgcuqMPfjJrKTIqQ8YfA7QuX37KFa/mCfwXNuq/3GtEQqezTUQ48cB4 tA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rwgun1tdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 18:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzULZ3J23PflhyxZZ5WZbD8qdQTqJB3+bsy0RBKh8Bo1oXjRtKAWg+xkifpdVoHMUG4Bfu2FJSdiyQUS7dpujn/3PTe0eZz4+iPVjMaFltmUtkcZiNhTQhttLz5g2/a42I137+/cJMFyIkCO+T9KYf2FDZ6LybpKExf2E8l2YPLWyoLMSuMEcW3FDJvHDBRyTN0xmFW0F3iXzSZ9E0kFVXMFGhNVn8CKGWZlqczSB3FVQmy/zSXJrHysB8cvsTAev7SemjFRrEWmatv9OS82GTS1wd87znlQgW44FoGPVzZno+B01G2fk46I2+SkVlu/wBdNMA3DWYBRvi3XDYlcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlleDseN3rvEIOsG1vKeafN560ccE84V83w+yED3R2c=;
 b=b1VJfudx8KTWZATOU3KarFLudfm37n4uwTWAhjWJQq9eJ9vCLkpRLdlF04H/i3iy+9SG8JxCXN9R+ZEBaxuEyucJ4dcukQ4v5YdHzrF/sLXtgN5+f6OBPajAaDVaYIf2T7RMJ1dSbwucFilIZEX5fHW+2nemJ9YTA3CE9Lx0BbKOPwtgeFNnFd0OjMTPb/FiFVJ0nNsgcrQ4sKb5v5FNhZNg1ZnA2pZlAue4Nj7XwH94oTkDPrJ4RUA1FDDVPmO4qQ1kI3A5hWHomPgyiTQ27kVEpxj/7R8WY0ZPFMwwn5/owdTGjBe1ybz3+jvb+wL9WPrVUxVOnAHT15QgV8XUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4729.namprd15.prod.outlook.com (2603:10b6:303:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 01:17:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:17:24 +0000
Message-ID: <356fc6bf-77cb-abbc-f7cf-3d2678ffa83b@meta.com>
Date: Tue, 18 Jul 2023 18:17:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Support new sign-extension mov
 insns
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060734.390551-1-yhs@fb.com>
 <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e6271c-95f3-4836-fa00-08db87f5e85c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qio7pGUfVcxZ0Z3fBFUZbqUj1ic9eC9SedeinsvNWiNsEleW+TQGPrrWjLVc6eSMY/sxYJeJfKQpBxHZpsMkz21Iu/DyVCiFgR7qS4vyCV9+g6u2s6P0CJdqdJ6VYKr4kVYOKQWekKj07VA4btMz2lxsEU2XuEjNuIvnHfb65h/LehoxHs2WdgZiin5HQ0PUY2Q5SEM+VjfkPQiozjTQrOAVWDTYvkHdPSK9bI3d7c6MJP2oMmF05XDY0POSrcBHj1sdEYGtvJeaQ+AX6FGZVwUQu51dhCXiM0GBm48pp5BUyy3I5spb9LV83xVEgx6MouUSvfN6dXmNdcTQ1lKUY3xWx9QU57Sjiepuxu8RWY4lW7pVRIM/Y8vmtp8DYBt8L2z6gpek+HoEg/nL8Kyz4hgMAioUAfr/LvIdJBG5BJ5pGEENAzMclseonLbTVBN9wOxbx5bTJIa0aRXx8Pq/Ku0kG/BOwwyBhMcWXXfzxVRoVusv52WG8rCIzOkNDZ82xV/klaJZ2RrZ9795pjEKIvi8aoE+YeqTZD2zZ8D3vnouduNFy/dSxViR8DrS+iF6PqEUBl/Pf7MDmTqxnITJoP2RNo/dmZr3IW/05QOoAA6zH2qIQC1JS7d89b9ADTikbC5bYiAic0z4Ink5tqVO1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(38100700002)(36756003)(86362001)(31696002)(31686004)(6506007)(66946007)(66556008)(66476007)(5660300002)(53546011)(186003)(41300700001)(54906003)(6666004)(6486002)(110136005)(966005)(6512007)(4326008)(2616005)(2906002)(83380400001)(316002)(8936002)(478600001)(8676002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REZNVkJqZ1NuaFVLTkNFYzRaTVN2REVSb2t0cDJnK213V3pIb2xwOHlqMUZm?=
 =?utf-8?B?b3ZlakR1UUVuS0xsZHZYL3JIeHdPVm1SanRRQytTd1VXTWZ0M1NxWUVORzRx?=
 =?utf-8?B?WThLN1IvcXRreDByQ1FMZFJhY24vMm9iTCtsSEJPMzRZc2ZqOWRhMjRVOWV4?=
 =?utf-8?B?Y3NIak1VNUFqTjZ2aW05S25UTUxjeFl2RmJMZVhVZ21lL0t1TkRpczZGZFJZ?=
 =?utf-8?B?WUQxbzVrZ0tldUF4UjVSaDMzeW1NY3FPL0VndzQwaHJYbG16MGwxVjVkeDlH?=
 =?utf-8?B?UE82TDhybG5TQjNZZzV4eTZvVmtPbnAyZk94ZmhVUVQ3VkNiN3lvWUIwaHZK?=
 =?utf-8?B?eng0d2orU1RNc0hKWElWNXZhWFFKeGordEZaVUZvOHhtQlluZkxkOVdhQzRt?=
 =?utf-8?B?aFRXSEh5eFhkcWRTSEMyQXk2TUNiREdRSS8waForTUtzMGN4S0RFMHcvS05J?=
 =?utf-8?B?elpmWG5xU0xZeldYa2VVZDhaTlo4KzYzUWZOeFAvT2lmOHZNTThRK2ttblJI?=
 =?utf-8?B?VXdRYXcxM3pobmVrclF2UEYyMERNeFpON3BINjNpM2YzNEE2d2tCWkNFUVhM?=
 =?utf-8?B?Vy9pc0pYZmVROVNoV1pmL2IxU2N4akhXWHl2RXEzOFd2VXdRVGpyUW5aOVl2?=
 =?utf-8?B?TVRnZno0SFNsMHA4K0lISjAxdmRwWHpwZlFRWnpDclFEUnI1RXdlQzJoSGUy?=
 =?utf-8?B?RjdzMVlPWDhnc3ZYN0NWVTdMc0JRbFBkTC9GWXVFdU5RYXhBbmV0a3hLNVYr?=
 =?utf-8?B?VE5lSEM5Y3NpQTFaSzF2YW83RTQ5NWdZd1ByZFJMMDVHVHFoUjVVTDZGUWdy?=
 =?utf-8?B?ZWFsTERUd0Ftd1ZXeEptNWNiTzFuODBET3FCYnovRU9PZTRNMjJVTlhCVzRZ?=
 =?utf-8?B?dG0zNVRNK05Pdkx2T2VMWHA1N2xOUjB6WnNZTERSc24rMWI5S1RKUTM1RFdU?=
 =?utf-8?B?VXFSTXlwQ0ZlNUN5NlBSa3JvVFdvbjJrdCs1aWtWaWRMZ2xEbjJLaGVKMXNX?=
 =?utf-8?B?UXdqZmpkZFVtWEZIcVNsdFpjY0FUNlRnckhvd2lHQUp6OWx3aENhbzRadWF3?=
 =?utf-8?B?ckppd1FoeXpsTVJKcVhFUzVGemVkVWtOV2NNN0dYVkM4aG5YRXZuc0x1Witp?=
 =?utf-8?B?TGhkZ1NLOWJlQ3c3L3dBN2Y2V3Z3Ni9INGhhTkxPZTU0TGM0WUdMMERSYll0?=
 =?utf-8?B?SG5JVEZOcHpCUmttRWRsRHBDamFzSGZTUFhaUU03azZIL2NIZTJ4MTUzWGlE?=
 =?utf-8?B?eTB2KzhKQVN0V3F4NXh6bzJpaWRjbFRhaUR0akk0SFBNelAxVng0TnFIcHJi?=
 =?utf-8?B?VFM4RU8wcjNRS1A3SitVZTg0YWoza2NIWWtRVVNxbmJyNjNYT1dKN1JhKzRG?=
 =?utf-8?B?WFp6c0ZLSGplekFwcENsZ0lmWS9EODA4bWE0MUlmQVFBUllvRldRM1lYTlJS?=
 =?utf-8?B?c3IvdTJ3c1BTTnpQMEd5M3dwYVlVKzNreCtNOGNmZDJYYW1tQjhQWHYyek5W?=
 =?utf-8?B?b0Z0UUhLdWRDOHlvUS9DZS8vT0c4aUttWE1ZT3ZhM3pZRUJrQTNZNnhOeGVv?=
 =?utf-8?B?RHBFUHZqa09Uc05HOGkzem1HZ013YWdzOWdDd2VhMGhSTEw0Tm1MVExNVmJs?=
 =?utf-8?B?N2tUbjNZVHhDUGE3ZlA2bmdIU04xWUthNWhFSHlmU2RpQVRoT1pUcXFtOHl1?=
 =?utf-8?B?cElrOXJSd085L1N5NHVvbVdKT0NUd2VHZDdaak53MlFMY2RReTZjWDhSQVRp?=
 =?utf-8?B?SWFjRjVSSUNvYTczc1VsSXdzQ2tLUzlrS0xnU1FNMi9aVnN1K09UUjdwNmMy?=
 =?utf-8?B?WDJKMk0ranlxNk9TajY0UEttb2xKZng3a3pSdE0yUXJCd3BnbHJqYUNONlJq?=
 =?utf-8?B?bC8zbG52dkR3YUtsRUxLUG51YTMxWHNxcXJCRHkxMWVoaWd5Nkw0R0V4Mlg3?=
 =?utf-8?B?dWxnRWd2YlY1d25DVmxVTzZKSXJNbXh2SlB6NnhIbmpqUG5IM1ExcXUvV1ln?=
 =?utf-8?B?c1d0d0dESFlpRWtpSVhsVDZsZGNjdUpESEVvemxKZ082d21uMEVBN3VHYlFH?=
 =?utf-8?B?RFZQZkszMGtFbDd2YUZpbkxLUkQ3SnpxR0hMdk1qQVNCNFdVZFUwWTVnT3ZN?=
 =?utf-8?B?eGNOcVBhM0tTYXhKVGRSc0gvaGNJdGJsNzNUVjJucnRPeWRjMGh0OEdDZkVi?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e6271c-95f3-4836-fa00-08db87f5e85c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 01:17:23.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvfgLOILhxU5K3bbLbWWvMG18yzBmYBYC4/J+UgZnr8Qa96yQ+wlTL5oCqmNDFp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4729
X-Proofpoint-GUID: 45ppHWzdji1dIhFt_XlrYA9fpUkMFbiQ
X-Proofpoint-ORIG-GUID: 45ppHWzdji1dIhFt_XlrYA9fpUkMFbiQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/16/23 6:41 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>>> Add interpreter/jit support for new sign-extension mov insns.
>>> The original 'MOV' insn is extended to support signed version
>>> for both ALU and ALU64 operations. For ALU mode,
>>> the insn->off value of 8 or 16 indicates sign-extension
>>> from 8- or 16-bit value to 32-bit value. For ALU64 mode,
>>> the insn->off value of 8/16/32 indicates sign-extension
>>> from 8-, 16- or 32-bit value to 64-bit value.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   arch/x86/net/bpf_jit_comp.c |  43 ++++++++++-
>>>   kernel/bpf/core.c           |  28 ++++++-
>>>   kernel/bpf/verifier.c       | 150 +++++++++++++++++++++++++++++-------
>>>   3 files changed, 190 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index addeea95f397..a740a1a6e71d 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -701,6 +701,38 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
>>>   	*pprog = prog;
>>>   }
>>>   
>>> +static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
>>> +			   u32 src_reg)
>>> +{
>>> +	u8 *prog = *pprog;
>>> +
>>> +	if (is64) {
>>> +		/* movs[b,w,l]q dst, src */
>>> +		if (num_bits == 8)
>>> +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbe,
>>> +			      add_2reg(0xC0, src_reg, dst_reg));
>>> +		else if (num_bits == 16)
>>> +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbf,
>>> +			      add_2reg(0xC0, src_reg, dst_reg));
>>> +		else if (num_bits == 32)
>>> +			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x63,
>>> +			      add_2reg(0xC0, src_reg, dst_reg));
>>> +	} else {
>>> +		/* movs[b,w]l dst, src */
>>> +		if (num_bits == 8) {
>>> +			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
>>> +			      add_2reg(0xC0, src_reg, dst_reg));
> 
> Nit: As far as I understand 4-126 Vol. 2B of [1]
>       the 0x40 prefix (REX prefix) is optional here
>       (same as implemented below for num_bits == 16).

I think 0x40 prefix at least neededif register is from R8 - R15?
I use this website to do asm/disasm experiments and did
try various combinations with first 8 and later 8 registers
and it seems correct results are generated.


> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671200
> 
> 
>>> +		} else if (num_bits == 16) {
>>> +			if (is_ereg(dst_reg) || is_ereg(src_reg))
>>> +				EMIT1(add_2mod(0x40, src_reg, dst_reg));
>>> +			EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0xbf,
> 
> Nit: Basing on the same manual I don't understand why
>       add_2mod(0x0f, src_reg, dst_reg) is used, '0xf' should suffice
>       (but I tried it both ways and it works...).

 From the above online assembler website.

But I will check the doc to see whether it can be simplified.

> 
>>> +			      add_2reg(0xC0, src_reg, dst_reg));
>>> +		}
>>> +	}
>>> +
>>> +	*pprog = prog;
>>> +}
>>> +
>>>   /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
>>>   static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
>>>   {
>>> @@ -1051,9 +1083,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>   
>>>   		case BPF_ALU64 | BPF_MOV | BPF_X:
>>>   		case BPF_ALU | BPF_MOV | BPF_X:
>>> -			emit_mov_reg(&prog,
>>> -				     BPF_CLASS(insn->code) == BPF_ALU64,
>>> -				     dst_reg, src_reg);
>>> +			if (insn->off == 0)
>>> +				emit_mov_reg(&prog,
>>> +					     BPF_CLASS(insn->code) == BPF_ALU64,
>>> +					     dst_reg, src_reg);
>>> +			else
>>> +				emit_movsx_reg(&prog, insn->off,
>>> +					       BPF_CLASS(insn->code) == BPF_ALU64,
>>> +					       dst_reg, src_reg);
>>>   			break;
>>>   
>>>   			/* neg dst */
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 8a1cc658789e..fe648a158c9e 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -61,6 +61,7 @@
>>>   #define AX	regs[BPF_REG_AX]
>>>   #define ARG1	regs[BPF_REG_ARG1]
>>>   #define CTX	regs[BPF_REG_CTX]
>>> +#define OFF	insn->off
>>>   #define IMM	insn->imm
>>>   
[...]
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index fbe4ca72d4c1..5fee9f24cb5e 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -3421,7 +3421,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>>   			return 0;
>>>   		if (opcode == BPF_MOV) {
>>>   			if (BPF_SRC(insn->code) == BPF_X) {
>>> -				/* dreg = sreg
>>> +				/* dreg = sreg or dreg = (s8, s16, s32)sreg
>>>   				 * dreg needs precision after this insn
>>>   				 * sreg needs precision before this insn
>>>   				 */
>>> @@ -5866,6 +5866,64 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>>>   	set_sext64_default_val(reg, size);
>>>   }
>>>   
>>> +static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
>>> +{
>>> +	if (size == 1) {
>>> +		reg->s32_min_value = S8_MIN;
>>> +		reg->s32_max_value = S8_MAX;
>>> +	} else {
>>> +		/* size == 2 */
>>> +		reg->s32_min_value = S16_MIN;
>>> +		reg->s32_max_value = S16_MAX;
>>> +	}
>>> +	reg->u32_min_value = 0;
>>> +	reg->u32_max_value = U32_MAX;
>>> +}
>>> +
>>> +static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
>>> +{
>>> +	s32 init_s32_max, init_s32_min, s32_max, s32_min;
>>> +	u32 top_smax_value, top_smin_value;
>>> +	u32 num_bits = size * 8;
>>> +
>>> +	top_smax_value = ((u32)reg->s32_max_value >> num_bits) << num_bits;
>>> +	top_smin_value = ((u32)reg->s32_min_value >> num_bits) << num_bits;
>>> +
>>> +	if (top_smax_value != top_smin_value)
>>> +		goto out;
>>> +
>>> +	/* find the s32_min and s32_min after sign extension */
>>> +	if (size == 1) {
>>> +		init_s32_max = (s8)reg->s32_max_value;
>>> +		init_s32_min = (s8)reg->s32_min_value;
>>> +	} else {
>>> +		/* size == 2 */
>>> +		init_s32_max = (s16)reg->s32_max_value;
>>> +		init_s32_min = (s16)reg->s32_min_value;
>>> +	}
>>> +	s32_max = max(init_s32_max, init_s32_min);
>>> +	s32_min = min(init_s32_max, init_s32_min);
>>> +
>>> +	if (s32_min >= 0 && s32_max >= 0) {
>>> +		reg->s32_min_value = s32_min;
>>> +		reg->s32_max_value = s32_max;
>>> +		reg->u32_min_value = 0;
>>> +		reg->u32_max_value = U32_MAX;
>>> +		return;
>>> +	}
>>> +
>>> +	if (s32_min < 0 && s32_max < 0) {
>>> +		reg->s32_min_value = s32_min;
>>> +		reg->s32_max_value = s32_max;
>>> +		reg->u32_min_value = (u32)s32_max;
>>> +		reg->u32_max_value = (u32)s32_min;
>>> +		return;
>>> +	}
>>> +
>>> +out:
>>> +	set_sext32_default_val(reg, size);
>>> +}
>>> +
>>>   static bool bpf_map_is_rdonly(const struct bpf_map *map)
>>>   {
>>>   	/* A map is considered read-only if the following condition are true:
>>> @@ -13003,11 +13061,23 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>>   	} else if (opcode == BPF_MOV) {
>>>   
>>>   		if (BPF_SRC(insn->code) == BPF_X) {
>>> -			if (insn->imm != 0 || insn->off != 0) {
>>> +			if (insn->imm != 0) {
>>>   				verbose(env, "BPF_MOV uses reserved fields\n");
>>>   				return -EINVAL;
>>>   			}
>>>   
>>> +			if (BPF_CLASS(insn->code) == BPF_ALU) {
>>> +				if (insn->off != 0 && insn->off != 8 && insn->off != 16) {
>>> +					verbose(env, "BPF_MOV uses reserved fields\n");
>>> +					return -EINVAL;
>>> +				}
>>> +			} else {
>>> +				if (insn->off != 0 && insn->off != 8 && insn->off != 16 && insn->off != 32) {
>>> +					verbose(env, "BPF_MOV uses reserved fields\n");
>>> +					return -EINVAL;
>>> +				}
>>> +			}
>>> +
>>>   			/* check src operand */
>>>   			err = check_reg_arg(env, insn->src_reg, SRC_OP);
>>>   			if (err)
>>> @@ -13031,18 +13101,32 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>>   				       !tnum_is_const(src_reg->var_off);
>>>   
>>>   			if (BPF_CLASS(insn->code) == BPF_ALU64) {
>>> -				/* case: R1 = R2
>>> -				 * copy register state to dest reg
>>> -				 */
>>> -				if (need_id)
>>> -					/* Assign src and dst registers the same ID
>>> -					 * that will be used by find_equal_scalars()
>>> -					 * to propagate min/max range.
>>> +				if (insn->off == 0) {
>>> +					/* case: R1 = R2
>>> +					 * copy register state to dest reg
>>>   					 */
>>> -					src_reg->id = ++env->id_gen;
>>> -				copy_register_state(dst_reg, src_reg);
>>> -				dst_reg->live |= REG_LIVE_WRITTEN;
>>> -				dst_reg->subreg_def = DEF_NOT_SUBREG;
>>> +					if (need_id)
>>> +						/* Assign src and dst registers the same ID
>>> +						 * that will be used by find_equal_scalars()
>>> +						 * to propagate min/max range.
>>> +						 */
>>> +						src_reg->id = ++env->id_gen;
>>> +					copy_register_state(dst_reg, src_reg);
>>> +					dst_reg->live |= REG_LIVE_WRITTEN;
>>> +					dst_reg->subreg_def = DEF_NOT_SUBREG;
>>> +				} else {
>>> +					/* case: R1 = (s8, s16 s32)R2 */
>>> +					bool no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
>>> +
>>> +					if (no_sext && need_id)
>>> +						src_reg->id = ++env->id_gen;
>>> +					copy_register_state(dst_reg, src_reg);
>>> +					if (!no_sext)
>>> +						dst_reg->id = 0;
>>> +					coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
>>> +					dst_reg->live |= REG_LIVE_WRITTEN;
>>> +					dst_reg->subreg_def = DEF_NOT_SUBREG;
>>> +				}
>>>   			} else {
>>>   				/* R1 = (u32) R2 */
>>>   				if (is_pointer_value(env, insn->src_reg)) {
>>> @@ -13051,19 +13135,33 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>>   						insn->src_reg);
>>>   					return -EACCES;
>>>   				} else if (src_reg->type == SCALAR_VALUE) {
>>> -					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
>>> -
>>> -					if (is_src_reg_u32 && need_id)
>>> -						src_reg->id = ++env->id_gen;
>>> -					copy_register_state(dst_reg, src_reg);
>>> -					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
>>> -					 * dst_reg min/max could be incorrectly
>>> -					 * propagated into src_reg by find_equal_scalars()
>>> -					 */
>>> -					if (!is_src_reg_u32)
>>> -						dst_reg->id = 0;
>>> -					dst_reg->live |= REG_LIVE_WRITTEN;
>>> -					dst_reg->subreg_def = env->insn_idx + 1;
>>> +					if (insn->off == 0) {
>>> +						bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
>>> +
>>> +						if (is_src_reg_u32 && need_id)
>>> +							src_reg->id = ++env->id_gen;
>>> +						copy_register_state(dst_reg, src_reg);
>>> +						/* Make sure ID is cleared if src_reg is not in u32 range otherwise
>>> +						 * dst_reg min/max could be incorrectly
>>> +						 * propagated into src_reg by find_equal_scalars()
>>> +						 */
>>> +						if (!is_src_reg_u32)
>>> +							dst_reg->id = 0;
>>> +						dst_reg->live |= REG_LIVE_WRITTEN;
>>> +						dst_reg->subreg_def = env->insn_idx + 1;
>>> +					} else {
>>> +						/* case: W1 = (s8, s16)W2 */
>>> +						bool no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
>>> +
>>> +						if (no_sext && need_id)
>>> +							src_reg->id = ++env->id_gen;
>>> +						copy_register_state(dst_reg, src_reg);
>>> +						if (!no_sext)
>>> +							dst_reg->id = 0;
>>> +						dst_reg->live |= REG_LIVE_WRITTEN;
>>> +						dst_reg->subreg_def = env->insn_idx + 1;
>>> +						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
> 
> I tried the following test program:
> 
> {
>   "testtesttest",
>   .insns = {
>   BPF_MOV64_IMM(BPF_REG_7, 0xffff),
>   {
>   .code = BPF_ALU | BPF_MOV | BPF_X,
>   .dst_reg = BPF_REG_0,
>   .src_reg = BPF_REG_7,
>   .off = 16,
>   .imm = 0,
>   },
>   BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 1),
>   BPF_EXIT_INSN(),
>   },
>   .result = ACCEPT,
>   .retval = 0,
> },
> 
> And it produces verification log as below:
> 
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   0: (b7) r7 = 65535    ; R7_w=P65535
>   1: (bc) w0 = w7       ; R0_w=P65535 R7_w=P65535
>   2: (77) r0 >>= 1      ; R0_w=P32767
>   3: (95) exit
>   ...
>   FAIL retval 2147483647 != 0 (run 1/1)
> 
> Note that verifier considers R0 to be 0x7FFF at 3,
> while actual value during execution is 0x7FFF'FFFF.

This is a verifier issue. Will fix.

> 
>>> +					}
>>>   				} else {
>>>   					mark_reg_unknown(env, regs,
>>>   							 insn->dst_reg);
> 

