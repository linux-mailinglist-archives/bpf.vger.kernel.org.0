Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA638F358
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhEXS5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhEXS5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 14:57:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B8BC061756
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 11:56:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z24so28892694ioi.3
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kY5ODL09+MFOG0z0UW2n/UhvHutj9fmmLO3qpZTedGA=;
        b=DU9Nb3d0eumYE6yPGePAk/liCz7kzb4TdqRZU3Q9TXKx1N0JT/l2RW1mQ5dVtqN8WV
         RfLtOktNcAG2XTXy0wmJy59K9Kj9T2JgvzslsaBWDS8Dug081GxE3ql9gr8eG0H8i/8W
         phWc3AWv+VY0QMEc1d8eIrsiprPFZogFOsvco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kY5ODL09+MFOG0z0UW2n/UhvHutj9fmmLO3qpZTedGA=;
        b=F6XN1luzgR0lR0N/Uq4VXF5Oa4dCtjHeDa/yFW7kby5DnxyGHQqA4YG8GWCnsNNdQz
         4nVbvrXnomtJ2ZgTa/2ddDCfNMR7o2nRQ2vLrUHKEAaMFXbtyp24xAuPO9sn+MftPlOx
         X/q12bgJ8MeBsOAY/NnwMgO00lpdEC/WpEsWWVAeJPssmgVesu7lK1F1BwQdSP/oc3YN
         cEN2gcClZGW0q23tOj4kB2wH05AEEh84F0WiysCywIhKdRKuvgy40SeTVyBTeVrZRTX/
         4NTLaTdbRnckwqW4b19L6n4GgRPebejbQyqL1+Uwlv8W2YIVXQ0ID05acEUx9IBzABM1
         qPRA==
X-Gm-Message-State: AOAM530L0aDNNZgynVdtwKerhJIVtaDxYLXcurVxWdH316eNSsErzjWJ
        qgWRE7oyfG8dwhQ21yho/pCwJ/TTsy6/PFNYG/PyVA==
X-Google-Smtp-Source: ABdhPJyU5QTyR2R5Ov3SlHc+M44rspLop3d/kpVd20Xusxd9ECjmltvb99VG+PRGEuN4LJN9mjVBUZxMjMroEa/D55c=
X-Received: by 2002:a05:6602:2d8f:: with SMTP id k15mr16960080iow.114.1621882565864;
 Mon, 24 May 2021 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620499942.git.yifeifz2@illinois.edu> <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <eae2a0e5038b41c4af87edcb3d4cdc13@DM5PR11MB1692.namprd11.prod.outlook.com> <CAGMVDEFE8g5XKyQbB1xaK3ve58cENN2hZm3u=ktpGFgmBdQkeQ@mail.gmail.com>
In-Reply-To: <CAGMVDEFE8g5XKyQbB1xaK3ve58cENN2hZm3u=ktpGFgmBdQkeQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 24 May 2021 11:55:29 -0700
Message-ID: <CAMp4zn9gAA4csoM=p75_hU_EfxMaw25yrjy0bFnn3gGhrksFhg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Tianyin Xu <tyxu@illinois.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 1:22 AM Tianyin Xu <tyxu@illinois.edu> wrote:
>
> On Mon, May 17, 2021 at 12:08 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > While I agree with you that this is the case right now, there's no reas=
on it
> > has to be the case. There's a variety of mechanisms that can be employe=
d
> > to significantly speed up the performance of the notifier. For example,=
 right
> > now the notifier is behind one large per-filter lock. That could be rem=
oved
> > allowing for better concurrency. There are a large number of mechanisms
> > that scale O(n) with the outstanding notifications -- again, something
> > that could be improved.
>
> Thanks for the pointer! But, I don=E2=80=99t think this can fundamentally
> eliminate the performance gap between the notifiers and the ebpf
> filters. IMHO, the additional context switches of user notifiers make
> the difference.
>
I mean, I still think it can be closed. Or at least get better. I've
thought about
working on performance improvements, but they're lower on the list
than functionality changes.

> >
> > The other big improvement that could be made is being able to use somet=
hing
> > like io_uring with the notifier interface, but it would require a
> > fairly significant
> > user API change -- and a move away from ioctl. I'm not sure if people a=
re
> > excited about that idea at the moment.
> >
>
> Apologize that I don=E2=80=99t fully understand your proposal. My
> understanding about io_uring is that it allows you to amortize the
> cost of context switch but not eliminate it, unless you are willing to
> dedicate a core for it. I still believe that, even with io_uring, user
> notifiers are going to be much slower than eBPF filters.
The notifier gets significantly slower as a function of the notifications. =
If
you have a large number of notifications in flight, or if you're trying to
concurrently handle a large number of notifications, it gets slower. This
is where something like io_uring is super useful in terms of reducing
wakeups.

Also, in the original futex2 patches, it had a mechanism to better handle
(scheduling) of notifier like cases[1]. If the seccomp notifier did a simil=
ar
thing, we could see better performance.

>
> Btw, our patches are based on your patch set (thank you!). Are you
> using user notifiers (with your improved version?) these days? It will
> be nice to hear your opinions on ebpf filters.
>
I'm so glad that someone is picking up the work on this.

> > >
> > >
> > > > >> eBPF doesn't really have a privilege model yet.  There was a lon=
g and
> > > > >> disappointing thread about this awhile back.
> > > > >
> > > > > The idea is that =E2=80=9Cseccomp-eBPF does not make life easier =
for an
> > > > > adversary=E2=80=9D. Any attack an adversary could potentially uti=
lize
> > > > > seccomp-eBPF, they can do the same with other eBPF features, i.e.=
 it
> > > > > would be an issue with eBPF in general rather than specifically
> > > > > seccomp=E2=80=99s use of eBPF.
> > > > >
> > > > > Here it is referring to the helpers goes to the base
> > > > > bpf_base_func_proto if the caller is unprivileged (!bpf_capable |=
|
> > > > > !perfmon_capable). In this case, if the adversary would utilize e=
BPF
> > > > > helpers to perform an attack, they could do it via another
> > > > > unprivileged prog type.
> > > > >
> > > > > That said, there are a few additional helpers this patchset is ad=
ding:
> > > > > * get_current_uid_gid
> > > > > * get_current_pid_tgid
> > > > >   These two provide public information (are namespaces a concern?=
). I
> > > > > have no idea what kind of exploit it could add unless the adversa=
ry
> > > > > somehow side-channels the task_struct? But in that case, how is t=
he
> > > > > reading of task_struct different from how the rest of the kernel =
is
> > > > > reading task_struct?
> > > >
> > > > Yes, namespaces are a concern.  This idea got mostly shot down for =
kdbus
> > > > (what ever happened to that?), and it likely has the same problems =
for
> > > > seccomp.
> > > >
So, we actually have a case where we want to inspect an argument --
We want to look at the FD number that's passed to the sendmsg syscall, and =
then
see if that's an AF_INET socket, and if it is, then pass back to
notifier, otherwise
allow it to continue through. This is an area where I can see eBPF being
very useful.

> > > > >>
> > > > >> What is this for?
> > > > >
> > > > > Memory reading opens up lots of use cases. For example, logging w=
hat
> > > > > files are being opened without imposing too much performance pena=
lty
> > > > > from strace. Or as an accelerator for user notify emulation, wher=
e
> > > > > syscalls can be rejected on a fast path if we know the memory con=
tents
> > > > > does not satisfy certain conditions that user notify will check.
> > > > >
> > > >
> > > > This has all kinds of race conditions.
> > > >
> > > >
> > > > I hate to be a party pooper, but this patchset is going to very hig=
h bar
> > > > to acceptance.  Right now, seccomp has a couple of excellent proper=
ties:
> > > >
> > > > First, while it has limited expressiveness, it is simple enough tha=
t the
> > > > implementation can be easily understood and the scope for
> > > > vulnerabilities that fall through the cracks of the seccomp sandbox
> > > > model is low.  Compare this to Windows' low-integrity/high-integrit=
y
> > > > sandbox system: there is a never ending string of sandbox escapes d=
ue to
> > > > token misuse, unexpected things at various integrity levels, etc.
> > > > Seccomp doesn't have tokens or integrity levels, and these bugs don=
't
> > > > happen.
> > > >
> > > > Second, seccomp works, almost unchanged, in a completely unprivileg=
ed
> > > > context.  The last time making eBPF work sensibly in a less- or
> > > > -unprivileged context, the maintainers mostly rejected the idea of
> > > > developing/debugging a permission model for maps, cleaning up the b=
pf
> > > > object id system, etc.  You are going to have a very hard time
> > > > convincing the seccomp maintainers to let any of these mechanism
> > > > interact with seccomp until the underlying permission model is in p=
lace.
> > > >
> > > > --Andy
> > >
> > > Thanks for pointing out the tradeoff between expressiveness vs. simpl=
icity.
> > >
> > > Note that we are _not_ proposing to replace cbpf, but propose to also
> > > support ebpf filters. There certainly are use cases where cbpf is
> > > sufficient, but there are also important use cases ebpf could make
> > > life much easier.
> > >
> > > Most importantly, we strongly believe that ebpf filters can be
> > > supported without reducing security.
> > >
> > > No worries about =E2=80=9Cparty pooping=E2=80=9D and we appreciate th=
e feedback. We=E2=80=99d
> > > love to hear concerns and collect feedback so we can address them to
> > > hit that very high bar.
> > >
> > >
> > > ~t
> > >
> > > --
> > > Tianyin Xu
> > > University of Illinois at Urbana-Champaign
> > > https://urldefense.com/v3/__https://tianyin.github.io/__;!!DZ3fjg!o4_=
_Ob32oapUDg9_f6hzksoFiX9517CJ5-w8qtG9i-WKFs_xWbGQfUHpLjHjCddw$
>

[1]: https://lore.kernel.org/lkml/20210215152404.250281-1-andrealmeid@colla=
bora.com/T/
