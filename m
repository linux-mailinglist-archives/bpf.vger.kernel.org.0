Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439E4A938F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 06:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiBDFZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 00:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBDFZx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 00:25:53 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C71C061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:25:53 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r144so6044485iod.9
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 21:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHS4s3XraIYOLvniup7ctP685Jp+gVpWTDXBHSEcjdU=;
        b=ECjEmk+TP5t4aEiYlmQS3qBXuZfymi7r6uL83yx/LSIaECo3jyXYaE7RuiqqIPivns
         t1xpr4/oF+KAwgDhW/VJW5w35C+v6vrucFRqWYN6AyL0aRc7yUN+fb1nK6xogF5OAN29
         XrwCa6NNfE6oiMK74HjkbchrxgJ4DGpbkMUcCm0rpKsGmJWestT7o/+uNUVBkNc3oKHF
         9O+k30DaRsXmjEMET0Lcm4y3TkwwCnbJHmBi3NJsuYfgwdJHqvJyr8QKK+DZEqTGu+uc
         4M4dxDi+4fghT6wwKtmR8nH983net2PlrhgIbvfn8EoY3xCwwXs9HZmbYyUOKvUR6VRD
         aLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHS4s3XraIYOLvniup7ctP685Jp+gVpWTDXBHSEcjdU=;
        b=HlF00aErIwSe2dTLPXP8HppQoCYTXivEIPkadPAXuVduu/EtrH1bB1OombqblArD24
         rhUdkEVSqup70UyIM6cSNFTk8Y7V8GGcaV0bCPdfcQtrB5ASWRTJtpUWBpNVlScbImpy
         Q/Sl8psIqXSppXKe+OhNs+G00VbCiewnUkQ7g10Ym2a1f8pNrNtwqXwl+kzpld4zy1Ez
         4m4Dgl6Jo35kDWB6j2mMP8pvIvZqePQyC69EY/eLHa8tg0d/rv+s8dCCSewuFN6RDEqR
         w+u7IaT3xi3+vT5xKWhYqdOr3ez80TEn20guZ/GC3QfTHpuXSwFqyxKEAALXk+gXUhd0
         SCCQ==
X-Gm-Message-State: AOAM531z/9bHL1H3PiCNDlmj/+2Df6tyVOb0MKGBBuliZ61d8E05hkOD
        JVxs3jPkNhLCQNGBKpekXy5OT2LXKeEuHAhhkz8=
X-Google-Smtp-Source: ABdhPJxWtZtwgN9gjXgZUMJApuGrY+r2qe99LpFo7ncjkJVWnu3L0VpbYl1mZNBLaqVyiLZTuMAURp64bLsvO1dfzTE=
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr625134jak.103.1643952352626;
 Thu, 03 Feb 2022 21:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com> <20220204041955.1958263-10-iii@linux.ibm.com>
In-Reply-To: <20220204041955.1958263-10-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Feb 2022 21:25:41 -0800
Message-ID: <CAEf4BzZMA4eProszPhP_EdxZVrusYA8bqODj-PGrcE1Uradgqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/10] libbpf: Fix accessing syscall arguments
 on riscv
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> riscv's syscall handlers get "unpacked" arguments instead of a
> struct pt_regs pointer. Indicate this to libbpf using PT_REGS_SYSCALL
> macro.
>
> Fixes: d084df3b7a4c ("libbpf: Fix the incorrect register read for syscalls on x86_64")

This doesn't really fix that commit, it just adds an analogous fix for
a different architecture.

> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index c21aaecd711b..2b707aff0763 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -213,7 +213,8 @@
>  #define __PT_FP_REG fp
>  #define __PT_RC_REG a5
>  #define __PT_SP_REG sp
> -#define __PT_IP_REG epc
> +#define __PT_IP_REG pc

Is this epc -> pc change intentional? If yes, please split it into a
separate patch with corresponding Fixes tag and explanation.

> +#define PT_REGS_SYSCALL(ctx) ctx
>
>  #endif
>
> --
> 2.34.1
>
