Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1504C495779
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 01:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbiAUAoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347962AbiAUAoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 19:44:06 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C4C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:44:05 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v17so6428785ilg.4
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0KZtq+IofEtUGJDmSwimsP2FE7kVCL+4qw8EaYeVYo=;
        b=RZRPyFrNRZTRRuCtqmpMJ4/en8a0MB6kEA3B+2JyOLlwEOneyCIwhq/1hD0zBm4ROL
         86GCL7dAZPvmi+SlZGtOHMk8QaqCUTOApQOANDXoTjMEn0HX93BW0yVBH1+xu5N80CD4
         CjzIjP9kdV0X6SEKkdyJkMzrW9rwTln56wPsciz5n3aA8UYpNfSG26/hLyi8O6x1aZVS
         kwH5n4BMsH4Pq4RAEdxvL1GDn6jt6t4GGpDsEqEeMrkCgXqESCZDAkpJlOFlaGm1AoQl
         GYBV32IadbnL8Qa9qn9ujrowT7ldNEdfuZnYoLvDx9n1rYXMNwttAxyqelVDe9poCRmN
         txIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0KZtq+IofEtUGJDmSwimsP2FE7kVCL+4qw8EaYeVYo=;
        b=njuB8NSEt0N4knjqOz1In/qYYH2yiDJ2KuiHmyXuTomK0/eH2joaLRtSXsmVJrQ3PH
         REFaEs63g/RFqpvAgMIC4HJaEtH7dYo3gdbpj0zS/qp4xF8Xka9382bCr6rrUf2PwJZ8
         VjUDwZEEvJ8SAKh6nxYY197OEvKoeni9X/7qbXa9NSGUIb+E6Zxthr6cYwOs6dOe+9/L
         OlO3jZpCJjqqM4ZdipfV+lzSMiDow42josWOC+SemIZ8T5dTJ1GX6ryp5vApoC5eO9pA
         AFBTj6bk65n1D37499QRqnljb220vlgayr5WHcAFus+J+Uo9vNcKCZ0TIiAv/UVfJxJg
         Iysg==
X-Gm-Message-State: AOAM532Qp8XxZoRclD6XI9ySyvYweLV0LJo8u9Kn4gw9NDHFD63/OLuE
        RY5r3Rsi/c9Xv/G3HbzlKEqVdmpuKzExv4SGAdjKegZ0
X-Google-Smtp-Source: ABdhPJzfj9erkwgL4tPSmzY2NgEPc1+wbOTooepgl156+JxrCSvltucoAXl78u9EAMFIvsF1dBZeVzixzYVv1jbh33g=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr818538ill.305.1642725844968;
 Thu, 20 Jan 2022 16:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20220121004115.3845888-1-andrii@kernel.org> <20220121004115.3845888-3-andrii@kernel.org>
In-Reply-To: <20220121004115.3845888-3-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 16:43:53 -0800
Message-ID: <CAEf4BzaJwQPsTC9s=CjxvfQP1s6zWRvrGk938kS=ASo5w8vxmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] libbpf: deprecate bpf_map__resize()
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 4:41 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Deprecated bpf_map__resize() in favor of bpf_map__set_max_entries()
> setter. In addition to having a surprising name (users often don't
> realize that they need to use bpf_map__resize()), the name also implies
> some magic way of resizing BPF map after it is created, which is clearly
> not the case.
>
> Another minor annoyance is that bpf_map__resize() disallows 0 value for
> max_entries, which in some cases is totally acceptable (e.g., like for
> BPF perf buf case to let libbpf auto-create one buffer per each
> available CPU core).
>
>   [0] https://github.com/libbpf/libbpf/issues/304

This is supposed to have Closes: there. I'll fix it in the next
revision after waiting for any comments.

>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dbf37c0fa531..6f8e6b3cff84 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -716,6 +716,7 @@ LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
>  /* get/set map size (max_entries) */
>  LIBBPF_API __u32 bpf_map__max_entries(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__set_max_entries() instead")
>  LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
>  /* get/set map flags */
>  LIBBPF_API __u32 bpf_map__map_flags(const struct bpf_map *map);
> --
> 2.30.2
>
