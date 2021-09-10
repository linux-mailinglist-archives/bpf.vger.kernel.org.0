Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04359407074
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhIJRVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 13:21:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231314AbhIJRVG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 13:21:06 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 18AHDx7p018893;
        Fri, 10 Sep 2021 10:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F5Neh/c70aYa4hw0Q3dzjfUvKE1XNGt76hAU6fGjd24=;
 b=fiqO8K1xrhKelZHrsjsyeMwvO3sYhFcI9KkQ0pE7ifc5JeCmK1PFwgBaaLgvB9oXeI0F
 0NAFbxV25ohrCjEbZ+Hi1jJVfEoqcBRhjJgpS/oCQzqpV5Hvdo3suZb12XtiIUeUsoRn
 jPNcRH1TXTHlVDciws2DoQg1g4B3xXJysH8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b0agg0pc1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 10:19:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 10:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD9hVli9SKCiqnFD9/CoW4HqBtavRpgkudXX0ev+aGQVygkr3T0N9pdrkt59os+kb3XT82SqmDr9wGaIQvJ5eSoCWNTS4lzsa8bq1wrjPk/4S1zqssOvJgqhvXhwAelgEor83gIfFuYthwKZ2X5+QVZGFjk96QoECAJ1onLhkjtOK4k6UNFMnwLa9exau10g9A6Ty34FnZ+QFiagsZ6ffCfCGj2OfXunXgZlJHtWUFPs0V9LNuE6CAgycQZAdqUARXv47J+va+NvF0WFdWM1y7RQYvAChBeaNdiYASML3Z/ivL7RuahMajT3Lt3ghingpdWRx+qj0VxfEq9KUbwlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F5Neh/c70aYa4hw0Q3dzjfUvKE1XNGt76hAU6fGjd24=;
 b=BUCH3kYYMn9slKIyF9ceht1+4duLlOazrdxoQEHI+kFKB3j2g7p0DeWtPR2avy3i2c1c/hzcAZuBRCf8+cKgRdTvts1FkhG+uHJZtClR4eybklu+aQHn7n+lLpgQOpvYCQEuU1cYDSorEiNP14GUhPfa4T5Nb6ZIsNo2IBoZH5MaIf3TkidWkfHhpBjpsMP90kzdavvLXiwNiR35aZCXosV1Qtva7Yz5ld9xGY2jeT5+/B9PT9JEAklbZRCWGTsC1FrmaeMc2X+nttXiA0YDinB1lzd4qpczuNp+ZULxkcMWjBzrUXZk0AyyGdM3nu7A8wuHOTVn/2o9ckOcvPmMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2478.namprd15.prod.outlook.com (2603:10b6:805:1a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 17:19:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 17:19:34 +0000
Subject: Re: [PATCH bpf-next] bpf, selftests: Replicate tailcall limit test
 for indirect call case
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Chaignon <paul@cilium.io>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20210910091900.16119-1-daniel@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <85502a8b-49c0-80a9-9e68-1102b2e32ea4@fb.com>
Date:   Fri, 10 Sep 2021 10:19:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210910091900.16119-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Fri, 10 Sep 2021 17:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c4988d2-f4a3-4ccd-c5c4-08d9747f286e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2478:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2478178A6BA6D2B72138A3BFD3D69@SN6PR15MB2478.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7WICNvzXC47iTcr7QT7XomGNgu290OEh9a5fK2KxJDqLC2lvkKIYEkA8UEM+NVraTMIIUbIoXDKsFFBAXYWbDDlVImCdAfQ0rRmoSTMTOMvVA0nHIqGdIdj4JoioOSyTyIuU1jxViZ+pEeQkbrS83r5VRYapYf3AhLRugKooAx/UDbzn70m2Xz6fUMeVD+2kAYSjvxbFqNZPbJHCnk/IMfL/O7Oc20esp4dSAFZKfr9JjcdXUBMZFG47i90i7D9SoWGYYLlYuxgxh5FCWHETXS+caBQVRBfvoeJrEWFl+F8HQQIs29aK1ogRsWGMp2Os1SQUPac2l1YCMXgS/tdFSeAXP7JvWs5rTfWoZGXk68NJMncA9BncJ6B4YLihSd+mAp+dKYOYPDAq6vlOcZ8Xw5oBlGmBY4p1DnfAMVgkIanyRsDCDYEunlIJXkQXALCvci9K5H2Th+Hd9cm0xmcAaGeTpgIoO0q20ktt9lctAWjzvvR1yipouFlpjfwpmkSvROFurMllPhS9kgDvYQFMLJHcuQ5BtLZnMeB/KbunC2mstxro1oQpREFuZDpvEkWaeNLmywi+CVPNYfvzZhtpO86vSk+2bTO+JH8cciw+cgX+TcHlwm+ZuI1+X6OnNgRSmcfdoyJ0Vvnzhp6NFUI1DKvMHaqS8Rjj1CZuX4kMbxvnNzRFsla5KkHVqnQEJSkiRIjzEPiIDD3tKDYxWHfmyBeShX+uFm4zVeXOpyvLUG2J6+wzSwfvUdI6UqpjHIosXnf5/oFStbKx600D+umf1StOqfGY/7WVZZsvD+ibVHfqxuUOvO0lqL0Z2tTo4Ax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(83380400001)(6486002)(31696002)(478600001)(54906003)(2906002)(8936002)(86362001)(36756003)(31686004)(38100700002)(5660300002)(53546011)(52116002)(186003)(2616005)(316002)(966005)(8676002)(4326008)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRad2xwMXZuYkdickxDd29rQTVVOE9OM1BNSk9BMmVsRVU4RW9hb2dnOWZH?=
 =?utf-8?B?Zi9yd0dVYUd0SWdxWUxBQnlnOWIxU3hZbUIxRWg3UmZWWHB5U3VvckpKaEg5?=
 =?utf-8?B?WVV4OGJUU2JHc3FVay9xWERZcHhYY3Fad0Mrc0U2Z2Y2YXdseWtsN1ZwaVdN?=
 =?utf-8?B?ZTJMVm5rL3lQaGxuMnFreWVyN0NpYUd1eXZNZTdTZ0FERnZJMUp6OW01Q1cx?=
 =?utf-8?B?MmNadG9ITzh5NmJnWWw2Q1hwRndCMDBvempZL0VrbytnbmlFVjdoblc1UC96?=
 =?utf-8?B?Q2tVcEFJVGVGMXhwdFFEaGxXY3JqZ1hxdWJqd1lhZ3FuUGRpUnpzZkpuOHhI?=
 =?utf-8?B?RDB6YlIzYmNpd2c4V2RoQWFOYjUyNG9rVkRWUGxFRGZoMWhNbi9NYm9GM3BR?=
 =?utf-8?B?TkdoOEpyNjB4K0VjZThLWisrc2dCZ2xSMGo0VitNd21wU292RFM4RUQ4L09v?=
 =?utf-8?B?UmRIYnA5WnVHNm1qUzRCaDBnd29PbWhTTVE1QU9kUW8zY3NGTkU5djN3UUtm?=
 =?utf-8?B?Q1hWc3hnTzR5dUFtNUs0YTJZOGpGY0pNV0VyQlVoYmhWcVlJanZtamRKa3NN?=
 =?utf-8?B?QksvZDloa1dHYzJrQlpGTENBUHA5N2NBNzk1YmRkSnlndzlxb1h3T3R3N3Ry?=
 =?utf-8?B?cWpYYWZpT3QwU1k2a0VSRkJHUGVvMU5ubVdxVWdXdHNUbHpwaGtNdk0zbkRJ?=
 =?utf-8?B?YXNBaWNQMXdMUUdIWTB2MWZPbXcyRGpRODVmYWwwTDI3RXRsY3JnSDh1T05L?=
 =?utf-8?B?TGhRM0JRM3NKWDVxSmhzc1pISVgwRUJyZUJWdjFtaTIraTB0VXk1UjhHSUVV?=
 =?utf-8?B?MmpUaTRVaVhheWpqUFgwRkM1eXlBSW95UDVuUHpXVWpSTTZTQy96RDRiWVNm?=
 =?utf-8?B?ZnU2TjZJcUROWG1pL0ZOdS84c0U2NzdrOFlpYVpkZW5vZDRyd1FMU1Q0a1gy?=
 =?utf-8?B?ejY5SVRnOFRsTVhMWW0zdXRBSE5WaHR6eThtb0pFWjZaZC9kdm1MbU5mcFpU?=
 =?utf-8?B?VStncGU3NWNyZXllMzlUOWtWVnpvWXIwb3J6cENMQVU4bm1mS2ttalFkR0Qr?=
 =?utf-8?B?SUt5TXNyOFBDQndVdE5hc29XdTdaeEpCa2Y5NU1pMWFRdlB5dmxBandlMVpX?=
 =?utf-8?B?Zm9OS21BdUhXazlOdG5NSkdwRW1Ubm51Tmh1TkJzRWdPZTVHMTdQdzRkRFlK?=
 =?utf-8?B?OTcxVG42eFVTME9qcTh6bVBiMW52UkYyM2V2NE93dkxvT0pCOGQ5alY3Zk9J?=
 =?utf-8?B?UUM1TTVVcWhETEtMckp6cU1mVEJsTjFOdmkwaFBBay9NTGpGa2NzcldSUGd6?=
 =?utf-8?B?Y0FpeDc5RXNFL01VMXhoWGVtcFZOVnBOUWtaRTVIWjhuUEpMVWQ4OFdoc1M0?=
 =?utf-8?B?bUI1UzErdkRJSFlmZkUrOUI4MXYrRTBnQnNiUGZEUGo2VWNHN1cwYVcwMzU2?=
 =?utf-8?B?d1lyK2Zoa21WbTErSS8wN0s5N1lKb1ZabFlwUlkrNVNFQWIzRjhwa1JGTm9F?=
 =?utf-8?B?T2wvTFFWUElxNVcvY3BwdFFEVm9yWTlNblBkSFdtSVk3QXgvaDBnSlRWL2FQ?=
 =?utf-8?B?SHJxL29DckJKQkt2MS9KLzc0dXcwVmxubEtkYlFaYnhhTmFVaHNMb0dMY0RG?=
 =?utf-8?B?YnlKTmJHNWIyRTh6YW8wMmhiSzArZjJ4Q3Q4dWJrNlB3NWZhTDZXZW9XMHVs?=
 =?utf-8?B?b1JMQzJjOUcwKy9VR0U3SU5BMmFiUWg3SGJVTHhucnlmYkh1TWkraTJYbWZC?=
 =?utf-8?B?bWdOSElwMUEzK2hqeitRUk11TzNXNjVFYVVReDJFK1JCNlVsSm1McXVZK2Vo?=
 =?utf-8?B?NDQ0eWN0VzdaajBYeWlkQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4988d2-f4a3-4ccd-c5c4-08d9747f286e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 17:19:33.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXgPsYzH3tQbeTldQoIjQeC07eLMOk2aJIUppp/BIRylweDd24x/IjGk9VxF2LjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2478
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: otWxRnMfTV15o24ZDbYAhC4zNILJ_QxI
X-Proofpoint-GUID: otWxRnMfTV15o24ZDbYAhC4zNILJ_QxI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/10/21 2:19 AM, Daniel Borkmann wrote:
> The tailcall_3 test program uses bpf_tail_call_static() where the JIT
> would patch a direct jump. Add a new tailcall_6 test program replicating
> exactly the same test just ensuring that bpf_tail_call() uses a map
> index where the verifier cannot make assumptions this time.
> 
> In other words, this will now cover both on x86-64 JIT, meaning, JIT
> images with emit_bpf_tail_call_direct() emission as well as JIT images
> with emit_bpf_tail_call_indirect() emission.
> 
>    # echo 1 > /proc/sys/net/core/bpf_jit_enable
>    # ./test_progs -t tailcalls
>    #136/1 tailcalls/tailcall_1:OK
>    #136/2 tailcalls/tailcall_2:OK
>    #136/3 tailcalls/tailcall_3:OK
>    #136/4 tailcalls/tailcall_4:OK
>    #136/5 tailcalls/tailcall_5:OK
>    #136/6 tailcalls/tailcall_6:OK
>    #136/7 tailcalls/tailcall_bpf2bpf_1:OK
>    #136/8 tailcalls/tailcall_bpf2bpf_2:OK
>    #136/9 tailcalls/tailcall_bpf2bpf_3:OK
>    #136/10 tailcalls/tailcall_bpf2bpf_4:OK
>    #136/11 tailcalls/tailcall_bpf2bpf_5:OK
>    #136 tailcalls:OK
>    Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
> 
>    # echo 0 > /proc/sys/net/core/bpf_jit_enable
>    # ./test_progs -t tailcalls
>    #136/1 tailcalls/tailcall_1:OK
>    #136/2 tailcalls/tailcall_2:OK
>    #136/3 tailcalls/tailcall_3:OK
>    #136/4 tailcalls/tailcall_4:OK
>    #136/5 tailcalls/tailcall_5:OK
>    #136/6 tailcalls/tailcall_6:OK
>    [...]
> 
> For interpreter, the tailcall_1-6 tests are passing as well. The later
> tailcall_bpf2bpf_* are failing due lack of bpf2bpf + tailcall support
> in interpreter, so this is expected.
> 
> Also, manual inspection shows that both loaded programs from tailcall_3
> and tailcall_6 test case emit the expected opcodes:
> 
> * tailcall_3 disasm, emit_bpf_tail_call_direct():
> 
>    [...]
>     b:   push   %rax
>     c:   push   %rbx
>     d:   push   %r13
>     f:   mov    %rdi,%rbx
>    12:   movabs $0xffff8d3f5afb0200,%r13
>    1c:   mov    %rbx,%rdi
>    1f:   mov    %r13,%rsi
>    22:   xor    %edx,%edx                 _
>    24:   mov    -0x4(%rbp),%eax          |  limit check
>    2a:   cmp    $0x20,%eax               |
>    2d:   ja     0x0000000000000046       |
>    2f:   add    $0x1,%eax                |
>    32:   mov    %eax,-0x4(%rbp)          |_
>    38:   nopl   0x0(%rax,%rax,1)
>    3d:   pop    %r13
>    3f:   pop    %rbx
>    40:   pop    %rax
>    41:   jmpq   0xffffffffffffe377
>    [...]
> 
> * tailcall_6 disasm, emit_bpf_tail_call_indirect():
> 
>    [...]
>    47:   movabs $0xffff8d3f59143a00,%rsi
>    51:   mov    %edx,%edx
>    53:   cmp    %edx,0x24(%rsi)
>    56:   jbe    0x0000000000000093        _
>    58:   mov    -0x4(%rbp),%eax          |  limit check
>    5e:   cmp    $0x20,%eax               |
>    61:   ja     0x0000000000000093       |
>    63:   add    $0x1,%eax                |
>    66:   mov    %eax,-0x4(%rbp)          |_
>    6c:   mov    0x110(%rsi,%rdx,8),%rcx
>    74:   test   %rcx,%rcx
>    77:   je     0x0000000000000093
>    79:   pop    %rax
>    7a:   mov    0x30(%rcx),%rcx
>    7e:   add    $0xb,%rcx
>    82:   callq  0x000000000000008e
>    87:   pause
>    89:   lfence
>    8c:   jmp    0x0000000000000087
>    8e:   mov    %rcx,(%rsp)
>    92:   retq
>    [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Cc: Paul Chaignon <paul@cilium.io>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Link: https://lore.kernel.org/bpf/CAM1=_QRyRVCODcXo_Y6qOm1iT163HoiSj8U2pZ8Rj3hzMTT=HQ@mail.gmail.com

Acked-by: Yonghong Song <yhs@fb.com>
