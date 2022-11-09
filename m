Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A22623752
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKIXMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKIXLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:11:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B89F3123C
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:11:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ft34so689418ejc.12
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=teNnklp1U8d6QeevKbxlWl4HOeA9d4ktWSq5mHU44No=;
        b=VLUXUImwpMgouKtEOMhvfKRlJNYkb0wyq5XUcWl/PoDhlpBnUQ7GFcCdborekigatp
         6CSW0o/qUqiCTlsXHO8jMPeFMaiaWT4uQ4EU1xnief7eurORvTGSpMjplM7hJ00ccuw5
         v8zxdBrqTEFPIoQp2k4zxc1rFC4krQXq4lnhZRDH3zS7lxVoMe+xXidJJ2FRICxubQly
         X09gpRqZmW96McyhaFOAlaPFuqW4BVkxiOusarR9mImlVrpJHUnhYn0OC+q0X0qWoOg4
         gOqiwYidG8vj4BWBze2kUbdZJyu/PsfjOA8mzecZncIYW0I66C03UG/AISrUhNiO6bxe
         axhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teNnklp1U8d6QeevKbxlWl4HOeA9d4ktWSq5mHU44No=;
        b=O6HOsfcXiWyfLqNMa1wg99X+MXyi7Th2KYZh+tu3OG4cEtjWEjthj8NtzS+Hk/PyKZ
         gCtlEXGBiEnmVCDIn93FW/l6loA6Y7iXvRNM33CGLuKwcYnndhZ9kLDXY9kZjJdFJ6xl
         mk4kxjWPKZVgRwF5HwOIsqNf0sbq2VDhUDJGAxMHPw/eoEolJKyBzX+EYWeBzE1imJr5
         h2ucqbxQaPS5khRkmW5gL469jpZWl1JmKTvg5nSrC0SAJ+LFkVx5WmEpQilUiR57dIh1
         SDLGoZ8em7QdqjrT79Cjq4ThF+aoeUvc3McVlj//whdXSv0n3nOJlygewIV84nBQ032J
         X5YA==
X-Gm-Message-State: ANoB5pni73MZYEPY+w/724oIBt0hLN8iAqEftInwjiaHIfxrcIqrTbM1
        zOsqz8in7Bm51SND4leoAbSemNXq5HgKMaPTers=
X-Google-Smtp-Source: AA0mqf7fAm4y29w7t3tLwoDOaQGq120hqoDhFnVwmlhNa8gjzrRkXpNOUzNSBEFGn2R3jKlAxPdzZQW2YM90L6D6cKw=
X-Received: by 2002:a17:906:4e86:b0:7ae:8d01:81f8 with SMTP id
 v6-20020a1709064e8600b007ae8d0181f8mr4032929eju.115.1668035486406; Wed, 09
 Nov 2022 15:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
 <20221108233944.o6ktnoinaggzir7t@apollo> <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
 <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com>
In-Reply-To: <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:11:14 -0800
Message-ID: <CAEf4BzbR-GjtjXi4mZTdya9gidPBsSi8hn3MJ7+G5J_r4iw5xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map values
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 5:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 8, 2022 at 4:23 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > > >  struct bpf_offload_dev;
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 94659f6b3395..dd381086bad9 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> > > > >         __u64 :64;
> > > > >  } __attribute__((aligned(8)));
> > > > >
> > > > > +struct bpf_list_head {
> > > > > +       __u64 :64;
> > > > > +       __u64 :64;
> > > > > +} __attribute__((aligned(8)));
> > > > > +
> > > > > +struct bpf_list_node {
> > > > > +       __u64 :64;
> > > > > +       __u64 :64;
> > > > > +} __attribute__((aligned(8)));
> > > >
> > > > Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> > > > alignment information, as the struct itself is empty, and so there is
> > > > nothing indicating that it has to be 8-byte aligned.
>
> Since it's not a new issue let's fix it for all.
> Whether it's a combination of pahole + bpftool or just pahole.

So yeah, I was expecting if we do this, we'd do this for all opaque
BPF UAPI structs like this (bpf_spin_lock and others), of course.

>
> > > >
> > > > So what if we have
> > > >
> > > > struct bpf_list_node {
> > > >     __u64 __opaque[2];
> > > > } __attribute__((aligned(8)));
> > > >
> > > > ?
> > > >
> > >
> > > Yep, can do that. Note that it's also potentially an issue for existing cases,
> > > like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> > > things now is possible, but if it is, we should probably make it for all of
> > > them?
> >
> > Why not? We are not removing anything or changing sizes, so it's
> > backwards compatible.
> > But I have a suspicion Alexei might not like
> > this __opaque field, so let's see what he says.
>
> I prefer to fix them all at once without adding a name.
>

This is not an issue with BTF per se.

struct blah {
  u64: 64
};

is just an empty struct blah with 8-byte size. Both BTF and DWARF will
record it as just

struct blah {
}

and record it's size as 8 bytes.

With that, there is nothing to suggest that this struct has to have
8-byte alignment.

If we mark explicitly __attribute__((aligned(8))) then DWARF will
additionally record alignment=8 for such struct. BTF doesn't record
alignment, though.

adding u64 fields internally will make libbpf recognize that struct
needs at least 8-byte alignment, which is what I propose as a simple
solution.

Alternatives are:
 - extend BTF to record struct/union alignments in BTF_KIND_{STRUCT,UNION}
 - record __attribute__((aligned(8))) as a new KIND (BTF_KIND_ATTRIBUTE)

Both seem like a bit of an overkill, given the work around is to have
u64 __opaque[] fields, which we won't have to remove or rename ever
(because those fields are not used).

> >
> > > > >                 off = vsi->offset;
> > > > > +               if (i && !off)
> > > > > +                       return -EFAULT;
> > > >
> > > > similarly, I'd say that either we'd need to calculate the exact
> > > > expected offset, or just not do anything here?
> > > >
> > >
> > > This thread is actually what prompted this check:
> > > https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com
> > >
> > > Unless loaded using libbpf all offsets are zero. So I think we need to reject it
> > > here, but I think the same zero sized field might be an issue for this as well,
> > > so maybe we remember the last field size and check whether it was zero or not?
> > >
> > > I'll also include some more tests for these cases.
> >
> > The question is whether this affects correctness from the verifier
> > standpoint? If it does, there must be some other place where this will
> > cause problem and should be caught and reported.
>
> If it's an issue with BTF then we should probably check it
> during generic datasec verification.
> Here it's kinda late to warn.

+1 and do it more properly than forcing it to be non-zero

>
> > My main objection is that it's half a check, we check that it's
> > non-zero, but we don't check that it is correct in stricter sense. So
> > I'd rather drop it altogether, or go all the way to check that it is
> > correct offset (taking into account sizes of previous vars).
