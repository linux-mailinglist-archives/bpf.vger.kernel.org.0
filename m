Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08CE24E097
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHUTS3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUTS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 15:18:28 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7EC061573
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:18:27 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id u6so1600812ybf.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwQYi7yPTRFHwsPxqihWQxC53BJV6JtAp4xq0VMbSow=;
        b=c9ORyMD/mb6mK3v8Mp+yFC82MhvGT4drMMUwcJIsUvrSbyIStQ+v9350KA8Gu0o1mC
         7KoDtB3CKwY8AAz1PWb94Qltyh/5vhm5kZD6kbeZBsOGOHPb5XHzTDtq/LmqdsidTUb4
         JG1hU1gMEs1R4wiN6HAYQL0IatSVNCULve7c0kCcvv/CMORolTMGOpiZmW3p7NbR9UKR
         JeGYUM9M5OKBxTd77f5xjMcvzJM1WspOxcbyaYrPXW0+1chB13nQHpOBxbZXTjOnFG2r
         NvbQFUEssBKd/v8InMQ8bECyKIpAW36sHyUinm3Y8oVkFyQt8rqtHPptjQhE+lkYUKpL
         u8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwQYi7yPTRFHwsPxqihWQxC53BJV6JtAp4xq0VMbSow=;
        b=uKXQke6LVw8QDsdVn5ASITCiVAORKhEpChp8T+30+r3py5w+zSkjPiAyDfP1sKbfGT
         LCvUU7ll3rGlxQJqBsW9u+uW81HiuBnta9s5i5GqcYaDi/SRHhnWrqDTJ2rvWFyW51L3
         IUG/qM6REUnVOTSCnT9sDINuVncU3fkd4ULLxLf975nPN+KroLVhqP3DoptQW9yvlqG8
         iFMH/PZbaT6uTBamfJLZ8s4gaSLCbR2DUt63cE36wq72QFUQoaI8jYFpT0zHIOKtZSBz
         g5W9WccZ3QDQu/pVFnK+KVZ+RfpxJrjnOXzds5pN4Onq1Omymu5/5lDKReFFHS4jXJd3
         jO/A==
X-Gm-Message-State: AOAM532r07jDJPfKOTLyaUiIC31qYER0HWJeznZXG8tfO6cwrh0vFOcj
        sjwWX3+pPNGwpRwOsjOI3Kh24VNkfOwiavbuhQg=
X-Google-Smtp-Source: ABdhPJztaieCLZOxC4X4gwkHpe28zWEcu2aMprox/sQ1bIgxsH7qODsPkJqf8qPfxYUQMtUOzMfnpb5+ealfeRBntUU=
X-Received: by 2002:a25:ae43:: with SMTP id g3mr5821428ybe.459.1598037506965;
 Fri, 21 Aug 2020 12:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <159802249863.919353.9321169154213417316.stgit@firesoul>
In-Reply-To: <159802249863.919353.9321169154213417316.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Aug 2020 12:18:16 -0700
Message-ID: <CAEf4BzbOa0wF6LzOP1PGEf7UB2StEAbG_SXwV_TXWuGZ0B2DwQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix test_progs-flavor run getting
 number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:09 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> Commit 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of
> tests") introduced ability to getting number of tests, which is targeted
> towards scripting.  As demonstrate in the commit the number can be use as a
> shell variable for further scripting.
>
> The test_progs program support "flavor", which is detected by the binary
> have a "-flavor" in the executable name. One example is test_progs-no_alu32,
> which load bpf-progs compiled with disabled alu32, located in dir 'no_alu32/'.
>
> The problem is that invoking a "flavor" binary prints to stdout e.g.:
>  "Switching to flavor 'no_alu32' subdirectory..."
> Thus, intermixing with the number of tests, making it unusable for scripting.
>
> Fix the issue by printing "flavor" info to stderr instead of stdout.
>
> Fixes: 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of tests")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/test_progs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index b1e4dadacd9b..d858e883bd75 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -618,7 +618,7 @@ int cd_flavor_subdir(const char *exec_name)
>         if (!flavor)
>                 return 0;
>         flavor++;
> -       fprintf(stdout, "Switching to flavor '%s' subdirectory...\n", flavor);
> +       fprintf(stderr, "Switching to flavor '%s' subdirectory...\n", flavor);
>         return chdir(flavor);
>  }
>
>
>
