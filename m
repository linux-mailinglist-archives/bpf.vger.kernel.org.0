Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7676DC319
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 06:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDJE3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 00:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJE3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 00:29:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164173C28;
        Sun,  9 Apr 2023 21:29:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d10so1276009qka.3;
        Sun, 09 Apr 2023 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681100972; x=1683692972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GITc3kcivv2sRtOi8AmCGAXxKwKdQhYUBJ/H+AeVdsA=;
        b=L3Ut9UB37e/k+vT9lvYNb8DD1RVZrZ14LySw/MMc+sT1jEcgAJPnqw0Y/DPmpHRj8M
         dyfdErAifH24dOSTfabarFY+wa9yRjTM3OubTCA+x8bGp9NEShPTvcGDX95u4dfDTTnH
         LRnj2NJLZrb0fnlj7BB3Dlkg7tCuitT0JEoJC9moT7o7Ht3qMm+W6Y8lhWcrzQACInR/
         LRs0H8SV56TShxbKuH8Y2T29sJw65UmGtae0+SrX/1iL1GYB12oAWrXM+tK87hiO9Zxt
         DRfJMOn2eJR67C6iXGyqACHlxusFfKnsHzpqbwMkJm3AQv7br8/hfpg2phDNxgmaqm8T
         qZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681100972; x=1683692972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GITc3kcivv2sRtOi8AmCGAXxKwKdQhYUBJ/H+AeVdsA=;
        b=VHNETfQX/dRALpXu5F0w2dRs79eIaLc5SFFn6BFCGG2mpQHsQl6MEv+z8j92hdCRii
         +Gb5AT19Q+B7jJVCcY7KGCmgpI9x2IhW2cprm5IGxHPXCF6zOIl84YIBS9oC8seYcKyb
         pXOoe/be/rkoeTKNaoKEehM7hSpvgyemc618OyxsUn5KRN6x+A8UXOH/4JkpgqXGrW4n
         3ZNDPCGEmrYEKoIpuKegGtiDWC1hA3sBhF/UUG6uFqQ6wy1PLKkuuaGOH5Gt0XfrXvGa
         8+gSj7Il0x5mxg/RRGaMZMcDzlib2d0ZgIPuy0gnH0EJTHg58sdh+OlH+qUMGsDs3Cbi
         kLCg==
X-Gm-Message-State: AAQBX9f2QXS5qr7/IRON/j560wEnNi+Bm4gW1jRfS/J8GPut6cjKpVBP
        JEJ50ey+zktmkAEGsLqjgwUPJrUE3lw4XOWo6AbsCPuMpTL37A==
X-Google-Smtp-Source: AKy350bDOKXk9fhBtDAMXchOsVtD5UYP+JvQZwX3QuqtlGp73wCTN3UJj4IeD0osMpnu3XbG6EJb8OBvWTyVug7J1w4=
X-Received: by 2002:a05:620a:1918:b0:743:9b78:d97e with SMTP id
 bj24-20020a05620a191800b007439b78d97emr3082596qkb.14.1681100972156; Sun, 09
 Apr 2023 21:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home> <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
 <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409132544.023d9ec5@rorschach.local.home>
In-Reply-To: <20230409132544.023d9ec5@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 10 Apr 2023 12:28:56 +0800
Message-ID: <CALOAHbBvvFx2b1zHyRs=JMAVtUqmk6YLJiY3+hywW4KpgwGOCQ@mail.gmail.com>
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

On Mon, Apr 10, 2023 at 1:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 9 Apr 2023 20:45:39 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > I didn't notice preempt_{disable,enable}_notrace before :(
> > Seems that is a better solution. I have verified that it really works.
>
> Great.
>
> >
> > BTW, why can we attach fentry to preempt_count_sub(), but can't attach
> > it to migrate_disable() ?
> > migrate_disable() isn't hidden from ftrace either...
>
> You can't?
>
>  # trace-cmd -p function -l migrate_disable
>  # trace-cmd show
>           <idle>-0       [000] ..s2. 153664.937829: migrate_disable <-bpf=
_prog_run_clear_cb
>           <idle>-0       [000] ..s2. 153664.937834: migrate_disable <-bpf=
_prog_run_clear_cb
>           <idle>-0       [000] ..s2. 153664.937835: migrate_disable <-bpf=
_prog_run_clear_cb
>           <idle>-0       [000] ..s2. 153665.769555: migrate_disable <-bpf=
_prog_run_clear_cb
>           <idle>-0       [000] ..s2. 153665.772109: migrate_disable <-bpf=
_prog_run_clear_cb
>
> I think bpf prevents it. Perhaps that's another solution:
>
> See 35e3815fa8102 ("bpf: Add deny list of btf ids check for tracing progr=
ams")
>

Right, it is because of the BTF_ID(). I think we should introduce
migrate_{disable,enable}_notrace instead. Because actually we only
don't want it to attach migrate_{disable,enable} used in bpf prog
enter and exit, while it is safe to attach it at other places.

--=20
Regards
Yafang
