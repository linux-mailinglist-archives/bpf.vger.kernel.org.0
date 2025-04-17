Return-Path: <bpf+bounces-56084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30251A91108
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293BC189E0FC
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922A198E81;
	Thu, 17 Apr 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evE6qtGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E402DFA56;
	Thu, 17 Apr 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852325; cv=none; b=CeNo6H3TlPq5wYZYdmb6gUAnGyHZEsvRQfmV8IHebR8RzPMO3hj2kRWUYHhrgTyEPSi+0/DEg9heoUclLHEVEsjQL8aDGyo9JFvwhYbxIvNViWa/Axaoqmbv4WckT7cBcviftErqsKGVS+96yTVxAVpG2uPqIPNyUw20kEv73p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852325; c=relaxed/simple;
	bh=GO3AJpVFunxvBK7dsqnYA7s+56ZMAyRjuxtWDGNlUhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ89VNQLVypiRBuIyCtJm+JomS3o/FGALVCWir8InZKi8w5Fz6w3FUHdzHYzznDI3/mFmgrhwb6u9G+3ETg/o6j6IuwdWkr4+7zWhQbKB/ukmDmvirbp/hVuwWT9zpCTzWcWSXiYySpR+XlgC0Z/h+j2+SMLnXt0Nq0iIV5PSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evE6qtGY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so1064305ab.0;
        Wed, 16 Apr 2025 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744852322; x=1745457122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxfeyRvZDJsbI3j1YRsqjPmyiynKohpWoynXwrM8XMg=;
        b=evE6qtGYmbB/9Iyaf88+vNYc2caxM9JU6ppj77gsbtTupbJHSHU2XZ+shJwyQwzRJ2
         B2L/PTucSNAwhngdxNOQhSzxh4jf4E2Eq/iKBl0/nwSU+CNSxNhJtewXdZvyrjibqtj6
         7WvEUmG3iZvAJ2ha3QaHUSfFunnVVyouqw58broisq4qDzwbS6+eIIZi6vrOb7mRaxct
         qRQrDvNkW/5eirguCyjitbhmG13iKA5Qfv/IB9F/PZjDYFDwDP1kvGMhQj4xOmLccTD5
         FE9DouQuiawpDw1FhDzniiLyXUUWjQWoTlJ0F6DiQAd4X/0jz8eLlorL/z9FhNEMIoHH
         dHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744852322; x=1745457122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxfeyRvZDJsbI3j1YRsqjPmyiynKohpWoynXwrM8XMg=;
        b=t+wlRf7JCKtMj9LXdqBB3MzaMjvWJ9RRWfzyEBfZexQb+QvB5hG5HL44yyISh1ex+y
         A6HyRlBGKD4X4V6va/5Br/grQAMsflABj2YccJz4/yT2lhhOOP7BFsZBdP555H6JiS9N
         82KXwQmwkjFhAbP8LLGvCIHUTFvsbRXGGVxUfU07x+dU8K4AH4/E/EXUXRYhEtLwOAni
         AQB65mAHpDCiYx4mktM+4ofqksL7sqLH8y7z3LZQ0ItOEKvQvBowZPecEyWnLYnA1yQ4
         wKG+hss3kiezMek0DhZbXwp8P01E80pcREkakDjwfNLjiifD+8nhrn1YCqQ8ASxIoTHx
         EJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUH5cHZmracsSAWNdffpglWLi1LkiuzB+BUSSwOZc/PdK9FsQZTRy0VwFa5qk+wuVT8gPI=@vger.kernel.org, AJvYcCXhyBaNcwPc82a3kCcu65djMHMjnRskN+0jc6eMTvCnGZp5UbWawCG47RU5CmbylpLVghQ05uk+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6TsQbcd4VoZqXp3vsUr36tcSNgU9w23kTqjQ2bPhnmM+8oEm
	HlaEIboRhWq7S4qA2h9eia8jlXJCX9q5Ykj0jm20A7JnMxOmmxPgmcmpco3QiINLOcqgj6qH/mk
	TFRSFUSH3JDsTvMbZDr1eVJRRxwM=
X-Gm-Gg: ASbGncujt8cyYVwJPndx+bsjOE1gfGiNenYRu7V+STQ2J3Bn/SdCs/ety4+6AFYi32T
	rn2cgYzlFRq49TrBPuvE26RmtRqW/CmJqdPkjTH4gJyroSGHWx89tnf7TGou11nUuGG8Shuarju
	kU81YfNMLVLqjFODOeYYEo9A==
X-Google-Smtp-Source: AGHT+IGw7D9qBhV7f2Sy70w2zVI5mZ8g9B8xbmTzBbqnV2lgkkMRXOE7B5YDssmjnheR4kqSU5b4jEDIt+AIOudq2JM=
X-Received: by 2002:a05:6e02:2187:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d815af827bmr37881615ab.4.1744852321943; Wed, 16 Apr 2025
 18:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416200840.1338195-1-kuba@kernel.org>
In-Reply-To: <20250416200840.1338195-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Apr 2025 09:11:25 +0800
X-Gm-Features: ATxdqUFOZNa5rkfPD9mR4OQ5qZeN-zdi7EyEgJK8mycyGIaFbvM83egzO7ZgHMk
Message-ID: <CAL+tcoDAyaiwCVp020vfHjtV87ciOhm8PTure5iGy5ZYrX0uJw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add UAPI to the header guard in various
 network headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	m.grzeschik@pengutronix.de, jv@jvosburgh.net, willemdebruijn.kernel@gmail.com, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	nhorman@tuxdriver.com, kernelxing@tencent.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, idosch@nvidia.com, 
	gnault@redhat.com, petrm@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 4:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> fib_rule, ip6_tunnel, and a whole lot of if_* headers lack the customary
> _UAPI in the header guard. Without it YNL build can't protect from in tre=
e
> and system headers both getting included. YNL doesn't need most of these
> but it's annoying to have to fix them one by one.
>
> Note that header installation strips this _UAPI prefix so this should
> result in no change to the end user.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

> ---
> CC: m.grzeschik@pengutronix.de
> CC: jv@jvosburgh.net
> CC: willemdebruijn.kernel@gmail.com
> CC: magnus.karlsson@intel.com
> CC: maciej.fijalkowski@intel.com
> CC: nhorman@tuxdriver.com
> CC: kernelxing@tencent.com
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: idosch@nvidia.com
> CC: gnault@redhat.com
> CC: petrm@nvidia.com
> CC: bpf@vger.kernel.org
> ---
>  include/uapi/linux/fib_rules.h    | 4 ++--
>  include/uapi/linux/if_addr.h      | 4 ++--
>  include/uapi/linux/if_addrlabel.h | 4 ++--
>  include/uapi/linux/if_alg.h       | 6 +++---
>  include/uapi/linux/if_arcnet.h    | 6 +++---
>  include/uapi/linux/if_bonding.h   | 6 +++---
>  include/uapi/linux/if_fc.h        | 6 +++---
>  include/uapi/linux/if_hippi.h     | 6 +++---
>  include/uapi/linux/if_packet.h    | 4 ++--
>  include/uapi/linux/if_plip.h      | 4 ++--
>  include/uapi/linux/if_slip.h      | 4 ++--
>  include/uapi/linux/if_x25.h       | 6 +++---
>  include/uapi/linux/if_xdp.h       | 6 +++---
>  include/uapi/linux/ip6_tunnel.h   | 4 ++--
>  include/uapi/linux/net_dropmon.h  | 4 ++--
>  include/uapi/linux/net_tstamp.h   | 6 +++---
>  include/uapi/linux/netlink_diag.h | 4 ++--
>  include/uapi/linux/pkt_cls.h      | 4 ++--
>  include/uapi/linux/pkt_sched.h    | 4 ++--
>  19 files changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rule=
s.h
> index 2df6e4035d50..418c4be697ad 100644
> --- a/include/uapi/linux/fib_rules.h
> +++ b/include/uapi/linux/fib_rules.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_FIB_RULES_H
> -#define __LINUX_FIB_RULES_H
> +#ifndef _UAPI__LINUX_FIB_RULES_H
> +#define _UAPI__LINUX_FIB_RULES_H
>
>  #include <linux/types.h>
>  #include <linux/rtnetlink.h>
> diff --git a/include/uapi/linux/if_addr.h b/include/uapi/linux/if_addr.h
> index 1c392dd95a5e..aa7958b4e41d 100644
> --- a/include/uapi/linux/if_addr.h
> +++ b/include/uapi/linux/if_addr.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_IF_ADDR_H
> -#define __LINUX_IF_ADDR_H
> +#ifndef _UAPI__LINUX_IF_ADDR_H
> +#define _UAPI__LINUX_IF_ADDR_H
>
>  #include <linux/types.h>
>  #include <linux/netlink.h>
> diff --git a/include/uapi/linux/if_addrlabel.h b/include/uapi/linux/if_ad=
drlabel.h
> index d1f5974c76e1..e69db764fbba 100644
> --- a/include/uapi/linux/if_addrlabel.h
> +++ b/include/uapi/linux/if_addrlabel.h
> @@ -8,8 +8,8 @@
>   *     YOSHIFUJI Hideaki @ USAGI/WIDE <yoshfuji@linux-ipv6.org>
>   */
>
> -#ifndef __LINUX_IF_ADDRLABEL_H
> -#define __LINUX_IF_ADDRLABEL_H
> +#ifndef _UAPI__LINUX_IF_ADDRLABEL_H
> +#define _UAPI__LINUX_IF_ADDRLABEL_H
>
>  #include <linux/types.h>
>
> diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
> index 0824fbc026a1..b35871cbeed7 100644
> --- a/include/uapi/linux/if_alg.h
> +++ b/include/uapi/linux/if_alg.h
> @@ -11,8 +11,8 @@
>   *
>   */
>
> -#ifndef _LINUX_IF_ALG_H
> -#define _LINUX_IF_ALG_H
> +#ifndef _UAPI_LINUX_IF_ALG_H
> +#define _UAPI_LINUX_IF_ALG_H
>
>  #include <linux/types.h>
>
> @@ -58,4 +58,4 @@ struct af_alg_iv {
>  #define ALG_OP_DECRYPT                 0
>  #define ALG_OP_ENCRYPT                 1
>
> -#endif /* _LINUX_IF_ALG_H */
> +#endif /* _UAPI_LINUX_IF_ALG_H */
> diff --git a/include/uapi/linux/if_arcnet.h b/include/uapi/linux/if_arcne=
t.h
> index b122cfac7128..473569eaf692 100644
> --- a/include/uapi/linux/if_arcnet.h
> +++ b/include/uapi/linux/if_arcnet.h
> @@ -14,8 +14,8 @@
>   *              2 of the License, or (at your option) any later version.
>   */
>
> -#ifndef _LINUX_IF_ARCNET_H
> -#define _LINUX_IF_ARCNET_H
> +#ifndef _UAPI_LINUX_IF_ARCNET_H
> +#define _UAPI_LINUX_IF_ARCNET_H
>
>  #include <linux/types.h>
>  #include <linux/if_ether.h>
> @@ -127,4 +127,4 @@ struct archdr {
>         } soft;
>  };
>
> -#endif                         /* _LINUX_IF_ARCNET_H */
> +#endif                         /* _UAPI_LINUX_IF_ARCNET_H */
> diff --git a/include/uapi/linux/if_bonding.h b/include/uapi/linux/if_bond=
ing.h
> index d174914a837d..3bcc03f3aa4f 100644
> --- a/include/uapi/linux/if_bonding.h
> +++ b/include/uapi/linux/if_bonding.h
> @@ -41,8 +41,8 @@
>   *      - added definitions for various XOR hashing policies
>   */
>
> -#ifndef _LINUX_IF_BONDING_H
> -#define _LINUX_IF_BONDING_H
> +#ifndef _UAPI_LINUX_IF_BONDING_H
> +#define _UAPI_LINUX_IF_BONDING_H
>
>  #include <linux/if.h>
>  #include <linux/types.h>
> @@ -152,4 +152,4 @@ enum {
>  };
>  #define BOND_3AD_STAT_MAX (__BOND_3AD_STAT_MAX - 1)
>
> -#endif /* _LINUX_IF_BONDING_H */
> +#endif /* _UAPI_LINUX_IF_BONDING_H */
> diff --git a/include/uapi/linux/if_fc.h b/include/uapi/linux/if_fc.h
> index 3e3173282cc3..ff5ab92d16c2 100644
> --- a/include/uapi/linux/if_fc.h
> +++ b/include/uapi/linux/if_fc.h
> @@ -18,8 +18,8 @@
>   *             as published by the Free Software Foundation; either vers=
ion
>   *             2 of the License, or (at your option) any later version.
>   */
> -#ifndef _LINUX_IF_FC_H
> -#define _LINUX_IF_FC_H
> +#ifndef _UAPI_LINUX_IF_FC_H
> +#define _UAPI_LINUX_IF_FC_H
>
>  #include <linux/types.h>
>
> @@ -49,4 +49,4 @@ struct fcllc {
>         __be16 ethertype;               /* ether type field */
>  };
>
> -#endif /* _LINUX_IF_FC_H */
> +#endif /* _UAPI_LINUX_IF_FC_H */
> diff --git a/include/uapi/linux/if_hippi.h b/include/uapi/linux/if_hippi.=
h
> index 785a1452a66c..42c4ffd11dae 100644
> --- a/include/uapi/linux/if_hippi.h
> +++ b/include/uapi/linux/if_hippi.h
> @@ -20,8 +20,8 @@
>   *             2 of the License, or (at your option) any later version.
>   */
>
> -#ifndef _LINUX_IF_HIPPI_H
> -#define _LINUX_IF_HIPPI_H
> +#ifndef _UAPI_LINUX_IF_HIPPI_H
> +#define _UAPI_LINUX_IF_HIPPI_H
>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> @@ -151,4 +151,4 @@ struct hippi_hdr {
>         struct hippi_snap_hdr   snap;
>  } __attribute__((packed));
>
> -#endif /* _LINUX_IF_HIPPI_H */
> +#endif /* _UAPI_LINUX_IF_HIPPI_H */
> diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packe=
t.h
> index 1d2718dd9647..6cd1d7a41dfb 100644
> --- a/include/uapi/linux/if_packet.h
> +++ b/include/uapi/linux/if_packet.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_IF_PACKET_H
> -#define __LINUX_IF_PACKET_H
> +#ifndef _UAPI__LINUX_IF_PACKET_H
> +#define _UAPI__LINUX_IF_PACKET_H
>
>  #include <asm/byteorder.h>
>  #include <linux/types.h>
> diff --git a/include/uapi/linux/if_plip.h b/include/uapi/linux/if_plip.h
> index 495a366112f2..054d86a9c6e6 100644
> --- a/include/uapi/linux/if_plip.h
> +++ b/include/uapi/linux/if_plip.h
> @@ -9,8 +9,8 @@
>   *
>   */
>
> -#ifndef _LINUX_IF_PLIP_H
> -#define _LINUX_IF_PLIP_H
> +#ifndef _UAPI_LINUX_IF_PLIP_H
> +#define _UAPI_LINUX_IF_PLIP_H
>
>  #include <linux/sockios.h>
>
> diff --git a/include/uapi/linux/if_slip.h b/include/uapi/linux/if_slip.h
> index 65937be53103..299bf7adc862 100644
> --- a/include/uapi/linux/if_slip.h
> +++ b/include/uapi/linux/if_slip.h
> @@ -6,8 +6,8 @@
>   *     KISS TNC driver.
>   */
>
> -#ifndef __LINUX_SLIP_H
> -#define __LINUX_SLIP_H
> +#ifndef _UAPI__LINUX_SLIP_H
> +#define _UAPI__LINUX_SLIP_H
>
>  #define                SL_MODE_SLIP            0
>  #define                SL_MODE_CSLIP           1
> diff --git a/include/uapi/linux/if_x25.h b/include/uapi/linux/if_x25.h
> index 3a5938e38370..861cfa983db4 100644
> --- a/include/uapi/linux/if_x25.h
> +++ b/include/uapi/linux/if_x25.h
> @@ -13,8 +13,8 @@
>   *  GNU General Public License for more details.
>   */
>
> -#ifndef _IF_X25_H
> -#define _IF_X25_H
> +#ifndef _UAPI_IF_X25_H
> +#define _UAPI_IF_X25_H
>
>  #include <linux/types.h>
>
> @@ -24,4 +24,4 @@
>  #define X25_IFACE_DISCONNECT   0x02
>  #define X25_IFACE_PARAMS       0x03
>
> -#endif /* _IF_X25_H */
> +#endif /* _UAPI_IF_X25_H */
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 42869770776e..44f2bb93e7e6 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -7,8 +7,8 @@
>   *           Magnus Karlsson <magnus.karlsson@intel.com>
>   */
>
> -#ifndef _LINUX_IF_XDP_H
> -#define _LINUX_IF_XDP_H
> +#ifndef _UAPI_LINUX_IF_XDP_H
> +#define _UAPI_LINUX_IF_XDP_H
>
>  #include <linux/types.h>
>
> @@ -180,4 +180,4 @@ struct xdp_desc {
>  /* TX packet carries valid metadata. */
>  #define XDP_TX_METADATA (1 << 1)
>
> -#endif /* _LINUX_IF_XDP_H */
> +#endif /* _UAPI_LINUX_IF_XDP_H */
> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tun=
nel.h
> index 0245269b037c..85182a839d42 100644
> --- a/include/uapi/linux/ip6_tunnel.h
> +++ b/include/uapi/linux/ip6_tunnel.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _IP6_TUNNEL_H
> -#define _IP6_TUNNEL_H
> +#ifndef _UAPI_IP6_TUNNEL_H
> +#define _UAPI_IP6_TUNNEL_H
>
>  #include <linux/types.h>
>  #include <linux/if.h>          /* For IFNAMSIZ. */
> diff --git a/include/uapi/linux/net_dropmon.h b/include/uapi/linux/net_dr=
opmon.h
> index 84f622a66a7a..9dd41c2f58a6 100644
> --- a/include/uapi/linux/net_dropmon.h
> +++ b/include/uapi/linux/net_dropmon.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __NET_DROPMON_H
> -#define __NET_DROPMON_H
> +#ifndef _UAPI__NET_DROPMON_H
> +#define _UAPI__NET_DROPMON_H
>
>  #include <linux/types.h>
>  #include <linux/netlink.h>
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index 383213de612a..a93e6ea37fb3 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -7,8 +7,8 @@
>   *
>   */
>
> -#ifndef _NET_TIMESTAMPING_H
> -#define _NET_TIMESTAMPING_H
> +#ifndef _UAPI_NET_TIMESTAMPING_H
> +#define _UAPI_NET_TIMESTAMPING_H
>
>  #include <linux/types.h>
>  #include <linux/socket.h>   /* for SO_TIMESTAMPING */
> @@ -216,4 +216,4 @@ struct sock_txtime {
>         __u32                   flags;  /* as defined by enum txtime_flag=
s */
>  };
>
> -#endif /* _NET_TIMESTAMPING_H */
> +#endif /* _UAPI_NET_TIMESTAMPING_H */
> diff --git a/include/uapi/linux/netlink_diag.h b/include/uapi/linux/netli=
nk_diag.h
> index dfa61be43d2f..ff28200204bb 100644
> --- a/include/uapi/linux/netlink_diag.h
> +++ b/include/uapi/linux/netlink_diag.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __NETLINK_DIAG_H__
> -#define __NETLINK_DIAG_H__
> +#ifndef _UAPI__NETLINK_DIAG_H__
> +#define _UAPI__NETLINK_DIAG_H__
>
>  #include <linux/types.h>
>
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 2c32080416b5..490821364165 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_PKT_CLS_H
> -#define __LINUX_PKT_CLS_H
> +#ifndef _UAPI__LINUX_PKT_CLS_H
> +#define _UAPI__LINUX_PKT_CLS_H
>
>  #include <linux/types.h>
>  #include <linux/pkt_sched.h>
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sche=
d.h
> index 25a9a47001cd..9ea874395717 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_PKT_SCHED_H
> -#define __LINUX_PKT_SCHED_H
> +#ifndef _UAPI__LINUX_PKT_SCHED_H
> +#define _UAPI__LINUX_PKT_SCHED_H
>
>  #include <linux/const.h>
>  #include <linux/types.h>
> --
> 2.49.0
>
>

