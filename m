Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4982029CD63
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgJ1BiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:18 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42886 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832997AbgJ0XV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 19:21:26 -0400
Received: by mail-yb1-f195.google.com with SMTP id a12so2685539ybg.9;
        Tue, 27 Oct 2020 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxvGSPSSphSIY4oZ8UoU8OfzDn8W0Y+8aAkQkd7/l4I=;
        b=ufANqGIWs9zQlmtAA0WWpw78tzyVtPDWUcYHek5VwtiXQlk+rxR0PwVHnFUYBCavUO
         N+KLpRl1BDlMjD0/+kN3OE3Tw9PuovvbaJsCLunaoxsqjQAJxAl7bsNlm4rYGUMhe7/r
         18qOifg5Stum0RIytyMzbdZ4tKN7qE+xN/1dPhVULwGPkgbZO0RBn996hvyHGsTH0+xs
         SYe7UF8/M2XAM0DUsZU+EErKpeL49qnAAAlG44GYhUOtqtpdJ3NPRyomepybz+hOpN+Q
         N7gPxiRZ+BW5g3hu7eMfKt+ykAfNC7siHH2Vyq9SQPDi8ps7gugwck8R25WtVb01w2jP
         HaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxvGSPSSphSIY4oZ8UoU8OfzDn8W0Y+8aAkQkd7/l4I=;
        b=Clzc2df5RGe4iF7DA/W3XEXCd6JDWkXZzmU2a/OLCfQVZ1D4ZF52N+CuyXcYJQzjhT
         z3hpmGlbOLtHld1r+0dA2XL/iULqraJaJMeWKg+LH624JJ1aLKscO3rz5W0oZtJxgGc7
         yi7qvwD7SA6lX+G3kbMHaRUj1WtOepKNLsSPjzX6jY1rnE0nHKusDH5kh0ErFpgS28f0
         /X/CLmxNWHyVAra0Vpn0CBuukbtG0++PyzaYmXhI8TlAs0UV1TLOMOrQz0nuZoDmEEx7
         gYGoDI8FNb+u7tlQx9RVzyjbv3s0DKAqfh0Sx64L6l3h+jHCiYhQTEgF5oIGl1YC/c27
         QQBQ==
X-Gm-Message-State: AOAM531ie/XcT5aTtePAw2aWVTFwW5wa8zicubmyR6XxZBX9pNFJ9nhD
        PKKJ4x9+LI8V3q/jsu96rMoGKZxNKE4DlAQiB1M=
X-Google-Smtp-Source: ABdhPJzxAus0jivdIfUAM9pDcHvGgr/Q+U8xN+KNBQDK56TBvUdNcDiSYpf+vBYMAaqOnRBPqkkB8gwkm/JI/EgEZRM=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr6873017ybg.459.1603840885595;
 Tue, 27 Oct 2020 16:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201026223617.2868431-1-jolsa@kernel.org> <20201026223617.2868431-4-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Oct 2020 16:21:14 -0700
Message-ID: <CAEf4BzYpntU_ikusuwYLn0eBqvmQLt-qaOqECkBODEeSfwnx6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Include static functions to BTF data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Removing the condition to skip static functions.
>
> Getting extra 23k functions on my kernel .config:
>
>            nr     .BTF size (bytes)
>   before:  23291  3342279
>    after:  46606  4361045

almost exactly 2x... such coincidences make me nervous ;)

>
> The BTF section size increased of about 1MB.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 99b9abe36993..03a4bef11947 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -485,9 +485,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 int btf_fnproto_id, btf_fn_id;
>                 const char *name;
>
> -               if (!fn->external)
> -                       continue;
> -
>                 /*
>                  * We need to generate just single BTF instance for the
>                  * function, while DWARF data contains multiple instances
> --
> 2.26.2
>
