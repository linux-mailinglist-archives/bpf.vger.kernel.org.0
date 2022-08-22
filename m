Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAF59B73B
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 03:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiHVBVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiHVBVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 21:21:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736CA20F52
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 18:21:15 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M9vdY08lwznTj0;
        Mon, 22 Aug 2022 09:18:57 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 09:21:12 +0800
Subject: Re: [PATCH 0/3] fixes for concurrent htab updates
To:     Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
CC:     Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <639f1b24-25bb-32e5-36e0-1abadd63cb5a@huawei.com>
Date:   Mon, 22 Aug 2022 09:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220821033223.2598791-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, forget to add bpf prefix for the patchset.

On 8/21/2022 11:32 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patchset aims to fix the issues found during investigating the
> syzkaller problem reported in [0]. It seems that the normally concurrent
> updates in the same hash-table are disallowed as shown in patch 1.
>
> Patch 1 uses preempt_disable() to fix the problem to !PREEMPT_RT case.
>
> Patch 2 introduces an extra bpf_map_busy bit in task_struct to
> detect the re-entrancy of htab_lock_bucket() and allow concurrent map
> updates due to preemption in PREEMPT_RT case. It is coarse-grained
> compared with map_locked in !PREEMPT_RT case, because if two different
> maps are manipulated the re-entrancy is still be rejected. But
> considering Alexei is working on "BPF specific memory allocator" [1],
> and the !htab_use_raw_lock() case can be removed after the patchset is
> landed, so I think may be it is fine and hope to get some more feedback
> about the proposed fix in patch 2.
>
> Patch 3 just fixes the out-of-bound memory read problem reported in [0].
> Once patch 1 & patch 2 are merged, htab_lock_bucket() will always
> succeed for userspace process, but it is better to handle it gracefully.
>
> Selftests will be added after getting more feedback about the patchset
> and comments are always welcome.
>
> Regards,
> Tao
>
> [0]: https://lore.kernel.org/bpf/CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com/
> [1]: https://lore.kernel.org/bpf/20220819214232.18784-1-alexei.starovoitov@gmail.com/
>
> Hou Tao (3):
>   bpf: Disable preemption when increasing per-cpu map_locked
>   bpf: Allow normally concurrent map updates for !htab_use_raw_lock()
>     case
>   bpf: Propagate error from htab_lock_bucket() to userspace
>
>  include/linux/sched.h |  3 +++
>  kernel/bpf/hashtab.c  | 59 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 44 insertions(+), 18 deletions(-)
>

