Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2746A8AB
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbhLFUoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 15:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbhLFUoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 15:44:18 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4D4C061746;
        Mon,  6 Dec 2021 12:40:49 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m9so14578566iop.0;
        Mon, 06 Dec 2021 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=iucRg1A8O0b/DSlL+QUGuCPoLHVICPlHNX37Ro375BQ=;
        b=KncN5votJOwMoSlpiuiuzB057dMGARhjKDyxunvNzo1Dump0KT7X2PFkch0itMhVYt
         4JtVagEWUS9Biu0EhHyrImOOljaHqZqjpWXSRzdRzGf3CXF4RmJ5/fqSW8/X9t1cAxp1
         KpXZhSCoRg8lry5AoBX38MXw6Pa0ar0Z9BDHEMsryVreBPq5n+ILoREmsyUDrelVeOta
         E25m641PjbEGO1E6hV43nTUvzlRs2Jn5qdUF2QyzY0JeNBXCL8lPCRbBe72iGLmx2+0i
         cx7JKYvFOdii8r9a+wbEtsM13GbCzEoeMM+ifYC9tYFhQG2l8n097Lukh0ejX6HikDK9
         pNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=iucRg1A8O0b/DSlL+QUGuCPoLHVICPlHNX37Ro375BQ=;
        b=ealEKZkW8ITBTXcGvGeU/veRopRtyOtMlM3vRSMx4scnSmFFnBculhcoKQ7ghJBB2c
         mmCb8tV51GmIUxPdhE4Yj/vXG8HepqGUgabllG5OGtrVHrqCaRZLvAboU53VRA7c7YXh
         W4QK9THDyo+If4zYJNrVJg4mQ2HhncB8B29h1uAs9VxL5rJ6dXQNaxUDUeRcp7myXJGY
         67P+fBD9c+bX+4JdiYqwtDQQMfLq6Lxy43BjNuUsioZrJHSoyaHKXOtx/GgUmSLFuqH8
         3TwNkrfBQ2UCbiEv01WnrdBPspI9ygkikLgLZ6uaHi2ZRhesGS6q7qRqPpQpgv3h7wku
         fQbA==
X-Gm-Message-State: AOAM531mqXpZK41jYlVTlL5R35K8fybMgLOh4GD1ICKGteI6M7/FyBLE
        MhaVG1+6kYUTqjCcrfdQeh0=
X-Google-Smtp-Source: ABdhPJxWK5HARIkqCVgCIuhPmrbv5yIqhL3LymQ5dC3KkNhuN/IJgtB9V02hGfdn47rORfQe1XCwhg==
X-Received: by 2002:a05:6602:1813:: with SMTP id t19mr35468573ioh.135.1638823249201;
        Mon, 06 Dec 2021 12:40:49 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id m2sm7297819iob.21.2021.12.06.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:40:48 -0800 (PST)
Date:   Mon, 06 Dec 2021 12:40:40 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Luca Boccassi <bluca@debian.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <61ae75487d445_c5bd20827@john.notmuch>
In-Reply-To: <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
 <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
 <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
 <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
 <61aae2da8c7b0_68de0208dd@john.notmuch>
 <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Luca Boccassi wrote:

cutting to just the relevant pieces here.

[...]

> =

> > I'll give the outline of the argument here.
> > =

> > I do not believe signing BPF instructions for real programs provides
> > much additional security. Given most real programs if the application=

> > or loader is exploited at runtime we have all sorts of trouble. First=

> > simply verifying the program doesn't prevent malicious use of the
> > program. If its in the network program this means DDOS, data
> > exfiltration,
> > mitm attacks, many other possibilities. If its enforcement program
> > most enforcement actions are programmed from this application so
> > system
> > security is lost already.=C2=A0 If its observability application simp=
ly
> > drops/manipulates observations that it wants. I don't know of any
> > useful programs that exist in isolation without user space input
> > and output as a critical component. If its not a privileged user,
> > well it better not be doing anything critical anyways or disabled
> > outright for the security focused.
> > =

> > Many critical programs can't be signed by the nature of the program.
> > Optimizing network app generates optimized code at runtime.
> > Observability
> > tools JIT the code on the fly, similarly enforcement tools will do
> > the
> > same. I think the power of being able to optimize JIT the code in
> > application and give to the kernel is something we will see more and
> > more of. Saying I'm only going to accept signed programs, for a
> > distribution or something other than niche use case, is non starter
> > IMO because it breaks so many real use cases. We should encourage
> > these optimizing use cases as I see it as critical to performance
> > and keeping overhead low.
> > =

> > From a purely security standpoint I believe you are better off
> > defining characteristics an application is allowed to have. For
> > example allowed to probe kernel memory, make these helpers calls,
> > have this many instructions, use this much memory, this much cpu,
> > etc. This lets you sandbox a BPF application (both user space and
> > kernel side) much nicer than any signing will allow.
> > =

> > If we want to 'sign' programs we should do that from a BPF program
> > directly where other metadata can be included in the policy. For
> > example having a hash of the program loaded along with the calls
> > made and process allows for rich policy decisions. I have other
> > use cases that need a hash/signature for data blobs, so its on
> > my todo list but not at the top yet.=C2=A0 But, being able to verify
> > arbitrary blob of data from BPF feels like a useful operation to me
> > in general. The fact in your case its a set of eBPF insns and in
> > my case its some key in a network header shouldn't matter.
> > =

> > The series as is, scanned commit descriptions, is going to break
> > lots of in-use-today programs if it was ever enabled. And
> > is not as flexible (can't support bpftrace, etc.) or powerful
> > (can't consider fine grained policy decisions) as above.
> > =

> > Add a function we can hook after verify (or before up for
> > debate) and helpers to verify signatures and/or generate
> > hashes and we get a better more general solution. And it can
> > also solve your use case even if I believe its not useful and
> > may break many BPF users running bpftrace, libbpf, etc.
> > =

> > Thanks,
> > John
> =

> Hello John,
> =

> Thank you for the summary, this is much clearer.
> =

> First of all, I think there's some misunderstanding: this series does
> not enable optional signatures by default, and does not enable
> mandatory signatures by default either. So I don't see how it would
> break existing use cases as you are saying? Unless I'm missing
> something?
> =

> There's a kconfig to enable optional signatures - if they are there,
> they are verified, if they are not present then nothing different
> happens. Unless I am missing something, this should be backward
> compatible. This kconfig would likely be enabled in most use cases,
> just like optionally signed kernel modules are.

Agree, without enforcement things should continue to work.

> =

> Then there's a kconfig on top of that which makes signatures mandatory.=

> I would not imagine this to be enabled in may cases, just in custom
> builds that have more stringent requirements. It certainly would not be=

> enabled in generalist distros. Perhaps a more flexible way would be to
> introduce a sysctl, like fsverity has with
> 'fs.verity.require_signatures'? That would be just fine for our use
> case. Matteo can we do that instead in the next revision?

We want to manage this from BPF side directly. It looks
like policy decision and we have use cases that are not as
simple as yes/no with global switch. For example, in k8s world
this might be enabled via labels which are user specific per container
policy. e.g. lockdown some containers more strictly than others.

> =

> Secondly, I understand that for your use case signing programs would
> not be the best approach. That's fine, and I'm glad you are working on
> an alternative that better fits your model, it will be very interesting=

> to see how it looks like once implemented. But that model doesn't fit
> all cases. In our case at Microsoft, we absolutely want to be able to
> pre-define at build time a list of BPF programs that are allowed to be
> loaded, and reject anything else. Userspace processes in our case are

By building this into BPF you can get the 'reject anything else' policy
and I get the metadata + reject/accept from the same hook. Its
just your program can be very simple.

> mostly old and crufty c++ programs that can most likely be pwned by
> looking at them sideways, so they get locked down hard with multiple
> redundant layers and so on and so forth. But right now for BPF you only=

> have a "can load BPF" or "cannot load BPF" knob, and that's it. This is=

> not good enough: we need to be able to define a list of allowed
> payloads, and be able to enforce it, so when (not if) said processes do=

> get tricked into loading something else, it will fail, despite having

Yikes, this is a bit scary from a sec point of view right? Are those
programs read-only maps or can the C++ program also write into the
maps and control plane. Assuming they do some critical functions then
you really shouldn't be trusting them to not do all sorts of other
horrible things. Anyways not too important to this discussion.

I'll just reiterate (I think you get it though) that simply signing
enforcement doesn't mean now BPF is safe. Further these programs
have very high privileges and can do all sorts of things to the
system. But, sure sig enforcement locks down one avenue of loading
bogus program.

> the capability of calling bpf(). Trying to define heuristics is also
> not good enough for us - creative malicious actors have a tendency to
> come up with ways to chain things that individually are allowed and
> benign, but combined in a way that you just couldn't foresee. It would

Sure, but I would argue some things can be very restrictive and
generally useful. For example, never allow kernel memory read could be
enforced from BPF side directly. Never allow pkt redirect, etc.

> certainly cover a lot of cases, but not all. A strictly pre-defined
> list of what is allowed to run and what is not is what we need for our
> case, so that we always know exactly what is going to run and what is
> not, and can deal with the consequences accordingly, without nasty
> surprises waiting around the corner. Now in my naive view the best way
> to achieve this is via signatures and certs, as it's a well-understood
> system, with processes already in place to revoke/rotate/etc, and it's
> already used for kmods. An alternative would be hard-coding hashes I
> guess, but that would be terribly inflexible.

Another option would be to load your programs at boot time, presumably
with trusted boot enabled and then lock down BPF completely. Then
ensure all your BPF 'programs' are read-only from user<->kernel
interface and this should start looking fairly close to what you
want and all programs are correct by root of trust back to
trusted boot. Would assume you know what programs to load at boot
though. May or may not be a big assumption depending on your env.

> =

> Now in terms of _how_ the signatures are done and validated, I'm sure
> there are multiple ways, and if some are better than what this series
> implements, then that's not an issue, it can be reworked. But the core
> requirement for us is: offline pre-defined list of what is allowed to
> run and what is not, with ability for hard enforcement that cannot be
> bypassed. Yes, you lose some features like JIT and so on: we don't
> care, we don't need those for our use cases. If others have different
> needs that's fine, this is all intended to be optional, not mandatory.
> There are obviously trade-offs, as always when security is involved,
> and each user can decide what's best for them.
> =

> Hope this makes sense. Thanks!

I think I understand your use case. When done as BPF helper you
can get the behavior you want with a one line BPF program
loaded at boot.

int verify_all(struct bpf_prog **prog) {
	return verify_signature(prog->insn,
				prog->len * sizeof(struct bpf_insn),
			        signature, KEYRING, BPF_SIGTYPE);
}

And I can write some more specific things as,

int verify_blobs(void data) {
  int reject =3D verify_signature(data, data_len, sig, KEYRING, TYPE);
  struct policy_key *key =3D map_get_key();

  return policy(key, reject);  =

}

map_get_key() looks into some datastor with the policy likely using
'current' to dig something up. It doesn't just apply to BPF progs
we can use it on other executables more generally. And I get more
interesting use cases like, allowing 'tc' programs unsigned, but
requiring kernel memory reads to require signatures or any N
other policies that may have value. Or only allowing my dbg user
to run read-only programs, because the dbg maybe shouldn't ever
be writing into packets, etc. Driving least privilege use cases
in fine detail.

By making it a BPF program we side step the debate where the kernel
tries to get the 'right' policy for you, me, everyone now and in
the future. The only way I can see to do this without getting N
policies baked into the kernel and at M different hook points is via
a BPF helper.

Thanks,
John=
