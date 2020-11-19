Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07E2B9ACF
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 19:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgKSSkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 13:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbgKSSkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 13:40:41 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E7C0613CF
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 10:40:41 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so9703507lfj.6
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au469p9zNDfgQl3YuPnVjJXrVJoWnWoruzOG8UjNgGY=;
        b=JZSAlZlPuBlxQ0nuN/uoo+TEedexwo/b6B3fshF+TpuFw8crNJAfWtrQ3Qg04u+Q/h
         mciY8jrsrbVTF0gl99ATsUZ17TzH9bpiyZdXaZsZqi4iuJAlDRGjqadzl/XcrIH5ev3Y
         9z+kb1x6C/lH/74ARZBFlQL+vvyu7NnZ/Knq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au469p9zNDfgQl3YuPnVjJXrVJoWnWoruzOG8UjNgGY=;
        b=QI3Vsdai+8fNmxXRfT5dLnfd0rV0HBS3j/hD+G8AHII3yJfxbQ+VwPViZaKazwHP89
         uhRpsgybhcLBPCrtuX8eXz2mytz4WMOpRkJ4D4SQk1gSSj+5KifzEp2e5c5Hh5uPqKO7
         wZsnveCJKQ7RYpIZEaBkrMZVqccfeWoL6jXzPvBC4uOxM5lVFNXvD1JRg2ChoMP+xSOm
         CT/o54pVS0lLxZ+fI22OarfCEniUofQzqPMWomrnuT6kkmv9s4hvTd28p6ONwGZwJ1+Z
         mFqeAT3TV31qUShrClFFftjyeo2ufXrco8ko3ARJm484m92RKAKLixk0W72WslP6Q3v9
         YKfw==
X-Gm-Message-State: AOAM530vyxz6Ois2d7bhotSydnd8uFWGB5MzcTy00hEmOtTGl42FNCNs
        1tC27VR2ejyMRIG0bZpb/eYZsb1k1efKtw==
X-Google-Smtp-Source: ABdhPJw93c7KN/k0wLbV0FGCJw4TvjVtfHAMX63mGAN6ZcAovCIWqutPcigcT1zKSlf1C2X95s26Sg==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr6470926lfg.167.1605811239638;
        Thu, 19 Nov 2020 10:40:39 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r12sm51430lfc.80.2020.11.19.10.40.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:40:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 74so9728649lfo.5
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 10:40:38 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr5994156lff.105.1605811237959;
 Thu, 19 Nov 2020 10:40:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605642949.git.dxu@dxuuu.xyz> <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
 <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com> <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
In-Reply-To: <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Nov 2020 10:40:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
Message-ID: <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 19, 2020 at 10:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> ping.

I'm ok with this series that adds explanations for why you care and
what bpf does that makes it valid.

So this one you can put in the bpf tree.

Or, if you want me to just apply it as a series, I can do that too, I
just generally assume that when there's a git tree I usually get
things from, that's the default, so then it needs ot be a very loud
and explicit "Linus, can you apply this directly".

              Linus
