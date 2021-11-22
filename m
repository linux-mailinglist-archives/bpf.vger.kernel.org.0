Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331DA4596D6
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 22:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhKVVp7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 16:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhKVVp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 16:45:59 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70280C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 13:42:52 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g17so53762009ybe.13
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl+dEtNPXQvgNa/Q6APIMR7bY4PlPpdOe803KVajt4Y=;
        b=GBQUCoEgZnso17kYz87dKSGrsetjvCjB/8FMlBD8A55bZCpsZ72nSHQEvFaMelm3yP
         lA935tAkFDGvCMxs/DlcWfdoY724iwPvMJtnLmepdW8DLGucaYyzllrsEa/kcZJX9KLt
         ZR27iOI1DZlDvXOQ/46aKGoHKldX6NpYxWOaxir4adfiNZHRdqFG0meSx3hJCR5+BOpk
         iD3heN6ZOb8ZnNzqK8qAjKQBSXJNpK9Ulf9Xgp397JGqZmVYJEFw1gLSIfShnf/5fCaK
         yoGlWxXtPR0acDhp6BO6pkcwQF14gselAM6F3DKwqhkk5myra+ukD6aEXHCH820HuyvD
         62wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl+dEtNPXQvgNa/Q6APIMR7bY4PlPpdOe803KVajt4Y=;
        b=vzz6VzDCdgt+Ezu6I7nRB766Sz8Hh08dAr5nSC6P8+94UdTvG8K7Os9H93/9BNrDd6
         DF1Bvl1pRiTVNu7r7DDwMRsBuqma5MS60CUBwqvYa+9Rz8JadNRWTuS6kmaS8ODAepAn
         h78gLpkderkSwHSOGoAjlpEe2e8bf73eKp8gXqnQzsTbVAnCmUucLhVrI29ywroMyGKc
         dr8/oOp3gIj/4JbTDnTLWNA3uwT99FevjIt4Cs43r4KLSCsQEw2uC7+bR/UUbc0gjNi4
         RLW8MRTTzdoW6fxw9f3sqvub234vanAKiSlUHJePlNTWNwkX54t9oVo0wzxe5/Jf1PWd
         NUuQ==
X-Gm-Message-State: AOAM5317T+dTLuBF/gugHv+DHj/bSN2liYp5kdmgJ9ywLCyRrbT2LZK+
        6MmlXv+4DAPKY8KgmC2EsbN2J0lBpKZNfF3xiqs=
X-Google-Smtp-Source: ABdhPJwVkn0c5MJceOodvAHWppAbcIlXx43TjoQx87lMVvW7JrogUeuTV0P5mnF/Uo1DacYruSIqdt65oqDMnfkyuGM=
X-Received: by 2002:a05:6902:114a:: with SMTP id p10mr240311ybu.267.1637617371762;
 Mon, 22 Nov 2021 13:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-2-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 13:42:40 -0800
Message-ID: <CAEf4BzbkMMOr3dvF49=VjGv6LiXO-Y9sXjDMxBjg_sr0+5LCZg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/13] libbpf: Replace btf__type_by_id() with btf_type_by_id().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> To prepare relo_core.c to be compiled in the kernel and the user space
> replace btf__type_by_id with btf_type_by_id.
>
> In libbpf btf__type_by_id and btf_type_by_id have different behavior.
>
> bpf_core_apply_relo_insn() needs behavior of uapi btf__type_by_id
> vs internal btf_type_by_id, but type_id range check is already done
> in bpf_core_apply_relo(), so it's safe to replace it everywhere.
> The kernel btf_type_by_id() does the check anyway. It doesn't hurt.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c             |  2 +-
>  tools/lib/bpf/libbpf_internal.h |  2 +-
>  tools/lib/bpf/relo_core.c       | 19 ++++++++-----------
>  3 files changed, 10 insertions(+), 13 deletions(-)
>

[...]
