Return-Path: <bpf+bounces-27637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D78AFFB0
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9222828AB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9A13A3F4;
	Wed, 24 Apr 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jn1DlBWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpKb9fM2"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A413777A;
	Wed, 24 Apr 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929570; cv=none; b=dPFVeuh5GOWHIQyDmResMpwk48eQZ23TYCJIkA/lXY4wezr/ZxqG46irDmegO/VFeriT0OFP3wJig8WP41WC+t3sdOhv3f2AgpZ41T8Au5baKQbaLvXj0KJ1x3aZQNxodCUKojF4u1ZJJiVumffYG+OvUxw8C3DddbZ333a84js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929570; c=relaxed/simple;
	bh=Khjus+HfzxaJppH7X7Pk3KpV1jmAMizV4V6024DU/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j76cv26stb4bxKQF0vwQjzDMABlBTpj8Gpl3GOOUbURzSfZwea2xFQVpJcVapwCFp1uznBD3kUo/E/qmikcCIRrIPdQRN5X7kZg4tEQQfI+QUYYSSBJT0Pf3YNAmhCkMPSmgIHoHaEjvomY4VdEK/hpkNsKXLpgLK58J4LBkY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jn1DlBWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpKb9fM2; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3F78F1800102;
	Tue, 23 Apr 2024 23:32:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Apr 2024 23:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713929565; x=1714015965; bh=2u7QLK6iLE
	fgIF/y1f/4W+S7yA8t2QuIHCWyyrdNLQQ=; b=jn1DlBWavDnu0mjYMMvnVLH87R
	wJYK9qL1kQ2tc0/E417m0d1nPxoVP+6qDGjq/ucR+30/gdQzrOgxubeLE2w1xe2T
	DStvW9iWvg4UtAdxUodk9tDkqkCfKrVdEOk3LCMVRNNGKB6V+K78uOQfgqcRn96n
	HMobVGJICB1ui3djy4UROcH1CBkr+r48fdAk6sywB7fYtrLQeGm1bLeMBZkYbS+6
	tbJURxCAlYcTOUT1AuPj1K7m8e74qORslurGsKbJ0YwkmpwoYzqL4tee3nONE1+M
	h3asJVxVw0pV1oRxbPVhXG7tYT+/5V6umpXe/gTw5sqt1qt808IVGJ+9l8FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713929565; x=1714015965; bh=2u7QLK6iLEfgIF/y1f/4W+S7yA8t
	2QuIHCWyyrdNLQQ=; b=cpKb9fM2O8JleeFZNt+uLRgx0AU9lFIn0K6xoMLifW0F
	9KFWO7Goz/CnFa/qiM3UIgYOL4lz+ljf8WDDDlPkvmU603jdW/LOUSvg1GmPOea7
	TAuZgA1dp9wC7/bLslqGVLKE9dV9PTJz/M997NR3J31f1v3sWva5LkqNhxHihDPu
	Aju/oJW+7oAQU5I9mqxQn3JipbzvJjbc1/A+PxbHAHZkqLHq4d54UkvoYPy0P/Do
	s7tZGbZQqw/k+Dl01EhhCD7YkT8Igwklg4j0zza8bJyFsutJSDe/siEfUCKZBU3U
	Oc9oEkD7m8wzk4PFajQI1vGhiSSYWUt8+AdqoRelxQ==
X-ME-Sender: <xms:XX0oZreXQoes74M0gR1wZZEwsaY-7OBbu-AmqXUSKJg26HozOcs69A>
    <xme:XX0oZhMfU0Lmwx63uSn90uNLU79rmmjufhIFJhvHY9RsIKUVr1N7bld8Kwae1EaI3
    32IDgyuqn3RE-qUTA>
X-ME-Received: <xmr:XX0oZkilMwLGBuLpOAwRIaz4yBVBkhOagSC701p46CSExUNah5GPhmv_GwmdCvg7Wnl0BM2Rr2aVKdmMBQawicwM1sYB2RPcPzKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:XX0oZs97v2mZI6KLTWkqQObrXEa2v-Ap5aOjW6EMZb6gYzHlVBQnAQ>
    <xmx:XX0oZnt12_AR-UT3D7KYYactfKZPUzUv3v14Fv2mSa9DRrjV9RJ7BA>
    <xmx:XX0oZrEjSDExO5gMIqpxa-m76r2j3LYzymNyqadgnVMKF6Znal632Q>
    <xmx:XX0oZuPJkaOOrYmhHBSMRxr1Hv3RvPeC7MbF08_6p3cQpiHfLP1CkQ>
    <xmx:XX0oZg-UXqT4ZgKf4GAhJMPxcl1tqz9jQvLB4lyOrd4NgJP-koM3zS01>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 23:32:44 -0400 (EDT)
Date: Tue, 23 Apr 2024 21:32:43 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	andrii.nakryiko@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH dwarves 0/2] replace --btf_features="all" with "default"
Message-ID: <hpokpgpw6aruujyis4bdgymc4jsucegwoos2kpsj5ty2i2jnjk@mquc3dvsor33>
References: <20240423160200.3139270-1-alan.maguire@oracle.com>
 <Zif1ysMXHRd01ovg@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zif1ysMXHRd01ovg@x1>

On Tue, Apr 23, 2024 at 02:54:18PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 23, 2024 at 05:01:58PM +0100, Alan Maguire wrote:
> > Use of "all" in --btf_features is confusing; use the "default" keyword
> > to request default set of BTF features for encoding instead.  Then
> > non-standard features can be added in a more natural way; i.e.
> > 
> > --btf_features=default,reproducible_build
> > 
> > Patch 1 makes this change in pahole.c and documentation.
> > Patch 2 adjusts the reproducible build selftest to use "default"
> > instead of "all".
> > 
> > This series is applicable on the "next" branch.
> 
> Applied to the next branch, I also refreshed the patches adding the
> alternative + syntax, its basically a one liner :-)
> 
> I'll leave it there for a day for the libbpf CI to test with it and then
> will move all to 'master'.
> 
> The first patch of Daniel's series got merged as well, it would be good
> to refresh the other two patches on top of what we have in 'next' now,
> Daniel?

Apologies for the delay - it's top of my todo list now. I will rebase
with changes in the morning.

Thanks,
Daniel

