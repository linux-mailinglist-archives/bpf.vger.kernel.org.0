Return-Path: <bpf+bounces-64093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFECB0E3EB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD46567E18
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E308284688;
	Tue, 22 Jul 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOk/9/kZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C4283FFB;
	Tue, 22 Jul 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211426; cv=none; b=QFpMtmtci74a6EoPp0/rqdNkbVCV33VROvVFOpY/vF42mALfbXY1dDFgtbtn3kamdbT+JZ7l/qAQuTDO2YAvPlzDo4rR/u7GP7BtFklvKZnvtjZ9yVVRfOxV7WEtrkGYKLNDkHz3pLYLB0XCxzUsA1iq3/pO3EQFfCHHzWHmtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211426; c=relaxed/simple;
	bh=mnpBLtJWdm2k9I873fT/Z5PirhHnkPVy+YBvGqaU01k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfDB1CbcpoCwMVrKomTh8apvCQCuYK/qyswcLbtRsCc/HNKz141T9R+MULi8JeJSzNL8iWdtnzwIjNslwW71VAlP2iMbptZKhXxjvHQ6vHZVYw+YRttCCA248LUYPQ96nLmkmUv4yC/Vdrkq5L7AW+3SiuKwTSORHKhmgQTv00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOk/9/kZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-75001b1bd76so3716343b3a.2;
        Tue, 22 Jul 2025 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753211424; x=1753816224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJv1+TF2aY1G9+2B34MvYv5nXQt0E2zq0MVGsD3E+pE=;
        b=TOk/9/kZpjRDNUS65bXEDAUMjU7dTKzuPjapG8POVFjjZmjVPdqppJ0z4w+jdlShCm
         eQRq17yuTwykYYYHd2IjsYSMuTsnNKTL0HFtM31nB3pWgLj6k8NEPPitLbFpaUNc0BOS
         tr4MjzzoJ4qb0OuCkzGqK5+geFXGRRBruj3TYn37/DQrrnxLy2Y+8/trM78HOjICFsoF
         nncAirJnk5WZ7ZxbIDbRQ+ZtsFhy/CIP/sC84ROEjqzk/YGkW8B2K0rlMj3I5wUOPT0g
         NClwSBvtEEBJAtoKAyLpNOVop+gG3ip7MiDNqKpGlA7DMb+QNOD6fRcpCNhKyfQ6sOFw
         2E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211424; x=1753816224;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJv1+TF2aY1G9+2B34MvYv5nXQt0E2zq0MVGsD3E+pE=;
        b=MOTFiWtmnQyuwy9JVH1xqBwt3XmCbvtLef/XD7UdkNI+MrIhLBunGu32nehUZgg+xJ
         SwQKD1rp1M2od3mlTLHR6FBWgals44BfcX/bWDGuswLL1jUzFSrIupsvJS876DoomRhh
         P3MLKjlDvKrlLe9D+soaEKcmUWmtZ7o3vnOwscCr+sbyD5jBEFb5ArjZ2MS6/gTO+V35
         II71c6VTrOAMXXcdVtwhfe0tgxrVAg6t5qDUgrgjGdXb7f2A/7OSoRTqVQyw8eFFfDIT
         JnhaxPFTmwkjtqBaQcVAsWH6SPIrzGvG0ZPo0UiaYPggkMNFL6RCXKhhf+r1+hQ7CxOR
         ZxnA==
X-Forwarded-Encrypted: i=1; AJvYcCUdujb2T6xaRKErZgye9vRGLAwe1HRq9zzUFsOw8QJIK7IK2tiaESpdrOyX9GKXN7G0smHbK7Qc@vger.kernel.org, AJvYcCVyF/a4JAgEP14NTPrTyrULchKJIAHFyJ6EQj/92fRy/W42WLnrKf11Jp3of1+0buX3QeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH+GZdJ3EyQAiM3r7PFQNpkplctIfsFkJ4BAPYv+D67SZmNxb
	hJklbPNhIrS95SoCDHH0ydB3aZT3dBMZlqWNqAcFf6P+be7sU+Ih2b8s
X-Gm-Gg: ASbGncvqKrEQb6h+xgai3x+XbukN3rIsxhnZ2iH3kV4WtzDkfUif5gS+vAiwwlaNSsq
	3//7mcaw/br0vxRg5pbSQcc+gRHgFleG4mTvwUOUHKcmCA2vgfc9GwOywk6LspfqPuAueQX4wnu
	9WSeh0lt8GE5857VgmLvGLuLpR/ydNdIjVSUrLFSgl9MJi+JHcUNJYl4xeIGjWu6khFRaewUzqf
	aIu/fVfUjHrup06daaKk9RVk6LgsEfUQbteCJ/uvZAf3wxutWL6abaQpgC9iGD39AtcG1kpoIyj
	UhBOa5AEAl+IQCbtSaZisXLiPoljhoQAV/S2ak0lT8LjIGQvniLHFaQtCmaoOXmh+DMT1ubw8cm
	qG+dq+Y4X70gWnqovNvsItttagEqf
X-Google-Smtp-Source: AGHT+IEnvjDmNv7m8y9nymLWTnp8judq/PMEKd5Ke5G6clP9QC+qdfNfGwBUxZC8urDNK3ry5T+VNA==
X-Received: by 2002:a05:6a00:2da0:b0:748:ff4d:b585 with SMTP id d2e1a72fcca58-760363f404emr566381b3a.19.1753211423818;
        Tue, 22 Jul 2025 12:10:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbf5a13csm7977381b3a.162.2025.07.22.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:10:23 -0700 (PDT)
Message-ID: <65744a70c11106a54ca2df212a9fd264e4340e2c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
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
Date: Tue, 22 Jul 2025 12:10:21 -0700
In-Reply-To: <83977f81df181ba05a6388f3f542ec027ff44189.camel@gmail.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
		 <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
	 <83977f81df181ba05a6388f3f542ec027ff44189.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 11:46 -0700, Eduard Zingerman wrote:

[...]

> > @@ -2274,7 +2278,8 @@ static bool reg_is_pkt_pointer_any(const struct b=
pf_reg_state *reg)
> >  static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
> >  {
> >  	return base_type(reg->type) =3D=3D PTR_TO_MEM &&
> > -		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP);
> > +	       (reg->type &
> > +		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
> >  }
>=20
> Note: This function is used to identify pointers to packet data that
>       might be stale after call to one of the functions in list [1].
>       Once such pointers are identified, verifier would disallow
>       access through these pointers.
>       dynptr_from_skb_meta() is implemented as:
>=20
>         bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metada=
ta_len(skb));
>=20
>       here any read or write goes through skb object, not a pointer deriv=
ed from it.
>       Given above, is it still necessary to list DYNPTR_FROM_SKB_META her=
e?
>       Or some functions from [1] can change skb_metadata_len(skb)?
>=20
> [1] https://elixir.bootlin.com/linux/v6.15.7/source/net/core/filter.c#L79=
89

Nevermind, it is necessary, otherwise your tests skb_meta_invalid_data_slic=
e*
would be accepted. Sorry for the noise.

