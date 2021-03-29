Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242334D224
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2OKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 10:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhC2OKG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Mar 2021 10:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617027005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXWEzN5hel6qKFRe0kyPUjyPQvN9/cHzcmTWECvhL/g=;
        b=X9VPEZabQ+NsCQ/eIG3SCHIKtb8+yDHlfh0FxC50hAX2uXnsLd7u6fqHWFjpnRS2O64KgV
        BMR8AH4sK5f/6e4xGDKLCCg9efqO4sGblVVso88+IeC7tyMxKuUdVzXGhGXp0e3Kr4/swj
        z5t88popOxDZmxffuuEkWAWyY6baVUU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-uBNsGjDaOrmTTSrIRBIdPQ-1; Mon, 29 Mar 2021 10:09:36 -0400
X-MC-Unique: uBNsGjDaOrmTTSrIRBIdPQ-1
Received: by mail-ej1-f69.google.com with SMTP id h14so5860871ejg.7
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 07:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NXWEzN5hel6qKFRe0kyPUjyPQvN9/cHzcmTWECvhL/g=;
        b=ojtuWFoxiCVOvrefpBK+pZCAt+mNbbdlOAsXGyNsNM2CS0PwhyY8tYVPVbLWU2BF2X
         m7SihKWMweoqg5e28Fwx1dGZ3cX8Ggf7PPqt9mE63WW5noaYyn6a2tVIaFVmxvfZhKtt
         nO2DjhB7Us9+MuVL3QJrL5UDGjP7ChyhqDNS+jeJns1cfaJXCED6ijog4+fwwlP5g0IB
         gOBDVffdevVAKbJSKfz2XeyGJrNaqFuPv7DFg3FYaMjWdGmVA7RRTnGZufqECtL6mczo
         q5fYycyVzP6fjueQoqm1QPafYQ4tLQ6qjVPHyy1c2j2cCPXE1aH7WacsVj70Pzu0UcSZ
         VeGA==
X-Gm-Message-State: AOAM531++QHHDiU1Cjjit2p6mcLEmWgZQ71P4+AtbFdEIdGzp884snZ4
        DTPJMpVoL5CxPWr8z0Gf1PYZpDkowyxdqfpVjjQ4ohqrp6FFffpxdQLd0QESA5B2cNZ9o0vrbg4
        Akj/m4P9SDLY6
X-Received: by 2002:a05:6402:1c1b:: with SMTP id ck27mr29111509edb.223.1617026975374;
        Mon, 29 Mar 2021 07:09:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ53PH4Lg/sbUhnD4A8n69SQtos7TzyMbhJjOD9LqIGJHjztzNmf9I+BQIc3EjD3JkMaxgrQ==
X-Received: by 2002:a05:6402:1c1b:: with SMTP id ck27mr29111487edb.223.1617026975166;
        Mon, 29 Mar 2021 07:09:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p3sm8450262ejd.7.2021.03.29.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:09:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 172DB180293; Mon, 29 Mar 2021 16:09:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, andrii@kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, ciara.loftus@intel.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH v4 bpf-next 06/17] libbpf: xsk: use bpf_link
In-Reply-To: <20210329131401.GA9069@ranger.igk.intel.com>
References: <20210326230938.49998-1-maciej.fijalkowski@intel.com>
 <20210326230938.49998-7-maciej.fijalkowski@intel.com>
 <87o8f2te2f.fsf@toke.dk> <20210329131401.GA9069@ranger.igk.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 29 Mar 2021 16:09:33 +0200
Message-ID: <87zgymrqzm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Mon, Mar 29, 2021 at 01:05:44PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > Currently, if there are multiple xdpsock instances running on a single
>> > interface and in case one of the instances is terminated, the rest of
>> > them are left in an inoperable state due to the fact of unloaded XDP
>> > prog from interface.
>> >
>> > Consider the scenario below:
>> >
>> > // load xdp prog and xskmap and add entry to xskmap at idx 10
>> > $ sudo ./xdpsock -i ens801f0 -t -q 10
>> >
>> > // add entry to xskmap at idx 11
>> > $ sudo ./xdpsock -i ens801f0 -t -q 11
>> >
>> > terminate one of the processes and another one is unable to work due to
>> > the fact that the XDP prog was unloaded from interface.
>> >
>> > To address that, step away from setting bpf prog in favour of bpf_link.
>> > This means that refcounting of BPF resources will be done automatically
>> > by bpf_link itself.
>> >
>> > Provide backward compatibility by checking if underlying system is
>> > bpf_link capable. Do this by looking up/creating bpf_link on loopback
>> > device. If it failed in any way, stick with netlink-based XDP prog.
>> > therwise, use bpf_link-based logic.
>> >
>> > When setting up BPF resources during xsk socket creation, check whether
>> > bpf_link for a given ifindex already exists via set of calls to
>> > bpf_link_get_next_id -> bpf_link_get_fd_by_id -> bpf_obj_get_info_by_fd
>> > and comparing the ifindexes from bpf_link and xsk socket.
>> >
>> > For case where resources exist but they are not AF_XDP related, bail o=
ut
>> > and ask user to remove existing prog and then retry.
>> >
>> > Lastly, do a bit of refactoring within __xsk_setup_xdp_prog and pull o=
ut
>> > existing code branches based on prog_id value onto separate functions
>> > that are responsible for resource initialization if prog_id was 0 and
>> > for lookup existing resources for non-zero prog_id as that implies that
>> > XDP program is present on the underlying net device. This in turn makes
>> > it easier to follow, especially the teardown part of both branches.
>> >
>> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>=20
>> The logic is much improved in this version! A few smallish issues below:
>
> Glad to hear that!
>
>>=20
>> > ---
>> >  tools/lib/bpf/xsk.c | 259 ++++++++++++++++++++++++++++++++++++--------
>> >  1 file changed, 214 insertions(+), 45 deletions(-)
>> >
>> > diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
>> > index 526fc35c0b23..c75067f0035f 100644
>> > --- a/tools/lib/bpf/xsk.c
>> > +++ b/tools/lib/bpf/xsk.c
>> > @@ -28,6 +28,7 @@
>> >  #include <sys/mman.h>
>> >  #include <sys/socket.h>
>> >  #include <sys/types.h>
>> > +#include <linux/if_link.h>
>> >=20=20
>> >  #include "bpf.h"
>> >  #include "libbpf.h"
>> > @@ -70,8 +71,10 @@ struct xsk_ctx {
>> >  	int ifindex;
>> >  	struct list_head list;
>> >  	int prog_fd;
>> > +	int link_fd;
>> >  	int xsks_map_fd;
>> >  	char ifname[IFNAMSIZ];
>> > +	bool has_bpf_link;
>> >  };
>> >=20=20
>> >  struct xsk_socket {
>> > @@ -409,7 +412,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xs=
k)
>> >  	static const int log_buf_size =3D 16 * 1024;
>> >  	struct xsk_ctx *ctx =3D xsk->ctx;
>> >  	char log_buf[log_buf_size];
>> > -	int err, prog_fd;
>> > +	int prog_fd;
>> >=20=20
>> >  	/* This is the fallback C-program:
>> >  	 * SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
>> > @@ -499,14 +502,43 @@ static int xsk_load_xdp_prog(struct xsk_socket *=
xsk)
>> >  		return prog_fd;
>> >  	}
>> >=20=20
>> > -	err =3D bpf_set_link_xdp_fd(xsk->ctx->ifindex, prog_fd,
>> > -				  xsk->config.xdp_flags);
>> > +	ctx->prog_fd =3D prog_fd;
>> > +	return 0;
>> > +}
>> > +
>> > +static int xsk_create_bpf_link(struct xsk_socket *xsk)
>> > +{
>> > +	/* bpf_link only accepts XDP_FLAGS_MODES, but xsk->config.xdp_flags
>> > +	 * might have set XDP_FLAGS_UPDATE_IF_NOEXIST
>> > +	 */
>> > +	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts,
>> > +			    .flags =3D (xsk->config.xdp_flags & XDP_FLAGS_MODES));
>>=20
>> This will silently suppress any new flags as well; that's not a good
>> idea. Rather mask out the particular flag (UPDATE_IF_NOEXIST) and pass
>> everything else through so the kernel can reject invalid ones.
>
> I'd say it's fine as it matches the check:
>
> 	/* link supports only XDP mode flags */
> 	if (link && (flags & ~XDP_FLAGS_MODES)) {
> 		NL_SET_ERR_MSG(extack, "Invalid XDP flags for BPF link attachment");
> 		return -EINVAL;
> 	}
>
> from dev_xdp_attach() in net/core/dev.c ?

Yeah, it does today. But what happens when the kernel learns to accept a
new flag?

Also, you're masking the error on an invalid flag. If, in the future,
the kernel learns to handle a new flag, that check in the kernel will
change to accept that new flag. But if userspace tries to pass that to
and old kernel, they'll get back an EINVAL. This can be used to detect
whether the kernel doesn't support the flag, and can if not, userspace
can fall back and do something different.

Whereas with your code, you're just silently zeroing out the invalid
flag, so the caller will have no way to detect whether the flag works
or not...

-Toke

