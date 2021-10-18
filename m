Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFDA4318CD
	for <lists+bpf@lfdr.de>; Mon, 18 Oct 2021 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJRMUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhJRMUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 08:20:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD5C061768
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 05:18:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r184so659357ybc.10
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzDyEdfFWyqtSOdiO6QK4xGkQUsG3IOdxwmFPTyDrKM=;
        b=53oTNf/YP2P2eto+z7EVCOtA+Vn7m80OFkKjWx5Zgo+FwwvaUT7NNxt2WRCDAqROc9
         NxzIHJBCQe58CjOjP70NdGcypknTCFeBvvk9FIkNDiSETTrLjuh7/Vz2YvMGSfCA/Bzw
         BvDQHMRNAuabxVKqWaw7O7lNgPzz7K1fb9F3xNQIol2t9FqwZgISe3xzkSOBWC1pNScE
         wx5llK7F1PD8rS8KxfEo15gq94V5jLjmmcWdzqS82AxNz/2jEE/Onb6WyqsKWp0UkWec
         2zUi96NaRnasJ7a0d69+ws0fyPiRo1tDTmVi9aGuRtgN+gql7i6ckyWO5hofBF0wqxaY
         DlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzDyEdfFWyqtSOdiO6QK4xGkQUsG3IOdxwmFPTyDrKM=;
        b=finIaWjPAZ+l4GNLrKaDQq1rdAKoljQa9y5SBLleqTco4GRBAHhh9RVxeS8wlyJTG7
         kTHsPsdyqr+pOGlj8Dvb5VQkFO5UVc0+pUhdZI/zoLs3n1FglmG06vwYhlBPoYRkO9Ld
         dUozDxWWcqw7lfSgrI58XpFh15fJk8bvC8+LcEyjn0I15+xDu5SY7qdY+N3fYfVn1HfI
         ULUa0sO/YlJywsXNn4NCm+BYyv1mDaXqVzZcM5gSPYDhyBhzffH74zAl/2/PAzSmOW4i
         9AEPDLHvq+mfh7QhMeGg0FZsw+MPAx3L+/haVRrCqXocBkLf4OfuYG8YwoNlc2V9x10g
         r5ZA==
X-Gm-Message-State: AOAM531qMTDKg1OolorY1pS5F9iIAc+xxF44GZ/npH3fWW1K2qhgRK9k
        T0dn9lCsYZbrx93wgze7U+KIlV+PXaPEmO22kYjw1g==
X-Google-Smtp-Source: ABdhPJwNiC8GfLPXo1yH8xcU+Nzj5ADXuvkFvo4kX/imGw4KxpkBqMOjXvN4jINqJ0fElfNAdMkf8tHdziGpVPkBf08=
X-Received: by 2002:a25:b904:: with SMTP id x4mr26912175ybj.48.1634559482132;
 Mon, 18 Oct 2021 05:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com>
 <20211005165408.2305108-3-johan.almbladh@anyfinetworks.com> <alpine.DEB.2.21.2110181359111.31442@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2110181359111.31442@angie.orcam.me.uk>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Mon, 18 Oct 2021 14:17:51 +0200
Message-ID: <CAM1=_QQqTSABUQ1WgmBS2mgRzYKB7UA7CHyDLfwnnFnEDL4QBw@mail.gmail.com>
Subject: Re: [PATCH 2/7] mips: uasm: Add workaround for Loongson-2F nop CPU errata
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        bpf <bpf@vger.kernel.org>, linux-mips@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

You are right, it should say "at" here instead of "ax". The code uses
the MIPS "at" register. AX is a BPF register, so this is a typo in my
commit message.

Thanks,
Johan





On Mon, Oct 18, 2021 at 2:00 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Tue, 5 Oct 2021, Johan Almbladh wrote:
>
> > This patch implements a workaround for the Loongson-2F nop in generated,
> > code, if the existing option CONFIG_CPU_NOP_WORKAROUND is set. Before,
> > the binutils option -mfix-loongson2f-nop was enabled, but no workaround
> > was done when emitting MIPS code. Now, the nop pseudo instruction is
> > emitted as "or ax,ax,zero" instead of the default "sll zero,zero,0". This
>
>  Confusing typo here, s/ax/at/.
>
>   Maciej
