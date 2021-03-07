Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB67B32FE8E
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 04:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCGDXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Mar 2021 22:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhCGDXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Mar 2021 22:23:18 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19AC06174A
        for <bpf@vger.kernel.org>; Sat,  6 Mar 2021 19:23:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b10so6463860ybn.3
        for <bpf@vger.kernel.org>; Sat, 06 Mar 2021 19:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRSSShO6D7Ou8Ikm85XSnRNta330or2s58QVGdeeo1s=;
        b=BLfJg2BkJKwYvv569mcZwtmWnUsc34HK9zqVKCrYRsdol3wBpHVYzFLqkOpXQV7oEG
         /D7RuZMOxelX1DpOoPrALz9bg4NtOUU1EFOdrIaSD4RIv7XkVf8QgkfRuEdhlDLJQFOj
         uq/zUWRMHovIeA20N7NZhrZ00UL7mRE2vJipx5vW4n6Zxox2VyUz0g12l4eqa788oxfp
         r3aOo8euruRlAEFwDaG8HMJP+oLN8LIVSUpjEaqsqAJpxorLq9gjcT8qGcyYuuZjREgQ
         5zdoreE47zXDHNjwMEVhWrud2c4oLj0L2P4x2nWIJLm520GK3/wTjNROjZ3yGYYYrTor
         1pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRSSShO6D7Ou8Ikm85XSnRNta330or2s58QVGdeeo1s=;
        b=QLlD9Pg9CfL7+m4XaNJDe7XIkdd7ta6Xme9/HjkID+0P+mYPS8F8tNY9Au9YOp4ICb
         UJN9eUdWAcwmyiCFz1wXkDCA20MIouf8iergSJxLvT2P2GtVMjcLGcfc/C+N4P30OKBu
         qG8Mze0Q7j2askCFscaUvdpUZpY2Sfelxu41HWiyIzFoiTxCeSptQJ1U3MQbNhxXZbWD
         ux07PmHuFDCH8n2dNNBLfPjM9gi+BHV3YrHqCWkddGJRAYIOc+9utq3w6BIRP773vIkW
         7hnVG0aNOe5mSNZa6g1UyQs45O6bWSw13QBiB2wGAqPdkDi9rk604dll86kb7di+jEeP
         Vw7g==
X-Gm-Message-State: AOAM531KLY4ETxcib+RuEy1r5BG9rsupqO1Zs+H8hE+tr4zKLzSRX0Ww
        9tAF0BS21fB3DQtwpTigHXWlXGgVX5ra0CKDUgw=
X-Google-Smtp-Source: ABdhPJwf01qgnlXy4lU389jyD0fga9ZUzpsgYIRfF6uJIMXPULs47urQkrnKUlyl1jf2ib2uygvnVPkwoB6wVmzpWqY=
X-Received: by 2002:a25:bd12:: with SMTP id f18mr24074318ybk.403.1615087397028;
 Sat, 06 Mar 2021 19:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20210305170844.151594-1-iii@linux.ibm.com> <20210305170844.151594-3-iii@linux.ibm.com>
In-Reply-To: <20210305170844.151594-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Mar 2021 19:23:05 -0800
Message-ID: <CAEf4BzayUW4-0mX6XCHeMif9mquqCbOGNMPJ_=VpV+YM6JzXyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add BTF_KIND_FLOAT to btf_dump_test_case_syntax
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 5, 2021 at 9:09 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Check that dumping various floating-point types produces a valid C
> code.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../selftests/bpf/progs/btf_dump_test_case_syntax.c        | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> index 31975c96e2c9..09d8d1e01ed6 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> @@ -205,6 +205,12 @@ struct struct_with_embedded_stuff {
>         int t[11];
>  };
>
> +struct float_struct {
> +       float *f;

just for a bit more diversity, try this one without a pointer?

> +       const double *d;
> +       volatile long double *ld;
> +};
> +
>  struct root_struct {
>         enum e1 _1;
>         enum e2 _2;
> @@ -219,6 +225,7 @@ struct root_struct {
>         union_fwd_t *_12;
>         union_fwd_ptr_t _13;
>         struct struct_with_embedded_stuff _14;
> +       struct float_struct _15;
>  };
>
>  /* ------ END-EXPECTED-OUTPUT ------ */
> --
> 2.29.2
>
