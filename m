Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5536D851F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjDERot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDERop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:44:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF440C4
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:44:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so143063659edd.5
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRqXVTibT1cGfMn1kpBISw8lKhONQScAvqjS94egmfk=;
        b=KTiZdkkGe71qjH90PJW/gi1ewIDlrYH9+pDXu4u/YrVPpRT8QYL0nrdu/oh0ZWWc1t
         gb9aczaLwiejA45yq8JKN6B+1+xs52HZFRuHyD0QmD80BYPM1J5CIsGWefgLC1Uuvs0E
         YHvjoSsBdaZmbkDpQS0sE3m/1T2VZ3i/5oLGhhQiA3i1whevO+6u8o8d0uf2OENGBA+F
         CK0IjtRc7RHyp35gfKTWuZqeIk/wnECGrFiurdRvmyp0CaToP91w9rdx4CSzE1W11YEP
         Ax/eyoF5TYb+vE1XhDMR5S31z/hN11wQ6KT9E3dnfg2YPY7+de7lkEHQInMFS8URY3hB
         XJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRqXVTibT1cGfMn1kpBISw8lKhONQScAvqjS94egmfk=;
        b=s70KMV/Fd83PgnYqVvb4rk65B/f21BHfnLrvFXMp/ZWhOITsRwvuleIRA7gAhauPIP
         /kQ6yf23cZM8qNA0dPKM9IOo4AqOhp+HlRdbw/dx69Id16JTAExwc0n4d/JzYbuI0K4h
         Yd4VZ2PLCkWgTH7hT0u0AytkHRaPfrSlK3tzqZjlW/Gw7nz+7/6D4OxXjh5AGwJLHgnA
         1RyKn4LebmDz4NPMscq3E8eLlivLLJ1JX+JIEDYd4YNbfW2zEhZQ1hr2FAvwb99+oTkI
         4O+YpIvb2z4NlIIvPM3r0nJNkHofJsuPOaUZIHWTZDeJxCe5hbSFPVuj/y0L64hKOPyI
         P3Cg==
X-Gm-Message-State: AAQBX9fL4W9hfo6by6sLb+8F38DHbN2aO9NXRSksXMGF9H6L1l1Er7xV
        NFnPKIFxgypVQT55iyW9+AZ5qsq8LHg0d0gOP10=
X-Google-Smtp-Source: AKy350Zhe4ESG0mx/rVksxpPuRInFmD+0Z7PiUAp6RQD2HIgS5V3Xw8s+vqtcw5Zi3LOf9w+Q1vhKIAUDFnhykMJ6F0=
X-Received: by 2002:a17:907:76dc:b0:944:70f7:6fae with SMTP id
 kf28-20020a17090776dc00b0094470f76faemr1912321ejc.5.1680716682771; Wed, 05
 Apr 2023 10:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
 <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
In-Reply-To: <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 10:44:30 -0700
Message-ID: <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:29=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Drop the log_size>0 and log_buf!=3DNULL condition when log_level>0. Thi=
s
> > allows users to request log_size_actual of a full log without providing
> > actual (even if small) log buffer. Verifier log handling code was mostl=
y ready to handle NULL log->ubuf, so only few small changes were necessary =
to prevent NULL log->ubuf from causing problems.
> >
> > Note, that user is basically guaranteed to receive -ENOSPC when
> > providing log_level>0 and log_buf=3D=3DNULL. We also still enforce that
> > either (log_buf=3D=3DNULL && log_size=3D=3D0) or (log_buf!=3DNULL && lo=
g_size>0).
>
> Is it possible to change it so that log_buf =3D=3D NULL && log_size =3D=
=3D 0
> && log_level > 0 only fills in log_size_actual and doesn't return
> ENOSPC? Otherwise we can't do oneshot loading.
>
>   if PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) >=3D 0:
>     return fd
>   else
>     retry PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)
>
> If the first PROG_LOAD returned ENOSPC we'd have to re-run it without
> the log enabled to see whether ENOSPC is masking a real verification
> error. With the current semantics we can work around this with three
> syscalls, but that seems wasteful?
>
>   if PROG_LOAD(buf=3DNULL, size=3D0, level=3D0) >=3D 0:
>     return fd
>
>   PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) =3D=3D ENOSPC
>   PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)

We could and I thought about this, but verifier logging is quite an
expensive operation due to all the extra formatting and reporting, so
it's not advised to have log_level=3D1 permanently enabled for
production BPF program loading. So I didn't want to encourage this
pattern. Note that even if log_buf=3D=3DNULL when log_level>0 we'd be
doing printf()-ing everything, which is the expensive part. So do you
really want to add all this extra overhead *constantly* to all
production BPF programs?
