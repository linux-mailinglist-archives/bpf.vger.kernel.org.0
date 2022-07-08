Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200B256C349
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiGHW0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiGHW0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:26:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82CDA2E72;
        Fri,  8 Jul 2022 15:26:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so13631741ejs.2;
        Fri, 08 Jul 2022 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWlKpaLv2VR3Vok4iSI8gNXJv7MjF7LayWn7Z5iN4Q0=;
        b=U8aaplgioalA7mIrEOI6BxlQFR6mErtWpV+io2v+ksxQVg+k9lnEYU+zCdHIv2Ac6X
         I9nsORy3aehZXRS3syRxg3scRJHMdJXhMzT2fJSi0GF9wsbNnJvSyLVpmePzCGt0IQJ7
         OCw9XBtGA0AkSM0ja5tk5M2vHFUfYb+LjreZu7aYLEJOUqBbOaRjrAiOSlWJ//C+NpUs
         zKJjR2a0kIDhYaeGNWABr2hacMVUnvi1PXcvtUTFA6rpPko+hKaw4j2QaqL4/9PbHPLF
         znos7RHZmL1Kkfh3B/JugMS0HkdzEjPP9nQd6wY61WglfVfM8pTvOx5qa2SMUrpM2aWq
         i4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWlKpaLv2VR3Vok4iSI8gNXJv7MjF7LayWn7Z5iN4Q0=;
        b=tZcPfj/sMNJfxphZPSo5YpFciFnZp3B6FinbGNhO/l3QMHBnLew/3wgPp6RAYggxft
         o4DrmQe5HFSP0VV56jbuIQYYU9w8+Up0CaMcUG9Pm6Hn8C2agNy869w0m6pB5jxD6NdL
         NX9KP9J3QIJxWGLj9DVdiezx+dnf8QggVXQXZCn5ahXLWrlSVDtEFpRQ6e/o7dDlno2n
         pGIFQzyQcdm3YZb+FtGN/mY0Na7MMHzxW0XApgH8GDH+YqbWSd1I6HyZ6IIekB7ZJ3XY
         WwI/AAy/iqqxjW/7F/ksRw9nCJhkxD8mHezv0wfqk1sw2LdiYQgXVe3GQP4aWECxL47r
         aHnw==
X-Gm-Message-State: AJIora9J0cuL5+E06UlOAcN98wwCn44PS5U9ui+6o/EVXuq5XVxVJnhH
        Mhu3Jmb6W/3JORx4RKBawEhLnBCttAxFF3Yt+Jk=
X-Google-Smtp-Source: AGRyM1vgBr55LanK+nzR7AP78QmdrVahMi/alnIxc+HkET+hfgQ3FznBjGTDryn7qk9TY0BGng2tusZNvHb0lcBNuE8=
X-Received: by 2002:a17:906:a3ca:b0:726:2bd2:87bc with SMTP id
 ca10-20020a170906a3ca00b007262bd287bcmr5782990ejb.226.1657319179460; Fri, 08
 Jul 2022 15:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com> <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:26:08 -0700
Message-ID: <CAEf4Bzbfi8Zx=riv5GOz0NqB18yvjixT02YtmowCd7ZSSggDfQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, swboyd@chromium.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Kenny Yu <kennyyu@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Jul 6, 2022 at 6:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
>
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/kallsyms.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>

LGTM, except for unnecessary pr_warn(), see below


[...]

> +
> +BTF_ID_LIST(btf_ksym_iter_id)
> +BTF_ID(struct, kallsym_iter)
> +
> +static int __init bpf_ksym_iter_register(void)
> +{
> +       int ret;
> +
> +       ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> +       ret = bpf_iter_reg_target(&ksym_iter_reg_info);
> +       if (ret)
> +               pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);

we don't emit such warnings for some other iterators I checked (map,
link, etc). Do we really need this? It's very unlikely to happen
anyways.

> +       return ret;
> +}
> +
> +late_initcall(bpf_ksym_iter_register);
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  static inline int kallsyms_for_perf(void)
>  {
>  #ifdef CONFIG_PERF_EVENTS
> --
> 1.8.3.1
>
