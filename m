Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87D6A4BED
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 21:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjB0UDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 15:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjB0UDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 15:03:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD79EE1
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:03:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 16so4272511pge.11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeBZJ4szCaozDZ5PKKJ+tCIuZcx51BR1ggTphMXA5LE=;
        b=PrTndjDL1BS0ztzQ4rIfnYJ0xd7H1501Fn0pgIRWshZm3quj9A4LqdkcsEN2cP9UBQ
         Kwxe/SSxlgKG4OgCW2riCCBIPP8lKtzb28PuwW/aHSo7Pum+JYEujdNG8OIOnwtrLpqB
         +tm1/d48VFQo+BzrPSGGYlNp6beKXEl3rmjvQax5y1Xjdiw9g5TgHr/przF7xz/oQeG7
         Ni9ZrquaiiLkEC4DV8GqErHZPQXg86KF43o8NF/w1Ju1C0w0qBoR7r4eL/i88jtm+lqG
         hnuk7rwpZbzCE2UKDn4r6MP7dNHAZSa5Rgh7fIirPiGszSeMjmMudYtJ6ESIOod6XEJo
         o+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeBZJ4szCaozDZ5PKKJ+tCIuZcx51BR1ggTphMXA5LE=;
        b=G2PqGMOa13TFYxz0x/ESmD9IfcvwyTuZPkl5e0AJFkhs7lP7Rrx2j/T1A87ALOiJ3T
         L0l/n8JijUBeZR/KriJgj8Jj8RnJ0SKpI7rrZy4l0On1nC+jw2sreRySkgsmzIuIb7OR
         GdtEAEM3zjFvgArfa2r1GM8MZomlkAkdQoVBavEmrQhdUr3nth/COuQGf9H4mPAj+0D2
         VFVt+HCkzk2z9pDsMg/FAnZmgtZRYfHG8bhF1vXI4tKWp7788GQiblNiL6R+fx8FT0Ro
         0I7Dkrrsd3MORZEPSX/lig1FhjQuAG2AqesuPbrmYbB2JgFb71r4zNT74g8hiRBAtgcW
         xIQA==
X-Gm-Message-State: AO0yUKV8IGIFxNCFuzuO60H2UeLijeCD66ZG0bHrJYNtwTWgBbHTucp3
        CZ5OHPEqQrfAgk/5vL9eso1GefPUS/G5nlT6wOFytBRY+qg1lj3Z
X-Google-Smtp-Source: AK7set/TTkCm/GlRM5Ue+tL580RR3UdT3GwK0GKrnAdouPdl5jRcMnVPhavaBwKbwHnUX2Q+Fgj+taSC+zdMIhDtl2c=
X-Received: by 2002:a63:3f84:0:b0:503:2d50:5bf1 with SMTP id
 m126-20020a633f84000000b005032d505bf1mr2565679pga.7.1677528224544; Mon, 27
 Feb 2023 12:03:44 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com> <878rgjjipq.fsf@toke.dk>
In-Reply-To: <878rgjjipq.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 27 Feb 2023 12:03:32 -0800
Message-ID: <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
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

On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
kernel.org> wrote:
> >>
> >> Stanislav Fomichev <sdf@google.com> writes:
> >>
> >> > I'd like to discuss a potential follow up for the previous "XDP RX
> >> > metadata" series [0].
> >> >
> >> > Now that we can access (a subset of) packet metadata at RX, I'd like=
 to
> >> > explore the options where we can export some of that metadata on TX.=
 And
> >> > also whether it might be possible to access some of the TX completio=
n
> >> > metadata (things like TX timestamp).
> >> >
> >> > I'm currently trying to understand whether the same approach I've us=
ed
> >> > on RX could work at TX. By May I plan to have a bunch of options lai=
d
> >> > out (currently considering XSK tx/compl programs and XDP tx/compl
> >> > programs) so we have something to discuss.
> >>
> >> I've been looking at ways of getting a TX-completion hook for the XDP
> >> queueing stuff as well. For that, I think it could work to just hook
> >> into xdp_return_frame(), but if you want to access hardware metadata
> >> it'll obviously have to be in the driver. A hook in the driver could
> >> certainly be used for the queueing return as well, though, which may
> >> help making it worth the trouble :)
> >
> > Yeah, I'd like to get to completion descriptors ideally; so nothing
> > better than a driver hook comes to mind so far :-(
> > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so far=
).
>
> Is there any other use case for this than getting the TX timestamp? Not
> really sure what else those descriptors contain...

I don't think so; at least looking at mlx5 and bnxt (the latter
doesn't have a timestamp in the completion ring).
So yeah, not sure, maybe that should be on the side and be AF_XDP specific.
And not even involve bpf, just put the tx tstamp somewhere in umem:
setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
&data_relative_offset, ..);
OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
have for eternity? (plus, this needs a driver "hook" for af_xdp
anyway, so why not make it generic?)

> >> > I'd like to some more input on whether applying the same idea on TX
> >> > makes sense or not and whether there are any sensible alternatives.
> >> > (IIRC, there was an attempt to do XDP on egress that went nowhere).
> >>
> >> I believe that stranded because it was deemed not feasible to cover th=
e
> >> SKB TX path as well, which means it can't be symmetrical to the RX hoo=
k.
> >> So we ended up with the in-devmap hook instead. I'm not sure if that's
> >> made easier by multi-buf XDP, so that may be worth revisiting.
> >>
> >> For the TX metadata you don't really have to care about the skb path, =
I
> >> suppose, so that may not matter too much either. However, at least for
> >> the in-kernel xdp_frame the TX path is pushed from the stack anyway, s=
o
> >> I'm not sure if it's worth having a separate hook in the driver (with
> >> all the added complexity and overhead that entails) just to set
> >> metadata? That could just as well be done on push from higher up the
> >> stack; per-driver kfuncs could still be useful for this, though.
> >>
> >> And of course something would be needed so that that BPF programs can
> >> process AF_XDP frames in the kernel before they hit the driver, but
> >> again I'm not sure that needs to be a hook in the driver.
> >
> > Care to elaborate more on "push from higher up the stack"?
>
> I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitted
> by the stack calling ndo_xdp_xmit() in the driver with an array of
> frames that are immediately put on the wire (see bq_xmit_all() in
> devmap.c). So any metadata writing could be done at that point, since
> the target driver is already known; there's even already a program hook
> in there (used for in-devmap programs).
>
> > I've been thinking about mostly two cases:
> > - XDP_TX - I think this one technically doesn't need an extra hook;
> > all metadata manipulations can be done at xdp_rx? (however, not sure
> > how real that is, since the descriptors are probably not exposed over
> > there?)
>
> Well, to me XDP_REDIRECT is the most interesting one (see above). I
> think we could even drop the XDP_TX case and only do this for
> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
> I.e., it's possible to XDP_REDIRECT back to the same device, the frames
> will just take a slight detour up through the stack; but that could also
> be a good thing if it means we'll have to do less surgery to the drivers
> to implement this for two paths.
>
> It does have the same challenge as you outlined above, though: At that
> point the TX descriptor probably doesn't exist, so the driver NDO will
> have to do something else with the data; but maybe we can solve that
> without moving the hook into the driver itself somehow?

Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
"transmit something out of xdp_rx hook" umbrella. We can maybe come up
with a skb-like-private metadata layout (as we've discussed previously
for skb) here as well? But not sure it would solve all the problems?
I'm thinking of an af_xdp case where it wants to program something
similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
support) or a checksum offload. Exposing access to the driver tx hooks
seems like the easiest way to get there?

> > - AF_XDP TX - this one needs something deep in the driver (due to tx
> > zc) to populate the descriptors?
>
> Yeah, this one is a bit more challenging, but having a way to process
> AF_XDP frames in the kernel before they're sent out would be good in any
> case (for things like policing what packets an AF_XDP application can
> send in a cloud deployment, for instance). Would be best if we could
> consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...
>
> > - anything else?
>
> Well, see above ;)
>
> >> In any case, the above is just my immediate brain dump (I've been
> >> mulling these things over for a while in relation to the queueing
> >> stuff), and I'd certainly welcome more discussion on the subject! :)
> >
> > Awesome, thanks for the dump! Will try to keep you in the loop!
>
> Great, thanks!
>
> -Toke
