Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2173352422
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhDAXlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:41:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233677AbhDAXlE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 19:41:04 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131NLiUu029147;
        Thu, 1 Apr 2021 16:41:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rz3/sHOkEPB/YwbAdkXJTVoUzbolW5jFwtzkXJufEY4=;
 b=dGiizdxahXvYh8RmbCQGstkREbcm1QpKrNBO8Mpfyyjt0ALgav82KqHl+iAqG2lMK2Vk
 S3crcliWYcOv+8rhHIutNhK3mf6aZK/00nd5ZbQo+vs7vAFf5jcCVlZf9LyimEAITaCY
 p9fUlqsDqDqRATuJMETYUYxwFXbB4+17OsA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28y76y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 16:41:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 16:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxjJHddsM7Dqhsy9KlChg0HlPOT32GZqcvLTv1du3WhM+eBJtuDbR2hBXqSZfLKjiqiRFG18K8+QeTcUoaG+Q1RgrzdVVCj6tkvr/vX22fifX5b8lcqP9YqQqkRu0DLjsCvhkpAdrDigHndYnnh0CSzn/CxfDczQxOoPD79FlzzZKEQkrfJ9o+QMxhBsgY/9x+S/7bFh1SKPv3cm+BfANMTI8ZjOA6WV6fFRUSdzSWXL6Njhsd1vtifpB32mNh0uwVNGwnfzV6GgXit1z6ZSUWm/2whCmyEAVPMLThxqtWy11HB2JJLN/GIF+xn3PjowXHqyc2oc/mM1HEYlL/DoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCGT/BPGi8YyfKhR7yKhvsRJD/p3FysJNv5iu6uyKNE=;
 b=einYjHeEBQuDk0gStq/W2Bo7OuihCcElVoEsMVC2fh9X/CM+Wuv7rWkBnbORcMQ4mZTawti+pTaq09RK4uU34VQt+bypJMUP7IsF4C5y9Z0tW2oZbbyp86H1vW06fso7pyaUYFnkRSrGSqcTiGGYoiulrb/AgVoJHcQ7zGZ2SPUIfLjnDQJrbP8V/j1tLXmDFQsvH7PDNigQwX4ICIqdILF9b/HZ61+bjzBdCh8C3hgS1+N11WA/B6oSgZ5E99X3pv6nOPXvGNgV3TzzLmndadbvZkDkMarb8/KYUKVfhAK3vTqD6C7FY0ojLdJYUqclh5SavPWIcdZ0uDNAApR18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3917.namprd15.prod.outlook.com (2603:10b6:806:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 23:40:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 23:40:57 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     David Blaikie <dblaikie@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
Date:   Thu, 1 Apr 2021 16:40:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fb66]
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:fb66) by MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 23:40:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a279e790-d6e5-449f-fe79-08d8f567993c
X-MS-TrafficTypeDiagnostic: SA0PR15MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3917B5DAB06C91F305164A40D37B9@SA0PR15MB3917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sJd/JjQ/HqdvmL4cjMAgQCw24iwqfUOGIOOYjVEjdF4b1Yd1nQkY5JXuuqkWxwG2Q1rtFDmyOfoCjbyS33qV6f8dr5iGeamJjttPgftgFA0kA4U8xcRJp8yUr0Qkil3TuTk0niL6RdrEuQYB3ngFWp3O7U1Sx87XjMAX85W3UGGGAeVO+3zWSEx4vkp7kJbU8x4OAG1UCQlcX0nhfmVlfrBRZvbmRj37pQeFyliDZBjB5gDAeMDziZKtxvACOxqm3htKTjN4iK6C5y9cSFgThRZl+xbsP9Ju7XY8q3/oMKUW7LGCPphQZYB3GmR7JfsAIbOzwFIZflMXCt3pBPepmKj8BbzH5K2/EtXLe/0Et/62EiBGnT7KrOKvRB8q4WLX4jHPndGOmcjIwnut9tt/NU0o5aKO69h9KpCeE+N8x3hzGGHMxS5wV/iCpXFRgqSYMF7t7nPoIT4giOuUor+x+02U7a1Uf2f0Xw/GJs3izSoYG0SJpP9nDQ2kJ/S8qTwcPCkrBD38+044OkhsyPNa94B6/GA3fd2DZvM1KE1XqCvk4ae8zI7DIeDybj996C6OtcTbBvVLjG8DM0Cwn4zt2hps79vkJZOYbBrGuEnsVXMEALhbUmoRR3PvLImJhrXGCCyk0EkMLMZ9HUKi3pT6mfEICena6cxycyrJzTMTw0aIg7Ut+OauqHt1+u0eHs7px2hM3rB+LxC7wBIubTZFALac6HANZ8wAQo/Eyfxv2qqdNe7qKHw7FVC8NYT3Vp61nEqUOU/xWJWcJoPhydKLndKN63LTCdbzgS48rtIbOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(8676002)(53546011)(5660300002)(8936002)(86362001)(316002)(66556008)(38100700001)(83380400001)(478600001)(66476007)(31686004)(54906003)(66946007)(2616005)(6486002)(2906002)(31696002)(52116002)(36756003)(4326008)(186003)(16526019)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MytHRWord1lJdjJBWVFBRnk0ekd4cnc3ZTRxbnZsVXZldVNLVk5ZNHVTbWRK?=
 =?utf-8?B?OUdxTmNMYzRFWFJoUXhzZDdQbjZadmkxTmgvRzFLNTRQZEpRcVZiblJ4aXdI?=
 =?utf-8?B?bHQ4R2JSNDU0US9ESitvdTY3bWQwWFd4WG1kd0hRNVMwcHg3dGpNbmlLWmlO?=
 =?utf-8?B?d0ZRTDMyY21MUXV3SDRYa05WM0tnRXRmMzc3OHdMUjFLVHh3YUxXd2UvaTNK?=
 =?utf-8?B?K3lxa0EzcVdZUFlOckJqbDhnZHlueCtiT1dzVkhpOXJmTGQ0bmpieU96NjJW?=
 =?utf-8?B?ODF5NU1NTCtUWVNvakRLTnB1UE9sOHVTYWwvaDZ3MjJHMk02Ryt4Wm9HNkZu?=
 =?utf-8?B?TG9yY21yN1VJenZTUnBzWm1nQUtHRHl3ckJHQ1VQNmRoL1Y5dDluQjlWb2ZJ?=
 =?utf-8?B?NCtkeFc1TE5HSms0UURadk1xbHhsQ2U3S2hFVXZUM2pqOGs5QldKTzRoZmYx?=
 =?utf-8?B?ZmlVN3hIclZEMU9UdHkxUjJjbGFVSHZYQlh3eThQMmErREdkczlEeU9ZVmh0?=
 =?utf-8?B?VWF0ZXpqcjhmeTljaHBzN202SGtvZUw5dkxjYlpFS3Q2cFZpMzhEb1N1WlJE?=
 =?utf-8?B?UEdBT2ZPSFpzZ3ZJOEdVMjNRMXdyZS96cEc4cGhmZi8vc1Q2Sjkxd0JiUDRP?=
 =?utf-8?B?dkJKS0NOeEtZQWpwTWFJVHNmcmhIQWs1bGl6dFBiWFczRFlyU1ZNTXgxOHhQ?=
 =?utf-8?B?V0NQZ3JBclU2KzAxaFVjQmRnYnBMcDRXS1JVZjFoUDBOYUl5MEl4azJMdTlw?=
 =?utf-8?B?KzFsT0hkWEtzSGVYMlJxK3ozMmJqYklNRndwOEZFR2dWNEdKb3haM0RyVEpi?=
 =?utf-8?B?NC96Y0VVNEdvME9GQTlpU1pMTDN1RXBNWWNzNXphY2xGM3FudkFxa3J1OXM4?=
 =?utf-8?B?ZWZpcFczSVdRYWRDdTNQQmhveEkwNlUva1NHSXBzZGQ4R2RyWmJoMUNvMDNy?=
 =?utf-8?B?WEpVbVV5T2ozV1VSTkdjTW9uZlFqRWRqTWdiSzEvZXdPVE5CaDY5RUdTR3lE?=
 =?utf-8?B?RVhoS00vMzVVb0xTR0lVb1FrZ3JIQkFGUU9OK2N5SXdEOFdmVnRCdmRMTzg3?=
 =?utf-8?B?aWFnQjc0TDhEb0tua0NuMWt4S1l5ck1vdEJYWmYrOVNBdWRhUndXaTFGUVRx?=
 =?utf-8?B?RTBLVVlBMmtYZEdlbjI2TWQ1cTIza1VKSFJ1QzNScVBmbllkcEdWN2ZYUVhs?=
 =?utf-8?B?bVhTOVl0MXEwN3pFY25zWng5MEJmZWF0SDViSGJuUGlsZWRGc0VieDJQbksv?=
 =?utf-8?B?dUZBNWduQmV6MzlmR0Q5VWlsL0o1ME1VYmR4aFBWVGcwSHZMQk82MHVic1hZ?=
 =?utf-8?B?VkpsVUlyUVRaODJSZDJSdHhPL3pLWEtzaFdscVBJQ2c2STlRdlR1aER1MlRM?=
 =?utf-8?B?eTBJNU0wRTB2emQ5b1lmSWZxZHVUR0o0TzJ3K0NPSTYyS0lmRUhjbGt5QVhn?=
 =?utf-8?B?Z2ZaUmZsenFUcW1ZZEU3K0ZwTlp1V29nMmlJNkQySWlwMnkvMy9mQUlxY3k4?=
 =?utf-8?B?a2cyL2NpU2x5dXJoOGkrWUpRWk5wS0hPcWJnL3dxNlBHdFkwUTExUUVZMklk?=
 =?utf-8?B?TGhzUERHUEc2Q094d0h5OG9GSWpnZGVxQTNDNkZvV1Mrc0R0Wm1rOGNLTk9O?=
 =?utf-8?B?MVlkT1VZK3VTWEZCZHRiN2N3VEkyRTI3d1FsZW9ySFpzTC8xT0t1b2ROZ2Mr?=
 =?utf-8?B?L1JMa1NQU1AzNFVOOXZ5TDM2VVM3d1pRdGd1MCtQaGsrNTFsYUJqT09abno1?=
 =?utf-8?B?YU5MbjlncTR0dG56WXFmNGJnSmtHeGw4emxtbjhBL3p6SUxET09meCtDS1Fa?=
 =?utf-8?Q?3+om42dQpSz5GruSWrfSlpWON/h7AjlEH6czo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a279e790-d6e5-449f-fe79-08d8f567993c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 23:40:57.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SOvsHWx3VLqLNNDCwuqfxmmd/sqJrQDuhobskIXexuC/j0O/xPjtkiVIQb9Jsfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3917
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jLfrPH7elMYNjPhM32lGYjyAgauFOv9l
X-Proofpoint-ORIG-GUID: jLfrPH7elMYNjPhM32lGYjyAgauFOv9l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_14:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/1/21 3:27 PM, David Blaikie wrote:
> On Thu, Apr 1, 2021 at 2:41 PM Yonghong Song <yhs@fb.com 
> <mailto:yhs@fb.com>> wrote:
>  >
>  >
>  >
>  > On 4/1/21 2:36 PM, Yonghong Song wrote:
>  > > With latest bpf-next built with clang lto (thin or full), I hit one 
> test
>  > > failures:
>  > >    $ ./test_progs -t tcp
>  > >    ...
>  > >    libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23] 
> incompatible with kernel [115303]
>  > >    libbpf: failed to load object 'bpf_cubic'
>  > >    libbpf: failed to load BPF skeleton 'bpf_cubic': -22
>  > >    test_cubic:FAIL:bpf_cubic__open_and_load failed
>  > >    #9/2 cubic:FAIL
>  > >    ...
>  > >
>  > > The reason of the failure is due to bpf program 'tcp_slow_start'
>  > > func signature is different from vmlinux BTF. bpf program uses
>  > > the following signature:
>  > >    extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
>  > > which is identical to the kernel definition in linux:include/net/tcp.h:
>  > >    u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
>  > > While vmlinux BTF definition like:
>  > >    [115303] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>  > >            'tp' type_id=39373
>  > >            'acked' type_id=18
>  > >    [115304] FUNC 'tcp_slow_start' type_id=115303 linkage=static
>  > > The above is dumped with `bpftool btf dump file vmlinux`.
>  > > You can see the ret_type_id is 0 and this caused the problem.
>  > >
>  > > Looking at dwarf, we have:
>  > >
>  > > 0x11f2ec67:   DW_TAG_subprogram
>  > >                  DW_AT_low_pc    (0xffffffff81ed2330)
>  > >                  DW_AT_high_pc   (0xffffffff81ed235c)
>  > >                  DW_AT_frame_base        ()
>  > >                  DW_AT_GNU_all_call_sites        (true)
>  > >                  DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
>  > > ...
>  > > 0x11f2ed66:   DW_TAG_subprogram
>  > >                  DW_AT_name      ("tcp_slow_start")
>  > >                  DW_AT_decl_file 
> ("/home/yhs/work/bpf-next/net/ipv4/tcp_cong.c")
>  > >                  DW_AT_decl_line (392)
>  > >                  DW_AT_prototyped        (true)
>  > >                  DW_AT_type      (0x11f130c2 "u32")
>  > >                  DW_AT_external  (true)
>  > >                  DW_AT_inline    (DW_INL_inlined)
>  >
>  > David,
>  >
>  > Could you help confirm whether DW_AT_abstract_origin at a
>  > DW_TAG_subprogram always points to another DW_TAG_subprogram,
>  > or there are possible other cases?
> 
> That's correct, so far as I understand the spec, specifically DWARFv5 
> <http://dwarfstd.org/doc/DWARF5.pdf> 
> 3.3.8.3 says:
> 
> "The root entry for a concrete out-of-line instance of a given inlined 
> subroutine has the same tag as does its associated (abstract) inlined 
> subroutine entry (that is, tag DW_TAG_subprogram rather than 
> DW_TAG_inlined_subroutine)."

Thanks. That means that some of my codes in the patch is
dead code.

> 
> Though people may come up with novel uses of DWARF features. What would 
> happen if this constraint were violated/what's your motivation for 
> asking (I don't quite understand the connection between test_progs 
> failure description, and this question)

I have some codes to check the tag associated with abstract_origin
for a subprogram must be a subprogram. Through experiment, I didn't
see a violation, so I wonder that I can get confirmation from you
and then I may delete that code.

The test_progs failure exposed the bug, that is all.

pahole cannot handle all weird usages of dwarf, so I think pahole
is fine only to support well-formed dwarf.

> 
> - David
> 
>  >
>  > Thanks,
>  >
>  > >
>  > > We have a subprogram which has an abstract_origin pointing to
>  > > the subprogram prototype with return type. Current one pass
>  > > recoding cannot easily resolve this easily since
>  > > at the time recoding for 0x11f2ec67, the return type in
>  > > 0x11f2ed66 has not been resolved.
>  > >
>  > > To simplify implementation, I just added another pass to
>  > > go through all functions after recoding pass. This should
>  > > resolve the above issue.
>  > >
>  > > With this patch, among total 250999 functions in vmlinux,
>  > > 4821 functions needs return type adjustment from type id 0
>  > > to correct values. The above failed bpf selftest passed too.
>  > >
>  > > Signed-off-by: Yonghong Song <yhs@fb.com <mailto:yhs@fb.com>>
>  > > ---
>  > >   dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  > >   1 file changed, 46 insertions(+)
>  > >
>  > > Arnaldo, this is the last known pahole bug in my hand w.r.t. clang
>  > > LTO. With this, all self tests are passed except ones due
>  > > to global function inlining, static variable promotion etc, which
>  > > are not related to pahole.
>  > >
>  > > diff --git a/dwarf_loader.c b/dwarf_loader.c
>  > > index 026d137..367ac06 100644
>  > > --- a/dwarf_loader.c
>  > > +++ b/dwarf_loader.c
>  > > @@ -2198,6 +2198,42 @@ out:
>  > >       return 0;
>  > >   }
>  > >
>  > > +static int cu__resolve_func_ret_types(struct cu *cu)
>  > > +{
>  > > +     struct ptr_table *pt = &cu->functions_table;
>  > > +     uint32_t i;
>  > > +
>  > > +     for (i = 0; i < pt->nr_entries; ++i) {
>  > > +             struct tag *tag = pt->entries[i];
>  > > +
>  > > +             if (tag == NULL || tag->type != 0)
>  > > +                     continue;
>  > > +
>  > > +             struct function *fn = tag__function(tag);
>  > > +             if (!fn->abstract_origin)
>  > > +                     continue;
>  > > +
>  > > +             struct dwarf_tag *dtag = tag->priv;
>  > > +             struct dwarf_tag *dfunc;
>  > > +             dfunc = dwarf_cu__find_tag_by_ref(cu->priv, 
> &dtag->abstract_origin);
>  > > +             if (dfunc == NULL) {
>  > > +                     tag__print_abstract_origin_not_found(tag);
>  > > +                     return -1;
>  > > +             }
>  > > +
>  > > +             /*
>  > > +              * Based on what I see it should be a subprogram,
>  > > +              * but double check anyway to ensure I won't mess up
>  > > +              * now and in the future.
>  > > +              */
>  > > +             if (dfunc->tag->tag != DW_TAG_subprogram)
>  > > +                     continue;
>  > > +
>  > > +             tag->type = dfunc->tag->type;
>  > > +     }
>  > > +     return 0;
>  > > +}
>  > > +
>  > >   static int cu__recode_dwarf_types_table(struct cu *cu,
>  > >                                       struct ptr_table *pt,
>  > >                                       uint32_t i)
>  > > @@ -2637,6 +2673,16 @@ static int cus__merge_and_process_cu(struct 
> cus *cus, struct conf_load *conf,
>  > >       /* process merged cu */
>  > >       if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
>  > >               return DWARF_CB_ABORT;
>  > > +
>  > > +     /*
>  > > +      * for lto build, the function return type may not be
>  > > +      * resolved due to the return type of a subprogram is
>  > > +      * encoded in another subprogram through abstract_origin
>  > > +      * tag. Let us visit all subprograms again to resolve this.
>  > > +      */
>  > > +     if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
>  > > +             return DWARF_CB_ABORT;
>  > > +
>  > >       if (finalize_cu_immediately(cus, cu, dcu, conf)
>  > >           == LSK__STOP_LOADING)
>  > >               return DWARF_CB_ABORT;
>  > >
