Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135304070A5
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhIJRqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 13:46:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhIJRqQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 13:46:16 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AHV4rM006219;
        Fri, 10 Sep 2021 10:45:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wy73wc4wkXR33XZESK9x6QtUKb6unOcFyrOCgYgSI6w=;
 b=LkHHH7ItNf+y9QpvR2VxFWAlZPIkpC6NhmG8qf0xVJNzJ4eyBFng0StUaYrwZhqps6fw
 mus8sq4rl/3CsnTHBG87+9oBD+7TEagxnN+22rbDEhgElLfuQ38fL6JwY42zA8PNAhqX
 RKZ5kqzCV+EbyoT0BfLp3dZC89cMPG1AAMA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgk6d72-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 10:45:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 10:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4kxZPIB8/HTeNnq4SfpnO5FlGOp6v+DTfwew4B04QnmS7UwZukxmX1rpt4xaSQTI2i7Ft79tdEybif+8JxapILcjbwmbQOrYOyZGPceR7cWPTWDJyckLIOSXe095dAEvN5KaCuvrTpot4nDC6hmt/C9veYajy+/wT4vy3Y0YpcPERR1seLldNw6dKJOSjBMGWTmBs4H6Gd0XPQ0gbXyYfsm3qJCIASE2DqSDMI6UEA6euVGJm7mpOVcqiZl0p2RsoGXcacLMNFQAFy+eCB5Ybi1vP7t4si3lC/icLaa931NYU1WsuHiD52GMIJ0GY8jicUESzW0K50hS1xkfyJclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wy73wc4wkXR33XZESK9x6QtUKb6unOcFyrOCgYgSI6w=;
 b=R4oJuPPdnVD55teQYyS6JHeX7TRgbhXk3Sa/F4pIotmMUqDekTHwpve9DhmrvoIolfnuU6jN0rzkQDwoF/XAynYk0hJYsJdTW3pL0Kl6Ow0cBrPyKYYSbc3SLHO3Oqq2O1+xfYTTQgXuo/cZl53GJPIGTAIORIng1NxEC6fAa4WozXDiEnv/b1NEQVxWEmeygHaF4F8vgtzObHadgEJaN8LqF2OdnIiQoItPGRh+kDwds9rVGzpSg71R0FClVjw+XThLDGPROZhUf0uvUY6gFZAxIo2SlzENF4ix12KwwS5yGx2gL8CkyDbhdqETbJyCG832OxFcJWuv/vGc98wSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2029.namprd15.prod.outlook.com (2603:10b6:805:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Fri, 10 Sep
 2021 17:45:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 17:45:00 +0000
Subject: Re: BPF_PROG_TYPE_CGROUP_SOCK bpf_sock ctx member direct access and
 BPF_CORE_READ return different values
To:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>, bpf <bpf@vger.kernel.org>
CC:     =?UTF-8?Q?Dario_Bara=c4=87?= <dario.barac@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
References: <CAOjtDRUnjONzDgtov-ugXejL-TUGwLgyQ50Q1uJqFSH=1q0QUg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c66fe63f-ee85-981b-ef2e-349c70f0cd7a@fb.com>
Date:   Fri, 10 Sep 2021 10:44:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAOjtDRUnjONzDgtov-ugXejL-TUGwLgyQ50Q1uJqFSH=1q0QUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by BYAPR07CA0031.namprd07.prod.outlook.com (2603:10b6:a02:bc::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 17:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cba246d-2f8e-430b-2cd6-08d97482b627
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2029:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2029BDF26ADAECFE163290BDD3D69@SN6PR1501MB2029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11lZIid2ItylKiuPmsWKin37c37JF80bpu+vP3hQPQ2hlhbu+NUt0YeXwx5jBqA+IfOHk9TtBDw+hJsuQ+0XJW8simWrgH1VO7HPz7PKsFXCAd4lGHbgrLbkEP6q4MeVeLuA9A5IglvS14oBh+hHhOWxMp5Zhml/vCpcrRU6axAEq3yS61vj6mzsq0BLVOANhmOCbN/SMAY+6c1Zkmj7x4GbFcu5004kIVt1gW/2vFeqZ6kzediNl1dkTrcPyaJimNtZa8AIOs01oeOw+QB41gnPiLfA5ocFeu86DE3vUY8VeV7Z1tIp3Zs99GRVjJhqwo/9+Ajx5nnkDuyHh6UuLdZtbjBf+xPPYx9T8BwOJHsUDrY9IPx3Oq7jK211v60Q+aL4nkzYb3IbFSaIsjBH03Cg3surRWL1dMclc3UiPapkcXgkNHA+TOZQiVSObspSKITCwrJ2i6D46LitSx7zckqUXOTral3JYAPf1bX6IyyBMGV0nB9oonFzHKyz+K/cH/rRJM+dn2H+NJZHIYqV2VW6abK1l1/RwCWPnfS4SPycEzK/1MjJLAc+UKvyI86EY6WIZ6frHWzPRIJl68kWr2P7/am18bIQ6IeQJnw0emkMpQbpiiZBhYBIySBRkUfmWKWmWpnQJgRe3Q7EEDGQoUcRQBeep38uOdNohVnw9eZeb/5ZN8wxAG5hq3H4DHMURCzvvywPCId7Bijfyh1Qt7wJvgf5AwRGWyuW8+S4INY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(110136005)(2616005)(54906003)(52116002)(36756003)(53546011)(5660300002)(8936002)(8676002)(83380400001)(6486002)(186003)(2906002)(66946007)(86362001)(66476007)(316002)(38100700002)(31686004)(4326008)(478600001)(66556008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDgzUWxUcjMzaDhjY3p5eGZYYUpBR3BSU3pETVo4KzVnMHZ2OW1vampoUXlR?=
 =?utf-8?B?N3FtcU42dk5GMEJScE5EanBoQU9aNnBENEpQWDg2YVRYMWM3aTNIQVQ5ektJ?=
 =?utf-8?B?L3VhVWFFeS9BVnBEV3VOT2VGUzc2VUtBUnVQWWVBNnc3SC9JVkxxanRrN3dk?=
 =?utf-8?B?dW1wdGdxNkJOL2k0QXg5VWJrYVB4eVhSTE9JL1pHTmxlSmFjUm9VR1B5Q1RE?=
 =?utf-8?B?YkIvWERZWTRxeU81OUc2MDJJSWdDWUVieS9JZW9iUENpTlpTNUU4R3E1cXlJ?=
 =?utf-8?B?T3BMNGhiY05Xdmk1dXBRTmFVYjNoODZnMkx3dmwyeDRVT0NTVWg1cXFvdDNK?=
 =?utf-8?B?VExycTBkclNvNitzMzJ5dTVGeXVkc0RNdmg0SStkZnlXNUN1KzJ6M0N1QzA0?=
 =?utf-8?B?eHlheExwMlROdEs0c2ROUm9hNW1uYTZvOVV5eFk4LytJNkdaZ2VVL2FnYndn?=
 =?utf-8?B?TzJLdThRelQ3bVliSW9IUzVsMThSMXFXbDIwelk4VjlGWWpmRE9FSFFwaHdq?=
 =?utf-8?B?TWlnUjltd3l0eTVrbnVVUFZmajBxVS9oRUVnYW9XN0hnZUpPSm9Za3Vib1Jx?=
 =?utf-8?B?RFZKbnNWb1N6SU1GUXowUE1tY05WbFoyVmhzbVFHOVNaQTM4ajRSR3R0UzFT?=
 =?utf-8?B?WEdnOWFrdTcva2pQQ1dmbEg3V0lYR0h0eVh3cnBYY3NHNEkxaG1sQ1I3K3hk?=
 =?utf-8?B?c0pEcFhoa2gyS3RtdlJhbm13N056L201aURkR1pKamh6YWRKb0YyLzNLNWdG?=
 =?utf-8?B?UklqSFZoRTNjVko0OERxQUpVbGZsbUFabTUxZ0V0eHlVTEROdlJrYzE1TndC?=
 =?utf-8?B?Y3BMT2M4NEZORWY1OWhGR1ZLb2I5L3FoeXdPNFIzT0RCTXN0ZkEwRzRJZ0N1?=
 =?utf-8?B?MHBUSFRsWGk3d3hWVGNGbUVuRlk2bEdrTmorU1YySFgycG00T3U5ckhvWURZ?=
 =?utf-8?B?THVaQlI2U3Rta1BlQmhhb0VqNUxyNDRjY3MvanNPN0FWQUdtai9WZTNnTkxj?=
 =?utf-8?B?OWZMSVg5QUE5bjdoQnVHcGpoVjBjTzJhaDFRMWR2dXZxMU4zKzJ3Mm5NeVNP?=
 =?utf-8?B?b2I0aWZOUFJTTC90WllSZmFWaXE4cmtLZXpSbWdaM3oybjJTUk5EZU1Rb1F1?=
 =?utf-8?B?QkNKRzRON1RRc1lzTmI0bUZzRUdwTWo1YzFmc3NZL0phNGI4dGlFSjJ4UGlj?=
 =?utf-8?B?R002ZHJmMHZ4WGs1a2FYVys3K21BVURjdklQQys4THIwQWlNejRLRm40RnZQ?=
 =?utf-8?B?L0phYlVNQmxiY2toRG9pREx2WWQ1TzdIdGR1YU1qQUYrdXd0d01XUUJCOEZQ?=
 =?utf-8?B?MkxqdzlWdDl5dlpPRTF2TDlNUEtXaFJJSlVBRmZpbFQ5RWZuajZ0MDQyZmgy?=
 =?utf-8?B?cUk0dXhTZ0o1WXJKZkN3SUZTRXA1cDcxZXBWUEswWjJvZ1dDSkJRNXBKWlc3?=
 =?utf-8?B?dnNBaWVSQ3Nham91TjUvK1dmVjFRbFBoSHJkempsT25IcWZaZURPLzNoWUY5?=
 =?utf-8?B?K2sxcGVaWkdyRzJRcTNHdnBMTEo3Z3dUVkwzRGhSbGtzemN5ck1xTU9rT1hj?=
 =?utf-8?B?bTMvaUlRQk9CQ2RpaWpFUHZPclZRWXdnQ25TMjdDWmZhL3h3NTJvZFpnUkhB?=
 =?utf-8?B?R3g1Z05EeDV0QllOTktialBxVnNJQzdpT0NYTFcxOElTZ3dqY3k0Mkprck1t?=
 =?utf-8?B?bU94MzA3QXFVeEYraEdrUmU1UjAyalpYYXI4eW5ManN0QnVINGFWVldLTXRl?=
 =?utf-8?B?UXVMbFdORlFoeUkzeDh2dkJkTEw1eEdyZSt4RDB0bm1qMDR1MEwxdVAxcStB?=
 =?utf-8?B?OXhHNklLZ3A4ZnByeVp0dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cba246d-2f8e-430b-2cd6-08d97482b627
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 17:45:00.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv1YXXSz9IzSjRZVCr1VaMy9cIwMesC9lAIk5ZPPefGHjyy9CkswPDn0GIGQ0QBW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2029
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Gdl_oZ0Lo0bsAPaanwWRRwbL_hY_-Z_c
X-Proofpoint-GUID: Gdl_oZ0Lo0bsAPaanwWRRwbL_hY_-Z_c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/10/21 8:36 AM, Juraj Vijtiuk wrote:
> Hello,
> 
> while developing some cgroup socket programs, we have noticed that
> some BPF_PROG_TYPE_CGROUP_SOCK programs return different values when
> the bpf_sock context is accessed, depending on how they are accessed.
> One example of the issue would be access to ctx->family in programs
> that attach to BPF_CGROUP_INET6_POST_BIND and
> BPF_CGROUP_INET4_POST_BIND. A direct ctx->family access returns the
> correct value, while BPF_CORE_READ(ctx, family) returns random values.
> The BPF C program and an example userspace C loader are attached
> below, with an example trace_pipe output.
> 
> So far we have looked at the generated BPF byte code with llvm-objdump
> and everything looked fine there, the main difference being in the way
> the access is done, as expected. The BPF_CORE_READ macro expands into
> a bpf_probe_read_kernel() call with arguments wrapped in
> __builtin_preserve_access_index. bpf_probe_read_* helper calls are
> supported for BPF_PROG_TYPE_CGROUP_SOCKS so that shouldn't be an
> issue. Next, we looked at libbpf debug output, where everything looked
> ok too. The part of the output with relocations is attached below.

This is an incorrect usage of CORE. See below.

> 
> We have tested this with various kernel versions, including 5.10, 5.11
> and 5.13 on x86_64 and 5.11 on 32 bit ARM. The issue appeared on all
> of those kernels and architectures.
> 
> At this point we're not sure what to look at next so any ideas on what
> might cause the issues or suggestions on what to test next would be
> greatly appreciated.
> 
> Regards,
> Juraj Vijtiuk
> 
> example.bpf.c
> ----------------------------------------
> 
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_core_read.h>
> 
> SEC("cgroup/post_bind4")
> int cgroup_post_bind4_prog(struct bpf_sock *ctx)
> {
>      u32 family1 = 0;
>      u32 family2 = 0;
> 
>      family1 = ctx->family;
>      family2 = BPF_CORE_READ(ctx, family);
>      bpf_printk("family1 = %u, family2 = %u\n", family1, family2);

We have assembly code below:
        0:       b7 02 00 00 04 00 00 00 r2 = 4
        1:       bf 13 00 00 00 00 00 00 r3 = r1
        2:       0f 23 00 00 00 00 00 00 r3 += r2
        3:       61 16 04 00 00 00 00 00 r6 = *(u32 *)(r1 + 4)
        4:       bf a1 00 00 00 00 00 00 r1 = r10
        5:       07 01 00 00 e0 ff ff ff r1 += -32
        6:       b4 02 00 00 04 00 00 00 w2 = 4
        7:       85 00 00 00 71 00 00 00 call 113
        8:       61 a4 e0 ff 00 00 00 00 r4 = *(u32 *)(r10 - 32)

Looks like they are the same one insn #3 read context + 4
and another insn #7 also read context + 4.

But for insn #3, the verifier will rewrite it proper kernel field,
         case offsetof(struct bpf_sock, family):
                 *insn++ = BPF_LDX_MEM(
                         BPF_FIELD_SIZEOF(struct sock_common, skc_family),
                         si->dst_reg, si->src_reg,
                         bpf_target_off(struct sock_common,
                                        skc_family,
                                        sizeof_field(struct sock_common,
                                                     skc_family),
                                        target_size));
                 break;

and this is not the same for insn #7.
That is why they have different results. The CORE is used for accessing
kernel data structures, the "ctx" is not really a kernel data structure
(rather a UAPI interface) in most cases.

> 
>      return 0;
> }
> 
> char LICENSE[] SEC("license") = "GPL";
> 
> example.c
> ----------------------------------------
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/resource.h>
> #include <argp.h>
> 
> #include <bpf/libbpf.h>
> #include <bpf/bpf.h>
> 
> #include "example.skel.h"
> 
> void read_trace_pipe(void)
> {
>      int trace_fd;
> 
>      trace_fd = open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
>      if (trace_fd < 0)
>          return;
> 
>      while (1) {
>          static char buf[4096];
>          ssize_t sz;
> 
>          sz = read(trace_fd, buf, sizeof(buf) - 1);
>          if (sz > 0) {
>              buf[sz] = 0;
>              puts(buf);
>          }
>      }
> }
> 
> int libbpf_print_fn(enum libbpf_print_level level,
> const char *format, va_list args)
> {
>      return vfprintf(stderr, format, args);
> }
> 
> int main(int argc, char **argv) {
>      struct example_bpf *obj;
>      int err = 0;
>      struct rlimit rlim = {
>          .rlim_cur = 512UL << 20,
>          .rlim_max = 512UL << 20,
>      };
> 
>      err = setrlimit(RLIMIT_MEMLOCK, &rlim);
>      if (err) {
>          fprintf(stderr, "failed to change rlimit\n");
>          return 1;
>      }
> 
>      libbpf_set_print(libbpf_print_fn);
>      obj = example_bpf__open();
>      if (!obj) {
>          fprintf(stderr, "failed to open and/or load BPF object\n");
>          return 1;
>      }
> 
>      err = example_bpf__load(obj);
>      if (err) {
>          fprintf(stderr, "failed to load BPF object %d\n", err);
>          goto cleanup;
>      }
> 
>      const char *cgroup_path = "/sys/fs/cgroup";
>      int cgroup_fd = open(cgroup_path, O_DIRECTORY | O_RDONLY);
> 
>      struct bpf_program *prog = obj->progs.cgroup_post_bind4_prog;
>      obj->links.cgroup_post_bind4_prog =
> bpf_program__attach_cgroup(prog, cgroup_fd);
>      err = libbpf_get_error(obj->links.cgroup_post_bind4_prog);
>      if (err) {
>          fprintf(stderr, "failed to attach BPF program %d\n", err);
>          goto cleanup;
>      }
> 
>      read_trace_pipe();
> 
> cleanup:
>      example_bpf__destroy(obj);
>      return err != 0;
> }
> 
> trace_pipe output
> ----------------------------------------
> Chrome_IOThread-26477   [006] d..2 385580.114654: bpf_trace_printk:
> family1 = 2, family2 = 1747691712
> <...>-144100  [004] d..2 385594.936690: bpf_trace_printk: family1 = 2,
> family2 = 0
> 
> libbpf relocation log
> ----------------------------------------
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: sec 'cgroup/post_bind4': found 2 CO-RE relocations
> libbpf: prog 'cgroup_post_bind4_prog': relo #0: kind <byte_off> (0),
> spec is [2] struct bpf_sock.family (0:1 @ offset 4)
> libbpf: CO-RE relocating [2] struct bpf_sock: found target candidate
> [24518] struct bpf_sock
> libbpf: prog 'cgroup_post_bind4_prog': relo #0: matching candidate #0
> [24518] struct bpf_sock.family (0:1 @ offset 4)
> libbpf: prog 'cgroup_post_bind4_prog': relo #0: patched insn #9
> (ALU/ALU64) imm 4 -> 4
> libbpf: prog 'cgroup_post_bind4_prog': relo #1: kind <byte_off> (0),
> spec is [2] struct bpf_sock.family (0:1 @ offset 4)
> libbpf: prog 'cgroup_post_bind4_prog': relo #1: matching candidate #0
> [24518] struct bpf_sock.family (0:1 @ offset 4)
> libbpf: prog 'cgroup_post_bind4_prog': relo #1: patched insn #12
> (LDX/ST/STX) off 4 -> 4
> 
