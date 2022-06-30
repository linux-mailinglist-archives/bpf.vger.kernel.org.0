Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A821562740
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiF3XtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 19:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiF3XtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 19:49:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293F50733
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 16:48:18 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cs6so2177053qvb.6
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYQec3qyTF1SRFDLnDJ4RLSVWpQO2iHyZ4ttKEdiyLY=;
        b=qONTj015O6PgdUuCg/09oKb9xLpgsplSfA1BedjwWWiw2bCK1AlP69oKqEYfrfrFAb
         4Op4hFVuJ3RnJ6e2BBjek9yo2mzXXr3r4msbf/4gmIva3LnRSxIFlcg/wAfAApHQnK2B
         hELFX01TsmvCTnxnNSz4w/ZwHe8Ad+6yai9WWHYmGXMGjkaeKn4JqQ0M6h6C8r00+06x
         ppzEiOHthLmYW0vfzx101tAz1E86dcdY2W1AQ6Gjpr87h98KoZZeXg4zCEoKDs3qX8VL
         uLlNiJ113Xs29IKaxuBl7eFQAfaWO/KC4RM2Z4HpPGT7DuTUisaZFstoE9i4EkEtNJ7h
         DIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYQec3qyTF1SRFDLnDJ4RLSVWpQO2iHyZ4ttKEdiyLY=;
        b=cqSpaKl2hO9aGzuQOskK0a6HIZa1JB/7KvIMHaCRBHqoIp/8iYgBbvhsohZNrM8wV4
         MBH8Ow0AsBhAFVOk5jvKUjRgbj9o0oL3FRaCT07HsiHwxDpJ6ZfzVbTkoK34ZFn1k1dn
         S3AW1UO3L8/yKbaOms41aQ934d4BC/CXIyaLPbYwmCbfkLOOGesldcPm9ehSXikUULEp
         HX0fFtEyHbXvW9OPjHpEdjoxJM6ZMnxfD3dkDiWlPZlcr+iFznw0VaARwDz7xsemURvv
         SvHbfY8ZcgVHUK9Rbijp1AQANlz4cD8kMjX3kIqYJigzCQFKchVR9NdTrUcFBlxkVWcj
         nffw==
X-Gm-Message-State: AJIora9s/LzsmEa7kn6CV/MtO/hUrv7e0oIN6GHzCFjdtJcYiR4liq+L
        lovpPi2325uBqS7wiyPB74newiqTolZP0cjKa4jCvg==
X-Google-Smtp-Source: AGRyM1uNU4CKGyXOvXbOFA6e8WVQ5tIXw2D98vS2jNy07LIe/zRb8daOuSqT5uqAYTnP4L5hLv0fYS3g0Z1N8k7IXUQ=
X-Received: by 2002:a05:6214:21ac:b0:470:b625:2bdd with SMTP id
 t12-20020a05621421ac00b00470b6252bddmr15476724qvc.17.1656632897621; Thu, 30
 Jun 2022 16:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220630224203.512815-1-sdf@google.com>
In-Reply-To: <20220630224203.512815-1-sdf@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Jun 2022 16:48:06 -0700
Message-ID: <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stan,

On Thu, Jun 30, 2022 at 3:42 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> With arch_prepare_bpf_trampoline removed on x86:
>
>  #98/1    lsm_cgroup/functional:SKIP
>  #98      lsm_cgroup:SKIP
>  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>
> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index d40810a742fa..c542d7e80a5b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -9,6 +9,10 @@
>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
>
> +#ifndef ENOTSUPP
> +#define ENOTSUPP 524
> +#endif
> +
>  static struct btf *btf;
>
>  static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
> @@ -100,6 +104,10 @@ static void test_lsm_cgroup_functional(void)
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
>         err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
> +       if (err == -ENOTSUPP) {
> +               test__skip();
> +               goto close_cgroup;
> +       }

It seems ENOTSUPP is only used in the kernel. I wonder whether we
should let libbpf map ENOTSUPP to ENOTSUP, which is the errno used in
userspace and has been used in libbpf.

Maybe the right thing is having bpf syscall return EOPNOTSUPP.

But, anyway, this fix looks good to me.

Acked-by: Hao Luo <haoluo@google.com>



>         if (!ASSERT_OK(err, "attach alloc_prog_fd"))
>                 goto detach_cgroup;
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1, "prog count");
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
