Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9D447066
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhKFU20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKFU20 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 16:28:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B49C061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 13:25:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn3so5317679pjb.0
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNA3kMEAZOLbYpFf0fLZf2zISrFkzZNr+YshV9Apcxw=;
        b=RIYki+nW2ZZ9hAIn79gn6/ZvcGY/fYKIjj5Jr3VSU64fdQ4ROxwbjGoiX4WhC+wkxM
         wo6NVDYPbv9fwn6lb2We/ChkqrN7KhjjJTZMgzswdVISecOcyYTBJkrAbMTTH+kks+hZ
         J8oZ70MoS93boEaoSdPtJemdX0UalkzdfhbfbTpr/9kT85CAbddbr84oF+AUsX/ACOio
         XscGS+3GqT/GH0+pI4365+ok9DmTnkFLvZz5tqLes1PMkCl+KWMu0p2FvI6zejMPTSAL
         3AF0v4cmCWuC8r1wV9b+klQ4tL/bccA4ecOHTkCDDh7pnVzrfRKkP1p0K7KCRXZFAf8m
         STNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNA3kMEAZOLbYpFf0fLZf2zISrFkzZNr+YshV9Apcxw=;
        b=mH6mdvE8ifEMtqN5BlpPDn5Vbdjr2BUElui+Opi4dznTVTxArHm6lQRuLZ1fxO7DZZ
         lp8LyW90KwOSXTS4NMyEKiY7lEedbVxZcKV0MK9R0xFHA+pjXvXE77CDISVz1Waq4Nmd
         TXYvnxtvqX4CyrzVhKpgPWNmU1Th2yjpYRI2P6c+HQbuPsVj7kRM72GbmnV8DY/p3OeY
         TjqzHEkt6tBdZONtyywx8hQrT/WVkPgmV7NGa4pOFPX7rsJTu7Vrg9tLmaQnj/NWGCh4
         jf9tLWcrJQP0AjJR+A34V6yThmtuxLgZ8Pkm65db53PeSJ0Umnf2Perognt3wfS51M0V
         a6lg==
X-Gm-Message-State: AOAM530SQC0HWnLFkXl3CNQJKPaTlck8lva/tHyHoLg5NfUBTnsHvPoU
        NKBoWs+RWNNAgSm81rBm2sIywePU6Ki8klt2Wf0=
X-Google-Smtp-Source: ABdhPJx2BZ8GNEPLkIioReUziQ6l5mRTTMUUBIXi1XVIU2vzrtu6YLTx4HCd96a9NxD8bogMhzmo7buWRmuDfyzD3fQ=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr39501695pja.122.1636230343520;
 Sat, 06 Nov 2021 13:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211106014007.650366-1-kafai@fb.com>
In-Reply-To: <20211106014007.650366-1-kafai@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 6 Nov 2021 13:25:32 -0700
Message-ID: <CAADnVQLQWE44g+SAN61D=gUEP1aejpOjzr8fn_-6iwWD0fnUQg@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Fix out-of-bound issue when jit-ing bpf_pseudo_func
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Yonatan Komornik <yoniko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 6:40 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> This set fixes an out-of-bound access issue when jit-ing the
> bpf_pseudo_func insn (i.e. ld_imm64 with src_reg == BPF_PSEUDO_FUNC)
>
> Martin KaFai Lau (2):
>   bpf: Stop caching subprog index in the bpf_pseudo_func insn
>   bpf: selftest: Trigger a DCE on the whole subprog
>
>  include/linux/bpf.h                           |  6 +++
>  kernel/bpf/core.c                             |  7 ++++
>  kernel/bpf/verifier.c                         | 37 +++++++------------
>  .../bpf/progs/for_each_array_map_elem.c       | 12 ++++++
>  4 files changed, 39 insertions(+), 23 deletions(-)

Thanks!
Applied to bpf tree with
Reported-by: Yonatan Komornik <yoniko@gmail.com>
