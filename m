Return-Path: <bpf+bounces-36151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A9943257
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1C1C243D7
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2711BD00A;
	Wed, 31 Jul 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leb7xbLf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0E1BC08E;
	Wed, 31 Jul 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437033; cv=none; b=esRKYpuM+OoH12rKfqoVH2w9+KdLSYA2PqV9ynZomoDbctyDT5yV1bBREOH4lIuvYVEixvwaRlalq0mX3TcEMECj3EtTsYCZvB8dNHptzmzlfXzLKQlsPd1fljvXSL+1bIFUc5WdpBbTFQIMoQPlRSZqw/aIsaqoPcyotSxNxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437033; c=relaxed/simple;
	bh=3uUQgB9NsO6QdRwnKkBcuAS4ZDSgOduuYPCnxlW5Kvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3Pt37aSchfHuMPXiQ6T3JrxP0FTqVzc4PcD/prNQ28LMjz+EXy2x+dRxarNKPOUHRFO/nP8YfsjBIbqwqf25qWVKVZZYeNX3PTtbkr+nW529S2Tqf5CrMKgrzvysvALMFWgyNF2YD+iM4ZmkOvshWDlPKSJcZ4pUZV6b04u/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leb7xbLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E59C116B1;
	Wed, 31 Jul 2024 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722437033;
	bh=3uUQgB9NsO6QdRwnKkBcuAS4ZDSgOduuYPCnxlW5Kvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=leb7xbLfru8tcQpwEZwAOOdUFIGDCp1thq7gTY1UcBFWmAZWS4lKpf3jdfAlD7efh
	 5cdQcAU64khHHAIqGb1Hh9D7++C+qWjbPxBaMwbyxeWg+dE9O34nIPBJ51+RmCN2Vt
	 zCUU4TYVoVpRerchg3Nm8zCx+a1mQ+UZH3P9Rz28ITevglLMFg56obR1McDMqu7N2v
	 fTQvhxOWm/34xmqfN2MVe/EdYr08QSFjkaxGPFQUUJNeZGdgMNBTPAjs62fytClG+S
	 1VEAomVL/gf/nNsiX2t0KuW6YmV5vfuYnlxMDmeXunBhwMPsDpIueHhDozX4kFGoGG
	 ldPbmLW5yoeAQ==
Date: Wed, 31 Jul 2024 07:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Shinas Rasheed <srasheed@marvell.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Brett Creeley
 <brett.creeley@amd.com>, "Blanco Alcaine, Hector"
 <hector.blanco.alcaine@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "Neftin, Sasha" <sasha.neftin@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH iwl-next,v1 0/3] Add Default Rx Queue Setting for igc
 driver
Message-ID: <20240731074351.13676228@kernel.org>
In-Reply-To: <PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
	<20240730075507.7cf8741f@kernel.org>
	<PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 07:40:11 +0000 Song, Yoong Siang wrote:
> Regarding your suggestion of implementing a "wildcard rule,"
> are you suggesting the use of an ethtool command similar to the following?
> 
> ethtool -U <iface name> flow-type ether action <default queue>
> 
> I have a concern that users might be not aware that this nfc rule is having lowest priority,
> as the default queue would only take effect when no other filtering rules match.

I believe that ethtool n-tuple rules are expected to be executed in
order. User can use the 'loc' argument to place the rule at the end 
of the table.

> Do you see this as a potential issue? If not, I am willing to proceed with
> exploring the ethtool options you've mentioned.

