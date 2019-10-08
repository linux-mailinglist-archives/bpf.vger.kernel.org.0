Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC97ECF318
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2019 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfJHG6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Oct 2019 02:58:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730111AbfJHG6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Oct 2019 02:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570517901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjiVfnfo3B219hJevj+nUA5nd9HYypooTjDbpxlfu2E=;
        b=iDg+l8uqsxGC0rzCjjSiN6614GKg+MM28ylegxN/Am9jp4g2RnYb3SZZyqeOrWjD5K6b3J
        dS+I8hjaLlaicPm56hIzKIJQjQ4WxddRYgXYf1U3jXNsq2q7CWP0wa2aeypPIvn2wXP30b
        eLo0ToVh79cHAT5Mj98DpOaywnaqExM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-RIDzUwHTMYSQ8g4C3A3Mmg-1; Tue, 08 Oct 2019 02:58:20 -0400
Received: by mail-lf1-f70.google.com with SMTP id w193so2042465lff.3
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 23:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=S9PjHaofBE8WvE/gCT9+Hpu5GwookQh45Bj4/FXFqOI=;
        b=HcAvqarVCXH6xx0cnRTAcTrySM8HKeslcXDHU8fVrbxcB7ZyCkFIrVbMpircDpFWO1
         iN17XT1FeYGBnlkRXXOqIRzkkwFp9cFwDRhQszEFCPd8H6crp5S7eWoVOoxQmQWwf2rt
         E9xNLEkE/FTSR4JTsv107C/yi8ZM9uGklMArC06E9seJYaX4lvXg2tDAw9sUKCIK7rV/
         KcqIN9MwDLFI2nQMuBYDh0i40wbCwRwiKF7BK6JWMvC0GuVrWLMj5YW8tVQNxPNMVrvz
         +Fxl0LIbPD/H+KzW//nQ3Hx+EEtAf14MJIzs0ytZPD67U8m+yFn+2WbGvxoo7/7l4Cdi
         J23Q==
X-Gm-Message-State: APjAAAWZRKcdRXm/6lNAsdo/IQof4xDn00IOzacthwiAYly2zuhOLd0L
        AIft9/zh8bT5wXZGx3aH+2dQU9NO53P/D1TcLZdfHAtAC+md6paNq/8UgecniQ86tSpiKtBhaq4
        zlvKp8+aZ+Iif
X-Received: by 2002:a2e:730a:: with SMTP id o10mr21912307ljc.214.1570517898816;
        Mon, 07 Oct 2019 23:58:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcpPsm8E/3M1oXM5bmklENMw0tvOHJJmGog/AgsVSfuHgI1NlUp2BPNtR6+WN3vcVRbtaEPA==
X-Received: by 2002:a2e:730a:: with SMTP id o10mr21912299ljc.214.1570517898646;
        Mon, 07 Oct 2019 23:58:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id b6sm3972837lfi.72.2019.10.07.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 23:58:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF15F18063D; Tue,  8 Oct 2019 08:58:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sridhar Samudrala <sridhar.samudrala@intel.com>,
        magnus.karlsson@intel.com, bjorn.topel@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        sridhar.samudrala@intel.com, intel-wired-lan@lists.osuosl.org,
        maciej.fijalkowski@intel.com, tom.herbert@intel.com
Subject: Re: [PATCH bpf-next 2/4] xsk: allow AF_XDP sockets to receive packets directly from a queue
In-Reply-To: <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com> <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Oct 2019 08:58:16 +0200
Message-ID: <875zkzn2pj.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: RIDzUwHTMYSQ8g4C3A3Mmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sridhar Samudrala <sridhar.samudrala@intel.com> writes:

>  int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>  =09=09    struct bpf_prog *xdp_prog)
>  {
>  =09struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
>  =09struct bpf_map *map =3D READ_ONCE(ri->map);
> +=09struct xdp_sock *xsk;
> +
> +=09xsk =3D xdp_get_direct_xsk(ri);
> +=09if (xsk)
> +=09=09return xsk_rcv(xsk, xdp);

This is a new branch and a read barrier in the XDP_REDIRECT fast path.
What's the performance impact of that for non-XSK redirect?

-Toke

