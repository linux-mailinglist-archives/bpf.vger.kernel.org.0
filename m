Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEC328332
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhCAQON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 11:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237652AbhCAQKn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 11:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614614929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Az1eLB1rHg/8/WeVTlNLmY71K+hCXtFSkbWggKWns=;
        b=SG1iBUqypvHx+eorg+NJVZ+Lbs/7Ia4Zae4uCuOBOZmIGJnPGu7WjRBfLfObTHr1DMlVIg
        fOiqT9O1j67rnLZW2+I46PiYqAvaQdwUODczYfdsyvfVXxg8FAwS6VFKOCaRNlBVVPy7CI
        depghaxhu0jU31ahXnEayAzz8u0gyDk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-GBXl-fK6PfS_ODVfFuRXpA-1; Mon, 01 Mar 2021 11:08:47 -0500
X-MC-Unique: GBXl-fK6PfS_ODVfFuRXpA-1
Received: by mail-ej1-f71.google.com with SMTP id k16so2668497ejg.9
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 08:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=x9Az1eLB1rHg/8/WeVTlNLmY71K+hCXtFSkbWggKWns=;
        b=mZTUE8lwOtaDu6cpWHP3GCTgse0wCTIF+OPLnQIMYzGeLYf2SM5ObzLZ8u9D0e3E8V
         3d0hFl8CQUJi3/VXbnHOvgiECkWvlNF6od62f9ldSiVhXITRbDrPIIWeN1DkXOCBPWny
         EXT6izg+L8AfHDQHUN1Z8/R8pLWsdJYghrSmvh4LpWusVzTN4sog3msMS+YpdqV95tqu
         6y0LPi6zxThTU9PzRR5tC9U8yrtVxOdYIN2KOnTZ5j5vewKlx7XVv6xdvvxt+YYX294D
         w8LQwHO4OIzCgxdGt3AUsU1Efx2sWImgFzki/Uk17s1H4NlshTWfnAYQyTkLd9GN+dXM
         b+bg==
X-Gm-Message-State: AOAM533k4o1i6WNGcIcylLdS8k7gP5BWpxToRuHUPh/RSaHJpoSZHLUg
        wPd63nHxNP7wY5eLCBJEoSytV6YOgaKdEcQ8OqznPTOArj+W+onzALnEnOqbPv9ow6EV7/Gjkgz
        94GUmL7ytXMbv
X-Received: by 2002:a17:907:2bdd:: with SMTP id gv29mr9410923ejc.259.1614614926161;
        Mon, 01 Mar 2021 08:08:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF8S8eg0HSwJfXlvUN9PBBN0jZ1ufwLzsMeNetL5ks4uJt3dnjx8Ivkh5RDG/ZvfR/7ARW/w==
X-Received: by 2002:a17:907:2bdd:: with SMTP id gv29mr9410887ejc.259.1614614925827;
        Mon, 01 Mar 2021 08:08:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t4sm16351977edw.24.2021.03.01.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 08:08:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 930301800F1; Mon,  1 Mar 2021 17:08:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        maximmi@nvidia.com, andrii@kernel.org
Subject: Re: [PATCH bpf-next 1/2] xsk: update rings for
 load-acquire/store-release semantics
In-Reply-To: <20210301104318.263262-2-bjorn.topel@gmail.com>
References: <20210301104318.263262-1-bjorn.topel@gmail.com>
 <20210301104318.263262-2-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 01 Mar 2021 17:08:43 +0100
Message-ID: <87mtvmx3ec.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Currently, the AF_XDP rings uses smp_{r,w,}mb() fences on the
> kernel-side. By updating the rings for load-acquire/store-release
> semantics, the full barrier on the consumer side can be replaced with
> improved performance as a nice side-effect.
>
> Note that this change does *not* require similar changes on the
> libbpf/userland side, however it is recommended [1].
>
> On x86-64 systems, by removing the smp_mb() on the Rx and Tx side, the
> l2fwd AF_XDP xdpsock sample performance increases by
> 1%. Weakly-ordered platforms, such as ARM64 might benefit even more.
>
> [1] https://lore.kernel.org/bpf/20200316184423.GA14143@willie-the-truck/
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>  net/xdp/xsk_queue.h | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 2823b7c3302d..e24279d8d845 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -47,19 +47,18 @@ struct xsk_queue {
>  	u64 queue_empty_descs;
>  };
>=20=20
> -/* The structure of the shared state of the rings are the same as the
> - * ring buffer in kernel/events/ring_buffer.c. For the Rx and completion
> - * ring, the kernel is the producer and user space is the consumer. For
> - * the Tx and fill rings, the kernel is the consumer and user space is
> - * the producer.
> +/* The structure of the shared state of the rings are a simple
> + * circular buffer, as outlined in
> + * Documentation/core-api/circular-buffers.rst. For the Rx and
> + * completion ring, the kernel is the producer and user space is the
> + * consumer. For the Tx and fill rings, the kernel is the consumer and
> + * user space is the producer.
>   *
>   * producer                         consumer
>   *
> - * if (LOAD ->consumer) {           LOAD ->producer
> - *                    (A)           smp_rmb()       (C)
> + * if (LOAD ->consumer) {  (A)      LOAD.acq ->producer  (C)

Why is LOAD.acq not needed on the consumer side?

-Toke

