Return-Path: <bpf+bounces-317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF606FE819
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C701C20C93
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 23:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE51E532;
	Wed, 10 May 2023 23:28:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066681E50B
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 23:28:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0022693
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 16:28:45 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AHqLeF022522;
	Wed, 10 May 2023 16:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UVEelFmm9bYPCdx3KU4gicLlROCTUUkSj/JmRKwta3s=;
 b=GEs2+lv+Qf4L6TOcC8rgwNw3cjiidqIiYb1L3o/p7hULYNNOT92gXVzAoWybN9t+E8Lr
 2XLrpj0ImRVQ15WucEEFXzc3d+LFaJoR5fCj/uAjZCV7hltwzONoX/ADUSMdG9hK0XJV
 w0P7oY5OvGmqgRHeq/L5w5CgYKCVRd7/bDoUgn/YTcQ6phjsypt2wtI2/2cTMpKiy9zT
 MF3hf3+EbqGIH1gbHBYFmH9dD6NGWF78LXb8gb6nh/OKU/uZhb9jOzdUwJkdE9u9u6Da
 e4pGGLMdxF+qJYtmRrpfrPVucjUIEjXsewTWiW3c1IGtPTeGMrn2Qf97OIq8OXFBpOpf 4Q== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qgeqjav8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 16:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGi7jupFVj9SGe+w9UNhekmO46E1l/geGMoV1PlYoAKfNZ/6Oq7p2j43eoIQLWjmGW6+aUbwnuigCjUamuit4ich3kULdHm6LLu2JxbJqg9y3jwQHkOx8qG577WTzpb4/co+odjEBj+HV5oLFoFdKzkhyrywFU2rV2v8mjQdoMRxPjbZ39pLnvi61Qk5F5sZkT31rVCiYoSiXOn7e3GsZq1T6qZjy4ihTc2Dc/htPCIbltTukcx1JgdbYfQVnyI9bBZ4EJqzPSRu0B9uezZZmYJiFHzDiuTqvyr+uSCA4wLi/aERnvh9xFkRzYvX1/lC6TWDvaiQ5MYOITkXqWiOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVEelFmm9bYPCdx3KU4gicLlROCTUUkSj/JmRKwta3s=;
 b=CalIcADAPU6tI6zdksmZNmUioaLBV8M4JjKbGCq96ZPgFEcX3YES/UnBDsi0UOKw5uz+K5hw+Zsp7LHVzYqMf4GPqRs1LKUAnJIoE7vkXhC6bjvBS/Pam4cdLuUX0XJziD+A19MDsRfZi8drAbfIscQ7S09PWbytoSkpMXNp6AUK9bTf87+aVt6mBoi5gJHfbeuK62u3OlUTRW85BCtAy0TmPO94DH8v82UM+lmPWJYb33VcuvCxgggJ2peNg+qgN6Vkd6+4m9tNb9CSqjwvdL9Xls1iWOkWMsh32j89OpGQ3QXL5phIFqG6w6LFq6WQeQSaXZ5Tso4msJGUrPmnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3821.namprd15.prod.outlook.com (2603:10b6:806:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 23:28:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 23:28:39 +0000
Message-ID: <e702f65c-0d6a-d9d6-12d7-d25d3597966b@meta.com>
Date: Wed, 10 May 2023 16:28:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] Shift operations are defined to use a mask
To: Dave Thaler <dthaler@microsoft.com>,
        Dave Thaler <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
 <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
 <PH7PR21MB38783D142478D9D569188B5AA3779@PH7PR21MB3878.namprd21.prod.outlook.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <PH7PR21MB38783D142478D9D569188B5AA3779@PH7PR21MB3878.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f8fa3e-4fcc-4d8f-f64f-08db51ae48f3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mcqOpfTsvNIm9NE7vic/Qp2ez6KKOXJS808DUf5iPD5DcWem6ae09TmUetd1MI7/r06zVLoxtFky+cD1feTvBC2Iun07Ubv0IDxTmiUVFgZzc8Cv31jyYA+ZIhr7A1unAltn9rPkzPXFZtceMA74g7rt3awXwHTl6zoDpUY1VYkAfb7PxqGfQ2X816G9f4fnrN0VZabMokRVIsM02ckkkC1mdWhCRGLL7e/+EfaIA+8T5dJYRz4lhAUvEqvjRVQWkMZcNAHaadan2+fGIZXLSiZv4yN4XMVJ2lDR2jnydwD9yDNjmrDI3wPVn0DwMRaU/r46MVqDIijFxLc6Zz807+XeyN8bzAfNoFNHWqN0fJX3G9G/YqLu32oPhfr2fOamAOaFwLSNbBe3VL9KVOMfzJyKws3QYXJJAos6PSYvR+a/9rIj61q8T1V8WAAXe85r4l9LHTllxfo1heHOFENFfq6ljNyj33xe7KwCD/XtbbOAVUk0BufnVwuzCwjjge0SGqthkorV1T14VQcoZF+gIDicF6VaQT9ewixMcYK+5LqNIgDAJ8JwoRTQuoHncXYZpCskLlJo0m0Hc9RVXD+B5Va+10efDenuxPESPSF30u4iW9HRrDF8OUKMA64iIY8Z7bareFXLUYesvlRIJvBt+g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(86362001)(38100700002)(36756003)(31696002)(31686004)(8676002)(8936002)(6506007)(5660300002)(478600001)(186003)(53546011)(2616005)(6486002)(2906002)(83380400001)(66476007)(316002)(45080400002)(6666004)(41300700001)(110136005)(66946007)(4326008)(66556008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHFjcGZSMEhVczdVTVMxM0F5UktVcWdqUFRKaEVWeVNLUHJ3UkhnclY0YTFs?=
 =?utf-8?B?dWY1ZDhVek9nV3pTT0p2OW5Hc3djdVFGbzZUSFZKQzlpS2hOTTUvNXU1Q01Y?=
 =?utf-8?B?d3NYWHpzOVNJNHJmU09qRTRxZjdaVTR2dmlRMlIyOExEUk10ME94YUVTNU5h?=
 =?utf-8?B?Z21Wa3hVWHZJK1ZqYUtpbVlDZUlVZUpHNkQ4Sjd6SVZKMzB5emtORkdkc3Yy?=
 =?utf-8?B?bjF2RnRPVm9CWldFRldLWkZLL2txVDRQSjM3ZWx1NmFSd29WN3ViTUdPV0Jw?=
 =?utf-8?B?NkY2dEkxMEhwOEpVVTRWdW1JeW42bEcxLzNEYjBTZ2tqYmRybkVLVENqTFlm?=
 =?utf-8?B?elEwaHJnbUlZSzFPbkVTMVhKL0lLOWw1aUhaa0YyM0cyaDJndGl0NGljS1lq?=
 =?utf-8?B?MWUzTUdST1Y0UlJzR0EzeWFRU280WHRQNHAxRkpMTDhlbXhubGN6QmxJMC9F?=
 =?utf-8?B?R3RLRHpnUDMxM2ZGMFgvREtlWml3dFlIWEdRWlhOeFd3TnNqRHgxdmVPdVZv?=
 =?utf-8?B?Q3FGY29qNFBjeG5wRUJ6ZVV5TzFsbUtSbDV1NXp3Q21ZMnF1NFdzVlJrTVNk?=
 =?utf-8?B?N0lyQy95d040d1g5S3E1aWZpU28vSzF0aUUwYlo2ZjZmSzJ5TnpYSXFCQk00?=
 =?utf-8?B?SU51eUNoRm8zS1hQSld0MmVhTEZvb0R2NnRZOWlOSDQ4STdzZDhnOGlvK05V?=
 =?utf-8?B?WHplVUJPTDNtLyt5UDZQcEJ6VmxqeWY4SlR3UVJpbGdqQTFCdUpzZUZMTUtj?=
 =?utf-8?B?NGFYODVJN3RzaUNzU1hXdG1vSDFVQjR5ZjhiMittQm9vbmRQYk8ySkc2aWty?=
 =?utf-8?B?ajFsNjhQYVEvaGtBUkR3ak9UVG91SFVKUmdRVDJmYW5iV25hT1dGR0krZi9w?=
 =?utf-8?B?Y0l3UDZyM3dOa2duWkt3dUN5ZDVBbkc1aVk1KzhwaFdtdXBiYjFLUDEzdnhN?=
 =?utf-8?B?YnVCQVVRTHVoc0djbHIzUWtIMWJqckZhbXZWUkY5dWxicWJaMlpVNFVBRlFL?=
 =?utf-8?B?eGtGaE5YL251Q1dqTjhvbERacHRXZE9TUHJEdGRvRXlQTi9ERzJPK1hKc3RH?=
 =?utf-8?B?cjZ6RjZLVzRxNUJhTTNrQ0tOdWRLZGRhTmVYTFB5NXZxWnZRYkZrdnZweGNC?=
 =?utf-8?B?bkRiOVUvenB1VElKelp5K2d4UG56UXNqV2lpMzhnRmRCd3VWRjgrYThKakg3?=
 =?utf-8?B?TkltUUJFd29hZmcxV1NCMW5ydUR6b0lwTUVWMWJkSDkwQmJHUk9RRGk1Rno4?=
 =?utf-8?B?ZFhzS2NEaXZwcHFGa2pNTk5oVWRiRkQzUTFUMDBNaTRaNFRqWFo4dmdySktp?=
 =?utf-8?B?NWZ6RVgzSzlHK2cxb2Zka1BnQmtPVnB6NUtXTEpOTmFRYWw0cGRQa2NMRS9L?=
 =?utf-8?B?Y2I0UEdGQUV2QXlndnpTVHJYeEJjZGJyQWxpeDV2dWt1S2ljM2R0VWtWYllD?=
 =?utf-8?B?MzJpQ29UdjRMWDVQK0FrRXJBVjVYcWpad3FCTkRvQVZtN1NCNGlyWWJ0UnRH?=
 =?utf-8?B?NlJ3dWk5MnJTcm9VaHhRTG5GYnZ0UTRvaEhHMnp0RWxpYlFoczhaZHZlOFFr?=
 =?utf-8?B?QnlaemdYQWVyekFzNStISDFlemd0YzZFZGxINDc2cFJPenAwc1Zib1drZlpE?=
 =?utf-8?B?b2hvZFE0OUJFN0VVam03QU1ZN1lqTXZVU1ZYcGlRSloxNHVEbStMaWg0Vjh1?=
 =?utf-8?B?dnI2RkVKZnJsY3d2dEJuMm9hd0RVLzdUZ2FnVWhjRjBiT3BMRENoaytnL216?=
 =?utf-8?B?eThjc052aGUzSmdJQVN2OFJnT2F0MXNkRUlOd1Z1eXJIVks2bFUyajJyNWh4?=
 =?utf-8?B?bWFYM2p5V25uWVlwSldiYWE3b1VyZ3RxUjJVNHEzRm1mazRSb0MxQnpjdWR2?=
 =?utf-8?B?QjQ3SEFJUmdERDlhSnRBajNtOG14eEpyL3JJL2xJU21mdFZUWm03RmJ5UjIr?=
 =?utf-8?B?VndXZzk3VHcvN3JKOEdESFhPVHp2azVtaXJzWXI4di9VNjRtK3dLcnhkdHFw?=
 =?utf-8?B?OHI3ZGlYWVV0NjIwd29Ob3pCUDJ5MS9KUUJacHN4YitZMGk1REs4WXJuYU1B?=
 =?utf-8?B?MlM4aTZHZ0VXaU4zRkZrenFrT3BTQ215VE51Mzh0R0ZHMllxVHl6RGViZFZh?=
 =?utf-8?B?TnF3bFgyM3c3clZmREZMWkQvWTJaRVBoUmFkaU8zU0Zma3dvd3ZiTVJmbnVW?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f8fa3e-4fcc-4d8f-f64f-08db51ae48f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 23:28:39.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojvip0UGDkriGI0ySoCNybOBwVq/nFCGD8A3N/Ho5Er7x27cyVf2gEMRIYhDtBKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3821
X-Proofpoint-ORIG-GUID: 5gYBGgW3Cm1P0TU1EyZy-Q6BbhjDwvu6
X-Proofpoint-GUID: 5gYBGgW3Cm1P0TU1EyZy-Q6BbhjDwvu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/10/23 8:45 AM, Dave Thaler wrote:
> Yonghong Song <yhs@meta.com> wrote:
>> On 5/9/23 11:08 AM, Dave Thaler wrote:
>>> From: Dave Thaler <dthaler@microsoft.com>
>>>
>>> Update the documentation regarding shift operations to explain the use
>>> of a mask, since otherwise shifting by a value out of range (like
>>> negative) is undefined.
>>>
>>> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
>>
>> LGTM with a few nit below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
> [...]
>>> -BPF_ARSH  0xc0   sign extending shift right
>>> +BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
>>
>> 		    dst s>>= (src & mask)
>> ?
> 
> I had thought about that, but based on Jose's LSF/MM/BPF
> presentation yesterday there are multiple such syntaxes.
> 
> ">>=" vs "s>>=" is only one of several.  There's ">>" vs ">>>",
> there's assembly-like, etc.   So I thought that it would take
> more text to define "s>>" as meaning signing extending right
> shift, than just saying sign extending ">>=" here.  And I didn't
> want to just assume the reader knows what "s>>" means
> without defining it since neither the C standard nor gcc use
> "s>>".

gcc will implement clang asm syntax as well. So for the consistency
of verifier log, bpftool xlated dump, and llvm-objdump result.
I think using "s>>=" syntax is the best.

The following table is the alu opcode in kernel/bpf/disasm.c
(used by both kernel verifier and bpftool xlated dump):

const char *const bpf_alu_string[16] = {
         [BPF_ADD >> 4]  = "+=",
         [BPF_SUB >> 4]  = "-=",
         [BPF_MUL >> 4]  = "*=",
         [BPF_DIV >> 4]  = "/=",
         [BPF_OR  >> 4]  = "|=",
         [BPF_AND >> 4]  = "&=",
         [BPF_LSH >> 4]  = "<<=",
         [BPF_RSH >> 4]  = ">>=",
         [BPF_NEG >> 4]  = "neg",
         [BPF_MOD >> 4]  = "%=",
         [BPF_XOR >> 4]  = "^=",
         [BPF_MOV >> 4]  = "=",
         [BPF_ARSH >> 4] = "s>>=",
         [BPF_END >> 4]  = "endian",
};

Also, in Documentation/bpf/instruction-set.rst:

========  =====  ==========================================================
code      value  description
========  =====  ==========================================================
BPF_ADD   0x00   dst += src
BPF_SUB   0x10   dst -= src
BPF_MUL   0x20   dst \*= src
BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
BPF_OR    0x40   dst \|= src
BPF_AND   0x50   dst &= src
BPF_LSH   0x60   dst <<= src
BPF_RSH   0x70   dst >>= src
BPF_NEG   0x80   dst = ~src
BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
BPF_XOR   0xa0   dst ^= src
BPF_MOV   0xb0   dst = src
BPF_ARSH  0xc0   sign extending shift right
BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
========  =====  ==========================================================

In the above, the BPF_NEG is specified as
'dst = ~src`, which is not correct, it should be
'dst = -dst'.

See kernel/bpf/core.c:
         ALU_NEG:
                 DST = (u32) -DST;
                 CONT;
         ALU64_NEG:
                 DST = -DST;
                 CONT;

Could you help fix it?

> 
> Thanks for the Ack.
> 
> Dave
> 

