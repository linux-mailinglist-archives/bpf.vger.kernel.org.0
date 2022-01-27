Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B049DFBD
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 11:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiA0KsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 05:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiA0KsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 05:48:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A614C06173B
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 02:48:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id s5so4935402ejx.2
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzOHmZ2n9+gsqUuicrYJlhYW5U/YGENeiTXZgdwdecQ=;
        b=GjFYtKexJXjCC2HBI1UDTG+OgIPhwu5Xdb2VPH+val+8BijKTI/NCUsMgy85sqBx9U
         IwRaTauFhD5r4ENsT0Xw5/ZrBeJYEVwaacKxYKhIVvU+VL9biwSLVfWlNvBMkCpVB82T
         Vlqlckjrga4eRNT6+ZD0zaVlFKeNRTV5/VDCbpj7EIcxPrihERYxkITY5Is4LkFhgD5a
         cc6dZubXrc00xtXRZ5QupfV1cn2QQSbuIxyYYnnCJbG8QSLEVLdGU4pLgaUrHAuvQE59
         h0eeELZC4tYhgJXxpEsoisnLe6we/bJyXnH5tCKQ1EesovMivAxrTVfpqR7KE3ypTWkw
         xcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzOHmZ2n9+gsqUuicrYJlhYW5U/YGENeiTXZgdwdecQ=;
        b=JMY55dT3e0TtkA+BNzsDkdzUhZpbpjJwXE+zuv2Y2BxPxpxX1WFIynfQBW3qvQfyTb
         TzRDsOUvAlJu5mYrmnOXHDPEeXAgyz3DsaSsGPklZ7CGBvnDrFOGASv83/ot4HuPBY0X
         ssPJsIPZZVF2vlL0jsGEfUlq5zMEAPcEGe9/cD9ZzkxxyYla9V5Picqd3LACa4H1Noqw
         pR8e/5lYUlA6xN5bntDzE5gBpBxoegUCrW58Ber1P0yFSjp3QEVy5lhX55P7CDWz1QWL
         FaBNRU/Ysufk+uAEcxjYBFlID/xsTsYAqMc60teYhicn7e0abPTSodsdOiXeZuWDshI0
         58Fg==
X-Gm-Message-State: AOAM531xDefk4LL5hCOTr/QiD4FUyQ9EOW9IGnRMHbq/DqAz/8Imqmpr
        siG2uvf9oMNBwjKvzjBcdCU6Y5rzC1HEwfXBkeF7qw==
X-Google-Smtp-Source: ABdhPJwUvrZCQQ3V4jxxg3A1li1+Vftf/mj2106/RMlhBLDJD9f9yDvtRBh3SX+om2TI+Ket5Oaqk2ycOeGV+kBIOA4=
X-Received: by 2002:a17:907:6091:: with SMTP id ht17mr2504214ejc.626.1643280496825;
 Thu, 27 Jan 2022 02:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20220127083240.1425481-1-houtao1@huawei.com>
In-Reply-To: <20220127083240.1425481-1-houtao1@huawei.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 27 Jan 2022 11:48:02 +0100
Message-ID: <CA+i-1C2HBja-8Am4gHkcrYdkruw0+sOaGDejc9DS-HfYVXVfyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: remove unnecessary handling of BPF_SUB
 atomic op
To:     Hou Tao <houtao1@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yep - BPF_SUB is also excluded in Documentation/networking/filter.rst,
plus the interpreter and verifier don't support it.

Thanks,

Acked-by: Brendan Jackman <jackmanb@google.com>


On Thu, 27 Jan 2022 at 09:17, Hou Tao <houtao1@huawei.com> wrote:
>
> According to the LLVM commit (https://reviews.llvm.org/D72184),
> sync_fetch_and_sub() is implemented as a negation followed by
> sync_fetch_and_add(), so there will be no BPF_SUB op and just
> remove it.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ce1f86f245c9..5d643ebb1e56 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -787,7 +787,6 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>         /* emit opcode */
>         switch (atomic_op) {
>         case BPF_ADD:
> -       case BPF_SUB:
>         case BPF_AND:
>         case BPF_OR:
>         case BPF_XOR:
> --
> 2.29.2
>
