Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF96BBEE9
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjCOVVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCOVVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 17:21:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA930FC
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 14:21:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-322fc56a20eso387065ab.0
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678915268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtGkZta8kr3aX4OtnVnQYv6dSKat8tApsT2Nzd8BoY8=;
        b=UMGT0VYp2EMsMxZh0XfEzS2agPikhIKE5OZ0SgN7tPGwdu7bDg4RK/Jc5yyVikxUmP
         yTKfzktQKLdQVJhWxlposn/04ZlaP9gPpXyvwctaWTD2mZEJoEJTTmBmrFtNFob+Cagp
         b3RZ/i2XKwd+N1uaTmmduwE4DAW1h4GKOZg1rIwre8CDpDBwaAOi+0QnBHU9JVAdtVdh
         NMeMddQP03mG8FZmzSbMeIY8ZIaI5XEX37RcZ8607AM4QoC+kjhr4N5JDezDpTyX4opS
         uJ+7P63sn/o9P7tWaTwLg+C0kEFWG8TYcaqW1P7VooEiaNS7nwIu+b2lNsb6UUyS/jAG
         SGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtGkZta8kr3aX4OtnVnQYv6dSKat8tApsT2Nzd8BoY8=;
        b=Mf0FrXVad4Q31gp7e3WThv/l6K9eCUIi/jns4BHfjTfgXvf2E5/iuR8M5TrrsaH7b9
         qInYldpVP33wg0fg5dBkJXke1gMTB+RFa9TqAeL++UwNhfwVNNmFjCN4M2FsUTvspy8V
         jrCnR6ukf2+HbWfpArr1huLXfGOErLtA5qPD6VQVOXAarxJeRZLSwqiumwEzVRNC2NH2
         Ib+tWME0EII1POJs3Re96JAdlInFS9cJc4TmJwTiT2zHqlaEv7b453o+b+b6CGtuB7JQ
         YzZwKK1u5ttJUjhxGIkNNekg40Y2engB8KVO1n8Ceb+MzT60GKsv3+yGngc9YDAuJeOk
         aPdw==
X-Gm-Message-State: AO0yUKWAKyObiWoe2FFPoF+L24W0Msxd1ppDxVe5FfLqZMpP+9uQ+150
        5wR2kkeDIFtIFfY2vy8TKTVAz61UI46/47eaulLm7g==
X-Google-Smtp-Source: AK7set8i0GD1k60EpeCsObmq8w6FjI/SxZtdvSvjKGP23RhGqBwh74Oha5n5jUHDosr6VgpOLpG5yVTn7VbzEPxNsME=
X-Received: by 2002:a05:6e02:1c2b:b0:322:848b:6c53 with SMTP id
 m11-20020a056e021c2b00b00322848b6c53mr23965ilh.14.1678915268259; Wed, 15 Mar
 2023 14:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315054932.1639169-1-gthelen@google.com>
In-Reply-To: <20230315054932.1639169-1-gthelen@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Mar 2023 14:20:56 -0700
Message-ID: <CAP-5=fXzyy7gNCpyS0aNHto720tK039q136_fL82ucEv0ifpQg@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Add libsubcmd to .gitignore
To:     Greg Thelen <gthelen@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 10:49=E2=80=AFPM Greg Thelen <gthelen@google.com> w=
rote:
>
> After building the kernel I see:
>   $ git status -s
>   ?? tools/bpf/resolve_btfids/libbpf/
>
> Commit af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> started copying header files into
> tools/bpf/resolve_btfids/libsubcmd/include/subcmd. These *.h files are
> not covered by higher level wildcard gitignores.
>
> gitignore the entire libsubcmd directory. It's created as part of build
> and removed by clean.
>
> Fixes: af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/bpf/resolve_btfids/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfi=
ds/.gitignore
> index 16913fffc985..52d5e9721d92 100644
> --- a/tools/bpf/resolve_btfids/.gitignore
> +++ b/tools/bpf/resolve_btfids/.gitignore
> @@ -1,3 +1,4 @@
>  /fixdep
>  /resolve_btfids
>  /libbpf/
> +/libsubcmd/
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
