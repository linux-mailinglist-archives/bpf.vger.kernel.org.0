Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A710435173
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJTRjx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhJTRjw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:39:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD1C06161C;
        Wed, 20 Oct 2021 10:37:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l201so3204350ybl.9;
        Wed, 20 Oct 2021 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3A9kzV19MGIac1TlBr0EFngPYz9LD2+wA6b0zyoctOA=;
        b=Zq47VcQTkf18SGe/xVBL+zfi00V3fnT1aZW3c78hEJZt6RbOV6F1CWJ9uF+X7pR9Sw
         g6QVj8AwWUzg987stoZbpVFVBNmrHlCUwVVQhufGn6Di27o8L/+ngO12IMyX+aZ1iT4P
         A4Ll4lG8manZH6JzFkZ+Jp28qcSofu4mUKNmZHcTB4D0ju9zJj9gCNQRXC6VHpTihd/q
         52iuB55lhe0/YgTLgjX8RoSDkQUonW4NOygPqUs1E0uXWSdEljH8XjMx4pdT1974iBND
         RN8evLGS3dbA1CGfKpyiZxdjX1gjVpFCx11uKTINZTT+fW/uUnMn0UsSU89r82Wlt1Ph
         ZUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3A9kzV19MGIac1TlBr0EFngPYz9LD2+wA6b0zyoctOA=;
        b=vtS3Qps42ohSE17569K1QFFGn4dRybKLb3yuCSB15MCLTlPnOAq8tG2J5wVXc4zpyz
         mP1/WPETu/HeJ2rY3FKFO2A4fzQ+GKxnC4CwOtjzT8asAhCz933M8mh9IxxddqEkF/1H
         uBiDFerhgJIUDs4r5RV4/UK952h89bxXp1A8YL+h40ZNUOmMrp1fRKW0NdFOXFwl4kXC
         lnWZYS+AsjB5B861j10arxUyrdXfjwo/DZvqyUgHQyW3r4Rx98fk4BwgkW0wMri+3q2b
         EewYeNPQYxOHT5uuv2R5JpY4okuAZMqfVxkVHvl8jOwTacAAUg8BDNHWkK0af/ZISnep
         N5xQ==
X-Gm-Message-State: AOAM533d8iY1nNNUuTMHaLSm80Lce7Pl54/wfjTijSDDFWNEnytcyAUj
        Ky9TO0FaWjm4mNRwmeEqS7145DilF6xAOMrh/o4xGBkuvxc=
X-Google-Smtp-Source: ABdhPJxibRbc5vNua8jEPyFSmWldN250wzQQREQaswwhPZRXKpQASmvwUydqA16Ngzv9LsRaBZzNXD1ffL66b2Fl50M=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr390759ybf.455.1634751457198;
 Wed, 20 Oct 2021 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211011082031.4148337-1-davemarchevsky@fb.com> <20211011082031.4148337-5-davemarchevsky@fb.com>
In-Reply-To: <20211011082031.4148337-5-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 10:37:26 -0700
Message-ID: <CAEf4BzbY+OMR_=JJHdzJpiuar_giusd0sb1LKoCQ7BEDYh57NQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] libbpf: deprecate bpf_program__get_prog_info_linear
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> As part of the road to libbpf 1.0, and discussed in libbpf issue tracker
> [0], bpf_program__get_prog_info_linear and its associated structs and
> helper functions should be deprecated. The functionality is too specific
> to the needs of 'perf', and there's little/no out-of-tree usage to
> preclude introduction of a more general helper in the future.
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/313

styling nit: don't know if it's described anywhere or not, but when
people do references like this, they use 2 spaces of indentation. No
idea how it came to be, but that's what I did for a while and see
others doing the same.

>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/libbpf.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 89ca9c83ed4e..285008b46e1b 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -877,12 +877,15 @@ struct bpf_prog_info_linear {
>         __u8                    data[];
>  };
>
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
>  LIBBPF_API struct bpf_prog_info_linear *
>  bpf_program__get_prog_info_linear(int fd, __u64 arrays);
>
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
>  LIBBPF_API void
>  bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
>
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")

we can actually deprecate all this starting from v0.6, because perf is
building libbpf statically, so no worries about releases (also there
are no replacement APIs we have to wait full release for)


>  LIBBPF_API void
>  bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
>
> --
> 2.30.2
>
