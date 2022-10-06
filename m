Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D315F6B65
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiJFQTc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiJFQT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 12:19:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC9B2768
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 09:19:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lx7so2223031pjb.0
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6vcGCSyh/yp3xC5uIRVMFXTdQ0xt3noIJJL9jaVO1sg=;
        b=QE3AQCSyl7woC242XO7P+dERgkeafBZ9F3zsmCqLJmcvrmgNZttdSaiJ4dMoaGtJ+X
         WTd7v/l1hw0gNdEfTQbpPvvNXjQniznxY91XzEe3CGz4CdVhgsFGKs55j8StOhA7Y1AF
         hNQdQEysPtPt9NLxouU0Jkck7fI5G5clOUuBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6vcGCSyh/yp3xC5uIRVMFXTdQ0xt3noIJJL9jaVO1sg=;
        b=B6EE6IlcRu2BubE4xYuxaaFTt8JENF7evY4H7RULvGtvyYkWCiFuJcOWxkD4YjhBRG
         eebpdYRU06LOIkhODNcYqaPgsLhcibDjMsQim8SF+sweXAsAp2dXtrGJllGEPoiye6ZD
         M5Tdbb1OB6VAlGZxrjOXVdS2A3mKe5LcD8TiVF/oMpIKey/4fSoFl5K2GTD+c1V+3HbM
         Di2HSJc+oGZ36o4/8PXebT2Dnk0RBdSAcGISpkL9Ahf5Pjc0VTNXA86PfJjd2iyPHwcP
         fMlk3RVrA+3OB1etXMoeb6XQa6MrX6u0oXSW3xIQ4arEWXr2h6rMsKqT5LysV3Bio4yl
         eMMQ==
X-Gm-Message-State: ACrzQf0UiA7B4K1aS1oR3B/ISm8Kmy75odvlRmZg19x26hls7FCG0SRP
        pJ7sYr+mXPLfEe59eDSqNrXuxJebE/tBy2kDq4kHuQ==
X-Google-Smtp-Source: AMsMyM5CP9aOlQkgIAdUuJuavCyQyZFUoy/1rQLLbWzXu4IQ8rUOqBG0DimAQLu5yLpHZ4X73ng7oEKd1LiUvV3fITE=
X-Received: by 2002:a17:902:8542:b0:179:eb8d:f41d with SMTP id
 d2-20020a170902854200b00179eb8df41dmr247725plo.62.1665073163603; Thu, 06 Oct
 2022 09:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net> <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N> <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N> <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com> <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com> <20221005113019.18aeda76@gandalf.local.home>
In-Reply-To: <20221005113019.18aeda76@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 6 Oct 2022 18:19:12 +0200
Message-ID: <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 5, 2022 at 5:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Oct 2022 17:10:33 +0200
> Florent Revest <revest@chromium.org> wrote:
>
> > On Wed, Oct 5, 2022 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Can you show the implementation of the indirect call you used?
> >
> > Xu used my development branch here
> > https://github.com/FlorentRevest/linux/commits/fprobe-min-args
>
> That looks like it could be optimized quite a bit too.
>
> Specifically this part:
>
> static bool bpf_fprobe_entry(struct fprobe *fp, unsigned long ip, struct ftrace_regs *regs, void *private)
> {
>         struct bpf_fprobe_call_context *call_ctx = private;
>         struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
>         struct bpf_tramp_links *links = fprobe_ctx->links;
>         struct bpf_tramp_links *fentry = &links[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fmod_ret = &links[BPF_TRAMP_MODIFY_RETURN];
>         struct bpf_tramp_links *fexit = &links[BPF_TRAMP_FEXIT];
>         int i, ret;
>
>         memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
>         call_ctx->ip = ip;
>         for (i = 0; i < fprobe_ctx->nr_args; i++)
>                 call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
>
>         for (i = 0; i < fentry->nr_links; i++)
>                 call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
>
>         call_ctx->args[fprobe_ctx->nr_args] = 0;
>         for (i = 0; i < fmod_ret->nr_links; i++) {
>                 ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
>                                       call_ctx->args);
>
>                 if (ret) {
>                         ftrace_regs_set_return_value(regs, ret);
>                         ftrace_override_function_with_return(regs);
>
>                         bpf_fprobe_exit(fp, ip, regs, private);
>                         return false;
>                 }
>         }
>
>         return fexit->nr_links;
> }
>
> There's a lot of low hanging fruit to speed up there. I wouldn't be too
> fast to throw out this solution if it hasn't had the care that direct calls
> have had to speed that up.
>
> For example, trampolines currently only allow to attach to functions with 6
> parameters or less (3 on x86_32). You could make 7 specific callbacks, with
> zero to 6 parameters, and unroll the argument loop.

Sure, we can give this a try, I'll work on a macro that generates the
7 callbacks and we can check how much that helps. My belief right now
is that ftrace's iteration over all ops on arm64 is where we lose most
time but now that we have numbers it's pretty easy to check hypothesis
:)
