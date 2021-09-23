Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED13416382
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhIWQpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 12:45:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15456 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhIWQpf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 12:45:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NEgKug029482;
        Thu, 23 Sep 2021 09:43:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IYjNjC1+3Oynpx51AXdliASTM8sqJIT5ZJNybepzbNQ=;
 b=fRQPehCVXuxmEW/5vGqY6cmQVRUWHF0d5bh8DsWU+0syucpZ3IvAMLaCwR94FsCKPIQJ
 wpxlxczYEGU3JJE4D5CsfG6eILF3LEUvb+r5t2r8kW/28tHvKb8Be5Qm8rmyHiJQh+L/
 b32/QuLGxVX5AxuPpylkRHSsjzKC/ZCvyCY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b8ujy8xex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 09:43:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 09:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6fj9CcH9YEtmvb1gW34UHXfmvU5SnMJyFKEjEx3YiOZjPArDuMiTzFY7dgKubjvVNcmzNyMFYLC29sfj0aegZPjvIJPXXgL19ojh3MZT9HfUCeNDDoA7NjjV5Fk03Mmt0DbjM3r/jI/D48OLOBWnoVIiIwP/6I8anfy0QjgAZt7mMcCwyFgHHp2uKz4bdKcoRR3LDmrvXSLfiwNm2cuYMqVlopaoF+Y4ouNz8AtaPRA0gshVcTI/UXXg+7BafS3p850pD7dJjjZVKklXMdaLm1fB1/Uws9VMaTEX1p9GCmve6ysyH3VcmRbcxRGcoUnghYSyBjpJfhZl4AJUmnhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IYjNjC1+3Oynpx51AXdliASTM8sqJIT5ZJNybepzbNQ=;
 b=l8e10Ev95NAa0dSUTarrsMidKE+SOvwm8phzgCvmRz+vVKnCuPfJ165EpxefDi77FUKBlcZT1dOZmwpgz/ba9xQrxVON5ObQ8hpTCT4R6uUm0tBlJX8MHMrWUmeH8lmJO0kyXHewVaapKh5tCAIfejjDrB64XGQTME1pomKY3Nkwi0vEw05QFgJ2U+2m7i7FVogxrNTqE/8xh/45PaCqnOVTg+FF6Ae4sIhjClyigmevD2/rk70PGbhkYyP3ncDsYF4/dZu6YTjXcJsj2xDaov5qR4rF4fapn6yY+HR//jhqG0a6TqkJ7hnn4ojzy16Efi/mNmSsT08T9DaNKPl7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR1501MB2005.namprd15.prod.outlook.com (2603:10b6:4:a5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 16:43:49 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 16:43:48 +0000
Message-ID: <0ce9822b-0e49-284e-e999-9b473ebc86b9@fb.com>
Date:   Thu, 23 Sep 2021 12:43:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210922234113.1965663-1-andrii@kernel.org>
 <20210922234113.1965663-9-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210922234113.1965663-9-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
Received: from [172.16.2.93] (67.250.161.190) by BL0PR0102CA0028.prod.exchangelabs.com (2603:10b6:207:18::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 16:43:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58499dca-a319-4cb1-a8a3-08d97eb15117
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1501MB2005523444AE87B0CA55CB8AA0A39@DM5PR1501MB2005.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoZjRjWJqkWQh+KQVEUbYMBoVlg3Fe+nbgzf6HHru6n1JctAllMvnwMfjhu6SB1pJy9H2+tvptB530FchI2ugDRxb5r9PeDgVxzx+W1yXQp1kpSt48Uke3HKZ5y+J+mufqTCSAQPiviyj5BrdkNzTsAbH7XsVVad1HW1KLo/SWqcmmeBtQ08x5C/N1Ifwyrd3nrC6yZdnCktyuZfjtyTqYe7RXplw7cbL+x4/0don13i2+QA3JG9ycs6UWxOrFWZkNLPBpZiFvba9bt/UEm7WVpNfukc+Xbtr+lf6hq5rDPFS7v07RZxaFTcW1Qan1YqgdAJpltKbdn41yHZEa+9CcvM7JEZnspPc34AOU6qibmbMDT/30scIYTVsReEvyoUY5DLEr8on0/g7NizwDX784EdDM15rzQVB68nsriD/hQEHsPc/aEum3BC5xEoyfxwEHOYsqYzLNH/n2Lx3mc0nC5SkUHhdS7xq1+nrOh+nQmMFvu+DT9JfgYEQbtneEI+NizRCL9axfqKL139yFHZhYmefvNGEe6aqWMjl8R6k7PcdbdosoNz+1SapppPIdUBtvIt04opBAwUEfE7Z0XAVymKpm5uwKt1uWVimJeeNM51Q7X83KC++V3qdPVrPGKpFsZCUeNdsh/78e0qRAI90cj2MI5diR2198yhn/nTL+7B3/7gxwd70iDGAIh7ediXqBEb9m0Yk+cudJ3u7Q6zdOpCsCCQ9ok8r5gCJhHr8tuSOMneEERoKgWaY0m8X+pOShv1VTyJgAsBZCP5q5f6QCM8SuHP9v56XNCwyZdUvfufFT5epdTy6ACo153+fj2KOWdyor7R9VteH4vgB7AUiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(186003)(66476007)(8676002)(86362001)(8936002)(4326008)(26005)(508600001)(31696002)(66556008)(36756003)(38100700002)(2906002)(956004)(316002)(5660300002)(966005)(16576012)(66946007)(53546011)(2616005)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWEwUHBuSDhhNDlzZ2szc1RpV0piY0l4MTFrWEszeEdOV1lWdTJYUVFrNTBk?=
 =?utf-8?B?K096anpxSWJ2Wkh1b1ZpVHkySkpJOWhtRURwbjBDSFp3MkVneTNwRjgzVjF4?=
 =?utf-8?B?M3Y5b1NDcDdmUit1c2NNSWZpa1E1ZGhOck9NTzIxVmF4QlIweXRpRGh6d2pC?=
 =?utf-8?B?QkhmeU5xRW5FZFlOb052QVBKRW1QbFJ2VHhndE9DWGpxM1pjYmdKcUY2bFFr?=
 =?utf-8?B?QUp4alpFTnRmWVRFbHNhOUI3b2VQbmpaemxjUU9WdHl6WG90bHppdUhSLzI1?=
 =?utf-8?B?bmErdU9pTlVFa3pTdUZuaTdlVzVmWGsyYVFLcm83L2J3RHBPbVlvSVJIU3pr?=
 =?utf-8?B?VW94Q2hjb2dzaWswcHREb1pTVlVDN3Zad3puSDZWKzhjYmtxWXo3WGZzK1Bm?=
 =?utf-8?B?WU9lWC85MVN6b2VmaytlK2JqLzNRbXlWckdqSnpBQXFwdUpDbGtLbVZrQTZ1?=
 =?utf-8?B?SExTd01qL0d5MWV4NW5oOEM2R0lBUmZ1NEdjSktmZWhIcm9scUlQQ3RJblpT?=
 =?utf-8?B?Q0lPYVk2Q3BrU0sycS9odHdiVEt2SVlpaEp2SXkyNW1GRERRL3NrbkhlU1ZY?=
 =?utf-8?B?MFJxaHR4MjZvNmNXOE9KNGY2bDJzKy9PWSs5eUJ1K1ZUSE5ua0dwb1BDYzVN?=
 =?utf-8?B?ZW1kcjNrWm1uNEIyWndhRElYTjR6bExzYkZMOGxZT281NWdaQTRNL3NtRjNh?=
 =?utf-8?B?UjNYSlJYd0FUT3o4OXFSSnB3NUV3b2MyMEpEcUNCSjFlSmY2SFBoS1kxTklr?=
 =?utf-8?B?aWpla0NuZVBjYnlyVEVkWFhSbENyKyt3L2pqSUhUOVpsVWtwMTFYN0RhUk9R?=
 =?utf-8?B?NStCQ2hXTEhuWWhJN2E5SlNmdERGVC9TK0R5K2JNMnJ4b3hNeDFZTWpsRDVN?=
 =?utf-8?B?NGNWT2xsRHR0Szltd2pqMFk0MVE4VjdWQmxEOVI0R0NXQThsc0FTbTRLTnpS?=
 =?utf-8?B?b0N6bjM5cSt4Vy94M3N6U1c2RGZtYm96WUpiMWh6NDVzeXVDckM0eHpaOXBu?=
 =?utf-8?B?b3E1ancvZDh0QTdRVjdqaHJJK3VDMlFlclk3NzlVZDdaOCtHYWJyQ2lFanZD?=
 =?utf-8?B?a3dpS3ZLcktFbk42U0R2VmVZU3pveWZYOW15Uk40UlhtVEJFOTFKbDlPcytp?=
 =?utf-8?B?QytGZ3drWlEweWRiallDRjNsMEN4UThaZzMzczNMdWV2MWFmSko2K1VKMGM4?=
 =?utf-8?B?VHcwV0FxaGtjdXczSW13bFpyR3hTSmNVWW52Z05XcUNWRXNoOElZeUpMTmdR?=
 =?utf-8?B?THNGWHNybWZDbW9zMEkzWmVka2lRRTBxbmlKdGtUei9scHo5V0xWTGkvYklt?=
 =?utf-8?B?SHJpQ2cwY3k3UkdvQ3hpUW9DQVZ2bitkWGQvZ2dENzNKbkNTMFJWUUFKd05t?=
 =?utf-8?B?QVF3SFpVNjhnYnVCUktJcG9FdHdIaFVNMjYvWDNGTDNwZDNBU0ZneVlFQThB?=
 =?utf-8?B?ZDlWL0I4Q0gvUXFDZktiOWY4VEZ2R0tldGFHaXJQcTQxZVJ0aWU5S2E1WFFG?=
 =?utf-8?B?YkZIME0yazNSZEV4eGI2MVpMT3pnWFZLcGtFR0hUYTZBSW42NkNmUUNMM3lR?=
 =?utf-8?B?ZSsxaWNqa2liRkcrTm9yUDAxVjhpWnVmVCtaSmdBVFV1SXROL3BmZTN2U3B3?=
 =?utf-8?B?bDdqb3VyeGFBNk1zbk42K3BJMENYOCtUNEZHZEhqSHJyOCs1WFhRYzlzNFhs?=
 =?utf-8?B?MHVlQmlPKzV5QWpZRzJ0bGxwUXBHb2JKdTZPWEZ1Nzk4bnZ2OXhKTGEvTDRp?=
 =?utf-8?Q?EspBcVr1MuxXtPE3Hxnq2RQ+in3ZCEdGJzAHMI3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58499dca-a319-4cb1-a8a3-08d97eb15117
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 16:43:48.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em6HsjG9wIeVkVGjA3QEN1fac+wp6KWLdKpptKbLcDYyfaUq7xDBwXc6PYPkyPKB3/+VRXWDJ8RMTF7ae1JgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2005
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JfzQm634skxpB_SKS14rvqdPr0jHF8zu
X-Proofpoint-GUID: JfzQm634skxpB_SKS14rvqdPr0jHF8zu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_05,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/21 7:41 PM, Andrii Nakryiko wrote:   
> Implement strict ELF section name handling for BPF programs. It utilizes
> `libbpf_set_strict_mode()` framework and adds new flag: LIBBPF_STRICT_SEC_NAME.
> 
> If this flag is set, libbpf will enforce exact section name matching for
> a lot of program types that previously allowed just partial prefix
> match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, now
> in strict mode only SEC("xdp") will be accepted, which makes SEC("")
> definitions cleaner and more structured. SEC() now won't be used as yet
> another way to uniquely encode BPF program identifier (for that
> C function name is better and is guaranteed to be unique within
> bpf_object). Now SEC() is strictly BPF program type and, depending on
> program type, extra load/attach parameter specification.
> 
> Libbpf completely supports multiple BPF programs in the same ELF
> section, so multiple BPF programs of the same type/specification easily
> co-exist together within the same bpf_object scope.
> 
> Additionally, a new (for now internal) convention is introduced: section
> name that can be a stand-alone exact BPF program type specificator, but
> also could have extra parameters after '/' delimiter. An example of such
> section is "struct_ops", which can be specified by itself, but also
> allows to specify the intended operation to be attached to, e.g.,
> "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not allowed.
> Such section definition is specified as "struct_ops+".
> 
> This change is part of libbpf 1.0 effort ([0], [1]).
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issues/271
>   [1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

