Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25003040EF
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbhAZOwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391246AbhAZJiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09068C061756
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 01:37:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id q12so21843150lfo.12
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 01:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc97bl9y/fOUWfcqC9Hh9udHha7efiEnc5d5nu4VkAU=;
        b=vd1XuR3gcGy119h75Y1qjivJKBqfMQoxlVfdaFE8OOJ2A7JYfLrSDiKeDDulAHSNrA
         MclXbRVXfHjAiw06826JQERooCqRYe5tGUyUBFnRcU+r4Fnp+nw+ZgwBLpDl9dzSETIN
         bHIKEFQ9jPwYKMb17EdGRflrasDgMbTkVP248=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc97bl9y/fOUWfcqC9Hh9udHha7efiEnc5d5nu4VkAU=;
        b=CF/crsagXtztoMblXrXQpooD8IDo0IgY7LVY5itn55ewCMKMOpy97G7895WGMlscSi
         kIZCGzgbhU1/Z/X2Y222m5mST9na3BL1qvV3Z8rmMNFo1xj6bgedC191jzm09RQKtZHG
         T1WhJYuDryrCDBVvrGNKerfJaaDh56gpN5S4K4SKQyQCd5ZMqcGmCEyz/x/8zko18nz6
         /8J8G4ECG49N86k8Aua/+SpB+kANfiYD15P55ytorhsI1gJmjhqxx6kRKY6Qr4lHCPce
         Zi8zlSA1CtgtP7b7w1VYnFAA9XKLDKK/Tohc3RdhiLwsigRunhr49WJvVGNGO7BbXKs5
         nFAA==
X-Gm-Message-State: AOAM530NUQjjqPQu6jPIPf9kSHZfION4qBUDh5A1v/AQ68RIsESEr5b4
        32+OG3V+8XRBj8ulI2Y1c0E91BDR141SzGej3NZ5ig==
X-Google-Smtp-Source: ABdhPJyCGPCvmzSWUJppoFAjsEUtCf8KWSJC0FJrI/QII7dvxqZrr5XBPR4F3kafupLvwui/f8oqxjIf8OmPtbBhies=
X-Received: by 2002:a19:c56:: with SMTP id 83mr2467065lfm.325.1611653828443;
 Tue, 26 Jan 2021 01:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20210126082606.3183-1-minhquangbui99@gmail.com>
In-Reply-To: <20210126082606.3183-1-minhquangbui99@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 26 Jan 2021 09:36:57 +0000
Message-ID: <CACAyw99bEYWJCSGqfLiJ9Jp5YE1ZsZSiJxb4RFUTwbofipf0dA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix integer overflow in argument calculation for bpf_map_area_alloc
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        kpsingh@kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Jan 2021 at 08:26, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>
> In 32-bit architecture, the result of sizeof() is a 32-bit integer so
> the expression becomes the multiplication between 2 32-bit integer which
> can potentially leads to integer overflow. As a result,
> bpf_map_area_alloc() allocates less memory than needed.
>
> Fix this by casting 1 operand to u64.

Some quick thoughts:
* Should this have a Fixes tag?
* Seems like there are quite a few similar calls scattered around
(cpumap, etc.). Did you audit these as well?
* I'd prefer a calloc style version of bpf_map_area_alloc although
that might conflict with Fixes tag.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
