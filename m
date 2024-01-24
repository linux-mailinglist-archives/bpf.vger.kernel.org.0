Return-Path: <bpf+bounces-20207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27483A4C3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A681C22EB4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915E17BAD;
	Wed, 24 Jan 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf0TZZ4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6D17BA1;
	Wed, 24 Jan 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086710; cv=none; b=Snlb6mvcuq5ki7UUUxxAzgYHmX938TOtCPGGtI7o4uCzUOZ4jr8zqK2QIu99MmLx2ke9XBZZtXH2SVhalslx0PF0YjGMo64vpbg4a1WeA04lykjlU7sSxM6d6962+BPTzb4I/1uAhmRm2eakTdv3Hxuqz2e/KKWIADix5yuMn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086710; c=relaxed/simple;
	bh=KfasA/UQDAtO30ddzex6IqLBpIDW2MblYV85KrwCaFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI3nN1mmU3dQZw737lzuioi+zaIp4BBm8ZPl3CXgUIvd5ClFVAQdfkOBI7cMrWbNXe5GUcqIVGEWuhREH/nk1qzxH0AQB2oxkM1yqm4Alsw2lSncot/7UVCVMz1A74gSuLWr5N3NZfhSN+rPQbe3OwOQfEzOHYwnzsi6WTvd80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf0TZZ4j; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff9061b7a9so7044447b3.1;
        Wed, 24 Jan 2024 00:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086708; x=1706691508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3nNckpzsRUm2Ct1UNE2+wpLpDPhph7rMcIeyvI2hLs=;
        b=Tf0TZZ4jJovYukedLp3KKtY0Slf8EABx13R09yBiIctgcdEkyxLLs50UZLyDGLqS38
         HusOoejuyn3VtNDNrvp1AfyDLqn6oqbWSlN3QXoZiKQCkzGOPnP0xjz2t2W1t5bfFGCu
         lWuTdRfz9L//JhDHv8B1khrBrGahzL9LE04Hj/hRUKtbiok/H5t0JTedOTWpGoHy1Qx+
         gOa5kHtC2NRrZ7fa98YW5g5gj1VJPoVdbHLvybKlwh6tLEqBvKJ/8H+/eAprRuw48uQw
         Zto0dPDbFWtEA1BX5ZmvBLN2MuO4IkGpOmiZYDleyWp/adFMHppXHtlVw4cNHBcd95Z9
         Ysbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086708; x=1706691508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3nNckpzsRUm2Ct1UNE2+wpLpDPhph7rMcIeyvI2hLs=;
        b=rjK4u1AgA9gAn8TiP7ktLaR2jSfYZFzgcdrMbs0iX8YAJOEDpXvRdNvAw91ivAMRAY
         hCcO3Pt292LTvjge4rpgUDXy/cLScErVKRVhJOEAu/56X1OoljJShz/4FFbpkd+ks72f
         SwxhDFCFem/h66cLOBPKUCC8T10A60qxiMZFEd8Wl53Ti5Xw77c6pP85to9oceSHdpKw
         bnd1KCMo5W7b6x8HNDyIzk0zBxp63mPPUy4QDahMB6hftW12Mv8rMTpEGinLefkimvzK
         iKhEmwtAJINk9UoztXfZtWjL0CLtfg1NdTTU226yHV7ft0/oZ6Kd6h/O0E+Pll0/lpBo
         Malg==
X-Gm-Message-State: AOJu0YwaXyU5TujiCUV43dq0YjA51sBN66wPjuRXf418UOkFkUsYOynU
	XJ324trdClmlw8fsdQa+xZ4CesJ0jHFCQogvfd3dKXioXIZMq9IAo1EFhWvZ81maDDTm0cf7pP/
	wRaHpFZdqsfCmhfbCMbxguuaZOTk=
X-Google-Smtp-Source: AGHT+IEb2L/SOhSk4DZOournNE7K4hdsdAP0YaXcXPZboyLwwuGWyFqweNGKuPpoZAQYQk1/TN/EzGGKWt0/zBRLyZw=
X-Received: by 2002:a25:eb11:0:b0:dbd:9912:e852 with SMTP id
 d17-20020a25eb11000000b00dbd9912e852mr1392239ybs.2.1706086708230; Wed, 24 Jan
 2024 00:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:58:17 +0100
Message-ID: <CAJ8uoz04Z72cVnhrQF+z96GTjG_xxYSMA+Lm2F1d5ABHvSuk6Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 00/11] net: bpf_xdp_adjust_tail() and Intel mbuf fixes
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hey,
>
> after a break followed by dealing with sickness, here is a v5 that makes
> bpf_xdp_adjust_tail() actually usable for ZC drivers that support XDP
> multi-buffer. Since v4 I tried also using bpf_xdp_adjust_tail() with
> positive offset which exposed yet another issues, which can be observed
> by increased commit count when compared to v3.

Thanks for this fix of getting bpf_xdp_djust_tail to work with AF_XDP
in multi-buffer mode. We clearly need to add a test case for this
helper in our test suite. I have put it on the todo list.

> John, in the end I think we should remove handling
> MEM_TYPE_XSK_BUFF_POOL from __xdp_return(), but it is out of the scope
> for fixes set, IMHO.
>
> Thanks,
> Maciej
>
> v5:
> - pick correct version of patch 5 [Simon]
> - elaborate a bit more on what patch 2 fixes
>
> v4:
> - do not clear frags flag when deleting tail; xsk_buff_pool now does
>   that
> - skip some NULL tests for xsk_buff_get_tail [Martin, John]
> - address problems around registering xdp_rxq_info
> - fix bpf_xdp_frags_increase_tail() for ZC mbuf
>
> v3:
> - add acks
> - s/xsk_buff_tail_del/xsk_buff_del_tail
> - address i40e as well (thanks Tirthendu)
>
> v2:
> - fix !CONFIG_XDP_SOCKETS builds
> - add reviewed-by tag to patch 3
>
>
> Maciej Fijalkowski (10):
>   xsk: recycle buffer in case Rx queue was full
>   xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
>   xsk: fix usage of multi-buffer BPF helpers for ZC XDP
>   ice: work on pre-XDP prog frag count
>   ice: remove redundant xdp_rxq_info registration
>   intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
>   ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
>   xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
>   i40e: set xdp_rxq_info::frag_size
>   i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue
>
> Tirthendu Sarkar (1):
>   i40e: handle multi-buffer packets that are shrunk by xdp prog
>
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 47 ++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 49 +++++++++----------
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  7 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 ++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++----
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
>  include/net/xdp_sock_drv.h                    | 26 ++++++++++
>  net/core/filter.c                             | 43 ++++++++++++----
>  net/xdp/xsk.c                                 | 12 +++--
>  net/xdp/xsk_buff_pool.c                       |  3 ++
>  12 files changed, 167 insertions(+), 79 deletions(-)
>
> --
> 2.34.1
>
>

