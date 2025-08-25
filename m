Return-Path: <bpf+bounces-66463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A09B34E14
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AFA487319
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037728DF2B;
	Mon, 25 Aug 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYB2urc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC228469C;
	Mon, 25 Aug 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157364; cv=none; b=O6s05p18t4ETfXaZ65fawcFDWOZA1MvCPKWTf1jNW5vKhgxRxTTW30mojb0zXdFay6GQsjj/TzdQI3EK5frYtsLYZbVLsPTuLUiLnxeyDtLtrdZepzxOLDnuGj1XWwMGxHhUrB6BdBIBEvI6jqcyL921A4Q2+PF+MtJxbsJUbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157364; c=relaxed/simple;
	bh=7ljL+g+TfWOt41e8Iptx7i4M47vfvr+9bEHaVtGXObE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhC7YKqzcARhh8jQmNfYriZa4KRoGPbKPHVPIrjyUuZAR7YSV3/AzTCpVNNS1TqFZax1aZOnmxU/v73b4wz7eZUb8jCpqnSwHA40XsoqBPike00GVVGusNGqPyQGTK9m7VSAgebe1zS40EoWGNRTbOAOTd6LQ+P7MVSg1xYOI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYB2urc+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso3456869a12.0;
        Mon, 25 Aug 2025 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756157362; x=1756762162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDl9j+vFFXmNp4QdX1B08rZR6RGpOt5hN8ZBoMXU19E=;
        b=PYB2urc+GBt9S9NA8jlcKvSgfu5sbfjim1N5fK7F+UW6DV8EkIqASmy+ppPxhuseq0
         AntWqQrjgXCl1/CEW+m1K7lMCPXKfYG8nAb2+x/9RcCyrc5afSdpEUqwpgkoVuH+z0ea
         oKGhiTu6Jkwbk7GOGwLPWL/Fclpz2lEG0xrW9kjzkewc/lbmgUwT/bypGYMxLP2KUq6W
         dh3Z0umxOVlv3xV4NCUozsIeXvRqvou2cd0KLwsRqf5IG7mca9G+HVRnQyIJMs6LlFxM
         BTePml89gowbdUnW9h5omFEe2WBIZ2Qh6QnufTMRLlHADBvWgqrYLBqvbKDAK3r/pigE
         VPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157362; x=1756762162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDl9j+vFFXmNp4QdX1B08rZR6RGpOt5hN8ZBoMXU19E=;
        b=iHZlopIo0WOfiyjgnbyZd60A42y6VdmRw+YcMTN3I0ok4XornM25G4HnXpInHrATgI
         4a6CtwQAO3SA4AsNHJ0Lopqsm3cYslrn/BKmjj9VqE7++BU9bpfDRzNn80tFEDuyQ1lx
         9hr4uQI9rUgx2ZO7+AWMjDmyN77FRJSv2o47jxtE2lwFHGzO6GFIBkGfk86LKZ5vxp0n
         gBNXuhhUm0wZxWllR7HHHGUyAyhOcPUVVgN+95ONeW/sRX/5YBK73PPaKjPdMr940tUV
         ZVOrha8fPCwL3mYi4RhebxbTeyS8CD27uC+bqiJjpN8eh5+vWrv7ScGbg/O5WBQTZmPV
         8RUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhp4eiY5Ur9KHcGCc9BU0ezz/xzkpUgjmk+hh2mEfRo+zBs+5b0dh48WuVBNxwdHcldNaStzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVkoLsVH2LaUIclg7Tzcv2Z4MsL/MooaISp/Woi8PvKrcsI1W
	HSIdUvzLm/ww4Zb6EWZML8Zrz2UkMR8xQzqBo5J+RmoGl5+plmSJZQo=
X-Gm-Gg: ASbGncvW8gCLiDJ3MqHfFtLrWrHKMzU8PYuvO3jHBNegS/QBZgcs2wSczrw1u6CmJuX
	U4kfMRZJB6/dRW3IzLnHKz6OIVyHdyky+aCJM8CXrbj/49XOhvC0oH9XB6BAWGIUwvbmhMZAHHG
	JMDpgNT5g0qSAAd/EoZ4ng6JJ+kbixFR8+TONxU/vNHD23AEuWYXW8IVOu/vSWFnu7jiSqnQUwt
	Bm8r6Vc4dYAzuYAdPW7vBZMbsOsciNazzWSB0p9uRdYRb9+BMrm8C1a6gphfpEBPt6GoqF9YbaI
	L3FmlwQgGxwMeXJ7sk73nv989SzMaDVJYqZUh3OCSjav/Hm7I3Uvo/RGgemkM2BOEeTWQTchi4J
	KEYYlTabatI2abbaFx2sIty+JfEnE8rLI9+4MGtjAvUhy3ZRx1beTqmRZ9gYfC/E61+6n45GgqN
	O3VWLQh+qZnS64qJ/8E3QC9zsjiTUw6GPQfWglQOuXv0MQEYcVWnc93+8oP7U84F+QiUVioJQKa
	TcK
X-Google-Smtp-Source: AGHT+IGJcR5pPtKrH0pxdiNUxZctZu4MPAjYaQY/VRmWlMPvMrdiJWQYhjD+FoMSi/XbmY1H9hAySA==
X-Received: by 2002:a17:903:2f44:b0:242:fba2:b8e4 with SMTP id d9443c01a7336-2462efaf1demr195173165ad.56.1756157362162;
        Mon, 25 Aug 2025 14:29:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24668779fcbsm77611675ad.8.2025.08.25.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:29:21 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:29:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <aKzVsZ0D53rhOhQe@mini-arch>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-4-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825193918.3445531-4-ameryhung@gmail.com>

On 08/25, Amery Hung wrote:
> Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> the first len bytes of data directly readable and writable in bpf
> programs. If the "len" argument is larger than the linear data size,
> data in fragments will be copied to the linear region when there
> is enough room between xdp->data_end and xdp_data_hard_end(xdp),
> which is subject to driver implementation.
> 
> A use case of the kfunc is to decapsulate headers residing in xdp
> fragments. It is possible for a NIC driver to place headers in xdp
> fragments. To keep using direct packet access for parsing and
> decapsulating headers, users can pull headers into the linear data
> area by calling bpf_xdp_pull_data() and then pop the header with
> bpf_xdp_adjust_head().
> 
> An unused argument, flags is reserved for future extension (e.g.,
> tossing the data instead of copying it to the linear data area).
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  net/core/filter.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f0ee5aec7977..82d953e077ac 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12211,6 +12211,57 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>  	return 0;
>  }
>  
> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)x;
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	void *data_end, *data_hard_end = xdp_data_hard_end(xdp);
> +	int i, delta, buff_len, n_frags_free = 0, len_free = 0;
> +
> +	buff_len = xdp_get_buff_len(xdp);
> +
> +	if (unlikely(len > buff_len))
> +		return -EINVAL;
> +
> +	if (!len)
> +		len = xdp_get_buff_len(xdp);

Why not return -EINVAL here for len=0?

> +
> +	data_end = xdp->data + len;
> +	delta = data_end - xdp->data_end;
> +
> +	if (delta <= 0)
> +		return 0;
> +
> +	if (unlikely(data_end > data_hard_end))
> +		return -EINVAL;
> +
> +	for (i = 0; i < sinfo->nr_frags && delta; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
> +
> +		memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);

skb_frag_address can return NULL for unreadable frags.

