Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033815B4294
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIIWpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiIIWp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:45:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843C7C1E9;
        Fri,  9 Sep 2022 15:45:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b35so4679366edf.0;
        Fri, 09 Sep 2022 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=D6lan38zKMOQIGF1Ne7MtFQkVxYF/iU3+Bl2miO5PNA=;
        b=Z81+J/Vly/aMDgyKIP5Rjg9VN8zyhLaLdhjMY/NEEyiggvrpVbZpuqTo+1ZFHHJRuz
         FtfXUaFlyEQX5gjkVbCtVJF05SsRrIUuy7Ya/qxPUw6FHSVArvJ5aACrYOF3zD/Cwdey
         XM/TwM5Z1za0Iz3TAT4TFMu44PvAj5PJ/4Ma1j+49PemnXu9uaiczjRhnRM8JKnLQWAN
         hSq8ckWQahg6B0e4TjjUJiZDwZRGkvUzeXzLkR/UZtCeadG0gNEcK3CIueNnS308o+6o
         baCqZBSXQsBcRC+8cCjrQ1xX4bb1jDuobHAZC5NDmU3xTqPs8cW3Gqitxh6FDd+QfC+I
         jIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=D6lan38zKMOQIGF1Ne7MtFQkVxYF/iU3+Bl2miO5PNA=;
        b=CzETrywtzBn7RiZCH3R3kaSwTndMuAxaoh4d+uJzcZI0VZQ6cyWFjZBVImEELNXtgE
         n/yVIkNIZVSndNZAul79s3gYf2h2LbtnxCG78FYh6vWGXTXy4ltfTmTdYq1NQRzvZSbQ
         I+S+6jKrNEJcDJA/w9bDVVHCBtpesSEFE9kyzxLos8AHYqE+8y2eAx6Xvsi2jCBcTZIW
         AVDDdpw9nCNLvoNQc9zr9QDJSscyu7mAICpFouZ8jRM2Ty5xguG3qYrj9rLKqlgZJqaX
         inZk6/iIHHHIGuVX+1z7VIJUVk87Fnl3s/Qk6Lo3NyrZJicd+Qbi38XeWDEQbsYulqsp
         yVWA==
X-Gm-Message-State: ACgBeo12jbdWBQ2KyFXTWjp7tMl1oT3zNLGUtGnfg37kR/CQ7KjTiDpu
        jqWOdN8I090thRNfAoX+OabURPwY9GlI/gXIXus=
X-Google-Smtp-Source: AA6agR60dbvOcU1OaWgF4lY+h7vZlmAM/MjqjlTAA2h/fHhx7mY2fZpcSoPxeK6zRs07rmM3cooZ+6DP49YY8LqOvFg=
X-Received: by 2002:a05:6402:1946:b0:44e:a406:5ff5 with SMTP id
 f6-20020a056402194600b0044ea4065ff5mr13452018edz.14.1662763524902; Fri, 09
 Sep 2022 15:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-3-void@manifault.com>
 <CAEf4BzY6oaCpHmh7x92mhqAVdPNDUe6GLndXHbqHx4i9QzjOsw@mail.gmail.com> <Yw4QjyD9tEB2xNK6@maniforge.dhcp.thefacebook.com>
In-Reply-To: <Yw4QjyD9tEB2xNK6@maniforge.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 15:45:13 -0700
Message-ID: <CAEf4Bzb=MuDYLy_VxWHtoT4SS-3D2F6MLA6TQ4z00h0Zj86WdA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 30, 2022 at 6:28 AM David Vernet <void@manifault.com> wrote:
>
> On Wed, Aug 24, 2022 at 02:22:44PM -0700, Andrii Nakryiko wrote:
> > > +/* Maximum number of user-producer ringbuffer samples that can be drained in
> > > + * a call to bpf_user_ringbuf_drain().
> > > + */
> > > +#define BPF_MAX_USER_RINGBUF_SAMPLES BIT(17)
> >
> > nit: I don't think using BIT() is appropriate here. 128 * 1024 would
> > be better, IMO. This is not inherently required to be a single bit
> > constant.
>
> No problem, updated.
>
> > > +
> > >  static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
> > >  {
> > >         u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> > > @@ -2411,6 +2417,7 @@ extern const struct bpf_func_proto bpf_loop_proto;
> > >  extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
> > >  extern const struct bpf_func_proto bpf_set_retval_proto;
> > >  extern const struct bpf_func_proto bpf_get_retval_proto;
> > > +extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
> > >

[...]

> > > +
> > > +static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
> > > +{
> > > +       u64 producer_pos, consumer_pos;
> > > +
> > > +       /* Synchronizes with smp_store_release() in user-space producer. */
> > > +       producer_pos = smp_load_acquire(&rb->producer_pos);
> > > +
> > > +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > > +        * prevents another task from writing to consumer_pos after it was read
> > > +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> > > +        */
> > > +       consumer_pos = rb->consumer_pos;
> > > +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> > > +       smp_store_release(&rb->consumer_pos, consumer_pos + size + BPF_RINGBUF_HDR_SZ);
> > > +
> > > +       /* Prevent the clearing of the busy-bit from being reordered before the
> > > +        * storing of the updated rb->consumer_pos value.
> > > +        */
> > > +       smp_mb__before_atomic();
> > > +       atomic_set(&rb->busy, 0);
> > > +
> > > +       if (!(flags & BPF_RB_NO_WAKEUP)) {
> > > +               /* As a heuristic, if the previously consumed sample caused the
> > > +                * ringbuffer to no longer be full, send an event notification
> > > +                * to any user-space producer that is epoll-waiting.
> > > +                */
> > > +               if (producer_pos - consumer_pos == ringbuf_total_data_sz(rb))
> >
> > I'm a bit confused here. This will be true only if user-space producer
> > filled out entire ringbuf data *exactly* to the last byte with a
> > single record. Or am I misunderstanding this?
>
> I think you're misunderstanding. This will indeed only be true if the ring
> buffer was full (to the last byte as you said) before the last sample was
> consumed, but it doesn't have to have been filled with a single record.
> We're just checking that producer_pos - consumer_pos is the total size of
> the ring buffer, but there can be many samples between consumer_pos and
> producer_pos for that to be the case.

you are right, never mind about single sample part, but I don't think
that's the important part (just something that surprised me making
everything even less realistic)

>
> > If my understanding is correct, how is this a realistic use case and
> > how does this heuristic help at all?
>
> Though I think you may have misunderstood the heuristic, some more
> explanation is probably warranted nonetheless. This heuristic being useful
> relies on two assumptions:
>
> 1. It will be common for user-space to publish statically sized samples.
>
> I think this one is pretty unambiguously true, especially considering that
> BPF_MAP_TYPE_RINGBUF was put to great use with statically sized samples for
> quite some time. I'm open to hearing why that might not be the case.

True, majority of use cases for BPF ringubf were fixed-sized, thanks
to convenience of reserve/commit API. But data structure itself allows
variable-sized and there are use cases doing this, plus with dynptr
now it's easier to do variable-sized efficiently. So special-casing
for fixed-sized sample a bit off, especially considering #2

>
> 2. The size of the ring buffer is a multiple of the size of a sample.
>
> This one I think is a bit less clear. Users can always size the ring buffer
> to make sure this will be the case, but whether or not that will be
> commonly done is another story.

so I'm almost certain this won't be the case. I don't think anyone is
going to be tracking exact size of sample's struct (and it will most
probably change with time) and then sizing ringbuf to be both
power-of-2 of page_size *and* multiple of sizeof(struct
my_ringbuf_sample) is something I don't see anyone doing.

>
> I'm fine with removing this heuristic for now if it's unclear that it's
> serving a common use-case. We can always add it back in later if we want
> to.

Yes, this looks quite out of place with a bunch of optimistic but
unrealistic assumptions. Doing one notification after drain will be
fine for now, IMO.

>
> > > +                       irq_work_queue(&rb->work);
> > > +
> > > +       }
> > > +}
> > > +
> > > +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> > > +          void *, callback_fn, void *, callback_ctx, u64, flags)
> > > +{
> > > +       struct bpf_ringbuf *rb;
> > > +       long num_samples = 0, ret = 0;
> > > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > > +       u64 wakeup_flags = BPF_RB_NO_WAKEUP;
> > > +
> > > +       if (unlikely(flags & ~wakeup_flags))
> >

[...]
