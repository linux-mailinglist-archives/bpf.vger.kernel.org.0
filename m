Return-Path: <bpf+bounces-69905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C4BA629E
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797974A0E00
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691B227586;
	Sat, 27 Sep 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcM8i5kZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAE125B2;
	Sat, 27 Sep 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758998204; cv=none; b=mqo9osCav1fOpcVLiwP6oKvFAqIwMz66aPpugICY7w4kIl7/k3b/ycNsYnCihajpkZbT876TxKjB1oJ46jR/1UzqAX/PzX888oJg27UFEHy7sb/T+BS+LQtw7MBlo3TkOqPXWqcho3pbfyskPVlWksmoRm3eB8UXiKdPhdY7YkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758998204; c=relaxed/simple;
	bh=cDoN8YEqoiJ/LYuWob2GFy91bd8eV4dOhvZov1qF5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQnpzwfx7LlfVY5lBJl+Jleho6kcice/UiqdTStklkLbun4C8cSSEcHjuheCmUfNCTKXXn7LvjUeuW7O7VTby9BkoPs8xGE9qCGEOnbjGaSiObe1oImc/YzFVWyHSXCASUIgUwDoItFPUMJ1R+U2CF53KNxndTjkbW3X2r4XYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcM8i5kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C6C4CEE7;
	Sat, 27 Sep 2025 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758998203;
	bh=cDoN8YEqoiJ/LYuWob2GFy91bd8eV4dOhvZov1qF5Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcM8i5kZOQ65hNzSoSSpOPugQLe9Q5hjHUnTGomf0Yb6qlz3EQnozwfDf7oa1nRcX
	 9IThXfN+Jzz49iIS9r3fUIj0+rqOKjB9TRE2wV1YJAlIunPj9xJoMnYh66SWzoplR3
	 vbIP3On68/6I/+LSeHCWHGeXrwKYGSS7XxA/IjImHuDV/9sSkG9ORJsjQ3LCBY7jPR
	 RIiflMeXOvTnAHbKVVDqlJEovHDef5cRNREBrub7ppmlkgm631f7B8DT1hpN73LnXO
	 mPz7QHyhE2nk5aOIwnM3TMVawA3f1HrGxmze+WxrAsGtjsVcjdJ4DQ8aK4N4DJclyc
	 T+4RykbSpF2Qg==
Date: Sat, 27 Sep 2025 11:36:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: bpf@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
Message-ID: <20250927183641.GA1719@quark>
References: <20250925225322.13013-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925225322.13013-1-ebiggers@kernel.org>

On Thu, Sep 25, 2025 at 03:53:22PM -0700, Eric Biggers wrote:
>  	ctx->obj_fd = open(pathname, O_RDONLY);
> -	if (ctx->obj_fd < 0)
> +	if (ctx->obj_fd < 0) {
> +		fprintf(stderr, "Error opening object %s: %s\n", pathname,
> +			strerror(errno));
>  		return ctx->obj_fd;
> +	}
> +
> +	ret = bpf_obj_hash(ctx->obj_fd, pathname, tmp);
> +	if (ret)
> +		return ret;

Correction: the 'return ret;' above should be 'goto out_fd;'.
I'll fix this in v2, but I'll wait a bit for more feedback first.

- Eric

