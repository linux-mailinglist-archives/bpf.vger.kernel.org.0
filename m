Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E8486187
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiAFIlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 03:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236796AbiAFIlw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 03:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641458511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6cO0By3xfU7a9n6TEUm5Q0O0rT0zqzS45h4TsZ5dLM=;
        b=Bl7gttkmQZHecyTqB0Nh6cJmBusFYbgq+Hm2PeN9Kv6s3bUXPqz6A/x75H1+d2MmyRom33
        c3VCTKn647eoLrpzEphdTGutft0KAbKAk3+wA3BqZ8INmc0igwsMBA/xpMw8sxpT3fvA1T
        u137Ze9YnVCSjWDe0CnYxImy9ME/cpo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-2feWWGZMNtax8abcr08RRA-1; Thu, 06 Jan 2022 03:41:50 -0500
X-MC-Unique: 2feWWGZMNtax8abcr08RRA-1
Received: by mail-ed1-f69.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so1407180edc.18
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 00:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6cO0By3xfU7a9n6TEUm5Q0O0rT0zqzS45h4TsZ5dLM=;
        b=EaXWnMVmwP50UkvlTYPAO36PWcn3v04xPhye98EeAQTrCc6ujro7vLoUYNyJ5Gi6kv
         E0anZp4Xw2m4QygwKIKbaASdnabG4oC2+H45zdSpk0GXgiuy73V7mIWYjb2R3O7myUBx
         UJNHdyMaexlvFBqEeoJeL3E2Xmx+pYW9FJKio/F/fTTvgc7bkec/W5Pe+QVWJAv0+i9y
         jsVUBo9mr3JvsgogrdxRXV9izMfp6v9UovL9GedAkWuXDoPWfX7mfQUGvfCM43KONeMP
         iRMAkFreFttOBX5dt6oa6FuVkvpUWEdefgKq56YzSYFZepRbq5Q6Jl7BaDZqGExLc8VD
         j9jw==
X-Gm-Message-State: AOAM5318WTLfGD2iSB7ZOBL3Z8J07gkF2nwlj6OnAejmslcjseHnBz2i
        RmAL2lxpp5KDKSMq4sQlIsAEQdDI3vZDk90DkxDzdhoXoDxNsMlfsnwH0DWEMWE7O61jbUTjBrA
        3gRmWZzR+R7xd
X-Received: by 2002:a05:6402:b41:: with SMTP id bx1mr55483121edb.292.1641458509066;
        Thu, 06 Jan 2022 00:41:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQIYkJhAAbOd6J0hHVNMxZpM46ATJPB6IQAd2TD7n+qeYiIloSdNHNaqNQIwh69l8u33Z77A==
X-Received: by 2002:a05:6402:b41:: with SMTP id bx1mr55483112edb.292.1641458508882;
        Thu, 06 Jan 2022 00:41:48 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id q20sm479615edt.13.2022.01.06.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:41:47 -0800 (PST)
Date:   Thu, 6 Jan 2022 09:41:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 08/13] bpf: Add kprobe link for attaching raw kprobes
Message-ID: <YdarSovbcmoY9lI6@krava>
References: <20220104080943.113249-1-jolsa@kernel.org>
 <20220104080943.113249-9-jolsa@kernel.org>
 <CAEf4BzZ7s=Pp+2xY3qKX9u6KrPdGW9NNfoiep7nGW+=_s=JJJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ7s=Pp+2xY3qKX9u6KrPdGW9NNfoiep7nGW+=_s=JJJA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 05, 2022 at 08:30:56PM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 4, 2022 at 12:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding new link type BPF_LINK_TYPE_KPROBE to attach kprobes
> > directly through register_kprobe/kretprobe API.
> >
> > Adding new attach type BPF_TRACE_RAW_KPROBE that enables
> > such link for kprobe program.
> >
> > The new link allows to create multiple kprobes link by using
> > new link_create interface:
> >
> >   struct {
> >     __aligned_u64   addrs;
> >     __u32           cnt;
> >     __u64           bpf_cookie;
> 
> I'm afraid bpf_cookie has to be different for each addr, otherwise
> it's severely limiting. So it would be an array of cookies alongside
> an array of addresses

ok

> 
> >   } kprobe;
> >
> > Plus new flag BPF_F_KPROBE_RETURN for link_create.flags to
> > create return probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf_types.h      |   1 +
> >  include/uapi/linux/bpf.h       |  12 +++
> >  kernel/bpf/syscall.c           | 191 ++++++++++++++++++++++++++++++++-
> >  tools/include/uapi/linux/bpf.h |  12 +++
> >  4 files changed, 211 insertions(+), 5 deletions(-)
> >
> 
> [...]
> 
> > @@ -1111,6 +1113,11 @@ enum bpf_link_type {
> >   */
> >  #define BPF_F_SLEEPABLE                (1U << 4)
> >
> > +/* link_create flags used in LINK_CREATE command for BPF_TRACE_RAW_KPROBE
> > + * attach type.
> > + */
> > +#define BPF_F_KPROBE_RETURN    (1U << 0)
> > +
> 
> we have plenty of flexibility to have per-link type fields, so why not
> add `bool is_retprobe` next to addrs and cnt?

well I thought if I do that, people would suggest to use the empty
flags field instead ;-) 

we can move it there as you suggest, but I wonder it's good idea to
use bool in uapi headers, because the bool size definition is vague

jirka

> 
> >  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >   * the following extensions:
> >   *
> > @@ -1465,6 +1472,11 @@ union bpf_attr {
> >                                  */
> >                                 __u64           bpf_cookie;
> >                         } perf_event;
> > +                       struct {
> > +                               __aligned_u64   addrs;
> > +                               __u32           cnt;
> > +                               __u64           bpf_cookie;
> > +                       } kprobe;
> >                 };
> >         } link_create;
> >
> 
> [...]
> 

