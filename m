Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D952C8E7C
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJBQfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 12:35:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33994 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBQfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 12:35:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so18237188oii.1
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLUUnnK14R0nL5szFv6PtQDO/zYgkw39qbL7SvG7ooU=;
        b=gcy9WA3RppdtWKnkjIWmPWAPXin0i2br8qOmuHEAkuuCbwdUhCHzGu/HJ4uMFD+sTz
         NzYecdpz0IWd+2r5ndoaEHu/6KEw+ur4ONqBCa4nzIFKdVVcn0pM4cSnfJRNEjOn/qvm
         q+R4BaAGuuvSz9b/GPe39UvpsbRAkbUISo8kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLUUnnK14R0nL5szFv6PtQDO/zYgkw39qbL7SvG7ooU=;
        b=VLxWdlP6RLKPT1ucNttM7U6wHezu5ktMUc8vy6TxD7iHTsyqT2BYdJGCtS7cIbnV6L
         VoYSdlpMx8wsifxToJUgmqTT5cSSSTP3upKl3zUhWnPTWgSQYHXWWJ3ANd7/lqWNWk13
         UFh3c7DpqLQX65DKyyNFLnBwEHHcceuE7fl43iSO0TuZaotthiqH2g5yNd4M0D50aoj0
         965pCvaQHFsOITSFwk7bfnVLV+HoLLIKUR3EiS/jiu25qJeAv+IRnp/g1XLJhFpjZcEO
         3qZNXd7ZZ6iCs9dKX1ccluFP5m/9psR73Z2dUnFzeogKgzS6GpSNIokpFR92ULDLHvFK
         GfCw==
X-Gm-Message-State: APjAAAXvOYeF05+WeeDKg9eNJlyi1errwbOriAMS0JAZH8M4Kljt1YME
        rYiAW8QpZGnhr+GXUKg5pSSoLnP382CSaTS9TNU3Eg==
X-Google-Smtp-Source: APXvYqxgAuUXmXrnpof2D35OTPhcj7iPyfA7RDgrJJGcNMW6vB30KJjmNsXijeaDznRUQqyIVK9yyd6ys/5UYLzrXbM=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr3693795oib.110.1570034137953;
 Wed, 02 Oct 2019 09:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
In-Reply-To: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 2 Oct 2019 17:35:26 +0100
Message-ID: <CACAyw9860eDGU9meO0wQ82OgWNPv3LXAQqrJNf-mQFA0yu7rWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/9] xdp: Support multiple programs on a single
 interface through chain calls
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2 Oct 2019 at 14:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> This series adds support for executing multiple XDP programs on a single
> interface in sequence, through the use of chain calls, as discussed at th=
e Linux
> Plumbers Conference last month:

Hi Toke,

Thanks for posting the patch set! As I mentioned, this is a big pain
point for us as
well. Right now, all of our different XDP components are managed by a singl=
e
daemon called (drumroll) xdpd. We'd like  to separate this out into
individual bits and pieces that operate separately from each other.

I've looked at the kernel side of your patch set, here are my thoughts:

> # HIGH-LEVEL IDEA
>
> The basic idea is to express the chain call sequence through a special ma=
p type,
> which contains a mapping from a (program, return code) tuple to another p=
rogram
> to run in next in the sequence. Userspace can populate this map to expres=
s
> arbitrary call sequences, and update the sequence by updating or replacin=
g the
> map.

How do you imagine this would work in practice? From what I can tell, the m=
ap
is keyed by program id, which makes it difficult to reliably construct
the control
flow that I want.

As an example, I'd like to split the daemon into two parts, A and B,
which I want
to be completely independent. So:

- A runs before B, if both are active
- If A is not active, B is called first
- If B is not active, only A is called

Both A and B may at any point in time replace their current XDP program wit=
h a
new one. This means that there is no stable program ID I can use.

Another problem are deletions: if I delete A (because that component
is shut down)
B will never be called, since the program ID that linked B into the
control flow is gone.
This means that B needs to know about A and vice versa.

> The actual execution of the program sequence is done in bpf_prog_run_xdp(=
),
> which will lookup the chain sequence map, and if found, will loop through=
 calls
> to BPF_PROG_RUN, looking up the next XDP program in the sequence based on=
 the
> previous program ID and return code.

I think that the tail call chain is useful for other eBPF programs as well.
How hard is it to turn the logic in bpf_prog_run_xdp into a helper
instead?

Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
