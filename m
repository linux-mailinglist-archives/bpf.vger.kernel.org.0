Return-Path: <bpf+bounces-34941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED59335EB
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 05:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD54B21404
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CE9445;
	Wed, 17 Jul 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rCWHpGpP"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C696FB6;
	Wed, 17 Jul 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188722; cv=none; b=GQWuFPt4O9eGkmQcoSgMeTf3B3sOsOTrN4Zy6s8+oXDmeebDb6rt+PIbxi2c30xYZkZS/WPKqLN6kAuIAA4PbRNkXXq3Zz2RA84eKQR8eFf9XAm+YFQTddthYI+w7e3Leh0vtUVT4RiQ4YhVT3asor2zVktquUb0l8vA7T2azAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188722; c=relaxed/simple;
	bh=D/f81NkoOuwM9rOrUqGhepQR6r1yw3IB2HNFfjiyosA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=guX9YEz9PZmH1iI1N1v/11DnpWsOAU0jAmL7am+QZBgeUzSJCIFBuFEKmZB06B76Yz4a/Moz0C8Ikhkgssp5SBC6flxLBm8nkX/wVSNagVE1qnHNjJ1+FxngU0HMK+C8XNTX4RR0Zp2kR3SyXlQ5F0EZZcAABpknTBMGmyztz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=rCWHpGpP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721188717;
	bh=OFZi07WYw07ktkZHKw95GSmV+6KfXxL/KNgObsOeLsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rCWHpGpPad0oI7coqJLrWR+QgRjO50M5p2JxzGHr/Kboq7Dj2/pDTa+CAQwX8jNU0
	 9hC488vmPCzSABj4nzB7iEnyPtKi6M7fu8GIPaCZ2rpMz7miMi+7TISZ783r7VF/bK
	 TN+aM3JLVK5zN0sMdMWO+CkVOBMP9ltKU/JAM16yAU45fHICtrX/x7+JFONJW2/8kH
	 BohDNRRZo/iub2PcMQETkNXU8D5PR0AIkk8YxfmZkS67XmBoF8VGkDZ9Vid8RQhU/u
	 RWFFNTccZTSlNPcocGdN8PvWwy0ECWmZmimXPcExgxPhcSp1yIEi8V3Dx1neuR9bXh
	 hDDm0NKcGxU5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WP2H04yD3z4wbr;
	Wed, 17 Jul 2024 13:58:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bpf@vger.kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hari Bathini <hbathini@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update email address of Naveen
In-Reply-To: <20240716190222.f3278a2ef0c6a35bd51cfd63@kernel.org>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
 <20240716190222.f3278a2ef0c6a35bd51cfd63@kernel.org>
Date: Wed, 17 Jul 2024 13:58:35 +1000
Message-ID: <87sew8wtxw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> Hi Naveen,
>
> On Sun, 14 Jul 2024 14:04:23 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
>
>> I have switched to using my @kernel.org id for my contributions. Update
>> MAINTAINERS and mailmap to reflect the same.
>> 
>
> Looks good to me. 
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Would powerpc maintainer pick this?

Yeah I can take both.

cheers

