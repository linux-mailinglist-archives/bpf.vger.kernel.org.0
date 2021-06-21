Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919543AF72D
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFUVJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 17:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhFUVJE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Jun 2021 17:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624309609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCYNjzCXOFt1BAinrqjdX4cXEeptp37zTrkwUbvDIfo=;
        b=M+gMjeQoeSt32OGuj3KBsGrOIHZVJcu9sPGHSaQngRAPQe7iW/qBKlJsUWf/2nXRGjKNx3
        yjzfQMF7alXqXTKwb8tX4qG1JJiNymASvFwtcOYrDXQb82IfmYpBkwiROitm9Z7WarYJ6h
        CZnPHpw88+5F8aVCUM5HXENSZaEm43s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-oX2UP2YROdytegyCZ2tpJg-1; Mon, 21 Jun 2021 17:06:45 -0400
X-MC-Unique: oX2UP2YROdytegyCZ2tpJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7BFF362FA;
        Mon, 21 Jun 2021 21:06:43 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742585D9F0;
        Mon, 21 Jun 2021 21:06:37 +0000 (UTC)
Date:   Mon, 21 Jun 2021 23:06:35 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     "Maloor, Kishen" <kishen.maloor@intel.com>
Cc:     "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>, brouer@redhat.com,
        XDP-hints working-group <xdp-hints@xdp-project.net>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Walfred 'Fred' Tedeschi <walfred.tedeschi@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: TXTIME (Launch Time) setting per XDP frame from userspace.
Message-ID: <20210621230635.3a83851c@carbon>
In-Reply-To: <00301BEA-4A94-4600-998A-BEDCF3330795@intel.com>
References: <00301BEA-4A94-4600-998A-BEDCF3330795@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


(Answer inlined below, please learn howto answer inline)

On Mon, 21 Jun 2021 19:08:54 +0000
"Maloor, Kishen" <kishen.maloor@intel.com> wrote:

> Hi Jesper,
>=20
> I wanted to run some patches by you for your comments.

Thanks a lot for reaching out, I really appreciate it.

> Intel has a requirement to support an SO_TXTIME like capability with
> AF_XDP sockets, to set a precise per-packet transmission time from
> user space XDP applications.

This is great!  I also have a customer that have this requirement.
Thus, I'm very interested in collaborating on getting this feature
implemented in practice.


> It is also critical that this support be upstreamed into the Linux
> mainline.

I fully agree "upstream first".  For this to happen, we should discuss
the approach in a public forum as early as possible to get upstream
feedback.  Cc'ing bpf@vger.kernel.org.  Also adding our working group
mailing list as not everybody follow the kernel list Cc'ed
xdp-hints@xdp-project.net (https://lists.xdp-project.net/xdp-hints/).

Multiple of your Intel colleagues (from other departments) have also
reached out to me, and they are also on this xdp-hints mailing list.
It would be great if you can keep this list Cc'ed to keep everybody in
the loop.

Consider subscribing:
 https://lists.xdp-project.net/postorius/lists/xdp-hints.xdp-project.net/


> The implementation is roughly equivalent to that of SO_TXTIME for
> AF_PACKET. It includes:
>
> - a new XSK bind flag,

So, this feature is enabled for all packets on this AF_XDP socket.

> - libbpf API to set a TXTIME for a frame,
>
> - leverages the concept of UMEM headroom to store the per-packet
>   TXTIME (immediately preceding the XDP buff's data_hard_start),

This sounds like the XDP metadata area?
Or is this top of mem data-area (guess not, as you use +umem_headroom)?

What will happen when an XDP-prog use this same metadata area, and your
feature (patch below) is enabled (via AF_XDP) ?

E.g. can I set the TXTIME in XDP-prog (RX) and XDP_REDIRECT out an
interface with TXTIME enabled?


> - internally signals the NIC driver via the XDP descriptor when
>   there's a TXTIME bound to a frame, and

Looking at patch, if I don't call 'xsk_umem__set_txtime' (libbpf), then
the kernel (xp_raw_get_txtime) will pickup random-data left over by
previous user of the memory, right?

> - provides a kernel API to retrieve it in the driver so it may proceed
>   to set the Launch Time on the NIC.
>=20
> It uses existing bitmasks and there's no overhead (i.e. not
> allocating any more memory than is already done), and there are no
> other dependencies.
>
> You may review the commit messages for all details.
>=20
> kernel: https://github.com/kmaloor/bpfnext/commit/b72a336bcb8df4a26646a29=
962ca95d58172147f
> libbpf: https://github.com/kmaloor/libbpf/commit/eda68c1ad11ed60739837ad6=
e4fb256768231b55
>=20
> We're currently testing these changes in conjunction with the igc
> driver.

Can you share the patches for the igc driver as well?

I want to see how you convert the "__s64 txtime" into the 30-bit
LaunchTime used[0] by the hardware (i225).  It would also be good to see
how this is used for driver igb/i210, that have a 25-bit LaunchTime.

Details on driver+hardware here:=20
 [0] https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code0=
1_follow_qdisc_TSN_offload.org


> Meanwhile, we'd appreciate any comments you may have, particularly as
> an expert with the kernel XDP subsystem.

I think this TXTIME work is just *one* use-case of "xdp-hints".  IMHO we
should use something like BTF to describe the metadata memory area
in-order to support more use-cases.

Being concrete .e.g. your XSK socket bind call could register a BTF-ID
that it tells the kernel about the layout. I guess, we need some
guidance from BTF experts on how kernel can check the driver supports
this LaunchTime feature, Andrii?

Other use-cases: (1) On TX we also want to support asking for TX-csum
by hardware. (2) Support setting VLAN via TX-descriptor (hint TSN can
use VLAN priority bits).

Again thanks for reaching out, lets find a solution together with
upstream.
--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Kernel:

 s64 xp_raw_get_txtime(struct xsk_buff_pool *pool, u64 addr)
=EF=BF=BC{
=EF=BF=BC	return *(s64 *)((char *)xp_raw_get_data(pool, addr) - XDP_TXTIME_=
LEN);
=EF=BF=BC}
=EF=BF=BCEXPORT_SYMBOL(xp_raw_get_txtime);

libbpf:

 static inline void xsk_umem__set_txtime(void *umem_area, __u64 addr, __u32=
 umem_headroom, __s64 txtime)
=EF=BF=BC{
=EF=BF=BC	*(__s64 *)(&((char *)umem_area)[addr] + umem_headroom - XDP_TXTIM=
E_LEN) =3D txtime;
=EF=BF=BC}

