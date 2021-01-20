Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0198E2FDBF0
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbhATV3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 16:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387540AbhATVLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 16:11:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC3F023603
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 21:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611177037;
        bh=FdjJoQjlwlPK5YeYe9dhzVIDHP27es9c4+ZmKd/gF8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JTVYDh5zoSaxansiwcolBVdoVFJOmHopFrvLTluv5dsQK0S27YASPL17iXikx+QFS
         ISRSio64Kd9SuPniJgNOei+BV04cDz6ZCwUyZzr16M1/ApLJAVBqh30NE0e96Vu9PY
         kp1Gz38wYwHRaTwiIqJcqrzwlx+ZY9TTVlh6DTSQVaqSn5K/+3l39y/V1A0mYM+k+U
         ebXmrtd0PHMHuwHvTGjC40UhLVFtJcdRPOzlV5t6xR14RUa/CqIGjM7BhJfOzNVNL6
         NVvNoBx2hHhjBqFJBJAtzL7RFaf8ttXcSnJ7RURaEbZd/W+e1B9rWc6lW72naYPuQe
         4F64l/OLP8gjg==
Received: by mail-lj1-f171.google.com with SMTP id n8so115363ljg.3
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 13:10:36 -0800 (PST)
X-Gm-Message-State: AOAM53306bucmNrJC1yQl4fwqbo7noAGsDpnrWcCkLJwvziBKMUdzk+9
        zmbBcb0EnweJID2A3jsIY1fNj/nLct1t8JtWQ0YU1w==
X-Google-Smtp-Source: ABdhPJzMaH9gaeKVcdbZyNCCSDkKeb84hwunkUzNtm9RVgiEVmMah1g76Zay0YS2b0I/93QAfuyG0alUSve0BmsdbA8=
X-Received: by 2002:a2e:a377:: with SMTP id i23mr5652583ljn.103.1611177035079;
 Wed, 20 Jan 2021 13:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20210119114624.60400-1-bianpan2016@163.com> <CAADnVQJr0idctwt53eD3dFmbZ_upLT6_7jc4raD825aPi640sA@mail.gmail.com>
In-Reply-To: <CAADnVQJr0idctwt53eD3dFmbZ_upLT6_7jc4raD825aPi640sA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 22:10:24 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4=q6_VtLp4iuf0DCc1vD=v9NbH3WDypH8phFTm5JMDgw@mail.gmail.com>
Message-ID: <CACYkzJ4=q6_VtLp4iuf0DCc1vD=v9NbH3WDypH8phFTm5JMDgw@mail.gmail.com>
Subject: Re: [PATCH] bpf: put file handler if no storage found
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Pan Bian <bianpan2016@163.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 8:23 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 19, 2021 at 4:03 AM Pan Bian <bianpan2016@163.com> wrote:
> >
> > Put file f if inode_storage_ptr() returns NULL.
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>

Thanks for fixing this! (You can add my ack with the fixes tag when
you resubmit)

Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
Acked-by: KP Singh <kpsingh@kernel.org>

> > ---
> >  kernel/bpf/bpf_inode_storage.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > index 6edff97ad594..089d5071d4fc 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -125,8 +125,12 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> >
> >         fd = *(int *)key;
> >         f = fget_raw(fd);
> > -       if (!f || !inode_storage_ptr(f->f_inode))
> > +       if (!f)
> > +               return -EBADF;
> > +       if (!inode_storage_ptr(f->f_inode)) {
> > +               fput(f);
> >                 return -EBADF;
> > +       }
>
> Good catch.
> Somehow the patch is not in patchwork.
> Could you please resubmit with Fixes tag and reduce cc list?
> I guess it's hitting some spam filters in vger.
