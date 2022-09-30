Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A25F1655
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiI3Wuj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiI3Wuh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:50:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D0FA0CF
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:50:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lh5so11811000ejb.10
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBT2gfDDSt8SL+ogFKh8iiDPgvYMqByI85mqfzc5LNk=;
        b=M2VjFFQ+nCBxh5/L91oeKcfQRFy9Q+998t8oo+zymC5YOGxe2AR68sjAIbw7kR5buS
         b4odkZ9wZGKAAKWd1VfkVOhwPWfNlnWNbtlIPp4gBxeCc16rP7xlGL8WQludOv69JgM7
         bWXpq6O1YKp6Kk+4h4KxNOCWhvbM8YXDiKHZB2C4kOyuMzsc0BwcgyB58LkXYqJqgeaJ
         79hb7796GgzLqMOOpzy+X8brI6MY/UuxztRBvPn9gRLMF9H/vwYp7EjSyt34I/5rySCP
         6G0q4vti7D6fM7sJK0xv/Vyyz33edfOdAjyh9Z9s40R+rUzNjDJe+km6QPXxOt8NEBNW
         j7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBT2gfDDSt8SL+ogFKh8iiDPgvYMqByI85mqfzc5LNk=;
        b=o34Kak1sEylik0XAQPpuHge4ggJw73KY3rvWZqpeXin+ohCbGeKDH2mxOPJNYBJ22a
         58+6c8EAOt1Jcf9eSyV1OrkUkkNSRFFrBl6SYxy7I6VtZQXJdbzRgMWYdjYdVBb0Z8SL
         nA8fNczWtotyPsiBsjX23Ph7JM7p6eQvj3Y298iIufytoxg+Ji/SWdt2KcpZuIOBhj7y
         KyjMkKop1chR35RNXx/y4qV7rCstEJR1nieTF2NuJ3xZus68CmPWt61jsgza50pd/ZND
         qX7HdigmrfENhUV7KoOMRr+CnARD1Dkyr6kfoHlLxlgZ9MWKemzs5u1U7mmnezYT5ggf
         1nZg==
X-Gm-Message-State: ACrzQf09Z/qn4GgaAhb5Am8v68JxpDSKdMTgtfZrd1Rcs/LDeV2mEc2+
        BpScPC7WgMoeaVGAIF3fGJMQW8Bt2yjsv/wCcJB/S0pu
X-Google-Smtp-Source: AMsMyM5V1fmIvlun2jtRx82i0h/nqGsigREf9DdOIDa2+6pSkhLiW0OQeYoFsR0Zf+hNqsH9OovDkgxFAfijc08EgCU=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr7852419ejc.545.1664578233659; Fri, 30
 Sep 2022 15:50:33 -0700 (PDT)
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
 <CAEf4Bza0-dx=X01ZqzLR_SF6-6r9YZFQa=VLyD6H=0DnLCU1AQ@mail.gmail.com>
 <CADvTj4oUMQL2hni0grtAumZAbK5_uxrVW-gZ9wju=Y8ba1WZhg@mail.gmail.com> <CADvTj4r_CTPyPp9vGO5MkgA9FX5i-eWciNes+Tiq1bds5LSHsw@mail.gmail.com>
In-Reply-To: <CADvTj4r_CTPyPp9vGO5MkgA9FX5i-eWciNes+Tiq1bds5LSHsw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:50:21 -0700
Message-ID: <CAEf4Bzaqw7xtGJ2sW0O2PaVzHxvi0r51PNRhquD7QHorDEHrBg@mail.gmail.com>
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

On Fri, Sep 30, 2022 at 2:52 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Wed, Aug 3, 2022 at 3:24 PM James Hilliard <james.hilliard1@gmail.com>=
 wrote:
> >
> > On Wed, Aug 3, 2022 at 10:57 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 2, 2022 at 6:49 PM James Hilliard <james.hilliard1@gmail.=
com> wrote:
> > > >
> > > > On Tue, Aug 2, 2022 at 6:29 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Tue, Aug 2, 2022 at 3:06 PM James Hilliard <james.hilliard1@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 2, 2022 at 3:29 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 1, 2022 at 4:35 PM James Hilliard <james.hilliard=
1@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 1, 2022 at 4:52 PM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
> > > > > > > > > <james.hilliard1@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> > > > > > > > > > <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > > > > > > > > > > >>> <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marches=
i
> > > > > > > > > > > >>>> > <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > > >>>> >>
> > > > > > > > > > > >>>> >>
> > > > > > > > > > > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hillia=
rd <james.hilliard1@gmail.com> wrote:
> > > > > > > > > > > >>>> >> >>
> > > > > > > > > > > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Mar=
chesi
> > > > > > > > > > > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > > > > > > > > > > >>>> >> >> >
> > > > > > > > > > > >>>> >> >> >
> > > > > > > > >
> > > > > > > > > Please trim your replies (and I don't know what your emai=
l client did,
> > > > > > > > > but it completely ruined nested quote formatting)
> > > > > > > >
> > > > > > > > Yeah, not sure what happened there.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/=
bpf/libbpf.c
> > > > > > > > > > > >>>> index e89cc9c885b3..887b78780099 100644
> > > > > > > > > > > >>>> --- a/tools/lib/bpf/libbpf.c
> > > > > > > > > > > >>>> +++ b/tools/lib/bpf/libbpf.c
> > > > > > > > > > > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__in=
it_global_data_maps(struct bpf_object *obj)
> > > > > > > > > > > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile=
.sec_cnt; sec_idx++) {
> > > > > > > > > > > >>>>                 sec_desc =3D &obj->efile.secs[se=
c_idx];
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> +                /* Skip recognized sections wit=
h size 0.  */
> > > > > > > > > > > >>>> +                if (sec_desc->data && sec_desc-=
>data->d_size =3D=3D 0)
> > > > > > > > > > > >>>> +                  continue;
> > > > > > > > > > > >>>> +
> > > > > > > > > > > >>>>                 switch (sec_desc->sec_type) {
> > > > > > > > > > > >>>>                 case SEC_DATA:
> > > > > > > > > > > >>>>                         sec_name =3D elf_sec_nam=
e(obj, elf_sec_by_idx(obj, sec_idx));
> > > > > > > > > > > >>>
> > > > > > > > > > > >>> Ok, skeleton is now getting generated successfull=
y, however it differs from the
> > > > > > > > > > > >>> clang version so there's a build error when we in=
clude/use the header:
> > > > > > > > > > > >>> ../src/core/restrict-ifaces.c: In function =E2=80=
=98prepare_restrict_ifaces_bpf=E2=80=99:
> > > > > > > > > > > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=
=80=98struct
> > > > > > > > > > > >>> restrict_ifaces_bpf=E2=80=99 has no member named =
=E2=80=98rodata=E2=80=99; did you mean
> > > > > > > > > > > >>> =E2=80=98data=E2=80=99?
> > > > > > > > > > > >>>    45 |         obj->rodata->is_allow_list =3D is=
_allow_list;
> > > > > > > > > > > >>>       |              ^~~~~~
> > > > > > > > > > > >>>       |              data
> > > > > > > > > > > >>>
> > > > > > > > > > > >>> The issue appears to be that clang generates "rod=
ata" members in
> > > > > > > > > > > >>> restrict_ifaces_bpf while with gcc we get "data" =
members instead.
> > > > > > > > > > > >>
> > > > > > > > > > > >> This is because the BPF GCC port is putting the
> > > > > > > > > > > >>
> > > > > > > > > > > >>   const volatile unsigned char is_allow_list =3D 0=
;
> > > > > > > > > > > >>
> > > > > > > > > > > >> in a .data section instead of .rodata, due to the =
`volatile'.  The
> > > > > > > > > > > >> x86_64 GCC seems to use .rodata.
> > > > > > > > > > > >>
> > > > > > > > > > > >> Looking at why the PBF port does this...
> > > > > > > > > > > >
> > > > > > > > > > > > So, turns out GCC puts zero-initialized `const vola=
tile' variables in
> > > > > > > > > > > > .data sections (and not .rodata) in all the targets=
 I have tried, like
> > > > > > > > > > > > x86_64 and aarch64.
> > > > > > > > > > > >
> > > > > > > > > > > > So this is a LLVM and GCC divergence :/
> > > > > > > > > > >
> > > > > > > > > > > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25=
521.
> > > > > > > > > > >
> > > > > > > > > > > You may try, as a workaround:
> > > > > > > > > > >
> > > > > > > > > > > __attribute__((section(".rodata"))) const volatile un=
signed char is_allow_list =3D 0;
> > > > > > > > > > >
> > > > > > > > > > > But that will use permissions "aw" for the .rodata se=
ction (and you will
> > > > > > > > > > > get a warning from the assembler.)  It may be problem=
atic for libbpf.
> > > > > > > > > >
> > > > > > > > > > So rather than try to force gcc to use the incorrect ll=
vm .rodata
> > > > > > > > > > section it looks
> > > > > > > > > > like we can instead just force llvm to use the correct =
.data section like this:
> > > > > > > > > > https://github.com/systemd/systemd/pull/24164
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > There is a huge difference between variables in .rodata a=
nd .data.
> > > > > > > > > .rodata variable's value is known to the BPF verifier at =
verification
> > > > > > > > > time and this knowledge will be used to decide which code=
 paths are
> > > > > > > > > always or never taken (as one example). It's a crucial pr=
operty and
> > > > > > > > > important guarantee.
> > > > > > > > >
> > > > > > > > > If you don't care about that property, don't declare the =
variable as `const`.
> > > > > > > > >
> > > > > > > > > So no, it's not llvm putting `const` variable into .rodat=
a
> > > > > > > > > incorrectly, but GCC is trying to be smart and just becau=
se variable
> > > > > > > > > is declared volatile is putting *const* variable into rea=
d-write .data
> > > > > > > > > section. It's declared as const, and yes it's volatile to=
 make sure
> > > > > > > > > that compiler isn't too smart about optimizing away read =
operations.
> > > > > > > >
> > > > > > > > Isn't const volatile generating a .rodata section(like llvm=
 is doing) a spec
> > > > > > > > violation?
> > > > > > > > https://github.com/llvm/llvm-project/issues/56468
> > > > > > > >
> > > > > > > > > But it's still a const read-only variable from the perspe=
ctive of that
> > > > > > > > > BPF C code.
> > > > > > > > >
> > > > > > > > > If you don't care about the read-only nature of that vari=
able, drop
> > > > > > > > > the const and make it into a non-read-only variable.
> > > > > > > > >
> > > > > > > > > And please stop proposing hacks to be added to perfectly =
valid systemd
> > > > > > > > > BPF source code (I replied on [0] as well).
> > > > > > > >
> > > > > > > > From my understanding gcc is correctly putting a const vola=
tile variable
> > > > > > > > in .data while llvm is incorrectly putting it in .rodata, i=
s the gcc behavior
> > > > > > > > here invalid or is the llvm behavior invalid?
> > > > > > >
> > > > > > > From link you left to C standard, it does seem like that side=
-note
> > > > > > > *implies* that const volatile should be put into .data, but i=
t's a)
> > > > > > > implied b) is quite arguable about assumptions that this data=
 has to
> > > > > > > be in modifiable section, and c) entire CO-RE feature detecti=
on and
> > > > > > > guarding relies on having `const volatile` variables in .roda=
ta and
> > > > > > > mark them as read-only for BPF verifier to allow dead code
> > > > > > > elimination. Changing c) would break entire CO-RE ecosystem.
> > > > > >
> > > > > > Well it does appear that llvm is fixing the behavior to be in l=
ine with gcc:
> > > > > > https://reviews.llvm.org/D131012
> > > > > >
> > > > > > >
> > > > > > > Seems like this issue was raised by Ulrich Drepper back in 20=
05 ([0])
> > > > > > > and he was also confused about GCC's behavior, btw.
> > > > > > >
> > > > > > > So either way, at the very least for BPF target we can't chan=
ge this
> > > > > > > and I still think it's more logical to put const variables in=
to
> > > > > > > .rodata, regardless of side notes in C standard.
> > > > > >
> > > > > > GCC does put const variables in .rodata, just not const volatil=
e variables.
> > > > > >
> > > > >
> > > > > It's still const. Volatile doesn't change constness of a variable=
.
> > > > > We've been discussing this over and over, it gets a bit tiring, t=
bh.
> > > > >
> > > > > Aaron Ballman seems to agree, quoting him from [0]:
> > > > >
> > > > >   The footnote cited isn't a normative requirement (I can't see a=
ny
> > > > >   normative requirements that say we can't put a const volatile o=
bject
> > > > >   into a read only section), so it's debatable just how much of a=
 bug
> > > > >   this is from a standards conformance perspective. I will have t=
o
> > > > >   inquire on the WG14 reflectors to see if there's something I've
> > > > >   missed but I believe that C17 6.7.3p5 is meant to point out tha=
t
> > > > >   only lvalue are qualified; rvalues are not because lvalue conve=
rsion
> > > > >   strips the qualifiers. I think the footnote is mostly a nod tow=
ards
> > > > >   the fact that volatile qualified objects may change their value=
 in
> > > > >   ways unknown to the compiler so storing it in a read-only secti=
on
> > > > >   of memory is a bit questionable. But I'm curious if the committ=
ee
> > > > >   tells me I've missed something there.
> > > > >
> > > > >
> > > > >   [0] https://github.com/llvm/llvm-project/issues/56468#issuecomm=
ent-1203146308
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > As for systemd's program and its is_allow_list ([1]), to unbl=
ock
> > > > > > > yourself you can drop const because systemd doesn't rely on r=
ead-only
> > > > > > > guarantees of that variable anyways. It's much more critical =
in
> > > > > > > feature-detection use cases. But let's try to converge discus=
sion in
> > > > > > > one place (preferably here), it's quite inconvenient to eithe=
r reply
> > > > > > > the same thing twice here and on Github, or cross-reference l=
ore and
> > > > > > > Github.
> > > > > >
> > > > > > Hmm, are you sure:
> > > > > > const __u8 is_allow_list SEC(".rodata") =3D 0;
> > > > > >
> > > > > > doesn't provide equivalent behavior to:
> > > > > > const volatile __u8 is_allow_list =3D 0;
> > > > >
> > > > > Is there anything preventing you from experimenting with this you=
rself?..
> > > >
> > > > Wasn't sure how to reproduce the issue properly.
> > > >
> > >
> > > Then please start asking specific questions about how to repro issues
> > > we are talking about, instead of randomly throwing various ideas
> > > around and seeing what sticks.
> >
> > I tested with the reproducer to see if any attribute based workarounds
> > might avoid the need for volatile, and I didn't find anything.
> >
> > >
> > > > >
> > > > > Let's see:
> > > > >
> > > > > $ git diff
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > > b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > > index 99dac5292b41..386785a45af0 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> > > > > @@ -31,6 +31,8 @@ void test_skeleton(void)
> > > > >         if (CHECK(skel->kconfig, "skel_kconfig", "kconfig is mmap=
ed()!\n"))
> > > > >                 goto cleanup;
> > > > >
> > > > > +       skel->rodata->should_trap =3D false;
> > > > > +
> > > > >         bss =3D skel->bss;
> > > > >         data =3D skel->data;
> > > > >         data_dyn =3D skel->data_dyn;
> > > > > diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > > b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > > index 1a4e93f6d9df..eee26bc82525 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > > > > @@ -26,6 +26,8 @@ const volatile struct {
> > > > >         const int in6;
> > > > >  } in =3D {};
> > > > >
> > > > > +const bool should_trap SEC(".rodata") =3D true;
> > > > > +
> > > > >  /* .data section */
> > > > >  int out1 =3D -1;
> > > > >  long long out2 =3D -1;
> > > > > @@ -58,6 +60,10 @@ int handler(const void *ctx)
> > > > >  {
> > > > >         int i;
> > > > >
> > > > > +       while (should_trap)
> > > > > +       {
> > > > > +       }
> > > > > +
> > > > >         out1 =3D in1;
> > > > >         out2 =3D in2;
> > > > >         out3 =3D in3;
> > > > >
> > > > >
> > > > > Result: selftests stop compiling. Why?
> > > > >
> > > > > $ llvm-objdump -d test_skeleton.linked1.o
> > > > >
> > > > > test_skeleton.linked1.o:        file format elf64-bpf
> > > > >
> > > > > Disassembly of section raw_tp/sys_enter:
> > > > >
> > > > > 0000000000000000 <handler>:
> > > > >        0:       05 00 ff ff 00 00 00 00 goto -1 <handler>
> > > > >
> > > > > Because compiler optimized away everything with while (true) {}. =
There
> > > > > is no global data at all anymore.
> > > > >
> > > > > This is what I keep telling you, const volatile is the only thing
> > > > > preventing the compiler from making wrong assumptions. And neithe=
r
> > > > >
> > > > > const bool should_trap SEC(".rodata") =3D true;
> > > > >
> > > > > nor
> > > > >
> > > > > const bool should_trap =3D true;
> > > > >
> > > > > work.
> > > > >
> > > > > But
> > > > >
> > > > > const volatile bool should_trap =3D true;
> > > > >
> > > > > does work.
> > > > >
> > > > > If you have some more speculative proposals, please investigate t=
hem
> > > > > yourself and report back with the results. But either way there i=
s a
> > > > > lot of BPF code written with reliance on `const volatile`, both o=
pen
> > > > > source and not, so please stop actively trying to break BPF ecosy=
stem
> > > > > with proposals like moving `const volatile` to .data, just becaus=
e
> > > > > it's more convenient for you in GCC. Thank you.
> > > >
> > > > So it does at least seem I can force GCC to use .rodata like this f=
or
> > > > systemd, maybe that's the best approach for now?:
> > > >
> > > > const volatile __u8 is_allow_list SEC(".rodata") =3D 0;
> > > >
> > > > It does emit an assembler warning but otherwise appears to work:
> > > > Generating src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstrip=
ped.o
> > > > with a custom command
> > > > /tmp/ccM2b7jP.s: Assembler messages:
> > > > /tmp/ccM2b7jP.s:87: Warning: setting incorrect section attributes f=
or .rodata
> > > >
> > > > I updated my systemd PR with that.
> > > >
> > >
> > > For Nth time, don't do this. Drop the const for systemd. And please
> > > start paying attention to feedback.
> >
> > Well I was looking for a more general solution for behavior convergence=
,
> > I posted here to see if that was a workable option to get both compiler=
s
> > to behave the same for cases where we want the variable to be in
> > .rodata. I had also updated the pull request to make it easier to get
> > feedback on that approach.
>
> I've opened a pull request reverting this:
> https://github.com/systemd/systemd/pull/24881
>
> GCC const volatile .rodata section behavior should now match LLVM/clang.
>
> Details:
> https://github.com/gcc-mirror/gcc/commit/a0aafbc324aa90421f0ce99c6f5bbf64=
ed163da6
>

Great, thanks! Approved systemd PR (FWIW).

> >
> > I guess a developer at your company approved the PR already and
> > it got merged.
> >
> > >
> > > Please also start with learning how to build selftests/bpf with Clang
> > > and looking at various examples so that you can at least look at all
> > > the different features we rely on in the BPF world, instead of trying
> > > to tune one small piece (systemd's BPF programs) to your liking. If
> > > you are serious about making GCC BPF backend viable, you'll have to
> > > understand BPF a bit better.
> >
> > I did do that for both clang and gcc, I've been fixing issues I discove=
red
> > like this one for example when trying to build tests with gcc:
> > https://lore.kernel.org/bpf/20220803151403.793024-1-james.hilliard1@gma=
il.com/
> >
> > >
> > > That would be a better use of everyone's time, instead of you going
> > > behind our backs and requesting Clang to break the entire BPF
> > > ecosystem just because GCC is doing something differently, like you
> > > and Jose E. Marchesi did with [0] and [1].
> >
> > The behavior divergence here appears to predate BPF support in both
> > compilers from my understanding, the issue is being discussed in both
> > GCC and llvm issue trackers to try and figure out what the best way to
> > get behavior convergence would be, seems to make sense to me to
> > have this issue tracked by llvm and GCC.
> >
> > Explicitly setting the section seemed like it might be a good approach =
so
> > that in the event llvm did change the default things would still work t=
he
> > same way.
> >
> > I don't think anyone is trying to go behind anyone's back here...I've t=
ried
> > to cross reference issues in general so that everyone is aware of all t=
he
> > discussions.
> >
> > >
> > >   [0] https://github.com/llvm/llvm-project/issues/56468
> > >   [1] https://reviews.llvm.org/D131012
> > >
> > > > >
> > > > > >
> > > > > > The used attribute in the SEC macro supposedly ensures that:
> > > > > > The compiler must emit the definition even if it appears to be =
unused, and
> > > > > > it must not apply optimizations which depend on fully understan=
ding how
> > > > > > the entity is used.
> > > > > >
> > > > > > Or maybe the retain attribute along with used would be sufficie=
nt to allow
> > > > > > us to drop volatile in these cases?:
> > > > > > https://clang.llvm.org/docs/AttributeReference.html#retain
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >   [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521
> > > > > > >   [1] https://github.com/systemd/systemd/pull/24164#issuecomm=
ent-1203207372
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >   [0] https://github.com/systemd/systemd/pull/24164#issue=
comment-1201806413
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > [...]
