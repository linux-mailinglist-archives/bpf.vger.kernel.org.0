Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3173525FF
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 06:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhDBEMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 00:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBEMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 00:12:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3DC0613E6
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 21:12:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so3649877wrp.13
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ab9mXgnZVMv96jlr6O1hIj0YRsCl0wKzDzAenTSuZc=;
        b=xf/w8QzI+ZBwFIoabuDx3ObP6k759O1uCoWKy8RIkcmvbjl+DGebyX85YYxjgYo4sX
         PaHW64tHXrgYHQBDApeA8ph+hznPztWlLMwAuqexcuiajj5rV0IdISu7vxJlEx7koGkb
         cmxXFNAz9rVUj/h3eC9Chtfz2c3nvzDmCxjioinaxE8P7iQpnz7fL0B9DCgyeWWYflH7
         mTp7kJmwjDBAqoitDCZoxKxQrbvyuWrDiprfRCtkRx9Sga5ojkbpKWXVVgbwg5Nudq3D
         5TARSmVvgAdFsa5vtlxP2J5AzOqXeuDc0OKVeaVKw/l+P/4hKIyB4i5N8arf5pBVZPya
         XjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ab9mXgnZVMv96jlr6O1hIj0YRsCl0wKzDzAenTSuZc=;
        b=flvLwNFSyNAD+CmaNaE9s5A2kKVL6bFqaJdJkw8nOwp2OMHoVpujUMSG1EPAPadUPc
         cxKeh0wfw3LVrDR+8bR4WpCBkwEwoNSch6v6owx/JXVrxg/lSp/Yw1BlI72vEdvWqOEu
         Me99pw9FJWikaSfgukAfHRpfgukmcO7WonHzI0edNb0D/tVCcS9tdhUUCxGptd0w3GMO
         w+oa2wo9SRBiD3zZwpnf2hI+tNmucNH2HbuQc1pC9jCEgnVyUCMI3FbbHcwx8BKlwIQl
         j6hw5zgVVz6FW5VmIUKrylpu0amherYsml7+zxAEzYw8qQMolMVxf/0U07Trf29cj2fM
         yRSw==
X-Gm-Message-State: AOAM533G3HUUV09/t7aTDIEhN3qSxuUfgfMUs9K+HqFkzVW+DtHzjTEc
        9VA3fzJphb84lOi9mIRR4YgdpPq3TLFZPccO8enbZA==
X-Google-Smtp-Source: ABdhPJzce57ZbjTnYu4jCQZ2VOeAbeFZGI80++FdsSrgqHui+/61LSGd1A4m/MCwzZEPoTJBilxreUdun/rWvR5X5xo=
X-Received: by 2002:adf:9544:: with SMTP id 62mr12956426wrs.128.1617336771963;
 Thu, 01 Apr 2021 21:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210401002442.2fe56b88@xhacker> <20210401002651.1da9087e@xhacker>
In-Reply-To: <20210401002651.1da9087e@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Apr 2021 09:42:41 +0530
Message-ID: <CAAhSdy18AwkvNj5bgq6nLV29UNBQcs2MTDCwf_9GL5dC+4=8og@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] riscv: Constify sbi_ipi_ops
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 10:02 PM Jisheng Zhang
<jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Constify the sbi_ipi_ops so that it will be placed in the .rodata
> section. This will cause attempts to modify it to fail when strict
> page permissions are in place.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/smp.h | 4 ++--
>  arch/riscv/kernel/sbi.c      | 2 +-
>  arch/riscv/kernel/smp.c      | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index df1f7c4cd433..a7d2811f3536 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -46,7 +46,7 @@ int riscv_hartid_to_cpuid(int hartid);
>  void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>
>  /* Set custom IPI operations */
> -void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
> +void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
>
>  /* Clear IPI for current CPU */
>  void riscv_clear_ipi(void);
> @@ -92,7 +92,7 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
>         cpumask_set_cpu(boot_cpu_hartid, out);
>  }
>
> -static inline void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
> +static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
>  {
>  }
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index cbd94a72eaa7..cb848e80865e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -556,7 +556,7 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
>         sbi_send_ipi(cpumask_bits(&hartid_mask));
>  }
>
> -static struct riscv_ipi_ops sbi_ipi_ops = {
> +static const struct riscv_ipi_ops sbi_ipi_ops = {
>         .ipi_inject = sbi_send_cpumask_ipi
>  };
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 504284d49135..e035124f06dc 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -85,9 +85,9 @@ static void ipi_stop(void)
>                 wait_for_interrupt();
>  }
>
> -static struct riscv_ipi_ops *ipi_ops __ro_after_init;
> +static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
>
> -void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
> +void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
>  {
>         ipi_ops = ops;
>  }
> --
> 2.31.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
