Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7944DF5A
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 01:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKLAzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 19:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhKLAzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 19:55:09 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34635C061767
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 16:52:20 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m14so7019916pfc.9
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lW3XzuVOk1Ay9qVq0FL0ILviBUb8U9nCJjQDEiDfds=;
        b=Qsn/4VPw4XqtlszmaOhvg4jQKv6MnZf4UOwif5Qe56WgMKwGQ/umJGDHKdMsDtYttP
         036fHKcEw75B2TFR0A/Rk1vXa35byX7iHVw7HT8LUgX/EsA9AqB3tYATnn9LJilEzGJF
         7eFszh7zWBirRfJVOL4iDPIocg0DOTS6JalmYKne27bxRf3H3z4K/FivcU5uzmcU82W0
         v9eRuhJO7aq9ju6Ls2UKp6yil8uXakl8iJOTwuV/c8oUR3RKkmRuHyj334b79PPJWSVZ
         qpFNTeqviDJh2JNWkGwvVgsvMhBUj4gBZohJJ62OqUimw+sk6GudTHeLM8XdjP06in7S
         nBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lW3XzuVOk1Ay9qVq0FL0ILviBUb8U9nCJjQDEiDfds=;
        b=JqfVieXUkShNi3D0ZDT5p955R4QdC380PIqxR0kfR0mo9u06X5tgZ68ZaMnNhtDdjc
         XursT9n2Ieqv5XF1JeKC+sqBhLJNm9eETlrz5WgeED5H2uv+BqDSGxogb3FEqhaMrcG7
         zj5+9aM2ye6dpIIiN+yxn9VIe5zs0pbfur+TlVlSzVL7mkfbytm1jEfbZ//uRgt2+ThA
         WDjfau+6NRiW1ObRosNvjLlRamXySwffvS4V1yTKmt9o0//knHd1eIPH5e4sqStZTV8J
         GiLRwUJ5XRZtVgddbFsIQGV4PPqQSNov20RbK1U6VacWwX8KYuU6FdaM+gDIelSbXPff
         KR3g==
X-Gm-Message-State: AOAM532q4dv/exXW5n3VBrKoCaemaXHhmFu1G74sJf1ip/YFjeNykRWU
        O8LU4G3osrGuuhPafMN/MCGFWdQ5PzTyHJkgHwA=
X-Google-Smtp-Source: ABdhPJyx3n950crs+QlR0UXQYwqSLlTzeMu531YB5of1y32XDGJQg4C0MKG93EphIeRpUL31LoAQtDDoa2qamBivDxI=
X-Received: by 2002:a62:33c6:0:b0:4a0:3a81:3489 with SMTP id
 z189-20020a6233c6000000b004a03a813489mr9762793pfz.59.1636678339661; Thu, 11
 Nov 2021 16:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20211111051758.92283-1-andrii@kernel.org>
In-Reply-To: <20211111051758.92283-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Nov 2021 16:52:08 -0800
Message-ID: <CAADnVQJ=8Zd43p7WqR3UGxv6XHmo2t=9dfq9X5GgSD3hEvGZpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: fix test_progs' log_level logic
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 9:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix the ability to request verbose (log_level=1) or very verbose (log_level=2)
> logs with test_progs's -vv or -vvv parameters. This ability regressed during
> recent bpf_prog_load() API refactoring. Also add
> bpf_program__set_extra_flags() API to allow setting extra testing flags
> (BPF_F_TEST_RND_HI32), which was also dropped during recent changes.

Applied. Thanks
