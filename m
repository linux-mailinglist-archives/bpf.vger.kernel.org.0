Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCC394F11
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 05:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE3D3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 23:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhE3D3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 23:29:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFDC061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 20:27:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 207so1364749ybd.1
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 20:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQ80997LMVKYphwclb+AtTBx9tyRm00pto8wmJzvbyQ=;
        b=NkWuJ2pbgYM6blZkHbbGWa1B+L4pGoeqoo2MAuetr7B2VAlwJotVDovUkrrXzKu/Se
         iCFq7AZ4x/nG/UGxD7J+cLfrOhGSUCTK0OTDOnxHT4kKW3+VIJ2I9fyOwRh95zIWFfOX
         PV4t17zqgXaEtwzOVLxoTzgUBQqdYIzMVpN53+9k78pmGv0UthTTsSF/JT2kfscCsFL3
         EiCKExGg6mRG9PtEV1et1/BLwieDS+vlJMUZvCICk5NRt9U1505sLW4+ZHl6gJdecxUM
         cwHzBEzEbl2LvBcjIYRrPO8QeiWgXxWeYHfISVwGRaAlaBTR04OkXhuAbYUnsTkyJEps
         kK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ80997LMVKYphwclb+AtTBx9tyRm00pto8wmJzvbyQ=;
        b=V7oOiQRtMl5ou59TgVS2o7zLwNOtpKG9BOStxaTA+PPsh8H/K6SNDGa3QzKS2CR584
         +WvsrVKrIRWUa2YPrUXNQUBGKibKHpwOh6WzheWQWHpChuqn3JP2vRbBV2xzTVVTNXyG
         qGJsWtyBBYFB6rxMtC371ZzCCKbkFcUBkNftE5gsEZ0D+ghUWIZcJxMICepV4LBn4gFE
         WGoFDk16G6H362XhXGem3BuEctfwrgH09bNvtyFL1cqgi5Qi8l0r1UtRz7OERB6JaJSP
         L2X7wHxef+lAX6mnZ+vfwKrbnCsUlDBaqpsuFIoPfp7HA41G+LVpFBlrGe3rJjdpc8Wy
         GQdA==
X-Gm-Message-State: AOAM530HHi9KkN2b32PG/eT+i3dVHzGuBkUte6ahjdduItGBzdM4n9BM
        MdmlrYNgVgUSlAg1mBxRcH3FiRGvGqU8y73uHLGQvlar
X-Google-Smtp-Source: ABdhPJw9Vzs86fAleLKKEj+u2qC0BV+cvgRg/PDEoRn+Vahr5m62Z1IQkUduZOL2re/RgJ0Hgq2UTK92WXoaYYg935I=
X-Received: by 2002:a25:1455:: with SMTP id 82mr23033382ybu.403.1622345231158;
 Sat, 29 May 2021 20:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch> <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch> <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch> <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch> <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
In-Reply-To: <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 20:27:00 -0700
Message-ID: <CAEf4Bzaqb=1b4uhU8PaCTW1T+5CwrR4TQNHyLJLZXt=NYtzh8g@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 10:30 AM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Jesper Dangaard Brouer wrote:
>
> [...]
>
> I'll try to respond to both Toke and Jesper here and make it coherent so
> we don't split this thread yet again.
>
> Wish me luck.
>
> @Toke "react" -> "not break" hopefully gives you my opinion on this.
>
> @Toke "five fields gives 32 different metadata formats" OK let me take
> five fields,
>
>  struct meta {
>    __u32 f1;
>    __u32 f2;
>    __u32 f3;
>    __u32 f4;
>    __u32 f5;
>  }
>
> I'm still confused why the meta data would change just because the feature
> is enabled or disabled. I've written drivers before and I don't want to
> move around where I write f1 based on some combination of features f2,f3,f4,f5
> state of enabled/disabled. If features are mutual exclusive I can build a
> sensible union. If its possible for all fields to enabled then I just lay
> them out like above.
>
>
> @Toke "completely reprogramming the NIC" -> sounds like some basic agreement.
>
>
> > > > >> > > union and independent set of BTFs are two different things, I'll let
> > > > >> > > you guys figure out which one you need, but I replied how it could
> > > > >> > > look like in CO-RE world
> > > > >> >
> > > > >> > I think a union is sufficient and more aligned with how the
> > > > >> > hardware would actually work.
> > > > >>
> > > > >> Sure. And I think those are two orthogonal concerns. You can start
> > > > >> with a single struct mynic_metadata with union inside it, and later
> > > > >> add the ability to swap mynic_metadata with another
> > > > >> mynic_metadata___v2 that will have a similar union but with a
> > > > >> different layout.
> > > > >
> > > > > Right and then you just have normal upgrade/downgrade problems with
> > > > > any struct.
> > > > >
> > > > > Seems like a workable path to me. But, need to circle back to the
> > > > > what we want to do with it part that Jesper replied to.
> > > >
> > > > So while this seems to be a viable path for getting libbpf to do all the
> > > > relocations (and thanks for hashing that out, I did not have a good grip
> > > > of the details), doing it all in userspace means that there is no way
> > > > for the XDP program to react to changes once it has been loaded. So this
> > > > leaves us with a selection of non-very-attractive options, IMO. I.e.,
> > > > we would have to:
>
>
> > >
> > > I don't really understand what this means 'having XDP program to
> > > react to changes once it has been loaded.' What would a program look
> > > like thats dynamic? You can always version your metadata and
> > > write programs like this,
> > >
> > >   if (meta->version == VERSION1) {do_foo}
> > >   else {do_bar}
> > >
> > > And then have a headeer,
> > >
> > >    struct meta {
> > >      int version;
> > >      union ...    // union of versions
> > >    }
> > >
> > > I fail to see how a program could 'react' dynamically. An agent could
> > > load new programs dynamically into tail call maps of fentry with
> > > the need handlers, which would work as well and avoid unions.
> > >
> > > >
> > > > - have to block any modifications to the hardware config that would
> > > >   change the metadata format; this will probably result in irate users
> > >
> > > I'll need a concrete example if I swap out my parser block, I should
> > > also swap out my BPF for my shiny new protocol. I don't see how a
> > > user might write programs for things they've not configured hardware
> > > for yet. Leaving aside knobs like VLAN on/off, VXLAN on/off, and
> > > such which brings the next point.
> > >
> > > >
> > > > - require XDP programs to deal with all possible metadata permutations
> > > >   supported by that driver (by exporting them all via a BTF union or
> > > >   similar); this means a potential for combinatorial explosion of config
> > > >   options and as NICs become programmable themselves I'm not even sure
> > > >   if it's possible for the driver to know ahead of time
> > >
> > > I don't see the problem sorry. For current things that exist I can't
> > > think up too many fields vlan, timestamp, checksum(?), pkt_type,
> > > hash maybe.
> > >
> > > For programmable pipelines (P4) then I don't see a problem with
> > > reloading your program or swapping out a program. I don't see the
> > > value of adding a new protocol for example dynamically. Surely
> > > the hardware is going to get hit with a big reset anyways.
> > >
> > > >
> > > > - throw up our hands and just let the user deal with it (i.e., to
> > > >   nothing and so require XDP programs to be reloaded if the NIC config
> > > >   changes); this is not very friendly and is likely to lead to subtle
> > > >   bugs if an XDP program parses the metadata assuming it is in a
> > > >   different format than it is
> > >
> > > I'm not opposed to user error causing logic bugs.  If I give
> > > users power to reprogram their NICs they should be capabable
> > > of managing a few BPF programs. And if not then its a space
> > > where a distro/vendor should help them with tooling.
> > >
> > > >
> > > > Given that hardware config changes are not just done by ethtool, but
> > > > also by things like running `tcpdump -j`, I really think we have to
> > > > assume that they can be quite dynamic; which IMO means we have to solve
> > > > this as part of the initial design. And I have a hard time seeing how
> > > > this is possible without involving the kernel somehow.
> > >
> > > I guess here your talking about building an skb? Wouldn't it
> > > use whatever logic it uses today to include the timestamp.
> > > This is a bit of an aside from metadata in the BPF program.
> > >
> > > Building timestamps into
> > > skbs doesn't require BPF program to have the data. Or maybe
> > > the point is an XDP variant of tcpdump would like timestamps.
> > > But then it should be in the metadata IMO.
> >
> > It sounds like we are all agreeing that the HW RX timestamp should be
> > stored in the XDP-metadata area right?
> >
> > As I understand, John don't like multiple structs, but want a single
> > struct, so lets create below simple struct that the driver code fills
> > out before calling our XDP-prog:
> >
> >  struct meta {
> >       u32 timestamp_type;
> >       u64 rx_timestamp;
> >       u32 rxhash32;
> >       u32 version;
> >  };
>
> From driver side I don't think you want to dynamically move around
> fields too much. Meaning when feature X is enabled I write it in
> some offset and then when X+Y is enabled I write into another offset.
> This adds complexity on driver side and likely makes said driver
> slower due to complexity.
>
> Perhaps exception to above is on pkt_type where its natural to
> have hardware engine write different fields, but that fits
> naturally into a union around pkt_types.
>
> >
> > This NIC is configured for PTP, but hardware can only do rx_timestamp
> > for PTP packets (like ixgbe).  (Assume both my XDP-prog and PTP
> > userspace prog want to see this HW TS).
> >
> > What should I do as a driver developer to tell XDP-prog that the HW
> > rx_timestamp is not valid for this packet ?
>
> Driver developer should do nothing. When enable write it into rx_timestamp.
> When disabled don't. Keep the drivers as simple as possible and don't
> make the problem hard.
>
> >
> >  1. Always clear 'rx_timestamp' + 'timestamp_type' for non-PTP packets?
> >  2. or, set version to something else ?
> >
> > I don't like option 1, because it will slowdown the normal none-PTP
> > packets, that doesn't need this timestamp.
> >
>
> 1, no and 2, no. When timestamps are wanted just set a global variable
> in the program. From XDP program,
>
>   if (rx_timestamp_enabled) {
>      meta->timestamp;  // do something
>   } else {
>      meta->timestamp = bpf_get_timestamp(); // software fallback if you want
>   }
>
> then when userspace enables the timestamp through whatever means it
> has to do this it also sets 'rx_timestamp_enabled = true' which can
> be done today no problem.
>
> Now its up to hardware and user to build something coherent. You
> don't need me to agree with you that its useful to add timestamps you
> have all the tools you need to do it. Presumably the user buys the
> hardware so they can buy whats most useful for them.
>
> >
> >
> > Now I want to redirect this packet into a veth.  The veth device could
> > be running an XDP-prog, that also want to look at this timestamp info.
> > How can the veth XDP-prog know howto interpret metadata area. What if I
> > stored the bpf_id in the version fields in the struct?.
>
> Well presumably someone is managing the system so with above XDP prog
> on real nic could just populate the metadata with software if needed
> and veth would not care if it came from hardware or software. Or
> use same fallback trick with global variable.
>
> >
> > (Details: I also need this timestamp info transferred to xdp_frame,
> > because when redirecting into a veth (container) then I want this
> > timestamp set on the SKB to survive. I wonder how can I know what the
> > BTF-layout, guess it would be useful to have btf_id at this point)
>
> Why do you need to know the layout? Just copy the metadata. The core
> infrastructure can not know the layout or we are back to being
> gate-keepers of hardware features.
>
> >
> > > >
> > > > Unless I'm missing something? WDYT?
> > >
> > > Distilling above down. I think we disagree on how useful
> > > dynamic programs are because of two reasons. First I don't
> > > see a large list of common attributes that would make the
> > > union approach as painful as you fear. And two, I believe
> > > users who are touching core hardware firmware need to also
> > > be smart enough (or have smart tools) to swap out their
> > > BPF programs in the correct order so as to not create
> > > subtle races. I didn't do it here but if we agree walking
> > > through that program swap flow with firmware update would
> > > be useful.
> >
> > Hmm, I sense we are perhaps talking past each-other(?).  I am not
> > talking about firmware upgrades.  I'm arguing that enable/disable of HW
> > RX-timestamps will change the XDP-metadata usage dynamically runtime.
> > This is simply a normal userspace program that cause this changes e.g.
> > running 'tcpdump -j'.
>
> I'm not sure why it would change the layout. The hardware is going
> to start writing completely different metadata? If so just pivot
> on a global value like above with two structs.
>
>   if (timestamp_enabled) {
>     struct timestamp_meta *meta = data->meta_data;
>     // do stuff
>   } else {
>     struct normal_meta *meta = data->meta_data;
>   }
>
> The powerful part of above is you have all the pieces you need today
> sans exporting a couple internal libbpf calls, but that should
> be doable. Although Andrii would probably object to such a ugly
> hack so a proper API would be nice. But, again not strictly needed

Of course I would :) But I had the ability to specify custom vmlinux
BTF in libbpf (through bpf_object__load_xattr) from the very beginning
(at least for testing purposes), though it bit-rotted a bit with all
the further BTF-enabled features. But I'm all for cleaning that up and
formalizing the ability to specify alternative vmlinux BTF and/or
additional external BTF.

> to get above working.
>
> Addressing Tokes example which I think is the same, Instead of building
> a metadata struct like this,
>
>  struct meta {
>   u32 rxhash;
>   u8 vlan;
>  };
>
> Use the second example as your metadata always
>
>  struct meta {
>    u32 rxhash;
>    u32 timestamp;
>    u8 vlan;
>  };
>
> Then pivot on what to do with that timestamp using a global variable or
> map or any of the other ways we do features dynamically in kprobes and
> other prog types.
>
> Thanks,
> John
