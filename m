Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AEA66D6A0
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 08:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjAQHFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 02:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjAQHFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 02:05:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07590BB9E;
        Mon, 16 Jan 2023 23:05:45 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30H70pSx031655;
        Mon, 16 Jan 2023 23:05:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=24Ss++lBoQmebOrKM2MDp1xR1pDz+ZThcMPNrK9eXEQ=;
 b=GBy9tctnztzftSSMkyPt9gufif1Qjz4yVD01rwwq7eY5q+NaBk9vUqn9NB2ARYwp6qjx
 Au5+5TPCUJfP7kO9jReInRIGH/KqaoTT2D+E5GIpVEi292azI4SwiR/ZGlr78KxGcQHS
 H382wpbXgMcR/i1rEYzxVtqODxcmTqy1X/KyZ/29Y8GFlNzB1bk0aXGaavsJeor4QYJ5
 CLTZmQp+D4H9FzSJA0zPkuRZqKcXAAYWvIBg2UYb7Pfh4vRpIU6BrC4L6W4MjE8enRYg
 yB3qppN3EJP4f07foJH8eZ07lDs7san+grHGInazLL5Gqk7Ozmgg2jc3YNVnoFFlhqv7 7Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3n3ry4u3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 23:05:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTJ9cd2wYWZa6w5Q9Lwen6NU3r8vq7nKF+wA/WCNsvqBlDXJi4/Bg0RhPhJ9WhzpwKqK0qPPpq8HlsRg1xlrtExs/rmbzpCbhBlmXardGhxfUvMWg7QZyL4hCMnh9Cel3srq6EQRQTYIf5Nez5JO32OnO3cGhKfmRWWGF07ybrzuu/ZbQExE8YIf+S4W64MmrKuqg8oPo5dqVTQs/KT7UEuGVXvuHtvVWky8ePwFRRLoBwmOXFFhQDaU7FaIe40iIGilT6Yku329DFIT5d+BS8m7fYoB2oT3MxYB/muHxc5KAz9PopfFB6OUD2dTe0g12LyNfg3xYizRWxmK9SAcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Ss++lBoQmebOrKM2MDp1xR1pDz+ZThcMPNrK9eXEQ=;
 b=A1X3FULii5z0+pxfhmBgiVQMgem/6wHeEH9sE0AEBKWOGDwHbIzwngTIMQArfs6z3MwPR8HTA9PNWV8G+TupBW27TCytdE8qKrYowk4uN7aDbsYukzTDCyPhqROdp9P6hbaTDQSu2DNhH6PyYdz3FyS9CvWHULSQzDb42ojAiEQRToFzFe/oHPu8WJPHGu8FOvxjzDgJg3ADG2YU22Wu6Oj3dMFXRJ0Pm4BIqkl8U4HmYq3pvWDxN4apBMq9HsDzEufaWuCfUejLkKUxBu4zCcrCFD+zdmiyVWx5vbTYX7mffCaQ76165BwfYGpfjQVtJmw5+oZpdp7u3uQYn1kOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4231.namprd15.prod.outlook.com (2603:10b6:510:23::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 07:05:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:05:19 +0000
Message-ID: <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
Date:   Mon, 16 Jan 2023 23:05:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     Peter Foley <pefoley2@pefoley.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
 <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 60381fe5-c25b-4cb0-52aa-08daf8593141
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scCXCikE2w/OET8JsG5HhxXwoI2JkuVZrukSfn+ELXdXXsdw34dVDuwZbxnBu6eqyqLJDmK1Xqk0lFPj1EyYyiXp1p+CCrMGkreg2eP6vQ0iZCx1VQW8hCGSecbApYn5zteUfLla4v691baf6t+U9bWjRVSNlbvhbPkEMo8UANdys+Iv7V4JLoRRhaVgAB54kRmYgOg+W2XLlRB4DxKgQSFQBsB1B+zWMo8A85Uaf8aNM9XMvgJanFTmbmgpyJwnAduprl/aRQemic3vECvSC/G451KhEHXwuIpGXaKfe+orgHoyqxO64XHtNMfgXxHn5RpkGGYiWGkHfaoiC6p9xmmFWG0wVaVWgyfn4QGX40aimjjIDee6zqX6ovAv1tyjWWxWISv73+joOvHOwKHU1+I/+gw7fblkU5edoTPW5qIJCvBtBtyhnyK6wl/RW1b2CQQirUqiWmvkl2Q9g08dgm4STWgK1hrzUTmYUr41oFVlgqaWx1ZrVFcNd0VyJzYs8N0zorHRZxyMxJW4N8J5rdr10HbI45NlEFYFXO1mXSSfw9qZLwNSa9BWe/bbeUk9blsUjCCffRPn/MmECe42jOyZxRpuPkzp4M+MpgCuT2SdqiYkNdbfSJ7MUuABn4xH8pqHjn14NTVq+enAIwfbxmcrh8xQ29+eg8Ucn13eNr/fqli2x7GL1B+i8hE2qKgU8N17nmyICRcWWRBJM6Djde/fa0yvGDKfiVSYPDlZe1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(478600001)(6486002)(41300700001)(6512007)(38100700002)(66556008)(186003)(31696002)(316002)(110136005)(54906003)(2616005)(86362001)(66476007)(66946007)(4326008)(53546011)(5660300002)(36756003)(6506007)(7416002)(2906002)(6666004)(31686004)(83380400001)(4744005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldEVzFKOG11S01IUmJLQUM4Y2Q0MndZVzdFbVppZmJRQ3AvQkh5VkVodUhE?=
 =?utf-8?B?ejc1ckJHWkcreC8wWlRaM3RDT3FSVG4vUEpBYldKOU5FY2lxcm5jS0l0dG56?=
 =?utf-8?B?MC9mQW9lbkt6aGdFQ1Q4bDBxUEFoam5LeHlycXl3VFRzWTRwcWl3cmZHaml4?=
 =?utf-8?B?U2ZUbm85MWNoK1MwSVZqaVdxaUI2bVdndjFiV2ZrT3lHbkFzV0VEZVdFa2h4?=
 =?utf-8?B?NUt1R2g4ckFTWW00Tk12S3JReHlKd0ZuVGppeHFILzdkbW0zc1h5dVdrSXND?=
 =?utf-8?B?RW9jU3dDMGhmbDNvL3gwWWpWYzhPUElCdE1XTnB6QWkrcWw3dWd4alhISGsy?=
 =?utf-8?B?enVKUlVCL2Nhc0NjTFJTMW10dXloT2xXZTNVUjlHVVdtbjBPRjB6bHRqMXdG?=
 =?utf-8?B?K1RUZW1COXIrTkt1WWZjY2FSQ0J2SjhCZDgzQUtZaXBTQ0xIQ1hmNXcxOVBO?=
 =?utf-8?B?Zy83ZCtjdnB1K3BwZjNqQ3JTSmpVR0dFZ1BscEkzYjNOUHFHK2tMT0tZWDNU?=
 =?utf-8?B?QU1CSUxzaEJLQlU3c2VqOHhzWDVUcEoxTzQwbTZIMmEzSTlUODIwSGNPMXZQ?=
 =?utf-8?B?b3RCZllvR1RrZ3hpaWlTNk40ZkhYc3RENWVPUjFoQlBGOTlQNkZqU0lvL0lv?=
 =?utf-8?B?dlNyc3hWTDRvMjZkRGkzdlc0dHhDSnpROEhmZFRPYzAwUWZ2OEo1T3E4UVJW?=
 =?utf-8?B?SHhubGhiRzhvYVpCT3dvcWdVYzVReXkwRVBjd1dGbnRmS2dNeUNlOUNPK2pj?=
 =?utf-8?B?MHJUa3JDYU5ZZlh3Qk5NLzFBWFhyTklzeUdsMDNhMVR6N0FUTG9mblFKMWdM?=
 =?utf-8?B?RWdGVmdjUUc3cEhSRnpmN1k5RTV2OWNQcmpJZ2dLQjJ6R0Y3UGhkVjhuQjYy?=
 =?utf-8?B?b1Y2ZW54TDE1ZVZUVTJadWlZTVVsc0lGYW1xUkMvd3dhN3JSS0JMeGJ4VmJ2?=
 =?utf-8?B?emQwRllSTmQ0ak9ROURHd3hTYVVFdFdQeU9tMjRRWnlVR0VadGNYNWlJNFVS?=
 =?utf-8?B?NHdkL21kMVJiNTVWd0RYRlU1d2VvbzVXWHNLMnlkUWxJbHRGVm9PQ0lYYnpT?=
 =?utf-8?B?RDA5MHhMUGhCN05wakNYYzgxQjBtZG9RdGFPM0I4empwWE5HejR5ak1RTEtv?=
 =?utf-8?B?dXZncmxWa1FlNnFNczFMV0dRTDBJWGRtSnhlMC9na0V4WTFjOUhmOWx2NFJH?=
 =?utf-8?B?MXlFVlVFMkNmNURoQVlsYzVZK3h0eFVNd0c4ZHNkenN5eWlIeGZZMlEwaHZI?=
 =?utf-8?B?bllnRkFCMU42VUpRdlZPWGpRYjB0VEFUWjFmVXJ5MFJiN1VOWGRWQnpoUlVI?=
 =?utf-8?B?UUFaQVpPdGYxc3VqbFpWSG41UDlFTVpTaUdZRGFPRWZQcGVXSFpWZE1neFF4?=
 =?utf-8?B?Skp3d2J0SUtZT1Q2YU5MckNjYS9Ud21CaXZFdVZmVDBhVUtmWFVyM0J0UmpC?=
 =?utf-8?B?N09vTlo5cHhGV245Q3Jya29LZlVhOFFVOG0xMk82R3hUQUl6RTVraWFxT0RK?=
 =?utf-8?B?WVVPMEc0UmNsWHZJRXhMa3N5cDhuVitrTlljcDR2K2NuVVFsaWNiWFg4WTZE?=
 =?utf-8?B?T1BnMEN6WXVtNUc0eUw4RmpDcU1tdG1waVF4UktPRUNyRnUxc01GeXl0Qm1P?=
 =?utf-8?B?K1phWU81YVlwUThzNkpTeitySUlZaURtL211dXBlYVRESWNzNklTbVJDcU9K?=
 =?utf-8?B?T2Vuc1VtY1ljVFFQTkQvUm1NVzZzVHZEM0lPTGlJOWI5Q3BQbGw0R2xQd0JX?=
 =?utf-8?B?RmZ2OHhnZVQ5R3FGelU4YkdPa3VIUk9iMCswaTRJUHBNTFhEdUpLVVpYc1Rn?=
 =?utf-8?B?MEk4RU9SN1ZsVGYwMURQcUw5MW1FV1hPa2dRUCtVb2w4Q2w2YUNJQlYzWktp?=
 =?utf-8?B?ZWlCNGphbSsyM0xUWkw0TzRuSFI2dytiSUZrcytwM2hPQVdTK3ZqaFczclVu?=
 =?utf-8?B?MitRRlhxNnFHNXJMREJjL1JjT3hqTk9wUnJUazhJNWhMMFF2S3h1T0hwSnp1?=
 =?utf-8?B?MG1OUEk0cjZpRXZrUHUzd0V4VE9jRlV3a1IwQzNPRGczQlJnZXZyeEprSEtu?=
 =?utf-8?B?WFhXTGxXSFhNRCtjWXpSKzR1SWtPZDdOZk9jcWJIS09pdEpsQWlQRVFEU3Ru?=
 =?utf-8?B?R0FlUGNTUDVnTzhyMHU4cDdCaW9SdXR3M1hHRlRwSW5DS2RlRUJsMHpYY2hL?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60381fe5-c25b-4cb0-52aa-08daf8593141
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 07:05:19.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acareQfEaETFbs0JCZ7fWpX9eD7DPEYBdpn9hGSFUi59gSqGmMgsaJS1mYC2VuS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4231
X-Proofpoint-GUID: dzsUfWbzq5L0Kq-ULK1-Cdkmw7YGc7Yw
X-Proofpoint-ORIG-GUID: dzsUfWbzq5L0Kq-ULK1-Cdkmw7YGc7Yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_03,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/16/23 2:49 PM, Peter Foley wrote:
> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> A bit tangential, but since BPF LLVM backend does not support the
>> stack protector (should it?) there is also an option to adjust LLVM
>> to avoid this instrumentation, WDYT?
>>
> 
> That would probably be worth doing, yes.
> But given that won't help already released versions of clang, it
> should probably happen in addition to this patch.

Peter,

If I understand correctly (by inspecting clang code), the stack 
protector is off by default. Do you have link to Gentoo build
page to show how they enable stack protector? cmake config or
a private patch?

Jose,

How gcc-bpf handle stack protector? The compiler just disables
stack protector for bpf target?
