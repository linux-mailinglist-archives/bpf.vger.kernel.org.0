Return-Path: <bpf+bounces-2352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CFE72B4BE
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 01:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B431C209D1
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 23:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0979156D7;
	Sun, 11 Jun 2023 23:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD2EA8
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 23:11:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B95F3
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 16:11:08 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BEq6Y8026365;
	Sun, 11 Jun 2023 16:11:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7FIofQAdPNihwtXq1sCwGEhgVuWXIKpHalljunuRhds=;
 b=IFlIXdcStp3q1duSRJeyWClnjrFHGISMTc9lQQxjziWSHQKMS5kNuB6xOojZA+eNXT/R
 ekOO4ETNzUQKWfN/WGAq8DLodK5PFF9cK1X/LRS3k9JFyNRY7yXDGgLRGTzd9g2HIyqy
 tFo8P9PJdyiiTzY+h+m9frUWU8flmFcHQ4AXKM/64HDEVjuOfT3dsVweN0lJaS8fa8Ov
 krqnFbgVsaUbMZZmXbHEn4vGiyOgdZlZW8pQtBF6+NFwUbl7E3oBHdrPTRaak15ZyztD
 iuj1rmgHJJ+Vyw14I3UTw4OYFUblP53SoaI12tNSk2cke+gBkkyEjm3mF5TLBWBPy0tJ OQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r4n7m8ps0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jun 2023 16:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pirdkh/a8wUzMJU4wgE0QnqB5uGnjsVScbcRNjCDZipuz7PhRK5sGKF6tRpkaFXY5tUy7iAC5AGrCpd4khQjCudwZhyEMI/qp7qAVqFNCDX3VoDvyGedm4znl4W8uT+BG4A3GWugwtUM+8Ueqal0dwXwGhg2YDdJR6SM+IhrQcTePcoqOo/YSeSEAhrfvC95438/7eerp4n+obocLzgSlpTjeBPmEvDRyku/GL89Wzw83MHOJCusnk1zaMMAkh7KhAPjhKxnrs+eR/XtMSlz8mImG9Hq9e5Wcua6YMZ8XW3kHogHvROM40DsFl3500w6FDEcdnO4Sb/3iVDfEV+4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FIofQAdPNihwtXq1sCwGEhgVuWXIKpHalljunuRhds=;
 b=Rpj2w1j9LvC6HWobN0t4MlEOtHKKwpR+JmMDxPnBXwTMZeBC7KT/LbULPZgMo2nAYS4ojD9cGiFofu/zOMR1ObmSpg96gfQ+zbTcMgu32o4AtL9HaQF5nd6yqWCiIN7SVEw0Wtufbrka5SZ9s5cODSZQo1B0+Xm3gOl6yGw4REDnCIYrq0P3/4UJaqYYu6Z553im6AoUpLkqcdrE5Jnx/kFDh+xzUHp3iHZgPgWr1iQedKJeabq0PfI2nU1lZQIPMfny07OW8Ws7YNkvaD66c6AAyHX8FFBLKXlxIdbD2tqTyjhe2qd7rEo3gVBCW5HghYBsly3JUYAwDm5zuDH9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5283.namprd15.prod.outlook.com (2603:10b6:806:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sun, 11 Jun
 2023 23:11:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Sun, 11 Jun 2023
 23:11:04 +0000
Message-ID: <03bdf90f-f374-1e67-69d6-76dd9c8318a4@meta.com>
Date: Sun, 11 Jun 2023 16:10:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [BUG] optimizations for branch cause bpf verification to fail
Content-Language: en-US
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
References: <CAFmV8NeH2zLhSY1RMos18OMEnU81ieCMG0aNtN14BGh_Y7Nzwg@mail.gmail.com>
 <4146a048-2838-cd2a-59f1-05369add7e05@meta.com>
 <CAFmV8Ndwh3KZZHqSmTv0uk=bmLb8YVsfWxRz+1CXBPN3aAfNmA@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAFmV8Ndwh3KZZHqSmTv0uk=bmLb8YVsfWxRz+1CXBPN3aAfNmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: cde8fb85-1396-40d5-33f7-08db6ad12151
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cjbKdBdGAXEBmo9asburRqTd3XrKIXWw1mh8qI34yPIpIF5cIqgg5yEwCRdi7+mV4qa6Qary5zxVo8IP3ri0UA4JzN8XIvFsf/7lBxLEYShaSRID221W9rDkQVd+nTQ/noH+X2GaA9bHDGiasOIy6cYnkPGWHy5iKyqs68A0G5erjk/DgfJf2Qqjr8ACBV1XxSjAGkNXfeDyzoiqAKvzEfF1UQsX75Cx8l5kS7waZxhb94lH04AckPVSzdgLmb96dnvqUZdoEQqODOUZye6x2DHv4y76cH0JC/RXD8OaJwd3tXABfN7BMq5pV1JP8cnn7Dd4JxF8NWwPLPxGG+ptpaZ/Pr1LS+Mq5pk3zi4xdw5K61fU9xX74Qp/LJNYiwu8rnwMaTRWaZkWReNlSA/VPzeqZMexm3Gu+pohjm714ocHb5umXnPHHIAIYiAph4S+7cLF8qUIKuG7OGjgDEzzxLTn0N3sKiU2Lspz82Y5AwWUEq3AXUDa7gAaWCkrsg/hsd3GoP/aZ7rumnccwJ4Ps2SsROdhGT3qHRKeWwPofHLvKDhYz6yzXUAvN8T7n/e59n8eUBHzosbFXUkeM6loCzNd3rhMFxE1q3L4g0D9EiJWJzVIesxJbiIw3ikQw7mfVNZsLwMbsq1UtKQlOfUIqmFcSMCxRF+w75hm7mQZByYCuRSl30Tc7Fg/kCRLFIMz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(5660300002)(66946007)(66556008)(66476007)(4326008)(6916009)(31686004)(2906002)(316002)(41300700001)(6666004)(8676002)(8936002)(2616005)(186003)(53546011)(6512007)(6506007)(83380400001)(86362001)(31696002)(478600001)(6486002)(36756003)(38100700002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlVxNVZMNmtyZlY5ZDBmREsxR09OSHE1WFBYV21vaTh1bU5vb0NEeVMxYS9Y?=
 =?utf-8?B?S1RQbjRsanB5RjViVkRCVkM1SXBsK2tjVWNkMU4rMVRINWpuSEpya05zZitk?=
 =?utf-8?B?dXFRQnBDSnRyZlVGdlk4Ujg4TkhuNy9YQXBKZXlENytQV0g5cFhZK2diMXVN?=
 =?utf-8?B?b2loOEVyaFQ5UVVObU5DYVdJd2NKdlZaRTVyQnRhUC8xWkxicUhsWjkwWmxa?=
 =?utf-8?B?Nkh2VlFtOVdoVDFlQ0FLR084VUgwSlNrbkRtbm8vNGpBVHJSMkp2TVFMZkl4?=
 =?utf-8?B?MGZ2Ym1DbXAxQzNRdlZoRjdiUS81MXk0MzFsNkMvcmJQKzAzY3NzOXVYT2w0?=
 =?utf-8?B?N2JKekFpdmd6K2xqTDlNdU8vcFUwamM5MVVkOWY3UEc4SXpJRmdzTFAwOGV6?=
 =?utf-8?B?ZndIb2thQm5IL2JIN21uQi9JUEdRd3ErNGhreFFrczZOSUd2WThLalFpUzhs?=
 =?utf-8?B?OWtuRnFRMWRvQUVuWlB4bitvRkQxU0NVTHV0andVKzY2SWpReFR6ellXakxs?=
 =?utf-8?B?ay95bVZPTFBBVEVMVE10eVEyV2JUSndVV2NXZWJsTUUyNVg5SUVKeVlibjBl?=
 =?utf-8?B?bER3a0dzR2FxYjBWZlAwTnpXY0o2NXM5V04yV0hzdVlBUldQWG1PTnBMYVd4?=
 =?utf-8?B?QlJMZ3Z2RU9NUkRrNGhjUFFkYmhtenVxRU5xcWdTR0ZKUHBFUlN0dExMSlox?=
 =?utf-8?B?OFJpUXd5cUE1UDhNS3lqUnBvcTd2cTlnb2IvbjdHYUJtZnhYeEhub1pYWVZ0?=
 =?utf-8?B?S016T3h3N3Q3QmhSSy9FRUlzSEhmcHNKTmQvMlk4VnBsYWNrazluV0RWWnlI?=
 =?utf-8?B?Ri9sbkJRZEdaWnozbFh2dW5FcWhYTGczb3JnVk1FdnBHc2lRTlVDdk9hTm8y?=
 =?utf-8?B?M0lNcmppbGRnRXlNMDdiZ2Eyb2s1VWM3OGtaT201MGw3RFNwdDdnMGJyZE9u?=
 =?utf-8?B?eEorYU5reHpVOUlNVlREK2Q5WHliaDdUbWtyRCsxS093OU1qL05nS2dVU08y?=
 =?utf-8?B?MXBHWG9VSVJqb3UveUtoc0VoalJ2dVBSQWtVODlVc0JVRFVvOHEzNFZUbjA1?=
 =?utf-8?B?NjVUSTg0RllYM1pITnhJN0NRRm40SkRPNCtVTEU2Z3dGbVMycWtSOXVlZEF5?=
 =?utf-8?B?U0h2eCswa3FIdDBETG9xWUNhSzE2SjR3M1NYRkkwdkVhUjUyTTFEcU5pTlJy?=
 =?utf-8?B?enIyODNOYUpaVXp5WmJXK0Z1RXU4anVUdzZ4eGduVTNWaSthdTVpS3JUVUFo?=
 =?utf-8?B?amxTTGhpNDFTbnA4WlplOEJLeHlqbFZPcTNET3NGRHM4enYvUGVBSDVEREFq?=
 =?utf-8?B?NVFwU2kvNUt4M3oxOHF1S1B6UjM3Qk5DaFdSUkJKTUJaWmF3dFEwNVJBMHBn?=
 =?utf-8?B?VjI5MjJxV0Q1eVVRWHNtMzVoT1V1bGRnb3UrS1k0QjIwVFlaRVpXcENYTER4?=
 =?utf-8?B?dldlQm1QTDJHamNFUTdZYnBRSjRyalVibzdQK2FlOXBQSFQvOUhSN3ppQUZ1?=
 =?utf-8?B?bnF1UnFSMnpmSkpNQWxxV0NwZGRXbkhCWUhRV1VhQXgrSmlpU2FTeWdkbEho?=
 =?utf-8?B?b1Z3amw0RjdGQ2ViaW1QNHlyTEQ1LzRvcUR0NXNqbHVWaWNZRjZIVlhlaVdo?=
 =?utf-8?B?VlpsVGZzQ216T0oxMVNENnJ1QkxYaGx1eGVRN09zUVRxL2xYWVpjMWNFeVJQ?=
 =?utf-8?B?a1dFeW1xZ21JZEFmQlZmb0ZZeDhORjNqMEtmbnI0NU1oQTQyUUU0Q01xQ0dK?=
 =?utf-8?B?RUF4ZTQwUkJhRFFVdytFNUUydVJpaHdUVVhVYlIrbVVNN3lyYmpJUzM3K0VN?=
 =?utf-8?B?VTlCS1BUcUE0REJUdXlJSW4wYm5wV0NpQlB5MlViU0dsOFBJNUcxN0pLck5w?=
 =?utf-8?B?NTdQOEdtL3Y3Sk03Z0wyL083OTR3VWh0LzhNMzdNUGw3cXVqcnh2RFRPNGlU?=
 =?utf-8?B?SVRTOWNYMnRLN1BMQmhRbzRkOWlJZmFORS9HdldSbW5EOEZwT0ZaMzJKZlIx?=
 =?utf-8?B?Y21pY1lSZFBaM1NKaUlUSVZJWUJBWjExUDlOdGRFRmo3LzIwRm1hR0FrVkRY?=
 =?utf-8?B?WUFPSWQxbXFhOEhtUlVyM3RHczE0bHJkc1dMcTVIS0RCZjVSZ0lhRkVPZTBr?=
 =?utf-8?B?eUVnZnJQcFB5NVhIVjkyR3lwQy9SV0p5a21Cd3ZWWkl6Nmx2WGhWS1JyT0R6?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde8fb85-1396-40d5-33f7-08db6ad12151
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 23:11:04.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0TaVqfKd6F8U5QHr7HyztOoxAx0SjL8k9hyqQ+0aXY9K1acVvfMQLbDzkIPpCrW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5283
X-Proofpoint-GUID: zXjbmb-BuKl_cparxAkTuz_2leoOCQUV
X-Proofpoint-ORIG-GUID: zXjbmb-BuKl_cparxAkTuz_2leoOCQUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_18,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/8/23 10:02 PM, Zhongqiu Duan wrote:
> On Fri, Jun 9, 2023 at 5:26 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 6/8/23 12:52 PM, Zhongqiu Duan wrote:
>>> Hello,  everyone.
>>>
>>> Recently, I've been doing some work using eBPF techniques. A situation was
>>> encountered in which a program was rejected by the verifier.
>>>
>>> Iterate over different maps under different conditions. It should be a good idea
>>> to use map-of-maps when there are lots of maps. I use if cond for a quick test.
>>>
>>> It looks like this:
>>>
>>> int foo(struct xdp_md *ctx)
>>> {
>>>      void *data_end = (void *)(long)ctx->data_end;
>>>      void *data = (void *)(long)ctx->data;
>>>      struct callback_ctx cb_data;
>>>
>>>      cb_data.output = 0;
>>>
>>>      if (data_end - data > 1024) {
>>>          bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
>>>      } else {
>>>          bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
>>>      }
>>>
>>>      if (cb_data.output)
>>>          return XDP_DROP;
>>>
>>>      return XDP_PASS;
>>> }
>>>
>>> Compile by clang-15 with optimization level O2:
>>>
>>> 0000000000000000 <foo>:
>>> ;     void *data = (void *)(long)ctx->data;
>>> 0:       61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>>> ;     void *data_end = (void *)(long)ctx->data_end;
>>> 1:       61 13 04 00 00 00 00 00 r3 = *(u32 *)(r1 + 4)
>>> ;     if (data_end - data > 1024) {
>>> 2:       1f 23 00 00 00 00 00 00 r3 -= r2
>>> 3:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>> 5:       65 03 02 00 00 04 00 00 if r3 s> 1024 goto +2 <LBB0_2>
>>> 6:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>> 0000000000000040 <LBB0_2>:
>>> 8:       b7 02 00 00 00 00 00 00 r2 = 0
>>> ;     cb_data.output = 0;
>>> 9:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r2
>>> 10:       bf a3 00 00 00 00 00 00 r3 = r10
>>> 11:       07 03 00 00 f8 ff ff ff r3 += -8
>>> 12:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>>> 14:       b7 04 00 00 00 00 00 00 r4 = 0
>>> 15:       85 00 00 00 a4 00 00 00 call 164
>>> 16:       b7 00 00 00 02 00 00 00 r0 = 2
>>> ;     if (cb_data.output)
>>> 17:       61 a1 f8 ff 00 00 00 00 r1 = *(u32 *)(r10 - 8)
>>> ; }
>>> 18:       15 01 01 00 00 00 00 00 if r1 == 0 goto +1 <LBB0_4>
>>> 19:       b7 00 00 00 01 00 00 00 r0 = 1
>>> 00000000000000a0 <LBB0_4>:
>>> ; }
>>> 20:       95 00 00 00 00 00 00 00 exit
>>>
>>> When loading the prog, the verifier complained "tail_call abusing map_ptr".
>>> The Compiler's optimizations look fine, so I took a quick look at the code of
>>> the verifier.
>>>
>>> The function record_func_map called by check_helper_call will ref the current
>>> map in bpf_insn_aux_data of current insn. After the current branch ends,
>>> pop stack and enter another branch, but the relevant state is not cleared.
>>> This time, record_func_map set BPF_MAP_PTR_POISON as the map state.
>>> At the start of set_map_elem_callback_state, poisoned state causing EINVAL.

Okay, I see. For the following code,

       if (data_end - data > 1024) {
           bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
       } else {
           bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
       }

the compiler changed to
       if (data_end - data > 1024)
         tmp = &map1;
       else
         tmp = &map2;
       bpf_for_each_map_elem(tmp, cb, &cb_data, 0);

Since the 'map' input of bpf_for_each_map_elem() has two choices,
verifier complains. This is to simplify the verifier for common cases.

To fix the issue, you can add
	asm volatile("" ::: "memory");
after each bpf_for_each_map_elem() call.

Eduard is working on a llvm solution to address such issues.

>>
>> It will be helpful if you can provide a reproducible test case
>> so people can help you to double check whether it is a verifier
>> bug/limitation or not. It is hard to decide where is the problem
>> in verifier based on the above description.
>>
> 
> Hi, Yonghong.
> 
> The complete example is as follows:
> 
> foo.c
> ---
> /* SPDX-License-Identifier: GPL-2.0 */
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> 
> struct {
>     __uint(type, BPF_MAP_TYPE_ARRAY);
>     __type(key, __u32);
>     __type(value, __u32);
>     __uint(max_entries, 1024);
> } map1 SEC(".maps"), map2 SEC(".maps");
> 
> struct callback_ctx {
>     int output;
> };
> 
> static __u64 cb(struct bpf_map *map, __u32 *key, __u64 *val,
>                 struct callback_ctx *data)
> {
>     if (*key == 1) {
>         data->output = 1;
>         return 1; /* stop the iteration */
>     }
>     return 0;
> }
> 
> SEC("xdp")
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
> char _license[] SEC("license") = "GPL";
> ---
> 
> Environment: linux-6.3 clang-14.0.6 bpftool-7.2.0 libbpf-1.2
> 
> Steps to load:
> 
> clang -S -target bpf -Wno-visibility -Wall -Wno-unused-value -Wno-pointer-sign \
> -Wno-compare-distinct-pointer-types -Werror -O2 -emit-llvm -c -g -o foo.ll foo.c
> llc -march=bpf -filetype=obj -o foo.o foo.ll
> sudo bpftool prog load foo.o /sys/fs/bpf/foo
> 
> Regards,
> Zhongqiu
> 
>>>
>>> I'm not very familiar with BPF. If it is designed like this, it is
>>> customary to add
>>> options on the compiler side to avoid it, then please let me know.
>>>
>>> Thanks,
>>> Zhongqiu
>>>

