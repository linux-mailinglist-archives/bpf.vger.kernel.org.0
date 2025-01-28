Return-Path: <bpf+bounces-49918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB6A20208
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 01:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431587A1452
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1972905;
	Tue, 28 Jan 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fh/bfofd"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD0290F
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022597; cv=none; b=Lqs3YxjzFh0Bt+yxV56yBksPRHDiSIYnOewxgtn+sx9dzRQ59xvooh+iW7iobfpcbiNq60n4wyt39LQq6kOXbdyn9IVLQQmiE01WoqgZW7DzlxR6cHFJTMFjgO4emQ0ECqgfxO58DnTo7fdYvROzTMeIHSpBEc2BxLphnq5ALmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022597; c=relaxed/simple;
	bh=OY4JGWDbVjv6gQRTu+PfiqfThf0rSLEXTdIcrjJRLNs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=G16/qN/Ie4c97lNsYrcwt2xiokextXo0Bw5/bs8qXYql3qlfyXOAzMcb93GGyPt7IVlVw8sGYn6l397knb/F3h1aw2xTGihPa3TdVCnV/Kg7mbgCCz3XSBcaiyOsOVECwFmOK3O5JVfRVz6Gfd1GCTuLH9MhhxQoeVrVJ/ZxP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fh/bfofd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738022587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY4JGWDbVjv6gQRTu+PfiqfThf0rSLEXTdIcrjJRLNs=;
	b=fh/bfofdfxJekh7YMUBk4kKj10BPVedAZPd1erXavfBurDs9B9DKXxO6d8E+qE+3v9Ncum
	Egw75DMDJEFWaErEmiRHYVcwEYln2LFR3UdgD+wplXi6cHTffnish//jhdUBSKdQCAxr4A
	6yzSN+Nf0bHpeCDiiwLclm/OuiA9opo=
Date: Tue, 28 Jan 2025 00:03:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ihor.solodrai@linux.dev
Message-ID: <8bb182c6a5f7a7ac3668297bca5a31467fac93de@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v2] btf_encoder: fix memory access bugs
To: alan.maguire@oracle.com, acme@kernel.org
Cc: eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, dwarves@vger.kernel.org
In-Reply-To: <20241216183112.206072-1-ihor.solodrai@pm.me>
References: <20241216183112.206072-1-ihor.solodrai@pm.me>
X-Migadu-Flow: FLOW_OUT

December 16, 2024 at 10:31 AM, "Ihor Solodrai" <ihor.solodrai@pm.me> wrot=
e:

>=20
>=20When compiled with address sanitizer, a couple of errors were reporte=
d
>=20
>=20on pahole BTF encoding:
>=20
>=20 * A memory leak of strdup(func->alias), due to unchecked
>=20
>=20 reassignment.
>=20
>=20 * A read of uninitialized memory in gobuffer__sort or bsearch in
>=20
>=20 case btf_funcs gobuffer is empty.
>=20
>=20Used compiler flags:
>=20
>=20 -fsanitize=3Dundefined,address
>=20
>=20 -fsanitize-recover=3Daddress
>=20
>=20 -fno-omit-frame-pointer
>=20
>=20v1: https://lore.kernel.org/dwarves/20241213233205.633927-1-ihor.solo=
drai@pm.me/
>=20
>=20Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>=20
>=20Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>=20
>=20---
>=20
>=20 btf_encoder.c | 11 +++++++++--
>=20
>=20 1 file changed, 9 insertions(+), 2 deletions(-)
>=20

Alan,=20Arnaldo,

This patch hasn't been applied.
Just a reminder in case it fell off the radar.

Thanks.

