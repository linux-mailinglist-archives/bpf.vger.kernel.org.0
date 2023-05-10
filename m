Return-Path: <bpf+bounces-288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B76FDEAB
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978F81C20D69
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAFE12B8F;
	Wed, 10 May 2023 13:35:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E36ADE
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:35:22 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5BAD12
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:34:50 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A2BrSb003210;
	Wed, 10 May 2023 06:34:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ir8ozh5Mipzn9LRhhvQzo5LSjOj+TH8DThhFhJlZXjs=;
 b=Ie3l0K0+gR94QIijpHBkYK64sQRLnwKPUl46rSIX2GyERS6mpv3NnJOviaCK5fxFpOhw
 k+/ZGl1HXzJRZO8N4JSXvbT6keDxH6EXkvB51ZwrTea1N7XdZWENOw61qQ0OxRtzLOJA
 aP89U493dRzyqUpl4cPdHRhs9tajE9d9gp2LMJq1iX4iokeE1bEE0+Mg6sra0Zr7truz
 z7bZpaaso5O8Py03XfP8Pi6QRKoGk9yCwkVVos2G6mpM50QgEW2ApUwAblJwuN+FX9e1
 kOJhEVXa3cFJYsoDNumB57oLANx1mgyYETbiqC4EQy7Ysvvt5Bo332FVeNzUDEdH57N2 5w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qg28kuegt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 06:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgKcZgZOIG7EQe4EMAYOgRaiZJ6RAzfS0Wvo/o/kdp9b/nDZzizi17SSa4bXoNY0hV7R1CvUXdv+71pucDfi2/MxgtmsquvBvmVRxkEdG9NRushJWYd5v/XihRlWDlQLFlPwFbs8CIjTh4h5mJEvZSfryp0vjpOdG0isY6EBFFM2vDllk46OJ3duciJmtbZ5a/trTI8dqdaOxYz3n/XstSr09FfAe3FziLhfZxrMSdbOH7qVnRFu5h+3H6V3bZA9Va/EQeWR1I5H7FuTPJ5z3znd6jl7anb0XGXCmnRmrX1+aXHbI58URVtz0fj5FutnkwIp/cred5qasLgkdjxvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir8ozh5Mipzn9LRhhvQzo5LSjOj+TH8DThhFhJlZXjs=;
 b=hOO6uCiy+g4waKQHF0uMKJJbHkFECEw/JH7/d7EsDELLANoO+mfHG/0m6ddgqCowJRy43NqEQoNT+4BNQ8US7YWjBAptdxcCBRnpunIOQWd81MjjemVHbjaonidHab28ciJh+fsiferTO9bVHnmt5d4fCMJFM2GsiBClESVU5sJzFphU/YtiFCSKuWyi7byyCaNNrcRV4Cc5haN1mzi2Q4YxFR2VkSZVDzwSK4CtmmqVpU6MyQHGVzFZWCuV8ULpsSu+xKrrOiyVXPnGRYwLcuMnngYXqe/cNdoLM1+RINrURBhDtmG9jrOdIV5vIHnpj+n/V4XlfsQuTlIfL4z7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4815.namprd15.prod.outlook.com (2603:10b6:510:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 13:34:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 13:34:42 +0000
Message-ID: <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
Date: Wed, 10 May 2023 06:34:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] Shift operations are defined to use a mask
Content-Language: en-US
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230509180845.1236-1-dthaler1968@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d7fe29-d010-402b-3d9d-08db515b4fd8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k43oRYFxwDvP5u2g7rcvdz8LeLpzGJwQr+V54p5a0eNzdokDXG0COP2aTrFNRAVOX+GQfTW2QdN8x+XxPYLL0w2jgWs1Tg4bnNMnatZ1R9vLgeNfZ3Csqbx5J7JyAMYTeLwDERHNg8UiFzK1J9bMXUYLYpL2Mgd6zXvQFwAzX1R06JEZbCaqesEFYI/AYUABKvJBIn4skrMIeSN8aOMKUwMmgwa9dLg3b0+Opqa2vf1eh2ISZCeU7pWuGBkFAAVkcVB+Dv70AOQjECUe4fvulhgmBX3nVa9DpXx06ntOrtC4n+vagDfg5tbxR5OQFMwKWH0py5pfbGIxgyMhZpQHLLo/X+4OnQSLghmQgDzEtZlfODhL8ixt2yK5uIEVRvQFci9oggH7IFpPVGqBQ5i34OXyUm/9LvDHa9ATRvQnpXu8ZdPZM1zz/gL7qxVac5Fs6KX29aaaSqAVLdhJkW/Kk+zHVYv0eQv+kbXbDn/C0seEVm+Xlpr8og7tXBP/D9ZcbIs931XLd0Ej6y61vnvtaEWgNtMk/WqQmKOUURX85bLd0oDM0VFIiJLYD/SwTLtznN8Dm6+z1Zc1I4GbE9de97k6EGjkGYCMG265RdSH0HJOXfz9IOP3ASaq6M7uRPd8+KmCFDx2vqu6m1tfuNGH7A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(66946007)(66556008)(478600001)(45080400002)(4326008)(66476007)(8676002)(8936002)(5660300002)(6506007)(6512007)(53546011)(31686004)(316002)(6666004)(41300700001)(6486002)(2906002)(2616005)(83380400001)(186003)(86362001)(31696002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGxqSVFFcnU4Mkc3aVVBZS83Tk93TWQ0YWd6djNFbjJ2dXhibWJSbm1iODNR?=
 =?utf-8?B?MXBtcmRHY3E1clZZWWd1aXNPQ3RFTG1Gall2MnhKZ29MRWVZZlNma2UyU0tx?=
 =?utf-8?B?L05RV0pJQXp3VFNhL0xRVWZNSzREQ2NBWGhEd3NWUS8xa25maHVCaWNqSENt?=
 =?utf-8?B?N0RVRjhweE1QbkNUZ2ZtN2VlaVpXcGhFeTBOZnRjbFRVK2lXMFJNREg3MUl1?=
 =?utf-8?B?djFVanF5SURzREp0Z2pscm9takxYdjZVSHVqNTdwWGNCUW4vNFQ4YWtCUzVB?=
 =?utf-8?B?NjI3bGVyQzNSbkpSRDBYNnNGNUZuUzFZNFJZWmo5UDNtTzBTUStpcUxLK21a?=
 =?utf-8?B?cjUvU3owWUVvcUR3NlNaRG1NS2tNQzkrUzk2RU1vaTQ4NDNlWHpxS3BQck5l?=
 =?utf-8?B?VlRuckNha2lRYUh4aElSd3g5Q2RpNjFHcG5wb2NVWFEweWhKdmJZbDJrbnlz?=
 =?utf-8?B?L0FrQjMrRkpPQXhUZmtSQTlWaFRMNk03WUlqenMwUUhsdjFVWmE0cGJBZXFQ?=
 =?utf-8?B?RGxmc25jZWJZOHRydFYrdVkwWkdGWmV4VkxYV2cvVEIvdXhlOW5vK2lmTDNF?=
 =?utf-8?B?UENzam9wMnVxbGpTZDg4VU1iZEg1RFNKUWJzVm9yYzF6SVFRdUwrQVdQaEJG?=
 =?utf-8?B?UTlFVVltQ0JQR25sOVhCM0xFeklPdlBoQVlZUzI2U0ZnOEtwWDZ0Ry9XTkox?=
 =?utf-8?B?NDBmMVJvWWtONjdXS3RvMnl2U2thTUg2dVFabTUwMW1BMnVsODFYSzNhSTlS?=
 =?utf-8?B?RElOT01VdVRNM3AzVFhvYjJZRDM1SHJMYkZ0enpaY2NrbXB5TW0xQWt6MGVD?=
 =?utf-8?B?Z00vcEcvWVB2MzVaczBFcWNPaUh3UnVXRXpvQ0dkSkJWSWFPcHhRYXBzS1lz?=
 =?utf-8?B?NFhHZ3BXcU9HV0V6MzdOVEhxVEhrV3VxbVV4WndnR08yelR1M0xpRWgyNFpF?=
 =?utf-8?B?bUIzL01RYmR1d05FR2xqVi9oMnA0cEhQMTJCQmswRWtWNHlIMk9CVlFzRG1Y?=
 =?utf-8?B?Wmlma0xyUnZRTHBjUnAvclBsUkhyVEk3cllKVGQxSGN2azdmRGpwcEtNOVpl?=
 =?utf-8?B?Y09lVElISzNhRSszYlFCZ2Ywd25YT1FOT2llbVQ1Y1Q3VXhBWWUvcVdvZ09a?=
 =?utf-8?B?WEk0WkZiOTRXSUpvTGRTSlZaME9DaGxnTXNINlhJcGRJZW1Ed0p1U1lhalJk?=
 =?utf-8?B?SnY3NnA1MVJUVmovRHRrek1aZjhVdG1EblBYUWdWbjM0K1NiZnNTd3pZN1gx?=
 =?utf-8?B?NnFZdE1oaHJIRXUxeTU4azBldWVQeURoUjZVRmxER09EKytIZ1BjMTl2bGNK?=
 =?utf-8?B?eE9FYzBrVE5FV3ZwYjJWS3lUUXd5VzU5MCtJQitpS3BTWGF3SUtuWEZBeHVt?=
 =?utf-8?B?SnMrVTBYRyt2VVpSZ3gwWE9VN0I1Mk1Zd1VoeVdCYTZMc2hWUytBbjh4ZUtE?=
 =?utf-8?B?Yzg5RUo0STQ0eng4bW5XOHFZclErdHZIeUpnTWlURzY0a2lUekZnbVFNbnNW?=
 =?utf-8?B?bnVXLzU5RWcwdGhRVDlLS0J4Rk9ZNldrRXBTN3g5SUdIaWJQUHhoQlNSOStC?=
 =?utf-8?B?S0g0cHhRc3pvbUM2WnV5M21tWU9PdkhyZnEwQmt1N0N3QmFOd0hLR1ZzRStz?=
 =?utf-8?B?Q2NyS3p1QzVOZ2pzMTVMaEYxY1hPa2Ewd084Uk4xWkFSN2QxZVJNQnVYdUxS?=
 =?utf-8?B?ZHlRZTY1d3k0d24yb0xRbWQ1L0lYWXpiVFV2Mk11TTBGYVl0WDAyRkk2ejZa?=
 =?utf-8?B?cnlTMlBWbWpoMGJ4SnNyeXNTcHBoeCszSGxCWGYzV0Z1blJyaVFtdXZ5Y1ND?=
 =?utf-8?B?VzZrRG93MWNnRU5zOXgzajArWWdBZ1Y4UXZEWTRaY1BhU3FnR3BRU0VydmRR?=
 =?utf-8?B?anI2NkFtbjY5L0pBRHlKQWNTUUE1b2lyRFJ4T0VSZmp4QkdWYXRhNUxESlg1?=
 =?utf-8?B?YkhPWDkya0xsRFdRN3pmalE5RDI1L1NVOEkwMFRuMVAzOGVOdnlHd29tdEVO?=
 =?utf-8?B?ZXB5cXhscFdUS3NwUXhobWd0bG52RFU2dXVVSUMxME5KUHVCYktodzRrR0FL?=
 =?utf-8?B?NmhhYmRZOWZMaTZXdisrdVFYTEVZREZqQW9PZ1JLbEtpSC8wWmZEU0NBY2cr?=
 =?utf-8?B?UVB0aEZ1a1UxWVNyL3NoenBkRVlqNEZMWEFLaWhDU2dXUnBUT1QwWHhvL2gv?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d7fe29-d010-402b-3d9d-08db515b4fd8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:34:42.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdivVvYDqHzA1WUR7v5TNNGKaDleohDst3pjf2yRdSNgfusn0IR/pIqZDJKgMk5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4815
X-Proofpoint-GUID: Hv_GmLnmb4q3wChoqo5afH4xhF4cL1Su
X-Proofpoint-ORIG-GUID: Hv_GmLnmb4q3wChoqo5afH4xhF4cL1Su
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



On 5/9/23 11:08 AM, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Update the documentation regarding shift operations to explain the
> use of a mask, since otherwise shifting by a value out of range
> (like negative) is undefined.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

LGTM with a few nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   Documentation/bpf/instruction-set.rst | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 492980ece1a..6644842cd3e 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -163,13 +163,13 @@ BPF_MUL   0x20   dst \*= src
>   BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
>   BPF_OR    0x40   dst \|= src
>   BPF_AND   0x50   dst &= src
> -BPF_LSH   0x60   dst <<= src
> -BPF_RSH   0x70   dst >>= src
> +BPF_LSH   0x60   dst <<= (src & mask)
> +BPF_RSH   0x70   dst >>= (src & mask)
>   BPF_NEG   0x80   dst = ~src
>   BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>   BPF_XOR   0xa0   dst ^= src
>   BPF_MOV   0xb0   dst = src
> -BPF_ARSH  0xc0   sign extending shift right
> +BPF_ARSH  0xc0   sign extending dst >>= (src & mask)

		    dst s>>= (src & mask)
?

>   BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>   ========  =====  ==========================================================
>   
> @@ -204,6 +204,9 @@ for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
>   interpreted as an unsigned 64-bit value. There are no instructions for
>   signed division or modulo.
>   
> +Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
> +for 32-bit operations.
> +
>   Byte swap instructions
>   ~~~~~~~~~~~~~~~~~~~~~~
>   

