Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E965139169E
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhEZLwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 07:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbhEZLvG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 07:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622029771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n0qlKXB1bnPoNluf4mjZlVoqIwiQZkhDutOAoVJjSM=;
        b=OAO69Nh6TwgMYOjNCGYDXn4VRTVKa771BtTj5CpSexvHH9qhLypHMGDJZKH6CdVieRVzKx
        3U+dVLFbKhdB8dH4Y5DyPdVEi8yxUHCFctJXCj9FT4bViCuh9grghKmen5QWwII6yIQgdh
        xG4Xaf5/G6TjBFRk5vCfB5X+XL62zHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-4EOmWYC1MZGc--gEK8i0Fw-1; Wed, 26 May 2021 07:49:25 -0400
X-MC-Unique: 4EOmWYC1MZGc--gEK8i0Fw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96786189C446;
        Wed, 26 May 2021 11:49:22 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B6210074E0;
        Wed, 26 May 2021 11:49:11 +0000 (UTC)
Date:   Wed, 26 May 2021 13:49:10 +0200
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
        brouer@redhat.com
Subject: Re: AF_XDP metadata/hints
Message-ID: <20210526134910.1c06c5d8@carbon>
In-Reply-To: <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
        <20210507131034.5a62ce56@carbon>
        <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 25 May 2021 21:51:22 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> Separate the config of hardware from the BPF infrastructure these
> are two separate things.

I fully agree.

How should we handle existing config interfaces?

Let me give some concrete examples. Today there are multiple existing
interfaces to enable/disable NIC hardware features that change what is
available to put in our BTF-layout.

E.g. changing if VLAN is in descriptor:
 # ethtool -K ixgbe1 rx-vlan-offload off
 # ethtool -k ixgbe1 | grep vlan-offload
 rx-vlan-offload: off
 tx-vlan-offload: on

The timestamping features can be listed by ethtool -T (see below
signature), but it is a socket option that enable[1] these
(see SO_TIMESTAMPNS or SOF_TIMESTAMPING_RX_HARDWARE).

Or tuning RSS hash fields:
 [2] https://github.com/stackpath/rxtxcpu/blob/master/Documentation/case-studies/observing-rss-on-ixgbe-advanced-rss-configuration-rss-hash-fields.md

I assume we need to stay compatible and respect the existing config
interfaces, right?

Should we simple leverage existing interfaces?

E.g. tcpdump --time-stamp-type=adapter_unsynced could simple enable the
BTF-layout that contains the RX-timestamp.  This would make it avail to
XDP/AF_XDP and the xdp_frame can also create a SKB with the timestamp.


[1] https://www.kernel.org/doc/html/latest/networking/timestamping.html
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


# ethtool -T ixgbe1
Time stamping parameters for ixgbe1:
Capabilities:
	hardware-transmit
	software-transmit
	hardware-receive
	software-receive
	software-system-clock
	hardware-raw-clock
PTP Hardware Clock: 7
Hardware Transmit Timestamp Modes:
	off
	on
Hardware Receive Filter Modes:
	none
	ptpv1-l4-sync
	ptpv1-l4-delay-req
	ptpv2-event


# ethtool -T igc1
Time stamping parameters for igc1:
Capabilities:
	hardware-transmit
	software-transmit
	hardware-receive
	software-receive
	software-system-clock
	hardware-raw-clock
PTP Hardware Clock: 1
Hardware Transmit Timestamp Modes:
	off
	on
Hardware Receive Filter Modes:
	none
	all

