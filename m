Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA4325A08
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBYXF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 18:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBYXF1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 18:05:27 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF211C061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:04:46 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id c131so7086281ybf.7
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIr/u6vRce5aqjtgKKKYMrQP5BHXoq3l+i6eRrvdIRU=;
        b=UnWl5KVw3ra2GbeOS+tC+BBsE6jntaS/26djyVzkI9/6ceoxCeSKDTZbH/Rn4oG4M5
         X/+XxfllVUEAw4sQV3HnYOKh/aDXqlPigPK9gg67slZktBjSXdL24g0kcoyWrmLF1eTQ
         ZQfgZMJyJ0coGJwc+qFV4J4JWQdurSncKlNHw+spVyOEHtbuSMkool0OonmV9JQxzQ0N
         EwzkpmGaCWc9kuTk3deDq6zJJ/thTtb9kJjqr0wkAoCfIAB5VjTNg/kGcQFIKQnVs5LU
         gpO7BKK1e/CQo2ZEsuD5wPoVzD6aoETZK5ro/bXrcUnClXueutYUYlvEFrlwuVriwvWs
         D4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIr/u6vRce5aqjtgKKKYMrQP5BHXoq3l+i6eRrvdIRU=;
        b=fRyx8NrKoyuEzICRf+jWKkASHQhG2Rl6IEFgXyFoNSFvtG84W83ySijt6TbTToaTOy
         75uSimpz4xAU2BG7/pUBll18D2mGMI/WnxbjTTZP8xUehT8lP1hpZpGOfXFORgJML/Oi
         Vd6PwBmeU+Trd/wcOFeR2xqcWBQvTcbh0H7YnJUkTUIH5jQNAmYHTaiUiRz81OPfOEHj
         L8mHfEiVglM/VdYHLcqK4xyPhpXbeFSUMffEQsUMAErXcZuvD11ZVuufQDPM4W9RWbYA
         VQFvKaC/EoCrp0Zz/ykB3kZS7cd67Jm61jvJFaHt5YKIbl8Mv3j2worAIKwiEoHs6iHQ
         yGGA==
X-Gm-Message-State: AOAM533ZyBP9WS6cp4R6D3Q8nUxd9FB8/N2XKu7d9PiswYthvRUloJjJ
        ES87VLx2g3r4U04DRYnzjCKxG/rs1u/Lrcq841OG42EMsL4=
X-Google-Smtp-Source: ABdhPJylx3CBZciCWe7FURZ1sbcbf8eJ8oIVvdZuAY5eMUx9cAQm7hb9Fl77gV73Ilq2Io14HGtZAf8Hwa0L6S7WlYY=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr271974yba.347.1614294286279;
 Thu, 25 Feb 2021 15:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073318.4121448-1-yhs@fb.com>
In-Reply-To: <20210225073318.4121448-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 15:04:35 -0800
Message-ID: <CAEf4BzYY2AkkRG6x5DW3s-kk_t7hUQfGBJrWDU=TtqJR+PY1SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/11] libbpf: support subprog address relocation
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> A new relocation RELO_SUBPROG_ADDR is added to capture
> subprog addresses loaded with ld_imm64 insns. Such ld_imm64
> insns are marked with BPF_PSEUDO_FUNC and will be passed to
> kernel. For bpf_for_each_map_elem() case, kernel will
> check that the to-be-used subprog address must be a static
> function and replace it with proper actual jited func address.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 64 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 3 deletions(-)
>

LGTM. I'll still need to relax it a bit more for static functions, but
it can come as part of static linker work.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
> +static bool sym_is_subprog(const GElf_Sym *sym, int text_shndx)
> +{
> +       int bind = GELF_ST_BIND(sym->st_info);
> +       int type = GELF_ST_TYPE(sym->st_info);
> +
> +       /* in .text section */
> +       if (sym->st_shndx != text_shndx)
> +               return false;
> +
> +       /* local function */
> +       if (bind == STB_LOCAL && type == STT_SECTION)
> +               return true;
> +
> +       /* global function */
> +       return bind == STB_GLOBAL && type == STT_FUNC;

theoretically STT_FUNC could be STB_LOCAL here, though Clang doesn't
emit it that way today. It will be easy to fix later, though. Just
mentioning, because I intend to have STB_LOCAL + STT_FUNC relocations
with BPF static linker.

> +}
> +
>  static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
>  {
>         const struct btf_type *t;

[...]
