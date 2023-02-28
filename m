Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C966A6120
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjB1VTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 16:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB1VTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 16:19:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2015562
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 13:18:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so10553088pjg.4
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677619138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiiIN1DJhIa0bB6VhNi2A9WBRr8Sqv6cSKXJm24YK80=;
        b=ln9o1eiiMWsfSzYxrqXwNO0INyJa+49niZ4jJRB8auMHwR5Xz2nqUzVeKi2Votk+qP
         K3FEZzx0HKxg2Tpa+XCOGlL6wao6GFe1MA070Mj8l4EzXTuSrI/e2qfIEF2Wj906CA3+
         rl4WT8HzbFib5DEzpzi5dD3pF8Iyu4SmvsSOW0JdKo6aI/pcxZ4PyGWAfgcjCZd0Lo9r
         YZmqMhKQIiECKPjnn6IHWWUYSlpKnCwgDJEAzaTwzScXyj7++chL6Q9zzCxvYexrfbLX
         emUKzs/1NxyjtSJDQTmDa7n9kJsEtTd9n01LxNdDjPMdLZUxFn4u1reahJH+PeXBTIYs
         kETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiiIN1DJhIa0bB6VhNi2A9WBRr8Sqv6cSKXJm24YK80=;
        b=bBojzdlArgZ8AubuKZyjB3U4dxClti20EpaEuw7eZnyRENGRzCqMYeb3w5sth7Bnf+
         1z7nOgJV6lXPMwm97+nTYqMRzJkmAQ+nvWtrDVAa3BY3Dby2WLjVrKytcTDNDOb25uet
         uh4Y2eHG8w+Hq+4qqD5dDhdWqkuTOKHVufap729t7JjzpVhc2cEcd8hDz2FGekGsOe19
         dptFA64Gk8E9aODLrJpv7d+4JuuYDNVFhlfPripgu89pjPmhhZUVjto/+i5UnTrCSMW8
         2SnwJ/zJyCuojn4riU1FboLsC0l4ivqMJfZ8VbWjGcO6ri5RVb/p70Ne6evlMl4mojUN
         /O1Q==
X-Gm-Message-State: AO0yUKX7vZFQpRwb9ihgptL+BiVWaHQWQ/SAqo6djA5tueA7yblWV23q
        /O4C1Gsv0118xDs/OBVWZtUJQAFam+6Q28Maz8bqlbutHRPq6Gbx
X-Google-Smtp-Source: AK7set/8SmfT6LiqNfWxpVeF/tYUCIbQVGwZEfSRE+i7oWJHR3bDHxLLQTgToeRBKypd+ghxAaDrCMcBGBJJ2LtRZow=
X-Received: by 2002:a17:90a:8a04:b0:237:9ca5:4d5d with SMTP id
 w4-20020a17090a8a0400b002379ca54d5dmr1680256pjn.6.1677619137483; Tue, 28 Feb
 2023 13:18:57 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk> <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <87zg8yis0h.fsf@toke.dk>
In-Reply-To: <87zg8yis0h.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 28 Feb 2023 13:18:46 -0800
Message-ID: <CAKH8qBvzhuaZzEbWT1_4pDuiE7ZooJ6tZJFLZJctqLrEFQ_YrA@mail.gmail.com>
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

On Mon, Feb 27, 2023 at 3:54 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
kernel.org> wrote:
> >>
> >> Stanislav Fomichev <sdf@google.com> writes:
> >>
> >> > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
> >> >>
> >> >> Stanislav Fomichev <sdf@google.com> writes:
> >> >>
> >> >> > I'd like to discuss a potential follow up for the previous "XDP R=
X
> >> >> > metadata" series [0].
> >> >> >
> >> >> > Now that we can access (a subset of) packet metadata at RX, I'd l=
ike to
> >> >> > explore the options where we can export some of that metadata on =
TX. And
> >> >> > also whether it might be possible to access some of the TX comple=
tion
> >> >> > metadata (things like TX timestamp).
> >> >> >
> >> >> > I'm currently trying to understand whether the same approach I've=
 used
> >> >> > on RX could work at TX. By May I plan to have a bunch of options =
laid
> >> >> > out (currently considering XSK tx/compl programs and XDP tx/compl
> >> >> > programs) so we have something to discuss.
> >> >>
> >> >> I've been looking at ways of getting a TX-completion hook for the X=
DP
> >> >> queueing stuff as well. For that, I think it could work to just hoo=
k
> >> >> into xdp_return_frame(), but if you want to access hardware metadat=
a
> >> >> it'll obviously have to be in the driver. A hook in the driver coul=
d
> >> >> certainly be used for the queueing return as well, though, which ma=
y
> >> >> help making it worth the trouble :)
> >> >
> >> > Yeah, I'd like to get to completion descriptors ideally; so nothing
> >> > better than a driver hook comes to mind so far :-(
> >> > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so =
far).
> >>
> >> Is there any other use case for this than getting the TX timestamp? No=
t
> >> really sure what else those descriptors contain...
> >
> > I don't think so; at least looking at mlx5 and bnxt (the latter
> > doesn't have a timestamp in the completion ring).
> > So yeah, not sure, maybe that should be on the side and be AF_XDP speci=
fic.
> > And not even involve bpf, just put the tx tstamp somewhere in umem:
> > setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
> > &data_relative_offset, ..);
> > OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
> > have for eternity? (plus, this needs a driver "hook" for af_xdp
> > anyway, so why not make it generic?)
>
> So since this is read-only in any case, we could just make it a
> tracepoint instead of a whole new hook? That's what I was planning to do
> for xdp_return_frame(); we just need a way to refer back to the original
> frame, but we'd need to solve that anyway. Just letting XDP/AF_XDP
> specify their own packet ID in some form, and make that part of the
> tracepoint data, would probably be sufficient?

That would probably mean a driver specific tracepoint (since we might
need to get to the completion queue descriptor)?
Idk, probably still makes sense to have something that works across
different drivers?
Or are you suggesting to just do fentry/mlx5e_free_xdpsq_desc and go from t=
here?
Not sure I can get a umem frame, as you've mentioned; and also it
doesn't look like cqe is there...
I guess the fact that it would arrive out-of-band (not in a umem
frame) is a minor inconvenience, the userspace should be able to join
the data together hopefully.

> >> >> > I'd like to some more input on whether applying the same idea on =
TX
> >> >> > makes sense or not and whether there are any sensible alternative=
s.
> >> >> > (IIRC, there was an attempt to do XDP on egress that went nowhere=
).
> >> >>
> >> >> I believe that stranded because it was deemed not feasible to cover=
 the
> >> >> SKB TX path as well, which means it can't be symmetrical to the RX =
hook.
> >> >> So we ended up with the in-devmap hook instead. I'm not sure if tha=
t's
> >> >> made easier by multi-buf XDP, so that may be worth revisiting.
> >> >>
> >> >> For the TX metadata you don't really have to care about the skb pat=
h, I
> >> >> suppose, so that may not matter too much either. However, at least =
for
> >> >> the in-kernel xdp_frame the TX path is pushed from the stack anyway=
, so
> >> >> I'm not sure if it's worth having a separate hook in the driver (wi=
th
> >> >> all the added complexity and overhead that entails) just to set
> >> >> metadata? That could just as well be done on push from higher up th=
e
> >> >> stack; per-driver kfuncs could still be useful for this, though.
> >> >>
> >> >> And of course something would be needed so that that BPF programs c=
an
> >> >> process AF_XDP frames in the kernel before they hit the driver, but
> >> >> again I'm not sure that needs to be a hook in the driver.
> >> >
> >> > Care to elaborate more on "push from higher up the stack"?
> >>
> >> I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitte=
d
> >> by the stack calling ndo_xdp_xmit() in the driver with an array of
> >> frames that are immediately put on the wire (see bq_xmit_all() in
> >> devmap.c). So any metadata writing could be done at that point, since
> >> the target driver is already known; there's even already a program hoo=
k
> >> in there (used for in-devmap programs).
> >>
> >> > I've been thinking about mostly two cases:
> >> > - XDP_TX - I think this one technically doesn't need an extra hook;
> >> > all metadata manipulations can be done at xdp_rx? (however, not sure
> >> > how real that is, since the descriptors are probably not exposed ove=
r
> >> > there?)
> >>
> >> Well, to me XDP_REDIRECT is the most interesting one (see above). I
> >> think we could even drop the XDP_TX case and only do this for
> >> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
> >> I.e., it's possible to XDP_REDIRECT back to the same device, the frame=
s
> >> will just take a slight detour up through the stack; but that could al=
so
> >> be a good thing if it means we'll have to do less surgery to the drive=
rs
> >> to implement this for two paths.
> >>
> >> It does have the same challenge as you outlined above, though: At that
> >> point the TX descriptor probably doesn't exist, so the driver NDO will
> >> have to do something else with the data; but maybe we can solve that
> >> without moving the hook into the driver itself somehow?
> >
> > Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
> > "transmit something out of xdp_rx hook" umbrella. We can maybe come up
> > with a skb-like-private metadata layout (as we've discussed previously
> > for skb) here as well? But not sure it would solve all the problems?
> > I'm thinking of an af_xdp case where it wants to program something
> > similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
> > support) or a checksum offload. Exposing access to the driver tx hooks
> > seems like the easiest way to get there?
>
> Well, I was thinking something like exposing driver kfuncs like what you
> implemented on RX, but having the program that calls them be the one in
> the existing devmap hook (each map entry is tied to a particular netdev,
> so we could use the same type of dev-bound logic as we do on RX). The
> driver wouldn't have a TX descriptor at this point, but it could have a
> driver-private area somewhere in the xdp_frame (if we make space for it)
> which the kfuncs could just write to in whichever format it wants, so
> that copying it to the descriptor later is just a memcpy().

Yeah, that sounds similar to what we've discussed for the xdp->skb
path, right? Maybe it should be even some kind of extension to that?
On rx, we stash a bunch of metadata in that private area. If the frame
goes to the kernel stack -> put it into skb; if the frame goes back to
the wire -> the driver can parse it?

> There would still need to be a new hook for AF_XDP, but I think it could
> have the same semantics as a devmap prog (i.e., an XDP program type that
> runs right before TX, but after the destination device is selected); we
> could attach it to the socket, maybe? Doesn't have to be in the driver
> itself (just before the driver ndo is called for zc - I think?).

Sounds sensible; will try to explore more, thx!

> -Toke
