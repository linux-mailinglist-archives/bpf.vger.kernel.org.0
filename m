Return-Path: <bpf+bounces-64388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB6B122F9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC31540F0C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924942EF9D1;
	Fri, 25 Jul 2025 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyJubIWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4612EF2AD
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464383; cv=none; b=cLdCQxX16lSf8fs2Mx60F8JYLppsqv7aDDs8bYWVuNVO1GKzeoXx3cwT8NezwUE+uHOhCjEpudcWHWqM3qr2OMmYk5LwLUhSwkmEus+Yx9HwY4V7uU0Vr84JWOLJ+j1PKbqJo+ggceVxP71N9eTnJu3IjJdKC8hoXGI7Ya0LdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464383; c=relaxed/simple;
	bh=btVAVuegSIOJDS7xfq8vYwmHLLgaL3FZ0h4RPUQljWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVibzOGlZzDj4/RnCu2wZSC7OmvBdcY5nVPXrkPpRqNSN3ccDKcNaHja+/QcCm2qpM/khoml1nOOtJO6FfwdrYNYbrr+fXhW7i9xqMdFGmSQPZq0/pGaEMUjRmeNSMjfpGDnIldkUJZ9AMzvjBFV+3XGn4OdGcHTG22+Z0NFmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyJubIWs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235a3dd4f0dso15552695ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464381; x=1754069181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dj/8pKt2lkynOdzWDFAlJNH/DrXqa4eK9EAINEyTaAM=;
        b=hyJubIWsCVHQgPlscUaADnwLsTGungHPG1zNUK734gWRPkebs+cPQnhfHP3SjWqHTh
         /gInZyAFqPZuRef+wtLTqgyKzhvSp/JFvnzK8oAQ2trRZsBiCOM3VlGte8G4VsQma4U0
         9/rKEFyYawpMg84nlup4R5noiS6bhSiqtpx32RpZvess8S4sk4qSmlpNWTmAG1YX6Kxc
         m9xTWMdI96w3/EbJ/TyoC+PB3EcwsRcbodFVlsIJMlwWsw4YQBeG6iS8E4Zd/9HEpq2x
         +0whF59pe2To0lnjnAcodFDcPWc1P19LtJu4yQqh1KVOsuyY9bV2fcLMSbYaoBCahcbj
         G1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464381; x=1754069181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dj/8pKt2lkynOdzWDFAlJNH/DrXqa4eK9EAINEyTaAM=;
        b=Iq5DLDyue+2wVmDPhgvPpUn4MC0sEz1iuqU2tzZSWvf3XbJik4lmRszFxDFEowd2wR
         KmL9HijENefIJBdjp+rxExVw6+QbfVS194a8AlOgxgcpu/iN6X0KIKYmUIlBhC1zaDwt
         TgA9vpM8aiuE4aAX7VMxnLmwOHQUFCmWMrIs4PVZmhP9aHyZ32FKjM+BGgOGon1z4S+f
         UtlP5HvZ1AjhWx9BZzJLx1Kna0Mi0W6pzCNSQ78hYC6HZdQR3kaNbvpBGqPZqzMg3bg4
         8uYJrhPlCp4FqAS5NEzxorGQgyIHUD6WbuMBkM1euo2cQj6X5sP2/j7eH+/9DJAjorpH
         qPvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmjOJMv6Jr78B9hIFpBiOjtcr/MB47AB2u7nROgAj4lXLwIOHTiqg2BT7pZVtYieaAuVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5Dx09+4UV9MRmd7DYrDbmAefuOmgutaLQ5XQht2INeVkSnmQ
	+ji0umFRj0/C87uIEleMzRBK7gdCn0y7IWxGPf8L2/urmljmEScjPCZwiTNWuA==
X-Gm-Gg: ASbGncvM1lPRLqPJ+uXJr3xhWFC8RrlukYxbYfNd/aqw4Ro29tgPvCUyUyGGNzgZr4C
	aCd+xpgWTbbxXp8XLrdebDRp0ozZvxwkWn7V3JZ2k1rtN7rvBHxhHMQVLq3yKSEa1kmzR896uAa
	sMcZv3O94SV4UG4vUkxHpXVAbD4/TmWhAs9rUX/FdSrbxEBdUNNr/AQCDCroVA4yMfSt9vTwjn3
	8KcPR1AvZc1qkc9xxI5lMmETAm+s16qz+GnPGdBAo/fiJS6mdTcrP38n9hM+7T5cyUEDZXA/VBF
	/0hh18f1qOc/4NUAegTozwtSlPYlaSgHGtbDLdAM1HymSPJIM82eEQhlBUEfhlX9nnYGzDb6Wy3
	nP7THkklqh0yGVKevfA==
X-Google-Smtp-Source: AGHT+IFAh4lffS8UnDUifhugDWVgETNoyhUY5GvR8YEQSx2GW0DGmxSvlk8IQvsEEQ/HI3cCBDuh4g==
X-Received: by 2002:a17:902:db0e:b0:235:c973:ba20 with SMTP id d9443c01a7336-23fb314746cmr47188215ad.49.1753464380852;
        Fri, 25 Jul 2025 10:26:20 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30ff62sm1744995ad.38.2025.07.25.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:26:20 -0700 (PDT)
Message-ID: <2c788b2df52c93ff786f95204a9b8406e9caccd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Fri, 25 Jul 2025 10:26:17 -0700
In-Reply-To: <aIJwnFnFyUjNsCNa@mail.gmail.com>
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 19:42 +0200, Paul Chaignon wrote:
> During the bounds refinement, we improve the precision of various ranges
> by looking at other ranges. Among others, we improve the following in
> this order (other things happen between 1 and 2):
>=20
>   1. Improve u32 from s32 in __reg32_deduce_bounds.
>   2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
>   3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.
>=20
> In particular, if the s32 range forms a valid u32 range, we will use it
> to improve the u32 range in __reg32_deduce_bounds. In
> __reg_deduce_mixed_bounds, under the same condition, we will use the s32
> range to improve the s/u64 ranges.
>=20
> If at (1) we were able to learn from s32 to improve u32, we'll then be
> able to use that in (2) to improve s/u64. Hence, as (3) happens under
> the same precondition as (1), it won't improve s/u64 ranges further than
> (1)+(2) did. Thus, we can get rid of (3).
>=20
> In addition to the extensive suite of selftests for bounds refinement,
> this patch was also tested with the Agni formal verification tool [1].
>=20
> Link: https://github.com/bpfverif/agni [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

