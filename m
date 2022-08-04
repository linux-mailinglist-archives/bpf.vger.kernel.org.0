Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF5258A2F5
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiHDV6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDV6B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACAD1B794
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 14:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 943E4B82773
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 21:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418D9C433D7
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659650278;
        bh=A+ORtwtH+nQKM4sSLtbkpk1pB9SsV5SU2yqcbDUBHkc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iQMQuiuiddruNdt92QVQBOCnfLqoJCxuGxCX9OkGpm9SeLUx33dHkCOl6qUoQTI1Q
         IM5wNTE79T1oAO2DMLWEXWEl8heQi2kHbIQpMA5ZDAKCKfXVsrG1YNFVCYlZJMsQGl
         WbN38p6Dvc1me6ZUfktrOQxWCklmBvUgtwaAuBR6k8PexV18B2vbSBLv2YJYJ7ahHN
         OkSMa0riCAc5ca9xqbHG4noxkL58rCF/oVAyRh3nrMxKVcS8dlLQLV3ocOgIvkLenn
         7EG21unMq6mwLxGJkk3AWFAv5CHbgKVrklXssbn5c8HLxPYOfPxqJdOEvuw7Rao5FZ
         cWmiXI4S2crzQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31f445bd486so8152897b3.13
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 14:57:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo1/7nwo5W1TXdf04C5JGdEvYsnyAheaQlKXtVudR4EhYX+1K4R9
        R9DAkqtnE14/498yy3gTB1QcrRISNW46+KgK16I=
X-Google-Smtp-Source: AA6agR7gHSmYTbVSeOvjFBlpB8mcDoaoYDll6Als9s5i4E9ojIeVV37hDhipzJ51+R5L/8PHdUiXLLKuSLI9GnvZOWI=
X-Received: by 2002:a81:63c3:0:b0:323:ce27:4e4d with SMTP id
 x186-20020a8163c3000000b00323ce274e4dmr3495885ywb.472.1659650277271; Thu, 04
 Aug 2022 14:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802135651.1794015-1-jolsa@kernel.org>
In-Reply-To: <20220802135651.1794015-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 4 Aug 2022 14:57:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW76i55-UqfaL0gRLK7FKGoPFjMCfPNZNePry=PamYrRfw@mail.gmail.com>
Message-ID: <CAPhsuW76i55-UqfaL0gRLK7FKGoPFjMCfPNZNePry=PamYrRfw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Cleanup ftrace hash in bpf_trampoline_put
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 6:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to release possible hash from trampoline fops object
> before removing it, otherwise we leak it.
>
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Great catch! Thanks!

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/bpf/trampoline.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 0f532e6a717f..ff87e38af8a7 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -841,7 +841,10 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>          * multiple rcu callbacks.
>          */
>         hlist_del(&tr->hlist);
> -       kfree(tr->fops);
> +       if (tr->fops) {
> +               ftrace_free_filter(tr->fops);
> +               kfree(tr->fops);
> +       }
>         kfree(tr);
>  out:
>         mutex_unlock(&trampoline_mutex);
> --
> 2.37.1
>
