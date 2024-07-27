Return-Path: <bpf+bounces-35790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D979093DCDF
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FC62844F7
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1791469D;
	Sat, 27 Jul 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npNccG7l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559551FC4;
	Sat, 27 Jul 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722042622; cv=none; b=RpRerKvlIsUypxSsTaM4EtWRFwzNtmmreDtFTySi5TlgzOYhAthQRNse1kIWqxkAibaAGfeJNuNIR/T6KZKrG3ppvseMnczU/LanR3qX9Ol5jUG4Mi7qj1tjJJEJ3sevrEIc8XLbsETo6PG/qfk0SHPi72q85vd5Aicmfr6BgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722042622; c=relaxed/simple;
	bh=B8xcTQete29+yLOOOGHqCHxvBXsSXDnEQZ7UOKIo+zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWrRMsEEB7a4iOfRufczwQ3Lsuh67E9m0ZXe7Y5576F/8kBvBXOR6FY19ga1YN0XqPwtTWDqmPZkRkx9cggis6nSzRMSTfP5ZlcVUI8h6VROOenb/cjgaflp+gso0YKzGWZ5IavsZNEwBACcUZtLNRRWskvE1KGrtdWAcYMe5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npNccG7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A752C32782;
	Sat, 27 Jul 2024 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722042621;
	bh=B8xcTQete29+yLOOOGHqCHxvBXsSXDnEQZ7UOKIo+zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npNccG7l/Z2vs6tew5cYKt73DRtpEdrVs0YVtzxlC9alm/cyElobMEpv/cDbtYQFf
	 TeByFAqa7NfZEvYm3V8LNtfnqsYAwUFSyBrkBgXAZ0/5lPOX91NuCH3l7GYjgy1xmR
	 fyXpGL8Inb1qVD5KZ5RwTv0NdE46d2z4pZybuhx5qxEYALgi157igkOsx/D5+/NFOX
	 /oIOMOy87AvGhKqI72lHCfFYqm+N2vmdhEuUgv++j42QAL5x5ysjJBvYLHlN8w9p+1
	 TFXxU9/UYlOWs1YPBVvBsoRypwdCQErJJpaOILgvr1Jc48Ojqbf08a1YSPE86gR4ri
	 cYddRrfZc+WBw==
Date: Fri, 26 Jul 2024 18:10:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when
 compiling test_cpp
Message-ID: <20240726181020.19bca47d@kernel.org>
In-Reply-To: <CAEf4BzYonHCyFr7ivRDDUtsJY3MEgWRKwVZ=N0sWjpMrn1dR6A@mail.gmail.com>
References: <20240725214029.1760809-1-sdf@fomichev.me>
	<CAEf4BzYonHCyFr7ivRDDUtsJY3MEgWRKwVZ=N0sWjpMrn1dR6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:45:06 -0700 Andrii Nakryiko wrote:
> or we could
> 
> #ifndef _GNU_SOURCE
> #define _GNU_SOURCE
> #endif
> 
> (though we have 61 places with that...) so as to not have to update
> every target in Makefile.

AFAIU we have -D_GNU_SOURCE= twice _in the command line args_ :(
One is from the Makefile which now always adds it to CFLAGS,
the other is "built-in" in g++ for some weird reason.

FWIW I have added this patch to the netdev "hack queue" so no
preference any more where the patch lands :)

