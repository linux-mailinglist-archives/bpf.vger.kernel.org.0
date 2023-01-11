Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF76661BE
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjAKRZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbjAKRYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 12:24:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3E3F13F
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 09:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCF8D61DB1
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B75C433D2
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673457736;
        bh=FP2FnhP1QvjFsheIERrvEoQhr5VEmzjlXXkhJqMugJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wg6C+j1T3sSxQk0BJjc6WOUHch/xeUHNSfOPFqNpJpRu3ETdpvZmH+6U/V90cQj2Q
         CxZHI8wVKnHEWekkwRxB2TejSb2dayGj6lGnQKv+mmp2baSBBtCPyc8NqbUTZFOMRz
         IcGMk+W2tZxqDEKBtAuyjrHUYPECNwF8OBmcoCF2TzNA/bNrHdSpzfcQLT8t4mnMsM
         CToNYPiDtF0idtxnsTa0jNrY+0HORyBVgQMzk9A6VS359T4cyQpLfDcrKpZnsGEXIA
         y39uPcfsqpRuLQmpy8YgSlKL822pYXh+HcermuVg8woBAVIVlMv+tF/39YisRh839b
         xWPpwwqCO4/Aw==
Received: by mail-lj1-f173.google.com with SMTP id s22so16719570ljp.5
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 09:22:16 -0800 (PST)
X-Gm-Message-State: AFqh2krsqCsk/b3g1WWURsHzUDAirO8/qldzor3Hx4tlF5bWkvVXBN1D
        QZrhWLI9Tf6lpEMS8/bH3rIjIsu4V9orOIxjsPQ=
X-Google-Smtp-Source: AMrXdXtuk7i1GnSUpySjbF1/fm8a0ds7bHQXAAVWxrGG9OVNWN2ry4C6YiblaV3cx1kq8Oswfna6YZbB0bbSIhXs3yA=
X-Received: by 2002:a2e:a26a:0:b0:285:3383:6635 with SMTP id
 k10-20020a2ea26a000000b0028533836635mr831505ljm.323.1673457734226; Wed, 11
 Jan 2023 09:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20230111101142.562765-1-jolsa@kernel.org>
In-Reply-To: <20230111101142.562765-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 11 Jan 2023 09:22:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7iznowc65UKQ_5oN6MPnfYrWWRn2G7-P3=4zbiqVxT+w@mail.gmail.com>
Message-ID: <CAPhsuW7iznowc65UKQ_5oN6MPnfYrWWRn2G7-P3=4zbiqVxT+w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Do not allow to load sleepable
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

On Wed, Jan 11, 2023 at 2:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we allow to load any tracing program as sleepable,
> but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> will fail to load.
>
> Updating the verifier error to mention iter programs as well.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
> v2 changes:
>   - use bool for can_be_sleepable return value [Song]
>   - add tests [Song]
>
>  kernel/bpf/verifier.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa4c911603e9..f20777c2a957 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16743,6 +16743,18 @@ BTF_ID(func, rcu_read_unlock_strict)
>  #endif
>  BTF_SET_END(btf_id_deny)
>
> +static bool can_be_sleepable(struct bpf_prog *prog)
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
>
> --
> 2.39.0
>
