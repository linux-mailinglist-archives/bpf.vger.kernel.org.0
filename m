Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ACD573E2C
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiGMUvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiGMUvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:51:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967FF31220
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:51:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g1so15619093edb.12
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qamUMHquv+ZhyWKBvmSWCtkoZB9la1HcTES1jzfiU4o=;
        b=AbET/nUyPIP/tZxDrP2cNnnQ8CKbtG6KOajTOXMEb+i80oLoJzwuMwUZh8GnCKPaJP
         7ri0rAyCBw3uP0b+1/P0sa5gGkeE2FYJBGuE9q2abUL9zI47qWEE5x3oZjgwgKgFgtk4
         kEYRsjcxasQaAgqU+hQjBbAUSGi9/FDSafEgFE+JmC35fJoJZZ86qzh/+KKyovDU/GCc
         mw/ECXGmZgYrix5jV0ZQKgUdncIGOOHILgsMNS5s0+C5a+BeKQwYU2+TD5QTnal51OWd
         IkmpGLx2skD5GBU5CHcTP8KrKOOa5ThZuOeoe4HDLnjSaF2j3W7oXknjtleJa8mGxzan
         ticw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qamUMHquv+ZhyWKBvmSWCtkoZB9la1HcTES1jzfiU4o=;
        b=yjkhuuiBPuq9JiUHVaZPIwXLCQ15G7BLxoK5f34KD4QWoOKM67FyIvZX8N/qwSyIQt
         L0XOspopG6uJi+z0I2Ri2BbBhvvEKVxb02TYb1fVmDcM4XYE+hDfw7KSyVWvWQw05NfK
         bwePivXScMxUOaeCGxWrIR9XXnDnvC95615INd4fAF/3asXi6bgPqoXvVhDI89OhEBpH
         7pmTt5BmgmfAulpeaG33yN9c24bZ+y0ZPE6dvuLel5dnybjp4F5T6h1rsmvOIjTJvRaS
         19GA4ZqJmKnOqCIOUeBdq3+1dhciIKrp/tjxCGFe63Ew/u0n7SvrlCX2cdfHozZhzfk7
         sY5A==
X-Gm-Message-State: AJIora8E90s8ynfEJb1doKxnD3qEpYFOmiQTiL7GqZgbz+K4QGT/Vlxx
        V9lx9s+8Kasi0gHgSYPJoQv64acmaWv859i4Jgs=
X-Google-Smtp-Source: AGRyM1sIx64SkNRk5TX43JD7H1HSmDAcIpq7Vkr73Snd6J2rLxEworw2fldzPDlYKM6OmEtHxbvYgKUDCgwXX7ZU91I=
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id
 ef4-20020a05640228c400b0043acddee047mr7412264edb.368.1657745460134; Wed, 13
 Jul 2022 13:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220713012621.2485047-1-joannelkoong@gmail.com> <cc84acdc-9221-2d99-f65a-fd9d0de87e32@iogearbox.net>
In-Reply-To: <cc84acdc-9221-2d99-f65a-fd9d0de87e32@iogearbox.net>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 13 Jul 2022 13:50:48 -0700
Message-ID: <CAJnrk1YbMVPq0x8Gy2WOZhE5fnhrKd+QF=fTftnqVfLa-_bK_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Fix bpf/sk_skb_pull_data for flags == 0
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 12:23 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/13/22 3:26 AM, Joanne Koong wrote:
> > In the case where flags is 0, bpf_skb_pull_data and sk_skb_pull_data
> > should pull the entire skb payload including the bytes in the non-linear
> > page buffers.
> >
> > This is documented in the uapi:
> > "If a zero value is passed for *len*, then the whole length of the *skb*
> > is pulled"
> >
> > Fixes: 36bbef52c7eb6 ("bpf: direct packet write and access for helpers
> > for clsact progs")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> This is not correct. We should fix the helper doc fa15601ab31e ("bpf: add
> documentation for eBPF helpers (33-41)"). It will make the head private
> for writing (e.g. for direct packet access), but not linearize the entire
> skb, so skb_headlen is correct here.
>
Great, I'll fix up the uapi doc. I'll change it to something like: "If
a zero value is passed for *len*, then all bytes in the head of the
skb will be made readable and writable".
> > ---
> >   net/core/filter.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 4ef77ec5255e..97eb15891bfc 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -1838,7 +1838,7 @@ BPF_CALL_2(bpf_skb_pull_data, struct sk_buff *, skb, u32, len)
> >        * access case. By this we overcome limitations of only current
> >        * headroom being accessible.
> >        */
> > -     return bpf_try_make_writable(skb, len ? : skb_headlen(skb));
> > +     return bpf_try_make_writable(skb, len ? : skb->len);
> >   }
> >
> >   static const struct bpf_func_proto bpf_skb_pull_data_proto = {
> > @@ -1878,7 +1878,7 @@ BPF_CALL_2(sk_skb_pull_data, struct sk_buff *, skb, u32, len)
> >        * access case. By this we overcome limitations of only current
> >        * headroom being accessible.
> >        */
> > -     return sk_skb_try_make_writable(skb, len ? : skb_headlen(skb));
> > +     return sk_skb_try_make_writable(skb, len ? : skb->len);
> >   }
> >
> >   static const struct bpf_func_proto sk_skb_pull_data_proto = {
> >
>
