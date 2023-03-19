Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6326BFFCC
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCSHjS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCSHjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 03:39:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DF1B31C
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 00:39:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t9so9935673qtx.8
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679211553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HSeEQ4JCB9RTOBsFnKC3Z8CyYqW4wonc9wVXqs0aW8=;
        b=au+vBLb+MM7ulgcjNtG+v6T0dAS4n4ejgGh1RA6+hUjhXu3tnCxHYnwGQ2W3SHSum3
         Oqvt5H8wRXZ7O9WQZ1xSiWeBQryEIM8470ypzTfRAis8LplfrTByhG94nNjhiAsV6A2z
         zbusqJ/ZLTi0BHvmS+BKQxRAZNIfnz/6GPkWthgS6l6oFsoILril6Mu2ugr1slxwT3kV
         J+4dAIeoSXdqorlUzChXIAqwnW8chbzfH2nzvjCVQg79HtAejRclzjcuNIa3SoQi8SsZ
         UfpaMK6/4gsmxoCQVVnUhtIhnrkbRilDk5oVj95JGiXS6Z4cWjpq30LKn++aj9v+6AWB
         iwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679211553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HSeEQ4JCB9RTOBsFnKC3Z8CyYqW4wonc9wVXqs0aW8=;
        b=XGjHBC/HMEiYKxA8vQKqAt03q/hxzZEzB615NbcTUgPLtZU4YVo2tZ5RKwh3g2xG2g
         HwuGqoHyaOH2JXFfXRY84g6M3u/cUnwCqmS2ahB3RMxV4+hRf26qatfK1QfdopVA6jEe
         t4Peu8sRd3Q2cr885i3+q14sjERG/Aa7OoRv/n3/Gcd3RRQuXUvSqePfLdJ9jr2QwGOQ
         6d+ju+YQCafjHFoPj48MqoWDNKkWRB/w48IScfZ9Qe2rW3doZevMue8YlyLKATG/xKvk
         cXztlDF45DeHPgT81+zQhssLyHw6kEPfl6WUXQH6cF/OVizVVwTfnzRysr8Sh6ARi3XO
         dNIA==
X-Gm-Message-State: AO0yUKVREOBMs2djeAQHrbB3k9Yd0ydCcjhYIRiHMJ+qvTRfFSb7Iq/4
        dN3HgVpP4CkVnHYPystDZ2oHYwqXg6xi6MfWQrM=
X-Google-Smtp-Source: AK7set9SxHeuqPgC4pHXuHWVidIKIqjTYEAO4qTWFzxmzjR94l5xqGrmMcFhpw5VbBN48FZWPYJghds7gFpLQ94CyBU=
X-Received: by 2002:ac8:42c6:0:b0:3c0:40c1:e5ac with SMTP id
 g6-20020ac842c6000000b003c040c1e5acmr3629009qtm.6.1679211553407; Sun, 19 Mar
 2023 00:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230317114832.13622-1-laoar.shao@gmail.com> <CAEf4BzbdFHt00E+XbZdmT4wYFfx8isfvRQ9JpbUkDaH30XaMtw@mail.gmail.com>
In-Reply-To: <CAEf4BzbdFHt00E+XbZdmT4wYFfx8isfvRQ9JpbUkDaH30XaMtw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 19 Mar 2023 15:38:37 +0800
Message-ID: <CALOAHbBoOZNsCu-uj0UiY-0knCKjB12W8boQnjaP6faZ-h4Dkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
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

On Sat, Mar 18, 2023 at 12:41=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
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
> >
> > Filtering out preempt_count_ functions from the bench test.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c=
 b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 22be0a9..5561b93 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -379,6 +379,8 @@ static int get_syms(char ***symsp, size_t *cntp, bo=
ol kernel)
> >                 if (!strncmp(name, "__ftrace_invalid_address__",
> >                              sizeof("__ftrace_invalid_address__") - 1))
> >                         continue;
> > +               if (!strncmp(name, "preempt_count_", strlen("preempt_co=
unt_")))
> > +                       continue;
> >
>
> let's add str_has_pfx() helper macro from libbpf_internal.h to
> test_progs.h and use that instead of repeating each substring twice?
>

Thanks for the suggestion.

> Here's what libbpf is doing:
>
> /* Check whether a string `str` has prefix `pfx`, regardless if `pfx` is
>  * a string literal known at compilation time or char * pointer known onl=
y at
>  * runtime.
>  */
> #define str_has_pfx(str, pfx) \
>         (strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1
> : strlen(pfx)) =3D=3D 0)
>
>
> >                 err =3D hashmap__add(map, name, 0);
> >                 if (err =3D=3D -EEXIST)
> > --
> > 1.8.3.1
> >



--=20
Regards
Yafang
