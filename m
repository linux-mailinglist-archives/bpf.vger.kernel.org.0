Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D34B186F
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbiBJWm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:42:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbiBJWm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:42:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6816E26D4
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:42:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z18so5605069iln.2
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xh+NYF4m3jc7CKjUczD22891+y6dmYsMjUQKIrgDRTE=;
        b=oS5zG0df3k/mL4XgF2NPR0zfRo8VUor8l+gnOCnYQH0+P6f3120yRnSnBnsiI3II+G
         4g3Ur2yR2I7NxgtPnRfNao0do8dTmnhiRylwOzsbV0tsDxwklFJX7Ed3YxK7F36gs6xY
         522sMULefd9PKOtMuqBBbYUuIo31wI+Pd5cVBloHhFX5W+czcZXAArGKfQCwVMjdSYXb
         CfpOuodFMhKgnb8uoL4fdutVSoRo7wBsiJnLQSd/0aCIaZcXNw45AjfkbwNgU8pU8jgT
         nmjghG2hEmdBFX0rrRFJ05TgTHQ7iACUmQ2ROgHUfvuOqapp8V5/XO7nJ/YDEdtgRTg1
         vZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh+NYF4m3jc7CKjUczD22891+y6dmYsMjUQKIrgDRTE=;
        b=hDllJd3WhyAGLKtZ9S7999WfthbNu2h7tJbkJB/r1xnnd3KJwoRXlzwsx4cgF280ia
         SVlhZDdxTa5ggvmPoeZtHOWEa8zD8hRcD0aZw86kcjW3stAby24NHalOOxXBUlycsjxV
         B5zpFHG6dSuj6GVfb/XBduw09JWWtHtnGvkMvCw/YEoueUp8zt/Dep7SidvLfNQihMY6
         LJpHa4jKMyqNgfSh139CDIis54eZJyJ3Mjr9SpwCn98psRvm2wnhs016IASy2YZ5gRhP
         ssNhJFy+FhEKSYIpQLglwBWCiu9UbkHAHzivWiGM2izc+1cZiQEAJaZq0FSEihdjDuzT
         av/A==
X-Gm-Message-State: AOAM530ZqVHwAN+BuKlolHByC1TN/ZvRFug44yE50bLyrbks6cyqc5xu
        f2LpKLirhZUQa6N4PNeCGMg3PWK1ZRdmt1jauQM=
X-Google-Smtp-Source: ABdhPJxIp9b8ApD+eINsYXlSyxBeSHXtkuarS5Ihs0araOjzRv6wzNLBoclk6aDAO1iRcudMeucZeg5djwH8SPJzzVk=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr4886608ilv.252.1644532945809;
 Thu, 10 Feb 2022 14:42:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <b904faaff6e8a04809e722d33e062ad47e97c84e.1644453291.git.delyank@fb.com>
In-Reply-To: <b904faaff6e8a04809e722d33e062ad47e97c84e.1644453291.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Feb 2022 14:42:14 -0800
Message-ID: <CAEf4BzaCRjik0wA+SjOjO8Yp9Nju-2trxCq_y_izQiTnR5qeNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpftool: skeleton uses explicitly sized ints
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Feb 9, 2022 at 4:37 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> As reported in [0] and [1], kernel and userspace can sometimes disagree
> on the definition of a typedef (in particular, the size).
> This leads to trouble when userspace maps the memory of a bpf program
> and reads/writes to it assuming a different memory layout.
>
> This commit now uses the libbpf sized ints logic when emitting the
> skeleton. This resolves int types to int32_t-like equivalents and
> ensures that typedefs are not just emitted verbatim.
>
> The drive-by selftest changes fix format specifier issues
> due to the definitions of [us]64 and (u)int64_t differing in how
> many longs they use (long long int vs long int on x86_64).
>
>   [0]: https://github.com/iovisor/bcc/pull/3777
>   [1]: Closes: https://github.com/libbpf/libbpf/issues/433
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/bpf/bpftool/gen.c                          |  3 +++
>  .../testing/selftests/bpf/prog_tests/skeleton.c  | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index eacfc6a2060d..18c3f755ad88 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -146,6 +146,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
>                         .field_name = var_ident,
>                         .indent_level = 2,
>                         .strip_mods = strip_mods,
> +                       .sizedints = true,
>                 );
>                 int need_off = sec_var->offset, align_off, align;
>                 __u32 var_type_id = var->type;
> @@ -751,6 +752,7 @@ static int do_skeleton(int argc, char **argv)
>                 #ifndef %2$s                                                \n\
>                 #define %2$s                                                \n\
>                                                                             \n\
> +               #include <inttypes.h>                                       \n\

if Alexei's patch set will go in first (very likely), you'll need to
rebase and make sure that you don't include either inttypes.h or
stdint.h for kernel mode, as those headers don't exist there


>                 #include <stdlib.h>                                         \n\
>                 #include <bpf/bpf.h>                                        \n\
>                 #include <bpf/skel_internal.h>                              \n\
> @@ -770,6 +772,7 @@ static int do_skeleton(int argc, char **argv)
>                 #define %2$s                                                \n\
>                                                                             \n\
>                 #include <errno.h>                                          \n\
> +               #include <inttypes.h>                                       \n\

seems like inttypes.h just includes stdint.h, I'd just include stdint.h directly

>                 #include <stdlib.h>                                         \n\
>                 #include <bpf/libbpf.h>                                     \n\
>                                                                             \n\
> diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> index 180afd632f4c..9894e1b39211 100644
> --- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> +++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> @@ -43,13 +43,13 @@ void test_skeleton(void)
>         /* validate values are pre-initialized correctly */
>         CHECK(data->in1 != -1, "in1", "got %d != exp %d\n", data->in1, -1);
>         CHECK(data->out1 != -1, "out1", "got %d != exp %d\n", data->out1, -1);
> -       CHECK(data->in2 != -1, "in2", "got %lld != exp %lld\n", data->in2, -1LL);
> -       CHECK(data->out2 != -1, "out2", "got %lld != exp %lld\n", data->out2, -1LL);
> +       CHECK(data->in2 != -1, "in2", "got %"PRId64" != exp %lld\n", data->in2, -1LL);
> +       CHECK(data->out2 != -1, "out2", "got %"PRId64" != exp %lld\n", data->out2, -1LL);

we don't use PRIxxx ugliness anywhere in selftests or libbpf code
base, it would be easier to just convert this to ASSERT_EQ()

>
>         CHECK(bss->in3 != 0, "in3", "got %d != exp %d\n", bss->in3, 0);
>         CHECK(bss->out3 != 0, "out3", "got %d != exp %d\n", bss->out3, 0);
> -       CHECK(bss->in4 != 0, "in4", "got %lld != exp %lld\n", bss->in4, 0LL);
> -       CHECK(bss->out4 != 0, "out4", "got %lld != exp %lld\n", bss->out4, 0LL);
> +       CHECK(bss->in4 != 0, "in4", "got %"PRId64" != exp %lld\n", bss->in4, 0LL);
> +       CHECK(bss->out4 != 0, "out4", "got %"PRId64" != exp %lld\n", bss->out4, 0LL);

[...]
