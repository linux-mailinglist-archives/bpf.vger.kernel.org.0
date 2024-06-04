Return-Path: <bpf+bounces-31386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B208FBD6D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19DE1C217D5
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1714B945;
	Tue,  4 Jun 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0K2rCbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82817C96
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533441; cv=none; b=Xx2laUPy301zbzCrbaxqtTe5edcXeRk8VF/a2tSOXrwzYODfNL3NIHMAD8BPDbGmW41laqbn4QY9HIz7BL+8wpY8OfFO34QYu+aO7RjENqqTBnkely9+jkqp7e9I1iijxSkUGL2x9grU7stdCiamgFt8hxDhzGNM9NOELyS3BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533441; c=relaxed/simple;
	bh=TtWrZ4cYjAUqcj1tqTqzWjEE9wB3aFTQNkpIUt6/x24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJGUJ9BRyj74E469fBdw/BXiAi+kX3g5FHH6fCAegfpuFvOjg3kWeHLn8JmIyBQNscEt5UbqWbCdnmj/jpn38DaJQrnyyA8s94rk/jYy36z7cyrzfqeBiRO6+utgIfgYfLjbDk47O1Xlv//7pgs3ZE2b03Xt82/gz6zHvBxLSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0K2rCbE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b5d0c50so45437125ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717533439; x=1718138239; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWzxPZxW5AS0CkfYrc1/NhyT5h4PMkVFigq0jjF7sb4=;
        b=U0K2rCbEoNUrbv2CQi4JRSbQDFv8gqSInyaeWkf/td763KJI5kz0ncYyfPq7CI2Kip
         UXiAV+2jaVkJwhkc54ofxkcAxYHa0l491Ddrc6Xd05PIDD/DIgmBwqwkhuABclwNWG/z
         Q3qYCAlqgN0d2v0yxhJd0anXye28OFmvncorweT5mMwCC7RBjkf2OQsQvvsenVXfOi2W
         ObJLxqzwpN0gMqeEKqfE9BnzPXPJiJQ0D5oZN41ryAGy7ElvHE70TmJ5nXO6oQNHoPs5
         GaWW74TiMAplKsy0t0E/FE+bsLqMVR/wAQs8z9VreizLrxwWMywbMW7ZrbuESyIRzHMn
         AYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717533439; x=1718138239;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWzxPZxW5AS0CkfYrc1/NhyT5h4PMkVFigq0jjF7sb4=;
        b=HWyAJAiu1cYsMhohbzhXXwVhFkjdxTUsiB5M4LdzeRHmsjL5HTqFnaTHlE/wpp3V2/
         BC6ohGEa3nAthU02U4GTPKK9467QMJN6T/uUbQCLSEzoVE2h0BNc9jSpv59L5ucsKbzy
         9WDkcrt4skGAm87hJszGiV/LeSZ5YmEUeRCUVCiyPPsjiYHW0n9V19B5L7GoeTn1DtYC
         lZz+SEVp1JAA3G6N04qQzOUXjwooBoy7TbOSXvXN/PBMSJkUOd5PIXaPu7KdpzoXrJuO
         TPex88/paiUjNe2U1qAf3s+6KMlRAPmO8g+XO/XNDYvx+d7dZoEzWIN6SUE6SV0xsIgC
         NInA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4VpH4STr+IfBHwNwdluYO4EtqkG9fkx09+q/hLvBsT2mgG8d6hpWrUjH6OTXcgzH1L92K1ayLtLRSTDeynchHF5v
X-Gm-Message-State: AOJu0YyQzKTT7BNODMlszVKNyZLp0j9raF9x0+obr1BZnhmYOapppI5e
	GKfqhh3yvR/XPgBHO3NsCmm22wh5Ms3aoPTZfVz1FYsbLo0ezqotM0vKjA==
X-Google-Smtp-Source: AGHT+IHsxkVpQyRHLj5Vjd3bTTgjU7wLgf3YTCf9YxiZgzN25xFBNMopuUOmCIiSk0aDLfPGcG2j1g==
X-Received: by 2002:a17:903:22c3:b0:1f6:782e:da23 with SMTP id d9443c01a7336-1f6a5a84e4emr7988855ad.63.1717533438741;
        Tue, 04 Jun 2024 13:37:18 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f67f8f68acsm39440985ad.276.2024.06.04.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:37:18 -0700 (PDT)
Message-ID: <91750196c22c77d28d016ff51ff4bd3452d499e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: add BTF field iterator
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: alan.maguire@oracle.com, jolsa@kernel.org
Date: Tue, 04 Jun 2024 13:37:13 -0700
In-Reply-To: <20240603231720.1893487-2-andrii@kernel.org>
References: <20240603231720.1893487-1-andrii@kernel.org>
	 <20240603231720.1893487-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 16:17 -0700, Andrii Nakryiko wrote:
> Implement iterator-based type ID and string offset BTF field iterator.
> This is used extensively in BTF-handling code and BPF linker code for
> various sanity checks, rewriting IDs/offsets, etc. Currently this is
> implemented as visitor pattern calling custom callbacks, which makes the
> logic (especially in simple cases) unnecessarily obscure and harder to
> follow.
>=20
> Having equivalent functionality using iterator pattern makes for simpler
> to understand and maintain code. As we add more code for BTF processing
> logic in libbpf, it's best to switch to iterator pattern before adding
> more callback-based code.
>=20
> The idea for iterator-based implementation is to record offsets of
> necessary fields within fixed btf_type parts (which should be iterated
> just once), and, for kinds that have multiple members (based on vlen
> field), record where in each member necessary fields are located.
>=20
> Generic iteration code then just keeps track of last offset that was
> returned and handles N members correctly. Return type is just u32
> pointer, where NULL is returned when all relevant fields were already
> iterated.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +__u32 *btf_field_iter_next(struct btf_field_iter *it)
> +{
> +	if (!it->p)
> +		return NULL;
> +
> +	if (it->m_idx < 0) {
> +		if (it->off_idx < it->desc.t_cnt)
> +			return it->p + it->desc.t_offs[it->off_idx++];
> +		/* move to per-member iteration */
> +		it->m_idx =3D 0;
> +		it->p +=3D sizeof(struct btf_type);
> +		it->off_idx =3D 0;
> +	}
> +
> +	/* if type doesn't have members, stop */
> +	if (it->desc.m_sz =3D=3D 0) {
> +		it->p =3D NULL;
> +		return NULL;
> +	}
> +
> +	if (it->off_idx >=3D it->desc.m_cnt) {
> +		/* exhausted this member's fields, go to the next member */
> +		it->m_idx++;
> +		it->p +=3D it->desc.m_sz;
> +		it->off_idx =3D 0;
> +	}
> +
> +	if (it->m_idx < it->vlen)
> +		return it->p + it->desc.m_offs[it->off_idx++];

Nit: it is a bit confusing that for two 'if' statements above
     m_idx is guarded by vlen and off_idx is guarded by m_cnt :)

> +
> +	it->p =3D NULL;
> +	return NULL;
> +}
> +

[...]

