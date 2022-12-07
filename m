Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE946457DF
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLGKbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 05:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLGKbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 05:31:04 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97AB9F
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 02:31:01 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d131so18724018ybh.4
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 02:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Te+qRfL0gSPa2I5bK5OY5bAXbxohK6qh4ntuX06onLw=;
        b=eBPc6LCdVbJNZrD/vNuWi34IC2I2EByvcZ8T0bOHHwJG02J4XKMyBtJKL5TXNyKr4l
         d2If4UglHwt630P/gso8MBO1XAPD4/15iytfqwluNRAjCjHvYaQX6lqz92qU1KueqWLl
         NmEtQ6abKgUm6qF8HpC29w+VmYMpJBX6lk06RhkXqIM9gvHs/UgSHGt9e1c749PUkstn
         JEkgkYj0nWksUc/pyFxQvgoiSB+fxrbCrHfYpt751cz2XxTcjqE/hdsmUs5eBIkUlkj6
         Y0xvfCUPe9v+Y3nCGvY+7x0g7pjw9eqxhnA819SOFLRlldbiFVDZtpE2xX/6x/MdWLVi
         l40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te+qRfL0gSPa2I5bK5OY5bAXbxohK6qh4ntuX06onLw=;
        b=ixjbUYhDsRx2RyentRleKGs2j7IPb121d0CjUGEoVFGvET4TaQzBMrGgE6+V246VkL
         ohlkkuTxZcsYaKEzV0QbuoJwsXPXow7wNcw1YFnXmsI8QfFmwEKU2YrQUBh7PV/BaPzG
         z4BNf0LcberCXDIRkW3t4T9y69xw+emgg8j/j5w6WiUVXuOF4+qR3iW2qPw5pD8bM2Ph
         Xl9nvPe99cB57WsmDjlc77XnmBmYmz37tQSVSRC6SBItsKhAX37cTVaP+0udhuDgp3F4
         Cb3vDxtdR1B5qkZKh21T4HzupzvlPpMLkErh0vinB6ZY7vhCLrFKvlz00cN/88kOh46/
         8lZQ==
X-Gm-Message-State: ANoB5pkhhegCgmFbEqsUWoLKDDdRcCMkaUYfTBkzUkWF2JUHq/JnW5aI
        EUNuwRR1jlNYI4sDuqfT4c6UWDH4W/0ZB+arOb6onw==
X-Google-Smtp-Source: AA0mqf6t39Rs8bP0A/bgsq+RjfUaGFwDeeFVVvJr2EUDgik0KecD4HhEv5Xo7lS6iqkDVNk/fFXWXXRma5m/Cfa/4Mw=
X-Received: by 2002:a05:6902:1004:b0:6fe:d784:282a with SMTP id
 w4-20020a056902100400b006fed784282amr17363367ybt.598.1670409060680; Wed, 07
 Dec 2022 02:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20221206231659.never.929-kees@kernel.org> <20221206175557.1cbd3baa@kernel.org>
In-Reply-To: <20221206175557.1cbd3baa@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 7 Dec 2022 11:30:36 +0100
Message-ID: <CANn89i+A49o1zXLJHTjQPrGrdATv7Mkis06FahZ0Yy2gLB1BXQ@mail.gmail.com>
Subject: Re: [PATCH] skbuff: Reallocate to ksize() in __build_skb_around()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+fda18eaa8c12534ccb3b@syzkaller.appspotmail.com,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        pepsipu <soopthegoop@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrii Nakryiko <andrii@kernel.org>, ast@kernel.org,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, jolsa@kernel.org,
        KP Singh <kpsingh@kernel.org>, martin.lau@linux.dev,
        Stanislav Fomichev <sdf@google.com>, song@kernel.org,
        Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        David Rientjes <rientjes@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 2:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  6 Dec 2022 15:17:14 -0800 Kees Cook wrote:
> > -     unsigned int size = frag_size ? : ksize(data);
> > +     unsigned int size = frag_size;
> > +
> > +     /* When frag_size == 0, the buffer came from kmalloc, so we
> > +      * must find its true allocation size (and grow it to match).
> > +      */
> > +     if (unlikely(size == 0)) {
> > +             void *resized;
> > +
> > +             size = ksize(data);
> > +             /* krealloc() will immediate return "data" when
> > +              * "ksize(data)" is requested: it is the existing upper
> > +              * bounds. As a result, GFP_ATOMIC will be ignored.
> > +              */
> > +             resized = krealloc(data, size, GFP_ATOMIC);
> > +             if (WARN_ON(resized != data))
> > +                     data = resized;
> > +     }
> >
>
> Aammgh. build_skb(0) is plain silly, AFAIK. The performance hit of
> using kmalloc()'ed heads is large because GRO can't free the metadata.
> So we end up carrying per-MTU skbs across to the application and then
> freeing them one by one. With pages we just aggregate up to 64k of data
> in a single skb.
>
> I can only grep out 3 cases of build_skb(.. 0), could we instead
> convert them into a new build_skb_slab(), and handle all the silliness
> in such a new helper? That'd be a win both for the memory safety and one
> fewer branch for the fast path.
>
> I think it's worth doing, so LMK if you're okay to do this extra work,
> otherwise I can help (unless e.g. Eric tells me I'm wrong..).

I totally agree, I would indeed remove ksize() use completely,
let callers give us the size, and the head_frag boolean,
instead of inferring from size==0
