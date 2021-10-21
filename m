Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33342435813
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhJUBOq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 21:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUBOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 21:14:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD5C06161C;
        Wed, 20 Oct 2021 18:12:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o133so4437028pfg.7;
        Wed, 20 Oct 2021 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPzDsdX08NZmDx8Uzcz7akVMOz1kLBz7pqYyuIw+ZW4=;
        b=RuvKXK5gQBkp+PCNywSjxIbKM3ItZD29IBCojEGxMfH+RWCq+Asjw4L+Dht3I8tJQD
         4ffSWQu21rkk/ZX1fM70dGBvmT0TtuLwL/+FP7Iu0ddKgxF7KbT+3ZhO3TAYV1iQqHi4
         +Xmj1+7OViUidvIKQxIB8TCv5Wl9wOo/BAE6wWCZyc6nQvG3Bli7z0ilCBndTG5+z9Tj
         5XN4mm5WAWyquA3phwZ1Em69xYDRQYzEirqhXJ2ey0ZKXwTvpmM9juDOt9ijSGoCXI++
         jiToyRxT3tW+FvXo+MLQfQ8GiLGKIPGYZaCZvVWFMw+BKBra2Cc/fB62NUM7UjnKy60M
         qREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPzDsdX08NZmDx8Uzcz7akVMOz1kLBz7pqYyuIw+ZW4=;
        b=UIVg/QRf2alm91+Q1FG65B5ZxhmkmN+kbXvfHbmOOztHfpLLXh/88uyM2P2VjDMHwz
         Pw2gzdLXNVxa5qK6hBwuBzGDz8UVzPb/BDGg6zaBTJ42o5p0sCUr1EMv7xCOsmk+3HKV
         JqP7CYg9NQLZQXiEFPBN2c2Ujju7aN6THpFMnL4K2n35QevrG7so8VyVxVJZBOMHg9tS
         vOiPvxhgVArMGo1EpBAxeWAu2alaF7Xf4drRxTxhQCoQ+h6tVQSlWwWy1VWOuGn00/ui
         y6dHSQ1V5NwO47d00t8n7gTq+CGwL5CeCWyRht7FU1dhKa+CN6fvfwKMSUpUXhwdf4JH
         NFNw==
X-Gm-Message-State: AOAM5334+dY/Gp+71X8u1DGhi8j2kvGcy8c76vqy9GYi0/PE1Gm+i2kL
        rFsEAdThEUc6gtKaj1wkOmx+qJkcEVsMLCgdmq6gCKfE
X-Google-Smtp-Source: ABdhPJw3QWWPVYqMXzg8U0HaSTLX5wnUGNnR5b+CuFcas++LD/CZcnho1YhpkuhGKxaFAkLxAcCFpFm9T0Jol+Ebjiw=
X-Received: by 2002:aa7:9f8f:0:b0:44c:cf63:ec7c with SMTP id
 z15-20020aa79f8f000000b0044ccf63ec7cmr2146811pfr.77.1634778750690; Wed, 20
 Oct 2021 18:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211015093318.1273686-1-jackmanb@google.com>
In-Reply-To: <20211015093318.1273686-1-jackmanb@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Oct 2021 18:12:19 -0700
Message-ID: <CAADnVQ+VJbbAvEG8c++2K8WgPWOfnPbdHA414nGnqub+PRrhxw@mail.gmail.com>
Subject: Re: [[PATCH bpf-next]] selftests/bpf: Some more atomic tests
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 15, 2021 at 2:33 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> Some new verifier tests that hit some important gaps in the parameter
> space for atomic ops.
>
> There are already exhaustive tests for the JIT part in
> lib/test_bpf.c, but these exercise the verifier too.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Applied and fixed subj.
