Return-Path: <bpf+bounces-66545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F34B36360
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8004A8A49D9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388C2BE653;
	Tue, 26 Aug 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaJQvjOH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E781C860A;
	Tue, 26 Aug 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214421; cv=none; b=Nm+/12JlFTDtDJ8qMhVQmwKCC75wxw06U/9o/qcWUmEIH4FejzzxLRz4gwt3Q5Upv/ficvSk2cSsnNgV96cAK2YvdBzNejEuUaHH0P7xNq6/+SjDdYuwXJerfW+9UDRbukD68jFMBlq13rL3RRlf7vv9uIuYzSy/4YAkhhfeiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214421; c=relaxed/simple;
	bh=eBrdg9J0nCOHJH6fb/UDlL/Ww8rDcYhGdD+Jte9UrXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJatb21AcT7INHCY2/GlTHIVNdsR3FSyJlNI8bHSKGevG0e830NeFu/a7ZCUDQkoALW7VW8RzpwxM0gPWlL3Z0Z4jcYqsXLR5cXmxK6auwe/iGLCitRpQFRbsiU+Tt8tJn4Cps9eZbGUXVSe2MmohRh1kvd+Uir9H3k8Si8/vV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaJQvjOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE64C4CEF1;
	Tue, 26 Aug 2025 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756214421;
	bh=eBrdg9J0nCOHJH6fb/UDlL/Ww8rDcYhGdD+Jte9UrXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BaJQvjOHTe4U+SttoYbmadUUx3w5UgFwzrPMX4OtYvXOdv10Uq+gLkeQwXQLcv2dk
	 gE+7o65EaLxAd3n+OTjL8AgIRJaxSmpcxoz9SZGoZqX7/1ITCOPmUCsxiXXxqIB1xK
	 UZaxbYiU0b/mptLbx7md6kS02j/PazXzQkOfMjniAYYD2/XsSyP/J3317L/4z8LiJF
	 zBXv7bVKd+q43vWv4GRPDFD+4SkNC93CxeT2PcaXSMKU99PJq2+oVsPqmDErZ1W/ru
	 nR96FsGUIt0MYuQJ+4rAgujj6UlUC7tuT9xObqPCfgsXDy3XBXLAq2UP0ku+1T4Vjc
	 jG7930lP/3A1A==
Date: Tue, 26 Aug 2025 06:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <20250826062019.2140dd84@kernel.org>
In-Reply-To: <CAMB2axP2c+tfYPvw7PiPRk11ZkTpvMdMnLRMgjgG697unhGEcA@mail.gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-4-ameryhung@gmail.com>
	<20250825153923.0d98c69d@kernel.org>
	<CAMB2axP2c+tfYPvw7PiPRk11ZkTpvMdMnLRMgjgG697unhGEcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 22:12:21 -0700 Amery Hung wrote:
> > > +     data_end = xdp->data + len;
> > > +     delta = data_end - xdp->data_end;
> > > +
> > > +     if (delta <= 0)
> > > +             return 0;
> > > +
> > > +     if (unlikely(data_end > data_hard_end))
> > > +             return -EINVAL;  
> >
> > Is this safe against pointers wrapping on 32b systems?
> >  
> 
> You are right. This may be a problem.
> 
> > Maybe it's better to do:
> >
> >          if (unlikely(data_hard_end - xdp->data_end < delta))
> >
> > ?  
> 
> But delta may be negative if the pointer wraps around and then the
> function will still continue. How about adding data_end < xdp->data
> check and reorganizing the checks like this?

You already checked that delta is positive in the previous if (),
so I think it's safe. Admittedly having 3 separate conditions is 
more readable but it's not strictly necessary. Up to you.

