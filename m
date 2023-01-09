Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E43662B05
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAIQTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjAIQTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 11:19:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57FC193C1
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 08:19:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D75611CA
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 16:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD38C43392
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673281185;
        bh=mhAX4ypzBHbXRvNftq0w6poGrboCAFvmYvtK0zKjEu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iq6w+TW4AZ4q3PKKjS0P27s74+pBuP0pxS2lGYpDB6abkoT4KouEyyDyK8bAa0uY5
         BlssD8UdaVUNLMAJ4wD6SrwX4+M5eEVlqYyQMItnqG8ZPE348AY1d0Yk3KeGLm3KcA
         STeBeLaoCCHe8pewVRRG0crwODHl+kZJ4LVx7xZu7VnQmM+KvuhGaMSRNlvqrPPkFd
         m9W+EDfSDsXZ0r9/P6dod2wodwhnf3A0fIHYMwuJPqlgmMunaGARs8yr5kCWLwXl+w
         JAusgMYYPMYQdGakM5Q+AGObqPymFVYUCqqpyps2qSogTLc4YR4eGGIsXoRQVzlpXq
         4RYaVSy721/9g==
Received: by mail-lf1-f51.google.com with SMTP id v25so13743606lfe.12
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 08:19:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpj7wmZ6Y1k2BAMF6tWtya3sM8/2GTgHGhgJZeU5cvCEUEnCyUJ
        6ISrn/rGxcD8C2PmV5qS4ZkC5KhTXkatfp4lm7I=
X-Google-Smtp-Source: AMrXdXuYHaNwScIfkskNKkmspiEZiEpGQ40CciOYXWQFaWWO84rGr8TaB9X20+dlwL6GvWcTYt1yWrRhjY/GAkE+SMI=
X-Received: by 2002:a05:6512:2987:b0:4b5:8f03:a2b6 with SMTP id
 du7-20020a056512298700b004b58f03a2b6mr6935743lfb.643.1673281183634; Mon, 09
 Jan 2023 08:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20230109143716.2332415-1-jolsa@kernel.org>
In-Reply-To: <20230109143716.2332415-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 9 Jan 2023 08:19:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4n4ZM2yF+tDQ8=hicyyRExSyhMkGTT15G8asbBkhyHCg@mail.gmail.com>
Message-ID: <CAPhsuW4n4ZM2yF+tDQ8=hicyyRExSyhMkGTT15G8asbBkhyHCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 9, 2023 at 6:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we allow to load any tracing program as sleepable,
> but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> will fail to load.
>
> Updating the verifier error to mention iter programs as well.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa4c911603e9..121a64ee841a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16743,6 +16743,18 @@ BTF_ID(func, rcu_read_unlock_strict)
>  #endif
>  BTF_SET_END(btf_id_deny)
>
> +static int can_be_sleepable(struct bpf_prog *prog)

Shall we return bool?

> +{
> +       if (prog->type == BPF_PROG_TYPE_TRACING) {
> +               return prog->expected_attach_type == BPF_TRACE_FENTRY ||
> +                      prog->expected_attach_type == BPF_TRACE_FEXIT ||
> +                      prog->expected_attach_type == BPF_MODIFY_RETURN ||
> +                      prog->expected_attach_type == BPF_TRACE_ITER;
> +       }
> +       return prog->type == BPF_PROG_TYPE_LSM ||
> +              prog->type == BPF_PROG_TYPE_KPROBE;
> +}
> +
>  static int check_attach_btf_id(struct bpf_verifier_env *env)
>  {
>         struct bpf_prog *prog = env->prog;
> @@ -16761,9 +16773,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>                 return -EINVAL;
>         }
>
> -       if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> -           prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> -               verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> +       if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> +               verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
>                 return -EINVAL;
>         }

Maybe add a verifier test for this?

Thanks,
Song

>
> --
> 2.39.0
>
