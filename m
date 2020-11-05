Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7682A7C84
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKELA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKELA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 06:00:58 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798AC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 03:00:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so1139188wmd.4
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 03:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SfmUBxbadBily7wOan4YYuQOPQR7fej8AK9RO3iODM=;
        b=A0tUuWSus9Z4wxnk/b1UA8wDpt5td4yVdEdLk5GKlpPlD5rzZmRLLQ0yzsCTLr6IWS
         q6Hb35bvbd0jyiqyiMSDe6nDowBPRHUfs/3plYNUm8DIAgRDELleb4wH9cQBSz5kDOuV
         Zt2apNYLL0ogIdKOtmL1gKbW3gQJd0nwhTWNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SfmUBxbadBily7wOan4YYuQOPQR7fej8AK9RO3iODM=;
        b=pF3qTYTJGd12v0yYGUiWDJHs/kryP3qU0JqMI/c7dtJGxtNr8d2fgVbNf4mDQYtZYX
         FiNHgeCSKtsTtafGGLPWLkcIjhQxuVQ4uU5nlv+Ma+nDLAHlUcdKGPYqfUzIJEzthwhS
         XlEB92gn3g3A4uONis0eTHdMnk5pZHb5BpZn8px6c7vPpFfx7R4Z43qOVJvZ6AtClCza
         8RCEpUHypFEiTjj6eNQdgfJx8I1GuXkBdx2TMvAPOHhzq6wmIdGy6E7YinzsRoNebEmp
         NtAV7sWxXSHyFzfHsDRcPOFAb+2oh7XWgjJQn+wpMLppPbNbOmq0R37nKMPvLgRMngsH
         NmUg==
X-Gm-Message-State: AOAM5332iX5paRPe9nzD+3FgO0c+/byRbrSa4kWu7KZYrEVFWrMod2Qt
        9AkamLS/fM+ae/w3AF+JklsHV+y5uIs8ToRBC196Zw==
X-Google-Smtp-Source: ABdhPJwvzb0LZuf1dvdlz5CAAX88iWIKXnaDhf9xg3Ii8KEjErcftQHaTpvTwHpE5CnEhb+UraHZZ79F7+UVitvBUag=
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr2109194wme.153.1604574056944;
 Thu, 05 Nov 2020 03:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com> <20200629095630.7933-2-lmb@cloudflare.com>
 <20201104190808.417b9a4b@redhat.com>
In-Reply-To: <20201104190808.417b9a4b@redhat.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 5 Nov 2020 11:00:45 +0000
Message-ID: <CACAyw98rvXpcdQBE_XzFR0Y0s=rgtum-D0dcyE3DSZXUL-im=Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/6] bpf: flow_dissector: check value of unused
 flags to BPF_PROG_ATTACH
To:     Jiri Benc <jbenc@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 4 Nov 2020 at 18:08, Jiri Benc <jbenc@redhat.com> wrote:
>
> On Mon, 29 Jun 2020 10:56:25 +0100, Lorenz Bauer wrote:
> > Using BPF_PROG_ATTACH on a flow dissector program supports neither
> > target_fd, attach_flags or replace_bpf_fd but accepts any value.
> >
> > Enforce that all of them are zero. This is fine for replace_bpf_fd
> > since its presence is indicated by BPF_F_REPLACE. It's more
> > problematic for target_fd, since zero is a valid fd. Should we
> > want to use the flag later on we'd have to add an exception for
> > fd 0. The alternative is to force a value like -1. This requires
> > more changes to tests. There is also precedent for using 0,
> > since bpf_iter uses this for target_fd as well.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
> > ---
> >  kernel/bpf/net_namespace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> > index 3e89c7ad42cb..bf18eabeaea2 100644
> > --- a/kernel/bpf/net_namespace.c
> > +++ b/kernel/bpf/net_namespace.c
> > @@ -217,6 +217,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >       struct net *net;
> >       int ret;
> >
> > +     if (attr->target_fd || attr->attach_flags || attr->replace_bpf_fd)
> > +             return -EINVAL;
>
> I'm debugging failing test_flow_dissector.sh selftest and I wonder how
> this patch works.
>
> The test_flow_dissector.sh selftest at line 28 runs:
>
> bpftool prog -d attach pinned /sys/fs/bpf/flow/flow_dissector flow_dissector
>
> which invokes this code:
>
> static int parse_attach_detach_args(int argc, char **argv, int *progfd,
>                                     enum bpf_attach_type *attach_type,
>                                     int *mapfd)
> {
>         [...]
>         if (*attach_type == BPF_FLOW_DISSECTOR) {
>                 *mapfd = -1;
>                 return 0;
>         }
>         [...]
> }

Hi Jiri,

Thanks for the bug report. The commit indeed breaks attaching the flow
dissector using bpftool as you point out. I think I didn't catch this
because I don't have bpftool in my path, so that test was actually
skipped... The other parts of the test use a custom loader, which
passes 0 for the arguments and are not affected.

I had a cursory look at bpftool packaging in Debian, Ubuntu and
Fedora, it seems they all package bpftool in a kernel version
dependent package. So the most straightforward fix is probably to
change bpftool to use *mapfd = 0 and then land that via the bpf tree.

What do you think?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
