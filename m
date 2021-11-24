Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8945CDE7
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 21:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbhKXUY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 15:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKXUYx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 15:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637785302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1vUQaxlrdWienJBZ/hTNe8wlE9HiB2BtlS1FdXZL0M=;
        b=Er4mxsJHlGHyRbh2Cx6kcrQ9+ohZGDr0sPE5ImsI47KAVhn8wf57XvSy/uiyd8Gj3aKu/L
        Kk3rOyARanxwQY7YawXYvdtHpYsuaVvnegtbjPrxJN4AFwczRuMmHpk4jKQJdc9YxuZ0AI
        9BsaNHRwVrFnDQmDC/n8PrfzS/BLN6s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-mtccxS_KOAOxbnB_FA6_EA-1; Wed, 24 Nov 2021 15:21:38 -0500
X-MC-Unique: mtccxS_KOAOxbnB_FA6_EA-1
Received: by mail-ed1-f70.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so3415012edw.6
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 12:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1vUQaxlrdWienJBZ/hTNe8wlE9HiB2BtlS1FdXZL0M=;
        b=n+rDByY/POinj+t7LGVF7WhIJUKO7P6SoP6GeoFaUXbgaJ7tepcxHyWNbQZN3H7dwD
         TrOAAHuvDlQDRN1hIv4oyXFnPuFsnnTdOWGEKt3TB/jg0xdE1+GDArscqLMck3eoWVUA
         sTvi5/xXbaSsqDIBax+QxMnL1lXl0w5HS/cs0hyYr8gZxOA5BezU6SaTRrJx3UDoK1zb
         SgZiuAM87dVkO0Bq8UBjEBky7sM0I4fI+hBVes3vVsTC2UYOpy0VR5+msSHri8+/ycd7
         /cBt3A3Xnk+BkMDL5ycKfh6i9pPr10SK3wUaApE/WZadcVipuw2keg1SqXlT5Zo+Xk0o
         gsMA==
X-Gm-Message-State: AOAM532WgeIb99NjsUCYNx+rwPPvk2rzaFwQXssBu9/+PrTK4E0yE2F7
        bloCAwMDl9O6jzvFW8gPj2PFcm2mNkdaAfBpXr3xmj7gcZDaXiYa6d/hU3YD3sA9nPF+CYmaOMM
        4J4dGrKSWw5Hi
X-Received: by 2002:a17:906:2b16:: with SMTP id a22mr23258355ejg.447.1637785296909;
        Wed, 24 Nov 2021 12:21:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeXjBvfO4j30b7KVa+rrxFaCRUJtpBy+QfbBghZt0liNvNZmZcE0t0xgoehxUeHbfTUhA8Nw==
X-Received: by 2002:a17:906:2b16:: with SMTP id a22mr23258329ejg.447.1637785296726;
        Wed, 24 Nov 2021 12:21:36 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id v3sm691027edc.69.2021.11.24.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:21:36 -0800 (PST)
Date:   Wed, 24 Nov 2021 21:21:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
Message-ID: <YZ6ezpVG8jgLV12k@krava>
References: <20211117194114.347675-1-andrii@kernel.org>
 <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava>
 <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
 <YZ4kUzG26392CvWi@krava>
 <YZ5UFmJlb7rf4mKI@krava>
 <CAEf4BzZ5DXdKAVD15r4tViH8neaKV4Pq82P6bWKRT2SAt7Jd9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ5DXdKAVD15r4tViH8neaKV4Pq82P6bWKRT2SAt7Jd9Q@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 11:20:42AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 24, 2021 at 7:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 12:39:00PM +0100, Jiri Olsa wrote:
> > > On Thu, Nov 18, 2021 at 02:49:35PM -0800, Andrii Nakryiko wrote:
> > > > On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > > > > > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > > >
> > > > > > > According to [0], compilers sometimes might produce duplicate DWARF
> > > > > > > definitions for exactly the same struct/union within the same
> > > > > > > compilation unit (CU). We've had similar issues with identical arrays
> > > > > > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > > > > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > > > > > same for struct/union by ensuring that two structs/unions are exactly
> > > > > > > the same, down to the integer values of field referenced type IDs.
> > > > > >
> > > > > > Jiri, can you please try this in your setup and see if that handles
> > > > > > all situations or there are more complicated ones still. We'll need a
> > > > > > test for more complicated ones in that case :( Thanks.
> > > > >
> > > > > it seems to help largely, but I still see few modules (67 out of 780)
> > > > > that keep 'struct module' for some reason.. their struct module looks
> > > > > completely the same as is in vmlinux
> > > >
> > > > Curious, what's the size of all the module BTFs now?
> > >
> > > sorry for delay, I was waiting for s390x server
> > >
> > > so with 'current' fedora kernel rawhide I'm getting slightly different
> > > total size number than before, so something has changed after the merge
> > > window..
> > >
> > > however the increase with BTF enabled in modules is now from 16M to 18M,
> > > so the BTF data adds just about 2M, which I think we can live with
> > >
> 
> 16MB for vmlinux BTF is quite a lot. Is it a allmodyesconfig or something?

looks like my english betrayed me again.. sry ;-)

size of all modules without BTF is 16M,
size of all modules with BTF is 18M,

so it's overall 2M increase

also note that each module is compressed with xz

jirka

> 
> > > > And yes, please
> > > > try to narrow down what is causing the bloat this time. I think this
> > >
> > > I'm on it
> >
> > I'm seeing vmlinux BTF having just FWD record for sctp_mib struct,
> > while the kernel module has the full definition
> >
> > kernel:
> >
> >         [2798] STRUCT 'netns_sctp' size=296 vlen=46
> >                 'sctp_statistics' type_id=2800 bits_offset=0
> >
> >         [2799] FWD 'sctp_mib' fwd_kind=struct
> >         [2800] PTR '(anon)' type_id=2799
> >
> >
> > module before dedup:
> >
> >         [78928] STRUCT 'netns_sctp' size=296 vlen=46
> >                 'sctp_statistics' type_id=78930 bits_offset=0
> >
> >         [78929] STRUCT 'sctp_mib' size=272 vlen=1
> >                 'mibs' type_id=80518 bits_offset=0
> >         [78930] PTR '(anon)' type_id=78929
> >
> >
> > this field is referenced from within 'struct module' so it won't
> > match its kernel version and as a result extra 'struct module'
> > stays in the module's BTF
> >
> 
> Yeah, not much we could do about that short of just blindly matching
> FWD to STRUCT/UNION/ENUM by name, which sounds bad to me, I avoided
> doing that in BTF dedup algorithm. We only resolve FWD to
> STRUCT/UNION/ENUM when we have some containing struct with a field
> that points to FWD and (in another instance of the containing struct)
> to STRUCT/UNION/ENUM. That way we have sort of a proof that we are
> resolving the right FWD. While in this case it would be a blind guess
> based on name alone.
> 
> > I'll need to check debuginfo/pahole if that FWD is correct, but
> > I guess it's normal that some structs might end up unwinded only
> > in modules and not necessarily in vmlinux
> 
> It can happen, yes. If that's a very common case, ideally we should
> make sure that modules keep FWD or that vmlinux BTF does have a full
> struct instead of FWD.
> 
> 
> >
> > jirka
> >
> 

