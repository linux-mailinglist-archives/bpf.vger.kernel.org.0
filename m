Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704893822B
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 02:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfFGA3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 20:29:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41844 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGA3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 20:29:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so198286lji.8
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncfB1bkvQjjcQUi6KbWdikB3/nwSp0glJr+hMN1OMNE=;
        b=u5FEujl3lGcx9XdOagsLbbFwEOqChX3g2CCPr8q40+ALGZK+WZUqoNYtF7OjzdrqiT
         9tM2aXa7breP+9A7IF6PMqI4i55LrizriOvQCcLBa2YHNwFs9reluUOCcsOZz5A2QxIo
         SkPlqsU82T3rXZfpuM+tOWWdkzNClsqJog1zyAwcwEzLUHh7Eqaaz+j42QenVMJq8u54
         f1S/070RU8jt80pvO6aTn4x9ylCSt19/Gd2qU8gGn02RcN0DY8BzkEmqdgHEH0og1Djp
         6BF37G02EFFEkMhy8IfqTEaSHWhqz2NuuRM5v/PNg5D4f6wtbYeEvUF2et/QnRaHV6/f
         Ux8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncfB1bkvQjjcQUi6KbWdikB3/nwSp0glJr+hMN1OMNE=;
        b=hgZJxHlPJz8WQmHKVGu76GqLkcx+eQHlY2oPhufctxCQ9tcBoEgXq3QVShjeVe5MYN
         /Erho74iq7gxS2MV1aYjyFfD3jejO/PC1H6mw9iBzr4dvMSX3Tqo73RktUqMalzByVqz
         SYrkBW+Dsv94F6f4DM7QThXy5PWhKIXd4hheyndLWl20SDyVsDwwnLT23n4jIQHT4bUP
         b5jcjPNQuJ1HeVx6xR25zfSbQeRQ0ycw8D+gixPdeadHRa+9dR1GQbBA9H/qeJAGeQKJ
         biYVUgUhylPSjivIw+1sgnJlcNhDSCySUGPRUcNwhXUW0mzRP5MxqPw7tf77iF9YNb60
         Bl+w==
X-Gm-Message-State: APjAAAWixB/AbTq4/UiMsTdRBAjU9ZCiNYBGeX3EwG7p3Q76z0rInTPg
        nM+3a6tgjGGPWf1BFDkXeTgPW7wF3BoE9KR6W1mtwA==
X-Google-Smtp-Source: APXvYqylZBlxMuSgk1gtHWMyh1wk340O0NkPx7eDymU0H+xvP4SJf7jdDw58hISYxIf+S8L9NDzK76NR4rKT/Mkzmlo=
X-Received: by 2002:a2e:9885:: with SMTP id b5mr486812ljj.206.1559867383982;
 Thu, 06 Jun 2019 17:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
 <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com> <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de>
In-Reply-To: <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Jun 2019 17:29:32 -0700
Message-ID: <CAADnVQKJr-=gZM2hAG-Zi3WA3oxSU_S6Nh54qG+z6Bi8m2e3PA@mail.gmail.com>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600 instructions
To:     Andreas Steinmetz <ast@domdv.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 6, 2019 at 5:23 PM Andreas Steinmetz <ast@domdv.de> wrote:
>
> On Sat, 2019-06-01 at 22:03 -0700, Alexei Starovoitov wrote:
> > On Fri, May 31, 2019 at 3:55 PM Andreas Steinmetz <ast@domdv.de> wrote:
> > > I do have a working eBPF program (handcrafted assembler) that has about
> > > 600 instructions. This programs takes more than 2 CPU seconds to load.
> > >
> > > In short, the eBPF program selects and redirects packets, does MSS
> > > clamping and sends ICMPs where required for IPv4 and IPv6. The eBPF
> > > program is part of a project that will be GPLed when sufficiently
> > > ready.
> > >
> > > I am willing to cobble something testable together and post it
> > > (attachment only) or send it directly, if somebody on this list is
> > > willing to investigate, why the verifier is having lots of CPU for
> > > breakfast.
> >
> > Please post it to the bpf mailing list if it's reproducible on the
> > latest kernel.
>
> Will do, probably over the weekend - I have to do this as an attached tgz,
> though.

text only please.
bpf mailing list doesn't accept tarballs.
