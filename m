Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA907391F67
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhEZSqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 14:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235617AbhEZSqO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 14:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622054682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlYH7p/eoCpk1qqpjbcMyREVG0HzvWbFtqQuQwpv8l4=;
        b=Nr3xcs5pgUxEKLpYcO3LYZPupRFkkD7tJpABDwVEib6w3Ij2dw6wyQG6e106l1E1e5cfTM
        XbLjnOTN6MRuyqu9a29j1BeI2pZtbr3KZatCz7+/5FjjGCEwaSC0ukr2SJlIeNuN6myc92
        vUft0YrBiH0lxkqCAHRJL1Me0K8i5Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ycZ3SiLTPnWsFWgRSqNewg-1; Wed, 26 May 2021 14:44:39 -0400
X-MC-Unique: ycZ3SiLTPnWsFWgRSqNewg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF35C107ACC7;
        Wed, 26 May 2021 18:44:36 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDB5C5C241;
        Wed, 26 May 2021 18:44:19 +0000 (UTC)
Date:   Wed, 26 May 2021 20:44:18 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, Saeed Mahameed <saeed@kernel.org>,
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
        xdp-hints@xdp-project.net, brouer@redhat.com,
        David Ahern <dsahern@gmail.com>
Subject: Re: AF_XDP metadata/hints
Message-ID: <20210526204418.532a0604@carbon>
In-Reply-To: <60ae7847b066e_5ff320887@john-XPS-13-9370.notmuch>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
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
        <20210526155402.172-1-alexandr.lobakin@intel.com>
        <60ae7847b066e_5ff320887@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 09:33:11 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> Alexander Lobakin wrote:
> > From: John Fastabend <john.fastabend@gmail.com>
> > Date: Wed, 26 May 2021 08:35:49 -0700
> > 
[...]
> > >> >
> > >> > I assume we need to stay compatible and respect the existing config
> > >> > interfaces, right?  
> > 
> > Again, XDP Hints won't change any netdev features and stuff, only
> > compose provide the hardware provided fields that are currently
> > inaccessible by the XDP prog and say cpumap code, but that are
> > highly needed (cpumap builds skbs without csums -> GRO layer
> > consumes CPU time to calculate it manually, without RSS hash ->
> > Flow Dissector consumes CPU time to calculate it manually +
> > possible NAPI bucket misses etc.).  
> 
> Thats a specific cpumap problem correct?

No, it is not a specific cpumap problem.  It is actually a general
XDP_REDIRECT problem.  The veth container use-case is also hit by this
slowdown due to lacking HW-csum and RSS-hash, as describe by Alexander.

It also exists for redirect into Virtual Machines, which is David
Ahern's use-case actually.

> In general checksums work as expected?

Nope, the checksums are non-existing for XDP_REDIRECT'ed packets.
 
> [...] 
> I'm not convinced hashes and csum are so interesting but show me some
> data. 

Checksum overhead measurements for veth container use-case see here[1].
 [1] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame01_checksum.org
 

> Also my admittedly rough understanding of cpumap is that it helps
> the case where hardware RSS is not sufficient. 

I feel the need to explain what I'm using cpumap for, so bear with me.

In xdp-cpumap-tc[2] the XDP cpumap redirect solves the TC Qdisc locking
problem.  This runs in production at an ISP that uses MQ+HTB shaping.
It makes sure customer assigned IP-addresses (can be multiple) are
redirected to the same CPU. Thus, the customer specific HTB shaper
works correctly. (Multiple HTB qdisc are attached under MQ [6]).

 [2] https://github.com/xdp-project/xdp-cpumap-tc
 [6] https://github.com/xdp-project/xdp-cpumap-tc/blob/master/bin/tc_mq_htb_setup_example.sh

In traffic-pacing-edt[3] the cpumap code[4] maps VLAN tagged traffic to
the same CPU.  This allows the TC-BPF code[5] to be "concurrency
correct" as it updates the VLAN based EDT-rate-limit BPF-map without any
atomic operations.  This runs in production at another ISP, that need
to shape (traffic pace) 1Gbit/s customer on a 10Gbit/s link due to
crappy 1G GPON switches closer to the end-customer.  It would be useful
to get the offloaded VLAN info in XDP-metadata.

 [3] https://github.com/xdp-project/bpf-examples/tree/master/traffic-pacing-edt
 [4] https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/xdp_cpumap_qinq.c
 [5] https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c

> Seeing your coming from the Intel hardware side why not fix the RSS
> root problem instead of using cpumap at all? I think your hardware is
> flexible enough.

Yes, please fix i40e hardware/firmware to support Q-in-Q packets.  We
are actaully hitting this at a customer site.  But my above cpumap
use-cases were not due to bad RSS-hashing.

 
> I would really prefer to see example use cases that are more generic
> than the cpumap case.


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

 

