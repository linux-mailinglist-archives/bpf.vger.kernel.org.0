Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B162F3114
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 14:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbhALNQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 08:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbhALNP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 08:15:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D775C22571
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610457287;
        bh=It8hwsp3kwp1MvkNdVmaMkspUPQDFXCoPYoDzNp0vNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o4GysrNUvsz6jY7oQOolIbtbyYa48PoscnI2HyAHnhrUQYJT5vZuOsMQWMC/wKIJT
         e3I2japtQOKmAckkhR5xWb+gmVB3i2ENbhesUp4y4ako8odS8ySND1cRorSaIF2mZT
         C2C8M100rRnZj8w7As/XK0Sg10+OEyMdmUqt7QYz7b2RaaUuHUonAl9uMSnr6jT0gb
         vyF2sh4kc+9FYiWNFGJWrhqcX06swnRiJTySHcIWXRkdJbXR/86w6ipzzuxSUf0CvT
         +Wn6abfsgjIYYXbHZ9IBKrYJHIFyseY1QMGuoTRyPsofWCbD1id2x663Y2/cAMR0ar
         ZXDwmqhGsmxcQ==
Received: by mail-lf1-f42.google.com with SMTP id b26so3273410lff.9
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 05:14:46 -0800 (PST)
X-Gm-Message-State: AOAM531LXLp1fVUTa8GXTxWYx8P/71E5pADM0Lxw3vRqQfRfBOvNxz4P
        IjN6OCV2NqGD7h9g4zEumku2sR4ivbhv1AEJSnkN3Q==
X-Google-Smtp-Source: ABdhPJzTTOcnEMQSjDUK8UaKaos3oSZEHBUgqUvMzQpvWIx8CjosYAowjfGBlIlg19oKaPy/y5ODjBk6R+kSNN1Nops=
X-Received: by 2002:a19:810:: with SMTP id 16mr2237205lfi.233.1610457285057;
 Tue, 12 Jan 2021 05:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20210112123913.2016804-1-jackmanb@google.com>
In-Reply-To: <20210112123913.2016804-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 14:14:33 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5v6ANJnB0qk7hdEFf+44RH02G22+JFi0OUoJiFLe-RMA@mail.gmail.com>
Message-ID: <CACYkzJ5v6ANJnB0qk7hdEFf+44RH02G22+JFi0OUoJiFLe-RMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a verifier message for alloc size
 helper arg
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 1:39 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> The error message here is misleading, the argument will be rejected
> unless it is a known constant.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17270b8404f1..5534e667bdb1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4319,7 +4319,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         err = mark_chain_precision(env, regno);
>         } else if (arg_type_is_alloc_size(arg_type)) {
>                 if (!tnum_is_const(reg->var_off)) {
> -                       verbose(env, "R%d unbounded size, use 'var &= const' or 'if (var < const)'\n",

Can you check if:

int var = 1000;
var += 1;

if (var < 2000)
   // call helper

and then using var in the argument works? If so, the existing error
message would be correct.


> +                       verbose(env, "R%d is not a known constant'\n",
>                                 regno);
>                         return -EACCES;
>                 }
>
> base-commit: e22d7f05e445165e58feddb4e40cc9c0f94453bc
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
