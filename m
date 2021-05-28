Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E34394668
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhE1Rbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhE1Rbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 13:31:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E1C061574
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 10:30:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v9so4938566ion.11
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MOZ6esETDuANvmzlYvhqBWyBOkNmf2Ivc1WPy2Zxxdk=;
        b=XF4acHkV/Z52JVxOa0dmrLMuqYkc35tpdyAVSSQN87amFT8pgsPjT/ycZ0A7qFvG2M
         NdLkTbsgH8ZJlQEwEw3dXukvxK9/8+aXsjMN1PwsGpzOetLM0CaflFvELMaV3YcI0rUh
         rUaxmF6mrTT4NCy4PJdgg/U03QyAXx2BacdER3YJNfUGFDCHOMXQ8A+8EFOtWZxkxnov
         V+OQgRlv84pOb4+ZDMG5QB1vfN2plpEPynZPOyO//NwqanuMOq/4L3UCAeRvwct0AHtp
         QP/Nm0Nl+omiCIEeWdjFsVfTPPbmfvckZ4qJRr5BTtM0kU/X/U1d2fMG3TDlWmWZuqIt
         Mltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MOZ6esETDuANvmzlYvhqBWyBOkNmf2Ivc1WPy2Zxxdk=;
        b=b43l0B21KVVF+s+iIp23bwoAATWLZlZ5JHKFQJnd0nS17Z2Dm6qptXxlZgznZKW/HT
         f78c1SfJh17JFvewG8ESb+D1mqpOPgSTvfVtImx37hOQDKYSZRoQYpFzr5i3AkLe0PxC
         JdJBXAyZ9m+ZmIAKgGz+fhXHEYRLEXjmFcccCH0ZWNitNaQ44vyzpIxdZkirzWuPl/DD
         cc3nj1ygFa6BArdzXP+DmyWjio5B+V+NGOnuuWIqkHReWCW56pl0RZIly87KM4ze17rR
         askSlyrux+uMVI1x3p6VDCvg3dU6no8vXt+reruRkHBpDYrfRIItEja7bKF0AZJpoqOh
         qS3w==
X-Gm-Message-State: AOAM5303aQ6T+eXZE22ReyaADXzcUQq3uYVGnyCPr+zROewFdNH+Dhab
        nMO+k2JxrrmPvAaJjT2jlw0=
X-Google-Smtp-Source: ABdhPJzEtLFqRYJIsCuhm0lDi9cMQwMyYJ0gTIz4noAbIEzZir1aZ/SZTT3z3W9rjbq9zNsIh9UICQ==
X-Received: by 2002:a5d:9c9a:: with SMTP id p26mr7971771iop.94.1622223008667;
        Fri, 28 May 2021 10:30:08 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id l1sm1863898ilc.66.2021.05.28.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:30:08 -0700 (PDT)
Date:   Fri, 28 May 2021 10:29:59 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        brouer@redhat.com
Message-ID: <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
In-Reply-To: <20210528180214.3b427837@carbon>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer wrote:

[...]

I'll try to respond to both Toke and Jesper here and make it coherent so
we don't split this thread yet again.

Wish me luck.

@Toke "react" -> "not break" hopefully gives you my opinion on this.

@Toke "five fields gives 32 different metadata formats" OK let me take
five fields,

 struct meta {
   __u32 f1;
   __u32 f2;
   __u32 f3;
   __u32 f4;
   __u32 f5;
 }

I'm still confused why the meta data would change just because the feature
is enabled or disabled. I've written drivers before and I don't want to
move around where I write f1 based on some combination of features f2,f3,f4,f5
state of enabled/disabled. If features are mutual exclusive I can build a
sensible union. If its possible for all fields to enabled then I just lay
them out like above.


@Toke "completely reprogramming the NIC" -> sounds like some basic agreement.


> > > >> > > union and independent set of BTFs are two different things, I'll let
> > > >> > > you guys figure out which one you need, but I replied how it could
> > > >> > > look like in CO-RE world  
> > > >> >
> > > >> > I think a union is sufficient and more aligned with how the
> > > >> > hardware would actually work.  
> > > >> 
> > > >> Sure. And I think those are two orthogonal concerns. You can start
> > > >> with a single struct mynic_metadata with union inside it, and later
> > > >> add the ability to swap mynic_metadata with another
> > > >> mynic_metadata___v2 that will have a similar union but with a
> > > >> different layout.  
> > > >
> > > > Right and then you just have normal upgrade/downgrade problems with
> > > > any struct.
> > > >
> > > > Seems like a workable path to me. But, need to circle back to the
> > > > what we want to do with it part that Jesper replied to.  
> > > 
> > > So while this seems to be a viable path for getting libbpf to do all the
> > > relocations (and thanks for hashing that out, I did not have a good grip
> > > of the details), doing it all in userspace means that there is no way
> > > for the XDP program to react to changes once it has been loaded. So this
> > > leaves us with a selection of non-very-attractive options, IMO. I.e.,
> > > we would have to:  


> > 
> > I don't really understand what this means 'having XDP program to
> > react to changes once it has been loaded.' What would a program look
> > like thats dynamic? You can always version your metadata and
> > write programs like this,
> > 
> >   if (meta->version == VERSION1) {do_foo}
> >   else {do_bar}
> > 
> > And then have a headeer,
> > 
> >    struct meta {
> >      int version;
> >      union ...    // union of versions
> >    }
> > 
> > I fail to see how a program could 'react' dynamically. An agent could
> > load new programs dynamically into tail call maps of fentry with
> > the need handlers, which would work as well and avoid unions.
> > 
> > > 
> > > - have to block any modifications to the hardware config that would
> > >   change the metadata format; this will probably result in irate users  
> > 
> > I'll need a concrete example if I swap out my parser block, I should
> > also swap out my BPF for my shiny new protocol. I don't see how a
> > user might write programs for things they've not configured hardware
> > for yet. Leaving aside knobs like VLAN on/off, VXLAN on/off, and
> > such which brings the next point.
> > 
> > > 
> > > - require XDP programs to deal with all possible metadata permutations
> > >   supported by that driver (by exporting them all via a BTF union or
> > >   similar); this means a potential for combinatorial explosion of config
> > >   options and as NICs become programmable themselves I'm not even sure
> > >   if it's possible for the driver to know ahead of time  
> > 
> > I don't see the problem sorry. For current things that exist I can't
> > think up too many fields vlan, timestamp, checksum(?), pkt_type,
> > hash maybe.
> > 
> > For programmable pipelines (P4) then I don't see a problem with
> > reloading your program or swapping out a program. I don't see the
> > value of adding a new protocol for example dynamically. Surely
> > the hardware is going to get hit with a big reset anyways.
> > 
> > > 
> > > - throw up our hands and just let the user deal with it (i.e., to
> > >   nothing and so require XDP programs to be reloaded if the NIC config
> > >   changes); this is not very friendly and is likely to lead to subtle
> > >   bugs if an XDP program parses the metadata assuming it is in a
> > >   different format than it is  
> > 
> > I'm not opposed to user error causing logic bugs.  If I give
> > users power to reprogram their NICs they should be capabable
> > of managing a few BPF programs. And if not then its a space
> > where a distro/vendor should help them with tooling.
> > 
> > > 
> > > Given that hardware config changes are not just done by ethtool, but
> > > also by things like running `tcpdump -j`, I really think we have to
> > > assume that they can be quite dynamic; which IMO means we have to solve
> > > this as part of the initial design. And I have a hard time seeing how
> > > this is possible without involving the kernel somehow.  
> > 
> > I guess here your talking about building an skb? Wouldn't it
> > use whatever logic it uses today to include the timestamp.
> > This is a bit of an aside from metadata in the BPF program.
> > 
> > Building timestamps into
> > skbs doesn't require BPF program to have the data. Or maybe
> > the point is an XDP variant of tcpdump would like timestamps.
> > But then it should be in the metadata IMO.
> 
> It sounds like we are all agreeing that the HW RX timestamp should be
> stored in the XDP-metadata area right? 
> 
> As I understand, John don't like multiple structs, but want a single
> struct, so lets create below simple struct that the driver code fills
> out before calling our XDP-prog:
> 
>  struct meta {
> 	u32 timestamp_type;
> 	u64 rx_timestamp;
> 	u32 rxhash32;
> 	u32 version;
>  };

From driver side I don't think you want to dynamically move around
fields too much. Meaning when feature X is enabled I write it in
some offset and then when X+Y is enabled I write into another offset.
This adds complexity on driver side and likely makes said driver
slower due to complexity.

Perhaps exception to above is on pkt_type where its natural to
have hardware engine write different fields, but that fits
naturally into a union around pkt_types.

> 
> This NIC is configured for PTP, but hardware can only do rx_timestamp
> for PTP packets (like ixgbe).  (Assume both my XDP-prog and PTP
> userspace prog want to see this HW TS).
> 
> What should I do as a driver developer to tell XDP-prog that the HW
> rx_timestamp is not valid for this packet ?

Driver developer should do nothing. When enable write it into rx_timestamp.
When disabled don't. Keep the drivers as simple as possible and don't
make the problem hard.

> 
>  1. Always clear 'rx_timestamp' + 'timestamp_type' for non-PTP packets?
>  2. or, set version to something else ?
> 
> I don't like option 1, because it will slowdown the normal none-PTP
> packets, that doesn't need this timestamp.
> 

1, no and 2, no. When timestamps are wanted just set a global variable
in the program. From XDP program,

  if (rx_timestamp_enabled) {
     meta->timestamp;  // do something
  } else {
     meta->timestamp = bpf_get_timestamp(); // software fallback if you want
  }

then when userspace enables the timestamp through whatever means it
has to do this it also sets 'rx_timestamp_enabled = true' which can
be done today no problem.

Now its up to hardware and user to build something coherent. You
don't need me to agree with you that its useful to add timestamps you
have all the tools you need to do it. Presumably the user buys the
hardware so they can buy whats most useful for them.

> 
> 
> Now I want to redirect this packet into a veth.  The veth device could
> be running an XDP-prog, that also want to look at this timestamp info.
> How can the veth XDP-prog know howto interpret metadata area. What if I
> stored the bpf_id in the version fields in the struct?.

Well presumably someone is managing the system so with above XDP prog
on real nic could just populate the metadata with software if needed
and veth would not care if it came from hardware or software. Or
use same fallback trick with global variable.

> 
> (Details: I also need this timestamp info transferred to xdp_frame,
> because when redirecting into a veth (container) then I want this
> timestamp set on the SKB to survive. I wonder how can I know what the
> BTF-layout, guess it would be useful to have btf_id at this point)

Why do you need to know the layout? Just copy the metadata. The core
infrastructure can not know the layout or we are back to being
gate-keepers of hardware features.

> 
> > > 
> > > Unless I'm missing something? WDYT?  
> > 
> > Distilling above down. I think we disagree on how useful
> > dynamic programs are because of two reasons. First I don't
> > see a large list of common attributes that would make the
> > union approach as painful as you fear. And two, I believe
> > users who are touching core hardware firmware need to also
> > be smart enough (or have smart tools) to swap out their
> > BPF programs in the correct order so as to not create
> > subtle races. I didn't do it here but if we agree walking
> > through that program swap flow with firmware update would
> > be useful.
> 
> Hmm, I sense we are perhaps talking past each-other(?).  I am not
> talking about firmware upgrades.  I'm arguing that enable/disable of HW
> RX-timestamps will change the XDP-metadata usage dynamically runtime.
> This is simply a normal userspace program that cause this changes e.g.
> running 'tcpdump -j'.

I'm not sure why it would change the layout. The hardware is going
to start writing completely different metadata? If so just pivot
on a global value like above with two structs.

  if (timestamp_enabled) {
    struct timestamp_meta *meta = data->meta_data;
    // do stuff
  } else {
    struct normal_meta *meta = data->meta_data;
  }

The powerful part of above is you have all the pieces you need today
sans exporting a couple internal libbpf calls, but that should
be doable. Although Andrii would probably object to such a ugly
hack so a proper API would be nice. But, again not strictly needed
to get above working.

Addressing Tokes example which I think is the same, Instead of building
a metadata struct like this,

 struct meta {
  u32 rxhash;
  u8 vlan;
 };

Use the second example as your metadata always

 struct meta {
   u32 rxhash;
   u32 timestamp;
   u8 vlan;
 };

Then pivot on what to do with that timestamp using a global variable or
map or any of the other ways we do features dynamically in kprobes and
other prog types.

Thanks,
John
