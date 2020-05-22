Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2C1DE1B8
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgEVIWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 04:22:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00236C061A0E
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 01:22:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s3so12019597eji.6
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4qdoEycBTAs3pNrgkm7pmsLiPziUhW20aeo7uy5vMA=;
        b=yv++BEwAWrnYbdU5JWEUDy5WVhGMgAL8IQpMh/vXOcWJFOIY9Mgv38rvyL0rzLpwAW
         5sMPaPkR/iMyGAfS11rwmPNv3dovfaCBcuNWcTANhhtcKQ0tVjfEr1SRdQ8AV68A+dyw
         sso9j6l33DUj19rs7+61byosUMGP7TpLQ2l94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4qdoEycBTAs3pNrgkm7pmsLiPziUhW20aeo7uy5vMA=;
        b=dwmtQn63HvAauBSo03jJ4uSQzXbnbBO6K+ymh2WL70QjJQZgTsnzVq7UfiVISGfHJe
         53+gJx32FBVVx148lfe/PN51R+5GUoEW1n/Qh7WcIlRg/e8Hy1sXr8UNkxELDXGU3PDM
         YwJZhyZX+NmWRjOsfTmJU6wgK0tzB9OcrchHpfZZ16aemZhlY5+FZ5VN2TkusCdw3VBU
         MnaIxqOdPJbYm0W3NqUUGr0MLo6YBRywT5yjxydABAMEqgDdd4DdLQErtob6J9kEtd0J
         nplsGGrryIsjL1tZdsu7cfjiJONCLk6WDaPONwFMo57ijMgCYLDvHCPckjr4tH8U2rV4
         cijg==
X-Gm-Message-State: AOAM533xnboMfRbKAxeHtJNohQexMChborjZwKMxVm1dFdPcheSstQjm
        E3CG07E0o057iWCUbRdloJl8qQ==
X-Google-Smtp-Source: ABdhPJzX5zN1xYcQiqpHUET2Zd5PP154NF4kULTwE2I9DY67lpXkaQMTTL6JrMukkzg+4aeLC9CxrA==
X-Received: by 2002:a17:907:392:: with SMTP id ss18mr7452112ejb.156.1590135725621;
        Fri, 22 May 2020 01:22:05 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 93sm6859222edy.49.2020.05.22.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:22:05 -0700 (PDT)
Date:   Fri, 22 May 2020 10:22:02 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf] flow_dissector: Drop BPF flow dissector prog ref on
 netns cleanup
Message-ID: <20200522102202.4cb9232b@toad>
In-Reply-To: <CAADnVQKztsp-fF5Mbi7DUGrM-5SfH24xntaF0Qaewxr9ax7ZRw@mail.gmail.com>
References: <20200520172258.551075-1-jakub@cloudflare.com>
        <CAEf4BzbpMp9D0TsC5dhRJ-AeKqsXJ5EyEcCx2-kkZg+ZBnHYqg@mail.gmail.com>
        <CAADnVQKztsp-fF5Mbi7DUGrM-5SfH24xntaF0Qaewxr9ax7ZRw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 May 2020 17:53:14 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, May 21, 2020 at 12:09 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 20, 2020 at 10:24 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:  
> > >
> > > When attaching a flow dissector program to a network namespace with
> > > bpf(BPF_PROG_ATTACH, ...) we grab a reference to bpf_prog.
> > >
> > > If netns gets destroyed while a flow dissector is still attached, and there
> > > are no other references to the prog, we leak the reference and the program
> > > remains loaded.
> > >
> > > Leak can be reproduced by running flow dissector tests from selftests/bpf:
> > >
> > >   # bpftool prog list
> > >   # ./test_flow_dissector.sh
> > >   ...
> > >   selftests: test_flow_dissector [PASS]
> > >   # bpftool prog list
> > >   4: flow_dissector  name _dissect  tag e314084d332a5338  gpl
> > >           loaded_at 2020-05-20T18:50:53+0200  uid 0
> > >           xlated 552B  jited 355B  memlock 4096B  map_ids 3,4
> > >           btf_id 4
> > >   #
> > >
> > > Fix it by detaching the flow dissector program when netns is going away.
> > >
> > > Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> > > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > > ---
> > >
> > > Discovered while working on bpf_link support for netns-attached progs.
> > > Looks like bpf tree material so pushing it out separately.
> > >
> > > -jkbs
> > >  
> >
> > [...]
> >  
> > >  /**
> > >   * __skb_flow_get_ports - extract the upper layer ports and return them
> > >   * @skb: sk_buff to extract the ports from
> > > @@ -1827,6 +1848,8 @@ EXPORT_SYMBOL(flow_keys_basic_dissector);
> > >
> > >  static int __init init_default_flow_dissectors(void)
> > >  {
> > > +       int err;
> > > +
> > >         skb_flow_dissector_init(&flow_keys_dissector,
> > >                                 flow_keys_dissector_keys,
> > >                                 ARRAY_SIZE(flow_keys_dissector_keys));
> > > @@ -1836,7 +1859,11 @@ static int __init init_default_flow_dissectors(void)
> > >         skb_flow_dissector_init(&flow_keys_basic_dissector,
> > >                                 flow_keys_basic_dissector_keys,
> > >                                 ARRAY_SIZE(flow_keys_basic_dissector_keys));
> > > -       return 0;
> > > +
> > > +       err = register_pernet_subsys(&flow_dissector_pernet_ops);
> > > +
> > > +       WARN_ON(err);  
> >
> > syzbot simulates memory allocation failures, which can bubble up here,
> > so this WARN_ON will probably trigger. I wonder if this could be
> > rewritten so that init fails, when registration fails? What are the
> > consequences?  
> 
> good catch. that warn is pointless.
> I removed it and force pushed the bpf tree.

Thanks for patching it up. I'll keep it in mind next time.
