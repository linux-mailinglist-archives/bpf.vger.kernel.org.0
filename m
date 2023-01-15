Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500566B422
	for <lists+bpf@lfdr.de>; Sun, 15 Jan 2023 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjAOVWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 16:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjAOVWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 16:22:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAC144A4
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 13:22:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so35491843edd.10
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0nW+/ovccJnuctjNQZ/ok4HmxvE8lBBwahv75JBb100=;
        b=kg1HCgAJtNUh1RBxXOJud2wW7S7H78d6vRjo77hglWW4Wcx+Y/fipk2gS8kqIUBlU8
         6+AIzJQ81sf/X71vhw8l2q/lMrCsp1t4shvQdee651C241o7MJcNM/NPyF1+nWnJmHeG
         7ClgyrleVxlhinG11U/1RXZMzjxHh5LtAiOifkozcAgD3lL8E2VfoOON1XwgyU+R730D
         HO45bEMRExYk3DDVzXf+pq6fXyVG2H4CUV/57EFSCr0gt3ah0+ufHIDTiiklE2wtLge6
         SHnyW8snL5R7BT6GWHO2kPQI3Hi7nXMU6hnO996B2s+VChgjGtGmFUgM/bm/YEp5H8ZH
         7LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nW+/ovccJnuctjNQZ/ok4HmxvE8lBBwahv75JBb100=;
        b=2FsCizx/E6amYfezh0/V/l81osZUFB7yYaeX/2is9OAwL7FZExT3NxnX3CSv1N1Vk+
         u3XpDuQh35Oe/fEetyXXGtIZEuE7BvaPvzgJbou7Hu2c77a4dzsxuGLtkusoO9eGG+e+
         lUcN2TsyKfgsguJBNWIRQBWjUyJtFA0jmXIL20acPQCd/5DtEgMx8l/C5fUV8MMXzWM2
         5iyu8/yfhlHHB6oi9YWBhR+bGlXHGAuF+oLPCseTKOQCveSlN/f9uPq00vMeG1wvAYuo
         aifSdyaXDkCSvh3zgLnbi8ubB20/G/zq9wfnqV9gmkEtxmGkX0pq6TQ+Wy4zgz+eJQu/
         Qg/w==
X-Gm-Message-State: AFqh2kqpO+6JSArusIvJVVrz3OFYlj2QOV5/ifBDzXnoeDfN3mEcdAiJ
        4O7HDXugAEW3Cv2+nqN7ZcRTJTLWbmmEwYLfLTooghXeQzo=
X-Google-Smtp-Source: AMrXdXvCMPPticDBSiZ2FKN/fSIB05ESCtJ2uoQhyVBfJ33y2uJRu4jxGmbiDVk6Qlvtbj0pMcJTayYpiZym2nLewjY=
X-Received: by 2002:aa7:d60b:0:b0:499:d297:4997 with SMTP id
 c11-20020aa7d60b000000b00499d2974997mr2157520edr.94.1673817719948; Sun, 15
 Jan 2023 13:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20230111101142.562765-1-jolsa@kernel.org>
In-Reply-To: <20230111101142.562765-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 15 Jan 2023 13:21:48 -0800
Message-ID: <CAADnVQJgwc3gjLa_Z5OxxW2g7dz0GtFk_aZpx55=k=LV-iiDDw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Wed, Jan 11, 2023 at 2:11 AM Jiri Olsa <jolsa@kernel.org> wrote:
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

imo it's too verbose.
Maybe try a switch stmt ?
Or at least copy prog->expected_attach_type and prog->type into variables.
