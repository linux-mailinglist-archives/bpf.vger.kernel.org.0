Return-Path: <bpf+bounces-19723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AB83041A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956D41C23F89
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55711CFB7;
	Wed, 17 Jan 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="J2Ime0pY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r17Hk7sJ"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F519BA5;
	Wed, 17 Jan 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489371; cv=none; b=Xp65gIznLp+CNsQkyZN/oCl2UkSiYGN+YK6nG7mTny62Qql5UQ9yIEw1mPuwlhpSEQHcFmBnYawZLHun2rns2RfQvuCRL0gnUmulwcfBcSmwi5zY2feglZjhT5cmvu25BfHonZQa92ECX9VU7pj+lBXUx8SQT18bZImXIvPNGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489371; c=relaxed/simple;
	bh=qHQ+N4umlEdjLufFxkO1Ro/Oj3IAM6psLP+SKnUMgPI=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm7r5AzFQHhe1L6ehLTBWv2e3OjcEWKLj9oJhX56CTQ4w4gWSWRaUM9SG3Bgi79wWS36qqmTXQ2ctWGXhxCvKd8JyGjAN+Rj8agKXe79KI32bdVvhG/OsW4tgmZAV+5GsFMJCNSRkqu4ACiYLq9m6w70/lMobY5CxgosTcj50pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=J2Ime0pY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r17Hk7sJ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id BC3C73200A74;
	Wed, 17 Jan 2024 06:02:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Jan 2024 06:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705489367; x=1705575767; bh=kRTRAeywno
	UPKAnDlbOo2Rog7s7oJJTn5uJyXbPOWdw=; b=J2Ime0pYlsYOx881YUe/h3nqUD
	CaZ19S1HP8RkY+1nsESGJHeOj86vc7Dw2NgkTxBt6tlUYbn5xdhKphpQNw3Chxgc
	P4Y2Vw/4CBFCEM9s+WqQ/A84uHMNza/RyhhpSOi2KwiPNjOlDOoYY5d2V7E4M8Ia
	v+Z29nQQ180UHTgAJWHoUe2Wz7XufFkmyWe5KxIgpfBu1OrEWQL1WsB8v8HmFnhv
	vuS5cU0dxwHRt8O8YjhF09zoT3I3W634C43cb00tU+Y6vU5yj0nHYintt2I0Jxjc
	/vUIw6Yg0wC5t6mqnPf1TrixfvMzBF/JHnv9SD1aUWowyBcFY6N3/ccqgUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705489367; x=1705575767; bh=kRTRAeywnoUPKAnDlbOo2Rog7s7o
	JJTn5uJyXbPOWdw=; b=r17Hk7sJ/tUT2HFV3zFGc7g/yFugl9NV904vKYKZ07mY
	bGVhzgkKZBg5HF7brtN4f5G45jSHJiFe0DLO90HKK8KPBLnpO+QoxaLbA5g2fMUk
	/z5oToY53Rd4N0OAVfXxQTK4b12/KnXBDbeKVqkOTZ337FCL0G2HG9Zzz/ob55G4
	DNZU0YAAM0a8xHAPghTf27DYTF8RwCTRH39Gm7aVnBJPup2O+A2acut4baEgDOsJ
	gI6+tRO9IlfHWJ5VHopPzrTc90dfcTI44fKDFGIwscqXyT4rUGPeeqUEEB5vNT5V
	TMvt3fjeE7UC5Xi4q+LXy8uSzhAe1o6KNNwwIELAbA==
X-ME-Sender: <xms:1rOnZevhlxNa3IBGmp2mvZ0O_02J9K4UVCZpfw8VSbuTdXLYH_xb9Q>
    <xme:1rOnZTdvPiNUtk8YyPwMHpMxsPji7gujlq9l4bK9r88OTvnJy4a9IsBR0Av3Xyvkh
    bjW-xPUQhaw6w>
X-ME-Received: <xmr:1rOnZZwclUlrgRDRIcxKDXXKJSUki-70CG3Cc-DxJXgBR3zcJd4QouEwgwN2-SNElw_6Hqn5nL9JASlcUurLe7kFHFp9W65vPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:1rOnZZPC5DiEO1X4H7FAI1U0-8W-ApuxvNQMO_iMBd0_ULOezrrf2Q>
    <xmx:1rOnZe-u_tXhvqaoVqVyStYfQseolTAymhbyXLd6mvga5edtsry28Q>
    <xmx:1rOnZRXS1fV9FHX8tzKxmywXo_1BDE6-D9D08zvjPqWOsQkXi1CxtQ>
    <xmx:17OnZf3auseHDmO_yGAAhVOGEJiQLyeZrzKfk2dqJe98XDPMJ718AA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 06:02:46 -0500 (EST)
Date: Wed, 17 Jan 2024 12:02:44 +0100
From: Greg KH <greg@kroah.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH stable 6.1 2/2] bpf: Add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <2024011730-droplet-related-5a61@gregkh>
References: <20240117094424.487462-1-jolsa@kernel.org>
 <20240117094424.487462-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117094424.487462-3-jolsa@kernel.org>

On Wed, Jan 17, 2024 at 10:44:24AM +0100, Jiri Olsa wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.
> 
> v1.25 of pahole supports filtering out functions with multiple inconsistent
> function prototypes or optimized-out parameters from the BTF representation.
> These present problems because there is no additional info in BTF saying which
> inconsistent prototype matches which function instance to help guide attachment,
> and functions with optimized-out parameters can lead to incorrect assumptions
> about register contents.
> 
> So for now, filter out such functions while adding BTF representations for
> functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
> This patch assumes that below linked changes land in pahole for v1.25.
> 
> Issues with pahole filtering being too aggressive in removing functions
> appear to be resolved now, but CI and further testing will confirm.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/r/20230510130241.1696561-1-alan.maguire@oracle.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)

Again, a signed-off-by please.

Resend the whole series?

thanks,

greg k-h

