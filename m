Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534106A5CD2
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjB1QKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 11:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjB1QKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 11:10:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E826CC0;
        Tue, 28 Feb 2023 08:09:57 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SFx11v007465;
        Tue, 28 Feb 2023 08:09:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZDFqMs1uFkjCOsWvCGf5GxjssAWJCx8QtYZ9St6iJ1M=;
 b=Red2/chxFF5lQtdhyeTtlwd/+RThwiLTJDnrTPwtM+b5XEBXX3knqYNZxmxa+T2y0MVu
 eZ/U5tOH46su5PkThe0RrRP7QZJQm0to0fgAuhL/OepaNhskg4UpJZEFRqyJvb+aCQJH
 aXa67MCak0ime5DZTaEtRedS/R/uf78uCrLd78dw7nWr/K58ba2QJkHK3oE1pk2ZPaa0
 xnBvRDc0ndc5ip29CMAF2zG/SitnED/nya/99gpNnFQbf4YKnAwZfGHR8b8wZrthnqY+
 iZFSyRdfh05GkiM3lfsvuexME7RqqVJ3g6nwpDSI6WAlfipRBwjP3OAFIm9mmB4unB8x Qw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p1jungxxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 08:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4DetmUFt5tpMSV8PvgN3qAIXk0NBjzsckEzZETLE9mGx8OcqFyAQB5rZ0SS+9M5DDx4A3MP3UeU/QV58+C1zM/NNoOLHj0swpoEvkf7/q0asKKKBtUNwnFjczcYuuGEamfJwsTANiZlFCqK571Uh8vgjNx2+/WWbKhxXXCSjBKfQhSDjGk8SuABm/a+gDcTkvWP6sIvnpXpHCXLBHp1C2r95nRAK4BlBWRmwHotxjtqo7LObtElSD0lI1pbU1DTPv5tASwlnWBa4zh/wCsg+QTYPU9k0j7UWY5qJ8YfogkgzPRF0f05kMaFi19OlSFmyaIRIavCadVrn9dimRJs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDFqMs1uFkjCOsWvCGf5GxjssAWJCx8QtYZ9St6iJ1M=;
 b=JUfowjv82ZYqSWSDUJ+s0fB97iKcEL1AKn6n1XqBd25k2QuuTOC92BFMR0zyCn+s+0oUxR6kTzJPa65+Qh7UyRHxdWwbf+fx5/bqki2G9xnzPF5AxzRjfCFQMxWmfTJg64oN/mG5f6w+56VEiytluY3sFMb61TEuF5oKJgG7dTxv+9RkMwQThIfK+K0R17a0UY2ap7ncdYVU6Auvo+j9BUgSPtKraVbZtEUVdM5H7AnaiH7IYRaWNFGhQLnywJ+ISp+fFPrc2Q5Q1DGPNwNBVGTnTctjEvOnhXLVyuMqHcEvG6yVYRnqmGSFAg7MPBRochA8pnCk0KSlb7hr+Pdg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5301.namprd15.prod.outlook.com (2603:10b6:303:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 16:09:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 16:09:31 +0000
Message-ID: <f8cba1b5-f82e-c74c-2eb3-25cc41110e45@meta.com>
Date:   Tue, 28 Feb 2023 08:09:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_cgroup_from_id() doxygen header
Content-Language: en-US
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230228152845.294695-1-void@manifault.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230228152845.294695-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3621cd-fd2c-4d8d-3a38-08db19a62d38
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXBH52W+Qb2mDnMVHjfzvAkzuXfaxAdX4g0hR8fIihOVYBN8SuYqz45NoMjSpNz6zgj2+CM4qc1qaDQHP5snxAqs1C75mUeN8jzHIPaCGvXdA2lQotjc/6XHY9Z3qNgauZdmO5HnKclJ39LJWPdgxeFiLfRGxu1ZRjkpYMhm1+XtJCOrw27BBk5lXUwxVKOOmZi60OC3MLmdCt/LdgsoFKH/NtDW37E3EyriPKwA94aBu95jgXMfzEa0mXfx6tzrIy7YMUPh35hrWrwRHHOPDFESKeCbm7iM88A0nbDaRnKb1ivKP3UvFgX2oxyXOi0/LRytPLoc6gfKzYjqmEHMsH37kKbumM8bx2pktAwXB4QqaB59cA/dPnxv31gWcHQK+aOsOwk0N5PbCw1zEvKEfI8d/MRk8kMhgwKZdohzH6A2zMba5TE7UZqPA2GNwZbuL6x7tq1Dv7/V8aGV7tz+GQxcM0Lt7TRLSNlsPbzdIt/oUHlRg9ktkIC2BgYZeXfXCZv7sf1+jrxRB84xeiBfCgftlvOGZ3Wba5wo37klZMR4/SOuC5pCm8k069NF1G0zQrYM1RAgArCa9Ck+5adWB+s6TFSdrliFrw9ztFMZn2LEvqlSskwBdgG4N3urXUSPCOeqWqI4Ng7xqvPZA/07rEmmWOX12f3FMFKtX5bSF3MLrAWnhJJF3RLb6U+cNgLNGpJNQZ0qa4ylBnTSkLGitw1ImXu/SJA7lNm2Cq+CMjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199018)(4326008)(6512007)(186003)(6506007)(6666004)(478600001)(2616005)(8676002)(53546011)(66476007)(6486002)(316002)(66946007)(31696002)(66556008)(86362001)(38100700002)(83380400001)(4744005)(5660300002)(41300700001)(8936002)(7416002)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9LZTd2bUk3Zm0wR1FVNEVCMGU1d0dac1Rjbm5LYllpMFc2eTBJZlhGUTg5?=
 =?utf-8?B?TWNtclFWWlRUbjZOaWs1Rk5BUmdwWFl3ZWlLNWJpVkl3SGdiNHF0ZlpTbms1?=
 =?utf-8?B?Y2drd29xUWdrMUFEUFQ3UHlNR0VWeFIzejE1Y1plR01kQXpIT012OFlKd1l6?=
 =?utf-8?B?Q0pHYlV0dnIzdTBGZGduTmdLaXNoNzZqT0ZXdlZ0dnFjdFFjbmdtWUhSLzk5?=
 =?utf-8?B?VVJLUHlyVWs5Z1UyYThodU16MnRiZEhWaXUwbVFrL040R0lCSzVtMmdNTWlz?=
 =?utf-8?B?MjFsaXM2N0ZTbUk1c3RkeGJKbDIrS2NCemRoZE1LM0RNaU00WHA1MmpNUmxH?=
 =?utf-8?B?c0luS2w0RVNQT1V4MmErVjZKYmdWMmd2cW5CL0pKY0VMYm92REZ3UlBuekpH?=
 =?utf-8?B?dll1N2FFbXNYZFdkc1VKTEUzWFBiSEdFdUR0SW10QVcwSWNkVkYxVUIwenNB?=
 =?utf-8?B?cTl0cEJJWmszTXg4akl0S2d3ZHJXTitHNTdDRUQ2K2luVkg2c0FtK2hZOEpI?=
 =?utf-8?B?dUgvZkpyc3lsMlYzQTZmT2NwMFExRHkyajNCSnA1azdiNzBWNWdPUUNLdTF3?=
 =?utf-8?B?eTc4WHhiRDlDelBRcDRMRFFjcWtXMTcwdGNYNWRLVlhQMlh4YWRCRERMV0RI?=
 =?utf-8?B?TU5pa1JNcHg0S1BPbXMzKzhNUmNFK2s1MG1LeGVvd0dqbDFDL0V6OU80ZWt2?=
 =?utf-8?B?cFZEOWwyOW93YnQySkJ5RkpKWXJ3NmpEV3N2VUtET1JhbzVoMnlSYXBuQ0FJ?=
 =?utf-8?B?bEJEbGlQUHV0U1V3WEQzL05oajVqOWdITHBETU8yaDRTcDBiS0VSSTFCZloz?=
 =?utf-8?B?L2hEN0xla0h3eGlSbG9BSWxoL01reUFyc1A3eUg0amQxdXFlVEdKYlZuMG8w?=
 =?utf-8?B?K3p1TjhnenkrQUlLOUtFa09lVWVFSXUyUEtFU1NMczlRbWN5MnExSlhBOUt5?=
 =?utf-8?B?VnRqOEx0azlNTWoxbEpZL0NKMVR1WGplQnpEQ2dxYlQrWjZkQXBTVVdZRTNX?=
 =?utf-8?B?aFFxbTEyNEs0OFlyOEN5NnhCbTJ5RVU1WUV5SW9hYkRTbDNOQWNZQzFhNm04?=
 =?utf-8?B?ajZ4T20zRytiWmMxQVEyUFpTckdzcUZZM1lqMjVsa3VZai9ic3JtQ3NwVFR5?=
 =?utf-8?B?Q0VRZ3V1amFYNVAwOTNmUjBIaGdZWHljNXZGRENieDhHcGtsYllUckpRZG5T?=
 =?utf-8?B?ZmdBM1luZGdaY015dGhxUXpUSFZwYkZPcGpKYmlJNGxBWkIrd3ptREpab0xK?=
 =?utf-8?B?czVzeG5zVlZBTVF0am9JVWxtUGxBcWNtcWViZTJ1UEoyZFhkTTgwVFFhWEMw?=
 =?utf-8?B?N084NVZYOUxrVFdKN2VZdVNGWG0rbnE5RXBOYlF6c21CK3plLzNheFZPSEp6?=
 =?utf-8?B?cFJTSytjaTM3ZnpPcjdPT09DKzUyNWtlSWZIMG9BakJuMFUrMTlEZ29LVGgx?=
 =?utf-8?B?bXpONGIxa3d3cGdLM0x0ZG9McEV3Z2VIS1AxZElKMENJT1dmMGcwNjYyd0ZR?=
 =?utf-8?B?MmxvQkRsWTlLb0Q4V1VXQmFxdVNQeXYza2dkaWJBYmhiSXFaNjVaL2tmaC9U?=
 =?utf-8?B?K2o4UVYyRjhLNjRxbHkydUZmOS9xbUdPdjhNQ2h0cW1XSEZYeG91TUtxeUNN?=
 =?utf-8?B?YmxxakhTVlN2NUhqRFgzWmRGUW9kVDY3NGV4MDVXRUdBUjFlMFlaWkJJc0VJ?=
 =?utf-8?B?RVpFTmZ2QlJ2UjcxdjVBRHlOVVRVZjJGYnhwY1VlRnRBYlFmV1J6Rm9pQ0xi?=
 =?utf-8?B?eVdFb2JhWTJKYlNRUnpCcmUvL0tDNmQySmtYNnhka3ozMlZMYUJtZHM4WEp6?=
 =?utf-8?B?N0Y4a1N6dGxUandvbUdWL0RPcExFai85bURBUG9ybFlCVmhaU2FQb0xSMFN0?=
 =?utf-8?B?MnBEbzM1dEJianNPV21EVVVWdnBrSlRKZ2FjM1g5blFEc2JzOFh4eTJxMVh0?=
 =?utf-8?B?RXc1YmxleEVUUUJhZWRRamxnNDc0ZEJlUjZQQzF6UnFsK3FPck5MbFIzKytu?=
 =?utf-8?B?Rkc0RjYwdEVQeW4zN3pxM0J0dHhTM29lQURseWtINXhpbS95NWgreWMveHV2?=
 =?utf-8?B?d3NEUzNOMXRYYU9sdXhoVWE2NGpXYUdNcDhYK0ZpVGtMMzhubXdJRFpsYkZG?=
 =?utf-8?B?QlVPSFg1ekFkOFp5VkpvaVcra0Yrc0l1NGgwVVIwVi9WMTFGZm8rSFdta3V4?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3621cd-fd2c-4d8d-3a38-08db19a62d38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 16:09:31.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvltHHC9AVE89bo3gRZ9k2b274CdFqYzErWpaQMSp4QYDS8d5moJkRdGfHq5+L0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5301
X-Proofpoint-GUID: KVf4CPz3awo9MANrqrm2v3CuRznGkE7V
X-Proofpoint-ORIG-GUID: KVf4CPz3awo9MANrqrm2v3CuRznGkE7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_13,2023-02-28_03,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/23 7:28 AM, David Vernet wrote:
> In commit 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc"), a new
> bpf_cgroup_from_id() kfunc was added which allows a BPF program to
> lookup and acquire a reference to a cgroup from a cgroup id. The
> commit's doxygen comment seems to have copy-pasted fields, which causes
> BPF kfunc helper documentation to fail to render:
> 
> <snip>/helpers.c:2114: warning: Excess function parameter 'cgrp'...
> <snip>/helpers.c:2114: warning: Excess function parameter 'level'...
> 
> <snip>
> 
> <snip>/helpers.c:2114: warning: Excess function parameter 'level'...
> 
> This patch fixes the doxygen header.
> 
> Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>
