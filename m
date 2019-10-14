Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77359D62A5
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfJNMfw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 14 Oct 2019 08:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbfJNMfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 08:35:51 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B92554E93D
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2019 12:35:50 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id m16so2884969lfb.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2019 05:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PvVm8u9ObL3aYBOygBx9VWFhpRttK7ssE/n72+9xa/0=;
        b=XRWTw0ocwqo+ohLdr6MmWcN9GLt1PM/YpLAjdpb7GacYieNJPk8J90eD7qoxi4hsXt
         fMv3PvakdRk2Xde6SpHh4ep9pwbn1ljLXHXZqR0myRXeNcUhwa+ltJd6HVO2Z+ta7CMA
         eWncrDVCoxbUVxCqUhoZ9XFEIiY8O5iuVxVZjuSEIzD7sAs5fzRxvwMxPIKYwpvpxdor
         ZsZkMnlFJITJKI+c3l6SdD5S6y3MQnphE+I4UQ0HpIWzZJHBrKgWWycUpJjMmk9+qtNs
         fipyWNpbdVKCIaW+41JFlFD2/yZOemnQ8yhWUNGuknYZuL1aXvG6qaokf+YKj8Gslml/
         hwjA==
X-Gm-Message-State: APjAAAVrQNAkrTeQqTFZc3BsZEMbBMHdKGdaePRzOJPHnOToaewCKolH
        4NBsYP9qBDNcK26ZixZ7mvh54LVmCP2KmGY0SGuBT8Ey4vUscXoWzK4ux8dV7Ap06m7rwxmqmuB
        2lgG+YXh3JaMA
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr16948674ljj.168.1571056548723;
        Mon, 14 Oct 2019 05:35:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuPCWjO7iKsWtjLdhGHxGgh+y+o7yVh8iwinIdgS/da0MWM6yCi6ZPx6BIVIe5jtwmZvf8FA==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr16948656ljj.168.1571056548487;
        Mon, 14 Oct 2019 05:35:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id n5sm4971168ljh.54.2019.10.14.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:35:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ADBD818063D; Mon, 14 Oct 2019 14:35:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF programs after each other
In-Reply-To: <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com> <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 14 Oct 2019 14:35:45 +0200
Message-ID: <87v9srijxa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 09, 2019 at 10:03:43AM +0200, Toke Høiland-Jørgensen wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > Please implement proper indirect calls and jumps.
>> 
>> I am still not convinced this will actually solve our problem; but OK, I
>> can give it a shot.
>
> If you're not convinced let's talk about it first.
>
> Indirect calls is a building block for debugpoints.
> Let's not call them tracepoints, because Linus banned any discusion
> that includes that name.
> The debugpoints is a way for BPF program to insert points in its
> code to let external facility to do tracing and debugging.
>
> void (*debugpoint1)(struct xdp_buff *, int code);
> void (*debugpoint2)(struct xdp_buff *);
> void (*debugpoint3)(int len);

So how would these work? Similar to global variables (i.e., the loader
creates a single-entry PROG_ARRAY map for each one)? Presumably with
some BTF to validate the argument types?

So what would it take to actually support this? It doesn't quite sound
trivial to add?

> Essentially it's live debugging (tracing) of cooperative bpf programs
> that added debugpoints to their code.

Yup, certainly not disputing that this would be useful for debugging;
although it'll probably be a while before its use becomes widespread
enough that it'll be a reliable tool for people deploying XDP programs...

> Obviously indirect calls can be used for a ton of other things
> including proper chaing of progs, but I'm convinced that
> you don't need chaining to solve your problem.
> You need debugging.

Debugging is certainly also an area that I want to improve. However, I
think that focusing on debugging as the driver for chaining programs was
a mistake on my part; rudimentary debugging (using a tool such as
xdpdump) is something that falls out of program chaining, but it's not
the main driver for it.

> If you disagree please explain _your_ problem again.
> Saying that fb katran is a use case for chaining is, hrm, not correct.

I never said Katran was the driver for this. I just used Katran as one
of the "prior art" examples for my "how are people solving running
multiple programs on the same interface" survey.

What I want to achieve is simply the ability to run multiple independent
XDP programs on the same interface, without having to put any
constraints on the programs themselves. I'm not disputing that this is
*possible* to do completely in userspace, I just don't believe the
resulting solution will be very good. Proper kernel support for indirect
calls (or just "tail calls that return") may change that; but in any
case I think I need to go write some userspace code to have some more
concrete examples to discuss from. So we can come back to the
particulars once I've done that :)

-Toke
