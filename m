Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADB58838E
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiHBV3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 17:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiHBV3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 17:29:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B960FF
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 14:29:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e13so270374edj.12
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=U97NH3460uvRIyiVkz6BqNsQRQWQQT1QvHF8hvvKHQU=;
        b=XedmEWvlmYVZXGHnQhDR8JK0W5OypzWZKlHVDIEQH7w29tS5k2ukFeupObLdi2OuUN
         M2LN8sw8Svq+r/Iprj16tcpwYoHm7y7o9QHPRSIucjYYhGjvBpREbni0Ty0PyNRTzggS
         uC1VUeD5/NbQx9HtJR1gxgtcyM/V9JySb7ol2CTXp//bznySXy/8Bg7R9z2Dz9bxHHlB
         nDUowO7Pe5Ujlib4apmWRvhO/AtN2edOb3+5xrre8Csp5UKla2cKyPRMdTxDOrgamm6V
         dg4LvyxrF2ihEE7GUgV3bfiiJBwmOKCN2hzrkC5NWuEWiS9vcdnjzcbC/d9wXz9Fl02y
         +7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=U97NH3460uvRIyiVkz6BqNsQRQWQQT1QvHF8hvvKHQU=;
        b=c1H3ksrQYGsEcVukzqtJ6GQyYkP/ZtPNE6AYz+P5HK8DdlbJAoS9BnfJQmyQSdFu2F
         s3Mn/6c4wto9Qsk8FnhCpIhTqYunR0pu59LGok8k7zDmnP2AmXlVSd5ewo2UdW2D6ngw
         PW8+d/HxCYxgBMad9SNssM+fjyYeTUvGmZjzVgnZkuIK+FNEcYwe/WnrG0hVkj54ysIZ
         Al6fA8pQo8AeDsa3caz6MniyfKzLEJLDrg4hg39QU3wZsNFiV+/BkGcHg8n4pwD3gLAH
         c0SCElMyVIV/7YEPxZF7B369N9i1klYvWvTNaQMowgcTz9r+gaof7CzHlGF4m5hTDUSu
         Ne4A==
X-Gm-Message-State: ACgBeo0TKhK+t9xirdD1Nzj+loBQAlyO+nciQzA3ansoXe77dtIOUlQ9
        gSIik1y9rpzYAZVbUSAeYik4YRTeyXv14wjjoQ0=
X-Google-Smtp-Source: AA6agR4gDNwKDKb15rXgHxeojCSJfIlZo2qVIRKs91yDt4JUtWhVRL7Kd/YqUPvIU2oH6fWcBVkmTpJVWp40CdffyZ0=
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id
 y4-20020aa7ccc4000000b0043d9e0eb7ffmr12336177edt.14.1659475751002; Tue, 02
 Aug 2022 14:29:11 -0700 (PDT)
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
 <CAEf4BzbN99WbEDS9r7nyO-7+SOYTU=-kXhD+A1L3dzrwrcHdBQ@mail.gmail.com> <CADvTj4qi_ZZhdXRPd0X_tgQ8-jgrRgxF+4+kYVA92ZMO8KqESA@mail.gmail.com>
In-Reply-To: <CADvTj4qi_ZZhdXRPd0X_tgQ8-jgrRgxF+4+kYVA92ZMO8KqESA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 14:28:59 -0700
Message-ID: <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com>
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

On Mon, Aug 1, 2022 at 4:35 PM James Hilliard <james.hilliard1@gmail.com> w=
rote:
>
> On Mon, Aug 1, 2022 at 4:52 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> > > <jose.marchesi@oracle.com> wrote:
> > > >
> > > >
> > > > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > > > >>> <jose.marchesi@oracle.com> wrote:
> > > > >>>>
> > > > >>>>
> > > > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
> > > > >>>> > <jose.marchesi@oracle.com> wrote:
> > > > >>>> >>
> > > > >>>> >>
> > > > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hill=
iard1@gmail.com> wrote:
> > > > >>>> >> >>
> > > > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
> > > > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > > > >>>> >> >> >
> > > > >>>> >> >> >
> >
> > Please trim your replies (and I don't know what your email client did,
> > but it completely ruined nested quote formatting)
>
> Yeah, not sure what happened there.
>
> >
> > [...]
> >
> > > > >>>>
> > > > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > >>>> index e89cc9c885b3..887b78780099 100644
> > > > >>>> --- a/tools/lib/bpf/libbpf.c
> > > > >>>> +++ b/tools/lib/bpf/libbpf.c
> > > > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_data=
_maps(struct bpf_object *obj)
> > > > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; sec_=
idx++) {
> > > > >>>>                 sec_desc =3D &obj->efile.secs[sec_idx];
> > > > >>>>
> > > > >>>> +                /* Skip recognized sections with size 0.  */
> > > > >>>> +                if (sec_desc->data && sec_desc->data->d_size =
=3D=3D 0)
> > > > >>>> +                  continue;
> > > > >>>> +
> > > > >>>>                 switch (sec_desc->sec_type) {
> > > > >>>>                 case SEC_DATA:
> > > > >>>>                         sec_name =3D elf_sec_name(obj, elf_sec=
_by_idx(obj, sec_idx));
> > > > >>>
> > > > >>> Ok, skeleton is now getting generated successfully, however it =
differs from the
> > > > >>> clang version so there's a build error when we include/use the =
header:
> > > > >>> ../src/core/restrict-ifaces.c: In function =E2=80=98prepare_res=
trict_ifaces_bpf=E2=80=99:
> > > > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=98struct
> > > > >>> restrict_ifaces_bpf=E2=80=99 has no member named =E2=80=98rodat=
a=E2=80=99; did you mean
> > > > >>> =E2=80=98data=E2=80=99?
> > > > >>>    45 |         obj->rodata->is_allow_list =3D is_allow_list;
> > > > >>>       |              ^~~~~~
> > > > >>>       |              data
> > > > >>>
> > > > >>> The issue appears to be that clang generates "rodata" members i=
n
> > > > >>> restrict_ifaces_bpf while with gcc we get "data" members instea=
d.
> > > > >>
> > > > >> This is because the BPF GCC port is putting the
> > > > >>
> > > > >>   const volatile unsigned char is_allow_list =3D 0;
> > > > >>
> > > > >> in a .data section instead of .rodata, due to the `volatile'.  T=
he
> > > > >> x86_64 GCC seems to use .rodata.
> > > > >>
> > > > >> Looking at why the PBF port does this...
> > > > >
> > > > > So, turns out GCC puts zero-initialized `const volatile' variable=
s in
> > > > > .data sections (and not .rodata) in all the targets I have tried,=
 like
> > > > > x86_64 and aarch64.
> > > > >
> > > > > So this is a LLVM and GCC divergence :/
> > > >
> > > > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521.
> > > >
> > > > You may try, as a workaround:
> > > >
> > > > __attribute__((section(".rodata"))) const volatile unsigned char is=
_allow_list =3D 0;
> > > >
> > > > But that will use permissions "aw" for the .rodata section (and you=
 will
> > > > get a warning from the assembler.)  It may be problematic for libbp=
f.
> > >
> > > So rather than try to force gcc to use the incorrect llvm .rodata
> > > section it looks
> > > like we can instead just force llvm to use the correct .data section =
like this:
> > > https://github.com/systemd/systemd/pull/24164
> > >
> >
> > There is a huge difference between variables in .rodata and .data.
> > .rodata variable's value is known to the BPF verifier at verification
> > time and this knowledge will be used to decide which code paths are
> > always or never taken (as one example). It's a crucial property and
> > important guarantee.
> >
> > If you don't care about that property, don't declare the variable as `c=
onst`.
> >
> > So no, it's not llvm putting `const` variable into .rodata
> > incorrectly, but GCC is trying to be smart and just because variable
> > is declared volatile is putting *const* variable into read-write .data
> > section. It's declared as const, and yes it's volatile to make sure
> > that compiler isn't too smart about optimizing away read operations.
>
> Isn't const volatile generating a .rodata section(like llvm is doing) a s=
pec
> violation?
> https://github.com/llvm/llvm-project/issues/56468
>
> > But it's still a const read-only variable from the perspective of that
> > BPF C code.
> >
> > If you don't care about the read-only nature of that variable, drop
> > the const and make it into a non-read-only variable.
> >
> > And please stop proposing hacks to be added to perfectly valid systemd
> > BPF source code (I replied on [0] as well).
>
> From my understanding gcc is correctly putting a const volatile variable
> in .data while llvm is incorrectly putting it in .rodata, is the gcc beha=
vior
> here invalid or is the llvm behavior invalid?

From link you left to C standard, it does seem like that side-note
*implies* that const volatile should be put into .data, but it's a)
implied b) is quite arguable about assumptions that this data has to
be in modifiable section, and c) entire CO-RE feature detection and
guarding relies on having `const volatile` variables in .rodata and
mark them as read-only for BPF verifier to allow dead code
elimination. Changing c) would break entire CO-RE ecosystem.

Seems like this issue was raised by Ulrich Drepper back in 2005 ([0])
and he was also confused about GCC's behavior, btw.

So either way, at the very least for BPF target we can't change this
and I still think it's more logical to put const variables into
.rodata, regardless of side notes in C standard.


As for systemd's program and its is_allow_list ([1]), to unblock
yourself you can drop const because systemd doesn't rely on read-only
guarantees of that variable anyways. It's much more critical in
feature-detection use cases. But let's try to converge discussion in
one place (preferably here), it's quite inconvenient to either reply
the same thing twice here and on Github, or cross-reference lore and
Github.


  [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521
  [1] https://github.com/systemd/systemd/pull/24164#issuecomment-1203207372

>
> >
> >   [0] https://github.com/systemd/systemd/pull/24164#issuecomment-120180=
6413
> >
> >
> > [...]
