Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529641E2A4C
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgEZSwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 14:52:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFAC03E96D
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:52:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so2114583qte.10
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9auDf0N7hlfi634wEO+YmK0Avytb9l7uYeuqMLlWSUg=;
        b=oIS+0qrOFKi4pTNkiX81GJg0nDjUhgRT2RW4WdLOXZPbpLFGLk8UhTtJrY+yLpbtFA
         quSX0k+eQ6XxkDwStDMXHHuSQDgueNnkDafuep5/Qx+zgL3KvJ2rnC/Z0xcg7zmXsMRk
         hpP4/Q3kkNnSep78084DdJ67IRIbLsO5eWTsf12ApHd3upspxY8sTGjY9mQIPhslkhzk
         4UEjERK/R0nosMpNSPtsMQeGdVdibKhqSkkRpqRTKvMLIrGrEwwrgqtld9oxlaAnglqU
         hJ4KBZAkiEZupyOvRQchpk36YhqohhRZ+HOHjTe9T/8Nfb8pR+ysnBkUy9qJnnlRJO8y
         MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9auDf0N7hlfi634wEO+YmK0Avytb9l7uYeuqMLlWSUg=;
        b=MnIvBKQR7c+c43KmuT8Lf+Eqe82UIKMsZM9aHvMVv1ODOPcC+k7YjEBj/T4lvUre3d
         e165Nmr9eCtU+ws+jtY6VvJG6PV18T7gUlWWarXx3JVeFakFQ/thvpizPz/8lEo+CXX2
         9xdSkOtd5AWvPfKtKSR5PNsjHp3mvVOCA3sZVXVNKM1vCHaAYKVOiiEqUyVhr9EHpFhk
         cQz749FRd6P81o3M59YhDgzdDV2yKS3epdomOhUFUxkgPPXdMbq3THP00EfIyfIecJw6
         J88Xz4ItjEHZFcv7PinPeiEiyoJkiOhie6i/JZiPyHQg9XBxAWbaEYVjcaMU/cZp2F6A
         HKjg==
X-Gm-Message-State: AOAM530PwV9XXyewJxCsrwiWExFuwgWkPdZlxsTRxW9f31Ga36O5zh1N
        9M7VXfaHwxmLo6QhAFnzkCZh9LBgPgu2L/5xkn4=
X-Google-Smtp-Source: ABdhPJxjq8OKGrwG5nmOk4/oaTfhpWIvJcU+EVQWyX0f1YJ80Aa7fFzW9EhPFTlkQvtOQY+xb/tKU8r2nVDB6LKX010=
X-Received: by 2002:ac8:424b:: with SMTP id r11mr219747qtm.171.1590519164865;
 Tue, 26 May 2020 11:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <159050511046.148183.1806612131878890638.stgit@firesoul>
 <CAEf4BzaXE5AsR1EvC8kQRoiRbsdLtq2AkHSU9_NqijAWxcN5fQ@mail.gmail.com> <20200526203541.41efd94d@carbon>
In-Reply-To: <20200526203541.41efd94d@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 11:52:33 -0700
Message-ID: <CAEf4BzafPs4wRqbbe1JXH3=Eo=JV+K8RGZgHcif6SbKqEymP7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix map_check_no_btf return code
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 11:35 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Tue, 26 May 2020 11:16:50 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, May 26, 2020 at 7:59 AM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >
> > > When a BPF-map type doesn't support having a BTF info associated, the
> > > bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
> > > map_check_no_btf() currently returns -ENOTSUPP, which result in a very
> > > confusing error message in libbpf, see below.
> > >
> > > The errno ENOTSUPP is part of the kernels internal errno in file
> > > include/linux/errno.h. As is stated in the file, these "should never be seen
> > > by user programs."
> > >
> > > Choosing errno EUCLEAN instead, which translated to "Structure needs
> > > cleaning" by strerror(3). This hopefully leads people to think about data
> > > structures which BTF is all about.
> >
> > How about instead of tweaking error code
>
> Regardless we still need to change the error code used, as strerror(3)
> cannot convert it to something meaningful.  As the code comment says
> this errno "should never be seen by user programs.".

"Structure needs cleaning" doesn't really make sense to me either, to
be honest. If -524 bothers you so much, maybe switch to EOPNOTSUPP
(with alias ENOTSUP in user-space)? Or we can just handle this case
better in libbpf for better user error? Either way there will be a lot
of old kernels around that will still produce such error.

>
> My notes are here:
>  https://github.com/xdp-project/xdp-project/blob/BTF01-notes.public/areas/core/BTF_01_notes.org
>
> > we actually just add support
> > for BTF key/values for all maps. For special maps, we can just enforce
> > that BTF is 4-byte integer (or typedef of that), so that in practice
> > you'll be defining it as:
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >     __type(key, u32);
> >     __type(value, u32);
> > } my_map SEC(".maps");
> >
> > and it will just work?
>
> Nope, this will also fail.

Why? If kernel supports 4-byte integers as BTF types for key/value for
such maps, then what would fail in this case?

>
> I'm all for adding support for more BPF-maps in follow up patches.  I
> will soon be adding support for cpumap and devmap.  And I will likely
> be asking all kind of weird questions, I hope I can get some help from
> you to figure out all the details ;-)

Of course.

>
> > >
> > > Before this change end-users of libbpf will see:
> > >  libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.
> > >
> > > After this change end-users of libbpf will see:
> > >  libbpf: Error in bpf_create_map_xattr(cpu_map):Structure needs cleaning(-117). Retrying without BTF.
> > >
> > > Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
> > > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > > ---
> > >  kernel/bpf/syscall.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index d13b804ff045..ecde7d938421 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
> > >                      const struct btf_type *key_type,
> > >                      const struct btf_type *value_type)
> > >  {
> > > -       return -ENOTSUPP;
> > > +       return -EUCLEAN;
> > >  }
> > >
> > >  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> > >
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
