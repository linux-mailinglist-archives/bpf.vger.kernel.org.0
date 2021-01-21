Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46382FE388
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 08:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAUHKq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 02:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbhAUHKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 02:10:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FCAC061575;
        Wed, 20 Jan 2021 23:09:57 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x6so1137423ybr.1;
        Wed, 20 Jan 2021 23:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqoTzXb3UtyxpYm+0ODqpjRNVDXJe2GzcZiA48o4adE=;
        b=IfSMvHPRbr0JtSo8IHasxH813VQ0i7zqlDAFsKw37/XrXL/RdvrpRuUt3VuCn7wp61
         VTSMDhx64N3NUL62KbTg0rGlOrqwWRd8oH+sWT4V8NF303xBqKR/z6nahki0Px2BgzN3
         r8YGzQEd0/nSreEQ1HozVulyDRlhHs2JQ9ZxrxEcs3SIL5a9JAjxUqkUneuLXsHqCt11
         MSvAmhJedJogT5xjxu94XCTjptm/ebHDDngS+kBmhhtsiHVXo2LppUa2i5PkCpJNRxPO
         eBAG/ibplTRU2Qk7KkPnHAmyM3ZfdQ47QO0H1IcrJRNT5lFjGUWdBEv4d/35sBdf4JDo
         uWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqoTzXb3UtyxpYm+0ODqpjRNVDXJe2GzcZiA48o4adE=;
        b=Av0JQmWc2eAbdO4TR7oNXjzyQnBRG68fgaqKnQ6rtNGHLcBtxZpEj57e1fmCdS4HDE
         EZaQG83JNA8gLKO43NRYipp2m+M1O27LCLGFIo9DO4hTsGsM7FPVMtzu+2AHLa2YKoyO
         S4NOChKJ11qM44WVzlxll1FsZC5YfUcijyu79Y7pegtOvJ+qcj80foeQ1c7Pu3fvWWbN
         ZIkW7oCbsd2D48YsEQ6rmPR1Oa1D3yueoeK8Jp6f9QtRSGMkZb8YN1WWrdMRNCE2lnAW
         9eh38FCgUXUhZMj7fwzFBNAlOh1q3G32uBsu0LoMTimkmBG2YvE0DotHFDnFcvqV+enh
         6TBQ==
X-Gm-Message-State: AOAM5317F5YQ48tMPMuooqHlKPHPsY8PDSAnju3WzNHizoMGmUIKT94x
        iY1xSaCosbx1JR1HgzXUx5Ih6PrTj/hK+8tnvgM=
X-Google-Smtp-Source: ABdhPJxRk5PMGPSRemX5rTo3P7g+Se3aunGeRlP7qwPKDVaS728Abdc1/WGnKPXCJBFNCQ9pdaqyAMbEDNj7ioN07CY=
X-Received: by 2002:a25:a183:: with SMTP id a3mr13911013ybi.459.1611212996419;
 Wed, 20 Jan 2021 23:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-3-gprocida@google.com>
In-Reply-To: <20210118160139.1971039-3-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Jan 2021 23:09:45 -0800
Message-ID: <CAEf4BzbPwkCGhLeHbpS+asrLGs_BqRrqxK_gz-Pfzkgk9tbaAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf_encoder: Improve error-handling around objcopy
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.com> wrote:
>
> * Report the correct filename when objcopy fails.
> * Unlink the temporary file on error.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 3709087..7552d8e 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -786,18 +786,19 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
>                         fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
>                                 __func__, raw_btf_size, tmp_fn, errno);
> -                       goto out;
> +                       goto unlink;
>                 }
>
>                 snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
>                          llvm_objcopy, tmp_fn, filename);
>                 if (system(cmd)) {
>                         fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> -                               __func__, tmp_fn, errno);
> -                       goto out;
> +                               __func__, filename, errno);
> +                       goto unlink;
>                 }
>
>                 err = 0;
> +       unlink:
>                 unlink(tmp_fn);
>         }
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
