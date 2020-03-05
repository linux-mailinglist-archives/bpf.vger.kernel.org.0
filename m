Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7041817AA6A
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEQWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 11:22:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50495 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCEQWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 11:22:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so7033089wmb.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEvgQVZavtTsnR3H4wayPtk/nZQ+Zm47QLXTHSzN7fo=;
        b=GcAAzWY1RcrrmwdnC52Rlub3aR8//mgYvQ9FmOS++fuNEZoR8Rlkaj/Z1BRuuybFA0
         uMHBNEOfUefPRil4g2NixlSsSkl8in3cEnm9Mc1ocdM/8SFn2GNnB/QfmtaelLsczEt0
         XY/4MAu0ZTNZZCjzbYc0+4sWwqTPwaWT2A2xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEvgQVZavtTsnR3H4wayPtk/nZQ+Zm47QLXTHSzN7fo=;
        b=FR+I0/iR7pRwIud3fMg7g/d5USCDsZvRBVFT6Iv5WRpa9TOKyU4innlXO1KyzUg/d5
         ZSzbVasJEBzHdjU43YObXyhCddJ1+KgU2F/m5OTas1Sk7LgFnn079RnL32TvYu9s9sIS
         r1FfgTJHe/AhsiOZ650Pr6kVBb5GhQ9etc9oKBmNi9IChdOWAaN3270ufDqbkDo8y7AI
         oEv2u3bKvyE75TIDljDfFTRZmQ8ElH8nq5tZ86jDTSk9GwgZKgnCirx3RKrAxt910/tg
         BYzkhRbYByqDtvlQFnjIl8220Xc+fYHLszWYIAzVzZikv0teqvTklTtxGy2gXcLz4J8p
         WrJg==
X-Gm-Message-State: ANhLgQ0+87NRGh2EzGDmblWZUI93EO3vxHHd7vnBxkzn+Rdp9gDm3ifC
        owEBbqgVMcFC3RXLr9ratkGbCid3KaMub5vvWqFUCg==
X-Google-Smtp-Source: ADFU+vvBj+1xJThqxd5rF87Tunq26QxaCiqKxwYjHudkZ0a9XD8NqOyNXEkTlJ26vyLocVjmpuu2PlqvdYuTfnFNgbU=
X-Received: by 2002:a1c:2504:: with SMTP id l4mr10601800wml.72.1583425364775;
 Thu, 05 Mar 2020 08:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20200305175528.5b3ccc09@canb.auug.org.au> <715919f5-e256-fbd1-44ff-8934bda78a71@infradead.org>
 <CAADnVQ+TYiVu+Ksstj4LmYa=+UPwbv-dv-tscRaKn_0FcpstBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+TYiVu+Ksstj4LmYa=+UPwbv-dv-tscRaKn_0FcpstBg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 5 Mar 2020 17:22:34 +0100
Message-ID: <CACYkzJ4ks6VgxeGpJApvqJdx6Q-8PZwk-r=q4ySWsDBDy1jp+g@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 5 (bpf_trace)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 5, 2020 at 5:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 8:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 3/4/20 10:55 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20200304:
> > >
> >
> > on i386:
> >
> > ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to `bpf_prog_test_run_tracing'
>
> KP,
> Please take a look.

Sure. Taking a look.

- KP
