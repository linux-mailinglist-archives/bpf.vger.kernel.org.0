Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9F6BFFCB
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCSHhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSHhh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 03:37:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602391515E
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 00:37:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 133so2847656qkh.8
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679211453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHu2z1nhNaih7n88M6X8xgvwrGn+C+FhH21HuBFc+Rw=;
        b=BbKknQBJpDUysvloJ8q7gXPvbazDISxdU5A3ej/euKyHt3Nk2FapGzBfNO2ys/TgMd
         Br2PYNxBNtubFJBl42j+UqoKc8Vs7FSrNYPBS4q+al8QU2QfWNFL2ANRA+A32febzU38
         lHRyNUMD8u1G/CJmRFy3JIuzGSAScnD08/fqWqVVoiTLDEz5Ioug9jax9TT4heIF5IWx
         DXYV6LyllqnXDIj6Y8adVjBJOexu8Sx3UF+1Nn8a2rlXFydXhGbC/iJQhw6+dqneQrDD
         a5SdWBYuC7H5d8tkAlGP2jqJDbBfu+pK55S66Z0QwEBdV8VXUlBZQCflg8sJaUH3d69v
         ZukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679211453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHu2z1nhNaih7n88M6X8xgvwrGn+C+FhH21HuBFc+Rw=;
        b=WzD+Gwvagn0RMo0jhOs+U6FOuOqRR6WlbeO/nvE3AHseitDmmnZioaEBdfwLbM79yF
         BRF9zo/t9PK/QTIDNB6LNXMMoPBPwUJ3UolkuIwpXixM/1go4R9CybdOeCQasHmT2O8u
         80sUpDlOME8hVXb0FMAPMlMusY9e1AJcIClawxOmrmR09TRY7kYHVg4OHXGgpSv7hZYh
         9SohjKRvH4XwPxNkPY55yCo6Z4pf1/vqLgOmcig22VT0HsD/CoyBQBr2TjbWy7Szmhc6
         VPwAp5Jr6mtE42RXhprlFn2nfNWjodb8TzxpFfMoXsUs7ZkKTevQDMiYi3dA++TRdM00
         x9dQ==
X-Gm-Message-State: AO0yUKVirj9hT410Ud4u83or42d5IyvgvmcDZagpvYg91i80/S/0Sfgf
        kZw9RP9ryCbTnqI2ne0ZG6mh3MlBW/oLG4MKFZc=
X-Google-Smtp-Source: AK7set8//15ZVN3zMSEjAjujf0sYzniy94se04MN6daMYh6zBm86BdqQ38py2JRiG/eFC+vQ5SvQ5H8cSENQkT4Sb0E=
X-Received: by 2002:a05:620a:a12:b0:746:7228:9533 with SMTP id
 i18-20020a05620a0a1200b0074672289533mr519778qka.4.1679211453431; Sun, 19 Mar
 2023 00:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230317114832.13622-1-laoar.shao@gmail.com> <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
In-Reply-To: <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 19 Mar 2023 15:36:57 +0800
Message-ID: <CALOAHbA9rQGGmBN7dV4qqdeq0MQAbK_m4f19nj-BTXo9zbe1Tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 18, 2023 at 12:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 17, 2023 at 4:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > It hits below warning on my test machine when running test_progs,
> >
> > [  702.223611] ------------[ cut here ]------------
> > [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> > [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recurs=
ion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> > [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted=
: G           O       6.2.0+ #584
> > [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> > [  702.241388] Call Trace:
> > [  702.241615]  <TASK>
> > [  702.241811]  fprobe_handler+0x22/0x30
> > [  702.242129]  0xffffffffc04710f7
> > [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> > [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80=
 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b=
 <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> > [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 00=
00000000000000
> > [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000=
000000000
> > [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000=
000000001
> > [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000=
000000000
> > [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
0000000ca
> > [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000=
000000000
> > [  702.250785]  ? preempt_count_sub+0x5/0xa0
> > [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> > [  702.252368]  ? preempt_count_sub+0x5/0xa0
> > [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> > [  702.253918]  do_syscall_64+0x16/0x90
> > [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [  702.255422] RIP: 0033:0x46b793
> >
> > It's caused by bench test attaching kprobe_multi link to preempt_count_=
sub
> > function, which is not executed in rcu safe context so the kprobe handl=
er
> > on top of it will trigger the rcu warning.
>
> Why is that?

It is caused by CONFIG_CONTEXT_TRACKING_USER=3Dy, and it seems the
preempt_count_sub is executed before the RCU is watching.
  user_exit_irqoff
      if (context_tracking_enabled())  // CONFIG_CONTEXT_TRACKING_USER=3Dy
          __ct_user_exit(CONTEXT_USER);
             ct_kernel_enter
                 ...
                 // RCU is not watching here ...
                 ct_kernel_enter_state(offset);
                 // ... but is watching here.

It can be reproduced with a simple bpf code as follows when
CONFIG_CONTEXT_TRACKING_USER=3Dy,
  SEC("kprobe.multi/preempt_count_sub")
  int kprobe_multi_trace()
  {
      return 0;
  }

> preempt_count itself is fine.
> The problem is elsewhere.
> Since !rcu_is_watching() it some sort of idle or some other issue.

Not sure if we need to improve the code under
CONFIG_CONTEXT_TRACKING_USER=3Dy, but it seems skipping "preempt_count_"
in kprobe_multi test case would be a quick fix.

--=20
Regards
Yafang
