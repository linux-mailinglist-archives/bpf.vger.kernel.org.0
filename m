Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3FF4B18B9
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiBJWoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbiBJWoj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:39 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8CE5589
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:44:39 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 9so9365753iou.2
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvRFZxbWx8Kdu/daxRGkkgrusYNwZaQrBCXKGMaiTng=;
        b=KCcw/iVrm0U8RBWxe7XIhVS3kO96BZt7jpg5iVSg5KdNu6uMfXVEHliO9Mth0O8JkU
         tO2rAW98woTrqYmc3ut4XRJjsnDITNs9gL16xcdhxHA8FaemHMhFPN2luZQfpvhw4viN
         Y7e1sfGPBoEgH5enrgKYNJilUlnsoYQpLlFisLOnwhCOaJiZHjYGxqpywtxo0tAwGChA
         kPcwt6fqkkPw5jlhXYPqmzZjmNKxaJTVmknESCUDxPdwoKY2wBipCjYvQqpJQ7xV2B1Z
         cvCFtWDXj3fLaRhOzAmeDKjIwtZiQ3DrNDScdcBrF+lt/MvgkXXMqGwqOcpIXdV2+cdl
         OFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvRFZxbWx8Kdu/daxRGkkgrusYNwZaQrBCXKGMaiTng=;
        b=6BwBjEEYxNqeMdupgmchoQQZ7hn1b54CUfZy6kVb1LKNKtS6TleovM+3YfBEgDaLBW
         7X/vYT1g+SrC0SFUq0xEJ2BPECP/pngrixUjEtcWCLzHOscvWifCp+2DRY94ATWb1BYd
         /29PbbgTmuV1WTicWUQLfctnUlr0h3ZtpXn5rAdpI+/DP4e5IdaLQJenbBn8mlV9y8tD
         9FiUUW6i7hw+5/7tMhkp3Yc0hP1dtcoJVDd8BJ9kEfAdRbPtI7+AD/n3tk8xCqvTIoOI
         iilS8kisns4h4Hj/DXk8Iy1SPgpF4ButYxOO+17kzzozYlav0Fj+Y20VJ7Qa8zdnvbKb
         Uc+g==
X-Gm-Message-State: AOAM532XIz0VCtcjY2wYE8k4i1NY8r89wIUgX1zT9FAZnnExuHdZ9rEP
        QlCJcm5xQBl3BT27z/+UplZ/54b3g23yrCdRIFA=
X-Google-Smtp-Source: ABdhPJwEOpf/4LnFyxAcGOpp0ukuJpbhbQWwgpRezitZxrHiIuT8VGiXGAgFAbXVkgyjajuJmg5l5SDohC6gK44xTWQ=
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr5460745jak.103.1644533078863;
 Thu, 10 Feb 2022 14:44:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <dcb8cfcd9946a937b8d4a93b9c42eaf3aad54038.1644453291.git.delyank@fb.com>
In-Reply-To: <dcb8cfcd9946a937b8d4a93b9c42eaf3aad54038.1644453291.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Feb 2022 14:44:27 -0800
Message-ID: <CAEf4BzbJvZyAfdY4+kFSBzBv=-dXQU=2Y7EfjwnTB++d_b=SJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test case for
 userspace and bpf type size mismatch
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
> Multiple test cases already fail if you add a type whose size is
> different between userspace and bpf. That said, let's also add an
> explicit test that ensures mis-sized reads/writes do not actually
> happen. This test case fails before this patch series and passes after:
>
> test_skeleton:FAIL:writes and reads match size unexpected writes
> and reads match size: actual 3735928559 != expected 8030895855
> test_skeleton:FAIL:skeleton uses underlying type unexpected
> skeleton uses underlying type: actual 8 != expected 4
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/skeleton.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/test_skeleton.c | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> index 9894e1b39211..bc07da929566 100644
> --- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> +++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> @@ -97,6 +97,9 @@ void test_skeleton(void)
>
>         skel->data_read_mostly->read_mostly_var = 123;
>
> +       /* validate apparent 64-bit value is actually 32-bit */
> +       skel->data->intest64 = (typeof(skel->data->intest64)) 0xdeadbeefdeadbeefULL;
> +
>         err = test_skeleton__attach(skel);
>         if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>                 goto cleanup;
> @@ -126,6 +129,9 @@ void test_skeleton(void)
>         ASSERT_OK_PTR(elf_bytes, "elf_bytes");
>         ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
>
> +       ASSERT_EQ(skel->data->outtest64, skel->data->intest64, "writes and reads match size");
> +       ASSERT_EQ(sizeof(skel->data->intest64), sizeof(u32), "skeleton uses underlying type");
> +
>  cleanup:
>         test_skeleton__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
> index 1b1187d2967b..fd1f4910cf42 100644
> --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> @@ -16,6 +16,13 @@ struct s {
>  int in1 = -1;
>  long long in2 = -1;
>
> +/* declare the int64_t type to actually be 32-bit to ensure the skeleton
> + * uses actual sizes and doesn't just copy the type name
> + */
> +typedef __s32 int64_t;
> +int64_t intest64 = -1;
> +int64_t outtest64 = -1;

This will be so confusing... But when you drop __s32 special handling
you can just use __s32 directly, right?


> +
>  /* .bss section */
>  char in3 = '\0';
>  long long in4 __attribute__((aligned(64))) = 0;
> @@ -62,6 +69,7 @@ int handler(const void *ctx)
>         out4 = in4;
>         out5 = in5;
>         out6 = in.in6;
> +       outtest64 = intest64;
>
>         bpf_syscall = CONFIG_BPF_SYSCALL;
>         kern_ver = LINUX_KERNEL_VERSION;
> --
> 2.34.1
