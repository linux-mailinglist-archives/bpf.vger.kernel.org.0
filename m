Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516883B376D
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 21:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFXT46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 15:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232178AbhFXT46 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 15:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624564465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZsjIeFeEKU0DGHCohMaRKz9BtynWkkpWSagaUI+Kfo=;
        b=E7siLmcRdJpxyZgsjRk6yvuVp6VU4Fib6bIaBnuB0MgSbmMWTd0ACBNAlVp3Y1oZOo2Ii+
        mvyKvYjyQ/ItXBEN//edNS4SHqbzDYMKDBn3SBDt8kWC0TqjHDTaD9QcaBotJrrZll6QJm
        wANxIDot8YkXoBy6IngmXUYWyciE6mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-t3HvfRD0OuyxH7UyWe0xqg-1; Thu, 24 Jun 2021 15:54:21 -0400
X-MC-Unique: t3HvfRD0OuyxH7UyWe0xqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4882F8030D6;
        Thu, 24 Jun 2021 19:54:20 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8785608BA;
        Thu, 24 Jun 2021 19:54:14 +0000 (UTC)
Date:   Thu, 24 Jun 2021 21:54:11 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     "Desouza, Ederson" <ederson.desouza@intel.com>
Cc:     "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        brouer@redhat.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: A look into XDP hints for AF_XDP
Message-ID: <20210624215411.79324c9d@carbon>
In-Reply-To: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Jun 2021 00:10:12 +0000
"Desouza, Ederson" <ederson.desouza@intel.com> wrote:

> Following current discussions around XDP hints, it's clear that
> currently the focus is on BPF applications. But my interest is in the
> AF_XDP side of things - user space applications.

I agree, that most of the discussion is focused on BPF-programs being
loaded into the kernel via libbpf.  I actually also care about getting
this working for AF_XDP.

We've discussed this with Magnus (meeting yesterday) and I think we
agree that this is also something we want for AF_XDP.  IIRC the plan is
to use one bit to indicate if a packet is carrying info in metadata
area, as (1) AF_XDP descriptor don't have room for storing the BTF-ID,
and (2) if bit is not set, then we can avoid touching that cache-line.
If the bit is set, then the BTF-ID is stored in metadata area
(preferably as the last member, as ctx->data_meta is a minus offset
from ctx->data, making it accessible via a fixed offset from data).

For the BPF-programs it would make sense to store the BTF-ID in
xdp_buff/xdp_frame and make it accessible via xdp_md (ctx seen from
BPF-prog).  To help AF_XDP the *proposal* is to (also) store it in
metadata area itself.


> In there, there's not much help from BPF CO-RE - who's going to rewrite
> user space structs, after all? 

Well, AFAIK most of the offset relocation happens in user-space by
libbpf.  Which Alexei also indicate in the other thread[1]. To better
understand BTF/CO-RE I've coded up an example here[2]. 

 [1] https://lore.kernel.org/bpf/CAADnVQKv5SLBfnBWnEBFqf0-DQv+NZuixGiCVx1hewfQFhHSKg@mail.gmail.com/
 [2] https://github.com/xdp-project/bpf-examples/blob/master/ktrace-CO-RE/ktrace01_kern.c

I'm trying to understand how libbpf does this.  So, I added a --debug
option that makes libbpf print verbose messages. See commit[3] that
also contains output example.

 [3] https://github.com/xdp-project/bpf-examples/commit/0542d8a7a327b642d105

Some of the --debug output:

 libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
 [...]
 libbpf: CO-RE relocating [0] struct sk_buff___local: found target candidate [2965] struct sk_buff in [vmlinux]
 libbpf: prog 'udp_send_skb': relo #1: matching candidate #0 [2965] struct sk_buff.hash (0:55 @ offset 148)
 libbpf: prog 'udp_send_skb': relo #1: patched insn #1 (ALU/ALU64) imm 4 -> 148
 libbpf: prog 'udp_send_skb': relo #2: kind <byte_off> (0), spec is [7] struct sk_buff___local.len (0:0 @ offset 0)
 libbpf: prog 'udp_send_skb': relo #2: matching candidate #0 [2965] struct sk_buff.len (0:6 @ offset 112)
 libbpf: prog 'udp_send_skb': relo #2: patched insn #8 (ALU/ALU64) imm 0 -> 112
 libbpf: prog 'udp_send_skb': relo #3: kind <target_type_id> (7), spec is [7] struct sk_buff___local
 libbpf: prog 'udp_send_skb': relo #3: matching candidate #0 [2965] struct sk_buff
 libbpf: prog 'udp_send_skb': relo #3: patched insn #24 (ALU/ALU64) imm 7 -> 2965

As indicated in [1] a BTF matching is being done in userspace. First
libbpf loads kernels BTF from '/sys/kernel/btf/vmlinux'.  Then it have
the BTF from BPF-prog 'sk_buff___local' which finds target 'struct
sk_buff' as btf_id 2965.  Afterwards it patches the relocations in the
byte code.


> So, I decided to give a try at a possible implementation, using igc
> driver as I'm more used to it, and come here ask some questions about
> it.
> 
> For the curious, here's my branch with current work:
> 
> https://github.com/edersondisouza/linux/tree/xdp-hints
> 
> It's on top of Alexandr Lobakin and Michal Swiatkowski work - but I
> decided to incorporate some of the CO-RE related feedback, so I could
> have something that also works with BPF applications. Please not that
> I'm not trying to jump ahead of them in incorporating the feedback -
> probably they have something more robust here - but if you see some
> value in my patches, feel free to reuse/incorporate them (if they are
> just an example of what not to do, it's still an example =D ).
> I also added some XDP ZC patches for igc that are still moving to
> mainline.
> 
> In there, I basically defined a sample of "generic hints", that is
> basically an struct with common hints, such as RX and TX timestamp,
> hash, etc. I also included two more members to that struct: field_map
> and extension_id. The first, shows which members are actually valid in
> the data, the second is an arbitrary id that drivers can use to say
> "there's extra data" beyond the generic members, and how to interpret
> what's there is driver specific. A BTF is also created to represent
> this struct, and registering is done the same way Saeed's patch did.
> 
> User space developers that need to get the struct can use something
> like to get it from the driver:
> 
>   # tools/bpf/bpftool/bpftool net xdp show
>   xdp:
>   enp6s0(5) md_btf_id(60) md_btf_enabled(1)
> 
> And use the btf_id to get the struct:
> 
>   # bpftool btf dump file /sys/kernel/btf/igc format c
> 
> Currently though, that's bad - as in this case the struct has no
> types, only the field names. Why?

I don't follow, what is not working?

> With the driver specific struct (or by using the generic one, if no
> specific fields are needed), the application can then access the XDP
> frame metadata. I've also added some helpers to aid getting the
> metadata.
> 
> I added some examples on how to use those (they may be too simplistic),
> so it's possible to get a feel on how this API might work.
> 
> My goals for this email are to check if this approach is valid and what
> pitfalls can you see. I didn't send a patch series yet to not jump
> ahead Alexandr and Michal work (I can rebase on top of their work
> later) and because the igc RX and TX timestamp implementation I'm using
> to provide more real looking data is not yet complete.
> 
> Another goal is to ensure that AF_XDP side is not forgotten in the XDP
> hints discussion =D

Thanks for pointing that out :-)

> Naturally, if someone finds any issue trying those patches, please let
> me know!

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

