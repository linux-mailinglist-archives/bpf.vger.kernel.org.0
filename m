Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5A6C10DB
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCTLf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCTLfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 07:35:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04781D30E
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 04:35:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bz27so814142qtb.1
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0GKEFRESfUR8HE6JGyJuQiaCsfh6b8Qf6b/HGC73Ww=;
        b=YboRrWpNWXgTasY2NEIjwGqndVYn8fnTJyY4rX4BJ0UlrgDtTwVQHrTUGGsGEl6/7K
         /lBaPz1cEhStq1xvMlUUwP87O936n4MUNGq344N9i5pLDWZLMyBaaNAEpsVESygLMJn1
         F3iJms2RE/19c6fKCsrMvbud2dF72Pj23oSzVSrKYrbpoC0iCRBMUIFXeK1Z1xUiG7fW
         pN7Zo6DJSFY1rQfZ3wBwAyUsmihaOqLVk0btEyhwCIU5mceG/wMP8HQ6lE7mAm2kSy93
         YixhnX+rDrH82tlqdTcOuu9dBrFBHm49MJ003e59b6VGS789Q+6ee5gNx8vHN9zkmTXx
         d6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0GKEFRESfUR8HE6JGyJuQiaCsfh6b8Qf6b/HGC73Ww=;
        b=W4+frgp/t2sf9R1TCSy0aebMPa9tThil8/h7uQoAp3npvGMGUja3QduBrZd0GhyQ3u
         +I+wHqgbp1RHJx/HRxA5XpNRbslRt4/53oVUAC6q0JiZRm3Gmg2jqtH1cl7Dvzm+f4hO
         Q8D5e5MZZULDns17+dWj+nfzLX+zwQTdczm+OzoVceI5L7tEoZaJ0zNTkJE8Lf6diOOj
         DhlQ9HakYRaAmuWg6k8DG1vXo3qYXfTop7ux7pXl8Ctk2dZnW7U8IqNBV/qKJXyKbKKB
         MNWamQD7Mkve19yuuwLz/g7fwWrekbySsVbIapkiF+la5deWuooawMUDff1XIqByBoJA
         GOXg==
X-Gm-Message-State: AO0yUKWEW2gC31yXkRod76Gb6mcgexJSgDRYtnomU+fQbUzHTrhAS630
        2n3PHDwKI1bk8JbkhggzI+0aWpcRiPkhdag/2oo=
X-Google-Smtp-Source: AK7set+XSQmF14rnkKuVw0fhp797/cmNuQ3/6H8+Gj5+fb4v62YwopuhJJkCTaSTWpNZzgCPhZAe5AGmpKPcrkAGUGo=
X-Received: by 2002:a05:622a:19a9:b0:3db:c138:ae87 with SMTP id
 u41-20020a05622a19a900b003dbc138ae87mr3104442qtc.6.1679312122051; Mon, 20 Mar
 2023 04:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230317114832.13622-1-laoar.shao@gmail.com> <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
 <CALOAHbA9rQGGmBN7dV4qqdeq0MQAbK_m4f19nj-BTXo9zbe1Tg@mail.gmail.com> <20230319165456.ho6in6d5smokiksd@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230319165456.ho6in6d5smokiksd@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 20 Mar 2023 19:34:46 +0800
Message-ID: <CALOAHbB2oSYBfpU1fBq6HuGa0xp1az0M=tYfGdpQOjzaKrkNPQ@mail.gmail.com>
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

On Mon, Mar 20, 2023 at 12:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 19, 2023 at 03:36:57PM +0800, Yafang Shao wrote:
> > On Sat, Mar 18, 2023 at 12:52=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 17, 2023 at 4:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > It hits below warning on my test machine when running test_progs,
> > > >
> > > > [  702.223611] ------------[ cut here ]------------
> > > > [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> > > > [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_re=
cursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> > > > [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tai=
nted: G           O       6.2.0+ #584
> > > > [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> > > > [  702.241388] Call Trace:
> > > > [  702.241615]  <TASK>
> > > > [  702.241811]  fprobe_handler+0x22/0x30
> > > > [  702.242129]  0xffffffffc04710f7
> > > > [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> > > > [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1=
f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 3=
8 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> > > > [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX=
: 0000000000000000
> > > > [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 000=
0000000000000
> > > > [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 000=
0000000000001
> > > > [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 000=
0000000000000
> > > > [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
00000000000ca
> > > > [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 000=
0000000000000
> > > > [  702.250785]  ? preempt_count_sub+0x5/0xa0
> > > > [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > > [  702.252368]  ? preempt_count_sub+0x5/0xa0
> > > > [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> > > > [  702.253918]  do_syscall_64+0x16/0x90
> > > > [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > [  702.255422] RIP: 0033:0x46b793
> > > >
> > > > It's caused by bench test attaching kprobe_multi link to preempt_co=
unt_sub
> > > > function, which is not executed in rcu safe context so the kprobe h=
andler
> > > > on top of it will trigger the rcu warning.
> > >
> > > Why is that?
> >
> > It is caused by CONFIG_CONTEXT_TRACKING_USER=3Dy, and it seems the
> > preempt_count_sub is executed before the RCU is watching.
> >   user_exit_irqoff
> >       if (context_tracking_enabled())  // CONFIG_CONTEXT_TRACKING_USER=
=3Dy
> >           __ct_user_exit(CONTEXT_USER);
> >              ct_kernel_enter
> >                  ...
> >                  // RCU is not watching here ...
> >                  ct_kernel_enter_state(offset);
> >                  // ... but is watching here.
> >
> > It can be reproduced with a simple bpf code as follows when
> > CONFIG_CONTEXT_TRACKING_USER=3Dy,
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
> > CONFIG_CONTEXT_TRACKING_USER=3Dy, but it seems skipping "preempt_count_=
"
> > in kprobe_multi test case would be a quick fix.
>
> It's not a fix. Only moving a goal post.
> We probably need
>         if (!rcu_is_watching())
>                 return;
> in [kf]probe handler instead.

Good suggestion. I will think about it.

BTW, we can't kprobe preempt_count_sub, because it is a nokprobe symbol.
    NOKPROBE_SYMBOL(preempt_count_sub);

--=20
Regards
Yafang
