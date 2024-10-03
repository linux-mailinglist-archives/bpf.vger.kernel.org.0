Return-Path: <bpf+bounces-40873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4298F9B5
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254121F23653
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B91C9B68;
	Thu,  3 Oct 2024 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XImjavwB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428A1AC423;
	Thu,  3 Oct 2024 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993763; cv=none; b=HhfFhjW+rnuyFohJJ1GToVNcWLuzgrWeqFmLffg9B4ARdMLV5xlK7tHZ29ynQYveuUMZjznH69oVmWr6NNVAXzz2wMObT0gyCRuLi39GeXVoi6bKkBJpuXZyhbOhCgp+omqqdNIALcOl202gfe32ZlGChBWpJUphr8IH6SQQbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993763; c=relaxed/simple;
	bh=D+ghG0MrKmn8b3XPiHiiAbAfeJYJi4AuJV8eGVSY380=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tu5iCo+fG+PBWaQIyUoBELmubWSmrn44Zr/Y00StCjbyqLn7JEQGuYKnV91GjMFyT0WwkZpg5BVBjH8hjTa94nX7H3jx+ZEDr6f9yPxwwwX/ZjhPT06a9YORrvPDsU0Mu3J2YpDhaz7aQ7X88w7iR8Ro6w2h/gFmL4ILgpMdpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XImjavwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE755C4CEC5;
	Thu,  3 Oct 2024 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993763;
	bh=D+ghG0MrKmn8b3XPiHiiAbAfeJYJi4AuJV8eGVSY380=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XImjavwBqRtpXaENJvewVh0Va+/rI8L1RALnBt8epsKEWFcfJxCahZG6cWYwidCRx
	 K7QYZYWxQrvpuJ86iSbLSnoC9AIH/+K3JhM8q2Dy1nr/lESF2LqCkFRCd9JEFM/W58
	 GSXufVtKQr2+DhxHVmm6skVMvSbNVtFGFrqHpw/715PRzLfYUkaP2sNeKlIrhP8Ykd
	 0Bq5ZwdWU80oJkLgRyD4DIcnlzM108WKIu7J4rQUFatDflwFGy5Ogr6w6LPn/+69xJ
	 OUPfj9wb3ErotSJr87ZGzgIuBuELabp5TKPu54q+XbpA8eXwJpkgAxJRtKhRrwEBWl
	 1WFyURptYcOag==
Date: Thu, 3 Oct 2024 15:16:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, jrife@google.com,
 tangchen.1@bytedance.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] netkit: Add option for scrubbing skb meta
 data
Message-ID: <20241003151601.2404a28c@kernel.org>
In-Reply-To: <20241003180320.113002-1-daniel@iogearbox.net>
References: <20241003180320.113002-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 20:03:17 +0200 Daniel Borkmann wrote:
> +static int netkit_check_scrub(int scrub, struct nlattr *tb,
> +			      struct netlink_ext_ack *extack)
> +{
> +	switch (scrub) {
> +	case NETKIT_SCRUB_DEFAULT:
> +	case NETKIT_SCRUB_NONE:
> +		return 0;
> +	default:
> +		NL_SET_ERR_MSG_ATTR(extack, tb,
> +				    "Provided device scrub setting can only be default/none");
> +		return -EINVAL;
> +	}
> +}

Set the parsing policy to NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_NONE)
and delete this open coded checking, please.

