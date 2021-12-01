Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D281846584B
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhLAVYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 16:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344089AbhLAVXv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 16:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638393625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4cBSs7q9AxQUbiiSjJih2agXVCeF4A6zJ0Pj2RfSmd0=;
        b=goXAY4NIb4TMw4+NKaVOraIxJGIBQqO4hJmHiiHQ0cCGEqS/b0eJ7DHAMQ/i/5zaDJq2kq
        GHiWcFE39KoM/20KjEeK3HNCsLpRua1tzOY8VK+TkY6b2gzjyNBTwoU4qf6QQ7yd9fhDke
        4a0+oxsCMgvzYHDn1Lh7NSJ4OKDxGCg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-ZR4qYN97M7SvrScF4_44wA-1; Wed, 01 Dec 2021 16:20:23 -0500
X-MC-Unique: ZR4qYN97M7SvrScF4_44wA-1
Received: by mail-wm1-f72.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so12850602wmj.7
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 13:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cBSs7q9AxQUbiiSjJih2agXVCeF4A6zJ0Pj2RfSmd0=;
        b=yk2esru8xBvnvAccdfqtArjrKYP7ORATl8Y7OaPLbO/cmDtSjPLqvKHK/TL5Hw9K5F
         cobIFt0eI1RmG2UQ5a3SL2JTCEBnhvM6C1U0YAJfw2n0d7vEVv9M0kyxKIFB4a9fIF0F
         ViTibeUaiAIT6EdGtkw5R6eZlOjLKbw5gynhWx4kt80nFTydSgmONJPDq8mXTzOA8kJ5
         0olo/0F1gS0yP9KWwornyECcLAFKGEokj5gkANeKsH9mT4QgbDEM8dL2TSrpPLHstgLu
         Ds1n5PC2e1RXo5tEI4JdbmWJE9sgVY81jQKhBFzfaPJIFBY9GmmKiadCXGROsPFNCR60
         P13A==
X-Gm-Message-State: AOAM532Ti3hm/nxo4Q4NtB2kb2FPRwjt2vq/6ROX/f1+MftRNPt/0b68
        39qf3RxUX1CrCnsx1redG9MIW1vf4VsYSdTuTU1uQ5mxgwRSS0rvhQ/IwcyLdazdYDVG3QGAKrf
        BgWsHTiefJCjq
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr9349316wrq.94.1638393622723;
        Wed, 01 Dec 2021 13:20:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBCpKQsZXg/B6E1PQNAe8R0tqvCCIBW6nAS3BqJX2pFFrApPJnLHYs6CwkYg1PuLFtcB3bQg==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr9349295wrq.94.1638393622552;
        Wed, 01 Dec 2021 13:20:22 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t8sm855846wrv.30.2021.12.01.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:20:22 -0800 (PST)
Date:   Wed, 1 Dec 2021 22:20:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 09/29] bpf: Add support to load multi func
 tracing program
Message-ID: <YafnFLxjC+hyP2Xg@krava>
References: <20211118112455.475349-1-jolsa@kernel.org>
 <20211118112455.475349-10-jolsa@kernel.org>
 <20211119041159.7rebb5lz2ybnygqr@ast-mbp.dhcp.thefacebook.com>
 <YZv6VLAuv+4gPy/4@krava>
 <CAEf4Bzad=O3PgZ9Z55HpuiobQTkhA57GHFEV2M6JveG_nzP40A@mail.gmail.com>
 <YaO/O4bNeg2JRrbU@krava>
 <CAEf4Bza5ceiQS0jLAsoCvMSb4CbS7vJ-Qym=wn7CzOGsU2g_DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza5ceiQS0jLAsoCvMSb4CbS7vJ-Qym=wn7CzOGsU2g_DQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 30, 2021 at 11:17:44PM -0800, Andrii Nakryiko wrote:
> On Sun, Nov 28, 2021 at 9:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 01:51:36PM -0800, Andrii Nakryiko wrote:
> > > On Mon, Nov 22, 2021 at 12:15 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 18, 2021 at 08:11:59PM -0800, Alexei Starovoitov wrote:
> > > > > On Thu, Nov 18, 2021 at 12:24:35PM +0100, Jiri Olsa wrote:
> > > > > > +
> > > > > > +DEFINE_BPF_MULTI_FUNC(unsigned long a1, unsigned long a2,
> > > > > > +                 unsigned long a3, unsigned long a4,
> > > > > > +                 unsigned long a5, unsigned long a6)
> > > > >
> > > > > This is probably a bit too x86 specific. May be make add all 12 args?
> > > > > Or other places would need to be tweaked?
> > > >
> > > > I think si, I'll check
> > > >
> > > > >
> > > > > > +BTF_ID_LIST_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
> > > > > ...
> > > > > > -   prog->aux->attach_btf_id = attr->attach_btf_id;
> > > > > > +   prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
> > > > >
> > > > > Just ignoring that was passed in uattr?
> > > > > Maybe instead of ignoring dopr BPF_F_MULTI_FUNC and make libbpf
> > > > > point to that btf_id instead?
> > > > > Then multi or not can be checked with if (attr->attach_btf_id == bpf_multi_func_btf_id[0]).
> > > > >
> > > >
> > > > nice idea, it might fit better than the flag
> > >
> > > Instead of a flag we can also use a different expected_attach_type
> > > (FENTRY vs FENTRY_MULTI, etc).
> >
> > right, you already asked for that - https://lore.kernel.org/bpf/YS9k26rRcUJVS%2Fvx@krava/
> >
> > I still think it'd mean more code while this way we just use
> > current fentry/fexit code paths with few special handling
> > for multi programs
> >
> 
> I don't see how it makes much difference for kernel implementation.
> Checking expected_attach_type vs checking prog_flags is about the same
> amount of code. The big advantage of new expected_attach_type (or
> prog_type) is that it will be very obvious in all sorts of diagnostics
> tooling (think bpftool prog show output, etc). prog_flags are almost
> invisible and it will be the last thing that users will think about.
> I'd try to minimize the usage of prog_flags overall.

ok, I'll check on that.. I recall adding this new type in
many expected_attach_type switches, which made me think
the new flag will be easier

> 
> > > As for attach_btf_id, why can't we just
> > > enforce it as 0?
> >
> > there's prog->aux->attach_func_proto that needs to be set based
> > on attach_btf_id, and is checked later in btf_ctx_access
> 
> right:
> 
> if (attach_btf_id == 0)
>     prog->aux->attach_func_proto =
> &special_func_model_or_proto_or_whatever_that_does_not_have_to_be_known_to_libbpf_and_outside_world_ever;
> 
> ;) let's keep implementation details as internal implementation
> details, instead of dumping all that to UAPI

ok, we can do that ;-)

thanks,
jirka

