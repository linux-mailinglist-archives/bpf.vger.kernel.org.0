Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC23164C9
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 12:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBJLNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 06:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhBJLL1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 06:11:27 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A64C06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:10:47 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y5so1453513ilg.4
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUIeQd9dRKZvJfPwuNmqbsap2AJdL+uTQ7IsX1CPjCs=;
        b=RiPl85BIIZipxUVUQVmKhzc6lhMNUKD3AbnpjaiMu7KGX+SQ4+RozIJVno9ua6U33H
         ezvI6/CnRdf4yFZjKpqYPeRxbctDrzoHDTiFChM55G9TXJNSNTNgUgaEtH+Ohf7dP8v9
         XCgvR/aNQ59t5C1x3KPzj/bxPzcVI4uPOUDMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUIeQd9dRKZvJfPwuNmqbsap2AJdL+uTQ7IsX1CPjCs=;
        b=GZF9G8KCYKBvEYwxTmku4rtOOktOWF1ORO1cWQ696K4cUiYr3kckT+4PwFSSZ0dzMk
         GhJGcrOXgEc+JihLdDZNnSN/iq2lrbVXXs1FXbrOdPuwbZJfGiUoGL8BbC/ErFrJG5Lm
         E1E5mwQiu7Ym9LxopefjrQmSggap5JT0JKXrnFfKUWSk8bg1KRNFWNgOsFpyQyVNpE/x
         8QEWSvLnRV34CTRuQc2V3/uiXkIKfDtEUx0bj1pMkCazLBNGAVDpXeCOPv6nu/zUN4v+
         GI0VvgFckvJGWL1X4oiRs7qUcdON3n3oVWkFjNyrv6HRaRllzvMCpEF+umS9fZiMNruL
         rS0w==
X-Gm-Message-State: AOAM532G5tIwAtraJ/pBorU7ubeeESfyVmRpFgaU9JmvdB7/ObssP4qo
        z+N3lRxK/AJBpVEOVrT0OlMdSETI0ThlewJb6TmlZQ==
X-Google-Smtp-Source: ABdhPJy20fdc4cg69jyQpfDWgO9SZimh0I32UYuBJ71PHO/zxSlHB5nGJPCwPgvu5eSa0uapEBo1UVkvKaqEqi7i3wE=
X-Received: by 2002:a05:6e02:10c:: with SMTP id t12mr537264ilm.220.1612955446626;
 Wed, 10 Feb 2021 03:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-2-revest@chromium.org>
 <CAEf4BzZ9MmdeR9P7bybXEM77MV6C-T=yZPugLOHSFC1ES2e4=g@mail.gmail.com>
 <4a8ceab1-6eef-9fda-0502-5a0550f53ddc@iogearbox.net> <37730136-2c33-589c-a749-4221b60b9751@iogearbox.net>
 <CABRcYm+cNW5A_=5qsKRuX7feB--xyTu3vPSRfzZcuFahzwuxhw@mail.gmail.com>
 <3f850e85-72ee-5a69-a6f4-7a2daab3af67@iogearbox.net> <CAADnVQKJxiEdF0HsNVyaA=jkTvjYfC00cjkyM_+1MsROnoeMsg@mail.gmail.com>
In-Reply-To: <CAADnVQKJxiEdF0HsNVyaA=jkTvjYfC00cjkyM_+1MsROnoeMsg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 10 Feb 2021 12:10:36 +0100
Message-ID: <CABRcYmJWjRxgCsbMnBCiYouMw0mx_uwXhjUDwZOvUW-6ywqoNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 11:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 2:32 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 1/30/21 12:45 PM, Florent Revest wrote:
> > > On Fri, Jan 29, 2021 at 1:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >> On 1/29/21 11:57 AM, Daniel Borkmann wrote:
> > >>> On 1/27/21 10:01 PM, Andrii Nakryiko wrote:
> > >>>> On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
> > >>>>>
> > >>>>> This needs a new helper that:
> > >>>>> - can work in a sleepable context (using sock_gen_cookie)
> > >>>>> - takes a struct sock pointer and checks that it's not NULL
> > >>>>>
> > >>>>> Signed-off-by: Florent Revest <revest@chromium.org>
> > >>>>> Acked-by: KP Singh <kpsingh@kernel.org>
> > >>>>> ---
> > >>>>>    include/linux/bpf.h            |  1 +
> > >>>>>    include/uapi/linux/bpf.h       |  8 ++++++++
> > >>>>>    kernel/trace/bpf_trace.c       |  2 ++
> > >>>>>    net/core/filter.c              | 12 ++++++++++++
> > >>>>>    tools/include/uapi/linux/bpf.h |  8 ++++++++
> > >>>>>    5 files changed, 31 insertions(+)
> > >>>>>
> > >>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >>>>> index 1aac2af12fed..26219465e1f7 100644
> > >>>>> --- a/include/linux/bpf.h
> > >>>>> +++ b/include/linux/bpf.h
> > >>>>> @@ -1874,6 +1874,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> > >>>>>    extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> > >>>>>    extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> > >>>>>    extern const struct bpf_func_proto bpf_sock_from_file_proto;
> > >>>>> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
> > >>>>>
> > >>>>>    const struct bpf_func_proto *bpf_tracing_func_proto(
> > >>>>>           enum bpf_func_id func_id, const struct bpf_prog *prog);
> > >>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >>>>> index 0b735c2729b2..5855c398d685 100644
> > >>>>> --- a/include/uapi/linux/bpf.h
> > >>>>> +++ b/include/uapi/linux/bpf.h
> > >>>>> @@ -1673,6 +1673,14 @@ union bpf_attr {
> > >>>>>     *     Return
> > >>>>>     *             A 8-byte long unique number.
> > >>>>>     *
> > >>>>> + * u64 bpf_get_socket_cookie(void *sk)
> > >>>>
> > >>>> should the type be `struct sock *` then?
> > >>>
> > >>> Checking libbpf's generated bpf_helper_defs.h it generates:
> > >>>
> > >>> /*
> > >>>    * bpf_get_socket_cookie
> > >>>    *
> > >>>    *      If the **struct sk_buff** pointed by *skb* has a known socket,
> > >>>    *      retrieve the cookie (generated by the kernel) of this socket.
> > >>>    *      If no cookie has been set yet, generate a new cookie. Once
> > >>>    *      generated, the socket cookie remains stable for the life of the
> > >>>    *      socket. This helper can be useful for monitoring per socket
> > >>>    *      networking traffic statistics as it provides a global socket
> > >>>    *      identifier that can be assumed unique.
> > >>>    *
> > >>>    * Returns
> > >>>    *      A 8-byte long non-decreasing number on success, or 0 if the
> > >>>    *      socket field is missing inside *skb*.
> > >>>    */
> > >>> static __u64 (*bpf_get_socket_cookie)(void *ctx) = (void *) 46;
> > >>>
> > >>> So in terms of helper comment it's picking up the description from the
> > >>> `u64 bpf_get_socket_cookie(struct sk_buff *skb)` signature. With that
> > >>> in mind it would likely make sense to add the actual `struct sock *` type
> > >>> to the comment to make it more clear in here.
> > >>
> > >> One thought that still came to mind when looking over the series again, do
> > >> we need to blacklist certain functions from bpf_get_socket_cookie() under
> > >> tracing e.g. when attaching to, say fexit? For example, if sk_prot_free()
> > >> would be temporary uninlined/exported for testing and bpf_get_socket_cookie()
> > >> was invoked from a prog upon fexit where sock was already passed back to
> > >> allocator, I presume there's risk of mem corruption, no?
> > >
> > > Mh, this is interesting. I can try to add a deny list in v7 but I'm
> > > not sure whether I'll be able to catch them all. I'm assuming that
> > > __sk_destruct, sk_destruct, __sk_free, sk_free would be other
> > > problematic functions but potentially there would be more.
> >
> > I was just looking at bpf_skb_output() from a7658e1a4164 ("bpf: Check types of
> > arguments passed into helpers") which afaiu has similar issue, back at the time
> > this was introduced there was no fentry/fexit but rather raw tp progs, so you
> > could still safely dump skb this way including for kfree_skb() tp. Presumably if
> > you bpf_skb_output() at 'fexit/kfree_skb' you might be able to similarly crash
>
> the verifier cannot check absolutely everything.
> Whitelisting and blacklisting all combinations is not practical.

Ok, I'm sending a v7 that only changes the signature to take a struct
sock * argument then and I won't be adding an allow or deny list in
this series. :)

> > your kernel which I don't think is intentional (also given we go above and beyond
> > in other areas to avoid crashing or destabilizing e.g. [0] to mention one). Maybe
> > these should really only be for BPF_TRACE_RAW_TP (or BPF_PROG_TYPE_LSM) where it
> > can be audited that it's safe to use like a7658e1a4164's original intention ...
> > or have some sort of function annotation like __acquires/__releases but for tracing
> > e.g. __frees(skb) where use would then be blocked (not sure iff feasible).
>
> I think this set is useful and corner cases like fexit in sk_free are
> not worth the hassle.
> One can install xdp prog that drops all packets. The server is dead at
> this point.
