Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC03BF214
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhGGW3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhGGW3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 18:29:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B6C061574
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:27:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o139so5654525ybg.9
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpUE1NQZWjpFLfko9bn7MhifV3D6weuHRb1lwduB7lo=;
        b=eR90/7i7WESJ+/bgGjPH9LC52UB5IJgXbPthsZsc46DJQbowQlvjfl26Fi0C+BV0HQ
         Sws2RxnCsaevc/21DTuTMoK2dtBK0jJ/x2xDZDNgxITXY5/seA11JJJbEMPFg2WI98F0
         k1681mbN4FxVSlq2hWAJKGoWGCykr2lp0efwLTXD8NBVx1mi/Hj0iFgfpj4OPot3aKhJ
         kS7aJ0yrCKHDxwypc8Cc/UE7QhUJh9ktRoS1FqyeuOSjdlDSIveSb0H+kmqRdqQ81yIO
         isQ6Bcd1AAzDjDLIswHLadO5vbl8WqD77ZukL5m8w9+ZbUTCHWZwLGDqcqz60sUJfGh5
         jE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpUE1NQZWjpFLfko9bn7MhifV3D6weuHRb1lwduB7lo=;
        b=jNuQYcmVU2QS32OwVcAhLtRbnSROto6iZDl2b5LP3uLBT/DJVwAZ6wrkrvv7drKvZg
         ELbebGLdCyVRJ0kpQAIrWuD4F0KWPR44zR5YNgb0Eg75uy+LvoKjM65yTPEBGLDyM0ME
         Hq6gLUfKIf18BNBRAy0RK2GsDQLxTDyMQEk9ZNs0oroUL4ugpmqukMMck7YYnBSxyn31
         g1BtMaFmH90DUjlhsQMkkU6itybPoSXJubiBQMgousN9+aEvQKWUm9qtKW3OY99Ck2nt
         B0PR/1J9Q5IULqUHpDaOd9aZPpcrViU/31bQGYrMtGRQjtXx8Viz6XeOZF1/+a3nXJqw
         WmNQ==
X-Gm-Message-State: AOAM532lTJPO5UOhpik3BpQP7yX+HDgVdIiArRe5Brss/OrvqH0Q7V5e
        9TtVon7CihijWpqNK6W9xLyFwetuQZ/nX11rA1Y=
X-Google-Smtp-Source: ABdhPJwwBSWIEmtfv4smqZau6L3Zopj0cOYO4pRPh14W83LUa7++A+JMPx42lQFU/pnsOH1ZqmASauOdnq/OnlCciOA=
X-Received: by 2002:a25:bd09:: with SMTP id f9mr36677148ybk.27.1625696820381;
 Wed, 07 Jul 2021 15:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
 <20210624215411.79324c9d@carbon> <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
In-Reply-To: <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 15:26:49 -0700
Message-ID: <CAEf4BzYHZRRGTwMswAUrtcpSyox_-5p1yMDwf21oK7tBCqViZA@mail.gmail.com>
Subject: Re: A look into XDP hints for AF_XDP
To:     "Desouza, Ederson" <ederson.desouza@intel.com>
Cc:     "brouer@redhat.com" <brouer@redhat.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 2:54 PM Desouza, Ederson
<ederson.desouza@intel.com> wrote:
>
> On Thu, 2021-06-24 at 21:54 +0200, Jesper Dangaard Brouer wrote:
> > On Thu, 24 Jun 2021 00:10:12 +0000
> > "Desouza, Ederson" <ederson.desouza@intel.com> wrote:
> >
> > > Following current discussions around XDP hints, it's clear that
> > > currently the focus is on BPF applications. But my interest is in the
> > > AF_XDP side of things - user space applications.
> >
> > I agree, that most of the discussion is focused on BPF-programs being
> > loaded into the kernel via libbpf.  I actually also care about getting
> > this working for AF_XDP.
> >
> > We've discussed this with Magnus (meeting yesterday) and I think we
> > agree that this is also something we want for AF_XDP.  IIRC the plan is
> > to use one bit to indicate if a packet is carrying info in metadata
> > area, as (1) AF_XDP descriptor don't have room for storing the BTF-ID,
> > and (2) if bit is not set, then we can avoid touching that cache-line.
> > If the bit is set, then the BTF-ID is stored in metadata area
> > (preferably as the last member, as ctx->data_meta is a minus offset
> > from ctx->data, making it accessible via a fixed offset from data).
> >
> > For the BPF-programs it would make sense to store the BTF-ID in
> > xdp_buff/xdp_frame and make it accessible via xdp_md (ctx seen from
> > BPF-prog).  To help AF_XDP the *proposal* is to (also) store it in
> > metadata area itself.
> >
> >
> > > In there, there's not much help from BPF CO-RE - who's going to rewrite
> > > user space structs, after all?
> >
> > Well, AFAIK most of the offset relocation happens in user-space by
> > libbpf.  Which Alexei also indicate in the other thread[1]. To better
> > understand BTF/CO-RE I've coded up an example here[2].
> >
> >  [1] https://lore.kernel.org/bpf/CAADnVQKv5SLBfnBWnEBFqf0-DQv+NZuixGiCVx1hewfQFhHSKg@mail.gmail.com/
> >  [2] https://github.com/xdp-project/bpf-examples/blob/master/ktrace-CO-RE/ktrace01_kern.c
> >
> > I'm trying to understand how libbpf does this.  So, I added a --debug
> > option that makes libbpf print verbose messages. See commit[3] that
> > also contains output example.
> >
> >  [3] https://github.com/xdp-project/bpf-examples/commit/0542d8a7a327b642d105
> >
> > Some of the --debug output:
> >
> >  libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> >  [...]
> >  libbpf: CO-RE relocating [0] struct sk_buff___local: found target candidate [2965] struct sk_buff in [vmlinux]
> >  libbpf: prog 'udp_send_skb': relo #1: matching candidate #0 [2965] struct sk_buff.hash (0:55 @ offset 148)
> >  libbpf: prog 'udp_send_skb': relo #1: patched insn #1 (ALU/ALU64) imm 4 -> 148
> >  libbpf: prog 'udp_send_skb': relo #2: kind <byte_off> (0), spec is [7] struct sk_buff___local.len (0:0 @ offset 0)
> >  libbpf: prog 'udp_send_skb': relo #2: matching candidate #0 [2965] struct sk_buff.len (0:6 @ offset 112)
> >  libbpf: prog 'udp_send_skb': relo #2: patched insn #8 (ALU/ALU64) imm 0 -> 112
> >  libbpf: prog 'udp_send_skb': relo #3: kind <target_type_id> (7), spec is [7] struct sk_buff___local
> >  libbpf: prog 'udp_send_skb': relo #3: matching candidate #0 [2965] struct sk_buff
> >  libbpf: prog 'udp_send_skb': relo #3: patched insn #24 (ALU/ALU64) imm 7 -> 2965
> >
> > As indicated in [1] a BTF matching is being done in userspace. First
> > libbpf loads kernels BTF from '/sys/kernel/btf/vmlinux'.  Then it have
> > the BTF from BPF-prog 'sk_buff___local' which finds target 'struct
> > sk_buff' as btf_id 2965.  Afterwards it patches the relocations in the
> > byte code.
> >
>
> Hmmm... that's something I definitely want to try =D
>
> >
> > > So, I decided to give a try at a possible implementation, using igc
> > > driver as I'm more used to it, and come here ask some questions about
> > > it.
> > >
> > > For the curious, here's my branch with current work:
> > >
> > > https://github.com/edersondisouza/linux/tree/xdp-hints
> > >
> > > It's on top of Alexandr Lobakin and Michal Swiatkowski work - but I
> > > decided to incorporate some of the CO-RE related feedback, so I could
> > > have something that also works with BPF applications. Please not that
> > > I'm not trying to jump ahead of them in incorporating the feedback -
> > > probably they have something more robust here - but if you see some
> > > value in my patches, feel free to reuse/incorporate them (if they are
> > > just an example of what not to do, it's still an example =D ).
> > > I also added some XDP ZC patches for igc that are still moving to
> > > mainline.
> > >
> > > In there, I basically defined a sample of "generic hints", that is
> > > basically an struct with common hints, such as RX and TX timestamp,
> > > hash, etc. I also included two more members to that struct: field_map
> > > and extension_id. The first, shows which members are actually valid in
> > > the data, the second is an arbitrary id that drivers can use to say
> > > "there's extra data" beyond the generic members, and how to interpret
> > > what's there is driver specific. A BTF is also created to represent
> > > this struct, and registering is done the same way Saeed's patch did.
> > >
> > > User space developers that need to get the struct can use something
> > > like to get it from the driver:
> > >
> > >   # tools/bpf/bpftool/bpftool net xdp show
> > >   xdp:
> > >   enp6s0(5) md_btf_id(60) md_btf_enabled(1)
> > >
> > > And use the btf_id to get the struct:
> > >
> > >   # bpftool btf dump file /sys/kernel/btf/igc format c
> > >
> > > Currently though, that's bad - as in this case the struct has no
> > > types, only the field names. Why?
> >
> > I don't follow, what is not working?
>
> I get something like this:
>
>   struct xdp_hints {
>          yet_another_timestamp;
>          rx_timestamp;
>          tx_timestamp;
>          hash32;
>          extension_id;
>          field_map;
>   };

it could be due to corrupted BTF. Can you show output of

bpftool btf dump file /sys/kernel/btf/igc

(note no "format c").

>
> Note how there's no type before the fields, one has to figure out if
> `rx_timestamp` is u32 or u64.
>
>
> >
> > > With the driver specific struct (or by using the generic one, if no
> > > specific fields are needed), the application can then access the XDP
> > > frame metadata. I've also added some helpers to aid getting the
> > > metadata.
> > >
> > > I added some examples on how to use those (they may be too simplistic),
> > > so it's possible to get a feel on how this API might work.
> > >
> > > My goals for this email are to check if this approach is valid and what
> > > pitfalls can you see. I didn't send a patch series yet to not jump
> > > ahead Alexandr and Michal work (I can rebase on top of their work
> > > later) and because the igc RX and TX timestamp implementation I'm using
> > > to provide more real looking data is not yet complete.
> > >
> > > Another goal is to ensure that AF_XDP side is not forgotten in the XDP
> > > hints discussion =D
> >
> > Thanks for pointing that out :-)
> >
> > > Naturally, if someone finds any issue trying those patches, please let
> > > me know!
> >
>
