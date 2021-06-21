Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ABC3AECC7
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUPwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 11:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230028AbhFUPwx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Jun 2021 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624290638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhiN9L8xkxoHGrh/rosbAHaVX/RlsXtRLjFzFufUl1w=;
        b=E44M5hnC9Wa1ZS0jrfaoABfWXD2udYbxlagqDZZzGW+UqC8AyA2WyRUyvl8EjrMhHR7HTT
        mBKB45QxRprAO2GRmcZgJAbGGvT0LrxotQldbAvv8+njNnRS4Zb7nxjYJ1rrYmMSvevYDD
        9L/7PfsILx4SQPTb3eu5GOcEPtVQqks=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-kd0khh30OTqwSko4WyuuVw-1; Mon, 21 Jun 2021 11:50:36 -0400
X-MC-Unique: kd0khh30OTqwSko4WyuuVw-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso8028116edd.12
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 08:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bhiN9L8xkxoHGrh/rosbAHaVX/RlsXtRLjFzFufUl1w=;
        b=GC/8Ry6twsDA1ABj1TG15ElSS6dv/m0jeN/1UUQxH/RU/opdHelhPRgcBNeJw5VTPQ
         EBPfbrnR6SRoo9ObGeAmuPFIjUHOMNdnl06tzCvyr2kEqXe7m64k+Adjt4sWo+Tq66V5
         kz/kQ21fDwGqQvcIbyvvigZnWaqMnu1GGsSsyG0wgPmdqdT1zkg/QkTE3e5MTQgk2adK
         Mbdv5IYxcbhR6lPCCZ4OWn9lH7sD/2NInpd75wtUf4Yf5I4nASnvvHHdPUbZeXKSuc7E
         mLtXNsRQ2AKrrPpwXnRDWdVyYoK+nFAz4j6Yx9WCrs/dZbRHib0qrzdm1AxWY3Gh7jD1
         kb/w==
X-Gm-Message-State: AOAM530UX5ctloEckHZaIT6QL1I10pI+F75lBraqfzpNkRMTo4VS7JM6
        JOqpBZXAaPRynvrCSJtK+2VzsajKGnO66wkjoG1Cpooo905Qxr2QIMX2xzINL3nMy22lLrUtDnJ
        fpEKXiVRNnSTe
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr22163007edd.12.1624290635608;
        Mon, 21 Jun 2021 08:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8mB6ET6QXJ6602FS9T53mFOWuf+6C+0SthHvXV5z2Hgq9JKAtfOCUFepukUKJtB6pMeTqew==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr22162984edd.12.1624290635420;
        Mon, 21 Jun 2021 08:50:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u12sm4935071eje.40.2021.06.21.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:50:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4275118071D; Mon, 21 Jun 2021 17:50:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] bpf: devmap: implement devmap prog
 execution for generic XDP
In-Reply-To: <20210620233200.855534-4-memxor@gmail.com>
References: <20210620233200.855534-1-memxor@gmail.com>
 <20210620233200.855534-4-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 21 Jun 2021 17:50:34 +0200
Message-ID: <87sg1brzcl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> This lifts the restriction on running devmap BPF progs in generic
> redirect mode. To match native XDP behavior, it is invoked right before
> generic_xdp_tx is called, and only supports XDP_PASS/XDP_ABORTED/
> XDP_DROP actions.
>
> We also return 0 even if devmap program drops the packet, as
> semantically redirect has already succeeded and the devmap prog is the
> last point before TX of the packet to device where it can deliver a
> verdict on the packet.
>
> This also means it must take care of freeing the skb, as
> xdp_do_generic_redirect callers only do that in case an error is
> returned.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/devmap.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2a75e6c2d27d..db3ed8b20c8c 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -322,7 +322,8 @@ bool dev_map_can_have_prog(struct bpf_map *map)
>  {
>  	if ((map->map_type == BPF_MAP_TYPE_DEVMAP ||
>  	     map->map_type == BPF_MAP_TYPE_DEVMAP_HASH) &&
> -	    map->value_size != offsetofend(struct bpf_devmap_val, ifindex))
> +	    map->value_size != offsetofend(struct bpf_devmap_val, ifindex) &&
> +	    map->value_size != offsetofend(struct bpf_devmap_val, bpf_prog.fd))
>  		return true;

With this you've basically removed the need for the check that calls
this, so why not just get rid of it entirely? Same thing for cpumap,
instead of updating cpu_map_prog_allowed(), just get rid of it...

-Toke

