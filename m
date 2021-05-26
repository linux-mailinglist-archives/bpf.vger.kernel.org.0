Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3878391E3F
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhEZRkJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 13:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232714AbhEZRkJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 13:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622050717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/9PHlCIbYLHT5Bvg+Fmyn6xRX3OaRP0W0KpRzB/Qpg=;
        b=OHdtYu+F08ZzLtZh8Tu1gHdMW2wosdotQvigE4sF+eB7kjyHPAyPSb77Rn8pb+B9nctTJz
        GgjP/o+fdsClhDqd90w/MTJhlYbGGy6eD9f7czo452mo7fw5/gNJFOzRS0mK04Fd+R2h6g
        va6t9Yf/7I1MxswZtuGoxmEgCRyZpiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-gkoWIi7IODCwJorW7ooopw-1; Wed, 26 May 2021 13:38:33 -0400
X-MC-Unique: gkoWIi7IODCwJorW7ooopw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53186180FD6B;
        Wed, 26 May 2021 17:38:31 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 450905D6D3;
        Wed, 26 May 2021 17:38:20 +0000 (UTC)
Date:   Wed, 26 May 2021 19:38:18 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
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
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, bpf@vger.kernel.org,
        brouer@redhat.com
Subject: Re: AF_XDP metadata/hints
Message-ID: <20210526193818.2fda7dba@carbon>
In-Reply-To: <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
        <20210510185029.1ca6f872@carbon>
        <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210512102546.5c098483@carbon>
        <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com>
        <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com>
        <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com>
        <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com>
        <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210521153110.207cb231@carbon>
        <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org>
        <87lf85zmuw.fsf@toke.dk>
        <20210525142027.1432-1-alexandr.lobakin@intel.com>
        <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch>
        <20210526134910.1c06c5d8@carbon>
        <87y2c1iqz4.fsf@toke.dk>
        <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 08:35:49 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> I'll still have a basic question though. I've never invested much time
> into the hints because its still not clear to me what the use case is?
> What would we put in the hints and do we have any data to show it would be
> a performance win.

I've documented and measured[1] the performance overhead of the missing
checksum for UDP packets when XDP-redirecting into veth (that does
XDP_PASS).  Full delivery into a socket we can save 8% (54.28 ns /
+109Kpps).  Lorenzo is working patches outside XDP-hints for this, but
it only handle CHECKSUM_UNNECESSARY, and if we need CHECKSUM_COMPLETE
then we also need XDP-hints/metadata (for storing skb->csum).

[1] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame01_checksum.org
 
> If its a simple hash of the headers then how would we use it?

Even with a simple/smaller hash you can tune the RSS-hash on parts of
the packet you like, see[2]. That would be valuable for doing lookups
in BPF-maps.

[2] https://github.com/stackpath/rxtxcpu/tree/master/Documentation/case-studies

For cpumap redirect I would like to spread packets with this RX-hash,
as I can avoid parsing packets headers on RX-CPU.

The mlx5 NIC support 64-bit unique flow hash, that you could use as a
lookup key in your (Cilium) conntrack table, or a container/sockmap
redirect-tracking table.

> The map_lookup/updates use IP addrs for keys in Cilium. So I think the
> suggestion is to offload the jhash operation? But that requires some
> program changes to work. Could someone convince me?

Is my explanations enough, or are you still not convinced? 
 
> Maybe packet timestamp?

I have a concrete use-case that needs packet timestamps for AF_XDP. It
is the control system inside a wind-turbine that use a time-triggered
Real-Time protocol.  I actually both need hardware RX-timestamps and
TX-timestamps.  A lot it lacking on the TX-side to allow AF_XDP to send
down a transmission timestamp, but I have a real-use-case that needs
this (before end-of year).  I have hardware i210 and i225 chips in my
testlab so I can get this working.

Thanks you John for engaging and challenging us in our design of
XDP-hints, I truly appreciate your feedback! :-)
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

