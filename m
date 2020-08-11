Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C62415C0
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 06:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgHKEdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 00:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHKEdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 00:33:09 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4FC06174A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 21:33:08 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e14so6358602ybf.4
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQQTAbiPjogw2+cNx5kLhGwyOoHVEEVLYwgv41xvnpo=;
        b=NETjq15mX6EJphK6nsvStoZiUn5flEJQ+bDZZOmw0MqTw7YFiQPBBGNGN9RCEFHIDy
         YhWPE+uIXzHkoI1MwdXOkBeC3ZFEvg40M8n/U3eo9cXPa7K3m8eFyY7JxqfWLKbW0ve5
         exJKsHyqRQp4RRSMg9fnJ1gE/A3a5bklmpw5EzRCCeNR6hIjEoDzINNKF+g9CTSqLKSt
         iH7BvfvtCJ37eM17KKMEOMDm3GAvDIJXmLXkYLgBXHz3qOO0bZ/LhaeW4L9OLuB3KmzV
         JK/QIddAtoSveZwJyTQmdzHolP3ibDZsT+8t8etedzyjCf74hDTmh9f5xcuPKwSwhmYO
         fMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQQTAbiPjogw2+cNx5kLhGwyOoHVEEVLYwgv41xvnpo=;
        b=NFz8h6vxLR+uW8uIjRGc4ozG1z1Rb3ZFlFXIxgha/VRX3r9/9qd7pHmyKAtJKPa9pm
         KV04si6lMnVwQuY+DXpy3MmzLWNJw+1lBiUmFyKtRdKVjd07BwcTjTrfZZ4j35imyLFa
         b/ah3OI4EqjKjM1eAJp8nhY38G+0VKUJXMkT9z/cmdruTwUnijaz8d2n5Zs0JTgvqslq
         QloC3NLJKW/c7+J79RyvGkT9Ld/gEgElCtXn3ad/mIM0afoCWnRnrWr8XiPqlCC0STb2
         RvtKeIjN7VCcj0eggQNAKp0W9uCJqK9Fd6WRwS3rPFc0yst5WMeyDlSk3QCcdJWchPO8
         CLiA==
X-Gm-Message-State: AOAM532uRT5GpecKW7PDwePVIq+x+jpISJRrJA/+D8DFX1ePbG+IIS9g
        BTeEGxSsKu8Wn87e8YcjSReXC89PoZNLo4+1APw=
X-Google-Smtp-Source: ABdhPJyQjucoDnOzWX344iM7pGcwTN3tEWGhqHcHazxRRv4XqPUMOeBnPx2YDgYH286IfA32ictUcTd5mUSZT/p0Usw=
X-Received: by 2002:a25:bc50:: with SMTP id d16mr9516599ybk.230.1597120387757;
 Mon, 10 Aug 2020 21:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811030852.3396929-1-yhs@fb.com>
In-Reply-To: <20200811030852.3396929-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Aug 2020 21:32:56 -0700
Message-ID: <CAEf4Bzaa5rj0a+NVVjZNxD9+MueCuaOwt0kZP7-7eJxkH7df7g@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: do not use __builtin_offsetof for offsetof
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 8:09 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro
> in bpf_helpers.h") added a macro offsetof() to get the offset of a
> structure member:
>    #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
>
> In certain use cases, size_t type may not be available so
> Commit da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof
> for offsetof") changed to use __builtin_offsetof which removed
> the dependency on type size_t, which I suggested.
>
> But using __builtin_offsetof will prevent CO-RE relocation
> generation in case that, e.g., TYPE is annotated with "preserve_access_info"
> where a relocation is desirable in case the member offset is changed
> in a different kernel version. So this patch reverted back to
> the original macro but using "unsigned long" instead of "site_t".
>
> Cc: Ian Rogers <irogers@google.com>
> Fixes: da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof for offsetof")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf_helpers.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index bc14db706b88..e9a4ecddb7a5 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -40,7 +40,7 @@
>   * Helper macro to manipulate data structures
>   */
>  #ifndef offsetof
> -#define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
> +#define offsetof(TYPE, MEMBER) ((unsigned long)&((TYPE *)0)->MEMBER)
>  #endif
>  #ifndef container_of
>  #define container_of(ptr, type, member)                                \
> --
> 2.24.1
>
