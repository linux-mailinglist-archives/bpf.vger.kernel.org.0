Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3229E29CD6A
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJ1BiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36991 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832978AbgJ0XMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 19:12:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id h196so2696992ybg.4;
        Tue, 27 Oct 2020 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liJO0UMBseJNqhQ8h4VmFtQtQMXB3zNjeUaURQyVCEo=;
        b=Obe/XgPbNO/BHqgDadY9cgOjPedKu51zbnkO62vClNGy7TVe0YFA773/odhGJBUW97
         XvGVVUaNSNO/pHcxO/xVlqxjx9EtpOl+GN+8BRsfTCK4ybntWwXU3JHOQRosFvDyTgVz
         WWrCOofusRIcYQC8BcSfQth6k8Ezg7kco5y0Ggw3wfIvrtnm0FRr5kdxIil41ZplaBpC
         /KdWsNnB1/q3CRSp+IEKFlL04TttaVJSwzsqZD2f4xudmjfucal8tio1D8mRFSlBuiXV
         7qU1nd4GXgZATX5BEn4tLwogBwmcWmE1B3FkvZvef5vepbATMAwaYwPVxJ0IbvvLj9vS
         ZI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liJO0UMBseJNqhQ8h4VmFtQtQMXB3zNjeUaURQyVCEo=;
        b=dtLL90MQxc4u0PMb0MjOIJCgJ4ujlBpthHeLEJa91KK6sBprtlURbe+WE/Hekzarld
         r4SqLWgxThw1ELJfHHKZfYpuvqBFHlV5WwCx14/GUPJzwCEvV0PREQKu1BnES0R9sstc
         sL37GiAJ6SxXb8AjEHw+GREhpa9run3BRyzXL8L895FKTjj7Xd7mqP9ggrxXjEgk74AW
         LkneSBiHhxlusi0k/83MqP5gHCewd3rNxwikPYpRmQvYvEgtkZGLGq3D3/8gRsP3O3sn
         xOPSAWNhZbmf/lMdUii5FZDVM3W7bR2SaZDfta7w7Nqwdgan3QHzT+dKurkkCITgmjKw
         PRmw==
X-Gm-Message-State: AOAM530fDmvSc9uqn3I6t5LxC6Yf1x4xHEIoConMImef+PI4po+2UXvF
        qptrxIJfwJb6nU9n0UWzRQfmFft1bYBhSK0pjl0=
X-Google-Smtp-Source: ABdhPJxw1hKiK5CplvZxp7ME/ZAqyGFIHtoXGPX8jDl/CvgnipqvxLbWWva4oBFRgiiouSI9QxmBvKKLaGAUIccf2XE=
X-Received: by 2002:a25:bdc7:: with SMTP id g7mr7032229ybk.260.1603840335916;
 Tue, 27 Oct 2020 16:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201026223617.2868431-1-jolsa@kernel.org> <20201026223617.2868431-2-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Oct 2020 16:12:04 -0700
Message-ID: <CAEf4Bzan6=Jjfez17=S55Zu9EQTF_J2dg2DST4v+CfENm8cbUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] btf_encoder: Move find_all_percpu_vars in generic
 config function
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
> Moving find_all_percpu_vars under generic onfig function
> that walks over symbols and calls config_percpu_var.
>
> We will add another config function that needs to go
> through all the symbols, so it's better they go through
> them just once.
>
> There's no functional change intended.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 126 ++++++++++++++++++++++++++------------------------
>  1 file changed, 66 insertions(+), 60 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2a6455be4c52..2dd26c904039 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -250,7 +250,64 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
>         return true;
>  }
>
> -static int find_all_percpu_vars(struct btf_elf *btfe)
> +static int config_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)

I find the "config" name completely misleading. How about
"collect_percpu_var" or something along those lines?

> +{
> +       const char *sym_name;
> +       uint64_t addr;
> +       uint32_t size;
> +

[...]

> +}
> +
> +static int config(struct btf_elf *btfe, bool do_percpu_vars)

same here, config is generic and misrepresenting what we are doing
here. E.g., collect_symbols would probably be more clear.

>  {
>         uint32_t core_id;
>         GElf_Sym sym;

[...]
