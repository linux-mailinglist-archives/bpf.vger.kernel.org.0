Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC936C59BC
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCVXAJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCVXAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:00:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC128728D
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:00:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so79370205edb.6
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679526006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfXlW9Yd6FljZAbW7F8E4NhsLFyPbtCV1+3wrjJq5SE=;
        b=BOvVLSAaIufGN0gOiE0mI+++EzQ0kVGR5FDMlEmeYEh61GoVbG5iEufgsCvMnkCdOe
         z06mGE27Sd85n/Ztr89IWM3RVRcfdnYEL6zHgc6Rd/gAQdtIU9MeY5DOT/rPW7UzN3dB
         xUmS1wiZRpHkoErz8Xz8QssP/yiQHB5JfS0wuWJuUUSAdnEETDXgL2GKmF7V8//aysyw
         TWehNmDJZEFmU1v+ZZp/AUjx6LNNkkJMI/sDWz/eH/jyjsbALUty71E3+Z7c/GwWelHq
         29EptkXrEob8w5HHarygZe0pTH4PPBzcn4vqsJGVynhMJEMkuFt7Udpb4h/EpSjYYBmi
         fFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679526006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfXlW9Yd6FljZAbW7F8E4NhsLFyPbtCV1+3wrjJq5SE=;
        b=sxWXFGdQaDBkmsvlfx03ZMblWLg0EwLoVY3lD2ko2oH5U6NYy5TsKoRppO+31LSrCs
         CuVsG0dF9Xw8ziSXUXwxAnZcbAuHf3Viq/R5KGf/BmUfUCpnvvh5hdKm9l27CGztXxUf
         aZlRxbR+RPSqUSWlV6UZa2sYvUsGEPKvylMVf+L038X36qT0TId+jfGsugHN+OZ5vWzh
         G8hgULz+37sQ0Bh6IGMsW0o1GZSTdWpWiIUiNoNE7tT9IX/qpYcn803GI4WBlI+OU7Wa
         8BWv5DmfY1xy3Jc2+E68KYXKnjiIB/ORPCrWs/fcXlLBKYU+Amww9mLre25yakcmb3wj
         +UHQ==
X-Gm-Message-State: AO0yUKULqphKqv2jR+hJFUjSkyi6N0TbeGfuL8dl+0UDmiIHzRqyhKJP
        nms/AFbVnuT2d4slS2kgCtjXTyuhOBiU10MRoGHMaWhk4jU=
X-Google-Smtp-Source: AK7set8dtFLYRgmCpSijj3p3n716klwRKVqoLvnsluSPwEQTTrygUtPnwltnCvwdlfcyGKLIG0ntiOVSjM+Yxtjdxvs=
X-Received: by 2002:a50:c3cf:0:b0:4fb:2593:846 with SMTP id
 i15-20020a50c3cf000000b004fb25930846mr4219845edf.3.1679526006062; Wed, 22 Mar
 2023 16:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava> <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
 <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com>
 <CAADnVQKxbzULYHhWUr=OQWke-QJt6QkVsO7pVBNpgurQMZPWkQ@mail.gmail.com> <CAMAi7A4e=yJrCBrWMuKGs37LjOMeVAQzBPvMiysG7QW1gL0yHw@mail.gmail.com>
In-Reply-To: <CAMAi7A4e=yJrCBrWMuKGs37LjOMeVAQzBPvMiysG7QW1gL0yHw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Mar 2023 15:59:54 -0700
Message-ID: <CAADnVQKp9QLDKZTs=ArxQfSBDKXS769BOUYFpBn0O2oumrvO5A@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Davide Miola <davide.miola99@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
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

On Wed, Mar 22, 2023 at 3:45=E2=80=AFPM Davide Miola <davide.miola99@gmail.=
com> wrote:
>
> On Wed, 22 Mar 2023 at 23:21, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 22, 2023 at 2:39=E2=80=AFPM Davide Miola <davide.miola99@gm=
ail.com> wrote:
> > >
> > > On Wed, 22 Mar 2023 at 17:06, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > there was discussion about this some time ago:
> > > > >   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg=
382+_4kQoTLnj4eQ@mail.gmail.com/
> > > > >
> > > > > seems the 'active' problem andrii described fits to your case as =
well
> > > >
> > > > I suspect per-cpu recursion counter will miss more events in this c=
ase,
> > > > since _any_ kprobe on that cpu will be blocked.
> > > > If missing events is not an issue you probably want a per-cpu count=
er
> > > > that is specific to your single ip_queue_xmit attach point.
> > >
> > > The difference between the scenario described in the linked thread
> > > and mine is also the reason why I think in-bpf solutions like a
> > > per-cpu guard can't work here: my programs are recursing due to irqs
> > > interrupting them and invoking ip_queue_xmit, not because some helper
> > > I'm using ends up calling ip_queue_xmit. Recursion can happen
> > > anywhere in my programs, even before they get the chance to set a
> > > flag or increment a counter in a per-cpu map, since there is no
> > > atomic "bpf_map_lookup_and_increment" (or is there?)
> >
> > __sync_fetch_and_add() is supported. A bunch of selftests are using it.
> > Or you can use bpf_spin_lock.
>
> Sure, but I'd still have to lookup the element from the map first.
> At a minimum it would look something like:
>
> SEC("fentry/ip_queue_xmit")
> int BPF_PROG(entry_prog) {
>     int key =3D 0;
>     int64_t *guard =3D bpf_map_lookup_elem(&per_cpu, &key);
>     if (guard) {
>         if (__sync_fetch_and_add(guard, 1) =3D=3D 0) {
>             ...
>         }
>     }
> }
>
> The program could be interrupted before it reaches
> __sync_fetch_and_add (just tested this and it does not solve the
> problem)

Ahh. I got confused by your bpf_map_lookup_and_increment idea.
It won't help here either if you're concerned of IRQ
after prog starts and before the first lookup.
You can use global data. In such case there is no lookup function call.
It reduces the race window, but it's theoretically still there.
Try kprobes, but they're slower and I suspect you'll miss more events,
because all kprobe progs are in one bucket.

Better approach is to switch to networking hooks instead of tracing.
