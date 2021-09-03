Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319B3FF88E
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346056AbhICBEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 21:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346037AbhICBEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 21:04:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6824C061575;
        Thu,  2 Sep 2021 18:03:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c5so1395677plz.2;
        Thu, 02 Sep 2021 18:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DCudZZq4BCGyRqK9T3SXUuab3iD7BkjY5ekmbCqtp8=;
        b=N/BJJfzm0XA6bDo9jAwneD19vi6/gLhyyTeUOxBPAtjTUp2pYUn/0pZzaurEnMlB58
         dYPFDPWbPSzD89bdGYcoCYnJbAynPhuoHfAVIQGSOTrk/ahIEXceNmOuFYC49u+2RrLZ
         +zLhHiZk5qNJ4Pq52SKeUWpKUaqgezTI3yMET3BohvUa7D1+SUN2HxokdDeB1M8PWsek
         mHOnQsImY/ush+7YyJs7KPVmZttkfq8r4K/slr8IH8WrgA1YhY1pdFL7IdHuxQkgy4GJ
         NWcwB5uUSnTIKDHH7VKhWxVla+0yM/pTWgKC3XHKff/fd2PeX3OtVpI4hNyUUXfMEDjn
         FVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DCudZZq4BCGyRqK9T3SXUuab3iD7BkjY5ekmbCqtp8=;
        b=gqe4MRcFvYCMFrtDuUpSwzldP+qFlmJhJ2yBAqOFJNkkgp+jeh9o0qiyjc36Nk4Gy3
         HftTr9yZkN0rrOznwLLolkVRwu+g4WyPxA5acMkq4Ny56Zw2ooenMmC4e6qUK4qw3vEk
         g4uoqEbplBRbAyy75qYYlxGgckYeY1jP6z5y3CzIwjv3MmsDfRncAoA2TK8wIOIR0ZSj
         323/YrFWqP3IHCxxDQ7se6cE3iBb2avXgqi2LwncpvKf8SbFdnZNKUPlxlKUV11ALpPu
         P9b83No0uHm/gMlOSKTJVYTY/7AfwOZQXYTrPoGVwiXvsSEeWS4zdMIuJovKzWp5HYYA
         FWdQ==
X-Gm-Message-State: AOAM533V8JHIzbR3LSQihjZnELiCF6NtG9CX0ucD+G4JlctZB7ApHa5s
        BaBOG7zZy4RS5aq61ZWR5Nu98edxonBMTWkZf1c=
X-Google-Smtp-Source: ABdhPJwWS86hdKpJy5bSjHeQ3JB0qgxXYnZTyR3aaMfvNH/4QvwkEV/JL6J3OPEy1dgscMlXgSiMufgqxGO4abDE9Ek=
X-Received: by 2002:a17:90b:513:: with SMTP id r19mr983426pjz.93.1630631032093;
 Thu, 02 Sep 2021 18:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com> <20210902165706.2812867-3-songliubraving@fb.com>
In-Reply-To: <20210902165706.2812867-3-songliubraving@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Sep 2021 18:03:41 -0700
Message-ID: <CAADnVQKxwUtUJTNjwiU-hmtqjpaTZLXoFzKtK7SME=zLuRbdUg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kjain@linux.ibm.com,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 9:58 AM Song Liu <songliubraving@fb.com> wrote:
>
> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> +{
> +#ifndef CONFIG_X86
> +       return -ENOENT;
> +#else
> +       static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +       u32 entry_cnt = size / br_entry_size;
> +
> +       if (unlikely(flags))
> +               return -EINVAL;
> +
> +       if (!buf || (size % br_entry_size != 0))
> +               return -EINVAL;
> +
> +       entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);

Not taken branches will not be counted even with PERF_SAMPLE_BRANCH_ANY,
right?
Probably the first unlikely(flags) will be a fallthrough in asm.
Maybe worth adding unlikely to 2nd condition as well to make
sure that the compiler will generate default fallthrough code for it ?
So both will not appear in lbr entries?
Or maybe do:
if (unlikely(!buf))
   return -EINVAL;
entry_cnt = static_call
if (size % br_entry_size)
   return -EINVAL;

The lbr trace will be collected anyway.
If there are jmps in lbr due to earlier "if"s we can move them
after static_call. Like if (unlikely(flags) can be done afterwards too.

Bigger bang for the buck would be static-inline-ing migrate_disable, though.
