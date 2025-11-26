Return-Path: <bpf+bounces-75522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F080EC87AFF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D932A3B5A08
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C32FB99B;
	Wed, 26 Nov 2025 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="och1pLHZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094741E5B70;
	Wed, 26 Nov 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120081; cv=none; b=TeDm1cbbMJHNGbC5mxCMDtwDm+CFkEtdc/a/JvSlZghBF/2G5XobQWNraXlK7r8tYRc3MlTGwIVkkaT0YrhpcgLWLBrfwVAd3I9lA6V+iyJNRQA1vngEV6VCFjqdoa5tGd1uku2tUkX2r+0u8t6kEVB9RvJRDr5pbNuBRNWnR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120081; c=relaxed/simple;
	bh=vtjuBpux/XAz6OnKKFX5ZPodE80kJ1VjUxtahhXRkfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOrdvK5/AoX7QeF7ji+1aUrgvs3WizWChPG8J8gPpBzgg0XHaGV63V8guwhYc6qBM8TqPi0l+JIwZSdNCTCM747+Tv9PTwqXVDErcjXA2AHthWw3Q9VFU3OJ70w9VOxyHIzxt+03o8FgtOw52YhflX4eutFBmVwPUKCEkKEiEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=och1pLHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F013C4CEF1;
	Wed, 26 Nov 2025 01:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764120080;
	bh=vtjuBpux/XAz6OnKKFX5ZPodE80kJ1VjUxtahhXRkfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=och1pLHZfwttlBljwWdfC4a63LkRN3ocRg2N5xyXgvqqjZG+Pjk59x/nmwWqezV7e
	 PXUfCmgK5XJ9j+zJILSk3tdpEW0iBSJvvPFWGQzzDMx8897sQXq90pfFyWywxiovsh
	 Dp3wyid9fj7LbRcenVBa4GcaKQ0QDFeQWhi33b6s8mwN3rK3rHvDudfks+sFFufHeE
	 V1eyAm8QfDkvld3YSxOqCftUnh4wRWMqyjkxESbPD/7WcTjYycZGKGBNha/BGJFt7/
	 yVhNqS3am+jEqbaV7EP/nqJeUjhloDbfJOuRFHmHB0xEQzC1FGhHdA2FVBkGuk6/3R
	 rD1Ze/gfmU2iA==
Date: Tue, 25 Nov 2025 17:21:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Colitti <lorenzo@google.com>, Neal
 Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
Message-ID: <20251125172119.6cf78522@kernel.org>
In-Reply-To: <CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
References: <20251121015933.3618528-1-maze@google.com>
	<CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
	<20251121064333.3668e50e@kernel.org>
	<CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 17:08:17 -0800 Maciej =C5=BBenczykowski wrote:
> > FWIW this breaks the mptcp_join.sh test, too: =20
>=20
> What do you mean by 'too',

I meant - in addition to your self-reply saying that it should have
been an RFC. I haven't see any other failures.

