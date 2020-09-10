Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6B264A93
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIJREY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgIJQ4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:56:38 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA51C061795
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:56:28 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 195so4503108ybl.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAhoX5lSQPf8vRqJD430I/KtexX6WEPJiQfEe/TRMok=;
        b=P6bZk+3xcYk4JDIvQcZrAhprohK8LJatgetQWHHNSRMksfjnv439+nJDUnAmMh/gN/
         vicODwzu6xkOujUh7NfcJm/0rsonkTIrAWT+g3kG0l0bQw7FDf9Mof+5x5GyC8js9ELc
         zokGfsPDFXGkGubAygFVYH5SiV8nuyG7G3n/55lRovEBZp+ObypubPjjrJ3azeOOQnu1
         NYr+lpik0rm8qx0qIqwf881OA8PoWNXRiCUR3OOQxggqeR5KMmOUcKarEWMot+c/sHQa
         P4UUDY1NIYYatPsleFqrANuIta/t/yvuMe0ZyHNX9n+s0+5ohg/daewns5Kmux91Ub/f
         nkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAhoX5lSQPf8vRqJD430I/KtexX6WEPJiQfEe/TRMok=;
        b=BMHoh49gOtegzPFOuPjVSixMoSCRHuRt1v1SJD0r4Xhv5TkIeFkNzWa6D0PvTWPkNE
         EmorCvliqzxWppFugIWC5LlWTE6rP2pFBlsTEaY0md3G+zhlfF3kc7pZlRnjRsXZAVm2
         7TfDUlWQ9pv96us2z6Vp29HMy1xh474KFCurRiFnB+s/XM4ZgT9bg5AxMV6mV73beKf/
         65rJHx/SF3ANViYM1clrkWMAQgIrinx8XpeyvePb2MDEC+85NeAER5zZM8qgkSYaOiJL
         9R9qYxzR/TH9LdHArbMvu+FEdz3p1l0aJ8xgpOMAbNiFE0QB7LZCjD0ysa9Z0pY6ZPb/
         Ea0w==
X-Gm-Message-State: AOAM531aPBNo5AZEJHdRoh6VlCMRdotW9bJ7D1uuaRc4uAxnCMb3cG06
        1OAoi/4FIPq0JGGXXFHPzRA2wYvaCwza0H/0Y9bFSU8D
X-Google-Smtp-Source: ABdhPJxmJOlWFPdnAmMZYx0gXkHn9gBWuevnFn2KDNayKvpBVRXdkNA+vi/YM12uauP8inhPe8SX+04KqcMeyFIoxb4=
X-Received: by 2002:a25:7b81:: with SMTP id w123mr14670556ybc.260.1599756988077;
 Thu, 10 Sep 2020 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200909232443.3099637-1-iii@linux.ibm.com> <20200909232443.3099637-4-iii@linux.ibm.com>
In-Reply-To: <20200909232443.3099637-4-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 09:56:17 -0700
Message-ID: <CAEf4BzZbf0r6RuOBCA3JfeQ22S9pRVMoGujxiibVxxnzkYZRLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix endianness issue in sk_assign
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

On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> server_map's value size is 8, but the test tries to put an int there.
> This sort of works on x86 (unless followed by non-0), but hard fails on
> s390.
>
> Fix by using long instead of int.
>
> Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index a49a26f95a8b..402d0da8e05a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -265,7 +265,7 @@ void test_sk_assign(void)
>                 TEST("ipv6 udp port redir", AF_INET6, SOCK_DGRAM, false),
>                 TEST("ipv6 udp addr redir", AF_INET6, SOCK_DGRAM, true),
>         };
> -       int server = -1;
> +       long server = -1;

this would still fail on 32-bit arches, so maybe __s64 instead?

>         int server_map;
>         int self_net;
>         int i;
> --
> 2.25.4
>
