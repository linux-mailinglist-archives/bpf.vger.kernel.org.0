Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF37B26B948
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIPBSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgIPBSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 21:18:37 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384AC06174A
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:18:37 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s19so4131245ybc.5
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QtRPZ4m0Wtszom2bjhalVDPkSCI0C/qplzC2HIEUfY=;
        b=uTLogG6QA5wC4HOKZHvQDF5MqWuFJheLWsFmfMKEJS1s0sM4rTaHaOl2x4+shpSWbq
         rQVmiheEzivUrRukjiWZ9S/LJaUB89agyObDHCEeDlM5lnr4PZ7MlHCXDxsrfO+Oa9p4
         Wc6yv70YC+Ufg44DnOCp979QE1cuCdlItAAEkKX7YVTWeYubcBCQZYcb+LVJ1hV+yiUv
         sHgoghRDvKuRiXgctddxM/r354uvluCSmPSBH0+loDpys5/h4cprK1dNcmbRLuinor2z
         o1WwuNHa5ZkcJRwW6sBJbGA59jFPuOYcl/DIGsr+nKVX3+gtjL12iRSZeMPmLGRaT7hu
         8Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QtRPZ4m0Wtszom2bjhalVDPkSCI0C/qplzC2HIEUfY=;
        b=DLc1aho5HRVMAyuE82S7x8+NKM1IQCyVKMGXgTwcZGdo/9vlDjPTkfBlmv0pwSReAY
         t4d0h2k8F7N1LjoLwpgBsrIwDjG1qmcIf7VRq6XXoIO0W5bJIpaTMdbZZlu4Z+j/Pr/l
         RFyJqu+VYTaqEhaASM0qE8izmueagYPIa6fSbv6tfc4RnWPYp2w5s3NQdvKDZYz5M2uC
         ybMEEWq6Nqv4eWIK2DqDeJ+f3u+wQ9KIt2E+LzCHMTKgo9xWMS+NrRf3liXtUjfF+r3/
         B2SFNsVfPOUdpy0SNnfG+87mKABSaTcwTQLOz9aHbLnVgztSiWN64DU9CKQGZMwcueEI
         Jeew==
X-Gm-Message-State: AOAM531lnDByfx/Tb5tHB1Bp9OggWbtaWbOE2xljdlUWxMXYrUT2b5Zc
        f+ywTbDLzBYSS4wTQSbHQJN9nPqKHO9KVLR18X8=
X-Google-Smtp-Source: ABdhPJy8/KM7myA5mLT6AmA+SYbZPpX9iBHQsUlCtcUnmYcKPJb8WPj9JxNi6R3mtFPuc7bMuB2An2TQFkjEpov5dYs=
X-Received: by 2002:a25:9d06:: with SMTP id i6mr30406676ybp.510.1600219116915;
 Tue, 15 Sep 2020 18:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200915113815.3768217-1-iii@linux.ibm.com>
In-Reply-To: <20200915113815.3768217-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Sep 2020 18:18:26 -0700
Message-ID: <CAEf4BzbJ++yj_-p0Yw+1ki4ZJBGFZXEq_bWi3Cf_H-5bkpnfNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in sk_assign
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 4:38 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> server_map's value size is 8, but the test tries to put an int there.
> This sort of works on x86 (unless followed by non-0), but hard fails on
> s390.
>
> Fix by using __s64 instead of int.
>
> Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> v1->v2: Use __s64.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> tools/testing/selftests/bpf/prog_tests/sk_assign.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index a49a26f95a8b..3a469099f30d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -265,7 +265,7 @@ void test_sk_assign(void)
>                 TEST("ipv6 udp port redir", AF_INET6, SOCK_DGRAM, false),
>                 TEST("ipv6 udp addr redir", AF_INET6, SOCK_DGRAM, true),
>         };
> -       int server = -1;
> +       __s64 server = -1;
>         int server_map;
>         int self_net;
>         int i;
> --
> 2.25.4
>
