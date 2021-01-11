Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3622F1E6E
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbhAKTBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhAKTBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:01:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D82C061786
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:00:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d17so1136107ejy.9
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAQtzSxGA3+ZigKcaBoyf+oVRyAJV6LvZeoMkFVxqCo=;
        b=ADxSEU2Xcs7JJQ7HYsB23h3NP6nhLjLwH5UPPSxABsaoHdE/LVWZF+cSickls4ki5I
         kxE+Kbg42jdxc845ALuahXAteS24KN+GJN0VwpF3oLFAUdrcK9ZOKr4dmtzhQcgTs7tj
         TXOMfhebzWE1PbsUZINxhW5NePEMVBGYPmQhPWAahb+xfmeJaA6nMccl+kI9FemrjGQA
         pfD1jOkLdRwBjaEQnHhU4laTI84irMJw2WeKIPptHge5Qo3B+u+zhliUM0tNdIcQwEqm
         mU3kkSCmjpZxtQS3QgoHE/brKhgB4Ernuz7efZbYNohSlDuGVxXOqHmZBK0YkBuYZ5l4
         1Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAQtzSxGA3+ZigKcaBoyf+oVRyAJV6LvZeoMkFVxqCo=;
        b=YQkvJkA3rcLUlUUVp4ot2hiVdQSg41fSAbGky3qIkTI4MXiOf1rzom9+XKcRtVBJeK
         G68w6z95Ou+FwCSP3MHk/I6UiyuRt36ukGsHGw2QsWzYiE5q9KB/sloP4krhs7bsy/cQ
         kt/0VMQs36O6E6dv8CyuhFAiySnc/9lVbctjNz60yJpSFjN4fKJag7Xe1gL4iBEG6I3q
         w5MUmtnDCfTL/I491XBY52rJDSDCQljm9W1GanYU4wRaRV/j5PfV5Rae0yPaP3T8SNul
         Gpy2ecee5dH9SfN20ipmk3e59M1UwEh/3Bcya8s1ODX3Ix8dVTI/kvuxVEYuZ7eDJlc+
         dDLw==
X-Gm-Message-State: AOAM5312KK7jwr+WwZ602yrRgwzNTCDSTlXvsdJf1KN30jnwu/qLaarw
        naQe/JQiruKtirvFTIiHpE9a5b5jOPJ8V9Lg7x+kQw==
X-Google-Smtp-Source: ABdhPJxhQG5TtXErzAksyOUEhDTT+CD5yPBqo+gUtvm3FIrn5yRPBTHtRuPLP/1K5hall3gLZPgS1P+qdLG/+FanLIA=
X-Received: by 2002:a17:906:eb49:: with SMTP id mc9mr565992ejb.487.1610391651162;
 Mon, 11 Jan 2021 11:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20210108220930.482456-1-andrii@kernel.org> <20210108220930.482456-7-andrii@kernel.org>
In-Reply-To: <20210108220930.482456-7-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jan 2021 11:00:39 -0800
Message-ID: <CA+khW7jWiTRe36Uc5zKzk_bHmC+R_QZ43EBRo0gmPGhZHiOrqA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/7] libbpf: support kernel module ksym externs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Hao Luo <haoluo@google.com>, with a couple of nits.

On Fri, Jan 8, 2021 at 2:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add support for searching for ksym externs not just in vmlinux BTF, but across
> all module BTFs, similarly to how it's done for CO-RE relocations. Kernels
> that expose module BTFs through sysfs are assumed to support new ldimm64
> instruction extension with BTF FD provided in insn[1].imm field, so no extra
> feature detection is performed.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6ae748f6ea11..57559a71e4de 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[...]
> @@ -7319,7 +7321,8 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
>  {
>         struct extern_desc *ext;
> -       int i, id;
> +       struct btf *btf;
> +       int i, j, id, btf_fd, err;
>
>         for (i = 0; i < obj->nr_extern; i++) {
>                 const struct btf_type *targ_var, *targ_type;
> @@ -7331,8 +7334,22 @@ static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
>                 if (ext->type != EXT_KSYM || !ext->ksym.type_id)
>                         continue;
>
> -               id = btf__find_by_name_kind(obj->btf_vmlinux, ext->name,
> -                                           BTF_KIND_VAR);
> +               btf = obj->btf_vmlinux;
> +               btf_fd = 0;
> +               id = btf__find_by_name_kind(btf, ext->name, BTF_KIND_VAR);

Is "if (id <= 0)" better? Just in case, more error code is introduced in future.

> +               if (id == -ENOENT) {
> +                       err = load_module_btfs(obj);
> +                       if (err)
> +                               return err;
> +
> +                       for (j = 0; j < obj->btf_module_cnt; j++) {
> +                               btf = obj->btf_modules[j].btf;
> +                               btf_fd = obj->btf_modules[j].fd;
> +                               id = btf__find_by_name_kind(btf, ext->name, BTF_KIND_VAR);
> +                               if (id != -ENOENT)
> +                                       break;
> +                       }
> +               }
>                 if (id <= 0) {

Nit: the warning message isn't accurate any more, right? We also
searched kernel modules' BTF.

>                         pr_warn("extern (ksym) '%s': failed to find BTF ID in vmlinux BTF.\n",
>                                 ext->name);
> @@ -7343,24 +7360,19 @@ static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
[...]

> --
> 2.24.1
>
