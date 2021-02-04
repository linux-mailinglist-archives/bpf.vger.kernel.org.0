Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2F30FBE8
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 19:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhBDStY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 13:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239379AbhBDSrS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 13:47:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E959864DE1
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612464398;
        bh=NRJXX8o+eCnGP+XM9ZOS0SkypSiTrsfrfjvK+hiTL7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBbUlW8r3/g2BBlpshszE40IrEvd3XatpdtBRKzyhDOQQcxgUo1Qr3ZfS0tRE35W3
         t+EZlbIdE/j8y9oEGP4QxkLaoNzhtwFVVP3Pdh4z8A0CiyFuk/uWl2HXQBD9/dXAFs
         ZPPZ45MpaN14xawVHt9b0PGEJbDOWJBqm9KTkym6sI+k+BX75vVrGGm/ibXzt2ZgSq
         HfscYEIvNy4Z8eynVxerDsP3Sym2paDrpvHkL8yUvCZheqloy6Kw0G3CACmLJiYydD
         Km98YR/+FIIRfimIbx1ZQxXUsh1o74ctra90+DMfN1Gp2TYwUupd0IznmDrgmaxHzN
         1X4QRvbePkNug==
Received: by mail-lf1-f44.google.com with SMTP id h12so6065309lfp.9
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 10:46:37 -0800 (PST)
X-Gm-Message-State: AOAM532BkNNfNFiMFfZirtnialt1QkhwIKZaC55vYh/IZt40PgPpaUyB
        CFYL/szCo5A5HEXaAsGbDp2flJzGE8b5dR4ZRarKfQ==
X-Google-Smtp-Source: ABdhPJwah41nVycTmuanZAvtCV+J9vEIOIhxPM9/Kg+PUV2LElyld/e5hNFmhveNeul3aYQoghSC2OauHnuvLLixAMc=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr403587lfd.233.1612464396189;
 Thu, 04 Feb 2021 10:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20210203232331.2567162-1-kpsingh@kernel.org> <20210203232331.2567162-3-kpsingh@kernel.org>
 <CAEf4Bzb4LzUPkA0SB3W2iri42=4Pv3CveWb+-a6rAJU772HvQA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4LzUPkA0SB3W2iri42=4Pv3CveWb+-a6rAJU772HvQA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 4 Feb 2021 19:46:24 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5=uNxnq7XYhZAr-R0_DyTwAbdHFEBZcopnxnodp50sFA@mail.gmail.com>
Message-ID: <CACYkzJ5=uNxnq7XYhZAr-R0_DyTwAbdHFEBZcopnxnodp50sFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf/selftests: Update the IMA test to use
 BPF ring buffer
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> >
> > @@ -44,6 +54,11 @@ void test_test_ima(void)
> >         if (CHECK(!skel, "skel_load", "skeleton failed\n"))
> >                 goto close_prog;
> >
> > +       ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf),
> > +                                  process_sample, NULL, NULL);
> > +       if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
> > +               goto close_prog;
>
> nit: could have used ASSERT_OK_PTR()

Updated this instance, I can separately clean some of the other places
to use the
ASSERT_* macros as well.

>
> > +
> >         err = ima__attach(skel);
> >         if (CHECK(err, "attach", "attach failed: %d\n", err))
> >                 goto close_prog;
> > @@ -60,11 +75,9 @@ void test_test_ima(void)
> >         if (CHECK(err, "run_measured_process", "err = %d\n", err))
> >                 goto close_clean;
> >
> > -       CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
> > -             "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
> > -
> > -       CHECK(skel->bss->ima_hash == 0, "ima_hash",
> > -             "ima_hash = %lu\n", skel->bss->ima_hash);
> > +       err = ring_buffer__poll(ringbuf, 1000);
>
> nit: given data should definitely be available here, could use
> ring_buffer__consume() instead and fail immediately if data is not
> there

Good idea. Done.

>
> > +       ASSERT_EQ(err, 1, "num_samples_or_err");
> > +       ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
> >
> >  close_clean:
> >         snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
> > diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
> > index 86b21aff4bc5..dd0792204a21 100644
> > --- a/tools/testing/selftests/bpf/progs/ima.c
> > +++ b/tools/testing/selftests/bpf/progs/ima.c
> > @@ -9,20 +9,37 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >
> > -long ima_hash_ret = -1;
> > -u64 ima_hash = 0;
> >  u32 monitored_pid = 0;
> >
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +       __uint(max_entries, 1 << 12);
> > +} ringbuf SEC(".maps");

[...]

> > +               sample = bpf_ringbuf_reserve(&ringbuf, sizeof(u64), 0);
> > +               if (!sample)
> > +                       return;
> >
> > -       if (pid == monitored_pid)
> > -               ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
> > -                                                 &ima_hash, sizeof(ima_hash));
> > +               *sample = ima_hash;
> > +               bpf_ringbuf_submit(sample, BPF_RB_FORCE_WAKEUP);
>
> no need for BPF_RB_FORCE_WAKEUP, notification should happen
> deterministically. And further, if you use ring_buffer__consume() you
> won't even rely on notifications. Did you see any problems without
> this?

Yes, it works without BPF_RB_FORCE_WAKEUP too, I thought I had removed it,
which I clearly didn't :)

>
> > +       }
> >
> > -       return 0;
> > +       return;
> >  }
> > --
> > 2.30.0.365.g02bc693789-goog
> >
