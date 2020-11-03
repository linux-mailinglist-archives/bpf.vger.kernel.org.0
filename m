Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5A2A5A76
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKCXSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 18:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgKCXSi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 18:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604445517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdp/CXXpC3BZzpn6iHoH+GMSR/z9Kw5PfRI2yEVai0g=;
        b=aiLZW+G2j+DWmS3ucSxt+hL9Ip/w/WjadJk9O/yo9NU2myOYvobssUsdZH0osQ5O2jJu0L
        /AEYTWuKwpxvn+JkBskCaR6LS7xkM4eems7R+Oa68dRsiKxJFH6YEK4/uTdjSRstMfWY3y
        Gc2PTpGIfV6uh8Zcl7e/k7XBPgN70oY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-6dBtCt6VPpCBWY9hhlrSlQ-1; Tue, 03 Nov 2020 18:18:35 -0500
X-MC-Unique: 6dBtCt6VPpCBWY9hhlrSlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D51085F9D2;
        Tue,  3 Nov 2020 23:18:33 +0000 (UTC)
Received: from krava (unknown [10.40.195.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28CB95D9DC;
        Tue,  3 Nov 2020 23:18:27 +0000 (UTC)
Date:   Wed, 4 Nov 2020 00:18:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201103231827.GA3861143@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava>
 <20201102225658.GD3597846@krava>
 <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
 <20201103190559.GI3597846@krava>
 <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
 <5bbb9838-d98a-c04d-ecba-878f2f934ae0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbb9838-d98a-c04d-ecba-878f2f934ae0@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 03, 2020 at 12:27:56PM -0800, Yonghong Song wrote:

SNIP

> > > > 
> > > 
> > > bpf_map iter definition:
> > > 
> > > DEFINE_BPF_ITER_FUNC(bpf_map, struct bpf_iter_meta *meta, struct bpf_map *map)
> > > 
> > > goes to:
> > > 
> > > #define DEFINE_BPF_ITER_FUNC(target, args...)                   \
> > >          extern int bpf_iter_ ## target(args);                   \
> > >          int __init bpf_iter_ ## target(args) { return 0; }
> > > 
> > > that creates __init bpf_iter_bpf_map function that will make
> > > it into BTF where it's expected when opening iterator, but the
> > > code will be freed because it's __init function
> > 
> > hm... should we just drop __init there?
> > 
> > Yonghong, is __init strictly necessary, or was just an optimization to
> > save a tiny bit of space?
> 
> It is an optimization to save some space. We only need function
> signature, not function body, for bpf_iter.
> 
> The macro definition is in include/linux/bpf.h.
> 
> #define DEFINE_BPF_ITER_FUNC(target, args...)                   \
>         extern int bpf_iter_ ## target(args);                   \
>         int __init bpf_iter_ ## target(args) { return 0; }
> 
> Maybe you could have a section, e.g., called
>   .init.bpf.preserve_type
> which you can scan through to preserve the types.

right, sounds good, will send v3 with that

thanks,
jirka

