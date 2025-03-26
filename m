Return-Path: <bpf+bounces-54771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42022A71D80
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3652189C0BF
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75C23ED63;
	Wed, 26 Mar 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mK3zpB7P"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6023E34A
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010904; cv=none; b=K3KlMpGY+nfHQZSOXTuiIxhG4jz95ObqnFeC1m6oiJDo/2KRdezUdTLOiYPGcAh+VDugWq2iaQrRltHmYKwURS9ib92DJHq69gG5vFJCAX9ADYp3gYBc+7Z4hdgen2R/YdorphTrSbUX2LbpYm0iEf9qS0cyWt/6SnyAR6jDxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010904; c=relaxed/simple;
	bh=q7wSIrRIYL5kP/noNSnlzmD1boHkpnAtRBSqJNbfLns=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DZn6sFUlK5wXjw3M3glpfPCTOX1Bx/12t90sVVL5R2ntsyJc58bsauU2wgp0Bcg0dc2ota11Jfr7iM0iDuyhJ24Lvlr6W24Ti2oKZSX3WbHeFC0FvtnfUWOh2zyg0FmZzKjmuMHg1GySwAP8Q+N8nk/4XxMms1ViaxhMizvBWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mK3zpB7P; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743010890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7wSIrRIYL5kP/noNSnlzmD1boHkpnAtRBSqJNbfLns=;
	b=mK3zpB7PBZ2Ay/gkkEyGScCgr/GHe62/xAu0R+6jvDePGeEfMx+nB9NJWmdYKmAjR/Ef0p
	IdBro6XJiRCYOoiJEq5nJ33TCnsv3bnL8mPX3m/JCxbq97orP1+Qrb0ggNHcApEcLUEbIH
	UZLAKBvFCmpjOe8O1jl+g4bjUA1cKmY=
Date: Wed, 26 Mar 2025 17:41:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <70bf9434663f748563e5e464ac76bab669d0acf9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
 <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
 <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
 <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 3/25/25 2:59 AM, Alan Maguire wrote:
>
> [...]
>
> Great; so let's do this to land the series. Could you either
>
> - check I merged your patches correctly in the above branch, and if the=
y
> look good I'll merge them into next and I'll officially send the featur=
e
> check patch; or if you'd prefer
> - send a v5 (perhaps including my feature check patch?)
>
> ...whichever approach is easiest for you.

Hi Alan.

I reviewed the diff between your branch:
https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3Dnext.=
attributes-v4

and v1.29 + my patchset:
https://github.com/theihor/dwarves/tree/v4.kf-arena

Not a lot of difference besides your patch.
Didn't spot any problems.

I also ran a couple of tests on your branch:
* generate BTF with and without --btf_feature=3Dattributes
* run ./tests/tests on 6.14-rc3 vmlinux (just a build I had at hand)

I think you can apply patches from next.attributes-v4 as is.

Thank you.

>
> Thanks!
>
> Alan

