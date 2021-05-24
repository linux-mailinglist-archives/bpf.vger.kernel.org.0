Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6547D38E27F
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhEXIq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXIqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 04:46:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B2C06138A
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:45:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p20so32551661ljj.8
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7Eot4reizRuUqmf0K/rkTFVGo7P8pVMLjLh6jyCFRA=;
        b=jInJomWEJ28bqvyt64gfUqIqCzsBLfPEp0SuWcOA9hPgIacmJdJNeky6DMbwP8Wz+q
         HDm6wLRis4iIKKkKF3NbsWrHYo2VBydUGn7Y2LAWpNbaA+Gc/NvqbfGoYIGcNOfV/cHA
         M11srfGLNcSGaAlz//XUQdiuQPC77HjtAAUlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7Eot4reizRuUqmf0K/rkTFVGo7P8pVMLjLh6jyCFRA=;
        b=kolXbYu6q7YiZPzg9lKVBNlnSv/It5j4vjsoLF7MAr8CVHaUtt6JRu9L9+PfkxeJIw
         QLnb4o/ZXGY+pE9N7kNVAfL11VoiDWRN3PxP7Lo48UOy45bY7r6mmastpUa9rjjiEGVx
         08m5ybE0iTNUIp0fdpy1v8mFu2WR8U1dQZwRbLijDpAudxEw4SmWNRIjQGc3M9eFtcQW
         WJXBg6WWpjAL4mqTARezYq72bE9D/83MkS5Rh+pyvfXkcChRx8XZjpMzNAk94HG2aF5+
         1DOzcFhk2gC2NNQd31g/xStazd2L3JOiRGKSweVRQ+9AI1eG4P38OUXYOh8wCyeusmZ+
         u2Og==
X-Gm-Message-State: AOAM533V8OMNzDch0bXX3mZ8kahQm/FOzlduTD+biDXTymlrIx16rvKE
        ASJst09I/z3SUAywg8G6rkaUILJpdfr4z9TjwJbylg==
X-Google-Smtp-Source: ABdhPJwA1x8pZHLOORWFrbzbiN4gz/ORPklgCSKn6iOCER1OtA5BndR6oypOHyH9f+eeYntk7OSUjehV0lu0suev7dE=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr16419494ljp.226.1621845924323;
 Mon, 24 May 2021 01:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <CAM_iQpWDgVTCnP3xC3=z7WCH05oDUuqxrw2OjjUC69rjSQG0qQ@mail.gmail.com> <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
In-Reply-To: <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 24 May 2021 09:45:13 +0100
Message-ID: <CACAyw9-aCgu5aApK4QKEJ-rdRTAEda5f8jdJDvmbnNod-RxP-Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 23 May 2021 at 17:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 21, 2021 at 2:37 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hi, Alexei
> >
> > Why do you intentionally keep people in the original discussion
> > out of your CC? Remember you are the one who objected the
> > idea by questioning its usefulness no matter how I hard I tried
> > to explain? I am glad you changed your mind, but it does not
> > mean you should forget to credit other people.
>
> I didn't change my mind and I still object to your stated
> _reasons_ for timers.

For others reading along, here is the original thread
https://lore.kernel.org/bpf/CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com/

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
