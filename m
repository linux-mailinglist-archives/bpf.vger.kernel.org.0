Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6832D3DAE5B
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhG2Va6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhG2Va5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:30:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D061C0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:30:54 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g76so12519687ybf.4
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7A9NX6+R1ItDbdDIykYJjZM1Xg5IpEpNDoq6IEGQ8o=;
        b=JTVj1vaunTbw9kjl1pX0C+tDUCSH3ibGRU4k4l2Hxh7n9Sdl40XCw2otPlx68jrCcM
         cc7Qlx0M1K7JKWWG6ceg5i4rxVa80c+RkHxopfGq59XpvV454renSO/OpK0/sYs7k/Dw
         k9ywW5HKeQGBD6sHVpQiXwjxFk5y6AdUG1rHTuMpqPgtldoU2Aj75lZ0suFTaoZJXVdt
         Ox6r0DMvIBiBTmgsU5j6t8yHwCtfw9H302+gY5pQJshKZvBDyeDnDLTBdxdpaA0VJ+61
         t1qCxCuyaCm0LqvLn9L3jYzGA3BxNSyEhkr71nzirtzWqDL1h0z/m1WIl1ntdB1D7rDN
         Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7A9NX6+R1ItDbdDIykYJjZM1Xg5IpEpNDoq6IEGQ8o=;
        b=MukqXlpY0a1xtEa5alsKh2Lg86BC263y4VmPS205EuufnHwb7OFaePNqtPJDzljNcV
         HSEfINda0I7ANnFaZ08Tp4OR3mKmTTX5Ae1S+izA8tTMbYjurZX9GiITQGwY05HoWGDT
         apy0xb9oXHC8NT+CuO/B8b5/ZL8LM2KpHjPCfd9f1We12F+jpeJycbuDPM+1F0a7EKYh
         unqtVSRGeyWlhKEBtibg2dzqsK98ePSe3L6pkFTzfXHB3aNeEPQVx/0qpZ6w9EGNtgSf
         XfvmrO2awJngI5in0ktGtphKCqgGWhxWGxUbWeLuMxPx6mDaDC0nhsourspinMmJBcUd
         fsbw==
X-Gm-Message-State: AOAM531xWWcQtrgEM1Sls5FgTmjpPs5tiQnNO4LCXnJvMAIxAK6NRyjc
        oAt0G1DfUGHM4zYNUxrmnuheScjMoB/0NszD/gaOeA==
X-Google-Smtp-Source: ABdhPJzuhcxaS2sQ+qP2XuyzDDaW9wET+IM6k8IAttgmQzrnqgR5umhTtP9xE3TkKRLiUwaLFRcOhflSQlq/XZT5vwM=
X-Received: by 2002:a25:6b51:: with SMTP id o17mr9577028ybm.149.1627594253432;
 Thu, 29 Jul 2021 14:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
 <20210728170502.351010-2-johan.almbladh@anyfinetworks.com> <ede57ee2-a975-b98c-5978-102280a77d8c@fb.com>
In-Reply-To: <ede57ee2-a975-b98c-5978-102280a77d8c@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 23:30:42 +0200
Message-ID: <CAM1=_QSnRvN=rW3W79TCoNe38pgQ4-5Dmu4uRWCV5hqX4nwE_Q@mail.gmail.com>
Subject: Re: [PATCH 01/14] bpf/tests: Add BPF_JMP32 test cases
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 12:31 AM Yonghong Song <yhs@fb.com> wrote:
> > +     /* BPF_JMP32 | BPF_JGT | BPF_X */
> > +     {
> > +             "JMP32_JGT_X",
> > +             .u.insns_int = {
> > +                     BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
> > +                     BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
> > +                     BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
>
> Maybe change the offset from 1 to 2? Otherwise, this may jump to
>    BPF_JMP32_REG(BPF_JGT, R0, R1, 1)
> which will just do the same comparison and jump to BTT_EXIT_INSN()
> which will also have R0 = 0xfffffffe at the end.

You are right. All BPF_X versions should have the first jump offset
incremented by one to account for the extra MOV that is not present in
the BPF_K version of the test. I'll correct it.
