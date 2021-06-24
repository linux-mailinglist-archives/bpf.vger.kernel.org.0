Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD63F3B33FA
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFXQfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXQfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 12:35:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC6C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:32:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i5so9463628eds.1
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=egTn1FMlmfeT/dzjOjUkqCgglPdHX6smEmjVmtwYYpA=;
        b=J3y0j1hRnhYICVsBxXMLeCrB3M60/h40pRx306wCOE3cVJCNieS2swU8CMiTcLPko7
         8FTuPl9yE5W1tk7TM1heA7z2x9IWe5mcz2W9IhIhI3qd328UtRaOwt5K1tUej5atA08q
         XP/cIZWshDEjbMqvEgJMWAyoWzkOTLAmd8Jno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=egTn1FMlmfeT/dzjOjUkqCgglPdHX6smEmjVmtwYYpA=;
        b=gL0KuC+uLQFAHTN3Go/rJF+vsqDtVzFzdX5cZUuCeBOtFZcSH33TuADle+ZwrXAK4j
         cVq4meXmhaDRrgJjfklA2eaXurJd3ESWx3RPogGwTb9nhwsubGHRzf6WvRB3QsmxyvvS
         ZdbUlw8Fkwn/BuzIlpawxF0N2Y5hzEFuzZ5vNcjFRI80HqdPNlDd3ImHKm6gvsrSCT7y
         dCY03b91lggV2B97P015ORz0l7F+cbDM2OZEm8jhh7Jjmy1lhKJbIg9p2e3x+0SJI8U8
         +0fsHfJsMqgtdhTHSNpdQoZSjmLlQy90iz9YZ4fdCpThRW/kpLezX0n/7BUAFsz3KUp1
         nhFA==
X-Gm-Message-State: AOAM532yBygTziqY7pyKL9P5x/vajFvBgu7Nv1vpHGT3P24MWVg7oYUX
        cClDtJdc2AZN7dThxbQqBvNPFyLuO6YQTkX16oXEEg==
X-Google-Smtp-Source: ABdhPJyiONROmRKGRUmzfB1dHub6FXXe5vmme2LJzdtNFlgbzMncch0hvHwMdCw38Pn7jFok1j2F/nprcPLOmU0YJwg=
X-Received: by 2002:aa7:cc87:: with SMTP id p7mr8384240edt.82.1624552376726;
 Thu, 24 Jun 2021 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk> <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon> <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk> <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <CAC1LvL0i6mY2pAuNriwA_CWmxpO=VHoRHGfMK6ovp3LUt43g1g@mail.gmail.com> <878s2zmeov.fsf@toke.dk>
In-Reply-To: <878s2zmeov.fsf@toke.dk>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 24 Jun 2021 09:32:44 -0700
Message-ID: <CAC1LvL3P3KoWOvCbskFB-DbHZ_U1HTBpjJJg_ikdPVBnt2hREQ@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 9:05 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Zvi Effron via xdp-hints <xdp-hints@xdp-project.net> writes:
>
> > On Thu, Jun 24, 2021 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> >>
> >> > On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:[..]
> >> >
> >> > Sorry, but I feel that I don't fully understand the idea. Correct me=
 if
> >> > I am wrong:
> >> >
> >> > In building CO-RE application step we can defined big struct with
> >> > all possible fields or even empty struct (?) and use
> >> > bpf_core_field_exists.
> >> >
> >> > bpf_core_field_exists will be resolve before loading program by libb=
pf
> >> > code. In normal case libbpf will look for btf with hints name in vml=
inux
> >> > of running kernel and do offset rewrite and exsistence check. But as=
 the
> >> > same hints struct will be define in multiple modules we want to add =
more
> >> > logic to libbpf to discover correct BTF ID based on netdev on which =
program
> >> > will be loaded?
> >>
> >> I would expect that the program would decide ahead-of-time which BTF I=
Ds
> >> it supports, by something like including the relevant structs from
> >> vmlinux.h. And then we need the BTF ID encoded into the packet metadat=
a
> >> as well, so that it is possible to check at run-time which driver the
> >> packet came from (since a packet can be redirected, so you may end up
> >> having to deal with multiple formats in the same XDP program).
> >>
> >> Which would allow you to write code like:
> >>
> >> if (ctx->has_driver_meta) {
> >>   /* this should be at a well-known position, like first (or last) in =
meta area */
> >>   __u32 *meta_btf_id =3D ctx->data_meta;
> >>
> >>   if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
> >>     struct meta_mlx5 *meta =3D ctx->data_meta;
> >>     /* do something with meta */
> >>   } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
> >>     struct meta_i40e *meta =3D ctx->data_meta;
> >>     /* do something with meta */
> >>   } /* etc */
> >> }
> >>
> >> and libbpf could do relocations based on the different meta structs,
> >> even removing the code for the ones that don't exist on the running
> >> kernel.
> >>
> >> -Toke
> >>
> >
> > How does putting the BTF ID and the driver metadata into the XDP metada=
ta
> > section interact with programs that are already using the metadata sect=
ion
> > for other purposes. For example, programs that use the XDP metadata to =
pass
> > information through BPF tail calls?
> >
> > Would this break existing programs that aren't aware of the new driver
> > metadata? Do we need to make driver metadata opt-in at XDP program
> > load?
>
> Well, XDP applications would be free to just ignore the driver-provided
> metadata and overwrite it with its own data? And I guess any application
> that doesn't know about it will just implicitly do that? :)
>
> -Toke
>

Ah, right, because bpf_xdp_adjust_meta() moves ctx->data_meta earlier in
the buffer. That would mean that if the BTF ID were stored in the metadata
it would have to be the last position in the metadata or
bpf_xdp_adjust_meta() would make it impossible to find for subsequent
programs (specifically, tail calls).

Or, potentially, we could put the BTF ID into struct xdp_md. In your code
sample, there's already a new has_driver_meta field added to that struct.
I believe that could instead just be the BTF ID, and a value of 0 (I believ=
e
that's an invalid BTF ID?) would indicate no driver metadata.

That would change your sample to:

__u32 meta_btf_id =3D ctx->driver_meta_btf_id;

if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
  struct meta_mlx5 *meta =3D ctx->data_meta;
  /* do something with meta */
} else if (meta_btf_id =3D=3D BTF_ID_I40E) {
  struct meta_i40e *meta =3D ctx->data_meta;
  /* do something with meta */
} else if (meta_btf_id =3D=3D BTF_ID_INVALID /* 0 */) {
  /* there is no driver metadata */
} /* etc */

The current limit on metadata size would also likely need to be adjusted
to allow for current uses (that could potentially be using all of the
metadata) as well as the driver metadata and BTF ID.

--Zvi
