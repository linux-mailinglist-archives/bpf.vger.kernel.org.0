Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9CCC9263
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfJBT3k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Oct 2019 15:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBT3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 15:29:39 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8B0087630
        for <bpf@vger.kernel.org>; Wed,  2 Oct 2019 19:29:38 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id y21so11537527edr.18
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 12:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6VK1CVq1bkjT+g7JVLPTFlMCxLcYfbSs3VY1Jw9zRBk=;
        b=S9tVcUjOR41Gjx4xh2cfFkFXWGdEB5vK/JGJxxplBvneHPi+4OBK7KvqsEDX4GxzoB
         EQMbc3ZiFev6n1QC7bbE9wOuXuf8ehtxeEV7/+oewynVywUhRShhtR5o+GGy4LWARNu/
         xfpbIOYM3cFbJmK44ZgEtp5hFF3kfh4HcFmNC2FSVyl2B/gNdpdgPxBxHb0sGMxGup1/
         qlg94PWNbGyCLhshoZRfRLLAa+zn3MxTJ64bjH/PXVAjEjF2d79hFVYcud3Pj/x71+tU
         7VP68eoFqOg39+o9VeXJsZGEVrxAca4HnWg0tuK4hJd6C+RkbBJ9AnuUcXOXP9B/zw14
         3tGA==
X-Gm-Message-State: APjAAAXUWZqcBIJ0s5V2V5JHdZFuk3m2CzUoRksm3IRBz2cYy1cx3dV5
        FHSt/HAe+aG9teXj8LAnB89xv8yc+euEupD9hD6jaEifytDnCu4YKA3LDd9UMX1NWOxwJ//tdNJ
        etNEkFVfg3ATa
X-Received: by 2002:a50:87ca:: with SMTP id 10mr5665082edz.77.1570044577539;
        Wed, 02 Oct 2019 12:29:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydORY3PD1uUX5ODCfrJsaFMZgFl9G72FsYfygk1o+tHXAzsfb1jjOZaHXs0Y9mZ5mzBGAjQA==
X-Received: by 2002:a50:87ca:: with SMTP id 10mr5665059edz.77.1570044577288;
        Wed, 02 Oct 2019 12:29:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 60sm15200edg.10.2019.10.02.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:29:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F2F4418063D; Wed,  2 Oct 2019 21:29:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] xdp: Support multiple programs on a single interface through chain calls
In-Reply-To: <20191002191522.GA9196@pc-66.home>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1> <5d94d3c5a238f_22502b00ea21a5b4e9@john-XPS-13-9370.notmuch> <20191002191522.GA9196@pc-66.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Oct 2019 21:29:35 +0200
Message-ID: <87o8yzq734.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Wed, Oct 02, 2019 at 09:43:49AM -0700, John Fastabend wrote:
>> Toke Høiland-Jørgensen wrote:
>> > This series adds support for executing multiple XDP programs on a single
>> > interface in sequence, through the use of chain calls, as discussed at the Linux
>> > Plumbers Conference last month:
>> > 
>> > https://linuxplumbersconf.org/event/4/contributions/460/
>> > 
>> > # HIGH-LEVEL IDEA
>> > 
>> > The basic idea is to express the chain call sequence through a special map type,
>> > which contains a mapping from a (program, return code) tuple to another program
>> > to run in next in the sequence. Userspace can populate this map to express
>> > arbitrary call sequences, and update the sequence by updating or replacing the
>> > map.
>> > 
>> > The actual execution of the program sequence is done in bpf_prog_run_xdp(),
>> > which will lookup the chain sequence map, and if found, will loop through calls
>> > to BPF_PROG_RUN, looking up the next XDP program in the sequence based on the
>> > previous program ID and return code.
>> > 
>> > An XDP chain call map can be installed on an interface by means of a new netlink
>> > attribute containing an fd pointing to a chain call map. This can be supplied
>> > along with the XDP prog fd, so that a chain map is always installed together
>> > with an XDP program.
>> > 
>> > # PERFORMANCE
>> > 
>> > I performed a simple performance test to get an initial feel for the overhead of
>> > the chain call mechanism. This test consists of running only two programs in
>> > sequence: One that returns XDP_PASS and another that returns XDP_DROP. I then
>> > measure the drop PPS performance and compare it to a baseline of just a single
>> > program that only returns XDP_DROP.
>> > 
>> > For comparison, a test case that uses regular eBPF tail calls to sequence two
>> > programs together is also included. Finally, because 'perf' showed that the
>> > hashmap lookup was the largest single source of overhead, I also added a test
>> > case where I removed the jhash() call from the hashmap code, and just use the
>> > u32 key directly as an index into the hash bucket structure.
>> > 
>> > The performance for these different cases is as follows (with retpolines disabled):
>> 
>> retpolines enabled would also be interesting.
>> 
>> > 
>> > | Test case                       | Perf      | Add. overhead | Total overhead |
>> > |---------------------------------+-----------+---------------+----------------|
>> > | Before patch (XDP DROP program) | 31.0 Mpps |               |                |
>> > | After patch (XDP DROP program)  | 28.9 Mpps |        2.3 ns |         2.3 ns |
>> 
>> IMO even 1 Mpps overhead is too much for a feature that is primarily about
>> ease of use. Sacrificing performance to make userland a bit easier is hard
>> to justify for me when XDP _is_ singularly about performance. Also that is
>> nearly 10% overhead which is fairly large. So I think going forward the
>> performance gab needs to be removed.
>
> Fully agree, for the case where this facility is not used, it must
> have *zero* overhead. This is /one/ map flavor, in future there will
> be other facilities with different use-cases, but we cannot place them
> all into the critical fast-path. Given this is BPF, we have the
> flexibility that this can be hidden behind the scenes by rewriting and
> therefore only add overhead when used.
>
> What I also see as a red flag with this proposal is the fact that it's
> tied to XDP only because you need to go and hack bpf_prog_run_xdp()
> all the way to fetch xdp->rxq->dev->xdp_chain_map even though the
> map/concept itself is rather generic and could be used in various
> other program types as well. I'm very sure that once there, people
> would request it. Therefore, better to explore a way where this has no
> changes to BPF_PROG_RUN() similar to the original tail call work.

As I said in the other reply, I actually went out of my way to make this
XDP only. But since you're now the third person requesting it not be, I
guess I'll take the hint and look at a more general way to hook this in :)

-Toke
