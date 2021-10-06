Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8342361D
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJFC6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 22:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhJFC6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 22:58:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720FC061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 19:56:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s75so1154663pgs.5
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn9UM+/dkZKadYcqMwIDdS5DaVvIvKYy80rqUeg/Gfg=;
        b=qrpHp0GeS4GZshPr/AcQP//XjTMeyV96E5pEHdyh99Zu7kF3s5r9Xi3QPbtPyN24iN
         BeWpQj055c94x9lRuUYlQaBnQpgvO0NlhHHGka90XnIe5jG27IcxhEkeeQd9wpt5cw8J
         4RlyslSbIceBMHctXrFSXy8gtOSkBEC8aXeQHBod9o2sUmrN14hTe4PWqdaGuO3i7kCW
         Y8QAKk74IYBYCJxwxvnbbNzuSYOyJcHFfrinq1aImjHJlkldvjQUMdfB08liZ8109JEV
         OKNsoxJVajOnK4JqDPFTDXEjE5HG8wq0Cj/r4QgYD6Z+pGgwxiU/ketlVSMz7p+hLPPl
         r8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn9UM+/dkZKadYcqMwIDdS5DaVvIvKYy80rqUeg/Gfg=;
        b=2Wb1FevVSSta08faN3ZNNkQA/weM6XuAQAN629nfcFoJSecR97Y+0tWQ0JI8K+T8L4
         uX3WTcdW+b/KzY0Mr9je/1sVH/CHjygRYuDclDl9zTa+DcaXk7fbpBzRteu77ooinfix
         YjCOsfVFnVKTKMSSAU/WkK9ZIKXQfsCY4QPw/RXKBM8LaPzbV/ujlbNfZluFCqHZ24Pb
         R9WB0nwG/uZqkgCQtRxfKx7IsR+sGZuZNWglUTmG1XYettQsStPQjxjxcZYXKo43TOLp
         RkfKRhDBRd/3o4EUH8AGrIxbKy/GOxq5Ac0V+JkNV8grQ60V5CBjLY7kOBnawwtfDl5k
         dH/Q==
X-Gm-Message-State: AOAM533nDeZ+J2l4sQ3I+FhkcKJIiaClBeHbPHVKLlDFfyUxdhl5l6sV
        huQFakR6LoeJI8pm0vgI92Zm13u95Q+UBxoLPF0=
X-Google-Smtp-Source: ABdhPJzMHfD9RjhnIDtbshxeRSfa/W8Q0SF0fsKTibzWVPK+QAaGKGrovihux7TRIM3Huf3w7DECYPnP8GM5fvJXVSE=
X-Received: by 2002:a65:4008:: with SMTP id f8mr18092492pgp.310.1633488972336;
 Tue, 05 Oct 2021 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211002035626.2041910-1-jmeng@fb.com>
In-Reply-To: <20211002035626.2041910-1-jmeng@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 Oct 2021 19:56:01 -0700
Message-ID: <CAADnVQJb6wjXXBV0ZeQGXY3wFFU9eXDj5zBZrGymXrk8OTO+qw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf,x64: Save bytes for DIV by reducing reg copies
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 8:56 PM Jie Meng <jmeng@fb.com> wrote:
>
> Instead of unconditionally performing push/pop on rax/rdx in case of
> division/modulo, we can save a few bytes in case of dest register
> being either BPF r0 (rax) or r3 (rdx) since the result is written in
> there anyway.
>
> Also, we do not need to copy src to r11 unless src is either rax, rdx
> or an immediate.
>
> For example, before the patch:
>   22:   push   %rax
>   23:   push   %rdx
>   24:   mov    %rsi,%r11
>   27:   xor    %edx,%edx
>   29:   div    %r11
>   2c:   mov    %rax,%r11
>   2f:   pop    %rdx
>   30:   pop    %rax
>   31:   mov    %r11,%rax
>   34:   leaveq
>   35:   retq
>
> After:
>   22:   push   %rdx
>   23:   xor    %edx,%edx
>   25:   div    %rsi
>   28:   pop    %rdx
>   29:   leaveq
>   2a:   retq
>
> Signed-off-by: Jie Meng <jmeng@fb.com>

Applied. Thanks
