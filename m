Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAC195607
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgC0LKI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 07:10:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36205 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0LKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 07:10:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id l23so9291501otf.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEHvc2eECIwXjJj+lOYocuGVybUGUEyMeCQsRA0GpXI=;
        b=Q6wS68Q0JwyVBewdNcVKcLjVcH0GqfxOXy0HwvU2Hq0i2erc8+RURo/R9Ju0b6f2aA
         c3JqYERhZeQRYRhNhRsL8qnDmpYM4v8cJqE2dRXuh5FIz7WSX47j/Bc89OdLQjJShPzi
         mqmdcJvhUjDYth1wA3s+2GdjIDekfraxmaVE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEHvc2eECIwXjJj+lOYocuGVybUGUEyMeCQsRA0GpXI=;
        b=lf/gOBzrvqAMMLD7Fe87dvfXRxqEZC4jhEfFJw1IhiEFYgwt1jL9Bwhzv/6hc0pkoP
         CZ6K9PHL3c4eLDO/US2KaVM32+s8pQSMcFu9ye3OyKA4jrSlHKWvfznKttyfwDdWUI9r
         GvbvWEMYo/kVml6cYeZ09S6BbtUciDEUqImW8572F88otVjYHAJhcTRZSRzyzK8J1ttf
         KG9sYfk8jYduTujKT3FmXtR22xMHWxNGMSeXZBGDsSFET5REh33pHzC3jV4geMHCDSqi
         LH8F+hVk+PByEOy34t1+E1wSscBxOWtEcer68meJFhUGtFhWWdebP6iDfSu450EB17Tq
         VqhA==
X-Gm-Message-State: ANhLgQ3qO+ubY4CPOUof7B9+6LUMly+LQUOjCfzedBCXedpVQQ/KNWe+
        LT4CIRDn2g5YDxFZq0OwKMgGdVSxBRa6jjT4oj/s+g==
X-Google-Smtp-Source: ADFU+vu7xu9O8vJDb0KgMXnTp8WJvh2bh3nQ32TfTHdtFDYHU+EAhDkNL0uH5s0xm0NWNfjBEYDPjbpfFYlS+wXEzL8=
X-Received: by 2002:a9d:4009:: with SMTP id m9mr9521052ote.132.1585307407626;
 Fri, 27 Mar 2020 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com>
 <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
 <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
 <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com>
 <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com>
 <20200325221323.00459c8d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200326194050.d5cjetvhzlhyiesb@ast-mbp> <042eca2c-b0c1-b20f-7636-eaa6156cd464@solarflare.com>
In-Reply-To: <042eca2c-b0c1-b20f-7636-eaa6156cd464@solarflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 27 Mar 2020 11:09:56 +0000
Message-ID: <CACAyw9-p2HhswYamV_-5H51JmwfzU64McEBYUPAOfJ7vqcvzeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing
 program when attaching XDP
To:     Edward Cree <ecree@solarflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020 at 20:06, Edward Cree <ecree@solarflare.com> wrote:
>
> On 26/03/2020 19:40, Alexei Starovoitov wrote:
> > At this point I don't believe in your good intent.
> > Your repeated attacks on BPF in every thread are out of control.
> > I kept ignoring your insults for long time, but I cannot do this anymore.
> > Please find other threads to contribute your opinions.
> > They are not welcomed here.
> Given that this clearly won't land in this cycle (and neither will bpf_link
>  for XDP), can I suggest thateveryone involved steps back from the subject
>  for a few days to let tempers cool?  It's getting to the point where people
>  are burning bridges and saying things they might regret.
> I know everyone is under a lot of stress right now.

Sorry, I hadn't seen this message before sending my reply. I think
this sounds like a good idea.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
