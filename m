Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED41955F8
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0LHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 07:07:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37829 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgC0LHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 07:07:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id g23so9291343otq.4
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UwJqxa3yHiX1j+SqcPDEjAVECaEkpX3JEjU0/vOYdyc=;
        b=pZfraiipYHsq5uZzzZjKsHdm6Exszd2YQpjt1TjmU2s1TItl8P3bQqih4/27rlxhzT
         qsIQx18aowUMc+xo0+XtIpogHSoJw+cmrSkXt/6dOevm/uLxIT9xDTZlVTY3jTMdgLmq
         b0YVuNify+zdw2pfHcKyXa6VsHDpnnxHT/uN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UwJqxa3yHiX1j+SqcPDEjAVECaEkpX3JEjU0/vOYdyc=;
        b=W3MaNBTSFYkT4AxW+V7d4YKhe1RWjUMeJ2lfaRfEkuw13uyXBWbhcERaJQBBk2jVXI
         P2/+WuzCJkKnDYwz6Dgx9K8TbngEQ6bC3iQ6lR4+3E9omKLI4r4FW8WudMQ0gVCLjAFd
         jIX5l/8d1M6+O1vNC56NKSf89vIyhnkOMhgV/B092sQnOAaQD0Wd8msTZRiiJEBlJ5mC
         LzgDh77HSNcxbvg6zVuczhhdXNcM/OrqqxvoGNh3TJxzLlmqDY9HEm2ur7pNju5qyKmE
         bqcHusud7e5NH1IQbJhxDyaeB0HxrGEN2DIALYOPmQjMBGwEuB21arnk49rWJ7zbJqz9
         XTDg==
X-Gm-Message-State: ANhLgQ1wQF1I3hn5PvXZgC8DxXx2Rk4eriV1ExJMuAjupfffiU89pMGC
        JUNR/+YJTnied6q2w6LvLb62HbK7E3fTyvADDlO1Xg==
X-Google-Smtp-Source: ADFU+vss2c+b3kfqkP2+WpNQwMyyZ3IkIm4xdrrPCQ2LWF6sMR79AfQB7qGUaSpiNF46NWlTFn2BVCIOhoKzUizgnTg=
X-Received: by 2002:a9d:6310:: with SMTP id q16mr9095234otk.147.1585307230734;
 Fri, 27 Mar 2020 04:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
 <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN>
 <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN>
 <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch>
 <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com>
 <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
 <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
 <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com>
 <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com>
 <87pncznvjy.fsf@toke.dk> <CAEf4BzaPQ6=h8a6Ngz638AtL4LmBLLVMV+_-YLMR=Ls+drd5HQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaPQ6=h8a6Ngz638AtL4LmBLLVMV+_-YLMR=Ls+drd5HQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 27 Mar 2020 11:06:59 +0000
Message-ID: <CACAyw98yYE+eOx5OayyN2tNQeNqFXnHdRGSv6DYX7ehfMHt1+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing
 program when attaching XDP
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020 at 19:06, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Mar 26, 2020 at 5:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> > > Now for XDP. It has same flawed model. And even if it seems to you
> > > that it's not a big issue, and even if Jakub thinks we are trying to
> > > solve non-existing problem, it is a real problem and a real concern
> > > from people that have to support XDP in production with many
> > > well-meaning developers developing BPF applications independently.
> > > Copying what you wrote in another thread:
> > >
> > >> Setting aside the question of which is the best abstraction to repre=
sent
> > >> an attachment, it seems to me that the actual behavioural problem (X=
DP
> > >> programs being overridden by mistake) would be solvable by this patc=
h,
> > >> assuming well-behaved userspace applications.
> > >
> > > ... this is a horrible and unrealistic assumption that we just cannot
> > > make and accept. However well-behaved userspace applications are, the=
y
> > > are written by people that make mistakes. And rather than blissfully
> > > expect that everything will be fine, we want to have enforcements in
> > > place that will prevent some buggy application to wreck havoc in
> > > production.
> >
> > Look, I'm not trying to tell you how to managed your internal systems.
> > I'm just objecting to your assertion that your deployment model is the
> > only one that can possibly work, and the refusal to consider other
> > alternatives that comes with it.
>
> Your assumption doesn't work for us. Because of that we need something
> like bpf_link. Existing attachment API doesn't go away and is still
> supported. Feel free to use existing API. As for EXPECTED_FD API you
> are adding, it will be up to maintainers to decide, ultimately, I
> can't block it, even if I wanted to.
>
> >
> > >> You're saying that like we didn't already have the netlink API. We
> > >> essentially already have (the equivalent of) LINK_CREATE and LINK_QU=
ERY,
> > >> this is just adding LINK_UPDATE. It's a straight-forward fix of an
> > >> existing API; essentially you're saying we should keep the old API i=
n a
> > >> crippled state in order to promote your (proposed) new API.
> > >
> > > This is the fundamental disagreement that we seem to have. XDP's BPF
> > > program attachment is not in any way equivalent to bpf_link. So no,
> > > netlink API currently doesn't have anything that's close to bpf_link.
> > > Let me try to summarize what bpf_link is and what are its fundamental
> > > properties regardless of type of BPF programs.
> >
> > First of all, thank you for this summary; that is very useful!
>
> Sure, you're welcome.
>
> >
> > > 1. bpf_link represents a connection (pairing?) of BPF program and som=
e
> > > BPF hook it is attached to. BPF hook could be perf event, cgroup,
> > > netdev, etc. It's a completely independent object in itself, along th=
e
> > > bpf_map and bpf_prog, which has its own lifetime and kernel
> > > representation. To user-space application it is returned as an
> > > installed FD, similar to loaded BPF program and BPF map. It is
> > > important that it's not just a BPF program, because BPF program can b=
e
> > > attached to multiple BPF hooks (e.g., same XDP program can be attache=
d
> > > to multiple interface; same kprobe handler can be installed multiple
> > > times), which means that having BPF program FD isn't enough to
> > > uniquely represent that one specific BPF program attachment and detac=
h
> > > it or query it. Having kernel object for this allows to encapsulate
> > > all these various details of what is attached were and present to
> > > user-space a single handle (FD) to work with.
> >
> > For XDP there is already a unique handle, it's just implicit: Each
> > netdev can have exactly one XDP program loaded. So I don't really see
> > how bpf_link adds anything, other than another API for the same thing?
>
> I certainly failed to explain things clearly if you are still asking
> this. See point #2, once you attach bpf_link you can't just replace
> it. This is what XDP doesn't have right now.

From your description I like bpf_link, because it'll make attachment easier
to support, and the pinning behaviour also seems nice. I'm really not fusse=
d
by netlink vs syscall, whatever.

However, this behaviour concerns me. It's like Windows not
letting you delete a file while an application has it opened, which just le=
ads
to randomly killing programs until you find the right one. It's frustrating
and counter productive.

You're taking power away from the operator. In your deployment scenario
this might make sense, but I think it's a really bad model in general. If I=
 am
privileged I need to be able to exercise that privilege. This means that if
there is a netdevice in my network namespace, and I have CAP_NET_ADMIN
or whatever, I can break the association.

So, to be constructive: I'd prefer bpf_link to replace a netlink attachment=
 and
vice versa. If you need to restrict control, use network namespaces
to hide the devices, instead of hiding the bpffs.

>
> It's a game of picking features/properties in isolation and "we can do
> this particular thing this different way with what we have". Please,
> try consider all of it together, it's important. Every single aspect
> of bpf_link is not that unique, but it's all of them together that
> matter.
>
> >
> > > 2. Due to having FD associated with bpf_link, it's not possible to
> > > talk about "owning" bpf_link. If application created link and never
> > > shared its FD with any other application, it is the sole owner of it.
> > > But it also means that you can share it, if you need it. Now, once
> > > application closes FD or app crashes and kernel automatically closes
> > > that FD, bpf_link refcount is decremented. If it was the last or only
> > > FD, it will trigger automatica detachment and clean up of that
> > > particular BPF program attachment. Note, not a clean up of BPF
> > > program, which can still be attached somewhere else: only that
> > > particular attachment.
> >
> > This behaviour is actually one of my reservations against bpf_link for
> > XDP: I think that automatically detaching XDP programs when the FD is
> > closed is very much the wrong behaviour. An XDP program processes
> > packets, and when loading one I very much expect it to keep doing that
> > until I explicitly tell it to stop.
>
> As you mentioned earlier, "it's not the only one mode". Just like with
> tracing APIs, you can imagine scripts that would adds their
> packet-sniffing XDP program temporarily. If they crash, "temporarily"
> turns into "permanently, but no one knows". This is bad. And again,
> it's a choice, just with a default to auto-cleanup, because it's safe,
> even if it requires extra step for applications willing to do
> permanent XDP attachment.
>
> >
> > > 3. This derives from the concept of ownership of bpf_link. Once
> > > bpf_link is attached, no other application that doesn't own that
> > > bpf_link can replace, detach or modify the link. For some cases it
> > > doesn't matter. E.g., for tracing, all attachment to the same fentry
> > > trampoline are completely independent. But for other cases this is
> > > crucial property. E.g., when you attach BPF program in an exclusive
> > > (single) mode, it means that particular cgroup and any of its childre=
n
> > > cgroups can have any more BPF programs attached. This is important fo=
r
> > > container management systems to enforce invariants and correct
> > > functioning of the system. Right now it's very easy to violate that -
> > > you just go and attach your own BPF program, and previous BPF program
> > > gets automatically detached without original application that put it
> > > there knowing about this. Chaos ensues after that and real people hav=
e
> > > to deal with this. Which is why existing
> > > BPF_PROG_ATTACH/BPF_PROG_DETACH API is inadequate and we are adding
> > > bpf_link support.
> >
> > I can totally see how having an option to enforce a policy such as
> > locking out others from installing cgroup BPF programs is useful. But
> > such an option is just that: policy. So building this policy in as a
> > fundamental property of the API seems like a bad idea; that is
> > effectively enforcing policy in the kernel, isn't it?
>
> I hope we won't go into a dictionary definition of what "policy" means
> here :). For me it's about guarantee that kernel gives to user-space.
> bpf_link doesn't care about dictating policies. If you don't want this
> guarantee - don't use bpf_link, use direct program attachment. As
> simple as that. Policy is implemented by user-space application by
> using APIs with just the right guarantees.
>
> >
> > > Those same folks have similar concern with XDP. In the world where
> > > container management installs "root" XDP program which other user
> > > applications can plug into (libxdp use case, right?), it's crucial to
> > > ensure that this root XDP program is not accidentally overwritten by
> > > some well-meaning, but not overly cautious developer experimenting in
> > > his own container with XDP programs. This is where bpf_link ownership
> > > plays a huge role. Tupperware agent (FB's container management agent)
> > > would install root XDP program and will hold onto this bpf_link
> > > without sharing it with other applications. That will guarantee that
> > > the system will be stable and can't be compromised.
> >
> > See this is where we get into "deployment-model specific territory". I
> > mean, sure, in the "central management daemon" model, it makes sense
> > that no other applications can replace the XDP program. But, erm, we
> > already have a mechanism to ensure that: Just don't grant those
> > applications CAP_NET_ADMIN? So again, bpf_link doesn't really seem to
> > add anything other than a different way to do the same thing?
>
> Because there are still applications that need CAP_NET_ADMIN in order
> to function (for other reasons than attaching XDP), so it's impossible
> to enforce with for everyone.

I think I'm missing some context. CAP_NET_ADMIN is trusted by definition,
so trust these applications to not fiddle with XDP? Are there many of these=
?
Are they inside a user namespace or something?

>
> >
> > Additionally, in the case where there is *not* a central management
> > daemon (i.e., what I'm implementing with libxdp), this would be the flo=
w
> > implemented by the library without bpf_link:
> >
> > 1. Query kernel for current BPF prog loaded on $IFACE
> > 2. Sanity-check that this program is a dispatcher program installed by
> >    libxdp
> > 3. Create a new dispatcher program with whatever changes we want to do
> >    (such as adding another component program).
> > 4. Atomically replace the old program with the new one using the netlin=
k
> >    API in this patch series.
> >
> > Whereas with bpf_link, it would be:
> >
> > 1. Find the pinned bpf_link for $IFACE (e.g., load from
> >    /sys/fs/bpf/iface-links/$IFNAME).
>
> But now you can hide this mount point from containerized
> root/CAP_NET_ADMIN application, can't you? See the difference? One
> might think about bpf_link as a fine-grained capability in this sense.
>
>
> > 2. Query kernel for current BPF prog linked to $LINK
> > 3. Sanity-check that this program is a dispatcher program installed by
> >    libxdp
> > 4. Create a new dispatcher program with whatever changes we want to do
> >    (such as adding another component program).
> > 5. Atomically replace the old program with the new one using the
> >    LINK_UPDATE bpf() API.
> >
> >
> > So all this does is add an additional step, and another dependency on
> > bpffs. And crucially, I really don't see how the "bpf_link is the only
> > thing that is not fundamentally broken" argument holds up.
> >
> > -Toke
> >



--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
