Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628772CF31A
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgLDR1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 12:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgLDR1l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 12:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607102774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQ798MNDfvtqQrDv2UBWcc2VnF0HXJeCo5mjae/HrWs=;
        b=SyEZjxKtQ/Qc4wQiogLjGqrYKWFirtH3gJIMtZHryNZawBtwn41DZ7t724Tg1x9d73sx1b
        hPhMO3MfI8RnctMNn1wchzNCbl1xgisn9l70wylBrSDl/lwBpYaG3z0VJAZ7yagHtHtjDT
        Htxh97CHzCnuM/FwG0+EVBkJzozgcIQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-0LAzOQClNh6o8gU8df6-GQ-1; Fri, 04 Dec 2020 12:26:13 -0500
X-MC-Unique: 0LAzOQClNh6o8gU8df6-GQ-1
Received: by mail-ed1-f70.google.com with SMTP id z20so2594564edl.21
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 09:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NQ798MNDfvtqQrDv2UBWcc2VnF0HXJeCo5mjae/HrWs=;
        b=V3gAllx5GZ+WywErsek1T3dym2q8W+oQGlDwl/OocdQbO5eZa30vwqqeyM4ZIFy0qI
         XKchbP2DYBKG3UG6hiGJTI/lOYsJ1Df+6y5Q+PRx7TyXyAT3qaXjtZfd+UA0WcGycb9r
         R4DUAHDZ1Qv4O211RX4lnLYKxk5d0vsLxZyjOhjIKNQ8uQTHNp9uXbg6Gz4yiJgfI/z+
         dPX3YeOnlvjNW0Bn1Cvn5E+pQ3UOstms9m965Q8v0fC0uUY+ugrLAsmWTNOWenbl1pE4
         pRlcvxeF+vOHPpS97ozIlM86FtLqNO7xhxv6OzcUuNsvWZwJaBFeqKlWm3i7eDIFOj2s
         hcUw==
X-Gm-Message-State: AOAM530v9BtdSuJ5qTI7LR7bNKoPv2XXeMErbwvRHKFb0KhHeeUocCBP
        c3ohb41FnTwKK07DvQOQLPhRZWzxpm2A++ZqmoGUy1v2U+qWCWNTIwy5Y2Q2cdW3YZHTS4qKqtE
        GdQwL8W0b0viN
X-Received: by 2002:a17:907:700c:: with SMTP id wr12mr7944104ejb.398.1607102772067;
        Fri, 04 Dec 2020 09:26:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfRey5xD/WZwhxd3Nz82+uyMq/nlfkZPaMg0SBTagSfHMxSO6JURM+9isThgDkn3lIA72mTw==
X-Received: by 2002:a17:907:700c:: with SMTP id wr12mr7944088ejb.398.1607102771880;
        Fri, 04 Dec 2020 09:26:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ch30sm3854443edb.8.2020.12.04.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:26:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EF454182EEA; Fri,  4 Dec 2020 18:26:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, alardam@gmail.com
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, davem@davemloft.net,
        john.fastabend@gmail.com, hawk@kernel.org,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH v2 bpf 0/5] New netdev feature flags for XDP
In-Reply-To: <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Dec 2020 18:26:10 +0100
Message-ID: <87k0tx7aa5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri,  4 Dec 2020 11:28:56 +0100 alardam@gmail.com wrote:
>>  * Extend ethtool netlink interface in order to get access to the XDP
>>    bitmap (XDP_PROPERTIES_GET). [Toke]
>
> That's a good direction, but I don't see why XDP caps belong in ethtool
> at all? We use rtnetlink to manage the progs...

You normally use ethtool to get all the other features a device support,
don't you? And for XDP you even use it to configure the number of
TXQs.

I mean, it could be an rtnetlink interface as well, of course, but I
don't think it's completely weird if this goes into ethtool...

-Toke

