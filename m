Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D38419552
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhI0NsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhI0NsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 09:48:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49125C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 06:46:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 75so1474512pga.3
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CAg97vcMx+GjmZPMk3e2OXfCovKEIWyEqjdBD5L79aY=;
        b=iYSGVWyv92Veyt1ahvS3WYCsSBT0w0flXiOOr0cuVskPHixUdwZNZskFwKAHz59wQT
         4hg9h/yc2M3X78V8EvxntEDlWs8NjCpA07v9ZypETdQOOAsQw48nCBunAppj4rA0aMAU
         B/rKGK/9i8qLvkPdD7WJM0MLfAsi/msyH07nTN/dwCEXIE3c4EZxzxrc78bjGMTLlXaa
         4wW65bCnLFEqMH/atfD4I3+Alq9/8RSaThr5f8qh7E52iA9077gFn325N1rIF5asAgpR
         ZJhU42GKVg1IuSXt0bJ6JALKWspCvlmaULzxZWaRyN7P5lyz1Wx1r2MzHcs68cpLKFcO
         QiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CAg97vcMx+GjmZPMk3e2OXfCovKEIWyEqjdBD5L79aY=;
        b=IxysZvI1+7hhVbRHhlNm3QbCjbKj/l36Yef0IQtUbCAo1pN5AWQV3j7pL+7IgzZyK9
         BokvXxOVP96K9/fFikszmpNZU38nYSuifhCnwcybXQtjGAi5gFGjsyRn+/hJTWSkBPbN
         VddUhjqo3cQZu6d1JnhezQVbS4+zfog8YirjC9OklOEFrJqnWn7xPbhm7gB3P6XKd519
         XVncmssn36zoNP30/HUhQgIWgfjxGWLtyYXK8EDcAOR8Q5/hpdsJ2emKcGmGKXwCH52N
         yEmdrOIe12CXqcUd3AoLhz371t5+KMSGanTZjZ17vx0ewslYTAjkCRFVY4tSeAvgFWMF
         qfWg==
X-Gm-Message-State: AOAM532oX0tc32emizGZWS3KC9zAS7oRpT4TldzagHB63f/nWvcs9VlX
        X6HPL7FL7LVJZ3k98HBHXO2tdnMa+Zg=
X-Google-Smtp-Source: ABdhPJwZSnokvG7AwCVP6m9hS6XOhmwaOawFuZIoay/58RWoAE+UMBN7hVJwqNLVlDXBwgQsKXG5pQ==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr16938177pgk.448.1632750391675;
        Mon, 27 Sep 2021 06:46:31 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id 23sm18879033pgk.89.2021.09.27.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:46:31 -0700 (PDT)
Date:   Mon, 27 Sep 2021 19:16:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] samples: bpf: avoid name collision with kernel
 enum values
Message-ID: <20210927134629.4cnzf25dfbprxwbc@apollo.localdomain>
References: <20210926125605.1101605-1-memxor@gmail.com>
 <87sfxqjit1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfxqjit1.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 06:07:30PM IST, Toke Høiland-Jørgensen wrote:
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > In xdp_redirect_map_multi.bpf.c, on newer kernels samples compilation
> > fails when vmlinux.h is generated from a kernel supporting broadcast for
> > devmap. Hence, avoid naming collisions to prevent build failure.
>
> Hmm, shouldn't the sample just be getting the value from the kernel in
> the first place instead of re-defining it?
>

True, but in general my assumption was that it could be built with a older
kernel's vmlinux.h, but be ran on a newer one. If that's not strictly needed, I
can just drop it.

This can also be the case if you haven't built the kernel in the tree (just did
a make headers_install), it then falls back to generating the vmlinux.h from the
running kernel.

> -Toke
>

--
Kartikeya
