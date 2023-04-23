Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEE6EC0FF
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDWQPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 12:15:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28076E74
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 09:15:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34a14a54so634554566b.1
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682266549; x=1684858549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDxM2/nZgVv5AuzM6A953wR/5pPPA3QiV9tEhmexKvE=;
        b=d++vfO0cOXmCM9GAkFcVGWkZcilZN1FFL3V6mb61439kFoMXB0+NXOg6NFzqrg3oHJ
         /U9XJtVijIWhKECQ7MEm0Kz4XIP8BMZNn7Kg4ZMw1QxrRAZe63uUXLHdmW92VnYwcZTQ
         2CQfLymzHTVefYIJsN9VbjisYaZ0uqt5zKZu/s8vfmJwcdWpFG3GOfylQLYv6DYK9aIm
         63VWmeXEvdV/3BlCAgGtfBs3kC45ZXb/F6jv+Flz6ITe1k9J/Nu3Jz+luW5+kojKOPdh
         V38arHiydFIVWyhCeNPOqRwKBFahZQp2fReXjFOOKQSnR7iUWwnNwJ0xsoDfiGMuvaQi
         UYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682266549; x=1684858549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDxM2/nZgVv5AuzM6A953wR/5pPPA3QiV9tEhmexKvE=;
        b=aw8BB6LdxXo++0bQ+65djpFI9A02sZ/XGesuk7aI0bRvX8DScS3MmffgJ6hpom54XQ
         /MT3gKPZUyuL9mgSnhdeCihvUGmrld2LVtiQKgBgXdUBGKNTeqWKxh70xEzyBS+DdwYj
         hUbmpgzW9yMImSU7gmJ5la1xb51ndfhWASHIwQClRc0JEIYNIT+eLvFXQ160yJoKr6nj
         opJz8xZwwdlxYSlh1Wm6Ca/tM4GCzhFOMoX/k2adeY5oqcAVsElkqWCpjRZH5PIGxw7a
         Sf5HUYA4RK0yFDzsVdIyQCY2EO25BSZ2ezw2s2SN8VX4e3LC/NR9tckAyKfC1fNMa+HM
         Ke7Q==
X-Gm-Message-State: AAQBX9fyvi/WbNQAIMN1KFAb6BRkDoTsHFqMeT/HoKSvsrejv8n3k+dU
        DZ4bunkuZroJLjdlYMDeegIUOC4SikyCoM6EkoU=
X-Google-Smtp-Source: AKy350bTYtZldrYti6ZO3iN7RVYiUlTWdwYL/Bxee8vHcplpK2amIqpCVxFZDqQ4K5tKYbj53cePksKUMAHckIBmncM=
X-Received: by 2002:a17:906:5904:b0:94f:928a:af0f with SMTP id
 h4-20020a170906590400b0094f928aaf0fmr7362723ejq.47.1682266549219; Sun, 23 Apr
 2023 09:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <xunyjzy64q9b.fsf@redhat.com> <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
 <xunyjzy6z3vu.fsf@redhat.com> <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
 <xunyfs8uz0z1.fsf@redhat.com> <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
 <xunybkjhzdpe.fsf@redhat.com> <CAADnVQKGrSvJHXbsqzEF=QSuePF5KzGUKeC_HWsY56bTTSRWMw@mail.gmail.com>
 <xunybkjfyno7.fsf@redhat.com>
In-Reply-To: <xunybkjfyno7.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 23 Apr 2023 09:15:37 -0700
Message-ID: <CAADnVQKGJNBf4EtG8kE2-xvnvw+=fb6XG3-ce6G3-csy-fd=rw@mail.gmail.com>
Subject: Re: sys_enter tracepoint ctx structure
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
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

On Sun, Apr 23, 2023 at 2:04=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redhat.co=
m> wrote:
>
> Hi, Alexei!
>
> >>>>> On Fri, 21 Apr 2023 09:02:34 -0700, Alexei Starovoitov  wrote:
>  > On Fri, Apr 21, 2023 at 4:17=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redh=
at.com> wrote:
>  >> >>>>> On Thu, 20 Apr 2023 16:12:49 -0700, Alexei Starovoitov  wrote:
>  >> > On Thu, Apr 20, 2023 at 2:40=E2=80=AFPM Yauheni Kaliuta <ykaliuta@r=
edhat.com> wrote:
>  >> >> >>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrot=
e:
>  >> >> > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliut=
a@redhat.com> wrote:
>  >> >> >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  w=
rote:
>
> [...]
>
>  >> > Let's fix the kernel side too. Something like this should do it:
>  >>
>  >> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_sys=
calls.c
>  >> > index 942ddbdace4a..7aa1f4299486 100644
>  >> > --- a/kernel/trace/trace_syscalls.c
>  >> > +++ b/kernel/trace/trace_syscalls.c
>  >> > @@ -555,7 +555,7 @@ static int perf_call_bpf_enter(struct
>  >> > trace_event_call *call, struct pt_regs *re
>  >> >                                struct syscall_trace_enter *rec)
>  >> >  {
>  >> >         struct syscall_tp_t {
>  >> > -               unsigned long long regs;
>  >> > +               struct trace_entry ent;
>  >> >                 unsigned long syscall_nr;
>  >> >                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
>  >> >         } param;
>  >> > @@ -657,7 +657,7 @@ static int perf_call_bpf_exit(struct
>  >> > trace_event_call *call, struct pt_regs *reg
>  >> >                               struct syscall_trace_exit *rec)
>  >> >  {
>  >> >         struct syscall_tp_t {
>  >> > -               unsigned long long regs;
>  >> > +               struct trace_entry ent;
>  >>
>  >>
>  >> > pls add build_bug_on that sizeof(ent) >=3D sizeof(void*).
>  >>
>  >> Ok. Should the line *(struct pt_regs **)&param =3D regs; be commented=
 somehow?
>
>  > commented out?
>
> No, no :)
>
>  > No. It's mandatory.
>  > And the reason for build_bug_on existence... to make sure that there
>  > is enough space there.
>
> Yes, it's clear for sure.
>
> It can be not obvious why basically 'ent' is inited with
> 'regs'. Before it was called 'regs' at least.

Got it :) Yeah. A comment describing the intent would be nice.
