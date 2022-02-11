Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169C4B2B50
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiBKRGR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:06:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351597AbiBKRGQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:06:16 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D681CD4
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:06:14 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p63so12103060iod.11
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbHj9kPDFr0Tydia4N4Dw+mVUabzHMmb0sDrzeTPM4g=;
        b=TysFfOEWyMjDcnlVrJu6Aydtf4dA+7OckI3KsO6oNVJqWLrxMm1VyqcupK/qHpr/AF
         ZxGFDrnxmbyFi5QcCpzXL/v/KyyfQiNb9dOytZ3SatrxCzDJEI/xlDywVjFqJbs5OUsh
         KBsxSwoiD2nTc2Cvk3BtwRtIPKvA2vs2Q+wFpoNTDWrCRdx8x++VUcXGAQrMoQT+s/Ff
         VDxweMUTz17bWe1wCKZNq9bigUgjeZPlhK19xzzXhQlt5rMy1xwaz84NeRM9MIA47UE8
         jQDI9qJAgfnv2qWetgnNjCNhWNEXA+YQ0Y0GJKnoWGUAUWpsXEPntTJk1uE/jkjEdrZt
         KyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbHj9kPDFr0Tydia4N4Dw+mVUabzHMmb0sDrzeTPM4g=;
        b=qqW7B36gEfNoM1O0xjoXWVdms6eyxqid5fLAWSLjYKItuY5fy1g82FOgnEXQapF7qK
         lIyMGKUphmyOgEwGvCgaEVd5VGyOx075Dby7cbO16TUp5L5bdAkHJAt9yT17G5r0W2O0
         CdmXKu8D/pnemMtd7MSWg5Te4QdKt6J+iT9qEGp3oBFVkQqS78+hP+dJIGnUbPxv116S
         XTp1UmV8ZqdQZcMceHLgbb8C6WzUsjJw+rdsQnJDdTH9fp9JwTCFzt2DyDls1AT5usD9
         5bAoQx3bJlBIoUS4yHx/9RrbXMZp9eQ4P3niaMwOTsXyHcVBlbprArXahad3EWA/dZtX
         kNsQ==
X-Gm-Message-State: AOAM531qlTsBaJi5tbTbtYYKygHh8dDbSPBBZ72sDIQFr0XApq5Wa60A
        IgE4rGXx/fqOB1sAWgSQ9F2II5RlqhZNos6+cdc=
X-Google-Smtp-Source: ABdhPJz/yYgflSdOqMCjuaukL2s5KCCAKZ8Y7kny1JkTpojEj/kYc/PZcBzbeznWRriwJD17ak2UYJ3+ewHFWEW+BUw=
X-Received: by 2002:a02:7417:: with SMTP id o23mr1420928jac.145.1644599173693;
 Fri, 11 Feb 2022 09:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20220211152054.1584283-1-yhs@fb.com> <20220211152104.1586041-1-yhs@fb.com>
In-Reply-To: <20220211152104.1586041-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 09:06:02 -0800
Message-ID: <CAEf4BzZ=pKn-tu6vBaQwXKN+m0JhRVy0zJhhV_p6ZAQn=gwjvg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: emit bpf_timer in vmlinux BTF
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> Previously, the following code in check_and_init_map_value()
>   *(struct bpf_timer *)(dst + map->timer_off) =
>       (struct bpf_timer){};
> can help generate bpf_timer definition in vmlinuxBTF.
> But previous patch replaced the above code with memset

For bisectability the order of the patches should be reverted then.
Otherwise we have a commit that will break selftests for no good
reason.

> so bpf_timer definition disappears from vmlinuxBTF.
> Let us emit the type explicitly so bpf program can continue
> to use it from vmlinux.h.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 01cfdf40c838..66f9ed5093b2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/proc_ns.h>
>  #include <linux/security.h>
> +#include <linux/btf.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -1075,6 +1076,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>         void *key;
>         u32 idx;
>
> +       BTF_TYPE_EMIT(struct bpf_timer);
>         callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
>         if (!callback_fn)
>                 goto out;
> --
> 2.30.2
>
