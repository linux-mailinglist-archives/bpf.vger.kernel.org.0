Return-Path: <bpf+bounces-4174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD47494C2
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9231428120B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1AED7;
	Thu,  6 Jul 2023 04:50:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B8A47
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:50:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE91BCC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:50:45 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3661mnaw024808;
	Wed, 5 Jul 2023 21:50:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=D2QATmMi2Cg63uabJSNF7cBq58DNupTA8AVTTnNSReM=;
 b=Xk9vjM7KkAHDl6bDVIGQi50DLOcqI7ZCGeSvqci0r/+6zCj1NHDDL+5+sempBsOwCHRb
 oKUSaMFpGLR7f7UrNpgeiIvRN/sqGirE2VbSxsnFkFD1KhpPCU0hlOsVLdx9+9ImgCtH
 V434yzRC1SEfu1LhB4gQALFmNRjojuDx7h6JIWqb+GHwjGiiEtZNZltaY+usRSNhgLeW
 sF+AayHcDr4kTT09GgrXHUotshPK7FibsxA0xaupCsIxB0sPsHKrfijWgVATY/yYHofN
 4dHv8yLN9v+erFD/Ou3bALy0wbeWSPy9yzxSe35A2qkwhMFcU/uYuso1PilcTNkr+J7D BA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rnm93s3rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jul 2023 21:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRpvbXIEpf48BLGpNhjWb8Vw02F/hwkENitDrfqsYW70A+5vXVN7T+qq6hxfM05bchEw5rwr+x7GsVvfZNg2mHR4TSRolN1VOyiv5ez1uI5RCnZGAN9TwRI/A1T69xWFkfTKGcglU7SAHI3iFFY8KD4HrbGhvl6WIzKrCYy5Ay8j5MLYWfEcWDIpKY4da+ez4GF9Y+m9XMy9UzCjZkpTb7ROzJ5hsVd0iGnmT0fUX7aw/oT5ZaJl4+bDuQYrF/x3Pqkvb/ztFfeQEfqO5NQrx5FyHUIJdE3lLFWm4ZO8xeI9xGxEuk6kvadR7fRPYsCsbpH13wekg5RcGjbp/jCbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEl/AWjB6EfWpTatkwuhUho9umn+uBAcD0ZUpizIiQQ=;
 b=cgYriBFC04sTG0LSIuort9NeGpXqoooC5wgYGNGLkeo9kvahqWYT2f5rg+wTWULLF/Fr1DECEgvwbfvTgh1JHQx7v8B4y1ZSUp7ZSm9aN7JWGvyla1hVLgb0TOjaGfT38Zxj7gX7YGVnGwCRX23Pa6oeksrY8v67i6GpdPKUpYiE3h5aVetxumaaVdxyxxpIk4826dRwyh5Xu0BMJmlW9DhgqucLhk5r+obETf9GhN8YMbh80yooJg6t5x6kXhvZObqrliDEJwMGkkGEpYXsCkTvcoMjvaDft0+9evnGKlI0IYXc2bELvqfeTIor1xuyr2xZhz/S0TSclyis5EGrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4157.namprd15.prod.outlook.com (2603:10b6:806:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 04:50:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 04:50:38 +0000
Message-ID: <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
Date: Wed, 5 Jul 2023 21:50:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: bpf_core_type_id_kernel is not consistent with
 bpf_core_type_id_local
To: Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN7PR15MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 32875caa-bc35-4e6d-8460-08db7ddc8b31
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5c1K1vR2BL7MhvDuTCoqy2aikjbhdbr9RHGvDr479w/Zodqg5UWsXE3uqN1tS5Z1p2vZ4NFhFAlABW7rwdAyNhibDIRI9XKxOai+eIXNkNsfD4OSUmxr0TCTS1IT+JEob5bPm02w+eDLWSpJ8AgVqfb0d4nWXiiGfShK33Ir/tgHYXJPYEoWKCAiVjrdl7H/mggCY/1bWL9CiH4wEe01V/lZOToeHH6k7UlM7bCVO77Yxg1/N7rxh8iKlQcpHyW1o82gE2Ke8IypdSvNny+awje2hruv0G6/Pe6JpOqfTWwjTc9odGMn5tRiHZnpyHoP5kwMJmy9AivnZaHlLBhpeDm60HbdzJPnesVtKLEt4Y2DMowErxKclQhev75fkSwFEloX6eKXKHvzXCDm/d9KWNwg3Kwx8bwPvCRcJUCo9GsuP8/Q5kl0GpeQNxU2hbPL+KhetapZZB1TKBNaPQ6xHli6CmDOrUoCGUn213NpcILqobOPHVRV3CXd6b7wFvVw9nw14Ki1K6b5dcTfI+Q9K9fdb53jzHUR321E1zlTjLHiy5swE8dtUFfe8Y2SZErFcTe/PygOto2Zpptu7Mj9UUze2ih8dV3DpJ6qlQhn62IzZeJLeQ18rhXisU3EYk4q8KWVarg2FVPj4vN9FcEjoWB6gwcskgFaRW+mXAWKHQc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6506007)(66556008)(66476007)(66946007)(478600001)(41300700001)(38100700002)(66899021)(316002)(2616005)(83380400001)(186003)(53546011)(6512007)(966005)(110136005)(8936002)(2906002)(5660300002)(6486002)(31686004)(86362001)(31696002)(36756003)(6666004)(8676002)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjdQK2RlZ1FidFdmS1BvUS9GcFZmdjc2cjBVVGRJblphY21GaWYwWVRVY25W?=
 =?utf-8?B?TXFTZnVBenhwekw5SDNNWGdwcXZySElCZmRIeU9QVk81MjdEOVV3UENndkdn?=
 =?utf-8?B?MHJmZjdJUG5tTGRTbEc1OXkvY08rRjBqZmJtZEJqcDllVXpZV3FFVFMxWUVq?=
 =?utf-8?B?YzlPbHhCaE1RUU5NNGFST1JsR3p4S003ekxGMnlGVkN0Y2NWeitzQ2prcWUr?=
 =?utf-8?B?U0JFTGRRQkptRDNWUkJRc3VmdjhSd082c0YvRCttbUc3dUREaDZiMTNtZ3Nj?=
 =?utf-8?B?OUp3RmdxM0tKeFVpNXU4UFZWTENLQlZicVo2Nm8rTVpQVTk4aGRtTTRSMlZD?=
 =?utf-8?B?dklUUi8yZGwzU0hIeEMvTWEwRmVFaTJPbFltc2YzRWZ0ckFMZlF5UlFSejVa?=
 =?utf-8?B?R3k0ZUEyWUZ4d3FWQk9lSTFFU3JFZTB6RnBBR1U5MUFkM1hjV0NNVVRWNzNW?=
 =?utf-8?B?YlVwb1lWczFka2w2dkU2SjhMcDhvTzFPNndoVGVaUEplWVhnUmJoek9SbDZL?=
 =?utf-8?B?b0hrSVRFTVg5NEVtNkFySzFxWlBFNUFVa2N1VWp5ajMzTTNjcGRlcm5aUU1q?=
 =?utf-8?B?eE5qZUpDZVROSUt2YzUyTnFtdmNIVlJlWWdlOFdrQlk4OFd4czIzWEx4bC9W?=
 =?utf-8?B?TGhib3NxazR4Y2hXbFpJYkU4YngxaWFMT0YvK1Z3MERLK3dNOXZOaTNLaEtB?=
 =?utf-8?B?dDFsbk12VVU4OFgrNlpCV1dKR0Y5RkxhK0ZoeVhicFAzTC94V1V1MDFNc0xR?=
 =?utf-8?B?SXB2cVpYNzVqNFVSenlCSGhQYmtzQjhkSkgwY0hzNVNMZjJFd0hTZlIrbHh0?=
 =?utf-8?B?ano4QitZOThoYkZwYUY0b2U4VUlPSjZxMVZFTnVmeDUxcXgxaHo3WFJ1anZp?=
 =?utf-8?B?TUVUbWdhaWYvZHEzUVUrMmgvM3Bsb2xaVCtpVnJWRFl1eFFrUC9EVWtsVTRq?=
 =?utf-8?B?K1ZnODZDQzd6Z29IVG05d3o5NnFSRHFWRmtrdldkWjExQmhJenN6WWRyQjda?=
 =?utf-8?B?eXZWYkRCWDhLT1NUbFBLYmpmelFJQUduVEY2U0J5UGVGRGpFTzZxNXlqWTR5?=
 =?utf-8?B?a3FZN2FLOXpPT1lLOStSRTRoTVQvN3VySW1LUlA1NlN0cEh1UG9HcDdvVVlO?=
 =?utf-8?B?OSt4cmR1Znp3akw5SkJFUGY3ZWdKMG9BSFNyTUJyaXhNdjJHTDQ5S0FuMDhX?=
 =?utf-8?B?TDM5Z0dBY3MzMWtXVjRKMTZNaGFvUFZyRzhRcHVtQ1dka3FIcjFTeXk1dWhR?=
 =?utf-8?B?dk9oVlJwMGcwaG0ydUJ6Zkc3bFcvRTRIcEk1YTB0QUhCbktubXV3blJvd0kz?=
 =?utf-8?B?NzJZTEtVWXlTOXF2VW9rSzlBYnB0bVJSRVdGOGtFQ3VOWjIrZWY3NWdEbkhJ?=
 =?utf-8?B?MjlkZGttN0NwOE81VWswdTVwQThSZmFTZEdrV0Ryd3J1bUlHbkRTSFhZSElw?=
 =?utf-8?B?dEF2cjJPYmd6aGE2RlJkNVBTVGNlL1hrempHaUNUU1pDc1F0bkZvL2tqZWww?=
 =?utf-8?B?bXh3UWpEN3MxYkxKeWNrQlQveGxQbzQrZVRqSUx3Q3V6MGQydFR4U0xBUitz?=
 =?utf-8?B?a0g5ZEdwVWNDZU5pUzkvbWtNUzA0cU50NkQ5RXBuZ084bkxhQzlQVjJrZWtT?=
 =?utf-8?B?b0ZVckpwdmhnMDB6cXFKNXdZcmFqUUxYeEdFT1ZVWXNXZjE4TmF3OU1LWDVL?=
 =?utf-8?B?b1FFR09mc2RsTFF4SjNoQ0hTcHUyZDJ0UHI1NDRQTUduN1U2cGJYQ3ppRGFv?=
 =?utf-8?B?UkNFM1g4bTNKWC9kYUNRNVI5Tll6amViWnNuVHJuWEN4VE1ra2ZpclN3dlZU?=
 =?utf-8?B?S1kzbUdnTU1KbUxQcjJibHhYWWoxQVhGcjhhTnQxSzc2UlhmalZYYmRFSDhE?=
 =?utf-8?B?M3JXcjdBUlVUODZ4OTZmSk5YeG8ydFUwa1BoVnp2VkpGcDZNQ1BESVZYazl6?=
 =?utf-8?B?VDVNVE8wMFc4dkR1bXFuRjQrSzFGczFpdEcwWFdMcEoxT21oais0YjVjbWFz?=
 =?utf-8?B?SW1WdTNUYlZWbm1SMVFsT05kcTZFZGI2MDJrSFR2ZTRHOTJQa2hRNGYyNE1m?=
 =?utf-8?B?ZXVLenY5b3g5MkxHK0VBVUg1TVkzaW5BZm16RHBZWWRVZDRTenpaMVIyTEdS?=
 =?utf-8?B?eTY5NjdHU3A5R1NoZ3J2SktmOTB3YU0yeU9rZ2lSV1ZGdk51bTVJVTRaZE1x?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32875caa-bc35-4e6d-8460-08db7ddc8b31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:50:38.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4iaKYFbsZgjYVIzXTEXr0J19FgnVjbpv6D0LRMTbOEUeEBxTi391vrTMS32SQ54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4157
X-Proofpoint-ORIG-GUID: VdqeEgsD-o30dVCRPGWDGpwsUnii6_c0
X-Proofpoint-GUID: VdqeEgsD-o30dVCRPGWDGpwsUnii6_c0
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
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/4/23 6:30 AM, Lorenz Bauer wrote:
> Hi,
> 
> I think that CO-RE has inconsistent behaviour wrt. BPF_TYPE_ID_LOCAL
> and BPF_TYPE_ID_TARGET when dealing with qualifiers (modifiers?) Given
> the following C:
> 
> enum bpf_type_id_kind {
>      BPF_TYPE_ID_LOCAL = 0,        /* BTF type ID in local program */
>      BPF_TYPE_ID_TARGET = 1,        /* BTF type ID in target kernel */
> };
> 
> int foo(void) {
>      return __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_TARGET)
> != __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_LOCAL);
> }
> 
> That line with __builtin_btf_type_id is just the expansion of
> bpf_core_type_id_kernel, etc. clang generates the following BPF:
> 
> foo:
>   18 01 00 00 02 00 00 00 00 00 00 00 00 00 00 00    r1 = 0x2 ll
>   79 11 00 00 00 00 00 00    r1 = *(u64 *)(r1 + 0x0)
>   18 02 00 00 04 00 00 00 00 00 00 00 00 00 00 00    r2 = 0x4 ll
>   79 22 00 00 00 00 00 00    r2 = *(u64 *)(r2 + 0x0)
>   b7 03 00 00 00 00 00 00    r3 = 0x0
>   7b 3a f0 ff 00 00 00 00    *(u64 *)(r10 - 0x10) = r3
>   b7 03 00 00 01 00 00 00    r3 = 0x1
>   7b 3a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) = r3
>   5d 21 02 00 00 00 00 00    if r1 != r2 goto +0x2 <LBB0_2>
>   79 a1 f0 ff 00 00 00 00    r1 = *(u64 *)(r10 - 0x10)
>   7b 1a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) = r1
> LBB0_2:
>   79 a0 f8 ff 00 00 00 00    r0 = *(u64 *)(r10 - 0x8)
>   95 00 00 00 00 00 00 00    exit
> 
> Link to godbolt: https://godbolt.org/z/jr63hKz9E  (contains version info)
> 
> Note that the first two ldimm64 have distinct type IDs. I added some
> debug logging to cilium/ebpf and found that the compiler indeed also
> emits distinct CO-RE relocations:
> 
> foo {InsnOff:0 TypeID:2 AccessStrOff:69 Kind:local_type_id}
> foo {InsnOff:2 TypeID:4 AccessStrOff:69 Kind:target_type_id}
> 
> It seems that for BPF_TYPE_ID_TARGET the outer const is peeled, while
> this doesn't happen for the local variant.
> 
> CORERelocation(local_type_id, Const[0], local_id=4) local_type_id=4->4
> CORERelocation(target_type_id, Int:"int"[0], local_id=2) target_type_id=2->2
> 
> Similar behaviour exists for BPF_TYPE_EXISTS, probably others.
> 
> The behaviour goes away if I drop the pointer casting magic:
> 
> __builtin_btf_type_id((const int)0, BPF_TYPE_ID_TARGET) !=
> __builtin_btf_type_id((const int)0, BPF_TYPE_ID_LOCAL)
> 
> Intuitively I'd say that the root cause is that dereferencing the
> pointer drops the constness of the type. Why does TARGET behave
> differently than LOCAL though?

Thanks for reporting. The difference of type w.r.t. 'const' modifier
is a deliberate choice in llvm:

See 
https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPFPreserveDIType.cpp#L84-L103

     if (FlagValue == BPFCoreSharedInfo::BTF_TYPE_ID_LOCAL_RELOC) {
       Reloc = BPFCoreSharedInfo::BTF_TYPE_ID_LOCAL;
     } else {
       Reloc = BPFCoreSharedInfo::BTF_TYPE_ID_REMOTE;
       DIType *Ty = cast<DIType>(MD);
       while (auto *DTy = dyn_cast<DIDerivedType>(Ty)) {
         unsigned Tag = DTy->getTag();
         if (Tag != dwarf::DW_TAG_const_type &&
             Tag != dwarf::DW_TAG_volatile_type)
           break;
         Ty = DTy->getBaseType();
       }

       if (Ty->getName().empty()) {
         if (isa<DISubroutineType>(Ty))
           report_fatal_error(
               "SubroutineType not supported for BTF_TYPE_ID_REMOTE reloc");
         else
           report_fatal_error("Empty type name for BTF_TYPE_ID_REMOTE 
reloc");
       }
       MD = Ty;
     }

Basically, the BTF_TYPE_ID_REMOTE (the kernel term BPF_TYPE_ID_TARGET)
needs further checking to prevent some invalid cases.
Also for kernel type matching, it would be good to eliminate modifiers
otherwise, there could be many instances of 'const' which makes
kernel matching is more complicated.

But I see your point. Maybe we should preserve the original type
for BTF_TYPE_ID_TARGET as well. Will check what libbpf/kernel
will handle 'const int *' case and get back to this thread later.

> 
> Cheers
> Lorenz

