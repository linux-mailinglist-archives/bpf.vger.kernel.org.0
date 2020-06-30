Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEC20ED47
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgF3FRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 01:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3FRE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 01:17:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D8C061755;
        Mon, 29 Jun 2020 22:17:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so7107736plm.10;
        Mon, 29 Jun 2020 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hp+HnDhs/4eD0oclIHVQN7L3ud8iDGI74HhAm9juhsw=;
        b=lQCPK4Dlt4VIzph2W3LXFszIK1ohIrBI7n9kuUNFAVxsLkM+WGDPqRzMDJi4kU42pY
         wAKEHaywQgwb7/1s3AUx49llgM/iSlkAcmsVTgBLY3s4fQ9CsVPXW7qkHRBzCoiH7X7W
         XVCcuSVNuiDZ35YY5dcGpegczFd4LlYGmB/yq5P8kMv+O3FtAscY7iDW30xKPXEcTIRN
         biVsBtbIOOiNL0ExmRzx1i3fGdBjiA4OrtzQLMoP8faT4GGeFXEe5PcVRyCwulABVk63
         f0M09Q3UIl7Da7ZcNh1o9X06jlyvFtdIF2CX7EV7vcf5n4WfPuH68OI23LdXUlZsoZVr
         Q5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hp+HnDhs/4eD0oclIHVQN7L3ud8iDGI74HhAm9juhsw=;
        b=mXoBEnFS0LpjnUHfm7Uxs9hHKKt6E9hdiojfc8Mhx1aoZDrLcCZWmjun5fE97HE5ZB
         i3UmPjBBh/ZA1coxZN8VBu21ykSzDYs/UJe3DiNPojB29DaI1LIJDv2SHsU5B8/ALthO
         mkV3GRVXamXTdrDqFAqNF5yL6WYFpSMK3HqkuGryg0fmBHefYEk51+pkJDP7l6x/ADVL
         JvxxR8KuguEqCiP8K8a9nZdPCZrk9siwJqMPiP5TiltlspnWUvI9Chv2gmbdjeebI0OS
         EesOhvEUAQstfMGVUN7HX/JfBYv0zCcvszmgI+AtSnVmU7XJiYCrI0MF/8oSUELOawwq
         5eVg==
X-Gm-Message-State: AOAM532gRZJ8IdbDwGFi98AJu061u0oFMc6Ow0FJldadU0ZgZmIxS/N4
        +YS6VLeeYO2A4LZlNS016ew=
X-Google-Smtp-Source: ABdhPJzaAWpAzzSp+Qi2HKKoLwoETD9wPt0PvMKWn9nVb71tk7lC9Zoq/oQIjSFLzcSIs0jlV4+n9g==
X-Received: by 2002:a17:90a:8b91:: with SMTP id z17mr19898205pjn.151.1593494223497;
        Mon, 29 Jun 2020 22:17:03 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:140c])
        by smtp.gmail.com with ESMTPSA id r1sm952646pjd.47.2020.06.29.22.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 22:17:02 -0700 (PDT)
Date:   Mon, 29 Jun 2020 22:16:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Message-ID: <20200630051659.uqnkkwaho3lvvnu7@ast-mbp.dhcp.thefacebook.com>
References: <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
 <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
 <20200626181455.155912d9@oasis.local.home>
 <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
 <20200628144616.52f09152@oasis.local.home>
 <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
 <20200628154331.2c69d43e@oasis.local.home>
 <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
 <20200628182842.2abb0de2@oasis.local.home>
 <20200628194334.6238b933@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628194334.6238b933@oasis.local.home>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 28, 2020 at 07:43:34PM -0400, Steven Rostedt wrote:
> On Sun, 28 Jun 2020 18:28:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > You create a bpf event just like you create any other event. When a bpf
> > program that uses a bpf_trace_printk() is loaded, you can enable that
> > event from within the kernel. Yes, there's internal interfaces to
> > enabled and disable events just like echoing 1 into
> > tracefs/events/system/event/enable. See trace_set_clr_event().
> 
> I just started playing with what the code would look like and have
> this. It can be optimized with per-cpu sets of buffers to remove the
> spin lock. I also didn't put in the enabling of the event, but I'm sure
> you can figure that out.
> 
> Warning, not even compiled tested.

Thanks! I see what you mean now.

> 
> -- Steve
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 6575bb0a0434..aeba5ee7325a 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -31,6 +31,8 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>  
> +CFLAGS_bpf_trace.o := -I$(src)

not following. why this is needed?

> +
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>  
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index dc05626979b8..01bedf335b2e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -19,6 +19,9 @@
>  #include "trace_probe.h"
>  #include "trace.h"
>  
> +#define CREATE_TRACE_EVENTS

CREATE_TRACE_POINTS ?

> +#include "bpf_trace.h"
> +
>  #define bpf_event_rcu_dereference(p)					\
>  	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
>  
> @@ -473,13 +476,29 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
>  		fmt_cnt++;
>  	}
>  
> +static DEFINE_SPINLOCK(trace_printk_lock);
> +#define BPF_TRACE_PRINTK_SIZE	1024
> +
> +static inline void do_trace_printk(const char *fmt, ...)
> +{
> +	static char buf[BPF_TRACE_PRINT_SIZE];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&trace_printk_lock, flags);
> +	va_start(ap, fmt);
> +	vsnprintf(buf, BPF_TRACE_PRINT_SIZE, fmt, ap);
> +	va_end(ap);
> +
> +	trace_bpf_trace_printk(buf);
> +	spin_unlock_irqrestore(&trace_printk_lock, flags);

interesting. I don't think anyone would care about spin_lock overhead.
It's better because 'trace_bpf_trace_printk' would be a separate event
that can be individually enabled/disabled?
I guess it can work.
Thanks!
