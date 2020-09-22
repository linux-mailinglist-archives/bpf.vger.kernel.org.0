Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF78273E61
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIVJSg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVJSg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 05:18:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39DC0613CF
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:18:35 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so20341354oie.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIvWbUTBySNTHnVhnBYw7E1b06YY+R3Gv6z9efsMGRs=;
        b=lKZPSxpfX2Bd96LPhxRL7rYNi+m3wVAp+wl3BumysybGdxga2s/epo8VhBAc3LJNJJ
         UZ7XThxbtQOpWYiD2eylwLSQstdsswJ3ZdH6v39TnmbDcfT1N1uWEXC4uCwpoyj9dLJb
         mXl5Zc0RCSRZdy6ruNZZFboYwiOisTfkOTPuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIvWbUTBySNTHnVhnBYw7E1b06YY+R3Gv6z9efsMGRs=;
        b=O2CeYP0ugIkZeY0ASLt7NQ7hS1podvw4ryrYB1eCm39nVTIothIAlaNP0yC38swEi7
         l5NYLpq07zyiyZvuBFEmBKhgSGThg0gmgyr61Zdht7N0MxIV0QkF9udKJr+2Pt41Hvma
         81QZVFbfnnWxLg1DgEaeaHtnGKNk7Y0eFptHxaS7EWRkp5Txaa26MllC9a8ZUDU3CmHo
         3gbYS/VAumCUpcsJNNqwDzZCn0GU5xJEf+PF4HEazScFta5Vp/74xaCUCvyMwpBC1SPQ
         hwsUAJuwIsbmT9jA+EJVb0sR3zkaS9l+c2xInkd37vE/lH/UBcFgbcAt7dyr7TaCyviO
         t6/Q==
X-Gm-Message-State: AOAM533tnK+oZQA2AIOhXc4y6qPjOSyACD0YNpYkbjN2jor/Uo1iLgZd
        +N0GL5W4MIkRncoCmGTPTIeJC81mv9/uPZGlqI37ng==
X-Google-Smtp-Source: ABdhPJwtIAWI60BsncNBkyvO8idOff95UP2tPFkMlT0u41iJi/GCCpycEBvqBZnXrmdOdTymaEGQ/EESj3csh41iLRU=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr2118153oip.13.1600766315392;
 Tue, 22 Sep 2020 02:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200922070409.1914988-1-kafai@fb.com> <20200922070440.1920065-1-kafai@fb.com>
In-Reply-To: <20200922070440.1920065-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 22 Sep 2020 10:18:24 +0100
Message-ID: <CACAyw9_7AHqVoMhQ7ZdBBRVt+6FaJnJG+VNc1zt52dx=+z-7wg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] bpf: Change bpf_tcp_*_syncookie to
 accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Sep 2020 at 08:04, Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch changes the bpf_tcp_*_syncookie() to take
> ARG_PTR_TO_BTF_ID_SOCK_COMMON such that they will work with the pointer
> returned by the bpf_skc_to_*() helpers also.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
