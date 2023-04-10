Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113556DC34E
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDJFhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 01:37:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6230F4;
        Sun,  9 Apr 2023 22:37:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h3so18438704qtu.1;
        Sun, 09 Apr 2023 22:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681105028; x=1683697028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSSM4Ko5+t7Pv6ZeauQVLzpIgbt0M4rB/pYJhq+urPs=;
        b=OZLvRrRJ9XBsIe+vjlVm+x8eXYuzNXcdCvXF4idQn+MDtpENf7KayEoeU6CnX81XSO
         yDunnu6hMyns4TOupEisWrQAzqdej+cIP3E0mgFSay6b3xS2eGt5sdUBALbCOGA0OMwy
         TCgmhZIrqLraFvO9HBdzSSYBMegk2wRZSMDUJjts6YyHqEl0sUmYekVyh6FWWZAK6EFK
         X68U78sjYolT+4+respW1M7txhlOIRQpZNRCz3RH9brzUEmw/Lhxwlj43YZMP762UVz6
         MENr0AVmY1WWj1U8m3Sfo+W7TsaOnHSQhtu3ycNIq5ZYbBxdvwsNrluoASAD0DA4jF6w
         MeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681105028; x=1683697028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSSM4Ko5+t7Pv6ZeauQVLzpIgbt0M4rB/pYJhq+urPs=;
        b=W1qT097UIPhHZjmY+4DNk/KefSha7g0pUa319IFtBE5itZHNlNpI9i7Rw1prnkZR3n
         VwwtNxV/SfNeB/aw4LmkCJ5WzI2sDHgh8EjwlvoYBJCiPJtcxrJxHAG88NmkaoAY8rWN
         Zb3VyzW+qOqeVomoqojj7a3eiTlMiMnArI+pLWAPzOeLHFICCGATmJgLfg51zAk8QxZw
         9H/zqE6BCIOdXqfWUecgaJQHVU+E8JL4WmUYYBVzwhYErXJywNNb4yC2dnAsmLWyzv9K
         XtlGXMpOwtaRPH8wTixppfwpFw+fr39HbrciiF5gt4ZUwYpL0CeqlWElI79soGmkRFra
         nrYw==
X-Gm-Message-State: AAQBX9cEJPhzzxrQjrKt/4tLH6gOQNnFp/ebMcKQyc65Gf0DMOc14kMP
        e16r1Hg3tQh6u0iW1fa4DhKegJtljmZoU+JuqTU=
X-Google-Smtp-Source: AKy350Yld8G3dInkX8Rf5vgLEcTA783F8Tsk9/U8AAuP3e74RcNdv7+rQ9I42uPKaJUjQy3VLA0P6W77oRCphC0PlU4=
X-Received: by 2002:a05:622a:1994:b0:3db:c138:ae87 with SMTP id
 u20-20020a05622a199400b003dbc138ae87mr3633621qtc.6.1681105028537; Sun, 09 Apr
 2023 22:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home> <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
 <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org> <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home>
In-Reply-To: <20230409220239.0fcf6738@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 10 Apr 2023 13:36:32 +0800
Message-ID: <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Mon, Apr 10, 2023 at 10:02=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Sun, 9 Apr 2023 22:44:37 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > You can use ftrace_test_recursion_trylock() before using migrate_disa=
ble()
> > > if you ensure the callback is only for fentry. Can you prepare a fent=
ry
> > > specific callback?
> > >
> >
> > fentry uses both ftrace-based probe and text-poke-based probe.
> > ftrace_test_recursion_trylock() can avoid the recursion in the
> > ftrace-based probe. Not sure if we can split bpf_trampoline_enter into
> > two callbacks, one for ftrace and another for text poke. I will
> > analyze it. Thanks for your suggestion.
>
> ftrace_test_recusion_trylock() works with anything. What it basically
> is doing is to make sure that you do not pass that same location in the
> same context.
>
> That is, it sets a specific bit to which context it is in (normal,
> softirq, irq or NMI). If you call it again in the same context, it will
> return false (recursion detected).
>
> That is,
>
>   normal:
>     ftrace_test_recursion_trylock(); <- OK
>
>     softirq:
>        ftrace_test_recursion_trylock() <- OK
>
>        hard-irq:
>           ftrace_test_recusion_trylock() <- OK
>           [ recusion happens ]
>           ftrace_test_recursion_trylock() <- FAIL!
>
> That's because it is perfectly fine for the same code path to enter
> ftrace code in different contexts, but if it happens in the same
> context, that has to be due something calling back into itself.
>
> Thus if you had:
>
>         bit =3D ftrace_test_recursion_trylock();
>         if (bit < 0)
>                 return;
>         migrate_disable();
>         ftrace_test_test_recursion_unlock(bit);
>
> It would prevent migrate_disable from recursing.
>
>     bpf_func()
>         bit =3D ftrace_test_recursion_trylock() <<- returns 1
>         migrate_disable()
>             preempt_count_add()
>                 bpf_func()
>                     bit =3D ftrace_test_recusion_trylock() <<- returns -1
>                     if (bit < 0)
>                         return;
>
> It would prevent the crash.
>

Many thanks for the detailed explanation.
I think ftrace_test_recursion_trylock() can't apply to migreate_enable().
If we change as follows to prevent migrate_enable() from recursing,

         bit =3D ftrace_test_recursion_trylock();
         if (bit < 0)
                 return;
         migrate_enable();
         ftrace_test_recursion_unlock(bit);

We have called migrate_disable() before, so if we don't call
migrate_enable() it will cause other issues.

--=20
Regards
Yafang
