Return-Path: <bpf+bounces-20021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA4E836F93
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D692903D3
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952413E49C;
	Mon, 22 Jan 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="f4rbwtZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVlk+b9A"
X-Original-To: bpf@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1F3E49E;
	Mon, 22 Jan 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945609; cv=none; b=mrkQliJizcp5BrtoP95A/WWW8AyS+kY+GZpt7z3cx7pLNAxmgaLwFIyPFfg6Gha2u3BGVuGwDmV9BrBtI0oClxzCb300bRBiYNKyN1osvcBWlL3HxhW8ozKfC9zQ/2ZJbfE037qPt7kmauHZNn4k7ICnkSEm9JyhMSrW6GAkPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945609; c=relaxed/simple;
	bh=Zemc84as28Qt/EvYBnMgtVCnIYBIanKlk2SL4PcSVis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbs/cwG4e58NDrooIXTvppHMz2HBmG8t7VWKnI9GGh0fSkGvxnSil5WW5TPR7SMdH+dPuNavY0x8gLhtPkhBrfvq5JYFSPR6G20iikcohaNzGPvaidWXYmLMhgMqwnX5DCGqIbo7Hd9biF4N3gL0uSI3JKQNNM6S4KwMaThxtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=f4rbwtZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVlk+b9A; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C7DFD5C0189;
	Mon, 22 Jan 2024 12:46:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 12:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705945606; x=1706032006; bh=e9LVoKSgLL
	tbY+Vvka55V3OHOtxAH3+B7CLqY3bumM4=; b=f4rbwtZelSM+qvHoGWCNMmvEnK
	sizHZ5dnwQ8Po8zDy+9/BXyW3+Mj1ywTIDYRUpUnDObQ6NvdEHqysurPUP7nbR+E
	HCG29BkEz5lLYx/1Ax7a7D9WDhT2YTfJoZkj5898IoZJg46jj9YIYiHU7Wl7Tpbu
	uPOVg8/gblD/D2FYr1xTHcFUh6SvYGyx2VZSYL52EoHZjmssJGfYVphbleYIG7Hs
	0832jTVicFnQbkffvNXTh0HPeA8Bkn/ac+jnKolaKyMDaNRFyrUFsEe5eUvguEZw
	OJz/vPdX6BkSwGXrKa7KhcgGcnJgGU2HUSGaGhDtfK58RkWImBsL14X9V9Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705945606; x=1706032006; bh=e9LVoKSgLLtbY+Vvka55V3OHOtxA
	H3+B7CLqY3bumM4=; b=SVlk+b9AObVBqLv3lHt5Tw5HIRgJTbKryBX3Fz2K/KrG
	kAhoXTEXHJtRBCLmtBMKuAVrAwAoYBoulmfR9R6jPxR+gxvXLzIk1ZT9UD2+LyIa
	YttQvkNOwfDUfWnD7LSdKd1Io4Z0i6EWLMI5ZJjn0dqj6PjkkXVcyh6WxQhzOHQS
	80JxNMxqrC5Sp8FO8iqxJvWDBb6KcO9gFx+NmLcFw7WRlU/Xp37g4nkkVm8D+Zke
	fX7Th3ww9W9BLXTbml2iJI4zwupVKlgrGeDG7S9j7CsacdC7CLApGj/TyZubin8m
	+OdvkxaX8KqJH7MDb7y1BkhfxkdisYig/tt7V4wk1Q==
X-ME-Sender: <xms:BqquZSOJhvlCu3PlfsoXhLQuj6i1TttI3CKg4_NM1I-9fJ_9DtL62A>
    <xme:BqquZQ_ytysYDjdcu0dW9gUDor1cpB2v3STFBMsj1KTSiQwceiweM7MPl0aHq4lnT
    etX_ZZnsBYUIA>
X-ME-Received: <xmr:BqquZZTi__8FGjSfaYRy5iCcTs2ahit9v2dDJlrz8YvJJzynmiqI6ABtQUjF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:BqquZSvd12I0nn1SNyKR2o5g_a9ccUbTdCRLUiFUTqvbi85pqb5dXg>
    <xmx:BqquZaeRhXDGcO2xKF8Cr8NtNmkZxJVJhU0mPFIwRKkE7UEcM9kTRA>
    <xmx:BqquZW2qlYKxStj-w_923AuVPddhjBj2OX8YfusEn24Z4oF9DO-N7Q>
    <xmx:BqquZbXbH80wBjOC4rMeAqKjyz4507K-TW-4RwaIKSpTsRcgqdQ3dQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 12:46:46 -0500 (EST)
Date: Mon, 22 Jan 2024 09:46:36 -0800
From: Greg KH <greg@kroah.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH stable 5.15] bpf: Add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <2024012228-styling-gaffe-f4de@gregkh>
References: <20240122080329.856574-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122080329.856574-1-jolsa@kernel.org>

On Mon, Jan 22, 2024 at 09:03:29AM +0100, Jiri Olsa wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.
> 
> [ small context conflict because of not backported --lang_exclude=rust
> option, which is not needed in 5.15 ]
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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)

Now queued up, thanks.

greg k-h

