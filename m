Return-Path: <bpf+bounces-7089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F11771219
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 22:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8311C20A4F
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B9C8E8;
	Sat,  5 Aug 2023 20:24:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435261FA0;
	Sat,  5 Aug 2023 20:24:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7B513E;
	Sat,  5 Aug 2023 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dNu2egnhMUuwuP0JymsvaeCUIB7L8YRoiDijl0XGqF4=; b=1bIGNScm0IlJWgpkYH1OZiiSSD
	uHkr6jYSWQ5cc3wxwc1OdW+tKzWVw1aYJr/qO0+4yBJ+eG/TKtZMchreUC63QrMnYOqh5wjNate88
	Iqffy5k7Xm5gMKqojm+G4Z4okBjK1iIjdgyGu0bPyz3bSZ0IgPK4CR3fmqraKDsaPO3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qSNp9-003DAy-Il; Sat, 05 Aug 2023 22:24:31 +0200
Date: Sat, 5 Aug 2023 22:24:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Cover <werekraken@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthew Cover <matthew.cover@stackpath.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next] Add bnxt_netlink to facilitate representor pair
 configurations.
Message-ID: <3987add6-4928-4cd9-9fe6-a232f202ecc6@lunn.ch>
References: <20230804212954.98868-1-matthew.cover@stackpath.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804212954.98868-1-matthew.cover@stackpath.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 02:29:54PM -0700, Matthew Cover wrote:
> To leverage the SmartNIC capabilities available in Broadcom
> NetXtreme-C/E ethernet devices, representor pairs must be configured
> via bnxt-ctl

Could you give a link to the bnxt-ctl sources. Also give a brief
description of what they do. 

> @@ -0,0 +1,231 @@
> +/* Broadcom NetXtreme-C/E network driver.
> + *
> + * Copyright (c) 2014-2016 Broadcom Corporation
> + * Copyright (c) 2016-2017 Broadcom Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation.

Please remove the license boilerplate and use a SPDX-License-Identifier.

> + */
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include "bnxt_hsi.h"
> +#include "bnxt_netlink.h"
> +#include "bnxt.h"
> +#include "bnxt_hwrm.h"
> +
> +/* attribute policy */
> +static struct nla_policy bnxt_netlink_policy[BNXT_NUM_ATTRS] = {
> +	[BNXT_ATTR_PID] = { .type = NLA_U32 },
> +	[BNXT_ATTR_IF_INDEX] = { .type = NLA_U32 },
> +	[BNXT_ATTR_REQUEST] = { .type = NLA_BINARY },
> +	[BNXT_ATTR_RESPONSE] = { .type = NLA_BINARY },

Passing binary blobs from user space to firmware will not be
accepted. You need well defined and documented individual commands.


    Andrew

---
pw-bot: cr

