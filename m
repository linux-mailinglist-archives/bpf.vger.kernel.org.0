Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0D3D8D8F
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhG1MPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhG1MPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 08:15:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF1C061764
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 05:15:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x192so3634349ybe.0
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkDxrgrEVg6tw+Td7iNYrIfj80xo4Flt2pA0V0PfbyE=;
        b=XKmmcNW+KMe99DyKo7MPqtLY3kmkpOZuDtBuENQ3CQxYeJU9C+eM3vWJp6/P5CXU6n
         RRYWmF5Sk4ffJtiYRZ2Z7eAqrHd7C4Z8kOxgBVRD3ifAYcG1ojTvsWPaM6aVk6gpMqp5
         Fagk6ift32oS3zPGJlpfce7bhk9cOv7XOfPcp6EiPhdG/a4UptP2KYLGgmGVh28ONQ5Y
         wKuy1SxEhdHMpzcVn6OMuazbUufV24wGr7CcxGq4YSxJO9sJqthJ/5fnw6CLiOGVmxHG
         DorzbQ1TRHGviwHS2R2g582ItgCtek5HD9j0yTasHmb+9ki8ilVV0g+7bbgkIecvUoTt
         Ts3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkDxrgrEVg6tw+Td7iNYrIfj80xo4Flt2pA0V0PfbyE=;
        b=noXoHFTrmTPxuHD7bnPk4b9Z7NV9Jbn3ZfT9oWF3tkUFPEb94j6vQkri5Y4MuloRQP
         Ww0xmnlV/efz09PKMOFxSTCCja3sp73aNZlKbMEIVQSPUr4jkCmVp+MekySIOjj3Rbyr
         VfGH9J7ViVDigj5w8uCsUIoc15NBnfy/X2LKOgElgOC/+ZjA4IYKORj5ICSavkb4+5Mb
         mIOfR2JfZ6DEkHKbExMgEI6WkampYiXAQETnp1OMw29yRXJEBHtSTw99R565Pi3nHqX2
         e5Ud16dzQhsT2H9RumhfR+XPzCPKVVXiImqWcC8IhtJQOgyEJQOtoc2TJfywWu8MQCgS
         6ajA==
X-Gm-Message-State: AOAM531uyySD0kn1sIabl2iWfwjezth7GSBSduiLtyO2/xHiYpIoTZL5
        vjWNFy7K7Mx4xGaRITZjyfKk6h8J8nHfH8LOmCAF3A==
X-Google-Smtp-Source: ABdhPJzIXMVkoZ9OK3XH6VeVrJjbY9D6/ev3O5D5BPxxLC9ShFop+gESwxnfrnwIaJV1ratBfodrpqmbpu3wLliBL2w=
X-Received: by 2002:a25:e910:: with SMTP id n16mr20613870ybd.226.1627474518602;
 Wed, 28 Jul 2021 05:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
 <CAEf4BzYdvjz36K7=qYnfL6q=cX=ha27Ro2x6cV1X4hp22VEO=g@mail.gmail.com> <5afe26c6-7ab1-88ab-a3e0-eb007256a856@iogearbox.net>
In-Reply-To: <5afe26c6-7ab1-88ab-a3e0-eb007256a856@iogearbox.net>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Wed, 28 Jul 2021 14:15:36 +0200
Message-ID: <CAM1=_QQWPX4FumpfPXqRd1UnsLyTZhy7f6bcUsW5C1uBuEV0OQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] bpf/tests: Extend the eBPF test suite
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 28, 2021 at 10:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Yes, lets fix up the interpreter.
>
> Could you send a fix for the latter, Johan, along with this series?

Thanks for the comments, Andrii and Daniel. Yes, I agree that fixing
up the interpreter makes most sense. I'll submit the patches shortly.

Johan
