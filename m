Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2672FBBD6
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbhASQAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 11:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbhASQAf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 11:00:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F39C061575
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:59:49 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u17so40589612iow.1
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnSHKTtadAAW6f/V6v1P54dpn5XhZcWC2sCdL18R9nM=;
        b=BCz/IO67zgT9CdPUsNFpVQqiCBjOVaMK/Pax9eNFPRuTiMeljI8vVrfwgwPLLQjAS4
         Tikti9KuYz6SSyNawS4HSnT31Tysbz2DTAYV+HiWMN2c5lswqB2gOQ1HOjDuXgOl0D4E
         4z5lBRztA4DJSLN/+W/OVX/rw5LoMqUxnWuA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnSHKTtadAAW6f/V6v1P54dpn5XhZcWC2sCdL18R9nM=;
        b=DL0UHfVm0Ex0JO93jbBsqaU/LIcjMTBZ3mFNq8ySCILmXQbkF5GZR+o7WEuzxkqlxt
         x7D56HSG2eNKquhJ0y8XH51m7Xxg8krA7Hn4sk9zOcmmBmaGOHNlox/UoZIb2uGgdhVu
         VIpP3K6rMGNpcR+lweWGGCs8aT8df/BY4NRNhSTOXLAKgt7FvC/k9Qzs1hLKAd5EQaHx
         ++GVQL9xQAuA2Irsqt0dtFEf+v0zOexQejw9km4iOe3MwBa0cc94OeSu9UetNZYSoMpj
         TKPf3bC4vb7Bn+Snpb45p26VR+f2eXjLJfPCH//XyPPu5DeRVDgzyKsinXyycPmqd5Pn
         3SmA==
X-Gm-Message-State: AOAM533B/QgZGNp4XXH22a93IpDzIByat7V6R/3T23NY4T4N1twodfAP
        l/yOj/Bq/wadaeIBEAPruRnwHSEz1rb6wXqj0zSxHZKwOXY=
X-Google-Smtp-Source: ABdhPJw1q2AuXeeiU4fIPEMq65Kyi56qqi9inbUrV//84fq15yKyeQTBsx0IAV4FlbnjU3y7bjNocnTIPYiTyCiBzoE=
X-Received: by 2002:a5e:8d03:: with SMTP id m3mr3547547ioj.130.1611071988858;
 Tue, 19 Jan 2021 07:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20201209132636.1545761-1-revest@chromium.org> <20201209132636.1545761-2-revest@chromium.org>
 <c3f1619d-41c1-89d3-a2a2-c2de0041fa51@iogearbox.net>
In-Reply-To: <c3f1619d-41c1-89d3-a2a2-c2de0041fa51@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 19 Jan 2021 16:59:38 +0100
Message-ID: <CABRcYmKpDvy=_pXcL=XDiWkjxqumMBgRoApWrAru1Dc-=21eUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 9, 2020 at 5:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/9/20 2:26 PM, Florent Revest wrote:
> > This needs two new helpers, one that works in a sleepable context (using
> > sock_gen_cookie which disables/enables preemption) and one that does not
> > (for performance reasons). Both take a struct sock pointer and need to
> > check it for NULLness.
> >
> > This helper could also be useful to other BPF program types such as LSM.
>
> Looks like this commit description is now stale and needs to be updated
> since we only really add one helper?
>
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >   include/linux/bpf.h            |  1 +
> >   include/uapi/linux/bpf.h       |  7 +++++++
> >   kernel/trace/bpf_trace.c       |  2 ++
> >   net/core/filter.c              | 12 ++++++++++++
> >   tools/include/uapi/linux/bpf.h |  7 +++++++
> >   5 files changed, 29 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 07cb5d15e743..5a858e8c3f1a 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1860,6 +1860,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> >   extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> >   extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> >   extern const struct bpf_func_proto bpf_sock_from_file_proto;
> > +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
> >
> >   const struct bpf_func_proto *bpf_tracing_func_proto(
> >       enum bpf_func_id func_id, const struct bpf_prog *prog);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index ba59309f4d18..9ac66cf25959 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1667,6 +1667,13 @@ union bpf_attr {
> >    *  Return
> >    *          A 8-byte long unique number.
> >    *
> > + * u64 bpf_get_socket_cookie(void *sk)
> > + *   Description
> > + *           Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> > + *           *sk*, but gets socket from a BTF **struct sock**.
>
> Maybe add a small comment that this one also works for sleepable [tracing] progs?
>
> > + *   Return
> > + *           A 8-byte long unique number.
>
> ... or 0 if *sk* is NULL.

Argh, I somehow missed this email during my holidays, I'm sending a
v5. Thank you Daniel!
