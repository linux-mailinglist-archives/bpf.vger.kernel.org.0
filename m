Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C518943A92D
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 02:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhJZAXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhJZAXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 20:23:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33EC061745;
        Mon, 25 Oct 2021 17:21:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o12so26294930ybk.1;
        Mon, 25 Oct 2021 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xAX9J7s8Ak1x97cx5ASfC7vUeon7RIMGp5IVKda4uQ=;
        b=MFpghTTP7kDYJZyCns0R6MD5/remfDE3UI/a20vAzkeUNqXxL9x7owWELqYj5RqYWb
         x2b9ph77ecKGpBcUDBV3WPVeyj/DFL1iTTusYtFYboeF24kwL3zLCYJB+Ha7CwZCDpD4
         BsWDWraN16s9cRtg5zppEmsbZIPouNh58fnRdNcklKXDERXnvle3yqFcpNfBWUfDljCE
         1zYjPVuKOxXgRNc4xoh0UGCYfG99TrQsnfkLl/qM6hyB5cVEf2Dnx3ZwqD1ouK9WhaFZ
         MsNBoJZxst6RP4PEEfT6AVhoVI/VXFEBK+JJBu578x75fffKZGZO51a7BcIelmSYmY1E
         bDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xAX9J7s8Ak1x97cx5ASfC7vUeon7RIMGp5IVKda4uQ=;
        b=R4JlgkJh2SmvVZlFnmCBMHoe0kbn3pATmTa42b6uwuULSOIou0rKLwlJbxdXi5gdOJ
         X3E1r7IF973eqyKPokT6nV41eNcUglWnXPHb44QySg4gqmaxMi2AHJKGjpFM3iKAggMK
         CO5u7ZpRlV9PwuOkDbpKJoCT4MpZSmdkAOcDi2fC0bWmdjrmykCvEr7FlU9Hwqr9hEmq
         6i0PLrWB4nksozmN1qlyEYxstAvqtyRyTyindxj7ZuuovjEru1QgKydWfM9JH0j0jjEJ
         AlRJzxGpYCUBydgbUyXUK6PPg2M0EKX8qy3gmrUPmzscHM1ncYjFFZYgmQJJfgpMpYAR
         bGBA==
X-Gm-Message-State: AOAM533OTFIXf4U5vwwZg79jmOIDEDffDs+Ct4iiyg9PQR4sAoqdlrk2
        SHgQB9yG/zw+ulujAqI6+uzQyk1wECf6jFtXiXM=
X-Google-Smtp-Source: ABdhPJyRrYXR7B21pA/VtiD/arEEJsCU9lCMCbjFsJnCv1KeE+TKGHCs8Nrs9JAEpLL2t8QLto5WeyEhVwHz9eU+cBE=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr19830619ybj.433.1635207660956;
 Mon, 25 Oct 2021 17:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211025230220.3250968-1-yhs@fb.com>
In-Reply-To: <20211025230220.3250968-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 17:20:49 -0700
Message-ID: <CAEf4BzZ9povWyXYnx0_ud8chXobB3_wga+cWoi0gX8EoLO=gLA@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf: rename btf_tag to btf_decl_tag
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 4:02 PM Yonghong Song <yhs@fb.com> wrote:
>
> Kernel commit ([1]) renamed btf_tag to btf_decl_tag
> for uapi btf.h and libbpf api's. The reason is a new
> clang attribute, btf_type_tag, is introduced ([2]).
> Renaming btf_tag to btf_decl_tag makes it easier to
> distinghish from btf_type_tag.
>
> I also pulled in latest libbpf repo since it
> contains renamed libbpf api function btf__add_decl_tag().
>
>   [1] https://lore.kernel.org/bpf/20211012164838.3345699-1-yhs@fb.com/
>   [2] https://reviews.llvm.org/D111199
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c  | 16 ++++++++--------
>  dwarf_loader.c |  6 +++---
>  dwarves.h      |  2 +-
>  lib/bpf        |  2 +-
>  pahole.c       | 12 ++++++------
>  5 files changed, 19 insertions(+), 19 deletions(-)
>

[...]
