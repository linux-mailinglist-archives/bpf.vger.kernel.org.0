Return-Path: <bpf+bounces-31888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DC904622
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0581C2343A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2B153501;
	Tue, 11 Jun 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBEfZAwa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427A1514C9;
	Tue, 11 Jun 2024 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140345; cv=none; b=JeEYMgYfcjsfMuD3SKV7RUMhpIv5zKhKoXuEoFODRa72x1KhmjLohzjvHuwOZZqvid3aA9EKbX3AsloGwY30syvVqE2E7VZvDYLcczJp92cseLHR4h6oPZchmlZhWOSaK9mDwdZJeBOOmNTXokgmgnsDO1pOTRBiTYPfbuDPgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140345; c=relaxed/simple;
	bh=gABUjaIqxTdKPvs62Zv3vC0020OcVeLRR4OmLvIB1EQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=X8IQGK5aEr1Kjipk4vVMfY9b+GOy1Ky9QaVLbW6uNkXcGw6V6mo2AvXj53HQofWM+f+ARcfVjLDNJ/VtZ1SR6EofrQR/HanyYZ4tSmZi1HW5vsFoAqxzqJ48wnIIu8lKpRSwDHuK2pCBwXDir2tafHBLEX2ivwVtlYjsMy0uQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBEfZAwa; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f96445cfaeso860223a34.2;
        Tue, 11 Jun 2024 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140343; x=1718745143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f8iA+BT0JdT+xCtVM5QIlFnTXVcaJHgvzWFas2qCZg=;
        b=bBEfZAwayXI43Dgf4xeZS/XGBkdG4fVLTP2oj8dcQSdUJIdHGS3elwcNLqMVFKUdrL
         5OskYjKynca2cMD/P+2K5prcgCzvIrMuA7+OxaQ1DVLN5oyMGa3ZqHv0DPxVZYtKuTDW
         vRe50bCB3JPK2tIwBOvFSUoF+Mo5FXJalpeDIWt9soONGCjmJC1HVs5g+Q0D5o/b5EEb
         jZwH0xJxiDOCGyVB4VZKnfNO9jcY/iqEba3T7/1Wt4tyFol0h2HSAzXdwfO7STWmsrwH
         Bh5DR8e3HZeBbcomWMLZSwNwsRflWacKgOdN9MluSBEx95gavPbxV8X3kgi3rrhNm3WO
         c8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140343; x=1718745143;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4f8iA+BT0JdT+xCtVM5QIlFnTXVcaJHgvzWFas2qCZg=;
        b=oiVwJXesg3Z8m+du4roFmoS49kCEHY6v6CkV5Q66NIQ/kOIb5BoExlbScRXFrwcuqL
         R/L+jlzSZaZJJ1MaQqBHKU4FYtF1K5NnUs7dzoGV2mWVokSBqzDbdu+jT68/QWwqpyop
         DmGOey09DZD5IzDVrnQrYVq4zuAmvApQ70UB55QB/NX4QxSrPNbNLxqz/zVCeck2VMtx
         Xc4DfH7hFSNQtdCnb9hmThstEUSm3gXmLzOAv/2ilftZgCSQkMZmjJQqfysX43CLo41R
         Ol7wWS/V4rO9Q4Uj6LOKmnsRUGH3bT6LzSu78kr2FxEACJ+o+tTdRIgwLFbVRyO4ffEp
         Brjg==
X-Forwarded-Encrypted: i=1; AJvYcCWyORBladBTqxhWRVg4d5UCRo4Tti+xZOJrYceW4C1F153LhZRwtaZMGpBauhEs74+/Aej+77b5rDKOGCIh4cjT8b4n+GwC0mGVMmbZyZF5OPlsyY1eB5b0uBpJ
X-Gm-Message-State: AOJu0Yyzedx+ZOHeV1P08A1vjy0dEcEJVun+d44Pmjsrkbcfu9RVl+jg
	t8NRzQEjQeAh+duWoBGLNJ98NZmv4l+RwiQHjkfScHJKq7s+ly8c
X-Google-Smtp-Source: AGHT+IEPlAD1O1VAe7Ad0WITLf8o8k5Jdn+TEIdSksTF8DDGfXFYOIyOMNIzrDppvgei50u3oBnRNw==
X-Received: by 2002:a05:6830:1541:b0:6f9:a479:d160 with SMTP id 46e09a7af769-6f9a479d405mr8766328a34.25.1718140343222;
        Tue, 11 Jun 2024 14:12:23 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7977e0eb111sm188859285a.89.2024.06.11.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:12:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:12:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: YiFei Zhu <zhuyifei@google.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6668bdb68eaf5_f6b0e29416@willemb.c.googlers.com.notmuch>
In-Reply-To: <a932c40e59f648d9d2771f9533cbc01cd4c0935c.1718138187.git.zhuyifei@google.com>
References: <cover.1718138187.git.zhuyifei@google.com>
 <a932c40e59f648d9d2771f9533cbc01cd4c0935c.1718138187.git.zhuyifei@google.com>
Subject: Re: [RFC PATCH net-next 1/3] selftests/bpf: Move rxq_num helper from
 xdp_hw_metadata to network_helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

YiFei Zhu wrote:
> This helper may be useful for other AF_XDP tests, such as xsk_hw.
> Moving it out so we don't need to copy-paste that function.
> 
> I also changed the function from directly calling error(1, errno, ...)
> to returning an error because I don't think it makes sense for a
> library function to outright kill the process if the function fails.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 27 +++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  2 ++
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 27 ++-----------------
>  3 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 35250e6cde7f..4c3bef07df23 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -569,6 +569,33 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>  	return 0;
>  }
>  
> +int rxq_num(const char *ifname)
> +{
> +	struct ethtool_channels ch = {
> +		.cmd = ETHTOOL_GCHANNELS,
> +	};
> +	struct ifreq ifr = {
> +		.ifr_data = (void *)&ch,
> +	};
> +	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
> +	int fd, ret, err;

Since sending this as RFC, when sending for inclusion let's move the
strncpy, to not mix declarations and code.

