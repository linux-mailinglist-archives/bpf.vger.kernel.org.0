Return-Path: <bpf+bounces-69231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D49B91FE9
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778E84E1215
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAA2EAB64;
	Mon, 22 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBlmArr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADC2EA72B
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555545; cv=none; b=HrIGHuIl+SMxEtTY5C6ZQaF/Ht8La+uZyPs1JxhI3CMhAyeC7WSUuzjf4hX5zdUPxuvSLi+mR5+Nn5jG7xIpmBzsMwNUCVkbXwvG9M9D/tDBtc2BNKzCOgyrKm8dsxfEU7nxep50PQZW6sWFKmcgtnzAWZTPA4nsiX+84ULe92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555545; c=relaxed/simple;
	bh=+pi56O3b51xWpK/gynXOWLU473m1ZZ7txSI/RgTjuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnZsPHmsUjaOhsAz8q7J2aIPN2dNYl2BVqqkAmw833bFDyv2WncalicCm05TuZhZktPxkiDRQef4mB0Hk9An0juOgwNz2QP48e3rUV/NalhfeOOmx4sEGnwpU891pMF3KycoUMwMiW7+x0JUe5Xxi6ttCjWZIc7DlCJqwbe8iUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBlmArr3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2077d1c8so1461479b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758555544; x=1759160344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=QBlmArr31oLL8Kd3LI497dLTRX/SlDIDr77UHPMRb0qMIjWX1jN1pGgWAVgp0n3wK8
         5iLJ9+1fMAN22qftQ+idM7DmNplpXnuuU6SrQ3fj2iYSNofBsyVxeJG6KV4bi3MO1MmL
         VaSBYmTAelgPP4vIWp1EeF4QkeePuT4BfpmRxv5EVT/24XGrJ4VVtn+Z81eAh5ukZxSy
         zEj/99O4KL2z79o/YVrqjulLaD4jaC2uSlUy6L7BTmf6cmNWcv/wUXgpllef9xGfuJc6
         04BOvmM7dPeIUJ6a/1a+JsPQgFbTWRh0L5qFs8X1QoeRJ7BpfBpuZeUdON9Kva4MwLN9
         ITXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555544; x=1759160344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=FhJEQajf74q/Fs+t0quJWH/l/7Teoe0SDZtHk2yIpY+JiIoz5sM3iG2lin7nOcuEj3
         erROq1YYs/1CklX3SZayekvJ6u1BKkC81CaSaUZq4qYaG9gN7QgWV5DO5fb2I8XYDNeo
         cQmyykUW1iHgg0l9t11zm3etwneVKLwCUZBfR7gakasjteujL4M7GP305otE+N693Cws
         nrZGcXCS4GZt/yKasuHIJb8+3dbesO3lxDmg6BwHvLplyabEhLWvuePg1I4VqW3t5Dv+
         +rd7II7QrKCVB99QCN1oiSNn/entgzsGt6v0uKlMn76Q9PtRzThKgtk3LVamKzOvcimi
         i7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZTNR88+oMjVeQcfg8fKiTP8P87ScdDZUvHQPGGC6krkk7Z261Zq154bPD2iBwKK3dBG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBreJp73lZ1H048nueLJNUPQSAQZ3cRlKFI8eDi2kMARF6Iew9
	El+c032JCoFDK+LmImK/Oj3voN5bO9ZJqPbW5bczZhqGC8ztmuwo3UM=
X-Gm-Gg: ASbGncuUbVv28n12Ll8sOqX8vLZSB9ojd6+NN69o4RICHsKWwdzeRPKINNFGQeJRSRh
	qHZ7LyfcAAblbs4zFS32rl8R16Q0qSVS/kF4+gbEJ69jc31RktPzEzF4HyRojjrmJUl5Otnatr+
	DMzKinVUtOyA95E6vI7LtTmjOOP2C+1V+on2S+gv6h4xTLlt9A32mUrtICl5pcCM2FUB7aUGzV3
	9Qlt79Vjt1sHYOi29VAVzFpTuRror/og0pHrPvLi0pGQX6l4GhjaVHYxfsr4OHU6CbYwXWz0LDb
	7ZB9U+sa56wydiCC0cbvkrR2bUWLXdcEQ1P25UT7Yw0p8F9THsV5YDtF6Jwm4hoETq3x4luJgqQ
	EIqjMtrV6fGjnXA7AxFfdkeNZx8x3XInKCwcXZJwUV7nnNq5gnbCxUyT41RtwfUdj5+cP+4Ha4d
	pdB2BohGDFezlEJGCfKrp8wrrtet773loGwX1fJ1aVqxRd2DdqMBZEkWWLAJZHuiFq2b/UBue5P
	umh
X-Google-Smtp-Source: AGHT+IE3TS2ZT2iVwXx8IVuVRd65DCwplvU4zTMTt2k1/M2gr1xCgjuzcB7lSRGACmTncGG25EZblA==
X-Received: by 2002:a05:6a20:4327:b0:245:ffe1:5619 with SMTP id adf61e73a8af0-292189dd44emr15040347637.23.1758555543694;
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b55149526cfsm10207767a12.36.2025.09.22.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:39:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNFtljcYeLK3uVo3@mini-arch>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>

On 09/20, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags

nit: let's fold it into patch 2? Will be easier to git blame the
feature..

