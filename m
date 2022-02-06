Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563264AB1B0
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiBFTbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 14:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBFTbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 14:31:23 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE2C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 11:31:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z18so9462120ilp.3
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyZT3XxHNtAYHQcNffNR3k72iwDljfEh+SbyCVzOovw=;
        b=TzZj3RMIUm0UAfDZwlUj+0ZK3cDWkF3hDOG5+QBUMfXlWJiqRPw0dlDRFmkabp+Q8f
         630b9E6msWYW4M3k4g66bNaZfoerhImMXLwCpHjBloV/JMoXkrNDKKp0XkcM5jp5sVqp
         /H3Vjum9Bk8SSVpYH0hXOZtkMMUeSgqY39dgiYjcePL1OUoV9xUPFEc+nfilteeyu6l4
         ggi+QYGuN78HVl48Zxri78GSDtBgP40vK8aM0Ay36XQK4Xc9L3UCXh9tr0rc9LdfHG4B
         ZhSjsmgjfIDkJv8x5go+Oqepm8s109/5oYW6TEgk4tYu8LaqMzHLL4zbaChmSXZjvR3d
         /0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyZT3XxHNtAYHQcNffNR3k72iwDljfEh+SbyCVzOovw=;
        b=Py91OeWZJtJrEknHAvVHg58LvshG8c5zYWhfeISmNtn7cbs/uVCJ0opGfcy7UIN2Tj
         Wc9D/Qx2shjEFMp9qcGuM3XipumN3zPnqHULTFis8HwOrmVN+eimxtmFZc4dMATa0SBV
         Hn/rSRSHvhP20PCKt3HvIutJurmCoXf2qIiDb36i6a6Ods12GgIqElcDKfeTWyhq3l5l
         DtMooFsPwXT4R33xM93F/6GW5+upw/mMma7/iQzp/x1XUiOIlEU/j0gsa08KiTNTVV6i
         xKPp9inNzgiGkD9qeZPyE3YGgxkE4QVztyyUCefUI7x3sMbMq3pXFaqJHRWT9AKwUOfO
         XxyA==
X-Gm-Message-State: AOAM531OmgT4WZbQWEzljb4TxAnMS63ywvDAn/ebO0ZpXVNk5pl0Po4u
        oVN/5vMFVQuleRLjuL/pxq4OUdE7S5rzK5ck8mwsQYgm
X-Google-Smtp-Source: ABdhPJxCQSdqxAi6ZN5O1dHNjg0J0TfkmGVqhL2agTW8hQFKCNu1/ER+D/pQA17Llfgs8OExwzN0/0QhRHQzFELChBM=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr4048179ilv.252.1644175881903;
 Sun, 06 Feb 2022 11:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20220206145350.2069779-1-iii@linux.ibm.com>
In-Reply-To: <20220206145350.2069779-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 6 Feb 2022 11:31:11 -0800
Message-ID: <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
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

On Sun, Feb 6, 2022 at 6:54 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> libbpf CI noticed that my recent changes broke bpf_perf_event_data ABI
> on s390 [1]. Testing shows that they introduced a similar breakage on
> arm64. The problem is that we are not allowed to extend user_pt_regs,
> since it's used by bpf_perf_event_data.
>
> This series fixes these problems by removing the new members and
> introducing user_pt_regs_v2 instead.
>
> [1] https://github.com/libbpf/libbpf/runs/5079938810
>
> Ilya Leoshkevich (2):
>   s390/bpf: Introduce user_pt_regs_v2
>   arm64/bpf: Introduce struct user_pt_regs_v2

Given it is bpf_perf_event_data and thus bpf_user_pt_regs_t
definitions that are set in stone now, wouldn't it be better to
instead just change

typedef user_pt_regs bpf_user_pt_regs_t; (s390x)
typedef struct user_pt_regs bpf_user_pt_regs_t; (arm64)

to just define that fixed layout instead of reusing user_ptr_regs?

This whole v2 business looks really ugly.


>
>  arch/arm64/include/asm/ptrace.h      |  1 +
>  arch/arm64/include/uapi/asm/ptrace.h |  7 +++++++
>  arch/s390/include/asm/ptrace.h       |  1 +
>  arch/s390/include/uapi/asm/ptrace.h  | 10 ++++++++--
>  tools/lib/bpf/bpf_tracing.h          | 10 ++++++----
>  5 files changed, 23 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
