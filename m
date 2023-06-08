Return-Path: <bpf+bounces-2158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBF728A3F
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E1B281784
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3B34CF9;
	Thu,  8 Jun 2023 21:26:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1B1DCDC
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 21:26:20 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888262D55
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 14:26:19 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GmHC4014761;
	Thu, 8 Jun 2023 14:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=vxWNyJQQVYrU8Owz3c72ztlsx0dJWBCdS5+dbXNuOSI=;
 b=OqjBXZo7gawrrpChGcgrxgxfXGXtWfSegWj+d/wkNAxabRqffhbhEHZwX1/jrPUV4wWs
 ik3Q8nmrm5WDuSA+I+a1dZOboHkbGHc5VHxUwXB59lI7y+UGTgu/Z9ubzJy+Worddud8
 HnDIdkw9j/OBI+azmlRVjYn9vmeIOtPrV4oIU4lHveUobv4euLz+jWPvIEHSpeugRAGV
 m+0SOnGjfsI8Ac8tgHg2Q91muGq11rRc48GTOne6V53LQC6ZB/lbO1egIXoU7fDEZdq1
 9zjU3jdB+H/oRcEOf4CJwcn06GROrufz7Kci2NAMlprsUPknkxg7SurxSeXwkVFJWrZA 5w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2nbax734-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jun 2023 14:26:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxJJv0b9GKM5t7vUPvelNZ+ADi+bCqgxwrli7aETjsiJuO0EKAjm7pVg0GJ3VBKsuR7/in+/M4uMqPld+AU5lQNs3ueFdK+8r3QcowmBcvBaFLt9Kmg7SMr+SESqUen45TSHUGZCpV4ECcQ6PaGy6ff3CZBEHGK2eNmqjZqGeog04jWMQMZmUpJ3DgIA5VnJ+49UKGc/kmAIWzOWc3HYLrJL5La2IUQy4V9QfGkTZIhhtnd9a08TGed+xSwqyQvvYisErgUOzbHgVak6euT/PC29bOJIZGUtcW6kfw8u8HOQmBSPr41bcR6M1/nejDvzAprLnNTi7MQuBe4B3xlFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxWNyJQQVYrU8Owz3c72ztlsx0dJWBCdS5+dbXNuOSI=;
 b=C+QwszCD5lFepTMj7Z5i1Zr99b/vVgQ8Fl+WDY7NkimxFD13ubz1bm8kwwL0teIr7Kps2AyyurOBeioEWWAsOPdaT1D+6wlnQYyxSo9nz+AWH/old0dUAWd7UHfy0QRh/32q72JAVa//WfTRXRpE2LA9OvxIyCmrDwxJL2DmNBTlpAr//lbRb5RgqzrO7mDbUPPmBnUHFpNE2qYiUFQoineCV3mQGgNnj+ljqGT4UsjTZy9TgVbBzp0aa1Zwz8LhhHCipwsSUDwNcm+p92+3qO+XsFhPir3ICcaPhxu2BGCRTyYHUFgGTPZQA2rUsLSkI2vsSxheBvqIJDxRFJB2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4232.namprd15.prod.outlook.com (2603:10b6:510:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 21:26:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:26:15 +0000
Message-ID: <4146a048-2838-cd2a-59f1-05369add7e05@meta.com>
Date: Thu, 8 Jun 2023 14:26:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [BUG] optimizations for branch cause bpf verification to fail
Content-Language: en-US
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>, bpf@vger.kernel.org
References: <CAFmV8NeH2zLhSY1RMos18OMEnU81ieCMG0aNtN14BGh_Y7Nzwg@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAFmV8NeH2zLhSY1RMos18OMEnU81ieCMG0aNtN14BGh_Y7Nzwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 04236efa-21cd-4f2d-5e81-08db6866fd4c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z1diq+v9zVAzl4op5u5Tatt9SrhumusqpIOL+nYuJhTBFv8p21tCiTOUy7vUA4eLDB3ZJmk00SCIRK9yW+A+Jply+F4Ii0k+LsZBiaudvG84ORDpOuBhKD+BIv89h6QsjcQVL/h3t/lWbgx5SBNtgvWQgDVYm+ANU4RZVdonTLphSSesUh/6ouJeg1f7kFbiP1SE7Tsb0vaEVmHtlz7j3ntFwkjF6sbs5GSxDcXFyTg30tscwXaahdFDOUUqmWYAss4veL5MiVaxbyrWEkl74Uw1fL+EkS4TDBBv07+kWyM/Pq8qoGgG9Q5fpHsASfaCv6CPvcriR2H/5SnsFoOJQpFzZTLKtQWwYm4zakMu6itXHLmiV3m/5UWBryNnOTAR2Xe3ZAz2i/QtP6Vk1L+etYXOeH5X4KMRw9bpYB2dhdTRG2/dzjsLcNBM0m7a4ePgAiZC5pk5MIY5G2SnapIp3OPALHXsEkyTdpqUNe/eDJ3F3R7J6MMm77IkL1hZfn3+uOUtuaoskTRRUcGtLZXHx1YJXNlZxLtlXhbeMvWvERmWhbbOuf1FrjOblKQ7NpquQxYPRnv8JE/ONphM6byXR1qXpbOBluzoGKRnQ5HcuOMKxceeNCuEMzSFVEJkZzsDytHsXdTTf7/AnQr2/nthCKo1ueMmlKnHbL033GMb5tUL4QNpUChetbBxUVjdfTBW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(66556008)(66946007)(8936002)(8676002)(66476007)(316002)(41300700001)(2906002)(478600001)(31686004)(5660300002)(6486002)(31696002)(6512007)(6506007)(53546011)(2616005)(6666004)(186003)(83380400001)(36756003)(86362001)(38100700002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzFlV2FQa001ZzBHVEVpMzZRWDVnaVQvSHdvOFBoUFoxd0Z4N0lXdFNBQVJy?=
 =?utf-8?B?NHlKdjJodXFZa05sbDlWVG15SW1pRVVIZmoyemRxOEE4enZCdXBFeVdQWHk2?=
 =?utf-8?B?OVp6ZU0xL1VTVEVZSEZaQjJPMjhqeTlIVy95akpXallmSE1ndEVLRlQ0elpq?=
 =?utf-8?B?bmQ0blhPVXlQTDg1VVptZjFVK096YmE2dTlwZzR0RXpQUHVkejlXUytwMzd4?=
 =?utf-8?B?Tm5YcWZhWGZoV2NMaERSQXVBb2hXRFNVTGdaMWc0UWdTN1RocXhMNDZoam1w?=
 =?utf-8?B?RkIvUU9DUTUxUzRueGJuY01helI5L0lnUTNUR1UxVE5icityMXNrM3dLZzk0?=
 =?utf-8?B?T0lFQU14RmRHbTFqeG1hd1dRU1QyOGttZ2VMTm1vOTNQRjYyV0MzVHgyYTRH?=
 =?utf-8?B?Rzc3L003SXJUU2Jlb0VCTmZxd2x3YVJmb3JySHVrQWRyVGNQRjBqMnFYOHRp?=
 =?utf-8?B?d2FTejJ2SnVBMXp0OCsrUnVhbGNtVlFDd3BMdGpaQ1NhZXFCNkF4NkcvNHFL?=
 =?utf-8?B?RWF3VGp4ak4wZk93TG1jQjAvVFptSWFVTkF1VEVsMk9JSExSK1ozc0FJKzk1?=
 =?utf-8?B?bkgrRXExcm82TGQ1ZU42cmxVYWZvZHgwN2dGeFV5bFJmU2dRbzVnSWQzOEhY?=
 =?utf-8?B?MExDbnNndFVVaU4wSWVPdXlxYml0N0RaYS94a2VONVk4TUs5K1JsVEpLcUlr?=
 =?utf-8?B?VDRiNmxyYXYrT2RkSTE0eDVFNjlnT29KMCs0SUtNTGFacGVPM0xGdmJwV1pX?=
 =?utf-8?B?MVVQNmZ5NitBWWd1NkhtM0tkZldFWTNGaWMzUm9sWGs4bnd3YVUwbjZWMzBm?=
 =?utf-8?B?dy90K1l6SUZWWVMyUk9LZ3MrQ29hTkk4ZGFOWklEcHNxNStFaUNTTUNHSmpF?=
 =?utf-8?B?YjRvSWpsUXNUYmJXeE1VZW1NbVptNE52V2RNS2VUbXZZd2VhVmpqQTN4KzZD?=
 =?utf-8?B?enpRUXFLRG9nMFEzR2FUOWlibnRqQlFDMGhENzZRMS9nQjk4TWI3cFM0SGty?=
 =?utf-8?B?bHd6MjdmcFo5emVwbTgrc3p4Z1hEemlHeklnTWZlcXhXaDhIL1l6R2dOczhj?=
 =?utf-8?B?ZW1MYmRNUTVXMHhQTDFkWnFIekNpYWpRVUJlN2JGNEhPdGlmZjduek85UnZz?=
 =?utf-8?B?S2xRRDN3UzVJTGtXM0lRaUJMMm1lM0FGNEgzMHhuNlZncDdEVEhMT0xOZDU0?=
 =?utf-8?B?TmppM3UxbkVoc0g0OTR5cWpEK252NXp2MW1yckFub2VHRWN0TmF0S2lUY3h2?=
 =?utf-8?B?aDRJTVZtN21mT1JlbUt6eXBNK0VPZ3RXR0VDUGVTSVlOV1pVT1dPa0RwTTZJ?=
 =?utf-8?B?RFJST3pEd24rOTRvVEtLSlBhaEtnYlo2R1JXVjN3YW9VODk5dVRiN05uVDVn?=
 =?utf-8?B?UVFjOFpJSyszZnRGZEF4WHJtYWFhQ0ZJMjBGM2RvOFZIUmNLelpPRmNjQTNq?=
 =?utf-8?B?cHpCbXEzOE1qVE95bHNNd1NFY2hsaXRDbmRYVGJ6eEYvQjRoL2d4K1oyR04y?=
 =?utf-8?B?ZmtROXUrVW55R1FLa1lZNnhmcUR6ajlXR2N6Y1dnYTdHSmZTMVRIV21NSnZo?=
 =?utf-8?B?VkRRR0IxS0xhQmxJTHlGZDY5YzI5d2liOVk3SzFTajVyL1EwdjB5WXEySGJZ?=
 =?utf-8?B?Y3RTSDVkMWRRZTNJTGRzc0ZaYkxFLzlDOE16VTFhc1hyY3M3WTRlOGdvYisz?=
 =?utf-8?B?REdDU3pXWjhGbGNEaFYwa1BpOVJsdmt1UWNTN25OeHhJZHlGRjB6RFVvRFJ4?=
 =?utf-8?B?d0VWQnFTT1JiNnV6K3ZvRjRCMEh3UW5lakVjdi9tcjQ2RlA0QXpIcU4zRkdS?=
 =?utf-8?B?VVF3eEpTNHhIKzFLNndYSGZXTUdvS29hL3JjaW5rYnkwajBLM1dhKzJwR0FO?=
 =?utf-8?B?Z0g5NHBodU5PeUpnUHNVSFF4ZzQ2alNCS0N4WWdnSDZBY2FiM2NLQjdQVUNV?=
 =?utf-8?B?NUlMZmtPOTNjT2VCMFN1bFkrOUtGTTlXSUQ3SkQxUWdsZ3NBZUY3ZVZZWGdX?=
 =?utf-8?B?bXlEa0huUWJKeXliRm9Hc2huRmtMbGV3clkxZ2RNRXlvZlFaNjdHelFpaWgw?=
 =?utf-8?B?S01za0dFQ2dONjdzejFoNUI1R280KzNsYllyS2NlYks5Q0lKYUVpOGRqSkpH?=
 =?utf-8?B?dkp5ODVIMXhDdmM3TG9IaGVWeXg4c3RiUG5SR2FQaXJmRE5TNzRQTjV2Z0lO?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04236efa-21cd-4f2d-5e81-08db6866fd4c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:26:15.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7CaiSydIXhwtClc8VRbbtTgLtKYNqum2C/dd2dVXKkoFpIzGdN/PP5fpMnpOvbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4232
X-Proofpoint-GUID: SIcAgcPuUhtkb1rU8DATLpAdZmCqMkeq
X-Proofpoint-ORIG-GUID: SIcAgcPuUhtkb1rU8DATLpAdZmCqMkeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/8/23 12:52 PM, Zhongqiu Duan wrote:
> Hello,  everyone.
> 
> Recently, I've been doing some work using eBPF techniques. A situation was
> encountered in which a program was rejected by the verifier.
> 
> Iterate over different maps under different conditions. It should be a good idea
> to use map-of-maps when there are lots of maps. I use if cond for a quick test.
> 
> It looks like this:
> 
> int foo(struct xdp_md *ctx)
> {
>     void *data_end = (void *)(long)ctx->data_end;
>     void *data = (void *)(long)ctx->data;
>     struct callback_ctx cb_data;
> 
>     cb_data.output = 0;
> 
>     if (data_end - data > 1024) {
>         bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
>     } else {
>         bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
>     }
> 
>     if (cb_data.output)
>         return XDP_DROP;
> 
>     return XDP_PASS;
> }
> 
> Compile by clang-15 with optimization level O2:
> 
> 0000000000000000 <foo>:
> ;     void *data = (void *)(long)ctx->data;
> 0:       61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
> ;     void *data_end = (void *)(long)ctx->data_end;
> 1:       61 13 04 00 00 00 00 00 r3 = *(u32 *)(r1 + 4)
> ;     if (data_end - data > 1024) {
> 2:       1f 23 00 00 00 00 00 00 r3 -= r2
> 3:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> 5:       65 03 02 00 00 04 00 00 if r3 s> 1024 goto +2 <LBB0_2>
> 6:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> 0000000000000040 <LBB0_2>:
> 8:       b7 02 00 00 00 00 00 00 r2 = 0
> ;     cb_data.output = 0;
> 9:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r2
> 10:       bf a3 00 00 00 00 00 00 r3 = r10
> 11:       07 03 00 00 f8 ff ff ff r3 += -8
> 12:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
> 14:       b7 04 00 00 00 00 00 00 r4 = 0
> 15:       85 00 00 00 a4 00 00 00 call 164
> 16:       b7 00 00 00 02 00 00 00 r0 = 2
> ;     if (cb_data.output)
> 17:       61 a1 f8 ff 00 00 00 00 r1 = *(u32 *)(r10 - 8)
> ; }
> 18:       15 01 01 00 00 00 00 00 if r1 == 0 goto +1 <LBB0_4>
> 19:       b7 00 00 00 01 00 00 00 r0 = 1
> 00000000000000a0 <LBB0_4>:
> ; }
> 20:       95 00 00 00 00 00 00 00 exit
> 
> When loading the prog, the verifier complained "tail_call abusing map_ptr".
> The Compiler's optimizations look fine, so I took a quick look at the code of
> the verifier.
> 
> The function record_func_map called by check_helper_call will ref the current
> map in bpf_insn_aux_data of current insn. After the current branch ends,
> pop stack and enter another branch, but the relevant state is not cleared.
> This time, record_func_map set BPF_MAP_PTR_POISON as the map state.
> At the start of set_map_elem_callback_state, poisoned state causing EINVAL.

It will be helpful if you can provide a reproducible test case
so people can help you to double check whether it is a verifier 
bug/limitation or not. It is hard to decide where is the problem
in verifier based on the above description.

> 
> I'm not very familiar with BPF. If it is designed like this, it is
> customary to add
> options on the compiler side to avoid it, then please let me know.
> 
> Thanks,
> Zhongqiu
> 

