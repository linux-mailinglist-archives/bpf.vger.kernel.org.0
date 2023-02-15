Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FEA69812A
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBOQq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBOQq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:46:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118A265B3;
        Wed, 15 Feb 2023 08:46:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id n20so8174602edy.0;
        Wed, 15 Feb 2023 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTPd/G13h67SQvxJF7Fd8d1Wb8TMYU9q6slWVQsYcbQ=;
        b=gfSDlMgqaEAUQcsHE7zFBvDmeTcjYBDG8IIdD/p+6IPMpmOfAcQZzUrVB6VmIWzvPX
         U1t/iUbb9ZWO411InumPfkqVPXbF0RjRlnbNL7NY3f+occ+/k7QMwwuy87Sc1rIahD4E
         LjbvVuEtX6Vgq2ZCejmIpZWR15NNOPS28wnBRQwXAMxXq0WDDzm7pI4o2gCJO5PtRaTe
         DRA01ANEJysOHm6anUz+q47OwGlRoRnDghcKNELp0dmTgtnx5OAs7gGSH7cxtYJ7HWxJ
         LMZL6ntMipz2nLBDRPOyn1sxlupCXKYq6JcSfT8RlMcITstq6Hb/WB/OIJBkkJuE4wEr
         DufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTPd/G13h67SQvxJF7Fd8d1Wb8TMYU9q6slWVQsYcbQ=;
        b=Y7Y1CqEtxsb+4JmKzwDwdzcvrYBOnrt8v/XAMimh6clOgA8BcXzluKc/gi/FfYAGBd
         fGHLbjMC8U/VF3zAhfHlEYK0bYFu7594LB6zNF8fSGaV+Hz6GDJJWTkeLk5sbr3TyEDP
         JRM5HPQwdvrLTV5PYtcYA0dCN/9cKBAzHbbSURUD8nRuqdbxhAM8Cw7jnI8MdYw6bKzE
         eArtAqMbQFOkjVhnWYg444jRUc5CpN9QqfHt3r4Nzmjdi+gD4ZkWYt9k5uPkjIjbyn6d
         RtTAm+Un4EYSIqYqBqU4imX2/RAkidO74FZUA1ROvf+X+wolxjbkPLte/4Qv+6uMF3Gb
         ZXWA==
X-Gm-Message-State: AO0yUKWykiM+2LeOPRwQ1LTNY5MYI6nYbM8ZGPBNHzXimHZ1nft8BrqG
        P5GJA6QP6yGjUFuPga6vNAHs1Qbv6qM9GvgLgqc=
X-Google-Smtp-Source: AK7set+sGkoZVdFmtF4qAXP8i0ZUDFHlMpTwAlohWFbmzRRZjSuduQkzODAFqzk5o4m8YYqB+MDRXgJyxV2MIWPVLys=
X-Received: by 2002:a50:d093:0:b0:49d:ec5d:28b4 with SMTP id
 v19-20020a50d093000000b0049dec5d28b4mr1468753edd.6.1676479581483; Wed, 15 Feb
 2023 08:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20230215123253.41552-1-bagasdotme@gmail.com> <20230215123253.41552-3-bagasdotme@gmail.com>
In-Reply-To: <20230215123253.41552-3-bagasdotme@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Feb 2023 08:46:10 -0800
Message-ID: <CAADnVQKZ2rrhrpLMf+cRhmNEQ5rPwFibqUe0eFisL7AkY5_y2A@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: bpf: Add missing line break separator
 in node_data struct code block
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Huang Rui <ray.huang@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        oe-kbuild-all@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 4:33 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Stephen Rothwell reported htmldocs warning when merging bpf-next tree,
> which was the same warning as reported by kernel test robot:
>
> Documentation/bpf/graph_ds_impl.rst:62: ERROR: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 12 supplied.
>
> The error is due to Sphinx confuses node_data struct declaration with
> code-block directive option.
>
> Fix the warning by separating the code-block marker with node_data struct
> declaration.
>
> Link: https://lore.kernel.org/linux-next/20230215144505.4751d823@canb.auug.org.au/
> Link: https://lore.kernel.org/linux-doc/202302151123.wUE5FYFx-lkp@intel.com/
> Fixes: c31315c3aa0929 ("bpf, documentation: Add graph documentation for non-owning refs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/bpf/graph_ds_impl.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/graph_ds_impl.rst
> index 8bbf1815efe784..61274622b71d85 100644
> --- a/Documentation/bpf/graph_ds_impl.rst
> +++ b/Documentation/bpf/graph_ds_impl.rst
> @@ -60,6 +60,7 @@ The new-style data structures are intrusive and are defined similarly to their
>  vanilla kernel counterparts:
>
>  .. code-block:: c
> +
>          struct node_data {

Applied to bpf-next.
