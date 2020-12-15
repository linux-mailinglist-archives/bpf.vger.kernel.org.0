Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0842DAE86
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLOOGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 09:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgLOOGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 09:06:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECBC06179C;
        Tue, 15 Dec 2020 06:05:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c5so16323486wrp.6;
        Tue, 15 Dec 2020 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gK+9YqVJCbtE3lQ5Don8jQgcKt63bQ7YNsENkuEVRUE=;
        b=qPV3HGsEfqw5c3jtXuS+vSjHNl8VETOoc3VbCRnTuxTLnre2GeankDt5kkgTHBlOJJ
         zniL7Vhb0Z53drb6aw0O8UcvwXDy1N43yBXb0FZ4MtEaVzo8XCedNKEi0BadQubgcFWs
         6bKMbvnDHi3/PeCKtvOYIrjE5kdFbchptbAyMPdhzAYpiGEb6uwJxSjZ3+93ipxfLoqc
         JiQqsDmsEkkdfLfsNDvjYdXiDj1X0mg/dn3sPMNtOQxy/BxRikgrr3iFc5po2UP+DFtj
         z/hvy+14U11M8J0D03oFSDyI09TWP5d2Aw5A69gmWPDmAcRgTqcaMtlisi9857V5NCns
         S0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gK+9YqVJCbtE3lQ5Don8jQgcKt63bQ7YNsENkuEVRUE=;
        b=aaMyhKsv+ij2r/QxXyoR2shQ+o7hhs2zqcn0EnJ8cXPV524km2CYfkNh0GJX27ppaW
         GmNLqh2jGD9uUQi18WKNSsWcsZpyctOW5NJMFAHzzquSJv3kNYT2yyM3uU5RcZvXuef3
         eZ6vfmnEYrWU8K5sf4kyL2/MCL6/jh5BPZY8HDTP3cD2+R94L/lTdSmPsO7uymXw2z+3
         VOZB0TR4JwRgRfFwj5/PcWxSdPhoys+wsuWGOG5A3QG13Kejfohd49Qqprkp/vUd3kK/
         i2PUhluH4EaHwq4N5eOMZLntgLGqZ3rQQ0dEfS+zr/3v96kD21E33uRBwnZ3d/xAUrfW
         Sn0w==
X-Gm-Message-State: AOAM531Ak9Ga877IuJ1qq4QJUy0sOKSGevC9A6GUsMpMjOCwpLg0tsRn
        7hb0948pNpLmrqUbw5I0ODh9OfwsPy3mGRd6NKk=
X-Google-Smtp-Source: ABdhPJw0TvI/84WJdHKHkNLWAhh5uOLOg15l6fjsw9HoAXZZUKlCeo2D9tqXJksK271XP8S7Hvm3c1VEcbd1aeQtdyM=
X-Received: by 2002:adf:e512:: with SMTP id j18mr2954037wrm.52.1608041148627;
 Tue, 15 Dec 2020 06:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com> <20201215121816.1048557-6-jackmanb@google.com>
In-Reply-To: <20201215121816.1048557-6-jackmanb@google.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 15 Dec 2020 15:05:36 +0100
Message-ID: <CAJ+HfNieDqvamAzZfp36_yZHzsnwkeaARwedQaiFjaEu5Cn1tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Dec 2020 at 13:25, Brendan Jackman <jackmanb@google.com> wrote:
>
> A subsequent patch will add additional atomic operations. These new
> operations will use the same opcode field as the existing XADD, with
> the immediate discriminating different operations.
>
> In preparation, rename the instruction mode BPF_ATOMIC and start
> calling the zero immediate BPF_ADD.
>
> This is possible (doesn't break existing valid BPF progs) because the
> immediate field is currently reserved MBZ and BPF_ADD is zero.
>
> All uses are removed from the tree but the BPF_XADD definition is
> kept around to avoid breaking builds for people including kernel
> headers.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/networking/filter.rst           | 30 +++++++-----
>  arch/arm/net/bpf_jit_32.c                     |  7 ++-
>  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++--
>  arch/mips/net/ebpf_jit.c                      | 11 +++--
>  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++--
>  arch/riscv/net/bpf_jit_comp32.c               | 20 ++++++--
>  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++--

For RISC-V:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
