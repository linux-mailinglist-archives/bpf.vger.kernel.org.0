Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FE5883DA
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHBWGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiHBWGN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:06:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2012AE7
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:06:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w7so14655243ply.12
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=B0o0xK5l4zN30wGQ9QJCO+bFioUFcDi2K2HiZZc9utQ=;
        b=JoYhaWGpWj1f9ft9yCDHT0vr48Ftz4lWB+PrbSctwjVLQSx1TpT5QR3K4XB38zOj0Y
         wd5gbVxFhJnushYBdGwUwqiG/1A2Lyv3y+XI1dDkvNmhOUogZWKjKq+BOGjEQrwNydfe
         J/b7shm7C/QKxpNnlaEB6EcEeHegj6wAGsRJWt04LLDCgtHxC1B644DgNmabo/V8h4oH
         0C2JEZ5DLkiCfs8gokyV9meyXd7xDqDfT0Lvdr7EoF9H6B/rKlV7mVsc3dzrH0Iz34fx
         fUMiqu7rIMqQfmbd2f10X7HVFgun2675MwCuFOMUlr+ndkg6Q0Kem6J3unJN86pCD7NA
         Wilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=B0o0xK5l4zN30wGQ9QJCO+bFioUFcDi2K2HiZZc9utQ=;
        b=wk/c1PLZqhSPfUNk6pY4iolPrq/yM5rDd/netidVo2e3I6kCxscCFO7nbMDXV6Ql3e
         8K0+eUIshHYb3yVFNZ43WBpKiJBIlEJvIV1fGd5R/c5z9bc9M8ewOsiL4ARiC4F6NRy0
         X5XBwcseBDtv4c1WxwG+26EMJXVHDWbUFE6Whejj8SzkfATyY/wViDZHWw6CAAgcOvdm
         BpJnlGheOQnDRtVFF3zJSctj+tKSrewETL6Y629pgxIHhET//c8VWoVoluGqi9hzkePk
         Sfq/e8eZI4isQ6z/i+6Lwq+UwyNXjqcFm2lNBY5i4eBMmIg70Dej0xEHYxJrJM4KXPhA
         k89A==
X-Gm-Message-State: ACgBeo14tKd67Pgvmb9R0/QGD9iDjpF4kAlN573qYhsbX4vFFlTqsdUD
        qVtSRSMNhE/tlPijpbz6krKoK26+AuMaU2FJiksRBm9qruh/Rw==
X-Google-Smtp-Source: AA6agR6pzi+qaeCWZsyOrOOKEBg9pgcrpSQCGHzZRdirlGQUC9Y47D3VQIzCVY1XncBj4rYcSAuYUy4AW91OfGYpfP4=
X-Received: by 2002:a17:903:40c4:b0:16d:d2a9:43ae with SMTP id
 t4-20020a17090340c400b0016dd2a943aemr21937245pld.57.1659477970936; Tue, 02
 Aug 2022 15:06:10 -0700 (PDT)
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
 <CADvTj4qi_ZZhdXRPd0X_tgQ8-jgrRgxF+4+kYVA92ZMO8KqESA@mail.gmail.com> <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com>
In-Reply-To: <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Tue, 2 Aug 2022 16:05:58 -0600
Message-ID: <CADvTj4oSc646ebcWzXB65gSy144D+GikbT5eF38OHu+T5tbn-w@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 3:29 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 4:35 PM James Hilliard <james.hilliard1@gmail.com>=
 wrote:
> >
> > On Mon, Aug 1, 2022 at 4:52 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > >
> > > > On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> > > > <jose.marchesi@oracle.com> wrote:
> > > > >
> > > > >
> > > > > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > > > > >>> <jose.marchesi@oracle.com> wrote:
> > > > > >>>>
> > > > > >>>>
> > > > > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
> > > > > >>>> > <jose.marchesi@oracle.com> wrote:
> > > > > >>>> >>
> > > > > >>>> >>
> > > > > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hi=
lliard1@gmail.com> wrote:
> > > > > >>>> >> >>
> > > > > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
> > > > > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > > > > >>>> >> >> >
> > > > > >>>> >> >> >
> > >
> > > Please trim your replies (and I don't know what your email client did=
,
> > > but it completely ruined nested quote formatting)
> >
> > Yeah, not sure what happened there.
> >
> > >
> > > [...]
> > >
> > > > > >>>>
> > > > > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > >>>> index e89cc9c885b3..887b78780099 100644
> > > > > >>>> --- a/tools/lib/bpf/libbpf.c
> > > > > >>>> +++ b/tools/lib/bpf/libbpf.c
> > > > > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_da=
ta_maps(struct bpf_object *obj)
> > > > > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; se=
c_idx++) {
> > > > > >>>>                 sec_desc =3D &obj->efile.secs[sec_idx];
> > > > > >>>>
> > > > > >>>> +                /* Skip recognized sections with size 0.  *=
/
> > > > > >>>> +                if (sec_desc->data && sec_desc->data->d_siz=
e =3D=3D 0)
> > > > > >>>> +                  continue;
> > > > > >>>> +
> > > > > >>>>                 switch (sec_desc->sec_type) {
> > > > > >>>>                 case SEC_DATA:
> > > > > >>>>                         sec_name =3D elf_sec_name(obj, elf_s=
ec_by_idx(obj, sec_idx));
> > > > > >>>
> > > > > >>> Ok, skeleton is now getting generated successfully, however i=
t differs from the
> > > > > >>> clang version so there's a build error when we include/use th=
e header:
> > > > > >>> ../src/core/restrict-ifaces.c: In function =E2=80=98prepare_r=
estrict_ifaces_bpf=E2=80=99:
> > > > > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=98struct
> > > > > >>> restrict_ifaces_bpf=E2=80=99 has no member named =E2=80=98rod=
ata=E2=80=99; did you mean
> > > > > >>> =E2=80=98data=E2=80=99?
> > > > > >>>    45 |         obj->rodata->is_allow_list =3D is_allow_list;
> > > > > >>>       |              ^~~~~~
> > > > > >>>       |              data
> > > > > >>>
> > > > > >>> The issue appears to be that clang generates "rodata" members=
 in
> > > > > >>> restrict_ifaces_bpf while with gcc we get "data" members inst=
ead.
> > > > > >>
> > > > > >> This is because the BPF GCC port is putting the
> > > > > >>
> > > > > >>   const volatile unsigned char is_allow_list =3D 0;
> > > > > >>
> > > > > >> in a .data section instead of .rodata, due to the `volatile'. =
 The
> > > > > >> x86_64 GCC seems to use .rodata.
> > > > > >>
> > > > > >> Looking at why the PBF port does this...
> > > > > >
> > > > > > So, turns out GCC puts zero-initialized `const volatile' variab=
les in
> > > > > > .data sections (and not .rodata) in all the targets I have trie=
d, like
> > > > > > x86_64 and aarch64.
> > > > > >
> > > > > > So this is a LLVM and GCC divergence :/
> > > > >
> > > > > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521.
> > > > >
> > > > > You may try, as a workaround:
> > > > >
> > > > > __attribute__((section(".rodata"))) const volatile unsigned char =
is_allow_list =3D 0;
> > > > >
> > > > > But that will use permissions "aw" for the .rodata section (and y=
ou will
> > > > > get a warning from the assembler.)  It may be problematic for lib=
bpf.
> > > >
> > > > So rather than try to force gcc to use the incorrect llvm .rodata
> > > > section it looks
> > > > like we can instead just force llvm to use the correct .data sectio=
n like this:
> > > > https://github.com/systemd/systemd/pull/24164
> > > >
> > >
> > > There is a huge difference between variables in .rodata and .data.
> > > .rodata variable's value is known to the BPF verifier at verification
> > > time and this knowledge will be used to decide which code paths are
> > > always or never taken (as one example). It's a crucial property and
> > > important guarantee.
> > >
> > > If you don't care about that property, don't declare the variable as =
`const`.
> > >
> > > So no, it's not llvm putting `const` variable into .rodata
> > > incorrectly, but GCC is trying to be smart and just because variable
> > > is declared volatile is putting *const* variable into read-write .dat=
a
> > > section. It's declared as const, and yes it's volatile to make sure
> > > that compiler isn't too smart about optimizing away read operations.
> >
> > Isn't const volatile generating a .rodata section(like llvm is doing) a=
 spec
> > violation?
> > https://github.com/llvm/llvm-project/issues/56468
> >
> > > But it's still a const read-only variable from the perspective of tha=
t
> > > BPF C code.
> > >
> > > If you don't care about the read-only nature of that variable, drop
> > > the const and make it into a non-read-only variable.
> > >
> > > And please stop proposing hacks to be added to perfectly valid system=
d
> > > BPF source code (I replied on [0] as well).
> >
> > From my understanding gcc is correctly putting a const volatile variabl=
e
> > in .data while llvm is incorrectly putting it in .rodata, is the gcc be=
havior
> > here invalid or is the llvm behavior invalid?
>
> From link you left to C standard, it does seem like that side-note
> *implies* that const volatile should be put into .data, but it's a)
> implied b) is quite arguable about assumptions that this data has to
> be in modifiable section, and c) entire CO-RE feature detection and
> guarding relies on having `const volatile` variables in .rodata and
> mark them as read-only for BPF verifier to allow dead code
> elimination. Changing c) would break entire CO-RE ecosystem.

Well it does appear that llvm is fixing the behavior to be in line with gcc=
:
https://reviews.llvm.org/D131012

>
> Seems like this issue was raised by Ulrich Drepper back in 2005 ([0])
> and he was also confused about GCC's behavior, btw.
>
> So either way, at the very least for BPF target we can't change this
> and I still think it's more logical to put const variables into
> .rodata, regardless of side notes in C standard.

GCC does put const variables in .rodata, just not const volatile variables.

>
>
> As for systemd's program and its is_allow_list ([1]), to unblock
> yourself you can drop const because systemd doesn't rely on read-only
> guarantees of that variable anyways. It's much more critical in
> feature-detection use cases. But let's try to converge discussion in
> one place (preferably here), it's quite inconvenient to either reply
> the same thing twice here and on Github, or cross-reference lore and
> Github.

Hmm, are you sure:
const __u8 is_allow_list SEC(".rodata") =3D 0;

doesn't provide equivalent behavior to:
const volatile __u8 is_allow_list =3D 0;

The used attribute in the SEC macro supposedly ensures that:
The compiler must emit the definition even if it appears to be unused, and
it must not apply optimizations which depend on fully understanding how
the entity is used.

Or maybe the retain attribute along with used would be sufficient to allow
us to drop volatile in these cases?:
https://clang.llvm.org/docs/AttributeReference.html#retain

>
>
>   [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521
>   [1] https://github.com/systemd/systemd/pull/24164#issuecomment-12032073=
72
>
> >
> > >
> > >   [0] https://github.com/systemd/systemd/pull/24164#issuecomment-1201=
806413
> > >
> > >
> > > [...]
