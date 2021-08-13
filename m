Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DC3EBDCF
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhHMVXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 17:23:33 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C0C061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 14:23:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t3-20020a0cf9830000b0290359840930bdso4674095qvn.2
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O+a+kJqxjsCgYqIdwgvSL+Ilv4hJngYXbJtEdzYwooo=;
        b=TTEK0RsM0JDQzLJzTTKgdUZ1jeQNd6jO75zKxOU8a8zbe5n8WmbMyrhc9HDAyjpcEA
         xUWHjMiUoEGprRniwj2eZm29N7S47LSxajYvw5aRs5leok81CT6EbTzRoM9vB9WrK3Xu
         OrHhiqL+3TzpX++Bd4qzr054j6Ta/n0Fpmh/H3Xm2h041up4xo2pqioaaBoytzee0U6D
         QkKnyYhek5UitBG66xSSkeuQx7Ew7lemNTw1nzfveoYAIq8KIok1nQjXzHLBUstzL5gU
         BB+RV1J9OIJ0dOUMem1HZQLdT/WdDtTSRh7z5gJDWmqvxFfBISa5sroz6FswMcUuuJIu
         1XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O+a+kJqxjsCgYqIdwgvSL+Ilv4hJngYXbJtEdzYwooo=;
        b=WQxVlgVNPgeHdY3lzHVsOo7allLtzy06+LnLDHmuAyTF3fA8oxSJ4OR6efZ6BCPGx2
         v9pxk3jyqiC5jdNspeZ8pGjTllofENcGNkAv/6C8oB04C7PWp5+giWZMqf8JgUWI0BEw
         dTMxzojkpqoAXtwR2OAR1GVE5weidD0OxdaqqdL6NLML92RrjPXE1aSeO6CiB74fvQos
         Tqz91CthNuNToMqzHe+jlRG3jPuBHWqIx9MLa/XxlUVuOtcOrJay2LEXdUTXPnmbAHcN
         rJB4xV2UN8Xn9EFZNml9euUIFTJZvPbaP8HpxSdAi6AG/mhjAjKKWAbPuv6xnDDsksVG
         13Gg==
X-Gm-Message-State: AOAM530lfxlqS8vqXG4bbvZcaAPXDBmuOlJ+twXfDITz6fqzVSSnwp5v
        xMONgOZbXEkS45h7qmlPzWCu7Jg=
X-Google-Smtp-Source: ABdhPJzaBi3DhigOdVcaLGyPU08xbaff8xdPewdHsDYx0sxO6SOeJkpVzOE8JZtHc9VrLl+L6SQymuU=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f73:a375:cbb9:779b])
 (user=sdf job=sendgmr) by 2002:a05:6214:e62:: with SMTP id
 jz2mr4654757qvb.54.1628889785281; Fri, 13 Aug 2021 14:23:05 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:23:02 -0700
In-Reply-To: <20210813195802.r67s62f5iwvnlmv4@kafai-mbp>
Message-Id: <YRbittzJQjF/KqKU@google.com>
Mime-Version: 1.0
References: <20210812153011.983006-1-sdf@google.com> <20210812153011.983006-2-sdf@google.com>
 <20210813195802.r67s62f5iwvnlmv4@kafai-mbp>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/13, Martin KaFai Lau wrote:
> On Thu, Aug 12, 2021 at 08:30:10AM -0700, Stanislav Fomichev wrote:
> > This is similar to existing BPF_PROG_TYPE_CGROUP_SOCK
> > and BPF_PROG_TYPE_CGROUP_SOCK_ADDR.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/cgroup.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index b567ca46555c..ca5af8852260 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1846,11 +1846,30 @@ const struct bpf_verifier_ops  
> cg_sysctl_verifier_ops = {
> >  const struct bpf_prog_ops cg_sysctl_prog_ops = {
> >  };
> >
> > +#ifdef CONFIG_NET
> > +BPF_CALL_1(bpf_get_netns_cookie_sockopt, struct bpf_sockopt_kern *,  
> ctx)
> > +{
> > +	struct sock *sk = ctx ? ctx->sk : NULL;
> > +	const struct net *net = sk ? sock_net(sk) : &init_net;
> A nit.

> ctx->sk can not be NULL here, so it only depends on ctx is NULL or not.

> If I read it correctly, would it be less convoluted to directly test ctx
> and use ctx->sk here, like:

> 	const struct net *net = ctx ? sock_net(ctx->sk) : &init_net;

> and the previous "struct sock *sk = ctx ? ctx->sk : NULL;" statement
> can also be removed.
Agreed, makes sense. Let me also add bpf_get_netns_cookie to some
existing BPF prog to make sure it's executed. That ctx.c isn't
really running the prog..
