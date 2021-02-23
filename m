Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317E33226E6
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBWIIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhBWIHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 03:07:48 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A798C06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:07:08 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x19so15639252ybe.0
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6X4pKBiK6Zj/Jozykzyb3rkkBiOrgkwAij95iiTmF8Y=;
        b=rNrGqyjUdX1e+c/Z9C2G6phS/2EedFpHb1MwvwvVSl37KRYtUQLaXGMwAKF1zPqmp0
         C8o8rOwbLRArJAZiG84jOTgavL8GBLnBhqxjlefFjNIkD/elYc0padzPtIrNLytQbtjF
         cq6sgFjKk+Yv80qHr1acTdnSiXxBNAGrAOvqJF8hQ5JQE8XOIfSWXukNv6UiJeiWRePg
         gS5FZ5iU5CWPdhhOywVma4pw6OI5/7cfd2l8+SCJIRrd0clzp5AVGDUzQzhn/0mKYoWa
         uq0YAoTvZ3fVCnoHDe03ta2vUOEx/boQulX0L3Qk8q6YQG8mhOGt88HXNcyNLw3SDzMw
         V+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6X4pKBiK6Zj/Jozykzyb3rkkBiOrgkwAij95iiTmF8Y=;
        b=hEKigAkbG8/Yk4bzjKWJs4n78M+y1XzDJ+6Eq2tN7P0EoVqIiPj1z3tz+U3WeVTIRs
         glRS5eK3LTuZW7TcP3EhoZerWq+Uqj1nkgWOPrsLBJgGqcCeGdDSOArdiqqYJMJkUCHh
         Bcjv+LWiux4dhX8OFwUauF9FxHJkCRqgom+aJxwww3V/TeYnwuS6DrE2rUtJVslxxtwL
         dxjQSudBJoqdWdXAHGFu+OEk0lkanqGa2dPSinOv7Q4nc0zrti6UUHnsXauZjpVjeEV5
         s23E+pMYvef2igQ4ML56HJP6ggcNjj8doami3fOP3+6P6kzv/UaGBPp39K9O/BfST5UZ
         hWQg==
X-Gm-Message-State: AOAM533N7BWP0W+CNIPc13M3cIL8wBhI3X9nb/XlnqJkGAONZbhObOu5
        dKaDDyzXINmE0kJEM2bN9o4ggH1XVz9qmGtz7Lt7uPqu37I=
X-Google-Smtp-Source: ABdhPJxCceLN51rr7141AdmwcrTgp437dd5a+5ZQDB/HB+L0bHaiu3oFBCmflLSIjsYYLPEMNMwACJt8uhNYlTrgqyU=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr39051854ybe.459.1614067627729;
 Tue, 23 Feb 2021 00:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20210217181803.3189437-1-yhs@fb.com> <20210217181811.3191061-1-yhs@fb.com>
In-Reply-To: <20210217181811.3191061-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 00:06:57 -0800
Message-ID: <CAEf4BzbsniN=dswRUSeykFkbq22A4JzR7mDnStgdfC5b9cNOxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/11] libbpf: move function is_ldimm64()
 earlier in libbpf.c
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 12:55 PM Yonghong Song <yhs@fb.com> wrote:
>
> Move function is_ldimm64() close to the beginning of libbpf.c,
> so it can be reused by later code and the next patch as well.
> There is no functionality change.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d43cc3f29dae..21a3eedf070d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -574,6 +574,11 @@ static bool insn_is_subprog_call(const struct bpf_insn *insn)
>                insn->off == 0;
>  }
>
> +static bool is_ldimm64(struct bpf_insn *insn)
> +{
> +       return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
> +}
> +
>  static int
>  bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>                       const char *name, size_t sec_idx, const char *sec_name,
> @@ -3395,7 +3400,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>                 return 0;
>         }
>
> -       if (insn->code != (BPF_LD | BPF_IMM | BPF_DW)) {
> +       if (!is_ldimm64(insn)) {
>                 pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\n",
>                         prog->name, sym_name, insn_idx, insn->code);
>                 return -LIBBPF_ERRNO__RELOC;
> @@ -5566,11 +5571,6 @@ static void bpf_core_poison_insn(struct bpf_program *prog, int relo_idx,
>         insn->imm = 195896080; /* => 0xbad2310 => "bad relo" */
>  }
>
> -static bool is_ldimm64(struct bpf_insn *insn)
> -{
> -       return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
> -}
> -
>  static int insn_bpf_size_to_bytes(struct bpf_insn *insn)
>  {
>         switch (BPF_SIZE(insn->code)) {
> --
> 2.24.1
>
