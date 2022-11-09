Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F26220B4
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiKIA0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKIA0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:26:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A122B09
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:26:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id q9so42889638ejd.0
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKslX2EvFAOH2H7iVkn02NVu/Uebn7E/8NO4PeVhHgQ=;
        b=q1a25w/Em1jNik5j5lCEOU70rjAr9Ex1iSVsxbGezstAV6EL5wIPxIZJiQfYDHgK3Q
         KBtDmmF+JNoAWzgblqSPV63b4ln9KmeOyHWylUeO+HSq6BSD1U/CxMURoZg3gP5yafqw
         2lRNO1ZUQfGCEY7P7aiN93THkg/OzGTxDySLKg8N9jnzz+brTkec+4lTOrxg7Ag4rPez
         LfHlEQbWAarSu0sEsM6NeqBwWi32YAGv/EJ/3+8RbFrNRvmASOM5yl+gFwKCinD8gMn7
         2Ewk78vDKy0VILMS6nc0iWTOV7anVPf48E1Ozkb+dYNI1oK9lZarzTKdp9RKCvVFlZLs
         ++Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKslX2EvFAOH2H7iVkn02NVu/Uebn7E/8NO4PeVhHgQ=;
        b=8MZOVJY47LFOwp12OMNXwMb8DwSTzeBhztiSxIHQaAoxtnRWVqYqjbVDYNBOzay8QD
         J/J3k+PB8W6nMuTr+YNW1k2OCTY1bV1U+wAalIJbjNcwWqtBBmCgn9qml2uTYnH7uoTA
         vFJKAKEuqFEjKU5SgGKNL1Xdci1+xr+2sjMJMppbxjl8+eJJpubNwV1ljWtg9JBk75Ee
         tfgNwBLk7GJ1q/aneTDT19XG/WZV7M9889Ip/lUA060egxtlEPwcOgYNZZRPHQl/KDt7
         aALla9gcZWQHtz1Dv2vEZTHEVGm/gdujYQg/aqP7vVix2IrQXSOpma22SnD+7T0R06m9
         TcvA==
X-Gm-Message-State: ACrzQf0g0ZbFb1F1eqhMMp/X0PueWTGFofscODJ73Ry+65KD1UuRiiji
        amQBkLj3zmU9NwreLQte1605HFzAYc57uRNrdP0=
X-Google-Smtp-Source: AMsMyM5mXl7xsDgY/prWwqE1dHuq+JPaKkHTKEkU+mGRuRXxYnZ1Mu/o1mA7Th7QhRlbWN7XbiVotlyRPfGYO05LEEU=
X-Received: by 2002:a17:906:af6b:b0:7a9:ecc1:2bd2 with SMTP id
 os11-20020a170906af6b00b007a9ecc12bd2mr1048818ejb.545.1667953574141; Tue, 08
 Nov 2022 16:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-6-memxor@gmail.com>
 <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com> <20221108234901.erzrj2b6bsvqkzir@apollo>
In-Reply-To: <20221108234901.erzrj2b6bsvqkzir@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:26:02 -0800
Message-ID: <CAEf4BzZJBeBr69QFdbj0L_76uViBsJJ1EzTiTFni+eUtTCG9mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/25] bpf: Rename MEM_ALLOC to MEM_RINGBUF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Nov 8, 2022 at 3:49 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, Nov 09, 2022 at 04:44:16AM IST, Andrii Nakryiko wrote:
> > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > Currently, verifier uses MEM_ALLOC type tag to specially tag memory
> > > returned from bpf_ringbuf_reserve helper. However, this is currently
> > > only used for this purpose and there is an implicit assumption that it
> > > only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
> > > in check_func_arg_reg_off).
> > >
> > > Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
> > > relationship and instead open the use of MEM_ALLOC for more generic
> > > allocations made for user types.
> > >
> > > Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.
> > >
> > > Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > Ok, so you are doing what I asked in the previous patch, nice :)
> >
> > >  include/linux/bpf.h                               | 11 ++++-------
> > >  kernel/bpf/ringbuf.c                              |  6 +++---
> > >  kernel/bpf/verifier.c                             | 14 +++++++-------
> > >  tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
> > >  tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
> > >  tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
> > >  6 files changed, 17 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 2fe3ec620d54..afc1c51b59ff 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -488,10 +488,8 @@ enum bpf_type_flag {
> > >          */
> > >         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
> > >
> > > -       /* MEM was "allocated" from a different helper, and cannot be mixed
> > > -        * with regular non-MEM_ALLOC'ed MEM types.
> > > -        */
> > > -       MEM_ALLOC               = BIT(2 + BPF_BASE_TYPE_BITS),
> > > +       /* MEM points to BPF ring buffer reservation. */
> > > +       MEM_RINGBUF             = BIT(2 + BPF_BASE_TYPE_BITS),
> >
> > What do we gain by having ringbuf memory as additional modified flag
> > instead of its own type like PTR_TO_MAP_VALUE or PTR_TO_PACKET? It
> > feels like here separate register type is more justified and is less
> > error prone overall.
> >
>
> I'm not sure it's all that different. It only matters when checking argument
> during release. We want to ensure it came from ringbuf_reserve. That's all,
> apart from that it's no different from PTR_TO_MEM. In all other places it's
> folded and code for PTR_TO_MEM is used. Same idea as PTR_TO_BTF_ID | MEM_ALLOC.
>
> But I don't feel too strongly, so if you still think it's better I can make the
> switch.

Not strongly, but I think having this as a flag is more error prone.
For cases where ringbuf memory should be treated just as memory, we
should use the same mechanism we have for MAP_VALUE. But I haven't
checked how we deal with MAP_VALUE, if that's a special case
everywhere, in addition to generic PTR_TO_MEM, then fine. But if
having PTR_TO_RINGBUF_MEM is converted to PTR_TO_MEM generically where
needed, I'd have dedicated PTR_TO_RINGBUF_MEM.
