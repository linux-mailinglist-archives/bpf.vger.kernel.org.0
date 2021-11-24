Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BCD45C830
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 16:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhKXPGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 10:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhKXPGD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 10:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637766173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkWCtGeAQcuBhAqjWYam8Mt7lwjzFbzGWyUAyQx/5I0=;
        b=SqCY9CDxSIWxtx25BuMAatGpTKgBYWHlFXaJf9xceU9FGaM6y3Ex7pFY84GROVM6BwFtKy
        SeYDOXvo7RsCU3kO2mEzdSSWVuIIutzlplcSvkQv6Q0qGs84nWAzRZcRWzCMZF6dFn4XWb
        Vde1glNxPe90fTzoxFXwhh8r4e+dW0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-165-h_74NJNtOt-skGmuFgXxtA-1; Wed, 24 Nov 2021 10:02:52 -0500
X-MC-Unique: h_74NJNtOt-skGmuFgXxtA-1
Received: by mail-wr1-f70.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso564301wrt.5
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 07:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkWCtGeAQcuBhAqjWYam8Mt7lwjzFbzGWyUAyQx/5I0=;
        b=b4n64RTjhGdwYzVCW8yx3EGUBffJf1hgoiTaii3n6kdjcOiC8vWOZX3NzbgbwGXDf9
         zvW4l4pGnunKPc4qb31jLQOdk2SYCCm1NQfYHpP1yEbEqM2HcYqcaCz1eTJ8A81mtF9q
         uqpWDRHB1iM7SWxuRAibIkbdG+OkK8tbqjzPNpjoUoneM7B0j6kPbW8+l8vfdfPF4vl+
         eUJuG+XGjEgnhtRLGwWgK/XqbfX56zoFD1WOdnQ/0++o6UD5VGfnvmm6n4njlV8e65eL
         3HRvVBPV/Le4LQOilIyCzdpT43lvkZ02lyiZuspc+drPk6R/UcqeHvp7o/jH5OH5VfhQ
         NRzQ==
X-Gm-Message-State: AOAM533WFKUSJnYFEYV5OyfnxOfaIlFx7QyFda8LlEJI5amBVIpqxhEl
        CvLtzNA8qcHbjBHtRMdc7j97ESFz975vFXt/u4mzLyaf6r7wcNuQF4a6NMhnz+axctlEEyySJ3p
        Zt0h94rSV7mc/
X-Received: by 2002:a1c:f416:: with SMTP id z22mr16678073wma.121.1637766170350;
        Wed, 24 Nov 2021 07:02:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgT/yl/PIiKKecRHOq0zLcLAelJzBEhMKgn8WL5SLrNtiXayPNqU9tLlxFam+PC2E666aaaA==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr16677712wma.121.1637766168184;
        Wed, 24 Nov 2021 07:02:48 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s63sm11189wme.22.2021.11.24.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:02:47 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:02:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
Message-ID: <YZ5UFmJlb7rf4mKI@krava>
References: <20211117194114.347675-1-andrii@kernel.org>
 <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava>
 <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
 <YZ4kUzG26392CvWi@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ4kUzG26392CvWi@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 12:39:00PM +0100, Jiri Olsa wrote:
> On Thu, Nov 18, 2021 at 02:49:35PM -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > > > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > >
> > > > > According to [0], compilers sometimes might produce duplicate DWARF
> > > > > definitions for exactly the same struct/union within the same
> > > > > compilation unit (CU). We've had similar issues with identical arrays
> > > > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > > > same for struct/union by ensuring that two structs/unions are exactly
> > > > > the same, down to the integer values of field referenced type IDs.
> > > >
> > > > Jiri, can you please try this in your setup and see if that handles
> > > > all situations or there are more complicated ones still. We'll need a
> > > > test for more complicated ones in that case :( Thanks.
> > >
> > > it seems to help largely, but I still see few modules (67 out of 780)
> > > that keep 'struct module' for some reason.. their struct module looks
> > > completely the same as is in vmlinux
> > 
> > Curious, what's the size of all the module BTFs now?
> 
> sorry for delay, I was waiting for s390x server
> 
> so with 'current' fedora kernel rawhide I'm getting slightly different
> total size number than before, so something has changed after the merge
> window..
> 
> however the increase with BTF enabled in modules is now from 16M to 18M,
> so the BTF data adds just about 2M, which I think we can live with
> 
> > And yes, please
> > try to narrow down what is causing the bloat this time. I think this
> 
> I'm on it

I'm seeing vmlinux BTF having just FWD record for sctp_mib struct,
while the kernel module has the full definition

kernel:

        [2798] STRUCT 'netns_sctp' size=296 vlen=46
                'sctp_statistics' type_id=2800 bits_offset=0

        [2799] FWD 'sctp_mib' fwd_kind=struct
        [2800] PTR '(anon)' type_id=2799


module before dedup:

        [78928] STRUCT 'netns_sctp' size=296 vlen=46
                'sctp_statistics' type_id=78930 bits_offset=0

        [78929] STRUCT 'sctp_mib' size=272 vlen=1
                'mibs' type_id=80518 bits_offset=0
        [78930] PTR '(anon)' type_id=78929


this field is referenced from within 'struct module' so it won't
match its kernel version and as a result extra 'struct module'
stays in the module's BTF

I'll need to check debuginfo/pahole if that FWD is correct, but
I guess it's normal that some structs might end up unwinded only
in modules and not necessarily in vmlinux

jirka

