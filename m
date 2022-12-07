Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40F644FE5
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLGABG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLGABC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:01:02 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C64B742;
        Tue,  6 Dec 2022 16:00:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so8656953eji.5;
        Tue, 06 Dec 2022 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jas4TSAtuN6LWbtIF+nPUMnpUZPrF2EDu/+wlEL6xKY=;
        b=TrwcaV6uea9EW0PMoloiHKU/VSG8RGuKCGSV5hMfvnxtYoszOgUEiH17o2x69cfIDi
         8jD8YuqOsLSwUreU6OftZ57y2nhckiGwC7ijw3ZgMNgf9ax4w4v1gLubxtC/zMQQC+0C
         yVAhKTJzt0PekNBrT4o2WNyJAdnKcSlei37WeaKQUylUM3p4pTfisqMfzM/qGvGQj3Pt
         5zxz/Nij1OD3/f1atp0xegdXG9VMRPvH+2UZwh2mSEebSlrc18YF5MHajEqdMJUww/o8
         xABO8HVOq9ksyM1pRieUM1TLoVgsGg+I1mxLu+Wl00WZxn+EXr6tEXTThGAerwOa8XBo
         dx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jas4TSAtuN6LWbtIF+nPUMnpUZPrF2EDu/+wlEL6xKY=;
        b=idgx4/5MmJOLKaHgCFngdQayfduGD4hm1AYxcWoqXhXSB9mbSUuXxzL4iJgeGlcPqp
         O1R6kVaiht6ruzCo/Vg6M25OHHlC4EK3Jimdcz6rGf3Z2KnAKWcbmxjk48uQLuwvx5BA
         A4RXXa/E8OijZsgw+Ok18Gm7rB+9G1/sZckKvy7RaqJ1gqbKdqBt6t51Cw8fS9qMTiTB
         /lp5BaWT5j6sJ/8oXZfMqMOxH/hZPI2qiL2yC1APNdOMwUVKSuSxer25VXpXxk9hJC8/
         ROJVBjriS5m60ugW3aSmL6wqrqApyCmOFinD8WArTs4qwPSHoGArcpCVVrccPIJKTzQK
         DAfw==
X-Gm-Message-State: ANoB5pkxyGS/95VPpwNmSGeDA3ZpV6mA6sved0QYu69Idma0pTW14hT6
        jbLgBg6PqQfzIzWeBQE3ugpO8KnKEKfnUEx3QEk=
X-Google-Smtp-Source: AA0mqf7WomRPJaUkDEFCYGS12V6R+ykI+I6TTA8rn6zM7gA50KeoFNowe0qEZCK3K29/FkK6wzS4bZW7+9+PyyAqESg=
X-Received: by 2002:a17:906:3e53:b0:7c1:1f2b:945f with SMTP id
 t19-20020a1709063e5300b007c11f2b945fmr275331eji.302.1670371257785; Tue, 06
 Dec 2022 16:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20221203093740.218935-1-liuxin350@huawei.com> <6ac9f767-e7f5-6603-6234-97126ea22005@iogearbox.net>
In-Reply-To: <6ac9f767-e7f5-6603-6234-97126ea22005@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 16:00:45 -0800
Message-ID: <CAEf4BzaC6hhNzKkzFa+s4bws7APWj-Nk8Uup+3J6avCXnMFziA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Optimized return value in
 libbpf_strerror when errno is libbpf errno
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Mon, Dec 5, 2022 at 1:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/3/22 10:37 AM, Xin Liu wrote:
> > This is a small improvement in libbpf_strerror. When libbpf_strerror
> > is used to obtain the system error description, if the length of the
> > buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> > ERANGE.
> >
> > However, this processing is not performed when the error code
> > customized by libbpf is obtained. Make some minor improvements here,
> > return -ERANGE and set errno to ERANGE when buf is not enough for
> > custom description.
> >
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >   tools/lib/bpf/libbpf_errno.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> > index 96f67a772a1b..48ce7d5b5bf9 100644
> > --- a/tools/lib/bpf/libbpf_errno.c
> > +++ b/tools/lib/bpf/libbpf_errno.c
> > @@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t size)
> >
> >       if (err < __LIBBPF_ERRNO__END) {
> >               const char *msg;
> > +             size_t msg_size;
> >
> >               msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
> >               snprintf(buf, size, "%s", msg);
> >               buf[size - 1] = '\0';
> > +
> > +             msg_size = strlen(msg);
> > +             if (msg_size >= size)
> > +                     return libbpf_err(-ERANGE);
>
> Given this is related to libbpf_strerror_table[] where the error strings are known
> lets do compile-time error instead. All callers should pass in a buffer of STRERR_BUFSIZE
> size in libbpf.

That sounds a bit too pessimistic?.. If the actual error message fits
in the buffer, why return -ERANGE just because theoretically some
error descriptions might fit?

But I don't think we need to calculate strlen(). snprintf above
returns the number of bytes required to print a full string, even if
it was truncated. So just comparing snprintf's result to size should
be enough.

>
> >               return 0;
> >       }
> >
> >
>
