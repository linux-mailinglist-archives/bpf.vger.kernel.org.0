Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDB324600
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 22:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhBXV4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhBXV4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 16:56:24 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA13C06174A
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 13:55:44 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u75so3357748ybi.10
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHA9bfLresQzPLzSgfYkYmFfLD1OHGX99sQYG3VhXf8=;
        b=QwGrhxqyPm4lyAtdfIqdJDPig71wv683J1cXjpAm91etjIFFXg5OZ/AzfUITt04cxX
         61G2+XPf+YXfdFLR7w+7TzBFDAbhQ0HOqFVzcCN0cnOmmGiQ5ChTnZAxAeK1in7tD3ws
         /vLgiq3GHOdrK5jzJTU70QkzcrSt5/gLtG5AOksOpscNLRdXXeu8fDYJWCCQeA6SpXt3
         /afgfWgijMXCk0DNfyNc3wHpsIpnRCxNoZLPCx+hYJ5Kza8rAUqVD7frZZFPQWtfwg6N
         5WmK84CLejZNb3aBUKS9g5AMi0yfaOw4QebQXawNFZCUaBOOW9mJsh5eArWHG631WOXJ
         WUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHA9bfLresQzPLzSgfYkYmFfLD1OHGX99sQYG3VhXf8=;
        b=FvOcF9jmTMe9et1LHc30IqKFJFRhB2Y5quobz9LdbAPXYtSwiZ2T2VgQaY08DpNb1V
         T1M1+qtVXn1REfpaQNpbQhnQ+S3W5n1d4WoZRYpGg/m4/JwvOmr5zEsS8f7pY+RGv5TP
         1OoyZigzaHSdVq7nS3JmjcOUSqjHwLLmb99uzFWyA36+nHkmlF42/OBMk0TTZxEwcLZc
         5j82jlZQLRoRFNXxo2r5o1D8cxv+TnYjXcchUMmNQFclfh8MI7Kk02JLssbCf0Aajlnw
         IRV4nIp0ptVkLnifUQ+0Y4GIgQIJTtBTjTTykP+v1O7/VhLqa1oBXJe8LabfqkuqzRiM
         AE7Q==
X-Gm-Message-State: AOAM5334UEoUJjKs+GtX/XdLZS6j3EljpYiFQ9g7sJii5jL/abI4HBHn
        noh6kJpfo9cFrFZAeodxka8vOFWbtB8xuzc3WFQ=
X-Google-Smtp-Source: ABdhPJwdUjKxg97yoninB3pGEamm9EHpPWQYOKdcO/buwT2t36HSQwds6eJLkMHIUhqyB8P0oWofjnKLemf5CTgQ/V8=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr21358203ybf.260.1614203743429;
 Wed, 24 Feb 2021 13:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20210223231459.99664-1-iii@linux.ibm.com> <20210223231459.99664-7-iii@linux.ibm.com>
In-Reply-To: <20210223231459.99664-7-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Feb 2021 13:55:32 -0800
Message-ID: <CAEf4BzZXvokRMWqDrOg2JWFPr+caNjG=yeCM-W_9cDhkVraRPg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 6/8] selftest/bpf: Add BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 3:15 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Test the good variants as well as the potential malformed ones.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>  tools/testing/selftests/bpf/prog_tests/btf.c | 129 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  3 files changed, 136 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
> index 48f90490f922..b692e6ead9b5 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c
> @@ -23,6 +23,7 @@ static const char * const btf_kind_str_mapping[] = {
>         [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
> +       [BTF_KIND_FLOAT]        = "FLOAT",
>  };
>
>  static const char *btf_kind_str(__u16 kind)
> @@ -173,6 +174,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>                 }
>                 break;
>         }
> +       case BTF_KIND_FLOAT:
> +               fprintf(out, " size=%u", t->size);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index c29406736138..3a8ceb8db20f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3531,6 +3531,134 @@ static struct btf_raw_test raw_tests[] = {
>         .max_entries = 1,
>  },
>
> +{
> +       .descr = "float test #1, well-formed",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1] */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                /* [2] */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 4),                /* [3] */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 8),                /* [4] */

nit: 12-byte for completeness?


> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 16),               /* [5] */
> +               BTF_STRUCT_ENC(NAME_TBD, 4, 32),                /* [6] */
> +               BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +               BTF_MEMBER_ENC(NAME_TBD, 3, 32),
> +               BTF_MEMBER_ENC(NAME_TBD, 4, 64),
> +               BTF_MEMBER_ENC(NAME_TBD, 5, 128),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0_Float16\0float\0double\0long_double\0floats"
> +                   "\0x\0y\0z\0_"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 32,
> +       .key_type_id = 1,
> +       .value_type_id = 6,
> +       .max_entries = 1,
> +},

[...]
