Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C353D67F7
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhGZTgD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 15:36:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3CC061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 13:16:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q15so16899815ybu.2
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/Hh0BhXPg+c/FHcyqxLjFQd7yO/ysXyVL2dIDqJLZ0=;
        b=P3fNDzl+PL28tuZVAYkjCX9nR86dWwu9aGaDqgWitTbzhhkIaEDF1qUkaU+QPuySnN
         IRmJPFv4Cp2B6URKXFmDAGtyV8S8981ImE73K9MllhtGOCRKK3X3fmDbETHE3+Y/zq4W
         1cCWrE3wn7rz/YTFLTw2MD66IQfg4hk3hPi85B8iRylEy/uF6NcLttjmMH3/epSxYEKx
         LN4KvmWthoeV437QDgbyUrkF3+hrTC1oaXaFOIE+gVn1Yn6vPk0ExVQxx2zMrEYQP0SY
         DljfSXcNomLtRSB/87w7b4OXp20xFZHkyqvaN9iQYHBd1ujAJKOepcKT/BV7MycUXMTJ
         7zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/Hh0BhXPg+c/FHcyqxLjFQd7yO/ysXyVL2dIDqJLZ0=;
        b=LiYUPDZB4zArgmueqiglC7AOT4wlrkQdCfH/4BFEkdnFD7E8/9KxfDi2sObHkRqwMq
         BnUahI9IYDpuZxqa0lkD53J/MY57w93ctkHG2BvrnvEP6vA0AhfcH17Nkuftu3Ms70CV
         wRat4KbqOHkkPdH32iYD4oqk/+LPglXNCv8vrmCqJxwo/2rRE61q9pgLCe1SxsmUsS0L
         M8iClhmeDihy30v7r5hg49FdysozbxTqHWvvKUWIDd7wh0qswq97G5a7MFslroVEowyC
         3599eJwzRASZg/HzX8q6JF5Nq37dmjFnTfKU00pAmxfYOUV+16Ud1NRhEb2khv7vg1j+
         YIWA==
X-Gm-Message-State: AOAM53357ds7QzDyz9JF+3x++xgrAznhBQ6HeDSd2XNvL4QohGkhv9cZ
        HO2l9dyoNhLHF74D0RdMaFaEjr+MB4xkmzI3TcU=
X-Google-Smtp-Source: ABdhPJyu2JjGO0pLxx4c5AczizVXFzPafoysnW44uN715Hk58CQPcgDcOnoGkFUjEyAmW6P149DjGNbX944xA9Umj7c=
X-Received: by 2002:a25:9942:: with SMTP id n2mr26803371ybo.230.1627330589420;
 Mon, 26 Jul 2021 13:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210725141814.2000828-1-hengqi.chen@gmail.com> <20210725141814.2000828-2-hengqi.chen@gmail.com>
In-Reply-To: <20210725141814.2000828-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Jul 2021 13:16:18 -0700
Message-ID: <CAEf4BzaN50T=4sCDhXKMLNZPXJor6DVtOSoJ10NNxLU8kiOvBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 25, 2021 at 7:18 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Kernel functions referenced by .BTF_ids may changed from global to static
> and get inlined and thus disappears from BTF. This causes kernel build
> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
> Update resolve_btfids to emit warning messages and patch zero id for missing
> symbols instead of aborting kernel build process.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 3ad9301b0f00..3ea19e33250d 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>         sh->sh_addralign = expected;
>
>         if (gelf_update_shdr(scn, sh) == 0) {
> -               printf("FAILED cannot update section header: %s\n",
> +               pr_err("FAILED cannot update section header: %s\n",
>                         elf_errmsg(-1));
>                 return -1;
>         }
> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>
>         elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>         if (!elf) {
> +               close(fd);
>                 pr_err("FAILED cannot create ELF descriptor: %s\n",
>                         elf_errmsg(-1));
>                 return -1;
> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>         err = libbpf_get_error(btf);
>         if (err) {
>                 pr_err("FAILED: load BTF from %s: %s\n",
> -                       obj->path, strerror(-err));
> +                       obj->btf ?: obj->path, strerror(-err));
>                 return -1;
>         }
>
> @@ -555,8 +556,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
>         int i;
>
>         if (!id->id) {
> -               pr_err("FAILED unresolved symbol %s\n", id->name);
> -               return -EINVAL;
> +               pr_err("WARN: unresolved symbol %s\n", id->name);

we should probably give a bit more information for people to get back
to us for this. For starters, maybe prefix the message with
"resolve_btfids:" so that people at least can grep something relevant?

>         }
>
>         for (i = 0; i < id->addr_cnt; i++) {
> @@ -734,8 +734,9 @@ int main(int argc, const char **argv)
>
>         err = 0;
>  out:
> -       if (obj.efile.elf)
> +       if (obj.efile.elf) {
>                 elf_end(obj.efile.elf);
> -       close(obj.efile.fd);
> +               close(obj.efile.fd);
> +       }
>         return err;
>  }
> --
> 2.25.1
