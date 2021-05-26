Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC55391332
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhEZI74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhEZI7x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:59:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDAAC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 01:58:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x18so431836pfi.9
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nf0o14otEwb6UCKidmoF6TW9ZvMZTTtWXjgyRWaTqjk=;
        b=E86wxzhn8uKjeMf/lN+n4pFbcligMmyMO0IACbh1s3/Dx6wO9GzpQcb3pqxnMHmaUK
         jLkKvYh8e0KIXkvnM4EOJTWwL48Fm6RZjKOywARqGDO54DB64kQu082sxEAzTUWi98iR
         n0Fh8L89Mm+LUVCsYWbneue7A7vzv9E8C+HWRnF0zRbKTTliSvvCHUp3L4IZ8rK/Vuw3
         Jkit+2iaPbr8shVlveWhYFqCTqmxthdp5A80BKDcRsxzDaZeV0sjKiu/8MBl8gufw2BG
         lahUvICxm0tvi2gm1siQ/492ahvMq2IPocsXgGV+W8t1nAUJY8+oPTPvMtKMIu3IVjPr
         yLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf0o14otEwb6UCKidmoF6TW9ZvMZTTtWXjgyRWaTqjk=;
        b=VvZNEM2/5a1l40xCEKyXZBlSxYiekCipkF+mhw3MG2HhEdUFlPI64yuYcxTNkCzvQC
         t6aGW8ecFqVCPf3ha0VVQAuSK0PMcAQapDEuW6/WVJZYF4A+PVMDAktr/mSRvoMiGw5d
         nV18LKXLzU4WVPNs8nqy1BlZEU9ru40bUItDCphq1e4MelojY5QVTAqE7/sU0M2J3ZAT
         xO8RTddBvUy6oHO0JbOke7v7bU5917kVi4L8npDSqFKMGR8u/cWLZeC/P3WFRidLsyWL
         GLBKagcF9pDtuopU3ZpVflfA4JGrCoVV5jVxfcJ2DxbRrFs5G8dtNoD/y6JVlFhlVVXR
         ZSqA==
X-Gm-Message-State: AOAM533cEou5HuwaeJtws95pWUJKNly7mqq/lj6YaEQyEkN4dSqylq4N
        1jN10ZGHyx9ChcszpZw4jN1A+QUbMRgjeTuC82o=
X-Google-Smtp-Source: ABdhPJyxyEQkU5iFCWcPIHkiCkdWdYkFBwXXNmrVHUu2f92rJg3PHNecu20Kue7EzFDmvsUAQnaVVsy65UYuXoFupvQ=
X-Received: by 2002:aa7:9a4b:0:b029:2db:2fe9:e73e with SMTP id
 x11-20020aa79a4b0000b02902db2fe9e73emr35146831pfj.73.1622019499753; Wed, 26
 May 2021 01:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210525121637.46fcdebe@carbon> <DM6PR11MB4593177EE3BBA8E4E2C7CC2BF7259@DM6PR11MB4593.namprd11.prod.outlook.com>
 <20210526102819.04b99ae0@carbon>
In-Reply-To: <20210526102819.04b99ae0@carbon>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 26 May 2021 10:58:08 +0200
Message-ID: <CAJ8uoz0_h2Hqt5HYMEdeGXUjUKyOGLR48h_N37q=5KRpdtZ5xg@mail.gmail.com>
Subject: Re: XDP-hints: Storing some bits in XDP metadata and others in
 xdp_frame/xdp-buff (was: Checksum for xdp_frame)
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 10:29 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
>
> (Cc. upstream bpf-list as Magnus brought up a good question and
> important AF_XDP view-point)
>
> On Tue, 25 May 2021 12:40:03 +0000
> "Karlsson, Magnus" <magnus.karlsson@intel.com> wrote:
>
> > > -----Original Message-----
> > > From: Jesper Dangaard Brouer <brouer@redhat.com>
> > > Subject: Fwd: Checksum for xdp_frame
> > >
> > > The important part is this commit by Ahern:
> > > [1] https://github.com/dsahern/linux/commit/b6b4d4ef9562383d8b407a873d30
> > >
> > > The patch use bitfields, which we now know is a bad idea for performance,
> > > so that needs to change.
>
> We were discussing above patch [1].  That implement CHECKSUM_UNNECESSARY
> HW indication, by storing two-bits in xdp_buff, that is later
> transferred to xdp_frame, which use them to populate skb->ip_summed.
> (Plan is for Lorenzo to continue this work).
>
> Measurements[2] show a need for this.
>  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame01_checksum.org
>
> > [...]
> >
> > Some initial thoughts from an AF_XDP point of view. For every one of
> > these "metadata" items being it IP checksumed, Rx/Tx timestamps,
> > packet continues in next buffer, VLAN id, RSS hash, etc. we can pick
> > one of these methods:
> >
> > 1: Put it in the XDP metadata section before the packet. Good since
> > it requires no intervention to convert this to AF_XDP and it is
> > large. AF_XDP uses exactly the same metadata section as XDP. The
> > drawback here might be that we touch a new cache line unless we play
> > with headroom so that it is located on the same cache line as the
> > start of the packet (and use that too).
> >
> > 2: We put it in the struct xdp_buff which is invisible to user space
> > and therefore must be copied out to either the XDP metadata section
> > or to the __u32 options field in the AF_XDP Rx descriptor. As we add
> > stuff to the xdp_buff, this will become a scalability problem and we
> > will create a mini skb. Moreover, we only have space for 32 bits of
> > information in the AF_XDP Rx options field and in contrast to the
> > xdp_buff, we can never increase this, so AF_XDP needs to put things
> > in the XDP metadata section sooner or later. The only advantage with
> > this approach is that if we put the item in the options field, this
> > will be fast since it will very likely be in the L1 cache. But since
> > it is only 32 bits, we have to pick what goes in the options field
> > very carefully.
> >
> > One thing I think should go into the options field is the
> > multi-buffer flag in Lorenzos multi-buffer patch set since that has
> > to be checked all the time in multi-buffer mode and it has to do with
> > frames/descriptors composing a packet. (multi_buffer is a property on
> > each descriptor/frame, while ip_checksummed is a property on the
> > packet but not each descriptor.) But for all the rest, I think we
> > should use the XDP metadata field. I have not read David's mail, but
> > what is the argument for having ip_checksummed in the xdp_buff? Why
> > not any of the other metadata items that could be equally or more
> > important for my app? Putting it in the XDP metadata requires a lot
> > of plumbing before we can realize #1 so that is one good short-term
> > argument for #2. But I think we need to take the step towards XDP
> > metadata now. #2 is not a scalable approach, not even for the
> > xdp_buff. Opinions? What am I missing?
>
> Thanks for framing the issue/dilemma very accurately.
>
> My perspective is converting xdp_frame into SKB, where we *also* need
> some of these HW-hints.  This is very easy with method #2, where we
> simply extend the C-structs to contain more info, but these are fixed
> fields that add a small constant/fixed overhead.  One could argue that
> it is naturally limited by what the SKB have fields for, but AF_XDP
> also need visibility into these fields.  I'm all for going in method #1
> direction, but I don't fully know/understand how the kernel C-code can
> access fields in the BTF described XDP metadata area?
>
> In my opinion we could/can "allow" the HW-checksum "ok" indication to
> use method #2, as shown in Ahern's patch[1].  The argument is that
> almost all hardware provide this.

Agree with that. There should be a small set of standard items that
all vendors have in their NICs such as in your examples above. I might
argue that timestamp and a "least common denominator" RSS hash would
also qualify to this list of standard items. (If available, a larger
RSS hash could be accessed using the NIC specific features below.)
Regardless of the list, it makes sense to have a flags field in the
AF_XDP Rx descriptor and in the xdp_buff that quickly can be tested
for anomalies and values that are present in the XDP metadata. If this
flags field is 0, everything is fine and there is no data for this
packet in the XDP metadata section, so no need to check and lose
performance. If the field is non-zero, then we need to act. For
ip_checksummed it means that something is wrong with the checksum but
no need to check XDP metadata for that (unless we want to save one bit
and not use 2 in the flags field). For a timestamp, it means that a
timestamp is present for this packet and I would need to fetch it in
the metadata section. And so on. So I am all for a flags field (max
32-bits please so it can be put in the currently unused options field
of the AF_XDP Rx descriptor) that can be quickly tested to improve
performance.

I think it is really important that all the metadata items are
optional, that they are all off unless explicitly and individually
turned on. These items are not for free. It costs to check and fetch
them from the HW, to populate the flags field and if needed the XDP
metadata field. It might even cost to have them turned on in the HW.
If I do not need ip_checksummed, multi-buffer, timestamp, or whatever,
I should not have to pay for it. Assuming everything will be turned on
(or just one big on/off switch) is not scalable. We do not want to end
up with a "mini skb" where everything must be populated. Keep XDP fast
;-)!

> The next natural field for method #2 seems to be "rxhash32" (32-bit
> RSS-hash).  This is also something we know almost all hardware provide,
> but IMHO is would be a mistake to use method #2.  First of all OVS
> AF_XDP (vmware Cc William) have RFC-patches[3] that AF_XDP need access
> to this.  Second, keeping this 32-bit is limiting hardware, as some NIC
> hardware (Mellanox and Napatech) support a 64-bit hash that is uniquely
> identify flows.  Mellanox also support using this RX-descriptor field
> for containing the skb->mark.  Thus, the flexibility of method #1 is
> preferred. (But how do I access this during xdp_frame to SKB creation?).
>
> As Magnus also said, I (also) think we need to take the step towards XDP
> metadata (method #1) with BTF... but we need some help from BTF experts.
>
>
> [3] http://patchwork.ozlabs.org/project/openvswitch/patch/1614882425-52800-1-git-send-email-u9012063@gmail.com/
> - -
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
> (Just to remind myself: Cache-line details about method #2 is that
> xdp_buff lives on call-stack and is cache-hot.  During redirect
> xdp_buff is converted to xdp_frame, which imply copying info into new
> memory area. The xdp_frame memory is located in top of data-frame.  The
> xdp_frame mem is prefetched in drivers to hide this cache-line miss).
>
