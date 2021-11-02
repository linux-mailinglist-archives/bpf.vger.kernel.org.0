Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57E443241
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhKBQEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 12:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231855AbhKBQDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 12:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1859761152
        for <bpf@vger.kernel.org>; Tue,  2 Nov 2021 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635868865;
        bh=da1eVycy50X4otQmrik6T2V+LN6wIM3TUnD/viJWm78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wwjso66r66rZvnerXMejmiBymKNgEfQ/7zm+uV94JteVeOuqjG7JS1RnA3Dbkhizc
         278wFhh2v6QGYYb7LWyUEoQdmtBrVnqy+8qRa+vB38cAsqDLMYo5ZmuRo4Nse8PKqD
         XZiIYEn2Aat3c8slVlHJhd18P8LjkNk0uN2YZlfWwsg0wwE/+RtNohhGmO7jBug5I9
         ue7sfh2sWgEppcQdiqxU/a6M4iUKKyh+lpKoEcpOhPyAYBN6UkznsNo7z9Bqr8Zt+n
         med44cTYJS3K221mV9ocErdaYTY79Rjt/q+l2NsvRKTQKDQX/o8b4/GeK+RH348Fby
         k0o1KQaDImP/Q==
Received: by mail-ed1-f51.google.com with SMTP id o8so5835763edc.3
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 09:01:05 -0700 (PDT)
X-Gm-Message-State: AOAM532MVre4NG8WA8UVO/04AFujsGA9WOgLm6aMxXVaYc0Na0A2wEIe
        YA4FFwYr2RvbQzfc6fDORYsDgpOTkZ1bVxn5MrvhEA==
X-Google-Smtp-Source: ABdhPJyG639/bwb24Z9ukyt2PqMYiAtaWSE+zLkSarKrvtVPKFZUqOoXO7GUwI+4z/qEm+cqjqoHsdkYPqcBwAynFTM=
X-Received: by 2002:a05:6402:1d9a:: with SMTP id dk26mr39886443edb.222.1635868863484;
 Tue, 02 Nov 2021 09:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210826235127.303505-1-kpsingh@kernel.org> <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp> <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com> <20210930184642.drfinqwgxgeuf3iz@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210930184642.drfinqwgxgeuf3iz@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 2 Nov 2021 17:00:52 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6rGT-Fvru=GfUmzaZJXxu4jocTWejC2Q2x7jydtj9UBg@mail.gmail.com>
Message-ID: <CACYkzJ6rGT-Fvru=GfUmzaZJXxu4jocTWejC2Q2x7jydtj9UBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30, 2021 at 8:47 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> > > > > > > > > --- a/net/core/bpf_sk_storage.c
> > > > > > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > > > > > @@ -13,6 +13,7 @@
> > > > > > > > >  #include <net/sock.h>
> > > > > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > > > > >  #include <uapi/linux/btf.h>
> > > > > > > > > +#include <linux/rcupdate_trace.h>
> > > > > > > > >

[...]

> > > Or is there another way to update the verifier to recognize safe sk and inode
> > > pointers?
> > I was thinking specifically for this pointer walking case.
> > Take a look at btf_struct_access().  It walks the struct
> > in the verifier and figures out reading sock->sk will get
> > a "struct sock *".  It marks the reg to PTR_TO_BTF_ID.
> > This will allow the bpf prog to directly read from sk (e.g. sk->sk_num)
> > or pass the sk to helper that takes a "struct sock *" pointer.
> > Reading from any sk pointer is fine since it is protected by BPF_PROBE_MEM
> > read.  However, we only allow the sk from sock->sk to be passed to the
> > helper here because we only know this one is refcnt-ed.
> >
> > Take a look at check_ptr_to_btf_access().  An individual verifier_ops
> > can also have its own btf_struct_access.  One possibility is
> > to introduce a (new) PTR_TO_RDONLY_BTF_ID to mean it can only
> > do BPR_PROBE_MEM read but cannot be used in helper.
> KP,  not sure how far you are with the verifier change, if it is
> moving well, please ignore.  Otherwise,
> I looked at the sock a bit and I currently don't see
> potential concern on the following pointer case without the
> rcu_read_lock for those sock-related sleepable lsm hooks in bpf_lsm.c.
> If cases did come up later (e.g. other lsm hooks are added or something got
> overlooked), we could bring in a bigger hammer to make the above verifier
> change.  I think it should be fine to stop some exotic usage

+1 Makes sense.

> later that is proven to be not safe.  For the lsm sleepable hook case,
> another option is to lock the sock first before calling the bpf prog.
>
> If you agree a similar situation is also true for inode and task,
> do you want to respin the patches addressing other points
> discussed in this thread.

I will respin the series with the other changes discussed.
