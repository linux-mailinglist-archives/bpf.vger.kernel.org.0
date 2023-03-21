Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD76C3DE8
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCUWzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUWzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 18:55:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1E58C0D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:55:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m2so15277771wrh.6
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrFj5gEKfITvGxCH+ThVDqAiNRBRBw8EYqHx23R5v58=;
        b=mAYaIBRz+sWLAvM7kBLD+gUZkwN0ZZdhfalQ1bDzkhMlrFJpFl9/C5GD5pzuul5JNX
         DxL4A5k1Rn2mXnydPOT0WUhdyg5lq9nel9pNmp03b/nKoNskyys/kybTlYm7Q9znwBxX
         vRWQ5MAAiHbKcJZCuhb8lxWvz/vxtvm4RJr7kREF2UXp/J8zu38nvSANw+7NhBMGovjF
         ThyO56yqBsutyeBryCAK+/Z2WI1XulFgFK/zRSuV9bmV74FTh5hXwr3XGpCae4Z4ZAbB
         ELXkHhJOL2pgqf3uVUEiFoXd6Stu+NJvo6ub3VsNPOBhDFF9lPfo5LzqolKvcpz0TNKt
         SRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrFj5gEKfITvGxCH+ThVDqAiNRBRBw8EYqHx23R5v58=;
        b=jMUQjhF20JlTSbQVZq1cQ+6GDSIFwYgoPG77dVC7PKSZnfJK7ZsqQjqjHU3+zAnwRd
         bgE0/o3CDwxitlw/ZYkm/LAarJwa9INm0V3zsI+KucyHRVMd1mna8MYBryHs5eh9MArI
         exLq8oC13O9NvcPO025CO8L375M+nxyUiHN7oFFSPP6fP++Gjn4R+ZvrUZarvtCMKK9c
         c+MIK8Db5i0mOF3Ou6hAUpjmlQbaKIhLDny38DjX3zzJddVoRQvQ8nIBm0UrEpi6JjIg
         19ELefnH0Noe2pONcMK4goPqrLYhxxKGCl3bW2c1LDvk0YBXcxejd40vMktwsBikkhHn
         mPNg==
X-Gm-Message-State: AO0yUKUhoTOZ0nes6Vq/JRlPKXFkigyRcjXyjkXctbS7IWHaA0O35pe8
        AXLS+lXP/CP8R/Md1tVWuKA=
X-Google-Smtp-Source: AK7set+Vsm1U0725WGJr1aaugYJaogeByrjCzAG8JC65xGTK//IexXiPaIUeeKsM0fyEAT42YKRBlw==
X-Received: by 2002:a5d:448a:0:b0:2ce:9fd8:8e6d with SMTP id j10-20020a5d448a000000b002ce9fd88e6dmr3191505wrq.8.1679439341538;
        Tue, 21 Mar 2023 15:55:41 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id p10-20020a056000018a00b002c3f9404c45sm12483076wrx.7.2023.03.21.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:55:41 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Mar 2023 23:55:39 +0100
To:     Davide Miola <davide.miola99@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
Message-ID: <ZBo164Lc2eL3HUvN@krava>
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 06:13:29PM +0100, Davide Miola wrote:
> Hello,
> 
> I've been trying to measure the per-task CPU time spent in the kernel
> function ip_queue_xmit by attaching an entry and exit probe to said
> function in the form of fentry/fexit programs, but I've noticed that
> under heavy traffic conditions this solution breaks. I first observed
> this as the exit program was occasionally being called more times
> than the entry, which of course shouldn't be possible.
> 
> Below is the stack trace (most recent call last) of one such event:
> 
> 0xffffffffb8800099 entry_SYSCALL_64_after_hwframe
> 0xffffffffb879fb49 do_syscall_64
> 0xffffffffb7d8ff49 __x64_sys_read
> 0xffffffffb7d8fef5 ksys_read
> 0xffffffffb7d8d3d3 vfs_read
> 0xffffffffb7d8caae new_sync_read
> 0xffffffffb84c0f1f sock_read_iter
> 0xffffffffb84c0e81 sock_recvmsg
> 0xffffffffb85ef8bc inet_recvmsg
> 0xffffffffb85b13f4 tcp_recvmsg
> 0xffffffffb84ca5b0 release_sock
> 0xffffffffb84ca535 __release_sock
> 0xffffffffb85ce0a7 tcp_v4_do_rcv
> 0xffffffffb85bfd2a tcp_rcv_established
> 0xffffffffb85b5d32 __tcp_ack_snd_check
> 0xffffffffb85c8dcc tcp_send_ack
> 0xffffffffb85c5d0f __tcp_send_ack.part.0
> 0xffffffffb85a0e75 ip_queue_xmit
> 0xffffffffc0f3b044 rapl_msr_priv        [intel_rapl_msr]
> 0xffffffffc0c769aa bpf_prog_6deef7357e7b4530    [bpf]
> 0xffffffffb7c6707e __htab_map_lookup_elem
> 0xffffffffb7c66fe0 lookup_nulls_elem_raw
> 0xffffffffb8800da7 asm_common_interrupt
> 0xffffffffb87a11ae common_interrupt
> 0xffffffffb7ac57b4 irq_exit_rcu
> 0xffffffffb8a000d6 __softirqentry_text_start
> 0xffffffffb84f1fd6 net_rx_action
> 0xffffffffb84f1bf0 __napi_poll
> 0xffffffffc02af547 i40e_napi_poll       [i40e]
> 0xffffffffb84f1a7a napi_complete_done
> 0xffffffffb84f158e netif_receive_skb_list_internal
> 0xffffffffb84f12ba __netif_receive_skb_list_core
> 0xffffffffb84f04fa __netif_receive_skb_core.constprop.0
> 0xffffffffc079e192 br_handle_frame      [bridge]
> 0xffffffffc03f9ce5 br_nf_pre_routing    [br_netfilter]
> 0xffffffffc03f979c br_nf_pre_routing_finish     [br_netfilter]
> 0xffffffffc03f95db br_nf_hook_thresh    [br_netfilter]
> 0xffffffffc079dc07 br_handle_frame_finish       [bridge]
> 0xffffffffc079da28 br_pass_frame_up     [bridge]
> 0xffffffffb84f2fa3 netif_receive_skb
> 0xffffffffb84f2f15 __netif_receive_skb
> 0xffffffffb84f2eba __netif_receive_skb_one_core
> 0xffffffffb859aefa ip_rcv
> 0xffffffffb858eb61 nf_hook_slow
> 0xffffffffc03f88ec ip_sabotage_in       [br_netfilter]
> 0xffffffffb859ae5e ip_rcv_finish
> 0xffffffffb859ab0b ip_local_deliver
> 0xffffffffb859a9f8 ip_local_deliver_finish
> 0xffffffffb859a79c ip_protocol_deliver_rcu
> 0xffffffffb85d137e tcp_v4_rcv
> 0xffffffffb85ce0a7 tcp_v4_do_rcv
> 0xffffffffb85bf9cb tcp_rcv_established
> 0xffffffffb85c6fe7 __tcp_push_pending_frames
> 0xffffffffb85c6859 tcp_write_xmit
> 0xffffffffb85a0e75 ip_queue_xmit
> 0xffffffffc0f3b090 rapl_msr_priv        [intel_rapl_msr]
> 0xffffffffc00f0fb5 __this_module        [linear]
> 0xffffffffc00f0fb5 __this_module        [linear]
> 
> As I interpret this, it appears that after the first invocation of
> ip_queue_xmit the entry function is called, but it's then interrupted
> by an irq which eventually leads back to ip_queue_xmit, where the
> entry's bpf_prog->active field is still 1, preventing its invocation
> (whereas the exit program can instead be executed).
> Inspecting bpftool seems to confirm this, as I can see an unbalanced,
> slowly increasing recursion_misses counter for both programs.

seems correct to me, can you see see recursion_misses counter in
bpftool prog output for the entry tracing program?

jirka

> 
> I'm not even sure this would qualify as a bug, but - even though I've
> only been able to reproduce this consistently with a 40G
> iperf3 --bidir - the chance of it happening render fentry/fexit
> unreliable for the job.
