Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13017463C51
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhK3Q5a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 11:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238952AbhK3Q52 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Nov 2021 11:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638291249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5vPtGusYWFIblm5VKQ4I+RoQ7n2VZ5875ryMIyzOig=;
        b=bAM19MWSpBgA5UPGfVGL0Tw20WGcEnV5RIK84iZHmRMIX1zgDsbK63DY3BUoHcCvAMaYzv
        LVksdXmpXWTCUuNM4duado0rfXpqQ+cCrie20jx2/jwkuv6LSbEEmXW/HejeALUK5ifMsJ
        HCOO2FJCZtL9fzx0a329mWH1bOZJio4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-qoJc2kVrPMaL4UnGBfuNXw-1; Tue, 30 Nov 2021 11:54:07 -0500
X-MC-Unique: qoJc2kVrPMaL4UnGBfuNXw-1
Received: by mail-ed1-f70.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso17473937edc.18
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 08:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A5vPtGusYWFIblm5VKQ4I+RoQ7n2VZ5875ryMIyzOig=;
        b=u56WTtc41PNWeOk0tptC1v8PkN4yQr7PZyrIPwnW0/wmcyCiR0uwye1/Fmk0UAIEUu
         CREP6ak43F+3YtjvQ7x2G6SyEs39whF1FRKE9o64Ye8O3T6zqwwjgoKImlQs5MnkHiGh
         LayflyuuTCJFcoHhwwo+OsiZ36+xygh7/T9nSWPszdIK8j/QusCGlxZPuQoq7MZoQ+s+
         5GPuvIUusmwQf7V7oTm6PIYkDJ9VURxHVikv/0bYB1gpPFrKBQhntR3YcnypJj3ECcJF
         KHxCE0bMItBqh+1wB2rUXYdE31aViBnbh51fSH2MS18Yo7n5kGuR/qioChrlIBG1nUN1
         p1Nw==
X-Gm-Message-State: AOAM532nhi86PrrgaUroL+WuxYhILcoPtypkSd7mlgL2UFP+aV/2A1h/
        uZwPEWZm4MP2E6oi4RksHW0CeU4d9Gz+xQ2v4TLxHAnQ+iOCrMmilQoFdHcWrbNNnnYF+QhDmQF
        rFZNHIdHvad+x
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr141757edw.241.1638291246411;
        Tue, 30 Nov 2021 08:54:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9EQvdlaeok/ltUIxL7D6EolrwSSTAb72+iIudgBaKocvZ7z/BHxr79pztyFHLg2n5+l/E3Q==
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr141723edw.241.1638291246195;
        Tue, 30 Nov 2021 08:54:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id nb17sm9844424ejc.7.2021.11.30.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:54:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD7011802A0; Tue, 30 Nov 2021 17:54:04 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: Add bpf_loop helper
In-Reply-To: <20211129223725.2770730-2-joannekoong@fb.com>
References: <20211129223725.2770730-1-joannekoong@fb.com>
 <20211129223725.2770730-2-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 17:54:04 +0100
Message-ID: <87tuft7ff7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> This patch adds the kernel-side and API changes for a new helper
> function, bpf_loop:
>
> long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
> u64 flags);
>
> where long (*callback_fn)(u32 index, void *ctx);
>
> bpf_loop invokes the "callback_fn" **nr_loops** times or until the
> callback_fn returns 1. The callback_fn can only return 0 or 1, and
> this is enforced by the verifier. The callback_fn index is zero-indexed.
>
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_loop (kernel/bpf/bpf_iter.c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_loop calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack dep=
th
> cannot exceed MAX_BPF_STACK))
> ~ Recursive callback_fns do not pass the verifier, due to the call stack
> for these being too deep.
> ~ The next patch will include the tests and benchmark
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

