Return-Path: <bpf+bounces-20205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A625083A491
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95DA1C21A79
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132117BA5;
	Wed, 24 Jan 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLaRrQpk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CA179A8;
	Wed, 24 Jan 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086321; cv=none; b=uNA6wwZMXagNbk5yq0o2oUHD2oJH8qDMr1Ju/2GhLMCTwK+EZkIoLKfGdjejOnNxXWtiMAodnbTz7Q0xgrsW8l0N6iJ3QFAZyaeQS8q2fov1BrjnV1YSnEIlTFr8LCYI6yNXu7ozIKsz5VymUVfiwuHh16z+X5IFLyJPbxs5Y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086321; c=relaxed/simple;
	bh=BD7Nwb9Evn5PtJyHWj0VrJuan5hBOCtPl25Y/9WyZoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2+P7Rr60MeGQ5+JOEt6vVoF4PbKsraf4PYupetJPhHHXv8G+Wq1+RvBx0CzSmC/mS1tQ2XZdTqFs+OayhlG2w+1UNzRMt2KAdSSbzlq7p2NRa9sneqORqYxtasPsyt0gehBK9xA+BrgTG/MDyEJqhYsKX2o5SWAQezuxhXTelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLaRrQpk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783b3539c16so11448385a.1;
        Wed, 24 Jan 2024 00:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086318; x=1706691118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiEf6sHv7ty0qODOxlZPDdflI80TEjr888e4brqwrrg=;
        b=hLaRrQpkVyNE8tQRfWCufBuN8GAod4Hm3jLrvv1aNg1v8IYY/SW3IMDbRju4yjdMqA
         V+8K7RplP30xQHZ3hBbKGZAKpjq6fnSajIRgIdZmT0hghYjhFvqKXrFqCuMEwxowrY+y
         RHcNhLzUT+EbP1JCNpI0krpp7fbBCQE2zuE0syRe6na1I/uV1eElQSWKvfBfNjuBr2JK
         g6QXt8xRH/gINer0CrO4Q6XNvQES6llcHZmvtwXAnXCqUrqSflDHKsp/+s4wDBskijcS
         3yRKy828/bRh0IfA2roCFHcG+JkxctO6qdkmtsxM5W5TbnlFuPZA82RcUdf+QbHGf3KR
         GPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086318; x=1706691118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiEf6sHv7ty0qODOxlZPDdflI80TEjr888e4brqwrrg=;
        b=iWguYrUShAuvAznspr2j8I3s59igeMIN7USDOwLNOXWb+YmQNbZPTvnV+0yDxuktvV
         D63/5KrFY6jIzEKXFHMLvdPq5rUnaPLYTw13EYh+fNMAmiZ7l3KciZA3y76xXgjxtRG+
         hmPZvLtmPw3mxhlezfNt73tw0equwX7BjlsxhMhcDkPY1nOsHhxBkKxhOLBKCJo2Z1uU
         kDtoiN1hwuak1rZnfs/1O/tu4W6pyjmb2Kaxo96vEVe/+qSkI4wYCwqIVHphULcq4Qbf
         bvO56mFtZST7Ru10rroxpFZlMjJqXQHm89Mw+8O5qeL+BHs85BCSrVeFb4wK7Ojy6i4h
         QlhA==
X-Gm-Message-State: AOJu0YzP5alacpkIQgfrI6TrY1YAhCyimNg/n6u+lThuwLxLcD9M+WZO
	BQsZ07V7/Zo1DdJgxA7SqbC6wLpdBtnA1lSGKr8gzHys6qyVUtiO931lxWgl2RXSezEq3Pc/p2W
	G2czdJDotuVt3h9yXR8p0Bu7mOz7wDnbp9QA6ZQ==
X-Google-Smtp-Source: AGHT+IEM5nuXw+47etcQDQfd0v/uxQ6VAl9kerEu86mm46iLckCnWy7rLKp1OZTdsl+FTyIbyC5koZGRWF+gjBYzBpA=
X-Received: by 2002:ad4:5aab:0:b0:686:9e90:96c5 with SMTP id
 u11-20020ad45aab000000b006869e9096c5mr1640275qvg.6.1706086318631; Wed, 24 Jan
 2024 00:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-9-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-9-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:51:47 +0100
Message-ID: <CAJ8uoz3jAtyDXr=WSXYXZeX0WfYuJK+WA0tTpYMscM=XRqisSQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC
 enabled Rx queue
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:17, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
> make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
> is being set via xsk_pool_get_rx_frame_size() and this needs to be
> propagated up to xdp_rxq_info.
>
> Use a bigger hammer and instead of unregistering only xdp_rxq_info's
> memory model, unregister it altogether and register it again and have
> xdp_rxq_info with correct frag_size value.
>
> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index b25b7f415965..df174c1c3817 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -564,10 +564,15 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>
>                 ring->xsk_pool = ice_xsk_pool(ring);
>                 if (ring->xsk_pool) {
> -                       xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> +                       xdp_rxq_info_unreg(&ring->xdp_rxq);
>
>                         ring->rx_buf_len =
>                                 xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +                       /* coverity[check_return] */

Why not check the return value here? I can see that the non xsk_pool
path ignores the return value too, but do not understand why.

> +                       __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                          ring->q_index,
> +                                          ring->q_vector->napi.napi_id,
> +                                          ring->rx_buf_len);
>                         err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>                                                          MEM_TYPE_XSK_BUFF_POOL,
>                                                          NULL);
> --
> 2.34.1
>
>

