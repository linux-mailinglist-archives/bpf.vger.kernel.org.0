Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005DAF9572
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2019 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLQUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Nov 2019 11:20:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54717 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbfKLQUT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Nov 2019 11:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573575618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r//zjTOaVUMtQnKHa6rCIADzB9+4K853UxgF2HLsC2M=;
        b=CLmWREaTuvBjqBK5QFvNaLYZ22L63YX0yxFHmmWDlpyxEuifSn6RFFPcRsQ0+eIl5Wv3S4
        lxJpFNw8lBReoDY1IW8CHeVLQO4uZy2EIdqPv6siUGGRkgEDVvnO4HkgZOKWha8b3ED9if
        A/lpEEuD8tfptDV1O3PRXUr4pvMoNfA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167--NtsjxVGP2iN7sLxueHCPQ-1; Tue, 12 Nov 2019 11:20:11 -0500
Received: by mail-lf1-f71.google.com with SMTP id a4so3983700lfg.23
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2019 08:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g9UzlHbJ8q5OmzDADfQDucyzYQNRZ7LJRzCaSfLicEQ=;
        b=RRwnCqr33R+4pXO7dWIXk03p39RX6Dtyn15NzmRxsc2h1NhkPP3gMUnAHVZRsEWtMf
         iZdrVwWR+h/pR+aQ6io20yZbqaAHhlrokEcuZq8FSoGqZvQVFww7drEadStph5BOsXEG
         S6Omy5caIEP3nvXBgvTFc91qFAYG5OgDRA47hXxMHGkC7M5A+ydqqGW+26HnSqmkpl/t
         xjDWHIWVaxLDHxRx46g0UAuv9FtUiAeqhyG+nqH8W+R7A+oA878Q2Zqe9c71zXZgm09r
         I6ueXToLCKDlWVFAiwJyu3yqIvV77v95bOoMTPfZXpTF/ZeHe6b1VWbZVBRG90gybMK4
         K0xw==
X-Gm-Message-State: APjAAAX4pIAkbe1/CIxXZMcyBt5ogt4jXXxC7RlStUXC/YApSf0hKlI3
        yrEoQPBi5bylvJcCVuGtI1iFHq9I8TguO9vklBCm+fb0LOiIpmgrBJxoi1jNH5ahFeMb++4tjTa
        TtAraIbvwTQXK
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr20066335lff.127.1573575609842;
        Tue, 12 Nov 2019 08:20:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBOXGr1L/tAinew64XtQqCagu697U8sz7IZa3xNhXK0zM9rPwXCIH32RnxyVF9kIMzhlpgsw==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr20066308lff.127.1573575609540;
        Tue, 12 Nov 2019 08:20:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 186sm2763590lfb.28.2019.11.12.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:20:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C0F2B1803C7; Tue, 12 Nov 2019 17:20:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Edward Cree <ecree@solarflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: static and dynamic linking. Was: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF
In-Reply-To: <20191112025112.bhzmrrh2pr76ssnh@ast-mbp.dhcp.thefacebook.com>
References: <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com> <87v9srijxa.fsf@toke.dk> <5da4ab712043c_25f42addb7c085b83b@john-XPS-13-9370.notmuch> <87eezfi2og.fsf@toke.dk> <f9d5f717-51fe-7d03-6348-dbaf0b9db434@solarflare.com> <87r23egdua.fsf@toke.dk> <70142501-e2dd-1aed-992e-55acd5c30cfd@solarflare.com> <874l07fu61.fsf@toke.dk> <aeae7b94-090a-a850-4740-0274ab8178d5@solarflare.com> <87eez4odqp.fsf@toke.dk> <20191112025112.bhzmrrh2pr76ssnh@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 Nov 2019 17:20:07 +0100
Message-ID: <87h839oymg.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: -NtsjxVGP2iN7sLxueHCPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Oct 22, 2019 at 08:07:42PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>=20
>> I believe this is what Alexei means by "indirect calls". That is
>> different, though, because it implies that each program lives as a
>> separate object in the kernel - and so it might actually work. What you
>> were talking about (until this paragraph) was something that was
>> entirely in userspace, and all the kernel sees is a blob of the eBPF
>> equivalent of `cat *.so > my_composite_prog.so`.
>
> So I've looked at indirect calls and realized that they're _indirect_ cal=
ls.
> The retpoline overhead will be around, so a solution has to work without =
them.
> I still think they're necessary for all sorts of things, but priority shi=
fted.
>
> I think what Ed is proposing with static linking is the best generic solu=
tion.
> The chaining policy doesn't belong in the kernel. A user space can expres=
s the
> chaining logic in the form of BPF program. Static linking achieves that. =
There
> could be a 'root' bpf program (let's call it rootlet.o) that looks like:
> int xdp_firewall_placeholder1(struct xdp_md *ctx)
> {
>    return XDP_PASS;
> }
> int xdp_firewall_placeholder2(struct xdp_md *ctx)
> {
>    return XDP_PASS;
> }
> int xdp_load_balancer_placeholder1(struct xdp_md *ctx)
> {
>    return XDP_PASS;
> }
> int main_xdp_prog(struct xdp_md *ctx)
> {
>    int ret;
>
>    ret =3D xdp_firewall_placeholder1(ctx);
>    switch (ret) {
>    case XDP_PASS: break;
>    case XDP_PROP: return XDP_DROP;
>    case XDP_TX: case XDP_REDIRECT:
>       /* buggy firewall */
>       bpf_perf_event_output(ctx,...);
>    default: break; /* or whatever else */
>    }
>   =20
>    ret =3D xdp_firewall_placeholder2(ctx);
>    switch (ret) {
>    case XDP_PASS: break;
>    case XDP_PROP: return XDP_DROP;
>    default: break;
>    }
>
>    ret =3D xdp_load_balancer_placeholder1(ctx);
>    switch (ret) {
>    case XDP_PASS: break;
>    case XDP_PROP: return XDP_DROP;
>    case XDP_TX: return XDP_TX;
>    case XDP_REDIRECT: return XDP_REDIRECT;
>    default: break; /* or whatever else */
>    }
>    return XDP_PASS;
> }
>
> When firewall1.rpm is installed it needs to use either a central daemon o=
r
> common library (let's call it libxdp.so) that takes care of orchestration=
. The
> library would need to keep a state somewhere (like local file or a databa=
se).
> The state will include rootlet.o and new firewall1.o that wants to be lin=
ked
> into the existing program chain. When firewall2.rpm gets installed it cal=
ls the
> same libxdp.so functions that operate on shared state. libxdp.so needs to=
 link
> firewall1.o + firewall2.o + rootlet.o into one program and attach it to n=
etdev.
> This is static linking. The existing kernel infrastructure already suppor=
ts
> such model and I think it's enough for a lot of use cases. In particular =
fb's
> firewall+katran XDP style will fit right in. But bpf_tail_calls are
> incompatible with bpf2bpf calls that static linking will use and I think
> cloudlfare folks expressed the interest to use them for some reason even =
within
> single firewall ? so we need to improve the model a bit.
>
> We can introduce dynamic linking. The second part of 'BPF trampoline'
> patches allows tracing programs to attach to other BPF programs. The
> idea of dynamic linking is to replace a program or subprogram instead
> of attaching to it. The firewall1.rpm application will still use
> libxdp.so, but instead of statically linking it will ask kernel to
> replace a subprogram rootlet_fd + btf_id_of_xdp_firewall_placeholder1
> with new firewall1.o. The same interface is used for attaching tracing
> prog to networking prog.

Hmm, let's see if I'm understanding you correctly. In this model, to
attach program #2 (assuming the first one is already loaded on an
interface), userspace would need to do something like:

old_fd =3D get_xdp_fd(eth0);
new_fd =3D load_bpf("newprog.o"); // verifies newprog.o
proglet =3D load_bpf("xdp-run-2-progs.o"); // or dynamically generate this
replace_subprog(proglet, 0, old_fd); // similar to map FD replacement?
replace_subprog(proglet, 1, new_fd);
proglet_fd =3D load_bpf(proglet); // verifier reuses sub-fd prog verdicts

bpf_tracing_prog_attach(old_fd, proglet_fd, FLAG_REPLACE);


So the two component programs would still exist as kernel objects,
right? And the trampolines would keep individual stats for each one (if
BPF stats are enabled)? Could userspace also extract the prog IDs being
referenced by the "glue" proglet? Similar to how bpftool shows which map
IDs a program refers to today?

What about attaching a third program? Would that work by recursion (as
above, but with the old proglet as old_fd), or should the library build
a whole new sequence from the component programs?

Finally, what happens if someone where to try to attach a retprobe to
one of the component programs? Could it be possible to do that even
while program is being run from proglet dispatch? That way we can still
debug an individual XDP program even though it's run as part of a chain.

> Initially I plan to keep the verifier job simple and allow replacing
> xdp-equivalent subprogram with xdp program. Meaning that subprogram
> (in above case xdp_firewall_placeholder1) needs to have exactly one
> argument and it has to be 'struct xdp_md *'.

That's fine.

> Then during the loading of firewall1.o the verifier wouldn't need to
> re-verify the whole thing. BTF type matching that the verifier is
> doing as part of 'BPF trampoline' series will be reused for this
> purpose. Longer term I'd like to allow more than one argument while
> preserving partial verification model. The rootlet.o calls into
> firewall1.o directly. So no retpoline to worry about and firewall1.o
> can use bpf_tail_call() if it wants so. That tail_call will still
> return back to rootlet.o which will make policy decision. This
> rootlet.o can be automatically generated by libxdp.so.

Sounds reasonable. Any reason libxdp.so couldn't be part of libbpf?

> If in the future we figure out how to do two load-balancers libxdp.so
> will be able to accommodate that new policy.

Yeah, it would be cool if we could move things across CPUs; like with
cpumap, but executing another XDP program on the target CPU.

> This firewall1.o can be developed and tested independently of other
> xdp programs. The key gotcha here is that the verifier needs to allow
> more than 512 stack usage for the rootlet.o. I think that's
> acceptable.

Right, cool.

> In the future indirect calls will allow rootlet.o to be cleaner:
> typedef int (*ptr_to_xdp_prog)(struct xdp_md *ctx);
> ptr_to_xdp_prog prog_array[100];
> int main_xdp_prog(struct xdp_md *ctx)
> {
>    int ret, i;
>
>    for (i =3D 0; i < 100; i++) {
>        ret =3D prog_array[i](ctx);
>        switch (ret) {
>        case XDP_PASS: break;
>        case XDP_PROP: return XDP_DROP;
>        ..
>    }
> }
> but they're indirect calls and retpoline. Hence lower priority atm.

Yes, this was what I was envisioning when you first said 'indirect
calls'. This would be wonderfully flexible... But a shame about the
indirect calls, performance-wise.

-Toke

