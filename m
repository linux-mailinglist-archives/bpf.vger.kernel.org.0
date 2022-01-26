Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A049D2DD
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiAZTzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244588AbiAZTzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 14:55:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD1C06161C;
        Wed, 26 Jan 2022 11:55:01 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x3so659181ilm.3;
        Wed, 26 Jan 2022 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiRNFPZxx1b8Iw6otnphrPffoT1d2DXkPIgcH6aNRiI=;
        b=Yx4khfrNQxL3A9k2WXIK2mxpQBiJM8K1suQ7zdXZEJcc/2kgHlegfIvI4TN2YZ2CTL
         SB/qWj3Qjjm5wTYXeFUSBufCUw+8PjyNxKMaX1FTE0VAc8ruj2SWPITYwSr5Zlptu5Tx
         Gy545LLZJzd3G8KmVGJLHOZtqWzwTHE4sVtUym/geTteM5cchbFuX9H5cWZZxcMvIhZe
         eYIkfkKJxQp+VEboUOCpLvLyXQx8wuz2luUCjAhLZsKkEP7lSba+2sSlBsJGHGMiuNC+
         apyi0vJ8P2cs8Q7hw/S7SH5mBy16UIQU+jQQ4s3kER5yJ/B3mA2f0nt2a0cmGDrPWjn/
         zbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiRNFPZxx1b8Iw6otnphrPffoT1d2DXkPIgcH6aNRiI=;
        b=1Koya33+/tVEhytXV0kbZERgK3GGvSBzNv68fo1VkzBhCwvl8C+LRrAFVby+TSqelM
         VJZzt5aT5akkAlhCRKRD1SrNAT9DhJvrsDNSsQtDSW/5HnE1b/llnbHvH0seYCbXaDlx
         lSuO7sjwUdueycXalLeOWGcwNYaHf+R1GpEP0qI+REC0GPt5r9JLQthHbMcc1jv6+vd+
         1MNxLNlJ1vIBcJMeJYrJ/8DDe1gPks1lU1Bjwf5yxkZdapD5JjvaiEv4UGtjl8H8FZym
         g1KmNv9o/YJVoXMKfxg7wocJBPeYznSgsAnf8cG8mLdqvyiaV5Li9RPYTf3dK8hZ88Jx
         BnKw==
X-Gm-Message-State: AOAM531ATfBzgvKx0TXmWHOd6f9yxFMpiygpbd7wKYOL5YXTr8Rfz2IS
        Kdj4302nvAtpknGp1mmdijz5/H6MVqWzrDwKdMM=
X-Google-Smtp-Source: ABdhPJyKE04RoZE+IZPtzP8FeJy2FcEZAiMfZ9/noeQzrxfqxcUCoOT3oMnHmzTSSgffwPoN1RyrkIdDnwH7LmrW4AA=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr447352ili.239.1643226900740;
 Wed, 26 Jan 2022 11:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20220126040509.1862767-1-kuifeng@fb.com> <20220126040509.1862767-4-kuifeng@fb.com>
 <CAEf4BzYsjsWZASrF0rjBYion7nL7L9gRvGm_VJ7-1Ojds34b=A@mail.gmail.com> <624acf82a7c43ca0f9b0203a77b13fa6539ce967.camel@fb.com>
In-Reply-To: <624acf82a7c43ca0f9b0203a77b13fa6539ce967.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 11:54:49 -0800
Message-ID: <CAEf4Bzbi12AK2YxYmgY73Mord-zDt-PMKBCQpVveodrgC0kGcw@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 10:39 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Tue, 2022-01-25 at 22:07 -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 25, 2022 at 8:07 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Create an instance of btf for each worker thread, and add type info
> > > to
> > > the local btf instance in the steal-function of pahole without
> > > mutex
> > > acquiring.  Once finished with all worker threads, merge all
> > > per-thread btf instances to the primary btf instance.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > >
> ............ cut ...........
> > > +       struct thread_data *thread = thr_data;
> > > +
> > > +       if (thread == NULL)
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * Here we will call btf__dedup() here once we extend
> > > +        * btf__dedup().
> > > +        */
> > > +
> > > +       if (thread->encoder == btf_encoder) {
> > > +               /* Release the lock acuqired when created
> > > btf_encoder */
> >
> > typo: acquired
> >
> > > +               pthread_mutex_unlock(&btf_encoder_lock);
> >
> > Splitting pthread_mutex lock/unlock like this is extremely dangerous
> > and error prone. If that's the price for reusing global btf_encoder
> > for first worker, then I'd rather not reuse btf_encoder or revert
> > back
> > to doing btf__add_btf() and doing btf_encoder__delete() in the main
> > thread.
> >
> > Please question and push back the approach and code review feedback
> > if
> > something doesn't feel natural or is causing more problems than
> > solves.
> >
> > I think the cleanest solution would be to not reuse global btf_encoder
> > for the first worker. I suspect the time difference isn't big, so I'd
> > optimize for simplicity and clean separation. But if it is causing
> > unnecessary slowdown, then as I said, let's just revert back to your
> > previous approach with doing btf__add_btf() in the main thread.
> >
>
> Your concerns make sense.
> I tried the solutions w/ & w/o reusing btf_encoder.  The differencies
> are obviously.  So, I will rollback to calling btf__add_btf() at the
> main thread.
>
> w/o reusing: AVG 5.78467 P50 5.88 P70 6.03 P90 6.10
> w/  reusing: AVG 5.304 P50 5.12 P70 5.17 P90 5.46
>

Half a second, wow. Ok, yeah, makes sense.

>
>
