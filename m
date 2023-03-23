Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636C6C5F3E
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 07:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCWGAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCWGAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 02:00:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC112473C;
        Wed, 22 Mar 2023 23:00:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bl39so6204232qkb.10;
        Wed, 22 Mar 2023 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679551210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khkEh87VOV5qByXCjte01mLcaqpsWFmMCoN/d+getgU=;
        b=naVGbe97QoHtHXJNGHJ53BjrnlFmDAgUJgbaJRV8uLuZlosSi+3jyHx9Ik0O1enWU0
         t6dgPiCjnpGCDJ+YxSWrgv8CMkWeZNg/4cD8XovwadXWRjHuJy0q5a+Bd9WCWhO46Nhu
         zM2gtxpF2Zz8zUGN41HuoYx7M6nGHsQySkqbU4wyxh2QUc4gpAV37rt4dOv57NQkNEDT
         15ha/lxNQXk/hYwbm0iuwo/kzyLpG2Akc98SEv5mt5O7L9lFQoxKb5IHA9hVvKqKYYkl
         11tx1kEZLFe5hTRYXBYAEa5MoFO8/vJgBekObFmC7Y6brKA4BmuG30C6u+MiQ3UnD78H
         j0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679551210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khkEh87VOV5qByXCjte01mLcaqpsWFmMCoN/d+getgU=;
        b=mbvGDVhXLKY4YLWvnb/vY9PtB0aY4pWoPOjfQp2QkL4FCs7FJaw39YohsOLmGP3xyV
         I9e47gy65ZaTgjixx943BzxyW24CJ+URMFmeKVLDQABRMU2iIxwYTi0dkVO6gisos0lE
         ou+3MJyQUrIU5DjHpS9775Pt/YXNy12MP5t09yDX7Rcv8Owtj4VVNnjceLv99+fgTAsc
         8Q5Om8lRSVg2iqjXLw3RIpbL6uWqqLP/+iqrVbut8Yy/hPs0p8jyq1pqSynnEDuA/Fey
         l7SPKo4Z1SPEEt29EnkZXYoHmLgVWZ0Dv4M9aNJgh62ijwoD5xk6iG/Npg6Msrkduxp0
         NQCQ==
X-Gm-Message-State: AO0yUKWRNi3d7r6PuRA6HP/qF7klIHwXux1Z67Nyc/rfUMAdkwzO/58f
        5+xPUjsCVFbPZA7WsDRDusjrA4VIK0g7xQtA8SA=
X-Google-Smtp-Source: AK7set/eCGEMNixWax9ZGSzn/UXHfberlduHP+jIdICEZKNzSBW0J1/xJkY2D9/lQddgNb5xk+ytZCMZXQRjOd23cqY=
X-Received: by 2002:a37:688a:0:b0:746:96c2:e458 with SMTP id
 d132-20020a37688a000000b0074696c2e458mr932959qkc.4.1679551210235; Wed, 22 Mar
 2023 23:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
In-Reply-To: <20230321101711.625d0ccb@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 23 Mar 2023 13:59:34 +0800
Message-ID: <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 10:17=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 21 Mar 2023 02:01:03 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > It hits below warning on my test machine when running
> > selftests/bpf/test_progs,
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
> > This issue happens under CONFIG_CONTEXT_TRACKING_USER=3Dy. When a task
> > enters from user mode to kernel mode, or enters from user mode to irq,
> > it excutes preempt_count_sub before RCU begins watching, and thus this
> > warning is triggered.
> >
> > We should not handle fprobe if RCU is not watching.
> >
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Jiri Olsa <olsajiri@gmail.com>
> > ---
> >  kernel/trace/fprobe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index e8143e3..fe4b248 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -27,6 +27,9 @@ static void fprobe_handler(unsigned long ip, unsigned=
 long parent_ip,
> >       struct fprobe *fp;
> >       int bit;
> >
> > +     if (!rcu_is_watching())
> > +             return;
>
> Hmm, at least on 6.3, this should not be an issue anymore. I believe that
> all locations that have ftrace callbacks should now have rcu watching?
>

Hi Steven,

I have verified the latest linux-trace tree,
    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/core

The result of "uname -r" is ''6.3.0-rc3+".
This issue still exists, and after applying this patch it disappears.
It can be reproduced with a simple bpf program as follows,
    SEC("kprobe.multi/preempt_count_sub")
    int fprobe_test()
    {
        return 0;
    }

> I think we *want* a warn on when this happens.
>
> Peter?
>



--=20
Regards
Yafang
