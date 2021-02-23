Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D90323159
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhBWTVs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhBWTUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 14:20:20 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A5C061786
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 11:19:39 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id n195so17619272ybg.9
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZP1XGWH9j/iMAnPLhfBbhLeR9pmgtzSmlXMRpWyQ58=;
        b=b00PwtEYCfKgYKGAlQDXMdLZKQjJHxxGFFHPoVBSNDFujnoV5aAxgmbaHRl7NRyEqq
         Nq7MVcTRD6PC41+V65P2j1+YCtB0DephkKvUbmErXvp6y9zvH5lW2ecfG70cO/ot1BMI
         3d2Hzm5D0sAI28AktqnV3fQ766vTWeCNf1YXnOjjPE+rnC2jAN0cjgfh/cAcnZBFwA7i
         dBkUlNAbFX2ZLDgYxDzRW4hh5lifScFBcpcaT3ABFMoORKAQV/4N09paGKSaG72p+MVd
         dhPRFGbnapY8rsYpEck227m4V9fcnLQkXCKn+LdA3hzm1xIDv/MG9gjBhlr0nsf+pcpe
         2zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZP1XGWH9j/iMAnPLhfBbhLeR9pmgtzSmlXMRpWyQ58=;
        b=rypKUSyN5XeReRAIvgCsPuUUcvEnIX9CTQOPrBp18iHIiQkDcyas0S53Ub7xCe2D6/
         nAbskXThFDbxjGNt5JoGynKxutVf69VhKKDUsOesyaPA+Nax0Ie6GhqJWaqDfrjv2t/6
         HS/3MGiVLVftS3dBCtwwX9nEFMo5O7PGvTZyiSO806VVzMOVxL02xc+LShU9sAAY/grY
         T9n5cJd4VJPWZFQ3zip5x2dMpRqbPLoI95VY9ixYznPnOLbUD+WDwsE2BKa9XXRLgM95
         G0wDzvrvvUnc0N6wrOtITFApyug6DPLARBQ8XoLyou92Vb94H3/C7ILd9ZTPJMclFHHk
         L51A==
X-Gm-Message-State: AOAM532p9mLPv6NuXS71toGTolundCvbcgJPSRq5zX07V1naIdUVYlsZ
        PW2PR1QfgxHNZwYz4EAeSdFu8YuoTgpc1oVUejIo3MxIQ90=
X-Google-Smtp-Source: ABdhPJxkTTuMNh4k98d4ntSOyhY2gg5FHep1nuObeeNoyj1XBZUlJZSQ3ejqRu3bfKmEHgCFnmMYWwr94U3SlTjCnHo=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr43744226yba.347.1614107978717;
 Tue, 23 Feb 2021 11:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20210217181803.3189437-1-yhs@fb.com> <20210217181812.3191397-1-yhs@fb.com>
 <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com> <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
In-Reply-To: <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 11:19:27 -0800
Message-ID: <CAEf4Bzav42vH8PdRYg7_vV20EV7FL6CJiciXs=zv3rqu5TR_zg@mail.gmail.com>
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

On Tue, Feb 23, 2021 at 10:56 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/23/21 12:03 AM, Andrii Nakryiko wrote:
> > On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> A new relocation RELO_SUBPROG_ADDR is added to capture
> >> local (static) function pointers loaded with ld_imm64
> >> insns. Such ld_imm64 insns are marked with
> >> BPF_PSEUDO_FUNC and will be passed to kernel so
> >> kernel can replace them with proper actual jited
> >> func addresses.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++++++++++---
> >>   1 file changed, 37 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 21a3eedf070d..772c7455f1a2 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -188,6 +188,7 @@ enum reloc_type {
> >>          RELO_CALL,
> >>          RELO_DATA,
> >>          RELO_EXTERN,
> >> +       RELO_SUBPROG_ADDR,
> >>   };
> >>
> >>   struct reloc_desc {
> >> @@ -579,6 +580,11 @@ static bool is_ldimm64(struct bpf_insn *insn)
> >>          return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
> >>   }
> >>
> >> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
> >> +{
> >> +       return is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
> >> +}
> >> +
> >>   static int
> >>   bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
> >>                        const char *name, size_t sec_idx, const char *sec_name,
> >> @@ -3406,6 +3412,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
> >>                  return -LIBBPF_ERRNO__RELOC;
> >>          }
> >>
> >> +       if (GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
> >> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&
> >
> > STB_LOCAL + STT_SECTION is a section symbol. But STT_FUNC symbol could
> > be referenced as well, no? So this is too strict.
>
> Yes, STT_FUNC symbol could be referenced but we do not have use
> case yet. If we encode STT_FUNC (global), the kernel will reject
> it. We can extend libbpf to support STT_FUNC once we got a use
> case.

I don't really like tailoring libbpf generic SUBPROG_ADDR relocation
to one current specific use case, though. Taking the address of
SUBPROG_ADDR is not, conceptually, tied with passing it to for_each as
a callback. E.g., what if you just want to compare two registers
pointing to subprogs, without actually passing them to for_each(). I
don't know if it's possible right now, but I don't see why that
shouldn't be supported. In the latter case, adding arbitrary
restrictions about static vs global functions doesn't make much sense.

So let's teach libbpf the right logic without assuming any specific
use case. It pays off in the long run.

>
> >
> >> +           (!shdr_idx || shdr_idx == obj->efile.text_shndx) &&
> >
> > this doesn't look right, shdr_idx == 0 is a bad condition and should
> > be rejected, not accepted.
>
> it is my fault. Will fix in the next revision.
>
> >
> >> +           !(sym->st_value % BPF_INSN_SZ)) {
> >> +               reloc_desc->type = RELO_SUBPROG_ADDR;
> >> +               reloc_desc->insn_idx = insn_idx;
> >> +               reloc_desc->sym_off = sym->st_value;
> >> +               return 0;
> >> +       }
> >> +
> >
> > So see code right after sym_is_extern(sym) check. It checks for valid
> > shrd_idx, which is good and would be good to use that. After that we
> > can assume shdr_idx is valid and we can make a simple
> > obj->efile.text_shndx check then and use that as a signal that this is
> > SUBPROG_ADDR relocation (instead of deducing that from STT_SECTION).
> >
> > And !(sym->st_value % BPF_INSN_SZ) should be reported as an error, not
> > silently skipped. Again, just how BPF_JMP | BPF_CALL does it. That way
> > it's more user-friendly, if something goes wrong. So it will look like
> > this:
> >
> > if (shdr_idx == obj->efile.text_shndx) {
> >      /* check sym->st_value, pr_warn(), return error */
> >
> >      reloc_desc->type = RELO_SUBPROG_ADDR;
> >      ...
> >      return 0;
> > }
>
> Okay. Will do similar checking to insn->code == (BPF_JMP | BPF_CALL)
> in the next revision.
>
> >
> >>          if (sym_is_extern(sym)) {
> >>                  int sym_idx = GELF_R_SYM(rel->r_info);
> >>                  int i, n = obj->nr_extern;
> >> @@ -6172,6 +6188,10 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> >>                          }
> >>                          relo->processed = true;
> >>                          break;
> >> +               case RELO_SUBPROG_ADDR:
> >> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;
> >
> > BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
> > already? If not, why not?
>
> This is really a contract between libbpf and kernel, similar to
> BPF_PSEUDO_MAP_FD/BPF_PSEUDO_MAP_VALUE/BPF_PSEUDO_BTF_ID.
> Adding encoding in clang is not needed as this is simply a load
> of function address as far as clang concerned.

Yeah, not a big deal, I was under the impression we do that for other
BPF_PSEUDO cases, but checking other parts of libbpf, doesn't seem
like that's the case.

>
> >
> >> +                       /* will be handled as a follow up pass */
> >> +                       break;
> >>                  case RELO_CALL:
> >>                          /* will be handled as a follow up pass */
> >>                          break;
> >> @@ -6358,11 +6378,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
> >>
> >>          for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
> >>                  insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
> >> -               if (!insn_is_subprog_call(insn))
> >> +               if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
> >>                          continue;
> >>
> >>                  relo = find_prog_insn_relo(prog, insn_idx);
> >> -               if (relo && relo->type != RELO_CALL) {
> >> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
> >>                          pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
> >>                                  prog->name, insn_idx, relo->type);
> >>                          return -LIBBPF_ERRNO__RELOC;
> >> @@ -6374,8 +6394,22 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
> >>                           * call always has imm = -1, but for static functions
> >>                           * relocation is against STT_SECTION and insn->imm
> >>                           * points to a start of a static function
> >> +                        *
> >> +                        * for local func relocation, the imm field encodes
> >> +                        * the byte offset in the corresponding section.
> >> +                        */
> >> +                       if (relo->type == RELO_CALL)
> >> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> >> +                       else
> >> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm / BPF_INSN_SZ + 1;
> >> +               } else if (insn_is_pseudo_func(insn)) {
> >> +                       /*
> >> +                        * RELO_SUBPROG_ADDR relo is always emitted even if both
> >> +                        * functions are in the same section, so it shouldn't reach here.
> >>                           */
> >> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
> >> +                       pr_warn("prog '%s': missing relo for insn #%zu, type %d\n",
> >
> > nit: "missing subprog addr relo" to make it clearer?
>
> sure. will do.

given the "generic support" comment above, I think we should still
support this case as well. WDYT?

>
> >
> >> +                               prog->name, insn_idx, relo->type);
> >> +                       return -LIBBPF_ERRNO__RELOC;
> >>                  } else {
> >>                          /* if subprogram call is to a static function within
> >>                           * the same ELF section, there won't be any relocation
> >> --
> >> 2.24.1
> >>
