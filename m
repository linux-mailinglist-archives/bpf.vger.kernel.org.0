Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48FC3226C9
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 09:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBWIEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 03:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhBWIEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 03:04:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34424C061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:03:29 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u75so15597061ybi.10
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLvgxTOz11Q1L8rio7pvMAcHIG/tZWTd56CFaClS1S0=;
        b=kz2fqEGyRLoh9k4f7n5//XNeFFWMwPXHeDzW5bT80WWZA2cHMI67Ux/UI1JD72NLTw
         xzAlIB8chCKhHLGFpECGQJwweDtfXZIsgPABQGyaloxmOemTfs8SB0OLiTFqxy2x2uhe
         29gRTt7PSpf+OlDGu9zgpnl4OHGTEHi2i/2IT8cr1usnJlCUzOsc/eKRK4iUGZSxMcGY
         ITr+baJDLLt6dYnBiZo6pfXB6vYaUsLZn3+9SEQ2j4FHORAlf9EDg8Fmd0CVNtRvsaHv
         qMaG8KtXvF51EkFNEfEAgInDnlwbjIsBhfkPLPx/fQXXoGa2oXsbwUUhijcIMlwi+uyr
         0j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLvgxTOz11Q1L8rio7pvMAcHIG/tZWTd56CFaClS1S0=;
        b=LRBURZgqBr5uh4hpTipMqTDZOhj+1RO3TDvauss9myYFd73elVE0hXrk18aO/vpWqL
         wqobBFWBRWXSCQhvVc5NuDSWb9NPmWcLzcF2G9oJoNtYgRU1K1yXhaeQT0scgt2Kss5t
         Bt/m5Fm5UOg3deTUqvbT9hJ2X7vcJk17zw2LmIa1zZ/5EsQaS73QjbFeFDtXbTrvyAOf
         +19DpEvxtxqZzFyhVCFO/Dbpp2c5k/FVZ61xkMGTplpVBTi0up9XyP2aoHK5btHjESld
         EECHji9Q46nHimgxdr3JRHdP/xVwAJZlS82DT7sL/qUXgW1AzHsuJacF/RxWUYvBuamC
         WLKg==
X-Gm-Message-State: AOAM533Hx+g7OKxlm21bulHJn5zK7fwpghbOfD78Kciq5AsdZaXE7TfN
        uDtdxdPGyXwO29wyNpkBv6SmyX4gINOLmP9XUM4=
X-Google-Smtp-Source: ABdhPJwVIZaRo63SHx7lV45LD8tBr7R7RrMftYMJ7yidF6CBSu97jbKXNxcEhm6zMdG3b96wgLF14BauOvA6w59KyoE=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr39750737yba.347.1614067408273;
 Tue, 23 Feb 2021 00:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20210217181803.3189437-1-yhs@fb.com> <20210217181812.3191397-1-yhs@fb.com>
In-Reply-To: <20210217181812.3191397-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 00:03:17 -0800
Message-ID: <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: support local function pointer relocation
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>
> A new relocation RELO_SUBPROG_ADDR is added to capture
> local (static) function pointers loaded with ld_imm64
> insns. Such ld_imm64 insns are marked with
> BPF_PSEUDO_FUNC and will be passed to kernel so
> kernel can replace them with proper actual jited
> func addresses.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 21a3eedf070d..772c7455f1a2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -188,6 +188,7 @@ enum reloc_type {
>         RELO_CALL,
>         RELO_DATA,
>         RELO_EXTERN,
> +       RELO_SUBPROG_ADDR,
>  };
>
>  struct reloc_desc {
> @@ -579,6 +580,11 @@ static bool is_ldimm64(struct bpf_insn *insn)
>         return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
>  }
>
> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
> +{
> +       return is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
> +}
> +
>  static int
>  bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>                       const char *name, size_t sec_idx, const char *sec_name,
> @@ -3406,6 +3412,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>                 return -LIBBPF_ERRNO__RELOC;
>         }
>
> +       if (GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&

STB_LOCAL + STT_SECTION is a section symbol. But STT_FUNC symbol could
be referenced as well, no? So this is too strict.

> +           (!shdr_idx || shdr_idx == obj->efile.text_shndx) &&

this doesn't look right, shdr_idx == 0 is a bad condition and should
be rejected, not accepted.

> +           !(sym->st_value % BPF_INSN_SZ)) {
> +               reloc_desc->type = RELO_SUBPROG_ADDR;
> +               reloc_desc->insn_idx = insn_idx;
> +               reloc_desc->sym_off = sym->st_value;
> +               return 0;
> +       }
> +

So see code right after sym_is_extern(sym) check. It checks for valid
shrd_idx, which is good and would be good to use that. After that we
can assume shdr_idx is valid and we can make a simple
obj->efile.text_shndx check then and use that as a signal that this is
SUBPROG_ADDR relocation (instead of deducing that from STT_SECTION).

And !(sym->st_value % BPF_INSN_SZ) should be reported as an error, not
silently skipped. Again, just how BPF_JMP | BPF_CALL does it. That way
it's more user-friendly, if something goes wrong. So it will look like
this:

if (shdr_idx == obj->efile.text_shndx) {
    /* check sym->st_value, pr_warn(), return error */

    reloc_desc->type = RELO_SUBPROG_ADDR;
    ...
    return 0;
}

>         if (sym_is_extern(sym)) {
>                 int sym_idx = GELF_R_SYM(rel->r_info);
>                 int i, n = obj->nr_extern;
> @@ -6172,6 +6188,10 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>                         }
>                         relo->processed = true;
>                         break;
> +               case RELO_SUBPROG_ADDR:
> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;

BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
already? If not, why not?

> +                       /* will be handled as a follow up pass */
> +                       break;
>                 case RELO_CALL:
>                         /* will be handled as a follow up pass */
>                         break;
> @@ -6358,11 +6378,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>
>         for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
>                 insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
> -               if (!insn_is_subprog_call(insn))
> +               if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
>                         continue;
>
>                 relo = find_prog_insn_relo(prog, insn_idx);
> -               if (relo && relo->type != RELO_CALL) {
> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
>                         pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
>                                 prog->name, insn_idx, relo->type);
>                         return -LIBBPF_ERRNO__RELOC;
> @@ -6374,8 +6394,22 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>                          * call always has imm = -1, but for static functions
>                          * relocation is against STT_SECTION and insn->imm
>                          * points to a start of a static function
> +                        *
> +                        * for local func relocation, the imm field encodes
> +                        * the byte offset in the corresponding section.
> +                        */
> +                       if (relo->type == RELO_CALL)
> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> +                       else
> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm / BPF_INSN_SZ + 1;
> +               } else if (insn_is_pseudo_func(insn)) {
> +                       /*
> +                        * RELO_SUBPROG_ADDR relo is always emitted even if both
> +                        * functions are in the same section, so it shouldn't reach here.
>                          */
> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> +                       pr_warn("prog '%s': missing relo for insn #%zu, type %d\n",

nit: "missing subprog addr relo" to make it clearer?

> +                               prog->name, insn_idx, relo->type);
> +                       return -LIBBPF_ERRNO__RELOC;
>                 } else {
>                         /* if subprogram call is to a static function within
>                          * the same ELF section, there won't be any relocation
> --
> 2.24.1
>
