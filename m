Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59821149D
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGAUyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAUyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:54:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07112C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 13:54:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so19610049qtq.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUzPEedrZfxHTuGNM+CtEDSJO7aB9PR9Ziy/8hq3fyk=;
        b=FCaIYCInpcoKg8NABvAX8yD+EuuVOsTDHsdrAFTvV1yT45/Pu017LYQDKbWezqDIgY
         5ZFzSo/GAkyHwjxtfm2R5BztHpaCbmtEA+OicSEKEk1wGTFF0H39sOFk7OBNd0kgRJzm
         pT9nE67SwFOu3OSjnqxKkBLw0gKjTPAi1ys4ug3rrImLJVXD6b6NlKACfrSfhkX8fskw
         QKQ3qTnIF142+ligN7Pdtu6+OgJzfME0FhC99Ldnh2CXNsVOIfij+IPIN+59pMRZcwL+
         EMcCJ0iBHnOXepzFVv2w0k2dh/Zm56M3mEhXUW/sfUVt1KYuDu5pBG4o5kC4sZShcPwd
         4eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUzPEedrZfxHTuGNM+CtEDSJO7aB9PR9Ziy/8hq3fyk=;
        b=XzgnsGNBz3KEYz7Nkig6ImDfuaBYtlpFYWo1KIeTH/QC8dYVZxK1Htrx5hTWbONUJT
         oKayX7EcSFUvcDGP+8TzFGRvP9zcPdynXbhcVJOwhSlJUz9F/WtBEYzzvKyAbnVPq+a+
         mFadPQfX9LzGOvtr8VSTuazTXtKjDSUI8GmZWQ87xHTB/jxEdnRlEgYKsAsL0oyT+eoY
         vunvGexuOepansZCz/GCA6s12ha+NA89v9/ovNkKZ21N0o6ofe/lBa5w6l8iPcZ7cjHy
         byJvufQT7UmebPSMhOdvTtW/67jP7qZFhZ9L8iJOYF6NkQE1kzStTPWCXwgdL4KFAlBP
         J5jw==
X-Gm-Message-State: AOAM530btYuiqnuzaenbj/HI/xGr6B2artdXZ+76WxIqCn+xKv3TFQYY
        vetvgKnWMPgwfdBAzZSDdoC73NfihelqKTAHXmc=
X-Google-Smtp-Source: ABdhPJwsNFyWKeIRZKdeOp/aiUpoTahYX6zTBU11vrxFMR27eq8ZcqSbvc4AipzA8/HqqQceWilQXLBxPCqmblXxhnk=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr26957750qtj.93.1593636892188;
 Wed, 01 Jul 2020 13:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <159363468114.929474.3089726346933732131.stgit@firesoul> <159363474925.929474.15491499711324280696.stgit@firesoul>
In-Reply-To: <159363474925.929474.15491499711324280696.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jul 2020 13:54:41 -0700
Message-ID: <CAEf4BzYXAHMC=7DTEzqH563zuMsuZuMbDaBPN9TmX4P8PG49jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 3/3] selftests/bpf: test_progs indicate to
 shell on non-actions
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 1:19 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> When a user selects a non-existing test the summary is printed with
> indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
> indicated. This can be understood by a human end-user, but for shell
> scripting is it useful to indicate a shell failure (EXIT_FAILURE).
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 3345cd977c10..75cf5b13cbd6 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -706,11 +706,8 @@ int main(int argc, char **argv)
>                 goto out;
>         }
>
> -       if (env.list_test_names) {
> -               if (env.succ_cnt == 0)
> -                       env.fail_cnt = 1;
> +       if (env.list_test_names)
>                 goto out;
> -       }
>
>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> @@ -723,5 +720,9 @@ int main(int argc, char **argv)
>         free_str_set(&env.subtest_selector.whitelist);
>         free(env.subtest_selector.num_set);
>
> +       /* Return EXIT_FAILURE when options resulted in no actions */
> +       if (!env.succ_cnt && !env.fail_cnt && !env.skip_cnt)
> +               env.fail_cnt = 1;
> +

Heh, just suggested something like this in the previous patch. I think
this change should go first in patch series and not churn on
env.list_test_names above.

I'd also rewrite it as (no need to muck around with fail_cnt, less
negation for integers):

if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
    return EXIT_FAILURE;

>         return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
>  }
>
>
