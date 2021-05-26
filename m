Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AD392166
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhEZUWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 16:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234915AbhEZUWQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 16:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622060444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNyspGPGQHDp7q9djjqkwrpFcnxI8JrRwzjNUQC7w7k=;
        b=RIhPE06SGf/Z4jPPDhAfCobjIVw/Y+ukCatKiRsleIb5IbxgbHXLdqJx1JKv3kQdTHiD+U
        cPjJhjVlslHVAnF1NX9eZw+Pk0TfRETgWO6HUqnOrULt1KFJUbmGrNyDRX9Pqe8BhHSR7B
        jusXAfLt33meTcDZZug/0LIEvONIJt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-luA67hrwP4OdTM7AnIAhmQ-1; Wed, 26 May 2021 16:20:40 -0400
X-MC-Unique: luA67hrwP4OdTM7AnIAhmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1291D106BB37;
        Wed, 26 May 2021 20:20:37 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9D05D6D3;
        Wed, 26 May 2021 20:20:24 +0000 (UTC)
Date:   Wed, 26 May 2021 22:20:23 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210526222023.44f9b3c6@carbon>
In-Reply-To: <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
References: <20210526125848.1c7adbb0@carbon>
        <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 12:12:09 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > Hi All,
> >
> > I see a need for a driver to use different XDP metadata layout on a per
> > packet basis. E.g. PTP packets contains a hardware timestamp. E.g. VLAN
> > offloading and associated metadata as only relevant for packets using
> > VLANs. (Reserving room for every possible HW-hint is against the idea
> > of BTF).
> >
> > The question is how to support multiple BTF types on per packet basis?
> > (I need input from BTF experts, to tell me if I'm going in the wrong
> > direction with below ideas). =20
>=20
> I'm trying to follow all three threads, but still, can someone dumb it
> down for me and use few very specific examples to show how all this is
> supposed to work end-to-end. I.e., how the C definition for those
> custom BTF layouts might look like and how they are used in BPF
> programs, etc. I'm struggling to put all the pieces together, even
> ignoring all the netdev-specific configuration questions.

I admit that this thread is pushing the boundaries and "ask" too much.
I think we need some steps in-between to get the ball rolling first.  I
myself need to learn more of what is possible today with BTF, before I
ask for more features and multiple simultaneous BTF IDs.

I will go read Andrii's excellent docs [1]+[2] *again*, and perhaps[3].
Do you recommend other BTF docs?
=20
 [1] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portabili=
ty-and-co-re.html
 [2] https://nakryiko.com/posts/bpf-portability-and-co-re/
 [3] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhanceme=
nt.html=20

> As for BTF on a per-packet basis. This means that BTF itself is not
> known at the BPF program verification time, so there will be some sort
> of if/else if/else conditions to handle all recognized BTF IDs? Is
> that right?=20

I do want libbpf CO-RE and BPF program verification to work.  I'm
asking for a BPF-program that can supply multiple BTF struct layouts
and get all of them CO-RE offset adjusted.

The XDP/BPF-prog itself have if/else conditions on BPF-IDs to handle
all the BPF IDs it knows.  When loading the BPF-prog the offset
relocation are done for the code (as usual I presume).

Maybe it is worth pointing out, that the reason for requiring the
BPF-prog to check the BPF-ID match, is to solve the netdev HW feature
update problem.  I'm basically evil and say we can update the netdev HW
features anytime, because it is the BPF programmers responsibility to
check if BTF info changed (after prog was loaded). (The BPF programmer
can solve this via requesting all the possible BTF IDs the driver can
change between, or choose she is only interested in a single variant).

By this, I'm trying to avoid loading an XDP-prog locks down what
hardware features can be enabled/disabled.  It would be sad running
tcpdump (-j adapter_unsynced) that request for HW RX-timestamp is
blocked due to XDP being loaded.


> Fake but specific code would help (at least me) to actually join the
> discussion. Thanks.

I agree, I actually want to code-up a simple example that use BTF CO-RE
and then try to follow the libbpf code that adjust the offsets.  I
admit I need to understand BTF better myself, before I ask for
new/advanced features ;-)

Thanks Andrii for giving us feedback, I do need to learn more about BTF
myself to join the discussion myself.


> >
> > Let me describe a possible/proposed packet flow (feel free to
> > disagree):
> >
> >  When driver RX e.g. a PTP packet it knows HW is configured for
> > PTP-TS and when it sees a TS is available, then it chooses a code
> > path that use the BTF layout that contains RX-TS. To communicate
> > what BTF-type the XDP-metadata contains, it simply store the BTF-ID
> > in xdp_buff->btf_id.
> >
> >  When redirecting the xdp_buff is converted to xdp_frame, and also
> > contains the btf_id member. When converting xdp_frame to SKB, then
> > netcore-code checks if this BTF-ID have been registered, if so
> > there is a (callback or BPF-hook) registered to handle this
> > BTF-type that transfer the fields from XDP-metadata area into SKB
> > fields.
> >
> >  The XDP-prog also have access to this ctx->btf_id and can
> > multiplex on this in the BPF-code itself. Or use other methods like
> > parsing PTP packet and extract TS as expected BTF offset in XDP
> > metadata (perhaps add a sanity check if metadata-size match).
> >
> >
> > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this
> > idea, and they pointed out that AF_XDP also need to know what
> > BTF-layout is used. As Magnus wrote in other thread; there is only
> > 32-bit left in AF_XDP descriptor option. We could store the BTF-ID
> > in this field, but it would block for other use-cases. Bj=C3=B8rn came
> > up with the idea of storing the BTF-ID in the BTF-layout itself,
> > but as the last-member (to have fixed offset to check in userspace
> > AF_XDP program). Then we only need to use a single bit in AF_XDP
> > descriptor option to say XDP-metadata is BTF described.
> >
> > In the AF_XDP userspace program, the programmers can have a similar
> > callback system per known BTF-ID. This way they can compile
> > efficient code per ID via requesting the BTF layout from the
> > kernel. (Hint: `bpftool btf dump id 42 format c`).
> >
> > Please let me know if this it the right or wrong direction?

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

