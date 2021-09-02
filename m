Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479B63FF521
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 22:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhIBUuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhIBUuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 16:50:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC0C061575;
        Thu,  2 Sep 2021 13:49:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a13so4229363iol.5;
        Thu, 02 Sep 2021 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Cf2q5M5Fwhi9VrSL2gabLLP20Hp7viOnQrVVuJp13nI=;
        b=dEWFPXxpAf++gO4BzjkoJgMY2ommnojOTiE3wvGbo2f39MJ7WFrK0zZNjnqJpfUQlT
         7ZP8yxnP6sNXcvM/mrn1zDOAMGuVGfAmtGwsDMG/2BxjKZd88pPXjaAWlqyxBzz55gua
         t9W0XPJ80KzVhCSHCZiE8FrLpSe4TrtLp2n4X0CtlA7QewkFI1ZW55+0btSdG07NrVe1
         lFZt29k14KlHwlTNJtW5CWGoYVf31vZj5hc+MfZl2mypuW8f4frmGeh1d/inLKmzDsJy
         Vnm5LYmSIQBiwOormAKzqwtwTW9Vu5INOlSFwX2gS7joVhoy/JTnifaU4NbZ59ZkjcmI
         0b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Cf2q5M5Fwhi9VrSL2gabLLP20Hp7viOnQrVVuJp13nI=;
        b=o17xIooGTCHZEk5oI2iGXvkdSyJI70xpilnW1mQuHVhm4Xcck7Xfa7MpoZLhnl4bWY
         p0KML6QEOYeTszdjfka6dW2wZMdTca8rY+XO0nvxxRgKRVeSujwrybcUuegHjqb/waIQ
         IZe2/6pKcfh6HAsxt8NKpH8sxyQBMX/ANQvN3SdzHx0jM5O6nLxtxaVQeIJYkQvfjKbl
         FhMWCVtZy6ag5eodh6+PQnbC3IwcXO6hFYOSn2iGDC6R5ICvkNWdYB1yeJvDk4+pJ5+B
         t1dSTvCJ7GwEteSi/pBI13mYcY1JVkA4nW3MxtkHYSn5RkAt7RYWlMZowCC5GQ0DL/tu
         YRUw==
X-Gm-Message-State: AOAM5329lJBDe/fYhKKkjCj9Y40llj1rKiWHuA0UJ3WLgmyszYhMHY0N
        UKAj1Bb8HnbUTJdVt7FSL/o=
X-Google-Smtp-Source: ABdhPJwv4ADR4J+mmssAFyqRNHgIGKK+EfG3o1aivo4JYwPu+UA2KNk0cUecfuXyRjl/OKOieyfe+Q==
X-Received: by 2002:a5e:d80c:: with SMTP id l12mr226738iok.120.1630615790613;
        Thu, 02 Sep 2021 13:49:50 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id g13sm1519011ile.68.2021.09.02.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:49:50 -0700 (PDT)
Date:   Thu, 02 Sep 2021 13:49:43 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        kjain@linux.ibm.com, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>
Message-ID: <613138e72048_2c56f20869@john-XPS-13-9370.notmuch>
In-Reply-To: <20210902165706.2812867-2-songliubraving@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
Subject: RE: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu wrote:
> The typical way to access branch record (e.g. Intel LBR) is via hardware
> perf_event. For CPUs with FREEZE_LBRS_ON_PMI support, PMI could capture
> reliable LBR. On the other hand, LBR could also be useful in non-PMI
> scenario. For example, in kretprobe or bpf fexit program, LBR could
> provide a lot of information on what happened with the function. Add API
> to use branch record for software use.
> 
> Note that, when the software event triggers, it is necessary to stop the
> branch record hardware asap. Therefore, static_call is used to remove some
> branch instructions in this process.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

[...]

>  void intel_pmu_auto_reload_read(struct perf_event *event);
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fe156a8170aa3..4fe11f4f896b1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -57,6 +57,7 @@ struct perf_guest_info_callbacks {
>  #include <linux/cgroup.h>
>  #include <linux/refcount.h>
>  #include <linux/security.h>
> +#include <linux/static_call.h>
>  #include <asm/local.h>
>  
>  struct perf_callchain_entry {
> @@ -1612,4 +1613,26 @@ extern void __weak arch_perf_update_userpage(struct perf_event *event,
>  extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
>  #endif
>  
> +/*
> + * Snapshot branch stack on software events.
> + *
> + * Branch stack can be very useful in understanding software events. For
> + * example, when a long function, e.g. sys_perf_event_open, returns an
> + * errno, it is not obvious why the function failed. Branch stack could
> + * provide very helpful information in this type of scenarios.
> + *
> + * On software event, it is necessary to stop the hardware branch recorder
> + * fast. Otherwise, the hardware register/buffer will be flushed with
> + * entries af the triggering event. Therefore, static call is used to
              ^^
nit, af->of

> + * stop the hardware recorder.
> + */
> +
> +/*
> + * cnt is the number of entries allocated for entries.
> + * Return number of entries copied to .
> + */

A bit out of scope, but LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
