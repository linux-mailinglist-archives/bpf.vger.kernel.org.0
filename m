Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF36A9CF9
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCCRQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 12:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjCCRQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 12:16:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667901D930
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 09:16:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id fa28so1993903pfb.12
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677863795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI8n81cTtGVYsEs6w12jfZnLukwvNkVohmJ/Zs2BJE0=;
        b=SvL+D4BZSFPc7CNmnZ6eyP0Uq/Dvc/JSJ+b+A0zgMvyJ5drrqN2PcJAoXYL0NozdxN
         BEQ6LlX+2wgJ3620jeJ5k0WMklYBD28RiAckwDGnFXCDX/qthwPnjBap3Pu4wHXkSvVm
         GzX6jPR6xl5TPDxdEmgbreoq6R+v/DOwom59ykP3rAH+WKJUiVz+TcOHNi8LzKSNTyfm
         GHSfsleKeGOXiUax4Q0kK7i+cDP31o2gkMYnJyFn0W0ux3asz+5vppbrCSxJvnb6mG36
         VNfx7hQ9VYh8NDvfeuNiNkcGJQPN8z/Y7qHY/sjJ8Nmq3HstqgYok9M80r0kFaGo7XeP
         y4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oI8n81cTtGVYsEs6w12jfZnLukwvNkVohmJ/Zs2BJE0=;
        b=crrQJZ/TB9Dv52sZtqJv0zbYOX8/QqtXCHNG5K5LSa7jdF9VFiwHLmrMtSgWf5RhkS
         bI0iUnTkbz7qpXMDl/YpznQ201Za/X/xGzrul9AobqyBcReWUWkyfQz4nMVG2bXTOaph
         BpARNMoQ8x9hlvJNyt6L3HXq94dHvfEmrGMvDIWZHYZzDgm0fN+kw5EtB4xfvHmD06tc
         FXz9ahLqNGTiCTJLgmnY6t0AhxtmoMMp8xFPL8bFs1cwoe5JYC8RhSgf4Ih4un3xOw7Q
         lsjmVaP1DL1TtYxoxolZHK4kjMI0PupR4JRmR7ZnnUntesL2KbhHvH8GTQYqI9e2u4G/
         LGBw==
X-Gm-Message-State: AO0yUKUU8ovdT/SQPxU2SsR8UZBCt3HCaVWWvBIl3S7D/3WHxfLgJT/U
        cRHFSH95ZNGVOPgDYFusOuKLZ9hdgXyOkmdlwgjmRg+uqX3Rji6/
X-Google-Smtp-Source: AK7set+HPykDyKI4XAl/4qv/O6kGlLCzsph/z64P9LrtjNVjpyBWPyAj8fKU2ebBZBlsWMLNimtiYfujl6BrQiDTkrE=
X-Received: by 2002:a62:8645:0:b0:5a8:9872:2b9b with SMTP id
 x66-20020a628645000000b005a898722b9bmr1200191pfd.1.1677863794526; Fri, 03 Mar
 2023 09:16:34 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk> <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com> <87zg8uc8ow.fsf@toke.dk>
In-Reply-To: <87zg8uc8ow.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 3 Mar 2023 09:16:22 -0800
Message-ID: <CAKH8qBv+aRx=jCRuVoeSm_TsvFuz4DBCd547YaTgpfCcZQTEPQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 3, 2023 at 4:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kerne=
l.org> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>
> > On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote=
:
> >>
> >> On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@kernel.org> wrote:
> >> >
> >> > Stanislav Fomichev <sdf@google.com> writes:
> >> >
> >> > > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
> >> > >>
> >> > >> Stanislav Fomichev <sdf@google.com> writes:
> >> > >>
> >> > >> > I'd like to discuss a potential follow up for the previous "XDP=
 RX
> >> > >> > metadata" series [0].
> >> > >> >
> >> > >> > Now that we can access (a subset of) packet metadata at RX, I'd=
 like to
> >> > >> > explore the options where we can export some of that metadata o=
n TX. And
> >> > >> > also whether it might be possible to access some of the TX comp=
letion
> >> > >> > metadata (things like TX timestamp).
> >> > >> >
> >> > >> > I'm currently trying to understand whether the same approach I'=
ve used
> >> > >> > on RX could work at TX. By May I plan to have a bunch of option=
s laid
> >> > >> > out (currently considering XSK tx/compl programs and XDP tx/com=
pl
> >> > >> > programs) so we have something to discuss.
> >> > >>
> >> > >> I've been looking at ways of getting a TX-completion hook for the=
 XDP
> >> > >> queueing stuff as well. For that, I think it could work to just h=
ook
> >> > >> into xdp_return_frame(), but if you want to access hardware metad=
ata
> >> > >> it'll obviously have to be in the driver. A hook in the driver co=
uld
> >> > >> certainly be used for the queueing return as well, though, which =
may
> >> > >> help making it worth the trouble :)
> >> > >
> >> > > Yeah, I'd like to get to completion descriptors ideally; so nothin=
g
> >> > > better than a driver hook comes to mind so far :-(
> >> > > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly s=
o far).
> >> >
> >> > Is there any other use case for this than getting the TX timestamp? =
Not
> >> > really sure what else those descriptors contain...
> >>
> >> I don't think so; at least looking at mlx5 and bnxt (the latter
> >> doesn't have a timestamp in the completion ring).
> >> So yeah, not sure, maybe that should be on the side and be AF_XDP spec=
ific.
> >> And not even involve bpf, just put the tx tstamp somewhere in umem:
> >> setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
> >> &data_relative_offset, ..);
> >> OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
> >> have for eternity? (plus, this needs a driver "hook" for af_xdp
> >> anyway, so why not make it generic?)
> >>
> >> > >> > I'd like to some more input on whether applying the same idea o=
n TX
> >> > >> > makes sense or not and whether there are any sensible alternati=
ves.
> >> > >> > (IIRC, there was an attempt to do XDP on egress that went nowhe=
re).
> >> > >>
> >> > >> I believe that stranded because it was deemed not feasible to cov=
er the
> >> > >> SKB TX path as well, which means it can't be symmetrical to the R=
X hook.
> >> > >> So we ended up with the in-devmap hook instead. I'm not sure if t=
hat's
> >> > >> made easier by multi-buf XDP, so that may be worth revisiting.
> >> > >>
> >> > >> For the TX metadata you don't really have to care about the skb p=
ath, I
> >> > >> suppose, so that may not matter too much either. However, at leas=
t for
> >> > >> the in-kernel xdp_frame the TX path is pushed from the stack anyw=
ay, so
> >> > >> I'm not sure if it's worth having a separate hook in the driver (=
with
> >> > >> all the added complexity and overhead that entails) just to set
> >> > >> metadata? That could just as well be done on push from higher up =
the
> >> > >> stack; per-driver kfuncs could still be useful for this, though.
> >> > >>
> >> > >> And of course something would be needed so that that BPF programs=
 can
> >> > >> process AF_XDP frames in the kernel before they hit the driver, b=
ut
> >> > >> again I'm not sure that needs to be a hook in the driver.
> >> > >
> >> > > Care to elaborate more on "push from higher up the stack"?
> >> >
> >> > I'm referring to the XDP_REDIRECT path here: xdp_frames are transmit=
ted
> >> > by the stack calling ndo_xdp_xmit() in the driver with an array of
> >> > frames that are immediately put on the wire (see bq_xmit_all() in
> >> > devmap.c). So any metadata writing could be done at that point, sinc=
e
> >> > the target driver is already known; there's even already a program h=
ook
> >> > in there (used for in-devmap programs).
> >> >
> >> > > I've been thinking about mostly two cases:
> >> > > - XDP_TX - I think this one technically doesn't need an extra hook=
;
> >> > > all metadata manipulations can be done at xdp_rx? (however, not su=
re
> >> > > how real that is, since the descriptors are probably not exposed o=
ver
> >> > > there?)
> >> >
> >> > Well, to me XDP_REDIRECT is the most interesting one (see above). I
> >> > think we could even drop the XDP_TX case and only do this for
> >> > XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
> >> > I.e., it's possible to XDP_REDIRECT back to the same device, the fra=
mes
> >> > will just take a slight detour up through the stack; but that could =
also
> >> > be a good thing if it means we'll have to do less surgery to the dri=
vers
> >> > to implement this for two paths.
> >> >
> >> > It does have the same challenge as you outlined above, though: At th=
at
> >> > point the TX descriptor probably doesn't exist, so the driver NDO wi=
ll
> >> > have to do something else with the data; but maybe we can solve that
> >> > without moving the hook into the driver itself somehow?
> >>
> >> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
> >> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
> >> with a skb-like-private metadata layout (as we've discussed previously
> >> for skb) here as well? But not sure it would solve all the problems?
> >> I'm thinking of an af_xdp case where it wants to program something
> >> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
> >> support)
> >
> > We have a patch set of this in the works. Need to finish the last
> > couple of tests then optimize performance and it is good to go. We
> > should be able to post it during the next cycle that starts next week.
>
> Uh, exciting, will look forward to seeing that! :)

+1, looking forward!

> -Toke
