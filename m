Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF16C0355
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 17:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCSQzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCSQzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 12:55:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058511517D
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 09:54:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so10176299plb.3
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679244899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YdUAy/sK9Ana56l3MG5hkVZ0312ocM+HMt1SB5iyA+Q=;
        b=ELZRfyVpI93r0VaMO+PZ25W5O1KJh/cESms5qoLNUQwK/jdxhCzzwUX0AkwRQo3y9i
         KpjBL9PW2jaUq9EvyxlNe3bR5+jSOGpik+rtdzWMZPLrM9tBRkou46U2NOdSTKbQlb1f
         gTuGaCJF3gS/rCYwvLOUQS4gmgZLDtJam5zEOmcVgtBvGRV6hGNtPRdXMqTgvZIyoqkM
         YtIPPyCkOjT7EeQssq4c5CPFC7cuL36tY91Ds+w8ob7rzB92T1Ys9973DYuHQqze/cQc
         0GdvOC4n69cfbHBA+wboM0eWIeuoNaQRwEF6QZ7mBgEXOjop5+8lwraO8yXv3akQpp17
         sYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679244899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdUAy/sK9Ana56l3MG5hkVZ0312ocM+HMt1SB5iyA+Q=;
        b=xeNTT1EumA9L5MmWGaY7IofEEj7gge+k1aX+xUBIHS0RxUmWv6RKdIPqhN94jBtt9A
         a4i/Dl+ofFueZo7QbxGjzxl/rCSp6kGFycQLDj1Da4E0IbrMT2Bq9/18bqh10niwDXcW
         XKqPpIwLBJfmmUS3Nct3zP5lyCvACb41fqHg6xgKWdd/Qb8cyMrjbJmyPR6F9XzmEWA7
         TDf2OxVc9R/WMJBNLd+d7WHdmrcs6MovZEqgPycLUtv6V5GAZJT0Ge2E9vUM8AV9SINS
         WiLJjRlRKpug5WueTKbuvnZmk5fuuiFRR6WhaMFsM2wQVTK3/fyWijPWro8fksYn02lu
         4P6Q==
X-Gm-Message-State: AO0yUKV2nk2nusM9QrT3kxE+IjjvL3F74LwCgael7XYgHlNulYnHJRLp
        9m8KMT5N1jhFm7hROF+iLTg=
X-Google-Smtp-Source: AK7set++9JN0zZifc/UmSGrzME/SgO8M4Enoy7AW5+KU+B4snaNbKAqux1E9zLScEgGgvH+YGhqvgw==
X-Received: by 2002:a17:90b:1a86:b0:237:161d:f5ac with SMTP id ng6-20020a17090b1a8600b00237161df5acmr15397290pjb.36.1679244899300;
        Sun, 19 Mar 2023 09:54:59 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:2bcf])
        by smtp.gmail.com with ESMTPSA id 60-20020a17090a09c200b00234465cd2a7sm4478305pjo.56.2023.03.19.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:54:58 -0700 (PDT)
Date:   Sun, 19 Mar 2023 09:54:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
Message-ID: <20230319165456.ho6in6d5smokiksd@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230317114832.13622-1-laoar.shao@gmail.com>
 <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
 <CALOAHbA9rQGGmBN7dV4qqdeq0MQAbK_m4f19nj-BTXo9zbe1Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbA9rQGGmBN7dV4qqdeq0MQAbK_m4f19nj-BTXo9zbe1Tg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 19, 2023 at 03:36:57PM +0800, Yafang Shao wrote:
> On Sat, Mar 18, 2023 at 12:52 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 17, 2023 at 4:49 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > It hits below warning on my test machine when running test_progs,
> > >
> > > [  702.223611] ------------[ cut here ]------------
> > > [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> > > [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> > > [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
> > > [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> > > [  702.241388] Call Trace:
> > > [  702.241615]  <TASK>
> > > [  702.241811]  fprobe_handler+0x22/0x30
> > > [  702.242129]  0xffffffffc04710f7
> > > [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> > > [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> > > [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
> > > [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
> > > [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
> > > [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
> > > [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
> > > [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
> > > [  702.250785]  ? preempt_count_sub+0x5/0xa0
> > > [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > [  702.252368]  ? preempt_count_sub+0x5/0xa0
> > > [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > [  702.253918]  do_syscall_64+0x16/0x90
> > > [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > [  702.255422] RIP: 0033:0x46b793
> > >
> > > It's caused by bench test attaching kprobe_multi link to preempt_count_sub
> > > function, which is not executed in rcu safe context so the kprobe handler
> > > on top of it will trigger the rcu warning.
> >
> > Why is that?
> 
> It is caused by CONFIG_CONTEXT_TRACKING_USER=y, and it seems the
> preempt_count_sub is executed before the RCU is watching.
>   user_exit_irqoff
>       if (context_tracking_enabled())  // CONFIG_CONTEXT_TRACKING_USER=y
>           __ct_user_exit(CONTEXT_USER);
>              ct_kernel_enter
>                  ...
>                  // RCU is not watching here ...
>                  ct_kernel_enter_state(offset);
>                  // ... but is watching here.
> 
> It can be reproduced with a simple bpf code as follows when
> CONFIG_CONTEXT_TRACKING_USER=y,
>   SEC("kprobe.multi/preempt_count_sub")
>   int kprobe_multi_trace()
>   {
>       return 0;
>   }
> 
> > preempt_count itself is fine.
> > The problem is elsewhere.
> > Since !rcu_is_watching() it some sort of idle or some other issue.
> 
> Not sure if we need to improve the code under
> CONFIG_CONTEXT_TRACKING_USER=y, but it seems skipping "preempt_count_"
> in kprobe_multi test case would be a quick fix.

It's not a fix. Only moving a goal post.
We probably need
        if (!rcu_is_watching())
                return;
in [kf]probe handler instead.
