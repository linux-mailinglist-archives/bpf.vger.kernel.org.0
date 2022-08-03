Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48318588524
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 02:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiHCA3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 20:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHCA3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 20:29:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136841EC73
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 17:29:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so6834631edd.3
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=KesMac/7YMHS4JeaZ0EQ54XTE6WKqI0Sppb0wx7xJ4I=;
        b=NsVhIEp22IEsuXu3Ra34s1JsHsAiolybITjbyUsYcgdAhz9DDnKP/6d7Rxuo8jk/nB
         m55E56CiAb60PLj4ohXgyzsHSR6/LrxGK97/OlQtPJr5TAvUwXeSFgUL6GNh4+HrU2tL
         kWwe4U8UmDhTs2R7rE4S+uEl36WCChuxE2iZ1m4p7py1pilHHKxaaa3Q7cfOem6Z5D7K
         be4JhRtDSGsLTArr55LIY7t8uMbQ+UwQg4bnA/QpSmVh5YiYcsz13y02QUz8l6c7wb+1
         AgJR/zUEsfFPjXmQeKiTtZJMJfGbXucRYOERxXUZJvjKpRjAP8yso+yX/2fMC1+vktI4
         4hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=KesMac/7YMHS4JeaZ0EQ54XTE6WKqI0Sppb0wx7xJ4I=;
        b=ahz3bYRKWZyhoCe44Wcn7+mK/WimAiFWd18i36sWsq/bEe30b4T+OJSRvcIIq/5f6+
         rsVdQjLJ42k9YG6MLzAJsie/6yfsiJDNMWQ4i1J9imysRHMTSfEEyINlJRJpoJT7Jn61
         MRZ/Z2tLrCSPCy9zTjSKnv0el8jZi22KU0kFWPHexJnwNmBP3XrlxAIDYhGw973Ri0zQ
         ma3u6OsonCZjU70pZz3H1s9GtqWUyLfFgZYJ3AKQJg+HRj4wkYZRehde4QSjJLj4/fy8
         41HDp+MsVsN8DnJdqrIIX4d0D8GDdOB09kFCKIY/UtFIPgtn+SsTqthgMwEZJPm3ENiQ
         KYJQ==
X-Gm-Message-State: AJIora/w2OIKD65Av9cEARReheCZmCfeebQyifmVOKguI8vRdoSjuFO5
        Xe1TrCAGotz6Eb2WhGjhZvDU64/cD50i7LQLur8=
X-Google-Smtp-Source: AGRyM1syAuaYIXc7XBIKHCajuFeGmwc7zhwKa42tyjJ5ZPsTirHNZfFzg2By779Z7MFD7lUFGcy7suHiZ21GSikD0gE=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr23200823edb.333.1659486571594; Tue, 02
 Aug 2022 17:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
 <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
 <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com> <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
 <87v8s65hdc.fsf@oracle.com> <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
 <8735fa3unq.fsf@oracle.com> <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
 <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
 <87tu7p3o4k.fsf@oracle.com> <CADvTj4r_WnaC-nb-wQwqrzfJsERaX-TnR0tRXZF8fE5UPBThHQ@mail.gmail.com>
 <87h73p1f5s.fsf@oracle.com> <CADvTj4qiz0xHnN+s32tiYm_WA8ai4cHUVPkKm7w6xTkZXUBCag@mail.gmail.com>
 <87k08lunga.fsf@oracle.com> <87fsj8vjcy.fsf@oracle.com> <87bktwvhu5.fsf@oracle.com>
 <CADvTj4o-36iuru665BW0XnEauXBeszW438QTtpt4_VUEjf5nXg@mail.gmail.com>
 <CAEf4BzbN99WbEDS9r7nyO-7+SOYTU=-kXhD+A1L3dzrwrcHdBQ@mail.gmail.com>
 <CADvTj4qi_ZZhdXRPd0X_tgQ8-jgrRgxF+4+kYVA92ZMO8KqESA@mail.gmail.com>
 <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com> <CADvTj4oSc646ebcWzXB65gSy144D+GikbT5eF38OHu+T5tbn-w@mail.gmail.com>
In-Reply-To: <CADvTj4oSc646ebcWzXB65gSy144D+GikbT5eF38OHu+T5tbn-w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 17:29:20 -0700
Message-ID: <CAEf4BzYGXj4otX0pFSTcxKrQAuv7L_rqLyb5Hsp_ueZOZdJorA@mail.gmail.com>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 3:06 PM James Hilliard <james.hilliard1@gmail.com> w=
rote:
>
> On Tue, Aug 2, 2022 at 3:29 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Aug 1, 2022 at 4:35 PM James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > >
> > > On Mon, Aug 1, 2022 at 4:52 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> > > > > <jose.marchesi@oracle.com> wrote:
> > > > > >
> > > > > >
> > > > > > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > > > > > >>> <jose.marchesi@oracle.com> wrote:
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
> > > > > > >>>> > <jose.marchesi@oracle.com> wrote:
> > > > > > >>>> >>
> > > > > > >>>> >>
> > > > > > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.=
hilliard1@gmail.com> wrote:
> > > > > > >>>> >> >>
> > > > > > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
> > > > > > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > > > > > >>>> >> >> >
> > > > > > >>>> >> >> >
> > > >
> > > > Please trim your replies (and I don't know what your email client d=
id,
> > > > but it completely ruined nested quote formatting)
> > >
> > > Yeah, not sure what happened there.
> > >
> > > >
> > > > [...]
> > > >
> > > > > > >>>>
> > > > > > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf=
.c
> > > > > > >>>> index e89cc9c885b3..887b78780099 100644
> > > > > > >>>> --- a/tools/lib/bpf/libbpf.c
> > > > > > >>>> +++ b/tools/lib/bpf/libbpf.c
> > > > > > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_=
data_maps(struct bpf_object *obj)
> > > > > > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; =
sec_idx++) {
> > > > > > >>>>                 sec_desc =3D &obj->efile.secs[sec_idx];
> > > > > > >>>>
> > > > > > >>>> +                /* Skip recognized sections with size 0. =
 */
> > > > > > >>>> +                if (sec_desc->data && sec_desc->data->d_s=
ize =3D=3D 0)
> > > > > > >>>> +                  continue;
> > > > > > >>>> +
> > > > > > >>>>                 switch (sec_desc->sec_type) {
> > > > > > >>>>                 case SEC_DATA:
> > > > > > >>>>                         sec_name =3D elf_sec_name(obj, elf=
_sec_by_idx(obj, sec_idx));
> > > > > > >>>
> > > > > > >>> Ok, skeleton is now getting generated successfully, however=
 it differs from the
> > > > > > >>> clang version so there's a build error when we include/use =
the header:
> > > > > > >>> ../src/core/restrict-ifaces.c: In function =E2=80=98prepare=
_restrict_ifaces_bpf=E2=80=99:
> > > > > > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=98struct
> > > > > > >>> restrict_ifaces_bpf=E2=80=99 has no member named =E2=80=98r=
odata=E2=80=99; did you mean
> > > > > > >>> =E2=80=98data=E2=80=99?
> > > > > > >>>    45 |         obj->rodata->is_allow_list =3D is_allow_lis=
t;
> > > > > > >>>       |              ^~~~~~
> > > > > > >>>       |              data
> > > > > > >>>
> > > > > > >>> The issue appears to be that clang generates "rodata" membe=
rs in
> > > > > > >>> restrict_ifaces_bpf while with gcc we get "data" members in=
stead.
> > > > > > >>
> > > > > > >> This is because the BPF GCC port is putting the
> > > > > > >>
> > > > > > >>   const volatile unsigned char is_allow_list =3D 0;
> > > > > > >>
> > > > > > >> in a .data section instead of .rodata, due to the `volatile'=
.  The
> > > > > > >> x86_64 GCC seems to use .rodata.
> > > > > > >>
> > > > > > >> Looking at why the PBF port does this...
> > > > > > >
> > > > > > > So, turns out GCC puts zero-initialized `const volatile' vari=
ables in
> > > > > > > .data sections (and not .rodata) in all the targets I have tr=
ied, like
> > > > > > > x86_64 and aarch64.
> > > > > > >
> > > > > > > So this is a LLVM and GCC divergence :/
> > > > > >
> > > > > > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521.
> > > > > >
> > > > > > You may try, as a workaround:
> > > > > >
> > > > > > __attribute__((section(".rodata"))) const volatile unsigned cha=
r is_allow_list =3D 0;
> > > > > >
> > > > > > But that will use permissions "aw" for the .rodata section (and=
 you will
> > > > > > get a warning from the assembler.)  It may be problematic for l=
ibbpf.
> > > > >
> > > > > So rather than try to force gcc to use the incorrect llvm .rodata
> > > > > section it looks
> > > > > like we can instead just force llvm to use the correct .data sect=
ion like this:
> > > > > https://github.com/systemd/systemd/pull/24164
> > > > >
> > > >
> > > > There is a huge difference between variables in .rodata and .data.
> > > > .rodata variable's value is known to the BPF verifier at verificati=
on
> > > > time and this knowledge will be used to decide which code paths are
> > > > always or never taken (as one example). It's a crucial property and
> > > > important guarantee.
> > > >
> > > > If you don't care about that property, don't declare the variable a=
s `const`.
> > > >
> > > > So no, it's not llvm putting `const` variable into .rodata
> > > > incorrectly, but GCC is trying to be smart and just because variabl=
e
> > > > is declared volatile is putting *const* variable into read-write .d=
ata
> > > > section. It's declared as const, and yes it's volatile to make sure
> > > > that compiler isn't too smart about optimizing away read operations=
.
> > >
> > > Isn't const volatile generating a .rodata section(like llvm is doing)=
 a spec
> > > violation?
> > > https://github.com/llvm/llvm-project/issues/56468
> > >
> > > > But it's still a const read-only variable from the perspective of t=
hat
> > > > BPF C code.
> > > >
> > > > If you don't care about the read-only nature of that variable, drop
> > > > the const and make it into a non-read-only variable.
> > > >
> > > > And please stop proposing hacks to be added to perfectly valid syst=
emd
> > > > BPF source code (I replied on [0] as well).
> > >
> > > From my understanding gcc is correctly putting a const volatile varia=
ble
> > > in .data while llvm is incorrectly putting it in .rodata, is the gcc =
behavior
> > > here invalid or is the llvm behavior invalid?
> >
> > From link you left to C standard, it does seem like that side-note
> > *implies* that const volatile should be put into .data, but it's a)
> > implied b) is quite arguable about assumptions that this data has to
> > be in modifiable section, and c) entire CO-RE feature detection and
> > guarding relies on having `const volatile` variables in .rodata and
> > mark them as read-only for BPF verifier to allow dead code
> > elimination. Changing c) would break entire CO-RE ecosystem.
>
> Well it does appear that llvm is fixing the behavior to be in line with g=
cc:
> https://reviews.llvm.org/D131012
>
> >
> > Seems like this issue was raised by Ulrich Drepper back in 2005 ([0])
> > and he was also confused about GCC's behavior, btw.
> >
> > So either way, at the very least for BPF target we can't change this
> > and I still think it's more logical to put const variables into
> > .rodata, regardless of side notes in C standard.
>
> GCC does put const variables in .rodata, just not const volatile variable=
s.
>

It's still const. Volatile doesn't change constness of a variable.
We've been discussing this over and over, it gets a bit tiring, tbh.

Aaron Ballman seems to agree, quoting him from [0]:

  The footnote cited isn't a normative requirement (I can't see any
  normative requirements that say we can't put a const volatile object
  into a read only section), so it's debatable just how much of a bug
  this is from a standards conformance perspective. I will have to
  inquire on the WG14 reflectors to see if there's something I've
  missed but I believe that C17 6.7.3p5 is meant to point out that
  only lvalue are qualified; rvalues are not because lvalue conversion
  strips the qualifiers. I think the footnote is mostly a nod towards
  the fact that volatile qualified objects may change their value in
  ways unknown to the compiler so storing it in a read-only section
  of memory is a bit questionable. But I'm curious if the committee
  tells me I've missed something there.


  [0] https://github.com/llvm/llvm-project/issues/56468#issuecomment-120314=
6308

> >
> >
> > As for systemd's program and its is_allow_list ([1]), to unblock
> > yourself you can drop const because systemd doesn't rely on read-only
> > guarantees of that variable anyways. It's much more critical in
> > feature-detection use cases. But let's try to converge discussion in
> > one place (preferably here), it's quite inconvenient to either reply
> > the same thing twice here and on Github, or cross-reference lore and
> > Github.
>
> Hmm, are you sure:
> const __u8 is_allow_list SEC(".rodata") =3D 0;
>
> doesn't provide equivalent behavior to:
> const volatile __u8 is_allow_list =3D 0;

Is there anything preventing you from experimenting with this yourself?..

Let's see:

$ git diff
diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c
b/tools/testing/selftests/bpf/prog_tests/skeleton.c
index 99dac5292b41..386785a45af0 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -31,6 +31,8 @@ void test_skeleton(void)
        if (CHECK(skel->kconfig, "skel_kconfig", "kconfig is mmaped()!\n"))
                goto cleanup;

+       skel->rodata->should_trap =3D false;
+
        bss =3D skel->bss;
        data =3D skel->data;
        data_dyn =3D skel->data_dyn;
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c
b/tools/testing/selftests/bpf/progs/test_skeleton.c
index 1a4e93f6d9df..eee26bc82525 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -26,6 +26,8 @@ const volatile struct {
        const int in6;
 } in =3D {};

+const bool should_trap SEC(".rodata") =3D true;
+
 /* .data section */
 int out1 =3D -1;
 long long out2 =3D -1;
@@ -58,6 +60,10 @@ int handler(const void *ctx)
 {
        int i;

+       while (should_trap)
+       {
+       }
+
        out1 =3D in1;
        out2 =3D in2;
        out3 =3D in3;


Result: selftests stop compiling. Why?

$ llvm-objdump -d test_skeleton.linked1.o

test_skeleton.linked1.o:        file format elf64-bpf

Disassembly of section raw_tp/sys_enter:

0000000000000000 <handler>:
       0:       05 00 ff ff 00 00 00 00 goto -1 <handler>

Because compiler optimized away everything with while (true) {}. There
is no global data at all anymore.

This is what I keep telling you, const volatile is the only thing
preventing the compiler from making wrong assumptions. And neither

const bool should_trap SEC(".rodata") =3D true;

nor

const bool should_trap =3D true;

work.

But

const volatile bool should_trap =3D true;

does work.

If you have some more speculative proposals, please investigate them
yourself and report back with the results. But either way there is a
lot of BPF code written with reliance on `const volatile`, both open
source and not, so please stop actively trying to break BPF ecosystem
with proposals like moving `const volatile` to .data, just because
it's more convenient for you in GCC. Thank you.

>
> The used attribute in the SEC macro supposedly ensures that:
> The compiler must emit the definition even if it appears to be unused, an=
d
> it must not apply optimizations which depend on fully understanding how
> the entity is used.
>
> Or maybe the retain attribute along with used would be sufficient to allo=
w
> us to drop volatile in these cases?:
> https://clang.llvm.org/docs/AttributeReference.html#retain
>
> >
> >
> >   [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521
> >   [1] https://github.com/systemd/systemd/pull/24164#issuecomment-120320=
7372
> >
> > >
> > > >
> > > >   [0] https://github.com/systemd/systemd/pull/24164#issuecomment-12=
01806413
> > > >
> > > >
> > > > [...]
