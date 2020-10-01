Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9849280517
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgJAR0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAR0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 13:26:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CCC0613D0;
        Thu,  1 Oct 2020 10:26:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s205so5336355lja.7;
        Thu, 01 Oct 2020 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2eUGU+6UJ2iNJKOqgJiZZvCYDFJo4EPNmr8omyQDAM=;
        b=suL0SQnHO5+XcwiJH/4SWM63Idj/mI1NdY8opxw07lARA3Qbl4iQBnMkj7466Hn6xE
         zqwSNVgsDeCkqrZ6Xa+bGXyXdre6kw+1UArbMFRlfEaqwiJI0aSGHEPO9XDNp8A8utmb
         xVA54FWEcI+3tJUw05dCapTJVcR1uLwgi6hhZy06NdL/E5ZYbBnU7SoUqJFG8eI6mLZ+
         xkNCKKOowLL6+PTEOYwyE4TXk4Zs6nOlRHpTbrwGDGVHJFC9vUH+njUHBIABJ1p2xAi3
         zZ6wWnU287BKzKGBajhY+IpxAnrfRga4gsfskTOpAq09BpPwHRHVuZMSemBKm1mNoXTW
         h9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2eUGU+6UJ2iNJKOqgJiZZvCYDFJo4EPNmr8omyQDAM=;
        b=CrjAlJWZic5kq4ah+6W5XBJLZg0g8Pbv32JBD4Jl2eP3Gy1Q0vARvbL66I2mlzXvu4
         cs3G/q8Jb5geLcrfBOVo7Jq0couC63fw4D8q9Ih+/f3pQSYV104aKnxM6FC4wdPiXTqk
         sk59GzA0vY7jhOO35zrqUcsQVXqViOxVZxlL6hplAk57RXBWhIwXqzL36HrxWeCnDQFr
         w/qKiF47+U5nqfrhpnAarOCm6HeD7pHxLFRYneRJ6dZJIEORCB7WxAG9pIXZCZQQqxmZ
         W83C30wf1ZmTWwDo2fZ+128SqNNXyvrt3f8avIod2LHsT6hsuoHJko9+RuawzIJbEsOw
         wCnA==
X-Gm-Message-State: AOAM5312CzA8TaHSMC3juKhiA68d3O6b0s9OMUyj/AMyB7zLLVKBfIBm
        ASoe5zqaxpHgi43gzNXXVKCtgjg7nrKTLi71C4nZyTkz
X-Google-Smtp-Source: ABdhPJzOHdcyd5WenZTs16njk0NN+gwihYQYr9swObb9UqSRviEA7Hnufv3hNP54Vz8sqG/oX6J8Bcbb47ZHpkIb62w=
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr2826408ljj.450.1601573179021;
 Thu, 01 Oct 2020 10:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <87sgayfgwz.fsf@nanos.tec.linutronix.de> <87mu16f4ze.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu16f4ze.fsf@nanos.tec.linutronix.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Oct 2020 10:26:07 -0700
Message-ID: <CAADnVQLejbNccFttVZY=dzQ7Qqyjjtg4-PuBt36Ms+_DQAQZwQ@mail.gmail.com>
Subject: Re: mb2q experience and couple issues
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 6:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Oct 01 2020 at 11:13, Thomas Gleixner wrote:
> > Yes, it's ugly and I haven't figured out a proper way to deal with
> > that. There are quite some mbox formats out there and they all are
> > incompatible with each other and all of them have different horrors.
> >
> > Let me think about it.
>
> I've pushed out an update to
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/quilttools.git

Awesome. Pulled and tested. Everything looks great now.
Thanks for the quick fixes!
