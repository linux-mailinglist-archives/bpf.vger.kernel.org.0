Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82B399155
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 19:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFBRVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 13:21:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46998 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhFBRVM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 13:21:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152H9cvH009098;
        Wed, 2 Jun 2021 10:19:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yNwCLLv4OMCHaEb1MzdhjtM2CrKmDFW5TXQTQ8gmSjU=;
 b=AZ5utjtXIrasdF75BUpBU7WcCsX/XevYVXJOKnrfCYNw2v94y+aIKQigmsRPfsZcj9So
 lis2fBuKfkuohuv1TBcL+FfEGDNZahZRkdSorB9Msj1dQJkreGiKJYZz7iGUlqB1xI9S
 qFTe7LUDvFYb9WZrO5ph9otYz0rK/URAxG0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xcnm0qmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Jun 2021 10:19:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUUS2T7fsacJXPTAwWVscjRwm+/ipUd5FXaaBG6ZzeZzEXMPfL/Wq/WwajaX/bNZ6zDu8pOIHUsWPQKTCKoh9LCwQKyFS5NZO1WBczlXJuJGUOk1Rfa1ui193d4qlcDj8B1TZA/R7v5OMrRaC+Qgiy8yqQOCjf6GOFOuJ8Iq19J/Jigbgn1PsZXYCSARrLnfOfBV5d+7wZLGko9UAOr+wpp6NnGGeBihJxtKQpNQJVL0bL1Y9bDFS1D3BgNUcKVagMyNuxWV7f5bTBtiz5zYHy1edmIsoKQyO4dqxJKgTdUtiPKkmnJxyrf/+O0+DGxRFgJ7bwBmhSc8ZdElPMrO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNwCLLv4OMCHaEb1MzdhjtM2CrKmDFW5TXQTQ8gmSjU=;
 b=NUSb9pWZUiFC3kZvsB2ho60xh6YBY65OSLHwy/OFnCm9oC65YVvleTBN7Wa9bWp4Bx9Woe7UvuiC9n0jdbPI/nTBt1icl6rOAbfBKwWuM2lqmpk58bIRaowrkYMit9iYpWO3+Immp6ICi4ANy2PJjzBWmNmYhsrwoFaPr+gJ0c8BdDCHzUMAAKt0U6imLMcMKGoHrj3+E62XMpFueQftXxN5/yS2BJn/Fvw3iTfJN7IEfaJLoPyrxJtycS14frsw/UOVHluBHUxa5m4CJls78gQYzuqmLMNeVgQ8G+fviycd8yJJjuKtNNK7y6r1iv6Kk9cS52lTvyPKZVxi8oCGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2029.namprd15.prod.outlook.com (2603:10b6:805:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Wed, 2 Jun
 2021 17:19:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 17:19:24 +0000
Subject: Re: LLVM bug when storing unpacked struct?
To:     Julian P Samaroo <jpsamaroo@jpsamaroo.me>, <bpf@vger.kernel.org>
References: <CBTAHNOALDNZ.3N7KFDP60ZTUH@ares>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <75772f13-b366-d1f7-07a1-c43666e512d1@fb.com>
Date:   Wed, 2 Jun 2021 10:19:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <CBTAHNOALDNZ.3N7KFDP60ZTUH@ares>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:80b]
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1354] (2620:10d:c090:400::5:80b) by SJ0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:a03:2c2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Wed, 2 Jun 2021 17:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb12432-d523-4a0c-34b3-08d925ea915e
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2029:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20295D9620923759D0ED487DD33D9@SN6PR1501MB2029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tk8/CUY47jpBS+68ezYh4Q8ANJhJ0WIDGp+KhDC5/G6dhH1qyksIvtyt/M3AF4N/cg3OaNJAgYermo5/mhgn2yW6Vl7nVYj1p1FDAbqT+S3CDLvZIMlwExhIhZ92368igKD/qQceNVE91BKty/N3qXcNho8MGAvhVk3PnMghTzfb/DNTXOblbNR4RXi6iL8Okt1e01aNtJmSewIZ5uh1R/6utopvxiwIICeILzn5QHd2k4HGp1W3qfI+ouAIzjd6oWpHXT1BrrQCvXyztYqPwRW4evytUk6Wna1dU35Ia3eD3nbIN8MID9woVPTyZrrC25HqxaorE7YqP1ij/Ugd+zT6JbHQQ51wondzyoBnZny+S40wRRYfP8SvRtlEFfQr8lHeEEQpwSC5GHXeBU+NEhQNLSQMyA2nGyBdrmL4yYsK8QVA6olQC8GCCXMF39skxNixN9H96oLApwPoHLZa73jHfi8PLvZ7vjHhumZnWzgcRZHaQPou4VKRs1RakksNY2Zi3sVEZo+RzyIMcekrnwqxvXCIKYTZ4OkH4pFB6YIrCVJ6ADydPqS63ojN6oGPGBDICHWSogmZKCa8lF1S0OpqKOuuFvuDvnNPlk8zJkb4dnypaZWNtbVGuRVpJ+6whq/rECAqXn1EnlyR6m+/zlYxuNrsht/3t2ID4t4zLtfV+x3SnFpv9eN7c/YTDG3U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(86362001)(53546011)(31696002)(6486002)(2906002)(52116002)(478600001)(38100700002)(66476007)(66946007)(36756003)(31686004)(66556008)(2616005)(186003)(8936002)(16526019)(8676002)(83380400001)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c3lKLzl6MVZaZnQrTFNKbitSVUw2ZisxNDdtV0dZN21jdXI5Y1lEYklITExa?=
 =?utf-8?B?SFk3dTA5bHpBRElsc0JpeHk3K1NWL0FCQmNLRnRhaXI3MnFINHhWVllLUTg5?=
 =?utf-8?B?dE5wSmRPWEVZUnZVM0RZMlg1UWNrRlJjMXZpdjEvYkxNTndpOFJLTzVybXFh?=
 =?utf-8?B?QVdxYlZRLzNuTnozQzQrZ1ZiQlB6cXB4WHloZ05rcXBUSVBDZVlDRWhwODZP?=
 =?utf-8?B?bGlySm9sSGw2WHIzUktpR1JINVBKdVprS0M3SXIxS09jT2xvb3NOeS9WdmRr?=
 =?utf-8?B?Q3JqSnczeE8wdzJkbkgrV2ZOT2RlOFJDTCtoMGgzZ2lDRllSYWQ4MThzK1Zv?=
 =?utf-8?B?LzhmSVhUeDZBUUxkUFlKWFpxN3B4SGwzc25zUUJ1RjJmNGVCZ3JERGN4c09M?=
 =?utf-8?B?SWJHbDY0NlM0TFhWQjlYSkswekJ4UGxxay9jRFl6ZGdYZmQvdTZhSXk1ZjlD?=
 =?utf-8?B?OW55WmFFeW9RdUtFWGdPY3FyYkF2eG9tRTZ1ZW56QlpLQzBlUndxZDNVMnVP?=
 =?utf-8?B?TGtRS3FwZ2JVUS9MUWRBMEJRWk5BRHY4L2JpTktueURONHRSUUJaRnoyTytF?=
 =?utf-8?B?TXd5OWNnNkpZbjRvMTh2RFNPTmJhMkVoYUVuRktzckR3eExVeFdueUlYYktX?=
 =?utf-8?B?QzJ6UVJ2cDZtSDcxbW94ejhPUnFQakViUGZjeHg2d0JzS3J1cWxWTXd3TUl5?=
 =?utf-8?B?REszMDBkTEFWdmduQm1FMUlrZURvTFJHODNoSGlNOUJ4eE5KOCtSUkg5YjRP?=
 =?utf-8?B?MHdxcUVKOTNuNnhFR1F4SStpWFg3cHNXRGl5QjZQekkvdDNqUE5GSkZoTlMz?=
 =?utf-8?B?YUZGdm5KNnFWeUFZWEdUNXdXRWMvNjhYck5CYmplRzdXZHJFb25VWjVSZUtO?=
 =?utf-8?B?TVNKVHd5MVM1K1FoajN4ZUpXbW54bmFtY1lFVG1lazVZbkY3RVZjczAyS0Rr?=
 =?utf-8?B?MFA1TG5wVm14dU5rb0NxMGtIODJTZlRTbTZMMnJqQmxBeXp6ZzJ1djFrOEMy?=
 =?utf-8?B?cFdkNzNUb1Myc2g1a1IzcnNQVStxOWxaWUxvY05OZkEyQU1kdmxabHVWb1cy?=
 =?utf-8?B?ckhqOW9DbFpWN0Z4TDl4OEtGRjRuczlnVW8ybWVuZUszZzVLSXhrd05BQkdx?=
 =?utf-8?B?WWpoMFpGemxMTFY4ZGhqdlFCM2xpVXQ5U2FKV1lwcFBjTGhnaEVXMGJOWTE1?=
 =?utf-8?B?MUlRam5Sem9GS1A0RFFrc0RudUJvbWdwNkVUWFJpTnp5RVlRVUV3ckFJTnZO?=
 =?utf-8?B?ejVzL0IxS2Fka1RzeXozSndCMXROdnhoTnlDZjAzSjlXVnNLeXNRQm1iOG1Q?=
 =?utf-8?B?eXd4YWd3dWZCMXEvYVdscjN6aDlUMEJHdk5PNi8rVlZ6NFYvT09ITG9tb0s5?=
 =?utf-8?B?TWorUjErSEorUHRQaDJ5dEJNQVVtNWFWaU1ibHhBUmpuVm8rZ1ZTekJBdWtT?=
 =?utf-8?B?K1d5c0dZaERwV25La05QOVdHNHZWTXNpeXB5di9ReFlwNm9Db0hFSnMvclg1?=
 =?utf-8?B?ZGZRNFU1bnFzVXM0am51eW1KTUpWTmdZRjJ2bmVYNC9JNTVwRFlKQlFyV1hU?=
 =?utf-8?B?V2hjaDZIdHNCbFA0R1M1ZktlOWdwRFpHcWlWY1plMEhIT2dDV1FiT2FDTHpi?=
 =?utf-8?B?eE9na3h1OFdadWRjQUxHQ3JUaUxucWJULzIvTy83TTJNQStoUFdqZWNaQ2tj?=
 =?utf-8?B?eUIrVjUyb0tMT0JyenRteEhZRkVPdGoxTTZiYm9yZExtT2tEMkl0cDIyRmZs?=
 =?utf-8?B?Zm0zM2JheVlkOFpFUTVvQm93NjFYN2Q0aW1WeXdDTlQyb2h3REk1OEJtb0NP?=
 =?utf-8?B?RXhkVS85OURhUzFxaEtOQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edb12432-d523-4a0c-34b3-08d925ea915e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:19:24.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l3dts7Xv+yCB8uu1GW/nP82Px9Nij12kbeAEsy+SSKQm4/pAf+3WZ1IVfB+kgAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2029
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: AlVLGyGCbK5og7umQLblGOThyj7vL691
X-Proofpoint-GUID: AlVLGyGCbK5og7umQLblGOThyj7vL691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_09:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106020109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/2/21 9:57 AM, Julian P Samaroo wrote:
> This is my first LKML email, so let me know if I'm doing something wrong! :)
> 
> I believe I've found a bug in LLVM's generation of BPF bytecode, and would like
> to get advice on whether this is truly a bug before considering writing a
> patch.
> 
> When storing an unpacked struct such as { i64, i32 } to the stack (as part of
> writing a struct-typed map key), LLVM 11.0.1 generates BPF bytecode like the
> following:
> 
> ...
> 2: (b7) r1 = 2
> 3: (63) *(u32 *)(r10 -24) = r1
> 4: (b7) r1 = 4
> 5: (7b) *(u64 *)(r10 -32) = r1
> ...
> 8: (bf) r3 = r10
> 9: (07) r3 += -32
> ...
> 13: (85) call bpf_map_update_elem#2
> invalid indirect read from stack off -32+12 size 16
> 
> The verifier understandably complains about this when verifying a call that
> uses these stack slots, such as bpf_map_update_elem, because the associated map
> definition has a key size of 16 bytes, not 12 bytes as this bytecode would
> suggest. In my particular case that generated this code, my frontend doesn't
> have the notion of packed structs, so I can't workaround this by making the
> struct packed.
> 
> My belief is that for unpacked structs, LLVM should emit these stores as 64-bit
> stores, which should be OK since the padding bytes are going to be zero (from
> my limited understanding of LLVM structs). Does this seem like a reasonable

Your assumption about padding bytes to be zero is not correct. Except 
explicitly requesting to fill padding bytes with zero e.g., using
__builtin_memset(), the compiler doesn't need to write to padding bytes.
So this is not a compiler bug.

The best approach is to do manual padding or using __builtin_memset()
before assigning values to each individual field.

> change to make? I'm also unable to test this on LLVM 12 (my language hasn't yet
> updated to support that version), so this could have possibly already been
> fixed; please let me know if so!
> 
> Julian
> 
