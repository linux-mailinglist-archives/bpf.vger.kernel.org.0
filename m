Return-Path: <bpf+bounces-61158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59149AE16DE
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3A3BD1B9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F727E040;
	Fri, 20 Jun 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIjhVyr0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6B2512F0;
	Fri, 20 Jun 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410024; cv=none; b=t4L33mRvTjYVTXu3ta7m3r7VW6Sh4PoVM0XyQth6jmJWV8MDuRhlEG/BdmpuRDhnDxApu6nYCktOFI9/ylKu3os52iI3aQ/kOaPpEO+pz8sFXWz1ED64q+pYGhsRtL5bbB4wSJzjjJJvMXsIGTDjy6qYxJRt+J0uf2BVSuEljx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410024; c=relaxed/simple;
	bh=V3FC9tL6wka3q2KjeuJK53nDAzxYB4CGcXkfNXuEbfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPP/hPoD+mRoK8PDBt8ZPXeYLrKN41CW4BgeEYkOI3HOl2whgSurbGLS/GgMLfTbFo4F1pvwBc3lbgBxBy0e8BAyWLVOK8lI1D5gsD1cfxcuUOUfvslHkBl/sF+aVR+hWwcpQ0lYz+Eim1v2vpyHI/im9EdINuiiAkUkF8q1ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIjhVyr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ED1C4CEE3;
	Fri, 20 Jun 2025 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750410024;
	bh=V3FC9tL6wka3q2KjeuJK53nDAzxYB4CGcXkfNXuEbfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIjhVyr0ArBxchw9QX7AHlciYhE7Hvc1gG504TxKVkB5x2ZkmJHmBEsXGAopL8G8G
	 DVQ+G77e+3izffybwy+2KlKcgix3FABjyF/lJpmxMR2aUTbV0IZT3QEZnyxfyHEotl
	 zby7lpfBwd1q+MgUMRMnPlnTweb5fn0YQJO5k++7Udn8zp6Icrhk1YmXJ7LRL+GcXk
	 /aVWhaEFVpKmu2a9eDY87+DSaWrS7nqevrBZG5MjicaCZd/DHoRmHgkbHTbt0ofrTH
	 zUbz0Zk5F/y3owGfpZ457JSTxg6rUMqjRESKQAzz6UyQ+mPqN+C3izGTQlR066Is/W
	 Zb81XDMC12mPg==
Message-ID: <e9f96821-6dc2-4488-b470-199415fc2548@kernel.org>
Date: Fri, 20 Jun 2025 10:00:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpftool: Fix memory leak in dump_xx_nlmsg on realloc
 failure
To: Yuan Chen <chenyuan_fl@163.com>, ast@kernel.org,
 alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <CAADnVQLy0_FsjRLt2n9R0Rs90VvLQYbkSiji6usaoB_bf4+tYg@mail.gmail.com>
 <20250620012133.14819-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250620012133.14819-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-20 09:21 UTC+0800 ~ Yuan Chen <chenyuan_fl@163.com>
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
> the original pointer to the buffer is overwritten with NULL. This causes
> a memory leak because the previously allocated buffer becomes unreachable
> without being freed.
> 
> Fixes: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

