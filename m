Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B484044F7
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbhIIF3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhIIF3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:29:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D22C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:28:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v10so1523152ybm.5
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URX1TjkpKQTY1xyDoogmgzOK3y88nc/qcMSLf9kxMhs=;
        b=f7rmIAX0TczVItidEKHLqVuiXo1ryKnqM6G9vWC7CFGZ+BfYHz9Auqr27yWSvoSeob
         axaEF3glLRiWOYtkdJujB8IQ+yYY6scu2lZZKEgvJMdUkO9XjvEUsPk/evhgCp54aCL/
         LExlg/gQgCODeeRQtSc5Dcvcv+tz3KURzgPhzumh3mr2KnajYCelzNtSDcUSF2lu6LTj
         il0CqPeedCxVqkF9UkSDH2P9TsQvDrO+ymoccUHeTmF8+rFF8K9xrXAhetOxxwMWFr4l
         lCePjItWKctmN9F1BwuOJlb5BXomIIi63RMDSA549tO6JJaK8EzPpUv9ZteJR6DpM2Jo
         kh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URX1TjkpKQTY1xyDoogmgzOK3y88nc/qcMSLf9kxMhs=;
        b=AMmtmlG2ufWP5DEX+BrOGSfWBPoILHsIX1yYol+PkjaP1ESBIbMUvDjgSmfCfwtyGr
         9TmyGW5WyvAzM5qrv+Kd/vmlgNve0vpqHAYaCyYj2G+PjYDX71gF+zmoB/E2QRakh/pG
         nHGAv1Gm9iMoPoRWS5F6YM9WtOexZhQrWWKU1frlH867edbSfCW/zaf+fkpoTFm0qbeH
         7dDlvYJHzv9LBcFoyYtWNn+GLjlb9dGjkxLLu1IoHDszFpvauVBMz91G8wyar6eU3GbK
         Z85r9us8dTl9jj6xMFYq/ujA3Kammjox+K+X4SIdpBxdqsfwevMOIIjMv3lxhjJh/dHH
         kgmQ==
X-Gm-Message-State: AOAM532Wws+bOrqSTP5xvl8rOoBCQJDHGBRiyv882WWGY07EeCBa1eRS
        aEvehtMgFl0QoKubRpmN3CpOGSM7QvSeRke/m24=
X-Google-Smtp-Source: ABdhPJyE9SOr4VhfQo4JvQjxJF6Kx7ePl2Q7THB4CDCbPmti4hOupdKpUgHJwvWMUM2gLBRezUnQS/l+rrW+rkucAS4=
X-Received: by 2002:a5b:702:: with SMTP id g2mr1498395ybq.307.1631165307238;
 Wed, 08 Sep 2021 22:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230111.1959279-1-yhs@fb.com>
In-Reply-To: <20210907230111.1959279-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:28:16 -0700
Message-ID: <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> added bpftool support to dump BTF_KIND_TAG information.
> The new bpftool will be used in later patches to dump
> btf in the test bpf program object file.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index f7e5ff3586c9..89c17ea62d8e 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +       [BTF_KIND_TAG]          = "TAG",
>  };
>
>  struct btf_attach_table {
> @@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>                         printf(" size=%u", t->size);
>                 break;
>         }
> +       case BTF_KIND_TAG: {
> +               const struct btf_tag *tag = (const void *)(t + 1);
> +
> +

extra empty line?

> +               if (json_output) {
> +                       jsonw_uint_field(w, "type_id", t->type);
> +                       if (btf_kflag(t))
> +                               jsonw_int_field(w, "comp_id", -1);
> +                       else
> +                               jsonw_uint_field(w, "comp_id", tag->comp_id);
> +               } else if (btf_kflag(t)) {
> +                       printf(" type_id=%u, comp_id=-1", t->type);
> +               } else {
> +                       printf(" type_id=%u, comp_id=%u", t->type, tag->comp_id);
> +               }

here not using kflag would be more natural as well ;)

> +               break;
> +       }
>         default:
>                 break;
>         }
> --
> 2.30.2
>
