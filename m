Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77048689772
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 12:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjBCLBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 06:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBCLBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 06:01:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC179639
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 03:01:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l4-20020a17090a850400b0023013402671so8433483pjn.5
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=smoE99lYqF9OtoFAefwmIaEGKk9MXYc6gAi/SfQ6S5o=;
        b=RiMx8wCN8L74r8xqXqmhHt5YDiuPIUD3lIgV4nA3Jn+HglL2FQHWx4UGSlAoyiwkKZ
         7QwqypCmr9w1CZfAkFzdnp6mMMSYpNzw4NsqATw7CMFyZFDOZV5zCDrtdi5Tx1cohCXR
         +oG9oo3w80TVUDO6QZqBipWhDmXOX+cA/cGB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smoE99lYqF9OtoFAefwmIaEGKk9MXYc6gAi/SfQ6S5o=;
        b=NaQOS1bfECLl+RJ7/h1CAShIdSlkyQeFlSJLH0l8/4zaD9tgP9aRt7Tg6XScKDxVd0
         /esogdyWPx21R6t4XzT9QRs93ZXU1hKQjDwCFcjbE//1twPLPtVKovRrpkPAlbzdcWDH
         DC5MkuKhepqJRm6Cz9HnugCQQ1hHxElntsxYhgOLYmp5VBLZ9QQXdlRzOAnoopPwxjDA
         XC4czHTbovc/hmFyXEvXFvbUNHTZWuafQNL18wS25SikgJZDaSmfV0D+yUcFnepPyZSo
         a3OzAwWHjcYA6PVjFlMm7XeGF1EtohhOrMAAWaO7a8iDI87oHPyrR3fqgKFtObXjKOW1
         7k4Q==
X-Gm-Message-State: AO0yUKUPZjv/h+HdO1LWlJNrM2lRqt64syz0HTF1dTIiKpiKyaBP7XQi
        mIHU2O+3axnN1eErh4DbZTJcq/tiXrOBlvdtjDyxjg==
X-Google-Smtp-Source: AK7set9Z93YpJ222AxyxW4G54MZBshv84MlYZdvH+Ot8YqQbnIBZzX6aPxafVyJxCLs/rYBjxj9uvPTnMVqYSJhBHKE=
X-Received: by 2002:a17:90b:31ce:b0:22c:3e91:15e6 with SMTP id
 jv14-20020a17090b31ce00b0022c3e9115e6mr1157227pjb.17.1675422107522; Fri, 03
 Feb 2023 03:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-6-revest@chromium.org>
 <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com> <Y9vrWUM8ypNNwHyv@FVFF77S0Q05N.cambridge.arm.com>
 <CABRcYm+nwsyyKEhvz9dr8sDiOWfha-YxOkGMFSx4mH9O+HAiYg@mail.gmail.com> <Y9zb+uKqQN9gJJBI@FVFF77S0Q05N>
In-Reply-To: <Y9zb+uKqQN9gJJBI@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 3 Feb 2023 12:01:36 +0100
Message-ID: <CABRcYmKMdoEAH=ua+AKJyMTt_xMvV0jisAFcr4UuVOJGDzHdfw@mail.gmail.com>
Subject: Re: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 3, 2023 at 11:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Feb 02, 2023 at 07:19:58PM +0100, Florent Revest wrote:
> > On Thu, Feb 2, 2023 at 5:57 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 84f717f8959e..3d2156e335d7 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -241,6 +241,12 @@ enum {
> > >         FTRACE_OPS_FL_DIRECT                    = BIT(17),
> > >  };
> > >
> > > +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > +#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
> > > +#else
> > > +#define FTRACE_OPS_FL_SAVE_ARGS                        0
> >
> > Mh, could we (theoretically) be in a situation where an arch supports
> > WITH_ARGS but it also has two ftrace_caller trampolines: one that
> > saves the args and the other that saves nothing ? (For example if x86
> > migrates their WITH_REGS to WITH_ARGS only)
>
> I don't think so -- the point of WITH_ARGS is that we always have to
> save/restore the args, and when WITH_ARGS is selected they're unconditionally
> available (though not necessarily a full pt_regs), which is what other code
> assumes when WITH_ARGS is selected.

Perfect then!

> > Wouldn't it make sense then to define FTRACE_OPS_FL_SAVE_ARGS as an
> > extra bit to tell ftrace that we need the args, similarly to
> > FTRACE_OPS_FL_SAVE_REGS ?
> >
> > If that can't happen or if we want to leave this up for later, the
> > patch lgtm and I can squash it into my patch 5 in v2. ;)
>
> I think that can't happen, and for now the above should be fine.

Yep
