Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F5301867
	for <lists+bpf@lfdr.de>; Sat, 23 Jan 2021 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAWUqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Jan 2021 15:46:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbhAWUqw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Jan 2021 15:46:52 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10NKiRa9027414;
        Sat, 23 Jan 2021 12:45:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FiZgng/APoPHuB/XZUR/xbBjA+PRGwzDG+60dpYCWPo=;
 b=R/9H4q72B/SrWmv00kpT4DmuQBb5TgLs2KbIDFF4OzxpWLU2ovskPKF920rKTdbqJvMr
 x+j92Igatxd2Mdi5s21bTHKATwgV69O+i4FqTWvb1v+5JDljPWDAAq0+xemPGEhxwcgd
 icm8CyokyanTFjG2XnKbry0ljDk1sgCJKrw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 368hssstee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 23 Jan 2021 12:45:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 23 Jan 2021 12:45:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqPa2Nu6AouUHBu3F/RlzlDB58szrX8dPjhUw52QvhoL04yE8EOLz1fFZ4Qx8+lpDREDsKMD1OS1Wp6BX2DVLE7r2hZ5u1Aw7RZKm87U7c/2NRGFeb95d9XVrV82//EYtqWvzGgVVMV5hrz9fwc7XfLIPbptssQTqkLbhhjw1gOLdCA/kbp8FeHwsP17c8FQoG0NPz8T2K4fP7ethmwSxUm9sZYlgkUbEyNDeoOw/BAnwHAvER4D2iY+CeLxDywyO4aXOTt5EDLDAj2V5pKgiK8SN56vBoaJIjh/IUEGL5LV8rKFUJrNYUaSQcoyPKn6IytTQwP10ObfQ+TeqQqa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiZgng/APoPHuB/XZUR/xbBjA+PRGwzDG+60dpYCWPo=;
 b=m0QPLyghULzUs3emasR8o7htg5/pPuuODODTOd/oSdDACnQwbWbQOmQ8nppWEydZK+CfR+dTh5y+0XuuTmu1oCRhIoU/LTSH7eQPva9pQ39OIKILFWuHfhWrT9zQdC/uj9QMded3mUVW7XNTezKa9Dwha+uxfxB5K+1YzjK9+kVu3s4CYvy9iwq135sfPL+dFeh91O3fLD6vdSBOzGdfp1qtJxDOw1YL5JQFF1FSvD2ii7QeC/RIL0vwzG6yDbpWCr7MxYCTN3k7laWB2v/fByDJBlYcb0TzHyjvf2h23/OczUOpIEGC6a8Z3jQpcWdLsE0DMn3ljmGWOHVM1FrNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiZgng/APoPHuB/XZUR/xbBjA+PRGwzDG+60dpYCWPo=;
 b=ImGLQ4Y49mOklQzp7Bq7cfx3OQoghqObAAd50NQSF+tuMVQzsEX/oobCjoorwooT81VPWie0UDcerC3eimAwbt+mo6ayQva77uTmS4Pj3vdeq5kMbVI5B9oNXZ5vXWf6PK+UoXaHbSSalJbehrEkm+Lnlnq4xxoel4wNCmGlZAI=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Sat, 23 Jan
 2021 20:45:49 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.013; Sat, 23 Jan 2021
 20:45:49 +0000
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the
 tracing bpf_get_socket_cookie
To:     Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210119155953.803818-1-revest@chromium.org>
 <20210119155953.803818-4-revest@chromium.org>
 <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
 <CAADnVQJqVEvwF3GJyuiazxUUknBUaZ_k7gtt-m18hbBdoVeTGg@mail.gmail.com>
 <CABRcYmJ1jOgV2Ug6sKxbq4ZnaGFLvGLwCPmhrAYdaRh6oY-o=g@mail.gmail.com>
 <CABRcYm+cWobt9yd-2k8nx+19wCZVniLszTcQRphq1soxQG0jdg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <93be5434-58ca-1e3b-d7dc-7ae079381104@fb.com>
Date:   Sat, 23 Jan 2021 12:45:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CABRcYm+cWobt9yd-2k8nx+19wCZVniLszTcQRphq1soxQG0jdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:250c]
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1946] (2620:10d:c090:400::5:250c) by MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Sat, 23 Jan 2021 20:45:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa15724-c9c2-47ce-8520-08d8bfdfdda6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-Microsoft-Antispam-PRVS: <BYAPR15MB226338DE15A76EA326C9D6D4D3BF0@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6JR48lRAZp2sjsVWV29GawzYcDS6aUXqtalcRWhCAmIyrH3HlK9vn3vcu0niTGbNw2le9rWHtbAiEWREMTU8WkYbr0lFI23nK3Fic1IG6bOPC/8bP1yBsRhGTRU+dfyigB3xO65WXycXZ0F7ol+vsJP76N9RKCI+W1hVEQY2TTuRa7QctPKtA/0+DuyMpdgdbXqsudWJ9IOEqyLRm/wlfIBJzFLdegeiQ/FSuiXoSBdC5PqZ4x07Y9b4CZt4p9Kg5YhYzzrDH+1KJg31k1sCBG/iKN6yoHfNAa5bfnodbXp7xR8NA3fCqSKVDx2BJubW5bHl2gKrpmlDFvAN0hBxVcOw1IPNm/Rvb8PvIPifYngzvKpNoy5y1B5d5w2AMPjVd8+sSvKIXfs17VNixmY1cKdY/MucFTU4ITGdO6UWHfC0AUycc9Bf0cHmPmENRQmF3+EtK7PRjD2bqEGsQgGPceHeOZdUp3NFMk4Lw4TmJYo/JPk0Drh2ndEHhNmb5Gy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(31696002)(66476007)(186003)(8676002)(110136005)(31686004)(66556008)(86362001)(7416002)(6486002)(16526019)(66946007)(54906003)(53546011)(4326008)(52116002)(2906002)(8936002)(36756003)(5660300002)(2616005)(83380400001)(316002)(478600001)(6666004)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2IYAdCnqjtOhLvteTUgC/wwTbcDQT+yIzzWdZEvJGBt4irmiyslx6llyIwwThfD4POOnJia87aUW11cdiOIT5XyNDF7czPuxyRZ6ufhsrVNwboK/lyLBwsrjalTynYHIMi1+sLOvvEGXAgqH4ncPUY6o1Y6R2TGoNhjRw6Gz7dpGLfVPLrNdTubpKmhzN8YxSlcQYv6BSn5LNq/xAweRlbvJAlVr/R2/DnFncfgd7TCLTLfoIWIuYZBBP92Bd5+1VCU9MqVwTdtyoNOBxUJRsNB0qLdmNfG8ki1NNdtUbvFJTuUoG1As/cI10I+gIBVovAYJ7nrZejhT4csF2Pkl8tmDT6W8WK9zCLjtfsByk5TpBv8TGrkM+4FEDjlPOdZd7pArR2NJOcEg9F3ah0wQDMgMeaPZVdHI0gJE52OI6CVBwyxWp6Zy+JIHxrSriB2MokKsG65CLmqYUo1RbiHYePscKnd0eU491MCErebOj/g1RolO+6AVI6s74YbEQmYn6B76cDEph5C9uHOV5hf1UX4QbAMU5UPmyoLh8UO2RTTfvEf7HofdYbV6WFg2gEeTiGVjYllNAD4/Mku7GU4w9YGPJfrOUeiZ2z5A32mVfYE1PPwSXwxRkDqOsX1FzgtdFEE4TFGf8PAuy5G09BgCXfeqNujDNDrN0fxCWw7nYuu0iD6mwo6TNuDpcdzToLImttUyUP5pfoYphu1AmRo2A2nUnDRFHhqfxJNK2f00Fu4RtTdi6C0JVbrEDRj/y/KAmeeV/1GtkiPO+FFekS+c4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa15724-c9c2-47ce-8520-08d8bfdfdda6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2021 20:45:49.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzVp2CvxYsogXbsuNW3PV0qTLehlPefWpanU3Ywtw9ua9VSRBLHYThqPM1QobVGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_12:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101230121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/22/21 7:34 AM, Florent Revest wrote:
> On Wed, Jan 20, 2021 at 8:06 PM Florent Revest <revest@chromium.org> wrote:
>>
>> On Wed, Jan 20, 2021 at 8:04 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Wed, Jan 20, 2021 at 9:08 AM KP Singh <kpsingh@kernel.org> wrote:
>>>>
>>>> On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
>>>>>
>>>>> This builds up on the existing socket cookie test which checks whether
>>>>> the bpf_get_socket_cookie helpers provide the same value in
>>>>> cgroup/connect6 and sockops programs for a socket created by the
>>>>> userspace part of the test.
>>>>>
>>>>> Adding a tracing program to the existing objects requires a different
>>>>> attachment strategy and different headers.
>>>>>
>>>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>>>
>>>> Acked-by: KP Singh <kpsingh@kernel.org>
>>>>
>>>> (one minor note, doesn't really need fixing as a part of this though)
>>>>
>>>>> ---
>>>>>   .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
>>>>>   .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
>>>>>   2 files changed, 52 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
>>>>> index 53d0c44e7907..e5c5e2ea1deb 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
>>>>> @@ -15,8 +15,8 @@ struct socket_cookie {
>>>>>
>>>>>   void test_socket_cookie(void)
>>>>>   {
>>>>> +       struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
>>>>>          socklen_t addr_len = sizeof(struct sockaddr_in6);
>>>>> -       struct bpf_link *set_link, *update_link;
>>>>>          int server_fd, client_fd, cgroup_fd;
>>>>>          struct socket_cookie_prog *skel;
>>>>>          __u32 cookie_expected_value;
>>>>> @@ -39,15 +39,21 @@ void test_socket_cookie(void)
>>>>>                    PTR_ERR(set_link)))
>>>>>                  goto close_cgroup_fd;
>>>>>
>>>>> -       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
>>>>> -                                                cgroup_fd);
>>>>> -       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
>>>>> -                 PTR_ERR(update_link)))
>>>>> +       update_sockops_link = bpf_program__attach_cgroup(
>>>>> +               skel->progs.update_cookie_sockops, cgroup_fd);
>>>>> +       if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
>>>>> +                 "err %ld\n", PTR_ERR(update_sockops_link)))
>>>>>                  goto free_set_link;
>>>>>
>>>>> +       update_tracing_link = bpf_program__attach(
>>>>> +               skel->progs.update_cookie_tracing);
>>>>> +       if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
>>>>> +                 "err %ld\n", PTR_ERR(update_tracing_link)))
>>>>> +               goto free_update_sockops_link;
>>>>> +
>>>>>          server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
>>>>>          if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
>>>>> -               goto free_update_link;
>>>>> +               goto free_update_tracing_link;
>>>>>
>>>>>          client_fd = connect_to_fd(server_fd, 0);
>>>>>          if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
>>>>> @@ -71,8 +77,10 @@ void test_socket_cookie(void)
>>>>>          close(client_fd);
>>>>>   close_server_fd:
>>>>>          close(server_fd);
>>>>> -free_update_link:
>>>>> -       bpf_link__destroy(update_link);
>>>>> +free_update_tracing_link:
>>>>> +       bpf_link__destroy(update_tracing_link);
>>>>
>>>> I don't think this need to block submission unless there are other
>>>> issues but the
>>>> bpf_link__destroy can just be called in a single cleanup label because
>>>> it handles null or
>>>> erroneous inputs:
>>>>
>>>> int bpf_link__destroy(struct bpf_link *link)
>>>> {
>>>>      int err = 0;
>>>>
>>>>      if (IS_ERR_OR_NULL(link))
>>>>           return 0;
>>>> [...]
>>>
>>> +1 to KP's point.
>>>
>>> Also Florent, how did you test it?
>>> This test fails in CI and in my manual run:
>>> ./test_progs -t cook
>>> libbpf: load bpf program failed: Permission denied
>>> libbpf: -- BEGIN DUMP LOG ---
>>> libbpf:
>>> ; int update_cookie_sockops(struct bpf_sock_ops *ctx)
>>> 0: (bf) r6 = r1
>>> ; if (ctx->family != AF_INET6)
>>> 1: (61) r1 = *(u32 *)(r6 +20)
>>> ; if (ctx->family != AF_INET6)
>>> 2: (56) if w1 != 0xa goto pc+21
>>>   R1_w=inv10 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>> ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
>>> 3: (61) r1 = *(u32 *)(r6 +0)
>>> ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
>>> 4: (56) if w1 != 0x3 goto pc+19
>>>   R1_w=inv3 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>> ; if (!ctx->sk)
>>> 5: (79) r1 = *(u64 *)(r6 +184)
>>> ; if (!ctx->sk)
>>> 6: (15) if r1 == 0x0 goto pc+17
>>>   R1_w=sock(id=0,ref_obj_id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
>>> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
>>> 7: (79) r2 = *(u64 *)(r6 +184)
>>> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
>>> 8: (18) r1 = 0xffff888106e41400
>>> 10: (b7) r3 = 0
>>> 11: (b7) r4 = 0
>>> 12: (85) call bpf_sk_storage_get#107
>>> R2 type=sock_or_null expected=sock_common, sock, tcp_sock, xdp_sock, ptr_
>>> processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
>>> 0 peak_states 0 mark_read 0
>>>
>>> libbpf: -- END LOG --
>>> libbpf: failed to load program 'update_cookie_sockops'
>>> libbpf: failed to load object 'socket_cookie_prog'
>>> libbpf: failed to load BPF skeleton 'socket_cookie_prog': -4007
>>> test_socket_cookie:FAIL:socket_cookie_prog__open_and_load skeleton
>>> open_and_load failed
>>> #95 socket_cookie:FAIL
>>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> Oh :| I must have missed something in the rebase, I will fix this and
>> address KP's comment then. Thanks for the review and sorry for the
>> waste of time :)
> 
> So this is actually an interesting one I think. :) The failure was
> triggered by the combination of an LLVM update and this change:
> 
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
> 
> With an older LLVM, this used to work.
> With a recent LLVM, the change of header causes those 3 lines to get
> compiled differently:
> 
> if (!ctx->sk)
>      return 1;
> p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> 
> When including linux/bpf.h
> ; if (!ctx->sk)
>         5: 79 62 b8 00 00 00 00 00 r2 = *(u64 *)(r6 + 184)
>         6: 15 02 10 00 00 00 00 00 if r2 == 0 goto +16 <LBB1_6>
> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
>         7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>         9: b7 03 00 00 00 00 00 00 r3 = 0
>        10: b7 04 00 00 00 00 00 00 r4 = 0
>        11: 85 00 00 00 6b 00 00 00 call 107
>        12: bf 07 00 00 00 00 00 00 r7 = r0
> 
> When including vmlinux.h
> ; if (!ctx->sk)
>         5: 79 61 b8 00 00 00 00 00 r1 = *(u64 *)(r6 + 184)
>         6: 15 01 11 00 00 00 00 00 if r1 == 0 goto +17 <LBB1_6>
> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
>         7: 79 62 b8 00 00 00 00 00 r2 = *(u64 *)(r6 + 184)
>         8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>        10: b7 03 00 00 00 00 00 00 r3 = 0
>        11: b7 04 00 00 00 00 00 00 r4 = 0
>        12: 85 00 00 00 6b 00 00 00 call 107
>        13: bf 07 00 00 00 00 00 00 r7 = r0
> 
> Note that ctx->sk gets fetched once in the first case (l5), and twice
> in the second case (l5 and l7).
> I'm assuming that struct bpf_sock_ops gets defined with different
> attributes in vmlinux.h and causes LLVM to assume that ctx->sk could
> have changed between the time of check and the time of use so it
> yields two fetches and the verifier can't track that r2 is non null.
> 
> If I save ctx->sk in a temporary variable first:
> 
> struct bpf_sock *sk = ctx->sk;
> if (!sk)
>      return 1;
> p = bpf_sk_storage_get(&socket_cookies, sk, 0, 0);
> 
> this loads correctly. However, Brendan pointed out that this is also a
> weak guarantee and that LLVM could still decide to compile this into
> two fetches, Brendan suggested that we save sk out of an access to a
> volatile pointer to ctx, what do you think ?

Your above workaround should be good. Compiler should not do *bad* 
optimizations to have two fetches if the source code just has one
in the above case. If this happens, it will be a llvm bug.

The latest llvm trunk can reproduce the above issue. It is due to
(1). llvm's partial (not complete) CSE and (2). this partial CSE
resulted in llvm BPF backend generating two CORE_MEM operations (for 
CORE relocations) instead of one. If llvm will do complete cse like the 
above your code, we will be fine.

Although fixing llvm CSE is desired, it may take
some time. At the same time, please use your above source workaround.
Thanks.
