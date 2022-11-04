Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0261A088
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 20:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKDTIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKDTIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 15:08:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698825C74
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:08:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id 13so15749503ejn.3
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WMv2UWRZes0/WCag77VIo0o3Ilho5YOtWcXtq4SQgAM=;
        b=LA25+PMaJO5MKpLTfTswSf/PVB6S8l2I6ojPD9FtWhjrW+EJ1AGPMAZglegXVXg0kz
         ETaXFE31z3z8sntSjeC1jNkTqlfj5bfONc82cH+0mlUjh9o3ANCoIVoXf4VQ/EM5tEft
         nhDVn3pdDvXJ0/ludPFJ5SuWiSywgS2oe8TMvKLXgKgM6phDowLabpyRwyts/SEaqk9W
         ecCTjaie5Ay9TASny52lcvWGvW6rRebPKZaLImgRC4TTqNM4I/g7Ec2DHMiE8kRfk90H
         /fLpzq571E+FxOmSUn5tLnrTCmRdQicrHRB/Q3CVxpdjJk312vCV/GclVzUTBSrKLz33
         cI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMv2UWRZes0/WCag77VIo0o3Ilho5YOtWcXtq4SQgAM=;
        b=7e3uigRTNet9kIVR76gKfm6pltxD3HlBpfbZp2eIQ/ooD/Kw2bjoskFzV85T1AJJBf
         RzYwabKBuW61IXSvcJahlj9Y91lPymXdVd6hO0VYup+JLACgczpx0CHkL4GqsqkRqjgc
         wxp1CAMKB5cLvGhVlGtnToykayzX2W42pZfTkrQWKzlqnKU/0no+Mx5oAdFq+rR18RKe
         yCQ6T4TmqMZLdt+gbwN5VQZB0YHIOlgOxyyA4tLSqAzaQMN7m9Qh3SqZaeQP7nMaOQD/
         o01RRiDbdpnhxVxy6O1rnUIdxEc5++/ZPIKBjicYtC1BaoEHEUpuRKSKAVWTJpaBCVbu
         k98Q==
X-Gm-Message-State: ACrzQf0+K+rr6n4fqXzqsAgdIfjAix57q5O0gmB3Y5stkvZB8k+IfEuQ
        4T9ANRwk6tOJg6+I0Fd1KNHaB832GfEbMRg5n38=
X-Google-Smtp-Source: AMsMyM7YE0eG9XH/XTgsT9XxGFeexKma/IwtircHKckgUF+bV59Qx1MKq0E96v2nX+jQPp+7IAYPveMzwEmw+t7IPdM=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr16683429eja.545.1667588918561; Fri, 04
 Nov 2022 12:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221103033430.2611623-1-eddyz87@gmail.com> <20221103033430.2611623-5-eddyz87@gmail.com>
In-Reply-To: <20221103033430.2611623-5-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 12:08:26 -0700
Message-ID: <CAEf4BzZ62SU01V_yQq4Gv0hzv9KPQE5L3WkuKnA8MEV3FaptGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Tests for btf_dedup_resolve_fwds
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
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

On Wed, Nov 2, 2022 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Tests to verify the following behavior of `btf_dedup_resolve_fwds`:
> - remapping for struct forward declarations;
> - remapping for union forward declarations;
> - no remapping if forward declaration kind does not match similarly
>   named struct or union declaration;
> - no remapping if forward declaration name is ambiguous;
> - base ids are considered for fwd resolution in split btf scenario.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++++++++++++++++
>  .../bpf/prog_tests/btf_dedup_split.c          |  45 ++++--
>  2 files changed, 182 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 127b8caa3dc1..f14020d51ab9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -7598,6 +7598,158 @@ static struct btf_dedup_test dedup_tests[] = {
>                 BTF_STR_SEC("\0e1\0e1_val"),
>         },
>  },
> +{
> +       .descr = "dedup: standalone fwd declaration struct",
> +       /*
> +        * // CU 1:
> +        * struct foo { int x; };
> +        * struct foo *a;

I was quite confused what did you mean here.. and I think you meant
just `struct foo;` as FWD, right? But then you also wanted to have
pointers to check ref type resolution, right? And "a" and "b" are
completely unrelated and very misleading, you don't seem to actually
define them.

So why not use typedefs to tie PTR, FWD and STRUCT together? Basically:

// CU1
struct foo { int x; };

struct foo;
typedef struct foo *foo_t;

if you treat this literally, compiler would just omit forward
declaration, so it's not 100% identical, but I think it communicates
intent better. In BTF you can control this better and make sure you
have TYPEDEF -> PTR -> FWD

> +        *
> +        * // CU 2:
> +        * struct foo;
> +        * struct foo *b;
> +        */
> +       .input = {
> +               .raw_types = {
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +                       BTF_PTR_ENC(1),                                /* [3] */
> +                       BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
> +                       BTF_PTR_ENC(4),                                /* [5] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0foo\0x"),
> +       },
> +       .expect = {
> +               .raw_types = {
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +                       BTF_PTR_ENC(1),                                /* [3] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0foo\0x"),
> +       },
> +},
> +{
> +       .descr = "dedup: standalone fwd declaration union",
> +       /*
> +        * // CU 1:
> +        * union foo { int x; };
> +        * union foo *another_global;
> +        *
> +        * // CU 2:
> +        * union foo;
> +        * union foo *some_global;

same, those "global" variables are confusing and are not really
present in BTFs you are testing, so I'd avoid specifying them in
comments

> +        */
> +       .input = {
> +               .raw_types = {
> +                       BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +                       BTF_PTR_ENC(1),                                /* [3] */
> +                       BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
> +                       BTF_PTR_ENC(4),                                /* [5] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0foo\0x"),
> +       },
> +       .expect = {
> +               .raw_types = {
> +                       BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +                       BTF_PTR_ENC(1),                                /* [3] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0foo\0x"),
> +       },
> +},

[...]
