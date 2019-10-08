Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15FCF52E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2019 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJHImG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 8 Oct 2019 04:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbfJHImF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Oct 2019 04:42:05 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92A0511A27
        for <bpf@vger.kernel.org>; Tue,  8 Oct 2019 08:42:04 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id j6so4102687ljb.19
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2019 01:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=z7CZ2Zrc9UzmfHGFH2MD86DogE6B+cOvtIyP0patMCo=;
        b=U7/SMXNdCsYlkRapsXERI/s5V/q6mHW+xq+UaXyc7a9tXo/7BPhtPs7O3AaFiZcOcN
         vi6hK65f+FTnDFQGYF6eFcKTaFQmoLQcjZXTcceBjiymQTtDoQAEiKM1LOZFN5DnosNP
         je/yZ6FFxylPpxz879xy7Pmy+BpfTxPU8toPKdipUaPN0JUPHaKxbfZxHpCAcXp8uwAm
         W2wIa+zzJGrKgtsHi9vvFKpkXvDAjTe+PSsBnRH7B06Re4HhYUUJWQGLCV43NJ/FSKUD
         cyVq+jNEEqzhGD6AqsiD4wZfwPa3UEomAURAAnQNSwjBSxVhd+PNo4xkydIpM8xuPaLC
         CunA==
X-Gm-Message-State: APjAAAU92OfijKALSDrLkKgBzW3wHCXObfQCd3ghjUKNOHhnXobBLITY
        2N8cpfB4Dnwtn/PnMsXxNZ/uGG7Gbn9QaIB81q7/sH101RkgpnJFW8CkiJbW5hPdyu5PDYvf+12
        U5F420Ct5Lgsj
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr19795920lfq.145.1570524123061;
        Tue, 08 Oct 2019 01:42:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrXVySrB19IfktpKpc0xArXZQ8UW7Xnpdw9R5LoOEYr/jfN6mP3yyonjuowIFzrTwyv7l5cw==
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr19795908lfq.145.1570524122842;
        Tue, 08 Oct 2019 01:42:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o18sm3370050lfb.25.2019.10.08.01.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 01:42:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0F25518063D; Tue,  8 Oct 2019 10:42:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: RE: [PATCH bpf-next v3 0/5] xdp: Support multiple programs on a single interface through chain calls
In-Reply-To: <5d9b8ac5655_2a4b2aed075a45b41@john-XPS-13-9370.notmuch>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <5d9b8ac5655_2a4b2aed075a45b41@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Oct 2019 10:42:00 +0200
Message-ID: <87h84jljc7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke Høiland-Jørgensen wrote:
>> This series adds support for executing multiple XDP programs on a single
>> interface in sequence, through the use of chain calls, as discussed at the Linux
>> Plumbers Conference last month:
>> 
>> https://linuxplumbersconf.org/event/4/contributions/460/
>> 
>
> Can we add RFC to the title if we are just iterating through
> idea-space here.

I don't view this as "just iterating through idea-space". I'll admit
that I may have overestimated the extent to which we were all on the
same page on this after LPC, but I do view these submissions as serious
proposals that are making progress... :)

>> # HIGH-LEVEL IDEA
>> 
>> Since Alexei pointed out some issues with trying to rewrite the eBPF byte code,
>> let's try a third approach: We add the ability to chain call programs into the
>> eBPF execution core itself, but without rewriting the eBPF byte code.
>> 
>> As in the previous version, the bpf() syscall gets a couple of new commands
>> which takes a pair of BPF program fds and a return code. It will then attach the
>> second program to the first one in a structured keyed by return code. When a
>> program chain is thus established, the former program will tail call to the
>> latter at the end of its execution.
>> 
>> The actual tail calling is achieved by adding a new flag to struct bpf_prog and
>> having BPF_PROG_RUN run the chain call logic if that flag is set. This means
>> that if the feature is *not* used, the overhead is a single conditional branch
>> (which means I couldn't measure a performance difference, as can be seen in the
>> results below).
>> 
>
> I still believe user space should be able to link these multiple
> programs together as Ed and I were suggesting in the last series.

I expect that userspace probably could (I mean, after all, eBPF is
within spitting distance of a full almost-Turing-complete executing
environment so userspace can conceivably do pretty much anything).

However, I don't believe that doing it in userspace is the best
solution. I view it as a tradeoff: How much complexity do we have to add
to the kernel to make things easier for userspace. And given that we can
do this without negatively impacting performance, and with a reasonable
cost in terms of complexity (both of which I think this series
demonstrates that yes, we can), I think this makes sense to put in the
kernel.

> Also by doing it by linking your control program can be arbitrary
> complex. For example not just taking the output of one program and
> jumping to another but doing arbitrary more complex/interesting
> things. Taking the input from multiple programs to pick next call for
> example.

I expect there will indeed be more complex use cases where combining
multiple programs in arbitrary complex ways would make a lot of sense,
and doing that by linking in userspace is probably a good fit for that.
But for the simple use case of running multiple programs after one
another, I think it is overkill, and something that is better to do in
the kernel.

-Toke
