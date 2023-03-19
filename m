Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16786C03B7
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCSSMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 14:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSSMU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 14:12:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49C19699
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 11:12:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so7878774wmb.2
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679249537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VSJoIRHi6wXArw7MraUrhmcxr26urYUiHC2eQ7gJzE=;
        b=PxKt7yG/CCXzUpKHNU4TVeq9wfdYm/uCRfnWLoGJqlqnmBpo9w4/zE/Usha6t8V5PI
         DoW+IhBgRNTVvCjGWeAt8/VZ1wQbCeyIxo0M4qA9gV3BL/OeYAF9pHvH7yZuFxbNsj9Y
         bewPUkCxCMByT7rfxZ8V5vuV5L+RZ3D90xIOn3zGqzD2qQZUV3cdbv3hn265AsVu9rDO
         cI0NCWEcED2JvOH4HQS3YrXigCLoEW0hV8s1BSm9gOTjTek4UdamqmDf9tD5RZvAuU+R
         J4Mv8mMZkJ9JVJpr5AMhesEbi4fiRMEq4x+9vGNpPRuDL1D18tjS+OCwpnADvlP5W1rG
         0QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679249537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VSJoIRHi6wXArw7MraUrhmcxr26urYUiHC2eQ7gJzE=;
        b=7pt2TXCwW52pQgbWCaildXCCc7c6GwyXFle5Puy/1dZklrgEpC3NlPiGUJLUxW9ze8
         zBm+N5ah0zJI65Kl45AUdIdd+XrtMazWSTV9huSVqqP2OhRVsFrHsxcaDqQNaY9onp6w
         UrNk8kRAteDfessV096zmmf6/tM/X9TEBHa5+/VpHRQVgGpMk8ajJAbWxllZUTB13oQs
         BCqS+KKSKlBaWdPkdelXLOTSE3L9k5vy3HMm6fot/k04kz++UXMD76IqS8gPXQOpLHKO
         aFvUpEmkJbqFB+LrRgtZN1NOE0jaBbGbHrofN3+zMppxcC/bUvNYd6uJ8IheILHmY5Mb
         pIPw==
X-Gm-Message-State: AO0yUKVIlMslAhx/vB0eIE2f4Ue3ACxFATRYNHJPKlbucGyCpAp0nLVa
        EKdvtsmF7R7Wxmf0qLPub+s=
X-Google-Smtp-Source: AK7set9eN8rxXtaC0VtDb8PJfCNf+HnZcCsxbdRlK9IJEtlDIs31j5/E0uLYqb0qLSrUpISRaPPQ9w==
X-Received: by 2002:a05:600c:3b0e:b0:3ed:3033:496d with SMTP id m14-20020a05600c3b0e00b003ed3033496dmr16295168wms.0.1679249537205;
        Sun, 19 Mar 2023 11:12:17 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003eb5ce1b734sm8480360wmj.7.2023.03.19.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 11:12:16 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Mar 2023 19:12:14 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
Message-ID: <ZBdQfs8r9C1fxYGA@krava>
References: <20230317114832.13622-1-laoar.shao@gmail.com>
 <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
 <CALOAHbA9rQGGmBN7dV4qqdeq0MQAbK_m4f19nj-BTXo9zbe1Tg@mail.gmail.com>
 <20230319165456.ho6in6d5smokiksd@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319165456.ho6in6d5smokiksd@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 19, 2023 at 09:54:56AM -0700, Alexei Starovoitov wrote:
> On Sun, Mar 19, 2023 at 03:36:57PM +0800, Yafang Shao wrote:
> > On Sat, Mar 18, 2023 at 12:52 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 17, 2023 at 4:49 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > It hits below warning on my test machine when running test_progs,
> > > >
> > > > [  702.223611] ------------[ cut here ]------------
> > > > [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> > > > [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> > > > [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
> > > > [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> > > > [  702.241388] Call Trace:
> > > > [  702.241615]  <TASK>
> > > > [  702.241811]  fprobe_handler+0x22/0x30
> > > > [  702.242129]  0xffffffffc04710f7
> > > > [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> > > > [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> > > > [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
> > > > [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
> > > > [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
> > > > [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
> > > > [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
> > > > [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
> > > > [  702.250785]  ? preempt_count_sub+0x5/0xa0
> > > > [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > > [  702.252368]  ? preempt_count_sub+0x5/0xa0
> > > > [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > > [  702.253918]  do_syscall_64+0x16/0x90
> > > > [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > [  702.255422] RIP: 0033:0x46b793
> > > >
> > > > It's caused by bench test attaching kprobe_multi link to preempt_count_sub
> > > > function, which is not executed in rcu safe context so the kprobe handler
> > > > on top of it will trigger the rcu warning.
> > >
> > > Why is that?
> > 
> > It is caused by CONFIG_CONTEXT_TRACKING_USER=y, and it seems the
> > preempt_count_sub is executed before the RCU is watching.
> >   user_exit_irqoff
> >       if (context_tracking_enabled())  // CONFIG_CONTEXT_TRACKING_USER=y
> >           __ct_user_exit(CONTEXT_USER);
> >              ct_kernel_enter
> >                  ...
> >                  // RCU is not watching here ...
> >                  ct_kernel_enter_state(offset);
> >                  // ... but is watching here.
> > 
> > It can be reproduced with a simple bpf code as follows when
> > CONFIG_CONTEXT_TRACKING_USER=y,
> >   SEC("kprobe.multi/preempt_count_sub")
> >   int kprobe_multi_trace()
> >   {
> >       return 0;
> >   }
> > 
> > > preempt_count itself is fine.
> > > The problem is elsewhere.
> > > Since !rcu_is_watching() it some sort of idle or some other issue.
> > 
> > Not sure if we need to improve the code under
> > CONFIG_CONTEXT_TRACKING_USER=y, but it seems skipping "preempt_count_"
> > in kprobe_multi test case would be a quick fix.
> 
> It's not a fix. Only moving a goal post.
> We probably need
>         if (!rcu_is_watching())
>                 return;
> in [kf]probe handler instead.

that might also help with some of the warnings we saw from idle
functions that we skip at the moment

jirka
