Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88C53F32BC
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhHTSG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTSG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 14:06:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA438C061575
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 11:06:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k5so22285294lfu.4
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kpdK3tQnsd5kU/S6cdE5TTNsWchQfKmPnLEhEuoCOSw=;
        b=bFdIYjl85UxRyepXF+qWt5RpSgjuLshaALianuSS1+dNYiRsSCpeN9ncBk7nOAnPqM
         bMZ+RJGsTz3VI+uitqqY8sspqhku9zFS3rvC8C0HEQ94s3Rm2ivOnnWGPKHt9qcW0Nte
         MlwQeacxXGMFYnYfINZdZu8dYeYIGXMcHFwZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kpdK3tQnsd5kU/S6cdE5TTNsWchQfKmPnLEhEuoCOSw=;
        b=sTo0fC8qUJrFZUj8lu9Nsbf4K/r0BeUsIyA6RyssoqQhGKw3CyhVvBNqFPD2J7EWwu
         iP2Twxmpo3szFwJpj6v/uqJs1oWaWKxMVYRwkv0eusZnKpw62SvEPOHQZNyvNE2z7jjE
         HRzUdndjEY/HX+vqZt8kTk0AhMkPQPcygfOuaOelVBSnfRDjV4Wp8rg3DuXKnBMcBo/D
         LysQTNoW2jlvvoQYlKfo6xL8/Un151LCqC6ZpM6No+Zf8Z3NqfeB2tLkY1pqi044eGIX
         lxHiN6fQHEKl1xsC6RI1tNhk8ssIp5DkXIgaQINQumyzzKBVyrckjWWCgbAnD4xmhjlq
         YkGg==
X-Gm-Message-State: AOAM530jIEZxB6dlvQbArT325fqH0oH1R/3V08RIB6416iYViuav+p7A
        QvygKs8FZqiyRd/5Qln1/mZG5LRtw/H09lxHn+SXsQ==
X-Google-Smtp-Source: ABdhPJyDvw/lD+z2kmSTqPAlkIyBYwbU08Q/RU9cGlUTWre3D154WzXg2hJq2G29Cv1+Z20vZK1V7PTOSjALTtZizxk=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr15164118lfn.578.1629482775755;
 Fri, 20 Aug 2021 11:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210820165511.72890-1-mauricio@kinvolk.io>
In-Reply-To: <20210820165511.72890-1-mauricio@kinvolk.io>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 20 Aug 2021 13:06:04 -0500
Message-ID: <CAHap4zvz5JW2paVnkYERq=L98pDBBk2mfkJrQ=pHAU3cfqMkAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: remove unused variable
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauriciov@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 20, 2021 at 11:55 AM Mauricio V=C3=A1squez <mauricio@kinvolk.io=
> wrote:
>
> From: Mauricio V=C3=A1squez <mauriciov@microsoft.com>
>
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algor=
ithm")
>
> Signed-off-by: Mauricio V=C3=A1squez <mauriciov@microsoft.com>
> ---
>  tools/lib/bpf/relo_core.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git tools/lib/bpf/relo_core.c tools/lib/bpf/relo_core.c
> index 4016ed492d0c..52d8125b7cbe 100644
> --- tools/lib/bpf/relo_core.c
> +++ tools/lib/bpf/relo_core.c
> @@ -417,13 +417,6 @@ static int bpf_core_match_member(const struct btf *l=
ocal_btf,
>                                 return found;
>                 } else if (strcmp(local_name, targ_name) =3D=3D 0) {
>                         /* matching named field */
> -                       struct bpf_core_accessor *targ_acc;
> -
> -                       targ_acc =3D &spec->spec[spec->len++];
> -                       targ_acc->type_id =3D targ_id;
> -                       targ_acc->idx =3D i;
> -                       targ_acc->name =3D targ_name;
> -
>                         *next_targ_id =3D m->type;
>                         found =3D bpf_core_fields_are_compat(local_btf,
>                                                            local_member->=
type,
> --
> 2.25.1
>

Forget that, it's used indeed. Sorry for the noise.
