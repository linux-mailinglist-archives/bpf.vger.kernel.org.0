Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA26546822D
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 04:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384155AbhLDDmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 22:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354735AbhLDDmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 22:42:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2023C061751;
        Fri,  3 Dec 2021 19:39:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e128so6279817iof.1;
        Fri, 03 Dec 2021 19:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mnmWyc1uRIrdzxVFTBTowCQsABDGXi8QqEJLurRE1YQ=;
        b=o/vMVl11VQo+RrITYPPXy7WPC2Zk0D6Q4CxjZewNMihggM0DO6hDqQh7QygRYnUtAI
         BwjFIrOEm3Hn+in6wLcRxXRs43QeYQeiDACPJ6gcpR5MHw1QDrTGH75qaehaSZNQ97sr
         9vVrgSTv6puz5q1ylS3ONydy0RiKEkLnA/VuxEdkDPYs9gf8/8ywJFUDxEnKzmseCj0L
         U7Ft0LU4GKVgQAVTmJIQ5j63p/94g4BAEXBZJaLLVO+KPMzOoIq+ZJblGBuhwian7eMR
         neQ1ltvtKRKaKTyYNKaauUbk6AhPC8LzRa5Y1T0M5BWP/daVT4VCsPbeQREWtQoCu04Q
         U/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mnmWyc1uRIrdzxVFTBTowCQsABDGXi8QqEJLurRE1YQ=;
        b=rNlGjEjdFiK1JCZLVFPnAXJNOwEvhyT6Y5BdsZq862ZlZVf3n194lw2adyLSLVgOc+
         LApXDdTWegB3J1vO0lDwEWLwdZrKq4vnwWYfXzGjvacKbLEiEQ/GCsMtPilRU2AZijWw
         sINh3aU9uSLrqfNjGOZ5AxtBeIKUyVrZeY1N83mfxC4cmlEvtSrrzw5+8mid7PWWHsEg
         7y5pVGVQbHg3BfEnacHfIseAsY2488vroqJd/x69PjJQDFGDQKY/qJ1aZoxAgoGzk/ot
         czpYgYBlFna+qKdSiDjV3sNSKX7/dgCPOyPjO1lQ/P+kaXHH5mcpINeu80TUSJkLEgoE
         LT4Q==
X-Gm-Message-State: AOAM5335lO1TxfK9BhmDLHcinNpHaN9TmDTGlMuO+JH3Hz05vAl5S0Rb
        gzFc/xzYe4Pmi8TMlL85F3Tzez+AlSgcdg==
X-Google-Smtp-Source: ABdhPJwGGjCN3NDCfgSuAgWAA4wKTe9tmiLqQKtQnTIjmqmWC/3QmYxerCzIKPK0alWsz3Vewvtysg==
X-Received: by 2002:a05:6638:2bb:: with SMTP id d27mr31546039jaq.66.1638589156983;
        Fri, 03 Dec 2021 19:39:16 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id s20sm2715243iog.25.2021.12.03.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 19:39:16 -0800 (PST)
Date:   Fri, 03 Dec 2021 19:39:06 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Luca Boccassi <bluca@debian.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <61aae2da8c7b0_68de0208dd@john.notmuch>
In-Reply-To: <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
 <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
 <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
 <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Fri, Dec 3, 2021 at 4:42 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Fri, Dec 3, 2021 at 11:20 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Dec 3, 2021 at 2:06 PM Luca Boccassi <bluca@debian.org> wrote:
> > > >
> > > > On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> > > > > On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > > > >
> > > > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > > > >
> > > > > > > > This series add signature verification for BPF files.
> > > > > > > > The first patch implements the signature validation in the
> > > > > > > > kernel,
> > > > > > > > the second patch optionally makes the signature mandatory,
> > > > > > > > the third adds signature generation to bpftool.
> > > > > > >
> > > > > > > Matteo,
> > > > > > >
> > > > > > > I think I already mentioned that it's no-go as-is.
> > > > > > > We've agreed to go with John's suggestion.
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > my previous attempt was loading a whole ELF file and parsing it in
> > > > > > kernel.
> > > > > > In this series I just validate the instructions against a
> > > > > > signature,
> > > > > > as with kernel CO-RE libbpf doesn't need to mangle it.
> > > > > >
> > > > > > Which suggestion? I think I missed this one..
> > > > >
> > > > > This talk and discussion:
> > > > > https://linuxplumbersconf.org/event/11/contributions/947/
> > > >
> > > > Thanks for the link - but for those of us who don't have ~5 hours to
> > > > watch a video recording, would you mind sharing a one line summary,
> > > > please? Is there an alternative patch series implementing BPF signing
> > > > that you can link us so that we can look at it? Just a link or
> > > > googlable reference would be more than enough.
> > >
> > > It's not 5 hours and you have to read slides and watch
> > > John's presentation to follow the conversation.
> >
> > So, If I have understood correctly, the proposal is to validate the
> > tools which loads the BPF (e.g. perf, ip) with fs-verity, and only
> > allow BPF loading from those validated binaries?
> > That's nice, but I think that this could be complementary to the
> > instructions signature.
> > Imagine a validated binary being exploited somehow at runtime, that
> > could be vector of malicious BPF program load.
> > Can't we have both available, and use one or other, or even both
> > together depending on the use case?
> 
> I'll let John comment.

I'll give the outline of the argument here.

I do not believe signing BPF instructions for real programs provides
much additional security. Given most real programs if the application
or loader is exploited at runtime we have all sorts of trouble. First
simply verifying the program doesn't prevent malicious use of the
program. If its in the network program this means DDOS, data exfiltration,
mitm attacks, many other possibilities. If its enforcement program
most enforcement actions are programmed from this application so system
security is lost already.  If its observability application simply
drops/manipulates observations that it wants. I don't know of any
useful programs that exist in isolation without user space input
and output as a critical component. If its not a privileged user,
well it better not be doing anything critical anyways or disabled
outright for the security focused.

Many critical programs can't be signed by the nature of the program.
Optimizing network app generates optimized code at runtime. Observability
tools JIT the code on the fly, similarly enforcement tools will do the
same. I think the power of being able to optimize JIT the code in
application and give to the kernel is something we will see more and
more of. Saying I'm only going to accept signed programs, for a
distribution or something other than niche use case, is non starter
IMO because it breaks so many real use cases. We should encourage
these optimizing use cases as I see it as critical to performance
and keeping overhead low.

From a purely security standpoint I believe you are better off
defining characteristics an application is allowed to have. For
example allowed to probe kernel memory, make these helpers calls,
have this many instructions, use this much memory, this much cpu,
etc. This lets you sandbox a BPF application (both user space and
kernel side) much nicer than any signing will allow.

If we want to 'sign' programs we should do that from a BPF program
directly where other metadata can be included in the policy. For
example having a hash of the program loaded along with the calls
made and process allows for rich policy decisions. I have other
use cases that need a hash/signature for data blobs, so its on
my todo list but not at the top yet.  But, being able to verify
arbitrary blob of data from BPF feels like a useful operation to me
in general. The fact in your case its a set of eBPF insns and in
my case its some key in a network header shouldn't matter.

The series as is, scanned commit descriptions, is going to break
lots of in-use-today programs if it was ever enabled. And
is not as flexible (can't support bpftrace, etc.) or powerful
(can't consider fine grained policy decisions) as above.

Add a function we can hook after verify (or before up for
debate) and helpers to verify signatures and/or generate
hashes and we get a better more general solution. And it can
also solve your use case even if I believe its not useful and
may break many BPF users running bpftrace, libbpf, etc.

Thanks,
John
