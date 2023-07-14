Return-Path: <bpf+bounces-5051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F075455A
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 01:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536A21C21677
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A752AB2F;
	Fri, 14 Jul 2023 23:26:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398932C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 23:26:39 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABAFD9
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 16:26:37 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ELHWkN025644;
	Fri, 14 Jul 2023 16:26:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Xah8MOSrypUJ/gGCEwBqkb2igrLQ2SBpFHrHVl2Al6I=;
 b=JhC2xuQiUXK6VMqczMopwwIFcABEqQcgbTwY/xYRAY1qcj5I46jpn1hCOxjN97nAe4uz
 2ph1BVwvPJlSgJyKzTMWWbHTSBBMlC08c9qsxwq8G7dQZQmaG8iqG7cd9y6N4hZrIJKw
 NPmfbKIdtTzi4AjILfVbNakv80OtXpRwYiTusx6Te7B2txIGhpLo8wI54EDCo++e7jfs
 2ml5PgYNMLdTRRJ0tgev7RNzteujdu2pQCEVZvii+LwGuM9yCVtFpLP+ozdEa0Av62rX
 hm2jousYfOpgTQ1s/qnE/f6SQPVL1sIVNtw+WeYsh+dj83PdegIrmcbw9pRHZw2eYa5F 2Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rue4q8t8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 16:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV/VFq8mDeAkXUKKAzSxTJ6BW4fTmm8pcFJOLJcYBwO+pX0dDMzDolOmh2su5E+usfOITb9uTre3qrgcu5Ftcek7KKGC32xhdROyHLXR3JVOSAc3Y+fMlVrlThcutbiIqJiS4NPVRGQlOcJrrH7Mv3f19iLGMlBWn9JcnNGa8MXoAnuL68e+apWiQZohkZYlX10+cPr9/kbRlPHpf9dZdVFVOqv5SX0JBh/yvSmis0nFzPINAj7O3Uoqk8l7VCtXjw6XOnhSE3itWGjCr345Ai02bNe0ERVdk0b/FA0REb/uOXBaBH8tHBQeDw8zjsKx7Cl2P9h/2yBHFODcQTkg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xah8MOSrypUJ/gGCEwBqkb2igrLQ2SBpFHrHVl2Al6I=;
 b=M3HFjLeSpb9S8f4/5Jhva7QptRw5jah0xtGOfMgasfMZAWKawsAxcDtiC8g1I7o5Y5vUFsQjBy7xoGVeAWmK9gX8iIJFc/hYqvY1LQoExpHVtuJ8wNZlNCAeTHhCAzunRucl/5UE1cSfGubBlttzKo+iRJTxIZzfNE+XroO3vH+ZHBdwHU1vh2rwPHsiMPYzA7gv7ytiEYdj/z/G1I4q4+8rvRg9qgLLB5tlQHYb7xGhWWL4ErUYl2Jk2EU8Mv2SK4x4BOm/QRg8cl4UrRjgrFNtARUykUwGaR9djaV4Bc64/m79zIkNb0Emcbn0WfTAPLp8UoaC7Y6xA0Yousl3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5709.namprd15.prod.outlook.com (2603:10b6:510:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 23:26:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1%4]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 23:26:18 +0000
Message-ID: <5d530e78-a532-3544-f005-d33c962c61a6@meta.com>
Date: Fri, 14 Jul 2023 16:26:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
 instructions
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060847.397969-1-yhs@fb.com>
 <20230714182805.rvfrf4y4ctmrqbav@MacBook-Pro-8.local>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230714182805.rvfrf4y4ctmrqbav@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: f56c5ee9-0d5f-4582-ec6d-08db84c1b868
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZBGDREEnR8b3Q6YnTSx+hZRvpNWwln4QNWnATXcvGjKPRTdDtzZrIWY4/Q3f12xJ36rv6Fhit0CP1oMnQM4d3Ul3ZcxjJ0jH1GWe11Wlq8uBwvnnSqBMaKdWkf3to3QO7eEP1TGtlGgmNinc8sBFrg/ENkwSYCnz/QRBM3zbWvQ5zt2Ko/Jq6eRqAr5Cwmvf9U3kI4JuQPHbH8oKAwyAUh+GFM+SnTwCBt1812Gr6CKbmZ1SXBuvPdGb8dOQzx+MEWxdahSVPArL3KVSaiR2zSUUFkiXJb07qxXs6Q2tn8VrI0Y1Hv+XjY13SmtXJHXsEowM8Cn/Wge9E4pLtYerYUEZTuFEVB+S014svk+gf2YUZ98e+acwG0vAJ4Yxe+4dbWCIkoGBH3mObbmPQw6DSA4pVXeclL3xTDb1U/4vfBovAjmvLGXM4Gsb+sZlAYFV8UzDy58LWcPG+FOITzhTdyaLdtFw7QUXH6NrTDoui6p/NVC0xg0OpIrK6Xbf6QOlp+FoNe7vf5fBuXH8PiNKU6nJpzS+0TB8+2YH7vQdhfTYasP3IGYGfiObFi6Sur7Xbs2yNqH2nywyjOpdXe0ALT/uj1QECezQN50ISq/SatSbLjuCQCxaIUaMKF5UTCPM4M/J5DauFitchOqaeHfxMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(31686004)(53546011)(6506007)(38100700002)(31696002)(478600001)(110136005)(54906003)(5660300002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(6512007)(86362001)(41300700001)(316002)(6486002)(6666004)(2616005)(186003)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amNCbGVIR2g5a09kL0Mva29HWUhTZ1ZsSjV4WGNPZG5xdHhTMVNIWVZnQXhl?=
 =?utf-8?B?bHdWUUxLMmVqU2wwcElqaS8zZVhWcFZnK2h0UGxZbW5vVlNXMEZGQ0dWWWRl?=
 =?utf-8?B?NVZTK1dwK2dYSzdFbkxjK1l5bm85ZXg2dy9DNkRjVFZZaFRUUHpNbmdHTC9M?=
 =?utf-8?B?d1diQzA1eVlUeHZvUjFHUThOT1NmNjdnL0cwY3V6d3BHSUc2L293RCtPM2Q3?=
 =?utf-8?B?UEE0Smh3Y3dZazJDVDNCdmdSQjZNbllVWENoNURmVGlWZ09kSWNiQkk1dlFB?=
 =?utf-8?B?eTU2SzVldURqTDlrR2JlaFkrcVU2TVhsL0xjZ3oxcjQrTFdCNXZnamQwbVZM?=
 =?utf-8?B?R1k2MGYyTnlTV0Y1aFlBWm1DanM2aWQ3NUR0enZFTDhjRDVSdXRQamJUOTl2?=
 =?utf-8?B?dFVzZTFNVUl4UFRiSkk2RFJ6SW80WHRTMWNqWlZiNlBjbmwzaGdsUW54VXhY?=
 =?utf-8?B?eWF0VnRjMWNsQnBlQXRRdVpLSnJUaFJEblJBMjdKU0VNS0lDZU55c2tDZ3Rw?=
 =?utf-8?B?WldMOUNDZDdKSTMvcjZ5N0pBK0tXU2p2UmVOUE5zdEJHbFZTTisxTm82cXVt?=
 =?utf-8?B?bTQ0WnVaZFpLblVMb2lxcFZwWEw2WlVzM21FNC9GNU1YSXZwL2Y5TEpyQ0Zs?=
 =?utf-8?B?UDAzTXlKN3RBMkx2U0Z3dG1wM08wNEZrSm5xQ0NMejJnUjBZSWZxOTNqQjhh?=
 =?utf-8?B?NTh4NFBRVkJZNmhWOEcwSmg1djJqRjl1ZHp0bWhvbWNTMDBiK3VsSnM5MFh5?=
 =?utf-8?B?UWM0aC9qaVpvMUxzakppeW00KzFtVFhPaW1FQ0VUT0h6KzdoOXdPOHptR0lC?=
 =?utf-8?B?My96TEJHMU1XYWRwRDFxUDZxRGFlYXBPTWY2QVBpb2tMV0JydTM3Qm9hVEpw?=
 =?utf-8?B?NzRubjhGOENDd2pzQm84OTFtNGY4T2lUVzhxSUR2ZVZnQ2VuMkpUR1l5d0pZ?=
 =?utf-8?B?NGJybE1XWCswbnJMQUIwNW5KWlpyTmlna2FzWG5NOVhvbWV0S3FkOE5QOCtq?=
 =?utf-8?B?N0FlRzk4ZDU1MHI3QmM5bStPaWt6b0htRXRNMkk0cWgveXRMUllXdm5SSW1z?=
 =?utf-8?B?b2w0dUh1RlhCUjZQOGNLVmNPTDdJMW5hVlNoN0NwWnNMREZ5dWY0Nk94KzBv?=
 =?utf-8?B?NXoxV09EaVcyU1pkMC9EN2VsVXp3RE5KVmEySS9nSldWcDFlZkh1dU9hbjBN?=
 =?utf-8?B?Y2hoTURFdHVKUG1TRER4NlhlNEdsSnRpVVdRT2tPSk8yRW5sanplYUsxcWd0?=
 =?utf-8?B?My9NZ25sdzNDQVlObHEvV2NOU012Um9tQk03U3ZnY2o5WVZUUTNNNkVxYkk2?=
 =?utf-8?B?aFhqOWV1L05IbmZXRGthRW1UNnZ3WlY4QnErUDhGK21lWXNPd2ErazIzenc2?=
 =?utf-8?B?UXFZcmhMQWhWMWxMcys4S0dzNHBnRFp0aVRqbW90aE9iL2JlM2Q2R0NtTUNk?=
 =?utf-8?B?RDVuQlZYODd6dWNwcEpDRVFmMDl2eWFnK3NmVGp1WEorRGNyOS85SFhTd2hr?=
 =?utf-8?B?VFJQY1Ara1htaUtqclVVbzY5QjFva3ltYmpFT3pnUDd0b2ozc05OYkV1YkVo?=
 =?utf-8?B?Z252Y2VYalIrbmRmaUJxM1VtVmtYWFZFOEZIY3BmdTRjeFVlZVpTbVpPKzVu?=
 =?utf-8?B?NzNEYlM0V2RaQ3lpZ2hjTlI2VVlGM0s5WFBZOUZSVXNCVkRObEk5a3Q4aEp4?=
 =?utf-8?B?cFNVT0oxSTBOWURwVEpCaEFySnk4Y1JSWjRsZ3cvMjh5RXhvQmtwS1E1Q3J4?=
 =?utf-8?B?SW1qc1o5akl6aHY0OURTcU1xOWNjUG92QU1aVllIR1F4em1qN0Jqc1kvQTds?=
 =?utf-8?B?dGp4QThFWU90RC9CdGxmUVFmTjhFL3hIVlprWEg0S2F2dlIrMGJOUnVRTVls?=
 =?utf-8?B?M3pDdUZwTkQxbWthc2l0OU9JZlFZRmFBSlJDdFc3UGI4dUhUUFJIbDVzQXJQ?=
 =?utf-8?B?aUNBVDIwd3BEMTRDcDRhYUxNR044WlVOb0paRm04RFRRYnpKbUJGWmJHZUZu?=
 =?utf-8?B?MEJZN0VlOURSbXhRMXpQSTM3cUxmd2d5S3Y3OUk1SVExNUkxQitwWUxQZzJR?=
 =?utf-8?B?OU9xOHB2RlBlSmc1VnBnRXhzcC8xQ2wrQ2tTTDJsNWgrc0o2ZUhIVXdOV0ZE?=
 =?utf-8?B?NWFaTVFXR2xZWnE3dyt6eXh3TnlMc1A4blkvTStheXF2QVJ5ZVdYN2dqL0dk?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56c5ee9-0d5f-4582-ec6d-08db84c1b868
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 23:26:17.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALltfNCbBRMhlr+7t8QuD3xu7wHQ7Uwky1q4kTgdKZAInMuespSqTmiVkdS7OpCJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5709
X-Proofpoint-GUID: 5BK1TaCvOD_3y_6oKb3ZAqRozy67b_QP
X-Proofpoint-ORIG-GUID: 5BK1TaCvOD_3y_6oKb3ZAqRozy67b_QP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_11,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/14/23 11:28 AM, Alexei Starovoitov wrote:
> On Wed, Jul 12, 2023 at 11:08:47PM -0700, Yonghong Song wrote:
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index 751e657973f0..367f426d09a1 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -154,24 +154,27 @@ otherwise identical operations.
>>   The 'code' field encodes the operation as below, where 'src' and 'dst' refer
>>   to the values of the source and destination registers, respectively.
>>   
>> -========  =====  ==========================================================
>> -code      value  description
>> -========  =====  ==========================================================
>> -BPF_ADD   0x00   dst += src
>> -BPF_SUB   0x10   dst -= src
>> -BPF_MUL   0x20   dst \*= src
>> -BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
>> -BPF_OR    0x40   dst \|= src
>> -BPF_AND   0x50   dst &= src
>> -BPF_LSH   0x60   dst <<= (src & mask)
>> -BPF_RSH   0x70   dst >>= (src & mask)
>> -BPF_NEG   0x80   dst = -src
>> -BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>> -BPF_XOR   0xa0   dst ^= src
>> -BPF_MOV   0xb0   dst = src
>> -BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
>> -BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>> -========  =====  ==========================================================
>> +========  =====  ============  ==========================================================
>> +code      value  offset value  description
> 
> How about just 'offset' ?

Ack.

> 
>> +========  =====  ============  ==========================================================
>> +BPF_ADD   0x00   0             dst += src
>> +BPF_SUB   0x10   0             dst -= src
>> +BPF_MUL   0x20   0             dst \*= src
>> +BPF_DIV   0x30   0             dst = (src != 0) ? (dst / src) : 0
>> +BPF_SDIV  0x30   1             dst = (src != 0) ? (dst s/ src) : 0
>> +BPF_OR    0x40   0             dst \|= src
>> +BPF_AND   0x50   0             dst &= src
>> +BPF_LSH   0x60   0             dst <<= (src & mask)
>> +BPF_RSH   0x70   0             dst >>= (src & mask)
>> +BPF_NEG   0x80   0             dst = -src
>> +BPF_MOD   0x90   0             dst = (src != 0) ? (dst % src) : dst
>> +BPF_SMOD  0x90   1             dst = (src != 0) ? (dst s% src) : dst
>> +BPF_XOR   0xa0   0             dst ^= src
>> +BPF_MOV   0xb0   0             dst = src
>> +BPF_MOVSX 0xb0   8/16/32       dst = (s8,16,s32)src
>> +BPF_ARSH  0xc0   0             sign extending dst >>= (src & mask)
>> +BPF_END   0xd0   0             byte swap operations (see `Byte swap instructions`_ below)
>> +========  =====  ============  ==========================================================
>>   
>>   Underflow and overflow are allowed during arithmetic operations, meaning
>>   the 64-bit or 32-bit value will wrap. If eBPF program execution would
>> @@ -198,11 +201,19 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>>   
>>     dst = dst ^ imm32
>>   
>> -Also note that the division and modulo operations are unsigned. Thus, for
>> -``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
>> -for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
>> -interpreted as an unsigned 64-bit value. There are no instructions for
>> -signed division or modulo.
>> +Note that most instructions have instruction offset of 0. But three instructions
>> +(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
>> +
>> +The devision and modulo operations support both unsigned and signed flavors.
>> +For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
>> +interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
>> +first sign extended to 64 bits and the result interpreted as an unsigned 64-bit
>> +value.  For signed operation (BPF_SDIV and BPF_SMOD), for both ``BPF_ALU`` and
>> +``BPF_ALU64``, 'imm' is interpreted as a signed value.
> 
> Probably worth clarifying that in case of S[DIV|MOD] | ALU64 the imm is sign
> extended from 32 to 64 and interpreted as signed 64-bit.

I thought this before but think "'imm' is interpreted as a signed value"
might be good enough since in this case BPF_ALU and BPF_ALU64 should 
have the same signed 'imm' value. But what you suggested will make it
more clearer. Will do.

> 
>> +
>> +Instruction BPF_MOVSX does move operation with sign extension. For ``BPF_ALU``
>> +mode, 8-bit and 16-bit sign extensions to 32-bit are supported. For ``BPF_ALU64``,
>> +8-bit, 16-bit and 32-bit sign extenstions to 64-bit are supported.
> 
> How about:
> 
> Instruction BPF_MOVSX does move operation with sign extension.
> BPF_ALU | MOVSX sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.
> BPF_ALU64 | MOVSX sign extends 8-bit, 16-bit and 32-bit into 64-bit.

In previous doc, we already says that BPF_ALU operation has upper
32-bit zeroed. But since this sign extension is special, agree it
is worthwhile to mention upper 32-bit zeroed explictly.

> 
>>   
>> +``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16 means::
>> +
>> +  dst = bswap16(dst)
> 
> Worth spelling out imm 32 and 64 too ?

Will do.

> 
>>   
>> +The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
>> +instructions that transfer data between a register and memory.
>> +
>> +``BPF_MEMSX | <size> | BPF_LDX`` means::
>> +
>> +  dst = *(sign-extension size *) (src + offset)
>> +
> 
> How about:
> 
> ``BPF_MEM | <size> | BPF_LDX`` means::
> 
>    dst = *(unsigned size *) (src + offset)
> 
> ``BPF_MEMSX | <size> | BPF_LDX`` means::
> 
>    dst = *(signed size *) (src + offset)

Will do.
> 

