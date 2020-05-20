Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB611DA715
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 03:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgETBU6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 21:20:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 21:20:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CF23B1AA;
        Wed, 20 May 2020 01:20:59 +0000 (UTC)
Date:   Wed, 20 May 2020 11:20:45 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200520012045.5yqejh6kic3gbkyw@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
 <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5ec4uayovknuc3g"
Content-Disposition: inline
In-Reply-To: <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--a5ec4uayovknuc3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Mon, May 18, 2020 at 7:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2020-05-19, Jann Horn <jannh@google.com> wrote:
> > > On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wr=
ote:
> > > > ## deep argument inspection
> > > >
> > > > Background: seccomp users would like to write filters that traverse
> > > > the user pointers passed into many syscalls, but seccomp can't do t=
his
> > > > dereference for a variety of reasons (mostly involving race conditi=
ons and
> > > > rearchitecting the entire kernel syscall and copy_from_user() code =
flows).
> > >
> > > Also, other than for syscall entry, it might be worth thinking about
> > > whether we want to have a special hook into seccomp for io_uring.
> > > io_uring is growing support for more and more syscalls, including
> > > things like openat2, connect, sendmsg, splice and so on, and that list
> > > is probably just going to grow in the future. If people start wanting
> > > to use io_uring in software with seccomp filters, it might be
> > > necessary to come up with some mechanism to prevent io_uring from
> > > permitting access to almost everything else...
> > >
> > > Probably not a big priority for now, but something to keep in mind for
> > > the future.
> >
> > Indeed. Quite a few people have raised concerns about io_uring and its
> > debug-ability, but I agree that another less-commonly-mentioned concern
> > should be how you restrict io_uring(2) from doing operations you've
> > disallowed through seccomp. Though obviously user_notif shouldn't be
> > allowed. :D
> >
> > > > The argument caching bit is, I think, rather mechanical in nature s=
ince
> > > > it's all "just" internal to the kernel: seccomp can likely adjust h=
ow it
> > > > allocates seccomp_data (maybe going so far as to have it split acro=
ss two
> > > > pages with the syscall argument struct always starting on the 2nd p=
age
> > > > boundary), and copying the EA struct into that page, which will be =
both
> > > > used by the filter and by the syscall.
> > >
> > > We could also do the same kind of thing the eBPF verifier does in
> > > convert_ctx_accesses(), and rewrite the context accesses to actually
> > > go through two different pointers depending on the (constant) offset
> > > into seccomp_data.
> >
> > My main worry with this is that we'll need to figure out what kind of
> > offset mathematics are necessary to deal with pointers inside the
> > extensible struct. As a very ugly proposal, you could make it so that
> > you multiply the offset by PAGE_SIZE each time you want to dereference
> > the pointer at that offset (unless we want to add new opcodes to cBPF to
> > allow us to represent this).
>=20
> Please don't. cbpf is frozen.

I have an alternative proposal in another mail[1].

> > This might even be needed for seccomp user_notif -- given one of the
> > recent proposals was basically to just add two (extensible) struct
> > pointers inside the main user_notif struct.
> >
> > > > I imagine state tracking ("is
> > > > there a cached EA?", "what is the address of seccomp_data?", "what =
is
> > > > the address of the EA?") can be associated with the thread struct.
> > >
> > > You probably mean the task struct?
> > >
> > > > The growing size of the EA struct will need some API design. For fi=
lters
> > > > to operate on the contiguous seccomp_data+EA struct, the filter will
> > > > need to know how large seccomp_data is (more on this later), and how
> > > > large the EA struct is. When the filter is written in userspace, it=
 can
> > > > do the math, point into the expected offsets, and get what it needs=
=2E For
> > > > this to work correctly in the kernel, though, the seccomp BPF verif=
ier
> > > > needs to know the size of the EA struct as well, so it can correctly
> > > > perform the offset checking (as it currently does for just the
> > > > seccomp_data struct size).
> > > >
> > > > Since there is not really any caller-based "seccomp state" associat=
ed
> > > > across seccomp(2) calls, I don't think we can add a new command to =
tell
> > > > the kernel "I'm expecting the EA struct size to be $foo bytes", sin=
ce
> > > > the kernel doesn't track who "I" is besides just being "current", w=
hich
> > > > doesn't take into account the thread lifetime -- if a process launc=
her
> > > > knows about one size and the child knows about another, things will=
 get
> > > > confused. The sizes really are just associated with individual filt=
ers,
> > > > based on the syscalls they're examining. So, I have thoughts on pos=
sible
> > > > solutions:
> > > >
> > > > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses =
the
> > > >   EA style so we can pass in more than a filter and include also an
> > > >   array of syscall to size mappings. (I don't like this...)
> > > > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which c=
hanges
> > > >   the meaning of the uarg from "filter" to a EA-style structure with
> > > >   sizes and pointers to the filter and an array of syscall to size
> > > >   mappings. (I like this slightly better, but I still don't like it=
=2E)
> > > > - leverage the EA design and just accept anything <=3D PAGE_SIZE, r=
ecord
> > > >   the "max offset" value seen during filter verification, and zero-=
fill
> > > >   the EA struct with zeros to that size when constructing the
> > > >   seccomp_data + EA struct that the filter will examine. Then the s=
eccomp
> > > >   filter doesn't care what any of the sizes are, and userspace does=
n't
> > > >   care what any of the sizes are. (I like this as it makes the prob=
lems
> > > >   to solve contained entirely by the seccomp infrastructure and doe=
s not
> > > >   touch user API, but I worry I'm missing some gotcha I haven't
> > > >   considered.)
> > >
> > > We don't need to actually zero-fill memory for this beyond what the
> > > kernel supports - AFAIK the existing APIs already say that passing a
> > > short length is equivalent to passing zeroes, so we can just replace
> > > all out-of-bounds loads with zeroing registers in the filter.
> > > The tricky case is what should happen if the userspace program passes
> > > in fields that the filter doesn't know about. The filter can see the
> > > length field passed in by userspace, and then just reject anything
> > > where the length field is bigger than the structure size the filter
> > > knows about. But maybe it'd be slightly nicer if there was an
> > > operation for "tell me whether everything starting at offset X is
> > > zeroes", so that if someone compiles with newer kernel headers where
> > > the struct is bigger, and leaves the new fields zeroed, the syscalls
> > > still go through an outdated filter properly.
> >
> > I think the best way of handling this (without breaking programs
> > senselessly) is to have filters essentially emulate
> > copy_struct_from_user() semantics -- which is along the lines of what
> > you've suggested.
>=20
> and cpbf load instruction will become copy_from_user() underneath? I
> don't see how that can work. Have you considered implications to jits,
> register usage, etc ?
>=20
> ebpf will become sleepable soon. It will be able to do copy_from_user()
> and examine any level of user pointer dereference.
> toctou is still going to be a concern though,
> but such ebpf+copy_from_user analysis and syscall sandboxing
> will not need to change kernel code base around syscalls at all.
> No need to invent E-syscalls and all the rest I've seen in this thread.

No it won't become copy_from_user(), nor will there be a TOCTOU race.

The idea is that seccomp will proactively copy the struct (and
recursively any of the struct pointers inside) before the syscall runs
-- as this is done by seccomp it doesn't require any copy_from_user()
primitives in cBPF. We then run the cBPF filter on the copied struct,
just like how cBPF programs currently operate on seccomp_data (how this
would be exposed to the cBPF program as part of the seccomp ABI is the
topic of discussion here).

Then, when the actual syscall code runs, the struct will have already
been copied and the syscall won't copy it again.

eBPF being able to do copy_from_user() isn't really relevant to this
discussion because we need seccomp to be sure that the structure being
filtered by the program is the same structure that the syscall ends up
using. As you mentioned, there's a fundamental TOCTOU there.

[1]: https://lore.kernel.org/lkml/20200519134244.37bhucyram4n6sjk@yavin.dot=
=2Ecyphar.com/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--a5ec4uayovknuc3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl7EheoACgkQnhiqJn3b
jbQhIhAApHiGc5C+Mfz0GnrGdL0OIvNWCbcyI68AY6L7VJKzF8cgN1PwbFG8kysE
CTApVBTE8CmsfTL9MfLxB81Q8k30Xxgih1NFbwobypzSxJ1RR3t0rTqP/6wBpPE7
Fr4sdGEKQi41sj7w1Wqon4S23dCdx8U+NyuYW2EFDX0J7/p+xPsULg1SlxTdX/x8
Eddj0eq82UJQ00u5ON8UxmJ4NDiSKgyNC+4Wa4zOwlVw3QVp2MubD2shaJIxhIY7
/io7NKBvz/b0bHmZi3OnCqD1y2liqeYpjgJtjXyNNXwgafVadVz1rkRaL4t+Ah4j
1dwKeiwdBe/MDyU0uZZD9PlOlvWUDCUzwCwlcuJU5cpf23+VKMXPJTqXjCQj8/+K
dNmAhWmx+mRpG/GyoyVAMEa5PdU2pHaPoznkplzSaaDBpsMlTfZiD+GaooNY9Hhe
7yoFGZAK0Z3rb5Bmun139wPihlqRhUK3B+sbV3BcYe70T1iFmI6P+ZVriZh6OzNy
MxUVjXPhQ+WNjqmUqb/GN26FH45NQXVbK+8Ax+np/vpbxLDPMWIW4oCXI1PFjEvh
/ZeBo4biaoE28bNHorS6lPpzRkc2km1VAheJlNxa2Bw4QAeqnkPEzI/QdfyIHFvr
sFuPvqOls44GJVdiqsFF6tz5+QTkfuRkEEJsB3LgK3QB2YGlk2g=
=fXKj
-----END PGP SIGNATURE-----

--a5ec4uayovknuc3g--
