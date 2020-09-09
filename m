Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7682326261E
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIIENO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgIIENN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:13:13 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D6C061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:13:13 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id h20so890732ybj.8
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrDtEwc+rHURTnfQviusI6ZC4xqCSuojp4hRuymrIXc=;
        b=Q686TY6qxxOJlBrXM5TCRA6MhgBzjqFUHnZbzCfz4+SZwjyKBx+cSNckhbirw8Xw2P
         9M19duYLVM2hSRao85nFEV0O3S0t0LJI1POLPHGXs+d+lDwsB1XWEtyyFdDmaEQbLACW
         4yzl9jcfdE7Da8c15Ql/5JoXlnT9nEQet/ggH9oleAPYakLXEQSRwNcu3I0AaMWfew1A
         f4GmlA/6gJuK+l9XkYUVHFByFnIKdvA5mXbh8vEDGyPmutkT/SicXcxXUioUgdQUvZGu
         YZg4ACxvjq0T4I//S0ue53dhag594fqu26SjLPRCiae5PlIXgtEVTwRTJvMmdwMrjznz
         hhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrDtEwc+rHURTnfQviusI6ZC4xqCSuojp4hRuymrIXc=;
        b=LE5K5SSZRJ8fvbsW7m2O7KBpLZAEpZ60riiVUzKghOSQJlk5VS7CPYiFnFuSin+NDo
         FeSNn8RBzUxjbR6q1GF9eVQ1Ag5gKzjj7zkhQ1NJD/e9EfMhQBFBW2qAaZiTMduFmtpF
         IEA+PpXE+LFRgS1pDe10Y8Hz2CCb67G+lf/Dd2peckSUGT9S/vSTrcidta8g0mxM3pKP
         HfUNMvuy1ySeWEJr67nzUWF9KHm7Sm0lU8hDXkTuY/UfQ1GmLt7/N/lXqHaw72bmmBeP
         ML+YpjvJUQwSGXMywO6L9DuTt5U6iwVhCSiZGxsMf0mUjVaCeuAJggFIt3TrZ1q6mR8n
         x2VQ==
X-Gm-Message-State: AOAM530yUmerUPByH3IH5253J/LEHvz+bNFgtGbxgkT/sQ0LPNyeGW+4
        2TiIs8yvecjmoL3ChqTIgzV1X+Sbns0mINJctUQ=
X-Google-Smtp-Source: ABdhPJyLRG2L97Y6rr8Dytb09CMa5ns6CUFCm4Uw2eOUqUG2XQFU+vZRo264XDSNkRXZ4LcEYZo1+JzMJtWPvlTWSeY=
X-Received: by 2002:a25:e655:: with SMTP id d82mr3275162ybh.347.1599624792931;
 Tue, 08 Sep 2020 21:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-4-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-4-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:13:02 -0700
Message-ID: <CAEf4BzYMEwz2xfYRDn7G_hp7rrTjPy7m3eyEaNkd3B6EaD_z4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/11] btf: make btf_set_contains take a const pointer
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> bsearch doesn't modify the contents of the array, so we can take a const pointer.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf.h | 2 +-
>  kernel/bpf/btf.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c6d9f2c444f4..6b72cdf52ebc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1900,6 +1900,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>                        void *addr1, void *addr2);
>
>  struct btf_id_set;
> -bool btf_id_set_contains(struct btf_id_set *set, u32 id);
> +bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
>
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f9ac6935ab3c..a2330f6fe2e6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4772,7 +4772,7 @@ static int btf_id_cmp_func(const void *a, const void *b)
>         return *pa - *pb;
>  }
>
> -bool btf_id_set_contains(struct btf_id_set *set, u32 id)
> +bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
>  {
>         return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
>  }
> --
> 2.25.1
>
