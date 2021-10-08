Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917EF4273B7
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhJHW3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbhJHW3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:01 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE6C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s4so24139872ybs.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyhKQYmk+n1DAR5MGJZCHXw1fuNtgzMib9GIq2juiQM=;
        b=fKzpQsHAZGy1Gs0pgUmjKyP/RGoogh7bPULoYyFGIx6TGIDXO68P38Ul7iYJje6Kv/
         ql48R0iv4UPdue0OPbBCFzK96EHgA+3EOzsRePZoCLKiSk4ww1w1MYq7gZnMUBmGWk1V
         hftLJbmUuZSzUMB/xMs4N3asdpS0XLjeX5f8XkpiViyqK4Odgh51rkMSzXR4j/5QjMCN
         qIkAJtUsSCVDqgE7p7LbcAJTkBmaXXq9Kq4Nusw+lheKkPFkWwnpflll3vS39KcOT7Rt
         Yi9MzL8fnMjG7hyZ5xlHmJHL7C/H91T7Bv09LOQ5dILQ1rQVfkabSYcpSDHvFZ5yzadI
         TIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyhKQYmk+n1DAR5MGJZCHXw1fuNtgzMib9GIq2juiQM=;
        b=mmQc6FyWRXBi5AK9AunucEHCwu8dJGyBPFMCh7wgI/wR92wyB9G5Xc4rxToXzHzArm
         Dei1W94pTyuQxnwc42as8d6D/Oc63RfAg6oV03ydXEkfguJxebboSgXXl3V/u7SnvysD
         62nPiomaxLFReFWLaTN8lmTrkElm0E5OyZLBHIrPpSFHcc5o1g0EJBAM1PlW3aBLZbJ3
         TJ+y/VGGSnL/7S+7OByHRf3fLPh2hQZm5Da9BU5Tg8zJZXN7ImlVXT9rQP1iiPab+nIM
         af8UamonAjbRnuydKgV9S7g+UAz27xD1hAOIaB0WuDKnkDNGF3E23tllKMpGyqo+K01l
         lNUQ==
X-Gm-Message-State: AOAM531DwcudQy2SNnXtrbvo/7Ai6C6coCKaixx5a5a3JwGcuc01MZZz
        MEdUJtCwv4vqEU+SooUbCbq6LjO74H/rR+XHjyA=
X-Google-Smtp-Source: ABdhPJxy7rY7txebBbudYoSZLmi1QYdHwN5oUuEYtVNV8H3FhrpllXCinTsGnY+8rYoi75XoH27vk2L4k0cnfdcYdTg=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr6356158ybf.455.1633732025327;
 Fri, 08 Oct 2021 15:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-4-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-4-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:26:54 -0700
Message-ID: <CAEf4BzY3PAZoUjdMs=-Rct8J_mq+2uQwqr0MXff6FHvMHDUAbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 03/14] selftests/bpf: disable perf rate
 limiting when running tests.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> When running tests concurrently, perf rate limiting will often cause
> some events to be skipped and make some tests flaky, disabling it making
> running tests more robust.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 4e2028189471..2ac922f8aa2c 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1376,6 +1376,8 @@ int main(int argc, char **argv)
>                 }
>         }
>
> +       system("echo 0 > /proc/sys/kernel/perf_cpu_time_max_percent");

I don't think we want to do this outside of QEMU, changing the global
state of the real system. I think this might have also been relevant
to me waiting for perf_branches test for about 20 seconds or so. I've
dropped this patch for now.


> +
>         /* ignore workers if we are just listing */
>         if (env.get_test_cnt || env.list_test_names)
>                 env.workers = 0;
> --
> 2.30.2
>
