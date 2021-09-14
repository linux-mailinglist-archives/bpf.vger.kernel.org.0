Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440BC40A5E9
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhINFZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbhINFZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:25:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F9C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:24:09 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so25533332ybm.10
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK+6eGSCc0BdmVjr4xgVcHQkBiJZ9hGH+p11ZkSis2s=;
        b=CL8EPLHlQXt2Yuaa4ziu+BjoCR0968GF86levenXmis5bJ1hCYWq9SmHIe2aLxmovL
         EEq6jElJfBxj7fv1hk79W55LnP0QspViZl9fWh7Z3UJLUhqFuyt+S6TIFaU70mtdhMD8
         RimSnHR/sr61L3q9+BitFUwQjI95Adzdkj+MO4tm1q6pGRq6ahu4tfYoTypomxLReAvl
         cYeuxF0/Pt5+lm9Roo/Sv+CC/hm77kpWpWFYwH9Zi95Ntpz6ekVDMkW0KW9MExNOFW69
         nUoAUo/ImZYOn0oZnWo6Rf1TepcFNqx3aHbQBxHgYvQc+jWiQEFEDBbokE2H6qjLFpAD
         r7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK+6eGSCc0BdmVjr4xgVcHQkBiJZ9hGH+p11ZkSis2s=;
        b=JZAWW0dofBHakuMcCgNb/KB2jXeQtgC1/ofzryADE3+Vu2ReKA8L6WRi11gYS8hE0z
         kwWjS5JpY7bH7Ic3NjB8MyaMH34BEZAao9fBRe+hkV9ZFH8cm0G/XRNQvqQPwsG9HXGm
         jJwflTRcEYYAzND4ZmgqCwzH1Ncwm7ufXf2XkegJhFs0A9M6yONHR+2ZFzD6D2ieUEr4
         uVJdUh/Z12IHWofmcihg505Fvcku2dWQJtqXSm9/cFIbxAOlIgPcjDhzb/G8uyYphyka
         V2NqCCgaGt5wFqACKMbhUkQUt4l/f4IqVV14m67Asb19ZlETJvRPmS6fiHMA/pH2i4CP
         AzYg==
X-Gm-Message-State: AOAM533IYfmVxKlIW+XiR4tu/bwEfrxJpbsfL3W9fzkRX0tGfJqrra4h
        1sJqshidAgV/DdQ4LOY0HljW6lEsoYlCKT5hTws=
X-Google-Smtp-Source: ABdhPJxSfdcbIyVamr1IOzIl+nzKmpEtzDoNHg6Zop12HHsZL3559afLT5C3YNiCjE879wxqpP4odkBPpLKtJtsalOw=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr21488290yba.225.1631597048439;
 Mon, 13 Sep 2021 22:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155200.3728013-1-yhs@fb.com>
In-Reply-To: <20210913155200.3728013-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:23:57 -0700
Message-ID: <CAEf4BzbpwVP5n7mUWqw_Q4Ohq+xtBWRDUZt_AS_m2-4+BtiMOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/11] selftests/bpf: change
 NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>
> BTF_KIND_TAG ELF format has a component_idx which might have value -1.
> test_btf may confuse it with common_type.name as NAME_NTH checkes
> high 16bit to be 0xffff. Change NAME_NTH high 16bit check to be
> 0xfffe so it won't confuse with component_idx.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 649f87382c8d..ad39f4d588d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -39,8 +39,8 @@ static bool always_log;
>  #define BTF_END_RAW 0xdeadbeef
>  #define NAME_TBD 0xdeadb33f
>
> -#define NAME_NTH(N) (0xffff0000 | N)
> -#define IS_NAME_NTH(X) ((X & 0xffff0000) == 0xffff0000)
> +#define NAME_NTH(N) (0xfffe0000 | N)
> +#define IS_NAME_NTH(X) ((X & 0xffff0000) == 0xfffe0000)
>  #define GET_NAME_NTH_IDX(X) (X & 0x0000ffff)
>
>  #define MAX_NR_RAW_U32 1024
> --
> 2.30.2
>
