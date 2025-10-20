Return-Path: <bpf+bounces-71383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C12BF04CF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FB188558C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337023AB9D;
	Mon, 20 Oct 2025 09:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9D68A3F9FB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953741; cv=none; b=DtEB7dBOhPUfTGhKhLesGh6sZZ8KLmJL6n3j2y612U6I1vR7En5DKLJugTCAQ+rvNdLKJKtal18Vjwud/Hv4wScRmpWgTbXB4k3SL0yjjmCscQPZWR+C2NN4imO2cuKFvX8Tu/1hhuiQ1YirFuUXT/Jdj/lL7Vrn/C1uNdLeuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953741; c=relaxed/simple;
	bh=LfbZdpV5LvHcOTJ45ePoRitN/q6+NixBfo6m3xfb+fk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=pMUDcaqwii5deuXmIlfMmWd9T72GXAMpKSkhp3iDF4b1R3i3szMB92CTupEbzZbsMsBR7IwreLOp3Ah5YMLYS/aqv09Il4/ynY9/kttRwFdBZl6ejCIttGGe2/s0efQq3y17XDBh3zHXoyL7qJkeqkEYLhH9fuL9iyZECDEylyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 100.100.5.9 (helo [100.100.5.9])
    (reverse as null)
    by 100.100.3.18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.20-cur)
    for kerneljasonxing@gmail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Mon, 20 Oct 2025 11:48:58 +0200
Content-Type: multipart/mixed; boundary="------------HRBLNnslzn8o3BCiwYZoOUvz"
Message-ID: <95f50c03-ee78-4ac1-b1b8-d87b85149441@nop.hu>
Date: Mon, 20 Oct 2025 11:48:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
From: mc36 <csmate@nop.hu>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <5dde2a2f-a4cf-4ede-967d-b314ec27706f@nop.hu>
Content-Language: en-US
In-Reply-To: <5dde2a2f-a4cf-4ede-967d-b314ec27706f@nop.hu>

This is a multi-part message in MIME format.
--------------HRBLNnslzn8o3BCiwYZoOUvz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 10/20/25 11:18, mc36 wrote:
> so i managed to have the crash on 6.16.8, 6.16.9 and 6.17.2....
> 
> but 6.17.7 and below seems to be working just fine here....
> 

my fat fingers... 6.16.7 and below... :)

an other attachment with the versions that work and ones that crash....

br,

cs

--------------HRBLNnslzn8o3BCiwYZoOUvz
Content-Type: application/gzip; name="zzz2.tar.gz"
Content-Disposition: attachment; filename="zzz2.tar.gz"
Content-Transfer-Encoding: base64

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

--------------HRBLNnslzn8o3BCiwYZoOUvz--

