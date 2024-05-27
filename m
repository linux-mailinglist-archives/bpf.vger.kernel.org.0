Return-Path: <bpf+bounces-30678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6B8D0614
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439E8B2F9EC
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F7168C2B;
	Mon, 27 May 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFFFZ4+W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFF1667F9;
	Mon, 27 May 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821380; cv=none; b=fI5XeJ24iD8TP7jO7ZtFLyNmVF06DRjpUxXumh9njjZKTwjKX0cZUcIi9SN1lWmJCiOotm1IkZtA/AtAuKwGpEA5npRauJSa2fpvaCBHMwZYWegw/Ekq9Uvkz5757eSalq7X0Rqo6n+dGQ5WZjCTYZT22czZ4k2EeqroElZrXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821380; c=relaxed/simple;
	bh=V01owRMSGbHKVTfD/05++xO+/+N+LoOPgcGpNbPVVTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+7pNgFZWtf3G6L5v8eyW3jQwQ7Ybg5zEfoKbZfXxo7Amu5VkfWq1RvxVC+aMf4Pu6k+aKi1Kg3Tv4j5hw4nHswktbAvEp4kOSnsYd/jCCWGkVE7vrGuFjNZkT7Fe/5UsFRXVzD2syBIMPuCnn5N7RRAFOnitFi2ty1r7LPJAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFFFZ4+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F363C2BBFC;
	Mon, 27 May 2024 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716821379;
	bh=V01owRMSGbHKVTfD/05++xO+/+N+LoOPgcGpNbPVVTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFFFZ4+WujWysxWSi5yYd48hLJqvS5Zkqp0ltgJid34S7kCqpHYvJifRk2u2PQCrh
	 sObJ0mWRk1/RULHOsmrwmrbsI2dNkdCCDafqyK+xA8xELQPOEdtrxUAahAEKwqBqa3
	 sVozQoJfXAwI/02Scb8h9vIPbEvGwGxlN5mCTeJly+jRqfVSkEqRZCG5Wl3lBMQ2y0
	 QYZACSUFeZaToF3n3UfLTJQd0K2ckVTWSV27D14pBsPcVMTRlNKMbFBvmEQjuIWEe5
	 Gna6byLWuqtwzPw1sF0suWZCrCEoOz5CN5SDj1fTaRmWH44vki7GCLK8Pq5C7tBkzY
	 WY3XeUmFMwjsg==
Date: Mon, 27 May 2024 16:49:35 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Peter Hutterer <peter.hutterer@who-t.net>, jikos@kernel.org, linux-input@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 27/30] HID: bpf: add in-tree HID-BPF fix for
 the HP Elite Presenter Mouse
Message-ID: <wdxqrc3onfoltxvpqkvkpeu6f6afq36hwksl2krhue7ntk5r2o@bqkkjzxcfcg7>
References: <20240527141406.3852821-1-sashal@kernel.org>
 <20240527141406.3852821-27-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527141406.3852821-27-sashal@kernel.org>

On May 27 2024, Sasha Levin wrote:
> From: Benjamin Tissoires <bentiss@kernel.org>
> 
> [ Upstream commit 4e6d2a297dd5be26ad409b7a05b20bd033d1c95e ]
> 
> Duplicate of commit 0db117359e47 ("HID: add quirk for 03f0:464a HP Elite
> Presenter Mouse"), but in a slightly better way.
> 
> This time we actually change the application collection, making clearer
> for userspace what the second mouse is.
> 
> Note that having both hid-quirks fix and this HID-BPF fix is not a
> problem at all.

Please drop this patch in all backports (and FWIW, any fix in drivers/hid/bpf/progs/).

HID-BPF is only available since kernel v6.3, and the compilation output
of the in-tree file is not used directly, but shipped from udev-hid-bpf.

TL;DR: this just adds noise to those stable kernel trees.

Cheers,
Benjamin


> 
> Link: https://lore.kernel.org/r/20240410-bpf_sources-v1-4-a8bf16033ef8@kernel.org
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../hid/bpf/progs/HP__Elite-Presenter.bpf.c   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
> 
> diff --git a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
> new file mode 100644
> index 0000000000000..3d14bbb6f2762
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Benjamin Tissoires
> + */
> +
> +#include "vmlinux.h"
> +#include "hid_bpf.h"
> +#include "hid_bpf_helpers.h"
> +#include <bpf/bpf_tracing.h>
> +
> +#define VID_HP 0x03F0
> +#define PID_ELITE_PRESENTER 0x464A
> +
> +HID_BPF_CONFIG(
> +	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, VID_HP, PID_ELITE_PRESENTER)
> +);
> +
> +/*
> + * Already fixed as of commit 0db117359e47 ("HID: add quirk for 03f0:464a
> + * HP Elite Presenter Mouse") in the kernel, but this is a slightly better
> + * fix.
> + *
> + * The HP Elite Presenter Mouse HID Record Descriptor shows
> + * two mice (Report ID 0x1 and 0x2), one keypad (Report ID 0x5),
> + * two Consumer Controls (Report IDs 0x6 and 0x3).
> + * Prior to these fixes it registers one mouse, one keypad
> + * and one Consumer Control, and it was usable only as a
> + * digital laser pointer (one of the two mouses).
> + * We replace the second mouse collection with a pointer collection,
> + * allowing to use the device both as a mouse and a digital laser
> + * pointer.
> + */
> +
> +SEC("fmod_ret/hid_bpf_rdesc_fixup")
> +int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
> +{
> +	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
> +
> +	if (!data)
> +		return 0; /* EPERM check */
> +
> +	/* replace application mouse by application pointer on the second collection */
> +	if (data[79] == 0x02)
> +		data[79] = 0x01;
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +	ctx->retval = ctx->rdesc_size != 264;
> +	if (ctx->retval)
> +		ctx->retval = -EINVAL;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
> 

