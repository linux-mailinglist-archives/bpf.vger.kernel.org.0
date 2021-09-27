Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC241A139
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhI0VP7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhI0VP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 17:15:59 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF54C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 14:14:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z5so27049540ybj.2
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlB9Jq+7YM+VVcwWr0Qd1rqHlLAB0HoJrWYjxOkeu7E=;
        b=dB/wsPtHKLhQCbJpOm/c0NOTylzndHq3yH9BIHvECtUn0e+Wj26Z6L2UgWm09iBaEV
         1qxH8UVVDxmfgsD60A+D1At3SrotXpzF/aDnXwWIQN6Jb/jWNCR4gGz+oPj0wGvN/Ija
         gfMJpNm/8k52qvQ9fQtRuhg2VlXF576faaU+95bfXI1zzlOQ89D0G+2acQLukwXyyOXx
         zWu9nHmMKdryzgbC8Hp4gc/2n+Sj/poPF9HZy/eDJ1PdNyLDcJWweRLrBAiB2jJIBSvz
         WmOPfN79TkqlrnzCe3Ak1WoZFhXYD4IF4gvHfTAIKrxlHHz5yAO94Qo7skC30SdwJ9wf
         qXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlB9Jq+7YM+VVcwWr0Qd1rqHlLAB0HoJrWYjxOkeu7E=;
        b=pY360JpQWFrtDARpb8HvmsM7h2PyFvmO4qPFVX4dlxL69vbLvNH4F2MmqpNCyd4EUr
         aI6p7xNcGSa/CBcW57qlSzfHuJrwRoChVq/9ge/G0cbFU3iJa3wvRBOKjucPWgepPtJX
         aYVmI4YPHYuRL5YjATXeY+8vw9OcoVMuGqWy50zVt09/n/l8IIV3m27ADmIn1DZR1uFS
         jVUOELpHkEaJOXxXA5v08MD4elWAXYmr71D5y/ZHy8nQikieLddzQH5bInEEjRmMU3Bg
         aU8HyW2aTyNLNt+NxOVJzAd0EF7vCbJjWjlb8p/e2t0JkYGPJ8qXAJdYXoquhmY9Ms6S
         GNTw==
X-Gm-Message-State: AOAM530tS9ICmvp5McC5ltedb6puKHfg9Z/YobjFgJnJon3Gu+noxA+4
        0U/j2+2Jg+3EjGscOu7+9UhxAHYaW1kSqi8e1zs=
X-Google-Smtp-Source: ABdhPJxyjYH9row1DUbQn6Sp3drtjZ7HVCmizFxK7vWVf75Jokjr81N87CO3SsWyx+vqqAxms7UXRtG+5vDxjKr+7fg=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr2602003ybc.225.1632777260215;
 Mon, 27 Sep 2021 14:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp> <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com> <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com> <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 14:14:09 -0700
Message-ID: <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> >
> > That's not what I proposed. So let's say somewhere in the kernel we
> > have this variable:
> >
> > static int bpf_bloom_exists = 1;
> >
> > Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> > all its hashed bits are set in Bloom filter (it "exists"), we return
> > &bpf_bloom_exists. So it's not a NULL pointer.
>
> imo that's too much of a hack.

too bad, because this feels pretty natural in BPF code:

int my_key = 1234;

if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
    /* handle "maybe exists" */
} else {
    /* handle "definitely doesn't exist" */
}

With map->value_size == 0 verifier should be able to ensure that
whatever non-NULL pointer is returned isn't readable/writable. We
might need to fix some BPF verifier internals if that's not supported
yet, I haven't checked thoroughly.

>
> > Now, despite returning a valid pointer, it would be good to prevent
> > reading/writing from/to it in a valid BPF program. I'm hoping it is as
> > easy as just seetting map->value_size = 0 during map creation. But
> > worst case, we can let BPF program just overwrite that 1 with whatever
> > they want. It doesn't matter because the contract is that
> > bpf_map_lookup_elem() returns non-NULL for "exists" and NULL
> > otherwise.
> >
> > Now, for MAP_LOOKUP_ELEM command on user-space side. I'd say the
> > contract should be 0 return code on "exists" (and nothing is written
> > to value pointer, perhaps even disallow to specify the non-NULL value
> > pointer altogether); -ENOENT, otherwise. Again, worst-case we can
> > specify that "value_size" is 1 or 4 bytes and write 1 to it.
> >
> > Does it make sense?
> >
> >
> > BTW, for STACK/QUEUE maps, I'm not clear why we had to add
> > map_peek_elem/map_pop_elem/map_push_elem operations, to be honest.
> > They could have been pretty reasonably mapped to map_lookup_elem (peek
> > is non-destructive lookup), map_lookup_elem + some flag (pop is
> > lookup, but destructive, so flag allows "destruction"), and
> > map_update_elem (for push). map_delete_elem would be pop for when
> > value can be ignored.
> >
> > That's to say that I don't consider STACK/QUEUE maps as good examples,
> > it's rather a counter-example of maps that barely anyone is using, yet
> > it just adds clutter to BPF internals.
>
> Repurposing lookup/update ops for stack/queue and forcing bpf progs
> to pass dummy key would have looked quite ugly.

The idea was to pass non-NULL *key* pointer. For bpf_map_update_elem()
you'd pass non-NULL key and NULL value. But it's fine, we have
peek/pop/push now, might as well use them. From user-space side it's
still mapped to LOOKUP/UPDATE/DELETE commands, right? BTW, seems like
we have LOOKUP_AND_DELETE command as well which is implemented for
STACK/QUEUE maps, but not BLOOM_FILTER. I guess for consistency we'd
have to implement that one for user-space as well?

> peek/pop/push have one pointer. That pointer points to value.
> For bitset we have single pointer as well.
> So it makes perfect sense to reuse push/pop/peek and keep bitset
> as a value from the verifier side.

Ok.

> bpf_helper_defs.h could have static inline functions:
> bool bpf_bitset_clear(map, key);
> bool bpf_bitset_set(map, key);
> bool bpf_bitset_test(map, key);
>
> But they will map to FUNC_map_pop_elem/push/peek as func ids
> and will be seen as values from the verifier pov.
>
> The bpf progs might think of them as keys, but they will be value_size.
> The bitset creation could use key_size as an input, but internally
> set it as value_size.
> Not sure whether such internal vs uapi remaping will not lead
> to confusion and bugs though.

I think it will and I wouldn't do it.

> I agree that key as an input to bitset_clear/set/test make more sense,
> but the verifier needs value_size to plug into peek/pop infra.

Which is why I initially proposed to not use peek/pop infra and
instead do lookup/update/delete, but if a NULL value pointer passed
into bpf_map_update_elem() disqualifies this, then it's fine. But I
didn't ask to repurpose peek/pop for working with key pointers.

>
> I don't think it's worth to extend ops with yet another 3 callbacks
> and have clean ARG_PTR_TO_UNINIT_MAP_KEY there.
> That is probably too much clutter.
>
> I think
> bool bpf_bitset_clear(map, value);
> bool bpf_bitset_set(map, value);
> bool bpf_bitset_test(map, value);
> doesn't look too bad either.
> At least this way the bit set map_create op will use value_size
> and keep it as value_size. The bpf prog won't be confusing.
> That's my preference, so far.
