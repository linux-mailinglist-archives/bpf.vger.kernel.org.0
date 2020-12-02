Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0332CB268
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLBBjJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 20:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLBBjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:39:09 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080EC0613D4;
        Tue,  1 Dec 2020 17:38:29 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s8so125713yba.13;
        Tue, 01 Dec 2020 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0tPoBlU4NKyR6gcj3vy9nGS+9uhhqNqZLS5gO66TK0=;
        b=W8z9s7y0Ua26sqELm+h84HFNCk1fsBqzDiglnalhsMtYstzFt55bJ17IxbHXTX7+Kq
         B9q9NLbVB8WRAd9f4Go49EwJBs6YUyHtjWhZUXrwODxAUOUqAMr1MEmI5GeSgyxKqiVZ
         d1uqSQJIVifxysC3KEKM9MavXJOK0y2xFuJ1TLkWGDhaBervLJZATW3vhcNcV/idtCYO
         TEf4v7GKcP25LVw8K3eO4Z9nKkc1K+5m1rsSZMmBNKfjPlADDwe1bxmur9yvATVQjE1Q
         tjhn49s7nC/obLXny/wfi5uYC8jh1ZFp/FcoL/bxMd7wVDzDQCpBtu8HJIC6PDjWvEk0
         QQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0tPoBlU4NKyR6gcj3vy9nGS+9uhhqNqZLS5gO66TK0=;
        b=GrhxSptPhvlmQ96XWGl953v0d+dZxbVohT/918QMArQvYmimpAmCn+5Hdf50sihZdP
         gIQRRB1Bn/hyW3IRxdNBfiyDTI2ZGz9ghbl4OYQ9r+eQ3fMompReq83EJMUIC9r6vUm5
         puz4TB5nppGw0mHn4Nq9GqpNNtDO9BSNsJHXo3HneRfKCR8b1wPUODQXEKHcy/yZuXBd
         //m7O0ne2H23+VACBpixdGLghhwA/gAuWnmuzfYv45DqfU/0WPNpEvzaJCTFeIjOcHqu
         CLJZ34qNwRZb/D51qK9Sc+9Zc2HocHAh1J/GE+o5mPcUTcdMw8FJmPQSLmgfInT2/qUF
         3t7A==
X-Gm-Message-State: AOAM533fgCKJsALvKihtaXLKEynFhosDLJct7qjTWzdm3/EhzrbZ/Je1
        C5RNGOQs7g7JUZkx6dtCn4JkLO86k0fYe73C//M=
X-Google-Smtp-Source: ABdhPJzeFyn2AWeUIV6sKJUOxmAyHPcJ6Fed2FalTuZWQdaMu2TmwUpAeG1hc+OQuNGV+0ySqbJ9QvjUlAfqBNY7IcI=
X-Received: by 2002:a25:585:: with SMTP id 127mr240609ybf.425.1606873108487;
 Tue, 01 Dec 2020 17:38:28 -0800 (PST)
MIME-Version: 1.0
References: <HKAPR02MB429180E153A7547C20F17915E0F40@HKAPR02MB4291.apcprd02.prod.outlook.com>
In-Reply-To: <HKAPR02MB429180E153A7547C20F17915E0F40@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 17:38:17 -0800
Message-ID: <CAEf4BzY1Q7XZVMheN-e78HCO=M74frFM1d6h56-ChTNrDhNMUw@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf: Return the appropriate error value
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 7:06 PM =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@o=
ppo.com> wrote:
>
> Compile times error:
> "Error: failed to load BTF from /mnt/linux/vmlinux: No such file or direc=
tory".
> This file "/mnt/linux/vmlinux" actually exists, but only because CONFIG_D=
EBUG_INFO_BTF
> is not configured with this error.
>
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 231b07203e3d..228f508fbd04 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -865,7 +865,7 @@ struct btf *btf__parse_elf(const char *path, struct b=
tf_ext **btf_ext)
>         err =3D 0;
>
>         if (!btf_data) {
> -               err =3D -ENOENT;
> +               err =3D -EPROTO;

ENOENT as related to "no .BTF section found"... EPROTO would make
sense as well, but I don't think we need to really change anything.
"Protocol error" isn't very meaningful either...


>                 goto done;
>         }
>         btf =3D btf__new(btf_data->d_buf, btf_data->d_size);
> --
> 2.18.4
