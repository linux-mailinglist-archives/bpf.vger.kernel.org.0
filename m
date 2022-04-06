Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419684F6E0D
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiDFWwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiDFWwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 18:52:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742C20034E
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:50:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 125so4768653iov.10
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ka52ZVRwoT68SZlLm3ihVVTDF0atr82UndgPoILltyg=;
        b=nhTOdAHqqLBeLfZLOFcpKjaxF00VmCUOl8UlvLPYOtG95a6P5IlW5kM+4PnUjk0xLP
         dub+4D4e18Kr4OKXIxF+WssMoTJ/AFf10lgzCGYewYMUVoWlXDjfYhlLLoNY2beQXW4Z
         tmPpkEIHyD6LbP+/sXXQSUtk7eZvNWmEMHAxSkiPbb8ZvGYSLdIHjQHXIKZsmCr5h2C/
         Wg1AmG+N6MA85I8OTJycjBmH6OcPD7IZRNngoIiWCgu++EkbFCA0ZgOkyl+ZK6S5mwgM
         00TpMSAmNuXnoDlFST3lHJqtQXVEDLR/LaG7GZpAK4yudJzSHx3i4IPB8N9Oa2U28RBY
         1ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ka52ZVRwoT68SZlLm3ihVVTDF0atr82UndgPoILltyg=;
        b=HYZHDqiOVQiy+1MnQJtK2qt8AzGWI65Ei7Q967geuSO0Ymzq1nmCf3MZlrUHYZXUAH
         aApa8NZo6BXyaPQq+bRAQCf0mizGFcsOsfAfteNC4GVqqgNvoRyVwput7z+URmpZj9Ew
         KEvLlMrdF7cEVWHuYu+p3c1meX8ZB4HrnTN5yNr9xcc7TXUDUkCtqZ0QABOe5kky4yeG
         cYriOsIGC8RK1DJI0XqIaWd/AtfLGTKl5tXH1oPTcXrRuwJLPEi+sgg02FTGX0CmGl8r
         1rx+na6C9M8tT+9Aqecclz+fP3stOLBeDQyr+xuJZ4GZUB5CsYPQFgUYlgfeIzF7y+ZK
         FQ8g==
X-Gm-Message-State: AOAM531gWeTe/84ifeOtOsXCAZD0QVAbuzcY7KT8dv/mtlUMlC7NwGM8
        iLhCGV7wtSPK5mrPC/D8oCnpbYp6EN7Wcs7ZyGg=
X-Google-Smtp-Source: ABdhPJz93H+ByVEdACEjI3/s5Yxdia5daREoDGq3doxeHfFsYFK06o0HGJ/FI6T8cvVDC5zFtqZ5ddX5/7HvSs0Tut4=
X-Received: by 2002:a05:6638:2642:b0:323:756f:42a7 with SMTP id
 n2-20020a056638264200b00323756f42a7mr5943437jat.145.1649285433009; Wed, 06
 Apr 2022 15:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-7-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-7-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 15:50:22 -0700
Message-ID: <CAEf4Bzb4hUUqt7vcQyOYa3s407gb+dqovXGVDAQ-Sr495RV9Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/7] bpf: Dynptr support for ring buffers
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> Currently, our only way of writing dynamically-sized data into a ring
> buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> memcpy, but it can only safely support reservation sizes that are
> statically known since the verifier cannot guarantee that the bpf
> program won=E2=80=99t access memory outside the reserved space.
>
> The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> reservations without the extra memcpy.
>
> There are 3 new APIs:
>
> long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struc=
t bpf_dynptr *ptr);
> void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
>
> These closely follow the functionalities of the original ringbuf APIs.
> For example, all ringbuffer dynptrs that have been reserved must be
> either submitted or discarded before the program exits.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            | 10 ++++-
>  include/uapi/linux/bpf.h       | 30 ++++++++++++++
>  kernel/bpf/helpers.c           |  6 +++
>  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 17 ++++++--
>  tools/include/uapi/linux/bpf.h | 30 ++++++++++++++
>  6 files changed, 160 insertions(+), 4 deletions(-)
>

Looks great and is a very straightforward implementation, great job!
Please fix the warning and maybe expand a bit on "failure modes", but
otherwise:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  /* The upper 4 bits of dynptr->size are reserved. Consequently, the
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c835e437cb28..778de0b052c1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5202,6 +5202,33 @@ union bpf_attr {
>   *             Pointer to the underlying dynptr data, NULL if the ptr is
>   *             read-only, if the dynptr is invalid, or if the offset and=
 length
>   *             is out of bounds.
> + *
> + * long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, s=
truct bpf_dynptr *ptr)

looking at this, out param dynptr at the end makes more sense again...
ok, I'm fine either way I guess :)

> + *     Description
> + *             Reserve *size* bytes of payload in a ring buffer *ringbuf=
*
> + *             through the dynptr interface. *flags* must be 0.
> + *     Return
> + *             0 on success, or a negative error in case of failure.

It would be good to mention that the verifier will enforce submit or
discard even when reservation fails. And submit_dnyptr/discard_dynptr
is a no-op for such failed/null dynptrs.

> + *
> + * void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)
> + *     Description
> + *             Submit reserved ring buffer sample, pointed to by *data*,
> + *             through the dynptr interface.
> + *
> + *             For more information on *flags*, please see
> + *             'bpf_ringbuf_submit'.
> + *     Return
> + *             Nothing. Always succeeds.
> + *

[...]
