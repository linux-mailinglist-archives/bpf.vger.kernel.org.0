Return-Path: <bpf+bounces-5237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC02758B59
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4137C28184C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF15F17FF;
	Wed, 19 Jul 2023 02:31:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB977523B
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:31:07 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539711BC6
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:31:06 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36INPHMc013635;
	Tue, 18 Jul 2023 19:30:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=pvke0MrVwmD87Il2grwAJqIEy0xf8NKqoB+t6qdSsWE=;
 b=EL63weKzkQXMnkcSS4SRjAV7Zi3zkfl2nArH2ZbcBBIi5SNSSnNiifI5T8x8ZFlr9EG4
 rAzxOuyQs/jxB3qlrINMVQ67Pd6tBoJenxghpHBVgCYP0bPsSlZ4ApvIO6RBPaAJuc1s
 M5UIV5kcn8zhz17ucJJLbevTGmRl2eWkPQ+tOjiPvMETa7iSGJGLZWx/SDS2nccP6pCx
 JSFaFJV8hrqnPGlLfP/IfA4/w69VESfEfRv4Yk/6/yPChtmvUUz883jdWgqdeAORidEu
 xkeOc/pR722AmxL8LZEVi6GX5gApImcH7a5j1h7b1hWCBZwFZsSlvpEfpMY4RhB6hslW xA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx4cyh5bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 19:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+9dJGP4LoeVgMly8LDMq1kh9JK0hZiTN2IbuyejxNH7LvD0yb0FZnK4ArpEOxIg0kUOe6wrjalUp0Q4zoHbOy8ylGHv6vv2i6fgySHL3K9lYDLpZK0nWY0j1QzRdiLiGdKd24W43DRxnpvgyxkLgP5OZVnkIWqRuc8POWR/3h5r7IycDfeEKo7HAO190zdCcyNn2i6VJzKoQiSYIMbHw8szr/p1smK+ovnQwpokWc0Zq+Z1YLv+FvIscoZSbWF+au1uA98SjzaNr1kZw0EBwI5cz+tBjQqeRMJf+t20qwVoGV6KXfvCHa4CiNm3/wOsq3T8H2yyGpxd/vEX1ZIQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvke0MrVwmD87Il2grwAJqIEy0xf8NKqoB+t6qdSsWE=;
 b=LnpG/F2+vOtUdPKoAggbaC7Zv4O5B8Tp6GDhh9Yyb3TUpc/9nBjvzAo+y6Zq1a17sHLVpE3aUpoq8XIW7qavWf1qAXBT9oZgRBseil0a7AlPkxxiHzZSTbZW1SsT4+HhADVSrKiT4Mo0erit0ezgjrWrzOtTtq1YH3V189plYp2Ya/lIk2JWxtlabB39h4zA2zDrd5ppmEOtE3CVTAjV9Q6rzXzi8dOw3eu3b1OA6IjHR1WC95RwCoL66z2WH8mv2Oxew/j6mM7pq/X5KBa3NwgzXQC7LDKNNtY7e/U2O888pr8l/aeMVMSHVqWhFgG2i9ENwXVMppYlhSr4g3/FBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3878.namprd15.prod.outlook.com (2603:10b6:5:2b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:30:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:30:47 +0000
Message-ID: <5cdd79d3-d4c7-b119-ebcb-b8b143c79a01@meta.com>
Date: Tue, 18 Jul 2023 19:30:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Support new signed div/mod
 instructions.
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060744.390929-1-yhs@fb.com>
 <b8a16850c0482bf64f30b41c7dcb8b33ea6a6f61.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <b8a16850c0482bf64f30b41c7dcb8b33ea6a6f61.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a89729-1ff6-417a-6eb2-08db880028be
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uMHhuMRIFz7w5oD1lOUqhoHvNz1GiBzzxBh6PUQTsadNDUv6sUx2ZPKyg2Oz0amYQCtjA33AdqGadCFNZw2R9PYq7x8AQBEHOlBjrAAeMQtKn6IsKN9YV6fWQ4kB1pFaJoUtskGVnVV4DU6i+qFbmWdeHMydJ8m56l7B+R2t/fJvfzbasYvqwJnhvz0SI1ZFUUgrT3gLtwcwHelknBKgJuNTT0RKvca5NvQp0ZLSedGtQbNS2O4sTaRBypSjC5sYKUQOnBDocjpYuGwrs8SgNARHxzlY0eCQHaI0L7gmLdXgxTbaoAvnHsSj5i7YImVskyv2pGKBW5QFQ/XwcJedV2zU22FYnRQ0tAoKAcTkBW6+bymHE19dgI43gw12Hdy9/A6TYGg0tjscSWOOX8mYbDzLqXFRFYkHmjQBIAUTRHufdQkHmfhQGyr/nhxnKSZsf4o5Su/BzUxNi+v2mcNnyznqdkepj4USI8muCfN5rEZLmwYn636z+y6v/V5qRr04tBQqhIqWNAbatOLtZSdtypUE8wcwNYjH0ylBPOwxQGEJnvZteTu75ubKRpzpgvJUa2kns4weBW49PMdEYM60O/BkB62U7ZJpeXxpZlRHHsLbt+t8wYrzFDZVPRC1eo33
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(66476007)(66556008)(54906003)(110136005)(86362001)(186003)(66946007)(4326008)(966005)(478600001)(41300700001)(316002)(6512007)(31686004)(6486002)(6666004)(8676002)(8936002)(6506007)(5660300002)(36756003)(2906002)(31696002)(53546011)(83380400001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWFhaE1FaVhuMFdtNnlOYUNLRy9Bd2dUL0RzMjdnWXNPVlc1d3BsVDViL1k3?=
 =?utf-8?B?VFo0Zjdqc1NRQlp4bFh0THp2Qmx5SUNYNmFqYWo3d2lkcU1pMU4zb1E5WjFu?=
 =?utf-8?B?bCtsTnJENTMveTIxSUdMMk1Ob3JSL0pFQjM4a1MwbmJlMDVHbnZQcTVtTmN0?=
 =?utf-8?B?NzF1Z01sWVVNRWc4Nmp3dG1zZHArZVZqQjhHTjF1MzZ0OWpGSEJPRUpOZlNU?=
 =?utf-8?B?c2JKQ291K24wUTNuOUtZcW5LQVp6OWxaMTBtaGJqeXBSd0lMdGFGbWdtOHlv?=
 =?utf-8?B?dXUrWnExMHhKS3lkVXgvc1daSC90bFVUN3VKbmRScFM5bjJOckg5VFRWbGNm?=
 =?utf-8?B?N3lxNGNITE9qS0d1SVVMQkxiMEJidkh4QU5RdlYyclA3eUJUSGU1TEFZdzlT?=
 =?utf-8?B?UkN0RldCNXpYUyt6QlhycWpPWnVxUkN1TFExWlZ1dWRrQTB0ODNCSEZxRDZo?=
 =?utf-8?B?SE01SVRhakdkYVF6M2ZOVjYvUzA2NXorajdpSEk1UGlVOERWSTg0c01YS0lN?=
 =?utf-8?B?emxYcllKbm9NejIzUUtQcDZ6Z2M4ZSt5dndGNUw2Z1Z3dmtSTk42UThacnl1?=
 =?utf-8?B?YUxXQTlVVHNkT2szN1BRQTFJaElhUE1QaTRGbFJIL3BDbFhwbm8rWW90Snow?=
 =?utf-8?B?dFpoWnlwV2tsZjV4RmJNSGlZL25BU3AxMDdKVUxWQVVldEJmbWYwclc1OXIy?=
 =?utf-8?B?YXJ4WmhPWk1ZUUxRcHRIOEpqZG42dVlFcEF2OHhXVlNtWkFKU2g0T1NSaGgy?=
 =?utf-8?B?S0FFY3M0a05UYXFYeHFwRmo0dUtCN0VDdFkrcU5YdFRnU2pvZ3lpWUY2cDAz?=
 =?utf-8?B?MXVPcTgwZHlwVEMwZm8vWk9RbjZPUXVFQmpGV09EaDFycUxnaEpIQnV6Unk4?=
 =?utf-8?B?U09EUE1HcndIajVCcUF4b2VyTFZzbmQxYjU3NjNpaEVBb3g1S3E0RDB0ODVj?=
 =?utf-8?B?R3RmZE56RnJGVUV1VjB5aU9xUGpPMlZrdjQvZWVZRUd5TG9BK0pIRlczVmFJ?=
 =?utf-8?B?Mjc2OWlyTlJNUG1nOFFZVTd1Y0I5TVlmM0thM29waVVDeTJKRTRDTFZVc2hn?=
 =?utf-8?B?dXVvKzNpUklpZlRNWERwQy9OaDR5KzlCYjc3S1JkeFZtZktvdU9ZMExQNFNs?=
 =?utf-8?B?YzZoeW5Sano0RVVvQ2lxaVNWSzN4RWNRTklPZjBWNzlFOWpNV1JBbVB2ODBF?=
 =?utf-8?B?ekM2QmhkdUlEaTdjTTJzOVI0bzZqQ01pY3U5T05ZQzVRN2R6UWtnMEw5NjJu?=
 =?utf-8?B?ZVZjZnpMMHQ2azBxOVlLRjNKaTB0ZUJhYmZrOWNsK0RldFRmUXhCWTU0cHQw?=
 =?utf-8?B?Q3lrbkhaVUs3ZlZieXBUQTNmT0ZKU0pXbFNCdnpBWE51WUNPbGJqQVoyVmV0?=
 =?utf-8?B?alJweFNVNDEwQ05NWElGaHU2UE5IOVVCNmorNThkNU1veEd4ZU9TZHplNXZ5?=
 =?utf-8?B?S0NmMlFMcUY0elJCMDRldVR1UTgxcTBldzdCcDFYTUJZMkN1ZzNkSGJhbmhI?=
 =?utf-8?B?RGF1N1l4NnJockRXU2RNU05tK0Q0UHFzMVluczlrUUV6TVRHMjl0Smh1SVJZ?=
 =?utf-8?B?UVh3U3phQVpEd3RxelA0Y1FOVkowdzZSaUVCN3VweiswRG1EOEowZ3p5S2Fn?=
 =?utf-8?B?SHRXR3BuMjJmcS9yZ2pORmR5bTQ5M2ZReXlRSWJpalgwRno0RkVQRTk4MEl1?=
 =?utf-8?B?WnRvVDlRV0c4QkNBZ2I5SlpDdElGS0tESTFmekVFbVJDVXBDTkRmcVRZU3kw?=
 =?utf-8?B?YzBMVGZkbG9Qa25uUGY3MGY0QnRKWFlHTUo2RU41aUVDekRHYU5KQkdCUFh1?=
 =?utf-8?B?UXA3cnRoUmptUUhFd0k4UlBOcEJ4bUwxZXQwUHFnVjhlNVpDUkV2SmlGd0dS?=
 =?utf-8?B?WHkya3ZRSHgzQ0tnTlJ0Rlc5OVFEeld1amFBVEM2VjNqbTJDdENTdEIzK0tN?=
 =?utf-8?B?bG5yZGlsOXZ0V1ZSVXBaOG5QZGp5b0pvS0hhL3JDU2NydWo2UDZKNmoxb0dU?=
 =?utf-8?B?aTB5Z1FxcWtUWWNBTE5pVUtlVUNZY1h3Nm1oWlZVQkdmdTFDRTQxRGhGNUZr?=
 =?utf-8?B?R0k5S0NiV2ZJcnZhSUY5cmRrZldhd0VHY0dCaURhL3IwZUFJcGd3aml5WUJv?=
 =?utf-8?B?RHF2WUk3VFNLRXBHNmFLTDNhbUdteWt0WkVmVlpaN1RLR25rREZjOStCR2tu?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a89729-1ff6-417a-6eb2-08db880028be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:30:46.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhUWorWdw3cPbwLSQ36/fR59MPKI1wpMnHVx+AYzXl2km5U166l60yVGExyFVTMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3878
X-Proofpoint-GUID: oRKzWnsWwBa-kvBTwxoSmbxdRC97fXTH
X-Proofpoint-ORIG-GUID: oRKzWnsWwBa-kvBTwxoSmbxdRC97fXTH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
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



On 7/18/23 4:00 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>> Add interpreter/jit support for new signed div/mod insns.
>> The new signed div/mod instructions are encoded with
>> unsigned div/mod instructions plus insn->off == 1.
>> Also add basic verifier support to ensure new insns get
>> accepted.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 27 +++++++----
>>   kernel/bpf/core.c           | 96 ++++++++++++++++++++++++++++++-------
>>   kernel/bpf/verifier.c       |  6 ++-
>>   3 files changed, 103 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index adda5e7626b4..3176b60d25c7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>   				/* mov rax, dst_reg */
>>   				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
>>   
>> -			/*
>> -			 * xor edx, edx
>> -			 * equivalent to 'xor rdx, rdx', but one byte less
>> -			 */
>> -			EMIT2(0x31, 0xd2);
>> +			if (insn->off == 0) {
>> +				/*
>> +				 * xor edx, edx
>> +				 * equivalent to 'xor rdx, rdx', but one byte less
>> +				 */
>> +				EMIT2(0x31, 0xd2);
>>   
>> -			/* div src_reg */
>> -			maybe_emit_1mod(&prog, src_reg, is64);
>> -			EMIT2(0xF7, add_1reg(0xF0, src_reg));
>> +				/* div src_reg */
>> +				maybe_emit_1mod(&prog, src_reg, is64);
>> +				EMIT2(0xF7, add_1reg(0xF0, src_reg));
>> +			} else {
>> +				if (BPF_CLASS(insn->code) == BPF_ALU)
>> +					EMIT1(0x99); /* cltd */
>> +				else
>> +					EMIT2(0x48, 0x99); /* cqto */
> 
> Nitpick: I can't find names cltd/cqto in the Intel instruction manual,
>           instead it uses names cdq/cqo for these instructions.
>           (See Vol. 2A pages 3-315 and 3-497)

I got these asm names from
   https://defuse.ca/online-x86-assembler.htm
I will check the Intel insn manual and make the change
accordingly.

> 
>> +
>> +				/* idiv src_reg */
>> +				maybe_emit_1mod(&prog, src_reg, is64);
>> +				EMIT2(0xF7, add_1reg(0xF8, src_reg));
>> +			}
>>   
>>   			if (BPF_OP(insn->code) == BPF_MOD &&
>>   			    dst_reg != BPF_REG_3)
[...]

