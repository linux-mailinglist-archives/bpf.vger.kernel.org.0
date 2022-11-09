Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6699622121
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKIBDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 20:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKIBDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 20:03:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941415A3E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 17:03:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v17so25065940edc.8
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n2hdxIC5mY1i9uKM3KuiZjcJGjR3GV02BNKOEmqVuk=;
        b=mWLydqv3ZvTiaZfoP5a2mv/IRliPkSWm29v32IYacZyV4ZJIvoGWePQbVsR14qgt9D
         HTNZlvaro4Vo3RqqiQOEErFVFocWkcbg8fxsFJWJy231Kj3j1xSKRTAjDzjTr4LIQnPa
         o6Rok3IfGhYlmabPTV9I4lwtu9YNtt6Xv3Dyj9103bVhvfBoo0bHTAyxukcJYZHEn3XE
         s+lFOzG7tgHdEWCjWYCcKjqzRhjTlm6dbobNmVectsvZJbjfovQdKDpM94dxuL4zfYya
         g2fHR+PUTJxAMmUNKIsMn4nMnoHtnNYP3oFNl9rYK43noAOxON+RoAoynbLlDssX9N/u
         oquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n2hdxIC5mY1i9uKM3KuiZjcJGjR3GV02BNKOEmqVuk=;
        b=AnEN/WbENUyEBP5GvFdi/ZAHPJunXtQMXt3og6lpJDXK2wvjRorSIqLIx1vnVlY8FO
         jVcc0UO86eNVyL1Q4hiJrIqJ6DcoifbRU0Nx0WHgWAfKxqVBoV/LzslmdQkH5xTccgsK
         rQw+x4tn+GrdcVqyuM3BWCHr3OK8NAVJrCmMMkKR2pQsNHgDC3RyFNN86jic/lCy36AU
         HgfEvlmv/4ru6s/EYNZFqm/tuzzfkXfXHWyGNtDpe7WGea1DEmLkyCc0VmUkO9Gaw+bP
         PTwfnBm8AWGswEW+MZUCQJstN1g6T4etxDStOsg3M3j8vYUCZh1DyQ4WSY5YPdEeNeLS
         EgIw==
X-Gm-Message-State: ACrzQf3DW3N5WURmZ6S6hQo7wregS5Av3cr5BQB3Ec8X6LFxfhTOV5nF
        hENxSHoLRUHT94hWfApSV1N1adHjhUHBIN6+Zeg=
X-Google-Smtp-Source: AMsMyM4DQkyf1o6Tabhe3qVcj6g/AU0YF4BQ9UR3J6bp4lOWYiPSc9IMsyj75CBnMRtqVqI27zV2Vm3pn/Xx/YXHCaQ=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr58526681edb.333.1667955818469; Tue, 08
 Nov 2022 17:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
 <20221108233944.o6ktnoinaggzir7t@apollo> <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
In-Reply-To: <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Nov 2022 17:03:25 -0800
Message-ID: <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map values
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Tue, Nov 8, 2022 at 4:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > > >  struct bpf_offload_dev;
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 94659f6b3395..dd381086bad9 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> > > >         __u64 :64;
> > > >  } __attribute__((aligned(8)));
> > > >
> > > > +struct bpf_list_head {
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +} __attribute__((aligned(8)));
> > > > +
> > > > +struct bpf_list_node {
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +} __attribute__((aligned(8)));
> > >
> > > Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> > > alignment information, as the struct itself is empty, and so there is
> > > nothing indicating that it has to be 8-byte aligned.

Since it's not a new issue let's fix it for all.
Whether it's a combination of pahole + bpftool or just pahole.

> > >
> > > So what if we have
> > >
> > > struct bpf_list_node {
> > >     __u64 __opaque[2];
> > > } __attribute__((aligned(8)));
> > >
> > > ?
> > >
> >
> > Yep, can do that. Note that it's also potentially an issue for existing cases,
> > like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> > things now is possible, but if it is, we should probably make it for all of
> > them?
>
> Why not? We are not removing anything or changing sizes, so it's
> backwards compatible.
> But I have a suspicion Alexei might not like
> this __opaque field, so let's see what he says.

I prefer to fix them all at once without adding a name.

>
> > > >                 off = vsi->offset;
> > > > +               if (i && !off)
> > > > +                       return -EFAULT;
> > >
> > > similarly, I'd say that either we'd need to calculate the exact
> > > expected offset, or just not do anything here?
> > >
> >
> > This thread is actually what prompted this check:
> > https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com
> >
> > Unless loaded using libbpf all offsets are zero. So I think we need to reject it
> > here, but I think the same zero sized field might be an issue for this as well,
> > so maybe we remember the last field size and check whether it was zero or not?
> >
> > I'll also include some more tests for these cases.
>
> The question is whether this affects correctness from the verifier
> standpoint? If it does, there must be some other place where this will
> cause problem and should be caught and reported.

If it's an issue with BTF then we should probably check it
during generic datasec verification.
Here it's kinda late to warn.

> My main objection is that it's half a check, we check that it's
> non-zero, but we don't check that it is correct in stricter sense. So
> I'd rather drop it altogether, or go all the way to check that it is
> correct offset (taking into account sizes of previous vars).
