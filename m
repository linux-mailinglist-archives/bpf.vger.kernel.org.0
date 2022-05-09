Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFA52037E
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiEIR0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbiEIR0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 13:26:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16B25F794
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 10:22:10 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s30so26200698ybi.8
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88MktyXOljxhCM+O7+LU8K2/pTMlwL//WPQ9n+mIC5w=;
        b=GxRe11ErTymzHsjYcPe6fRtftyTGbw+jxyTkdT7uuMvYp/GR283SQh8zHGHeHQDlWV
         4p9T5C2mBtw08u5ElgMb7tP1HygFmfR7JQxvqq90+ZyZ+E8pPkB1d56oYQ+002W4bD4G
         vXtu9b+xeoPPuy1cwrfneR5qhviXW1JdC0HEmM8TZWnncJ3WfoYdrfQrvodvh9B0kO2h
         ZWrrFFCaIvbiwMfehmkKN+N/HYj6lXc4x2YKBmicq9G/V7HABUeK+JSzsnXvh2CSuUYm
         iqDllc4Lq/qmefk9fVqxYWu8Tywh6rVhlWQHqr6twlL7RKjARUi2R2vQtTQXIcOmxGKZ
         6/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88MktyXOljxhCM+O7+LU8K2/pTMlwL//WPQ9n+mIC5w=;
        b=dTgMIpIfbHWnSqdQ3zZo9M0PBxYutIDyz8VrQSS0DD6eoPmOhmJTIDrJJdrSK3d+fn
         XRsG4BgTwlFjvJgwln3ou6VDBWjrJveH5xpAqYD7GPdVx3ARTyVVUJyKGZIX8g9DpKzb
         ODKGHd5FRwuVN7xPGuT9Ly6uxGkofl0aMjATeUBRdq5yGqkkieQfH9fcuuWkwacyTjVc
         BLObhlyhk1CdKPixxr+nub+6oghes+4Ofj1NTvLpnTg5DP7p5ymDsS30FePUpzMIawp7
         lNuF0VBJRRtmc5a0orYg3stzYEbzpbUfTbAE136qY54haTqB4/R9lsDHo5C4UzrMeCHG
         TQHg==
X-Gm-Message-State: AOAM533GELSb1D6js3nhhWanGIaT5Wo/U0fBFlfxL0I03XAW01E90Gnk
        GjV8uh4fKtAb3u+8eL2bVFtdUNTlOTXho3INvtY=
X-Google-Smtp-Source: ABdhPJy2mohFj8Suw2pXMdNfhzM4KkUtEn7xmwGU1uHwaiOOg2UG5qbywQIo5E4EldnleuF338tsnaZgy0Zbt8QdaOc=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr15405584yba.153.1652116930186; Mon, 09
 May 2022 10:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-6-joannelkoong@gmail.com> <CAEf4BzY9eE1ud7RA4m6+kCGjNxhVsHo4uOQgrmbtS4C1i6Dv0A@mail.gmail.com>
In-Reply-To: <CAEf4BzY9eE1ud7RA4m6+kCGjNxhVsHo4uOQgrmbtS4C1i6Dv0A@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 10:21:58 -0700
Message-ID: <CAJnrk1aN-HLdoauqVcj3jK7s6AWU=xSFefnse1JwixDOBLyWPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add dynptr data slices
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Fri, May 6, 2022 at 4:57 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > This patch adds a new helper function
> >
> > void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);
> >
> > which returns a pointer to the underlying data of a dynptr. *len*
> > must be a statically known value. The bpf program may access the returned
> > data slice as a normal buffer (eg can do direct reads and writes), since
> > the verifier associates the length with the returned pointer, and
> > enforces that no out of bounds accesses occur.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  4 +++
> >  include/uapi/linux/bpf.h       | 12 +++++++
> >  kernel/bpf/helpers.c           | 28 +++++++++++++++
> >  kernel/bpf/verifier.c          | 64 ++++++++++++++++++++++++++++++----
> >  tools/include/uapi/linux/bpf.h | 12 +++++++
> >  5 files changed, 114 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b276dbf942dd..4d2de868bdbc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -397,6 +397,9 @@ enum bpf_type_flag {
> >         /* DYNPTR points to a ringbuf record. */
> >         DYNPTR_TYPE_RINGBUF     = BIT(9 + BPF_BASE_TYPE_BITS),
> >
> > +       /* MEM is memory owned by a dynptr */
> > +       MEM_DYNPTR              = BIT(10 + BPF_BASE_TYPE_BITS),
>
> do we need this yet another bit? It seems like it only matters for
> verifier log dynptr_ output? Can we just reuse MEM_ALLOC? Or there is
> some ringbuf-specific logic that we'll interfere with? If feels a bit
> unnecessary, let's think if we can avoid adding bits just for this.
I think we do need this bit to differentiate between MEM_ALLOC and
MEM_DYNPTR because otherwise, you would be able to pass in a dynptr
data slice to the ringbuf bpf_ringbuf_submit/discard helpers.
>
> > +
> >         __BPF_TYPE_LAST_FLAG    = DYNPTR_TYPE_RINGBUF,
> >  };
> >
>
> [...]
>
> > +               if (is_dynptr_ref_function(func_id)) {
> > +                       int i;
> > +
> > +                       /* Find the id of the dynptr we're acquiring a reference to */
> > +                       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > +                               if (arg_type_is_dynptr(fn->arg_type[i])) {
> > +                                       id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
>
> let's make sure that we have only one such argument?
Are we able to assume it's guaranteed given that
is_dynptr_ref_function() refers to BPF_FUNC_dynptr_data and the
definition of bpf_dynptr_data will always only have one dynptr arg?
>
> > +                                       break;
> > +                               }
> > +                       }
> > +                       if (unlikely(i == MAX_BPF_FUNC_REG_ARGS)) {
>
> please don't use unlikely(), especially for non-performance critical code path
>
> > +                               verbose(env, "verifier internal error: no dynptr args to a dynptr ref function");
> > +                               return -EFAULT;
> > +                       }
> > +               } else {
> > +                       id = acquire_reference_state(env, insn_idx);
> > +                       if (id < 0)
> > +                               return id;
> > +               }
>
> [...]
