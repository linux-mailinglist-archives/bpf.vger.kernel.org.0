Return-Path: <bpf+bounces-59864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3CAD03F4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CC3A40A2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E872628;
	Fri,  6 Jun 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hg8Ot8nT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7345009
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219932; cv=none; b=snPgKn++xvuUeTKPD5ZNPxdAwpz0Q2Iz6G0FyT2E7c/8Pv3BQxe2Y50Q3Xiq1BNG/IPxdXmelFu+wSGKSJA8CR+/qyCi8sIrpYpkPB2nJlktpB4qL7mfJb1B1AY5e3rlIUMl//KtuoY7VdalHBYkS0OvhCIiJAOJw2W1MipTWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219932; c=relaxed/simple;
	bh=0/Xbc5DoXdOonGdb1FnWFrx7HW4T9hMU9U0+W+iph0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loGzlILwL+9rEX4JL/+H22+0yIdPaGDcOkPIabAn3iVnWEGdYgQUXKo2Hw0MkvhlVzQBRnusZ7acvHk8x87RwrnW0Y4yWZX7G/1z6YtYV46FAhDuCGNvgOlIFZMHFSTg1hqzqW47h+SZlJMMAZ/shf1cUbr85Fi5YqCs69J0MCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hg8Ot8nT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86d1131551eso63511939f.3
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749219929; x=1749824729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAaimuBfQTz1EHGQEWzx7YSWNC+FbUyMuJtQhEefSSo=;
        b=Hg8Ot8nTiEGzQcCKgMxhnMiCQhGSeh7Fdst4ZRbHkSZKPC4IjjREa/Rxt1+yTNgZAh
         KsL4N1pB+rfF5asd5nZY4vEX/36NdHm44EHXpnbKt7p8+OptNH04iw17kssLmeXBDLRr
         3nJOCFkeVrZDve4p6uzr+/IEHmPnfCIj7feVAN0zAa6opJ9HUAjIg5C3gCWjnkf7fkdA
         rN73B6HL2742dEMB5v/OTSPnBECZK8CKM3rS9DIlFIXRW2yLTbG3ev44Zpelc7ruCaAd
         GWsfk3MS1iH2pqSfJpsZTyJ3S2RRENRKxf4ZZ9heiWUhRHpLmKtBx8SysvPZijIusWBM
         ZBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219929; x=1749824729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAaimuBfQTz1EHGQEWzx7YSWNC+FbUyMuJtQhEefSSo=;
        b=e/02BcfGneU0ZWqTUX+1YupjZU0nfnoyfii+H6Jo1haEO0a7BR79CHDZZS2vWvVkGK
         2U8S5WPOEut5XU6vTZ4WT58iq3aaLXlAMegFZAhaLsMLhwl+KhV+fosKyTxQorPsmeVa
         7C/V4wahCUyimxe4y5XWnVjNZni0MN6du/oGbqNV2nRb/RgBFKFSyn/tOTaEoTcVUBBh
         6yQEvMRh276X8b4OMjWRzksSso20w8ETOf1bEzzHMWrYUoCeQtYWCEpd2eud4bAhIIq6
         SIOvF70ZHG975A5vjlqrROQLpeVgdcOQUtldZS0FWgU0jBfSHM2n4DpYM7mMVxgp+w9/
         RYuw==
X-Forwarded-Encrypted: i=1; AJvYcCXplFHyAZLaoHGxwBkmIPA4BIfZx9xsd6Tih/qzJ+BD7BfY2//Jkp/FKLTIxHWpqlbU2K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1BcKWYbBDJcWwZ3t7bi4Pkxq5GO9Sv/3y22ADhrPiwQr2c68
	ni3ALMSbrC/XqKwHpmizDHNhX/kclEpF21MtpeNfcb6t0QVrWP8HKa3dKaOvniY5pnjoiAqPYMA
	qyyED
X-Gm-Gg: ASbGncsnHUoOV1jtL6zMd1WSW/btn6ptJlhjzSi+d02QBY61iDsCre1kKAkwv8begeH
	Rng8kzxQt4mPF+8nqLuOK7XLdeov/mgHeue7K4crDly/u6yzAuR/cbefBwFY5pkK16PPjTiT3jH
	LacIpqrLCIsPAPeg0/0D5XXMLba8cmFRJWiGpMBPyFquOLmO0POhVBBEU4s9D3KGoAo9DSyf8/Z
	snIIGT35uUwuGZOmjgUrB55K0PbFTPHtcyrhXJ1pDWG9sp2rVYDcsF2/jgihYmsIG4cWHSSnk/m
	NmGizp08n6BGtgnnTGgOzURyOj1DWfRnN57p+V0EHRGZErYIC3q158s6pA==
X-Google-Smtp-Source: AGHT+IF5km4CtDvHDOVe+SIqNmRZERGMS28Qi8RaU8LfNaXvtlGLcevIJqxza9IXKdKeERufgQAQHg==
X-Received: by 2002:a05:6e02:3093:b0:3dd:cb92:f12f with SMTP id e9e14a558f8ab-3ddce4100demr44053855ab.12.1749219916570;
        Fri, 06 Jun 2025 07:25:16 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddcf253213sm4120495ab.51.2025.06.06.07.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 07:25:15 -0700 (PDT)
Message-ID: <783d14e8-0627-492d-b06f-f0adee2064d6@kernel.dk>
Date: Fri, 6 Jun 2025 08:25:15 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/5] io_uring/bpf: add stubs for bpf struct_ops
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1749214572.git.asml.silence@gmail.com>
 <e2cd83fa47ed6e7e6c4e9207e66204e97371a37c.1749214572.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e2cd83fa47ed6e7e6c4e9207e66204e97371a37c.1749214572.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 7:57 AM, Pavel Begunkov wrote:
> diff --git a/io_uring/bpf.h b/io_uring/bpf.h
> new file mode 100644
> index 000000000000..a61c489d306b
> --- /dev/null
> +++ b/io_uring/bpf.h
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef IOU_BPF_H
> +#define IOU_BPF_H
> +
> +#include <linux/io_uring_types.h>
> +#include <linux/bpf.h>
> +
> +#include "io_uring.h"
> +
> +struct io_uring_ops {
> +};
> +
> +static inline bool io_bpf_attached(struct io_ring_ctx *ctx)
> +{
> +	return IS_ENABLED(CONFIG_BPF) && ctx->bpf_ops != NULL;
> +}
> +
> +#ifdef CONFIG_BPF
> +void io_unregister_bpf_ops(struct io_ring_ctx *ctx);
> +#else
> +static inline void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
> +{
> +}
> +#endif

Should be

#ifdef IO_URING_BPF

here.

-- 
Jens Axboe

