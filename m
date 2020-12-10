Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4452D6C1A
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394391AbgLJXnw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 18:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394392AbgLJXng (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 18:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607643728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MobA73H5OEPJoJGR5A82BMTboxXJp2LUYpdmrqO18a0=;
        b=c1+6+/HI6K+PQmYLBf8NaqO8Xnwck6jL5ltbH5XWltjNtDkFCTfeVbwAbWL715dQdu/tGt
        +EnOuviKYbhGTriad/Bqy1wGRb+gL621TqhOOnWF55QNzvG4OVZz0EAeqKDZBh0x3x8iJA
        8A19Qh0adQhCqjGJUBib+VpEZTmisr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-lSaBO3ysOBCwCvHOLWirew-1; Thu, 10 Dec 2020 18:42:04 -0500
X-MC-Unique: lSaBO3ysOBCwCvHOLWirew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C220192CC40;
        Thu, 10 Dec 2020 23:42:03 +0000 (UTC)
Received: from krava (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA52760862;
        Thu, 10 Dec 2020 23:42:01 +0000 (UTC)
Date:   Fri, 11 Dec 2020 00:42:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Per-CPU variables in modules and pahole
Message-ID: <20201210234201.GC186916@krava>
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava>
 <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 09:02:05AM -0800, Andrii Nakryiko wrote:

SNIP

> 
> yes, ELF symbol's value is 4, but when iterating DWARF variables
> (0x10e70 + 4) is returned. It does look like a special handling of
> modules. I missed that libdw does some special things for specifically
> modules. Further debugging yesterday showed that 0x10e70 roughly
> corresponds to the offset of .data..per_cpu if you count all the
> allocatable data sections that come before it. So I think you are
> right. We should probably centralize the logic of kernel module
> detection so that we can handle these module vs non-module differences
> properly.
> 
> >
> > not sure this is related but looks like similar issue I had to
> > solve for modules functions, as described in the changelog:
> > (not merged yet)
> >
> >     btf_encoder: Detect kernel module ftrace addresses
> >
> >     ...
> >     There's one tricky point with kernel modules wrt Elf object,
> >     which we get from dwfl_module_getelf function. This function
> >     performs all possible relocations, including __mcount_loc
> >     section.
> >
> >     So addrs array contains relocated values, which we need take
> >     into account when we compare them to functions values which
> >     are relative to their sections.
> >     ...
> >
> > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > because not sure where you see that address exactly
> 
> 
> It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.

I'm taking section sh_addr for each function and relocate
the addr value for kernel modules, check setup_functions
function

I don't see this being somehow centralized, looks simple
enough to me for each case

jirka

