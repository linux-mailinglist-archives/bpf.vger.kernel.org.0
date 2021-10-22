Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47E8437FC4
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhJVVJM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhJVVJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 17:09:10 -0400
Received: from mail-ua1-x963.google.com (mail-ua1-x963.google.com [IPv6:2607:f8b0:4864:20::963])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059ACC061766
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 14:06:52 -0700 (PDT)
Received: by mail-ua1-x963.google.com with SMTP id h4so10223386uaw.1
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 14:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=ImoABBg6541EdX3zFl8zDtW+p0YhC+RBw8rNkgwHIS4=;
        b=NoS2EzomGV/JuMSSHfzTq6L0PtY3MhEKeg9btooldhSWAGfJCgk4kCMQc2wBU68ipR
         Hjbl1Y7ZFJDS4YlhZGBKqIEqaFKj9oz/RcI3kpKbOrH7AWrCyhV9XkYSy48KWuuEt29R
         N+Lf2Gh/vQLkmbGqyUgEMZyStsn3qM6WGotxhDi6+3Rfk52tYFW/AtL+7dka76t/LZEh
         yl8b/yr0eHmdZDfh9UaJ3oN/OymwLhlAf94dc257GQm+6vUnDIjaMdeoRH6CZB3vZZjh
         RZqIqbRO5FFxyaOEQxrVNl82eYOx/OcGt4tPuchfy0SURF1J7pO/90eeb5sgtHFrVA/f
         0Dlw==
X-Gm-Message-State: AOAM532isUoTpSJjiNKpoDn5L+UBpGc5J6qtlP/PLGLXJlGRaIxLo9AA
        7GMNmq05VNENMmvpGqM6bXJ4IHV0lHDWKA7hHCOd3NGVbSWgog==
X-Google-Smtp-Source: ABdhPJzpO8xIOr7JntExVCHHboXlXTOFO60rMpnOVT9raU6BeZ0sxdQyWcKwaiIq2/MVE/AXXN9gbzC/gks6
X-Received: by 2002:a67:7282:: with SMTP id n124mr3112381vsc.15.1634936811224;
        Fri, 22 Oct 2021 14:06:51 -0700 (PDT)
Received: from netskope.com ([8.36.116.139])
        by smtp-relay.gmail.com with ESMTPS id a6sm2667684vsh.2.2021.10.22.14.06.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:06:51 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-ed1-f70.google.com with SMTP id l10-20020a056402230a00b003db6977b694so4844777eda.23
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImoABBg6541EdX3zFl8zDtW+p0YhC+RBw8rNkgwHIS4=;
        b=VFmwou63xGBQ7r34dSPf7G5KlE1DUc2W+kayLyAE2/eZMKcB5WubGiZmilCp2KmwZp
         Pk3ga81w4nej3U06VYYL1eYiL4YlaaMIpDXbzav9hcRx2VXw15SOXSHRW3j/5si9dPMA
         4y9wDck3ehrGR1l+e/xf7oBw51iZ8CXpl4HV0=
X-Received: by 2002:a50:e145:: with SMTP id i5mr3152590edl.16.1634936808196;
        Fri, 22 Oct 2021 14:06:48 -0700 (PDT)
X-Received: by 2002:a50:e145:: with SMTP id i5mr3152548edl.16.1634936807940;
 Fri, 22 Oct 2021 14:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net> <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
 <YXJ3WPu1AxHd1cLq@hirez.programming.kicks-ass.net>
In-Reply-To: <YXJ3WPu1AxHd1cLq@hirez.programming.kicks-ass.net>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 22 Oct 2021 14:06:36 -0700
Message-ID: <CAC1LvL1YCkX=0XwM4WHgSVejcs4RywMsXs--OTaJfsyWELHv+Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 1:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 21, 2021 at 04:51:08PM -0700, Zvi Effron wrote:
>
> > > What's a patchwork and where do I find it?
> > >
> >
> > Patchwork[0] tracks the status of patches from submission through to merge (and
> > beyond?).
>
> Yeah, I sorta know that :-) Even though I loathe the things because
> web-browser, but the second part of the question was genuine, there's a
> *lot* of patchwork instances around, not everyone uses the new k.org
> based one.
>

BPF and NetDev share one: https://patchwork.kernel.org/project/netdevbpf/list/

--Zvi
