Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB849AC7B
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 07:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbiAYGjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 01:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353819AbiAYGgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 01:36:44 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E2C05A1AE
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:54:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z199so7795162iof.10
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spDTzqhx7YEsHsfnYoD4R91BekwqRV0kLs1jtHrT4EE=;
        b=iECx914bMsvJ6x5ZcrDIdQt4Sm+ei+b18xvb5haecTmV6XRNLolhZYSCM+ztl8Tt0W
         jItZETnCCZ/BvQA8a0IESFfOp6uVKvPTJw1HwU2yXEmpdsVKOTbxZ8JcWCYbj07TUKS9
         kLnBB+3yQlF/zqGhykln48iHwXawBafrFqT962PTXKyZDzgAd07nxty8Kwxow0uP0dxe
         rwUy76SBsqxgX2z8sEVJYs6yUi3EVFwe36Js45PlFhuiwuecBTUMnHtId7Pvcsv/eYWy
         R10WcdJhroYxKie2DTBq2SRc+grKLQdDFbthuFzvfv8oOS4+5u0seLuGWH6z2SudW2nT
         oj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spDTzqhx7YEsHsfnYoD4R91BekwqRV0kLs1jtHrT4EE=;
        b=UtGEllfQPXkoc9goz/HrBh2JdMSYFgcs4SR5ZLoVU0lxrlwv03HWEefrP9LbR0vFQ2
         PIUbT6MJVseNH69CmAAo33djR/jRkzHUd2MdCSohrnfe0cWuDHIMD2hJboTmUenIot8b
         O3764muqUKFnCmqcX6TvFZsJkN4phW1CBUoky0xUpI88ixdSEvD1WcZhDM1qj7YlFxyD
         FfFV3fT7mF6zT9EIo3Td7jAio6eKtgKa2hfkJVV8e5P8P1O6cXyRgxxQb4Ar9lN12pHJ
         M5adNx4LO6chUYHBYa8LBQhrWzj/LkgbRtetI4c1K6ilP4Pk6I+lEP6OlAKmghwlodAM
         fHvQ==
X-Gm-Message-State: AOAM533jOun+uLJnyp1RwF/AAhQ/Bg3c+hZ7e2xEIDWZVT9s/aYvtxJ8
        xrpfEXwwIA1P6gOWivjcYjkqtq87R/4Nwsdvxp0=
X-Google-Smtp-Source: ABdhPJxTgnwi+VrZdrLJuvQ8CAv2gcIIUtVRZ/ZNLi35cU3FCxFxQ3ufBjBgeYDA68rBabyaoyKhV4JoWG00CevjbaY=
X-Received: by 2002:a05:6638:1212:: with SMTP id n18mr5299904jas.93.1643086490940;
 Mon, 24 Jan 2022 20:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20220125010917.679975-1-christylee@fb.com>
In-Reply-To: <20220125010917.679975-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 20:54:40 -0800
Message-ID: <CAEf4BzZCO-fpyKTaz+jvdnQjReUMB7fAcP4Xegxceh-R881aLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: mark bpf_object__open_xattr() deprecated
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 5:09 PM Christy Lee <christylee@fb.com> wrote:
>
> Mark bpf_object__open_xattr() as deprecated, use
> bpf_object__open_file() instead.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/287
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/lib/bpf/libbpf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 94670066de62..55dba4c38a04 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -183,6 +183,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
>                         const char *name);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_file() instead")
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_xattr(struct bpf_object_open_attr *attr);

You've missed one internal use of bpf_object__open_xattr() in
bpf_prog_load_xattr2(), which would cause compilation warning (turned
error) at the next version bump. I've updated that to
__bpf_object__open_xattr(&open_attr, 0).

Best way to catch this is to temporarily change DEPRECATED_SINCE to
the current version (0.7) and compile everything with that.

But also given a better API exists for a long time now, we can
deprecate bpf_object__open_xattr() right now, so I changed
DEPRECATED_SINCE to 0.7 and applied to bpf-next, thanks.

>
> --
> 2.30.2
>
