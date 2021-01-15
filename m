Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1752F710D
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 04:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbhAODkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 22:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbhAODko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 22:40:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A99C061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 19:40:04 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 19so10545353qkm.8
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 19:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfrYO+PzQZa2QgXSwKBu/qFaywy+T6Io8dlHNEUX3yI=;
        b=n4kETA0UJ2RPfhp5JNojIlpHVNNZficpwIcG6VF6OCwbB6kubdjLD2SR/BJ5DqMcJo
         k/1ejG49tWV9zHJrLsLNUXWHCpgXUkkRYWqz0ieWz4c8robiPwzsMTVSJop0D0apfwGW
         sCRApvTXm8DTS0jD126seaO0xdOYe93R5H/jlNo3YxhlboiooQ3T2bJPdgZZ9KPSzbYR
         C7+HznQpPHl3hR/fP6O7b8Mis9U67mbXWriFKl+nx/KWFhK/ESxJUuJyhNnMEntSmSk4
         Ws5UAuPVva/LjXZdChHAw6gVLwhrU88AudBfoFGqjQn+INB1jIBlzu/rVX/3hy53F4Sj
         AZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfrYO+PzQZa2QgXSwKBu/qFaywy+T6Io8dlHNEUX3yI=;
        b=JWqygTdLJYDSN66nEDbmmOXu0uSCXoV0DNvIgberxTGcaHAT1KDgusGTn9ijQgKRZx
         nfES1ejczWXf3km+6rcJPLE8RhRBaVUI23KrDVS4K6t4qu/+7aeyj/uSvsTfGizdl5Sf
         6Bj5/gamGGCnDFCC3jTWo/22MqMBXMu8gTJ5xkpnH9ZATMp1r+z63IOMyRrepLoH28NX
         /Xu8cFTZlUtjHgLCz4wqMvsYn0iGL7kD7gnAzbtorFpqhkCwtpXr+GfkFM4vHK1FOaM+
         Bv8ucbb9BMnXUErHgPedMWGDYepDwI+i7SOmfYAgb1BKsSuPsaNpEEl+kBIZzqFhTQn5
         o10Q==
X-Gm-Message-State: AOAM530JIfsxEpayEGLXfmmlw7MTfBL6iRThlf2PbE06OAKMbOOfQZhG
        bL8Gg0RfsFIftwZM81sHoLS76ODYhWltuXdKaVfHBg==
X-Google-Smtp-Source: ABdhPJxXAHrb2NsmvMNmhQMUV91h9BRzJJOWXPngoYyejvZNF3LZUpmlGg9PJfyt2CNYzclJ9nOXtG5fDk8MxCb5GVc=
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr10667659qkg.485.1610682003281;
 Thu, 14 Jan 2021 19:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20210113213321.2832906-1-sdf@google.com> <20210113213321.2832906-2-sdf@google.com>
 <CAADnVQLssJ4oStg7C4W-nafFKaka1H3-N0DhsBrB3FdmgyUC_A@mail.gmail.com>
In-Reply-To: <CAADnVQLssJ4oStg7C4W-nafFKaka1H3-N0DhsBrB3FdmgyUC_A@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 14 Jan 2021 19:39:52 -0800
Message-ID: <CAKH8qBsaZjOkvGZuNCtG=V2M9YfAJgtG+moAejwtBCB6kNJUwA@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 7:27 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 1:33 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Add custom implementation of getsockopt hook for TCP_ZEROCOPY_RECEIVE.
> > We skip generic hooks for TCP_ZEROCOPY_RECEIVE and have a custom
> > call in do_tcp_getsockopt using the on-stack data. This removes
> > 3% overhead for locking/unlocking the socket.
> >
> > Without this patch:
> >      3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> >             |
> >              --3.30%--__cgroup_bpf_run_filter_getsockopt
> >                        |
> >                         --0.81%--__kmalloc
> >
> > With the patch applied:
> >      0.52%     0.12%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt_kern
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
>
> Few issues in this patch and the patch 2 doesn't apply:
> Switched to a new branch 'tmp'
> Applying: bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> .git/rebase-apply/patch:295: trailing whitespace.
> #endif
> .git/rebase-apply/patch:306: trailing whitespace.
> union tcp_word_hdr {
> .git/rebase-apply/patch:309: trailing whitespace.
> };
> .git/rebase-apply/patch:311: trailing whitespace.
> #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3])
> .git/rebase-apply/patch:313: trailing whitespace.
> enum {
> warning: squelched 1 whitespace error
> warning: 6 lines add whitespace errors.
> Applying: bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
> error: patch failed: kernel/bpf/cgroup.c:1390
> error: kernel/bpf/cgroup.c: patch does not apply
> Patch failed at 0002 bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
Sorry, I mentioned in the cover letter that the series requires
4be34f3d0731 ("bpf: Don't leak memory in bpf getsockopt when optlen == 0")
which is only in the bpf tree. No sure when bpf & bpf-next merge.
Or are you trying to apply on top of that?
