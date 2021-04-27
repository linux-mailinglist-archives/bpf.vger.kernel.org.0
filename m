Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3036C88E
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhD0PVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhD0PVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 11:21:10 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81671C061756
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 08:20:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y10so9087850ilv.0
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+3S/Ke4S6+BJfOGg0qG6LOy1Ai6SNSUzROT5871JP4=;
        b=XhtEu50m4SNDxMMlj2Qgjkyisnk+vyOC+Kykp75IsezRlaqS9NzgLY00neE39leHwe
         tXCh9VD2qY5Pz0jC2rbqhfrCfRECn1EYBv6EbeE1GtICTGqWqKZF/W5Z9XovgmfVgcIl
         agq+QYupvX7mKWHTQhRddAP9Gq2R4mJiTIW6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+3S/Ke4S6+BJfOGg0qG6LOy1Ai6SNSUzROT5871JP4=;
        b=LwUHIjbbzHrakF4aUuJV3mPKjKqhNloPpOtwiUk2y5QCqc/nzLEpLuaIJ+nm9NwzmE
         K2jLU5BzlKnvTuiJgO9KlK8mCm4YLAP9zPDwcxbJKouKPiVSp8wPmpPUDK8WXYlTmNzZ
         N3/ybd+qVOZhuOeVrYHCq8SBJDuF6yv9KL3axtXKKllNeE5NYFxn2dZ7l+sYYpij/8CC
         QrhU2UExQhRvSUBs+nmwGYsfWAZjGp8Mwmen+xCucZr9tVOaWAtYNi3fDzL0pSHu8xUL
         G7JWwMWTDGxIqNkXRCTiiAl/50CKgRW+TwauGLY7UPGk19WbG79lEHWkDuOCjBcHEbky
         IPDA==
X-Gm-Message-State: AOAM530mI8/SbA3edDP8idQnXolEgovKxL7uKNwvZsU+z68cBWIg3Du/
        TIILN2d76eZ9I2x+P+homAjvSW3LPp8ureVWJsOLb4NqMzw=
X-Google-Smtp-Source: ABdhPJzUVzNRTwQW7ow2d0IynxZz565aonzrsvvp2GTwJLJ3xr0Dqt4cepa6//a3ihU0mG2057i+m6LHDOrTKb3giYw=
X-Received: by 2002:a92:ce90:: with SMTP id r16mr19368951ilo.220.1619536826986;
 Tue, 27 Apr 2021 08:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210427112958.773132-1-revest@chromium.org> <CAADnVQJGMU2OAA4cRuD=LmfF3Wn5z0hqo1Uz9nx-K_KWuCA70A@mail.gmail.com>
In-Reply-To: <CAADnVQJGMU2OAA4cRuD=LmfF3Wn5z0hqo1Uz9nx-K_KWuCA70A@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 27 Apr 2021 17:20:16 +0200
Message-ID: <CABRcYmLphttpFGdwq6YCboc_=dwkgpVAOf+Ni9NRiPioqRCokw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Lock bpf_trace_printk's tmp buf before it
 is written to
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 5:08 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 4:30 AM Florent Revest <revest@chromium.org> wrote:
> >
> > bpf_trace_printk uses a shared static buffer to hold strings before they
> > are printed. A recent refactoring moved the locking of that buffer after
> > it gets filled by mistake.
> >
> > Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> > Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Applied.

Thanks!

> Pls send v2 of bstr_printf series as soon as possible. Thanks!

Sure, I just assumed there would be more reviews on v1. The feedback
I'll address is only about the commit description wording but I can
send a v2 today.
