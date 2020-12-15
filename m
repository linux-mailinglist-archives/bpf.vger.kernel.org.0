Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009D62DAD81
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLOMvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 07:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgLOMve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 07:51:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280DC06179C
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 04:50:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b2so20901313edm.3
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKWH6NWmh0vdp1iUENuVwCMnMWAn+f9ot8xN6B8+FVA=;
        b=mSd9hOS9TJdRv7SYETAPbvBY9i+AXcpYR2QLwRQN46QvBwYfuxvOCoGxMpuCx5qUSI
         r2bqN+OV1fSePwS6izLR0kgPKgv/bzpmHqu4fNfpar3/l6gKtKQNIz0a6+Kh/0FV6QCE
         ceIBpj+7AWVlyDEPy2TB/LHvY8fRl56RKrOGIaBZLaOIMydtYsWOIDlcpXBwqAG4QT0D
         i/jn6b0mci2hu5fnTMPoORnJKoAmQvAaBnMOnd+foTzyclmovtXGt/agLBGoH2hwNzNh
         WkldJCEJksb/TWsL4yd4eSVZtZJ7SI8KDc1EfFpLjAstm/Ie0Uwc5xLdHVBtvzUJWFT6
         qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKWH6NWmh0vdp1iUENuVwCMnMWAn+f9ot8xN6B8+FVA=;
        b=jDFoNN1pmo72RtcNypyYyv2O4/hmpKBqT9E8C6EtLIwWUGdpPUFUnQ7x4jUmRg62t/
         gboVmL37l96wfHUbTQIXVNGlF4bvg8ndAVcr56E3lENA5STEudKirs/wMNweWhyQAJRE
         gli37RAmEbh7GL/k6qDrr3eycpYg9+ay86dhwGJd+gGwLfC34SyWRbFHhJ0U9cQ5i2Pj
         qFCg7sQdBGfQKQ8dnkLuaNuW8PpClhMP0KDlBC2DMbo8JeNbUPvrUzr7rImFrkOSAsT1
         VAShyj0sfxuChPy7ko9j/JultIdHus4N9OQYqhAZCxN7n2eNQqSdWB//t4sPlNaLcGG4
         zPVg==
X-Gm-Message-State: AOAM531l5CcvTIkD3at/YfEKt+M5OpPbhhIZ2/S7Tzb55hu82JcbwsV+
        9MKtWCWf3vl2alKS0Lr9JhhxPuufD6yZk3eyAhk=
X-Google-Smtp-Source: ABdhPJzwKSKZSPm1kRjc60YjSTZHH2egRUK0fRVhP4Mg0iHAlJmPTuXZOhXJBK/2NY7wLUVaXqhJGqyqpmYqtPTT3qg=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2243564edm.28.1608036651978;
 Tue, 15 Dec 2020 04:50:51 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
 <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
In-Reply-To: <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 15 Dec 2020 14:50:15 +0200
Message-ID: <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 3:26 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > Hello there,
> > libbpf provides BPF_CORE_READ macros for reading struct members in a
> > CO-RE compatible way. By default those macros reduct to the relevant
> > bpf_probe_read_kernel functions. As far as I could tell, there are no
> > variants of this macros that wrap the _user variants of the read
> > functions. Are there any plans to support ones?
>
> BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
> will be adjusted by libbpf to match kernel struct layouts by using
> kernel's BTF(s). Because of this, having xxx_user() variants doesn't
> make much sense, because libbpf can't relocate field offsets against
> user-space types (as there is no BTF for user-space applications,
> typically). Which is why there are no BPF_CORE_READ_USER()-like
> macros.
>
> What's your use case, though? There might be a valid one that we are
> not aware of, so please provide more details. Thanks.
Currently my use case is tracing syscall pointer arguments (For
example, "connect" has a "struct sockaddr *" argument).
>
> > Thanks,
> > Gilad Reti.
