Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084586C37FC
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCURON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCUROL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 13:14:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194B51C96
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 10:13:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so62468546edb.10
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418820;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihEjxjfpXnOe/oZLN8PVMMaocJ9+cRd6zOnQ7Mus7Q8=;
        b=VQyh1sp5BwA2Fj8K5e5vtf9s39Npb94wtghmgF0MPPznRoa7XxFWhFPG0I6yMjfBzC
         Yys544kM1fk+JMNtYteGVPxvIFjMNRoxcPCJpQJR0mdhk/i9687H2HJB/cypmhYS4ST0
         R3trKDYnOXWEO7uc1fJw3k2ebe8h0cm6vSzwq4rRAcJx2XhBnOzLWxalohxj/diAmMYW
         vHrj2bBzzdkA2ytObUz65agIv5Sis99Q0cwRkm3+DnQYm5K3n16ic4/+15L9q2FQpXed
         PyEuyTwmy9U0nJtd6fadpo+22GJWz1bHisOyzbI/AcrzKX9si1SrW8grsu+9HtUqMVcg
         l4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418820;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihEjxjfpXnOe/oZLN8PVMMaocJ9+cRd6zOnQ7Mus7Q8=;
        b=aR6/a2mn2eRE4HO7PoFva7ONfB7HthUGZZJ/YHousAa2F5yRf9Yn2zc3DAsGS/SYwO
         cPjpL2D1WFeyA+IUpFVzSYGB4Nv8Ru5KpwYViwQSUM2s/nXZaixK8DRipoq1uPnsjy2F
         ycfCcKGhlC15836qO3BX6hbijgHKWLieGbke497gTgeJK4QX8duepklAsngg3WsANWHZ
         RIPBowCJD83/y8GI+p+q8Hw83ovR53g4cvOaOw0y+fHX/Y2I2j2VV6A/lkzSuo6+cCQ+
         /t2zrDyE0f8fCIG/VnxJybifk+PAkMMS+LxBUfZMAAPC1m4GOuEaBL4jslXISB+zf0os
         kTMw==
X-Gm-Message-State: AO0yUKV6ZM+IgOdag+H8bdOQNCNM1uJPqGoC6M3TkdPYNIx8cyH8qXuK
        qD0B7vH52+oXk0UMdQs+0jaIwq8GXjnuuqV/VIKl3HUV/X0=
X-Google-Smtp-Source: AK7set8g9AWTjlk2LpQ9Oxt5f2gce3ujYDN8O7h35BoNJdvFwOWv/z7O24vJZcm9TIJMgHWEIZbByuyl9KXs0NhGcyo=
X-Received: by 2002:a50:cd8f:0:b0:501:d532:9224 with SMTP id
 p15-20020a50cd8f000000b00501d5329224mr2133605edi.8.1679418820026; Tue, 21 Mar
 2023 10:13:40 -0700 (PDT)
MIME-Version: 1.0
From:   Davide Miola <davide.miola99@gmail.com>
Date:   Tue, 21 Mar 2023 18:13:29 +0100
Message-ID: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
Subject: bpf: missed fentry/fexit invocations due to implicit recursion
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I've been trying to measure the per-task CPU time spent in the kernel
function ip_queue_xmit by attaching an entry and exit probe to said
function in the form of fentry/fexit programs, but I've noticed that
under heavy traffic conditions this solution breaks. I first observed
this as the exit program was occasionally being called more times
than the entry, which of course shouldn't be possible.

Below is the stack trace (most recent call last) of one such event:

0xffffffffb8800099 entry_SYSCALL_64_after_hwframe
0xffffffffb879fb49 do_syscall_64
0xffffffffb7d8ff49 __x64_sys_read
0xffffffffb7d8fef5 ksys_read
0xffffffffb7d8d3d3 vfs_read
0xffffffffb7d8caae new_sync_read
0xffffffffb84c0f1f sock_read_iter
0xffffffffb84c0e81 sock_recvmsg
0xffffffffb85ef8bc inet_recvmsg
0xffffffffb85b13f4 tcp_recvmsg
0xffffffffb84ca5b0 release_sock
0xffffffffb84ca535 __release_sock
0xffffffffb85ce0a7 tcp_v4_do_rcv
0xffffffffb85bfd2a tcp_rcv_established
0xffffffffb85b5d32 __tcp_ack_snd_check
0xffffffffb85c8dcc tcp_send_ack
0xffffffffb85c5d0f __tcp_send_ack.part.0
0xffffffffb85a0e75 ip_queue_xmit
0xffffffffc0f3b044 rapl_msr_priv        [intel_rapl_msr]
0xffffffffc0c769aa bpf_prog_6deef7357e7b4530    [bpf]
0xffffffffb7c6707e __htab_map_lookup_elem
0xffffffffb7c66fe0 lookup_nulls_elem_raw
0xffffffffb8800da7 asm_common_interrupt
0xffffffffb87a11ae common_interrupt
0xffffffffb7ac57b4 irq_exit_rcu
0xffffffffb8a000d6 __softirqentry_text_start
0xffffffffb84f1fd6 net_rx_action
0xffffffffb84f1bf0 __napi_poll
0xffffffffc02af547 i40e_napi_poll       [i40e]
0xffffffffb84f1a7a napi_complete_done
0xffffffffb84f158e netif_receive_skb_list_internal
0xffffffffb84f12ba __netif_receive_skb_list_core
0xffffffffb84f04fa __netif_receive_skb_core.constprop.0
0xffffffffc079e192 br_handle_frame      [bridge]
0xffffffffc03f9ce5 br_nf_pre_routing    [br_netfilter]
0xffffffffc03f979c br_nf_pre_routing_finish     [br_netfilter]
0xffffffffc03f95db br_nf_hook_thresh    [br_netfilter]
0xffffffffc079dc07 br_handle_frame_finish       [bridge]
0xffffffffc079da28 br_pass_frame_up     [bridge]
0xffffffffb84f2fa3 netif_receive_skb
0xffffffffb84f2f15 __netif_receive_skb
0xffffffffb84f2eba __netif_receive_skb_one_core
0xffffffffb859aefa ip_rcv
0xffffffffb858eb61 nf_hook_slow
0xffffffffc03f88ec ip_sabotage_in       [br_netfilter]
0xffffffffb859ae5e ip_rcv_finish
0xffffffffb859ab0b ip_local_deliver
0xffffffffb859a9f8 ip_local_deliver_finish
0xffffffffb859a79c ip_protocol_deliver_rcu
0xffffffffb85d137e tcp_v4_rcv
0xffffffffb85ce0a7 tcp_v4_do_rcv
0xffffffffb85bf9cb tcp_rcv_established
0xffffffffb85c6fe7 __tcp_push_pending_frames
0xffffffffb85c6859 tcp_write_xmit
0xffffffffb85a0e75 ip_queue_xmit
0xffffffffc0f3b090 rapl_msr_priv        [intel_rapl_msr]
0xffffffffc00f0fb5 __this_module        [linear]
0xffffffffc00f0fb5 __this_module        [linear]

As I interpret this, it appears that after the first invocation of
ip_queue_xmit the entry function is called, but it's then interrupted
by an irq which eventually leads back to ip_queue_xmit, where the
entry's bpf_prog->active field is still 1, preventing its invocation
(whereas the exit program can instead be executed).
Inspecting bpftool seems to confirm this, as I can see an unbalanced,
slowly increasing recursion_misses counter for both programs.

I'm not even sure this would qualify as a bug, but - even though I've
only been able to reproduce this consistently with a 40G
iperf3 --bidir - the chance of it happening render fentry/fexit
unreliable for the job.
