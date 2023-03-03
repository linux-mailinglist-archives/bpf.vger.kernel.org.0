Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8296A91D0
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 08:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCCHmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 02:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCHmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 02:42:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0114980
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 23:42:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ay14so3128936edb.11
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 23:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677829348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goQWZE/CEb59N83lFtzr4ON2tD9HDOER8sTUF6cIyEg=;
        b=o2oM028JnZphQSIP9FpgGoWe3lxO0MUkpcfDGnEkeWw82SMBs6lf9FQ6j8BvQGBW8I
         Dp3uL2+iAEsYQyTXgrR64ISvUQitWzySBHgB3Er2M+2OvSYJ172GRJLes+3OvcfJVBY4
         S2Ilgo57f+13w4zaYYR8Jj8ao5Fd44C4gqexVZIQoUKs1iqccpt0Yq1eBQ4TRx+HDpjv
         IwX3Un94A9Fcu1ElHBtNEm4AYuZaC6iwnwmi4hBv6YZUMiUtY4pQqIDmHHvevPR5wKge
         O1iNDdDcGEDonm7Kj8YFO7upew79s2KLIOCdJPyJYQAJa2p60TjedGl7BALaFhDmO0wK
         IbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goQWZE/CEb59N83lFtzr4ON2tD9HDOER8sTUF6cIyEg=;
        b=p+/Gv2RhmRig40qmZrXWNr2ILPgDdlXBGYc0pVNYm6xpP+uvzjYwRO2hJ0KqOv7FPB
         suuXvL/4kS+JyFJxGKi7DkVSjbeCPdtumw+W2mxMHWq5pXbqoztcqDb1Vd3XJddw9eba
         nRiB9b+UDP9DtAxgugOGKKqHJThQRiLsxUXluLsWHL0HlNmZ4HGfAv5bptV573G+zjWI
         T5iLM7mhNaIJj8wLgBIx+YAm71W1aXHtsWoTc0jcemlC2ByGXhrO7BTXVvmVicM8WgPx
         5D3ffYjMpZszTMpyrE1/QvOZX+hj0pXV0+x5ljOAcnLy8gfWz3D5eVTw4fYXWko8tB3N
         G7pw==
X-Gm-Message-State: AO0yUKXKaA/fxU1bGs2JBYMROQglZciBmkfuNS6Bf4wlwizMq2qjeMMn
        GxLwSF/mJNUkwn+iSu7Yo/0OxQh7KO0YuTTuWa4=
X-Google-Smtp-Source: AK7set8RWIpdGjqV+hXDT3ogQkAtW5EMuOwImN9dgRy//CPuim21aO+ZNhMWkqnAfYDMBliCkQebLAu/KnSRKfzCf0o=
X-Received: by 2002:a17:906:f82:b0:8f5:2e0e:6def with SMTP id
 q2-20020a1709060f8200b008f52e0e6defmr3107897ejj.0.1677829348072; Thu, 02 Mar
 2023 23:42:28 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk> <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
In-Reply-To: <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Fri, 3 Mar 2023 08:42:16 +0100
Message-ID: <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
To:     Stanislav Fomichev <sdf@google.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
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

On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
> >
> > Stanislav Fomichev <sdf@google.com> writes:
> >
> > > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
> > >>
> > >> Stanislav Fomichev <sdf@google.com> writes:
> > >>
> > >> > I'd like to discuss a potential follow up for the previous "XDP RX
> > >> > metadata" series [0].
> > >> >
> > >> > Now that we can access (a subset of) packet metadata at RX, I'd li=
ke to
> > >> > explore the options where we can export some of that metadata on T=
X. And
> > >> > also whether it might be possible to access some of the TX complet=
ion
> > >> > metadata (things like TX timestamp).
> > >> >
> > >> > I'm currently trying to understand whether the same approach I've =
used
> > >> > on RX could work at TX. By May I plan to have a bunch of options l=
aid
> > >> > out (currently considering XSK tx/compl programs and XDP tx/compl
> > >> > programs) so we have something to discuss.
> > >>
> > >> I've been looking at ways of getting a TX-completion hook for the XD=
P
> > >> queueing stuff as well. For that, I think it could work to just hook
> > >> into xdp_return_frame(), but if you want to access hardware metadata
> > >> it'll obviously have to be in the driver. A hook in the driver could
> > >> certainly be used for the queueing return as well, though, which may
> > >> help making it worth the trouble :)
> > >
> > > Yeah, I'd like to get to completion descriptors ideally; so nothing
> > > better than a driver hook comes to mind so far :-(
> > > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so f=
ar).
> >
> > Is there any other use case for this than getting the TX timestamp? Not
> > really sure what else those descriptors contain...
>
> I don't think so; at least looking at mlx5 and bnxt (the latter
> doesn't have a timestamp in the completion ring).
> So yeah, not sure, maybe that should be on the side and be AF_XDP specifi=
c.
> And not even involve bpf, just put the tx tstamp somewhere in umem:
> setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
> &data_relative_offset, ..);
> OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
> have for eternity? (plus, this needs a driver "hook" for af_xdp
> anyway, so why not make it generic?)
>
> > >> > I'd like to some more input on whether applying the same idea on T=
X
> > >> > makes sense or not and whether there are any sensible alternatives=
.
> > >> > (IIRC, there was an attempt to do XDP on egress that went nowhere)=
.
> > >>
> > >> I believe that stranded because it was deemed not feasible to cover =
the
> > >> SKB TX path as well, which means it can't be symmetrical to the RX h=
ook.
> > >> So we ended up with the in-devmap hook instead. I'm not sure if that=
's
> > >> made easier by multi-buf XDP, so that may be worth revisiting.
> > >>
> > >> For the TX metadata you don't really have to care about the skb path=
, I
> > >> suppose, so that may not matter too much either. However, at least f=
or
> > >> the in-kernel xdp_frame the TX path is pushed from the stack anyway,=
 so
> > >> I'm not sure if it's worth having a separate hook in the driver (wit=
h
> > >> all the added complexity and overhead that entails) just to set
> > >> metadata? That could just as well be done on push from higher up the
> > >> stack; per-driver kfuncs could still be useful for this, though.
> > >>
> > >> And of course something would be needed so that that BPF programs ca=
n
> > >> process AF_XDP frames in the kernel before they hit the driver, but
> > >> again I'm not sure that needs to be a hook in the driver.
> > >
> > > Care to elaborate more on "push from higher up the stack"?
> >
> > I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitted
> > by the stack calling ndo_xdp_xmit() in the driver with an array of
> > frames that are immediately put on the wire (see bq_xmit_all() in
> > devmap.c). So any metadata writing could be done at that point, since
> > the target driver is already known; there's even already a program hook
> > in there (used for in-devmap programs).
> >
> > > I've been thinking about mostly two cases:
> > > - XDP_TX - I think this one technically doesn't need an extra hook;
> > > all metadata manipulations can be done at xdp_rx? (however, not sure
> > > how real that is, since the descriptors are probably not exposed over
> > > there?)
> >
> > Well, to me XDP_REDIRECT is the most interesting one (see above). I
> > think we could even drop the XDP_TX case and only do this for
> > XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
> > I.e., it's possible to XDP_REDIRECT back to the same device, the frames
> > will just take a slight detour up through the stack; but that could als=
o
> > be a good thing if it means we'll have to do less surgery to the driver=
s
> > to implement this for two paths.
> >
> > It does have the same challenge as you outlined above, though: At that
> > point the TX descriptor probably doesn't exist, so the driver NDO will
> > have to do something else with the data; but maybe we can solve that
> > without moving the hook into the driver itself somehow?
>
> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
> with a skb-like-private metadata layout (as we've discussed previously
> for skb) here as well? But not sure it would solve all the problems?
> I'm thinking of an af_xdp case where it wants to program something
> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
> support)

We have a patch set of this in the works. Need to finish the last
couple of tests then optimize performance and it is good to go. We
should be able to post it during the next cycle that starts next week.

Having tso/encap/tunneling and checksum offload accessible in the
AF_XDP Tx path would indeed be very useful.

> or a checksum offload. Exposing access to the driver tx hooks
> seems like the easiest way to get there?
>
> > > - AF_XDP TX - this one needs something deep in the driver (due to tx
> > > zc) to populate the descriptors?
> >
> > Yeah, this one is a bit more challenging, but having a way to process
> > AF_XDP frames in the kernel before they're sent out would be good in an=
y
> > case (for things like policing what packets an AF_XDP application can
> > send in a cloud deployment, for instance). Would be best if we could
> > consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...
> >
> > > - anything else?
> >
> > Well, see above ;)
> >
> > >> In any case, the above is just my immediate brain dump (I've been
> > >> mulling these things over for a while in relation to the queueing
> > >> stuff), and I'd certainly welcome more discussion on the subject! :)
> > >
> > > Awesome, thanks for the dump! Will try to keep you in the loop!
> >
> > Great, thanks!
> >
> > -Toke
