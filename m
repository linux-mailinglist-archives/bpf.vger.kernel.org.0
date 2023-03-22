Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13866C598D
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCVWpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:45:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106FC6A58
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:45:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so79121053edb.13
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679525152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4TE9FJs6kf3hoZRIDdfAdAhdLQml0Cgb65TIqYsERU=;
        b=LGSjUukiho/dQkxkFvB0qP7Nof+d3N3DB5QsD81Io0GHbed/PPgHHRNRW9yessgESu
         U2lMFrMzfzfnZysKKOr/KcvKMt8VYu7Gf+hXN2Tc6zl6y7gq4JlBVWepwBN75jCEZcRt
         qQsMpdDzwuWnFGHHvaMfqVIyewd3bItJqkuy5Ic5sGrlnRwBoSGQWOicmMj4nXPpM7/4
         sSh3l2AAMVvJKQJ+y0Lav0qGcVea5cCJdYy+MKS1q1YuwEJnobRp1O0O4nPedKsiihiL
         +o0SHNLJfQWkwRfGgZ9SScZyaXwC1IYASeZzNWAFfwPhMb4qoqsKyDnxG4Xy+24Qpt+C
         nScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679525152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4TE9FJs6kf3hoZRIDdfAdAhdLQml0Cgb65TIqYsERU=;
        b=aeWBiQ+P71BksqiP6UfMHqzpDxAUmefv3uWPic7s1PyB2tTlciVlYK8u4Ih7HSI/NT
         RB2M31oZKH4M9ZOfgt5GVe3MUUZW/8HDuvbVQ5VNvVJX7Twwp945A1BeHtNfpKhzK73P
         5wuDPnjAGXraghRpMgIHxb+CgDxNWemoCSYLl1Bta/mgyrU6A4uGGTBpUJ75JaCtAPo5
         rPYD2YVs1Bh563S1g/MFafPUwA4iuLrLUfUJ5kq8jFUw2B96jmDMNBYGUjnQFZqrGQg2
         2JYQfpaLPW5tfer9vVdmuwE1CnNVOti9NRpH/aqxZo88bXPGTk/FHsa67Fs8RPi1vB2o
         xf8w==
X-Gm-Message-State: AO0yUKXmHRxVoNmJP1iW4jxlPCnG3878JgbwMQtkRJUeAh0E9DwETsJj
        ULtobenUosKWnT8ZEfpQtvVxan2zXMdCOw29/UfMgaw+rrmwEA==
X-Google-Smtp-Source: AK7set/FVBgsz94E/nRFir7FQUbV52OEwIIO4ZHAE+8VInM5ZaZqSRtOyk7COFZgA9RmQO0FCf1tbM1nTMdjp7UHyQM=
X-Received: by 2002:a17:906:f755:b0:932:dac6:3e2f with SMTP id
 jp21-20020a170906f75500b00932dac63e2fmr4050841ejb.12.1679525152381; Wed, 22
 Mar 2023 15:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava> <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
 <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com> <CAADnVQKxbzULYHhWUr=OQWke-QJt6QkVsO7pVBNpgurQMZPWkQ@mail.gmail.com>
In-Reply-To: <CAADnVQKxbzULYHhWUr=OQWke-QJt6QkVsO7pVBNpgurQMZPWkQ@mail.gmail.com>
From:   Davide Miola <davide.miola99@gmail.com>
Date:   Wed, 22 Mar 2023 23:45:41 +0100
Message-ID: <CAMAi7A4e=yJrCBrWMuKGs37LjOMeVAQzBPvMiysG7QW1gL0yHw@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Mar 2023 at 23:21, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 22, 2023 at 2:39=E2=80=AFPM Davide Miola <davide.miola99@gmai=
l.com> wrote:
> >
> > On Wed, 22 Mar 2023 at 17:06, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > there was discussion about this some time ago:
> > > >   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg38=
2+_4kQoTLnj4eQ@mail.gmail.com/
> > > >
> > > > seems the 'active' problem andrii described fits to your case as we=
ll
> > >
> > > I suspect per-cpu recursion counter will miss more events in this cas=
e,
> > > since _any_ kprobe on that cpu will be blocked.
> > > If missing events is not an issue you probably want a per-cpu counter
> > > that is specific to your single ip_queue_xmit attach point.
> >
> > The difference between the scenario described in the linked thread
> > and mine is also the reason why I think in-bpf solutions like a
> > per-cpu guard can't work here: my programs are recursing due to irqs
> > interrupting them and invoking ip_queue_xmit, not because some helper
> > I'm using ends up calling ip_queue_xmit. Recursion can happen
> > anywhere in my programs, even before they get the chance to set a
> > flag or increment a counter in a per-cpu map, since there is no
> > atomic "bpf_map_lookup_and_increment" (or is there?)
>
> __sync_fetch_and_add() is supported. A bunch of selftests are using it.
> Or you can use bpf_spin_lock.

Sure, but I'd still have to lookup the element from the map first.
At a minimum it would look something like:

SEC("fentry/ip_queue_xmit")
int BPF_PROG(entry_prog) {
    int key =3D 0;
    int64_t *guard =3D bpf_map_lookup_elem(&per_cpu, &key);
    if (guard) {
        if (__sync_fetch_and_add(guard, 1) =3D=3D 0) {
            ...
        }
    }
}

The program could be interrupted before it reaches
__sync_fetch_and_add (just tested this and it does not solve the
problem)
