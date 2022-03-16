Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9B4DA9D7
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbiCPFaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiCPFaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:30:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35782DAB9
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id w7so1191202ioj.5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPQuSlYsXZsu0VPE0Be4xsl9/iOFXxYt6CgNEPjUx6E=;
        b=h+8FbqSAV5h4yXZDq8dLDjxqQ/M8LzGY6D7bT6gBRlNsinBm8M88dfhmd1VW+HfdNP
         uWb37BeH5UhuFjxuGCzLRYgI3OMO/R0tpsoK0AubCupNpirbaNAuBUUvD9v/fUkfqQgA
         o1tZrrs8tq3jxWyxfvwlnMmouu1QDgJXdcX4TqdeM+SDxH3876x4FLy7FDdQ/fx9jAYd
         C4hPLJ7YBgZ/+wpUv/bTxT5lVOpeXvLDU0ynCOZgg3GRQ81fd8XUae1GJ7UfEbmwoODy
         AxVt/ewOdujioH47ab9z8rjbWF99PLaVwdML/dVyjzlWrmMpn7Y2Nt5eiVY/7oBi6QjP
         RsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPQuSlYsXZsu0VPE0Be4xsl9/iOFXxYt6CgNEPjUx6E=;
        b=EnNEHqPHNlN/XnVvhc1WiR9G2390RST+876FZ1S9X7q4unjX7PGMo8WwJZyluN8FUU
         NMGbeEcAzX2KtPR3DWR8+gRLJDPI5GUvYC4r2j1ZeoC8tkBMN+C12PqyAeW2x8Bx/3SL
         qw7chtFWruTpnnaG+R0weQZ0v8077pP9cajEFCeYmkKxYNrbVo90a7+LMZMFrApe3rvT
         Qdh3vtsYcIqK99dSL4ynYBGFLp4ZcGdeH942NwRNMXeT6beTPujsZubXH0fNe8Zhdrhx
         yZH7F81KWRUcLRGU8ESMnAlfxTxaEVTES9h2zeLxTkETWGRlYkHe+1kWljlRe9SzAFg9
         rm9A==
X-Gm-Message-State: AOAM530PfkuBuS4zuehsiOSvqwoXUzt53wC9oUi2F7VUPQsH8JCfaEpf
        h84laLGQQji7HT0cfpElL6vKbAGxhZ1kTn5NsN0=
X-Google-Smtp-Source: ABdhPJwvwMemuB2M9kfkETxy82Uyq/iFFjYLaTQqEz8nhegHj8vdxlcOMqgfM2UgrckvGPvAq66W55Bz+5jfx52XryE=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr23992684iov.144.1647408534445; Tue, 15
 Mar 2022 22:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647382072.git.delyank@fb.com> <b239588581c1a1367b3ae901a9e3058bbb7a9eb7.1647382072.git.delyank@fb.com>
In-Reply-To: <b239588581c1a1367b3ae901a9e3058bbb7a9eb7.1647382072.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:28:43 -0700
Message-ID: <CAEf4BzYoNDmGBQn6UrS8NAOt0TBB8A-jQ4Az0a+NtwfT2LH15g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] libbpf: .text routines are subprograms in
 strict mode
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

On Tue, Mar 15, 2022 at 3:15 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Currently, libbpf considers a single routine in .text to be a program. This
> is particularly confusing when it comes to library objects - a single routine
> meant to be used as an extern will instead be considered a bpf_program.
>
> This patch hides this compatibility behavior behind the pre-existing
> SEC_NAME strict mode flag.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c        | 7 +++++++
>  tools/lib/bpf/libbpf_legacy.h | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 43161fdd44bb..aa26163e4ca1 100644
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
> +       if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
> +               return prog->sec_idx == obj->efile.text_shndx;
> +
>         return prog->sec_idx == obj->efile.text_shndx && obj->nr_programs > 1;
>  }
>
> diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
> index a283cf031665..8d2e632aec79 100644
> --- a/tools/lib/bpf/libbpf_legacy.h
> +++ b/tools/lib/bpf/libbpf_legacy.h
> @@ -53,7 +53,9 @@ enum libbpf_strict_mode {
>          * SEC("xdp") and SEC("perf_event").
>          *
>          * Note, in this mode the program pin path will be based on the
> -        * function name instead of section name.
> +        * function name instead of section name. Additionally, routines in the
> +        * .text section are always considered sub-programs. (Legacy behavior
> +        * allows for a single routine in .text to be a program.)

nit: pinning doesn't have much in common with this, so please put the
new text on a separate paragraph


>          */
>         LIBBPF_STRICT_SEC_NAME = 0x04,
>         /*
> --
> 2.34.1
