Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD97F24E0F6
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHUTp1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHUTpW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 15:45:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB1C061573
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:45:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so3127265ljn.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9KZUZtWlcwZHdg1PnwQd1gOnG7tlxuzbT9u8TX4Pi8=;
        b=jOH07pt3zY612REW3C3O4apxf9lMFz8tp0PQ7VEs/zBavlAh+mnB5fK3AKkGFLXEO+
         vR5W1laGYfVf9Hp3/lf5tBlfvRWIi8RaX7sYJsE1zZv5Vm+y/5k0elFh/uv0jy6uObi3
         CAk/UjQagZ5tWE7nVFyozKL9F/PNcymkMT//X7g+PWGK52YtRPy6nl8xVEgPcErL2BUl
         E2Z6w0LxjS0ywBrj1nii1lhhcsfxqlhZIzH33dqnK1nkESCdMy7xlkzzd84os/3AUZyC
         o/35bojruwh0arE7doEXemYfDqDi05cPP9/6GPklFoQXY6FfGZcI11DczdisH7uagcpE
         xU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9KZUZtWlcwZHdg1PnwQd1gOnG7tlxuzbT9u8TX4Pi8=;
        b=WQA4+4KqBUnIV7I7YBnKJbuyGBwHiqn+GaYbc0KdeViUCVIn/MRRtkMmUtK71QRcQF
         YWa7m/WKiDkKFhBt3kBKeMZuNHVY29WqCrBlQqFwVU3ivM3Qpz3GQTrnN0yTspfpdaNb
         Bf4ZCBbYDCFxVfwh/8g/rvRGiZE3aSSfJFMY0Un0GiNXHJyMyjX+8uK8BPGgADH6nE5i
         86CgfRjjU8pRRZLkpo01SOA3VeqQEkCU2bbn3Ysc/cxALwaVv0M7uM4aLcRxhF/iq1jp
         7DFKsGZU0YkHdj2x6ZZImc/rlTRTdnHr2c05WWRyF9zxbAr4dwRaeIRQ31WdMtZYTO2v
         QYEA==
X-Gm-Message-State: AOAM532UHVSrg811Piy9J+EI7aoE5ShOsbXU8K/74L6KIwbeQQQXW+me
        EUEqqB7aAkeHmSk8GJt0d7mmspGrNTOrDQOC4OE=
X-Google-Smtp-Source: ABdhPJxxt8+tdyrkW+Gkb/j/PG07CYAwRqt17YI3KDaYw2/0qtoVSx3pjjflpP29Yi3AOAsanpbVS99hwbJp/xrVGaU=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr2293629ljb.283.1598039119949;
 Fri, 21 Aug 2020 12:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <159802249863.919353.9321169154213417316.stgit@firesoul>
In-Reply-To: <159802249863.919353.9321169154213417316.stgit@firesoul>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Aug 2020 12:45:08 -0700
Message-ID: <CAADnVQLA4UNsooPg7Cwk3hQU8dih6uATrOi+-V-a8b0Nb_ndWw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix test_progs-flavor run getting
 number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:08 AM Jesper Dangaard Brouer
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

Hmm. May be move it under -v flag instead?
The person or script that runs test_progs-no_alu32 knows what's happening.
That message either to stdout or stderr will be fine under extra verbose flag.
