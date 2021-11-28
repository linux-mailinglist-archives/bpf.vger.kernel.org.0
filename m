Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32A46081E
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353220AbhK1Rqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 12:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhK1Roh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Nov 2021 12:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638121281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9AGDIl3RZ7Ue6NK0cmAlDfm9kgv2zpdddX1BmxFhRrE=;
        b=XKYwlFOnWf/14DrKGUFD+wYthM+H/nn7dlZfKeHjUaqCWRsl6kwOiJ5doY+gQm8Rb8pnV4
        EqbquGO1dDcAYBw3naUa3P8V6yG++jjRGY7RudUi2LHA/lYLtSLxTJGZLyMrVQMvSMtTfq
        ZJPTpiYNcgT00CFlhNSf81JURtQnCQA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-ufFynlnfOV2lc-BZPgExRA-1; Sun, 28 Nov 2021 12:41:19 -0500
X-MC-Unique: ufFynlnfOV2lc-BZPgExRA-1
Received: by mail-wm1-f72.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so10567846wmc.7
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 09:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9AGDIl3RZ7Ue6NK0cmAlDfm9kgv2zpdddX1BmxFhRrE=;
        b=DY9+aGtZWyrvHr7+dd3nryKv1sW7jEveSBzbudD89bF1oo9fI/GbVv+FCy1+fK+bP1
         0FwhFoYZ4sZSh+qHp/euKC/EqjwRgnuzBHrvW/1WtvfojlFEpBJ6cMSaH2I5uzmUbwVM
         sC90YWt0yxNT30A+5Wv+mUYbSOaCsrRyi6jb6Ubu/uw1EBN2zzhqyx3tf6PpQtC3atmb
         e7MlF9KsANYn3F8tSNqHRuFfADdd1HDrvEBzZdi/uYMkbL6g+cCJ85Z2cuUDWMvqvRL0
         TMTncaHptKCB/X5ZUVjP1oitJ2dQ40neqXs+3EkKQ78F6iG12tVwIcLUfBbLy13r2Zq/
         Cbwg==
X-Gm-Message-State: AOAM532bwot9JGj5H7Y5i9UF1NoTTAgiCgHRILoNFx3sf/5KSyoL4B0Z
        AqQIKDF11YUBktsa+MSMllN/VKWCwYXJZNwq+Oxl6SPtw8UkBkcP49mFNZzj3Nl61MR2fCdgdMO
        4+QGzJYg0JpUH
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr31065867wmc.89.1638121278462;
        Sun, 28 Nov 2021 09:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj5z9AffheGCf8LLRY3tMX+p9VDf7knSBz3KFQ1rEHx1laoC2FWlsKzsAFl4DyzjGdowgqig==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr31065844wmc.89.1638121278282;
        Sun, 28 Nov 2021 09:41:18 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id bg34sm16521063wmb.47.2021.11.28.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:41:18 -0800 (PST)
Date:   Sun, 28 Nov 2021 18:41:15 +0100
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
Message-ID: <YaO/O4bNeg2JRrbU@krava>
References: <20211118112455.475349-1-jolsa@kernel.org>
 <20211118112455.475349-10-jolsa@kernel.org>
 <20211119041159.7rebb5lz2ybnygqr@ast-mbp.dhcp.thefacebook.com>
 <YZv6VLAuv+4gPy/4@krava>
 <CAEf4Bzad=O3PgZ9Z55HpuiobQTkhA57GHFEV2M6JveG_nzP40A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzad=O3PgZ9Z55HpuiobQTkhA57GHFEV2M6JveG_nzP40A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 01:51:36PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 22, 2021 at 12:15 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Nov 18, 2021 at 08:11:59PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Nov 18, 2021 at 12:24:35PM +0100, Jiri Olsa wrote:
> > > > +
> > > > +DEFINE_BPF_MULTI_FUNC(unsigned long a1, unsigned long a2,
> > > > +                 unsigned long a3, unsigned long a4,
> > > > +                 unsigned long a5, unsigned long a6)
> > >
> > > This is probably a bit too x86 specific. May be make add all 12 args?
> > > Or other places would need to be tweaked?
> >
> > I think si, I'll check
> >
> > >
> > > > +BTF_ID_LIST_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
> > > ...
> > > > -   prog->aux->attach_btf_id = attr->attach_btf_id;
> > > > +   prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
> > >
> > > Just ignoring that was passed in uattr?
> > > Maybe instead of ignoring dopr BPF_F_MULTI_FUNC and make libbpf
> > > point to that btf_id instead?
> > > Then multi or not can be checked with if (attr->attach_btf_id == bpf_multi_func_btf_id[0]).
> > >
> >
> > nice idea, it might fit better than the flag
> 
> Instead of a flag we can also use a different expected_attach_type
> (FENTRY vs FENTRY_MULTI, etc).

right, you already asked for that - https://lore.kernel.org/bpf/YS9k26rRcUJVS%2Fvx@krava/

I still think it'd mean more code while this way we just use
current fentry/fexit code paths with few special handling
for multi programs

> As for attach_btf_id, why can't we just
> enforce it as 0?

there's prog->aux->attach_func_proto that needs to be set based
on attach_btf_id, and is checked later in btf_ctx_access

jirka

> 
> >
> > thanks,
> > jirka
> >
> 

