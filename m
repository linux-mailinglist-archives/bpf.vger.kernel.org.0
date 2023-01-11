Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731D9666343
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 20:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjAKTIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 14:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbjAKTIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 14:08:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A7B840
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 11:08:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v30so23744634edb.9
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 11:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZqd7TSvEhNoa2xnKWN8/vF+DJKYX1qV2XXYaxOaLUY=;
        b=bb8Ks+XgLmojCZE2fGALhAmwLppZUHVBCNaJ5p1rW1h0dnjYHWPJ4/i7QKkVfqroGE
         T3RwwZbhA1nNbp+k3Ig72/ASk8NESMK5jvZpiuEtPLkWDS6ceM8VvzyBYSdl9u1EbAtC
         GMDvz8DBl+hz87WG9OS5u2MAHOlW57B0fwArowYgZpIjg7pUZ2WNVdMLz0i77STj+D7y
         QrIcI3RDsxJ6F5TmzHKCmS8GLuG5ofJmCqhCCjKKOXcni2rLtZSrB/d0Sl9wdxqXSos8
         rogB56RiHF/blpn8+vDohqQACic/in4QlkLEsVXsXWxUui6luCi0/uLBcXA7gm8L3FMF
         s9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZqd7TSvEhNoa2xnKWN8/vF+DJKYX1qV2XXYaxOaLUY=;
        b=WcqUOER3w6qJSMmyQMnYalCFvkB+m4iuYGvGVyAHePvmiuTxCbiCKQbjcSu4yGXSkq
         5hW0qc6b6gmyh+xqm6GoWb6zZ3Mn6rtBiBf3yhv8oTWXoOIB7jU5TvzRpQrq+0YFfVnY
         xI4C0SUVPVu5Zwl+y4sJWCUs1V/QPELQ6gvaxmoIg9QhCE/CR1dDl9ZqY2fBiPAJv0hW
         YO9moUOi15mNN67MU6mT184V/DuThVPq4S/wFe/Y9GNRlONMAwR/WiYyykyridoBxl4j
         AQdQIM+3YZD/qlWNDk0Y26gFhVvjBKWUyj/M3+/g57yQNB07hzc9JLw09TzXXZengRnF
         3pRA==
X-Gm-Message-State: AFqh2krtUNpnSaxUFCk+HuM56Sm34zlfOsn28Vo6jsnd2OBOPRENO0N0
        EGsMJhFwXbmznJr1uydeerbyQqaXjTiE+Uv1X08=
X-Google-Smtp-Source: AMrXdXtaAlJSsyEZhh00NLFs+gmqsHCkpChdGJkaTmX3IJazE7ahkMFxbM7hZ7S3ejA/kqKeKLAZML3H5eUJqxAs2AU=
X-Received: by 2002:aa7:c948:0:b0:48e:9afd:de63 with SMTP id
 h8-20020aa7c948000000b0048e9afdde63mr2635522edt.232.1673464117088; Wed, 11
 Jan 2023 11:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20221223054921.958283-1-andrii@kernel.org> <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
 <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local> <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
 <20230104223521.hi2wvabfn7ldgh6o@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYdaqF1yoXtEQSHLXmgEvWiieoKW=2xBM+iJuJt6ukTzQ@mail.gmail.com> <20230105001426.x4e4hm573f72rywp@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230105001426.x4e4hm573f72rywp@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Jan 2023 11:08:25 -0800
Message-ID: <CAEf4BzZ+Q35R23EvinrKa69AXeEoS0Lmi+d+OV_CSX9Bz4dVYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Wed, Jan 4, 2023 at 4:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 03:03:23PM -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 4, 2023 at 2:35 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jan 03, 2023 at 02:04:44PM -0800, Andrii Nakryiko wrote:
> > > > > It sounds logical, but it can get tricky with ranges and branch taken logic.
> > > > > Consider something like:
> > > > > R1=(min=2,max=8), R2=(min=1, max=10)
> > > > > if (R1 within R2) // bpf prog is doing its own 'within'
> > > >
> > > > a bit confused what is "R1 within R2" here and what you mean "bpf prog
> > > > is doing its own 'within'"? Any sort of `R1 < R2` checks (and any
> > > > other op: <=, >=, etc) can't really kick in branch elimination because
> > > > R2_min=1 < R1_max=8, so arithmetically speaking we can't conclude that
> > > > "R1 is always smaller than R2", so both branches would have to be
> > > > examined.
> > >
> > > Something like that. Details didn't matter to me.
> > > It was hypothetical 'within' operation just to illustrate the point.
> >
> > I just don't know what kind of instruction has this "within"
> > semantics, that's why I was confused.
> >
> > >
> > > > But I probably misunderstood your example, sorry.
> > > >
> > > > >   // branch taken kicks in
> > > > > else
> > > > >   // issues that were never checked
> > > > >
> > > > > Now new state has:
> > > > > R1=(min=4,max=6), R2=(min=5, max=5)
> > > > >
> > > > > Both R1 and R2 of new state individually range_within of old safe state,
> > > > > but together the prog may go to the unverified path.
> > > > > Not sure whether it's practical today.
> > > > > You asked for hypothetical, so here it goes :)
> > > >
> > > > No problem with "hypothetical-ness". But my confusion and argument is
> > > > similarly "in principle"-like. Because if such an example above can be
> > > > constructed then this would be an issue for SCALAR as well, right? And
> > > > if you can bypass verifier's safety with SCALAR, you (hypothetically)
> > > > could use that SCALAR to do out-of-bounds memory access by adding this
> > > > SCALAR to some mem-like register.
> > >
> > > Correct. The issue would apply to regular scalar if such 'within' operation
> > > was available.
> > >
> > > > So that's my point and my source of confusion: if we don't trust
> > > > var_off+range_within() logic to handle *all* situations correctly,
> > > > then we should be worried about SCALARs just as much as anything else
> > > > (unless, as usual, I missed something).
> > >
> > > Yes. I personally don't believe that doing range_within for all regtypes
> > > by default is a safer way forward.
> > > The example wasn't real. It was trying to demonstrate a possible issue.
> > > You insist to see a real example with range_within.
> > > I don't have it. It's a gut feel that it could be there because
> > > I could construct it with fake 'within'.
> >
> > Ok, so some new instruction with "within" semantics would be
> > necessary. I was just trying to see if I'm missing some existing
> > potential case. Seems like not, that's fine.
> >
> > >
> > > > > More gut feel than real issue.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > > > > > > Keeping default as regs_exact (that does ID match) is safer default.
> > > > > >
> > > > > > It's fine, though the point of this patch set was patch #7, enabling
> > > > > > logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> > > > > > send specific fixes for that, no problem. But as I said above, I'm
> > > > > > really curious to understand what kind of situations will lead to
> > > > > > unsafety if we do var_off+range_within checks.
> > > > >
> > > > > PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
> > > > > example above.
> > > > > I'm less sure about PTR_TO_BTF_ID. It could be ok.
> > > > > Just feels safer to opt-in each type explicitly.
> > > >
> > > > Sure, I can just do a simple opt-in, no problem. As I said, mostly
> > > > trying to understand the issue overall.
> > > >
> > > > For PTR_TO_BTF_ID specifically, I can see how we can enable
> > > > var_off+range_within for cases when we access some array, right? But
> > > > then I think we'll be enforcing that we are staying within the
> > > > boundaries of a single array field, never crossing into another field.
> > >
> > > Likely yes, but why?
> >
> > No reason, just seems sane. But it also doesn't matter for the
> > discussion at hand.
> >
> > > You're trying hard to collapse the switch statement in regsafe()
> > > while claiming it's a safer way. I don't see it this way.
> > > For example the upcoming active_lock_id would need its own check_ids() call.
> > > It will be necessary for PTR_TO_BTF_ID only.
> > > Why collapse the switch into 'default:' just to bring some back?
> > > The default without checking active_lock_id through check_ids
> > > would be wrong, so collapsed switch doesn't make things safer.
> >
> > I'm saying it's sane default and is better than what we have today.
> > The reason I want(ed) to make default case doing proper range checks
> > (if they are set) is so that we don't miss cases like PTR_TO_MEM and
> > PTR_TO_BUF in the future.
>
> Wait. What do you mean 'miss cases like PTR_TO_MEM' ?
> With 'switch() default: regs_exact()'
> it's not a safety issue that PTR_TO_MEM doesn't do range_within() like PTR_TO_MAP_KEY.
> The verifier is unnecessary conservative with PTR_TO_MEM.
> Applying range_within() will allow more valid programs to be accepted.
> What did I miss?

I don't think you missed anything. This was all exactly to allow the
verifier to see that two PTR_TO_MEM (and PTR_TO_BUF, and whatnot)
registers are compatible, even if their ranges are not exactly
matching. This is just an inefficiency in state comparison right now
(and potentially missed infinite loop detection, but that's also just
inefficiency), but it becomes an issue with open-coded iterators
because state equivalence is necessary to conclude that loop actually
terminates safely.

> Or all this time I've been misreading your 'saner' default as 'safer' default?

 I meant "saner" (with 'n') as "better and more flexible without
compromising safety".
