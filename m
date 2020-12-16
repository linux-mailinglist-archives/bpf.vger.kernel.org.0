Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547F2DC6AB
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgLPSlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgLPSlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 13:41:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9851C061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 10:41:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e2so18237956pgi.5
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ou8j4QMEYZWIBMB2j9Fp9Q/ULWiWgYq9cm9GH0m/uR0=;
        b=e9RhhxLeXLRMor9QiresXmHA6hWc9TEq3j2efz1HbJnF6nDRiTTbeRlhA+Zv04SUd3
         rRjinv4n0rlEwRFuYqJD2QNNCvIKPVWAfcgWA88IVjfM2W3m4qgHkA2xuFxcZJOUOrNs
         ZU5T/VOuJN3KdoguniUdqJSGbRokBtyJMhtPHyH1tJ01MctrE0tVD+SP5yyDlFF/jJXe
         xfNV0sVAtz3xwc50S7h5lQFzlBkddNlsAcJARV/Hs4EsXMd2G6YFwYDZD4FziSfhReS8
         JzlAkdke+poucspJfU/rRo0WftvKx53i6Z3D+wCiK23Z5TmcyL3nrcaFlAB8w5gRjW2r
         VBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ou8j4QMEYZWIBMB2j9Fp9Q/ULWiWgYq9cm9GH0m/uR0=;
        b=BTCvMpNYU0g2kwkpW16l68S8iWrlL+ENpXErsnzoqseQBglYOnbeJNho6SkzlJpSBz
         Xb8cIvsJ5Y12NNn5TooSiBHLNIZdqAyU5AjC0s2TjwgcDtY1UWqGnK/CY17COWfGx1pG
         3s3b7r3FKSKOr+zdRs2wtNwyt886PkmTNFsvJyAgYKxwtFTvXsNoK+PYb/eaKxQ/KDGz
         bwdV/aYt9INOLK4yg4A0WDSqBJ8U3TYLGwocpwRV4a+WQfe/3QT3pBZ48G0HmVnamMIS
         rkZHIpWEJSdayhNj+uaTe45kIp8WPXmCkc0AAlOTEb1MWVO5lp35Uce+DskqnJRPGYSV
         bKOQ==
X-Gm-Message-State: AOAM530BN9sUAiETuY31MxllOXqWem69/9PWp99Jix0XYaV3Zmz3lAWm
        YLaVnCj8DV5i5iIELR14qVI=
X-Google-Smtp-Source: ABdhPJyqdjgmpHBbrho0Dxu7yE9F9HlA7G8Rn8FuljUXFGugCe+skIFEkZvmdpKVjr8wH+y013/Brw==
X-Received: by 2002:a62:63c5:0:b029:1a9:3a46:7d32 with SMTP id x188-20020a6263c50000b02901a93a467d32mr2271528pfb.39.1608144064435;
        Wed, 16 Dec 2020 10:41:04 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:8232])
        by smtp.gmail.com with ESMTPSA id n1sm3544107pfu.28.2020.12.16.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:41:03 -0800 (PST)
Date:   Wed, 16 Dec 2020 10:41:01 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: Why n_buckets is at least max_entries?
Message-ID: <20201216184101.sboyqf2sjuhzmwzj@ast-mbp>
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
 <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com>
 <CAM_iQpX8HU1RPHb+vXRH2qqFLETOJHR91dNxjN-y88v-bcNh+Q@mail.gmail.com>
 <CAADnVQ+RHnrhTAb84aEoqpjy-ez5Hdr5BwroNskj7AfVS7v6Kg@mail.gmail.com>
 <CAM_iQpWb_rHVdxT1H-TwE5Tp=w_G-ZYaG5Ynb4FtJ_79J1La0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWb_rHVdxT1H-TwE5Tp=w_G-ZYaG5Ynb4FtJ_79J1La0g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 06:39:26PM -0800, Cong Wang wrote:
> On Tue, Dec 15, 2020 at 6:29 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 5:55 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 5:45 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 15, 2020 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > Any reason why we allocate at least max_entries of buckets of a hash map?
> > > > >
> > > > >  466
> > > > >  467         /* hash table size must be power of 2 */
> > > > >  468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
> > > >
> > > > because hashmap performance matters a lot.
> > >
> > > Unless you believe hash is perfect, there is always conflict no matter
> > > how many buckets we have.
> > >
> > > Other hashmap implementations also care about performance, but none
> > > of them allocates the number of buckets in this aggressive way. In some
> > > particular cases, for instance max_entries=1025, we end up having almost
> > > buckets twice of max_entries.
> >
> > Do you have any numbers to prove that max_entries > 1024 with n_buckets == 1024
> > would still provide the same level of performance?
> 
> No, I assume you had when you added this implementation?
> 
> Also, it depends on what performance you are talking about too, the
> lookup path is lockless so has nothing to do with the number of buckets.
> 
> The update path does content for bucket locks, but it is arguably the
> slow path.

The update/delete _is_ the fast path for many use cases.
Please see commit 6c9059817432 ("bpf: pre-allocate hash map elements")
Six! different implementation of prealloc were considered at that time.
Just as much, if not more, performance analysis went into LRU design.
See git log kernel/bpf/bpf_lru_list.c.
BPF was always laser focused on performance.
