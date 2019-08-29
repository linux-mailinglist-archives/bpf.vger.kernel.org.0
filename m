Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCDA221B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2RXO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 13:23:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35713 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2RXO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 13:23:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so1894808plb.2;
        Thu, 29 Aug 2019 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E3Tm3vXpQRzThkYMW6xItCj6dfrvJmjeOSHqbC0LlwI=;
        b=aytbVsaGGhE4CnFarm9zfCNNNGZMIlp6l2wE/XKg12+9VCpCl/Hz5hC3sDm+JQrBJv
         bx7fT5E5CEim6hDoKSUvZKusJM1god1y498pvfNm74Qyx4Kf1anr8qwWXOjCBfig/Xxq
         D+GZB1t/iZLiJoxsAKwN0gF9xwmCdhMx2wYyQSDqNC2/goF3CgaBOC18HqoCEvNB+BaC
         xuU1qAahdPrX4EW2dMvAeeTcw+Im2cuFJ0zUybvUlkG0mo6DqOUNR1/GONIOT8pa7caD
         OyX93vl8dktzUk23EFUW8wRwPlbtHNtRfOSempaudxSn7BacWdnYz+0auodTEdU5uvjk
         dGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E3Tm3vXpQRzThkYMW6xItCj6dfrvJmjeOSHqbC0LlwI=;
        b=tp62JvdACDujN9sERMVpkLSLxEuuadT/sRYZfrh3+d0rZLoqwu98ESU/HG0vNmEDLC
         Dc6BM1EFBtVbJNRkqANPV1kGspdCQqsVur7MzvHzXlNeLx1p0OoOnwYBpugepGKRRSTe
         i9+yrL1GJ/FImaP2POf3HvI8QoQ1dDOFQODn7XX3bIGuKXm+I/u5Fmet3KnLsRZI3hWu
         syKZ/AD0QWn+1LSKnWqIDvCrY+yBxEawn4xfQ/btbgHCe/6dEkyBj54y6oNwI3PmBZ3R
         1b2pg9Cg9gjC5RN1welK5BdsrrIoundVAeF3RaIoAivYblKFaDVZhTwi6e4mLL8/84g8
         U9lg==
X-Gm-Message-State: APjAAAWs/jbeE6+EZzdbnWbTPEN/d2jsl5aNb5UL8ygMaJ49bYpeHGDO
        KluC1lPk3fBK1WHMaI9Tksc=
X-Google-Smtp-Source: APXvYqxo4IbB5Ioulw4J7EjTIdR49mPTgSlPTN/mT0BFkG97AqcMGkRLfReCMEbIQ8djWYddYagM7A==
X-Received: by 2002:a17:902:244:: with SMTP id 62mr11042910plc.243.1567099393698;
        Thu, 29 Aug 2019 10:23:13 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::2:1347])
        by smtp.gmail.com with ESMTPSA id n24sm3140849pjq.21.2019.08.29.10.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:23:12 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:23:10 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, capabilities: introduce CAP_BPF
Message-ID: <20190829172309.xd73ax4wgsjmv6zg@ast-mbp.dhcp.thefacebook.com>
References: <20190827205213.456318-1-ast@kernel.org>
 <CALCETrV8iJv9+Ai11_1_r6MapPhhwt9hjxi=6EoixytabTScqg@mail.gmail.com>
 <20190828071421.GK2332@hirez.programming.kicks-ass.net>
 <20190828220826.nlkpp632rsomocve@ast-mbp.dhcp.thefacebook.com>
 <20190829093434.36540972@gandalf.local.home>
 <CALCETrWYu0XB_d-MhXFgopEmBu-pog493G1e+KsE3dS32UULgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWYu0XB_d-MhXFgopEmBu-pog493G1e+KsE3dS32UULgA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 29, 2019 at 08:43:23AM -0700, Andy Lutomirski wrote:
> 
> I can imagine splitting it into three capabilities:
> 
> CAP_TRACE_KERNEL: learn which kernel functions are called when.  This
> would allow perf profiling, for example, but not sampling of kernel
> regs.
> 
> CAP_TRACE_READ_KERNEL_DATA: allow the tracing, profiling, etc features
> that can read the kernel's data.  So you get function arguments via
> kprobe, kernel regs, and APIs that expose probe_kernel_read()
> 
> CAP_TRACE_USER: trace unrelated user processes
> 
> I'm not sure the code is written in a way that makes splitting
> CAP_TRACE_KERNEL and CAP_TRACE_READ_KERNEL_DATA, and I'm not sure that
> CAP_TRACE_KERNEL is all that useful except for plain perf record
> without CAP_TRACE_READ_KERNEL_DATA.  What do you all think?  I suppose
> it could also be:
> 
> CAP_PROFILE_KERNEL: Use perf with events that aren't kprobes or
> tracepoints.  Does not grant the ability to sample regs or the kernel
> stack directly.
> 
> CAP_TRACE_KERNEL: Use all of perf, ftrace, kprobe, etc.
> 
> CAP_TRACE_USER: Use all of perf with scope limited to user mode and uprobes.

imo that makes little sense from security pov, since
such CAP_TRACE_KERNEL (ex kprobe) can trace "unrelated user process"
just as well. Yet not letting it do cleanly via uprobe.
Sort of like giving a spare key for back door of the house and
saying no, you cannot have main door key.

