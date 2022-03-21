Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CA4E32D5
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 23:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiCUWq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 18:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCUWq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 18:46:28 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52AF47FC29
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 15:25:02 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h21so11344812ila.7
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QwTc/aZgWxAonyYAcThWgkliP6pLXbLK64gZl/J+QyU=;
        b=E/prtRg0vk6i5Lfx6RswCwmwH3UM2COQOlYWeROLObirP6Eo9A5sgWsOznGbRHsXD3
         rp6Om/d297aNJNek8jMLDb2CsaRQ1Vbb1yMjwtxzCq2VyuqoMwFYUC7CMHFdOndxFbHT
         UQEqj039SGPUYOsIgXulCBFR2LDsxKlQF0+5SJ0ov4PzOEwYNuqx3vVwg0Wb5PtiuqsB
         3jhSegjeZdEU7krLu7V8/3ZsExzPkQebewTggCN0ot4mJ3tMMfF2RI2A21KaxQuBTtXG
         e41ASl6qxZCYTZOMJu61m9gBIo/hYSlPgyq1q/mB5Tu+QfS0T74zS+SB4Jm0XLHgHpne
         2Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QwTc/aZgWxAonyYAcThWgkliP6pLXbLK64gZl/J+QyU=;
        b=tezsGzYIT9MOQP2vznvK59/VbOLc/nz3Bsi1SciHKmWHB2iYMJfv2r0UNRHoubJFLP
         8/rFD7wmCGaGsXMgMaygN0o/zGw2Zos68sWUkn/Rt5gXOboozUhylhPULdOFUXen4B+E
         DRMzyARQ2jqGYjisE00hC0q886T15/0vtJm0BOuSdIw/S6of/2kgzObAEl1BLjGTJvjs
         LIvipvUiUlxnyIwhARSKB7RdKYhGRvhcNa+5IrLIl0XqQW/bqQjDBVMkoUcrvuqtU3Sd
         1iZtyOB38N0G0OO6XVnZhPh8yq0jzLjSAbupYrNZmgq5/MnOJbf4ea2d9xIE+FwdU5ow
         yh2Q==
X-Gm-Message-State: AOAM5304JDXXPLtSEi0yECHU2vZbnkn/YBx2+JmvIin3FCs2sfkOkuVn
        NoKhitjmIx5bumMBWZpmP3SuQ1dPuCb0ej4Z0fQE+N1A
X-Google-Smtp-Source: ABdhPJwKsHyXN+pTc5MKoHf5XZ2IRNEDGJHx+1U1nnAZtxqRfaOPL53tI6QgPOCzYXafF91hzG6NlGCO1X1mYCy6aAs=
X-Received: by 2002:a05:6e02:16c7:b0:2c7:e458:d863 with SMTP id
 7-20020a056e0216c700b002c7e458d863mr10051488ilx.71.1647901418355; Mon, 21 Mar
 2022 15:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR21MB1430AFEB81F5F7930E8027C1FA089@CH2PR21MB1430.namprd21.prod.outlook.com>
 <CAEf4BzYsGVSTS5t=OBPpMKcGm8F0aB4PG=dxK+Pg=UeP18o0NA@mail.gmail.com> <CH2PR21MB14307F582468BB431CAABA4DFA0C9@CH2PR21MB1430.namprd21.prod.outlook.com>
In-Reply-To: <CH2PR21MB14307F582468BB431CAABA4DFA0C9@CH2PR21MB1430.namprd21.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 15:23:27 -0700
Message-ID: <CAEf4Bzbyn4qGNN6m0XDAMw2GTNFPBEfwHNgzxN31ERRgBXZLwg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH bpf-next] Support load time binding of bpf-helpers.
To:     Alan Jowett <Alan.Jowett@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 11, 2022 at 10:37 AM Alan Jowett <Alan.Jowett@microsoft.com> wr=
ote:
>
> Thanks for the feedback, I appreciate it. Any suggestions on how to make =
the output more visually appealing?
>
> If there was a IANA equivalent for assigning helper function id's then it=
 might be possible to support having the same IDs on multiple platforms, bu=
t as it exists today the various platforms are developed separately, with n=
o simple way to co-ordinate. The benefit of using symbols over numeric id's=
 is that it reduces the possibility of identifier collision, where differen=
t platforms might define helper ID # to mean different things, but it's les=
s likely that different platforms will define bpf_foo_bar to have different=
 semantics.
>
> Conceptually, this is like the relocations done using BTF data for CORE, =
where the offsets into structures can vary depending on the kernel version.=
 In this scenario the helper IDs can vary with the relocation being done ba=
sed on symbols stored in the ELF file.

Please don't top post, reply inline instead.

We have a BPF Foundation and BPF Steering Committee for coordinating
things like this across different platforms. Adding extra relocations
just for BPF helper IDs seems to go in the wrong direction from
minimizing the amount of runtime BPF instruction adjustments (to
simplify things like BPF signing, etc).

>
> Regards,
> Alan Jowett
>
> -----Original Message-----
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Sent: Tuesday, March 8, 2022 4:49 PM
> To: Alan Jowett <Alan.Jowett@microsoft.com>
> Cc: bpf@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH bpf-next] Support load time binding of bpf=
-helpers.
>
> On Tue, Mar 8, 2022 at 9:20 AM Alan Jowett <Alan.Jowett@microsoft.com> wr=
ote:
> >
> > BPF helper function names are common across different platforms, but
> > the id assigned to helper functions may vary. This change provides an
> > option to generate eBPF ELF files with relocations for helper
> > functions which permits resolving helper function names to ids at load
> > time instead of at compile time.
> >
> > Add a level of indirection to bpf_doc.py (and generated
> > bpf_helper_defs.h) to permit compile time generation of bpf-helper
> > function declarations to facilitating late binding of bpf-helpers to
> > helper id for cases where different platforms use different helper
> > ids, but the same helper functions.
> >
> > Example use case would be:
> > "#define BPF_HELPER(return_type, name, args, id) \
> >     extern return_type name args"
> >
> > To generate:
> > extern void * bpf_map_lookup_elem (void *map, const void *key);
> >
> > Instead of:
> > static void *(*bpf_map_lookup_elem) (void *map, const void *key) \
> >     =3D (void*) 1;
> >
> > This would result in the bpf-helpers having external linkage and
> > permit late binding of BPF programs to helper function ids.
> >
>
> Ugh...
>
> BPF_HELPER(void*, bpf_map_lookup_elem, (void *map, const void *key), 1);
>
> Looks pretty awful :(
>
> But I also have the question about why different platforms should have di=
fferent IDs for the same subset of BPF helpers? Wouldn't it be better to pr=
eserve IDs across platforms to simplify cross-platform BPF object files?
>
> We can probably also define some range for platform-specific BPF helpers =
starting from some high ID?
>
> > Signed-off-by: Alan Jowett <alanjo@microsoft.com>
> > ---
> >  scripts/bpf_helpers_doc.py | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> > index 867ada23281c..442b5e87687e 100755
> > --- a/scripts/bpf_helpers_doc.py
> > +++ b/scripts/bpf_helpers_doc.py
> > @@ -519,6 +519,10 @@ class PrinterHelpers(Printer):
> >          for fwd in self.type_fwds:
> >              print('%s;' % fwd)
> >          print('')
> > +        print('#ifndef BPF_HELPER')
> > +        print('#define BPF_HELPER(return_type, name, args, id) static =
return_type(*name) args =3D (void*) id')
> > +        print('#endif')
> > +        print('')
> >
> >      def print_footer(self):
> >          footer =3D ''
> > @@ -558,7 +562,7 @@ class PrinterHelpers(Printer):
> >                  print(' *{}{}'.format(' \t' if line else '', line))
> >
> >          print(' */')
> > -        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type'])=
,
> > +        print('BPF_HELPER(%s%s, %s, (' %
> > + (self.map_type(proto['ret_type']),
> >                                        proto['ret_star'], proto['name']=
), end=3D'')
> >          comma =3D ''
> >          for i, a in enumerate(proto['args']):
> > @@ -577,7 +581,7 @@ class PrinterHelpers(Printer):
> >              comma =3D ', '
> >              print(one_arg, end=3D'')
> >
> > -        print(') =3D (void *) %d;' % len(self.seen_helpers))
> > +        print('), %d);' % len(self.seen_helpers))
> >          print('')
> >
> >
> > ######################################################################
> > #########
> > --
> > 2.25.1
