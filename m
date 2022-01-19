Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F6A494035
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356923AbiASSw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356925AbiASSw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:52:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E19C06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:52:56 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id b1so3042624ilj.2
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvXD0croW9FPzzfWnZ+OnDNcKGUHtGRkFf7L0x8WUM4=;
        b=kTmcEa4GDPAhtV1sVU0CH8rHH91Atc28nJAkxofjtvMuPJFpxKVSfb7e38mhGP/r3b
         tXHpgBtn58wEy9WE+yUQksEfJzTiteb4hFGDbjKS9c7NdTVCYVRsexk049+6TsqhIqWX
         UYz7+UcUQNvR0If3xOXCrbp2alxlgyzLoEARPqZtZRupTRcwNNfcs7owUSwb5N8+YVIJ
         awLRO/LzkzuNWLri3bqKOaR/V8WtnyEKqzX7tRtEAr/y7nv2rbhny4XbBCJ0TDakmGca
         kWLvc2MOayr3hq2HqEJzLR8S10vNJZ76jfDGR381ps5Zkmc/B24UPub5feu3ui6OcpeS
         G4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvXD0croW9FPzzfWnZ+OnDNcKGUHtGRkFf7L0x8WUM4=;
        b=QNwai0FADhHYXl2V9XeEHWGm8HRIOkIgbPQF0HkkmGZXKexHPDyhXEKV6+hT9/ME4Q
         RPkzJWZ+LxnjAnNPAIGjnNOvkgni2WYNwzqyFui1OjD8BhnFa3wJWTYQi1WI+e+r189f
         ZaKDf2FUqJocrvsQAJYdOYzlVN/BpOCdQQ9PBOE0VKh2zDxFisrADjbEOE0Wol2/hxlR
         zI1Caatg9e7D+zWGvI4nIMAuGcnT296ps5HuY8t3gMHxJ0LxE+epamk0JzRFisH7tQ2Y
         xtp+3x0HiDUXyHLBB2ikMJMHGJVQsN0ecaXY5V63igJzYsCQqVrLRS2xLrZCED4G1cmO
         YH0w==
X-Gm-Message-State: AOAM5315uQre7LqbfqcbXPS2sFEuEJh9sYY8QiYhzYc8D8Ae/bwy7P7c
        JrCS6ViMs1I1ry/5xCB5XXn/Pfu4MOH5ZhzTqs+8sYVt
X-Google-Smtp-Source: ABdhPJwJ+NxG1k9jRyQe5J19xlvccTp7ZTJEF/DGtPB4KviZWgZDWsmTZqY7F9d4qx65AQOAPhehjLuPX6WCiXePJqU=
X-Received: by 2002:a05:6e02:1c01:: with SMTP id l1mr1540888ilh.239.1642618375867;
 Wed, 19 Jan 2022 10:52:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642611050.git.lorenzo@kernel.org> <bd3608faf2e9162cc93d54ee93d2d6737750bb30.1642611050.git.lorenzo@kernel.org>
In-Reply-To: <bd3608faf2e9162cc93d54ee93d2d6737750bb30.1642611050.git.lorenzo@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 10:52:44 -0800
Message-ID: <CAEf4BzafyO6ZnESn_hk56FX6MZoHdfTU6e33_FECv91Y7GFnew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 8:58 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Rely on ASSERT* macros and get rid of deprecated CHECK ones in
> xdp_adjust_tail bpf selftest.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 62 +++++++------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> index 3f5a17c38be5..dffa21b35503 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> @@ -11,22 +11,19 @@ static void test_xdp_adjust_tail_shrink(void)
>         char buf[128];
>
>         err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
> -       if (CHECK_FAIL(err))
> +       if (ASSERT_OK(err, "test_xdp_adjust_tail_shrink"))
>                 return;
>
>         err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
>                                 buf, &size, &retval, &duration);
>
> -       CHECK(err || retval != XDP_DROP,
> -             "ipv4", "err %d errno %d retval %d size %d\n",
> -             err, errno, retval, size);
> +       ASSERT_OK(err || retval != XDP_DROP, "ipv4");

it's better to do such checks as two ASSERTS: ASSERT_OK(err) and
ASSERT_EQ(retval, XDP_DROP). It will give much more meaningful error
messages and I think is easier to follow.

>
>         expect_sz = sizeof(pkt_v6) - 20;  /* Test shrink with 20 bytes */
>         err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
>                                 buf, &size, &retval, &duration);
> -       CHECK(err || retval != XDP_TX || size != expect_sz,
> -             "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
> -             err, errno, retval, size, expect_sz);
> +       ASSERT_OK(err || retval != XDP_TX || size != expect_sz, "ipv6");

same as above, old CHECK printed all those values so it was ok-ish to
combine checks. With ASSERT_XXX() let's do each error condition check
separately. Same for all the rest below.

> +
>         bpf_object__close(obj);
>  }
>

[...]
