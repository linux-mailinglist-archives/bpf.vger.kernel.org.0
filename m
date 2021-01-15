Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344B2F7199
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 05:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbhAOE3c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 23:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733006AbhAOE3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 23:29:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C9C061757
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 20:28:51 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 19so10615407qkm.8
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 20:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1I0MivWxgTJJK0CGJtIs4ZizYYvdU0LPHXbX6BtOUo=;
        b=qCMU5yGjOx/l0sj0OHxoctL/2OT55ILw+hMv3GSYlYK9dFV2+c/SPP1BBenurJifNp
         iyE0CFIf07+UJEwy/YpxKuXateVeAxqZX4B0rV4nZI25hWv0slmbiWdGSEec6O7DcM2a
         we+h1El0TlkShiFd9BVC0oHDO6U0jZ/msuOxgzHSjoUaUU33jRntZCBP29FVr9+KX5++
         cl84+iDWLYOwazx9199A5KpPOuz2QENkynDORN55KHHbub/FMBaArk4/zCNqq5xT0SZh
         H3/1kkT0/mynjWnwNTvFbVlewQGT8l1fFzOohOsOhYeyzCcBaci9quBT+iaxZ+MPwWVM
         w3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1I0MivWxgTJJK0CGJtIs4ZizYYvdU0LPHXbX6BtOUo=;
        b=Qe3+4caoktJhBdRRU9fRj48yhdhy3D3SEH7IQfrzpeK1dsEsg3XSM/V0DOB+EHfCGW
         pjip7rQ997iGqgi+TUazxkKhBZQdOm0hAQY5JGjLSseVc76gjTDZNgEvYxQdA+PJjMJl
         97l32AzXOxFJixUiaH6cQCP/YV9k1+d/Z/UsaQshsB9+0EljKtKTbH2Q2vp/T3RoHfoB
         cRAbN/pyLXO0IJKBCPhoa9oVk8m8z1uljZW94M+kvEl7NDXKQqrXiVPsxWXi2Kr8Nxcx
         9O4IOBgSTTlT1osD40fVvYc4J7lFW/ke/k5nHChHYk1Fjd/E6PbnlDjZ8ePfkin307yb
         3tMQ==
X-Gm-Message-State: AOAM533bL8+Rvu3++qCy5PFNQEYrTquPCOxcOH5uYiHA6qxCdlWR1EsT
        RQtvC3yRLfwmyy692FihRf7iEGR49tnoyqjRkvTohg==
X-Google-Smtp-Source: ABdhPJyTt1pjLtkDX6Gh6pIzAn99DHI4Kcu6AvpSyOHH84Xs8x6EkiwT4KVS1uA3/rYM9MSZHB2xp14pMGwED0GM9rs=
X-Received: by 2002:a37:6245:: with SMTP id w66mr10540930qkb.422.1610684930843;
 Thu, 14 Jan 2021 20:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20210113213321.2832906-1-sdf@google.com> <20210113213321.2832906-2-sdf@google.com>
 <CAADnVQLssJ4oStg7C4W-nafFKaka1H3-N0DhsBrB3FdmgyUC_A@mail.gmail.com>
 <CAKH8qBsaZjOkvGZuNCtG=V2M9YfAJgtG+moAejwtBCB6kNJUwA@mail.gmail.com>
 <CAADnVQ+2MDGVEKRZ+B-q+GcZ8CExN5VfSZpkvntg48dpww3diA@mail.gmail.com>
 <CAKH8qBuMUj0j7eS+O87=U6jzndXnCPiJ+4RbQ7nAdzbHY7cqAQ@mail.gmail.com> <CAADnVQKPj9Yh0nVi0AjHAxo5UaES9gYwLxAEixP+G6_EhdNpOg@mail.gmail.com>
In-Reply-To: <CAADnVQKPj9Yh0nVi0AjHAxo5UaES9gYwLxAEixP+G6_EhdNpOg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 14 Jan 2021 20:28:39 -0800
Message-ID: <CAKH8qBuG5mv0DW-Wvr6mRYeozxPuA5OpVno1-Q3j2aoMrnvdMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 8:07 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 8:05 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 7:57 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 14, 2021 at 7:40 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > On Thu, Jan 14, 2021 at 7:27 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jan 13, 2021 at 1:33 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > > >
> > > > > > Add custom implementation of getsockopt hook for TCP_ZEROCOPY_RECEIVE.
> > > > > > We skip generic hooks for TCP_ZEROCOPY_RECEIVE and have a custom
> > > > > > call in do_tcp_getsockopt using the on-stack data. This removes
> > > > > > 3% overhead for locking/unlocking the socket.
> > > > > >
> > > > > > Without this patch:
> > > > > >      3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> > > > > >             |
> > > > > >              --3.30%--__cgroup_bpf_run_filter_getsockopt
> > > > > >                        |
> > > > > >                         --0.81%--__kmalloc
> > > > > >
> > > > > > With the patch applied:
> > > > > >      0.52%     0.12%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt_kern
> > > > > >
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > > Cc: Martin KaFai Lau <kafai@fb.com>
> > > > > > Cc: Song Liu <songliubraving@fb.com>
> > > > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > > > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > > > >
> > > > > Few issues in this patch and the patch 2 doesn't apply:
> > > > > Switched to a new branch 'tmp'
> > > > > Applying: bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> > > > > .git/rebase-apply/patch:295: trailing whitespace.
> > > > > #endif
> > > > > .git/rebase-apply/patch:306: trailing whitespace.
> > > > > union tcp_word_hdr {
> > > > > .git/rebase-apply/patch:309: trailing whitespace.
> > > > > };
> > > > > .git/rebase-apply/patch:311: trailing whitespace.
> > > > > #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3])
> > > > > .git/rebase-apply/patch:313: trailing whitespace.
> > > > > enum {
> > > > > warning: squelched 1 whitespace error
> > > > > warning: 6 lines add whitespace errors.
> > > > > Applying: bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
> > > > > error: patch failed: kernel/bpf/cgroup.c:1390
> > > > > error: kernel/bpf/cgroup.c: patch does not apply
> > > > > Patch failed at 0002 bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
> > > > Sorry, I mentioned in the cover letter that the series requires
> > > > 4be34f3d0731 ("bpf: Don't leak memory in bpf getsockopt when optlen == 0")
> > > > which is only in the bpf tree. No sure when bpf & bpf-next merge.
> > > > Or are you trying to apply on top of that?
> > >
> > > hmm. It will take a while to wait for the trees to converge.
> > > Ok. I've cherry-picked that bpf commit and applied 3 patches on top,
> > > but the test failed to build:
> > >
> > > progs/sockopt_sk.c:60:47: error: use of undeclared identifier
> > > 'TCP_ZEROCOPY_RECEIVE'
> > >         if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
> > >                                                      ^
> > > progs/sockopt_sk.c:66:16: error: invalid application of 'sizeof' to an
> > > incomplete type 'struct tcp_zerocopy_receive'
> > >                 if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
> > >
> > > Looks like copied uapi/tcp.h into tools/ wasn't in the include path.
> > Interesting, let me try to understand where it comes on my system
> > because it did work even without this uapi/tcp.h so I might
> > have messed something up. Thank you!
>
> You probably have a newer glibc. Mine is old. I think our CI doesn't
> use glibc and
> is probably missing the newest tcp.h as well.

Ah, it doesn't pick up my uapi/tcp.h because I include netinet/tcp.h
in the test :-(
Let me change that to linux/tcp.h and define SOL_TCP (because netinet/tcp.h
used to provide it and linux/tcp.h isn't). I'll retest and resend
tomorrow with a fresh head.
Sorry for the noise.
