Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F346297B
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhK3BPK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhK3BPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:15:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60FC061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:11:51 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f186so47536590ybg.2
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cejAYbikLiA1GZawgVys1/WciOjzzQ31wJ9Tr56ruws=;
        b=mCRqNvTfINyJvFPylWjv4oDgv+acqHpSPBElMKVjNQnmbL9gSQ9kLHKBJj6Pv0IicE
         al0lGxTe5W5MyhyDb0qekzoVwfwHJ3X57kqTF5sEGM9rpIe4ZRqRxvkyRmfp9xI3UOFX
         wmB8Mt1UdLyCj7Nt5wUE4WZ+oMKwjqwWOgSrV8d0eRLY+dN4Z8JkJ1lEgrpY70J4Vdwr
         4SDA82Lze8T8hmz3KVoThYDOcKJeA+FNOiX1/eFtKuw8xSn+lRxwZNDzEpNYCG9Uqx7C
         AtipF1uGQWaiFlloNznM+y9R12EPY6MhlAoKj2nyBNa73DPUakiTZRKt55cy36axcyAA
         gWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cejAYbikLiA1GZawgVys1/WciOjzzQ31wJ9Tr56ruws=;
        b=SaAg6YIMeMa9lXYvXbgYG5DFhDM9PlZe6Ktwoo0MXKdClGTWPwoyAnYYdw3fUQlbVQ
         26pHakz+Nmm31QZcBxv44/Eo7ujDeb+Y8Y8WUot/Or3SIcUiscz37wWnIVrhN/J1cyKG
         L94wKiq7tiNP2GQHTTFKpUKPE8t20tHk0hX5zC70A39zDQaRS+LrdE89QCohnjSp1UDC
         NB1QMi+Fik87YVZXBSMjiwPfpdUYEKmIggXDrHeGQ/2J/O5BIETEZTP8B+DneAsckeGs
         zSUsv/n0lLOoNLpKZvaEO+bekBv1W5hPO5KjSUrMMZ1u5TgoZbh2Kydb0rMNLYTU4+8h
         pdqw==
X-Gm-Message-State: AOAM5303OnakQckXD8uBT1lnKg5X6vU+0rQl5lRFs8LO5H114HDnhzLf
        QySmGbzIhRhOfmGUOyI9ksr+8uqykU1abSZa8E8nxI+BP9KNgg==
X-Google-Smtp-Source: ABdhPJyhULKn0mhQ24IUBuzBbi4XaoYHM7ouVLxCTou0Ac1Whj6okgsCzSw7Q58og5QIXIsjV3IxF2YY+yGj9FOg4PY=
X-Received: by 2002:a25:6d4:: with SMTP id 203mr37312176ybg.83.1638234710587;
 Mon, 29 Nov 2021 17:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com> <20211124060209.493-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20211124060209.493-11-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 17:11:39 -0800
Message-ID: <CAEf4Bza0-MfcvSYtxOAjJcwo2qjM_TfBY7Zag-YimsxkxoFUMw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 10/16] libbpf: Clean gen_loader's attach kind.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The gen_loader has to clear attach_kind otherwise the programs
> without attach_btf_id will fail load if they follow programs
> with attach_btf_id.
>
> Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/gen_loader.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9066d1ae3461..3e9cc2312f0a 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1015,9 +1015,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>         debug_ret(gen, "prog_load %s insn_cnt %d", attr.prog_name, attr.insn_cnt);
>         /* successful or not, close btf module FDs used in extern ksyms and attach_btf_obj_fd */
>         cleanup_relos(gen, insns_off);
> -       if (gen->attach_kind)
> +       if (gen->attach_kind) {
>                 emit_sys_close_blob(gen,
>                                     attr_field(prog_load_attr, attach_btf_obj_fd));
> +               gen->attach_kind = 0;
> +       }
>         emit_check_err(gen);
>         /* remember prog_fd in the stack, if successful */
>         emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
> --
> 2.30.2
>
