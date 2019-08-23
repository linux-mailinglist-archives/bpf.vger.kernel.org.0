Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0849AE1E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2019 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfHWL3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Aug 2019 07:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfHWL3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Aug 2019 07:29:54 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83683859FE
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2019 11:29:53 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id u3so5149533edm.13
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2019 04:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wXbJp5wXCmhsoLAAv3JIXQ75ir1xpexGYkM6DjQPpLA=;
        b=XDsqU2Qrwq+m4O0RwDLrT4gQrFej5efH9vNT2mAX2EBzkZ8MXxwdOQPy/Da5lT43i/
         Ap/3uQ664KyCoJh8FhmDsg5s8n9RN++KrpDmyrhueVum4GpJkgGtF1HqG9oLmhwkV3Nq
         hP6NzgfODXtWy2ZNydVnv5cdf62fuXZRDz48xZKOCN2kCEN9RumBtPvTVoM1AVXw+CNa
         9fOaBwLcidZQAB1jZACHU4ZIINoQGLMxgCLlGFn3fOktWXMK26A+q8ceaSBEYWV8LOTv
         GjyI3UJ5JPopfrNfIPnCYiXodLGCZdR46mtTqT+NjfWNKTDmpL239KzNd7gPaIXFBcj6
         uzyQ==
X-Gm-Message-State: APjAAAWWJVre0yBLnsq6gwXqPbpjLEsGzI38iIuFXR1yytBsDs8SH0rQ
        KdUYO1X/TFFCZZphfLipE2jHiW2kHqTMWDaX1OEARKoNwEqgGo1XiCTZZkj4F/WgaiAtuECoPi8
        ma7VjGm8SnWdm
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr3680906ejz.223.1566559792280;
        Fri, 23 Aug 2019 04:29:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpFwd5L74YbNSW3YzrZnIJtPxVrWfZ1RYWPYrFnt5YQx5UeXc6A0ktklyR1Hwv5at4yJ0ZrA==
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr3680891ejz.223.1566559792086;
        Fri, 23 Aug 2019 04:29:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id g20sm473057edp.92.2019.08.23.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 04:29:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE452181CEF; Fri, 23 Aug 2019 13:29:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC bpf-next 0/5] Convert iproute2 to use libbpf (WIP)
In-Reply-To: <CAEf4Bzab_w0AXy5P9mG14mcyJVgUCzuuNda5FpU5wSEwUciGfg@mail.gmail.com>
References: <20190820114706.18546-1-toke@redhat.com> <CAEf4BzZxb7qZabw6aDVaTqnhr3AGtwEo+DbuBR9U9tJr+qVuyg@mail.gmail.com> <87blwiqlc8.fsf@toke.dk> <CAEf4BzYMKPbfOu4a4UDEfJVcNW1-KvRwJ7PVo+Mf_1YUJgE4Qw@mail.gmail.com> <43e8c177-cc9c-ca0b-1622-e30a7a1281b7@iogearbox.net> <CAEf4Bzab_w0AXy5P9mG14mcyJVgUCzuuNda5FpU5wSEwUciGfg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 23 Aug 2019 13:29:50 +0200
Message-ID: <87tva8m85t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ ... snip ...]

> E.g., today's API is essentially three steps:
>
> 1. open and parse ELF: collect relos, programs, map definitions
> 2. load: create maps from collected defs, do program/global data/CO-RE
> relocs, load and verify BPF programs
> 3. attach programs one by one.
>
> Between step 1 and 2 user has flexibility to create more maps, set up
> map-in-map, etc. Between 2 and 3 you can fill in global data, fill in
> tail call maps, etc. That's already pretty flexible. But we can tune
> and break apart those steps even further, if necessary.

Today, steps 1 and 2 can be collapsed into a single call to
bpf_prog_load_xattr(). As Jesper's mail explains, for XDP we don't
generally want to do all the fancy rewriting stuff, we just want a
simple way to load a program and get reusable pinning of maps.
Preferably in a way that is compatible with the iproute2 loader.

So I really think we need two things:

(1) a flexible API that splits up all the various steps in a way that
    allows programs to inject their own map definitions before
    relocations and loading

(2) a simple convenience wrapper that loads an object file, does
    something sensible with pinning and map-in-map definitions, and loads
    everything into the kernel.

I'd go so far as to say that (2) should even support system-wide
configuration, similar to the /etc/iproute2/bpf_pinning file. E.g., an
/etc/libbpf/pinning.conf file that sets the default pinning directory,
and makes it possible to set up pin-value-to-subdir mappings like what
iproute2 does today.

Having (2) makes it more likely that all the different custom loaders
will be compatible with each other, while still allowing people to do
their own custom thing with (1). And of course, (2) could be implemented
in terms of (1) internally in libbpf.

In my ideal world, (2) would just use the definition format already in
iproute2 (this is basically what I implemented already), but if you guys
don't want to put this into libbpf, I can probably live with the default
format being BTF-based instead. Which would mean that iproute2 I would
end up with a flow like this:

- When given an elf file, try to run it through the "standard loader"
  (2). If this works, great, proceed to program attach.

- If using (2) fails because it doesn't understand the map definition,
  fall back to a compatibility loader that parses the legacy iproute2
  map definition format and uses (1) to load that.


Does the above make sense? :)

-Toke
