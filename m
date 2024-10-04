Return-Path: <bpf+bounces-41030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A19912DA
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5FF284528
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF914D439;
	Fri,  4 Oct 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN9Um46U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D8130ADA;
	Fri,  4 Oct 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083710; cv=none; b=rvX2I/ZA/ZUXMoCiPoPkgg6MVz6QKqgwDVTIZ2kCRoAvvKrRYmTwRmH3oFIOU+yY8vQHSvHEdo1+GRVBtDSnliGttxePzh7egaVeXU5GNIiB4dd7nLtHjXdorjzj+8RFmcDD1zNjqPFcB9c/i/6q3y+qzAXXMWfysV9CkmbT3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083710; c=relaxed/simple;
	bh=Xq7c7kpq/8vnLvBxIIxXlfAa8geqeUB/LULs16Xjyjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nibf3Zg3u/7w5cdge+nknQ+sJAQ7I1q9+Si0E7WzBhwu1Z4HejVuR0GZXwIf8q7V8S5/eT7Z5PF4i8nG1ORaSQvlehikGCgalCvRNin/3xaeVHCm0P8S7ddKmzjzcYgTCfnDPYEGLo0GgR4DHBzHFhhLBzyU39nHCkTCbmHfqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN9Um46U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D8C4CEC6;
	Fri,  4 Oct 2024 23:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728083709;
	bh=Xq7c7kpq/8vnLvBxIIxXlfAa8geqeUB/LULs16Xjyjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vN9Um46USQHHyyRsL2FLu6xSytWGhXNKqiRvZqfdNhp7UTOL4GthmPi7L5D9hAoEX
	 Hwa790CrvCx1DEluCop1N1PqHIJglosC/+EPTTHq4sEXsUxrC1O8vfkYywjGn9SDhg
	 wQfVQtXHuCg1Twl9+wFvxaPjBsOEXcHWeQtusb/GTXehwy/GWhhvcHdvGsPkLX0cEC
	 nQdLW/jSh4zott66wLEgjNLkiOg/8Y36dA1V6ruLMtp/afzKpJ6X+MQSSHIQK0ASSY
	 xSulve0ddet08t268CK14fn1wtAv/uWWONmXY2BymlP0YSN5aL7oTndl1MbCvuT0uD
	 dJLQvNuVG8GIA==
Date: Fri, 4 Oct 2024 16:15:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, jrife@google.com,
 tangchen.1@bytedance.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] netkit: Add option for scrubbing skb
 meta data
Message-ID: <20241004161508.7cbb9a92@kernel.org>
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 12:13:31 +0200 Daniel Borkmann wrote:
>  v1 -> v2:
>    - Use NLA_POLICY_MAX (Jakub)
>    - Document scrub behavior in if_link.h uapi header (Jakub)

Thanks!

Acked-by: Jakub Kicinski <kuba@kernel.org>

