Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4F391595
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 12:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhEZLAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 07:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234172AbhEZLAg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 07:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622026745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4v2hzBg7euOmc0soSmar23PhyokMA03jLVgIhXzkhb4=;
        b=UTpCm67rCWAENL2jH37faEzqi+r/8GgD72Mp0V0TdpnySay7DGtjgG7XZ0cMC04dxNWBuU
        sIVFjTePnCimxbbeEU5+/vxO83hDY0FqCudfHBH276LxKh/5+g5Tqj5F0mnFnv23rHMZAu
        f1VM+SNhUjUuOMWs+t4kQBPEc3gv3VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-0-9ao6CPN46cBSKm_zCkfA-1; Wed, 26 May 2021 06:59:02 -0400
X-MC-Unique: 0-9ao6CPN46cBSKm_zCkfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 783B280293C;
        Wed, 26 May 2021 10:58:59 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D6CD5D9D3;
        Wed, 26 May 2021 10:58:50 +0000 (UTC)
Date:   Wed, 26 May 2021 12:58:48 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     brouer@redhat.com, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Subject: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210526125848.1c7adbb0@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi All,

I see a need for a driver to use different XDP metadata layout on a per
packet basis. E.g. PTP packets contains a hardware timestamp. E.g. VLAN
offloading and associated metadata as only relevant for packets using
VLANs. (Reserving room for every possible HW-hint is against the idea
of BTF).

The question is how to support multiple BTF types on per packet basis?
(I need input from BTF experts, to tell me if I'm going in the wrong
direction with below ideas).

Let me describe a possible/proposed packet flow (feel free to disagree):

 When driver RX e.g. a PTP packet it knows HW is configured for PTP-TS and
 when it sees a TS is available, then it chooses a code path that use the
 BTF layout that contains RX-TS. To communicate what BTF-type the
 XDP-metadata contains, it simply store the BTF-ID in xdp_buff->btf_id.

 When redirecting the xdp_buff is converted to xdp_frame, and also contains
 the btf_id member. When converting xdp_frame to SKB, then netcore-code
 checks if this BTF-ID have been registered, if so there is a (callback or
 BPF-hook) registered to handle this BTF-type that transfer the fields from
 XDP-metadata area into SKB fields.

 The XDP-prog also have access to this ctx->btf_id and can multiplex on
 this in the BPF-code itself. Or use other methods like parsing PTP packet
 and extract TS as expected BTF offset in XDP metadata (perhaps add a
 sanity check if metadata-size match).


I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this idea,
and they pointed out that AF_XDP also need to know what BTF-layout is
used. As Magnus wrote in other thread; there is only 32-bit left in
AF_XDP descriptor option. We could store the BTF-ID in this field, but
it would block for other use-cases. Bj=C3=B8rn came up with the idea of
storing the BTF-ID in the BTF-layout itself, but as the last-member (to
have fixed offset to check in userspace AF_XDP program). Then we only
need to use a single bit in AF_XDP descriptor option to say
XDP-metadata is BTF described.

In the AF_XDP userspace program, the programmers can have a similar
callback system per known BTF-ID. This way they can compile efficient
code per ID via requesting the BTF layout from the kernel. (Hint:
`bpftool btf dump id 42 format c`).

Please let me know if this it the right or wrong direction?

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

