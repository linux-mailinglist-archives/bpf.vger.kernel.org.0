Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3E1716A0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgB0MCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 07:02:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so3014475oii.7
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2020 04:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrW5LZwrgusNW5R7fWdBcyZoH5Id25Lj621CnfewVCc=;
        b=R7ucxzv9WX65DnqA/knWAtXzG4aPD3M+Asthh3S1KCrJkFmamDtuptP8MO97MSHPba
         e34rpQIqPzJrIS5t+m2Tbc5VplqIasAxwwwWAF/g02+wjLvXAycRrcQgceZ/5e3sPx6V
         FEQqshY/WSxH/1/V4meq2t1Hh1fEGRnWWai7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrW5LZwrgusNW5R7fWdBcyZoH5Id25Lj621CnfewVCc=;
        b=F8b58pfoAvYjJnSrPEGIXdv6Ja0GzWFnbcCMaICCLB4uBtwazMj8B/Oc5oNVS/ShG3
         k92WV2Vtw6r23AF6Wq6pXjIvH8SbqIqvcDwLjflxlHgG7wVFW6qtGXNZ+2WFd0hvpohJ
         dQ+hewaKflN2fGb6SeJUh+jfTYSuZ4L6BiW4NdbZJIZeqZ3nBnImhK/8DyhxT/z7iqhp
         55xBVI8f5cMwCVrMvrD3f8M2EnD0O3msNYsVxIyQsc9LC3RGrS+8uZZseA2eqD9ZWOKg
         QPGlMQlIJTU/5AeQhE6L5UzB2Id/Z1f5Cak55kI/FvBQMU2rIhKDCyOVNZqNjdKvPHOU
         eO4w==
X-Gm-Message-State: APjAAAWJD2dhfSxb8bmMHbS2o4XFot5KxS856mPsyP/JuuS4wdm3yJw6
        2PhtU+ox/HzfspIbycWd/+99ndYe9bz+sDiZeDGkBg==
X-Google-Smtp-Source: APXvYqxGGnZ2YlIzPYcumkmeZ2az1g8ikQk+YksINp58lf1d1j35iK2m2bjoEozqq7jJAU097AlwLPvODXTA3KcrXgY=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr3007527oig.172.1582804959343;
 Thu, 27 Feb 2020 04:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20200225135636.5768-1-lmb@cloudflare.com> <20200225135636.5768-7-lmb@cloudflare.com>
 <877e08cksq.fsf@cloudflare.com>
In-Reply-To: <877e08cksq.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 27 Feb 2020 12:02:28 +0000
Message-ID: <CACAyw9832Q+uLfYgzs5oAmYZDF+3U5pPGYKViMKovqb_hKY0gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests: bpf: add tests for UDP sockets in sockmap
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Feb 2020 at 11:49, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> > +#define TEST(fn) TEST_SOTYPE(fn, 0)
> > +#define TEST_STREAM(fn) TEST_SOTYPE(fn, SOCK_STREAM)
> > +#define TEST_DGRAM(fn) TEST_SOTYPE(fn, SOCK_DGRAM)
> > +
>
> An alternative would be to use __VA_ARGS__ and designated intializers,
> as I did recently in e0360423d020 ("selftests/bpf: Run SYN cookies with
> reuseport BPF test only for TCP"). TEST_DGRAM is unused at the moment,
> so that's something to consider.

Good idea, I'll pick it up!

> test_redir() doesn't get called with SOCK_DGRAM, because redirection
> with sockmap and UDP is not supported yet, so perhaps no need to touch
> this function.

I did this to avoid needing another macro, it should be possible to skip this
with your VA_ARGS idea.

> Looks like we can enable reuseport tests with not too much effort.
> I managed to get them working with the changes below.

Thanks, I'll add this to the next revision!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
