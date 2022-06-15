Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612CC54C577
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbiFOKID (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbiFOKIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 06:08:02 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F039816
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 03:08:00 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id d39so11405718vsv.7
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gz01wLOmYbzPFewaBzlsp1NtYztmbI+KjPaWV1zpQ9A=;
        b=Pzn4MqVDehQVMbSv0Q1Xm85YWmnHrd0OAEg7norCMhU41t+kdttCyU5mJs5WTSyI4a
         Ev4Yp6oZBCCTG7sZcgT49J7OsZDJL1KZSbQsHB+gRYgvQPBK3hmWHmny+RNrSOHnVZsE
         TqJ9Y/Tq7TiPIcaeiG4968ifnKGlApK4RNUY9dgIdTBpVss/N9/RY7bHQFHf4uoxnKMs
         44+DG5kQ5J0ek0Uh4OsM6rEbz1WIs3R6cB9DdQsWUm7IVDlc2LgHNUO2Rt25ECPlYLf9
         Q+CyCbouRHkQmYwFay4zCq/b2eHRnH49GjA2bluDhvetL2LKTtaOirG3Wk10TruoE8Oo
         WR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gz01wLOmYbzPFewaBzlsp1NtYztmbI+KjPaWV1zpQ9A=;
        b=75omHMcx4ILU63rpVotmdsvmN8VptmQI8dakbLaS0UMXJUUAUNaCwIEPF7lPoIYDc4
         NxLVwv+Vl/EyoTnYn2/KL82vh2PZMN1dLywxCCzLzFtjs3iz2we1yFdKWZu7ejtrt/Nl
         xD5ifvL/3bFyEhJ45LbF6VyRbdZwZJlCm8DMArMrib8HvsZkL/P3WWBT9TcoHL8fXghe
         vVUZKxBvxLO99RgT37/NpOjdpE+mlVofPTmzmbctRo2uScipEc9T2pZjImPgFeiYufsR
         b5eq2QVgxjaT2cMs7vl4CxdfxLwqoi2LpTHM+di+eU4EDIiGB2etIukMpDqxXvx5D+iX
         SXmQ==
X-Gm-Message-State: AJIora9IdsPhfcEU6cNBtmE6trEn+n7BsJN+zmYLmDjH01eUArui91gQ
        x9kSIRrK6MN0oVKK3itpGFwHWauhgSgLN6VwaBDIMvRd
X-Google-Smtp-Source: AGRyM1uaMPZ5nuoTW+CbluiDhGGas1p5vSDfQirdJ16KSHY9gRMbLgEmoqvdcgfcfYfzOo+I6kfHtx44D09cbMENev0=
X-Received: by 2002:a67:cd16:0:b0:34b:95ab:715a with SMTP id
 u22-20020a67cd16000000b0034b95ab715amr4458171vsl.19.1655287679078; Wed, 15
 Jun 2022 03:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <f038d6f9-b96b-0749-111c-33ac8939a1c0@i2se.com>
 <57664575-d02e-44fd-0314-d2e814775fdd@i2se.com> <CALeDE9PuZbWzSkA=fa+z+yhOox-ZEVuRO1_gyJp_d73ouSZtMw@mail.gmail.com>
 <05b3ae90-b66b-84c4-b525-dbab3aa677eb@i2se.com>
In-Reply-To: <05b3ae90-b66b-84c4-b525-dbab3aa677eb@i2se.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Wed, 15 Jun 2022 11:07:48 +0100
Message-ID: <CALeDE9PB+25eq7ouxuhPj7-mOLT00CyRh4sAeKYkqvoDtPUo=w@mail.gmail.com>
Subject: Re: [BUG] null pointer dereference when loading bpf_preload on
 Raspberry Pi
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     bpf@vger.kernel.org, jpalus@fastmail.com,
        regressions@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stefan,

> >>> Jan Palus already reported this NULL pointer dereference on bugzilla
> >>> [1], but i want to make sure this is noticed by the right people.
> >>>
> >>> I've i boot my Raspberry Pi 3 B Plus with multi_v7_defconfig and the
> >>> following config settings:
> >>>
> >>> CONFIG_BPF_SYSCALL=y
> >>> CONFIG_BPF_JIT=y
> >>> CONFIG_BPF_JIT_ALWAYS_ON=y
> >>> CONFIG_BPF_JIT_DEFAULT_ON=y
> >>> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> >>> CONFIG_USERMODE_DRIVER=y
> >>> CONFIG_BPF_PRELOAD=y
> >>> CONFIG_BPF_PRELOAD_UMD=m
> >> are you able to see this issue in 5.18.x, too? I'm asking because the
> >> BPF settings comes from your configuration.
> > I've not seen it in a standard boot, is there a simple way to test
> > this, TBH I've never really played with bpf (it's on the todo list) so
> > if there's an easy test I can certainly check.
>
> it's just during boot. No need to do something special.
>
> I want to figure out, if this is caused by my cross compile environment.

No, not seeing that anywhere, I've got 5.18.3 running on omap/rpi/imx6
32 bit devices without anything like that

We had an issue around BPF on arm32 back in late 2018 and I tried to
turn some of the options on in defconfig so they'd have wider testing
but got push back. I don't remember the exact issue there though (and
it's long been fixed)

Peter
