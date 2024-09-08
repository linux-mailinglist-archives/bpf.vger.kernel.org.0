Return-Path: <bpf+bounces-39207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202C970997
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 21:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0FC1C21642
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EC177991;
	Sun,  8 Sep 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGvyBwOf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A811C01;
	Sun,  8 Sep 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824926; cv=none; b=uFzLJE2LCwH2SWEwh+OgnbQHnA9F/ID+Yt2Pbjp0LSdVcwTKITqCSyCPEUzZ12CBDUTs/PtzsCZ3O1AilMxZ5RSMHAQ0a+hg8smxXeHehSDk70XzjTsw/lVyx3C8mkMYS/ta3LNsgI1CEaejQNqUIuDLKQJYmzLhU1pCoh+E15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824926; c=relaxed/simple;
	bh=IfaPlI7gHBuGvdyuPoCk5K67BUbA6tOt76dIMRn98YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewywwVurAL5flaYK9dVa+oKoNxNmoYKWKQg+c4Clox7I2x07eVtmuTBDvuYIyT44LXXge1i5fia5UKQp0TUs2sXgq2M+yn6Keaph9GkrOUd75Lf8tO/BMQ7gKu2+/SNDCdmzesfNbtiqhqYTRlCiQogn6wKUHKfhkqobwy82hYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGvyBwOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D94C4CEC3;
	Sun,  8 Sep 2024 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725824925;
	bh=IfaPlI7gHBuGvdyuPoCk5K67BUbA6tOt76dIMRn98YQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tGvyBwOfggoGnf4pf1PWvsAJzhf0l3mRmYm4CTbuYO3qy6CEP3DTytrFAxbRCA+s+
	 Z9La34kZQZCNlawwl2Z+boRjlNbHngdYZKS03WCfs24e7G9yiisj5+4l9i/gz7aZUp
	 usfFQcSmzM0w40RFr/b4kOBHY8YZv/nCVW9ahlilwcByIXxQdYkSroKkA56qb/5F/6
	 gfYI57YB7e8ZGlt00XjmKbK2GME/gn+J6mOPOLh8CJUrqTP05c7WxHyegPmRfdcakC
	 l5s8Lcqmr87V3CVcil+BSq8gDlopXx4G7nK3wjnv5GhhH0BMJrZdcPlvbz+yBj73mN
	 OEDZJj93tA7OQ==
Message-ID: <4a42a392-590d-4b90-a21d-df4290d86204@kernel.org>
Date: Sun, 8 Sep 2024 20:48:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] bpftool: Fix undefined behavior caused by shifting into
 the sign bit
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 jserv@ccns.ncku.edu.tw, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240908140009.3149781-1-visitorckw@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240908140009.3149781-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:00, Kuan-Wei Chiu wrote:
> Replace shifts of '1' with '1U' in bitwise operations within
> __show_dev_tc_bpf() to prevent undefined behavior caused by shifting
> into the sign bit of a signed integer. By using '1U', the operations
> are explicitly performed on unsigned integers, avoiding potential
> integer overflow or sign-related issues.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>


Looks good, thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>

How did you find these?

