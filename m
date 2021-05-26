Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796239218F
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhEZUjE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhEZUjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 16:39:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5FC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 13:37:26 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h11so2104646ili.9
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ly0K309wWBucFwzuHUOl/E2/4fdHzmSziVaE6a85y7M=;
        b=SVOnrjBhD/1rMAlwDfYioEoF2YxPr0JZIjVGan2/2l9JFKtSYVCB7GX5Sj5mxSJvXN
         0/CrPf0s2pDgr+e8xtMFWC/+9gF8quUVk4OE0+c6oKpUlW6dEqsYvGM8rFuQuGfkKuQp
         tObmY3fTbrtzKJSrkHLCoNKdJisa7LCukQ3lbMbOYJvgc6LV1N2WO6sCNdMH0IoegXGV
         YnSKbG/mhV1BbwOikhtfzq2G8Ts1CIwbls9EwkVj3LngwXpT8eTDffXfSb3se4CMzzu6
         4aanWEPq20POiGEeciNZGcjXBvBJkcEn9QPJ5Yc8hud6Gq63uBBUkTJG0jpKSc0LvkO1
         /KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ly0K309wWBucFwzuHUOl/E2/4fdHzmSziVaE6a85y7M=;
        b=dTDgfEe1NBsfoT8Rw05lwYnI2EWqJqbFKOTIaAEXppKJBaHle6aq/m/qY1VgvR8nYS
         Jl+diXhG+/0nAdZ+xM4dEGkt+E0R/zZUUfXSs6NHYGgCwAFMmXKR6aUqnzrYDpMJ9qOy
         te9qCONPyCSGsVXUXly7kbK/9e8P/R+Lgxw189rFr8qMUebdeu+O/BXx1Nw8YD1F7YYz
         +PFNzflY7m3ExUGm78OpjsdqdYd3TlzAt16eYle2Yx1mx6IpN5DKazHPXK36ZlLtY2pV
         ZKZfvOuepdPNaGD7JMqZifzp7pEu4JZ8gQw+ZzJMqZDv+VbzWW/0Hy4hgJt64bfGwq8m
         zsMA==
X-Gm-Message-State: AOAM531uOJsBxJEjEZeUxQtphMRFFosCtCf7fvfVGFVvpI1uXtXz6Ht2
        dEvL/N4PtT/sVx6lzuDZztvqs2L/PJoV8g==
X-Google-Smtp-Source: ABdhPJwWSQIWqi0bog75VcZ5aInu76K3JxfFuj9evcVhP+CSaMi7qUgXqiRxTHPoWArE0W304Vts4Q==
X-Received: by 2002:a05:6e02:1046:: with SMTP id p6mr163713ilj.86.1622061445260;
        Wed, 26 May 2021 13:37:25 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id r6sm51532ioc.5.2021.05.26.13.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 13:37:24 -0700 (PDT)
Date:   Wed, 26 May 2021 13:37:17 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, brouer@redhat.com,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Message-ID: <60aeb17dd2887_11c0c2089c@john-XPS-13-9370.notmuch>
In-Reply-To: <20210526222023.44f9b3c6@carbon>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <20210526222023.44f9b3c6@carbon>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer wrote:
> On Wed, 26 May 2021 12:12:09 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> =

> > On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >
> > > Hi All,
> > >
> > > I see a need for a driver to use different XDP metadata layout on a=
 per
> > > packet basis. E.g. PTP packets contains a hardware timestamp. E.g. =
VLAN
> > > offloading and associated metadata as only relevant for packets usi=
ng
> > > VLANs. (Reserving room for every possible HW-hint is against the id=
ea
> > > of BTF).
> > >
> > > The question is how to support multiple BTF types on per packet bas=
is?
> > > (I need input from BTF experts, to tell me if I'm going in the wron=
g
> > > direction with below ideas).  =

> > =

> > I'm trying to follow all three threads, but still, can someone dumb i=
t
> > down for me and use few very specific examples to show how all this i=
s
> > supposed to work end-to-end. I.e., how the C definition for those
> > custom BTF layouts might look like and how they are used in BPF
> > programs, etc. I'm struggling to put all the pieces together, even
> > ignoring all the netdev-specific configuration questions.
> =

> I admit that this thread is pushing the boundaries and "ask" too much.
> I think we need some steps in-between to get the ball rolling first.  I=

> myself need to learn more of what is possible today with BTF, before I
> ask for more features and multiple simultaneous BTF IDs.

Dang, I replied to the original thread before I saw this.

In short I don't think you are asking for much, most of it already exists=
.

> =

> I will go read Andrii's excellent docs [1]+[2] *again*, and perhaps[3].=

> Do you recommend other BTF docs?
>  =

>  [1] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-porta=
bility-and-co-re.html
>  [2] https://nakryiko.com/posts/bpf-portability-and-co-re/
>  [3] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhan=
cement.html =


Take a look over the selftests and libbpf BTF headers that should
give you the gist.

> =

> > As for BTF on a per-packet basis. This means that BTF itself is not
> > known at the BPF program verification time, so there will be some sor=
t
> > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > that right? =

> =

> I do want libbpf CO-RE and BPF program verification to work.  I'm
> asking for a BPF-program that can supply multiple BTF struct layouts
> and get all of them CO-RE offset adjusted.

See other thread, In C we call this a union right?

> =

> The XDP/BPF-prog itself have if/else conditions on BPF-IDs to handle
> all the BPF IDs it knows.  When loading the BPF-prog the offset
> relocation are done for the code (as usual I presume).

On kprobe side we have lots of code with

 if (exists(...)) { } else { }

Same should be doable from XDP side.

> =

> Maybe it is worth pointing out, that the reason for requiring the
> BPF-prog to check the BPF-ID match, is to solve the netdev HW feature
> update problem.  I'm basically evil and say we can update the netdev HW=

> features anytime, because it is the BPF programmers responsibility to
> check if BTF info changed (after prog was loaded). (The BPF programmer
> can solve this via requesting all the possible BTF IDs the driver can
> change between, or choose she is only interested in a single variant).

I don't think this is evil, it should be expected over time. But,
this is two or three steps ahead of where we are. As long as you
can get updated BTF either out of band or through kernel interface
this works as expected as far as I can tell.

> =

> By this, I'm trying to avoid loading an XDP-prog locks down what
> hardware features can be enabled/disabled.  It would be sad running
> tcpdump (-j adapter_unsynced) that request for HW RX-timestamp is
> blocked due to XDP being loaded.

Same as above

 if (exists(...)) {do better version} else {do slow version}

> =

> =

> > Fake but specific code would help (at least me) to actually join the
> > discussion. Thanks.
> =

> I agree, I actually want to code-up a simple example that use BTF CO-RE=

> and then try to follow the libbpf code that adjust the offsets.  I
> admit I need to understand BTF better myself, before I ask for
> new/advanced features ;-)
> =

> Thanks Andrii for giving us feedback, I do need to learn more about BTF=

> myself to join the discussion myself.

I suspect you will find with some minor user side changes this should
already work.

> =

> =

> > >
> > > Let me describe a possible/proposed packet flow (feel free to
> > > disagree):
> > >
> > >  When driver RX e.g. a PTP packet it knows HW is configured for
> > > PTP-TS and when it sees a TS is available, then it chooses a code
> > > path that use the BTF layout that contains RX-TS. To communicate
> > > what BTF-type the XDP-metadata contains, it simply store the BTF-ID=

> > > in xdp_buff->btf_id.
> > >
> > >  When redirecting the xdp_buff is converted to xdp_frame, and also
> > > contains the btf_id member. When converting xdp_frame to SKB, then
> > > netcore-code checks if this BTF-ID have been registered, if so
> > > there is a (callback or BPF-hook) registered to handle this
> > > BTF-type that transfer the fields from XDP-metadata area into SKB
> > > fields.
> > >
> > >  The XDP-prog also have access to this ctx->btf_id and can
> > > multiplex on this in the BPF-code itself. Or use other methods like=

> > > parsing PTP packet and extract TS as expected BTF offset in XDP
> > > metadata (perhaps add a sanity check if metadata-size match).
> > >
> > >
> > > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about th=
is
> > > idea, and they pointed out that AF_XDP also need to know what
> > > BTF-layout is used. As Magnus wrote in other thread; there is only
> > > 32-bit left in AF_XDP descriptor option. We could store the BTF-ID
> > > in this field, but it would block for other use-cases. Bj=C3=B8rn c=
ame
> > > up with the idea of storing the BTF-ID in the BTF-layout itself,
> > > but as the last-member (to have fixed offset to check in userspace
> > > AF_XDP program). Then we only need to use a single bit in AF_XDP
> > > descriptor option to say XDP-metadata is BTF described.
> > >
> > > In the AF_XDP userspace program, the programmers can have a similar=

> > > callback system per known BTF-ID. This way they can compile
> > > efficient code per ID via requesting the BTF layout from the
> > > kernel. (Hint: `bpftool btf dump id 42 format c`).
> > >
> > > Please let me know if this it the right or wrong direction?
> =

> -- =

> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> =



