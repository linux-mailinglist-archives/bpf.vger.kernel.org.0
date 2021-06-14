Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28ED3A5CC3
	for <lists+bpf@lfdr.de>; Mon, 14 Jun 2021 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhFNGRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 02:17:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231994AbhFNGRH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Jun 2021 02:17:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15E6DVs9011230;
        Sun, 13 Jun 2021 23:14:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=facebook; bh=Tvjl/Ymc2r+9h/8qH2s96ZMo4945gLILhmkYWTvTZ9Q=;
 b=FzY+WPhlLiao9QmlpC2MYhj9v9oz8PgigbpO6uBJglHon7QRxAP83a2MotRA6XfR6fFY
 6HdO9qZ/mIRRDE/3toXLpTr1l+yxDPtCQnjmqv/mg7R28di0Gp/wu/cwtse9RKfVdAyx
 rRkW9snfqi+JMS03xGQCIgd63xf1V19k1VQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 394rm074vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 13 Jun 2021 23:14:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 23:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Sd2t9nq1QiGPrUzztdmKJ2Nkmj3e1OghhupvzOyTksvZxCCLmy+Mq6otBTbZPI304xo6hP2TPzdmyisyurszMfqnJXTjGHWOJvLbZRxMAi4SvpI8IZJx5JAUDttG/IpgZ2xbbjawrX6zaN+7/rz4Se39s3GXGpZQ76cfZSElflJMEVfeC3VEy+paep/NMNlIElMcwkWnT6+byxL1bX9Qanp54oscXwZlpb/eilPc+4/m5tJtzLDqQ8gnL4Ul2zWIL5BSPfmtp5LXzx7m6FygvPaJRllif4lPzIZoXlP8AgiFCBlQ4et9MN4I/Jeue58tRCbpke/xUZVyA5znz+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsMRZY4j/uiFN5D9yfvD4yirGqVNlzu80LbFMDEEJtk=;
 b=PcLJ6c43CuCT2teV+yft1MmV6zLUl+e5et3YpDqUZtVSKlQnZV3FDWhyyuAmWS8jNfKzKiqvUcyVMwAOUSdWHJiD0Ha72JU0kujgkKaoHhct1wGumok3sLtzGuV+9AmmOrhqlsEz6ku56/LlrICatOudS9oskYAifewvSkVCSuH8cClot5hNVdSu/Iqnj7sQXGVdCreA/qsGyQGTOstU2THWs46ZI6R+AJXVJCvpo82grz/DZSFpeBFqH7yfc10HM/Y3rmdNDYTVag36tBHKXOGsTAi6dvlUDqcVrrbrDzw17zi5m6hM43T+Su8Qd3QV+tI0ZOpwe3ATI4cJWiPNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2206.namprd15.prod.outlook.com (2603:10b6:805:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 06:14:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 06:14:47 +0000
Subject: Re: Kernel Oops in test_verifier "#828/p reference tracking:
 bpf_sk_release(btf_tcp_sock)"
To:     Tony Ambardar <tony.ambardar@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
 <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com>
 <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4ec3c676-e219-6aaf-fe5c-76abbb0c9535@fb.com>
Date:   Sun, 13 Jun 2021 23:14:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
Content-Type: multipart/mixed;
        boundary="------------271E180B87F56E08905C58D5"
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:1e71]
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::100b] (2620:10d:c090:400::5:1e71) by MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 06:14:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaaf39d2-5287-414a-2cc3-08d92efbb597
X-MS-TrafficTypeDiagnostic: SN6PR15MB2206:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2206EA243EC801712A142FEAD3319@SN6PR15MB2206.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GP+SM0sVSEcPv/u71zsXaxgW7SbhMS1V3J84JhTT1SvqfeSsQVo0JygwRmCZb2jYBDqoh/ZEuh+YGNnJCp+xWOpvYs5oUWsIwVzZyLCuJqVTiNr/GcaVwseuln/AL2tA9/Qf4V5QDUeTFhAmrf6I4nJOAZ6nKbXtCF0jCtr+r4yBGXz9SUBs5V2hyyDHnxUwq5F1DEjHU9N33F7sRf0C8MGn8huLi/mGYAWT6TCW4GA2QrZ+KCL5nC4fGVjKboQ8/l+fTcKoaVxplXzfBKE4dVbO1MYHWlhTq2kHUAphZ/MxX/R6q/Fca1UG7Lol5ZW8vI0fS1e2FjKGeFvr2H7sMH1oztqObSf/LzihszBBEnZHxNJRuISI0DEJeh8vWmRnqlyUgD1chDHtYScvIFtiZ3Gb8nLzGjuq4gcxFT0lM2pPXawb13dmAIkObo3TC36Vz8FyGjAh2A7pu/nYKw7YebbQa2q1JYKbtF0tYXn36bzwOAho4df3f4xqoBQ5ilJtvVrmfrLVxMuSJ0jcxMpJtaUcGi6+yoDevo6YzP+7PeJwFuY+J+DG4IMj2180oY87GiO+vDQy4O2QsS3NHkFqt6j2z7SXgtEgQKCyinBzNtkVDfJZbF5UL0m9OzQEAmwZIv5rjVxx1qUDtyvOvsIyC6U/QPc0fZzqVjA1Mu3lBbmQGSm7wlqBWFP0ZoQZMx/h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(31686004)(2616005)(186003)(83380400001)(316002)(66556008)(478600001)(16526019)(2906002)(45080400002)(6486002)(6916009)(8676002)(86362001)(235185007)(66946007)(38100700002)(36756003)(66476007)(31696002)(4326008)(33964004)(8936002)(5660300002)(53546011)(54906003)(52116002)(66616009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVMcXhkZ0VHUXVDUEE0WmZZd3F1aEVCYWVPZWN4QnJOWWxVclJiTWVZR1Vq?=
 =?utf-8?B?c0hPcEQyNnFkMVhxdVp5bEFvMUlmN0FNd1hmMEpqM1lueFB4dWp5ckZxL3Nr?=
 =?utf-8?B?em1QTW9JRFhyelhjU1QzNDY3RjZUU1UvV3NDOHN0NWVWMkUyMU5HM1hKY3dZ?=
 =?utf-8?B?bU80KzBmYUFDWVllMHVDQm1yc0dqRy9xUmxCcnFpUFV5TzdCL2kyeG9icDVD?=
 =?utf-8?B?NUU0czlvcEs4TExPaWdnV1pQSXZCeUJZeC9KZ1F0WWNlOG1jT0daRlVSM2w2?=
 =?utf-8?B?TXZPSkZtWSt3WW1MOGQwQjAyczhZenlnT1ErWEpWcWxjWk5rcWpRaFF0bEIv?=
 =?utf-8?B?QTN2YWNaT3FSNHRJMmFFNVhqL2pXcmVBcGJTZzhJNllVUHRHc1RDNTU0K0lJ?=
 =?utf-8?B?RWQzY3FLUVhhT2pQTis3SjgzWVhZZEtoUDEzYXFlNDJXWllLMHRSa3lUa2tY?=
 =?utf-8?B?RHo5NkpJVzJMays1bWxPdllxczdYdDdWV0psQ1puYmE5ODJNbjZhNGFSMjl2?=
 =?utf-8?B?cW1PZkU2d04xYnpWQXJ4UytXS0lJalptbjZoaGxuM2RsZm1vZkhSSGRoY2pK?=
 =?utf-8?B?UFpzQmZyd1JkdytKRFpHZkR5SzNjVU0wUGUxMVV6TUFINHQ0NnZtektkdmt5?=
 =?utf-8?B?cmJtK1NYNStUdlJhMzdpUENpR0lubnUwVVBqbmdMcWI2OWthcjZhV1daUG5i?=
 =?utf-8?B?ZGxzWTlxRFYxOVlZc3FsdG9JSVBTTk9jaWdZbWU1bEFZUzZiWFUvWHBaNTN3?=
 =?utf-8?B?UTNOamRJcFNhcHBFTUttc0w5eFd2VWlUWlBFZ3JPUWlqR2x4bWpCMm1OY0gx?=
 =?utf-8?B?aXNGQzFjWWUzZFRZS1k0bHdDL0w4RFMySjhzTUVqdWtIaFZlVFUvOGdzOXNN?=
 =?utf-8?B?ZUhuamJWb2gwSjc2ZlBRNUVEOG5TRDlwV1o2clkwSjI1STM1My9FbmJPbFBZ?=
 =?utf-8?B?TnlEZ01SODFucjh6bjJFcDFwMm0rZ3Vkb1hhdFppTGdPbGFqbHhpSnRma29Z?=
 =?utf-8?B?ODVmWnR5OW43emljK3lXQ1pJd3hRYlhNSy9UZzJQZ1ViaXVzL3VyUitPUnFX?=
 =?utf-8?B?UlFWRHAwRGlBWEE3VTk4SUhYY0tJNVBoTzhBMGNGUW9FUjVkS1AzN0ZONndH?=
 =?utf-8?B?SWt1K3Qxem84bmZuOGlSajRRRXMrTHRmREZ4ZHU1VGdJVm9jckJOZloxMS9X?=
 =?utf-8?B?SFhqdHlWYzFDL3YwbzBzNFNsbkxSRUx4Rmo5UExsa0FCMGZtbnlmSnNUQVBB?=
 =?utf-8?B?VWt3VWdPSisyZjZna0ZUNTh4OFRpc2FGSTRtZEkyRm41Q3hHWm4xMy9ObkdY?=
 =?utf-8?B?cjVCZFV6elYwM3VPcENac1lJSTJSU2RYTndZeWVwSmhBWm9raTRrVndyTUsy?=
 =?utf-8?B?blFEOXllQlM1YW5LSHU4RW0xY2pPaTE5akJsVDNidjRQWTh2Y2VOVU1NeHJS?=
 =?utf-8?B?dGhCK0dJbTdINVcvR3hrSGxETWhuNjBhM2N5bnZNSENCeHpNd01NcmpxS3FM?=
 =?utf-8?B?c2ZMWG1zaDZjczdwaHU0ZzVvSkNTT29LUG1GOWJvRXdVTGJSQmhCRldGaURD?=
 =?utf-8?B?Y095bzNudWVkN3JiK1N5OXVWR0I2L2pmVXZNSHNRdC9WVnczTnpQRW1TTXJJ?=
 =?utf-8?B?SnhzOU5CVll0ajN3bmlDbnFuQTJoNDUrTDFXc1pDd2hvSGZCZUZwZVlRN2x3?=
 =?utf-8?B?YlJsdjRKbzZNVHprald0Z3lFMDBodWFkS050cENPY245dlBlUlAvWTJkZGxj?=
 =?utf-8?B?ZysvSExKZER3TUpJK3h3S0YxYXBtRnlCUU1CTk83UVVmN1ZYQk9QRVpJblE0?=
 =?utf-8?B?NGlNVEF2K2VsQUtxOXBpZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf39d2-5287-414a-2cc3-08d92efbb597
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 06:14:46.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELW0v3X8C7tdrGzJ0JdgOV5+gmrrGFIqFSOd6+R4hJUdoYecgmGlBn3FXibV9X3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2206
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: KuUF1rhellsJlyD4UgYHXoWuZvB9DJfl
X-Proofpoint-GUID: KuUF1rhellsJlyD4UgYHXoWuZvB9DJfl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140046
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--------------271E180B87F56E08905C58D5
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/21 5:07 PM, Tony Ambardar wrote:
> On Fri, 11 Jun 2021 at 08:57, Yonghong Song <yhs@fb.com> wrote:
>>
>> On 6/10/21 6:02 PM, Tony Ambardar wrote:
>>> Hello,
>>>
>>> I encountered an NPE and kernel Oops [1] while running the
>>> 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
>>> observed during development of a MIPS32 JIT but is verifier-related.
>>>
>>> Initial troubleshooting [2] points to an unchecked NULL dereference in
>>> btf_type_by_id(), with an unexpected BTF type ID. The root cause is
>>> unclear, whether source of the ID or a potential underlying BTF
>>> problem.
>>
>> Do you know what is the faulty btf ID number? What is the maximum id
>> for vmlinux BTF?
> 
> Thanks for the suggestions, Yonghong.
> 
> I had built/packaged bpftool for the target, which shows the maximum as:
> 
>    root@OpenWrt:~# bpftool btf dump file /sys/kernel/btf/vmlinux format
> raw|tail -5
>    [43179] FUNC 'pci_load_of_ranges' type_id=43178 linkage=static
>    [43180] ARRAY '(anon)' type_id=23 index_type_id=23 nr_elems=16
>    [43181] FUNC 'pcibios_plat_dev_init' type_id=29264 linkage=static
>    [43182] FUNC 'pcibios_map_irq' type_id=29815 linkage=static
>    [43183] FUNC 'mips_pcibios_init' type_id=115 linkage=static
> 
> After adding NULL handling and debug pr_err() to kernel_type_name(), I next see:
> 
>    root@OpenWrt:~# ./test_verifier_eb 828
>    [   87.196692] btf_type_by_id(btf_vmlinux, 3062497280) returns NULL
>    [   87.196958] btf_type_by_id(btf_vmlinux, 2936995840) returns NULL
>    #828/p reference tracking: bpf_sk_release(btf_tcp_sock) FAIL
> 
> Those large type ids make me suspect an endianness issue, even though bpftool
> can still properly access the vmlinux BTF. Changing byte order and
> looking up the
> resulting type ids seems to confirm this:
> 
>    Check endianness:
>      3062497280 -> 0xB68A0000 --swap endian--> 0x00008AB6 -> 35510
>    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[35510]":
>      [35510] STRUCT 'tcp_sock' size=1752 vlen=136
> 
>    Check endianness:
>      2936995840 -> 0xAF0F0000 --swap endian--> 0x00000FAF -> 4015
>    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[4015]":
>      [4015] STRUCT 'sock_common' size=112 vlen=25
> 
> As a further test, I repeated "test_verifier 828" across mips{32,64}{be,le}
> systems and confirm seeing the problem only with the big-endian ones.

 From the above information, looks like vmlinux BTF is correct.
Below resolve_btfids command output seems indicating the btf_id list
is also correct.

The kernel_type_name is used in a few places for verifier verbose output.

$ grep kernel_type_name kernel/bpf/verifier.c
static const char *kernel_type_name(const struct btf* btf, u32 id)
                                 verbose(env, "%s", 
kernel_type_name(reg->btf, reg->btf_id));
                                 regno, kernel_type_name(reg->btf, 
reg->btf_id),
                                 kernel_type_name(btf_vmlinux, 
*arg_btf_id));

The most suspicous target is reg->btf_id, which is propagated from
the result of bpf_sk_lookup_tcp() helper.

> 
>> The involved helper is bpf_sk_release.
>>
>> static const struct bpf_func_proto bpf_sk_release_proto = {
>>           .func           = bpf_sk_release,
>>           .gpl_only       = false,
>>           .ret_type       = RET_INTEGER,
>>           .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
>> };
>>
>> Eventually, the btf_id is taken from btf_sock_ids[6] where
>> btf_sock_ids is a kernel global variable.
>>
>> Could you check btf_sock_ids[6] to see whether the number
>> makes sense?
> 
> What I see matches the second btf_type_by_id() NULL call above:
>    [   56.556121] btf_sock_ids[6]: 2936995840
> 
>> The id is computed by resolve_btfids in
>> tools/bpf/resolve_btfids, you might add verbose mode to your linux build
>> to get more information.
> 
> The verbose build didn't print any details of the btf ids. Was there anything
> special to do in invocation? I manually ran "resolve_btfids -v vmlinux" from
> the build dir and this, strangely, gave slightly different results than bpftool
> but not the huge endian-swapped type ids. Is this expected?
> 
>    # ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux
>    ...
>    patching addr   116: ID   35522 [tcp_sock]
>    ...
>    patching addr   112: ID    4021 [sock_common]
> 
> Do any of the details above help narrow down things? What do you suggest
> for next steps?

We need to identify issues by dumping detailed verifier logs.
Could you apply the following change?

--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1088,7 +1088,7 @@ static void do_test_single(struct bpf_test *test, 
bool unpriv,
         attr.insns_cnt = prog_len;
         attr.license = "GPL";
         if (verbose)
-               attr.log_level = 1;
+               attr.log_level = 3;
         else if (expected_ret == VERBOSE_ACCEPT)
                 attr.log_level = 2;
         else

Run command like `./test_verifier -v 828 828`?

I attached the verifier output for x86_64.
Maybe by comparing x86 output vs. mips32 output, you can
find which insn starts to have *wrong* verifier state
and then we can go from there.

> 
> Thanks,
> Tony
> 
>>>
>>> Has this been seen before? How best to debug this further or resolve?
>>> What other details would be useful for BPF kernel developers?
>>>
>>> Thanks for any help,
>>> Tony
>>>
>>> [1]:
>>> (Host details)
>>> kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
>>> v1.21
>>>
>>> (Target details)
>>> root@OpenWrt:/# uname -a
>>> Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux
>>>
>>> root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
>>> net.core.bpf_jit_enable = 0
>>>
>>> #826/p reference tracking: branch tracking valid pointer null comparison OK
>>> #827/p reference tracking: branch tracking valid pointer value comparison OK
>>> CPU 0 Unable to handle kernel paging request at virtual address
>>> 00000000, epc == 80244654, ra == 80244654
>>> Oops[#1]:
>>> CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
>>> $ 0   : 00000000 00000001 00000000 0000a8a2
>>> $ 4   : 835ac580 a6280000 00000000 00000001
>>> $ 8   : 835ac580 a6280000 00000000 02020202
>>> $12   : 8348de58 834ba800 00000000 00000000
>>> $16   : 835ac580 8098be2c fffffff3 834bdb38
>>> $20   : 8098be0c 00000001 00000018 00000000
>>> $24   : 00000000 01415415
>>> $28   : 834bc000 834bdac8 00000005 80244654
>>> Hi    : 00000017
>>> Lo    : 0a3d70a2
>>> epc   : 80244654 kernel_type_name+0x20/0x38
>>> ra    : 80244654 kernel_type_name+0x20/0x38
>>> Status: 1000a403 KERNEL EXL IE
>>> Cause : 00800008 (ExcCode 02)
>>> BadVA : 00000000
>>> PrId  : 00019300 (MIPS 24Kc)
>>> Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
>>> mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
>>> xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
>>> xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
>>> xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
>>> xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
>>> slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
>>> nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
>>> iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
>>> cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
>>> sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
>>> em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
>>> libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
>>> sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
>>>    cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
>>> ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
>>> ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
>>> ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
>>> ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
>>> ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
>>> nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
>>> ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
>>> mii
>>> Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
>>> tls=77e5aec8)
>>> Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
>>>           a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
>>>           80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
>>>           834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
>>>           00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
>>>           ...
>>> Call Trace:
>>> [<80244654>] kernel_type_name+0x20/0x38
>>> [<8024af78>] check_helper_call+0x1c9c/0x1dbc
>>> [<8024d008>] do_check_common+0x1f70/0x2a3c
>>> [<8024fb6c>] bpf_check+0x18f8/0x2308
>>> [<802369ec>] bpf_prog_load+0x378/0x860
>>> [<80237e1c>] __do_sys_bpf+0x3e0/0x2100
>>> [<801142d8>] syscall_common+0x34/0x58
>>>
>>> Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
>>> 8fb00010  08099b4f  27bd0018
>>>
>>> ---[ end trace ab13ac5f89eb825b ]---
>>> Kernel panic - not syncing: Fatal exception
>>> Rebooting in 3 seconds..
>>> QEMU: Terminated
>>>
>>>
>>> [2]:
>>> Function Code:
>>> ==============
>>> const char *kernel_type_name(u32 id)
>>> {
>>>       return btf_name_by_offset(btf_vmlinux,
>>>                     btf_type_by_id(btf_vmlinux, id)->name_off);
>>> }
>>>
>>> const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
>>> {
>>>       if (type_id > btf->nr_types)
>>>           return NULL;
>>>
>>>       return btf->types[type_id];
>>> }
>>>
>>> Disassembled Code:
>>> ==================
>>> 0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
>>> 0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
>>> 0x0000000000000008:  02 00 20 25    move  $a0, $s0
>>> 0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
>>> 0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
>>> 0x0000000000000014:  02 00 20 25    move  $a0, $s0
>>> 0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
>>> 0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
>>> 0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
>>>

--------------271E180B87F56E08905C58D5
Content-Type: text/plain; charset="UTF-8"; x-mac-type=0; x-mac-creator=0;
	name="log.verifier"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="log.verifier"

IzgyOC9wIHJlZmVyZW5jZSB0cmFja2luZzogYWxsb2MsIGNoZWNrLCBmcmVlIGluIGJvdGggc3Vi
YnJhbmNoZXMgLCB2ZXJpZmllciBsb2c6CmZ1bmMjMCBAMAowOiBSMT1jdHgoaWQ9MCxvZmY9MCxp
bW09MCkgUjEwPWZwMAowOiAoNjEpIHIyID0gKih1MzIgKikocjEgKzc2KQoxOiBSMT1jdHgoaWQ9
MCxvZmY9MCxpbW09MCkgUjJfdz1wa3QoaWQ9MCxvZmY9MCxyPTAsaW1tPTApIFIxMD1mcDAKMTog
KDYxKSByMyA9ICoodTMyICopKHIxICs4MCkKMjogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIy
X3c9cGt0KGlkPTAsb2ZmPTAscj0wLGltbT0wKSBSM193PXBrdF9lbmQoaWQ9MCxvZmY9MCxpbW09
MCkgUjEwPWZwMAoyOiAoYmYpIHIwID0gcjIKMzogUjBfdz1wa3QoaWQ9MCxvZmY9MCxyPTAsaW1t
PTApIFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PXBrdChpZD0wLG9mZj0wLHI9MCxpbW09
MCkgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIFIxMD1mcDAKMzogKDA3KSByMCArPSAx
Ngo0OiBSMF93PXBrdChpZD0wLG9mZj0xNixyPTAsaW1tPTApIFIxPWN0eChpZD0wLG9mZj0wLGlt
bT0wKSBSMl93PXBrdChpZD0wLG9mZj0wLHI9MCxpbW09MCkgUjNfdz1wa3RfZW5kKGlkPTAsb2Zm
PTAsaW1tPTApIFIxMD1mcDAKNDogKGJkKSBpZiByMCA8PSByMyBnb3RvIHBjKzEKIFIwX3c9cGt0
KGlkPTAsb2ZmPTE2LHI9LTIsaW1tPTApIFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PXBr
dChpZD0wLG9mZj0wLHI9MCxpbW09MCkgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIFIx
MD1mcDAKNTogUjBfdz1wa3QoaWQ9MCxvZmY9MTYscj0tMixpbW09MCkgUjE9Y3R4KGlkPTAsb2Zm
PTAsaW1tPTApIFIyX3c9cGt0KGlkPTAsb2ZmPTAscj0wLGltbT0wKSBSM193PXBrdF9lbmQoaWQ9
MCxvZmY9MCxpbW09MCkgUjEwPWZwMAo1OiAoOTUpIGV4aXQKNjogUjBfdz1wa3QoaWQ9MCxvZmY9
MTYscj0xNixpbW09MCkgUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9cGt0KGlkPTAsb2Zm
PTAscj0xNixpbW09MCkgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIFIxMD1mcDAKNjog
KDYxKSByNiA9ICoodTMyICopKHIyICs4KQo3OiBSMF93PXBrdChpZD0wLG9mZj0xNixyPTE2LGlt
bT0wKSBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1wa3QoaWQ9MCxvZmY9MCxyPTE2LGlt
bT0wKSBSM193PXBrdF9lbmQoaWQ9MCxvZmY9MCxpbW09MCkgUjZfdz1pbnYoaWQ9MCx1bWF4X3Zh
bHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEwPWZwMAo3OiAoYjcp
IHIyID0gMAo4OiBSMF93PXBrdChpZD0wLG9mZj0xNixyPTE2LGltbT0wKSBSMT1jdHgoaWQ9MCxv
ZmY9MCxpbW09MCkgUjJfdz1pbnYwIFIzX3c9cGt0X2VuZChpZD0wLG9mZj0wLGltbT0wKSBSNl93
PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYp
KSBSMTA9ZnAwCjg6ICg2MykgKih1MzIgKikocjEwIC04KSA9IHIyCmxhc3RfaWR4IDggZmlyc3Rf
aWR4IDAKcmVncz00IHN0YWNrPTAgYmVmb3JlIDc6IChiNykgcjIgPSAwCjk6IFIwX3c9cGt0KGlk
PTAsb2ZmPTE2LHI9MTYsaW1tPTApIFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PWludlAw
IFIzX3c9cGt0X2VuZChpZD0wLG9mZj0wLGltbT0wKSBSNl93PWludihpZD0wLHVtYXhfdmFsdWU9
NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAw
MDAKOTogKDdiKSAqKHU2NCAqKShyMTAgLTE2KSA9IHIyCjEwOiBSMF93PXBrdChpZD0wLG9mZj0x
NixyPTE2LGltbT0wKSBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1pbnZQMCBSM193PXBr
dF9lbmQoaWQ9MCxvZmY9MCxpbW09MCkgUjZfdz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5Njcy
OTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2
X3c9MDAwMDAwMDAKMTA6ICg3YikgKih1NjQgKikocjEwIC0yNCkgPSByMgoxMTogUjBfdz1wa3Qo
aWQ9MCxvZmY9MTYscj0xNixpbW09MCkgUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52
UDAgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIFI2X3c9aW52KGlkPTAsdW1heF92YWx1
ZT00Mjk0OTY3Mjk1LHZhcl9vZmY9KDB4MDsgMHhmZmZmZmZmZikpIFIxMD1mcDAgZnAtOD0/Pz8/
MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0X3c9MDAwMDAwMDAKMTE6ICg3YikgKih1NjQgKiko
cjEwIC0zMikgPSByMgoxMjogUjBfdz1wa3QoaWQ9MCxvZmY9MTYscj0xNixpbW09MCkgUjE9Y3R4
KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52UDAgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1t
PTApIFI2X3c9aW52KGlkPTAsdW1heF92YWx1ZT00Mjk0OTY3Mjk1LHZhcl9vZmY9KDB4MDsgMHhm
ZmZmZmZmZikpIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0X3c9
MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMAoxMjogKDdiKSAqKHU2NCAqKShyMTAgLTQwKSA9IHIy
CjEzOiBSMF93PXBrdChpZD0wLG9mZj0xNixyPTE2LGltbT0wKSBSMT1jdHgoaWQ9MCxvZmY9MCxp
bW09MCkgUjJfdz1pbnZQMCBSM193PXBrdF9lbmQoaWQ9MCxvZmY9MCxpbW09MCkgUjZfdz1pbnYo
aWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEw
PWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0z
Ml93PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAKMTM6ICg3YikgKih1NjQgKikocjEwIC00OCkg
PSByMgoxNDogUjBfdz1wa3QoaWQ9MCxvZmY9MTYscj0xNixpbW09MCkgUjE9Y3R4KGlkPTAsb2Zm
PTAsaW1tPTApIFIyX3c9aW52UDAgUjNfdz1wa3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIFI2X3c9
aW52KGlkPTAsdW1heF92YWx1ZT00Mjk0OTY3Mjk1LHZhcl9vZmY9KDB4MDsgMHhmZmZmZmZmZikp
IFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0X3c9MDAwMDAwMDAg
ZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAwMDAwMDAwIGZwLTQ4X3c9MDAwMDAwMDAKMTQ6IChi
ZikgcjIgPSByMTAKMTU6IFIwX3c9cGt0KGlkPTAsb2ZmPTE2LHI9MTYsaW1tPTApIFIxPWN0eChp
ZD0wLG9mZj0wLGltbT0wKSBSMl93PWZwMCBSM193PXBrdF9lbmQoaWQ9MCxvZmY9MCxpbW09MCkg
UjZfdz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZm
ZmZmKSkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAw
MDAwMCBmcC0zMl93PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMAox
NTogKDA3KSByMiArPSAtNDgKMTY6IFIwX3c9cGt0KGlkPTAsb2ZmPTE2LHI9MTYsaW1tPTApIFIx
PWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PWZwLTQ4IFIzX3c9cGt0X2VuZChpZD0wLG9mZj0w
LGltbT0wKSBSNl93PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7
IDB4ZmZmZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0y
NF93PTAwMDAwMDAwIGZwLTMyX3c9MDAwMDAwMDAgZnAtNDBfdz0wMDAwMDAwMCBmcC00OF93PTAw
MDAwMDAwCjE2OiAoYjcpIHIzID0gMzYKMTc6IFIwX3c9cGt0KGlkPTAsb2ZmPTE2LHI9MTYsaW1t
PTApIFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PWZwLTQ4IFIzX3c9aW52MzYgUjZfdz1p
bnYoaWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkg
UjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBm
cC0zMl93PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMAoxNzogKGI3
KSByNCA9IDAKMTg6IFIwX3c9cGt0KGlkPTAsb2ZmPTE2LHI9MTYsaW1tPTApIFIxPWN0eChpZD0w
LG9mZj0wLGltbT0wKSBSMl93PWZwLTQ4IFIzX3c9aW52MzYgUjRfdz1pbnYwIFI2X3c9aW52KGlk
PTAsdW1heF92YWx1ZT00Mjk0OTY3Mjk1LHZhcl9vZmY9KDB4MDsgMHhmZmZmZmZmZikpIFIxMD1m
cDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0X3c9MDAwMDAwMDAgZnAtMzJf
dz0wMDAwMDAwMCBmcC00MF93PTAwMDAwMDAwIGZwLTQ4X3c9MDAwMDAwMDAKMTg6IChiNykgcjUg
PSAwCjE5OiBSMF93PXBrdChpZD0wLG9mZj0xNixyPTE2LGltbT0wKSBSMT1jdHgoaWQ9MCxvZmY9
MCxpbW09MCkgUjJfdz1mcC00OCBSM193PWludjM2IFI0X3c9aW52MCBSNV93PWludjAgUjZfdz1p
bnYoaWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkg
UjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBm
cC0zMl93PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMAoxOTogKDg1
KSBjYWxsIGJwZl9za19sb29rdXBfdGNwIzg0Cmxhc3RfaWR4IDE5IGZpcnN0X2lkeCAwCnJlZ3M9
OCBzdGFjaz0wIGJlZm9yZSAxODogKGI3KSByNSA9IDAKcmVncz04IHN0YWNrPTAgYmVmb3JlIDE3
OiAoYjcpIHI0ID0gMApyZWdzPTggc3RhY2s9MCBiZWZvcmUgMTY6IChiNykgcjMgPSAzNgoyMDog
UjA9c29ja19vcl9udWxsKGlkPTIscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSNj1pbnYoaWQ9
MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEwPWZw
MCBmcC04PT8/Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1t
bW1tIGZwLTQwPW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9MgoyMDogKDE1KSBpZiByNiA9
PSAweDAgZ290byBwYys0CiBSMD1zb2NrX29yX251bGwoaWQ9MixyZWZfb2JqX2lkPTIsb2ZmPTAs
aW1tPTApIFI2PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4
ZmZmZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1t
bW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0y
CjIxOiBSMD1zb2NrX29yX251bGwoaWQ9MixyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFI2PWlu
dihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKSBS
MTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1tbW1tbW0gZnAtMzI9
bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0yCjIxOiAoMTUpIGlm
IHIwID09IDB4MCBnb3RvIHBjKzIKIFIwPXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1t
PTApIFI2PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4ZmZm
ZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1tbW1t
bW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0yCjIy
OiBSMD1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSNj1pbnYoaWQ9MCx1bWF4
X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEwPWZwMCBmcC04
PT8/Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZw
LTQwPW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9MgoyMjogKGJmKSByMSA9IHIwCjIzOiBS
MD1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSMV93PXNvY2soaWQ9MCxyZWZf
b2JqX2lkPTIsb2ZmPTAsaW1tPTApIFI2PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2
YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAw
MG1tbW0gZnAtMjQ9bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9
bW1tbW1tbW0gcmVmcz0yCjIzOiAoODUpIGNhbGwgYnBmX3NrX3JlbGVhc2UjODYKMjQ6IFIwX3c9
aW52KGlkPTApIFI2PWludihpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7
IDB4ZmZmZmZmZmYpKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9
bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0KMjQ6
ICg5NSkgZXhpdAoyNDogUjA9aW52MCBSNj1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTQyOTQ5NjcyOTUs
dmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2PTAw
MDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZwLTQwPW1tbW1tbW1tIGZwLTQ4
PW1tbW1tbW1tCjI0OiAoOTUpIGV4aXQKMjU6IFIwPXNvY2tfb3JfbnVsbChpZD0yLHJlZl9vYmpf
aWQ9MixvZmY9MCxpbW09MCkgUjY9aW52MCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAw
MG1tbW0gZnAtMjQ9bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9
bW1tbW1tbW0gcmVmcz0yCjI1OiAoMTUpIGlmIHIwID09IDB4MCBnb3RvIHBjKzIKIFIwPXNvY2so
aWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFI2PWludjAgUjEwPWZwMCBmcC04PT8/Pz8w
MDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZwLTQwPW1t
bW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9MgoyNjogUjA9c29jayhpZD0wLHJlZl9vYmpfaWQ9
MixvZmY9MCxpbW09MCkgUjY9aW52MCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1t
bW0gZnAtMjQ9bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1t
bW1tbW0gcmVmcz0yCjI2OiAoYmYpIHIxID0gcjAKMjc6IFIwPXNvY2soaWQ9MCxyZWZfb2JqX2lk
PTIsb2ZmPTAsaW1tPTApIFIxX3c9c29jayhpZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxpbW09MCkg
UjY9aW52MCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1tbW1t
bW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0yCjI3
OiAoODUpIGNhbGwgYnBmX3NrX3JlbGVhc2UjODYKMjg6IFIwPWludihpZD0wKSBSNj1pbnYwIFIx
MD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1t
bW1tbW1tbSBmcC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbQoyODogKDk1KSBleGl0Cgpmcm9t
IDI1IHRvIDI4OiBzYWZlCnByb2Nlc3NlZCAzMSBpbnNucyAobGltaXQgMTAwMDAwMCkgbWF4X3N0
YXRlc19wZXJfaW5zbiAwIHRvdGFsX3N0YXRlcyAyIHBlYWtfc3RhdGVzIDIgbWFya19yZWFkIDEK
T0sKU3VtbWFyeTogMSBQQVNTRUQsIDAgU0tJUFBFRCwgMCBGQUlMRUQK

--------------271E180B87F56E08905C58D5--
