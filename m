Return-Path: <bpf+bounces-43830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F89BA564
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24B01C20967
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852B17107F;
	Sun,  3 Nov 2024 12:14:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B015C13E;
	Sun,  3 Nov 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730636076; cv=none; b=pLvO9oTs6St24X1Y8mVDYU7P+p7C/IkSvFOzwvAhfD70+0KCsipGUierhpnVuIfUYCgqLmGVcuPJ/bxUUXd39YgXJF73r+znUcB4NZXGbZ1Bpu1UKi9JQt2sC0yHCLjJMGI79e1CjfFNuRHj4kHNuKJfj12Bu8SKgNi+4yL6N5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730636076; c=relaxed/simple;
	bh=UA7zSDxtVIfDvpTFsZ/8xJLe88GTW4vWB1ZVQYG6XyU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=drZP75XS0190Gc+5s/XEZGm3CDgsBxliXKsloqm9lXaWnc7VnsERuF3O0zruOaTcy9XcDjH4tiTGMQpAo5NTgmSxsb7o2fVg7W+D8DDXM5Bn1G0P74FSXi2pqjB0fTVLbFfzQKf+u7mZ5dvYsKIbq/EI2eku/cBhNoPk7AzmOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7b29.dip0.t-ipconnect.de [93.221.123.41])
	by mail.itouring.de (Postfix) with ESMTPSA id 03E34C5B1;
	Sun, 03 Nov 2024 13:04:36 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 5AC226018938E;
	Sun, 03 Nov 2024 13:04:35 +0100 (CET)
Subject: Re: [PATCH] kbuild,bpf: pass make jobs' value to pahole
To: Florian Schmaus <flo@geekplace.eu>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241102100452.793970-1-flo@geekplace.eu>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <73398de9-620c-9fb9-8414-d0f5c85ac53a@applied-asynchrony.com>
Date: Sun, 3 Nov 2024 13:04:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241102100452.793970-1-flo@geekplace.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-11-02 11:04, Florian Schmaus wrote:
> Pass the value of make's -j/--jobs argument to pahole, to avoid out of
> memory errors and make pahole respect the "jobs" value of make.
> 
> On systems with little memory but many cores, invoking pahole using -j
> without argument potentially creates too many pahole instances,
> causing an out-of-memory situation. Instead, we should pass make's
> "jobs" value as an argument to pahole's -j, which is likely configured
> to be (much) lower than the actual core count on such systems.
> 
> If make was invoked without -j, either via cmdline or MAKEFLAGS, then
> JOBS will be simply empty, resulting in the existing behavior, as
> expected.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

As discussed on IRC:

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thanks!
Holger

