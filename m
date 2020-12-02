Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3852CB289
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLBBxs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 20:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgLBBxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:53:48 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC9C0613CF
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 17:53:08 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s8so150576yba.13
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 17:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRGukEaVC7ahcdIfPVDkgZ44XD+8rX5mwAlFk05Gr6I=;
        b=ZhD58MAehGIFOQlFqIFcXrAEWZGY6q3pYYG2xxKah4ndXgHZcok1D1Z/jG85/jntjG
         WadUYa4nMN1pPcs9rAxNZ7QejSDIRGR4ciZwp3SRUmr5vi/0yZWB/A+GYXQQbHIx0pDE
         rvjwEGKr/85RqoiGFd8oiMEo2axfvZiLV1tWWX0FlUIcagN6iHJlxX9F/6rb6+N8p2HT
         2fFGQDGK9LE4yDtwlTTe5eC42AXwxCSI/kvHaNXjuc5WNYL1cR6+2QfBr1q+LaZITb2q
         nm0Xwu0xhdD2771NJ3TyevCxlIB0ZqZGDyPOZx0syB1zaLGXI/hplaUVGOHsIcj2/sXX
         r7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRGukEaVC7ahcdIfPVDkgZ44XD+8rX5mwAlFk05Gr6I=;
        b=XAn0wE+j8/lCsSeZTMMyV/+jdSZaXbeW0hpQ4+clju+UO1/pOMsBxus1khFJz1oe0V
         JjiyGq3IR0DpmpXAkruRcgMAsaIi2GiPI2aXBTGwrA21ctCyX5LsqR4ZA6zg25kpcXsB
         9nexNuJt97RPqGYIH9pl5j7VHQc47Xzq0If507UcYRy0Z9XpTvAvVFZOMqi7cG+wLs2Q
         unuk8EtCPpe4deFe1C4gy+IOJnKF9/L117znMEpF91NujB611Y6hgAimKB9mCvQLU4ws
         K75RA0gF/qjNDYoRaAIRztpEvsVg5b/7g+Zr/N63SkG+1mDP7Dvq1b4LCUMIChp60SAe
         zdWQ==
X-Gm-Message-State: AOAM532fNFp4/b2fAKLL8DeiPatSpwex61pIR6BOmiJaVgdOoogaDqw5
        ru00y2LLktXfDiqYh3lfmn77krDPtxUe9McS7Kc=
X-Google-Smtp-Source: ABdhPJyte2h7cTpXqviBO/pqHZAbc4761D9cfp60ZDaDgwna084OTVnfjmSleh5MkitO4NSXu06IjD+M5yTS2UdEYo0=
X-Received: by 2002:a25:df82:: with SMTP id w124mr344140ybg.347.1606873987321;
 Tue, 01 Dec 2020 17:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20201201044104.24948-1-andreimatei1@gmail.com> <20201201044104.24948-2-andreimatei1@gmail.com>
In-Reply-To: <20201201044104.24948-2-andreimatei1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 17:52:56 -0800
Message-ID: <CAEf4BzbzEfUc77qe9rZ1HXWAzjr-4BDBfWSdJaxtHUXQPnFKxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] libbpf: fail early when loading programs
 with unspecified type
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 8:43 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> Before this patch, a program with unspecified type
> (BPF_PROG_TYPE_UNSPEC) would be passed to the BPF syscall, only to have
> the kernel reject it with an opaque invalid argument error. This patch
> makes libbpf reject such programs with a nicer error message - in
> particular libbpf now tries to diagnose bad ELF section names at both
> open time and load time.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

This is useful, thanks. See below for a few comments, though.


>  tools/lib/bpf/libbpf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 313034117070..abca93b4f239 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6629,6 +6629,18 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
>         char *log_buf = NULL;
>         int btf_fd, ret;
>
> +       if (prog->type == BPF_PROG_TYPE_UNSPEC) {
> +               if (!prog->sec_def) {
> +                       // We couldn't find a proper section definition at load time; that's probably why
> +                       // the program type is missing.

no C++-style comments, please

> +                       pr_warn("prog '%s': missing BPF prog type'; check ELF section name '%s'\n",

extra ' after "prog type"? also ';' -> ',' ?

> +                                       prog->name, prog->sec_name);
> +               } else {
> +                       pr_warn("prog '%s': missing BPF prog type\n", prog->name);

while, technically, user can manually set program type to UNSPEC even
with good section name, that's probably extreme case which we
shouldn't worry about. So I'd just always emit the section name.

> +               }
> +               return -EINVAL;
> +       }
> +
>         if (!insns || !insns_cnt)
>                 return -EINVAL;
>
> @@ -6920,9 +6932,11 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
>
>         bpf_object__for_each_program(prog, obj) {
>                 prog->sec_def = find_sec_def(prog->sec_name);
> -               if (!prog->sec_def)
> +               if (!prog->sec_def) {
>                         /* couldn't guess, but user might manually specify */
> +                       pr_debug("prog '%s': unrecognized ELF section name '%s'\n", prog->name, prog->sec_name);
>                         continue;
> +    }
>
>                 if (prog->sec_def->is_sleepable)
>                         prog->prog_flags |= BPF_F_SLEEPABLE;
> --
> 2.27.0
>
