Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935D3587419
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiHAWwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiHAWwG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:52:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9227162
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:52:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sz17so22933660ejc.9
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=N1IzmQfXzaKNlpMvQBLmpWblw0g7WUKSTydQrXmJYC4=;
        b=p0ze6krT2WD0OasGSz1nzbIAZ9NeicCOyTOiAFXkIpa8pJd7uzhWbuxj64a75DI1mi
         fIyK1MQZE5ED5vTvazyVP/Tc6LnI2lSMh10ZYkAcu1Y9IAtpJTz6NUYK8DFvZYQ1Ipjx
         l4QQlIPmJ1QGxNACCtT6u4PebwGGiLQXIJKUWQv727ibNy+70v4S1frvaWZZ1Ch+SsG1
         oEqsF27sNd/1cFABanmjiMK1fch97I3U5EUWW7MHcvnyIlS2Bxe2bFUcwla+RvbdsNsu
         /Z3lfYdN3GPDHGg9MP3EmPzksdJquAReR4zNxq5cI0iSpeLDqs6ohVHDl9vVJr5xH3mV
         tCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=N1IzmQfXzaKNlpMvQBLmpWblw0g7WUKSTydQrXmJYC4=;
        b=TOuI/GEwPoIcWeeuHJ979jLE69mXiJGu61j+DPWEGXfTIsoO5/YKAOXeo2T//KG+CX
         QNrZ+VLdheo4s8eBE6ALqr1CT9Yge7455YO6vt0v4fkbOoyEnHPvDCmkHJr2tW8soeXa
         bWjFpB9eHLhKJyC49E0/KUUVBUdZ+fA+dCxKZzqqybS+AbhjIvJTAauNM/djJUCfa9Uk
         iAWs5/7DXgWgaZVlIvkJIQxiG1yjPlVJYkjmGUIsXbHHI/MCaAtH8DHdctoPUUPeo6N0
         oXOU0sRuOvpCxeW94NGcx1HuSyrkjYa33QOBH+dhFTsTiy4Sonu5OcoRw8f0mQ2ZoniC
         2lhw==
X-Gm-Message-State: ACgBeo2zZJWG7XeeNJl1YCqSPz9JujlGDTxYm/Xd5C8FYw+IKILi7wpb
        ldmK/pf1C+x0Le1yl9tHa/R/Q3umH6Iz8pW8CoA=
X-Google-Smtp-Source: AA6agR4eG5CNUA3dHf6NsQMxvB85VbIDG1n2H4kvEkhP5WTbukl2MgOMzGPAcbUU8xBaVpQXbG7rz6+P/pAKv4pvAGo=
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id
 yo1-20020a170907136100b007308f596434mr4139046ejb.745.1659394324353; Mon, 01
 Aug 2022 15:52:04 -0700 (PDT)
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
In-Reply-To: <CADvTj4o-36iuru665BW0XnEauXBeszW438QTtpt4_VUEjf5nXg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 15:51:52 -0700
Message-ID: <CAEf4BzbN99WbEDS9r7nyO-7+SOYTU=-kXhD+A1L3dzrwrcHdBQ@mail.gmail.com>
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

On Sun, Jul 31, 2022 at 7:20 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Sun, Jul 10, 2022 at 2:22 PM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
> >
> >
> > >>> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> > >>> <jose.marchesi@oracle.com> wrote:
> > >>>>
> > >>>>
> > >>>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
> > >>>> > <jose.marchesi@oracle.com> wrote:
> > >>>> >>
> > >>>> >>
> > >>>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hilliard=
1@gmail.com> wrote:
> > >>>> >> >>
> > >>>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
> > >>>> >> >> <jose.marchesi@oracle.com> wrote:
> > >>>> >> >> >
> > >>>> >> >> >

Please trim your replies (and I don't know what your email client did,
but it completely ruined nested quote formatting)

[...]

> > >>>>
> > >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > >>>> index e89cc9c885b3..887b78780099 100644
> > >>>> --- a/tools/lib/bpf/libbpf.c
> > >>>> +++ b/tools/lib/bpf/libbpf.c
> > >>>> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_data_map=
s(struct bpf_object *obj)
> > >>>>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; sec_idx+=
+) {
> > >>>>                 sec_desc =3D &obj->efile.secs[sec_idx];
> > >>>>
> > >>>> +                /* Skip recognized sections with size 0.  */
> > >>>> +                if (sec_desc->data && sec_desc->data->d_size =3D=
=3D 0)
> > >>>> +                  continue;
> > >>>> +
> > >>>>                 switch (sec_desc->sec_type) {
> > >>>>                 case SEC_DATA:
> > >>>>                         sec_name =3D elf_sec_name(obj, elf_sec_by_=
idx(obj, sec_idx));
> > >>>
> > >>> Ok, skeleton is now getting generated successfully, however it diff=
ers from the
> > >>> clang version so there's a build error when we include/use the head=
er:
> > >>> ../src/core/restrict-ifaces.c: In function =E2=80=98prepare_restric=
t_ifaces_bpf=E2=80=99:
> > >>> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=98struct
> > >>> restrict_ifaces_bpf=E2=80=99 has no member named =E2=80=98rodata=E2=
=80=99; did you mean
> > >>> =E2=80=98data=E2=80=99?
> > >>>    45 |         obj->rodata->is_allow_list =3D is_allow_list;
> > >>>       |              ^~~~~~
> > >>>       |              data
> > >>>
> > >>> The issue appears to be that clang generates "rodata" members in
> > >>> restrict_ifaces_bpf while with gcc we get "data" members instead.
> > >>
> > >> This is because the BPF GCC port is putting the
> > >>
> > >>   const volatile unsigned char is_allow_list =3D 0;
> > >>
> > >> in a .data section instead of .rodata, due to the `volatile'.  The
> > >> x86_64 GCC seems to use .rodata.
> > >>
> > >> Looking at why the PBF port does this...
> > >
> > > So, turns out GCC puts zero-initialized `const volatile' variables in
> > > .data sections (and not .rodata) in all the targets I have tried, lik=
e
> > > x86_64 and aarch64.
> > >
> > > So this is a LLVM and GCC divergence :/
> >
> > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25521.
> >
> > You may try, as a workaround:
> >
> > __attribute__((section(".rodata"))) const volatile unsigned char is_all=
ow_list =3D 0;
> >
> > But that will use permissions "aw" for the .rodata section (and you wil=
l
> > get a warning from the assembler.)  It may be problematic for libbpf.
>
> So rather than try to force gcc to use the incorrect llvm .rodata
> section it looks
> like we can instead just force llvm to use the correct .data section like=
 this:
> https://github.com/systemd/systemd/pull/24164
>

There is a huge difference between variables in .rodata and .data.
.rodata variable's value is known to the BPF verifier at verification
time and this knowledge will be used to decide which code paths are
always or never taken (as one example). It's a crucial property and
important guarantee.

If you don't care about that property, don't declare the variable as `const=
`.

So no, it's not llvm putting `const` variable into .rodata
incorrectly, but GCC is trying to be smart and just because variable
is declared volatile is putting *const* variable into read-write .data
section. It's declared as const, and yes it's volatile to make sure
that compiler isn't too smart about optimizing away read operations.
But it's still a const read-only variable from the perspective of that
BPF C code.

If you don't care about the read-only nature of that variable, drop
the const and make it into a non-read-only variable.

And please stop proposing hacks to be added to perfectly valid systemd
BPF source code (I replied on [0] as well).

  [0] https://github.com/systemd/systemd/pull/24164#issuecomment-1201806413


[...]
