Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0771ED57B
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgFCR51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCR51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 13:57:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2DC08C5C0;
        Wed,  3 Jun 2020 10:57:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so3922157ljo.0;
        Wed, 03 Jun 2020 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et7dRPpu+NjCc4fF835EoYiytd+clcxhsW6X3P8az6E=;
        b=XZOapxBglFvUrWUxAImhgTQ38j3cWZGZ0cVSHbbJXLmdENy+CTqgKO4nwLd4XUVP6w
         FCPi8VHDyxN87407vRSsmeEtOt+uRfVhtSHfnPyXcbxFE7lKOI0qOmk/pTiXcxPd4B4S
         VouUl/OuMX+vDP0KAGJOll8otBwb5iPnM1duCjo3nF+euZL7K3gNYAvddTHGpvtvQt47
         JCfr1AKAYiiEs7SEYc1ztLqAm9v4WEpMFpontsZeM901qeHo4TVFkrMC8d68JsmGW7H7
         LYAZoC4wqYEA/i59i1lJjvH2z+h3AaEdsgOPHCSNKiILYQb6fIJEm8m/YqXqJhfqJ/ho
         8xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et7dRPpu+NjCc4fF835EoYiytd+clcxhsW6X3P8az6E=;
        b=UhwNANFFzkjcht58iAelsS5lAkdB046vEixafPe6EhyzZCvL6I+EFNmmMNJ7emNLhq
         Dn1vc2s0ux26PTXBQOe5qJmXMJZkOjwrymPDZ4P/JCzKCW6JYtOxMMqhW2atc+6DTfW7
         OFcBvz1gjxlyfYM0lRvZCuCdQV8nxQqxhpHrY/KTgUdY4txdbnYM2HKQLwQrcs3Uq7lf
         1E3Nw7pwCr5s2hA0JK0R1mADJ6rVHozAzj0nNurekhiI4xgi/Lp1bf2wxdSFlre+6YoY
         Q7rOjs61rPT3+BuZq61zCBMHriB9FL/leceXCia9lrpzOI5z1aiNnwlQbxq3NodqUwio
         yUCg==
X-Gm-Message-State: AOAM531udy6qXl7M/9ZIFhgZlnY2VRZFLzjxocqCPrYSszCzGvdKs6fp
        kdQmTLZsNStGgWFo2JnmNOM65djmS1en/aO0A69NWg==
X-Google-Smtp-Source: ABdhPJxQndFWkFtcDSnnyz3CWUAJujdiAEnn4FC3ceg4ENsHXqe/5G0P1bJFPHrrp8ZTxPz6m0jeYRANFdZ39z6o0X8=
X-Received: by 2002:a2e:80ce:: with SMTP id r14mr202067ljg.121.1591207045736;
 Wed, 03 Jun 2020 10:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200603175509.GE18931@mwanda>
In-Reply-To: <20200603175509.GE18931@mwanda>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 3 Jun 2020 10:57:14 -0700
Message-ID: <CAADnVQJPwtan12Htu-0VhvuC3M-o_kbnPpN=SXVC-amn9BcZCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix an error code in check_btf_func()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 3, 2020 at 10:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This code returns success if kcalloc() but it should return -ENOMEM.
>
> Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5c7bbaac81ef9..25363f134bf0c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7581,8 +7581,10 @@ static int check_btf_func(struct bpf_verifier_env *env,
>         if (!krecord)
>                 return -ENOMEM;
>         info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
> -       if (!info_aux)
> +       if (!info_aux) {
> +               ret = -ENOMEM;
>                 goto err_free;
> +       }

Thanks for the fix.
I think it's better to do 'int ret = -ENOMEM;' instead.
