Return-Path: <bpf+bounces-18539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9F81B972
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081ED1F21934
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD26D6D9;
	Thu, 21 Dec 2023 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polimi.it header.i=@polimi.it header.b="ekPEL9t1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE326D6D7
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polimi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polimi.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZl91pg+eVG8ONklKF6JrvNfY39BvRBl9YDoGgsCojscAAMDWql2qFfMiYxeJaGedajHkRRHXRDQ91NLetPN+FdkTGgD2+m0KH3naj1/S1uaVcptUK7MVDce8NQ4E+Bllhy6NpnK6YtEhtmuqaTT/TaSJnu1jvPFPdD6KrWrsO2Fc97PuQUNerHICaYD8WIHRJcamxN/HACjPOggCKWr/r2DvHvbyEdVTI4zExkR+qmAuuPTpuSQq7IMGF5+vMljnWPnW7BLeXpGuEGxwHfseyxpXBrJI28P3hahmde1j6H4zM9ZimeJlOQTDDq1l+mq27hSnotlkKwl4y0fJOvJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEn1RI36rgiHg78jGXQj1xRV8PeEZ29sBK/fwjjlTlc=;
 b=CxOIoBZlWe8JniVpd8BNbn+dllM7VaN1NShSgCWHidNYk0hvhnTnf38CYamEyLwBnpD9AFREOPy7JN/MlF0BsW1BWPdCD7bI7O5PM9T2wut2p5WFI7fhsm2h+6/zZM12XWcuifWtEN5ZOcJaAis0DcC8P+tqSvUeBzcgY4FAcRBPL63Nx5r6OJsp8Wr96acnuWwqQ0S0gItsvfBCHYo8BNpX7uHjc9AzMNn7NRNR2AIuieSfUwRRSWdyvGXxq1oN/Xj7HmjLRiZaZhzuHlAM+p85K25WeVYY8HyPUSPRWujNufTXxeFXsvyEwqhJ4X2XkYvcOC9xnPyRBKOPa+V14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polimi.it; dmarc=pass action=none header.from=polimi.it;
 dkim=pass header.d=polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEn1RI36rgiHg78jGXQj1xRV8PeEZ29sBK/fwjjlTlc=;
 b=ekPEL9t14Hp3gf+eiaZU0MNrGR69r4rwoqSauKeSU/dV7ZbgX4zSlLMBSuHwv2Jui7ImBxoduc4xPxvQj9/G5StaSCM69/yX4wipA7OD0+rrusXFCarPdJthIs7jHO26n/XddVMFYrAtBM0scwaFQhekEeHRV8ZLzviQz1uMI/5uJm5m5X2BzBiUUfZminT1wNiWkaT2FFowwW+CVpCq0hL/KttNs1T6EH64y2/KBecx+Hu6YXUUvnmzhbb83bvBs8gkIkOhmiUr0791UUUBGDYg21pNWSPdrm9Khxix3bWD8bAgvmh1nO7Tt4Ofx6Prg0IRZYBoF4C07I5FtO9qWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polimi.it;
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2ce::14)
 by AS1P251MB0557.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 14:20:16 +0000
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::afd1:5d4a:c4d0:945c]) by DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::afd1:5d4a:c4d0:945c%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 14:20:15 +0000
Message-ID: <e4f46321-73cc-44e2-9a20-50f923d00b65@polimi.it>
Date: Thu, 21 Dec 2023 15:20:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected behavior from BPF/XDP program
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <901d67ce-1344-4015-ac2d-7ca7dc28acc4@polimi.it>
 <CAADnVQLm9P6ghj2Ohh2gXYF4_m-vdfxoH5nz8PyHCJUhUOsEZg@mail.gmail.com>
Content-Language: en-US
From: Farbod Shahinfar <farbod.shahinfar@polimi.it>
Organization: Politecnico di Milano
In-Reply-To: <CAADnVQLm9P6ghj2Ohh2gXYF4_m-vdfxoH5nz8PyHCJUhUOsEZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0194.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::21) To DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2ce::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P251MB0389:EE_|AS1P251MB0557:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9be218-60ab-458b-d7e6-08dc022ff3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UqNk+wfhzHYXYI+3k68DovN87x4u+zXA8mD1uHD+XOEyAkehZBchBuFdlR38/BvEqDgiIBSVZYSjrsRvu5ybE2kxcMcoDnPjSS7pJL0ZT+iAicA3Gt1j40zIQhzJuG6X+p53gxIwXGpBcL1qpj5w1ZcBgdq3I6CjR8IwjtIO/OPTWJM3TcZ3P3FKThfbwdcyNNAXyqz+RsqXGBHY4HhqqFXhPWHLAhICGWCc5jx9UCW7rYthz4leB3dFcGaTG8rFOopMtO/DIYQUggjrkFgpEum29ro0WyChxCi2WD5ZZ6LpE7oHCr+iDOciLraq2G3cOTfi4nxTz6+n3YxadrY33EUxC6v4U16DgWu36LMo7MRzrcX+AljLsmteCDEFoA4MLEEIxod3T7VQfUlV6QjP93b6FCDtOMhau8D5HYdk6YVDef8Lj9NV78COn6JW+GWoy3waHRYiY80xx29LHa4jckFr8HSVRxAPggwPBkCwpJxg76B+yIhuXSR67GCE/JldEqa6kkGZ9y8eCLOWAPfHJyaBoIr14VbtlRtdxiVWs9zgCrKPhHjsSHp3Ay99tZBMxZVBEwAV5+yr40jvkMx+40coQwcmcyXuadgt5puFxowGLtLNUokAr503CtMYR+nC6ZrmPx583WpoAFv4RBI7DA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0389.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66476007)(26005)(6486002)(8676002)(2616005)(8936002)(478600001)(66556008)(44832011)(4326008)(6512007)(6506007)(83380400001)(66946007)(966005)(110136005)(54906003)(31686004)(316002)(786003)(36916002)(5660300002)(53546011)(4744005)(38100700002)(2906002)(31696002)(41300700001)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllVMmk1WVdPL2VLUkNZbURwRUYwRDZHeXlvZ1NVVVBnQkJvMHdXZE9NdVdO?=
 =?utf-8?B?aElsVUZIMk11ODE2OXZZb2tMKzRaYVdJb3NkRS9jQ1JWc3VzcmVPaTBPTit0?=
 =?utf-8?B?dEJKcmVCd3hQWXh1K2Q1U1BMMWRyVUFPWGNpN0dYWUNVQ09FSHZtYTcvc2Ni?=
 =?utf-8?B?M0REVnA5MkNINGVPYnpzYUtsRTlWMXZ2cGlZRmpGQTdmSWxKcUlVVFpGNmxU?=
 =?utf-8?B?aUtqcTl6cldyeXdSMnE5UnBkcjB4d3crR2F3TE9FOUNjSytLa2NxQmhvOFBr?=
 =?utf-8?B?R0cvQllrUUU2UkJpVXZBaFE1aHFyYms4amtpc0FnRG5ZWERIdzZrd2M3cVJt?=
 =?utf-8?B?TmtxcDVxcEplVW5XeHdyMUJPZVZ0ajhjU3Q5cFpNY2NCZDVaKzJhSTgyWk9l?=
 =?utf-8?B?Vm51RjZtTDNYZHZTS0dkdEZvSUl6eDhsSWRIN2tIUHFLU2N3R0QvbWtmK2Zz?=
 =?utf-8?B?S3drYVBuMFNvREw4NXJIa3BmWkZtZFE2S2N4V1pDTjVwWFU1d2lnWkJtbkJW?=
 =?utf-8?B?Uk0zY2RjcXAxdE8yOTFMRlliWERqTXpEb0p1N0pENk55aEJ6TlNubW5LUk56?=
 =?utf-8?B?OTVhTlU4Q3MxLzVmdTJETkJIUmhUMnVYZWZBY3owSHhWUWRhSTFwQlhHNXoz?=
 =?utf-8?B?SXBDdTFNS3V0V3FmQVJsWDRNUk9kaVRoRHRvcGgwWXhyTm5BVWEyZncwZnN1?=
 =?utf-8?B?VUhpaEpudDlCUXFOeXU4Smh5akpwK1dPblhjSTQ2R3FoN1ZUeGRqdGtOY2cy?=
 =?utf-8?B?Z1JDaDB4N25VcFp2WVdSRDY4M2YzemFsOUs0K0NCbHQ0Nm1wNHhYWHppZlRG?=
 =?utf-8?B?SzYrdmdJTkM4bW9uRlhBWHpyUURyQVhGMWx5aTRUdnJKRkJLTEpMSDJzMXVq?=
 =?utf-8?B?dW8zY0s5V2tZSVJrTDByU09VVkQvb2tSaXBucEFDR1pJVitJdHU1TzAzVjFs?=
 =?utf-8?B?ZVI2dXVCdExwTmxQU0xNWUFJVjZ4V1UwSXFPdkN5YXJKVVhFQWFGMmQzT2d1?=
 =?utf-8?B?ZU9oQzJOSWxjTHhyaklzd2swZ3NRenR1MGNGQTBmNmNNZEZVTVFoR01COVRW?=
 =?utf-8?B?U3ZENHNTZ09NYll3ZDFVS213ZUJZYjJyamV3cURNZDZCQ3Z6dDR4cGcvSVdk?=
 =?utf-8?B?SWJFTE1FWENrQ1hPczBpS0RBeWszVmtVQzRVcU1BUFErSlkzbnYxMmRYeS9Z?=
 =?utf-8?B?L1JaR01HM1NtSzhCY0lXYWZHODI1TWZyVWhEVlB1YmlnZU9xMHlpUUdINzZZ?=
 =?utf-8?B?QXgrc1paVXJzOTVxYks2TkQ1TWhVREhoUzNDa0pNNEM4QUZuQjU5bnZjd1A1?=
 =?utf-8?B?Rk5xYVFVZHg2ZFRJa0RwWm5FVlQyY0VINTl3ZUY4ZFhmMmttM0p0b1dncVBD?=
 =?utf-8?B?YUZiMS93RVlwV0tCWnRCV0xZdUQ0OVI5ZzdETWRNREk4N29kcnhiZWVPZ2w2?=
 =?utf-8?B?dnRld2tlMDNJTXhsZTNTREU1VDhUa1BrVStpQzREN3o5OEp2aVR2UktOWkk4?=
 =?utf-8?B?ajlyN2srWWJnS2cycEgvdmV4eThPL0lST1ZOSkUxRVIwYnRqMEJRZWZMbmFP?=
 =?utf-8?B?K0lvYzM0VXRuTG5KRGZod0lndkpJNHJTMGhUcHMrTU1NMWs1c3NKSXlnRjQ1?=
 =?utf-8?B?TUNtTXNZWWJkLzZsQXlJSXVDeWJDbmUwRENaVTB1MkIwUW0vanBSSkJQQkQ0?=
 =?utf-8?B?aGlYYVFaa0dsOFdpckx4UVQxZEtRam94YkdnR0JDSEtWYk1xekRIdzY0S0JN?=
 =?utf-8?B?cDBQaU5DQkdhSzQvK3FBNmpRQ01MMnNDTVZnRzNuY0g5ay9JZVJ5ZnlJaEx0?=
 =?utf-8?B?cDNsTFdmRVV2WGw3anlUZjAyU21WQ0ZSR1NXOXhQWUF5U3J2RmdKY3A4N3lD?=
 =?utf-8?B?ZzVqVjhRZ3l0WnlMcVdOaUZCVFB1aFpQL3MralZxeWNyTWNSdS9JMUxPeFZk?=
 =?utf-8?B?ZXdQaWZlNUxBeUFNQTladVlZdFZUYndKT244STNSZUtNN2tTd0szbEU1ZTNu?=
 =?utf-8?B?Wkw4VXJBTU5qeUYwdDY4bnFQSjQ3ZGptb2xyMC8rMkMvM21QNEMvOWh0TWVM?=
 =?utf-8?B?LzlxMWEwZDdCMm1yMnRWZ092aVUxQXBzMGNXbnlDTzdyTjU0TjlLck1PZnNm?=
 =?utf-8?Q?gYeVA7rfRvbBhQs4DODDvfft2?=
X-OriginatorOrg: polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9be218-60ab-458b-d7e6-08dc022ff3d8
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 14:20:15.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy2QML4YOVL1CiVzw6wp3jtgO2OHm/Upt0exmsiVcrCRM3/3vHjlLld/e0o44cF/hA4yv3W7hc8Izhxs5IpEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P251MB0557

On 12/20/23 01:31, Alexei Starovoitov wrote:
> On Tue, Dec 19, 2023 at 7:00 AM Farbod Shahinfar
> <farbod.shahinfar@polimi.it> wrote:
>>
>> The kernel versions tested are:
>>
>> - v6.1.0
>> - v6.5.6
>> - v6.6.0
> 
> ..
> 
>> I suspect the issue is related to the use of bpf_loop but I do not have
>> any strong evidence. Is this a known issue? Have I done something wrong?
> 
> You haven't done anything wrong :)
> bpf_loop is indeed broken in kernels 6.5 and earlier
> until the fixes are backported.
> 
> These patches fixed the issue:
> https://lore.kernel.org/all/20231121020701.26440-1-eddyz87@gmail.com/
> 
> Are you sure you've tested on 6.6 ?
> Above fixes should be there.

Thank you for the response. I think the patches you mentioned have not 
been merged into the mainline kernel. After receiving your response, I 
checked v6.6.7 from kernel.org and still had the problem.

I also tried the bpf-next branch. I think the bug has been fixed there.

Best regards,
Farbod

