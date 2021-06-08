Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842B839FC9D
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFHQfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFHQfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 12:35:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB7C061574
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 09:33:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so31026300ybi.12
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Byo/h/HDruOFzOy6rB37ipA5JjuE+03Q82tP9Iv4MlQ=;
        b=sZ47hAm741l11+SE70UBfv5tScKtezW2KnFG0Ah4YGSyTkBFm6vIQPt7ykKClpEN/U
         ULiYJ9M/84RQHk3hTISfyv0QR5Yu/hxr/vF1E4aKlwZdpORGxcj9Frp8H5/VAwC9P+lr
         s0/37LREEW2/tnjldmh3RIVoqOvn/ZhEYSJjn9bsNm8ek+FV3O2P/qbRJlr080xK2V+5
         GkoMEuOoI8rlQSIroFnmnuJsAhEfehYm/hVNzj2VFU0CdyChBxYBgOR/XA6lyXldWAxd
         fv9VGNHNRgRzxLFdyvUX8EWLbLkjJ11I4OAV1cjxFIepu0sRLWNlBrveq2wCZwvbOatq
         952w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Byo/h/HDruOFzOy6rB37ipA5JjuE+03Q82tP9Iv4MlQ=;
        b=fa9/sbzzi7AqjmOS2BJeVRRCozDcaN6YeYPwjZ3GzxqsFFXZ8wryzvDSslzjxqldZX
         m39qQqr481WX6TMN6WD2PPFdbXgsroAgHYZArX1fI3RzNpRTvju7XW0qUo7SZfgFnttG
         kbd0QuwNduYwOrtuIP+sLB3WNM/RdVLG5xh7cdG8xtpFLqs1sFM6Trg51eFPadLWtPUy
         aIkj/LWkDyTxH+h/bIvTA5Whsvb98W9L+01ycYHbeLpi/nHjG5dwV6nG18PxzU1ttvz6
         GIKeneRRrhrEgXLqBri1/V3lb8uqZZHiwYOzw9yXmimVMx4LHS4lcgzwbXQ+VJN2Q7+w
         RwSA==
X-Gm-Message-State: AOAM531auRuFs6P/I152ePQ9AOEYXKfz32fnu19cwCS7aZP56L0HWw5V
        g8TOqE2MoPdLEMU9keMV6/maktUHov/DerCgTvjkZA==
X-Google-Smtp-Source: ABdhPJympuD33KkdV0dCMYhrIew3Raw1K4B8gBYNg2UbOK20sGRBrtHjfXUb8R5NZp/xarE27XHDa1gCgEfzOM+oMGM=
X-Received: by 2002:a25:2442:: with SMTP id k63mr34836090ybk.106.1623170019556;
 Tue, 08 Jun 2021 09:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com> <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
 <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
In-Reply-To: <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 8 Jun 2021 09:33:28 -0700
Message-ID: <CAFP8O3KayCgP6OqF1Vx8afav==jkL038m0rK66b7jJ0DOO=uJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 8, 2021 at 8:49 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 7, 2021 at 10:51 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@goo=
gle.com> wrote:
> >
> > You can rename R_BPF_64_64 to something more meaningful, e.g. R_BPF_64_=
LDIMM64.
> > Then I am fine that such a relocation type applies inconsecutive bytes.
> >
> > See below. Just change every occurrence of the old name in llvm-project=
.
>
> No. We cannot rename them, because certain gnu tools resolve relos by nam=
e
> and not by number.

How do the GNU tools resolve relocations by name instead of by
relocation type number?
I don't think this should and can be supported.

Most tools should do:
if (type =3D=3D R_BPF_64_64) do_something();

You are free to change them to
if (type =3D=3D R_BPF_64_LDIMM64) do_something();
as long as R_BPF_64_LDIMM64 is defined as the number.

> The only thing we can do is to document why such a name was picked in
> the first place.
> Back then 64_64 meant that it applied to 64-bit field in 16-byte insn.
> Whereas 64_32 meant that it applied to 32-bit field in 8-byte insn.
> 64_64 used to be called 64_MAPFD relo, but was renamed early enough
> while we still had time to do such rename. Now backward compatibility
> is more important than odd looking names.
