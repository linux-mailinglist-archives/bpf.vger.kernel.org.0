Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EF2E043E
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 03:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLVCKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Dec 2020 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgLVCKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Dec 2020 21:10:21 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C519C0613D6
        for <bpf@vger.kernel.org>; Mon, 21 Dec 2020 18:09:41 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f19so9388451qtx.6
        for <bpf@vger.kernel.org>; Mon, 21 Dec 2020 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vOQd9yP8dnl1zG6DmfS+2twczWYoFLUhpIjtlAdwO9w=;
        b=tyilzIpemxvqjJmv3+b0bUO2gPk3NrAB2S/TSXrZ/PoyIk68Cv8mQh8rOhVd+NXlgG
         tXm3wm9+YOPRFI3rUtPJ/X4wREpQeyjb6qfTHtQVep/LVQLszARpHzvvjKkfDp6WFAVz
         QuvVsnaSqKBV2MU5aRB8XoH+XvDGJfjI8Nb0fPRTMt0b7RHcBcvHca+ExKfeuolIFqfx
         qtP8VeSgZKLR/iC7F/O9ezDlnK2upqOSBNFcTDQadUWbGAGKXasFIWH9BVx6U9hOqttl
         j6HePXjs2JiKK2YNhkDdpGUOACjFZrx2BQbZVrFRdKFNAJnpBtlyw+eWkyQxgB8oIRe/
         VcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vOQd9yP8dnl1zG6DmfS+2twczWYoFLUhpIjtlAdwO9w=;
        b=JLWG9AJXaHg8/58186O/UzKTtqBrjj+yx6Bvp4UJ9ph2bdu1GGF8Q2Hn6Pnzrpp/Wm
         T0o7aXxg1PT846Z1WtBbuORpXYS4FpRM25XstJgtmIupDe7fQVBQxA9HdgVwrJsZquYX
         MlpTkwrybuzQQ4TP2wZQ6UMAfVYCYGXzYhOz+XzK8ApSmrTPutaPviX82xtE4Azk0N6a
         mKhTeG0gYBINM7bQNngjlh7NwoupE/ciuKi76pbajsYRR3odUIUytrvUPeEnrn4e6Yx5
         QwFdoZZXvKL8uubwKgqTca6dMWVR42Sn345Gc8j/TesNWGashxVswOeJSDXgi1CDGOHr
         qaQA==
X-Gm-Message-State: AOAM5313+Her9bj2Y7a0k2V46p7JcQ6Rv09v6cGmJyz9NBfwNmXx60UY
        40gHM4ajSPtWcznQGLyVIclIAfA=
X-Google-Smtp-Source: ABdhPJwLBmUDEC2lN+0Xcur0E3G+9sfZ7swImQP5R6CucMyI6YEpwkLW/41iJXv1GfA2EEz0RrkCgQ8=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a0c:fa4c:: with SMTP id k12mr19806554qvo.16.1608602980708;
 Mon, 21 Dec 2020 18:09:40 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:09:39 -0800
In-Reply-To: <CAPhsuW52eTurJ4pPAgZtv0giw2C+7r6aMacZXx8XkwUxBGARAQ@mail.gmail.com>
Message-Id: <X+FVY0sWeVoC9wY1@google.com>
Mime-Version: 1.0
References: <20201217172324.2121488-1-sdf@google.com> <20201217172324.2121488-2-sdf@google.com>
 <CAPhsuW52eTurJ4pPAgZtv0giw2C+7r6aMacZXx8XkwUxBGARAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
From:   sdf@google.com
To:     Song Liu <song@kernel.org>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21, Song Liu wrote:
> On Thu, Dec 17, 2020 at 9:24 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > When we attach a bpf program to cgroup/getsockopt any other getsockopt()
> > syscall starts incurring kzalloc/kfree cost. While, in general, it's
> > not an issue, sometimes it is, like in the case of TCP_ZEROCOPY_RECEIVE.
> > TCP_ZEROCOPY_RECEIVE (ab)uses getsockopt system call to implement
> > fastpath for incoming TCP, we don't want to have extra allocations in
> > there.
> >
> > Let add a small buffer on the stack and use it for small (majority)
> > {s,g}etsockopt values. I've started with 128 bytes to cover
> > the options we care about (TCP_ZEROCOPY_RECEIVE which is 32 bytes
> > currently, with some planned extension to 64 + some headroom
> > for the future).

> I don't really know the rule of thumb, but 128 bytes on stack feels too  
> big to
> me. I would like to hear others' opinions on this. Can we solve the  
> problem
> with some other mechanisms, e.g. a mempool?
Yeah, I'm not sure as well. But given that we have at least 4k stacks,
it didn't feel like too much. And we will be paying those 128 bytes
only when bpf is attached.

Regarding mempool - I guess we can try that, depending on how the
discussion above ends up. I don't see any docs about kmalloc/mempool
overhead vs kmalloc. (and looking at mempool_alloc it seems
that it aways calls pool->alloc and mostly for guarantees, not
performance; correct me if wrong).

> > +static void *sockopt_export_buf(struct bpf_sockopt_kern *ctx)
> > +{
> > +       void *p;
> > +
> > +       if (ctx->optval != ctx->buf)
> > +               return ctx->optval;
> > +
> > +       /* We've used bpf_sockopt_kern->buf as an intermediary storage,
> > +        * but the BPF program indicates that we need to pass this
> > +        * data to the kernel setsockopt handler. No way to export
> > +        * on-stack buf, have to allocate a new buffer. The caller
> > +        * is responsible for the kfree().
> > +        */
> > +       p = kzalloc(ctx->optlen, GFP_USER);
> > +       if (!p)
> > +               return ERR_PTR(-ENOMEM);
> > +       memcpy(p, ctx->optval, ctx->optlen);
> > +       return p;
> > +}
> > +
> >  int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
> >                                        int *optname, char __user  
> *optval,
> >                                        int *optlen, char  
> **kernel_optval)
> > @@ -1389,8 +1420,14 @@ int __cgroup_bpf_run_filter_setsockopt(struct  
> sock *sk, int *level,
> >                  * use original userspace data.
> >                  */
> >                 if (ctx.optlen != 0) {
> > -                       *optlen = ctx.optlen;
> > -                       *kernel_optval = ctx.optval;
> > +                       void *buf = sockopt_export_buf(&ctx);

> I found it is hard to follow the logic here (when to allocate memory, how  
> to
> fail over, etc.). Do we have plan to reuse sockopt_export_buf()? If not,  
> it is
> probably cleaner to put the logic in __cgroup_bpf_run_filter_setsockopt()?
Sure. I guess I can add something like 'sockopt_can_export' that
returns 'ctx->optval == ctx->buf' and depending on that do the kmalloc.
