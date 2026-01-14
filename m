Return-Path: <bpf+bounces-78860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AAD1DC08
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E39C304A102
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8660B38736B;
	Wed, 14 Jan 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cuzGVv9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24137F730
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384585; cv=none; b=dgfvmmXB99N5/67Snja6JZIS8S7iakmGqJoBNM6KnukyYN9sTZMOw0E5FgR9i7ni4ggMW/SnqKslDSZ99IGF503nVTJVRAVf5AI9cQaE48s5icwZG8COtJTXrqsm++zO1mWL0GAjkX2tmdVfYbr1KouKir2NkgUmtg47XbxwoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384585; c=relaxed/simple;
	bh=2Rh0E6Gp2esSNQLEh23mThKotD32Snz3s+UKt6REioQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK4HlRO7PJ+wMbKV1JB0rbnkAt1E9Wr7p0hASz4swpupUcsgFAdGUpBDm0gJplvcI0TK14nPeXFddpLaaQXmq9cLJQC7YKaEeWtGC010emsurPJg4IKfpUT69WP7E/xu8qLQynn8Vz0s5RavWd8Prhv0b0StUcIRRDrpU6iGTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cuzGVv9V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so1072825e9.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768384582; x=1768989382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Rh0E6Gp2esSNQLEh23mThKotD32Snz3s+UKt6REioQ=;
        b=cuzGVv9VoRiTO0n5U0AHz1Dj7mEX5/dWlqx6HlATMLFq/8+wrireeavC839JDi1TRm
         EV4k7WZTBcog+7XpePwcXThq2l+TZeu7RIX/hnp0PR7/5rVSskICDZW/ZTDN/vfkOQPz
         hnA1KZ6YjSVaXWnxKhP+kewLQizxC6dH5P0yuehBlrLybbiFa44ShyIsp9KUJG7wPl/7
         RBDyhwuXoOqRbWIiDn9bUa30N2mBJD7sx8e6FUDqeDlYn9dlT6BPHJaj1qh+10e1CYtL
         oRWGq6XO3dUKo0EzLuBnLlDiYg2eDOISZSoIzAZQm5zqyppr6wanoo8H+dEGtxNkaAF9
         CKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384582; x=1768989382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rh0E6Gp2esSNQLEh23mThKotD32Snz3s+UKt6REioQ=;
        b=O1JnMT1H7n+Kvj66dFVPSPzg8VVfDQGu706CERpVk9r2+8YVp5KMH4qtnWX3qpEZTl
         i+SM1z8uQVkN0aa2c2VYzah4bbcZ0V2/RP9KOvPTUDXGWZl1fkMwNRM7HSRxqW9HHRW3
         nMnYaVO0Kpkf4lxLsF1P2gV+R+uQKUjUNpnnCld+Dltz3KOM+9hPhY7Sf/HU0vYBxgP8
         0TOpfot22YIY1IlNeatuB5XaYwF62SuZQDPorvwGrMBtqhb1n4oYTmPozgTohIOZ7Dum
         lk0lwCxtkVg+Ly1gL67YkhLkh+YIdYoVyKZMBawhKpbGGVDbdc6oQ1TYBr+jD+VpD6ZC
         XA6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJVpTcVl2Reb5c/MxdXLbYyB4NbR5iJYlCoSHqdMnXRhn7dIF1EiOn7HcKCWbIIpED1Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxN/dcuKedkxUOicyiOtPIZTzSJ5iSDEWnej7G7a0ayWXqu2FW
	AYOc2aeCNNGOoDbTXjOnZPcJzkvrpVgMGKWuxF5+J3aNNScyTRwiKH9nvJR8B/3e5SQ=
X-Gm-Gg: AY/fxX6au5KsfFJp/BZLT221HltyheWCs+8YKp+lmVW3UqQpHnbz4el/ob+nWmcO5pF
	cpyJeOb9ySpUVJPpoY1hWXFAl5KcQ6bW1K7fCaNOITwTzbJLWxAUx/KUqFW/g1bRHJ6440bf37P
	ro/CrkEswcHpcbZ7PqQUQBReiVv8DgONcgT5S+g2Fs8IqEk0d8xreQkll405Z69TPU3qOAQANko
	zIirFAUMLS4yjREcdG/ZB9ICrAH06lMBEGOPu/QCbwjFFOgTQZkS4F0KAZnHW/kEdEE0eVJHJXt
	aNhMXxGAL1U5RCjY2g1ZidaJtRhiLhlsjyX11S70aIN8U3VuRfzjLoAGciuVsm3yDUJs8xoNYw8
	PKEGy1S5aLiNdKXcR/U8PwKmjnos3W0nLvTkwqgpZweCXO9L3b7S1OstgbGXbE6MGtFbgz6FA4F
	U6hslQIGeJUPLwqdDJylwGrPe1bRRN00s=
X-Received: by 2002:a05:600c:6992:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47ee33aa21amr21454545e9.36.1768384581898;
        Wed, 14 Jan 2026 01:56:21 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm16156295e9.11.2026.01.14.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:56:21 -0800 (PST)
Date: Wed, 14 Jan 2026 10:56:19 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yu.c.chen@intel.com, zhao1.liu@intel.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa
 balancing
Message-ID: <cfyq2n7igavmwwf5jv5uamiyhprgsf4ez7au6ssv3rw54vjh4w@nc43vkqhz5yq>
References: <20260113121238.11300-1-laoar.shao@gmail.com>
 <20260113121238.11300-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlubd5uybwds24at"
Content-Disposition: inline
In-Reply-To: <20260113121238.11300-3-laoar.shao@gmail.com>


--hlubd5uybwds24at
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa
 balancing
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 08:12:37PM +0800, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> bpf_numab_ops enables NUMA balancing for tasks within a specific memcg,
> even when global NUMA balancing is disabled. This allows selective NUMA
> optimization for workloads that benefit from it, while avoiding potential
> latency spikes for other workloads.
>=20
> The policy must be attached to a leaf memory cgroup.

Why this restriction?
Do you envision how these extensions would apply hierarchically?
Regardless of that, being a "leaf memcg" is not a stationary condition
(mkdirs, writes to `cgroup.subtree_control`) so it should also be
prepared for that.

Also, I think (please correct me) that NUMA balancing doesn't need
memory controller (in contrast with OOM), so the attachment shouldn't be
through struct mem_cgroup but plain struct cgroup::bpf. If you could
consider this or add some details about this decision, it'd be great.


Thanks,
Michal

> To reduce lookup
> overhead, we can cache memcg::bpf_numab in the mm_struct of tasks within
> the memcg when it becomes a performance bottleneck.
>=20
> The cgroup ID is embedded in bpf_numab_ops as a compile-time constant,
> which restricts each instance to a single cgroup and prevents attachment
> to multiple cgroups. Roman is working on a solution to remove this
> limitation, after which we can migrate to the new approach.
>=20
> Currently only the normal mode is supported.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

--hlubd5uybwds24at
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWdoORsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiIeAEAyE9SkoPTsyFkBRkyPBoC
pzkAGjkincYpSGguv87R/CYA/AjBG2txgb/mG2NlcFAsgUWYMsnoFANpNYkc1sUa
9lcE
=vIqs
-----END PGP SIGNATURE-----

--hlubd5uybwds24at--

