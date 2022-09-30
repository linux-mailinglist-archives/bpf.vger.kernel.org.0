Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4F5F153E
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiI3Vwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3Vwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:52:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57301E5552
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:52:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g130so4754629pfb.8
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pSxAQhJKbQFKBFu2aUmfxxXrQhdB8NRsLZaC1mXwflg=;
        b=IUXknlkzrnlW7qyW/pRLFeJZA5ZR8QzA1dZtKdjaqDN1dJZdeZ9fGemjKCKJcoviY+
         89Lf0bzmMDZkXBRqZmMHjvye21r2APHRZctrKKwbWGr0jk4qMHmunos7tvFQ8OQ8TMTM
         avp5dRMkttJwKQy1BLZkNfipBFWefF6k0qQXeUf/V5ZJfit9/kLVw1bhrngRvWA7MQGs
         qWCsVoKZ+McGSN8hk9kFSj6pua+MckNsBE1EACWSMGxWriqcsIBvSxcTcczIAgbnuS7b
         DVV7Hu3hUlTGHo63Uz+vse6QAMfNwrOU1B2B1FK14gFXj3SKOAzBGzSs+o490efNDdAZ
         izCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pSxAQhJKbQFKBFu2aUmfxxXrQhdB8NRsLZaC1mXwflg=;
        b=S6YWTKqkTidGUx5ZP+LWBFTxHWPOYEWO8YA8eLsrK0ZKEb9wL/6Ai0UQcjXvdAaSFN
         rGxMcSljSwiXeXM0wzOb1KDTEH2FxAasQ+qjRBtu3+6GBujQicm8DBbw3yz86D/xZRkH
         aCCf0mHvOQOcBsvdycUmmkMKVRTQY0OFj1/yltktlLNUrEfbtMeuN69plrziN5MszXoj
         fVjA6UHWEWwHu9LBM5A0+NaGJLYMMuWhZ4Q9QCiASao5ozwQ7Ewotq+GaB0K+gWSvkfN
         o8sVWjpF7ZvMQMoTPiOJUMHWXnV1AR5p+9v3hutDUPJ/+s4xrlAIubOqegQ65CEWrX5U
         FcGw==
X-Gm-Message-State: ACrzQf0NworymzA53hV268lVL3m7oEsD0HN7wL+uYMPwJ1KSejVASFhG
        WNB+nTf2YcRjN1F4RKsrTsQprqeJ3mCFnZp2YT8=
X-Google-Smtp-Source: AMsMyM6Ku9wx6bzk4Ya9QbNaUs4z7rxum55ORrnoleRvAup8Dvs2fKuZxXGDVT+CEuLo8TCZ5WyF2IR4Sw7f3BqDEqI=
X-Received: by 2002:a63:914b:0:b0:43b:cf3c:870e with SMTP id
 l72-20020a63914b000000b0043bcf3c870emr9503619pge.296.1664574766994; Fri, 30
 Sep 2022 14:52:46 -0700 (PDT)
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
 <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com>
 <CADvTj4oSc646ebcWzXB65gSy144D+GikbT5eF38OHu+T5tbn-w@mail.gmail.com>
 <CAEf4BzYGXj4otX0pFSTcxKrQAuv7L_rqLyb5Hsp_ueZOZdJorA@mail.gmail.com>
 <CADvTj4pJwnCFB8LipENEPGAB2-+jBcvmOSJSezyTRr4xiozPNg@mail.gmail.com>
 <CAEf4Bza0-dx=X01ZqzLR_SF6-6r9YZFQa=VLyD6H=0DnLCU1AQ@mail.gmail.com> <CADvTj4oUMQL2hni0grtAumZAbK5_uxrVW-gZ9wju=Y8ba1WZhg@mail.gmail.com>
In-Reply-To: <CADvTj4oUMQL2hni0grtAumZAbK5_uxrVW-gZ9wju=Y8ba1WZhg@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 30 Sep 2022 17:52:34 -0400
Message-ID: <CADvTj4r_CTPyPp9vGO5MkgA9FX5i-eWciNes+Tiq1bds5LSHsw@mail.gmail.com>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 3:24 PM James Hilliard <james.hilliard1@gmail.com> w=
rote:
>
> On Wed, Aug 3, 2022 at 10:57 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 2, 2022 at 6:49 PM James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > >
> > > On Tue, Aug 2, 2022 at 6:29 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 2, 2022 at 3:06 PM James Hilliard <james.hilliard1@gmai=
l.com> wrote:
> > > > >
> > > > > On Tue, Aug 2, 2022 at 3:29 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 1, 2022 at 4:35 PM James Hilliard <james.hilliard1@=
gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 1, 2022 at 4:52 PM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
> > > > > > > > <james.hilliard1@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> > > > > > > > > <jose.marchesi@oracle.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > > > > > > > > > >>> <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > >>>>
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
> > > > > > > > > > >>>> > <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > >>>> >>
> > > > > > > > > > >>>> >>
> > > > > > > > > > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard=
 <james.hilliard1@gmail.com> wrote:
> > > > > > > > > > >>>> >> >>
> > > > > > > > > > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. March=
esi
> > > > > > > > > > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > >>>> >> >> >
> > > > > > > > > > >>>> >> >> >
> > > > > > > >
> > > > > > > > Please trim your replies (and I don't know what your email =
client did,
> > > > > > > > but it completely ruined nested quote formatting)
> > > > > > >
> > > > > > > Yeah, not sure what happened there.
> > > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bp=
f/libbpf.c
> > > > > > > > > > >>>> index e89cc9c885b3..887b78780099 100644
> > > > > > > > > > >>>> --- a/tools/lib/bpf/libbpf.c
> > > > > > > > > > >>>> +++ b/tools/lib/bpf/libbpf.c
> > > > > > > > > > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__init=
_global_data_maps(struct bpf_object *obj)
> > > > > > > > > > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile.s=
ec_cnt; sec_idx++) {
> > > > > > > > > > >>>>                 sec_desc =3D &obj->efile.secs[sec_=
idx];
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> +                /* Skip recognized sections with =
size 0.  */
> > > > > > > > > > >>>> +                if (sec_desc->data && sec_desc->d=
ata->d_size =3D=3D 0)
> > > > > > > > > > >>>> +                  continue;
> > > > > > > > > > >>>> +
> > > > > > > > > > >>>>                 switch (sec_desc->sec_type) {
> > > > > > > > > > >>>>                 case SEC_DATA:
> > > > > > > > > > >>>>                         sec_name =3D elf_sec_name(=
obj, elf_sec_by_idx(obj, sec_idx));
> > > > > > > > > > >>>
> > > > > > > > > > >>> Ok, skeleton is now getting generated successfully,=
 however it differs from the
> > > > > > > > > > >>> clang version so there's a build error when we incl=
ude/use the header:
> > > > > > > > > > >>> ../src/core/restrict-ifaces.c: In function =E2=80=
=98prepare_restrict_ifaces_bpf=E2=80=99:
> > > > > > > > > > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=
=98struct
> > > > > > > > > > >>> restrict_ifaces_bpf=E2=80=99 has no member named =
=E2=80=98rodata=E2=80=99; did you mean
> > > > > > > > > > >>> =E2=80=98data=E2=80=99?
> > > > > > > > > > >>>    45 |         obj->rodata->is_allow_list =3D is_a=
llow_list;
> > > > > > > > > > >>>       |              ^~~~~~
> > > > > > > > > > >>>       |              data
> > > > > > > > > > >>>
> > > > > > > > > > >>> The issue appears to be that clang generates "rodat=
a" members in
> > > > > > > > > > >>> restrict_ifaces_bpf while with gcc we get "data" me=
mbers instead.
> > > > > > > > > > >>
> > > > > > > > > > >> This is because the BPF GCC port is putting the
> > > > > > > > > > >>
> > > > > > > > > > >>   const volatile unsigned char is_allow_list =3D 0;
> > > > > > > > > > >>
> > > > > > > > > > >> in a .data section instead of .rodata, due to the `v=
olatile'.  The
> > > > > > > > > > >> x86_64 GCC seems to use .rodata.
> > > > > > > > > > >>
> > > > > > > > > > >> Looking at why the PBF port does this...
> > > > > > > > > > >
> > > > > > > > > > > So, turns out GCC puts zero-initialized `const volati=
le' variables in
> > > > > > > > > > > .data sections (and not .rodata) in all the targets I=
 have tried, like
> > > > > > > > > > > x86_64 and aarch64.
> > > > > > > > > > >
> > > > > > > > > > > So this is a LLVM and GCC divergence :/
> > > > > > > > > >
> > > > > > > > > > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D2552=
1.
> > > > > > > > > >
> > > > > > > > > > You may try, as a workaround:
> > > > > > > > > >
> > > > > > > > > > __attribute__((section(".rodata"))) const volatile unsi=
gned char is_allow_list =3D 0;
> > > > > > > > > >
> > > > > > > > > > But that will use permissions "aw" for the .rodata sect=
ion (and you will
> > > > > > > > > > get a warning from the assembler.)  It may be problemat=
ic for libbpf.
> > > > > > > > >
> > > > > > > > > So rather than try to force gcc to use the incorrect llvm=
 .rodata
> > > > > > > > > section it looks
> > > > > > > > > like we can instead just force llvm to use the correct .d=
ata section like this:
> > > > > > > > > https://github.com/systemd/systemd/pull/24164
> > > > > > > > >
> > > > > > > >
> > > > > > > > There is a huge difference between variables in .rodata and=
 .data.
> > > > > > > > .rodata variable's value is known to the BPF verifier at ve=
rification
> > > > > > > > time and this knowledge will be used to decide which code p=
aths are
> > > > > > > > always or never taken (as one example). It's a crucial prop=
erty and
> > > > > > > > important guarantee.
> > > > > > > >
> > > > > > > > If you don't care about that property, don't declare the va=
riable as `const`.
> > > > > > > >
> > > > > > > > So no, it's not llvm putting `const` variable into .rodata
> > > > > > > > incorrectly, but GCC is trying to be smart and just because=
 variable
> > > > > > > > is declared volatile is putting *const* variable into read-=
write .data
> > > > > > > > section. It's declared as const, and yes it's volatile to m=
ake sure
> > > > > > > > that compiler isn't too smart about optimizing away read op=
erations.
> > > > > > >
> > > > > > > Isn't const volatile generating a .rodata section(like llvm i=
s doing) a spec
> > > > > > > violation?
> > > > > > > https://github.com/llvm/llvm-project/issues/56468
> > > > > > >
> > > > > > > > But it's still a const read-only variable from the perspect=
ive of that
> > > > > > > > BPF C code.
> > > > > > > >
> > > > > > > > If you don't care about the read-only nature of that variab=
le, drop
> > > > > > > > the const and make it into a non-read-only variable.
> > > > > > > >
> > > > > > > > And please stop proposing hacks to be added to perfectly va=
lid systemd
> > > > > > > > BPF source code (I replied on [0] as well).
> > > > > > >
> > > > > > > From my understanding gcc is correctly putting a const volati=
le variable
> > > > > > > in .data while llvm is incorrectly putting it in .rodata, is =
the gcc behavior
> > > > > > > here invalid or is the llvm behavior invalid?
> > > > > >
> > > > > > From link you left to C standard, it does seem like that side-n=
ote
> > > > > > *implies* that const volatile should be put into .data, but it'=
s a)
> > > > > > implied b) is quite arguable about assumptions that this data h=
as to
> > > > > > be in modifiable section, and c) entire CO-RE feature detection=
 and
> > > > > > guarding relies on having `const volatile` variables in .rodata=
 and
> > > > > > mark them as read-only for BPF verifier to allow dead code
> > > > > > elimination. Changing c) would break entire CO-RE ecosystem.
> > > > >
> > > > > Well it does appear that llvm is fixing the behavior to be in lin=
e with gcc:
> > > > > https://reviews.llvm.org/D131012
> > > > >
> > > > > >
> > > > > > Seems like this issue was raised by Ulrich Drepper back in 2005=
 ([0])
> > > > > > and he was also confused about GCC's behavior, btw.
> > > > > >
> > > > > > So either way, at the very least for BPF target we can't change=
 this
> > > > > > and I still think it's more logical to put const variables into
> > > > > > .rodata, regardless of side notes in C standard.
> > > > >
> > > > > GCC does put const variables in .rodata, just not const volatile =
variables.
> > > > >
> > > >
> > > > It's still const. Volatile doesn't change constness of a variable.
> > > > We've been discussing this over and over, it gets a bit tiring, tbh=
.
> > > >
> > > > Aaron Ballman seems to agree, quoting him from [0]:
> > > >
> > > >   The footnote cited isn't a normative requirement (I can't see any
> > > >   normative requirements that say we can't put a const volatile obj=
ect
> > > >   into a read only section), so it's debatable just how much of a b=
ug
> > > >   this is from a standards conformance perspective. I will have to
> > > >   inquire on the WG14 reflectors to see if there's something I've
> > > >   missed but I believe that C17 6.7.3p5 is meant to point out that
> > > >   only lvalue are qualified; rvalues are not because lvalue convers=
ion
> > > >   strips the qualifiers. I think the footnote is mostly a nod towar=
ds
> > > >   the fact that volatile qualified objects may change their value i=
n
> > > >   ways unknown to the compiler so storing it in a read-only section
> > > >   of memory is a bit questionable. But I'm curious if the committee
> > > >   tells me I've missed something there.
> > > >
> > > >
> > > >   [0] https://github.com/llvm/llvm-project/issues/56468#issuecommen=
t-1203146308
> > > >
> > > > > >
> > > > > >
> > > > > > As for systemd's program and its is_allow_list ([1]), to unbloc=
k
> > > > > > yourself you can drop const because systemd doesn't rely on rea=
d-only
> > > > > > guarantees of that variable anyways. It's much more critical in
> > > > > > feature-detection use cases. But let's try to converge discussi=
on in
> > > > > > one place (preferably here), it's quite inconvenient to either =
reply
> > > > > > the same thing twice here and on Github, or cross-reference lor=
e and
> > > > > > Github.
> > > > >
> > > > > Hmm, are you sure:
> > > > > const __u8 is_allow_list SEC(".rodata") =3D 0;
> > > > >
> > > > > doesn't provide equivalent behavior to:
> > > > > const volatile __u8 is_allow_list =3D 0;
> > > >
> > > > Is there anything preventing you from experimenting with this yours=
elf?..
> > >
> > > Wasn't sure how to reproduce the issue properly.
> > >
> >
> > Then please start asking specific questions about how to repro issues
> > we are talking about, instead of randomly throwing various ideas
> > around and seeing what sticks.
>
> I tested with the reproducer to see if any attribute based workarounds
> might avoid the need for volatile, and I didn't find anything.
>
> >
> > > >
> > > > Let's see:
> > > >
> > > > $ git diff
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > index 99dac5292b41..386785a45af0 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > @@ -31,6 +31,8 @@ void test_skeleton(void)
> > > >         if (CHECK(skel->kconfig, "skel_kconfig", "kconfig is mmaped=
()!\n"))
> > > >                 goto cleanup;
> > > >
> > > > +       skel->rodata->should_trap =3D false;
> > > > +
> > > >         bss =3D skel->bss;
> > > >         data =3D skel->data;
> > > >         data_dyn =3D skel->data_dyn;
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > index 1a4e93f6d9df..eee26bc82525 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > @@ -26,6 +26,8 @@ const volatile struct {
> > > >         const int in6;
> > > >  } in =3D {};
> > > >
> > > > +const bool should_trap SEC(".rodata") =3D true;
> > > > +
> > > >  /* .data section */
> > > >  int out1 =3D -1;
> > > >  long long out2 =3D -1;
> > > > @@ -58,6 +60,10 @@ int handler(const void *ctx)
> > > >  {
> > > >         int i;
> > > >
> > > > +       while (should_trap)
> > > > +       {
> > > > +       }
> > > > +
> > > >         out1 =3D in1;
> > > >         out2 =3D in2;
> > > >         out3 =3D in3;
> > > >
> > > >
> > > > Result: selftests stop compiling. Why?
> > > >
> > > > $ llvm-objdump -d test_skeleton.linked1.o
> > > >
> > > > test_skeleton.linked1.o:        file format elf64-bpf
> > > >
> > > > Disassembly of section raw_tp/sys_enter:
> > > >
> > > > 0000000000000000 <handler>:
> > > >        0:       05 00 ff ff 00 00 00 00 goto -1 <handler>
> > > >
> > > > Because compiler optimized away everything with while (true) {}. Th=
ere
> > > > is no global data at all anymore.
> > > >
> > > > This is what I keep telling you, const volatile is the only thing
> > > > preventing the compiler from making wrong assumptions. And neither
> > > >
> > > > const bool should_trap SEC(".rodata") =3D true;
> > > >
> > > > nor
> > > >
> > > > const bool should_trap =3D true;
> > > >
> > > > work.
> > > >
> > > > But
> > > >
> > > > const volatile bool should_trap =3D true;
> > > >
> > > > does work.
> > > >
> > > > If you have some more speculative proposals, please investigate the=
m
> > > > yourself and report back with the results. But either way there is =
a
> > > > lot of BPF code written with reliance on `const volatile`, both ope=
n
> > > > source and not, so please stop actively trying to break BPF ecosyst=
em
> > > > with proposals like moving `const volatile` to .data, just because
> > > > it's more convenient for you in GCC. Thank you.
> > >
> > > So it does at least seem I can force GCC to use .rodata like this for
> > > systemd, maybe that's the best approach for now?:
> > >
> > > const volatile __u8 is_allow_list SEC(".rodata") =3D 0;
> > >
> > > It does emit an assembler warning but otherwise appears to work:
> > > Generating src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstrippe=
d.o
> > > with a custom command
> > > /tmp/ccM2b7jP.s: Assembler messages:
> > > /tmp/ccM2b7jP.s:87: Warning: setting incorrect section attributes for=
 .rodata
> > >
> > > I updated my systemd PR with that.
> > >
> >
> > For Nth time, don't do this. Drop the const for systemd. And please
> > start paying attention to feedback.
>
> Well I was looking for a more general solution for behavior convergence,
> I posted here to see if that was a workable option to get both compilers
> to behave the same for cases where we want the variable to be in
> .rodata. I had also updated the pull request to make it easier to get
> feedback on that approach.

I've opened a pull request reverting this:
https://github.com/systemd/systemd/pull/24881

GCC const volatile .rodata section behavior should now match LLVM/clang.

Details:
https://github.com/gcc-mirror/gcc/commit/a0aafbc324aa90421f0ce99c6f5bbf64ed=
163da6

>
> I guess a developer at your company approved the PR already and
> it got merged.
>
> >
> > Please also start with learning how to build selftests/bpf with Clang
> > and looking at various examples so that you can at least look at all
> > the different features we rely on in the BPF world, instead of trying
> > to tune one small piece (systemd's BPF programs) to your liking. If
> > you are serious about making GCC BPF backend viable, you'll have to
> > understand BPF a bit better.
>
> I did do that for both clang and gcc, I've been fixing issues I discovere=
d
> like this one for example when trying to build tests with gcc:
> https://lore.kernel.org/bpf/20220803151403.793024-1-james.hilliard1@gmail=
.com/
>
> >
> > That would be a better use of everyone's time, instead of you going
> > behind our backs and requesting Clang to break the entire BPF
> > ecosystem just because GCC is doing something differently, like you
> > and Jose E. Marchesi did with [0] and [1].
>
> The behavior divergence here appears to predate BPF support in both
> compilers from my understanding, the issue is being discussed in both
> GCC and llvm issue trackers to try and figure out what the best way to
> get behavior convergence would be, seems to make sense to me to
> have this issue tracked by llvm and GCC.
>
> Explicitly setting the section seemed like it might be a good approach so
> that in the event llvm did change the default things would still work the
> same way.
>
> I don't think anyone is trying to go behind anyone's back here...I've tri=
ed
> to cross reference issues in general so that everyone is aware of all the
> discussions.
>
> >
> >   [0] https://github.com/llvm/llvm-project/issues/56468
> >   [1] https://reviews.llvm.org/D131012
> >
> > > >
> > > > >
> > > > > The used attribute in the SEC macro supposedly ensures that:
> > > > > The compiler must emit the definition even if it appears to be un=
used, and
> > > > > it must not apply optimizations which depend on fully understandi=
ng how
> > > > > the entity is used.
> > > > >
> > > > > Or maybe the retain attribute along with used would be sufficient=
 to allow
> > > > > us to drop volatile in these cases?:
> > > > > https://clang.llvm.org/docs/AttributeReference.html#retain
> > > > >
> > > > > >
> > > > > >
> > > > > >   [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521
> > > > > >   [1] https://github.com/systemd/systemd/pull/24164#issuecommen=
t-1203207372
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >   [0] https://github.com/systemd/systemd/pull/24164#issueco=
mment-1201806413
> > > > > > > >
> > > > > > > >
> > > > > > > > [...]
