Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF546BF60A
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCQXNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCQXNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:13:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7249D0
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:13:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id er8so14390394edb.0
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679094785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A52h1IirVGjBb60KcQpdYTIOWZWxeOQC2P1jf+ep/s=;
        b=UrBLt/OE+ikLWzwiypJQ2TjmIvfrJP8UUAwB22hyQYwQw+GLNtbhBqjDyQYlFeT5MH
         CrY6Pz60b/vsoEmnyBGImZJIIcvYFlDPj4YKa5Ro6fIS7CtN6rBV2LSpQ21I4omzAsGm
         ZtRUjLx4xrA4jJOdLrHAsymDdRfXXM+0PC35+5yYi5k8RjyAjKNPFjEIA/hUcaz0dS4u
         q2s87xrzhPKuDhJMmRBCeyylxNeK8fyzhZDiyOel/2r5owNCzWxuRiaxa5E8JBz8YyGZ
         JVFFyIcL0Nyck4r5D3B7Tf9yNfY2mXiZoF/mGpdpet2KNHRFrt0Dd1pn9OQnjXzYKukr
         3iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A52h1IirVGjBb60KcQpdYTIOWZWxeOQC2P1jf+ep/s=;
        b=6nCksSDCOtdSP9kOe7/6xodLy+KA3cGKac0WkEyM+ryPefeHOHOkDSIDxmzFH6wBoc
         UBm1eFCN2I9Okpt2xOdxWgzZ9dBzJAxUSzXkvw4vYmw1qnqeUdqj0H9LVYgRJ0NvYMKv
         Zk1Q6OAlg5YEytj8oMmsw3Jky4iU+gf5OqFdrfbIcArs5TgquYVm0AFfayfNmRPd3HFM
         GdUiyzrPpzYnlr8NVrSo0j2v8ZIvFkiRefeJ+73SMRWRGv6CNmB4KsCEjNseXteJhZdi
         OrUJhEHaL3FrP5CHNgw2bY2h5LQQ2kl8T95ux1QDxdHAtrhxmuu6Ez0YbjvgYhndanCE
         Bv5A==
X-Gm-Message-State: AO0yUKV0LDmBVsQXv3RekwPWquof5fExjL8mdWlljV44aErglPva+4mM
        RhttJ6Bc3LEAl2qMY96lYkgNkbE7xfLS+emM+l4=
X-Google-Smtp-Source: AK7set/E+2qOTLoRWNtonKbVQHBOsmhFPaN5upw7Yhm1RQJDADfFtV4zzvwcJrGQ8IDD2Ywotd35FNn1q/Rte1nnDqo=
X-Received: by 2002:a50:8e14:0:b0:4fb:f19:883 with SMTP id 20-20020a508e14000000b004fb0f190883mr2691047edw.1.1679094784845;
 Fri, 17 Mar 2023 16:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
 <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net>
In-Reply-To: <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 16:12:52 -0700
Message-ID: <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
        i@lmb.io, timo@incline.eu, alessandro.d@gmail.com,
        Dave Tucker <dave@dtucker.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 4:02=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/17/23 11:03 PM, Andrii Nakryiko wrote:
> > Currently, if user-supplied log buffer to collect BPF verifier log turn=
s
> > out to be too small to contain full log, bpf() syscall return -ENOSPC,
> > fails BPF program verification/load, but preserves first N-1 bytes of
> > verifier log (where N is the size of user-supplied buffer).
> >
> > This is problematic in a bunch of common scenarios, especially when
> > working with real-world BPF programs that tend to be pretty complex as
> > far as verification goes and require big log buffers. Typically, it's
> > when debugging tricky cases at log level 2 (verbose). Also, when BPF pr=
ogram
> > is successfully validated, log level 2 is the only way to actually see
> > verifier state progression and all the important details.
> >
> > Even with log level 1, it's possible to get -ENOSPC even if the final
> > verifier log fits in log buffer, if there is a code path that's deep
> > enough to fill up entire log, even if normally it would be reset later
> > on (there is a logic to chop off successfully validated portions of BPF
> > verifier log).
> >
> > In short, it's not always possible to pre-size log buffer. Also, in
> > practice, the end of the log most often is way more important than the
> > beginning.
> >
> > This patch switches BPF verifier log behavior to effectively behave as
> > rotating log. That is, if user-supplied log buffer turns out to be too
> > short, instead of failing with -ENOSPC, verifier will keep overwriting
> > previously written log, effectively treating user's log buffer as a rin=
g
> > buffer.
> >
> > Importantly, though, to preserve good user experience and not require
> > every user-space application to adopt to this new behavior, before
> > exiting to user-space verifier will rotate log (in place) to make it
> > start at the very beginning of user buffer as a continuous
> > zero-terminated string. The contents will be a chopped off N-1 last
> > bytes of full verifier log, of course.
> >
> > Given beginning of log is sometimes important as well, we add
> > BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> > tools like veristat to request first part of verifier log, if necessary=
.
> >
> > On the implementation side, conceptually, it's all simple. We maintain
> > 64-bit logical start and end positions. If we need to truncate the log,
> > start position will be adjusted accordingly to lag end position by
> > N bytes. We then use those logical positions to calculate their matchin=
g
> > actual positions in user buffer and handle wrap around the end of the
> > buffer properly. Finally, right before returning from bpf_check(), we
> > rotate user log buffer contents in-place as necessary, to make log
> > contents contiguous. See comments in relevant functions for details.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Did you check behavior with other loaders if changing default works ok
> for them, e.g. their behavior/buffer around ENOSPC handling for growing?
>
> The go loader library did some parsing around the log [0], adding Lorenz
> and Timo for Cc for checking.

I didn't, no. Thanks for pinging Lorenz and Timo.

Libbpf by default uses 16MB right now, I didn't touch that part yet,
but it might be good to reduce this size if the kernel supports this
new behavior. Go library seems to be using 64KB, which probably would
be adequate for a lot of cases, but yeah, maybe Go library would like
to use slightly bigger default if rotating log behavior is supported
by kernel?

Alternative would be to make this rotating behavior opt-in, but that
would require active actions by multiple libraries and applications to
actively detect support. Given the rotating behavior seems like a good
default behavior I wish we had from the very beginning, I went for
making it default.

Let's see what Lorenz and Timo think.

Adding also aya-rs main contributors (Allesandro and Dave). Seems like
aya-rs uses very small 10KB minimum log buf size, which might be a bit
inadequate with rotating log semantics.



>
>    [0] https://github.com/cilium/ebpf/blob/master/internal/errors.go
>        https://github.com/cilium/ebpf/blob/master/prog.go#L61
