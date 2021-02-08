Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42733314303
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBHWaA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhBHW3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:29:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6BC061786;
        Mon,  8 Feb 2021 14:29:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y128so16177023ybf.10;
        Mon, 08 Feb 2021 14:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQY5cuKubV3ceU0O9YHpSCz4GdbreVhMJGdX+SS3JVw=;
        b=oz/0y/oTmqPWAKil4Djs66n3qk+qOfoju1vGhB3ylutM0+R6U4kipa3Q6ebmPnYJ2y
         l7WclDXmhP5r3FmOniD7xdX8IQe73ZR6aIDQbdMPfYtpdAptlTSDGM2MEBGOHHw9u977
         79xJrOV30OLNWvJA6AldQXJEU01qlk3IzTfplAD2InBLy/+TVo4J7iZrHBUcs8q53hnh
         CfRmu1wDg32FvRa33XwyrmSgO+XXnB+Kqf7/QTZd6W2Q/XCPJ2GYp2UvV2EUzzSVyZ3W
         L1r32t9OmhjIbFKeEMQxkntxO0mSaOOQHJWndldw70TgG3CTEEn5gfAk7cgTdBx+9CXT
         8R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQY5cuKubV3ceU0O9YHpSCz4GdbreVhMJGdX+SS3JVw=;
        b=kgMrrgwPQRRoSWYrpwa1ts6pcRB8EUE4IEY/UOOFWxcChWXOt3VMRfYh/F84BB4jFJ
         EkWGN1/v8Zyl1iWecRzdie67r5kHqNzPgQb9jcryv/cQExVLZw3HS60I5l+P56GsV9sI
         CljVXowZHR1QPF4pjJHTdh/O/9p05plwbsWBZzchTGhMqTK28+vNev3j+wq1aFNunw66
         soDYBs7uF/yzT5w5wRsX1k0qVWwV1YBBo28M6Qcs0kGj5CrUKuSHjzeQIoOIloWoVeuY
         ELQXIoNAHWnzGgMv3oOobRgF9vwPWsXjJ3IhN72kRa5+9ls5mS1kzKGPwJk4Xp9+CTuM
         wIOw==
X-Gm-Message-State: AOAM532X2kZMZJABpaEn5CVVEYojKOK3wGZl3dsHENFeghyMXNvPjyqm
        8BfiIQEJudyJNdKQploYsGAO7BEYWGV0szfVbTm2ONR+icVbww==
X-Google-Smtp-Source: ABdhPJz4I7ZaziF6RSQ9H5h0XYEUodOvfTsbU+AI5hFyo4Hc99i5SPW30VfQE7REnKqYwpFNPDAonhOygELia/Nr9qA=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr26472818ybp.510.1612823354577;
 Mon, 08 Feb 2021 14:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-5-gprocida@google.com>
In-Reply-To: <20210205134221.2953163-5-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:29:03 -0800
Message-ID: <CAEf4BzbF00jVMcVf1uQXM3QuHAeJYyV807KFeJoMOwnXdHbf7Q@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 4/5] btf_encoder: Add .BTF section using libelf
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
>
> pahole -J uses libelf directly when updating a .BTF section. However,
> it uses llvm-objcopy to add .BTF sections. This commit switches to
> using libelf for both cases.
>
> This eliminates pahole's dependency on llvm-objcopy. One unfortunate
> side-effect is that vmlinux actually increases in size. It seems that
> llvm-objcopy modifies the .strtab section, discarding many strings. I
> speculate that is it discarding strings not referenced from .symtab
> and updating the references therein.
>
> Layout is left completely up to libelf and existing section offsets
> are likely to change.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

Logic looks correct. One nit below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 127 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 46 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 4ae7150..9f4abb3 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -698,6 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
>
>  static int btf_elf__write(const char *filename, struct btf *btf)
>  {
> +       const char dot_BTF[] = ".BTF";

it's a constant, so more appropriate name would be DOT_BTF, but that
"dot_" notation in the name of the variable throws me off, honestly.
libbpf is using BTF_SEC_NAME for this, which IMO makes more sense as a
name for the constant


>         GElf_Ehdr ehdr;
>         Elf_Data *btf_data = NULL;
>         Elf *elf = NULL;
> @@ -705,6 +706,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         uint32_t raw_btf_size;
>         int fd, err = -1;
>         size_t strndx;
> +       void *str_table = NULL;
>
>         fd = open(filename, O_RDWR);
>         if (fd < 0) {

[...]
