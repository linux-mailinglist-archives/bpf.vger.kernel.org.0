Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0839AD92F9
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393699AbfJPNv5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 16 Oct 2019 09:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbfJPNv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 09:51:57 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60D49C057FA6
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 13:51:56 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id c27so468288lfj.19
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 06:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=690j5E5E+66xaMFE6kyJDIQJUYCHPgJtREdNBrjfaXM=;
        b=OR+VuQg5/JFygccajQoclMFUuYR2Pj+MAkhbbEVFEtc8GWKgygDWVk4R3JgU75Wr+o
         27RIlkZ/j/7iqRQZkDKIaoOvD8j+SArpAz5vaHCDIyYPG5i2uCEKVVcXjJtf34Jfnrwg
         Y9X9CKqnXFx10jSiuOrXiD+dhxJx30athbaWjQnHTNSmficfkEwI8lIeXoxG2UAxjhp9
         pFCwaE1X9J7+q7CxIylEKfqaULaJpA/sodt0KTiLEiihDtr89MpZib1pRjHN9ErlBhbZ
         xgvRt3k7fwsRH0SmDCrIQhUc8M5DdGiTB06MnyiPDpHSu7UdCBF4CqHOExixisqEy/dm
         i76w==
X-Gm-Message-State: APjAAAUqUiOpkOcP5HM6ZOYYHoDfgU/7x3AP5WyM/227FiSkfw/ujwkJ
        2aw1wn5+L8+mTBfoHJ7W7XUKBm3FzqUmZgvXLt2ztCaQQa5GkcK7YYzpysx+diaBNuwSuTdXXxq
        /B4x4iqblUIhg
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr15737580ljk.247.1571233914844;
        Wed, 16 Oct 2019 06:51:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQ3gMCyqceM+ReZWuga5btNJl6yTBNrPV8pKCtuvHLQgl1s5LqV1U0pkSBMNMUvr6NlIgeZg==
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr15737555ljk.247.1571233914461;
        Wed, 16 Oct 2019 06:51:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a13sm1981866lff.65.2019.10.16.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:51:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8B96C1800F4; Wed, 16 Oct 2019 15:51:52 +0200 (CEST)
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
In-Reply-To: <20191016022849.weomgfdtep4aojpm@ast-mbp>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com> <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com> <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Oct 2019 15:51:52 +0200
Message-ID: <8736fshk7b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Oct 14, 2019 at 02:35:45PM +0200, Toke Høiland-Jørgensen wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > On Wed, Oct 09, 2019 at 10:03:43AM +0200, Toke Høiland-Jørgensen wrote:
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >> 
>> >> > Please implement proper indirect calls and jumps.
>> >> 
>> >> I am still not convinced this will actually solve our problem; but OK, I
>> >> can give it a shot.
>> >
>> > If you're not convinced let's talk about it first.
>> >
>> > Indirect calls is a building block for debugpoints.
>> > Let's not call them tracepoints, because Linus banned any discusion
>> > that includes that name.
>> > The debugpoints is a way for BPF program to insert points in its
>> > code to let external facility to do tracing and debugging.
>> >
>> > void (*debugpoint1)(struct xdp_buff *, int code);
>> > void (*debugpoint2)(struct xdp_buff *);
>> > void (*debugpoint3)(int len);
>> 
>> So how would these work? Similar to global variables (i.e., the loader
>> creates a single-entry PROG_ARRAY map for each one)? Presumably with
>> some BTF to validate the argument types?
>> 
>> So what would it take to actually support this? It doesn't quite sound
>> trivial to add?
>
> Depends on definition of 'trivial' :)

Well, I don't know... :)

> The kernel has a luxury of waiting until clean solution is implemented
> instead of resorting to hacks.

It would be helpful if you could give an opinion on what specific
features are missing in the kernel to support these indirect calls. A
few high-level sentences is fine (e.g., "the verifier needs to be able
to do X, and llvm/libbpf needs to have support for Y")... I'm trying to
gauge whether this is something it would even make sense for me to poke
into, or if I'm better off waiting for someone who actually knows what
they are doing to work on this :)

>> > If you disagree please explain _your_ problem again.
>> > Saying that fb katran is a use case for chaining is, hrm, not correct.
>> 
>> I never said Katran was the driver for this. I just used Katran as one
>> of the "prior art" examples for my "how are people solving running
>> multiple programs on the same interface" survey.
>
> and they solved it. that's the point.

Yes, in a way that's specific to Katran. This whole thing actually
started out as an effort to make something that's (a) generically useful
so everyone doesn't have to re-invent their own way of doing it, and (b)
interoperable in the case where there is no direct coordination between
the program authors.

The ability to chain a program per return code came out of (a), and the
need to not have to modify all programs involved came out of (b).

>> What I want to achieve is simply the ability to run multiple independent
>> XDP programs on the same interface, without having to put any
>> constraints on the programs themselves. I'm not disputing that this is
>> *possible* to do completely in userspace, I just don't believe the
>> resulting solution will be very good.
>
> What makes me uneasy about the whole push for program chaining
> is that tc cls_bpf supported multiple independent programs from day one.
> Yet it doesn't help to run two firewalls hooked into tc ingress.
> Similarly cgroup-bpf had a ton discussions on proper multi-prog api.
> Everyone was eventually convinced that it's flexible and generic.
> Yet people who started to use it complain that it's missing features
> to make it truly usable in production.

I'll go look at the cgroup-bpf API as well... Do you have any references
to those complaints?

-Toke
