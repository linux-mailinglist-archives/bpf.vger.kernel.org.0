Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69661E5184
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgE0W76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE0W76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 18:59:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A984C05BD1E
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 15:59:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r16so3246041qvm.6
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 15:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ0Vq72W9QRGCJxoMgyu3FzhHtcrYW+iI4uF5iQCrw8=;
        b=bA0/H2exnSZwIX4ZbhJwbX+qbXQCJSu5+0FyvBnkOV5ji+fIbPV+kbGvEFhI5R/ehv
         X3k9U7iULhUhLAJfgaVqQNCz/8ANKyBPVDc4JvkYF/w20CgJELq5Plnu+ilAv6eWqyAu
         KY3CZfzZx796jMZfg6WqXr3Yma4wKCkXx3I1RQGSncSx4Zsswx75Wme+dSidRVG5+rHk
         lxhZ8Q2QHsxZsgeUOCdS4G6gut+OstVkv0aoXfWaNeLcbLJZXMNoqaG1gh3qij3W8yol
         sJCaXGu5DkPOwNPRlpBpXhvKxdPznBVyJaWa9nqajbID3QNitxwj1ug/u+qw3ctsrXtc
         dHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ0Vq72W9QRGCJxoMgyu3FzhHtcrYW+iI4uF5iQCrw8=;
        b=BEyuUmMhZS2SUhZ7WX3aeXkAogegHFufqKUDHouy11DGKaPCdIrCoVQ6eZv5g6vbix
         ptJYr0t3cQwd5MMrtxbiGFEXouxsUMoWtKtBmU3veqoHIKEn2bzMYA5NA6aPef62i/iw
         u1x7LLGLWVoC+u4u7v1n/w9AmWHbf9WdSTng6SV67ddGb/faFK5u+e6aeJ5LsFc966fb
         +9dONcPUs+ByobHKXh9PZhsINmW7Ck9aMu2niizsP3z5fsW94A3kJUUBkkWKHFRnSXA3
         ITWUQzH3EXMlhxDXOt1ZOPngKL/wP5jAvWL/o7SGvd6UiT7NztjsWuY5Dm7krf8DS50z
         jbsg==
X-Gm-Message-State: AOAM533onkosn7nJZuq4Lva8Z7rbZjNL8XglBomivoH/BVJGS61CmbPQ
        dK1Tc0KN7yjBUmtc3sYQsBdcfouKvMC0wsfjQ5I=
X-Google-Smtp-Source: ABdhPJxbKIqEiLp42CkkvuARpCJ6lK+MDk1K76rspAMz9TpDNR9kb7WjI/g53+RYXDtTlSr1XoODdH5nnkHFcpniPOY=
X-Received: by 2002:ad4:55ea:: with SMTP id bu10mr314872qvb.163.1590620397345;
 Wed, 27 May 2020 15:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <159057923399.191121.11186124752660899399.stgit@firesoul>
In-Reply-To: <159057923399.191121.11186124752660899399.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 May 2020 15:59:46 -0700
Message-ID: <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 27, 2020 at 4:34 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> When a BPF-map type doesn't support having a BTF info associated, the
> bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
> map_check_no_btf() currently returns -ENOTSUPP, which result in a very
> confusing error message in libbpf, see below.
>
> The errno ENOTSUPP is part of the kernels internal errno in file
> include/linux/errno.h. As is stated in the file, these "should never be
> seen by user programs". This is not a not a standard Unix error.
>
> This should likely have been EOPNOTSUPP instead. This seems to be a common
> mistake, that even checkpatch tries to catch see commit 6b9ea5ff5abd
> ("checkpatch: warn about uses of ENOTSUPP").
>
> Before this change end-users of libbpf will see:
>  libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.
>
> After this change end-users of libbpf will see:
>  libbpf: Error in bpf_create_map_xattr(cpu_map):Operation not supported(-95). Retrying without BTF.
>
> V2: Use EOPNOTSUPP instead of EUCLEAN.
>
> Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

I don't mind this change, per se, mostly because I think it doesn't matter. But:

$ rg ENOTSUPP kernel/bpf | wc -l
42
$ rg EOPNOTSUPP kernel/bpf | wc -l
8

So 5 to 1 in favor of ENOTSUPP in purely BPF sources.

Globally across kernel sources the picture is different, though:

$ rg ENOTSUPP | wc -l
1597
$ rg EOPNOTSUPP | wc -l
6982

I didn't audit if those errors can get eventually propagated to
user-space, but I'd imagine that most would. So, despite what that
errno.h header says, EOPNOTSUPP is quite widely used still.

But regardless, can you please reply on v1 thread why adding support
for BTF to these special maps (that do not support BTF right now)
won't be a better solution and won't work (as you claimed)?


>  kernel/bpf/syscall.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d13b804ff045..e4e0a0c5192c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
>                      const struct btf_type *key_type,
>                      const struct btf_type *value_type)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>
>
