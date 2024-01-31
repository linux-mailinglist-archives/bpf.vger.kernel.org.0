Return-Path: <bpf+bounces-20857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E98446AD
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACCD1F2458E
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4D12F5AC;
	Wed, 31 Jan 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VxyI1ez/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kt4/uvrT"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989884A5A
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724070; cv=none; b=kE42tbtyz5pQhpQMHj5TgXKH/cTJ0u+pHsPo1eTmAwnxkrie9txJGlUZtkUftI0q2o8X4zNNogWvwnzE+maPK8OaGViPLB8JncNA7roV94q4WohdTgQowxM6RxYQ4MIxHoWKFkl4kshKajHVptsqA2jqZjX6lxo+h02IAuUoZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724070; c=relaxed/simple;
	bh=gsciKAK5+Y5JOJnyvRHGFsJDMwhJ94RZpdmPS8aoPdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf6zPmTsKALb8PYhQJah0YRS9MWLZlZbviFnQcAcdbh2/R0jhRtvUE+o4fH1YEYPbgKfgL762dDPkF9VkULtlYq+D2I/FVPD2+2zW7enPcYIfwOpzT4quoLBOY8wXBCUeORvmavgwQcoA31xorkNVX60iepQ5sfrY3M1Nzd6w2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=VxyI1ez/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kt4/uvrT; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5D8535C0148;
	Wed, 31 Jan 2024 13:01:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 13:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706724065; x=1706810465; bh=t92J/WWEE9
	54lSv8cMd1gEmOHgDkry4e4YeyPpZrL1s=; b=VxyI1ez/E1TSbbwRisLsCdP/Sz
	dj/ciFDVIAt/YLFviqkjxYWB5QyCRPBNTXQ4ae4JDhUgSNC+2UkpqBk9HSmUMbSv
	t0vfnd4NL87Kss23/mBES073h5KENt1HjQlR0lo1MtSJKaM6uN610d6zAeNGR5/V
	+3NYgZVMgfrRNLBNv2AaxukQ6Fta8nEoaHoknnbBfJULAhXCWl4oe367jTfrDNZe
	IfUQ9YaZmsZFg7jqi/HLCJYN4Ni/a20KsCXZrJSLcsQQURlpCgqE42W+XeE8uAcU
	6LcmfPftEUqrDIDXWy8bQ5vqHYgS2wlRJ1ZfsMivZx9LR1rfAFFclwR9zypQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706724065; x=1706810465; bh=t92J/WWEE954lSv8cMd1gEmOHgDk
	ry4e4YeyPpZrL1s=; b=kt4/uvrT+vgagOmu+lEkXsSxu69H/PWxXi6oWWR60CR6
	3ZWwF86kGTVHG6AcLMeVYXvbdxf03Ypu/c/v2Zhm7iUiyVxYb9qumFKLcGNON1U2
	qPTzz9Lg3ATE5clKHjv4yjsD3HeiYTuHPXaqMrL63uQuRr8iKkxmLULEnJs0xLJK
	A6euhq9T0nPYlL3JxIeR1QoIDutrmbiS1oR6BTgsyZzf7edQqEcRvFyoGeZ4C0G1
	OTpiBrJ6N3V/ntItOLQVnOzZTA2Iza0gp9aH808AvTjU3qC2Str0n3Cy+WgStLHz
	b6SjAp5lx7MMhdL+A7wBUoH5Hj26T558BaCNehKgEQ==
X-ME-Sender: <xms:4Iq6ZVJvwE80nY9MVKazb1ZWoSvcG1mHGAxKjBFobrZcBK0mJiXuHg>
    <xme:4Iq6ZRIugdxw-zncIucBwMIoX1X2hYe_d-xkM87NYHSNM-RQxiiV6WrjEjTq5kn0L
    74FQX-PWCT_Eex93g>
X-ME-Received: <xmr:4Iq6ZdshXf7qAbrROpgsdFyjnug1-EgFUrsLR917dBzaGaluhw75DenO4Wutpr9R88LlXUT65E_Q5abLdxgVubtSrIBNClGeoQZZVtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgleetueetkeegieekheethfffleetkeeiiefgueffhedv
    veeiteehkeffgeduveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:4Iq6ZWaY2V4qlG04O2Zk0xN2igDlwO-ovSTWZzppEkniQKNPySgCZw>
    <xmx:4Iq6ZcZL3Q--ag8sW5NTsYUK83oeI5cQAU8VgAAYmpQJZLlRUCEkEg>
    <xmx:4Iq6ZaDDu6LquIHWWHfwqtwHJYlB9_IB63aWLZ6PbNoaJDLV_-20ww>
    <xmx:4Yq6ZYQSVn-jBgcEPu6dNPq9lHBXBWNhyjNOr7Pq1KD5ssXUIt5PZA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 13:01:03 -0500 (EST)
Date: Wed, 31 Jan 2024 11:01:02 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing
 (URDT)
Message-ID: <k5s2bbhap43hudy67i5iutrwwhgkgfocc6o7nn44f7as2w4gvx@ijccexoxzx4e>
References: <20240131162003.962665-1-alan.maguire@oracle.com>
 <vtkysqjcvf7yi6cwa4l5w44nuk6hvpe47f6ikchob3djzxfi7q@udajgkhv2rdq>
 <639d1941-f08c-488b-af54-66fc0709e498@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639d1941-f08c-488b-af54-66fc0709e498@oracle.com>

On Wed, Jan 31, 2024 at 05:38:37PM +0000, Alan Maguire wrote:
> On 31/01/2024 17:06, Daniel Xu wrote:

[..]

> 
> > This is something that would be nice to support in bpftrace as well. I'm
> > sure other tracers would probably find use as well.
> > 
> 
> Yeah, I was aiming for as simple as possible to make it easy for tracers
> to adopt. The aim is to try and facilitate wider support for runtime
> probes, so I'm curious if other folks have run into issues in that area,
> or have suggestions.

I think user_events is a thing: https://docs.kernel.org/trace/user_events.html

Might be good to take a look at that and see how URDT compares.


