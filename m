Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76540B93C
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhINU1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 16:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINU1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 16:27:35 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100CC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:26:16 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 13so159914vkl.1
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDoGPWavmQGTSDbgVrcbAxqPQ2iVqe4HzCSP1sLoRPs=;
        b=oC1QcEf9Q89+stjtMxT6CqmauaURKdQFbfs2CaRks5dYMcpXyiwjjd3Xh1QivclOsC
         zbyDaiiucyGhpK4E1rsyVkj5nsW1bmUj0vfO674TMWZnN3PMOXI2mzXQkxBabdLOV1mP
         LSVIZRK2zZKNv9UWr+UG3pdMxgeTIEfRezodgs/Jx0WD/3w/xCnf1lU8o9TrdjMNgmdn
         cy2pBy6qIRPXHaL23dXVOxZXA6rtzlUcqqVp7MclCgNkNYyG2AS9Hz1BvFz/j19aXkmH
         PcR+l7DtVdr6vNqGeyaTQeN9B2nNARBMLmD26+Fh7TTuSLl4cekNBiFdXNw2qzxW5mE/
         BMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDoGPWavmQGTSDbgVrcbAxqPQ2iVqe4HzCSP1sLoRPs=;
        b=V01ZZd4CP3cBwrN2SfI7yeqcwHez4hX66d+nLPZ1sqIAfH8gIR/rwoKKfHCaIi7+ci
         okqtyHUU4iXBjs+yinFNwBNeymraxkk8NWWTROQbR44Xw9h08ddnKN85SbdRnZsbbQ9L
         ZBJNA5x1BKI7MBE16aQDYsiynQJZTCKltoaveuN9AUky68r+FmysFv8+knutx2oFOsvJ
         DSYQaNa9QyNcH6Tgobj/CGJ1+VU3iC5fGfKfFM9vMcw6HuNRZom75HOwd6RBZ/+pcYPM
         dEhnQ9vo6QR/l+LXzW/DggHXGD99AVbWbBYMPMkOcUjAUpwXVCvfRCxv0gT9NQuTV6Hh
         gbGQ==
X-Gm-Message-State: AOAM530bqW56t9wSwgsX9qdKTjfd9KtObFwOcU6n262/FvXMKyiq/BMo
        i3LivnjtYYai33rtb6qfbjqjlKnmeGjWsuFBHFM=
X-Google-Smtp-Source: ABdhPJz508o+ku5GNKDBSw+4owhdy1oEmR2HKHk9+xc+7T8aweTMYLlayQPZ5rilOawdoM/YiasiM7wSvgZvZw66TDE=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr1032178vkj.21.1631651176043;
 Tue, 14 Sep 2021 13:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210909204312.197814-1-grantseltzer@gmail.com> <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
In-Reply-To: <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 14 Sep 2021 16:26:04 -0400
Message-ID: <CAO658oU0DORUHChtvh3fzteWzaR3sDBxTcxUiwekOTLtLVLQcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 11:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 9, 2021 at 1:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds comments above five functions in btf.h which document
> > their uses. These comments are of a format that doxygen and sphinx
> > can pick up and render. These are rendered by libbpf.readthedocs.org
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
>
> It's nice that you provided a test instance of readthedocs.io site, it
> made it much easier to look at how all this is rendered. Thanks!
>
> I'm no technical writer, but left some thoughts below. It would be
> great to get more help documenting all the APIs and important libbpf
> objects from people that are good at succinctly explaining concepts.
> This is a great start!
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 4a711f990904..f928e57c238c 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -30,11 +30,47 @@ enum btf_endianness {
> >         BTF_BIG_ENDIAN = 1,
> >  };
> >
> > +/**
> > + * @brief **btf__free** frees all data of the BTF representation
>
> I'd like to propose that we add () for all functions, I've been
> roughly following this convention throughout commit messages and
> comments in the code, I think it's makes it a bit clearer that we are
> talking about functions
>
> > + * @param btf
>
> seems like the format is "<arg_name> <description of the argument>" so
> in this case it should be something like
>
> @param btf BTF object to free
>
> > + * @return void
>
> do we need @return if the function is returning void? What if we just
> omit @return for such cases?

Forgot to address this in the previous email. We certainly can
eliminate this line, and it would just not render anything for the
return. I'm in favor of keeping it explicit but certainly can remove
it if you'd like!

>
> > + */
> >  LIBBPF_API void btf__free(struct btf *btf);
> >
> > +/**
> > + * @brief **btf__new** creates a representation of a BTF section
> > + * (struct btf) from the raw bytes of that section
>
> is there some way to cross reference to other types/functions? E.g.,
> how do we make `struct btf` a link to its description?
>
> > + * @param data raw bytes
> > + * @param size length of raw bytes
> > + * @return struct btf*
>
>
> @return new instance of BTF object which has to be eventually freed
> with **btf__free()**?
>
> > + */
> >  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> > +
> > +/**
> > + * @brief **btf__new_split** creates a representation of a BTF section
>
> "representation of a BTF section" seems a bit mouthful. And it's not a
> representation, it's a BTF object that allows to perform a lot of
> stuff with BTF type information. So maybe let's describe it as
>
> **btf__new_split()** create a new instance of BTF object from provided
> raw data bytes. It takes another BTF instance, **base_btf**, which
> serves as a base BTF, which is extended by types in a newly created
> BTF instance.
>
> > + * (struct btf) from a combination of raw bytes and a btf struct
> > + * where the btf struct provides a basic set of types and strings,
> > + * while the raw data adds its own new types and strings
> > + * @param data raw bytes
> > + * @param size length of raw bytes
> > + * @param base_btf the base btf representation
>
> same here, "representation" sounds kind of weird and wrong here
>
> > + * @return struct btf*
> > + */
> >  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> > +
> > +/**
> > + * @brief **btf__new_empty** creates an unpopulated representation of
> > + * a BTF section
> > + * @return struct btf*
> > + */
> >  LIBBPF_API struct btf *btf__new_empty(void);
> > +
> > +/**
> > + * @brief **btf__new_empty_split** creates an unpopulated
> > + * representation of a BTF section except with a base BTF
> > + * ontop of which split BTF should be based
>
> typo: on top
>
> > + * @return struct btf*q
> > + */
> >  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
> >
> >  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> > --
> > 2.31.1
> >
