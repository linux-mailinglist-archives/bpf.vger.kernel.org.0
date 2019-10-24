Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7402FE2994
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJXEhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 00:37:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37348 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJXEhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 00:37:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id g50so21763339qtb.4;
        Wed, 23 Oct 2019 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w5oAPp1DvM2wNS0V12iq3yipK2TmGDIqdcysRvkH2bM=;
        b=KpLvTPl3kRSir+JnFcCWCYhjPC8WV5rFXiArMSrwMEQQg+KowOtwHUoQDKejsNmqRG
         a+SiZh9vyufOfOfvDyyP0Ge40yQvoNT77Dd+KBVuu4tNBP3T7Hbbn3uebJPPLu82GHve
         3BIGUr4zuQbg0YOG2Q8Unxx45UFAwuBNt89z5bklX8j97+XjWGJ3k0CnquKJy4IrlVMV
         GkzHx9qP8PY+9TNdAyK4PSWlD1SFmgKINOghqCyollvjR2Nek5ARi4QosgxVAbN+DDad
         S3TtXxv+Bz024HVGeTmFVfVFCR9Ahn1gF/zdTX21pF/tqMOQ5UWoQ8NTANgpTcfF1tpy
         AV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w5oAPp1DvM2wNS0V12iq3yipK2TmGDIqdcysRvkH2bM=;
        b=hejpQYJ6zdjRaXTB7SeQUosQG1+uhJmG/mSzo8tUEny32uV9oFMo6x5R6EaUI54k0h
         czwDQ7mB1TK3TtbCRxrwbJKZRAhSuS+L/BEN9xWK7xW/s+M/56+xr+jbf5A5YB9IQ5G0
         6Jct19fMWnV7mdEH8D3YHMZgPddCnM2rT05djYrV+SlGoRfb6PT9vdlTJVz/5kRSKrBg
         5mCg+wyxlQnJhWftrFH6Ff7EPmRbMR50679yw4wInzYcrtkGA2Ysje9AjGVGmzJOJ/9Z
         qBUP+HbGPT8MHgcnZPsAbn8nj9C/O8qWJ3cVAixx+YB8gSU/BldL030CnDVFJxoRWOL9
         Y/EA==
X-Gm-Message-State: APjAAAXT1mF5dlKjO/QbFM69nEX97M1tfBvkCPEfkiVqSoszJ9J1RBAJ
        pZm/hG8SeFok9XtIUpMueS48ASEP7jsDMNG8EOI=
X-Google-Smtp-Source: APXvYqyE3Z0RsW9ubsZCa01VJ4oMo+i5QDUN7iCOTH/YF27ZOZOjGGuOdGWlCKeycyUDU8b/ugvhgTjikW5SfSNTvsA=
X-Received: by 2002:ac8:108e:: with SMTP id a14mr2190930qtj.171.1571891858102;
 Wed, 23 Oct 2019 21:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191023154038.24075-1-kpsingh@chromium.org>
In-Reply-To: <20191023154038.24075-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Oct 2019 21:37:27 -0700
Message-ID: <CAEf4BzZyqFqrp_S=iA8HHwcdCFSV3PBPK+3S5Wkd3pHK3XCprQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 23, 2019 at 9:06 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> On compiling samples with this change, one gets an error:
>
>  error: =E2=80=98strncat=E2=80=99 specified bound 118 equals destination =
size
>   [-Werror=3Dstringop-truncation]
>
>     strncat(dst, name + section_names[i].len,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> strncat requires the destination to have enough space for the
> terminating null byte.
>
> Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracep=
oint")
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 290684b504b7..dc7d493a7d3d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4693,7 +4693,7 @@ int libbpf_prog_type_by_name(const char *name, enum=
 bpf_prog_type *prog_type,
>                         }
>                         /* prepend "btf_trace_" prefix per kernel convent=
ion */
>                         strncat(dst, name + section_names[i].len,
> -                               sizeof(raw_tp_btf_name) - (dst - raw_tp_b=
tf_name));
> +                               sizeof(raw_tp_btf_name) - sizeof("btf_tra=
ce_"));
>                         ret =3D btf__find_by_name(btf, raw_tp_btf_name);
>                         btf__free(btf);
>                         if (ret <=3D 0) {
> --
> 2.20.1
>
