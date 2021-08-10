Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D563E52F4
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 07:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhHJFct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbhHJFcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 01:32:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF44C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 22:32:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z5so32285459ybj.2
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 22:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OhBZhz7fcbet+wWOm6YiZBxU1zL8v/h4whhwGboL7k=;
        b=DVkrvmN8wBWoqfFgklf6KnM7F4uTR2WAZ1/AhYOwGMaJEDDuimEmyfr+1advtArKP/
         WXtf0AXRc2SY8vdjU2yszDSxxUahk7hVn4TJSm1R2VB4BlYYBBj/2sNbkQ8np5TTUSaw
         BFsCU3JCChDhcQ/l0dXg5KBOTDlzZ0iR/ZV7UlYtl2POhbAE6PozF3sObczoUhPwwonf
         LeA+SFTwWsOKbi/zUN23bY84KUz+sCsreShiRtgl5z2eRrCJQo2Lafj3hNmykP/DvO4G
         //Gpcz5E34fjlhi6rrEzsIcQOoahb5mdpu/rtL33UsC0uf22rvely0ae7bqPsBn7ZhFn
         /mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OhBZhz7fcbet+wWOm6YiZBxU1zL8v/h4whhwGboL7k=;
        b=Qweo6Y1y/ZjXGvTi+onttYv0E80XVCO/7wLXQcyLKaTjROmWaFrkIxgCtGMT/7P3ED
         5JACIywBw5WLVTOXLrztirKzcPYxhakxxax/LeG36Bweow2U9qEVkZWeBV3k2WitJy2k
         lG85f+n2BHJo7G/7Ni4Osu5CwwNav9f976ophE82cq6E1SY2PxmOz2neDqtIr4GxOlvi
         soPJgelVUMWvLXeyDPZqjOxYAYk37v7z0Z8BEnyfoaP5vapSHen4k0/4dPu5XYmSe1r9
         TKf9CeY1ftCVmQch5sgfScNlCwSKXqy9/M0afhvHfq2z9ZsMw4A1kP2351KXlz6wjrZU
         eJ/Q==
X-Gm-Message-State: AOAM532kj60S7SkdxO9gLuCuUPmNrDObw8rJXJfnoIlV5imzv3NSCjA5
        yOqQu0imt0DWs0EUCnzCy3ziUaxqXBrVgJbEn8E=
X-Google-Smtp-Source: ABdhPJxiDeNYu9KoXlMcKlhhJfI/fmLWM+PPDRI/Fy2Do2vvcMTLeAJ5pMFcGIIB1/sT0W34yIe9b0VbWLuTgVmNVlI=
X-Received: by 2002:a25:5054:: with SMTP id e81mr27538361ybb.510.1628573546369;
 Mon, 09 Aug 2021 22:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210810010413.1976277-1-yhs@fb.com>
In-Reply-To: <20210810010413.1976277-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 22:32:15 -0700
Message-ID: <CAEf4BzYSWiehsEzaqV3rJ7O3xiDgX6haXRG9eeQ00Bejn=dOUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix potentially incorrect results with bpf_get_local_storage()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 6:04 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit b910eaaaa4b8 ("bpf: Fix NULL pointer dereference in
> bpf_get_local_storage() helper") fixed a bug for bpf_get_local_storage()
> helper so different tasks won't mess up with each other's
> percpu local storage.
>
> The percpu data contains 8 slots so it can hold up to 8 contexts
> (same or different tasks), for 8 different program runs,
> at the same time. This in general is sufficient. But our internal
> testing showed the following warning multiple times:
>
>   warning: WARNING: CPU: 13 PID: 41661 at include/linux/bpf-cgroup.h:193
>      __cgroup_bpf_run_filter_sock_ops+0x13e/0x180
>   RIP: 0010:__cgroup_bpf_run_filter_sock_ops+0x13e/0x180
>   <IRQ>
>    tcp_call_bpf.constprop.99+0x93/0xc0
>    tcp_conn_request+0x41e/0xa50
>    ? tcp_rcv_state_process+0x203/0xe00
>    tcp_rcv_state_process+0x203/0xe00
>    ? sk_filter_trim_cap+0xbc/0x210
>    ? tcp_v6_inbound_md5_hash.constprop.41+0x44/0x160
>    tcp_v6_do_rcv+0x181/0x3e0
>    tcp_v6_rcv+0xc65/0xcb0
>    ip6_protocol_deliver_rcu+0xbd/0x450
>    ip6_input_finish+0x11/0x20
>    ip6_input+0xb5/0xc0
>    ip6_sublist_rcv_finish+0x37/0x50
>    ip6_sublist_rcv+0x1dc/0x270
>    ipv6_list_rcv+0x113/0x140
>    __netif_receive_skb_list_core+0x1a0/0x210
>    netif_receive_skb_list_internal+0x186/0x2a0
>    gro_normal_list.part.170+0x19/0x40
>    napi_complete_done+0x65/0x150
>    mlx5e_napi_poll+0x1ae/0x680
>    __napi_poll+0x25/0x120
>    net_rx_action+0x11e/0x280
>    __do_softirq+0xbb/0x271
>    irq_exit_rcu+0x97/0xa0
>    common_interrupt+0x7f/0xa0
>    </IRQ>
>    asm_common_interrupt+0x1e/0x40
>   RIP: 0010:bpf_prog_1835a9241238291a_tw_egress+0x5/0xbac
>    ? __cgroup_bpf_run_filter_skb+0x378/0x4e0
>    ? do_softirq+0x34/0x70
>    ? ip6_finish_output2+0x266/0x590
>    ? ip6_finish_output+0x66/0xa0
>    ? ip6_output+0x6c/0x130
>    ? ip6_xmit+0x279/0x550
>    ? ip6_dst_check+0x61/0xd0
>   ...
>
> Using drgn to dump the percpu buffer contents showed that

worth putting the reference to drgn for people not familiar with what it is

  [0] https://github.com/osandov/drgn

> on this cpu slot 0 is still available but
> slots 1-7 are occupied and those tasks in slots 1-7 mostly don't exist
> any more. So we might have issues in bpf_cgroup_storage_unset().
>
> Further debugging confirmed that there is a bug in bpf_cgroup_storage_unset().
> Currently, it tries to unset "current" slot with searching from the start.
> So the following sequence is possible:
>   1. a task is running and claims slot 0
>   2. running bpf program is done, and it checked slot "0" has the "task"
>      and ready to reset it to NULL (not yet).
>   3. an interrupt happens, another bpf program runs and it claims slot 1
>      with the *same* task.
>   4. the unset() in interrupt context releases slot 0 since it matches "task".
>   5. interrupt is done, the task in process context reset slot 0.
>
> At the end, slot 1 is not reset and the same process can continue to occupy
> slots 2-7 and finally, when the above step 1-5 is repeated again, step 3 bpf program
> won't be able to claim an empty slot and a warning will be issued.
>
> To fix the issue, for unset() function, we should traverse from the last slot
> to the first. This way, the above issue can be avoided.
>
> The same reverse traversal should also be done in bpf_get_local_storage() helper
> itself. Otherwise, incorrect local storage may be returned to bpf program.
>
> Cc: Roman Gushchin <guro@fb.com>
> Fixes: b910eaaaa4b8 ("bpf: Fix NULL pointer dereference in bpf_get_local_storage() helper")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf-cgroup.h | 4 ++--
>  kernel/bpf/helpers.c       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> This patch targets to bpf tree. In bpf-next,
> Andrii's c7603cfa04e7 ("bpf: Add ambient BPF runtime context stored in current")
> should have fixed the issue too. I also okay with backporting Andrii's patch
> to bpf tree if it is viable.
>

I don't have preferences, but my patch might be a bit harder to
backport, so doing this as a fix is fine with me.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 8b77d08d4b47..6c9b10d82c80 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -201,8 +201,8 @@ static inline void bpf_cgroup_storage_unset(void)
>  {
>         int i;
>
> -       for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> -               if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +       for (i = BPF_CGROUP_STORAGE_NEST_MAX - 1; i >= 0; i--) {
> +               if (likely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
>                         continue;
>
>                 this_cpu_write(bpf_cgroup_storage_info[i].task, NULL);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62cf00383910..9b3f16eee21f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -397,8 +397,8 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>         void *ptr;
>         int i;
>
> -       for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> -               if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +       for (i = BPF_CGROUP_STORAGE_NEST_MAX - 1; i >= 0; i--) {
> +               if (likely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
>                         continue;
>
>                 storage = this_cpu_read(bpf_cgroup_storage_info[i].storage[stype]);
> --
> 2.30.2
>
