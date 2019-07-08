Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93B06298E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 21:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfGHT1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 15:27:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41371 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731757AbfGHT1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 15:27:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so8000257ljg.8
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBiM1zuJcMeI5+Yh7uSULiKYh4N3pjaRPeoWwFExL2I=;
        b=FZEcmfrbgVB9oSvv6DR9H/ifdOBifbonqSVyZsCWHrbrGsqK2aqIXdMjaf55sG/nhR
         jKFMqCovPW5aDWDnyF+508ZnpFF01kOUIK5JAyT9eblCYZ5tFqLcUlL2sJH8YqgjycM8
         SYHQQr8xB6e9xNiwyKKLr6ROHChPhvm/MeuOMaCsrBdzeiXErDQ4AgfOWTYt4+EMXiED
         svGUlOZZxjBrsinxTFExWUfVbXz1cTjDm/pS5bimWpMFVmGQ5UVSljsA65eFD53tdlwh
         +HYvUvkmnCjSRguoLjdFDfE3RloLQOUl61v+8Y0udgsJjMyOVGNuw5Jgae/LBftvJn3d
         pdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBiM1zuJcMeI5+Yh7uSULiKYh4N3pjaRPeoWwFExL2I=;
        b=ohOnvcSxh6JLMSQomWzdDkk1qRKpbinYMnMJyelaiEmXAqeXr0Wrqc2dla0LjBjHZH
         Eqae93GNDwi33XgZGo3wky+xf6ctzAIMDL5ODqe3k4IGexXG6DDmtgD3bVMM3y3gOzi/
         wb6UzQLYCscIR5asdOSAHPdf2TUWQ6MDYHWexZPkoQbwe/NoB+3o5x+es1gfQcinE+xS
         hZxlb0UTHM/rhLu885TaZzmKGNnJv7SkyZfGHKJTSnk6HELWUnj2Gab8OyLt57iuBrlQ
         OMj4UXqDKSJz/FWfLZmTYHSW8WI6E65HcXgXYHKpqP+WFTogeIS3Axrphpf/mP0X1yOS
         n4nw==
X-Gm-Message-State: APjAAAVAQNIrAZ5iw1jbRP/Frh+7rOYdBuiTO4HCIfZJQHVgiA6uawu/
        yQ+PuKIE3N02IpyLlfxDpXDObUOel6UmjRnyO0Pyh2khPlk=
X-Google-Smtp-Source: APXvYqy94epGJ/pl+EPbcFtXw+l8ibJnUhkDlIVSp+6lMe4yhWqOzkowNrelthGUm8LGtvwX0B8SnbtrOqe8aW++2+4=
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr11125546lji.231.1562614033738;
 Mon, 08 Jul 2019 12:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAH+k93FQkiwRXwgRGrUJEpmAGZBL03URKDmx8uVA9MnLrDKn0Q@mail.gmail.com>
 <CAEf4Bzb-EM41TLAkshQa=nVwiVuYnEYyhVL38gcaG=OaHoJJ6Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzb-EM41TLAkshQa=nVwiVuYnEYyhVL38gcaG=OaHoJJ6Q@mail.gmail.com>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Mon, 8 Jul 2019 20:27:02 +0100
Message-ID: <CAH+k93G=qGLfEKe+3dSZPKhmxrc8JiPqDppGa-yLSwaQYRJU=Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] libbpf: add kprobe/uprobe attach API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 8 Jul 2019 at 18:58, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Mon, Jul 8, 2019 at 8:11 AM Matt Hart <matthew.hart@linaro.org> wrote:
> >
> > Hi all,
> >
> > I bisected a perf build error on ARMv7 to this patch:
> > libbpf.c: In function =E2=80=98perf_event_open_probe=E2=80=99:
> > libbpf.c:4112:17: error: cast from pointer to integer of different
> > size [-Werror=3Dpointer-to-int-cast]
> >   attr.config1 =3D (uint64_t)(void *)name; /* kprobe_func or uprobe_pat=
h */
> >                  ^
> >
> > Is this a known issue?
>
> No, thanks for reporting!
>
> It should be
>
> attr.config1 =3D (uint64_t)(uintptr_t)(void *)name;
>
> to avoid warning on 32-bit architectures.

Tested with manual change and can confirm perf now builds without errors.

>
> I'll post a fix later today, but if you could verify this fixes
> warning for you, I'd really appreciate that! Thanks!
