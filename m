Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4904C9954
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfJCH7C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 3 Oct 2019 03:59:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJCH7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 03:59:01 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DF2A5945B
        for <bpf@vger.kernel.org>; Thu,  3 Oct 2019 07:59:01 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id h19so580254ljc.5
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AS56vdNDW40U5UmDisdCPzLy7KaBD/7uLXQNmmW8Fco=;
        b=dIv1SuBOLhwVKt0gMXUkXHcGwmedfu+72uvXTx65yVWGE9gDm4ySokiZd/zhv7ktfJ
         qcoMdzMWE7DCBdfc6KhaGNreju4Mb+K7h69Eyl6dH3aZy5tYlBdn6KSWwHmtoucElSBT
         oRPm+AyAH2oUHPzkCy1SsNTQBnAJos9lJX73qNAAZtkD33TcQ8QuRnA9YQimzrFs+awY
         /XXSkOQCUjkVcxwCjTNo5+w+JRj4A45yUULDBC0rdOXZ06kz96eeC+3QpBjzvpP42WLP
         kjPQpIHWKamQMb8P/wJSZ+P0OrQxZj4nZ4eH/jb7X4+/Zy143uZMnIs99VOXutvT0//C
         FmfQ==
X-Gm-Message-State: APjAAAUuZ7gWoL23vbssiaf6evn393MYQoh4k00RBMARu3dwECBD6S1b
        r1xefom3qISCcNI7ox7S4QJCe+gbhGyQs8gz2PQQKcol4/NFMkQSYnWiRn5b3nrwoIGMFSyCLwt
        a3L4iCjxLqHBy
X-Received: by 2002:a19:488f:: with SMTP id v137mr4812652lfa.26.1570089539545;
        Thu, 03 Oct 2019 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxG43GDG5bRR9RpI3BGYTU5kVYnVOqjQPsYi7t/vNHI0y2qvpdXyDfTVV+SuejJ/MC3IZEl7w==
X-Received: by 2002:a19:488f:: with SMTP id v137mr4812634lfa.26.1570089539276;
        Thu, 03 Oct 2019 00:58:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id k23sm367298ljc.13.2019.10.03.00.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 00:58:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C665F18063D; Thu,  3 Oct 2019 09:58:57 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] xdp: Support multiple programs on a single interface through chain calls
In-Reply-To: <20191002194642.e77o45odwth5gil7@ast-mbp.dhcp.thefacebook.com>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1> <5d94d3c5a238f_22502b00ea21a5b4e9@john-XPS-13-9370.notmuch> <20191002191522.GA9196@pc-66.home> <20191002194642.e77o45odwth5gil7@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Oct 2019 09:58:57 +0200
Message-ID: <87d0feqmym.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 02, 2019 at 09:15:22PM +0200, Daniel Borkmann wrote:
>> On Wed, Oct 02, 2019 at 09:43:49AM -0700, John Fastabend wrote:
>> > Toke Høiland-Jørgensen wrote:
>> > > This series adds support for executing multiple XDP programs on a single
>> > > interface in sequence, through the use of chain calls, as discussed at the Linux
>> > > Plumbers Conference last month:
>> > > 
>> > > https://linuxplumbersconf.org/event/4/contributions/460/
>> > > 
>> > > # HIGH-LEVEL IDEA
>> > > 
>> > > The basic idea is to express the chain call sequence through a special map type,
>> > > which contains a mapping from a (program, return code) tuple to another program
>> > > to run in next in the sequence. Userspace can populate this map to express
>> > > arbitrary call sequences, and update the sequence by updating or replacing the
>> > > map.
>> > > 
>> > > The actual execution of the program sequence is done in bpf_prog_run_xdp(),
>> > > which will lookup the chain sequence map, and if found, will loop through calls
>> > > to BPF_PROG_RUN, looking up the next XDP program in the sequence based on the
>> > > previous program ID and return code.
>> > > 
>> > > An XDP chain call map can be installed on an interface by means of a new netlink
>> > > attribute containing an fd pointing to a chain call map. This can be supplied
>> > > along with the XDP prog fd, so that a chain map is always installed together
>> > > with an XDP program.
>> > > 
>> > > # PERFORMANCE
>> > > 
>> > > I performed a simple performance test to get an initial feel for the overhead of
>> > > the chain call mechanism. This test consists of running only two programs in
>> > > sequence: One that returns XDP_PASS and another that returns XDP_DROP. I then
>> > > measure the drop PPS performance and compare it to a baseline of just a single
>> > > program that only returns XDP_DROP.
>> > > 
>> > > For comparison, a test case that uses regular eBPF tail calls to sequence two
>> > > programs together is also included. Finally, because 'perf' showed that the
>> > > hashmap lookup was the largest single source of overhead, I also added a test
>> > > case where I removed the jhash() call from the hashmap code, and just use the
>> > > u32 key directly as an index into the hash bucket structure.
>> > > 
>> > > The performance for these different cases is as follows (with retpolines disabled):
>> > 
>> > retpolines enabled would also be interesting.
>> > 
>> > > 
>> > > | Test case                       | Perf      | Add. overhead | Total overhead |
>> > > |---------------------------------+-----------+---------------+----------------|
>> > > | Before patch (XDP DROP program) | 31.0 Mpps |               |                |
>> > > | After patch (XDP DROP program)  | 28.9 Mpps |        2.3 ns |         2.3 ns |
>> > 
>> > IMO even 1 Mpps overhead is too much for a feature that is primarily about
>> > ease of use. Sacrificing performance to make userland a bit easier is hard
>> > to justify for me when XDP _is_ singularly about performance. Also that is
>> > nearly 10% overhead which is fairly large. So I think going forward the
>> > performance gab needs to be removed.
>> 
>> Fully agree, for the case where this facility is not used, it must have
>> *zero* overhead. This is /one/ map flavor, in future there will be other
>> facilities with different use-cases, but we cannot place them all into
>> the critical fast-path. Given this is BPF, we have the flexibility that
>> this can be hidden behind the scenes by rewriting and therefore only add
>> overhead when used.
>> 
>> What I also see as a red flag with this proposal is the fact that it's
>> tied to XDP only because you need to go and hack bpf_prog_run_xdp() all
>> the way to fetch xdp->rxq->dev->xdp_chain_map even though the map/concept
>> itself is rather generic and could be used in various other program types
>> as well. I'm very sure that once there, people would request it. Therefore,
>> better to explore a way where this has no changes to BPF_PROG_RUN() similar
>> to the original tail call work.
>
> two +1s.
>
> 1. new features have to have zero overhead when not used. this is not
>    negotiable.
> 2. prog chaining is not xdp specific.
>
> two years ago I was thinking about extending tail_call mechanism like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=prog_chain&id=f54f45d00f91e083f6aec2abe35b6f0be52ae85b
>
> and the program would call the new helper 'bpf_tail_call_next()' to jump
> into the next program.
> Sample code is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=prog_chain&id=933a93208f1bd60a9707dc3f51a9aa457c86be87

Ah, that's a useful starting point, thanks!

> In my benchmarks it was faster than existing bpf_tail_call via prog_array.
> (And fit the rule of zero overhead when not used).
>
> While coding it I figured that we can do proper indirect calls instead,
> which would be even cleaner solution.
> It would support arbitrary program chaining and calling.
>
> The verifier back then didn't have enough infra to support indirect calls.
> I suggest to look into implementing indirect calls instead of hacking
> custom prog chaining logic via maps.

One constraint I have is that the admin needs to be able to define the
program execution chain without any cooperation from the program
authors. So it can't rely on programs calling a helper. But I guess we
can achieve that by injecting code into the program when the feature is
turned on...

I'll go jump down the BPF execution environment rabbit whole and see
what comes back up! :)

-Toke
