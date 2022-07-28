Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D4583AE7
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiG1JDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiG1JDD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 05:03:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB06582D
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 02:02:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q14so959721iod.3
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzCybkHASBbHe8t6haWwO/x1XlmpXfIOQlEyCQdl7ug=;
        b=UcS5L0GsEVBoIzMJBr77747QG+/oLsfF5DNQ1QGPJW736IQ56LzEQLgM/nqE/NzELp
         0JWuRl4aZv/+o3MlKmpZYdkHv7xqR6Fd/rps0j678oCaGeiw+QNlQcg1w7QC+79qQeRQ
         GTmr+ZPbpA0urSgtCqHA/KB9dbwBbBOz1ban3iBEbTZocnPrYNBgUwTwDUpjKZmYiBNy
         0lsXwtMtHRbOSUwuu8dMWjJz95zk8Wae7fLkZLmTtKjKqGqMxJO1giIXHAp7qqoWPtgt
         Us9zwufvRl439TwtsVKNBN9amDh6wXnOwk3bDYVOJ9CUTpom//Xal8QA6puHyRSYt41Q
         zPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzCybkHASBbHe8t6haWwO/x1XlmpXfIOQlEyCQdl7ug=;
        b=yH/NIGr0febYZ4dUwC2RK6ZrIOu1OffZQAfNH0Jehe0BHUQopYoq/cI49KODmqfylU
         7pvgidoV5I5VRtmOeflL5sw4Hnneqty4T4r5TyNKjQKGIAdsKwt+sPZxXW0+Hng7HhRy
         rTc6TrJWFgDwfqWZj/22QQ5BcL8rm35CZAQdiYB4SqB4uLCia7GIYtmuyczmYzp0vGe6
         RpNhszlJonuHL9DDofVgmvT7vXDHDfmBKpAS3n4B97/rVmOJgsaIB5szntBSHJDNSqZJ
         3J0u7o+bHd5i71iQWqsxaWzWJ0/UUjvQZ6SUN0KmY051TzW90Vv0ge3Gb2WQ9fwuc5/4
         ZlMw==
X-Gm-Message-State: AJIora+nnd5oDUwmJfF+Ze+3DyvgSlpDADv+Y6d2rNgKHq0fwszxfNDD
        eemTMITWKaix8gQseOhLZ8z2dcMuvof8YGtuqwUXzrY6xuY=
X-Google-Smtp-Source: AGRyM1uoWjOy+eS9N6E3zvMjZhKPtDt84gy9+81SwlqOTjfbN6x7bCZlW6oAOH6d1ZXJqhHXy7FGKKtbMgsRz6DKVjE=
X-Received: by 2002:a05:6638:3807:b0:341:709f:31a7 with SMTP id
 i7-20020a056638380700b00341709f31a7mr10844213jav.206.1658998973210; Thu, 28
 Jul 2022 02:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220727081559.24571-1-memxor@gmail.com> <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com> <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
In-Reply-To: <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 28 Jul 2022 11:02:15 +0200
Message-ID: <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Thu, 28 Jul 2022 at 10:45, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 28 Jul 2022 at 10:18, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >
> > > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > > Sent: Thursday, July 28, 2022 9:46 AM
> > > > From: Kumar Kartikeya Dwivedi [mailto:memxor@gmail.com]
> > > > Sent: Wednesday, July 27, 2022 10:16 AM
> > > > Similar to how we detect mem, size pairs in kfunc, teach verifier to
> > > > treat __ref suffix on argument name to imply that it must be a trusted
> > > > arg when passed to kfunc, similar to the effect of KF_TRUSTED_ARGS flag
> > > > but limited to the specific parameter. This is required to ensure that
> > > > kfunc that operate on some object only work on acquired pointers and not
> > > > normal PTR_TO_BTF_ID with same type which can be obtained by pointer
> > > > walking. Release functions need not specify such suffix on release
> > > > arguments as they are already expected to receive one referenced
> > > > argument.
> > >
> > > Thanks, Kumar. I will try it.
> >
> > Uhm. I realized that I was already using another suffix,
> > __maybe_null, to indicate that a caller can pass NULL as
> > argument.
> >
> > Wouldn't probably work well with two suffixes.
> >
>
> Then you can maybe extend it to parse two suffixes at most (for now atleast)?
>
> > Have you considered to extend BTF_ID_FLAGS to take five
> > extra arguments, to set flags for each kfunc parameter?
> >
>
> I didn't understand this. Flags parameter is an OR of the flags you
> set, why would we want to extend it to take 5 args?
> You can just or f1 | f2 | f3 | f4 | f5, as many as you want.

Oh, so you mean having 5 more args to indicate flags on each
parameter? It is possible, but I think the scheme for now works ok. If
you extend it to parse two suffixes, it should be fine. Yes, the
variable name would be ugly, but you can just make a copy into a
properly named one. This is the best we can do without switching to
BTF tags. We can revisit this when we start having 4 or 5 tags on a
single parameter.

To make it a bit less verbose you could probably call maybe_null just null?
