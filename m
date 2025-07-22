Return-Path: <bpf+bounces-64100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D2B0E4F3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF353A2FC9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79C285417;
	Tue, 22 Jul 2025 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGq14BFj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BEB1F1302;
	Tue, 22 Jul 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215956; cv=none; b=flhzzwb8PfcHK8cIvua0UHJluoSdlUnt5fyqsDa/mX8OgnTPd18yqUr96bWpdiQDx7xgXlASVOtpnZXQlty8kphFiZO6FVokgruWqr6dYAiyqO1PPLSjXY+AhMRTI2OEB7ha0WibprTTyYT+YifMHWbAWvkv6tyCb380Wc5/1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215956; c=relaxed/simple;
	bh=5wZP20Tfx//u67UjtoE+nwUc0a4NuLBVstepM5ae2W0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0BY0vyTczhmYb6nvDSwZU3KEQC8yMrSM1itV8cwrUBnjU5sOhvIbrnkxHctcOUuZyxY9tcFFvn3VzhoHJUD91Jq6V0SRYDmKf7dxrYbb/iLAf20tnZRbZxQuS0t6u6/Fvx+1TDVdV2FcCRqHOHuG8mduNS6FDpoLFquZKnKbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGq14BFj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490acf57b9so4056301b3a.2;
        Tue, 22 Jul 2025 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753215954; x=1753820754; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5wZP20Tfx//u67UjtoE+nwUc0a4NuLBVstepM5ae2W0=;
        b=RGq14BFjXvI1XtBDsxvbVsDBDA5O3w0GXatVAVEsgOOYbzzXUHpRlcUKysDdbriv9+
         3FfCzVOMt36gTie+f5e1GNmc+FCkSJL6sm2yH8awPMXPYlNVcW5nNTp/URb5EcOiniUX
         ew/HeSBaypw+KmMUAo6384nT+GlIMZJxYpy8//dBNYDX38fP+uECfO0HsPzYdA57BE50
         vNkFAwEcKpvbRDSJfA81u/LL1v+N1/GY7aIliNKtf353d847MGqRKcX4xaqyzbM8vLWR
         l42AWUwgSaWNE/DCdb2V5A0iflIa0/3c0q2LD1OGiYyiInT0X4lQEMs/XabClAgggvqN
         drXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215954; x=1753820754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wZP20Tfx//u67UjtoE+nwUc0a4NuLBVstepM5ae2W0=;
        b=RhYYiGeIpjXLLZmCUd/W6Zn2JoWF/KQvwtt5L2DtoMZQhZFTd8KuhzhtgZuEcHlvqG
         BViLfc+mNJODvUNU9zeqVQhuiYjw3K54EK/FNGBv1tbHeiWFzX0VArYxB7XXSXFF2P0K
         oYQVWlTU8ekZ9Bb122i7/F1bFMmJUfDBeI9+jvOBstIdexJh1WVvAaP+XyKsZXGpduCw
         H4o6oAITuEMBNI9glBoU/hX+TVckbFPxwijQ7cfZThfG2w9HC+OxjgxL3llrnkI5uAsl
         f/cVK82j0QD3j7ZCrxvgq/jEpad6Qj+kRbbcC9gfIuE09d4Pgifx9bPfs2AWyBAbhupv
         ojpg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfFZxt2WkGpIv2xUeXRkIlpDB2Sdbqm5lB1ccYLzK7aABPHDHSqZoF9xNP3KgShTHv/jCD1N3@vger.kernel.org, AJvYcCUv9P36v1wDFU9POdLq46RCNHb9kazY6ZqFXy3stL6kr5+Tk0NhO64VCn0X+cktELsU7+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJT6I16vUg6stj/weuyL05X2OW6fuVZU2mFbHvv4sHNqX/aaCA
	1kv241SOPSJD7CB/ghfvKN+PbG8HYdSGSullDhhHCufu6oPz6ilLblpb
X-Gm-Gg: ASbGncueuwAP4xbGS1j4dOS6/UzmOIGhHlvPF/an+6Mj9MLRNwo3S6TGJriyL6Qy5tA
	JvUbCKUfHWKopdAQJV/Mdu/xbePANZ6p8EfLoO8htFZXHXG2+Ni4CTN2aPIQTjlZq5v3mvO2gdz
	raL06EEuWMweOg8x0QHfk+noFKkWxlm7cerwCXFn/KrJkYUcFFz9NpngCUWF3/cXZJoDFy3Fn77
	Al1J4Py5EWOdbPv//shDQ00RG4AcG8HYThmsaN9XP6euQv/JXtrxIsPRTEHmki2BHq1zJG4HT6P
	MCOJuyQMJ+yja4wb3MecXt65VFRvS9QdsH6nEjcEM3qotcEs7Jmn6OSTwLnEnzggbnFP56fuOxv
	AkMY/7qN5VBrDuaE/0UEwfo1Ujpi91rYhq7GI1Hg=
X-Google-Smtp-Source: AGHT+IH60kMrHwN+SLudvjvOILmhcGZWHG1rX4EV90AxLtS+Y/gYxiklAqzSumZMZVswU0jBsLRkcg==
X-Received: by 2002:a05:6a00:4d85:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-760341083e7mr680023b3a.10.1753215953778;
        Tue, 22 Jul 2025 13:25:53 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76da69sm8063409b3a.115.2025.07.22.13.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:25:53 -0700 (PDT)
Message-ID: <2bc87b6bd0d06b562261fe89a3bb509489a611e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Cover write access to
 skb metadata via dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 13:25:51 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-9-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-9-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> Add tests what exercise writes to skb metadata in two ways:
> 1. indirectly, using bpf_dynptr_write helper,
> 2. directly, using a read-write dynptr slice.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

