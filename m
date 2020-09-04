Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1025D2A3
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIDHrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDHrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 03:47:11 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B873C061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 00:47:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u25so5107082otq.6
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zpfaJWG5oeZQZBCxHY1rq0z3vspDy/xX0EDumGZq3E=;
        b=PnXY0UEnTXs32JDyqeBntouti0hnAv5xdUHVM3H1czXmF6cfit4L/L8syLoL6jx78Y
         hHyzPLGoKtgX2f2D5emv5x2EGRibYs270l38g+FmgCu/OJf5IK+cMl7q5F+uE15gwg7W
         /19Da0J3GqYBq2pw7fCnmcMpOnusYyj2S9nbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zpfaJWG5oeZQZBCxHY1rq0z3vspDy/xX0EDumGZq3E=;
        b=VB+fwpenvL6gfoF34ghC/sLqWz71k7GfMUaFGTpaO6okDIZwpMsPYQGpdzNqX7JJjJ
         zvbDIqh4eKuHE0Jf8dWiRg/4tWwuyvLYUhlSdCJK5uv+gMtLC1mN+QSm7Hc05PeIsnNy
         e0f8tSSMrIfwlFnqdnAUYjKOZi33I2RYUCji1LO5f+0hFY+fylbP7liN1TREWbYrxSkM
         hV0NXYIk1SUg/nNZvRJsQ1YDbwUFSeyP21FvDNMPoq3Qu1D+GLmmMbIxmbATM+H6zJBY
         mgyZA3Mmd/i9rJxvKBCOBgd9UIbOhOrxOgCqNk1bpqdKv/KNavmceFRAJJyz1p0jdDB2
         FdWA==
X-Gm-Message-State: AOAM531a8YHVRFj1TtuI3g0nugjl/KrWP5+KTAy5Co4FqGxNW/i3NGvp
        nzFGIZ2jFJaqkOyX3dFqx65sEuOAX051B4+kA2j57A==
X-Google-Smtp-Source: ABdhPJwY4ju0ap4JF1L76VlKVRIwupIyvGIQR29l3jAhT5DfC23KgDOVWFFEkdSlDpWruaQaUvJYVrkRrrv+W2EJUn0=
X-Received: by 2002:a9d:2f23:: with SMTP id h32mr4722178otb.334.1599205630815;
 Fri, 04 Sep 2020 00:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200901103210.54607-1-lmb@cloudflare.com> <20200903200810.lyxorvv2ocg2ibr2@kafai-mbp>
In-Reply-To: <20200903200810.lyxorvv2ocg2ibr2@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 4 Sep 2020 08:46:59 +0100
Message-ID: <CACAyw99qSjiqfpydAB2neBUwWRN_NzRniqxdKF6PHjenm_8Rag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Sockmap iterator
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 3 Sep 2020 at 21:08, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Sep 01, 2020 at 11:32:06AM +0100, Lorenz Bauer wrote:
> > * Can we teach the verifier that PTR_TO_BTF_ID can be the same as PTR_TO_SOCKET?
> I am working on a patch to teach the verifier to allow PTR_TO_SOCK* being used
> in the bpf_skc_to_*_sock() helper.
>
> The use case is, for example, use bpf_skc_to_tcp_sock() to cast the
> tc's __sk_buff->sk to a kernel "struct tcp_sock" (PTR_TO_BTF_ID) such
> that the bpf prog won't be limited by the fields in "struct bpf_tcp_sock"
> if the user has perfmon cap.   Thus, in general, should be doable.
> Hopefully I have something sharable next week.

That's great! I got carried away with refactoring check_func_arg with
the same goal, it'll be interesting to see what you've come up with.
I've decided to make a smaller change for the sake of landing this
series, and then I'll follow up with my refactoring. Hopefully we
won't be stepping on each others toes too much.

>
> For the sockmap iter  (which is tracing), I think it is better
> to begin with PTR_TO_BTF_ID_OR_NULL such that the bpf iter prog
> can access the tcp_sock (or udp_sock) without another casting or
> bpf_probe_read_kernel().

Yes, that's what I'm going with as well.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
