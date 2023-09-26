Return-Path: <bpf+bounces-10905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE167AF5AF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 23:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E99ED282FED
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C14A52F;
	Tue, 26 Sep 2023 21:26:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F4374CE
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 21:26:34 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AC903F
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:26:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0dd156e5so199420747b3.3
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695763591; x=1696368391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M0ZxDhPpbzbmTdpjKq/EH6B6II7eIRIx4eN4Kr09go=;
        b=3bGh7LRCdC/lgcxFPQQIjN00i2Ekfksi7wMia56EPExeJinZTvY2ZaMoyyEKlThOuj
         IkFme7qliWnqCVt/b6GOcouTZBKuYU3PtdWbZucM0pceKHSS62e9kGAm06gzvnhP0J+M
         JS6sDG8/Ns1+AshDvPjrbmIwjEOlzoHp45KrEz4Z2tmYvAyYDlqcZniBTlRFQZGiRT+4
         LE+O9LQ/T7/rndrQRlIuAYoNe+qqA1f0gBoZlzyRSSu7rhdmAIWWK20+njNO2AYarsrA
         IELNQ6E7pdzk6jsXB4zTWDk5MS++Mkycq6PWTqwnddwvaNUiKOeY3Yy/dzRZHiolSycf
         Lgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763591; x=1696368391;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1M0ZxDhPpbzbmTdpjKq/EH6B6II7eIRIx4eN4Kr09go=;
        b=P2ek/gndnCqP3k23Ue2O5s+SX4VwyQ5Gzbjv33YmSu/OXBfw+CwvQWYfJ0Ev9qjI4V
         rxOkVqBGlQ2fDUhZJCe8gti0PsnNt8qiGWKkU65qtdftMoEHYZTmLWKgRLd4ugNtExji
         QGAtwRR94BFqHcK/DIB7qDZblf7x5dg3BVFyHiCP7IcPK/Td4c31SSsRyHEgmP024oqx
         kQ47TtFNsNMUZG334Oa6cI+MrX1u2bc4o7FWydzawRdmtkCl2LVIwPHSq1vU4awm7HJE
         7/60fGLqJwITWg8UFrkIHp7j9KAjTPrJ2efVZJcsgkAcSE7y9zEClV0WAifNdacvROVI
         hclg==
X-Gm-Message-State: AOJu0YzrtBDkA9yyMgp8hsZTmtRqJIx3LkZPYGhd+PbUTkpqp0zqJgNV
	KJ3qnPI/rH651oUb4D2DPg1N1Ak=
X-Google-Smtp-Source: AGHT+IEQV9RjRxyay9q2R34lZnRBdbz5E0qy/hCrIJRCmAeZHQblXVs/TIZI/mbc9n0egaw0WBtVQOg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae46:0:b0:584:41a6:6cd8 with SMTP id
 g6-20020a81ae46000000b0058441a66cd8mr1754ywk.8.1695763591286; Tue, 26 Sep
 2023 14:26:31 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:26:29 -0700
In-Reply-To: <20230926055913.9859-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-2-daniel@iogearbox.net>
Message-ID: <ZRNMhVfuqPrK3J6O@google.com>
Subject: Re: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/26, Daniel Borkmann wrote:
> This work adds a new, minimal BPF-programmable device called "meta" we
> recently presented at LSF/MM/BPF. The latter name derives from the Greek
> =CE=BC=CE=B5=CF=84=CE=AC, encompassing a wide array of meanings such as "=
on top of", "beyond".
> Given business logic is defined by BPF, this device can have many meaning=
s.
> The core idea is that BPF programs are executed within the drivers xmit
> routine and therefore e.g. in case of containers/Pods moving BPF processi=
ng
> closer to the source.
>=20
> One of the goals was that in case of Pod egress traffic, this allows to
> move BPF programs from hostns tcx ingress into the device itself, providi=
ng
> earlier drop or forward mechanisms, for example, if the BPF program
> determines that the skb must be sent out of the node, then a redirect to
> the physical device can take place directly without going through per-CPU
> backlog queue. This helps to shift processing for such traffic from softi=
rq
> to process context, leading to better scheduling decisions and better
> performance.
>=20
> In this initial version, the meta device ships as a pair, but we plan to
> extend this further so it can also operate in single device mode. The pai=
r
> comes with a primary and a peer device. Only the primary device, typicall=
y
> residing in hostns, can manage BPF programs for itself and its peer. The
> peer device is designated for containers/Pods and cannot attach/detach
> BPF programs. Upon the device creation, the user can set the default poli=
cy
> to 'forward' or 'drop' for the case when no BPF program is attached.
>=20
> Additionally, the device can be operated in L3 (default) or L2 mode. The
> management of BPF programs is done via bpf_mprog, so that multi-attach is
> supported right from the beginning with similar API/dependency controls a=
s
> tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add generic
> attach/detach/query API for multi-progs"). tc BPF compatibility is provid=
ed,
> so that existing programs can be easily migrated.
>=20
> Going forward, we plan to use meta devices in Cilium as the main device t=
ype
> for connecting Pods. They will be operated in L3 mode in order to simplif=
y
> a Pod's neighbor management and the peer will operate in default drop mod=
e,
> so that no traffic is leaving between the time when a Pod is brought up b=
y
> the CNI plugin and programs attached by the agent. Additionally, the prog=
rams
> we attach via tcx on the physical devices are using bpf_redirect_peer()
> for inbound traffic into meta device, hence the latter also supporting th=
e
> ndo_get_peer_dev callback. Similarly, we use bpf_redirect_neigh() for the
> way out, pushing to phys device directly. Also, BIG TCP is supported on m=
eta
> device. For the follow-up work in single device mode, we plan to convert
> Cilium's cilium_host/_net devices into a single one.
>=20
> An extensive test suite for checking device operations and the BPF progra=
m
> and link management API comes as BPF selftests in this series.
>=20
> Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/borkmann/iproute2/commits/pr/meta
> Link: http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkman=
n.pdf (24ff.)
> ---
>  MAINTAINERS                    |   9 +
>  drivers/net/Kconfig            |   9 +
>  drivers/net/Makefile           |   1 +
>  drivers/net/meta.c             | 734 +++++++++++++++++++++++++++++++++
>  include/linux/netdevice.h      |   2 +
>  include/net/meta.h             |  31 ++
>  include/uapi/linux/bpf.h       |   2 +
>  include/uapi/linux/if_link.h   |  25 ++
>  kernel/bpf/syscall.c           |  30 +-
>  tools/include/uapi/linux/bpf.h |   2 +
>  10 files changed, 840 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/meta.c
>  create mode 100644 include/net/meta.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8985a1b0b5ee..ec3edd4caa56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3774,6 +3774,15 @@ L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	tools/lib/bpf/
> =20
> +BPF [META]
> +M:	Daniel Borkmann <daniel@iogearbox.net>
> +M:	Nikolay Aleksandrov <razor@blackwall.org>
> +L:	bpf@vger.kernel.org
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	drivers/net/meta.c
> +F:	include/net/meta.h
> +
>  BPF [MISC]
>  L:	bpf@vger.kernel.org
>  S:	Odd Fixes
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 44eeb5d61ba9..9959cdd50b0b 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -448,6 +448,15 @@ config NLMON
>  	  diagnostics, etc. This is mostly intended for developers or support
>  	  to debug netlink issues. If unsure, say N.
> =20
> +config META
> +	bool "BPF-programmable meta device"
> +	depends on BPF_SYSCALL
> +	help
> +	  The virtual meta devices can be created in pairs and used to connect
> +	  two network namespaces. A BPF program can be attached to the device(s=
)
> +	  which then gets executed on transmission to implement the driver
> +	  internal logic.
> +
>  config NET_VRF
>  	tristate "Virtual Routing and Forwarding (Lite)"
>  	depends on IP_MULTIPLE_TABLES
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index e26f98f897c5..18eabeb78ece 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO) +=3D mdio.o
>  obj-$(CONFIG_NET) +=3D loopback.o
>  obj-$(CONFIG_NETDEV_LEGACY_INIT) +=3D Space.o
>  obj-$(CONFIG_NETCONSOLE) +=3D netconsole.o
> +obj-$(CONFIG_META) +=3D meta.o
>  obj-y +=3D phy/
>  obj-y +=3D pse-pd/
>  obj-y +=3D mdio/
> diff --git a/drivers/net/meta.c b/drivers/net/meta.c
> new file mode 100644
> index 000000000000..e464f547b0a6
> --- /dev/null
> +++ b/drivers/net/meta.c
> @@ -0,0 +1,734 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include <linux/netdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/etherdevice.h>
> +#include <linux/filter.h>
> +#include <linux/netfilter_netdev.h>
> +#include <linux/bpf_mprog.h>
> +
> +#include <net/meta.h>
> +#include <net/dst.h>
> +#include <net/tcx.h>
> +
> +#define DRV_NAME	"meta"
> +#define DRV_VERSION	"1.0"
> +
> +struct meta {
> +	/* Needed in fast-path */
> +	struct net_device __rcu *peer;
> +	struct bpf_mprog_entry __rcu *active;
> +	enum meta_action policy;
> +	struct bpf_mprog_bundle	bundle;
> +	/* Needed in slow-path */
> +	enum meta_mode mode;
> +	bool primary;
> +	u32 headroom;
> +};
> +
> +static void meta_scrub_minimum(struct sk_buff *skb)
> +{

[..]

> +	skb->skb_iif =3D 0;
> +	skb->ignore_df =3D 0;
> +	skb->priority =3D 0;
> +	skb_dst_drop(skb);
> +	skb_ext_reset(skb);
> +	nf_reset_ct(skb);
> +	nf_reset_trace(skb);
> +	nf_skip_egress(skb, true);
> +	ipvs_reset(skb);

This looks similar to skb_scrub_packet; what's the difference?

