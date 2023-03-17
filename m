Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BDF6BEECD
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCQQsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCQQsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:48:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D24D42C
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:48:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so22860615edd.1
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMG3hYXRNRwUAMVJwodRXv6D5CLBldxvGeuubUbOhr4=;
        b=Nn+fFv2inJndYP5GNFnfdHOw0L3uYApn3b4QuoBa0QHKGY+u9bdCEnbWaqQiQZxvVd
         6chrInI7zYNd3tEClEFvHiKljTlW2rE4u6QNmQJVd64OXfiHTh2LdZTUB1BQesh3tvqJ
         AvAmWfCt9sQ7pF0dE+GYR7DAlNychIAuEUsD4oC6HBVhuBXgDN2HXYyKSQcR3tmUeI3F
         L8xKm6taCK5ZhcguB6yenjVDTEvuEN14aoVZu1D13G9LuVNkvp8HRM/bMyy2hPjpjtn2
         4JhcS43k+tqdLW3Q3BfAp+oTGUwo8BmbVvj3d9K9HXzlvqKF6c4YQoKQZ9ld9TtLpN0s
         L3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMG3hYXRNRwUAMVJwodRXv6D5CLBldxvGeuubUbOhr4=;
        b=jI7SlW5yNiLaKPWA2qMcw8PQmPGCRHDmlZN4MssS8oiDN5GkSqNoVDeQCd6bmhJCKU
         RBKYitvGjh7lD+P9QhCGxLqW+j4KyKTiVJxORrZ1VCFmyvbZ3AaAocsTp234OBF/NqR7
         P+uTLoY4CdysGjVf8OehxvHkpoD5d77PUuTcgLfK6g6ljfx9hziFapP7sQQh8xY/YeLO
         rck7TJfGDMjXwi0IkoW851bQ9YNrzKn1F1XPK4SYIk0dkBR6fJDAldIBiUh1gUDWCTWg
         aW2IS3y3gahfwKO7Lp2Q8iHG9uDgXvWSorCjjUUptv898UXm1oS806GAzJWV551GR0gL
         bcpQ==
X-Gm-Message-State: AO0yUKXDB4ujj2ln8zMTCrTeu9FOaRfhPDSu6TT8ZgzPJyZN1hhSicNZ
        j0ebixsjj8dH9vV0LiglJw0me3XqIvBddGXQYxw=
X-Google-Smtp-Source: AK7set+8M0urd/H7G/8zjloYryg8ErlAd+CdSOL8ox2gABQ+DQr6uFrfnBdlT2Efa+BNP6na3R0AM1BDCe5UjYnGAkU=
X-Received: by 2002:a50:8e14:0:b0:4fb:f19:883 with SMTP id 20-20020a508e14000000b004fb0f190883mr2142013edw.1.1679071680313;
 Fri, 17 Mar 2023 09:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230316183013.2882810-1-andrii@kernel.org> <20230316183013.2882810-4-andrii@kernel.org>
 <dacb74f46aef078e101d631ce95f03fddf17e284.camel@gmail.com>
In-Reply-To: <dacb74f46aef078e101d631ce95f03fddf17e284.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 09:47:48 -0700
Message-ID: <CAEf4Bzbr=HoJ5xUx7AyqGjMi=bydVSOU__LZ4_GKzG0FPkxwCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
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

On Fri, Mar 17, 2023 at 8:05=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-03-16 at 11:30 -0700, Andrii Nakryiko wrote:
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
> I tried bpf_verifier_vlog() and bpf_vlog_finalize() using some
> randomized testing + valgrind and everything seems to be fine.

Thanks for additional testing!

> Tbh, it seems to me that having kunit tests for things like this might
> be a good idea.

I found that this user-space driven testing using variable log_buf
size causes all the different corner cases, so felt confident enough
that match is right.

I missed the issue that Alexei caught because it never went past
user-space buffer (those 1K bytes), so it was poking zeros in
unused/unchecked portion of user-provided buffer. I'll add explicit
test that that contents is not modified (probably will fill with some
character and check that nothing changed. Hopefully that will be
enough to prevent any such issues in the future.


>
> Test script for reference:
>
>   void once(char *in, size_t out_sz) {
>         struct bpf_verifier_log log =3D {};
>         char *out =3D calloc(out_sz, 1);
>         size_t in_sz =3D strlen(in);
>         size_t orig_out_sz =3D out_sz;
>
>         log.ubuf =3D out;
>         log.len_total =3D out_sz;
>         log.level =3D 1 | 2 | 4;
>
>         for (char *input =3D strtok(in, " "); input; input =3D strtok(NUL=
L, " "))
>                 bpf_verifier_vlog(&log, input);
>
>         bpf_vlog_finalize(&log);
>
>         for (unsigned i =3D 0; i < in_sz; ++i)
>                 if (in[i] =3D=3D 0)
>                         in[i] =3D ' ';
>
>         out_sz =3D strlen(out);
>         if (in_sz)
>                 --in_sz;
>         if (out_sz)
>                 --out_sz;
>         while (out_sz > 0 && in_sz > 0) {
>                 if (in[in_sz] =3D=3D ' ') {
>                         --in_sz;
>                         continue;
>                 }
>                 if (in[in_sz] =3D=3D out[out_sz]) {
>                         --in_sz;
>                         --out_sz;
>                         continue;
>                 }
>                 printf("    in: '%s'\n", in);
>                 printf("   out: '%s'\n", out);
>                 printf("err at: %lu\n", out_sz);
>                 printf("out_sz: %lu\n", orig_out_sz);
>                 break;
>         }
>
>         free(out);
>   }
>
>   void rnd_once() {
>         char in[1024] =3D {};
>         size_t out_sz =3D 1 + rand() % 100;
>         size_t in_sz =3D rand() % (sizeof(in) - 1);
>         int cnt =3D 0;
>
>         for (unsigned i =3D 0; i < in_sz; ++i)
>                 if (rand() % 100 < 7)
>                         in[i] =3D ' ';
>                 else
>                         in[i] =3D 'a' + (rand() % 26);
>
>         once(in, out_sz);
>   }
>
>   int main(int argc, char **argv) {
>         if (argc =3D=3D 3) {
>                 once(argv[2], atoi(argv[1]));
>         } else {
>                 srand(clock());
>                 for (int i =3D 0; i < 100000; ++i)
>                         rnd_once();
>         }
>   }
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>
> > ---
> >  include/linux/bpf_verifier.h                  |  32 ++-
> >  kernel/bpf/log.c                              | 182 +++++++++++++++++-
> >  kernel/bpf/verifier.c                         |  17 +-
> >  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
> >  4 files changed, 209 insertions(+), 23 deletions(-)
> >

[...]
