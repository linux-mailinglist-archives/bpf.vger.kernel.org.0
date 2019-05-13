Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75611BA73
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfEMP5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 11:57:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36627 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfEMP5N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 11:57:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so8338585qke.3
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3lFWeDG361v5AKKAFn/xI1WFQCnGvS32KJsdSeQ3TU=;
        b=uEdDrnEGYwfdie+Sc9jE8lmh992GhIytGqb09Qfd0rG9xjPfTIqhnDjgRaQuwgF0sw
         xEkRvzbbOe6cCVH2C983FW1BS9vMVY205jIl+YCGd++iP3lQQKs5v+UZvSnn1BXB7XPJ
         rafGOAA0iPtGfLV+AT/1XfwBRmKt1r87uFwaM+0RxrHVdHuM7z20Tbp3ypp6c3dalRY0
         m80L/bySH3Y2FYu4toVNiGea2ObVveT6bx/MNjmt9pW5L5Wtn8rECnByAm8TRgyIpkkP
         5Lu9XREDKCxO/houPro7iE4AI0kUADXELqtmMYOwYfIrjq/pzYPUPNTTEzPKHTURCiIP
         nF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3lFWeDG361v5AKKAFn/xI1WFQCnGvS32KJsdSeQ3TU=;
        b=DDIBOvgLd8zSCz/by4bp5sRzFBSB/BP2sReShb/6QimRU4NEDCu1NWe+LGhtlBoJMy
         WlaoiArnJXXGky8PZM9el2/ADqRi3OXZRuWYsv8FdkM/dRB4APII1RIlwheafBE7U6oi
         vDLPGgfvhonUmyvc51IDeWvkhFKNJr+8K4MmaDL0J6guwCiw2cTjab07e9+apNexHsbt
         R0tS9N/ScWPRFYjO/zTcELz2c7qhNnuyNMPAjD3u+eTDgjJB/gd18v36quJR+u6z+98J
         2/SwMmbZQVu+MRznCKm4rpsu8TgYo9lfF/97DuXYS2e57VDq5R3emIEahcgjUksZxat4
         bhsQ==
X-Gm-Message-State: APjAAAVq7nvqQp4WfRQprr4ujAnhaf7N2c4rJcPMS0oFoUq1LfV+ug9P
        oBRqHwWpiNUbSZgMmPkiJOInVyEhjNMT0HR1y+g=
X-Google-Smtp-Source: APXvYqy3rYVx3nqNLXatsQSuASUb75rxOxp3VEWOZXgvnjl5VFbiACBVK77mDPhEZnrgtxitedBUjCG7BfslCzeTdZM=
X-Received: by 2002:a37:9085:: with SMTP id s127mr1229851qkd.352.1557763031860;
 Mon, 13 May 2019 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190513094548.9542-1-glin@suse.com>
In-Reply-To: <20190513094548.9542-1-glin@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 May 2019 08:57:00 -0700
Message-ID: <CAEf4BzYaxdyO+4y9U6TYrKw7fi6KrA5UBNPURfz+p1qc13x03g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: btf: fix the brackets of BTF_INT_OFFSET()
To:     Gary Lin <glin@suse.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 13, 2019 at 3:23 AM Gary Lin <glin@suse.com> wrote:
>
> 'VAL' should be protected by the brackets.
>
> v2:
> * Squash the fix for Documentation/bpf/btf.rst
>
> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> Signed-off-by: Gary Lin <glin@suse.com>
> ---
>  Documentation/bpf/btf.rst | 2 +-
>  include/uapi/linux/btf.h  | 2 +-

Can you please also sync btf.h into tools/include/uapi/linux/btf.h?
But as a separate patch, because otherwise it will cause issues when
syncing libbpf into github.com/libbpf/libbpf repo. Thanks!

>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 8820360d00da..35d83e24dbdb 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -131,7 +131,7 @@ The following sections detail encoding of each kind.
>  ``btf_type`` is followed by a ``u32`` with the following bits arrangement::
>
>    #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
> -  #define BTF_INT_OFFSET(VAL)     (((VAL  & 0x00ff0000)) >> 16)
> +  #define BTF_INT_OFFSET(VAL)     (((VAL) & 0x00ff0000) >> 16)
>    #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
>
>  The ``BTF_INT_ENCODING`` has the following attributes::
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 9310652ca4f9..63ae4a39e58b 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -83,7 +83,7 @@ struct btf_type {
>   * is the 32 bits arrangement:
>   */
>  #define BTF_INT_ENCODING(VAL)  (((VAL) & 0x0f000000) >> 24)
> -#define BTF_INT_OFFSET(VAL)    (((VAL  & 0x00ff0000)) >> 16)
> +#define BTF_INT_OFFSET(VAL)    (((VAL) & 0x00ff0000) >> 16)
>  #define BTF_INT_BITS(VAL)      ((VAL)  & 0x000000ff)
>
>  /* Attributes stored in the BTF_INT_ENCODING */
> --
> 2.21.0
>
