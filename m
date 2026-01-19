Return-Path: <bpf+bounces-79520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B15CFD3BB10
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 23:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A813049C4F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA02F616E;
	Mon, 19 Jan 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMempV1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A90258CD0
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863410; cv=none; b=MAi1gune/kNpNA3NP2DyXpXt+rlx6yJck+SVXiEKk61X8Rq2zVc0Hjrtg7KY0l1D+cDSU4kERDq3UNz5m+bGc/qdapcJZAquFGjxCs9kosIzQ6LOqfxJsw5D2t9N8jg5abfFCekHHVTn8xNS51ln7/Z7C/yEITjleTrH0U44nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863410; c=relaxed/simple;
	bh=pA/Rkns9EDC6SrTcf2DeyxqLJrTr1AJ+cpLUasj1r8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXE4TNlyL8sU4E+IskmJHHyhKYHt/nFLHzXzb9c+IpRNqJocx5UDNZGvf4RRQ/87ib2J2zYrHBt64x39btwkZ5get1kWZlzjwCIMM3+vxr7xS7aE/j0dSn+tt23dZBwu0tuImQLe/KWV7zRnsl1UNLiIrYIofEOxoon7iAWTYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMempV1K; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ae61424095so4829501eec.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768863408; x=1769468208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pA/Rkns9EDC6SrTcf2DeyxqLJrTr1AJ+cpLUasj1r8o=;
        b=AMempV1KZ5Zm8bszaWSswOz2aKKknsacZ1qOfG+eWFE/VsJgPbCdJF48kA6t4O1Ezs
         C4KTdNm3rA3dDxCBpNUasoQfyK087/V/efk2haRcrjGVgRyUkmKb85B43frEJ2h403ji
         4DW8kOsby9bn6gr/nywQxj6/KZfBXrf5XxLr3uOUoEALBIol7Y3JNAxUA+9f9JrAb65G
         3eqGBPbDgLpLJapzJvzHlaSsdUZ8H3M7onlbWcCgzccDwMxBWmdAmfi1jyNelw1gVJU8
         KvhSjU/a2xZOajWZibAUgkQzEi68dL0/c6fnWZ0MPl99ouSdzfBfKdSsC9w0N+cSLuxm
         uDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768863408; x=1769468208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pA/Rkns9EDC6SrTcf2DeyxqLJrTr1AJ+cpLUasj1r8o=;
        b=QtjOt+Nv9nfY5U8lTPwTexLkoo3mIAoV51Phk3LvlDaieeSKfik962KpghrGkUi9kp
         ni+AUnt6PyHmBoW0hR26ZTU7O5rcUdXhkWxBOz+a6CoZOzDSlFgpaK0B8QvXO0fRcqBo
         BUWxPyR+uqouOiO4hest4OOK+W396F4IrKKd4TWTpXkcFv1A0+vT34ETcrFNrLrnn2re
         vr/o7hyxTjC36fzLEqxsdr1cjH5IZwGPmCezPXyklwRiUMR3/NCH+E09BBQiiKwRrNsZ
         HNlEMytLB2k2pzYObMLsAYPDlrKBl3IP0myhUnpxy9ITjnfahUuoOekr0PYABT6sYc29
         Me5w==
X-Forwarded-Encrypted: i=1; AJvYcCXlTh/qicOX8bVLpH1mu3t441wqn6ySwAWwAHLXCFppQ/F5D87NvgUuMdAooCJ4GBkOxu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQKT8wzYthQLGMuGWDkUr3Dl7YD38Ye/Tg+RABXQBeVjOgAM9
	fWINmWydlsVcSAuoPscb8PwW4+LgpgpAFmfNg/G0UqwXYCmmKv41hkCw
X-Gm-Gg: AZuq6aI3swHi4VyOok2ViL2hrODi1f57W3rJjNBC44WA/wFD9VJFmVUGATOpcTzYGvM
	lm0vFE+LL70cvR+eouKLV5B4shIXIH1yqr7TKJVGS1iaGAf+G+hWNSvzKmi8zvGmjs4Ku9YMK42
	8HU5Q2XmcF2HjxHK8AMbkO4B9ugUkwnNTmsEPI+VrPN7Of5kJpuk1L7QNKgVf7RkdQtzvoCU78P
	BBjjYqs17Xp9N65D2XOf9PzuYNoH+cMfkI38EipT5UEuWCOQ+JivWe50myKQic5i6oXskfb7QjD
	rgovjK/j9U0ouOCuUHAWEwHa4LOzeqr1Ov7lZ+6kyr7+FH36swO9dDFUPprYPSQp4Jj2IY3ObFy
	M1nb2BS/+Jvk3Msktkc7H3RTYn59AsRj7LxFYLxlt/TVtOBThGHh8r9mmkZdeo1Qf4zBZzCYX6G
	cFmScIQx1+SIOoRul5myP1g7Tr8oAVYuC46OXELSTTzxbtP+0zAzkNSBGp2kRMY4VOIQ==
X-Received: by 2002:a05:7300:a883:b0:2ae:5424:e5a4 with SMTP id 5a478bee46e88-2b6b4eade90mr8720700eec.37.1768863407843;
        Mon, 19 Jan 2026 14:56:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6fc2820a2sm203553eec.35.2026.01.19.14.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:56:47 -0800 (PST)
Message-ID: <dba164866bf964e27b3bfb7fc0ec085833e6fb9e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:56:45 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Remove pro_epilogue_with_kfunc test program and its supporting code in
> bpf_testmod. This test exercised calling kfuncs from prologue and epilogu=
e,
> which is no longer supported after the switch to direct helper calls.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

