Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF2397365
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFAMjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 08:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhFAMjv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Jun 2021 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622551089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCmvmDvbA5Cyjt1llzDXopdRXRvPCz7n+zowurOsi2I=;
        b=UsCFNvmTEhZ+QNALNHRenTpaQZiML7YNn21PwmaQF41c/BiUacqUgHO9K/4U0vjtdk1qFS
        27GCTtdTC7SYTQF2l1sbG3vDjcMtnHIvPvWMFTRZjd1DuUBx+1JsIDmh+UrbuaMifCUXph
        FIgaMKarzPocqlK+M++r/MFWXFgoZv8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zcLZ8Dh1OhagLBYJgRIy0g-1; Tue, 01 Jun 2021 08:38:07 -0400
X-MC-Unique: zcLZ8Dh1OhagLBYJgRIy0g-1
Received: by mail-ej1-f70.google.com with SMTP id h18-20020a1709063992b02903d59b32b039so3310953eje.12
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 05:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BCmvmDvbA5Cyjt1llzDXopdRXRvPCz7n+zowurOsi2I=;
        b=N3TEUz+OL8jDcgaX/PSzc/exs9qKQpwz5543+YdKG+eQ3mJAW7l7si528ewr1Jai55
         lWH4we/FWJ4RGznXZMIWSR+fl53qT85pW1lsHYdaxHKUZDoy+Y7i1K4YVKxI6pbnYngz
         1+O4dokjfgdNuJURq5UTxcw3fj+vObu/o6XJaQr9zKLYsGWdw8frC+Od+QLL1IirFO1+
         AEWtjsynMAULS8oYs6HZAEt9iQGKxTHLPu6llQjlXSroAZUz55EdbZrB08n3/no3SXm/
         6hlsMuMD8roQaC6QLXJGjufwPiCpNNnPL+JghT4INPlmArwCF7VWgtWHbuKjQVpir/0Q
         2lUw==
X-Gm-Message-State: AOAM531YxGcrSdjryS3o1VISUGsLpB5EhyUWNro7uNI3cR+vjJYlaBH/
        gdWazxFZD2f7H1aiHuEV5kv1sDHbpa20J75P+HOjzWRyBBbgKO06kqHJt0xVZkhX1OyGImA+Lqf
        q7e444HldR2sf
X-Received: by 2002:aa7:c042:: with SMTP id k2mr22837694edo.21.1622551086352;
        Tue, 01 Jun 2021 05:38:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpB7ZQLhNrH3+kWIY4bBsxg5zjVbHaf8cT7e/xnmNqf1H54zyNXW9g9eVDMYuc9d3PO/JS6g==
X-Received: by 2002:aa7:c042:: with SMTP id k2mr22837659edo.21.1622551086016;
        Tue, 01 Jun 2021 05:38:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y25sm5008801edt.17.2021.06.01.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:38:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EA801180726; Tue,  1 Jun 2021 14:38:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        anthony.l.nguyen@intel.com, kuba@kernel.org, bjorn@kernel.org,
        magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH intel-next 2/2] ice: introduce XDP Tx fallback path
In-Reply-To: <20210601113236.42651-3-maciej.fijalkowski@intel.com>
References: <20210601113236.42651-1-maciej.fijalkowski@intel.com>
 <20210601113236.42651-3-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Jun 2021 14:38:03 +0200
Message-ID: <87czt5dal0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Under rare circumstances there might be a situation where a requirement
> of having a XDP Tx queue per core could not be fulfilled and some of the
> Tx resources would have to be shared between cores. This yields a need
> for placing accesses to xdp_rings array onto critical section protected
> by spinlock.
>
> Design of handling such scenario is to at first find out how many queues
> are there that XDP could use. Any number that is not less than the half
> of a count of cores of platform is allowed. XDP queue count < cpu count
> is signalled via new VSI state ICE_VSI_XDP_FALLBACK which carries the
> information further down to Rx rings where new ICE_TX_XDP_LOCKED is set
> based on the mentioned VSI state. This ring flag indicates that locking
> variants for getting/putting xdp_ring need to be used in fast path.
>
> For XDP_REDIRECT the impact on standard case (one XDP ring per CPU) can
> be reduced a bit by providing a separate ndo_xdp_xmit and swap it at
> configuration time. However, due to the fact that net_device_ops struct
> is a const, it is not possible to replace a single ndo, so for the
> locking variant of ndo_xdp_xmit, whole net_device_ops needs to be
> replayed.
>
> It has an impact on performance (1-2 %) of a non-fallback path as
> branches are introduced.

I generally feel this is the right approach, although the performance
impact is a bit unfortunately, obviously. Maybe it could be avoided by
the use of static_branch? I.e., keep a global refcount of how many
netdevs are using the locked path and only activate the check in the
fast path while that refcount is >0?

-Toke

