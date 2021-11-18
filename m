Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B74565DD
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 23:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhKRWv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 17:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhKRWv1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 17:51:27 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C50C061574;
        Thu, 18 Nov 2021 14:48:26 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v138so22642340ybb.8;
        Thu, 18 Nov 2021 14:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1A4I+IvpMnd1wIeiEMqnfEVMSvtyrpGJNH7+WyrCADg=;
        b=XPMPejQ4hp2jZEecf8S1x6d/hnxHl1myxWtrkVVOmM+/h4+9WyAkpMOtdPU9tZyJ7u
         0WQb62j2C7OKPp0I/2a4UsVmQZtuJk4yTj3nvvwt9ev4r6FDADcLdjAuFAjdWElPmS53
         pMOkWcLnonOZPjbbWCI6pd3gEnvmjc3gnmEzwZYm6xQa/TmseBChoCc41alLALVwIczz
         JIu/gO76XnEI4aKW6Bfpq/CrJUbN+n680utr5GPjKzSx9Ond368KrPs4S90e0O/IEg+T
         OSbRoMU4MbjXKUbeBW1CSH9eihXsz9EAfmncPfGu0xzn2uXiyek9VIQ+kiUfRvtWMWRI
         qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A4I+IvpMnd1wIeiEMqnfEVMSvtyrpGJNH7+WyrCADg=;
        b=Em7GTfiWb73eyGHGxTgeG5WKTFtQSyTUBRFaYQLBBRRCPkrv1s+ZoDpxyOXbhdCm2W
         mAHwRlJzw57GTxUynLaxdyWG/4p9D0+r8D7sT6Dzwu8Q3j1iW6tKQcVCbfDX646HFEB1
         BP0ROt2+9ddHLUAJR1Va8tRUMyKNQp//sTmWrtImGA4QdzwkWYcPCP59jrnoBNVqR/Qg
         WIxsdlSqwpZUNFCV8PZeRVAQdbDeuuRyqcuGEBZbsVHGV6bpPJhz47XLcWEWug4KmXfD
         1+kdRlkB6OFEV2bQ8my0pPcQjxMzHp940ZG356g2mUsnDJ00ZU84CTxRo9MwKm2Zp1UX
         xmwQ==
X-Gm-Message-State: AOAM531uzkxT8s4RaG/XzacYFsAkr7JFtOlWMpd9rzdtjBXEgLpQZnuO
        mVr+sG0L1KUJkdKbHsDs4d+XVGBdG+YpWirtYtLS3r4Q
X-Google-Smtp-Source: ABdhPJwUgfAuSgKLD26HnNHOrJPhk6SCNwQM2Dn26pOeI2qdLecIAvpsaXTS1kklB/ODwGB376Xm1xXl2h4EKAoY5X8=
X-Received: by 2002:a25:d187:: with SMTP id i129mr31194995ybg.2.1637275705946;
 Thu, 18 Nov 2021 14:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20211118130507.170154-1-kjain@linux.ibm.com>
In-Reply-To: <20211118130507.170154-1-kjain@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 14:48:14 -0800
Message-ID: <CAEf4BzbDgCVLj0r=3iponPp81aVAGokhGti8WLfWKhHuTLdA8w@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Remove config check to enable bpf support for
 branch records
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        KP Singh <kpsingh@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        rnsastry@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 5:10 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> Branch data available to bpf programs can be very useful to get
> stack traces out of userspace application.
>
> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
> added bpf support to capture branch records in x86. Enable this feature
> for other architectures as well by removing check specific to x86.
> Incase any platform didn't support branch stack, it will return with
> -EINVAL.
>
> Selftest 'perf_branches' result on power9 machine with branch stacks
> support.
>
> Before this patch changes:
> [command]# ./test_progs -t perf_branches
>  #88/1 perf_branches/perf_branches_hw:FAIL
>  #88/2 perf_branches/perf_branches_no_hw:OK
>  #88 perf_branches:FAIL
> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>
> After this patch changes:
> [command]# ./test_progs -t perf_branches
>  #88/1 perf_branches/perf_branches_hw:OK
>  #88/2 perf_branches/perf_branches_no_hw:OK
>  #88 perf_branches:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Selftest 'perf_branches' result on power9 machine which doesn't
> support branch stack
>
> After this patch changes:
> [command]# ./test_progs -t perf_branches
>  #88/1 perf_branches/perf_branches_hw:SKIP
>  #88/2 perf_branches/perf_branches_no_hw:OK
>  #88 perf_branches:OK
> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>
> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>
> Tested this patch changes on power9 machine using selftest
> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
> Add bpf_read_branch_records()")
>
> Changelog:
> v1 -> v2
> - Inorder to add bpf support to capture branch record in
>   powerpc, rather then adding config for powerpc, entirely
>   remove config check from bpf_read_branch_records function
>   as suggested by Peter Zijlstra

what will be returned for architectures that don't support branch
records? Will it be zero instead of -ENOENT?

>
> - Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434
>
>  kernel/trace/bpf_trace.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 7396488793ff..5e445985c6b4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1402,9 +1402,6 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>  BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>            void *, buf, u32, size, u64, flags)
>  {
> -#ifndef CONFIG_X86
> -       return -ENOENT;
> -#else
>         static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>         struct perf_branch_stack *br_stack = ctx->data->br_stack;
>         u32 to_copy;
> @@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>         memcpy(buf, br_stack->entries, to_copy);
>
>         return to_copy;
> -#endif
>  }
>
>  static const struct bpf_func_proto bpf_read_branch_records_proto = {
> --
> 2.27.0
>
