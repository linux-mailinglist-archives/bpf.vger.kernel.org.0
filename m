Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED7766D681
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 07:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjAQGtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 01:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjAQGtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 01:49:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929421DB94;
        Mon, 16 Jan 2023 22:48:59 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GJh3EV008512;
        Mon, 16 Jan 2023 22:48:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=v/0NL7XKy32WM6bAMIEJOr9wSxPIbKLCdp4OmqEFNcU=;
 b=TgjmzUHLz/iqsEhRRS5xQuqqKXQsau4pPLTzhCud91n8bFxlHaGT25bM49vvn21ssSZo
 Gkf+ueCULp9JXcsWpIfvXLFZXPBuhWX6j6d4ykro5D1uQ8qiv8vvpfN83S9Ge5fManRW
 jqON5GzitOg/WzXyuy2WR8pMwCTKUAQE6DU0TY7+ZuvfcY1PJEES3p/E5Ohx3BXH5ZAa
 wYkXtk3wn5YuV5ey+oXCqeiZjvVnSbCcbf5+NzizoFWifwSMT8nF+miJLijiRNdpW3dt
 ZwelQVE+UdWLm8Csmeojbx7d8dsUYt8uYolqB4Epgg+iljCGQdi1sd2n4LuOW6h6xeFV rA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n3tyuc601-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:48:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSgEj0ATyw3jImZm8aEepUnpqSWS+7XbtQTiLZnW6LL3nq5fVSITLunXewvZBRJb1/InuaMRISSpyxRo2WrrHNfv+iG3TDY046p/n+EWMeYXJX5imfeppwJ2K7P1KbpaOE4WmC8/E5YcQOcOkuVGxbKaYpTQUqEOClJXPacI5VUhWSmEWSkTSEH+5K+oxRaJI+3xNBVoPnD9aXociJJBHP8a+CM3cj3sR1oLDLGfK81mnjG+sYeHmZbM183wQkSRb5Qth73IewoOv5Ds5QpB7Ydi/z0T4oGQPzNSNkHHZ088jxCfjWJSL34kPZtz01cYtZppTFD6Y3csIxijZ09dbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/0NL7XKy32WM6bAMIEJOr9wSxPIbKLCdp4OmqEFNcU=;
 b=UrLeeeSJ2/4dK4a2t9KnNWvTsCChN0ZBp8gHM4uU22ElkLXDGtLJsaWf2aNsTbrsAwGExRklVzNSsyz49dinsNG4TKB92EoiiHUXO6B+KZvPH0GDVlA0Jhc3Vo9Re2W+6bx9UoZC3o6prlJ3Tz/q5X2NyIR+bhzPd8uH86f1Oy7llx68VO+H+UAFQte5Bg7JgUjUBtwldTsymzF48laSGWKgyiXoOQ+vwxjlb0NFjvklJKATgOn5oKXK9EHTCj8RAmJqeWccQVfcjyYzRGYojqLnLiQDBbQ3LVKMFWQU+1NP0YhaK8HZbDwuS8JrJfa6iDHMyAwK3JZa68lQ9k5rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5566.namprd15.prod.outlook.com (2603:10b6:8:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 06:48:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 06:48:30 +0000
Message-ID: <dffe5523-4ff7-8b27-46fa-079a9556166f@meta.com>
Date:   Mon, 16 Jan 2023 22:48:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build
 errors of test_bpf_nf.c
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
 <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
 <556dc633-e7fb-da8a-1fa9-757684edd3a4@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <556dc633-e7fb-da8a-1fa9-757684edd3a4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aab90b-d19e-4238-791c-08daf856d7dd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCAgufSpuPh5IL0RVCN2vEU1jrurzU8a0bIFsjofF9Na/vqrQZOXG8kxW7481mXL/s+W5oF2zPQMxEWWR+UJOle85eajYn2m3OBqI3kckteLg/7NNq5mJJOHq1gjaJxytAn9+PwSKANRUSwKaOIaJD45rzLgUi4eqRMd8pG9JZRA0gTUttT5cjWArWtouv+HIfgj+GoJcwztAa0s0zjJQH3Y//5OH3NjweR6lG3i9esEiDvjSsnhbuVNiZTecE1tf6vK2f9QMN4Ms5HOj4hy/yTrEIsgk+g2oqUS2nzGyiJrABYZM7gGEQG30L3apt+1nDxyqMPq/3vEBZcHWx0zu/0Yp3CcOXI56FH/eKiNpCbizYvzw/1CC24TB7MxBEGzI+v1D8bvp2J+EVB0nCo66GHUTE+gN6mmiWaDSMCkn3rNjpN+Y5TUFzdK6qCTlLJCdRXmvoSanJzVqvjMW3HRPPAxhPGe3Ei5DMAVp/oIX+KSk8jWEAaMJvIWaP3C2F94a9B8li789LbCEc8Q4VrRuJGKXiCsoJq5zl1F6464rL4LTEX5dvDR8gyfLbEm6LP+xRI17svkj1G6z/v1Xltm+g9F3Sd3vNC/Oq2OCS5dp37N9ziyuiRuupr9RGV9z2Id7h9937/7Rf5N5OFcENli+PMaYm034b/rB6UFU32MMtqD5XxNDm/ImqT5L9Ei6vBHjM8FLjB1q3hW50uK0I/p+ds64eqBXmiRhn9xUpFFzIfYM7fXaOXzYSK+Mfx6wBKY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(8936002)(31686004)(6666004)(8676002)(41300700001)(66476007)(66556008)(4326008)(66946007)(316002)(478600001)(2616005)(36756003)(2906002)(5660300002)(7416002)(110136005)(921005)(6486002)(31696002)(6512007)(53546011)(86362001)(6506007)(186003)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0JVU1MzdmVqQXBSZ01IRmFDK3Y3c2xFNnhYMjM5VWFoOE5ieWtWb1RPdnJ6?=
 =?utf-8?B?TThHUnVKMXNFeHNaL3pPUWgvREYrazFiTEppUm9TMTVUZDA4ZG1MNk1QSis5?=
 =?utf-8?B?Wk94eHlmTlR0RGc5WDE1MkUwc2QvcUtmdVVxTGJUb1JGVzFTeE9yays1WTFX?=
 =?utf-8?B?VkNPc2l6TDR6V3haUWQyeWUzdmZrV2RIcWJKV3NKeVNFTUpMQlB0cG9NbTVv?=
 =?utf-8?B?VGlNSUdnMjY5K01wNExkbExubFo2dFlpM1g2SWpZWnVqMVFqVytGUlhNOWZM?=
 =?utf-8?B?a0tzYzRjVDVuRXJsdUFXV3dEQkt1eGpHamcvYnA3cG5zNE5nemdOMS9SbGNl?=
 =?utf-8?B?UHhFT2VwUTNQUnhuMDZqR0YwdWF2Sm9KQWZ4NTZMWmRyOUZkWXVUTVRCckYv?=
 =?utf-8?B?bmNyNG14Z2lhUHNKUWVpeW9DQUZ3eEZWaDEyKzJFSDdBZ2twa1RNWFBvWXN3?=
 =?utf-8?B?SlhtcnQ0ZkhjZ29BTGNHcFJhUUdreGhpMDZiVWg3c2ZuSXkxWnlMTjhFU2Zq?=
 =?utf-8?B?cThRUHVWMGRCSUl0a1hPRFMzcTNZOUEzdmMrb3ViVHQ2T1I5QzJ1UWpYQnV4?=
 =?utf-8?B?Y1VodHA4VVlZN1VFazRVUEdXL3d1aHhkUXRER3dpd0dTU3NqNmRYaU10ZktZ?=
 =?utf-8?B?eXVHUjJXYzF6MnhTaVlpSkZNYi9Ta2dwVTFVdnZDUlROYkNET1JVRWxsQ3hJ?=
 =?utf-8?B?bHVXMERWVXJwTUoyUlRDY3B4MWRnZjJXQ1I2U3JWWlp4V3d2LzRYWEU4NVNy?=
 =?utf-8?B?b2N5c2hFaXd4dElnWXZpVVB6KzBBZjVuRFB2ZzBzTFdESEd1NExpZmUyK1I5?=
 =?utf-8?B?WS8veXlZRWVNS2NibmQra090UHkyaTJ4bjdUNVhGQk9QcjBZdndBbXA3bmdP?=
 =?utf-8?B?VURndlpkT2ZwaU5sZE8zVjVZSlVCRkhoYUN5dDVaZTc2NW04ZUcxUklmMms3?=
 =?utf-8?B?YVZDWEV6WW1iTnZUdzF6b1VWYWhCZ0FzUmxNT3ZPcG5laHhvbCtVaU1EeHc1?=
 =?utf-8?B?WXNnMHlLRFh0QU5SUy82eUpKQnhqdHVzdEMzM0phTWJFR09FNjh3RTlYSGQv?=
 =?utf-8?B?MnJZMjhQcnJDdWRSWnhmMW5iK3FXU1piYW0zaU14WDFMUXRVNEViZDJOdERn?=
 =?utf-8?B?NUZLQlZRZjVGeTZqdzYyalAwdFI5ekhXMEZsQjNvWFV6bmNaanRXQUczV1ZY?=
 =?utf-8?B?cy9mT1dwRHFkd1Bnc21ZSzJOOTY4QitHZjAweDU5Q1RyellET3oreVR2U1lF?=
 =?utf-8?B?KzAwRjJzUjM2U1puMGtjaWFiODc3cGJtSEZ5ZVR2ZEh5S0UwY0krYlZEL05K?=
 =?utf-8?B?WUFvVjNiNVRxNFpHWXFaK2drSnlpdlNSMXJ0WW0xa05XNi9ZVVFtaHlCRktH?=
 =?utf-8?B?aU9Zc3ZDY2dZZXpieUsxcVBuOGJoM3RkUThpOWZ5SWt4MHA5RmFZVEN1WHRj?=
 =?utf-8?B?VEZIODlIYStmUXhjb0k2TlJoSi9aazh6ZHQxSjlGbnBmWGJKQTFkdHo4cktz?=
 =?utf-8?B?RU5UVmcyTTdyTDRjbENaQmpETFFqamx3RHF5N3RnRjBmb3dBek43NmxkRWRz?=
 =?utf-8?B?ak9xcnk0ZmZ3c3RVQVRJdnFDMThVNHJzRzF6eVltL24zN2hJMk1td3BGa253?=
 =?utf-8?B?djF3RlhvNDZraTZkQWNaa2tVaEw2Unc1cFlwWkszZDJjckJyVFdWdmpIMjR0?=
 =?utf-8?B?Q1JlNEVpV2dSVDFQMjNvWVh4V1pKb2dBMitTOHJNQk9FaVoxVUdLbFgrZkpt?=
 =?utf-8?B?Kytkd0h6eVF6VWt5ek0rT0NNdnBtYUR5MmpIOG03d3c1b1ZNQm42UTVyT3ph?=
 =?utf-8?B?a0o4RC82djBJbTl3V1NubURRRlA5bmpxSVFha2cxQitzWUJlZVFFcEdnc25P?=
 =?utf-8?B?d0VTNUFKKzFGLzRKWXZPNjVJaW9JZTB4Uzk4V3NZNXZjK0VlUndKd0ZUZkFW?=
 =?utf-8?B?a2dKU0o0TUd2U1VDWVBNUURSelViNWk3ZnorbHFNOFB6NW55L2FrclRrMGk0?=
 =?utf-8?B?aEdaQ2ZobDdZbkREbjdYYlhJOWU0eVdiTFdYNXhOM2N3WFNVUUNnQU9pei81?=
 =?utf-8?B?MVl1b2RwS0RoSGVZSTFlQ3VVOFVnRnFRckpydmtaWThoT2lTNW5RT0I3UFFG?=
 =?utf-8?B?QSt6MzRzNDQ3NGt0eklWMENjYlFoQndyWlArQTkrOVNRVXBpOVJjYnpwRE9a?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aab90b-d19e-4238-791c-08daf856d7dd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 06:48:30.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQSMq5hKC/fz9GOzn2qs0nsaJfBhDlsQen+A3CZo+Viv9TAe6Ns6UniL4XUhlO3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5566
X-Proofpoint-GUID: KIAUhy8WEKwE5EvN3LfFjvTzQk7GpIfe
X-Proofpoint-ORIG-GUID: KIAUhy8WEKwE5EvN3LfFjvTzQk7GpIfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_02,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/16/23 5:54 AM, Alan Maguire wrote:
> On 16/01/2023 12:30, Eduard Zingerman wrote:
>> On Mon, 2023-01-16 at 12:55 +0800, Tiezhu Yang wrote:
>>> $ make -C tools/testing/selftests/bpf/
>>>
>>>    CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>>>                  bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>>>                                                         ^
>>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>>>                  bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>>>                                                         ^
>>> 2 errors generated.
>>>
>>> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c
>>> to fix the above build errors.
>>>
>>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>> index 227e85e..114f961 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>>   int test_exist_lookup = -ENOENT;
>>>   u32 test_exist_lookup_mark = 0;
>>>   
>>> +enum nf_nat_manip_type {
>>> +	NF_NAT_MANIP_SRC,
>>> +	NF_NAT_MANIP_DST
>>> +};
>>> +
>>
>> This is confusing, when I build the kernel/tests I get the declaration
>> the "enum nf_nat_manip_type" from the vmlinux.h (which is included from test_bpf_nf.c).
>> Which means that this patch results in compilation error with my configuration.
>> Is there a chance that your kernel is configured without some necessary netfilter
>> configuration options? Have you tried this patch with BPF CI?
>>
> 
> Yep; I suspect if CONFIG_NF_NAT=m , the required definitions won't make it
> into vmlinux.h. The reference tools/testing/seftests/bpf/config has
> CONFIG_NF_NAT=y so it is at least documented in the referenced config.
> 
> I'd suggest going the route of
> 
> commit aa67961f3243dfff26c47769f87b4d94b07ec71f
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> Date:   Tue Dec 6 11:35:54 2022 -0800
> 
>      selftests/bpf: Allow building bpf tests with CONFIG_XFRM_INTERFACE=[m|n]
>      
> ...and adding/using local definitons like:
> 
> enum nf_nat_manip_type_local {
> 	NF_NAT_MANIP_SRC_LOCAL,
> 	NF_NAT_MANIP_DST_LOCAL
> };

The above won't support core, and since preserve_access_index attribute
does not support enum for now. We need to use bpf_core_enum_value to
retrieve the proper value through CORE.

could you try the following?

enum nf_nat_manip_type___local {
	NF_NAT_MANIP_SRC___LOCAL,
	NF_NAT_MANIP_DST___LOCAL,
};

...
bpf_ct_set_nat_info(ct, &saddr, sport, bpf_core_enum_value(enum 
nf_nat_manip_type___local,  NF_NAT_MANIP_SRC___LOCAL));
...

bpf_ct_set_nat_info(ct, &daddr, dport, bpf_core_enum_value(enum 
nf_nat_manip_type___local,  NF_NAT_MANIP_DST___LOCAL));

whether it works or not? Could you also try if the
enumerator sequence in enum nf_nat_manip_type___local changed?

> 
> ...to avoid the name clash.
> 
> 
> Alan
