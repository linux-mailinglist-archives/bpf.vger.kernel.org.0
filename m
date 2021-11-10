Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8344BB0D
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhKJF0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:26:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhKJF0y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:26:54 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA4dNmW032052;
        Tue, 9 Nov 2021 21:23:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GHa42RsHVxcZfeu40a1ZcLhDJ+5fw8HyuQ8NIFvzo/Y=;
 b=hBtCxqVZnHkZ/h1ZCTng8excgj65BkC7fTxn02y8/pTbwEsQ/YDSNu4xt3iWFH5WSfRf
 Y/i9VQN3cn4hR/WCJPytYr8aPeD7MxEw7ThecNAxScl6dEnWfJ+mpcUMFcZL+q6J1bLG
 cnAbzEidZjsxRLqBjKbKjgyi34JayQsNMsI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c828pj0sy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Nov 2021 21:23:53 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:23:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E77YXPLnWz4E30K9rEb4smeEhnwIXkUl3cZc+lxhvrTA8Jc3rc5t2cPXCphWzoq4UcPMy5szNgN2/5W7J9DfwynHbocp1bzw9MOgINdXL8DMCJNkuT14ROFzQBMQC1a+jYhIrccvJwJnoATNu9KgZ48KOoEEiKWlEdzVccxKa7UH5MEQB8qA5p8PXiMWgPAeOXF8C4+EchV2cOm1s6VENByzVXLBwRpsPbnRWxmCHnju02bu4w3L54Rbz0cAMoqExBEXxaEdD1Opf+O81aV1p0nzg8VNzdJemLSM68kS7f3PA5I9u19FqrsIxx2qp2Wa3tTveHkLsUmkbgw4j4amWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHa42RsHVxcZfeu40a1ZcLhDJ+5fw8HyuQ8NIFvzo/Y=;
 b=Y3Vk9QByfAhSVIGI2fH3+iPcwH64l9SL1/8dT3e07R2yBwuPt2LV0Y9Te8+hpXsaFRcmRqvm3SjRGfnMyiWOsyMZ50xpX1NJYsmiJJopPcswyXekmrPY6xuBA+urm9MVWqSmdkwOiZbvAQJy81nSPh14NPr8FZVTIpivkP9vPWAQfZrYuzlPpVpnofm82vY3HNe5vCE3BPRkDsCDJK67qfd9nuboxYxXlnLprDpcMcq0AtyvGo23MPwV99cVOfwk70NMHY5SfLmvUEOYb7bEs80FSpd/MQ9J8dCc9q0cfs9XUH6FTKRpf6SRr7pn94p7FGRLiZcIJK2UhOGmgwo9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 05:23:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 05:23:34 +0000
Message-ID: <e89bbd11-724a-d186-26d6-ce34435702f1@fb.com>
Date:   Tue, 9 Nov 2021 21:23:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH dwarves v2 0/2] btf: support typedef
 DW_TAG_LLVM_annotation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211102233500.1024582-1-yhs@fb.com>
 <CAEf4BzZXVjTgZH-t0kXP6rwyA=dxQqc3VAHdmh-eFHY5OdbGYA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZXVjTgZH-t0kXP6rwyA=dxQqc3VAHdmh-eFHY5OdbGYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::1709] (2620:10d:c090:400::5:dba5) by MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Wed, 10 Nov 2021 05:23:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b59f0a0-7fd3-4b36-6798-08d9a40a3d9e
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42233078EF15EFED9D275F0DD3939@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2YSFCg0d9OuCbRNPRtAGjz2OV77+aFZu+f1L0VX5QxJDqxMkhJ43YEJpNV0uJNEVIWgkWUEeCaYLZyqu1nlDk94ZKu7Av1enZvrb/2K+zOghpTgnzBWeEGBX9rvm1blBM8Xq0iPfebuHMidnRyWo8YgdSAgq5u/JEXO5RYqUICL3luAO3pfAZ8Hyyd98+hwShZxnF9mKemlzQKo+vyaJ93v75HJYxbJdkDvAVzXF5Y0XGt5U//ymnVLCnqxGV0LIcaQ4BBBFCryZbn/8FUKkKsNyJmAkHEETdYDDN1xIdJs9EHenO5V7Z6F2gTBp2EIR/veKYALTAgatrvprmp3mKNh6z1DDjKWVRGazokHy7X8l9akE2/IglUdTm3KrS5q4hriEldxN5dyJH54wix4GnUMKwTt79A3JWQN4Io3Arpc5aHYbUJbzSt1Nf1qxmXPl3uXxXHN52U/V19HcYDawl9DQRXYBjAaWs/A/Dwr3PB0piy0PmTRUUD/b9CyRXN8fyUxJjc/zm9+zJw0ZpA+7iRpiL9NZLxmOBBUUkjTtRDQac4NZ6YXKbXgzloglZ7P0U5JtYOmCli8SjLHUi2kZmnaIWVlObo8b9z84GSPLMTIyFXiOuDvCi1VkwH2lIzWUx2WoHxaO5Fuoh6gFWREywOZOzDhYL/QAbTG2YLG361eNsDqfdx4L6XkKU6mYckWk1FP0AFzgyMPrIumfCmVCrhcY493jHi082b9HxdJ/8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(66556008)(38100700002)(2906002)(8936002)(66476007)(86362001)(83380400001)(2616005)(66946007)(5660300002)(4744005)(31696002)(8676002)(53546011)(52116002)(186003)(508600001)(36756003)(6916009)(4326008)(6486002)(31686004)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzE2R1o5MlZxYXh0SDAwR2h3Z3hQdUJuTDhDTk1OQ1NMNFNrRVkxRlZKRC9X?=
 =?utf-8?B?VHBYZlpMOHpycG1TYTBjWHZiUmdWbUl3aWg1NkxIZ1VyRkZSRkxnNnZPWS82?=
 =?utf-8?B?bVJ4RmNHc2l2M2F1N2NkY2tMSmR0c2pucHo2eVJQZmozbEJzZHYybmlBUnBt?=
 =?utf-8?B?eHZ3TEhkeWIvckI0U1o1Yno0MVBqMkpVSjRONzFDd1dvY1dpMTRYbjVVRUZI?=
 =?utf-8?B?a3VRZmRQTnl0Z2QwVkxlU095MDRkQ29nbDdCNUNkYkJNYmd0YUhIL3A5RkZn?=
 =?utf-8?B?YzhKSVN0VXhEVmdpenhYZFJneVdRUEpRU1JEU1RjZ0V3enJ6V2ZLUXZaWk4r?=
 =?utf-8?B?K1ZMWnYra0FIeTFsNk5TMXhzejdZWm8wYkd3VjdXb1NQbHM4SmRNRHFHd1I3?=
 =?utf-8?B?dUhONzRPZUpHbWRoVjdKYkp5alRjOTk5bEpzYmNGK0ZtZjVBZEszL3ZYL2JW?=
 =?utf-8?B?MGl3UjEwSkVPdk9uV2pvSXRHSXlyay91V2E0S3pIYXIyeDBRb1lQYVNtaFBX?=
 =?utf-8?B?b2hHcFBhL3VwWE1nVFJIcCtqNGo4d0lyL29QZEpJQ2Y5STR5bUtPZEo2VDV5?=
 =?utf-8?B?Z1pLYmJWY01UYjMvd1pxSldXNFhVUmlGVHU4UGwvRERIOUFHNkZqeEFxQ2Mv?=
 =?utf-8?B?MHBjb1dsL1NUV2FtSVdqellwcklFT3ZlV0ZqZWZTZVRxaURqR2R6M1JZT3U4?=
 =?utf-8?B?T0lhK0dhWnM1enRWK0hRZHdLQWxzd1d6Yk8vWUt5OUtieGhMME5JVWROcUty?=
 =?utf-8?B?c2Vmc0JRdmc2ZndyaXNKYjN3YjlpSkVlSDNFbkl0dEFycHpKMU1TK3Z1UWpv?=
 =?utf-8?B?YTN6eTFZTmk5dklkWDZVRTlsR2J1Ukl0ZGtjb2VMb0t6eFNNVlJnMldCZjBY?=
 =?utf-8?B?N0RlbC9FVjFiVVhCYmloczBsamQ4aGtoZ1piTG4xRUtEclVwRGlhSTFEZkFt?=
 =?utf-8?B?UTRaalprdm5CZ1REZ0lmd3RMRThKQzBCUHpzb251dXljV0JUampLbG1UVFhU?=
 =?utf-8?B?Sk11Y3FKZnQrOG5CVHRKYWRRQmkyR0xYN2JQZzY5b1ZrK0IxSkxMN3VGY1BC?=
 =?utf-8?B?T3FveDk5YUkvRE1ZSkRzTXd0OXZCTzdIQnJHeS9FSEtvVEFuMW1kWjduM2Nq?=
 =?utf-8?B?TXh2bUJZUDhLVVdpNk1PNWNTRXh2OStIZ3NSYjNEWkRiQnAwQnRLME1ycmZJ?=
 =?utf-8?B?TmNoSkFleUQ1WUlkQ2dZSDZFYXg3c2p0UHpSTHlBcmIybXM1UnBaajUxaXRX?=
 =?utf-8?B?ZGs1YThsY1JzMlQ4bzZKUTNGRGpzQmFzSWlzSVRIeHNleU0wWUlXazJZTTZw?=
 =?utf-8?B?M1N6aXRFNXVrVzROcm9vUUYvZHlJK2JDV0ozMmFOcTRxWjZwVHY1Z2EzSi9x?=
 =?utf-8?B?aWtSMUFrZDloamRYTjcyRktGMWVFOFBCTXBEZUpUeUM0ZTAwN1RyamdnZVdI?=
 =?utf-8?B?Nmt0dGxUMXFURWs2eWR2Z1ZTZUJ6RDB2Sy90TWN3RmtQREJCVjZGT0EwaDFy?=
 =?utf-8?B?ZVE5Y2N2enNVMHZ5MG85bzFCeXFqMGhFcnhpVkJzMFNpOHFlWDA5d2swVEVY?=
 =?utf-8?B?T0RRQ3NPbEY3UzkwSTVKbHBJbDYwdlUrTEVSNG5ackVWR0dXd1pPLy9Cdi8z?=
 =?utf-8?B?Vi84cXIxbXJYajBKMmhxRXJQNDNwRnowdEFDdXpBY3RvbkN6dkxQd0FMb3dJ?=
 =?utf-8?B?Tk1CRFNjVWw5ZU9ZNld3QkllSFNBaUwwTnUyM1hkaGpjeVBpNWwyTWMyUUJa?=
 =?utf-8?B?NURJTm5aczVPZ3JBWitYM2VNRThRUVNtZzgrZjFhbWFGclVvT2JoSkpkRjl0?=
 =?utf-8?B?SVoveXBpZGxjRFpYdVE5MEhLS2Q4SzdOWm82am1mMFJ3Rjh3Q250Z3h5ODZL?=
 =?utf-8?B?Q0wyMis0WS9IakJaREoxUjQzYld4Yjd2R3lvVjhERUsxcTRvNW1aZnErM1R4?=
 =?utf-8?B?ak90QVRwMVBiUFRQSnJQc2tyUDAzYmVNMWJ0RWZRUHBCd053V3E2WEJKM3Iw?=
 =?utf-8?B?c1pYMkhyQlN4dUJocXpGUjc5MXo0VWdpVjF2bHNZRXVPSWF3TVVrZFZQRUZR?=
 =?utf-8?B?NzVrVWwranpqRUc5NkRkanlVMDNEZmJjWXJZQ1dkbnRWY2xqenhIQVAyMXVM?=
 =?utf-8?Q?u6S6+FA/cEPrKOlbo+rjj7yS/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b59f0a0-7fd3-4b36-6798-08d9a40a3d9e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 05:23:34.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiPXCgCojCuLatOSH1znk3JmoQHlVNL2uv48jSXYkEJGrCXZom+8zv/cI0RpxPvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: R5nYbBkwyHHDCxUHn6cee0Tfb9DDbOtY
X-Proofpoint-GUID: R5nYbBkwyHHDCxUHn6cee0Tfb9DDbOtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=713
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:11 PM, Andrii Nakryiko wrote:
> On Tue, Nov 2, 2021 at 4:35 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Latest llvm is able to generate DW_TAG_LLVM_annotation for typedef
>> declarations. Latest bpf-next supports BTF_KIND_DECL_TAG for
>> typedef declarations. This patch implemented dwarf DW_TAG_LLVM_annotation
>> to btf BTF_KIND_DECL_TAG conversion. Patch 1 is for dwarf_loader
>> to process DW_TAG_LLVM_annotation tags. Patch 2 is for the
>> dwarf->btf conversion.
>>
>> Changelog:
>>    v1 -> v2:
>>     - change some "if" statements to "switch" statement.
>>
> 
> LGTM.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Arnaldo, did you get chance to look at this patch set?

> 
>> Yonghong Song (2):
>>    dwarf_loader: support typedef DW_TAG_LLVM_annotation
>>    btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
>>      attributes
>>
>>   btf_encoder.c  | 17 ++++++++++++++---
>>   dwarf_loader.c |  7 ++-----
>>   2 files changed, 16 insertions(+), 8 deletions(-)
>>
>> --
>> 2.30.2
>>
