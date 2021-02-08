Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC36313E1E
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhBHSxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbhBHSxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:53:19 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B78C06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:52:38 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d184so4304072ybf.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJnHHMRASF1YQS9u5aJd+V/Xzf6kX/XViL3Uh6tdWzg=;
        b=jY/EeklBTBa49b3+uHTxibekSpt7YoUfE/qX9P9RY3gLYM9rjPrLxgQkCSLhn+4SU+
         loKGlhrH45/D0aJDWq2Jvb+UqSbP36MWMEp8p34Sdi/7sKJfofa/XChKeI/AFrSiHYXp
         /fDwRu0E0fKDSDdlRyDUbwiKaKPICAL4p3R6gpfVDfc8oPYXvZ6wj/QBsV7kNsqglUaU
         y+LKCCU7nAzStNwpwLCLTqIknxEmhg2WWd9bTNyaFblH9ib2F3QJGSWuwaLD0mBG05d0
         wbVBpka588mbQWZZy8pb+h9N4SrVC7hQSDUSLOzLfCQaM53YnQmclhwF21wCg77lK8QL
         bOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJnHHMRASF1YQS9u5aJd+V/Xzf6kX/XViL3Uh6tdWzg=;
        b=odwPlYc746KK0jEp2Wl90SyRrOCVZr0dMgTfp4W0ZzxMV+jh/+jeJScdFmfJUeE+SE
         VlqVRT24259Z6UCQsIg1Kb0Cfvw7tlKFbFdqc73NVi9mVO3Fi1gCLvhBRbjeMut8+6Ly
         osSyuNV6bgbFnJ96QL4Xz3GVyPDC5VlELEy1G2wGoKgH1+jl/wE7p/MtDV6JfqR4sMoT
         bLfycd7iKlQhFnxSazMjHJo1PM6mcuEtJrdsQxeBEKlUMmfGi9LEkPWaaZ/FlMh/2nMN
         UNRRAkQbUyrw4R0qFUXuvCDbjwxC7TWDJWrhErkc8YUUgID2b+jLT4MePF16+Ux0uoHJ
         K6MA==
X-Gm-Message-State: AOAM533X7lg0GFeu/+B2NNLPe1G6Drz6DMtxCW+Pwv1u0AG1cZNB41UV
        +zS2Nsg9Fm+Ggohy8LDlwKRUfIAEPtHmtj3VzgrCzKVqXkQ=
X-Google-Smtp-Source: ABdhPJy7HXTRqdoogE3a44E8IvyCC8lCzHPwM0SwkvaW4FTY8NgIcMmIldCMUoCeQJ5XJhoh8z5yutx6i+TfX78TCSc=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr27591862ybd.230.1612810358029;
 Mon, 08 Feb 2021 10:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234832.1629393-1-yhs@fb.com>
In-Reply-To: <20210204234832.1629393-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:52:27 -0800
Message-ID: <CAEf4Bzai4qFDrVidGncaRMABiz2vNTRyWBftLm1Z_LTNNtfmHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] libbpf: support local function pointer relocation
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 5:54 PM Yonghong Song <yhs@fb.com> wrote:
>
> A new relocation RELO_LOCAL_FUNC is added to capture
> local (static) function pointers loaded with ld_imm64
> insns. Such ld_imm64 insns are marked with
> BPF_PSEUDO_FUNC and will be passed to kernel so
> kernel can replace them with proper actual jited
> func addresses.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2abbc3800568..a5146c9e3e06 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -188,6 +188,7 @@ enum reloc_type {
>         RELO_CALL,
>         RELO_DATA,
>         RELO_EXTERN,
> +       RELO_LOCAL_FUNC,

libbpf internally is using SUBPROG notation. I think "LOCAL" part is
confusing, so I'd drop it. How about just RELO_SUBPROG? We can
separately refactor these names to distinguish RELO_CALL from the new
one. It would be more clear if RELO_CALL was called RELO_SUBPROG_CALL,
and the new one either RELO_SUBPROG_ADDR or RELO_SUBPROG_REF (as in
subprog reference)

>  };
>
>  struct reloc_desc {
> @@ -574,6 +575,12 @@ static bool insn_is_subprog_call(const struct bpf_insn *insn)
>                insn->off == 0;
>  }
>
> +static bool insn_is_pseudo_func(const struct bpf_insn *insn)
> +{
> +       return insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&

there is is_ldimm64() function for this check (just move it up here,
it's a single-liner)

> +              insn->src_reg == BPF_PSEUDO_FUNC;
> +}
> +
>  static int
>  bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>                       const char *name, size_t sec_idx, const char *sec_name,
> @@ -3395,6 +3402,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>                 return 0;
>         }
>
> +       if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&

just move this check below the next if that checks !is_ldimm64, no
need to do it here early.

> +           GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&
> +           shdr_idx == obj->efile.text_shndx) {

see above how RELO_CALL is handled: shdr_idx != 0 check is missing. We
also validate that sym->st_value is multiple of BPF_INSN_SZ.

> +               reloc_desc->type = RELO_LOCAL_FUNC;
> +               reloc_desc->insn_idx = insn_idx;
> +               reloc_desc->sym_off = sym->st_value;
> +               return 0;
> +       }
> +
>         if (insn->code != (BPF_LD | BPF_IMM | BPF_DW)) {

feel free to use is_ldimm64 here as well, thanks!

>                 pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\n",
>                         prog->name, sym_name, insn_idx, insn->code);
> @@ -6172,6 +6189,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>                         }
>                         relo->processed = true;
>                         break;
> +               case RELO_LOCAL_FUNC:
> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;
> +                       /* fallthrough */

fallthrough into an empty break clause seems a bit weird... just break
and leave the same comment as below?

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
> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_LOCAL_FUNC) {
>                         pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
>                                 prog->name, insn_idx, relo->type);
>                         return -LIBBPF_ERRNO__RELOC;
> @@ -6374,8 +6394,15 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>                          * call always has imm = -1, but for static functions
>                          * relocation is against STT_SECTION and insn->imm
>                          * points to a start of a static function
> +                        *
> +                        * for local func relocation, the imm field encodes
> +                        * the byte offset in the corresponding section.
>                          */
> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> +                       if (relo->type == RELO_CALL)
> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> +                       else
> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ +
> +                                              insn->imm / BPF_INSN_SZ + 1;

nit: keep it on a single line, it still fits within 100 characters and
is easier to visually compare to RELO_CALL case.

>                 } else {
>                         /* if subprogram call is to a static function within
>                          * the same ELF section, there won't be any relocation

don't we have to adjust insn->imm for this case as well? Let's add
selftests to make sure this works.

> --
> 2.24.1
>
