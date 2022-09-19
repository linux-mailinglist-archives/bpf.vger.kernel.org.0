Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C85BD821
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 01:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiISXT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISXTM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 19:19:12 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541EE50198;
        Mon, 19 Sep 2022 16:19:11 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id y2so647161qtv.5;
        Mon, 19 Sep 2022 16:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZXtqtJ/ea5WuAK5JJBouQcp3rbN8LV4upygNznVncj8=;
        b=QHr+dm/tg7dJtT/HqbaBjTZSOTteeFctsy7LIJ5exUMIf/gylnr9Yjz+OD85PXAuQF
         LXNHSijVMEkOZh+Xez52tnZjR/CkQ2h4NdZATP8AgSXRPrAizfWWPRMltOgbJzhp9f3T
         CHLjtyNdTQOHGq5P5mjeHnkydbHk6UX9RXidGpt0z2mmlR+mTtdVIsNJZgbcB6NTC/pI
         NatDbekr59je2Nq43XRRqGxKZc9FwXmCmBLw8MReHJUQUO/4qoYshPoUkzzIwX1J1tk0
         d+j7wb7xvMKPDwwFhnBrCcqV1Vo3dzvYTxFwiSZLT61l7AZj0dVi73NRdiDF9njuuDIR
         vCNg==
X-Gm-Message-State: ACrzQf30TMb5+4fUOXTB4GuylKpXUpA6mmjRKcVWSO1+amU0FtRC0Wl9
        M8Xbd1VoSrjSt/7WZLJHXfI=
X-Google-Smtp-Source: AMsMyM7NFBScQzKm4DLElxBX0PkeMlBAsh8SvSjEqdrqhH/K8AWn19bUk/Kzg6NwLQGV2SQ7Nys+8g==
X-Received: by 2002:a05:622a:351:b0:35c:e183:69a2 with SMTP id r17-20020a05622a035100b0035ce18369a2mr9376235qtw.298.1663629550296;
        Mon, 19 Sep 2022 16:19:10 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b006ce7cd81359sm14650477qkp.110.2022.09.19.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:19:10 -0700 (PDT)
Date:   Mon, 19 Sep 2022 18:19:08 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        bpf@vger.kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/4] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <Yyj47Bc01MvJyU9n@maniforge.dhcp.thefacebook.com>
References: <20220902234317.2518808-1-void@manifault.com>
 <20220902234317.2518808-3-void@manifault.com>
 <CAEf4BzZgv7W=OBi+PogxrvuM1c8QRoZ8O4s347MfKdm-p=qY0w@mail.gmail.com>
 <YyjO2LspZ3GDELDw@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyjO2LspZ3GDELDw@maniforge.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 19, 2022 at 03:19:36PM -0500, David Vernet wrote:
> > > +static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
> > > +{
> > > +       u64 consumer_pos;
> > > +       u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> > > +
> > > +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > > +        * prevents another task from writing to consumer_pos after it was read
> > > +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> > > +        */
> > > +       consumer_pos = rb->consumer_pos;
> > > +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> > > +       smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
> > > +
> > > +       /* Prevent the clearing of the busy-bit from being reordered before the
> > > +        * storing of the updated rb->consumer_pos value.
> > > +        */
> > > +       smp_mb__before_atomic();
> > > +       atomic_set(&rb->busy, 0);
> > > +
> > > +       if (flags & BPF_RB_FORCE_WAKEUP)
> > > +               irq_work_queue(&rb->work);
> > 
> > I think this part is new, you decided to define that FORCE_WAKEUP
> > sends wakeup after every single consumed sample? I have no strong
> > opinion on this, tbh, just wonder if it wasn't enough to do it once
> > after drain?
> 
> I didn't have a strong reason for doing this other than that I think it
> more closely matches the behavior for BPF_MAP_TYPE_RINGBUF (which invokes
> irq_work_queue() after every call to bpf_ringbuf_commit() if
> BPF_RB_FORCE_WAKEUP is passed). Let's just match that behavior unless we
> have a good reason not to? I think that will be more intuitive for users.

Hmm, something else to consider is that if we move the busy-bit setting
into bpf_user_ringbuf_drain() per your suggestion below, the critical
section is now the the whole sample drain loop. That's of course _not_ the
case for BPF_MAP_TYPE_RINGBUF, which just holds the spinlock while
reserving the sample. It seems excessive to invoke irq_work_queue() while
the busy bit is held, so I think we should just have the behavior be to
only have BPF_RB_FORCE_WAKEUP imply that a wakeup will always be sent, even
if no sample was drained.

Let me know if you disagree, but for now I'll work on spinning up a v6 that
only issues the forced wakeup event once after drain.

> > > +}
> > > +
> > > +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> > > +          void *, callback_fn, void *, callback_ctx, u64, flags)
> > > +{
> > > +       struct bpf_ringbuf *rb;
> > > +       long samples, discarded_samples = 0, ret = 0;
> > > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > > +       u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
> > > +
> > > +       if (unlikely(flags & ~wakeup_flags))
> > > +               return -EINVAL;
> > > +
> > > +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> > > +       for (samples = 0; samples < BPF_MAX_USER_RINGBUF_SAMPLES && ret == 0; samples++) {
> > > +               int err;
> > > +               u32 size;
> > > +               void *sample;
> > > +               struct bpf_dynptr_kern dynptr;
> > > +
> > > +               err = __bpf_user_ringbuf_peek(rb, &sample, &size);
> > 
> > so I also just realized that ringbuf_peek will keep setting/resetting
> > busy flag, and in like all the practical case it's a completely
> > useless work as we don't intend to have competing consumers, right? So
> > maybe move busy bit handling into drain itself and document that peek
> > expect busy taken care of?
> > 
> > This should be noticeable faster when there are multiple records
> > consumed in one drain.
> 
> Great idea, I'll do this in v6.

Thanks,
David
