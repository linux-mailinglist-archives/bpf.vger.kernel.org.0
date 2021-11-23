Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2B45AA55
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 18:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhKWRtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 12:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhKWRtC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 12:49:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF7860F6F
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637689554;
        bh=5jjLEuYIs6C8r2EFDDWZc812z7E65yuu9g9TzPmgXuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tUteAxV00DOy3jVoKMvUhlUFxJzWIwwPwU1aQxWt1zmY2bay2w6l6LNm7Jez0vfyG
         YQtDh0Y1yIgjVU79LasOBJ1JvE2ZxmAaD1Y6j4vFEKnUswJVsk2uCyLlI9WJh4ft9N
         X0WFyuEPxiM7k0GzMG8cnYeex/vkUIochLgHtwYB4NDmSNQ7rxBR6Yk6SvrgFgab6p
         M+/vtC5GOtX4gxM/oKq50yebQEP3dVGai8CMYsp7ALBgu0fJSfnsVBeh/EZhoYwYVs
         kNlboOP0jAvBKOJpcS4O67Z9CNfaFrIIDdpjEEQL0jYJvJ11EiHS/XvGqVowtR9Buh
         DQJBtucQg34pw==
Received: by mail-yb1-f170.google.com with SMTP id v203so25175328ybe.6
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 09:45:54 -0800 (PST)
X-Gm-Message-State: AOAM530kzUfPlrgCGwwrTvwl5A9UxGRvSmiZrxvIoGOnVMbYGpkxndI2
        /vhD9X5WMJ179Y1h+Wv5iWHBVwZJhWRPqEolQz0=
X-Google-Smtp-Source: ABdhPJwu7Qe3mguuVpEgGDFFFwnwUZQVpRPJs+DQgMSrn4carwSRXSFSdil/HyBUPJtKSkhJsunNt/aFIk+XZ9gfaLk=
X-Received: by 2002:a25:af82:: with SMTP id g2mr8394965ybh.509.1637689553347;
 Tue, 23 Nov 2021 09:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20211120165528.197359-1-kuba@kernel.org>
In-Reply-To: <20211120165528.197359-1-kuba@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 Nov 2021 07:45:41 -1000
X-Gmail-Original-Message-ID: <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
Message-ID: <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        bpf <bpf@vger.kernel.org>, james.morse@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 6:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> This commit more or less reverts commit 709c4362725a ("cacheinfo:
> Move resctrl's get_cache_id() to the cacheinfo header file").
>
> There are no users of the static inline helper outside of resctrl/core.c
> and cpu.h is a pretty heavy include, it pulls in device.h etc. This
> trips up architectures like riscv which want to access cacheinfo
> in low level headers like elf.h.
>
> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: fenghua.yu@intel.com
> CC: reinette.chatre@intel.com
> CC: tglx@linutronix.de
> CC: mingo@redhat.com
> CC: bp@alien8.de
> CC: dave.hansen@linux.intel.com
> CC: x86@kernel.org
> CC: hpa@zytor.com
> CC: paul.walmsley@sifive.com
> CC: palmer@dabbelt.com
> CC: aou@eecs.berkeley.edu
> CC: peterz@infradead.org
> CC: will@kernel.org
> CC: linux-riscv@lists.infradead.org
>
> x86 resctrl folks, does this look okay?
>
> I'd like to do some bpf header cleanups in -next which this is blocking.
> How would you like to handle that? This change looks entirely harmless,
> can I get an ack and take this via bpf/netdev to Linus ASAP so it
> propagates to all trees?

Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
bpf header cleanup in -next, we can simply include it in a set for bpf-next.

Thanks,
Song


> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 20 ++++++++++++++++++++
>  include/linux/cacheinfo.h          | 21 ---------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index bb1c3f5f60c8..3c0b2c34be23 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -284,6 +284,26 @@ static void rdt_get_cdp_l2_config(void)
>         rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
>
> +/*
> + * Get the id of the cache associated with @cpu at level @level.
> + * cpuhp lock must be held.
> + */
> +static int get_cpu_cacheinfo_id(int cpu, int level)
> +{
> +       struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> +       int i;
> +
> +       for (i = 0; i < ci->num_leaves; i++) {
> +               if (ci->info_list[i].level == level) {
> +                       if (ci->info_list[i].attributes & CACHE_ID)
> +                               return ci->info_list[i].id;
> +                       return -1;
> +               }
> +       }
> +
> +       return -1;
> +}
> +
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 2f909ed084c6..c8c71eea237d 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -3,7 +3,6 @@
>  #define _LINUX_CACHEINFO_H
>
>  #include <linux/bitops.h>
> -#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/smp.h>
>
> @@ -102,24 +101,4 @@ int acpi_find_last_cache_level(unsigned int cpu);
>
>  const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
>
> -/*
> - * Get the id of the cache associated with @cpu at level @level.
> - * cpuhp lock must be held.
> - */
> -static inline int get_cpu_cacheinfo_id(int cpu, int level)
> -{
> -       struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> -       int i;
> -
> -       for (i = 0; i < ci->num_leaves; i++) {
> -               if (ci->info_list[i].level == level) {
> -                       if (ci->info_list[i].attributes & CACHE_ID)
> -                               return ci->info_list[i].id;
> -                       return -1;
> -               }
> -       }
> -
> -       return -1;
> -}
> -
>  #endif /* _LINUX_CACHEINFO_H */
> --
> 2.31.1
>
