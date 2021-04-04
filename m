Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F53538DE
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhDDQkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 12:40:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbhDDQkQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 4 Apr 2021 12:40:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 134Gc2t1010516;
        Sun, 4 Apr 2021 09:40:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lTTU0/3PgWR0P9G47lkjisXat6gJaGuL2qg9K/DZbQc=;
 b=c1mCBmP5NZi6nHfAcbZcQTCdPROaOGpwKFUCGHG5dKsx1JZWWGf4GbSZ8vwPIVnnYwYh
 nKpXmyleFg2lfLw7BVpsMz16v8LHON5g2IJwvv6E7o6QqPH2mGxtP/VIjiA0hGBpzEU8
 Tv5K0SqpY8awMCwuHJORyX9OWeXbv8omhkI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37qbn3rwex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 09:40:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 09:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDK7KunPzN3yJhp0fY0XgpK9vVti5fCbj1TpMcjO+oCHGsgN/eIR/FitHzBqipOIDB7GojmbMnSSR44QGOm3uyfj1Nsuc1AaYUkFD7wN4jWzASGn/MppyhWUleCbY2cubMxLRb6TZtpzYlD1o+poDsuWSuw4g3XCMS5XZbyAtF9ZV0e4s3qjizM00V6O647PLMR9D6ke6V6iSH3m+P527h4RfV6blFnUFI2mOrW9WBCRUZ5N3jAFEaJaSiX7SmGAcOdIitJp5zH6/3ty/1mCNsrR4qdxp1ymZb0Taeo660mBwcvFOWe4Qz7t54n2RzQt7zqPW16RLoNcBBac/fPP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTTU0/3PgWR0P9G47lkjisXat6gJaGuL2qg9K/DZbQc=;
 b=jMta1TywOXvp66LGgtyAEGN2pmTbjFh/XsOftH9J3vF+tPTzXOeXb1ePVWFa3My4cQwdWI3aJBTz5RnmZn6zz7CRYSrrqKZN3ROMtHgqYr2+MH5OaqcluFccBDGW8aPg8MaVr+3oABO++aa1sSzkACMn5hZAGtOg3iVPj+Motd0DqCU8Hz5jzoa+Y067bWw7yufMBLKa/JDXiitEupMjwH8TVSoez/kmaXT1nbCv4me1ZeUPHwCECX3G+W7apF+CzZLB3jNQbvyCai9JZwLOTQ3ENvv7UN4Xllz7vDokUhqe1jD5SBvZUjh5++HM95gFicWyLHzkkg8aruRXpbNMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2286.namprd15.prod.outlook.com (2603:10b6:805:1f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Sun, 4 Apr
 2021 16:40:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 16:40:02 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com>
 <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
Date:   Sun, 4 Apr 2021 09:39:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c996]
X-ClientProxiedBy: MWHPR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:300:ae::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10a5] (2620:10d:c090:400::5:c996) by MWHPR14CA0019.namprd14.prod.outlook.com (2603:10b6:300:ae::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Sun, 4 Apr 2021 16:40:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938aadea-3c34-4dae-d70c-08d8f7884b69
X-MS-TrafficTypeDiagnostic: SN6PR15MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2286961DD99822E1C8106D29D3789@SN6PR15MB2286.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxvBPH6oQ6/1KiXACTh+yep2pfxvFjM3VFh5NAnJ1fqxRiPqmQgtHxdZL53iTb3ogXfgt60jgXRsLyqNdpAk4YqAdO5KDZeDmCMtlHdUnTedkRGAnLZJeetJhDIv6L//e+/oQEEdcT74T34MjvpDCVM9Bp/omYK1detUB+OTnrcoJt3OSB4ktBnBEh5zZs8AihcyfMHSam6E1+Ab+A7OwufRamNTZbFkQkLTkLBxrDLPFRTYcAfVeTZjySnUVUOVfFJR2H/FrPgJZYwUHW6wViH5fBjW70GtuW+DLL+SdUn2DfoU8Jv49+FmKEKmHf6aB0+lqeLEfE6fWRHov0kefSj4Ubn4FgZ2Jv2ncCeq6kHxzWnkEnCT8TTuiT/NjPqSbibbxzdtD5fZGN+kIz3QU5sHUHcqOWKSwwv1qNdqXLT4wqdaXoORM87hsDwa9V6fMjkqxDcTRF6WzkVlyAnFYCmIWf+oycjdssBgxGjWlKT7axQBvz225/wdU9dT5X1lKIbOY/h6/3B9IVwPhyE9sJ8E8+TQH29JLWYXvdsFQvaILHlsWmirhf+Tsm02xXdC4t/PgjrvsNnEsLDmpWPb+uUksPq65Xgj4N2CCDTOhpShXeFRfV+c5QTDyhdrAYsl43AzvUhp6Rok6bME0P0SE6C3jq/4jEB+vQD4cfKJ6NnpCI94CQjoVTjeo+Rol65yP73mGQs93T41ajRlZp6yQP9MpJDE4MjZECfgKGg46NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(86362001)(38100700001)(54906003)(53546011)(31686004)(31696002)(4326008)(2616005)(316002)(6916009)(6486002)(36756003)(66946007)(5660300002)(16526019)(66556008)(186003)(8936002)(2906002)(966005)(478600001)(8676002)(66476007)(83380400001)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OHJtbGxVd0hqd2JoT1dNNGppaVZkR3c5SHAzUVpvRWV4bnd5TVY5TlhNYThx?=
 =?utf-8?B?OHRTR1loRXRiYkpITGxHK2IwTlhZejlZYzVTTWFRTzdZLy9nQmhYc04vK2ZK?=
 =?utf-8?B?U2tidjh6aGFyZ25NaW1qbVM4ckliN3U2MzcxNHBwNjF4YVdPZ3RiWm1aQUJ6?=
 =?utf-8?B?cTlxMTZWT3RoMGNRYzh4M0VwUWVacE5ub00wQldGaEdMT2pqbHJzTWh3b3N4?=
 =?utf-8?B?cHhhMmpFRlFPM0l4RFZLbjNlVUQ1R1hQaTVKaVlRVEEyckpvOWNaUjU5cFB2?=
 =?utf-8?B?ZUNoOGpSSnVTRGFVL1NZTjV0SHBacStYaU12WFBBODFrZ2NZSmxycWRrQU9u?=
 =?utf-8?B?b0lyWnphcndvZUpOcWgzbWhVVlBvK3Z5YjJGSFF2anVZNFJQelc4N00wbXZp?=
 =?utf-8?B?V1lmelA2ekZ6TUE5aUw3Q1RQYlVCZC8vbFlPZ3VscXliRjcrbC96VXJoYUE4?=
 =?utf-8?B?ZnhDUDc0TEdrSEt5T2NyRXNtaHZFQ3dLMXFXRldMRGtkazNoZTV0RitveVBU?=
 =?utf-8?B?V2xicUJka0hkaWMrSTZnaGlZVCtBem5FMXJCdGNINFFEcy9uSFdjWk1lTVhm?=
 =?utf-8?B?ZTVRVkQzZEVrTkVoZDRCQ0MrZkQzNkRCbzhkZmRHWncrSVFvMEoxNjdpNWJK?=
 =?utf-8?B?dGcxOHZuVmdPRFNGeXM0ODlubUYyN2JHRmF5N2llY1N1SU1HTTJkdEN2TEhk?=
 =?utf-8?B?bFltYy90UVRtVTNjcWdnWWFwNk1yeVdMcTM3Ny9ldm5kWXc5aTN2Ykhxa1dV?=
 =?utf-8?B?YmFGSjlENit5cktxNjNneE9uYTVCZEEwRU9jVVcyTU9uUXNpTFYxZHJOM0JH?=
 =?utf-8?B?RFZiL1NOR1VaZ3lZWWVhZXdsa3k1YUhaaWpRY2drU2k4NllCQXlST0hYbVkw?=
 =?utf-8?B?cnhJaE0zdU5NUUFzOXZIN3JtQ2hBYXRKM2V3Vll5ZU9SSzIvbmN2V3ZCMTZJ?=
 =?utf-8?B?djdOc0g1Z0x4MzVGOVkrSGF1bmNWZzJMc2JyL0xxR25qVDYwS2szS2RpcExz?=
 =?utf-8?B?cUxJcG9LSXo0YVZXYTc4bTE0UWNOUHRUZkxCS05Va0VWVFFRR08vYkJkNDEy?=
 =?utf-8?B?cmpGKzh5aTRpaHlLYzliVVRxeWIxelJ2cVVPV1VWY0NRRGRJM0k2VExlNXRw?=
 =?utf-8?B?OGVsdHZFU29iWCtDQ1FaYkJzNzB5YWlxM1ZvSG5KVXZCSC9ua2Z4dW5oakNG?=
 =?utf-8?B?VzRleEVOSW9OblJlOVY2Ni9mWDFqek81Wi80WUlNd1VsMlgzWUdnRTNZVGJX?=
 =?utf-8?B?eWwrbFREMHVxdjk1aUtTR3hWeHpiSHdiOS9aNHl4UFpWWTFNaFhRaExnRnE1?=
 =?utf-8?B?WHFPU1FzM0hVa2RWMzg4dkQ2RHk2ZVcybm1uRy9xUlcwMDAyMTV1R09YcjJ0?=
 =?utf-8?B?aGxhL0xNUzlnYzRtRCtGU1h6Q1RyRlEzVTZFREJjT0p3aHhKQXlmNjc3VVAx?=
 =?utf-8?B?b1V0a0gzZ2tKQnhISmRxQWFNRE1rdXJLNzNEQmhJTDF5dGs1akQxNlovMkZL?=
 =?utf-8?B?ckhZeEtLVU1IYXd4TmVUU0ZHZlUrN0IxSUhZY2RrNFJwZHdsd0wwVTZtSVlN?=
 =?utf-8?B?VkFhRGxqMDdkZ2lXRVhtR3AxTW80dFloalZWWGsrb0M4WUpEdDBnTXZENVZp?=
 =?utf-8?B?SnFWclpGK1gxNkFkK1VNMHhEYTk4ZTNoT3l4VC9qUi9paE15MGNJYmlJYkhG?=
 =?utf-8?B?Q3pRZUVJQlZLRjdYWXlzV29VeVM0WXVIbnhhZ0FoWC9XTVZZVkUweERJRmVs?=
 =?utf-8?B?SFBEdzYzcktCWHZzNUttTDBoaEdZUk5OVjBGWXZtK0g1ZHpZZ3p4MTFKeEVI?=
 =?utf-8?B?eS9PNE9EK2VYRnFyZnFuZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 938aadea-3c34-4dae-d70c-08d8f7884b69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 16:40:02.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOAEDakSPicakf9lODCpTm/WLJSu+P/o+tQ7VTPelLgzx9zQVa7/c2JNlMXkyM7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2286
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: tS3CkT1e4spYi4gg3HGO7xmnvGk44C5B
X-Proofpoint-GUID: tS3CkT1e4spYi4gg3HGO7xmnvGk44C5B
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-04_05:2021-04-01,2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/21 5:46 AM, Sedat Dilek wrote:
>> This shows a new build-error:
>>
>> clang  -g -D__TARGET_ARCH_x86 -mlittle-endian
>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
>> -I/home/dileks/src/linux-kernel/git/tools/t
>> esting/selftests/bpf
>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/usr/include
>> -idirafter /usr/loc
>> al/include -idirafter /opt/llvm-toolchain/lib/clang/12.0.0/include
>> -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include
>> -Wno-compare-distinct-pointer-type
>> s -DENABLE_ATOMICS_TESTS -O2 -target bpf -c
>> progs/test_sk_storage_tracing.c -o
>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_sk_storage_tracing.o-mcpu=v3
>> progs/test_sk_storage_tracing.c:38:18: error: use of undeclared
>> identifier 'BPF_TCP_CLOSE'
>>         if (newstate == BPF_TCP_CLOSE)
>>                         ^
>> 1 error generated.
>> make: *** [Makefile:414:
>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_sk_storage_tracing.o]
>> Error 1
>>
> 
> I was able to fix this by adding appropriate enums from <linux/bpf.h>.
> 
> $ git diff
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> index 8e94e5c080aa..3c7508f48ce0 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> @@ -6,6 +6,28 @@
> #include <bpf/bpf_core_read.h>
> #include <bpf/bpf_helpers.h>
> 
> +/* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> + * changes between the TCP and BPF versions. Ideally this should never happen.
> + * If it does, we need to add code to convert them before calling
> + * the BPF sock_ops function.
> + */
> +enum {
> +       BPF_TCP_ESTABLISHED = 1,
> +       BPF_TCP_SYN_SENT,
> +       BPF_TCP_SYN_RECV,
> +       BPF_TCP_FIN_WAIT1,
> +       BPF_TCP_FIN_WAIT2,
> +       BPF_TCP_TIME_WAIT,
> +       BPF_TCP_CLOSE,
> +       BPF_TCP_CLOSE_WAIT,
> +       BPF_TCP_LAST_ACK,
> +       BPF_TCP_LISTEN,
> +       BPF_TCP_CLOSING,        /* Now a valid state */
> +       BPF_TCP_NEW_SYN_RECV,
> +
> +       BPF_TCP_MAX_STATES      /* Leave at the end! */
> +};
> +
> struct sk_stg {
>         __u32 pid;
>         __u32 last_notclose_state;
> 
> NOTE: Attached as a diff as Gmail might truncate it.

This bpf-next commit:
   commit 97a19caf1b1f6a9d4f620a9d51405a1973bd4641
   Author: Yonghong Song <yhs@fb.com>
   Date:   Wed Mar 17 10:41:32 2021 -0700

     bpf: net: Emit anonymous enum with BPF_TCP_CLOSE value explicitly

fixed the issue.

> 
> [ Q ] Should these enums be in vmlinux.h - if so why are they missing?
> 
> Next build-error:
> 
> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
> -I/home/dileks/src/linux-kernel/git/tools/lib
> -I/home/dileks/src/linux-kernel/git/tools/include
> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> -lcap -lelf -lz -lrt -lpthread -o
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> relocation R_X86_64_32 against `.rodata.str1.1' ca
> n not be used when making a PIE object; recompile with -fPIE
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:455:
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> Error 1
> make: Leaving directory
> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
> 
> LOL, I was not aware that there is usage of *** CXX*** in tools
> directory (see g++ line and /usr/bin/ld ?).
> 
> So, I changed my $MAKE_OPTS to use "CXX=clang++".

In kernel, if LLVM=1 is set, we have:

ifneq ($(LLVM),)
HOSTCC  = clang
HOSTCXX = clang++
else
HOSTCC  = gcc
HOSTCXX = g++
endif

ifneq ($(LLVM),)
CC              = clang
LD              = ld.lld
AR              = llvm-ar
NM              = llvm-nm
OBJCOPY         = llvm-objcopy
OBJDUMP         = llvm-objdump
READELF         = llvm-readelf
STRIP           = llvm-strip
else
CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
READELF         = $(CROSS_COMPILE)readelf
STRIP           = $(CROSS_COMPILE)strip
endif

So if you have right path, you don't need to set HOSTCC and HOSTCXX 
explicitly.

> 
> $ echo $PATH
> /opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
> 
> $ echo $MAKE $MAKE_OPTS
> make V=1 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 PAHOLE=/opt/pahole/bin/pahole
> 
> $ clang --version
> dileks clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> 04ba60cfe598e41084fb848daae47e0ed910fa7d)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /opt/llvm-toolchain/bin
> $ ld.lld --version
> LLD 12.0.0 (https://github.com/llvm/llvm-project.git
> 04ba60cfe598e41084fb848daae47e0ed910fa7d) (compatible with GNU
> linkers)
> 
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
> 
> This breaks like this:
> 
> clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftes
> ts/bpf/tools/include
> -I/home/dileks/src/linux-kernel/git/include/generated
> -I/home/dileks/src/linux-kernel/git/tools/lib
> -I/home/dileks/src/linux-kernel/git/tools/incl
> ude -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -Dbpf_prog_load=bpf_prog_test_load -Dbpf_loa
> d_program=bpf_test_load_program test_cpp.cpp
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> /home/dileks/src/linux-kernel/git/to
> ols/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> -lcap -lelf -lz -lrt -lpthread -o /home
> /dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> clang-12: warning: treating 'c-header' input as 'c++-header' when in
> C++ mode, this behavior is deprecated [-Wdeprecated]
> clang-12: error: cannot specify -o when generating multiple output files
> make: *** [Makefile:455:
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> Error 1
> 
> OK, I see in bpf-next includes several fixes like:
> 
> commit a0964f526df6facd4e12a4c416185013026eecf9
> "selftests/bpf: Add multi-file statically linked BPF object file test"
> 
> ...and to "selftests: xsk".
> 
> Finally, I was able to build by suppressing the build of "test_cpp"
> and "xdpxceiver":
> 
> $ git diff tools/testing/selftests/bpf/Makefile
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 044bfdcf5b74..d9b19524b2d4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -77,8 +77,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
> # Compile but not part of 'make run_tests'
> TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> -       xdpxceiver
> +       test_lirc_mode2_user xdping runqslower bench bpf_testmod.ko
> +       # test_cpp xdpxceiver
> 
> TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
> 
> This diff is also attached before Gmail eats it.
> 
> Yonghong Song as you described your build-environment and checking
> requirements for clang-13 in bpf-next (see [1]), I am unsure if I want
> to upgrade LLVM toolchain to v13-git and use bpf-next as the new
> kernel base.
> Lemme see if I get LLVM/Clang v13-git from Debian/experimental and/or
> <apt.llvm.org>.

If you want to run bpf-next, clang v13 definitely recommended.
But I think if you use clang v13 to run linus linux, you may
hit DWARF5 DW_OP_addrx as well. But unfortunately you will
may hit a few selftest issues (e.g., BPF_TCP_CLOSE issue).

> 
> - Sedat -
> 
> [1] https://git.kernel.org/bpf/bpf-next/c/2ba4badca9977b64c966b0177920daadbd5501fe
> [2] https://git.kernel.org/bpf/bpf-next/c/a0964f526df6facd4e12a4c416185013026eecf9
> 
