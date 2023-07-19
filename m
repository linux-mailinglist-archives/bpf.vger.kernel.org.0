Return-Path: <bpf+bounces-5256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FE758E33
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A12E2815F1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C1AD45;
	Wed, 19 Jul 2023 06:57:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A3D8B
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 06:57:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721961FD6
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:57:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J3GHY0003377;
	Tue, 18 Jul 2023 23:57:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BgQXJWWXHJhMaC8r/xmS+F63SKylrTKtni2L3+vIkms=;
 b=jQP/K2h7beU6t/U0TS+B8VAekPdVAuiUYjbDo0j+FZuz7RTpi6nS7R2SKXgZPRc4r3mJ
 6wAmCzPYlib1ODYE5+XlQ9PW1zcVyP/KHjnRfEGEr8PBlcd8xIcVJWT0KwRZ1+yUpkAV
 9SYJRTDU3qTTRFGPtfEHgeccHu4CdvRs20bOBmzbPNt5I25b8FXseFGUL0M0yfe1ilI7
 tJ0DVPgZVEjm41+r+9tLvp/AEv3bvvsVvYYKBuplFalSc5Iv6/NWE7PjhVJmIN8frd7n
 fJpPRX8lfjt1DNMR0QX9wQuPOjYqMh1VaDDcvQOQ2O37qDWuOBecf2KJTT6cKF8qNWWS NA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx7s3hfgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 23:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjEzPnWuBL5q7w7Hsao2A/22Ym1REC8Z/47mx1UblacJk8kMtm2NHLj8RGB/403a9BcQ++IwPUhqHE00wqS/iAYSnA5cR4g2eNMOHSSmNhraXq/C0hQWn+2HaOfswTa/flXyDIPQiEguMa6ZRGX3WzdMRpgyZMaHUQgKkQ94ZDoIxlOKD1DqXBWbpv76gvc6COIFu51PcOClRkkR9NngvxRSfhi2giT7Nydt/16mvtxqZ5YSUHeLXaa/4Ftnwb9FH/DtLcL2++OqnGjoESakgpQWyaoxiMBGrIReX5xqWpTGT1JQVqeaZ9lmzAWQRgKDkmMs6yCW/aPI7P0szNT1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3tfuE/9I9YxtC3hmbHc3yJLcJi2ofYBCwaqwedFYO4=;
 b=eUFagiYzBWh3D83C+bbXboKsMkELcHC/s6HfGCscz2Y8F/SThHej46jiccUcWVymKHE4skU9RaJ07DbPW7YVPBPHoT7wjK7OkRRT1Kq7LlZJV/WdJgQmgLyB01sFX1yOf9NSn1cJoPL2EFSKYaMFvHlaTfCAvQrgN7Iywo/46ckzxjGqMT1jl3/izg2/NXy47cKrxpursXTqigzNIUscBIyYTyhnB3FALF5BAIZ72an2sl1LlH7kuy6VakjLLg6rBGvRXIA7EYN5OjB0dR56h5t3NTemPJ4rIiYiHd3qkHV0iCbMim4j8zSNFnGm9j30dEcxM5JyrSZi0P7AhbB2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3780.namprd15.prod.outlook.com (2603:10b6:208:278::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 06:57:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:57:07 +0000
Message-ID: <061d1f94-f617-7061-c500-2ee01d526927@meta.com>
Date: Tue, 18 Jul 2023 23:57:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Support new signed div/mod
 instructions.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, Kernel Team <kernel-team@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060744.390929-1-yhs@fb.com>
 <b8a16850c0482bf64f30b41c7dcb8b33ea6a6f61.camel@gmail.com>
 <5cdd79d3-d4c7-b119-ebcb-b8b143c79a01@meta.com>
 <CAADnVQJr+PWxBJSima_wJY1iqWaA51DRo32ct07W9BzOh1HoHw@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQJr+PWxBJSima_wJY1iqWaA51DRo32ct07W9BzOh1HoHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aab7172-b02d-40a3-21a1-08db88255d94
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JGoKszQvQkfGTXKVg64mj4XbsEIUn6tnAyIukjcb2ExnxMADskz6p5yS/ufZaeMgKBBB0Uh25mw9MDRsumi9H0VD4AEiFb9tSvw8tdOOKUvOnztNZLdJr/6K4sJnet81nAY6wF6g4G8Yrub3n3cUFXjXLFYT0p5dVtgSD5CPPOCzWSeHAHAYwoVGQ+ZVopU0A8o765dyTASYAq2VF+RMcWe9Bstic52k1E0IDnZrdSAPYMWkGTRz6gEUR+1gSU9D0q2zQvr9q4zj8QtzUbrVnyh5ip/AdUPw4q3ev2H+IRxjZJVO+25Qj0YLsXeShhLqsTYJQK4boCxnhrEEglLmUHw+0oecSwJdYGVqpUFriGBwn2T1mGohvySDRIj3Sh8EOwURhaVy99IZ4fTlQtHwY86a4oIT1VBd1CQCi83Hd3Gyw5BVSOC0QY0X2L3W5l6rPANm+0s9cR0TaZhwBECwfrg/Q+YgSRLKvyBgz7Gxl5/nNo5loFcd9SS5DSB0t3wxi9odENQQM1DPL2xHkd927sBw3JJWzK1B6UMcWPJAPZTq0Gw3XJmlDLh1dPffXuWZ8rbWzrJVliMTxzfI6Ji1jAxS2nsIt9EsMJE/rj1Xvl6RdV0ewvhMpxM8MwyJdnhZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6666004)(6512007)(6486002)(966005)(54906003)(478600001)(2616005)(53546011)(6506007)(186003)(2906002)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(36756003)(86362001)(31696002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkowaFRPVDd5VXNmYzRIb2FBUlpvcng4WUxFZU02NFRIWlhmS0FRc2JxMDd0?=
 =?utf-8?B?OEhUZnpJTkdnUzJiYnpKb3AzalFvNkVtV3UxNnY5M2xFNTBnaXFqNTV0c1Yy?=
 =?utf-8?B?OStWaEVSeEc5aWtmK3l5QkgvYTNzNC9idjdrSGd0cmJQYTNqS1ZPalF1akRX?=
 =?utf-8?B?MVBxc1BMYnF3Qnh2T0hiZ2tiL3BjL25RTFdCM1A3NFByRWkrbVBDM1k4Snd3?=
 =?utf-8?B?Y0NiRXN3eGlTUFB2N1FQYUxWUjd6dzlFemFKRmcyVmhza1JqTmw2NUFxQ0hY?=
 =?utf-8?B?RnF3OEkva1M0enpldEE2OWVRZVgwL0QyK0VMUmpPeG9HVXRzbEQ1ekxBUk1j?=
 =?utf-8?B?ME5pRVdsZzUvWHFBVE9rZVZreUJGck9FVGdFR0FTZ0xLVFN3SExLdVJBZDVR?=
 =?utf-8?B?enhjdjNqdkxWc3FyWnBrWkVtWVVNQ3p3dnk5NjEvRFY0T0FnSmFnWG45YjlL?=
 =?utf-8?B?eVAxMXk5MDRuVXh3SFNOLy9nWGZjWXgyNmFYN1Aya05CWEFVaVQvb0FBZFdk?=
 =?utf-8?B?aENEYUJOYWJwU3ljYVMyc24wdEtRL3NVYlN6VU16WkZ6ME00SjdZTVFUZG42?=
 =?utf-8?B?aVZyTVRYUDdxbXI5cjlBN20xSlFoeDdHWWxtczIrdzNpWGxFSWJmVlJoZi9x?=
 =?utf-8?B?Rkc3VE50ZTRUTlB5NHNjUlFIM1VNcm9KYXpYVHppV01RczRzaHM1MnVTak1s?=
 =?utf-8?B?cTBuTDFMRDNvNEVhNlJYY3BuellnVjQ4N1R0ZFhWT1lOclpHSi9QaC96ZXFH?=
 =?utf-8?B?ZXJjK3BLOWxxKzBWVEFyNFgwN2RDQ0FJeENGeWg4cTNTY0g2MzMwMWpINGNz?=
 =?utf-8?B?NGZ0aXpNY2t4cVVsODJTRlZlbkpLb2x2QUw3K1NmTjRFaUdLUEsxQi9EcktJ?=
 =?utf-8?B?dS9BR2V2amZDRTZ2MmZiR2N5VjRRS2xLS3RFdGQyUEdncE11RnkrTnR0c1NO?=
 =?utf-8?B?bEZ1NGtTNzgzbVlWak1tWHN2dDJ5ZkMyUFZFRDdDcE5kT3RoUVBvNkpJL1ZS?=
 =?utf-8?B?dytNMk92VVFkblkrSXltTGtxV0hEcGtxYk5vY3hpV1lxc3Z5eXBwZ3c3ampx?=
 =?utf-8?B?WHlDSTBIRkkrWVJFVklkR0VRRTlpWkt6ZE9LcUlGUjcvWjhINUVoc0lEVldm?=
 =?utf-8?B?dW85ZWExV2VyQm1mcEdZalczWGFqQ3dLZ3cwY3hHc1ZVWVF2bVEvTnVzeXNh?=
 =?utf-8?B?L1F2bXZzU1V1Sk9HL1Q0SWlRL3BPbTJqcVV1a0htMnp0QW54TGcxRE81VXJl?=
 =?utf-8?B?cFZTMlJrcFgvT21oUHZPMjFrRDlsVGVoQ0JTY3JFanMzbGdpRUZjL1FhN2lO?=
 =?utf-8?B?OGVnU3RZYjU1RTdlYmhTNnRwOXZHbFNud0phZG1JZHkrL3BmQkVqbEoyck4v?=
 =?utf-8?B?bjhqUGZURWhPOE51OHprWFJmN2JBSVZyMHI4ZlNiV1IzODZTdWJ4bU1yeGZP?=
 =?utf-8?B?bDJVZ1JMOUNIUHZhNTRIcUd2YW4zKzdCZktUYlZZZmpTdjA2UVUvNWhVZjJS?=
 =?utf-8?B?N1BNRGVzVm9TalhJS0JsK3o2Y3FwUlhEdHN5N3lMb0NYK3JGZEZUcVdML3dS?=
 =?utf-8?B?bTdCSjRBSTFSK2UvMGV2eDZaeXdkdk53UzJLVThPcGxIMWNCNGFWUEJUa0dx?=
 =?utf-8?B?VlFVbGxJSkdTRk5hcFQwc3FlQmE0V1puL2pIejAreURMYVlPb2tEYitFaW5v?=
 =?utf-8?B?Vis0SWJiM0VtTnhDQkFiNmoyc0hZNW1jbWlXMW5zSFlVMU15dUQ4MEJrcUJM?=
 =?utf-8?B?dktzekZXT2ExbmRYU2hEUXhHWW5obkNWUnc1V2ZxZ2FZanl6MUljcHk0Szd4?=
 =?utf-8?B?cG16TUxtZE8yc0lUZTF2Q2dhNklDVmhwdzAvUnNLRWQwQjBMelRDdzVySUto?=
 =?utf-8?B?bWFrdXk1MGJqMXRCK2E4eG9HanBuSTVKQm5ZdlI5ai9pYUdUSlIrQ0VzVGN0?=
 =?utf-8?B?Sm5UUzBLNWx3S0gvVnZiNy9ERWozV0ttY09BVlBOWGVFNThoRTIxNi8yakJE?=
 =?utf-8?B?cXE2WjNZQzFueEZRMkRhN21VbW1oeFVsK3FjOUNmV201V1B3QVkzbVF2b282?=
 =?utf-8?B?NHhUYzVsMzZIL0tGVE03YjZpdnRibFVyKzV4YUpad3p6cXBzU2xsYjQ4THJM?=
 =?utf-8?B?Z3cveUgvT2FpaUFpemthYndBd0h3THZhR2c2c1A5TjNhZlhjQlovZWNtV2k4?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aab7172-b02d-40a3-21a1-08db88255d94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:57:07.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re9qvqY1ptpYtQnzJNSwMEylkAjWKuEYkgDn7oJoUWexfbhaMnkSv9lV6CWLNxZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3780
X-Proofpoint-GUID: wlcwdAMbUqFfrR01Lohll0V8-_BkA1CX
X-Proofpoint-ORIG-GUID: wlcwdAMbUqFfrR01Lohll0V8-_BkA1CX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/23 7:44 PM, Alexei Starovoitov wrote:
> On Tue, Jul 18, 2023 at 7:31 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 7/18/23 4:00 PM, Eduard Zingerman wrote:
>>> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>>>> Add interpreter/jit support for new signed div/mod insns.
>>>> The new signed div/mod instructions are encoded with
>>>> unsigned div/mod instructions plus insn->off == 1.
>>>> Also add basic verifier support to ensure new insns get
>>>> accepted.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    arch/x86/net/bpf_jit_comp.c | 27 +++++++----
>>>>    kernel/bpf/core.c           | 96 ++++++++++++++++++++++++++++++-------
>>>>    kernel/bpf/verifier.c       |  6 ++-
>>>>    3 files changed, 103 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index adda5e7626b4..3176b60d25c7 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>>                               /* mov rax, dst_reg */
>>>>                               emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
>>>>
>>>> -                    /*
>>>> -                     * xor edx, edx
>>>> -                     * equivalent to 'xor rdx, rdx', but one byte less
>>>> -                     */
>>>> -                    EMIT2(0x31, 0xd2);
>>>> +                    if (insn->off == 0) {
>>>> +                            /*
>>>> +                             * xor edx, edx
>>>> +                             * equivalent to 'xor rdx, rdx', but one byte less
>>>> +                             */
>>>> +                            EMIT2(0x31, 0xd2);
>>>>
>>>> -                    /* div src_reg */
>>>> -                    maybe_emit_1mod(&prog, src_reg, is64);
>>>> -                    EMIT2(0xF7, add_1reg(0xF0, src_reg));
>>>> +                            /* div src_reg */
>>>> +                            maybe_emit_1mod(&prog, src_reg, is64);
>>>> +                            EMIT2(0xF7, add_1reg(0xF0, src_reg));
>>>> +                    } else {
>>>> +                            if (BPF_CLASS(insn->code) == BPF_ALU)
>>>> +                                    EMIT1(0x99); /* cltd */
>>>> +                            else
>>>> +                                    EMIT2(0x48, 0x99); /* cqto */
>>>
>>> Nitpick: I can't find names cltd/cqto in the Intel instruction manual,
>>>            instead it uses names cdq/cqo for these instructions.
>>>            (See Vol. 2A pages 3-315 and 3-497)
>>
>> I got these asm names from
>>     https://defuse.ca/online-x86-assembler.htm
>> I will check the Intel insn manual and make the change
>> accordingly.
> 
> Heh. I've been using the same.
> Most of the comments in the x86 JIT code are from there :)
> 
> and it actually returns 99 -> cdq, 4899 -> cqo
> 
> cltd/cqto must be aliases ?

Yes, cltd/cqto are aliases.

 From llvm-project repo:

[~/work/llvm-project/llvm/lib/Target/X86 (ni23)]$ egrep -r cltd
egrep: warning: egrep is obsolescent; using grep -E
README.txt:        cltd
X86InstrAsmAlias.td:def : MnemonicAlias<"cdq",  "cltd", "att">;
X86InstrExtension.td:              "{cltd|cdq}", []>, OpSize32, 
Sched<[WriteALU]>;

[~/work/llvm-project/llvm/lib/Target/X86 (ni23)]$ egrep -r cqto
egrep: warning: egrep is obsolescent; using grep -E
X86InstrAsmAlias.td:def : MnemonicAlias<"cqo",  "cqto", "att">;
X86InstrExtension.td:                "{cqto|cqo}", []>, 
Sched<[WriteALU]>, Requires<[In64BitMode]>;

I will change to use cdq and cgo.

