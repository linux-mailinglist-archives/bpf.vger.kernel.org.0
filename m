Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F3308346
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhA2Bfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhA2Bfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:35:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5BC061574;
        Thu, 28 Jan 2021 17:34:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so4392407plp.2;
        Thu, 28 Jan 2021 17:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KAt3Hk/Gb8LcoZvRv5KF3fdtULJAnVajhPJ6RzP37DM=;
        b=VfM5wrHIqATpQSuV0AhRwziEq1pHorb28/ZaQ87FB4aq06fwkU3RvWk/DcJ1/JZEw4
         VCvYp4M+9iUKppz9ZKRLyA8yCKmlESyikDjfxdQnQT2JqBvTCAabw0cZ8DNT/juIP0Mx
         ofsCW0NnBiwbIwJj5MgbmexRJdHbD7Ot2aeRW/JIgaXoJUnYn302sxPhRAwT5e8h/t2Y
         Z/XaczmTvmF5Zw0vBSkTNTmsbjQUQdM8lsRROfbR+p4TiogC9FEcQgXV+B2Fpf+k2piW
         cCPO5o8rF8FzyD9yNcMEIg8vZZcH/PHpGB654vBm7avfe41JZiIDpJ34G0i55laclM4+
         Zo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAt3Hk/Gb8LcoZvRv5KF3fdtULJAnVajhPJ6RzP37DM=;
        b=WZwuqNG/NmGREYR4I6liqVYxEacotxAqhWrntVopYjoN6bHOIggletKd1Fi26g4SpK
         3VrRJEN4Q4d3I25qYtssnrQNe1t0C37+4Vl4eujjytneV6nkUko5d/B1wGiDGfTc8Czj
         ZLAa8XnqeHCmXqZLUNesbEg/1NEvddSEfpD77jdkRN0w+Rz4yBwHDEqz+NGAlbkKj4Ai
         ncmjzsUoyRTGpKh+KSuqIhDbyG70B1+tHEhoHGlMQC69ICNIzWG+aNwKsJXZBw1ZrFB7
         3xu7+nQz9hvIR+WkomlZqTrc0MDqgzDOtjAupNaxZV/V2/t7/GlexfOr0TfBW/InlMKT
         28ww==
X-Gm-Message-State: AOAM532QYp2ftZNSAwk+op4zIeCTfjZNqR7p/xHmde9mbf7FSi2qmZrd
        dj5eUsc6lfNgCmitAqomWaA=
X-Google-Smtp-Source: ABdhPJxLZ+kjEBIMZiWiFSZyzY2jPo9djFz/eRnpY8NyJEFhGpT6sPmvYX55yJKF/6CPquwjKNsaDQ==
X-Received: by 2002:a17:90b:513:: with SMTP id r19mr2175055pjz.38.1611884095994;
        Thu, 28 Jan 2021 17:34:55 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id q79sm7677468pfc.63.2021.01.28.17.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:34:55 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:34:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
 <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 07:24:14PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 28, 2021 at 06:45:56PM +0200, Nikolay Borisov wrote:
> > it would be placed on the __fentry__ (and not endbr64) hence it works.
> > So perhaps a workaround outside of bpf could essentially detect this
> > scenario and adjust the probe to be on the __fentry__ and not preceding
> > instruction if it's detected to be endbr64 ?
> 
> Arguably the fentry handler should also set the nmi context, it can,
> after all, interrupt pretty much any other context by construction.

But that doesn't make it a real nmi.
nmi can actually interrupt anything. Whereas kprobe via int3 cannot
do nokprobe and noinstr sections. The exposure is a lot different.
ftrace is even more contained. It's only at the start of the functions.
It's even smaller subset of places than kprobes.
So ftrace < kprobe < nmi.
Grouping them all into nmi doesn't make sense to me.
That bpf breaking change came unnoticed mostly because people use
kprobes in the beginning of the functions only, but there are cases
where kprobes are in the middle too. People just didn't upgrade kernels
fast enough to notice.
imo appropriate solution would be to have some distinction between
ftrace < kprobe_via_int3 < nmi, so that bpf side can react accordingly.
That code in trace_call_bpf:
  if (in_nmi()) /* not supported yet */
was necessary in the past. Now we have all sorts of protections built in.
So it's probably ok to just drop it, but I think adding
called_via_ftrace vs called_via_kprobe_int3 vs called_via_nmi
is more appropriate solution long term.
