Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0F6885A1
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBBRl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjBBRl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 12:41:58 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819A29E13
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 09:41:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g68so1851945pgc.11
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfX5H9V5MrNKSKkgY4eT0EcmzgQwTbioJAoXOa/XrdM=;
        b=IBZzloQpx+KZogx2fGBmgKgaUAbIFkVMpIm0OS/6MUGMRU1dp6fG86bwon2V5JrY66
         kAdCfoVE0qvqVphmSTSn8iAhN6TrquxZf1GEkTI6WSPmva4mcCa1rGjGFSFRC9v1FXOw
         oHqgNRGdHiN5ubnh7PWo8Bp0pGDrOy9xvWku8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfX5H9V5MrNKSKkgY4eT0EcmzgQwTbioJAoXOa/XrdM=;
        b=RgBdcGIHK/yktHwjud9sks8ERcNZn21vk7f9A0NN1FsBMDL3KIfNb1ohIX9Ou0rKEA
         T5yZDUC8JL66LWiK1LTQeLpX/fjXOm6FOPnAPjtcUqTZ24uBDnYilGLjRnktbQuO6NTz
         uOXhJ2+moHI8biV1OrfgYNoIEgUM8ztjydLKBjeN4QEYmqGato17asLA6h2ek1TkpmmM
         NCNIJkULkBDg4t/F7P5ZADG8Pl3UYkWjFeqGUAsUfOx6U3JRr63MJnzpJ0Yt6mTcPNZ+
         aE7fAHhALxsRZfRuZu6ZY05A+Fr+P4REsYupKNwhNFU/El375j599CjopmWwBR5ny5mp
         LkVQ==
X-Gm-Message-State: AO0yUKXEbF+RixxbepaFxJ6YbSNBQVoMOx2ufR+jdUh3mdPXJgfoL8ue
        6vB3WNoPOpoeRbtZjry22k+TQI1JYWRSuvo5BWdAAg==
X-Google-Smtp-Source: AK7set9CPjhJRe6HGlggG3wVT7dSPHFZm+o5JvOQnESuOBjfXgM5pycZKi4DteYQDc4MkI8O5W97QQpw38zisdpCXsk=
X-Received: by 2002:a05:6a00:b41:b0:58b:c7ef:25ca with SMTP id
 p1-20020a056a000b4100b0058bc7ef25camr1848836pfo.51.1675359716731; Thu, 02 Feb
 2023 09:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-5-revest@chromium.org>
 <Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 2 Feb 2023 18:41:45 +0100
Message-ID: <CABRcYmJQiyZE__JD=xyt-PhAwj0Jpo2kkgmLcm-cD58cryD0ZQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] ftrace: Store direct called addresses in their ops
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 4:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 01, 2023 at 05:34:16PM +0100, Florent Revest wrote:
> > All direct calls are now registered using the register_ftrace_direct API
> > so each ops can jump to only one direct-called trampoline.
> >
> > By storing the direct called trampoline address directly in the ops we
> > can save one hashmap lookup in the direct call ops and implement arm64
> > direct calls on top of call ops.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  include/linux/ftrace.h | 3 +++
> >  kernel/trace/ftrace.c  | 6 ++++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index a7dbd307c3a4..84f717f8959e 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -321,6 +321,9 @@ struct ftrace_ops {
> >       unsigned long                   trampoline_size;
> >       struct list_head                list;
> >       ftrace_ops_func_t               ops_func;
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +     unsigned long                   direct_call;
> > +#endif
> >  #endif
> >  };
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index cb77a0a208c7..b0426de11c45 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2577,9 +2577,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> >                             struct ftrace_ops *ops, struct ftrace_regs *fregs)
> >  {
> > -     unsigned long addr;
> > +     unsigned long addr = ops->direct_call;
> >
> > -     addr = ftrace_find_rec_direct(ip);
> >       if (!addr)
> >               return;
> >
> > @@ -5375,6 +5374,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >       ops->func = call_direct_funcs;
> >       ops->flags = MULTI_FLAGS;
> >       ops->trampoline = FTRACE_REGS_ADDR;
> > +     ops->direct_call = addr;
> >
> >       err = register_ftrace_function_nolock(ops);
> >
> > @@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >       /* Enable the tmp_ops to have the same functions as the direct ops */
> >       ftrace_ops_init(&tmp_ops);
> >       tmp_ops.func_hash = ops->func_hash;
> > +     tmp_ops.direct_call = addr;
> >
> >       err = register_ftrace_function_nolock(&tmp_ops);
> >       if (err)
> > @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >                       entry->direct = addr;
> >               }
> >       }
> > +     ops->direct_call = addr;
>
> AFAICT we don't synchronize threads when installing the tmp_ops, so IIUC on
> arches with call_ops, there could be a a thread in the middle of ftrace_caller
> which has loaded the ops pointer from the patch-site, but hasn't yet loaded the
> ops::direct_func pointer, and could race with this assignment.
>
> Given that, I think this needs to be:
>
>         WRITE_ONCE(ops->direct_call, addr);
>
> ... in order to avoid the risk of the store being torn, and the ftrace_caller
> trampoline loading a corrupted pointer.

Good point, I'll do that in v2.
