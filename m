Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5A4700E4
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhLJMqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 07:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237927AbhLJMqU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 07:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639140162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0eMwO2FeUZK43PiWWzA0YbNlSdbfogBVCpSb3T/oYr0=;
        b=ToGwbuJMsdGlAnwgd4qKyg8n0eKVlU6h6KPX9qgeVhW+lzWXMeX0nzJs9OfvsRCn5kD/JI
        JawaD/vZv5q4UthesXobK0kEhEuzG+kXXUBC7OD9+6K3qrSXutUY4oU4sBskub6cqdU+yH
        QTSt2zkxfdGPeJdnlsCsJiaojgoCk1k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-z06kJ464OqOI84AqtogDHQ-1; Fri, 10 Dec 2021 07:42:41 -0500
X-MC-Unique: z06kJ464OqOI84AqtogDHQ-1
Received: by mail-ed1-f71.google.com with SMTP id 30-20020a508e5e000000b003f02e458b17so8067009edx.17
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 04:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eMwO2FeUZK43PiWWzA0YbNlSdbfogBVCpSb3T/oYr0=;
        b=wuY5/Yw12DIoL164+1xILOClXH+hGj58+3L9o62o/LJ7O1+yJZQ0wywwTywKNs3cWN
         /oz+cazCu5DrvV7uD+BzpBEtR3t1lZbhgGt7YGbD7OTUrCynwCwJVC2KEqciGZ26B27k
         yF/YHcetPMQzKc4OECFeHgZsi0Bh5t/reJRvwWTd9WYOZXl1lEIrYAAUMD+rjR/F6aPB
         KZpxI6EiIWNv0j0pxaDyi5AG2G6u0MTmYy280Bpt3FhaXa9Zgvw2fq4+dUUsIKLj/0+J
         XEShXc3RqbIJY5ISPsNsjWNNB2FBPEuWbB7wa7wZJmgBgLvoL9cXEM3yxhHP9b/SXTdV
         FSQQ==
X-Gm-Message-State: AOAM530wpUO8zIaUG6mB1bDYQwQJov5W+K2az+G3E7uDPeR1d7zde/Gg
        OxCtS32XSyi2WyK4Nv95RptR03sSkrA6WeK+w8cLj3o2bcyrVNwFGraNm22/ZZ9siYtBUMYtLok
        /afkGc1+uCni3
X-Received: by 2002:a05:6402:1287:: with SMTP id w7mr12749741edv.307.1639140160427;
        Fri, 10 Dec 2021 04:42:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc8cDmiTg7tKZOSAEXeJhur1jz7vh5IDcfh/sVEG1EDuVTmpLKOAM3AIeQ5exoHfj3e0C58A==
X-Received: by 2002:a05:6402:1287:: with SMTP id w7mr12749708edv.307.1639140160162;
        Fri, 10 Dec 2021 04:42:40 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id e26sm1435148edr.82.2021.12.10.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:42:39 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:42:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 1/8] perf/kprobe: Add support to create multiple probes
Message-ID: <YbNLPdrA80OMbzdS@krava>
References: <20211124084119.260239-1-jolsa@kernel.org>
 <20211124084119.260239-2-jolsa@kernel.org>
 <CAEf4Bzb5wyW=62fr-BzQsuFL+mt5s=+jGcdxKwZK0+AW18uD_Q@mail.gmail.com>
 <Yafp193RdskXofbH@krava>
 <CAEf4BzbmKffmcM3WhCthrgfbWZBZj52hGH0Ju0itXyJ=yD01NA@mail.gmail.com>
 <YbC4EXS3pyCbh7/i@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbC4EXS3pyCbh7/i@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 08, 2021 at 02:50:09PM +0100, Jiri Olsa wrote:
> On Mon, Dec 06, 2021 at 07:15:58PM -0800, Andrii Nakryiko wrote:
> > On Wed, Dec 1, 2021 at 1:32 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 10:53:58PM -0800, Andrii Nakryiko wrote:
> > > > On Wed, Nov 24, 2021 at 12:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > Adding support to create multiple probes within single perf event.
> > > > > This way we can associate single bpf program with multiple kprobes,
> > > > > because bpf program gets associated with the perf event.
> > > > >
> > > > > The perf_event_attr is not extended, current fields for kprobe
> > > > > attachment are used for multi attachment.
> > > >
> > > > I'm a bit concerned with complicating perf_event_attr further to
> > > > support this multi-attach. For BPF, at least, we now have
> > > > bpf_perf_link and corresponding BPF_LINK_CREATE command in bpf()
> > > > syscall which allows much simpler and cleaner API to do this. Libbpf
> > > > will actually pick bpf_link-based attachment if kernel supports it. I
> > > > think we should better do bpf_link-based approach from the get go.
> > > >
> > > > Another thing I'd like you to keep in mind and think about is BPF
> > > > cookie. Currently kprobe/uprobe/tracepoint allow to associate
> > > > arbitrary user-provided u64 value which will be accessible from BPF
> > > > program with bpf_get_attach_cookie(). With multi-attach kprobes this
> > > > because extremely crucial feature to support, otherwise it's both
> > > > expensive, inconvenient and complicated to be able to distinguish
> > > > between different instances of the same multi-attach kprobe
> > > > invocation. So with that, what would be the interface to specify these
> > > > BPF cookies for this multi-attach kprobe, if we are going through
> > > > perf_event_attr. Probably picking yet another unused field and
> > > > union-izing it with a pointer. It will work, but makes the interface
> > > > even more overloaded. While for LINK_CREATE we can just add another
> > > > pointer to a u64[] with the same size as number of kfunc names and
> > > > offsets.
> > >
> > > I'm not sure we could bypass perf event easily.. perhaps introduce
> > > BPF_PROG_TYPE_RAW_KPROBE as we did for tracepoints or just new
> > > type for multi kprobe attachment like BPF_PROG_TYPE_MULTI_KPROBE
> > > that might be that way we'd have full control over the API
> > 
> > Sure, new type works.
> > 
> > >
> > > >
> > > > But other than that, I'm super happy that you are working on these
> > > > complicated multi-attach capabilities! It would be great to benchmark
> > > > one-by-one attachment vs multi-attach to the same set of kprobes once
> > > > you arrive at the final implementation.
> > >
> > > I have the change for bpftrace to use this and even though there's
> > > some speed up, it's not as substantial as for trampolines
> > >
> > > looks like we 'only' got rid of the multiple perf syscall overheads,
> > > compared to rcu syncs timeouts like we eliminated for trampolines
> > 
> > if it's just eliminating a pretty small overhead of multiple syscalls,
> > then it would be quite disappointing to add a bunch of complexity just
> > for that.
> 
> I meant it's not as huge save as for trampolines, but I expect some
> noticeable speedup, I'll make more becnhmarks with current patchset

so with this approach there's noticable speedup, but it's not the
'instant attachment speed' as for trampolines

as a base I used bpftrace with change that allows to reuse bpf program
for multiple kprobes

bpftrace standard attach of 672 kprobes:

  Performance counter stats for './src/bpftrace -vv -e kprobe:kvm* { @[kstack] += 1; }  i:ms:10 { printf("KRAVA\n"); exit() }':

      70.548897815 seconds time elapsed

       0.909996000 seconds user
      50.622834000 seconds sys


bpftrace using interface from this patchset attach of 673 kprobes:

  Performance counter stats for './src/bpftrace -vv -e kprobe:kvm* { @[kstack] += 1; }  i:ms:10 { printf("KRAVA\n"); exit() }':

      36.947586803 seconds time elapsed

       0.272585000 seconds user
      30.900831000 seconds sys


so it's noticeable, but I wonder it's not enough ;-)

jirka

> 
> > Are there any reasons we can't use the same low-level ftrace
> > batch attach API to speed this up considerably? I assume it's only
> > possible if kprobe is attached at the beginning of the function (not
> > sure how kretprobe is treated here), so we can either say that this
> > new kprobe prog type can only be attached at the beginning of each
> > function and enforce that (probably would be totally reasonable
> > assumption as that's what's happening most frequently in practice).
> > Worst case, should be possible to split all requested attach targets
> > into two groups, one fast at function entry and all the rest.
> > 
> > Am I too far off on this one? There might be some more complications
> > that I don't see.
> 
> I'd need to check more on kprobes internals, but.. ;-)
> 
> the new ftrace interface is special for 'direct' trampolines and
> I think that although kprobes can use ftrace for attaching, they
> use it in a different way
> 
> also this current 'multi attach' approach is on top of current kprobe
> interface, if we wanted to use the new ftrace API we'd need to add new
> kprobe interface and change the kprobe attaching to use it (for cases
> it's attached at the function entry)
> 
> jirka
> 
> > 
> > >
> > > I'll make full benchmarks once we have some final solution
> > >
> > > jirka
> > >
> > 

