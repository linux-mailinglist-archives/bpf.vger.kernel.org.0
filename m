Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA04D6A91
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiCKWwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 17:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiCKWvv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF762EC
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:31:01 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id b14so6997870ilf.6
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQqZPONztLxE9uTHeBfdpB6/yRYGCpLeJ/HOdNNKmQ4=;
        b=fmhP6bGLTNkhPNCyAURnO2RHjPte62Np+LcmLkkfy1givxzhE9nubMp1+VeY0y25uC
         AaQ/MAJdRSCNh4ER2VzUN4ECYH4dF5yhTApRUOOjnzHE+X9AUyVMcaitC3qo1KQtp74X
         KN9jv7LHTMYaZyr5pMK88kkRRUi2eYolUvSsRUPoAF/5eZt9anFj/boCfEpAdxCoKPzh
         QJsQGnO6DzV7/DuY7Y5KGE8pYktrwmcg4pOGB2wAC57wgZSGtBDPIxjp278oR9zmRiTo
         nMdKBV6rB2B17Zj4nr6+oN6G7VhcVCYbXYugj1wJprXx2cOvcNiMR+445+WNdyNSyva3
         sGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQqZPONztLxE9uTHeBfdpB6/yRYGCpLeJ/HOdNNKmQ4=;
        b=1umOSTd0j4I5yz2av0eHxIMkRri+V54d5KwiULNBOu3Zasd30ksLe/wp1I4aaYZjUD
         xIABgU4Rp6cQ6KPJIyak19mGRZuIDTOepLMMoYTjZeoQgKLAV250OIvcAeslJR6Fme7Q
         3Ul1umiM6U6jLU4P3LjdrXXbkSXgBlj5y9tA3qHbeX2M2UZhHaHqfKQ0Z2iDfzKDTkFI
         s5jxYQT139CqYJS6TzcNfWYRKTKCm8Umdbr/Y81TbJ0gjoxOvG8rooiqgl0zMycWVEvO
         Eh7Ddc5a+Ta0Xxvacpfb49BtRRc3B50OSTyI8MzQs/V9waqrnwemouokgu9HLEDzwKPb
         qoDQ==
X-Gm-Message-State: AOAM531SlnJBAm3Ho5VxBzXu0hLpO6dxTmmx3U1O+gwA0p0yGTwY4jzR
        k4zkgV9NEl6CFSwzkl35sH0dCDQdGn3FlI+R9i0b5XyPhno=
X-Google-Smtp-Source: ABdhPJxpZRPNvI7ZfmMcxq5Mjz+Gpbt3Zh9MlQDosrksFCk4+8YnrGzgNpg5JGfB13fIUztXMjZwhMkBl/2++8oyMHc=
X-Received: by 2002:a92:ca0c:0:b0:2c7:7983:255f with SMTP id
 j12-20020a92ca0c000000b002c77983255fmr3530563ils.252.1647037860778; Fri, 11
 Mar 2022 14:31:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <b107f56787c89464ab52828b885e1a208312d20b.1646957399.git.delyank@fb.com>
In-Reply-To: <b107f56787c89464ab52828b885e1a208312d20b.1646957399.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 14:30:49 -0800
Message-ID: <CAEf4BzY_iCC-TFGSWrPFxcdnwFa6czuo-SGGLg_+Fxm_WqqwLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] libbpf: add new strict flag for .text subprograms
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Currently, libbpf considers a single routine in .text as a program. This
> is particularly confusing when it comes to library objects - a single routine
> meant to be used as an extern will instead be considered a bpf_program.
>
> This patch hides this compatibility behavior behind a libbpf_mode strict
> mode flag.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c        | 7 +++++++
>  tools/lib/bpf/libbpf_legacy.h | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 43161fdd44bb..b6f11ce0d6bc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3832,7 +3832,14 @@ static bool prog_is_subprog(const struct bpf_object *obj,
>          * .text programs are subprograms (even if they are not called from
>          * other programs), because libbpf never explicitly supported mixing
>          * SEC()-designated BPF programs and .text entry-point BPF programs.
> +        *
> +        * In libbpf 1.0 strict mode, we always consider .text
> +        * programs to be subprograms.
>          */
> +
> +       if (libbpf_mode & LIBBPF_STRICT_TEXT_ONLY_SUBPROGRAMS)
> +               return prog->sec_idx == obj->efile.text_shndx;
> +
>         return prog->sec_idx == obj->efile.text_shndx && obj->nr_programs > 1;
>  }
>
> diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
> index a283cf031665..388384ea97a7 100644
> --- a/tools/lib/bpf/libbpf_legacy.h
> +++ b/tools/lib/bpf/libbpf_legacy.h
> @@ -78,6 +78,12 @@ enum libbpf_strict_mode {
>          * in favor of BTF-defined map definitions in SEC(".maps").
>          */
>         LIBBPF_STRICT_MAP_DEFINITIONS = 0x20,
> +       /*
> +        * When enabled, always consider routines in the .text section to
> +        * be sub-programs. Previously, single routines in the .text section
> +        * would be considered a program on their own.
> +        */
> +       LIBBPF_STRICT_TEXT_ONLY_SUBPROGRAMS = 0x40,

We have LIBBPF_STRICT_SEC_NAME, we can probably just rely on that one.
STRICT_SEC_NAME means (among other things) that there has to be
SEC("abc"), so there can't be BPF program in .text section. We don't
enforce that yet, but that's a separate thing.

>
>         __LIBBPF_STRICT_LAST,
>  };

> --
> 2.34.1
