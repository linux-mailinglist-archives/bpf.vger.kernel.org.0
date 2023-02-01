Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63206869BD
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBAPPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBAPPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 10:15:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79246B6
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 07:14:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so7081165wmb.0
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 07:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQ4SjI01+pXsI7+60rYG2wsNRcl4gNYZpdSamH6mCS0=;
        b=FajcIc6JuX/flEcRveyLpNcd4XnMJwXprH8LISTqZcUZ4bbIUmBbyfPb4tSbm6sGfh
         SUSCaHGozfCK7fKWrsXhdhljmaCfFWJLdcHcPKfzgimned3V7NcN/GlGYsNkvUPidmtv
         EjHiwR0z0z7lQz4LNaEhayQgrhE5YSjMQkLF+kVSvOSVCNv4EM7HXSIoXJK18AdtGtGl
         ucjck3eSp8peYgvKQSCOt+CYXDvbEPYc3JVbs/HhtlGo0bRyfPAzCEV50kGvBxJrlKu0
         AvKaWAoFDD3NhEdg0W8n8CtOYO2cKNTcS9W2LtwjJFuinkmMCvt4Utvr9YDayYfGxeOC
         BZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQ4SjI01+pXsI7+60rYG2wsNRcl4gNYZpdSamH6mCS0=;
        b=2vTM+9gHU/sZ0ZFrCohoXKOTCC+XVV1GOODnRIA2GaY5n7j5vDrB8jxmrbcC7fM5QX
         +cxtMHmiL+otHHK7w9a9JiIhu5QK1jALsn5zY51rOaGSo8RiSbxT3o/NF6buZkK4H9tx
         RbN9tj1LgWcu+xhrirnmtuYcYQW6w31kyR3mKj9SoN4+b4unmRk4x9Jqs0pH/ECAUhHC
         VDk+WHKzNW1RM0Vl5OBU1oNxbJYJsMxmkLRgyOSCUndEEE5hT8Uhp2t17KlHDW08tQOw
         7KgMOkG1dUyab9a9Wdd9+169o5WOF62mnxrrCOSbBpWsUuIgEGabpgbaCH2q2TUjd8YG
         RFPA==
X-Gm-Message-State: AO0yUKUgJblGeLa+WeMbWBQiOIXfIWGHrF8JUvba5qPFRYBeK2ZPU00T
        zvSepM4pKeAR91iW6alu/y1zvDXV1C2Gyg==
X-Google-Smtp-Source: AK7set9SEgZpBEMgdpDoVW1LBrHAcXMfReiw1KtN91sUmmrAutAoZz80Mtnf97EuL2Pm/pM7EUqMtA==
X-Received: by 2002:a1c:4c08:0:b0:3de:b1ec:7f95 with SMTP id z8-20020a1c4c08000000b003deb1ec7f95mr2527098wmf.18.1675264474790;
        Wed, 01 Feb 2023 07:14:34 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003dd1c15e7fcsm2416704wmq.15.2023.02.01.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:14:34 -0800 (PST)
Message-ID: <48f840c1b879728bda69e059f19c2cea642c1e97.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Edward Cree <ecree.xilinx@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
Date:   Wed, 01 Feb 2023 17:14:33 +0200
In-Reply-To: <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
References: <20230131181118.733845-1-eddyz87@gmail.com>
         <20230131181118.733845-2-eddyz87@gmail.com>
         <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-01 at 11:00 +0000, Edward Cree wrote:
> On 31/01/2023 18:11, Eduard Zingerman wrote:
> > This is a followup for [1], adds an overview for the register liveness
> > tracking, covers the following points:
> > - why register liveness tracking is useful;
> > - how register parentage chains are constructed;
> > - how liveness marks are applied using the parentage chains.
> >=20
> > [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3r=
NV+kBLQCu7rA@mail.gmail.com/
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  Documentation/bpf/verifier.rst | 280 +++++++++++++++++++++++++++++++++
> >  1 file changed, 280 insertions(+)
> ...
> > +  Current    +-------------------------------+
> > +  state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
> > +             +-------------------------------+
> > +                             \
> > +                               r6 read mark is propagated via
> > +                               these links all the way up to
> > +                               checkpoint #1.

Hi Edward, could you please review the updates below?

> Perhaps explicitly mention here that the reason it doesn't
>  propagate to checkpoint #0 (despite the arrow) is that there's
>  a write mark on c1[r6].

I can update this remark as follows:

---- 8< ---------------------------

  Current    +-------------------------------+
  state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
             +-------------------------------+
                             \
                               r6 read mark is propagated via these links
                               all the way up to checkpoint #1.
                               The checkpoint #1 contains a write mark for =
r6
                               because of instruction (1), thus read propag=
ation
                               does not reach checkpoint #0 (see section be=
low).

--------------------------- >8 ----

>=20
> Also worth mentioning somewhere that write marks are really a
>  property of the arrow, not the state =E2=80=94 a write mark in c#1 tells
>  us that the straight-line code from c#0 to c#1 contains a write
>  (thus 'breaking' that arrow for read mark propagation); it lives
>  in c#1's data structures because it's c#1 that needs to 'know'
>  about it, whereas c#0 (and its parents) need to 'know' about any
>  *reads* in the straight-line code from c#0 to c#1 (but these are
>  of no interest to c#1).
> I sometimes summarise this with the phrase "read up, write down",
>  though idk how useful that is to anyone outside of my head ;)

TBH, I'm a bit hesitant to put such note on the diagram because
liveness tracking algorithm is not yet discussed. I've updated the
next section a bit to reflect this, please see below.

>=20
> > +Liveness marks tracking
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +For each processed instruction, the verifier propagates information ab=
out reads
> > +up the parentage chain and saves information about writes in the curre=
nt state.
> > +The information about reads is propagated by function ``mark_reg_read(=
)`` which
> > +could be summarized as follows::
> > +
> > +  mark_reg_read(struct bpf_reg_state *state):
> > +      parent =3D state->parent
> > +      while parent:
> > +          if parent->live & REG_LIVE_WRITTEN:
> > +              break
> This isn't correct; we look at `state->live` here, because if in
>  the straight-line code since the last checkpoint (parent)
>  there's a write to this register, then reads should not
>  propagate to `parent`.

You are correct, thank you for catching it (:big facepalm image:).

> Then there's the complication of the `writes` variable in
>  mark_reg_read(); that's explained by the comment on
>  propagate_liveness(), which AFAICT you don't cover in your
>  doc section about that.  (And note that `writes` is only ever
>  false for the first iteration through the mark_reg_read() loop).

I intentionally avoided description of this mechanics to keep some
balance between clarity and level of details. Added a note that there
is some additional logic.

>=20
> > +          if parent->live & REG_LIVE_READ64:
> > +              break
> > +          parent->live |=3D REG_LIVE_READ64
> > +          state =3D parent
> > +          parent =3D state->parent
> > +
> > +Note: details about REG_LIVE_READ32 are omitted.
> > +
> > +Also note: the read marks are applied to the **parent** state while wr=
ite marks
> > +are applied to the **current** state.
> May be worth stating that the principle of the algorithm is that
>  read marks propagate back along the chain until they hit a write
>  mark, which 'screens off' earlier states from the read.
> Your doc implies this but afaict never states it explicitly, and
>  I think it makes the algo easier to understand for someone who
>  doesn't already know what it's all about.

All in all here is updated start of the section:

---- 8< ---------------------------

The principle of the algorithm is that read marks propagate back along the =
state
parentage chain until they hit a write mark, which 'screens off' earlier st=
ates
from the read. The information about reads is propagated by function
``mark_reg_read()`` which could be summarized as follows::

  mark_reg_read(struct bpf_reg_state *state, ...):
      parent =3D state->parent
      while parent:
          if state->live & REG_LIVE_WRITTEN:
              break
          if parent->live & REG_LIVE_READ64:
              break
          parent->live |=3D REG_LIVE_READ64
          state =3D parent
          parent =3D state->parent

Notes:
* The read marks are applied to the **parent** state while write marks are
  applied to the **current** state. The write mark on a register or stack s=
lot
  means that it is updated by some instruction verified within current stat=
e.
* Details about REG_LIVE_READ32 are omitted.
* Function ``propagate_liveness()`` (see section :ref:`Read marks propagati=
on
  for cache hits`) might override the first parent link, please refer to th=
e
  comments in the source code for further details.

--------------------------- >8 ----

>=20
> Apart from that, this is great.  I particularly like your diagram
>  of the parentage chains.

Thanks a lot for commenting!
wdyt about my updates?

