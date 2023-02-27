Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B76A4D15
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjB0VXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjB0VXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:23:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB2CA06
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:23:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg37so31304677edb.12
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LFZ2Ef386rfLw4FYGGrBAaTreOZ8e26JfoUo9YP6io=;
        b=pKlr57YMbK4EipzeM5yC+L/MsP0szBDqIIMt4WYEo7gAx/RuRylJo9Lf4afqYsUIU/
         1mHor4SYGc5vhmuUKx71M/FFNwIid++X6Mk3aHqlMyT+SOC3nwFZCSAIuO60OwknC75W
         kbKMLj4rIWSKwggI9XKqXLcM46uHsvBKc9l3zMjKo+hxUvNZhZXd4Vy+RnIALb6SW0sy
         OBOvLWFbFJn9jn7x/gmme7mrsgj4JKjDMcwGEX0QGva7Iz0BKAwBHbsi1hd+oWmDNeiX
         r+9B0pZ/QUggVBfmZYCuev/WGlQPSmR4dzZI5Nve15WeHWHfzQcv7jchgRA0VzJrzX3Q
         cyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LFZ2Ef386rfLw4FYGGrBAaTreOZ8e26JfoUo9YP6io=;
        b=s5GQtzBS0zVuNBczydIIAslkhEILXCvarnV/t/YRdfEsIbA4xwx7q1HiKe8jWCEk2N
         EG87ex7FouTZ2cq3rR/IcVMXPu9NfulUeRO3YJ+5GchP9zAWvcUapk4yU4yaqCL0K94v
         0tgIg4Um5qWyLNVcMhBm1m817hGMiwOdXtdc2uimHN7EZERsnNCbIl1C42VZbe1/KulQ
         RDZ0SrI478GAsmZiD2NTRKU5MiFDc4NqNNWPf03BPzzs+z2rY0ZNVLoMtBzFlgTvrJsf
         JieHvMVSSowomrPeRuWp5WBWws1sLbu/U3yPXAVOLgHT3XGxvo/kBYOE6YPiouRNKOSr
         rkcg==
X-Gm-Message-State: AO0yUKWDGYLPrMrOm9quBryijGewa2gzDk32O53YEtmEk5KNwONhH60e
        SEILpurLm7o5pFjfF9qv9JPLUonQmnTwRZ96M4TOGII+
X-Google-Smtp-Source: AK7set95sOtDo1chb2lhqhxxMuzcoV1BLB/9EJZPXjdmFixEZGEmokCPu6JON94Ga1nGLwWRTURPsABk+QRnBIpaJ8k=
X-Received: by 2002:a17:907:e94:b0:8d7:edbc:a7b6 with SMTP id
 ho20-20020a1709070e9400b008d7edbca7b6mr746606ejc.2.1677533007436; Mon, 27 Feb
 2023 13:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214231221.249277-1-iii@linux.ibm.com> <20230214231221.249277-8-iii@linux.ibm.com>
 <CAEf4BzZcvuCZpjKwgT_-3WaKuM82CA1Uxg3X-4E63r2o6he+sA@mail.gmail.com> <b0ae5117d46948ca4d160157bc02e94c3b00fb19.camel@linux.ibm.com>
In-Reply-To: <b0ae5117d46948ca4d160157bc02e94c3b00fb19.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:23:15 -0800
Message-ID: <CAEf4BzaOWk1tRpg+9tFhjjss-PYoiC4z_++vnrCwHfo7wNAapg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/8] libbpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Mon, Feb 20, 2023 at 4:46 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2023-02-16 at 15:28 -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 14, 2023 at 3:12 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > MSan runs into a few false positives in libbpf. They all come from
> > > the
> > > fact that MSan does not know anything about the bpf syscall,
> > > particularly, what it writes to.
> > >
> > > Add __libbpf_mark_mem_written() function to mark memory modified by
> > > the
> > > bpf syscall, and a few convenience wrappers. Use the abstract name
> > > (it
> > > could be e.g. libbpf_msan_unpoison()), because it can be used for
> > > Valgrind in the future as well.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/bpf.c             | 161
> > > ++++++++++++++++++++++++++++++--
> > >  tools/lib/bpf/btf.c             |   1 +
> > >  tools/lib/bpf/libbpf.c          |   1 +
> > >  tools/lib/bpf/libbpf_internal.h |  38 ++++++++
> > >  4 files changed, 194 insertions(+), 7 deletions(-)
> >
>
> [...]
>
> > > +/* Helper macros for telling memory checkers that an array pointed
> > > to by
> > > + * a struct bpf_{btf,link,map,prog}_info member is initialized.
> > > Before doing
> > > + * that, they make sure that kernel has provided the respective
> > > member.
> > > + */
> > > +
> > > +/* Handle arrays with a certain element size. */
> > > +#define __MARK_INFO_ARRAY_WRITTEN(ptr, nr, elem_size) do
> > > {                    \
> > > +       if (info_len >= offsetofend(typeof(*info), ptr)
> > > &&                     \
> > > +           info_len >= offsetofend(typeof(*info), nr)
> > > &&                      \
> > > +           info-
> > > >ptr)                                                         \
> > > +               libbpf_mark_mem_written(u64_to_ptr(info-
> > > >ptr),                 \
> > > +                                       info->nr *
> > > elem_size);                 \
> > > +} while (0)
> > > +
> > > +/* Handle arrays with a certain element type. */
> > > +#define MARK_INFO_ARRAY_WRITTEN(ptr, nr,
> > > type)                                \
> > > +       __MARK_INFO_ARRAY_WRITTEN(ptr, nr, sizeof(type))
> > > +
> > > +/* Handle arrays with element size defined by a struct member. */
> > > +#define MARK_INFO_REC_ARRAY_WRITTEN(ptr, nr, rec_size) do
> > > {                   \
> > > +       if (info_len >= offsetofend(typeof(*info),
> > > rec_size))                  \
> > > +               __MARK_INFO_ARRAY_WRITTEN(ptr, nr, info-
> > > >rec_size);            \
> > > +} while (0)
> > > +
> > > +/* Handle null-terminated strings. */
> > > +#define MARK_INFO_STR_WRITTEN(ptr, nr) do
> > > {                                   \
> > > +       if (info_len >= offsetofend(typeof(*info), ptr)
> > > &&                     \
> > > +           info_len >= offsetofend(typeof(*info), nr)
> > > &&                      \
> > > +           info-
> > > >ptr)                                                         \
> > > +               libbpf_mark_mem_written(u64_to_ptr(info-
> > > >ptr),                 \
> > > +                                       info->nr +
> > > 1);                         \
> > > +} while (0)
> > > +
> > > +/* Helper functions for telling memory checkers that arrays
> > > pointed to by
> > > + * bpf_{btf,link,map,prog}_info members are initialized.
> > > + */
> > > +
> > > +static void mark_prog_info_written(struct bpf_prog_info *info,
> > > __u32 info_len)
> > > +{
> > > +       MARK_INFO_ARRAY_WRITTEN(map_ids, nr_map_ids, __u32);
> > > +       MARK_INFO_ARRAY_WRITTEN(jited_ksyms, nr_jited_ksyms,
> > > __u64);
> > > +       MARK_INFO_ARRAY_WRITTEN(jited_func_lens,
> > > nr_jited_func_lens, __u32);
> > > +       MARK_INFO_REC_ARRAY_WRITTEN(func_info, nr_func_info,
> > > +                                   func_info_rec_size);
> > > +       MARK_INFO_REC_ARRAY_WRITTEN(line_info, nr_line_info,
> > > +                                   line_info_rec_size);
> > > +       MARK_INFO_REC_ARRAY_WRITTEN(jited_line_info,
> > > nr_jited_line_info,
> > > +                                   jited_line_info_rec_size);
> > > +       MARK_INFO_ARRAY_WRITTEN(prog_tags, nr_prog_tags,
> > > __u8[BPF_TAG_SIZE]);
> > > +}
> > > +
> > > +static void mark_btf_info_written(struct bpf_btf_info *info, __u32
> > > info_len)
> > > +{
> > > +       MARK_INFO_ARRAY_WRITTEN(btf, btf_size, __u8);
> > > +       MARK_INFO_STR_WRITTEN(name, name_len);
> > > +}
> > > +
> > > +static void mark_link_info_written(struct bpf_link_info *info,
> > > __u32 info_len)
> > > +{
> > > +       switch (info->type) {
> > > +       case BPF_LINK_TYPE_RAW_TRACEPOINT:
> > > +               MARK_INFO_STR_WRITTEN(raw_tracepoint.tp_name,
> > > +                                     raw_tracepoint.tp_name_len);
> > > +               break;
> > > +       case BPF_LINK_TYPE_ITER:
> > > +               MARK_INFO_STR_WRITTEN(iter.target_name,
> > > iter.target_name_len);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +}
> > > +
> > > +#undef MARK_INFO_STR_WRITTEN
> > > +#undef MARK_INFO_REC_ARRAY_WRITTEN
> > > +#undef MARK_INFO_ARRAY_WRITTEN
> > > +#undef __MARK_INFO_ARRAY_WRITTEN
> >
> > Ugh... I wasn't a big fan of adding all these "mark_mem_written"
> > across a bunch of APIs to begin with, but this part is really putting
> > me off.
> >
> > I like the bpf_{map,btf,prog,btf}_info_by_fd() improvements you did,
> > but maybe adding these MSan annotations is a bit too much?
> > Applications that really care about this whole "do I read
> > uninitialized memory" business could do their own simpler wrappers on
> > top of libbpf APIs, right?
> >
> > Maybe we should start there first and see if there is more demand to
> > have built-in libbpf support?
>
> I can try moving all this to selftests.

So I'm afraid this will introduce so much extra code just for marking
some memory written by kernel for MSan. It might be "cleaner" to just
zero-initialize all the memory we expect kernel to fill out, tbh.


> Alternatively this could be made a part of LLVM sanitizers, but then
> we come back to the question of resolving fd types.
>
> > BTW, is this all needed for ASan as well?
>
> Not strictly needed, but this would help detecting bad writes.

So truth be told, ASan and LeakSanitizer seem like more
immediately-useful next steps, I bet we'll find a bunch of memory
leaks and missing resource clean up sequences with this. If you are
playing with sanitizers, maybe let's start with Leak and Address
sanitizer first and make sure we run them continuously in BPF CI as
well?

And then from there let's see whether/what things we'd need to
annotate for sanitizers' sake?


>
> > One more worry I have is that given we don't exercise all these
> > sanitizers regularly in BPF CI, we'll keep forgetting adding new
> > annotations and all this machinery will start bit rotting.
> >
> > So I'd say that we should first make sure that we have sanitizer
> > builds/runs in BPF CI, before signing up for maintaining these
> > "annotations".
>
> I'll wait until LLVM folks review my patches, and then see if I can
> add MSan to the CI. Configuring it locally wasn't too complicated,
> the main difficulty is that one needs instrumented zlib and elfutils.
> For the CI, they can be prebuilt and uploaded to S3, and then added
> to the build environment and the image.

Will we need special versions of zlib and elfutils to be able to
enable ASan and LeakSan? I hope not. We might want to allow static
linking against them, though. Not sure. But as I said, I'd start with
ASan/LeakSan first.

>
> [...]
