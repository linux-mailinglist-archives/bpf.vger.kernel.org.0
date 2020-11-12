Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAF2B1092
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKLVre (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 16:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKLVra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 16:47:30 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8413C0613D4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:47:29 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so8055952lji.4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCPO2N64UvEcig0H4AyRK325HEhtw6gy9ltijyrrQU4=;
        b=YVSK9i8GsziAJCKzxnKsYEJuAfC46RBIw034h9ZtV/DMKSu3y5Ulu+zUi6SO6opx+o
         5mo1eG5oo8otBUymKM6lWPxgDW0REELKDr6PdgORKp1Grd1yk3LO14/0OwkNtJ44zsUr
         CSXouw/Pop+C2uxHOy2aPuf4MntbHqieNZ9ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCPO2N64UvEcig0H4AyRK325HEhtw6gy9ltijyrrQU4=;
        b=Sff2ycQjxUTAO3J3bXtEAAEy8wENLQsMGU82BbBPuyFrU5uEQmuMrLfJ/eQhzTuGLY
         Sij5nW1eU5n3M8uDwbwtRlTsD+7ERHNfJdnPDR62joVpHXBl6rTvMSw1RAm6oUZbxDZN
         AwPK3A1v1a2vyC44RZN2n3mbwE0kFwmeyJyufCJgU9xzvNC8LNU4/o+x1g3x3ScIEcqv
         NGpmuyKRpA9vN3WpBsLMq0mpU6iv+hkoBYFsZLwqUtvVJ0LYxl1wdA5EpR1HIuCet4p+
         4Ei3Kz+ocTGRrPWwk92x+xaYE1rsvHB1zAEjjWPj9AL4VWvJo5a+EwKpSTNnbcuX1W9/
         hS9g==
X-Gm-Message-State: AOAM533fHI49ttU1N7qEwGAMhipssx/wwmrl2gB3JdcpM76KgyZeWJ5f
        WLHyY0arlN8LvXEVpcwgSdtb/Z0bXxiAZIV7UARcKQ==
X-Google-Smtp-Source: ABdhPJzbSlEsYn4VgWV4cZkM+KdjQfRdw86NaXH9ke2x62eiILm1HDlTmuFMYpnmiT7gex8p8LYdULj5CZy8l7LXf0g=
X-Received: by 2002:a2e:b16f:: with SMTP id a15mr708014ljm.430.1605217648181;
 Thu, 12 Nov 2020 13:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20201112211255.2585961-1-kafai@fb.com> <20201112211307.2587021-1-kafai@fb.com>
In-Reply-To: <20201112211307.2587021-1-kafai@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 22:47:17 +0100
Message-ID: <CACYkzJ4tpfT4yCdRwqrUfzftdiF4yOSe1JWHqnp+DqqguDF6Ag@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Rename some functions in bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 10:13 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> Rename some of the functions currently prefixed with sk_storage
> to bpf_sk_storage.  That will make the next patch have fewer
> prefix check and also bring the bpf_sk_storage.c to a more
> consistent function naming.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: KP Singh <kpsingh@google.com>
