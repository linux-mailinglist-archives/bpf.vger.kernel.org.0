Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5C39124F
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEZIaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232209AbhEZIaO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 04:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8mP9hdU2vxJhlwm/QcZaWaywE5qhn2quEvO4fqYV7I=;
        b=QZiSaMYV9VkB2TOwxZZpyWJBTWU0OPxMLNABU+3KIsMZX9iGmIthR7w7djL5q3xaFf9HBm
        /QwSyBc1X/YYGiGAHioMqrpzFwPFtmfZvQVtnpxWgSaGhL5sHfcLVlSOTEVzfFaooXE45Q
        BOVLwE/74tkRiB2R3FDM9gEuTcJcX0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-khTQfVtuPqaTHH7lppubrQ-1; Wed, 26 May 2021 04:28:39 -0400
X-MC-Unique: khTQfVtuPqaTHH7lppubrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0657E180FD77;
        Wed, 26 May 2021 08:28:37 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209536A046;
        Wed, 26 May 2021 08:28:20 +0000 (UTC)
Date:   Wed, 26 May 2021 10:28:19 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     "Karlsson, Magnus" <magnus.karlsson@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, "David Ahern" <dsahern@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        brouer@redhat.com, BPF-dev-list <bpf@vger.kernel.org>,
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
Subject: XDP-hints: Storing some bits in XDP metadata and others in
 xdp_frame/xdp-buff  (was: Checksum for xdp_frame)
Message-ID: <20210526102819.04b99ae0@carbon>
In-Reply-To: <DM6PR11MB4593177EE3BBA8E4E2C7CC2BF7259@DM6PR11MB4593.namprd11.prod.outlook.com>
References: <20210525121637.46fcdebe@carbon>
        <DM6PR11MB4593177EE3BBA8E4E2C7CC2BF7259@DM6PR11MB4593.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


(Cc. upstream bpf-list as Magnus brought up a good question and
important AF_XDP view-point)

On Tue, 25 May 2021 12:40:03 +0000
"Karlsson, Magnus" <magnus.karlsson@intel.com> wrote:

> > -----Original Message-----
> > From: Jesper Dangaard Brouer <brouer@redhat.com>
> > Subject: Fwd: Checksum for xdp_frame 
> > 
> > The important part is this commit by Ahern:
> > [1] https://github.com/dsahern/linux/commit/b6b4d4ef9562383d8b407a873d30
> > 
> > The patch use bitfields, which we now know is a bad idea for performance,
> > so that needs to change.

We were discussing above patch [1].  That implement CHECKSUM_UNNECESSARY
HW indication, by storing two-bits in xdp_buff, that is later
transferred to xdp_frame, which use them to populate skb->ip_summed.
(Plan is for Lorenzo to continue this work).

Measurements[2] show a need for this.
 [2] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame01_checksum.org

> [...]
> 
> Some initial thoughts from an AF_XDP point of view. For every one of
> these "metadata" items being it IP checksumed, Rx/Tx timestamps,
> packet continues in next buffer, VLAN id, RSS hash, etc. we can pick
> one of these methods:
> 
> 1: Put it in the XDP metadata section before the packet. Good since
> it requires no intervention to convert this to AF_XDP and it is
> large. AF_XDP uses exactly the same metadata section as XDP. The
> drawback here might be that we touch a new cache line unless we play
> with headroom so that it is located on the same cache line as the
> start of the packet (and use that too).
> 
> 2: We put it in the struct xdp_buff which is invisible to user space
> and therefore must be copied out to either the XDP metadata section
> or to the __u32 options field in the AF_XDP Rx descriptor. As we add
> stuff to the xdp_buff, this will become a scalability problem and we
> will create a mini skb. Moreover, we only have space for 32 bits of
> information in the AF_XDP Rx options field and in contrast to the
> xdp_buff, we can never increase this, so AF_XDP needs to put things
> in the XDP metadata section sooner or later. The only advantage with
> this approach is that if we put the item in the options field, this
> will be fast since it will very likely be in the L1 cache. But since
> it is only 32 bits, we have to pick what goes in the options field
> very carefully.
> 
> One thing I think should go into the options field is the
> multi-buffer flag in Lorenzos multi-buffer patch set since that has
> to be checked all the time in multi-buffer mode and it has to do with
> frames/descriptors composing a packet. (multi_buffer is a property on
> each descriptor/frame, while ip_checksummed is a property on the
> packet but not each descriptor.) But for all the rest, I think we
> should use the XDP metadata field. I have not read David's mail, but
> what is the argument for having ip_checksummed in the xdp_buff? Why
> not any of the other metadata items that could be equally or more
> important for my app? Putting it in the XDP metadata requires a lot
> of plumbing before we can realize #1 so that is one good short-term
> argument for #2. But I think we need to take the step towards XDP
> metadata now. #2 is not a scalable approach, not even for the
> xdp_buff. Opinions? What am I missing?

Thanks for framing the issue/dilemma very accurately.

My perspective is converting xdp_frame into SKB, where we *also* need
some of these HW-hints.  This is very easy with method #2, where we
simply extend the C-structs to contain more info, but these are fixed
fields that add a small constant/fixed overhead.  One could argue that
it is naturally limited by what the SKB have fields for, but AF_XDP
also need visibility into these fields.  I'm all for going in method #1
direction, but I don't fully know/understand how the kernel C-code can
access fields in the BTF described XDP metadata area?

In my opinion we could/can "allow" the HW-checksum "ok" indication to
use method #2, as shown in Ahern's patch[1].  The argument is that
almost all hardware provide this.

The next natural field for method #2 seems to be "rxhash32" (32-bit
RSS-hash).  This is also something we know almost all hardware provide,
but IMHO is would be a mistake to use method #2.  First of all OVS
AF_XDP (vmware Cc William) have RFC-patches[3] that AF_XDP need access
to this.  Second, keeping this 32-bit is limiting hardware, as some NIC
hardware (Mellanox and Napatech) support a 64-bit hash that is uniquely
identify flows.  Mellanox also support using this RX-descriptor field
for containing the skb->mark.  Thus, the flexibility of method #1 is
preferred. (But how do I access this during xdp_frame to SKB creation?).

As Magnus also said, I (also) think we need to take the step towards XDP
metadata (method #1) with BTF... but we need some help from BTF experts.


[3] http://patchwork.ozlabs.org/project/openvswitch/patch/1614882425-52800-1-git-send-email-u9012063@gmail.com/
- - 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

(Just to remind myself: Cache-line details about method #2 is that
xdp_buff lives on call-stack and is cache-hot.  During redirect
xdp_buff is converted to xdp_frame, which imply copying info into new
memory area. The xdp_frame memory is located in top of data-frame.  The
xdp_frame mem is prefetched in drivers to hide this cache-line miss).

