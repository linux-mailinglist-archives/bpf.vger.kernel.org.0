Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909E43E993
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ1Uhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1Uhu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 16:37:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E0C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 13:35:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 83so7600897pgc.8
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaWhUXINMcbBgsxmUbNDSLis8VUlnSOmYijw6hYH1Hg=;
        b=OqrumSxvRz40kg5Yg6MXFG+F8gmzFMdPy6NlMwoxQoXYDTtz5LC99yubuGQcW+ZIh5
         X+K50q5SoXN4gETiuMsstpMAYgJ5Vfpeoh4zJ+lvwrNP+pwxp508y7SO65hvgKj4o8V1
         i1dExqtli8RJDCC7UE9GQw8rogPGcIv5KmdEvxpQ5JdfLuIa8CLqReUUOBdZxRnEeBxS
         PoFmEg5/GDmXRhR7dOdLoH7mXcZCgx+belLhYeHhGHND5QajxDv3CGIjGEYmyj6430e4
         PzkjjtjMTm/b2z3M9ssuHMterTidDg8HeIYAGzw0+yI/LPvCAod32ug1Bs9Dz53ZeiMo
         +qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaWhUXINMcbBgsxmUbNDSLis8VUlnSOmYijw6hYH1Hg=;
        b=ZbxqMWqnKW/RJpls+g55WWDdj4MSnAIops1LiDXkdY60GpqX/HqQufVf1IwSKR2n1h
         eUpA5XAiBxlfnT3PvgGRwVBsNdhjFa9cnfPU3259L0mmLMx00Bxw/omjynKmJj+8NTTg
         TEM4aiDjv6kiVhyXBaGbRV63DLEHKjBt/S6wBP2IastE2GFe84XjZbkB6GQ+Ai5vw0WE
         PgcZ+qgjWbFRgIoQs8DvoCna36Eib1uCNUq+PZNohgpEX0UN9GEgIBTmj8JR3ceLIGaP
         UlSU/hqe//tMZEyC0ofUUah43B+2kw16VU6GwBuqzJsUBNsqDNlOfyMzZFjrP17t+6/f
         KOfg==
X-Gm-Message-State: AOAM533NDEFxil1lQ6JVX4CxqylixizJxqYjli8j30KR6fEJRckP6ZxV
        e+ejcIrs4IredFs6iyE3ryy1cHfgslJjb7yfGjY=
X-Google-Smtp-Source: ABdhPJyxKJBeO97b8L8kbatExy+dZABVrxTFJKsNkxJp23B/n0mqk9+aQu5oHn+usFYbsyu/8S90+AFmME44+ndlZAk=
X-Received: by 2002:aa7:9727:0:b0:47b:e175:2320 with SMTP id
 k7-20020aa79727000000b0047be1752320mr6508025pfg.77.1635453322295; Thu, 28 Oct
 2021 13:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-2-joannekoong@fb.com>
In-Reply-To: <20211027234504.30744-2-joannekoong@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Oct 2021 13:35:11 -0700
Message-ID: <CAADnVQ+y6KNTOHkw8xTjuAL6cFXOOZ4pPPh0sWSYfgP78FDh2Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
> @@ -1080,6 +1089,14 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (!value)
>                 goto free_key;
>
> +       if (map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
> +               if (copy_from_user(value, uvalue, value_size))
> +                       err = -EFAULT;
> +               else
> +                       err = bpf_map_copy_value(map, key, value, attr->flags);
> +               goto free_value;
> +       }
> +

Applied to bpf-next.
I couldn't find where lookup from user space is tested.
Please follow up with an extra test if that's the case.
