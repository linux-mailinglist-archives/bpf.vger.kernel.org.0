Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18FA2D100F
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLGMGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 07:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgLGMGK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 07:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607342675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlAEFvUMokOg0a4hoz6sBDTY3/sieYinmp5t9vlfqFw=;
        b=II+gDG3ni7SkkJBM6ZVS/M42DitnCXvq19VNimva8O9UQgjsOhAM49sXWJfex6L3ZW7jXO
        pSmBM0WaPUWFVvKctb6R9bspVLR8nd/EOC4MEodm7fTnDkPbMs2ZIjIhKGxgKLyJOzKStC
        RzLXXw3jizLOgm3tQCiNuSrUvHdUMfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-MVjx7gb1NwuNh4bORxxvCA-1; Mon, 07 Dec 2020 07:04:33 -0500
X-MC-Unique: MVjx7gb1NwuNh4bORxxvCA-1
Received: by mail-wr1-f72.google.com with SMTP id w17so4768093wrl.8
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 04:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nlAEFvUMokOg0a4hoz6sBDTY3/sieYinmp5t9vlfqFw=;
        b=r6Rg5hNhCQXUmpVozN/nK988oJWuWFfXDiret60lqnfjZyQnIuhCVwovhPc9NR3jWm
         zYgu7BrRMD4ToJy1I+n6eZo0D+vI3jPfXYGdoumJdq31DpiGVoCspNtJVUEEHRMzLCLg
         gV/iiWI+WAWAo7ASXNCqjBRGYKb0gIPWuTZwgn7w4xwh96uJPi+btfcE1qxeBXO3HsWL
         epoyBBbMIEDgDZBXoEgMH9nO49OOjf/pmGQMKmnuey0hku8NTqJ7BgQkOOn8KIPDxAPP
         P5xKFkVjUQcoK0BE8MyXxS4dsHnlX8v42CLtG2DX6FryhhmIB8goDlvUpZar1kEnOY8K
         6MWQ==
X-Gm-Message-State: AOAM5313ORfn7T82a7VZ+7a+K6+9/vh04H5JwPpCPL3F3vRoI1RlyYD8
        0tohRuY0t3VeAv1IvwrTlHMKxpTj9ocfxJ564Yk2O0RJ0uovryCA8Y85145XjDyZGUrzaNU88hZ
        MUqdCAew5pK9p
X-Received: by 2002:a5d:488d:: with SMTP id g13mr19054297wrq.274.1607342672437;
        Mon, 07 Dec 2020 04:04:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkE97umJrIjk5fQmH4C/2ZWdQyq7TxQSVYWyo/ZFQmsbfNtoEhiAj2EV6sbSopor8jcG3epQ==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr19054259wrq.274.1607342672089;
        Mon, 07 Dec 2020 04:04:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a65sm13974526wmc.35.2020.12.07.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 04:04:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 070881843F5; Mon,  7 Dec 2020 13:04:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     alardam@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, davem@davemloft.net,
        john.fastabend@gmail.com, hawk@kernel.org,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH v2 bpf 0/5] New netdev feature flags for XDP
In-Reply-To: <20201204112259.7f769952@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <87k0tx7aa5.fsf@toke.dk>
 <20201204112259.7f769952@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 13:04:30 +0100
Message-ID: <87tusx6cvl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 04 Dec 2020 18:26:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>>=20
>> > On Fri,  4 Dec 2020 11:28:56 +0100 alardam@gmail.com wrote:=20=20
>> >>  * Extend ethtool netlink interface in order to get access to the XDP
>> >>    bitmap (XDP_PROPERTIES_GET). [Toke]=20=20
>> >
>> > That's a good direction, but I don't see why XDP caps belong in ethtool
>> > at all? We use rtnetlink to manage the progs...=20=20
>>=20
>> You normally use ethtool to get all the other features a device support,
>> don't you?
>
> Not really, please take a look at all the IFLA attributes. There's=20
> a bunch of capabilities there.

Ah, right, TIL. Well, putting this new property in rtnetlink instead of
ethtool is fine by me as well :)

-Toke

