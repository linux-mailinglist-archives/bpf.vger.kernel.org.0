Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150E23094F6
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhA3LqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 06:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3LqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 06:46:21 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0ECC061574
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 03:45:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 16so12212001ioz.5
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//VX6ojmsc2r98X2mOVEeFZycqko9uWOR4VNHQdTCdM=;
        b=J2HP5jewPJhCIaR3NFZnmNbLul9BUge/BSXoypL+QjCvJ5XltASuHDfTuwoDr/MJjG
         cu6WfTY+p8qLAHNwo8kC1W/IMxy8bLIB8RYzbuGuICQkMGYwafHoyC5JhFk25yV0M++q
         K1Q7uxwWJ4h8/qJq/YuRYV6g69c1Q9f3wOn8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//VX6ojmsc2r98X2mOVEeFZycqko9uWOR4VNHQdTCdM=;
        b=KssNzHh0aqNgDm0eqfqoxXg7ypvFQIJesZC+LY7WIQudinQ63YVXHQAUyMVP1ZRDAQ
         /aGGl5+kWuZ3WfD3TmxTjVIEW4Ko911E1RrhJ48/Koq/qqf2rvj0AOSfqe9vE8S7Mc4N
         vinXoMPM5UMSNsUaccOAiu2tf6H5VkpXmI3p6VaFvoN7TarlocaMrxR8fcmCMRsTzH2i
         uwPAJPczICN6dpTRpIXGEHW4MVsiWfxGjVUdwonpQiwJIPu2ZIhZcCK58SC6u9rxKqcf
         VaHHvI+r+/P6qYwIeQ83PxKKjAZVAtMPLGIcNw5sbXNM/ybaCdn5zOIYn611qb9A67j7
         fcKQ==
X-Gm-Message-State: AOAM531tosEciNRFsMGBniz9Lfnqr6xBDpD3mlhnfPDbntWSbWONgwOM
        fQQDdUG+tJMsIqvjMuhhdgGmpYsUvuBs7H/RC70PwQ==
X-Google-Smtp-Source: ABdhPJzHXCKy4DccWXt1nJCYmgWBkM1Ew9DHMsOoSnHwXzuxSQhrQ4ZE6Q3RXz8t1YGMhlnOOx86yKiPN55aUI0m1D8=
X-Received: by 2002:a5d:8ac8:: with SMTP id e8mr7461817iot.163.1612007140508;
 Sat, 30 Jan 2021 03:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-2-revest@chromium.org>
 <CAEf4BzZ9MmdeR9P7bybXEM77MV6C-T=yZPugLOHSFC1ES2e4=g@mail.gmail.com>
 <4a8ceab1-6eef-9fda-0502-5a0550f53ddc@iogearbox.net> <37730136-2c33-589c-a749-4221b60b9751@iogearbox.net>
In-Reply-To: <37730136-2c33-589c-a749-4221b60b9751@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Sat, 30 Jan 2021 12:45:29 +0100
Message-ID: <CABRcYm+cNW5A_=5qsKRuX7feB--xyTu3vPSRfzZcuFahzwuxhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 1:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/29/21 11:57 AM, Daniel Borkmann wrote:
> > On 1/27/21 10:01 PM, Andrii Nakryiko wrote:
> >> On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
> >>>
> >>> This needs a new helper that:
> >>> - can work in a sleepable context (using sock_gen_cookie)
> >>> - takes a struct sock pointer and checks that it's not NULL
> >>>
> >>> Signed-off-by: Florent Revest <revest@chromium.org>
> >>> Acked-by: KP Singh <kpsingh@kernel.org>
> >>> ---
> >>>   include/linux/bpf.h            |  1 +
> >>>   include/uapi/linux/bpf.h       |  8 ++++++++
> >>>   kernel/trace/bpf_trace.c       |  2 ++
> >>>   net/core/filter.c              | 12 ++++++++++++
> >>>   tools/include/uapi/linux/bpf.h |  8 ++++++++
> >>>   5 files changed, 31 insertions(+)
> >>>
> >>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>> index 1aac2af12fed..26219465e1f7 100644
> >>> --- a/include/linux/bpf.h
> >>> +++ b/include/linux/bpf.h
> >>> @@ -1874,6 +1874,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> >>>   extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> >>>   extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> >>>   extern const struct bpf_func_proto bpf_sock_from_file_proto;
> >>> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
> >>>
> >>>   const struct bpf_func_proto *bpf_tracing_func_proto(
> >>>          enum bpf_func_id func_id, const struct bpf_prog *prog);
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 0b735c2729b2..5855c398d685 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -1673,6 +1673,14 @@ union bpf_attr {
> >>>    *     Return
> >>>    *             A 8-byte long unique number.
> >>>    *
> >>> + * u64 bpf_get_socket_cookie(void *sk)
> >>
> >> should the type be `struct sock *` then?
> >
> > Checking libbpf's generated bpf_helper_defs.h it generates:
> >
> > /*
> >   * bpf_get_socket_cookie
> >   *
> >   *      If the **struct sk_buff** pointed by *skb* has a known socket,
> >   *      retrieve the cookie (generated by the kernel) of this socket.
> >   *      If no cookie has been set yet, generate a new cookie. Once
> >   *      generated, the socket cookie remains stable for the life of the
> >   *      socket. This helper can be useful for monitoring per socket
> >   *      networking traffic statistics as it provides a global socket
> >   *      identifier that can be assumed unique.
> >   *
> >   * Returns
> >   *      A 8-byte long non-decreasing number on success, or 0 if the
> >   *      socket field is missing inside *skb*.
> >   */
> > static __u64 (*bpf_get_socket_cookie)(void *ctx) = (void *) 46;
> >
> > So in terms of helper comment it's picking up the description from the
> > `u64 bpf_get_socket_cookie(struct sk_buff *skb)` signature. With that
> > in mind it would likely make sense to add the actual `struct sock *` type
> > to the comment to make it more clear in here.
>
> One thought that still came to mind when looking over the series again, do
> we need to blacklist certain functions from bpf_get_socket_cookie() under
> tracing e.g. when attaching to, say fexit? For example, if sk_prot_free()
> would be temporary uninlined/exported for testing and bpf_get_socket_cookie()
> was invoked from a prog upon fexit where sock was already passed back to
> allocator, I presume there's risk of mem corruption, no?

Mh, this is interesting. I can try to add a deny list in v7 but I'm
not sure whether I'll be able to catch them all. I'm assuming that
__sk_destruct, sk_destruct, __sk_free, sk_free would be other
problematic functions but potentially there would be more.
