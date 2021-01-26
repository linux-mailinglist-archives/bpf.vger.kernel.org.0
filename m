Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E453046E2
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 19:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbhAZRTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 12:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390347AbhAZIqn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 03:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611650717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9gzTd6btxu4Ytm03Yrm00pwQppiXc/JxoltINtOzavM=;
        b=Gc48h2lmr1GaI5TUFhT4tDzBuMboPdN+DNHVEds8MMu7CWKNxQqLsL8oQtA5bOWka3a8Ki
        BCfr/1ltWaSdRRV+bACQIEG0WZJGyKzkkcCjJtyOnZzWcqdsG8hrOlieobc+BUkNS+uDtS
        WtewN5SYt/eyB82uxFfNIkyBYQmKq7M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-iWOmM8b0NYKP-S0E0gCgZg-1; Tue, 26 Jan 2021 03:45:15 -0500
X-MC-Unique: iWOmM8b0NYKP-S0E0gCgZg-1
Received: by mail-ej1-f70.google.com with SMTP id z2so4709815ejf.3
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 00:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9gzTd6btxu4Ytm03Yrm00pwQppiXc/JxoltINtOzavM=;
        b=Nx2DZC3Eu5bMbBQuKeNyM4IfDabPwoU5lbcZ1BYykWVpSnj6FDJBXYkejwH9+x4G1y
         F2oxQvoluj03uRxEwWRcl1V2roW6Ka3RrVob4gtSW/7y2M41MRmDO/3JmsXj3n+aRscx
         uPApEQkStkPmy0328KX28REgHdPqj6HBf2CcOK/62DLVxLWq4YEwgWb2lW2sZiQvTT3q
         a728S58u6o+ozbCLoscP2ssABHwl9XA/Z8xwU8jWxepgohw+i+iCNFWIbNNjKKaeI2gu
         a13/kx35IScrMfv/jeWoPnKCqv978C0xn7m2KnYFgM5dSFFmFrnTHV0z+0Wy5fyQBowB
         bx5Q==
X-Gm-Message-State: AOAM532fq7L3yrwbuTQ4JML8zy7+5ZLX35ydMLUY/J9ZCFEZoifX1gLO
        DHqJDFLRXvjdf9cV6Ncm0hpZX1QeBK+LiQY+ujtziZPAVcOMf8HTHPXCrwTdsowYExT/3Xe/IMa
        Nf3M9occGeZjs
X-Received: by 2002:a17:906:3a13:: with SMTP id z19mr2929236eje.317.1611650714305;
        Tue, 26 Jan 2021 00:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx03Mfbqu1LpR8FbZ3JbEqBq8v6YQIBFfG+PF3Y7BTCckd7Z8SXCcUKEb/nMVNSKlNABdcH4w==
X-Received: by 2002:a17:906:3a13:: with SMTP id z19mr2929218eje.317.1611650713949;
        Tue, 26 Jan 2021 00:45:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y8sm11850387edd.97.2021.01.26.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:45:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A46B4180349; Tue, 26 Jan 2021 09:45:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ciara Loftus <ciara.loftus@intel.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
        weqaar.a.janjua@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH bpf-next v2 0/6] AF_XDP Packet Drop Tracing
In-Reply-To: <20210126075239.25378-1-ciara.loftus@intel.com>
References: <20210126075239.25378-1-ciara.loftus@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Jan 2021 09:45:11 +0100
Message-ID: <87bldccciw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ciara Loftus <ciara.loftus@intel.com> writes:

> This series introduces tracing infrastructure for AF_XDP sockets (xsks).
> A trace event 'xsk_packet_drop' is created which can be enabled by toggling
>
> /sys/kernel/debug/tracing/events/xsk/xsk_packet_drop/enable
>
> When enabled and packets are dropped in the kernel, traces are generated
> which describe the reason for the packet drop as well as the netdev and
> qid information of the xsk which encountered the drop.
>
> Example traces:
>
> 507.588563: xsk_packet_drop: netdev: eth0 qid 0 reason: rxq full
> 507.588567: xsk_packet_drop: netdev: eth0 qid 0 reason: packet too big
> 507.588568: xsk_packet_drop: netdev: eth0 qid 0 reason: fq empty
>
> The event can also be monitored using perf:
>
> perf stat -a -e xsk:xsk_packet_drop

Would it make sense to also hook this up to drop_monitor?

-Toke

