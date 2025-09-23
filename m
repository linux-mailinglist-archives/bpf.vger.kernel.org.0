Return-Path: <bpf+bounces-69311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB9B93E2C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92B3482A31
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4F273D9A;
	Tue, 23 Sep 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do3wfT9c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30A23A984;
	Tue, 23 Sep 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591176; cv=none; b=a/pHysFlG5c+M6m9FlIhGf7NKM32YcnyCMRxTKmh/wJuexl2IT320/YUM6P8YjMyaogivPSHQ/6SJ3k2lUJ5zsYyiJMKz8U/2wHUR1i2uBqC50zoEZz6qhQbnEFeD3MyhbKa/WRi6w0Hm2qsuPPvaAWII+EzbFXc78kexQXv0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591176; c=relaxed/simple;
	bh=pSD1CLviB14FKJsEgjLcD0Tozdd0KvIAl4wln3FR17o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNJXVup14fY6NSLqBreEcgEYMTJjceLpItqDs5p0VA1cDrOUtsZ8BiWbblpX/UMmGRn6YlWzrtiU3eOuTRN7pyWzaF27fhOwOL3k+l/oRH+/BygNcCt/u3Ko35XP7vMETEgoWNpw1FS2xGvkT5ndGcijgijyTg1iEUvl6n8iwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do3wfT9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7EDC4CEF0;
	Tue, 23 Sep 2025 01:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758591176;
	bh=pSD1CLviB14FKJsEgjLcD0Tozdd0KvIAl4wln3FR17o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=do3wfT9cBbeJpacbQwTKRH5mSKWCydlAAkHLWVo3BadfZhHlstkv8ZDjsEQG5KKSU
	 BgB+Gb1fqNxoHAEVYAL2NbJC0NqTLLyzEZWUb8sYCEJnt16txB2z9JiqjZh5OVMMGW
	 KmaJSrYwyZP4FuilX7W554pmQlsWvvAt7zFrCIg6jN+qQlRGWvmbtKOzNlvmpJkcEb
	 GfTInKNIau85g34RCYIqY44dIM++6b7VRx9XXh6Z3vYha2xI+MuEVrI/9cxRWeUJLk
	 u9eJOsV7HXiHR35mbiCJsvHo5JrIeMtXAIC+CsaRqtTLiPjHhB+ltyN8Qnu6IZu2jf
	 yNen+cfPwCY0w==
Date: Mon, 22 Sep 2025 18:32:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 06/20] net, ynl: Add peer info to queue-get
 response
Message-ID: <20250922183254.5990893d@kernel.org>
In-Reply-To: <20250919213153.103606-7-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-7-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:39 +0200 Daniel Borkmann wrote:
> +    name: peer-info
> +    attributes:
> +      -
> +        name: id
> +        doc: Queue index of the netdevice to which the peer queue belongs.
> +        type: u32
> +      -
> +        name: ifindex
> +        doc: ifindex of the netdevice to which the peer queue belongs.
> +        type: u32

Oh, we have an ifindex in the local netns. So the API is to bind a
queue to one side of a netkit and then the other side of the netkit
actually gets to use it? Should we not be "binding" to the device that
is of interest rather than its peer?

