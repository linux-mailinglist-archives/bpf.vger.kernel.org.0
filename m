Return-Path: <bpf+bounces-49525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1220A198CB
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D3F7A2201
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3962153EE;
	Wed, 22 Jan 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C+R85aej"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD72B9A4;
	Wed, 22 Jan 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571884; cv=none; b=HCKsbczm+dwv/aOGFtklCiirvxa3AZfHKi6L5JDtlpn1jH5Cbehniz0SS/8G5GgbZTApPNerWjG2ml3HwRmuK7cVjywlIFMlLTY5W+SznEnPczX74VU2EdiRAROgfywm/qNdZLkVJs2S+ObNXJX3U41M5Pcz0VtIckUe0gOv/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571884; c=relaxed/simple;
	bh=B22Mi6HTlwfWaUxX3VfSAh8xgbaLxW79NBPIfiW8uJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udt/+Y3lscPpvgCf7hezeSfaYIrYqSKbT1iFbqM8hCDTyIEEJzIrPEcfm138haeXcBRRLs45RgLPq0vx2ojlxZZas91xyAwynLe2aGHUJ1zuVezfl3ayCK/Tio152OyiaD4kluNKXCa4xFone2ZJTagV80kdTMcygTvf8Yrrvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C+R85aej; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571881;
	bh=B22Mi6HTlwfWaUxX3VfSAh8xgbaLxW79NBPIfiW8uJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+R85aejVDCXd7p7pIkn3d0mJYapYMyYIKmX04LPzdE36xOvqQxNSdGvAsmg1mfaB
	 djkd9/H0zygqKY+dT+RAd0X7ANLSyaI7K2/oGFrcQru0OIXKyet1oU+rUwGpTB4PZb
	 fdjTd4649ToGr+2lFchn6E00ldaxwXzncjMi72JA=
Date: Wed, 22 Jan 2025 19:51:20 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Kui-Feng Lee <kuifeng@fb.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation
Message-ID: <698e7023-7725-4904-ba35-6b32955a3c40@t-8ch.de>
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>

On 2024-12-11 00:23:50+0100, Thomas Weißschuh wrote:
> Pahole v1.27 added a new BTF generation feature to support
> reproducibility in the face of multithreading.
> Enable it if supported and reproducible builds are requested.
> 
> As unknown --btf_features are ignored, avoid the test for the pahole
> version to keep the line readable.

Since pahole v1.29 this patch is obsolete. From [0]:

BTF encoder:

- The parallel reproducible BTF generation done using the new DWARF loader
  multithreading model is as fast as the old non-reproducible one and thus is
  now always performed, making the "reproducible_build" flag moot.


[0] https://lore.kernel.org/lkml/Z4-TDt42dTKZvCo6@x1/

