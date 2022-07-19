Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082457A862
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiGSUkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbiGSUkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:40:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD43B1D1
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:40:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so81194pjl.5
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OC6NSncubbo54zJwS4jqbRy+27bSdBUqKTObeoC6G/s=;
        b=f5Rnr19BgdjeCuPPX5SztiBl+D20YhCj8LLpNJhGusCW1CsxlAbgOeeY5ILg4cCN0d
         wbcIONy5qm95eyXkg6CezAgmXLtpMkSHRDnC3KYse9lW+aomXBePTd46+xmh+AB8HWE8
         mXE/Me1v9/AAxfJLIfwUTqHHC3SxctKcLA3YWdGWvUh3KIJtNu6grhYdhnoFciLd/X7Q
         9UYQD4XYzRkwFHHXh1EF8//r1JwSYNmQH4rCTvmE0sJ1IRRm47mj1zERkl4L6wMhKW/h
         KTbydvaduodEYSgCmA9G8AWv8/p0o1M3uoieULcgl2Xu/h0ewCsrfOaC5E7eT0KmJNq7
         I3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OC6NSncubbo54zJwS4jqbRy+27bSdBUqKTObeoC6G/s=;
        b=34EaePd3XahPnPeQLUFs1d/I0IjaMjPP5jPj6FCl3pg0w1t03YpNA3/GFRJif6/ker
         R4XyHS0sQ97EcoaCbnhS3GR4/w2o3KKEAhuHB0X5ZLVOC6XGdgYrFG3sGdAH/YlSisnp
         Ik8mChz4Fc25/GnfsEiO7uOSjOno1CkKeYPM/oJtVoItQONEYOHl9+b2e8vHcA9rS4KV
         RCG7/FCxsiLMPnZvOk/ZNBlqBZqNZ1Dhrlh+kE4zVfb3E9hFe8j5FNoUcVxzkLaajcDA
         6DY2vU8V8zBKp9TWCvcgZdUTLGPtwy6b4T8xjhBzT4Z9XQM5mjps9sAeohj7zF+1DxHb
         o7fQ==
X-Gm-Message-State: AJIora+ZXrNzOFISG+G4faiABWV4WBsLcEAXVk6IMuyfSr50HSME9cIh
        ANA6TmDaPyMX7vwFt3OLRO5EH5JOzgdhD+pcfIIZbw==
X-Google-Smtp-Source: AGRyM1uLtQY2Guu1CcxG7wrE2WtJcC+VP2deAiAOkkuOHmJ30YHQnxMCaYLdUf+McUMo6Mz6HOmTEE/R5opYBHFl0Tw=
X-Received: by 2002:a17:903:244d:b0:16c:5bfe:2e87 with SMTP id
 l13-20020a170903244d00b0016c5bfe2e87mr34944034pls.148.1658263213708; Tue, 19
 Jul 2022 13:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
In-Reply-To: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Jul 2022 13:40:02 -0700
Message-ID: <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Burton <jevburton@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jul 19, 2022 at 12:40 PM Joe Burton <jevburton.kernel@gmail.com> wrote:
>
> From: Joe Burton <jevburton@google.com>
>
> Add an extensible variant of bpf_obj_get() capable of setting the
> `file_flags` parameter.
>
> This parameter is needed to enable unprivileged access to BPF maps.
> Without a method like this, users must manually make the syscall.
>
> Signed-off-by: Joe Burton <jevburton@google.com>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

For context:
We've found this out while we were trying to add support for unpriv
processes to open pinned r-x maps.
Maybe this deserves a test as well? Not sure.

> ---
>  tools/lib/bpf/bpf.c      | 10 ++++++++++
>  tools/lib/bpf/bpf.h      |  9 +++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 20 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5eb0df90eb2b..5acb0e8bd13c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
>  }
>
>  int bpf_obj_get(const char *pathname)
> +{
> +       LIBBPF_OPTS(bpf_obj_get_opts, opts);
> +       return bpf_obj_get_opts(pathname, &opts);
> +}
> +
> +int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts *opts)
>  {
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_obj_get_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, sizeof(attr));
>         attr.pathname = ptr_to_u64((void *)pathname);
> +       attr.file_flags = OPTS_GET(opts, file_flags, 0);
>
>         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
>         return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 88a7cc4bd76f..f31b493b5f9a 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
>                                     __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);
>
> +struct bpf_obj_get_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibility */
> +
> +       __u32 file_flags;
> +};
> +#define bpf_obj_get_opts__last_field file_flags
> +
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
> +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> +                               const struct bpf_obj_get_opts *opts);
>
>  struct bpf_prog_attach_opts {
>         size_t sz; /* size of this struct for forward/backward compatibility */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 0625adb9e888..119e6e1ea7f1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
>
>  LIBBPF_1.0.0 {
>         global:
> +               bpf_obj_get_opts;
>                 bpf_prog_query_opts;
>                 bpf_program__attach_ksyscall;
>                 btf__add_enum64;
> --
> 2.37.0.170.g444d1eabd0-goog
>
