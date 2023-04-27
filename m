Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58B6F002C
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjD0E1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjD0E1O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:27:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D593
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:27:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so2969298a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569631; x=1685161631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KXcdvhP/M6zYFrqXIH58thfwzAMsR8d2RKOZjN9tlE=;
        b=IXuSkxTk6k8M8KpItmkhwA5YkO0se06eLP9Opo7OpLc0ZiTPnuSxrQKKEMXxL1em9M
         W7BJIZKITpwTGWEeZGWa6FXhF+M0a6vcjNtXXpkOSjrDImn/P6fDG4t7i3y22mZNkbrb
         ECyXCYh9UeBG/l4UsZAe91gayplPaumR7SiKLk/DZlPNUjJI6BumNmz/tf+ao/MbgizE
         rvg0MZjm9h0sAHFC8JFmLE3Od4etCvMnFUKKdTHKNS1GNRjB5+Htgc+hQa5ewgoBvR5U
         qMy7PygtuYszNdXC0i+x1Jjj7zT6uxYLXPzQ9SETPC4Zj8S6pCWPnMAfsPE0sATZEENS
         nc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569631; x=1685161631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KXcdvhP/M6zYFrqXIH58thfwzAMsR8d2RKOZjN9tlE=;
        b=k0hGIkZrbIPj7D1Pll7bOsPupRDiCwntWVw1SlWHp/fw9L8iZwzU83sOwBjcOXMWu2
         wODXH3/1vWtj9DJ8QCgdEG2YBQTLYu+8iMC7lbh9DNnXqxj7uG0SqAXEPd0bM5hU3A3P
         ug8XtHg0tWuIWDquZ36NWglZPmeZrim3UO4VXqPgwN+m1yBfI09OuaasIo9Zvr3R4/kD
         q+0NRiAzBa83jUobIpPFujVQZQRcSydWluuLx+HkQOqTbW6VLI+6jtpaAf9InZzI+ZJM
         WkvfJoWnfvAcnf+07F2Wewc5YEHE7K9NjTh7pZ921PQRfi9F+hEQFW8B5mox63WcM5eB
         ICog==
X-Gm-Message-State: AC+VfDxbNacKQHPZLE93+N6F6PDkB9iTg/6fyoUf1YjI2cCeEsOA9V1q
        QZvYstloBDFSbcTYiaSq2NyBjImDfl661mpRDhc=
X-Google-Smtp-Source: ACHHUZ6vy5f1/XTK8UPQyjI4wcSJYAuJfDyrJuYqQ/+88QnqXgm8X+90WDLihJCl0GirsLQz2/PFFtwOuRvL8kmEh2Y=
X-Received: by 2002:a05:6402:354d:b0:506:bda9:fcb9 with SMTP id
 f13-20020a056402354d00b00506bda9fcb9mr4343996edd.4.1682569630789; Wed, 26 Apr
 2023 21:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
In-Reply-To: <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 21:26:59 -0700
Message-ID: <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 7:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Andrii,
>
> On Wed, Apr 26, 2023 at 6:19=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 26, 2023 at 5:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello,
> > >
> > > I'm having a problem of loading perf lock contention BPF program [1]
> > > on old kernels.  It has collect_lock_syms() to get the address of eac=
h
> > > CPU's run-queue lock.  The kernel 5.14 changed the name of the field
> > > so there's bpf_core_field_exists to check the name like below.
> > >
> > >         if (bpf_core_field_exists(rq_new->__lock))
> > >                 lock_addr =3D (__u64)&rq_new->__lock;
> > >         else
> > >                 lock_addr =3D (__u64)&rq_old->lock;
> >
> > I suspect compiler rewrites it to something like
> >
> >    lock_addr =3D (__u64)&rq_old->lock;
> >    if (bpf_core_field_exists(rq_new->__lock))
> >         lock_addr =3D (__u64)&rq_new->__lock;
> >
> > so rq_old relocation always happens and ends up being not guarded
> > properly. You can try adding barrier_var(rq_new) and
> > barrier_var(rq_old) around if and inside branches, that should
> > pessimize compiler
> >
> > alternatively if you do
> >
> > if (bpf_core_field_exists(rq_new->__lock))
> >     lock_addr =3D (__u64)&rq_new->__lock;
> > else if (bpf_core_field_exists(rq_old->lock))
> >     lock_addr =3D (__u64)&rq_old->lock;
> > else
> >     lock_addr =3D 0; /* or signal error somehow */
> >
> > It might work as well.
>
> Thanks a lot for your comment!
>
> I've tried the below code but no luck. :(

Can you post an output of llvm-objdump -d <your.bpf.o> of the program
(collect_lock_syms?) containing above code (or at least relevant
portions with some buffer before/after to get a sense of what's going
on)

>
>         barrier_var(rq_old);
>         barrier_var(rq_new);
>
>         if (bpf_core_field_exists(rq_old->lock)) {
>             barrier_var(rq_old);
>             lock_addr =3D (__u64)&rq_old->lock;
>         } else if (bpf_core_field_exists(rq_new->__lock)) {
>             barrier_var(rq_new);
>             lock_addr =3D (__u64)&rq_new->__lock;
>         } else
>             lock_addr =3D 0;
>
>
> ; int BPF_PROG(collect_lock_syms)
> 0: (b7) r8 =3D 0                        ; R8_w=3D0
> 1: (b7) r7 =3D 1                        ; R7_w=3D1
> 2: <invalid CO-RE relocation>
> failed to resolve CO-RE relocation <byte_off> [381] struct
> rq___old.lock (0:0 @ offset 0)
> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read
>
> Thanks,
> Namhyung
