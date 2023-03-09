Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12E6B2C97
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCISFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCISE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:04:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415161AA3
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:04:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a9so2848562plh.11
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678385097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyNS/HvkNGO3HB6bTvr2A4GS1zLHx3Piz0FeFR4waQ4=;
        b=fceVk74bncNKsZ1EMlrc9i2SeNms8rV7OTopHID0PJ2tFKsLi007QoaWNNV/aGoCVZ
         jnMkLiSlogtE7LeO0rVsJSUvOFN2zMIlN2HSYEHOeFZUQX/lXLgqNu0x2fazo8fk6ng6
         uxabmS/Pu5WeWIKR8HVlogC8GRUzJ0xlL7lDP2gzLGFrLsMhYXGG/kOiZqbznyBwG8dU
         A7HIWmxEX0Agx7zZQKUHDBCgUrCQcokMlYNpXZ+gYLwnNZLRuWwEK8d9jdgWBrpHL7Vl
         dcoTcFMCFnOoE6d34NniDy098WmMQ4JE+VfFY2wlc+azg1Am+CCo4Id4C05/4FVuDj9V
         ostg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyNS/HvkNGO3HB6bTvr2A4GS1zLHx3Piz0FeFR4waQ4=;
        b=CIWfT+Ly4IEMJXzBjlqXiFI8Yk1TJ84jj0qPCh+QTRvG7wuWCxFI7xNI5RkyZl2Dx3
         Au/D1KL6uWjDEo3SxIwOv627b4Lx9JpPinix4+RhTBV2wBHBThV6NhUv0NN5uta9Lw4V
         lhNcrZWB5dQojNqM8xYjyjiaU7jIKQdlkjy8VLIEW8Rwk9cPXgIPibtovQ58GUsru+cu
         YxzuuHfCxC06pmLHMhV9SsNdwxNcXxFRP+DhIfXDHAWau35Hik3w34A9AxtvYcXTGAV6
         4siWArPOow1q7loCwnYRpSl6sjwWrKd8Ch2snArFqe33pV8Is1EkV425LzAyRNdiAnB7
         mgZA==
X-Gm-Message-State: AO0yUKVEcNPWNZq5SIf+Bg+on6spvspifKwrEoj+TPEiJ2CaGVdbXgrJ
        Q1EdfoWBN6TkyAireUKRdw3aArqHwDiqzAuatZJmZg==
X-Google-Smtp-Source: AK7set9JrQxWdXQcVMc8iSO2R01eH5+mZEmdg05RgzRd98rkXynh/4dOJf0aC1W9tc/QBlsy6nspR+Pp4CBZdtVOH5A=
X-Received: by 2002:a17:90a:f98f:b0:231:1dab:f8e with SMTP id
 cq15-20020a17090af98f00b002311dab0f8emr8428085pjb.9.1678385096961; Thu, 09
 Mar 2023 10:04:56 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk> <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com> <b09048d9-217e-ca3f-3d17-e82c146cd2df@redhat.com>
In-Reply-To: <b09048d9-217e-ca3f-3d17-e82c146cd2df@redhat.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 9 Mar 2023 10:04:45 -0800
Message-ID: <CAKH8qBuviabUfBTFg3gOfpkWc+oFvFP-NcV4g2ipn7D=C2u_2g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>, brouer@redhat.com,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
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

On Tue, Mar 7, 2023 at 11:32=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 03/03/2023 08.42, Magnus Karlsson wrote:
> > On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote=
:
> >> On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@kernel.org> wrote:
> >>> Stanislav Fomichev <sdf@google.com> writes:
> >>>> On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
> >>>>>
> >>>>> Stanislav Fomichev <sdf@google.com> writes:
> >>>>>
> >>>>>> I'd like to discuss a potential follow up for the previous "XDP RX
> >>>>>> metadata" series [0].
> >>>>>>
> >>>>>> Now that we can access (a subset of) packet metadata at RX, I'd li=
ke to
> >>>>>> explore the options where we can export some of that metadata on T=
X. And
> >>>>>> also whether it might be possible to access some of the TX complet=
ion
> >>>>>> metadata (things like TX timestamp).
> >>>>>>
>
> IMHO it makes sense to see TX metadata as two separate operations.
>
>   (1) Metadata written into the TX descriptor.
>   (2) Metadata read when processing TX completion.
>
> These operations happen at two different points in time. Thus likely
> need different BPF hooks.   Having BPF-progs running at each of these
> points in time, will allow us to e.g. implement BQL (which is relevant
> to XDP queuing effort).

I guess for (2) the question here is: is it worth having a separate
hook? Or will a simple traceepoint as Toke suggested be enough? For
BQL purposes, we can still attach a prog to that tracepoint, right?

> >>>>>> I'm currently trying to understand whether the same approach I've =
used
> >>>>>> on RX could work at TX. By May I plan to have a bunch of options l=
aid
> >>>>>> out (currently considering XSK tx/compl programs and XDP tx/compl
> >>>>>> programs) so we have something to discuss.
> >>>>>
> >>>>> I've been looking at ways of getting a TX-completion hook for the X=
DP
> >>>>> queueing stuff as well. For that, I think it could work to just hoo=
k
> >>>>> into xdp_return_frame(), but if you want to access hardware metadat=
a
> >>>>> it'll obviously have to be in the driver. A hook in the driver coul=
d
> >>>>> certainly be used for the queueing return as well, though, which ma=
y
> >>>>> help making it worth the trouble :)
> >>>>
> >>>> Yeah, I'd like to get to completion descriptors ideally; so nothing
> >>>> better than a driver hook comes to mind so far :-(
>
> As Toke mentions, I'm also hoping we could leverage or extend the
> xdp_return_frame() call.  Or implicitly add the "hook" at the existing
> xdp_return_frame() call. This is about operation (2) *reading* some
> metadata at TX completion time.

Ack, noted, thx. Although, at least for mlx5e_free_xdpsq_desc, I don't
see it being called for the af_xdp tx path. But maybe that's something
we can amend in a couple of places (so xdp_return_frame would handle
most xdp cases, and some new tbd func for af_xdp tx)?

> Can this be mapped to the RX-kfuncs approach(?), by driver extending
> (call/structs) with pointer to TX-desc + adaptor info and BPF-prog/hook
> doing TX-kfuncs calls into driver (that knows how to extract completion
> data).

Yeah, that seems like a natural thing to do here.

>
> [...]
> >>> Well, to me XDP_REDIRECT is the most interesting one (see above). I
> >>> think we could even drop the XDP_TX case and only do this for
> >>> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
> >>> I.e., it's possible to XDP_REDIRECT back to the same device, the fram=
es
> >>> will just take a slight detour up through the stack; but that could a=
lso
> >>> be a good thing if it means we'll have to do less surgery to the driv=
ers
> >>> to implement this for two paths.
> >>>
> >>> It does have the same challenge as you outlined above, though: At tha=
t
> >>> point the TX descriptor probably doesn't exist, so the driver NDO wil=
l
> >>> have to do something else with the data; but maybe we can solve that
> >>> without moving the hook into the driver itself somehow?
> >>
> >> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
> >> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
> >> with a skb-like-private metadata layout (as we've discussed previously
> >> for skb) here as well? But not sure it would solve all the problems?
>
> This is operation (1) writing metadata into the TX descriptor.
> In this case we have a metadata mapping problem, from RX on one device
> driver to TX on another device driver. As you say, we also need to map
> this SKBs, which have a fairly static set of metadata.
>
> For the most common metadata offloads (like TX-checksum, TX-vlan) I
> think it makes sense to store those in xdp_frame area (use for SKB
> mapping) and re-use these when at TX writing into the TX descriptor.

[..]

> BUT there are also metadata TX offloads offloads, like asking for a
> specific Launch-Time for at packet, that needs a more flexible approach.

Why can't these go into the same "common" xdp_frame area?

> >> I'm thinking of an af_xdp case where it wants to program something
> >> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
> >> support) or a checksum offload. Exposing access to the driver tx hooks
> >> seems like the easiest way to get there?
> >>
> >>>> - AF_XDP TX - this one needs something deep in the driver (due to tx
> >>>> zc) to populate the descriptors?
> >>>
> >>> Yeah, this one is a bit more challenging, but having a way to process
> >>> AF_XDP frames in the kernel before they're sent out would be good in =
any
> >>> case (for things like policing what packets an AF_XDP application can
> >>> send in a cloud deployment, for instance). Would be best if we could
> >>> consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...
> >>>
>
> I agree, it would be best if we can consolidate the XDP_REDIRECT and
> AF_XDP paths, else we have to re-implement the same for AF_XDP xmit path
> (and maintain both paths). I also agree that being able to police what
> packets an AF_XDP application can send is a useful feature (e.g. cloud
> deployments).
>
> Looking forward to collaborate on this work!
> --Jesper

Thank you for the comments! So it looks like two things we potentially
need to do/agree upon:
1. User-facing API. One hook + tracepoint vs two hooks (and at what
level: af_xdp vs xdp). I'll try to focus on that first (waiting for
af_xdp patches that Magnus mentioned).
2. Potentially internal refactoring to consolidate XDP_REDIRECT+AF_XDP
(seems like something we should be able to discuss as we go; aka
implementation details)
